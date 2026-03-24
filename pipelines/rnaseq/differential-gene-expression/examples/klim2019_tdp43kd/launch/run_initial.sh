#!/usr/bin/env bash
#SBATCH --job-name=klim_dge_init
#SBATCH --output=logs/klim_dge_init_%j.out
#SBATCH --error=logs/klim_dge_init_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --partition=cpu

cd /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge

set -euo pipefail

PIPELINE_VERSION="1.5.0"
PROFILE="singularity"

nextflow run nf-core/differentialabundance \
  -r "${PIPELINE_VERSION}" \
  -profile "${PROFILE}" \
  -params-file launch/params.initial.yaml \
  -c launch/create.config \
  -resume
