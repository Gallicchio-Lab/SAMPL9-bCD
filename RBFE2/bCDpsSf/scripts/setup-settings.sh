
#basename for jobs
basename=bCDpsSf

#path to ASyncRE
asyncre_dir=/home/users/jwu/Dropbox/github/async_re-openmm
#asyncre_dir=/home/u15684/software/async_re-openmm
#asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm


receptor=bCDpsS

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms
#  ligands=("PMZ1apsS   CPZ1apsS"  "PMZ1apsS   CPZ0apsS"  "PMZ1apsS  PMT1apsS"  "PMZ1apsS  PMT0apsS"  "PMZ1apsS  PMZ0apsS"  "PMZ1apsS  TDZNR1apsS"  "PMZ1apsS  TDZNR0apsS"  "PMZ1apsS  TDZNS1apsS"  "PMZ1apsS  TDZNS0apsS"  "PMZ1apsS  TFP1apsS"  "PMZ1apsS  TFP1bpsS"   "PMZ1apsS  TFP0apsS")
#ref_atoms=("20,18,2    20,18,12"  "20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2   20,18,2"   "20,18,2   20,18,2"    "20,18,2  24,22,12"    "20,18,2   24,22,12"    "20,18,2   24,22,12"    "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12"   "20,18,2   26,20,12") 

  ligands=("PMZ1apsS   CPZ1apsS"  "PMZ1apsS  PMT1apsS"  "PMZ1apsS  TDZNR1apsS"  "PMZ1apsS  TDZNS1apsS"  "PMZ1apsS  TFP1apsS"  "PMZ1apsS  TFP1bpsS" )
ref_atoms=("20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2  24,22,12"     "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12" ) 

#displacement vector
displacement=("-30.0" "0.0" "0.0")
