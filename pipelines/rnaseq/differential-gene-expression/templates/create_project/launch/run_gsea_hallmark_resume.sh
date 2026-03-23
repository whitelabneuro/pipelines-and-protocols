#!/usr/bin/env bash
set -euo pipefail

PIPELINE_VERSION="1.5.0"
PROFILE="singularity"

nextflow run nf-core/differentialabundance \
  -r "${PIPELINE_VERSION}" \
  -profile "${PROFILE}" \
  -params-file launch/params.gsea_hallmark.yaml \
  -c launch/create.config \
  -resume
