#!/bin/bash
#
#SBATCH -J bCDspR-PMZ1aspR-TDZNS1aspR
#SBATCH --partition=<PARTITION>
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=<ACCOUNTNO>
#SBATCH --no-requeue
#SBATCH -t 02:15:00

cp ../../scripts/nodefile .
../../scripts/runopenmm ../../../async_re-openmm/rbfe_explicit.py bCDspR-PMZ1aspR-TDZNS1aspR_asyncre.cntl