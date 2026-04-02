# HNRNPH1_LOF_TEST

Project-specific White Lab RNA-seq preprocessing record for an incoming short-read dataset used to validate the reusable `nfcore-rnaseq-processing` workflow on a novel experiment before downstream differential gene expression and splicing analysis.

## Purpose

This project exists to:

- test the White Lab RNA-seq preprocessing pipeline on a new internal dataset
- confirm that project setup, metadata handling, launch structure, and preprocessing execution behave as expected on CREATE
- complete primary QC review and output interpretation before progressing into downstream analysis workflows
- generate a clean, experiment-specific record separate from reusable workflow code and separate from future team-member trial runs

This project is part of the `pipelines-and-protocols/projects/` area and should be read as a project instantiation record, not as the reusable pipeline itself.

## Linked reusable workflow

Primary preprocessing workflow:

- `pipelines/rnaseq/nfcore-rnaseq-processing/`

This project should follow the reusable templates, configs, helper scripts, and guidance from that workflow rather than copying from worked examples directly.

## Dataset summary

This dataset comprises **24 short-read RNA-seq samples** submitted to Azenta/GENEWIZ under quotation/reference **40-1238029769**. The submission form records all samples as **Homo sapiens total RNA**, submitted in water, with **1500 ng input** and Qiagen QIAwave RNA Mini Kit extraction noted in the submission metadata. :contentReference[oaicite:0]{index=0}

The sample QC report indicates that all 24 RNA samples passed incoming QC without flagged notes, with **RQN values ranging from 9.6 to 9.9** and input quantities reported in the approximately **952-1212 ng** range for the submitted tubes. :contentReference[oaicite:1]{index=1}

## Biological design

The experiment contains two linked components.

### 1. Main KOLF cortical neuron arm

KOLF2.1J-derived cortical neurons treated with:

- **SCRAMBLE shRNA** or **HNRNPH1 shRNA**
- with either **DMSO** or **11j**

This creates a 2 x 2 design:

- SCRAMBLE + DMSO
- HNRNPH1 shRNA + DMSO
- SCRAMBLE + 11j
- HNRNPH1 shRNA + 11j

Each group contains **n=4 biological replicates**, where each replicate represents a **separate differentiation batch**.

### 2. Secondary endogenous H1-tagged comparison arm

A second set of samples compares:

- endogenous **H1-tagged line + SCRAMBLE**
- endogenous **H1-tagged line + HNRNPH1 shRNA**

Again, each group contains **n=4 biological replicates**.

## Biological rationale

The primary aim of the dataset is to determine the gene expression and splicing consequences of **hnRNP H1 loss of function** in human cortical neurons.

A key design feature is the inclusion of the **11j condition**, intended here as an NMD-inhibition arm to help reveal mis-splicing events that may otherwise be missed due to transcript destabilisation, such as cryptic exon-containing transcripts or other aberrant isoforms subject to nonsense-mediated decay.

A secondary aim is to assess whether the presence of the endogenous H1 tag alters baseline H1 function or materially changes the resulting loss-of-function transcriptomic signature relative to the untagged KOLF system.

## Sample groups represented in the submission/QC metadata

The uploaded submission and QC materials support the following sample classes:

- `H1-6a-SCRAMBLE-1` to `H1-6a-SCRAMBLE-4`
- `H1-6a-HNRNPH1-1` to `H1-6a-HNRNPH1-4`
- `KOLF-1-3-SCRAMBLE-DMSO-1` to `KOLF-1-3-SCRAMBLE-DMSO-4`
- `KOLF-1-3-HNRNPH1-DMSO-1` to `KOLF-1-3-HNRNPH1-DMSO-4`
- `KOLF-1-3-SCRAMBLE-11j-1` to `KOLF-1-3-SCRAMBLE-11j-4`
- `KOLF-1-3-HNRNPH1-11j-1` to `KOLF-1-3-HNRNPH1-11j-4` :contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3}

## Project scope

This project currently covers:

- project instantiation for this experiment
- CREATE-side preprocessing setup
- samplesheet and metadata preparation
- primary processing with `nf-core/rnaseq`
- QC interpretation and run sign-off
- preparation of retained outputs and downstream-ready inputs

This project does **not yet** cover:

- differential gene expression analysis
- downstream splicing analysis
- isoform-level interpretation
- manuscript-level reporting

These will be handled in linked downstream workflows once preprocessing has been completed and reviewed.

## Replication note

For this project, **n=4 denotes biological replication**, not technical replication. Each replicate corresponds to an **independent differentiation batch**, and this should be preserved clearly in project metadata and downstream design modelling.

## Planned project structure use

- `launch/` — project-facing copied launch files, samplesheet, metadata, and helper scripts
- `pipeline_info/` — retained run provenance and nf-core/Nextflow execution information
- `reports/` — retained MultiQC, execution report material, and project summaries
- `downstream_inputs/` — selected outputs retained for downstream DGE/splicing workflows
- `notes.md` — evolving project notes, setup decisions, and deviations from defaults

## Current status

Project directory created.

Initial project summary established from:

- sample submission metadata
- incoming Azenta sample QC report
- experimental design information provided during project setup. :contentReference[oaicite:4]{index=4} :contentReference[oaicite:5]{index=5}
