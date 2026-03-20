# Workflow overview

This document provides the high-level overview of the White Lab downstream bulk RNA-seq differential gene expression workflow.

The `differential-gene-expression/` repo section is the downstream layer that begins **after** upstream preprocessing has already been completed. It is designed to take retained outputs from `pipelines/rnaseq/nfcore-rnaseq-processing/` and turn them into structured, reproducible differential gene expression analyses using `nf-core/differentialabundance`, together with White Lab reporting, interpretation, and retention practice.

This page is intended to answer a simple question:

**Where does this workflow begin, what does it do, and how does it fit into the wider White Lab RNA-seq pipeline?**

---

## The position of this workflow in the White Lab RNA-seq stack

The White Lab short-read RNA-seq workflow is organised in layers.

### 1. Upstream preprocessing

The upstream preprocessing layer lives in:

`pipelines/rnaseq/nfcore-rnaseq-processing/`

That pipeline starts from raw FASTQ files and is responsible for:

- intake of sequencing data
- sample sheet preparation
- reference and annotation setup
- alignment and quantification
- primary sequencing and mapping QC
- provenance capture
- retention of processed outputs for downstream use

This is the stage that generates the count matrices, metadata, QC summaries, and pipeline records needed for later analysis.

### 2. Downstream differential gene expression

The downstream layer lives in:

`pipelines/rnaseq/differential-gene-expression/`

This workflow starts from the retained outputs of preprocessing and is responsible for:

- selecting the appropriate retained quantification files
- preparing sample metadata and contrasts for downstream analysis
- launching matrix-based differential expression analysis
- reviewing sample-level behaviour in the context of DGE
- generating statistical results, plots, reports, and interactive outputs
- extending analyses with pathway-level runs where appropriate
- retaining and handing over key downstream outputs for future work

This means that raw FASTQ files do **not** enter this workflow directly.

---

## Where this workflow begins

A downstream DGE project should begin only once an upstream preprocessing run has been completed and its important retained outputs have been organised properly.

In White Lab practice, that means a study should already have:

- retained quantification outputs
- sample metadata
- run metadata and provenance files
- primary processing pipeline information
- QC summaries from preprocessing
- a clear study-level retained directory on RDS or equivalent long-term storage

For a typical RNA-seq study, the most important downstream handoff files will include gene-level and transcript-level Salmon merged outputs plus the metadata and provenance files required to understand how those outputs were generated.

---

## Conceptual flow of the downstream workflow

At a high level, the downstream DGE workflow follows this logic:

### Step 1. Start from retained preprocessing outputs
The workflow begins with the files retained from a completed upstream preprocessing run.

### Step 2. Decide which matrix and metadata should be used
The user identifies the appropriate count matrix, confirms sample identities, and prepares the metadata and contrasts required for analysis.

### Step 3. Launch structured downstream differential analysis
A live CREATE analysis project is set up outside the repo, using the repo templates, configs, and guidance. Differential expression is then run using `nf-core/differentialabundance`.

### Step 4. Review outputs and assess interpretability
The user reviews the report outputs, plots, statistics, and optional interactive outputs to determine whether the analysis behaved as expected and what the major biological signals appear to be.

### Step 5. Extend analysis where appropriate
If needed, the user can perform resumed or extended downstream runs to add pathway analysis layers or other supported analysis modules.

### Step 6. Retain and hand over key outputs
The final step is to retain the important downstream results, reports, tables, provenance files, and supporting materials in a form that can be revisited later or passed forward into later transcriptomic workflows.

---

## What this repo section is designed to provide

This repo section is not just a launch wrapper for `nf-core/differentialabundance`.

It is intended to provide the full White Lab downstream DGE framework, including:

- documentation explaining the workflow
- templates for setting up new studies
- reusable configuration material
- helper utilities where appropriate
- worked examples for training
- records of lab decisions and conventions
- guidance on interpretation and retention

The goal is that a new lab member should be able to learn the workflow, not just run it.

---

## What `nf-core/differentialabundance` does in this workflow

Within the White Lab downstream DGE layer, `nf-core/differentialabundance` acts as the main execution framework for structured matrix-based differential analysis.

In practical terms, it provides the engine for:

- ingesting matrices and annotations
- checking consistency between inputs
- running differential comparisons
- generating plots and reports
- supporting optional downstream visualisation outputs
- supporting pathway and related downstream analyses through appropriate configuration

In White Lab use, the pipeline outputs are often combined with:

- careful manual review of study design and contrasts
- additional custom interpretation
- pipeline report review
- R Markdown-based summary and communication outputs
- optional Shiny-based data exploration
- resumed runs for additional pathway-focused layers

