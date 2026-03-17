# Klim et al. 2019 TDP-43 knockdown example

This folder contains the first worked example for the White Lab `nfcore-rnaseq-processing` workflow.

## Purpose of this example

This example exists to show how the reusable White Lab RNA-seq processing workflow can be instantiated for a real dataset.

It is intended to serve as:

- a proof of concept for the repo structure
- a worked example for lab members
- a reference showing how project-facing files are populated
- a demonstration that the templates, configs, scripts, and docs fit together coherently

This example uses a representative public short-read RNA-seq dataset associated with Klim et al. 2019 as a development and training use case.

## Important boundary

This folder is a worked example only.

It is **not** the starting point for new RNA-seq projects, and it is **not** a live CREATE run directory.

It should be read as a demonstration of how a new project would look after the standard repo files had been copied, renamed, and edited for a specific dataset.

For a new project, users should start with:

- `docs/new_project_on_create.md`
- `docs/new_project_checklist.md`
- `templates/`
- `configs/`

and use this example only for illustration.

## Dataset summary

Representative public RNA-seq dataset used for workflow development:

- Klim et al. 2019
- PMID: 30643292

Biological context:

- human iPSC-derived motor neurons
- TDP-43 knockdown setting
- used here as a representative public development dataset for White Lab pipeline building

## What this example demonstrates

This example is intended to demonstrate the setup layer of a White Lab RNA-seq project on CREATE, including:

- a populated project `launch/` directory
- a copied and edited launcher script
- a copied CREATE `nextflow.config`
- a populated `samplesheet.csv`
- a populated `sample_metadata.csv`
- a populated `run_metadata.yaml`
- a copied helper script for canonical samplesheet generation

The goal is to show exactly how the reusable repo files would be instantiated for one concrete dataset.

## Relationship to the reusable workflow

This example should be read alongside:

- `README.md`
- `docs/`
- `templates/`
- `configs/`
- `scripts/`

The guiding rule is:

- `templates/` and `configs/` define the reusable starting materials
- `examples/klim2019_tdp43kd/` shows one worked instantiation of those materials

## Expected contents

This example folder is expected to contain a project-like demo structure, typically including:

    examples/klim2019_tdp43kd/
      README.md
      launch/
        nextflow_run.sh
        nextflow.config
        samplesheet.csv
        sample_metadata.csv
        run_metadata.yaml
        make_canonical_samplesheet.sh
      notes.md

These files are included to demonstrate setup and organisation only.

They do not represent live FASTQ storage, live `work/` directories, or live pipeline output folders.

## White Lab design principle

The reusable workflow should remain independent of this example.

The Klim dataset is useful as a proof of concept, but it should not become the default template source for future users.

New projects should still be created from the reusable repo components, with this folder serving only as a worked illustration of the result.
