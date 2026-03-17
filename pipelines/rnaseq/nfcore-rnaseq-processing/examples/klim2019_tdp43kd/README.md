# Klim et al. 2019 TDP-43 knockdown example

This folder contains the first worked example for the White Lab `nfcore-rnaseq-processing` workflow.

## Purpose of this example

This example exists to demonstrate how the reusable RNA-seq workflow can be instantiated for a real dataset.

It serves as:

- a proof of concept
- a reference for how template files were populated
- a record of one representative public development dataset
- a guide for understanding expected project structure and metadata

## Important: this is not the template source

This folder is **not** the starting point for new RNA-seq projects.

For a new project, users should start with:

- `docs/new_project_on_create.md`
- `docs/new_project_checklist.md`
- files in `templates/`

This example should be consulted only as reference material.

## Dataset summary

Representative public RNA-seq dataset used for workflow development:

- Klim et al. 2019
- PMID: 30643292

Biological context:

- human iPSC-derived motor neurons
- TDP-43 knockdown context
- used here as a representative public development dataset for White Lab pipeline building

## What this example should contain

This example folder should document one instantiation of the workflow, including:

- example sample sheet
- example sample metadata
- example run metadata
- notes on project-specific adjustments
- summary of how the reusable templates were adapted

## Relationship to the reusable workflow

This folder should be read alongside:

- `templates/`
- `docs/`
- `configs/`

The general rule is:

- `templates/` = starting point
- `examples/klim2019_tdp43kd/` = worked illustration

## Suggested contents

Typical files in this example include:

- `example_samplesheet.csv`
- `example_sample_metadata.csv`
- `example_run_metadata.yaml`
- `notes.md`

These files should show what a completed proof-of-concept project looked like after the generic templates were filled in for this dataset.

## White Lab design principle

The reusable workflow should remain independent of this example.

The Klim dataset is important as a proof of concept, but it should not define the structure of the core RNA-seq pipeline for future users.
