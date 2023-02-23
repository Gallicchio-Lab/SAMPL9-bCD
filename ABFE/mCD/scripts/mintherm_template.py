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

jobname = "<JOBNAME>"

lig_restr_offset = [  0.       for i in range(3) ] * angstrom


lig_atoms = [ <LIGATOMS> ]
rcpt_cm_atoms = [ <VSITERECEPTORATOMS> ]

#load system
prmtop = AmberPrmtopFile(jobname + '.prmtop')
inpcrd = AmberInpcrdFile(jobname + '.inpcrd')
system = prmtop.createSystem(nonbondedMethod=PME, nonbondedCutoff=1*nanometer,
                             constraints=HBonds)

#load the ATM Meta Force facility. Among other things the initializer
#sorts Forces into groups 
atm_utils = ATMMetaForceUtils(system)


lig_cm_atoms = lig_atoms

kf = 25.0 * kilocalorie_per_mole/angstrom**2
r0 =  6.0 * angstrom # change it to s placeholder

atm_utils.addRestraintForce(lig_cm_particles = lig_cm_atoms,
                            rcpt_cm_particles = rcpt_cm_atoms,
                            kfcm = kf,
                            tolcm = r0,
                            offset = lig_restr_offset
)


num_rcpt_atoms = 189
rcpt_up_cm_atoms = [ 42, 43, 49, 50, 56, 57, 63, 64, 70, 71, 77, 78, 84, 85 ]
rcpt_cm_groups = [ rcpt_cm_atoms, rcpt_up_cm_atoms , None ]
#lig_cm_groups = [ [num_rcpt_atoms+4], [num_rcpt_atoms+5], None]
lig_cm_groups = [ [num_rcpt_atoms+5], [num_rcpt_atoms+2], None]
ktheta = 100.0 * kilocalories_per_mole
#theta0 =  0.0 * degrees;
theta0 =  180.0 * degrees;
thetatol = 100.0 * degrees
atm_utils.addVsiteRestraintForceCMAngles(lig_cm_groups, rcpt_cm_groups, ktheta, theta0, thetatol) 

#restrain all heavy atoms of receptor and ligands to equilibrate only the solvent
#this assumes that ligand is the last residue of the receptor-ligand system
#add code to keep hydrogens unrestrained
fc = 25.0 * kilocalorie_per_mole/angstrom**2
tol = 0.5 * angstrom
hydrogen = Element.getByAtomicNumber(1)
posrestr_atoms = []
last_not_solvent_atom = lig_atoms[len(lig_atoms)-1]
for at in prmtop.topology.atoms():
    if at.index <= last_not_solvent_atom:
        posrestr_atoms.append(at.index)
atm_utils.addPosRestraints(posrestr_atoms, inpcrd.positions, fc, tol)


#Set up Langevin integrator
initial_temperature = 50 * kelvin
final_temperature = 300 * kelvin
temperature = initial_temperature
frictionCoeff = 0.5 / picosecond
MDstepsize = 0.001 * picosecond
barostat = MonteCarloBarostat(1*bar, temperature)
saved_barostat_frequency = barostat.getFrequency()
barostat.setFrequency(0)#disabled
system.addForce(barostat)
integrator = LangevinIntegrator(temperature/kelvin, frictionCoeff/(1/picosecond), MDstepsize/ picosecond)

#sets up platform
platform_name = 'OpenCL'
platform = Platform.getPlatformByName(platform_name)
properties = {}

simulation = Simulation(prmtop.topology, system, integrator,platform, properties)
print ("Using platform %s" % simulation.context.getPlatform().getName())
simulation.context.setPositions(inpcrd.positions)
if inpcrd.boxVectors is not None:
    simulation.context.setPeriodicBoxVectors(*inpcrd.boxVectors)

state = simulation.context.getState(getEnergy = True)
print("Potential energy before minimization =", simulation.context.getState(getEnergy = True).getPotentialEnergy())

print("Energy minimizing the system ...")
simulation.minimizeEnergy()

print("Potential energy after minimization =", simulation.context.getState(getEnergy = True).getPotentialEnergy())
  
print("Thermalization ...")

totalSteps = 50000
steps_per_cycle = 5000
number_of_cycles = int(totalSteps/steps_per_cycle)
delta_temperature = (final_temperature - initial_temperature)/number_of_cycles
simulation.reporters.append(StateDataReporter(stdout, steps_per_cycle, step=True, potentialEnergy = True, temperature=True, volume=True))
simulation.reporters.append(DCDReporter(jobname + "_mintherm.dcd", steps_per_cycle))

#MD with temperature ramp
for i in range(number_of_cycles):
    simulation.step(steps_per_cycle)
    #prepare system for new temperature
    temperature = temperature + delta_temperature
    integrator.setTemperature(temperature)
    
print("NPT equilibration ...")
barostat.setFrequency(saved_barostat_frequency)#enabled

#MD at constant pressure
for i in range(number_of_cycles):
    simulation.step(steps_per_cycle)
    
#saves checkpoint
print( "SaveState ...")
simulation.saveState(jobname + '_mintherm.xml')

#saves a pdb file
positions = simulation.context.getState(getPositions=True).getPositions()
boxsize = simulation.context.getState().getPeriodicBoxVectors()
simulation.topology.setPeriodicBoxVectors(boxsize)
with open(jobname + '_mintherm.pdb', 'w') as output:
  PDBFile.writeFile(simulation.topology, positions, output)
    
end=datetime.now()
elapsed=end - start
print("elapsed time="+str(elapsed.seconds+elapsed.microseconds*1e-6)+"s")
