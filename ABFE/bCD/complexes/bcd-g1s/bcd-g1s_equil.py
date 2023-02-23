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

jobname = "bcd-g1s"

lig_restr_offset = [  0.       for i in range(3) ] * angstrom


lig_atoms = [ 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168 ]
rcpt_cm_atoms = [ 44, 49, 54, 59, 64, 69, 74 ]
restrained_atoms = [44, 49, 54, 59, 64, 69, 74]

#load system
prmtop = AmberPrmtopFile(jobname + '.prmtop')
inpcrd = AmberInpcrdFile(jobname + '.inpcrd')
system = prmtop.createSystem(nonbondedMethod=PME, nonbondedCutoff=1*nanometer,
                             constraints=HBonds)

#load the ATM Meta Force facility. Among other things the initializer
#sorts Forces into groups 
atm_utils = ATMMetaForceUtils(system)


#vsite CM restraints
lig_cm_atoms = lig_atoms
kf = 25.0 * kilocalorie_per_mole/angstrom**2
r0 =  6.0 * angstrom # change it to s placeholder
atm_utils.addRestraintForce(lig_cm_particles = lig_cm_atoms,
                            rcpt_cm_particles = rcpt_cm_atoms,
                            kfcm = kf,
                            tolcm = r0,
                            offset = lig_restr_offset)

#angle restraint
num_rcpt_atoms = 147
rcpt_up_cm_atoms = [ 42, 43, 47, 48, 52, 53, 57, 58, 62, 63, 67, 68, 72, 73 ]
rcpt_cm_groups = [ rcpt_cm_atoms, rcpt_up_cm_atoms , None ]
lig_cm_groups = [ [num_rcpt_atoms+4], [num_rcpt_atoms+5], None]
ktheta = 100.0 * kilocalories_per_mole
theta0 =  0.0 * degrees;
#theta0 =  180.0 * degrees;
thetatol = 100.0 * degrees
atm_utils.addVsiteRestraintForceCMAngles(lig_cm_groups, rcpt_cm_groups, ktheta, theta0, thetatol) 

#receptor positional restraints
fc = 25.0 * kilocalorie_per_mole/angstrom**2
tol = 2.0 * angstrom
atm_utils.addPosRestraints(restrained_atoms, inpcrd.positions, fc, tol)

#define a barostat but disable it
#Set up Langevin integrator
temperature = 300 * kelvin
frictionCoeff = 0.5 / picosecond
MDstepsize = 0.001 * picosecond
barostat = MonteCarloBarostat(1*bar, temperature)
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
pote = state.getPotentialEnergy()

print( "LoadState ...")
simulation.loadState(jobname + '_mintherm.xml')

print("Equilibration ...")

totalSteps = 50000
steps_per_cycle = 5000
number_of_cycles = int(totalSteps/steps_per_cycle)
simulation.reporters.append(StateDataReporter(stdout, steps_per_cycle, step=True, potentialEnergy = True, temperature=True, volume=True))
simulation.reporters.append(DCDReporter(jobname + "_equil.dcd", steps_per_cycle))

simulation.step(totalSteps)

#saves checkpoint
print( "SaveState ...")
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
