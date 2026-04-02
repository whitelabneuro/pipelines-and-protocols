# HNRNPH1_LOF_TEST downstream_inputs

This directory is for selected preprocessing outputs retained specifically to support downstream RNA-seq analysis of the `HNRNPH1_LOF_TEST` dataset.

Its purpose is to act as the handoff layer between primary processing and later workflows such as differential gene expression, splicing analysis, and related interpretation.

## What belongs here

This directory should contain only the subset of preprocessing outputs that are genuinely useful for downstream work.

Typical retained items may include:

- gene-level count matrices
- transcript-level quantification files
- sample annotation files used for downstream joins
- selected alignment files only if explicitly needed for downstream tools
- reference and annotation summaries needed to document the analysis context
- concise notes describing which outputs were retained and why

## What does not belong here

This directory should not be used for:

- full raw pipeline output trees
- FASTQ files
- large transient work products
- duplicated QC reports that belong in `../reports/`
- technical provenance files that belong in `../pipeline_info/`

## Intended use in this project

For `HNRNPH1_LOF_TEST`, this directory should hold the retained preprocessing products needed to move into downstream analysis after QC review and preprocessing sign-off.

The main downstream goals anticipated for this dataset are:

- differential gene expression analysis
- splicing-focused analysis
- assessment of HNRNPH1 loss-of-function signatures
- comparison of the KOLF main arm and the endogenous H1-tagged comparison arm where appropriate

## Design context to preserve downstream

This dataset contains two related components:

### Main KOLF arm
A 2 × 2 design in KOLF-1-3 cortical neurons with:

- `scramble_control` vs `hnrnph1_shrna`
- `dmso` vs `nmd_inhibition`

### Secondary H1-tagged comparison arm
An endogenous H1-tagged H1-6a arm with:

- `scramble_control`
- `hnrnph1_shrna`

Biological replication is by **independent differentiation batch** (`n=4` per group). Any downstream-ready files retained here should remain clearly linked to that metadata structure.

## Likely retained outputs for this project

The exact retained set will depend on the completed preprocessing run, but likely candidates include:

- Salmon gene-level quantification matrices or per-sample quant files
- transcript-level quantification files
- metadata files needed for DGE import
- selected BAMs only if a downstream method explicitly requires them
- retained reference summaries describing the genome and annotation used

## Handoff principle

Only keep what is needed to make downstream analysis:

- reproducible
- interpretable
- lightweight enough to manage cleanly

If an output is large and can be re-derived easily from archived primary processing outputs, it does not necessarily need to be duplicated here.

## Relationship to other project directories

- `../launch/`
  - source project launch and metadata files

- `../pipeline_info/`
  - execution provenance and technical run metadata

- `../reports/`
  - QC interpretation and preprocessing summaries

- `../README.md`
  - overall project summary

- `../notes.md`
  - evolving project notes and decisions

## Project reminder

This project is currently focused on validating the White Lab reusable preprocessing workflow on a novel internal dataset before downstream analysis begins.

This directory should therefore remain empty or lightly populated until:

1. preprocessing has completed
2. QC has been reviewed
3. the retained output set for downstream use has been agreed
