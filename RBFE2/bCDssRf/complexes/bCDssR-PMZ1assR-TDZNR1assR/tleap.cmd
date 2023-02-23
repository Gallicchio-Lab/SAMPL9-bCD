source leaprc.water.tip3p
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/receptor/bCDssR-p.leaprc"
RCPT = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/receptor/bCDssR-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/receptor/bCDssR-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/ligands/PMZ1assR-p.leaprc"
LIG1 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/ligands/PMZ1assR-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/ligands/PMZ1assR-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/ligands/TDZNR1assR-p.leaprc"
LIG2 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/ligands/TDZNR1assR-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDssRf/ligands/TDZNR1assR-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bCDssR-PMZ1assR-TDZNR1assR.prmtop bCDssR-PMZ1assR-TDZNR1assR.inpcrd
savepdb MOL bCDssR-PMZ1assR-TDZNR1assR.pdb
quit
