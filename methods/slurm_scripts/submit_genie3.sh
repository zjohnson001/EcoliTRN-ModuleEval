#!/bin/bash
#SBATCH -A transcriptome_20z
#SBATCH --job-name=GENIE3_ecoli_precise2k
#SBATCH --output=GENIE3_ecoli_precise2k-%A.out
#SBATCH --error=GENIE3_ecoli_precise2k-%A.out
#SBATCH --nodes=1	     # Request a full node
#SBATCH --ntasks=1           # Request 1 tasks for all array on the same node
#SBATCH --cpus-per-task=40   # Request 8 cpus/cores per task
#SBATCH --time=4:00:00
#SBATCH --partition=shared

module load python/miniconda24.1.2
source /share/apps/python/miniconda24.1.2/etc/profile.d/conda.sh
conda activate genie3

export PATH=$PATH:/rcfs/projects/transcriptome_20z/projects/module_evaluation

COUNTS_PATH=/rcfs/projects/transcriptome_20z/projects/module_evaluation/log_tpm_norm_qc.csv

#genie3_args.R --counts $COUNTS_PATH --cores 20 --treeMethod RF --nTrees 1000 --returnMatrix --verbose
genie3_args.R --counts $COUNTS_PATH --cores 20 --treeMethod ET --nTrees 1000 --returnMatrix --verbose

