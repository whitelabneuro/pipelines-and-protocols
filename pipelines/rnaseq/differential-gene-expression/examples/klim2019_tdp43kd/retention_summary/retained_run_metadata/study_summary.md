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

A key biological validation point is that the top down-regulated genes include both `TARDBP` and `STMN2`. This validates the knockdown at the transcript level and recovers the main mechanistic hit expected from the Klim study and the wider TDP-43 loss-of-function literature.

At the sample-structure level, the perturbation signal is detectable but not the dominant source of variance in the full dataset. PC2 is clearly associated with both `condition` and `group_family`, accounting for 9.5% of total variance, which is consistent with the analysed knockdown versus control comparison. At the same time, this indicates that most total variance lies elsewhere, likely reflecting other biological and/or technical influences.

The report also showed that `include_initial_dge` associates with PC3, accounting for 7.3% of variance. In practice, this reflects separation between the samples included in the initial DGE contrast and the additional archived control groups excluded from that first comparison. This supports the choice to restrict the initial analysis to the scramble-control versus TDP43 knockdown subset rather than combining all control classes.

The dendrogram of the 500 most variable genes does not show a perfectly clean knockdown versus control split, reinforcing that this is a realistic bulk RNA-seq example where the contrast of interest is meaningful but sits within broader sample heterogeneity.

A possible outlier was noted for `TDP43KD_1`, which should be remembered in later interpretation, but it did not prevent recovery of a coherent and biologically informative differential signature.

---

## Next actions

1. retain and document this initial validated downstream run
2. update repo templates and guides so they reflect the working CREATE launch pattern
3. mirror the final working scripts and configuration into the Klim example and general templates
4. prepare pathway extension reruns, beginning with GSEA
5. prepare a local-use guide for the generated Shiny app
