#!/usr/bin/env bash
set -euo pipefail

SAMPLESHEET="$1"
OUTDIR="$2"
WORKDIR="$3"
GENOME="$4"

mkdir -p "${OUTDIR}"
mkdir -p "${WORKDIR}"
mkdir -p "${OUTDIR}/logs"

echo "Launching nf-core/rnaseq"
echo "Samplesheet: ${SAMPLESHEET}"
echo "Output dir: ${OUTDIR}"
echo "Work dir: ${WORKDIR}"
echo "Genome: ${GENOME}"

nextflow run nf-core/rnaseq \
  -profile create_hpc \
  --input "${SAMPLESHEET}" \
  --outdir "${OUTDIR}" \
  --genome "${GENOME}" \
  -work-dir "${WORKDIR}" \
  -resume \
  2>&1 | tee "${OUTDIR}/logs/nfcore_rnaseq_launch.log"
