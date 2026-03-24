#!/bin/bash -l
#SBATCH --job-name=klim_gsea_hm
#SBATCH --output=/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/logs/%x-%j.out
#SBATCH --error=/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/logs/%x-%j.err
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --partition=cpu

set -euo pipefail

echo "Started at $(date)"
module load openjdk/17.0.8.1_1-gcc-13.2.0

# ------------------------------------------------------------------------------
# PROJECT SETTINGS
# ------------------------------------------------------------------------------

PROJECT_ID="Klim_TDP_LOF_dge"
DATASET_ID="klim2019_tdp43kd_hallmark"

PROJECT_SCRATCH_ROOT="$(readlink -f /scratch/prj/bcn_whitema_rbp)"
USER_SCRATCH_ROOT="/scratch/users/k1643702"

QUANT_DIR="$(readlink -f /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification)"
REFERENCE_GTF="$(readlink -f /scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz)"

NFCORE_DA_VERSION="1.5.0"
NXF_VER="25.10.4"
NFCORE_PROFILE="singularity"

# ------------------------------------------------------------------------------
# STANDARD WHITE LAB CREATE PATHS
# ------------------------------------------------------------------------------

BASE="${PROJECT_SCRATCH_ROOT}/Klim_TDP_LOF_dge"
LAUNCH_DIR="${BASE}/launch"
INPUTS_DIR="${BASE}/inputs"
WORKDIR="${BASE}/work"
LOGDIR="${BASE}/logs"
RUN_METADATA_DIR="${BASE}/retained_run_metadata"

RUNSTATE="${USER_SCRATCH_ROOT}/nextflow_runstate/${PROJECT_ID}"
export NXF_HOME="${USER_SCRATCH_ROOT}/nextflow_cache/nxf_home"
export NXF_SINGULARITY_CACHEDIR="${USER_SCRATCH_ROOT}/nextflow_cache/singularity_cache"
export SINGULARITY_CACHEDIR="${NXF_SINGULARITY_CACHEDIR}"

mkdir -p "$RUNSTATE" "$LOGDIR" "$WORKDIR" "$RUN_METADATA_DIR" "$NXF_HOME" "$NXF_SINGULARITY_CACHEDIR"

# ------------------------------------------------------------------------------
# REQUIRED INPUT FILES
# ------------------------------------------------------------------------------

PARAMS_FILE="${LAUNCH_DIR}/params.gsea_hallmark.yaml"
CREATE_CONFIG="${LAUNCH_DIR}/create.config"
METADATA_FILE="${INPUTS_DIR}/sample_metadata.csv"
CONTRASTS_FILE="${INPUTS_DIR}/contrasts.gsea_hallmark.csv"
MATRIX_FILE="${QUANT_DIR}/salmon.merged.gene_counts.tsv"
LENGTHS_FILE="${QUANT_DIR}/salmon.merged.gene_lengths.tsv"

for required_file in \
    "$PARAMS_FILE" \
    "$CREATE_CONFIG" \
    "$METADATA_FILE" \
    "$CONTRASTS_FILE" \
    "$MATRIX_FILE" \
    "$LENGTHS_FILE" \
    "$REFERENCE_GTF"
do
    if [[ ! -f "$required_file" ]]; then
        echo "ERROR: required file not found: $required_file"
        exit 1
    fi
done

# ------------------------------------------------------------------------------
# OUTPUT DIRECTORY LOGIC
# ------------------------------------------------------------------------------

OUTDIR_FILE="${RUNSTATE}/last_outdir_gsea_hallmark.txt"

if [[ "${RESUME:-0}" == "1" ]]; then
    if [[ -n "${OUTDIR:-}" ]]; then
        OUTDIR="$(readlink -f "$OUTDIR")"
    elif [[ -f "$OUTDIR_FILE" ]]; then
        OUTDIR="$(cat "$OUTDIR_FILE")"
    else
        echo "ERROR: RESUME=1 but no OUTDIR provided and no recorded outdir found."
        exit 1
    fi

    if [[ ! -d "$OUTDIR" ]]; then
        echo "ERROR: resume requested but outdir does not exist: $OUTDIR"
        exit 1
    fi

    RESUME_FLAG="-resume"
else
    OUTDIR="${BASE}/out_$(date +%Y%m%d_%H%M%S)_gsea_hallmark"
    echo "$OUTDIR" > "$OUTDIR_FILE"
    RESUME_FLAG=""
fi

mkdir -p "$OUTDIR"

# ------------------------------------------------------------------------------
# RUN MANIFEST
# ------------------------------------------------------------------------------

RUN_MANIFEST="${RUN_METADATA_DIR}/run_manifest_gsea_hallmark.txt"

{
    echo "run_start=$(date --iso-8601=seconds)"
    echo "project_id=${PROJECT_ID}"
    echo "dataset_id=${DATASET_ID}"
    echo "base=${BASE}"
    echo "launch_dir=${LAUNCH_DIR}"
    echo "inputs_dir=${INPUTS_DIR}"
    echo "quant_dir=${QUANT_DIR}"
    echo "workdir=${WORKDIR}"
    echo "runstate=${RUNSTATE}"
    echo "outdir=${OUTDIR}"
    echo "resume_flag=${RESUME_FLAG}"
    echo "nxf_ver=${NXF_VER}"
    echo "nfcore_pipeline=nf-core/differentialabundance"
    echo "nfcore_version=${NFCORE_DA_VERSION}"
    echo "profile=${NFCORE_PROFILE}"
    echo "matrix=${MATRIX_FILE}"
    echo "transcript_length_matrix=${LENGTHS_FILE}"
    echo "gtf=${REFERENCE_GTF}"
    echo "metadata=${METADATA_FILE}"
    echo "contrasts=${CONTRASTS_FILE}"
    echo "params_file=${PARAMS_FILE}"
    echo "create_config=${CREATE_CONFIG}"
} > "$RUN_MANIFEST"

echo "BASE=$BASE"
echo "LAUNCH_DIR=$LAUNCH_DIR"
echo "INPUTS_DIR=$INPUTS_DIR"
echo "QUANT_DIR=$QUANT_DIR"
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
# LAUNCH NF-CORE/DIFFERENTIALABUNDANCE
# ------------------------------------------------------------------------------

./nextflow run nf-core/differentialabundance \
    -r "$NFCORE_DA_VERSION" \
    -profile "$NFCORE_PROFILE" \
    -c "$CREATE_CONFIG" \
    -work-dir "$WORKDIR" \
    -params-file "$PARAMS_FILE" \
    --outdir "$OUTDIR" \
    $RESUME_FLAG \
    2>&1 | tee "$LOGDIR/${PROJECT_ID}_nextflow.log"
