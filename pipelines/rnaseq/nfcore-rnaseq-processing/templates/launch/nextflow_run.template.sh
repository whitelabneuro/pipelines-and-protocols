#!/bin/bash -l
#SBATCH --job-name=EDIT_PROJECT_ID
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=EDIT_EMAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=4gb
#SBATCH --time=12:00:00
#SBATCH --output=EDIT_PROJECT_SCRATCH/EDIT_PROJECT_ID/logs/%x-%j.out
#SBATCH --error=EDIT_PROJECT_SCRATCH/EDIT_PROJECT_ID/logs/%x-%j.err

set -euo pipefail

echo "Started at $(date)"
module load openjdk/17.0.8.1_1-gcc-13.2.0

# ------------------------------------------------------------------------------
# USER-EDITABLE PROJECT SETTINGS
# ------------------------------------------------------------------------------

PROJECT_ID="EDIT_PROJECT_ID"
DATASET_ID="EDIT_DATASET_ID"

PROJECT_SCRATCH_ROOT="/scratch/prj/bcn_whitema_rbp"
PROJECT_RDS_ROOT="/rds/prj/bcn_whitema_rbp"
USER_SCRATCH_ROOT="/scratch/users/k1643702"

REFERENCE_FASTA="/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/GRCh38.primary_assembly.genome.fa.gz"
REFERENCE_GTF="/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz"

NFCORE_RNASEQ_VERSION="3.23.0"
NXF_VER="25.10.4"
NFCORE_PROFILE="create"
ALIGNER="star_salmon"

# ------------------------------------------------------------------------------
# STANDARD WHITE LAB CREATE PATHS
# ------------------------------------------------------------------------------

BASE="${PROJECT_SCRATCH_ROOT}/${PROJECT_ID}"
LAUNCH_DIR="${BASE}/launch"
WORKDIR="${BASE}/work"
LOGDIR="${BASE}/logs"

RUNSTATE="${USER_SCRATCH_ROOT}/nextflow_runstate/${PROJECT_ID}"
export NXF_HOME="${USER_SCRATCH_ROOT}/nextflow_cache/nxf_home"
export NXF_SINGULARITY_CACHEDIR="${USER_SCRATCH_ROOT}/nextflow_cache/singularity_cache"
export SINGULARITY_CACHEDIR="$NXF_SINGULARITY_CACHEDIR"

mkdir -p "$RUNSTATE" "$LOGDIR" "$NXF_HOME" "$NXF_SINGULARITY_CACHEDIR"

# ------------------------------------------------------------------------------
# REQUIRED INPUT FILES IN PROJECT LAUNCH DIRECTORY
# ------------------------------------------------------------------------------

SOURCE_SAMPLESHEET="${LAUNCH_DIR}/samplesheet.csv"
CANON_SAMPLESHEET="${LAUNCH_DIR}/samplesheet.canon.csv"
CANON_SCRIPT="${LAUNCH_DIR}/make_canonical_samplesheet.sh"
NEXTFLOW_CONFIG="${LAUNCH_DIR}/nextflow.config"

if [[ ! -f "$SOURCE_SAMPLESHEET" ]]; then
  echo "ERROR: source samplesheet not found: $SOURCE_SAMPLESHEET"
  exit 1
fi

if [[ ! -x "$CANON_SCRIPT" ]]; then
  echo "ERROR: canonical samplesheet script not found or not executable: $CANON_SCRIPT"
  exit 1
fi

if [[ ! -f "$NEXTFLOW_CONFIG" ]]; then
  echo "ERROR: nextflow config not found: $NEXTFLOW_CONFIG"
  exit 1
fi

# ------------------------------------------------------------------------------
# GENERATE CANONICAL SAMPLE SHEET
# ------------------------------------------------------------------------------

bash "$CANON_SCRIPT" "$SOURCE_SAMPLESHEET" "$CANON_SAMPLESHEET"

# ------------------------------------------------------------------------------
# OUTPUT DIRECTORY LOGIC
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

mkdir -p "$OUTDIR"

# ------------------------------------------------------------------------------
# RUN MANIFEST
# ------------------------------------------------------------------------------

RUN_MANIFEST="${OUTDIR}/run_manifest.txt"

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
  echo "nfcore_version=${NFCORE_RNASEQ_VERSION}"
  echo "profile=${NFCORE_PROFILE}"
  echo "aligner=${ALIGNER}"
  echo "fasta=${REFERENCE_FASTA}"
  echo "gtf=${REFERENCE_GTF}"
  echo "samplesheet=${CANON_SAMPLESHEET}"
} > "$RUN_MANIFEST"

echo "BASE=$BASE"
echo "LAUNCH_DIR=$LAUNCH_DIR"
echo "WORKDIR=$WORKDIR"
echo "RUNSTATE=$RUNSTATE"
echo "OUTDIR=$OUTDIR"
echo "RESUME_FLAG=$RESUME_FLAG"

cd "$RUNSTATE"

# ------------------------------------------------------------------------------
# INSTALL / VERIFY LOCAL NEXTFLOW BINARY
# ------------------------------------------------------------------------------

if [[ ! -x ./nextflow || "$(./nextflow -version 2>/dev/null | awk '/version/{print $3; exit}')" != "$NXF_VER" ]]; then
  rm -f ./nextflow
  wget -qO- https://get.nextflow.io | bash
  chmod +x ./nextflow
fi

./nextflow -version | tee -a "$RUN_MANIFEST"

# ------------------------------------------------------------------------------
# LAUNCH NF-CORE/RNASEQ
# ------------------------------------------------------------------------------

./nextflow run nf-core/rnaseq \
  -c "$NEXTFLOW_CONFIG" \
  -r "$NFCORE_RNASEQ_VERSION" \
  -profile "$NFCORE_PROFILE" \
  -work-dir "$WORKDIR" \
  --input "$CANON_SAMPLESHEET" \
  --aligner "$ALIGNER" \
  --fasta "$REFERENCE_FASTA" \
  --gtf "$REFERENCE_GTF" \
  --outdir "$OUTDIR" \
  --save_align_intermeds \
  --gencode \
  --save_reference \
  $RESUME_FLAG \
  2>&1 | tee "$LOGDIR/${PROJECT_ID}_nextflow.log"
