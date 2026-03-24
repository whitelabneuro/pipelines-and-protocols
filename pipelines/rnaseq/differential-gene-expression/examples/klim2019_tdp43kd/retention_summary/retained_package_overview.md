# Retained package overview

This file records the intended retention logic for the first successful downstream DGE validation run of the `klim2019_tdp43kd` worked example.

---

## Retained downstream run

### Study ID
`klim2019_tdp43kd`

### Live CREATE project
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/`

### Primary downstream run
`out_20260324_105218`

### Status
`Initial successful downstream validation run`

---

## Linked upstream retained preprocessing package

### Archived study-level retained directory
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/`

### Archived retained primary-processing package
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/primary_processing/out_20260318_133306/`

This downstream run should remain explicitly linked to the upstream retained preprocessing package above.

---

## Expected retained downstream components

The initial retained downstream package should prioritise:

### Launch metadata
- launch script
- params file
- CREATE config
- run manifest
- study summary

### Pipeline provenance
- `pipeline_info/`

### Main report outputs
- `report/klim2019_tdp43kd.html`
- `report/klim2019_tdp43kd.zip`

### Main differential result tables
- `tables/differential/condition_control_scramble_tdp43kd.deseq2.results.tsv`
- `tables/differential/condition_control_scramble_tdp43kd.deseq2.results_filtered.tsv`

### Annotation and processed abundance support files
- `tables/annotation/gencode.anno.tsv`
- `tables/processed_abundance/all.normalised_counts.tsv`
- `tables/processed_abundance/all.vst.tsv`

### Key plot outputs
- selected files from `plots/exploratory/condition/`
- selected files from `plots/differential/condition_control_scramble_tdp43kd/`
- `plots/qc/condition_control_scramble_tdp43kd.deseq2.dispersion.png`

### Shiny app output
- `shinyngs_app/klim2019_tdp43kd/`

### DESeq2 support files
- selected files from `other/deseq2/`

---

## Retention note

This run should be treated as the primary retained downstream reference run for the first validated DGE layer of the Klim example.

Later pathway extension runs may be retained separately if they add meaningful interpretive value.

The initial retained run does not yet include pathway enrichment outputs.
