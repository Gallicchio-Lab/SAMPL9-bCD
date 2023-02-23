
#basename for jobs
basename=bCDspSf

#path to ASyncRE
asyncre_dir=/home/users/jwu/Dropbox/github/async_re-openmm
#asyncre_dir=/home/u15684/software/async_re-openmm
#asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm


receptor=bCDspS

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms
#  ligands=("PMZ1aspS   CPZ1aspS"  "PMZ1aspS   CPZ0aspS"  "PMZ1aspS  PMT1aspS"  "PMZ1aspS  PMT0aspS"  "PMZ1aspS  PMZ0aspS"  "PMZ1aspS  TDZNR1aspS"  "PMZ1aspS  TDZNR0aspS"  "PMZ1aspS  TDZNS1aspS"  "PMZ1aspS  TDZNS0aspS"  "PMZ1aspS  TFP1aspS"  "PMZ1aspS  TFP1bspS"   "PMZ1aspS  TFP0aspS")
#ref_atoms=("20,18,2    20,18,12"  "20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2   20,18,2"   "20,18,2   20,18,2"    "20,18,2  24,22,12"    "20,18,2   24,22,12"    "20,18,2   24,22,12"    "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12"   "20,18,2   26,20,12") 

  ligands=("PMZ1aspS   CPZ1aspS"  "PMZ1aspS  PMT1aspS"  "PMZ1aspS  TDZNR1aspS"  "PMZ1aspS  TDZNS1aspS"  "PMZ1aspS  TFP1aspS"  "PMZ1aspS  TFP1bspS" )
ref_atoms=("20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2  24,22,12"     "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12" ) 

#displacement vector
displacement=("-30.0" "0.0" "0.0")
