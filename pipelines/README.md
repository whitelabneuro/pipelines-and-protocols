# Pipelines

This directory contains reusable computational workflows developed or adapted for White Lab projects.

These may include pipelines for:
- bulk RNA-seq analysis
- splicing analysis
- single-cell transcriptomics
- long-read sequencing workflows
- project-specific workflow adaptations where appropriate

## What each pipeline should ideally include

Each pipeline folder should contain:

- a short description of purpose
- input and output expectations
- software or environment requirements
- version notes
- usage guidance
- links to associated projects, datasets or publications where relevant

## Suggested structure for a pipeline folder

```text
pipeline-name/
├── README.md
├── main.nf
├── nextflow.config
├── conf/
├── modules/
└── docs/
