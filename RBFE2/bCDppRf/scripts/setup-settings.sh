
#basename for jobs
basename=bCDppRf

#path to ASyncRE
asyncre_dir=/home/users/jwu/Dropbox/github/async_re-openmm
#asyncre_dir=/home/u15684/software/async_re-openmm
#asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm


receptor=bCDppR

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms
  ligands=("PMZ1appR   CPZ1appR"  "PMZ1appR  PMT1appR"  "PMZ1appR  TDZNR1appR"  "PMZ1appR  TDZNS1appR"  "PMZ1appR  TFP1appR"  "PMZ1appR  TFP1bppR" )
ref_atoms=("20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2  24,22,12"     "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12" ) 

#displacement vector
displacement=("-30.0" "0.0" "0.0")
