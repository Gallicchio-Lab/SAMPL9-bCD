source leaprc.water.tip3p
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.leaprc"
RCPT = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0assR-p.leaprc"
LIG1 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0assR-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0assR-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1assR-p.leaprc"
LIG2 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1assR-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1assR-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bcd-PHM0assR-PMZ1assR.prmtop bcd-PHM0assR-PMZ1assR.inpcrd
savepdb MOL bcd-PHM0assR-PMZ1assR.pdb
quit
