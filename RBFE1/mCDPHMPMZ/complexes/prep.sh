#!/bin/bash
#
#SBATCH -J mcd
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=<ACCOUNTNO>
#SBATCH --no-requeue
#SBATCH -t 02:15:00

for pair in PHM0aspS-PMZ1aspS PHM0assS-PMZ1assS PHM0aspR-PMZ1aspR PHM0assR-PMZ1assR PHM0appS-PMZ1appS PHM0apsS-PMZ1apsS PHM0appR-PMZ1appR PHM0apsR-PMZ1apsR ; do
    jobname=mcd-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_equil.py  )  || exit 1
done
