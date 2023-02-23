source leaprc.water.tip3p
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/receptor/mCDspS-p.leaprc"
RCPT = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/receptor/mCDspS-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/receptor/mCDspS-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/ligands/PMZ1aspS-p.leaprc"
LIG1 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/ligands/PMZ1aspS-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/ligands/PMZ1aspS-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/ligands/PMT1aspS-p.leaprc"
LIG2 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/ligands/PMT1aspS-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDspSf/ligands/PMT1aspS-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL mCDspS-PMZ1aspS-PMT1aspS.prmtop mCDspS-PMZ1aspS-PMT1aspS.inpcrd
savepdb MOL mCDspS-PMZ1aspS-PMT1aspS.pdb
quit
