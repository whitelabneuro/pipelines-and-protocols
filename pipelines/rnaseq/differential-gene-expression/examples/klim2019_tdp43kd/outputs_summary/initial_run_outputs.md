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

## First-pass interpretation

The initial run established a clear downstream DGE signal for the `control_scramble` versus `tdp43kd` comparison.

The unfiltered results table shows the expected genome-wide distribution of modest and non-significant effects across most genes, while the filtered results table contains a defined set of statistically significant hits with both positive and negative log2 fold changes.

Top filtered hits include strong effect sizes and highly significant adjusted p-values, indicating that the perturbation signal is detectable and the initial downstream workflow is functioning as intended.

The filtered DESeq2 results table contains 15 filtered hits (16 lines including header), confirming that the initial `control_scramble` versus `tdp43kd` comparison yields a defined set of significant differential signals suitable for downstream interpretation and later pathway extension.

---

## Priority review checklist completed

The following core outputs were successfully generated and are now available for review and retention planning:

- HTML report
- differential result tables
- exploratory and differential plot directories
- DESeq2 support files
- Shiny app output
- pipeline provenance outputs

---

## Notes

This initial run did not include:
- GSEA
- g:Profiler enrichment

Those will be treated as later extension runs after the initial DGE layer has been documented and retained.
