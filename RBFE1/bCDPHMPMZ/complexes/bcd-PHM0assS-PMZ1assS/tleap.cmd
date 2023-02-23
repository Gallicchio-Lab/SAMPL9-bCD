source leaprc.water.tip3p
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.leaprc"
RCPT = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0assS-p.leaprc"
LIG1 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0assS-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0assS-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1assS-p.leaprc"
LIG2 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1assS-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1assS-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bcd-PHM0assS-PMZ1assS.prmtop bcd-PHM0assS-PMZ1assS.inpcrd
savepdb MOL bcd-PHM0assS-PMZ1assS.pdb
quit
