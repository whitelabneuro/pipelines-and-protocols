# HNRNPH1_LOF_TEST pipeline_info

This directory is for retained preprocessing provenance and run-level technical records generated during primary RNA-seq processing of the `HNRNPH1_LOF_TEST` dataset.

Its purpose is to keep the most useful pipeline execution metadata together in a stable project record after a run has completed.

## What belongs here

Typical retained items include:

- `run_manifest.txt`
  - simple run summary written by `nextflow_run.sh`
  - records project ID, dataset ID, outdir, versions, references, and key launch settings

- selected Nextflow execution summaries
  - for example timeline, report, trace, or DAG files if retained for project documentation

- selected nf-core pipeline provenance files
  - software version summaries
  - pipeline parameter summaries
  - workflow metadata useful for later audit or troubleshooting

- copied or summarised execution notes
  - especially where a run involved a deviation from the default setup

## What does not belong here

This directory should not be used for:

- live work directories
- large transient pipeline outputs
- FASTQ files
- reference indices duplicated unnecessarily
- ad hoc scratch notes that belong in `../notes.md`

## Intended use in this project

For `HNRNPH1_LOF_TEST`, this directory should help preserve:

- the exact preprocessing context used for the first novel internal dataset test of the reusable White Lab RNA-seq preprocessing workflow
- the chosen nf-core / Nextflow versions
- the chosen GRCh38 / GENCODE v49 reference setup
- the exact relationship between launch configuration and final retained outputs

## Suggested retained files for this project

A sensible minimum retained set would be:

- `run_manifest.txt`
- a copy of the final `run_metadata.yaml`
- selected execution summaries from the completed run
- any concise note describing resume behaviour, reruns, or changes from the original launch

## Relationship to other project directories

- `../launch/`
  - contains the project-facing launch and metadata files used before and during execution

- `../reports/`
  - contains retained QC reports and project summaries intended for review and interpretation

- `../downstream_inputs/`
  - contains selected processed outputs retained for later downstream workflows

- `../notes.md`
  - contains broader project notes, chronology, and setup decisions

## Project reminder

This project is intended to validate preprocessing and QC handling on a novel internal dataset before downstream differential gene expression and splicing analysis.

That makes provenance especially important here: this directory should make it easy to understand exactly what was run, with what settings, and against which references.
