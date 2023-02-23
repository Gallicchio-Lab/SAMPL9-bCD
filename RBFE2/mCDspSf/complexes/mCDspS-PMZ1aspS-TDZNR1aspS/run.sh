#!/bin/bash
#
#SBATCH -J mCDspS-PMZ1aspS-TDZNR1aspS
#SBATCH --partition=<PARTITION>
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=<ACCOUNTNO>
#SBATCH --no-requeue
#SBATCH -t 02:15:00

cp ../../scripts/nodefile .
../../scripts/runopenmm ../../../async_re-openmm/rbfe_explicit.py mCDspS-PMZ1aspS-TDZNR1aspS_asyncre.cntl
