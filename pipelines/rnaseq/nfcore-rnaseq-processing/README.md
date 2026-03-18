# nfcore-rnaseq-processing

White Lab reusable short-read RNA-seq intake and primary processing workflow.

## What this pipeline is for

This pipeline provides the reusable White Lab structure for taking short-read RNA-seq data from raw FASTQ files through primary processing with `nf-core/rnaseq`.

The purpose of this workflow directory is to provide:

- reusable templates for new RNA-seq projects
- standardised documentation and onboarding instructions
- reusable validation and helper scripts
- reusable configuration defaults
- worked example projects showing how the workflow has been instantiated in practice

This pipeline is intended to support future White Lab RNA-seq datasets, including human iPSC-derived neuronal datasets, while remaining general enough to apply to representative public development datasets.

## What this pipeline currently covers

- project setup for new RNA-seq analyses
- samplesheet preparation
- sample and run metadata standardisation
- reusable launch templates
- reusable configuration defaults
- reusable helper scripts for validation and file preparation
- standardised documentation for CREATE deployment
- proof-of-concept and worked example organisation
- run summary and reporting templates for primary processing outputs

## What this pipeline does not yet cover

- downstream differential expression analysis
- downstream splicing analysis
- isoform-level analysis
- biological interpretation
- manuscript-level reporting

These downstream components will be developed separately and linked to this intake and processing layer later.

## How to use this pipeline

For a new RNA-seq project, start with:

- `README.md`
- `docs/new_project_on_create.md`
- `docs/new_project_checklist.md`
- files in `templates/`
- relevant reference defaults in `configs/`

Do not start by editing files in `examples/`.

## Repository structure

### `docs/`
Guidance, onboarding, governance, and explanation of how the workflow should be used.

### `configs/`
Reusable default configuration and parameter files that define the standard White Lab execution model.

These are reference defaults, not per-project live launch files.

### `templates/`
The main entry point for new users.

This folder contains the standard template files that should be copied into a new CREATE project and edited for that project.

Template areas include:

- `templates/launch/` — launcher template
- `templates/samplesheets/` — standard RNA-seq samplesheet template
- `templates/metadata/` — sample-level and run-level metadata templates
- `templates/reports/` — run summary and reporting template

### `scripts/`
Reusable helper scripts for validation, file preparation, manifest generation, and archiving support.

These are not intended to be one-off project notes; they are reusable workflow utilities.

### `examples/`
Worked examples showing how the reusable workflow has been instantiated for a real dataset.

These are for reference, proof of concept, and ongoing worked-example development only.

### `decisions/`
Design decisions and governance notes explaining why the workflow is structured in a particular way.

## Core design principle

This pipeline is organised around a strict separation between:

### Reusable workflow core
- templates
- scripts
- configs
- docs

### Worked example(s)
- dataset-specific worked example material in `examples/`

### Live CREATE projects
- created outside the repo in project scratch space
- populated by copying and editing the template files and reference configs

The repo stores the recipe and the documentation.  
It does not store live FASTQs, live work directories, or live pipeline outputs.

## First worked example

The first worked example is:

- `examples/klim2019_tdp43kd/`

This example documents use of public TDP-43 knockdown human iPSC-derived motor neuron RNA-seq from Klim et al. 2019 as a representative development dataset.

It is intended to function as a continuing worked CREATE example for the White Lab RNA-seq framework, supporting not only primary processing but also later downstream example development as additional workflows are added.

Even so, it should not act as the default starting point for future projects. New projects should still begin from the reusable repo templates, configs, and onboarding docs.
