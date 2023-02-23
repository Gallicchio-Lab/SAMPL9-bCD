source leaprc.water.tip3p
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/receptor/mcd-p.leaprc"
RCPT = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/receptor/mcd-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/receptor/mcd-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/ligands/PHM0appS-p.leaprc"
LIG1 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/ligands/PHM0appS-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/ligands/PHM0appS-p.frcmod"
source "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/ligands/PMZ1appS-p.leaprc"
LIG2 = loadmol2 "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/ligands/PMZ1appS-p.mol2"
loadamberparams "/home/emilio/Dropbox/sims/SAMPL9/work/FFEngine/mCDPHMPMZ/ligands/PMZ1appS-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL mcd-PHM0appS-PMZ1appS.prmtop mcd-PHM0appS-PMZ1appS.inpcrd
savepdb MOL mcd-PHM0appS-PMZ1appS.pdb
quit
