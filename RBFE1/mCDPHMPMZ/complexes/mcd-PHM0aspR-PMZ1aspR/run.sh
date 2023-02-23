#!/bin/bash
#
#SBATCH -J mcd-PHM0aspR-PMZ1aspR
#SBATCH --partition=<PARTITION>
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=<ACCOUNTNO>
#SBATCH --no-requeue
#SBATCH -t 02:15:00

cp ../../scripts/nodefile .
../../scripts/runopenmm /home/users/egallicchio/Dropbox/devel/src/async_re-openmm/rbfe_explicit.py mcd-PHM0aspR-PMZ1aspR_asyncre.cntl
