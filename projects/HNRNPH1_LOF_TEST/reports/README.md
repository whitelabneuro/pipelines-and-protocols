# HNRNPH1_LOF_TEST reports

This directory is for retained project-facing preprocessing reports and summaries generated during primary RNA-seq processing of the `HNRNPH1_LOF_TEST` dataset.

Its purpose is to provide a stable place for QC review, run interpretation, and handoff into downstream analysis.

## What belongs here

Typical retained items include:

- MultiQC report files
  - HTML report
  - associated data directory if needed for interpretation or record-keeping

- Nextflow execution report material
  - report HTML or selected summaries retained for project review

- project run summaries
  - concise written summaries of run success, issues encountered, and readiness for downstream analysis

- QC review documents
  - project-specific checklist
  - project-specific tutorial or annotated interpretation notes where produced

- selected figures or screenshots
  - only where they support QC interpretation or project documentation

## What does not belong here

This directory should not be used for:

- full transient pipeline output trees
- FASTQ files
- work directories
- large alignment or quantification outputs better retained elsewhere
- duplicated provenance files that belong more naturally in `../pipeline_info/`

## Intended use in this project

For `HNRNPH1_LOF_TEST`, this directory should support the main first-phase endpoint of the project:

- complete preprocessing
- review QC
- interpret run outputs
- determine whether the dataset is ready for downstream differential gene expression and splicing workflows

Because this project is functioning as a real internal test of the reusable preprocessing workflow, the reports retained here should allow another team member to understand:

- whether the run succeeded technically
- whether sequence quality and alignment/quantification QC were acceptable
- whether any samples require concern or exclusion
- whether the output is suitable to hand forward into downstream analysis

## Likely retained files for this project

Once the run is complete, likely retained items include:

- `multiqc_report.html`
- selected MultiQC supporting files if needed
- Nextflow execution report HTML
- a project-specific QC checklist
- a short run summary or preprocessing sign-off note
- any project-specific output interpretation notes

## Relationship to other project directories

- `../launch/`
  - source launch and metadata files used to run preprocessing

- `../pipeline_info/`
  - technical provenance and execution metadata

- `../downstream_inputs/`
  - selected processed outputs kept for later analysis

- `../README.md`
  - project summary and design overview

- `../notes.md`
  - evolving project notes and decisions

## Project reminder

This dataset contains:

- a main KOLF-1-3 cortical neuron 2 × 2 design
  - `scramble_control` vs `hnrnph1_shrna`
  - `dmso` vs `nmd_inhibition`

- a secondary endogenous H1-tagged comparison arm
  - `scramble_control`
  - `hnrnph1_shrna`

Biological replication is by independent differentiation batch (`n=4` per group), and QC interpretation should keep that design context in mind when assessing sample comparability and downstream readiness.
