from __future__ import print_function

from simtk import openmm as mm
from simtk.openmm.app import *
from simtk.openmm import *
from simtk.unit import *
from sys import stdout
import os, re,time, shutil, math
from datetime import datetime

from atmmetaforce import *

#the multiple-time step integrator does not have a setTemperature() method
def setTemperature(self, temperature):
    self.setGlobalVariableByName('kT', MOLAR_GAS_CONSTANT_R*temperature)
MTSLangevinIntegrator.setTemperature = setTemperature

print("Started at: " + str(time.asctime()))
start=datetime.now()

jobname = "bCDspR-PMZ1aspR-TDZNR1aspR"

displ = [ -30.0, 0.0, 0.0 ]
displacement      = [  displ[i] for i in range(3) ] * angstrom
lig1_restr_offset = [  0.       for i in range(3) ] * angstrom
lig2_restr_offset = [  displ[i] for i in range(3) ] * angstrom

lig1_atoms = [ 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187 ]
lig2_atoms = [ 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239 ]
refatoms_lig1 = [ 19, 17, 1 ]
refatoms_lig2 = [ 23, 21, 11 ]
rcpt_cm_atoms = [ 44, 49, 54, 59, 64, 69, 74 ]
restrained_atoms = [ 44, 49, 54, 59, 64, 69, 74 ]

#load system
prmtop = AmberPrmtopFile(jobname + '.prmtop')
inpcrd = AmberInpcrdFile(jobname + '.inpcrd')
system = prmtop.createSystem(nonbondedMethod=PME, nonbondedCutoff=0.9*nanometer,
                             constraints=HBonds)

#load the ATM Meta Force facility. Among other things the initializer
#sorts Forces into groups 
atm_utils = ATMMetaForceUtils(system)

#Vsite restraints
lig1_cm_atoms = [ 166, 164 ]
lig2_cm_atoms = [ 211, 209 ]
kf = 25.0 * kilocalorie_per_mole/angstrom**2 #force constant for Vsite CM-CM restraint
r0 = 4 * angstrom #radius of Vsite sphere
atm_utils.addRestraintForce(lig_cm_particles = lig1_cm_atoms,
                            rcpt_cm_particles = rcpt_cm_atoms,
                            kfcm = kf,
                            tolcm = r0,
                            offset = lig1_restr_offset)

atm_utils.addRestraintForce(lig_cm_particles = lig2_cm_atoms,
                            rcpt_cm_particles = rcpt_cm_atoms,
                            kfcm = kf,
                            tolcm = r0,
                            offset = lig2_restr_offset)

#orientation restraints
rcpt_up_cm_atoms = [ 42, 43, 47, 48, 52, 53, 57, 58, 62, 63, 67, 68, 72, 73 ]
rcpt_cm_groups = [ rcpt_cm_atoms, rcpt_up_cm_atoms , None ]
lig1_cm_groups = [ [lig1_atoms[0]+refatoms_lig1[0]], [lig1_atoms[0]+refatoms_lig1[1]], [lig1_atoms[0]+refatoms_lig1[2]]]
lig2_cm_groups = [ [lig2_atoms[0]+refatoms_lig2[0]], [lig2_atoms[0]+refatoms_lig2[1]], [lig2_atoms[0]+refatoms_lig2[2]]]
ktheta =   100.0 * kilocalories_per_mole
theta0 =     0.0 * degrees
thetatol = 100.0 * degrees
kphi = None
phi0 = None
phitol = None
kpsi =    0.05 * kilocalories_per_mole/degrees**2
psi0  =  180.0 * degrees
psitol = 100.0 * degrees
atm_utils.addVsiteRestraintForceCMAngles(lig1_cm_groups, rcpt_cm_groups,
                                         ktheta, theta0, thetatol,
                                         kphi, phi0, phitol,
                                         kpsi, psi0, psitol)
atm_utils.addVsiteRestraintForceCMAngles(lig2_cm_groups, rcpt_cm_groups,
                                         ktheta, theta0, thetatol,
                                         kphi, phi0, phitol,
                                         kpsi, psi0, psitol)


#alignment restraint
lig1_ref_atoms  = [ refatoms_lig1[i]+lig1_atoms[0] for i in range(3)]
lig2_ref_atoms  = [ refatoms_lig2[i]+lig2_atoms[0] for i in range(3)]
atm_utils.addAlignmentForce(liga_ref_particles = lig1_ref_atoms,
                            ligb_ref_particles = lig2_ref_atoms,
                            kfdispl =   5.0 * kilocalorie_per_mole/angstrom**2,
                            ktheta =   100.0 * kilocalorie_per_mole,
                            kpsi =     100.0 * kilocalorie_per_mole,
                            offset = lig2_restr_offset)

