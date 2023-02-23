source leaprc.water.tip3p
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/receptor/bCDpsS-p.leaprc"
RCPT = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/receptor/bCDpsS-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/receptor/bCDpsS-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/ligands/PMZ1apsS-p.leaprc"
LIG1 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/ligands/PMZ1apsS-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/ligands/PMZ1apsS-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/ligands/TFP1bpsS-p.leaprc"
LIG2 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/ligands/TFP1bpsS-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDpsSf/ligands/TFP1bpsS-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bCDpsS-PMZ1apsS-TFP1bpsS.prmtop bCDpsS-PMZ1apsS-TFP1bpsS.inpcrd
savepdb MOL bCDpsS-PMZ1apsS-TFP1bpsS.pdb
quit
