source leaprc.water.tip3p
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/receptor/mcd-p.leaprc"
RCPT = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/receptor/mcd-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/receptor/mcd-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/ligands/g1p-p.leaprc"
LIG1 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/ligands/g1p-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/ligands/g1p-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/ligands/PHM0appR-p.leaprc"
LIG2 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/ligands/PHM0appR-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/mCDg1PHM/ligands/PHM0appR-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL mcd-g1p-PHM0appR.prmtop mcd-g1p-PHM0appR.inpcrd
savepdb MOL mcd-g1p-PHM0appR.pdb
quit
