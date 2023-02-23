from __future__ import print_function

from simtk import openmm as mm
from simtk.openmm.app import *
from simtk.openmm import *
from simtk.unit import *
from sys import stdout
import os, re,time, shutil, math
from datetime import datetime

from atmmetaforce import *

print("Started at: " + str(time.asctime()))
start=datetime.now()

jobname = "bcd-PHM0appS-PMZ1appS"

displ = [ -30.0, 0.0, 0.0 ]
displacement      = [  displ[i] for i in range(3) ] * angstrom
lig1_restr_offset = [  0.       for i in range(3) ] * angstrom
lig2_restr_offset = [  displ[i] for i in range(3) ] * angstrom

lig1_atoms = [ 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172 ]
lig2_atoms = [ 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213 ]
refatoms_lig1 = [ 14, 13, 1 ]
refatoms_lig2 = [ 19, 17, 1 ]
rcpt_cm_atoms = [ 44, 49, 54, 59, 64, 69, 74 ]
restrained_atoms = [ 44, 49, 54, 59, 64, 69, 74 ]

#define the thermodynamic/alchemical state
#the system is prepared at the alchemical intermediate state at lambda=1/2
temperature = 300.0 * kelvin
lmbd = 0.50
lambda1 = lmbd
lambda2 = lmbd
alpha = 0.0 / kilocalorie_per_mole
u0 = 0.0 * kilocalorie_per_mole
w0coeff = 0.0 * kilocalorie_per_mole
umsc =  400.0 * kilocalorie_per_mole
ubcore = 200.0 * kilocalorie_per_mole
acore = 0.062500

#load system
prmtop = AmberPrmtopFile(jobname + '.prmtop')
inpcrd = AmberInpcrdFile(jobname + '.inpcrd')
system = prmtop.createSystem(nonbondedMethod=PME, nonbondedCutoff=1*nanometer,
                             constraints=HBonds)

#load the ATM Meta Force facility. Among other things the initializer
#sorts Forces into groups 
atm_utils = ATMMetaForceUtils(system)

#Vsite restraints
lig1_cm_atoms = [ 161, 160 ]
lig2_cm_atoms = [ 192, 190 ]
kf = 25.0 * kilocalorie_per_mole/angstrom**2 #force constant for Vsite CM-CM restraint
atm_utils.addRestraintForce(lig_cm_particles = lig1_cm_atoms,
                            rcpt_cm_particles = rcpt_cm_atoms,
                            kfcm = kf,
                            tolcm = 6 * angstrom,
                            offset = lig1_restr_offset)

atm_utils.addRestraintForce(lig_cm_particles = lig2_cm_atoms,
                            rcpt_cm_particles = rcpt_cm_atoms,
                            kfcm = kf,
                            tolcm = 6 * angstrom,
                            offset = lig2_restr_offset)

#orientation restraints
rcpt_up_cm_atoms = [ 42, 43, 47, 48, 52, 53, 57, 58, 62, 63, 67, 68, 72, 73 ]
rcpt_cm_groups = [ rcpt_cm_atoms, rcpt_up_cm_atoms , None ]
lig1_cm_groups = [ [lig1_atoms[0]+refatoms_lig1[0]], [lig1_atoms[0]+refatoms_lig1[1]], [lig1_atoms[0]+refatoms_lig1[2]]]
lig2_cm_groups = [ [lig2_atoms[0]+refatoms_lig2[0]], [lig2_atoms[0]+refatoms_lig2[1]], [lig2_atoms[0]+refatoms_lig2[2]]]
ktheta =   100.0 * kilocalories_per_mole
theta0 =  180.0 * degrees
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
                                         None, None, None)
atm_utils.addVsiteRestraintForceCMAngles(lig2_cm_groups, rcpt_cm_groups,
                                         ktheta, theta0, thetatol,
                                         kphi, phi0, phitol,
                                         kpsi, psi0, psitol)
#alignment restraint
lig1_ref_atoms  = [ refatoms_lig1[i]+lig1_atoms[0] for i in range(3)]
lig2_ref_atoms  = [ refatoms_lig2[i]+lig2_atoms[0] for i in range(3)]
atm_utils.addAlignmentForce(liga_ref_particles = lig1_ref_atoms,
                            ligb_ref_particles = lig2_ref_atoms,
                            kfdispl =  2.5 * kilocalorie_per_mole/angstrom**2,
                            ktheta =   10.0 * kilocalorie_per_mole,
                            kpsi =     10.0 * kilocalorie_per_mole,
                            offset = lig2_restr_offset)

#restrain selected atoms
fc = 25.0 * kilocalorie_per_mole/angstrom**2
tol = 2.0 * angstrom
atm_utils.addPosRestraints(restrained_atoms, inpcrd.positions, fc, tol)

