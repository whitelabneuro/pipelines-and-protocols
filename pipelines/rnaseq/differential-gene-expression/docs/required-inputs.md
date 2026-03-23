# Required inputs

This document explains the required handoff from upstream preprocessing into the White Lab downstream bulk RNA-seq differential gene expression workflow.

The `differential-gene-expression/` repo section begins only after a study has already completed upstream preprocessing in:

`pipelines/rnaseq/nfcore-rnaseq-processing/`

This downstream workflow is designed to start from **retained preprocessing outputs**, not from raw FASTQ files.

The purpose of this page is to define:

- which files are required before downstream DGE can begin
- which files are strongly recommended for good provenance and interpretation
- which files are optional but useful
- how these inputs should be understood in White Lab practice

---

## Core principle

A downstream DGE analysis is only as reliable as its input handoff from preprocessing.

For that reason, White Lab downstream projects should always begin with a clearly retained and documented upstream processing package that includes:

- quantification outputs
- sample metadata
- run metadata
- preprocessing provenance
- core QC outputs

A user should never have to guess where the count matrix came from, how the samples were processed, or what reference and pipeline settings were used upstream.

---

## Where these inputs come from

These inputs are expected to come from the retained outputs of a completed run from:

`pipelines/rnaseq/nfcore-rnaseq-processing/`

In White Lab practice, these files should already have been organised in the retained study directory on RDS or equivalent long-term project storage before downstream DGE begins.

For the worked Klim example, this handoff comes from the retained primary-processing package associated with the completed preprocessing run.

---

## Minimum requirement before starting downstream DGE

Before starting a downstream DGE project, the study should already have:

- a completed and retained preprocessing run
- a study-level retained directory containing the key handoff outputs
- a clearly defined sample metadata table
- a clear understanding of the intended biological comparison
- enough provenance files to trace the downstream analysis back to the upstream run

If those conditions are not met, the downstream analysis should not start yet.

---

## Input categories

The required handoff files fall into five main categories:

1. quantification matrices
2. metadata and sample annotation
3. provenance and preprocessing records
4. QC and run summary outputs
5. optional supporting files for extended interpretation

Each category is described below.

---

## 1. Quantification matrices

These are the most important technical inputs for downstream DGE.

They provide the expression measurements that will be used directly, or indirectly, in differential analysis.

### Required minimum quantification inputs for standard gene-level DGE

For a standard gene-level downstream analysis, the most important input is a gene-level count matrix retained from preprocessing.

Typical key files include:

- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_counts_scaled.tsv`
- `salmon.merged.gene_counts_length_scaled.tsv`
- `salmon.merged.gene_lengths.tsv`
- `salmon.merged.gene_tpm.tsv`

Not every downstream run will use all of these files directly, but they should be retained together as part of the study handoff so that matrix choice remains transparent and revisitable.

### Additional transcript-level quantification files

These are not always needed for basic gene-level DGE, but they are often useful for checking provenance, understanding summarisation, or supporting later extensions.

Important transcript-level files include:

- `salmon.merged.transcript_counts.tsv`
- `salmon.merged.transcript_tpm.tsv`
- `salmon.merged.transcript_lengths.tsv`
- `salmon.merged.tx2gene.tsv`

These should normally travel with the study-level retained quantification package even if the first downstream analysis is gene-level only.

### SummarizedExperiment objects

These are highly useful retained objects and should be carried forward where available:

- `salmon.merged.gene.SummarizedExperiment.rds`
- `salmon.merged.transcript.SummarizedExperiment.rds`

These may not always be the direct launch input for a given run, but they are valuable for provenance, structured reuse, and custom downstream analysis.

---

## 2. Metadata and sample annotation

A downstream DGE analysis cannot be launched correctly without clean sample-level metadata.

The count matrix alone is not enough.

### Required metadata input

The most important metadata file is:

- `sample_metadata.csv`

This file should define the samples and the experimental variables required for downstream analysis.

At minimum, the metadata should allow the user to answer:

- which samples are in the analysis
- which condition each sample belongs to
- which replicate each sample represents
- whether any batch or technical factors need to be considered
- how sample names match the matrix column names

### Why metadata matters

Downstream differential analysis depends on the relationship between:

- matrix columns
- sample identifiers
- biological groups
- modelling factors
- contrasts

If sample metadata is incomplete, inconsistent, or disconnected from the count matrix, the analysis may fail or, worse, run incorrectly.

For this reason, downstream users should treat sample metadata as a required primary input, not as an optional convenience file.

### Metadata expectations in White Lab practice

In White Lab downstream projects, the metadata should be:

- explicit
- human readable
- versioned with the project
- checked against the quantification matrix before launch
- suitable for defining contrasts without ambiguous renaming later

---

## 3. Provenance and preprocessing records

These files document how the upstream outputs were generated.

They may not always be consumed directly by the differential expression engine, but they are required for reproducibility and interpretation.

### Strongly recommended provenance files

The following files should always be carried forward into the downstream project context:

- `run_metadata.yaml`
- `samplesheet_with_bams.csv`
- `run_manifest.txt`

These files help preserve the chain of custody between the upstream preprocessing run and the downstream DGE analysis.

### Why provenance files are important

A downstream user should be able to determine:

- which preprocessing run produced the retained matrices
- what inputs were used upstream
- how samples were named and organised
- what references or study settings applied
- whether the downstream project is using the correct retained package

Without these files, the downstream project becomes much harder to audit or revisit later.

---

## 4. QC and run summary outputs

The downstream DGE workflow is not the stage where raw sequencing QC is generated, but users still need access to the upstream QC outputs when interpreting results.

### Important QC and summary inputs

These should normally be carried forward or at least remain directly linked from the retained package:

- `multiqc_report.html`
- `pipeline_info/*`

### Why these files matter downstream

These outputs help answer questions such as:

- were all samples processed successfully upstream?
- were there any obvious mapping or library issues?
- was there anything unusual in the preprocessing run that may affect interpretation?
- what exact pipeline execution information should be associated with the downstream study?

A downstream DGE analysis should not be interpreted in isolation from the upstream QC context.

---

## 5. Optional supporting inputs

Some files are not always required to launch the first DGE run, but are useful for later interpretation, custom analysis, or downstream extensions.

Examples include:

- transcript-level quantification files not used in the first pass
- retained reference outputs
- alignment outputs if manual follow-up is needed
- custom annotation tables
- study notes linking sample groups to biological context

These should be retained where practical, even if they are not copied into every live downstream working directory.

---

## Required versus recommended versus optional

The table below summarises the expected status of common input types for a standard White Lab downstream DGE project.

| Input type | Status | Notes |
|---|---|---|
| Gene-level count matrix | Required | Essential for standard gene-level DGE |
| Sample metadata | Required | Essential for matching samples to conditions and contrasts |
| Run metadata / provenance files | Strongly recommended | Required for reproducibility and auditability |
| `pipeline_info/` outputs | Strongly recommended | Important for linking downstream work to upstream processing |
| MultiQC report | Strongly recommended | Important for interpretation and QC context |
| Transcript-level files | Recommended | Useful for provenance and later extensions |
| SummarizedExperiment objects | Recommended | Valuable for structured reuse and custom downstream work |
| Alignment BAMs | Optional for standard DGE | Useful for some follow-up investigations but not usually required for launch |
| Reference outputs | Recommended | Useful for provenance and future reuse |

---

## White Lab expected handoff package

For most studies, the downstream DGE project should begin from a retained preprocessing package that includes at least the following files or directories.

### Quantification
- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_counts_scaled.tsv`
- `salmon.merged.gene_counts_length_scaled.tsv`
- `salmon.merged.gene_tpm.tsv`
- `salmon.merged.gene_lengths.tsv`
- `salmon.merged.transcript_counts.tsv`
- `salmon.merged.transcript_tpm.tsv`
- `salmon.merged.transcript_lengths.tsv`
- `salmon.merged.tx2gene.tsv`
- `salmon.merged.gene.SummarizedExperiment.rds`
- `salmon.merged.transcript.SummarizedExperiment.rds`

### Metadata and provenance
- `sample_metadata.csv`
- `run_metadata.yaml`
- `samplesheet_with_bams.csv`
- `run_manifest.txt`

### QC and run context
- `multiqc_report.html`
- `pipeline_info/`

This collection should be treated as the standard downstream handoff package unless there is a study-specific reason to do otherwise.

---

## The Klim example handoff

For the worked Klim example, the downstream analysis begins from the retained outputs of the completed preprocessing run associated with:

- example dataset ID: `klim2019_tdp43kd`
- CREATE project ID: `Klim_TDP_LOF`

The upstream retained processing package includes the key quantification, metadata, provenance, and QC materials required for downstream DGE.

That means the Klim example is not a hypothetical setup. It is intended to demonstrate the real White Lab handoff from completed preprocessing into downstream statistical analysis.

---

## What should not be used as the starting point

The following should not be treated as the proper starting point for a downstream DGE analysis:

- raw FASTQ files
- ad hoc copied matrices with unclear provenance
- count tables detached from metadata
- files taken from scratch or temporary directories without retention context
- renamed matrices that no longer match the study metadata cleanly
- downstream projects started without access to the associated preprocessing records

If the input origin is unclear, the study should be traced back and corrected before downstream work continues.

---

## Input validation mindset

Before launching downstream analysis, the user should be able to confirm all of the following:

- the matrix belongs to the correct retained preprocessing run
- the sample names in the matrix match the sample metadata exactly
- the metadata columns needed for design and contrasts are present
- the intended comparison is biologically and statistically sensible
- the retained provenance files are available and linked to the study
- upstream QC outputs are available for reference

This check should happen before any pipeline execution begins.

---

## Practical rule for new users

A useful rule is:

**If you cannot explain where the matrix came from, how the samples were processed, and how each sample maps to the metadata table, you are not ready to begin downstream DGE yet.**

That standard is important because downstream errors are often introduced at the handoff stage, not during statistical execution.

---

## Relationship to the next documentation pages

This page defines **what must be available** before downstream DGE starts.

The next pages explain:

- `count-matrix-selection.md` — which matrix should actually be used and why
- `metadata-and-contrasts.md` — how metadata and contrasts should be structured
- `nfcore-differentialabundance-run-setup.md` — how the downstream run is launched
- `create-run-structure.md` — how the live CREATE project should be organised

---

## Summary

A White Lab downstream DGE project should begin from a retained, traceable upstream preprocessing package.

At minimum, the downstream handoff must include:

- a suitable gene-level quantification matrix
- clean sample metadata
- enough provenance to trace the analysis back to the upstream run

In practice, a good downstream handoff should also include:

- alternate matrix forms
- transcript-level support files
- pipeline information
- QC summaries
- retained structured objects such as SummarizedExperiment files

The aim is to ensure that downstream analysis begins from a complete, transparent, and reproducible study package rather than from detached files of uncertain origin.

The next document to read is:

[`count-matrix-selection.md`](count-matrix-selection.md)
