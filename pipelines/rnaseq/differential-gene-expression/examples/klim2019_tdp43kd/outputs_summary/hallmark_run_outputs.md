# Hallmark GSEA run outputs

This file summarises the outputs from the first successful Hallmark GSEA extension run for the `klim2019_tdp43kd` worked example.

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
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/out_20260324_130120_gsea_hallmark/`

### Run purpose
Hallmark GSEA extension run built on top of the validated initial DGE layer for the `control_scramble` versus `tdp43kd` comparison.

---

## Input configuration used

### Metadata file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/sample_metadata.csv`

### Contrasts file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/contrasts.gsea_hallmark.csv`

### Matrix
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_counts.tsv`

### Transcript lengths
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_lengths.tsv`

### GTF
`/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz`

### Gene set file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/gene_sets/h.all.v2026.1.Hs.symbols.gmt`

---

## Run outcome

### Status
`COMPLETED`

### General note
The first Hallmark extension run completed successfully and preserved the same validated core DGE setup while adding Hallmark pathway-level enrichment outputs.

---

## Main output structure

The completed Hallmark run produced the following main output groups:

- `other/`
- `pipeline_info/`
- `plots/`
- `report/`
- `shinyngs_app/`
- `tables/`

In addition, the report directory now includes a dedicated GSEA results tree:

- `report/gsea/condition_control_scramble_tdp43kd_hallmark/`

---

## Key output files confirmed

### Main report outputs
- `report/klim2019_tdp43kd_hallmark.html`
- `report/klim2019_tdp43kd_hallmark.zip`

### Main differential result tables
- `tables/differential/condition_control_scramble_tdp43kd_hallmark.deseq2.results.tsv`
- `tables/differential/condition_control_scramble_tdp43kd_hallmark.deseq2.results_filtered.tsv`

### Main GSEA summary outputs
- `report/gsea/condition_control_scramble_tdp43kd_hallmark/h.all.v2026.1.Hs.symbols/condition_control_scramble_tdp43kd_hallmark.h.all.v2026.1.Hs.symbols.gsea_report_for_control_scramble.tsv`
- `report/gsea/condition_control_scramble_tdp43kd_hallmark/h.all.v2026.1.Hs.symbols/condition_control_scramble_tdp43kd_hallmark.h.all.v2026.1.Hs.symbols.gsea_report_for_tdp43kd.tsv`

### Main GSEA HTML reports
- `...gsea_report_for_control_scramble.html`
- `...gsea_report_for_tdp43kd.html`
- `...index.html`
- `...pos_snapshot.html`
- `...neg_snapshot.html`

### Main GSEA support files
- `...gene_set_sizes.tsv`
- `...ranked_gene_list_tdp43kd_versus_control_scramble.tsv`
- `...Symbol_to_probe_set_mapping_details.tsv`
- `...Gsea.rpt`

### Per-pathway outputs
The run produced per-pathway HTML, TSV, and enrichment plot files for Hallmark pathways under:

`report/gsea/condition_control_scramble_tdp43kd_hallmark/h.all.v2026.1.Hs.symbols/`

### Shiny app output
- `shinyngs_app/klim2019_tdp43kd_hallmark/app.R`
- `shinyngs_app/klim2019_tdp43kd_hallmark/data.rds`

### Pipeline provenance outputs
- `pipeline_info/collated_versions.yml`
- `pipeline_info/execution_report.html`
- `pipeline_info/execution_timeline.html`
- `pipeline_info/execution_trace.txt`
- `pipeline_info/params_2026-03-24_13-01-35.json`
- `pipeline_info/pipeline_dag.html`

---

## Interpretation status

This run successfully adds a Hallmark pathway-enrichment layer to the validated initial DGE baseline.

The next interpretation step should focus on the two phenotype summary reports:

- `gsea_report_for_control_scramble.tsv`
- `gsea_report_for_tdp43kd.tsv`

before drilling into individual pathway pages.

---

## Notes

This Hallmark extension should be treated as a distinct but directly linked downstream run built on the validated initial DGE layer, not as a replacement for the baseline DGE run.
