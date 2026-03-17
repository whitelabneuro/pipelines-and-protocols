# Repository philosophy

This document explains the intended design philosophy for the White Lab `nfcore-rnaseq-processing` workflow.

## Purpose

The RNA-seq pipeline should function as a reusable lab resource rather than a single-project folder.

The goal is to ensure that new users can:

- understand the structure quickly
- start a new project from clearly labelled templates
- avoid copying old projects in an ad hoc way
- follow a standard deployment model on CREATE
- document project-specific decisions consistently
- generate outputs that are ready for downstream analysis

## Core separation

This repository is intentionally divided into three conceptual layers.

### 1. Reusable workflow core

This includes:

- `docs/`
- `configs/`
- `templates/`
- `scripts/`
- `decisions/`

These files define how the workflow should be used in general.

They are intended to be reused across projects.

### 2. Worked example layer

This includes:

- `examples/`

Example folders document how the reusable workflow was instantiated for a real dataset.

These are proof-of-concept records and references.

They are **not** the starting point for new analyses.

### 3. Live execution layer

Live CREATE project directories are created outside the repo, typically on project scratch space.

These live project directories contain copied and edited project-specific files such as:

- `nextflow_run.sh`
- `nextflow.config`
- `samplesheet.csv`
- `sample_metadata.csv`
- `run_metadata.yaml`

These files are derived from the repo templates and adjusted for the project being run.

## How a new user should start

A new user should:

1. read the onboarding docs in `docs/`
2. copy the required files from `templates/`
3. create a new project directory on CREATE
4. edit the copied template files for the new project
5. use `examples/` only as reference material

A new user should **not** begin by editing files directly inside `examples/`.

## Role of templates

The `templates/` directory is the main entry point for a new project.

Templates are intended to be:

- generic
- well-labelled
- minimally editable
- easy to copy into a project launch area

Each template category should clearly indicate:

- what the file is for
- what the user must edit
- what the user should usually leave unchanged

## Role of configs

The `configs/` directory stores reusable default settings and parameter references.

This layer exists so that White Lab standard choices are documented centrally.

Examples include:

- reusable CREATE execution defaults
- reusable parameter defaults
- reusable reference assumptions

These files are not the same as the project-specific copied files used in a live CREATE run.

## Role of examples

Example folders exist to show:

- how templates were instantiated
- what values were used for a real dataset
- what project-specific edits were needed
- how the proof-of-concept project was organised

They help users understand the workflow, but they should not become the lab’s de facto template source.

## What the repo should not become

This repo should not become:

- a storage area for live results
- a collection of one-off shell commands
- a record of only one dataset
- a loose archive of partially overlapping project folders
- a substitute for project scratch/RDS on CREATE

## Practical White Lab rule

For every new RNA-seq project:

- start in `templates/`
- follow `docs/`
- use `configs/` as reference defaults
- consult `examples/` only when needed for illustration

That rule should remain true even as the pipeline grows to support more datasets and downstream analyses.
