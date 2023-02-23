#!/bin/bash
#
#SBATCH -J mCDpsS-PMZ1apsS-TFP1bpsS
#SBATCH --partition=<PARTITION>
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=<ACCOUNTNO>
#SBATCH --no-requeue
#SBATCH -t 02:15:00

cp ../../scripts/nodefile .
../../scripts/runopenmm ../../../async_re-openmm/rbfe_explicit.py mCDpsS-PMZ1apsS-TFP1bpsS_asyncre.cntl
