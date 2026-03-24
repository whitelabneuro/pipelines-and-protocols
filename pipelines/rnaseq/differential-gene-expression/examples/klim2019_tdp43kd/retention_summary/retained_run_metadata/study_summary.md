# Study summary

## Study identity

### Study name
`Klim 2019 TDP-43 knockdown motor neuron RNA-seq`

### Study ID
`klim2019_tdp43kd`

### Biological context
Human iPSC-derived motor neuron RNA-seq in a TDP-43 knockdown setting based on Klim et al. 2019.

### Downstream analysis goal
Validate the White Lab downstream DGE workflow on CREATE using retained preprocessing outputs and establish the first reference downstream run for this study.

---

## Linked upstream preprocessing package

### Retained preprocessing package
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/primary_processing/out_20260318_133306/`

### Handoff note
Archived retained preprocessing outputs on RDS were staged into scratch for live downstream execution on CREATE.

---

## Downstream analysis design

### Matrix strategy
Raw gene counts plus transcript lengths

### Main contrast
`control_scramble` versus `tdp43kd`

### Initial run output directory
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/out_20260324_105218/`

---

## Current status

- initial downstream CREATE validation run completed successfully
- expected report, table, plot, provenance, and Shiny outputs were generated
- first-pass QC supports retention of this run as the core validated DGE layer
- pathway extension runs not yet started

---

## First-pass interpretation

The initial run produced a clear differential signal for the `control_scramble` versus `tdp43kd` comparison.

The filtered DESeq2 results table contains 15 filtered hits, and the top results include strong positive and negative log2 fold changes with highly significant adjusted p-values. This supports retention of the run as the core validated DGE layer for the Klim example.

---

## Next actions

1. retain and document this initial validated downstream run
2. update repo templates and guides so they reflect the working CREATE launch pattern
3. mirror the final working scripts and configuration into the Klim example and general templates
4. only then begin pathway extension runs such as GSEA and g:Profiler
