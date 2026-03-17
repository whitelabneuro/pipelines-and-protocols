# nfcore-rnaseq-processing

White Lab reusable short-read RNA-seq intake and primary processing workflow.

## Scope

This workflow is designed to take raw FASTQ files through primary processing using `nf-core/rnaseq`, generating alignment, quantification, QC, and provenance outputs suitable for downstream differential expression, splicing, and isoform-level analysis.

## Current scope includes

- FASTQ intake
- samplesheet preparation
- metadata standardisation
- nf-core/rnaseq execution
- run logging and provenance capture
- QC review and run summary reporting

## Current scope excludes

- differential expression
- differential splicing
- isoform switching
- downstream biological interpretation

## Initial development dataset

Public RNA-seq data from Klim et al. 2019 (PMID: 30643292), using TDP-43 knockdown human iPSC-derived motor neurons as a representative development dataset.

## Execution environment

Currently developed for King's College London CREATE HPC.

## Structure

- `docs/` - workflow documentation
- `configs/` - Nextflow and parameter configuration
- `templates/` - samplesheet, metadata, and report templates
- `scripts/` - launch and validation scripts
- `examples/` - dataset-specific worked examples
- `decisions/` - design and governance notes
