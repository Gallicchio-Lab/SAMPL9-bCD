#!/bin/bash
#
#SBATCH -J SMPL-prep
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=TG-MCB150001
#SBATCH --no-requeue
#SBATCH -t 08:00:00

for pair in <LIGPAIRS> ; do
    jobname=<RECEPTOR>-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_equil.py  )  || exit 1
done
