source leaprc.water.tip3p
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/receptor/bcd-p.leaprc"
RCPT = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/receptor/bcd-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/receptor/bcd-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/ligands/g1s-p.leaprc"
LIG1 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/ligands/g1s-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/ligands/g1s-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/ligands/PHM0assR-p.leaprc"
LIG2 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/ligands/PHM0assR-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/postc/bCDg1PHM/ligands/PHM0assR-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bcd-g1s-PHM0assR.prmtop bcd-g1s-PHM0assR.inpcrd
savepdb MOL bcd-g1s-PHM0assR.pdb
quit
