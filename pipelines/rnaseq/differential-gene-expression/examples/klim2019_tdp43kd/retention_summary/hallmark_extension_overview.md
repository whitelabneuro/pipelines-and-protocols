# Hallmark extension overview

This file records the retention logic for the first successful Hallmark GSEA extension run of the `klim2019_tdp43kd` worked example.

---

## Hallmark extension run

### Study ID
`klim2019_tdp43kd`

### Live CREATE project
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/`

### Hallmark extension run
`out_20260324_130120_gsea_hallmark`

### Status
`Successful Hallmark GSEA extension run`

---

## Linked baseline DGE run

### Baseline validated DGE run
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/out_20260324_105218/`

### Relationship
This Hallmark run is an extension built on the validated baseline `control_scramble` versus `tdp43kd` DGE analysis.

It should be interpreted as a mechanistic enrichment layer added after the core DGE run had already been reviewed and retained as the primary downstream baseline.

---

## Linked upstream retained preprocessing package

### Archived retained preprocessing package
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/primary_processing/out_20260318_133306/`

This Hallmark extension remains explicitly linked to both:
- the archived upstream preprocessing package
- the validated downstream baseline DGE run

---

## Why this run should be retained

This run should be retained as the first pathway-enrichment extension layer for the Klim example because it:

- completed successfully on CREATE using the validated White Lab extension-run pattern
- preserved the same core contrast and matrix strategy as the baseline run
- added a full Hallmark GSEA results tree
- produced phenotype-level GSEA summaries, pathway-level reports, and enrichment plots
- generated a new HTML report and Shiny app for the Hallmark-extended study

---

## Expected retained Hallmark components

### Launch metadata
- Hallmark launch script
- Hallmark params file
- shared CREATE config
- Hallmark run manifest

### Pipeline provenance
- `pipeline_info/`

### Main report outputs
- `report/klim2019_tdp43kd_hallmark.html`
- `report/klim2019_tdp43kd_hallmark.zip`

### Main GSEA outputs
- `...gsea_report_for_control_scramble.tsv`
- `...gsea_report_for_tdp43kd.tsv`
- `...index.html`
- `...pos_snapshot.html`
- `...neg_snapshot.html`
- selected per-pathway HTML / TSV / PNG files

### Supporting outputs
- Hallmark differential result tables
- Hallmark Shiny app output
- Hallmark DESeq2 support files
- selected provenance and run notes

---

## Retention note

This run should be retained as a secondary extension layer associated with the validated baseline DGE run.

It adds mechanistic depth through Hallmark enrichment, but the baseline DGE run remains the primary retained downstream reference for the Klim example.
