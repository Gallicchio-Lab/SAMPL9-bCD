#!/bin/bash
#SBATCH -J bcd-PHM0assR-PMZ1assR
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=TG-MCB150001
#SBATCH --no-requeue
#SBATCH -t 26:00:00

#module purge
#module load gpu
#module load slurm

#echo "Number of nodes: $SLURM_NNODES"
#echo "Nodelist: $SLURM_NODELIST"
#echo "Number of tasks: $SLURM_NTASKS"
#echo "Tasks per node: $SLURM_TASKS_PER_NODE"
#echo "Assigned GPU: $CUDA_VISIBLE_DEVICES"

#jobname=bcd-PHM0assR-PMZ1assR
#dirname=`basename $SLURM_SUBMIT_DIR`

#echo "localhost,0:$CUDA_VISIBLE_DEVICES,1,centos-OpenCL,,/tmp" > nodefile

#cd ..

#rsync -av --exclude='slurm*.out' ${dirname} /scratch/$USER/job_$SLURM_JOB_ID/

#cd /scratch/$USER/job_$SLURM_JOB_ID/${dirname}

#for i in `seq 1 10` ; do
#    timeout --kill-after=30s --signal=9 3h  /home/u15684/software/openmm-7.6.0-ATMMetaForce-0.2.3/runopenmm /home/u15684/software/async_re-openmm/rbfe_explicit.py ${jobname}_asyncre.cntl &&  rsync -av * $SLURM_SUBMIT_DIR/ || exit 1
#done

cp ../../scripts/nodefile .
../../scripts/runopenmm /home/users/egallicchio/Dropbox/devel/src/async_re-openmm/rbfe_explicit.py bcd-PHM0assR-PMZ1assR_asyncre.cntl
