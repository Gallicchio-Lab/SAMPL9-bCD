
#basename for jobs
basename=bCDPHMPMZ

#path to ASyncRE
#asyncre_dir=/home/u15684/software/async_re-openmm
asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm


receptor=bcd

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms
  ligands=("PHM0aspS   PMZ1aspS" "PHM0assS    PMZ1assS" "PHM0aspR    PMZ1aspR" "PHM0assR   PMZ1assR" "PHM0appS    PMZ1appS" "PHM0apsS   PMZ1apsS" "PHM0appR   PMZ1appR" "PHM0apsR   PMZ1apsR" )
 ref_atoms=("15,14,2    20,18,2"  "15,14,2     20,18,2"  "15,14,2     20,18,2"  "15,14,2    20,18,2"  "15,14,2     20,18,2"  "15,14,2    20,18,2"  "15,14,2    20,18,2"  "15,14,2    20,18,2" )
 theta_psi=("0.0   180.0"         "0.0   0.0"            "0.0   180.0"          "0.0   0.0"           "180.0 180.0"          "180.0 0.0"           "180.0 180.0"         "180.0 0.0")

#displacement vector
displacement=("-30.0" "0.0" "0.0")
