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

jobname = "bCDspR-PMZ1aspR-TFP1bspR"

displ = [ -30.0, 0.0, 0.0 ]
displacement      = [  displ[i] for i in range(3) ] * angstrom
lig1_restr_offset = [  0.       for i in range(3) ] * angstrom
lig2_restr_offset = [  displ[i] for i in range(3) ] * angstrom

lig1_atoms = [ 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187 ]
lig2_atoms = [ 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237 ]
refatoms_lig1 = [ 19, 17, 1 ]
refatoms_lig2 = [ 25, 19, 11 ]
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
lig2_cm_atoms = [ 213, 207 ]
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

#define the thermodynamic/alchemical state
#the system is prepared at lambda = 0 and driven to lambda=1/2
temperature = 300.0 * kelvin
lmbd = 0.0
lambda1 = lmbd
lambda2 = lmbd
alpha = 0.0 / kilocalorie_per_mole
u0 = 0.0 * kilocalorie_per_mole
w0coeff = 0.0 * kilocalorie_per_mole
umsc =  1000.0 * kilocalorie_per_mole
ubcore = 500.0 * kilocalorie_per_mole
acore = 0.062500
direction = 1

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

#add barostat
barostat = MonteCarloBarostat(1*bar, temperature)
barostat.setForceGroup(1)
barostat.setFrequency(0)#disabled
system.addForce(barostat)

temperature = 300 * kelvin
frictionCoeff = 0.5 / picosecond
MDstepsize = 0.001 * picosecond
#MD is conducted using forces from groups 1 and 3 only. Group 1 are bonded forces that are calculated once.
#Group 3 contains the ATMMetaForce that computes the non-bonded forces before and after the ligand is displaced and
#it then combines them according to the alchemical potential.
integrator = MTSLangevinIntegrator(temperature, frictionCoeff, MDstepsize, [(3,1), (1,1)])
integrator.setConstraintTolerance(0.00001)

#platform_name = 'OpenCL'
platform_name = 'CUDA'
platform = Platform.getPlatformByName(platform_name)
properties = {}
properties["Precision"] = "mixed"

simulation = Simulation(prmtop.topology, system, integrator,platform, properties)
print ("Using platform %s" % simulation.context.getPlatform().getName())
simulation.context.setPositions(inpcrd.positions)
if inpcrd.boxVectors is not None:
    simulation.context.setPeriodicBoxVectors(*inpcrd.boxVectors)

state = simulation.context.getState(getEnergy = True, groups = {1,3})
pote = state.getPotentialEnergy()

print( "LoadState ...")
simulation.loadState(jobname + '_equil.xml')

#override ATM parameters
simulation.context.setParameter(atmforce.Lambda1(), lambda1)
simulation.context.setParameter(atmforce.Lambda2(), lambda2)
simulation.context.setParameter(atmforce.Alpha(), alpha *kilojoules_per_mole)
simulation.context.setParameter(atmforce.U0(), u0 /kilojoules_per_mole)
simulation.context.setParameter(atmforce.W0(), w0coeff /kilojoules_per_mole)
simulation.context.setParameter(atmforce.Umax(), umsc /kilojoules_per_mole)
simulation.context.setParameter(atmforce.Ubcore(), ubcore /kilojoules_per_mole)
simulation.context.setParameter(atmforce.Acore(), acore)
simulation.context.setParameter(atmforce.Direction(), direction)

state = simulation.context.getState(getEnergy = True, groups = {1,3})
print("Potential Energy =", state.getPotentialEnergy())

print("Annealing to lambda = 1/2 ...")

stepId = 1000
totalSteps = 250000
loopStep = int(totalSteps/stepId)
simulation.reporters.append(StateDataReporter(stdout, stepId, step=True, potentialEnergy = True, temperature=True))
simulation.reporters.append(DCDReporter(jobname + ".dcd", stepId))

binding_file = jobname + '_mdlambda.out'
f = open(binding_file, 'w')

deltalambda = (0.5 - 0.0)/float(loopStep)

for i in range(loopStep):
    simulation.step(stepId)
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
    lmbd += deltalambda
    lambda1 += deltalambda
    lambda2 += deltalambda
    simulation.context.setParameter(atmforce.Lambda1(), lambda1)
    simulation.context.setParameter(atmforce.Lambda2(), lambda2)

print( "SaveState ...")
simulation.saveState(jobname + "_0.xml")

#save a pdb file for visualization
positions = simulation.context.getState(getPositions=True).getPositions()
with open(jobname + '_0.pdb', 'w') as output:
  PDBFile.writeFile(simulation.topology, positions, output)

end=datetime.now()
elapsed=end - start
print("elapsed time="+str(elapsed.seconds+elapsed.microseconds*1e-6)+"s")
