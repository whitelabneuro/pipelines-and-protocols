#!/bin/bash -l
#SBATCH --job-name=klim2019_tdp43kd
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=matthew.white@kcl.ac.uk
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=4gb
#SBATCH --time=12:00:00
#SBATCH --output=/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF/logs/%x-%j.out
#SBATCH --error=/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF/logs/%x-%j.err

set -euo pipefail

echo "Started at $(date)"
module load openjdk/17.0.8.1_1-gcc-13.2.0

export NXF_VER=25.10.4

# ------------------------------------------------------------------------------
# White Lab standard CREATE execution model
# ------------------------------------------------------------------------------
PROJECT_ID="Klim_TDP_LOF"
DATASET_ID="klim2019_tdp43kd"
BASE="/scratch/prj/bcn_whitema_rbp/${PROJECT_ID}"
LAUNCH_DIR="${BASE}/launch"
WORKDIR="${BASE}/work"
LOGDIR="${BASE}/logs"

RUNSTATE="/scratch/users/k1643702/nextflow_runstate/${PROJECT_ID}"
export NXF_HOME="/scratch/users/k1643702/nextflow_cache/nxf_home"
export NXF_SINGULARITY_CACHEDIR="/scratch/users/k1643702/nextflow_cache/singularity_cache"
export SINGULARITY_CACHEDIR="$NXF_SINGULARITY_CACHEDIR"

mkdir -p "$RUNSTATE" "$LOGDIR" "$NXF_HOME" "$NXF_SINGULARITY_CACHEDIR"

# ------------------------------------------------------------------------------
# Output directory logic
# ------------------------------------------------------------------------------
OUTDIR_FILE="$RUNSTATE/last_outdir.txt"

if [[ "${RESUME:-0}" == "1" ]]; then
  if [[ -n "${OUTDIR:-}" ]]; then
    OUTDIR="$(readlink -f "$OUTDIR")"
  elif [[ -f "$OUTDIR_FILE" ]]; then
    OUTDIR="$(cat "$OUTDIR_FILE")"
  else
    echo "ERROR: RESUME=1 but no OUTDIR provided and no recorded outdir found."
    exit 1
  fi
  RESUME_FLAG="-resume"
else
  OUTDIR="$BASE/out_$(date +%Y%m%d_%H%M%S)"
  echo "$OUTDIR" > "$OUTDIR_FILE"
  RESUME_FLAG=""
fi

# ------------------------------------------------------------------------------
# Run manifest
# ------------------------------------------------------------------------------
RUN_MANIFEST="${OUTDIR}/run_manifest.txt"
mkdir -p "$OUTDIR"

{
  echo "run_start=$(date --iso-8601=seconds)"
  echo "project_id=${PROJECT_ID}"
  echo "dataset_id=${DATASET_ID}"
  echo "base=${BASE}"
  echo "launch_dir=${LAUNCH_DIR}"
  echo "workdir=${WORKDIR}"
  echo "runstate=${RUNSTATE}"
  echo "outdir=${OUTDIR}"
  echo "resume_flag=${RESUME_FLAG}"
  echo "nxf_ver=${NXF_VER}"
  echo "nfcore_pipeline=nf-core/rnaseq"
  echo "nfcore_version=3.23.0"
  echo "aligner=star_salmon"
  echo "fasta=/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/GRCh38.primary_assembly.genome.fa.gz"
  echo "gtf=/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz"
  echo "samplesheet=${LAUNCH_DIR}/samplesheet.canon.csv"
} > "$RUN_MANIFEST"

echo "BASE=$BASE"
echo "LAUNCH_DIR=$LAUNCH_DIR"
echo "WORKDIR=$WORKDIR"
echo "RUNSTATE=$RUNSTATE"
echo "OUTDIR=$OUTDIR"
echo "RESUME_FLAG=$RESUME_FLAG"

cd "$RUNSTATE"

# ------------------------------------------------------------------------------
# Install / verify local Nextflow binary
# ------------------------------------------------------------------------------
if [[ ! -x ./nextflow || "$(./nextflow -version 2>/dev/null | awk '/version/{print $3; exit}')" != "$NXF_VER" ]]; then
  rm -f ./nextflow
  wget -qO- https://get.nextflow.io | bash
  chmod +x ./nextflow
fi

./nextflow -version | tee -a "$RUN_MANIFEST"

# ------------------------------------------------------------------------------
# Launch pipeline
# ------------------------------------------------------------------------------
./nextflow run nf-core/rnaseq \
  -c "$LAUNCH_DIR/nextflow.config" \
  -r 3.23.0 \
  -profile create \
  -work-dir "$WORKDIR" \
  --input "$LAUNCH_DIR/samplesheet.canon.csv" \
  --aligner star_salmon \
  --fasta /scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/GRCh38.primary_assembly.genome.fa.gz \
  --gtf /scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz \
  --outdir "$OUTDIR" \
  --save_align_intermeds \
  --gencode \
  --save_reference \
  $RESUME_FLAG \
  2>&1 | tee "$LOGDIR/${PROJECT_ID}_nextflow.log"
