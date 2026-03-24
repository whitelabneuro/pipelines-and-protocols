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

- initial downstream CREATE validation run completed
- output inspection and first-pass QC pending
- retention packaging pending
- pathway extension runs not yet started

---

## Next actions

1. inspect HTML report and key differential outputs
2. review exploratory and differential plots
3. document the main output classes in the repo example
4. prepare retained downstream package structure
5. update repo templates and docs with the working CREATE launch pattern
6. only then begin GSEA and related pathway extension runs
