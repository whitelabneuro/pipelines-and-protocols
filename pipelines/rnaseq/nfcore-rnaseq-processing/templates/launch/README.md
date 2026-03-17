# Launch templates

This folder contains the standard White Lab launch-layer templates for starting a new RNA-seq project on CREATE.

## Purpose

These files are intended to be copied into a new CREATE project `launch/` directory and edited there.

They are templates, not live project files.

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
- output/error paths
- reference paths if they differ from the defaults

### `nextflow.config.template`
Template Nextflow configuration file for project-facing launch use.

This file should be copied and renamed to:

- `nextflow.config`

inside a live CREATE project launch directory.

This file allows project-level execution configuration while keeping the repo’s reusable defaults separate.

## Relationship to `configs/`

The files in `templates/launch/` are project-facing templates.

The files in `configs/` are reusable workflow defaults and reference settings.

In other words:

- `configs/` defines White Lab standard defaults
- `templates/launch/` provides the files a user copies into a live project

## Typical new-project workflow

For a new project, a user should copy:

- `nextflow_run.template.sh`
- `nextflow.config.template`

into the project launch directory and rename them appropriately.

Example target structure on CREATE:

```text
/scratch/prj/bcn_whitema_rbp/<PROJECT_ID>/launch/
  nextflow_run.sh
  nextflow.config
