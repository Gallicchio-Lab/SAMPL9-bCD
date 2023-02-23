source leaprc.water.tip3p
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/receptor/bCDspS-p.leaprc"
RCPT = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/receptor/bCDspS-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/receptor/bCDspS-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/ligands/PMZ1aspS-p.leaprc"
LIG1 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/ligands/PMZ1aspS-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/ligands/PMZ1aspS-p.frcmod"
source "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/ligands/TFP1bspS-p.leaprc"
LIG2 = loadmol2 "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/ligands/TFP1bspS-p.mol2"
loadamberparams "/home/users/egallicchio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDspSf/ligands/TFP1bspS-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bCDspS-PMZ1aspS-TFP1bspS.prmtop bCDspS-PMZ1aspS-TFP1bspS.inpcrd
savepdb MOL bCDspS-PMZ1aspS-TFP1bspS.pdb
quit
