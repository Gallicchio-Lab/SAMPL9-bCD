
#basename for jobs
basename=bCDssSf

#path to ASyncRE
asyncre_dir=/home/users/jwu/Dropbox/github/async_re-openmm
#asyncre_dir=/home/u15684/software/async_re-openmm
#asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm


receptor=bCDssS

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms
#  ligands=("PMZ1assS   CPZ1assS"  "PMZ1assS   CPZ0assS"  "PMZ1assS  PMT1assS"  "PMZ1assS  PMT0assS"  "PMZ1assS  PMZ0assS"  "PMZ1assS  TDZNR1assS"  "PMZ1assS  TDZNR0assS"  "PMZ1assS  TDZNS1assS"  "PMZ1assS  TDZNS0assS"  "PMZ1assS  TFP1assS"  "PMZ1assS  TFP1bssS"   "PMZ1assS  TFP0assS")
#ref_atoms=("20,18,2    20,18,12"  "20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2   20,18,2"   "20,18,2   20,18,2"    "20,18,2  24,22,12"    "20,18,2   24,22,12"    "20,18,2   24,22,12"    "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12"   "20,18,2   26,20,12") 

  ligands=("PMZ1assS   CPZ1assS"  "PMZ1assS  PMT1assS"  "PMZ1assS  TDZNR1assS"  "PMZ1assS  TDZNS1assS"  "PMZ1assS  TFP1assS"  "PMZ1assS  TFP1bssS" )
ref_atoms=("20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2  24,22,12"     "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12" ) 

#displacement vector
displacement=("-30.0" "0.0" "0.0")
