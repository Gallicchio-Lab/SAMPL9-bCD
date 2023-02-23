
#basename for jobs
basename=mCDg1PHM

#path to ASyncRE
asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm

#basename of the receptor pdb file (processed for amber using pdb4amber)
receptor=mcd

#basenames of the ligand pairs (.mol2 format expected)
#with their reference alignment atoms
   ligands=("g1s   PHM0aspS" "g1s   PHM0assS" "g1s   PHM0aspR" "g1s   PHM0assR" "g1p   PHM0appS" "g1p   PHM0apsS" "g1p   PHM0appR" "g1p   PHM0apsR" )
 ref_atoms=("5,6,4 15,14,2"  "5,6,4 15,14,2"  "5,6,4 15,14,2"  "5,6,4 15,14,2"  "5,6,4 15,14,2"  "5,6,4 15,14,2"  "5,6,4 15,14,2"  "5,6,4 15,14,2" )
 theta_psi=("0.0   180.0"    "0.0   0.0"      "0.0   180.0"    "0.0   0.0"      "180.0 180.0"    "180.0 0.0"      "180.0 180.0"    "180.0 0.0")

#displacement vector
displacement=("-30.0" "0.0" "0.0")
