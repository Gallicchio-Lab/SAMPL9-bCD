source leaprc.water.tip3p
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/receptor/mCDppR-p.leaprc"
RCPT = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/receptor/mCDppR-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/receptor/mCDppR-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/ligands/PMZ1appR-p.leaprc"
LIG1 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/ligands/PMZ1appR-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/ligands/PMZ1appR-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/ligands/TDZNS1appR-p.leaprc"
LIG2 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/ligands/TDZNS1appR-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDppRf/ligands/TDZNS1appR-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL mCDppR-PMZ1appR-TDZNS1appR.prmtop mCDppR-PMZ1appR-TDZNS1appR.inpcrd
savepdb MOL mCDppR-PMZ1appR-TDZNS1appR.pdb
quit
