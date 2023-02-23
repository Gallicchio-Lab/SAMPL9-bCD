source leaprc.water.tip3p
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.leaprc"
RCPT = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/receptor/bcd-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0apsS-p.leaprc"
LIG1 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0apsS-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PHM0apsS-p.frcmod"
source "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1apsS-p.leaprc"
LIG2 = loadmol2 "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1apsS-p.mol2"
loadamberparams "/scratch/egallicchio/FFEngine/bCDPHMPMZ/ligands/PMZ1apsS-p.frcmod"
translate LIG2 {  -30.0 0.0 0.0  } 
MOL = combine {RCPT LIG1 LIG2}
addions2 MOL Na+ 5
addions2 MOL Cl- 5
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL bcd-PHM0apsS-PMZ1apsS.prmtop bcd-PHM0apsS-PMZ1apsS.inpcrd
savepdb MOL bcd-PHM0apsS-PMZ1apsS.pdb
quit
