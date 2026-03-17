# Starting a new RNA-seq project on CREATE

This guide explains how to start a new short-read RNA-seq processing project on King's College London CREATE HPC using the White Lab `nfcore-rnaseq-processing` workflow.

## Purpose

The aim is to use a standardised White Lab approach for:

- organising project directories
- preparing sample sheets and metadata
- launching `nf-core/rnaseq`
- recording provenance
- producing outputs that are ready for downstream differential expression, splicing, and isoform-level analyses

This workflow is designed so that:

- the **repo stores the reusable pipeline structure, templates, and documentation**
- each **CREATE project directory stores the live run-specific files**

## Core principle

For a new project:

- use files in `templates/` as the starting point
- use `examples/` only as reference
- do not start by copying and editing the Klim example directly

---

## 1. Prerequisites

Before starting, make sure you have:

- access to CREATE
- access to the White Lab project areas
- raw FASTQ files available on CREATE
- the White Lab repo cloned or pulled on CREATE
- reference FASTA and GTF paths confirmed
- a clear project identifier and dataset identifier

---

## 2. Standard CREATE storage model

White Lab uses the following storage model on CREATE:

### Project scratch
Use for active runs, work directories, logs, and outputs.

Example:
`/scratch/prj/bcn_whitema_rbp/<PROJECT_ID>`

### User scratch
Use for Nextflow run state and caches.

Example:
`/scratch/users/<USERNAME>/nextflow_runstate/<PROJECT_ID>`

### Project RDS
Use for selected validated outputs and archived reports.

Example:
`/rds/prj/bcn_whitema_rbp`

See also:
- `docs/create_storage_model.md`

---

## 3. Create a new project directory

Choose a project identifier.

Example:
`My_New_Project`

Create the standard project structure on project scratch:

```bash
mkdir -p /scratch/prj/bcn_whitema_rbp/My_New_Project/{launch,logs,work}
