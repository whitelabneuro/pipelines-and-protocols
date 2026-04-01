# RNA-seq pipelines

This section of the White Lab `pipelines-and-protocols` repository contains reusable workflows, templates, and supporting documentation for RNA-seq data processing.

Its purpose is to organise White Lab RNA-seq pipeline development into clear subdirectories by analysis type, so that short-read, long-read, single-cell, and other RNA-seq workflows can be developed, documented, and maintained in a consistent way.

## Structure

Each subdirectory within `pipelines/rnaseq/` is intended to represent a distinct RNA-seq workflow or pipeline family.

Current and planned examples include:

- `nfcore-rnaseq-processing/` — reusable short-read bulk RNA-seq intake and primary processing workflow based on `nf-core/rnaseq`
- future long-read RNA-seq workflows
- future single-cell RNA-seq workflows
- future specialised downstream RNA analysis workflows where appropriate

## Current focus

The current active workflow in this section is:

- `nfcore-rnaseq-processing/`

This workflow is being developed as the reusable White Lab starting point for short-read bulk RNA-seq primary processing, from FASTQ intake through alignment, quantification, QC, and provenance capture.

## Design principles

RNA-seq workflow directories in this section should aim to be:

- reusable across projects
- clearly documented
- template-driven for new users
- suitable for structured use on CREATE HPC and related environments
- easy to extend with dataset-specific examples without turning examples into the main operational workflow

## Notes

- live experiment-specific working directories should be created outside the reusable pipeline folders, typically under projects/
- example datasets inside workflow directories are for demonstration and proof-of-concept purposes only
- downstream analyses such as differential expression, splicing, isoform analysis, and interpretation may be organised as separate workflows or later-stage modules rather than being forced into the primary processing pipeline

## See also

- `pipelines/rnaseq/nfcore-rnaseq-processing/`
