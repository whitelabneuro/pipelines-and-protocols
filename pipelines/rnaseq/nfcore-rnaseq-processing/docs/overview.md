# Overview

This workflow represents the first stage of the White Lab transcriptomic discovery pipeline.

Its purpose is to provide a stable, well-documented, reusable framework for short-read RNA-seq intake and primary processing, starting from raw FASTQ files and ending with alignment, quantification, and QC outputs produced by `nf-core/rnaseq`.

The workflow is being developed first on a representative public dataset before being applied to internal White Lab experimental datasets, including human iPSC-derived cortical neuron models.

## Development principles

- reproducible execution
- clear metadata standards
- version-controlled scripts and configs
- documented parameter choices
- consistent output organisation
- explicit recording of references and provenance
- clean handoff to downstream analysis workflows
