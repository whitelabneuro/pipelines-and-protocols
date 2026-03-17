# Starting a new RNA-seq project on CREATE

This guide explains how to start a new short-read RNA-seq processing project on King's College London CREATE HPC using the White Lab `nfcore-rnaseq-processing` workflow.

## Purpose

The aim is to use a standardised White Lab approach for:

- organising project directories
- preparing samplesheets and metadata
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

    mkdir -p /scratch/prj/bcn_whitema_rbp/My_New_Project/{launch,logs,work}

At this stage, the important thing is to establish the project directory cleanly before any run-specific logic is introduced.

---

## 4. Copy the required files

The next step is to copy the required template and reference files from the repo into the new project `launch/` directory.

### Required launch files

Copy:

- `templates/launch/nextflow_run.template.sh`
- `configs/nextflow/create.config`

Rename them in the project launch directory to:

- `nextflow_run.sh`
- `nextflow.config`

### Required samplesheet template

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

    /scratch/prj/bcn_whitema_rbp/My_New_Project/launch/
      nextflow_run.sh
      nextflow.config
      samplesheet.csv
      sample_metadata.csv
      run_metadata.yaml
      make_canonical_samplesheet.sh

---

## 5. Make scripts executable

Make the copied shell scripts executable.

    chmod +x /scratch/prj/bcn_whitema_rbp/My_New_Project/launch/nextflow_run.sh
    chmod +x /scratch/prj/bcn_whitema_rbp/My_New_Project/launch/make_canonical_samplesheet.sh

---

## 6. Edit the copied project files

Edit only the copied project-facing files in the new project directory.

### `nextflow_run.sh`

Review and update at minimum:

- project ID
- dataset ID
- email address
- SLURM job name
- SLURM output path
- SLURM error path
- reference FASTA path
- reference GTF path

### `nextflow.config`

This file is the project-local copy of the standard CREATE config.

Usually it can be kept unchanged unless project-specific settings are needed.

### `samplesheet.csv`

Populate with the real project samples.

Expected columns:

- `sample`
- `fastq_1`
- `fastq_2`
- `strandedness`

### `sample_metadata.csv`

Populate with richer sample-level metadata.

### `run_metadata.yaml`

Populate with run-level metadata including:

- project ID
- dataset ID
- pipeline name
- reference choices
- expected execution environment
- notes

---

## 7. Canonical samplesheet

The editable project samplesheet is:

- `samplesheet.csv`

A derived canonical file may later be generated from it:

- `samplesheet.canon.csv`

using:

- `make_canonical_samplesheet.sh`

At setup stage, the important rule is:

- edit `samplesheet.csv`
- do not manually maintain `samplesheet.canon.csv`

---

## 8. Confirm references and reusable defaults

Before execution, confirm:

- reference FASTA
- reference GTF
- nf-core/rnaseq version
- Nextflow version
- CREATE-specific assumptions

Reusable defaults and reference settings are stored in:

- `configs/nextflow/create.config`
- `configs/params/base_params.yaml`

These files are workflow reference defaults. The live project uses its own copied `nextflow.config` in the project `launch/` directory.

---

## 9. Use examples only for illustration

Worked examples are stored in:

- `examples/`

For this workflow, the first proof-of-concept example is:

- `examples/klim2019_tdp43kd/`

Examples show how the templates were instantiated for a real dataset.

Examples are not the template source for new projects.

---

## 10. Expected result of setup

At the end of setup, the project should have:

- a clean CREATE project directory
- copied launch files
- copied samplesheet template
- copied metadata templates
- copied helper script
- project-facing files renamed appropriately
- project-facing files edited with project-specific information

At this point, the project is structurally ready for later validation and execution.

---

## 11. Related documents

For the broader workflow structure, see:

- `README.md`
- `docs/repo_philosophy.md`
- `docs/templates_guide.md`
- `docs/create_storage_model.md`

For template-specific guidance, see:

- `templates/launch/README.md`
- `templates/samplesheets/README.md`
- `templates/metadata/README.md`
- `templates/reports/README.md`
