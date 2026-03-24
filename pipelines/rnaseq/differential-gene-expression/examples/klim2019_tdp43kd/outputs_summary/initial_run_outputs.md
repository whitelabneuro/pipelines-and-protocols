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

## Main output structure

The completed run produced the following main output groups:

- `other/`
- `pipeline_info/`
- `plots/`
- `report/`
- `shinyngs_app/`
- `tables/`

---

## Key output files confirmed

### Main report outputs
- `report/klim2019_tdp43kd.html`
- `report/klim2019_tdp43kd.zip`

### Main differential result tables
- `tables/differential/condition_control_scramble_tdp43kd.deseq2.results.tsv`
- `tables/differential/condition_control_scramble_tdp43kd.deseq2.results_filtered.tsv`

### Processed abundance tables
- `tables/processed_abundance/all.normalised_counts.tsv`
- `tables/processed_abundance/all.vst.tsv`

### Annotation table
- `tables/annotation/gencode.anno.tsv`

### Shiny app output
- `shinyngs_app/klim2019_tdp43kd/app.R`
- `shinyngs_app/klim2019_tdp43kd/data.rds`

### Pipeline provenance outputs
- `pipeline_info/collated_versions.yml`
- `pipeline_info/execution_report.html`
- `pipeline_info/execution_timeline.html`
- `pipeline_info/execution_trace.txt`
- `pipeline_info/params_2026-03-24_10-52-35.json`
- `pipeline_info/pipeline_dag.html`

### DESeq2 supporting outputs
- `other/deseq2/condition_control_scramble_tdp43kd.dds.rld.rds`
- `other/deseq2/condition_control_scramble_tdp43kd.deseq2.sizefactors.tsv`

### Plot outputs
- `plots/differential/condition_control_scramble_tdp43kd/`
- `plots/exploratory/condition/`
- `plots/qc/condition_control_scramble_tdp43kd.deseq2.dispersion.png`

---

## Initial interpretation status

This run successfully established the core downstream DGE layer for the Klim example.

The initial run did not include:
- GSEA
- g:Profiler enrichment

These are intended for later extension runs after the core DGE outputs have been reviewed, documented, and retained appropriately.

---

## Priority review checklist

The first files or directories to review are:

- `report/klim2019_tdp43kd.html`
- `tables/differential/condition_control_scramble_tdp43kd.deseq2.results.tsv`
- `tables/differential/condition_control_scramble_tdp43kd.deseq2.results_filtered.tsv`
- `plots/differential/condition_control_scramble_tdp43kd/`
- `plots/exploratory/condition/`
- `plots/qc/condition_control_scramble_tdp43kd.deseq2.dispersion.png`
- `shinyngs_app/klim2019_tdp43kd/`

---

## Notes

This file should be expanded after first-pass interpretation review, including:
- approximate number of significant genes
- brief summary of sample-level exploratory behaviour
- brief summary of contrast-level outputs
- note on whether the Shiny app behaves as expected
