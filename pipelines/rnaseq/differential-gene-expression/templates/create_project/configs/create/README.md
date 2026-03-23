# CREATE configuration

This directory contains the reusable reference CREATE configuration for White Lab downstream bulk RNA-seq differential gene expression studies.

The main file here is intended to act as the canonical lab reference for infrastructure and execution behaviour when running `nf-core/differentialabundance` on CREATE.

It is not a live study launch file. Instead, it is the reusable source version that informs the template copy used in real projects.

---

## Purpose

The CREATE config defines infrastructure-level settings such as:

- process retry behaviour
- Singularity settings
- container cache location
- selected environment variables
- generation of pipeline execution reports such as trace, timeline, and DAG

This is distinct from the study-specific pipeline parameters that belong in params YAML files.

---

## What this config is for

This config is intended to provide a stable White Lab default for CREATE runs that:

- supports containerised execution with Singularity
- captures useful pipeline provenance outputs
- separates infrastructure behaviour from pipeline input parameters
- can be copied into live projects via the template structure

---

## Important usage principle

This config should be used with:

- `-c` for infrastructure and execution settings only

It should not be used as the place to define ordinary pipeline parameters such as:

- matrix paths
- metadata paths
- contrasts
- GTF paths
- output study identity

Those belong in params files.

---

## Relationship to templates

A copy of this config is also provided in:

`templates/create_project/launch/create.config`

That template version is what a user will typically edit or instantiate into a real live CREATE project.

This version in `configs/create/` should be treated as the reusable reference source.

---

## Next step

The next file to read is:

`create.config`
