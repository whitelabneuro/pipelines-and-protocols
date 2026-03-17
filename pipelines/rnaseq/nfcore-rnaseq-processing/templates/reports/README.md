# Report templates

This folder contains reusable report templates for summarising RNA-seq processing runs.

## Purpose

These templates are intended to support consistent reporting of:

- input dataset details
- pipeline versions
- execution settings
- reference provenance
- key QC observations
- run-level notes
- downstream handoff information

## Main file

### `rnaseq_run_summary_template.Rmd`

This is the standard White Lab template for generating a run summary after primary RNA-seq processing.

Typical sections may include:

- run overview
- dataset description
- sample summary
- execution details
- references used
- QC summary
- notable issues or warnings
- output locations
- handoff notes for downstream analysis

## How this template should be used

For a new project:

1. copy the template
2. rename it appropriately for the project or run
3. edit the copied version
4. populate it after the run has been reviewed

## Important rule

Do not treat the template itself as the final report.

It is a reusable starting point that should be instantiated per project or per run.

## Relationship to examples

A completed example report may later be linked from:

- `examples/klim2019_tdp43kd/`

once the proof-of-concept run documentation has been fully populated.
