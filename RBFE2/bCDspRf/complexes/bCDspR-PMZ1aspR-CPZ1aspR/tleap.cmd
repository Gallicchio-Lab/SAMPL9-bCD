source leaprc.water.tip3p
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/receptor/bCDspR-p.leaprc"
RCPT = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/receptor/bCDspR-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/receptor/bCDspR-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/ligands/PMZ1aspR-p.leaprc"
LIG1 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/ligands/PMZ1aspR-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/ligands/PMZ1aspR-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/ligands/CPZ1aspR-p.leaprc"
LIG2 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/ligands/CPZ1aspR-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspRf/ligands/CPZ1aspR-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bCDspR-PMZ1aspR-CPZ1aspR.prmtop bCDspR-PMZ1aspR-CPZ1aspR.inpcrd
savepdb MOL bCDspR-PMZ1aspR-CPZ1aspR.pdb
quit
