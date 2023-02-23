
#basename for jobs
basename=mCD

#basename of the receptor mol2 file (processed for amber using antechamber)
#receptor=bCD
receptor=mcd

#basenames of the ligands (.mol2 format expected)
#ligands=(g1s)
ligands=(g1p)
#ligands=(pnitro7s)

#displacement vector
displacement=("15.0" "15.0" "15.0")

#path to ASyncRE
asyncre_dir=/home/users/egallicchio/Dropbox/devel/src/async_re-openmm
