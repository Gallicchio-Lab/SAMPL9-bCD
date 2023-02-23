
#basename for jobs
basename=mCDssRf

#path to ASyncRE
#asyncre_dir=/home/users/jwu/Dropbox/github/async_re-openmm
#asyncre_dir=/home/u15684/software/async_re-openmm
#asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm
asyncre_dir=~/Dropbox/sims/SAMPL9/work/FFEngine/postc/async_re-openmm

receptor=mCDssR

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms

  ligands=("PMZ1assR   CPZ1assR"  "PMZ1assR  PMT1assR"  "PMZ1assR  TDZNR1assR"  "PMZ1assR  TDZNS1assR"  "PMZ1assR  TFP1assR"  "PMZ1assR  TFP1bssR" )
ref_atoms=("20,18,2    20,18,12"  "20,18,2   20,18,2"   "20,18,2  24,22,12"     "20,18,2   24,22,12"    "20,18,2   26,20,12"  "20,18,2   26,20,12" ) 

#displacement vector
displacement=("-30.0" "0.0" "0.0")

