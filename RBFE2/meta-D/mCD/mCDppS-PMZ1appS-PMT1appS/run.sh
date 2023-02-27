#!/bin/bash
#
#!/bin/bash
#SBATCH -J ppS-mcd
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --account=TG-MCB150001
#SBATCH --no-requeue
#SBATCH -t 48:00:00

module purge
module load gpu
module load cuda10.2/blas/10.2.89 

echo "Number of nodes: $SLURM_NNODES"
echo "Nodelist: $SLURM_NODELIST"
echo "Number of tasks: $SLURM_NTASKS"
echo "Tasks per node: $SLURM_TASKS_PER_NODE"
echo "Assigned GPU: $CUDA_VISIBLE_DEVICES"

/home/u15684/software/openmm-7.6.0-ATMMetaForce-0.3.0-CUDA-10.2-Python-3.7/runopenmm /expanse/lustre/projects/rut147/sheenam/async_re-openmm/rbfe_explicit.py mCDppS-PMZ1appS-PMT1appS_asyncre.cntl
