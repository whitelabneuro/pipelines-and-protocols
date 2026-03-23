#!/usr/bin/env bash
set -euo pipefail

PIPELINE_VERSION="1.5.0"
PROFILE="singularity"

nextflow run nf-core/differentialabundance \
  -r "${PIPELINE_VERSION}" \
  -profile "${PROFILE}" \
  -params-file launch/params.gprofiler_go.yaml \
  -c launch/create.config \
  -resume
