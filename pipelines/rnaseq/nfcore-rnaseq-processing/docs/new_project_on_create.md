# Starting a new RNA-seq project on CREATE

This guide explains how to start a new short-read RNA-seq processing project on King's College London CREATE HPC using the White Lab `nfcore-rnaseq-processing` workflow.

## Purpose

The aim is to use a standardised White Lab approach for:

- organising project directories
- preparing sample sheets and metadata
- preparing launch files
- documenting references and run settings
- keeping project setup reproducible and easy to understand

This document focuses on **project setup and preparation**.

It does **not** assume that the user is ready to launch a run immediately.

## Core principle

For a new project:

- start with `templates/`
- follow the instructions in `docs/`
- use `configs/` as reusable reference defaults
- consult `examples/` only as worked illustrations

Do **not** start by copying and modifying files inside `examples/`.

---

## 1. Prerequisites

Before setting up a new RNA-seq project, make sure you have:

- access to CREATE
- access to the White Lab project storage areas
- access to the White Lab repository
- a clear project identifier
- a clear dataset identifier
- confirmed locations of the FASTQ files
- confirmed reference FASTA and GTF to be used for the project

---

## 2. Standard CREATE storage model

White Lab uses the following storage model on CREATE.

### Project scratch

Use for active project directories.

Typical contents include:

- `launch/`
- `logs/`
- `work/`
- output directories created later

Example:

`/scratch/prj/bcn_whitema_rbp/<PROJECT_ID>`

### User scratch

Use for user-specific Nextflow state and caches.

Example:

`/scratch/users/<USERNAME>/`

### Project RDS

Use for selected validated outputs and archived reports later in the workflow.

Example:

`/rds/prj/bcn_whitema_rbp`

For more detail, see:

- `docs/create_storage_model.md`

---

## 3. Create a new project directory

Choose a project identifier.

Example:

`My_New_Project`

Create the standard project structure on project scratch:

```bash
mkdir -p /scratch/prj/bcn_whitema_rbp/My_New_Project/{launch,logs,work}

---

## 4. Copy the required template files

The next step is to copy the required template files from the repo into the new project `launch/` directory.

### Required launch templates

Copy:

- `templates/launch/nextflow_run.template.sh`
- `templates/launch/nextflow.config.template`

Rename them in the project launch directory to:

- `nextflow_run.sh`
- `nextflow.config`

### Required sample sheet template

Copy:

- `templates/samplesheets/samplesheet_template.csv`

Rename it to:

- `samplesheet.csv`

### Required metadata templates

Copy:

- `templates/metadata/sample_metadata_template.csv`
- `templates/metadata/run_metadata_template.yaml`

Rename them to:

- `sample_metadata.csv`
- `run_metadata.yaml`

### Required helper script

Copy:

- `scripts/validate/make_canonical_samplesheet.sh`

Place it in the project launch directory as:

- `make_canonical_samplesheet.sh`

### Example project launch directory after copying

```text
/scratch/prj/bcn_whitema_rbp/My_New_Project/launch/
  nextflow_run.sh
  nextflow.config
  samplesheet.csv
  sample_metadata.csv
  run_metadata.yaml
  make_canonical_samplesheet.sh