#create ATM Force (direction is 1 by default)
atmforce = ATMMetaForce(lambda1, lambda2,  alpha * kilojoules_per_mole, u0/kilojoules_per_mole, w0coeff/kilojoules_per_mole, umsc/kilojoules_per_mole, ubcore/kilojoules_per_mole, acore )
#adds all atoms to the force with zero displacement
for at in prmtop.topology.atoms():
    atmforce.addParticle(at.index, 0., 0., 0.)
#the ligand atoms get displaced, ligand 1 from binding site to the solvent bulk
#and ligand 2 from the bulk solvent to the binding site
for i in lig1_atoms:
    atmforce.setParticleParameters(i, i, displ[0] * angstrom, displ[1] * angstrom, displ[2] * angstrom)
for i in lig2_atoms:
    atmforce.setParticleParameters(i, i, -displ[0] * angstrom, -displ[1] * angstrom, -displ[2] * angstrom)
#The ATMMetaForce assumes to be in force group 3, it looks for bonded forces in group 1 and non-bonded forces in group 2
#Bonded forces are those that are not expected to change when the ligand is displaced.
#Conversely, non-bonded forces change when the ligand is displaced. 
#The ATMMetaForceUtils() initializer (above) automatically sorts the system forces in groups 1 except for non-bonded forces
#that are placed in group 2.
atmforce.setForceGroup(3)
system.addForce(atmforce)

#Set up Langevin integrator
temperature = 300 * kelvin
frictionCoeff = 0.5 / picosecond
MDstepsize = 0.0005 * picosecond
barostat = MonteCarloBarostat(1*bar, temperature)
barostat.setForceGroup(1)
saved_barostat_frequency = barostat.getFrequency()
barostat.setFrequency(0)#disabled
system.addForce(barostat)
integrator = LangevinIntegrator(temperature/kelvin, frictionCoeff/(1/picosecond), MDstepsize/ picosecond)
#MD is conducted using forces from groups 1 and 3 only. Group 1 are bonded forces that are calculated once.
#Group 3 contains the ATMMetaForce that computes the non-bonded forces before and after the ligand is displaced and
#it then combines them according to the alchemical potential.
integrator.setIntegrationForceGroups({1,3})

#sets up platform
platform_name = 'OpenCL'
platform = Platform.getPlatformByName(platform_name)
properties = {}

simulation = Simulation(prmtop.topology, system, integrator,platform, properties)
print ("Using platform %s" % simulation.context.getPlatform().getName())
simulation.context.setPositions(inpcrd.positions)
if inpcrd.boxVectors is not None:
    simulation.context.setPeriodicBoxVectors(*inpcrd.boxVectors)

state = simulation.context.getState(getEnergy = True, groups = {1,3})
pote = simulation.context.getState(getEnergy = True, groups = {1,3}).getPotentialEnergy()

print( "LoadState ...")
simulation.loadState(jobname + '_mintherm.xml')

print("Potential Energy =", simulation.context.getState(getEnergy = True, groups = {1,3}).getPotentialEnergy())

print("Equilibration ...")

totalSteps = 150000
steps_per_cycle = 5000
number_of_cycles = int(totalSteps/steps_per_cycle)
simulation.reporters.append(StateDataReporter(stdout, steps_per_cycle, step=True, potentialEnergy = True, temperature=True, volume=True))

#binding energy values and other parameters are recorded in this file
f = open(jobname + "_equil.out", 'w')

#MD with temperature ramp
for i in range(number_of_cycles):
    simulation.step(steps_per_cycle)
    state = simulation.context.getState(getEnergy = True, groups = {1,3})
    pot_energy = (state.getPotentialEnergy()).value_in_unit(kilocalorie_per_mole)
    pert_energy = (atmforce.getPerturbationEnergy(simulation.context)).value_in_unit(kilocalorie_per_mole)
    l1 = simulation.context.getParameter(atmforce.Lambda1())
    l2 = simulation.context.getParameter(atmforce.Lambda2())
    a = simulation.context.getParameter(atmforce.Alpha()) / kilojoules_per_mole
    umid = simulation.context.getParameter(atmforce.U0()) * kilojoules_per_mole
    w0 = simulation.context.getParameter(atmforce.W0()) * kilojoules_per_mole
    print("%f %f %f %f %f %f %f %f %f" % (temperature/kelvin,lmbd, l1, l2, a*kilocalorie_per_mole, umid/kilocalorie_per_mole, w0/kilocalorie_per_mole, pot_energy, pert_energy), file=f )
    f.flush()
    
print( "SaveState ...")

#saves a checkpoint file and a pdb file at lambda=1/2.
#for historical reasons it has a "0" in the file name
simulation.saveState(jobname + '_0.xml')
positions = simulation.context.getState(getPositions=True).getPositions()
boxsize = simulation.context.getState().getPeriodicBoxVectors()
simulation.topology.setPeriodicBoxVectors(boxsize)
with open(jobname + '_0.pdb', 'w') as output:
  PDBFile.writeFile(simulation.topology, positions, output)
  
end=datetime.now()
elapsed=end - start
print("elapsed time="+str(elapsed.seconds+elapsed.microseconds*1e-6)+"s")
