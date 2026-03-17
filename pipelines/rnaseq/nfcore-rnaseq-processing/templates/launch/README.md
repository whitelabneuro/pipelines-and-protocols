# Launch templates

This folder contains the standard White Lab launch-layer template used when starting a new RNA-seq project on CREATE.

## Purpose

The file in this folder is intended to be copied into a new CREATE project `launch/` directory and edited there.

It is a template, not a live project file.

## Files in this folder

### `nextflow_run.template.sh`
Template SLURM launcher for running `nf-core/rnaseq` using the White Lab CREATE execution model.

This is the file a user copies and renames to:

- `nextflow_run.sh`

inside a live CREATE project launch directory.

Typical fields to edit include:

- project ID
- dataset ID
- email address
- SLURM job name
- output and error paths
- reference paths if they differ from the defaults

## Relationship to `configs/`

The file in `templates/launch/` is the project-facing launcher template.

The reusable CREATE Nextflow config is stored separately in:

- `configs/nextflow/create.config`

For a new project, that file should be copied into the live project launch directory and renamed to:

- `nextflow.config`

In other words:

- `configs/` defines White Lab standard defaults and reference configs
- `templates/launch/` provides the launcher template a user copies into a live project

## Typical new-project workflow

For a new project, a user should copy:

- `templates/launch/nextflow_run.template.sh`
- `configs/nextflow/create.config`

into the project launch directory and rename them appropriately.

Example target structure on CREATE:

    /scratch/prj/bcn_whitema_rbp/<PROJECT_ID>/launch/
      nextflow_run.sh
      nextflow.config
