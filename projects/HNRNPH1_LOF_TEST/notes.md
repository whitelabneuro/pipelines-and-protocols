# HNRNPH1_LOF_TEST notes

## Project overview

This project is being used as the first novel internal dataset to test the White Lab reusable short-read preprocessing workflow on CREATE before progressing into downstream RNA-seq analysis.

The intention is to validate:

- project setup logic
- metadata structure
- launch file handling
- preprocessing execution
- QC review workflow
- downstream handoff readiness

This project is separate from the reusable workflow core and separate from future team-member trial runs.

## Project ID

`HNRNPH1_LOF_TEST`

This identifier should be used consistently across:

- repo project directory
- CREATE scratch project directory
- run metadata
- reports and retained summaries where possible

## Experimental design notes

### Main analytical arm

KOLF cortical neurons with a 2 x 2 design:

- shRNA: SCRAMBLE vs HNRNPH1
- treatment: DMSO vs 11j

Expected groups:

- KOLF SCRAMBLE DMSO
- KOLF HNRNPH1 DMSO
- KOLF SCRAMBLE 11j
- KOLF HNRNPH1 11j

### Secondary comparison arm

Endogenous H1-tagged line:

- H1-tagged SCRAMBLE
- H1-tagged HNRNPH1

### Replication structure

Important: `n=4` refers to **biological replication**.

Each replicate corresponds to a **different differentiation batch**. This must be captured clearly in metadata and remembered during downstream modelling and interpretation.

## Biological interpretation notes

Primary biological aim:

- identify gene expression and splicing changes downstream of hnRNP H1 loss of function

Secondary biological logic:

- use the 11j arm to help reveal NMD-sensitive splicing abnormalities that may otherwise be under-represented due to transcript degradation
- assess whether the endogenous H1 tag alters baseline function or the resulting loss-of-function signature

## Submission/QC notes

The uploaded submission metadata indicates 24 total RNA samples submitted to Azenta/GENEWIZ under reference `40-1238029769`, using human RNA samples with 1500 ng input recorded in the submission form. :contentReference[oaicite:6]{index=6}

The incoming QC report is favourable:

- all 24 samples listed
- RQN values approximately 9.6-9.9
- no QC-note flags shown in the report
- sample amounts broadly adequate across the full cohort. :contentReference[oaicite:7]{index=7}

This supports progression into preprocessing setup.

## Naming notes

Current sample names include:

- `H1-6a-SCRAMBLE-*`
- `H1-6a-HNRNPH1-*`
- `KOLF-1-3-SCRAMBLE-DMSO-*`
- `KOLF-1-3-HNRNPH1-DMSO-*`
- `KOLF-1-3-SCRAMBLE-11j-*`
- `KOLF-1-3-HNRNPH1-11j-*` :contentReference[oaicite:8]{index=8} :contentReference[oaicite:9]{index=9}

Points to preserve during metadata creation:

- keep raw sample naming traceable to submission/QC records
- avoid accidental relabelling of `11j`
- explicitly distinguish model system (`KOLF` vs `H1-6a`)
- explicitly encode biological replicate / differentiation batch
- record treatment and shRNA separately in richer metadata even if combined in raw sample names

## Metadata planning notes

Likely sample metadata fields to include:

- project_id
- dataset_id
- sample
- model_system
- cell_line
- shRNA
- treatment
- biological_replicate
- differentiation_batch
- fastq availability
- notes

Likely run metadata fields to include:

- project_id
- dataset_id
- workflow
- nf-core/rnaseq version
- Nextflow version
- reference FASTA
- reference GTF
- genome build
- execution environment
- FASTQ source
- run purpose
- notes

## Workflow notes

The current objective is to stop after preprocessing QC interpretation and sign-off.

This project should therefore end the first phase with:

- successful preprocessing run
- MultiQC review
- execution report review
- retained run summary
- downstream-ready input identification

Downstream DGE/splicing work will be handled later.

## To do

- populate project README
- populate project notes
- continue walking reusable pipeline docs/templates
- create project-facing metadata structure
- define CREATE-side project path
- prepare launch directory contents from reusable templates
- validate samplesheet and metadata before launch
- run preprocessing
- review QC
- define downstream handoff material
