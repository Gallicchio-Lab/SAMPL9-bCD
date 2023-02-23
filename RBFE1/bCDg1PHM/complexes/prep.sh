#!/bin/bash
#
#SBATCH -J bcd
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=<ACCOUNTNO>
#SBATCH --no-requeue
#SBATCH -t 02:15:00

for pair in g1s-PHM0aspS g1s-PHM0assS g1s-PHM0aspR g1s-PHM0assR g1p-PHM0appS g1p-PHM0apsS g1p-PHM0appR g1p-PHM0apsR ; do
    jobname=bcd-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_equil.py  )  || exit 1
done
