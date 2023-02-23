source leaprc.water.tip3p
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.leaprc"
RCPT = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0aspS-p.leaprc"
LIG1 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0aspS-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0aspS-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1aspS-p.leaprc"
LIG2 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1aspS-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1aspS-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bcd-PHM0aspS-PMZ1aspS.prmtop bcd-PHM0aspS-PMZ1aspS.inpcrd
savepdb MOL bcd-PHM0aspS-PMZ1aspS.pdb
quit
