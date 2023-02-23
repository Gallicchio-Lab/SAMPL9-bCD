
#basename for jobs
basename=mCDspSf

#path to ASyncRE
#asyncre_dir=/home/u15684/software/async_re-openmm
#asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm
asyncre_dir=/projects2/insite/emilio.gallicchio/software/async_re-openmm

receptor=mcd

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms
  ligands=("PMZ1aspS   CPZ1aspS"  "PMZ1aspS  PMT1aspS"  "PMZ1aspS  TDZNR1aspS"  "PMZ1aspS  TDZNS1aspS"  "PMZ1aspS  TFP1aspS"  "PMZ1aspS  TFP1bspS" )
ref_atoms=("20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2  24,22,12"     "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12" ) 

#displacement vector
displacement=("-30.0" "0.0" "0.0")