#restrain selected atoms
fc = 25.0 * kilocalorie_per_mole/angstrom**2
tol = 4.0 * angstrom
atm_utils.addPosRestraints(restrained_atoms, inpcrd.positions, fc, tol)

#Set up Langevin integrator
initial_temperature = 50 * kelvin
final_temperature = 300 * kelvin
temperature = initial_temperature
frictionCoeff = 0.5 / picosecond
MDstepsize = 0.001 * picosecond
barostat = MonteCarloBarostat(1*bar, final_temperature)
saved_barostat_frequency = barostat.getFrequency()
barostat.setFrequency(0)#disabled
system.addForce(barostat)
integrator = MTSLangevinIntegrator(temperature/kelvin, frictionCoeff/(1/picosecond), MDstepsize/ picosecond, [(1,1), (2,1)])
integrator.setConstraintTolerance(0.00001)

#sets up platform
platform_name = 'CUDA'
platform = Platform.getPlatformByName(platform_name)
properties = {}
properties["Precision"] = "mixed"

simulation = Simulation(prmtop.topology, system, integrator,platform, properties)
print ("Using platform %s" % simulation.context.getPlatform().getName())
simulation.context.setPositions(inpcrd.positions)
if inpcrd.boxVectors is not None:
    simulation.context.setPeriodicBoxVectors(*inpcrd.boxVectors)

print("Potential energy before minimization =", simulation.context.getState(getEnergy = True).getPotentialEnergy())

print("Energy minimizing the system ...")
simulation.minimizeEnergy()

print("Potential energy after minimization =", simulation.context.getState(getEnergy = True).getPotentialEnergy())

#saves checkpoint
simulation.saveState(jobname + '_min.xml')
#saves a pdb file
positions = simulation.context.getState(getPositions=True).getPositions()
boxsize = simulation.context.getState().getPeriodicBoxVectors()
simulation.topology.setPeriodicBoxVectors(boxsize)
with open(jobname + '_min.pdb', 'w') as output:
  PDBFile.writeFile(simulation.topology, positions, output)

print("Thermalization ...")

totalSteps = 50000
steps_per_cycle = 5000
number_of_cycles = int(totalSteps/steps_per_cycle)
delta_temperature = (final_temperature - initial_temperature)/number_of_cycles
simulation.reporters.append(StateDataReporter(stdout, steps_per_cycle, step=True, potentialEnergy = True, temperature=True, volume=True))

#MD with temperature ramp
for i in range(number_of_cycles):
    simulation.step(steps_per_cycle)
    #prepare system for new temperature
    temperature = temperature + delta_temperature
    integrator.setTemperature(temperature)

#saves checkpoint
simulation.saveState(jobname + '_therm.xml')
#saves a pdb file
positions = simulation.context.getState(getPositions=True).getPositions()
boxsize = simulation.context.getState().getPeriodicBoxVectors()
simulation.topology.setPeriodicBoxVectors(boxsize)
with open(jobname + '_therm.pdb', 'w') as output:
  PDBFile.writeFile(simulation.topology, positions, output)
  
print("NPT equilibration ...")
barostat.setFrequency(saved_barostat_frequency)#enabled

#MD at constant pressure
for i in range(number_of_cycles):
    simulation.step(steps_per_cycle)

#saves checkpoint
simulation.saveState(jobname + '_npt.xml')
#saves a pdb file
positions = simulation.context.getState(getPositions=True).getPositions()
boxsize = simulation.context.getState().getPeriodicBoxVectors()
simulation.topology.setPeriodicBoxVectors(boxsize)
with open(jobname + '_npt.pdb', 'w') as output:
  PDBFile.writeFile(simulation.topology, positions, output)
  
print("NVT equilibration ...")
barostat.setFrequency(0)#disabled

#MD at constant volume
for i in range(number_of_cycles):
    simulation.step(steps_per_cycle)

#saves checkpoint
simulation.saveState(jobname + '_equil.xml')

#saves a pdb file
positions = simulation.context.getState(getPositions=True).getPositions()
boxsize = simulation.context.getState().getPeriodicBoxVectors()
simulation.topology.setPeriodicBoxVectors(boxsize)
with open(jobname + '_equil.pdb', 'w') as output:
  PDBFile.writeFile(simulation.topology, positions, output)
  
end=datetime.now()
elapsed=end - start
print("elapsed time="+str(elapsed.seconds+elapsed.microseconds*1e-6)+"s")
