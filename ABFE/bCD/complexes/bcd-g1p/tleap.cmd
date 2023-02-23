source leaprc.water.tip3p
source "/home/emilio/Dropbox/sims/SAMPL7/FFEngine/bCD/receptor/bcd-p.leaprc"
RCPT = loadmol2 "/home/emilio/Dropbox/sims/SAMPL7/FFEngine/bCD/receptor/bcd-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL7/FFEngine/bCD/receptor/bcd-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL7/FFEngine/bCD/ligands/g1p-p.leaprc"
LIG = loadmol2 "/home/emilio/Dropbox/sims/SAMPL7/FFEngine/bCD/ligands/g1p-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL7/FFEngine/bCD/ligands/g1p-p.frcmod"
MOL = combine {RCPT LIG}
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bcd-g1p.prmtop bcd-g1p.inpcrd
savepdb MOL bcd-g1p.pdb
quit
