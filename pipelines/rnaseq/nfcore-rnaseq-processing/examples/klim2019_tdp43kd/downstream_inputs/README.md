# Downstream input records

This folder contains small manifest-style files that help later downstream workflows understand the retained outputs from the Klim worked example.

## Purpose

These files are retained in the repository because they are small, informative, and useful for future worked-example pipeline development.

They do not replace the larger retained scientific output layer on RDS, but they help future workflow stages understand:

- which run produced the retained outputs
- how samples map to retained BAM files
- what provenance record should be consulted alongside downstream analysis

## Included files

### `samplesheet_with_bams.csv`

This samplesheet links sample identifiers to retained BAM outputs from the completed primary processing run.

It is intended to support later downstream workflows that need a compact run-associated manifest, especially where sample-level alignment files are used.

### `run_manifest.txt`

This is the launcher-generated provenance record for the completed primary processing run.

It captures key run settings such as:

- project ID
- dataset ID
- work directory
- output directory
- pipeline version
- reference files
- samplesheet used
- copied Nextflow config used for the run

## Relationship to RDS-retained outputs

The full retained scientific outputs for this worked example are stored outside the repository on RDS.

This folder keeps only the small records that are most helpful for future repo-based worked-example development.