So the nf-core workflow is central, but it sits inside a broader White Lab analysis and interpretation framework.

---

## Relationship between the repo and live CREATE projects

A central principle of this repo is that it should remain a reusable lab resource, not become a dumping ground for live analysis folders.

### Inside the repo
The repo contains:

- reusable documentation
- starter templates
- reusable configs
- helper scripts
- worked examples
- design decisions

### Outside the repo
Live downstream analysis projects on CREATE contain:

- study-specific copied templates
- launch files
- params files
- local working manifests
- pipeline work directories
- live outputs
- execution logs and run records

This separation keeps the repo clean and makes it easier to train new users consistently.

---

## Typical file handoff from preprocessing to downstream DGE

The exact downstream inputs will depend on the study design and analysis strategy, but the handoff usually includes a core set of files from preprocessing.

These may include:

- gene count matrices
- transcript count matrices
- TPM and length information
- transcript-to-gene mapping
- sample metadata
- run metadata
- samplesheets and run manifests
- MultiQC output
- pipeline information describing the preprocessing run

In White Lab practice, these files are not just technical inputs. They are part of the provenance chain linking raw data processing to the downstream biological interpretation.

---

## What this workflow is trying to achieve

The aim of this workflow is not simply to generate a table of significant genes.

It is intended to support a full downstream analysis process that is:

- reproducible
- interpretable
- well documented
- teachable
- reusable across studies
- easy to revisit months or years later

A good downstream DGE workflow should help the user answer questions such as:

- Are the samples behaving as expected?
- Is the comparison well defined?
- Are the contrasts biologically sensible?
- Which genes are changing?
- How strong and robust are those changes?
- What broader biological processes appear to be involved?
- Which outputs should be retained and shared?

---

## White Lab workflow philosophy at the downstream stage

The same general philosophy used in the preprocessing repo applies here.

### Repo-first and reusable
The repo should hold reusable resources, not one-off study clutter.

### Educational and explicit
The workflow should explain why things are done, not only how.

### Clear separation of functions
Templates, docs, examples, configs, and live study folders should remain clearly separated.

### Provenance matters
Downstream analysis should preserve a clear link back to the upstream processing run and its retained outputs.

### Interpretation matters as much as execution
A successful run is not the same thing as a well-understood analysis.

---

## Typical downstream analysis lifecycle in White Lab practice

A typical downstream DGE study in White Lab will often follow this sequence:

1. complete upstream preprocessing
2. retain the key preprocessing outputs
3. prepare a live downstream CREATE project using repo templates
4. define the count matrix, metadata, and contrasts
5. launch an initial `nf-core/differentialabundance` run
6. review the report, plots, statistics, and study behaviour
7. refine or extend with resumed runs where justified
8. retain the key downstream outputs
9. use those outputs for biological interpretation, presentation, publication, or integration with later workflows

This lifecycle is important because it encourages consistent practice across different users and studies.

---

## What belongs elsewhere in the docs

This page gives the overall workflow view only.

More detailed topics are covered in the other documentation pages:

- `required-inputs.md` explains the file handoff in detail
- `count-matrix-selection.md` explains matrix choice
- `metadata-and-contrasts.md` explains design setup
- `nfcore-differentialabundance-run-setup.md` explains run launching
- `create-run-structure.md` explains live CREATE project organisation
- `outputs-guide.md` explains what the pipeline produces
- `report-rmarkdown-and-shiny.md` explains reporting and interactive review
- `resumed-runs-and-pathway-analysis.md` explains extension runs
- `dge-qc-and-interpretation.md` explains QC and interpretation
- `retention-and-handover.md` explains what should be kept

---

## The role of the worked example

The worked Klim example is an important part of this workflow design.

It provides a real reference showing how the downstream repo structure is applied in practice using retained outputs from the completed upstream preprocessing example.

This helps users see:

- how upstream retained files feed into downstream analysis
- how a study should be organised
- what a good launch structure looks like
- what important outputs and retained materials look like in practice

The example should be used as a teaching tool and reference point, not as a substitute for the clean templates.

---

## Summary

The White Lab downstream DGE workflow begins after preprocessing has already been completed.

Its role is to take retained upstream RNA-seq outputs and turn them into a reproducible, interpretable, and well-documented differential gene expression analysis using `nf-core/differentialabundance`, supported by White Lab templates, documentation, worked examples, and retention practices.

In simple terms:

- preprocessing turns raw reads into retained processed outputs
- downstream DGE turns retained processed outputs into interpretable biological results

If you are new to this workflow, the next document to read is:

[`required-inputs.md`](required-inputs.md)
