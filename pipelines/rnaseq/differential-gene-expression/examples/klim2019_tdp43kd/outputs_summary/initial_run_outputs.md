# Initial run outputs

This file summarises the outputs from the first successful downstream DGE validation run for the `klim2019_tdp43kd` worked example.

---

## Run identity

### Study ID
`klim2019_tdp43kd`

### Live CREATE project
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/`

### Pipeline
`nf-core/differentialabundance`

### Pipeline version
`1.5.0`

### Output directory
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/out_20260324_105218/`

### Run purpose
Initial standard downstream DGE validation run comparing `control_scramble` versus `tdp43kd` using raw gene counts plus transcript lengths.

---

## Input configuration used

### Metadata file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/sample_metadata.csv`

### Contrasts file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/contrasts.initial.csv`

### Matrix
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_counts.tsv`

### Transcript lengths
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_lengths.tsv`

### GTF
`/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz`

---

## Run outcome

### Status
`COMPLETED`

### General note
The first downstream CREATE validation run completed successfully after correcting:
- scratch versus RDS execution assumptions
- absolute path handling in params
- local Nextflow bootstrap on CREATE
- absolute SLURM log paths
- Singularity cache directory configuration
- removal of the invalid `differential_method` parameter

---

## Expected output classes to review

The initial run was configured to produce:

- standard gene-level DGE outputs
- exploratory and differential plots
- HTML report
- Shiny app output
- pipeline provenance outputs

The initial run did not include:

- GSEA
- g:Profiler enrichment

These are intended for later extension runs after the core DGE layer has been reviewed and documented.

---

## Priority review checklist

The first files or directories to review are:

- main HTML report
- `pipeline_info/`
- main differential result tables
- exploratory plots
- differential plots
- Shiny app output if generated

---

## Notes

This file should be expanded after direct review of the generated outputs, including:
- key output filenames
- whether Shiny app generation succeeded
- brief summary of exploratory behaviour
- brief summary of contrast-level outputs
