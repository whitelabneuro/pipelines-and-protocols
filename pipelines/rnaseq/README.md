# nfcore-rnaseq-processing

White Lab reusable short-read RNA-seq intake and primary processing workflow.

## Scope

This workflow takes raw FASTQ files through primary processing with `nf-core/rnaseq`, producing alignment, quantification, QC, and provenance outputs for downstream analysis.

## Included

- FASTQ intake
- samplesheet preparation
- metadata standardisation
- nf-core/rnaseq execution
- provenance capture
- QC review
- run summary reporting

## Not yet included

- differential expression
- differential splicing
- isoform-level analysis
- downstream biological interpretation

## Development dataset

Initial development uses public TDP-43 knockdown human iPSC-derived motor neuron RNA-seq from Klim et al. 2019 (PMID: 30643292) as a representative dataset.

## Execution environment

Current primary execution environment:
- King's College London CREATE HPC

## CREATE execution model

This workflow uses:
- project scratch for active runs and heavy outputs
- user scratch for Nextflow state and caches
- RDS for selected durable archived outputs

See:
- `docs/create_storage_model.md`
- `docs/execution.md`

## Key folders

- `docs/` — workflow documentation
- `configs/` — Nextflow configs and reusable parameters
- `templates/` — samplesheet, metadata, and report templates
- `scripts/` — launch and helper scripts
- `examples/` — worked dataset examples
- `decisions/` — design decisions and workflow governance
