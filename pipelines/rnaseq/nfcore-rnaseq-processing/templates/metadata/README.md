# Metadata templates

This folder contains the standard White Lab metadata templates for short-read RNA-seq projects.

## Purpose

These files are used to record structured metadata that sits alongside the RNA-seq samplesheet.

The goal is to ensure that projects are documented consistently and are easy to interpret, reproduce, and hand off for downstream analysis.

## Files in this folder

### `sample_metadata_template.csv`

This file stores sample-level metadata.

Typical fields may include:

- sample ID
- dataset ID
- condition
- perturbation
- cell type
- genotype
- replicate information
- batch information
- library preparation details
- read layout
- strandedness
- reference genome
- annotation version
- notes

This file should be copied into a new project and renamed to:

- `sample_metadata.csv`

### `run_metadata_template.yaml`

This file stores run-level metadata.

Typical contents may include:

- run ID
- pipeline name
- dataset ID
- project ID
- execution environment
- pipeline version
- Nextflow version
- nf-core version
- references used
- notes and comments

This file should be copied into a new project and renamed to:

- `run_metadata.yaml`

## What the user should edit

For each new project, the user should edit the copied metadata files so they reflect the actual dataset, references, and execution context.

## What the user should not do

Do not edit the template files in place for a live project.

Instead:

1. copy the templates into the new project directory
2. rename the copied files
3. edit the copied versions there

## Relationship to the samplesheet

The samplesheet provides the minimal input required for `nf-core/rnaseq`.

The metadata files provide richer project context and should always be maintained alongside the samplesheet.

## Example

Worked example metadata files can be found in:

- `examples/klim2019_tdp43kd/launch/sample_metadata.csv`
- `examples/klim2019_tdp43kd/launch/run_metadata.yaml`
