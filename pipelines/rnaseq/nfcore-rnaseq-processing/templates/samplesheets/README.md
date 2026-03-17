# Samplesheet templates

This folder contains the standard White Lab samplesheet template for short-read RNA-seq projects.

## Purpose

The files in this folder are the starting point for defining the samples that will be processed by `nf-core/rnaseq`.

These are template files, not live project files.

## Main file

### `samplesheet_template.csv`

This is the generic RNA-seq samplesheet template that should be copied into a new CREATE project launch directory and renamed to:

- `samplesheet.csv`

## Expected columns

The standard template currently expects:

- `sample`
- `fastq_1`
- `fastq_2`
- `strandedness`

## What the user should edit

For each new project, the user should edit:

- sample names
- FASTQ paths
- strandedness values

## What the user should not do

Do not edit the template file in place for a live project.

Instead:

1. copy `samplesheet_template.csv`
2. rename the copy to `samplesheet.csv`
3. edit the copied file in the project launch directory

## Relationship to canonical samplesheets

The project-facing `samplesheet.csv` may be converted into a canonical absolute-path version, typically:

- `samplesheet.canon.csv`

using the reusable validation and helper script:

- `scripts/validate/make_canonical_samplesheet.sh`

## Relationship to metadata

The samplesheet is the minimal file required for pipeline input.

Richer biological and project metadata should be recorded separately using files in:

- `templates/metadata/`

## Example

A worked example of a populated samplesheet can be found in:

- `examples/klim2019_tdp43kd/example_samplesheet.csv`
