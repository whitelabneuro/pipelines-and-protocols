# Initial interpretation

This file provides the first-pass biological and analytical interpretation of the initial downstream DGE validation run for the `klim2019_tdp43kd` worked example.

The purpose of this note is not to replace detailed downstream follow-up, but to record the main interpretation points from the first successful CREATE run before moving on to pathway-extension reruns such as GSEA.

---

## Run context

This initial downstream run analysed the contrast:

- `control_scramble` versus `tdp43kd`

using:

- raw gene counts plus transcript lengths
- DESeq2 via `nf-core/differentialabundance`
- staged scratch-local inputs derived from the archived retained preprocessing package

This was the first validated downstream DGE run for the Klim worked example and was designed to establish the core gene-level differential expression layer before adding pathway analysis.

---

## Overall interpretation

The initial run produced a clear and biologically meaningful differential signal.

The analysis identified a modest but well-defined set of significant genes rather than a diffuse or obviously artifactual signature. This is a good outcome for an initial validation run because it suggests the contrast is informative while still reflecting the complexity of bulk neuronal RNA-seq data.

Importantly, the run also generated the full expected downstream output set, including:

- differential result tables
- exploratory and differential plots
- HTML report
- Shiny app output
- DESeq2 support files
- pipeline provenance outputs

This means the run is suitable to act as the core validated downstream DGE layer for the Klim example.

---

## Sample-level structure and variance

One of the most important interpretation points from this run is that the TDP-43 knockdown signal is detectable, but it is not the dominant source of total variance in the dataset.

PC2 is clearly associated with both `condition` and `group_family`, and accounts for 9.5% of the total variance. This is consistent with the intended biological comparison, because the main analysed groups are the TDP43 knockdown samples and their matched scramble controls.

At the same time, this also illustrates an important general lesson for bulk RNA-seq analysis: the contrast of interest may be real and biologically meaningful without accounting for the majority of total variance in the dataset. In this case, most variance lies elsewhere, likely reflecting other biological and/or technical influences such as broader sample heterogeneity, batch structure, or other uncontrolled sources of variation.

This interpretation is supported by the clustering behaviour of the 500 most variable genes. The hierarchical clustering does not produce a perfectly clean TDP43 knockdown versus control split, reinforcing the idea that the perturbation is real but sits within a more heterogeneous background. That does not invalidate the differential analysis, but it does argue for measured interpretation and for using pathway analysis later as an additional layer rather than expecting a dramatic global separation at the sample level.

---

## Outlier note

The report flagged two possible outliers at the condition-group level:

- `CONTROL_NONE_1`
- `TDP43KD_1`

For the current initial contrast, `CONTROL_NONE_1` is less important because the `CONTROL_NONE` samples were excluded from the analysis subset. `TDP43KD_1` is more relevant and should be kept in mind during later interpretation and any future reruns.

At this stage, the run still produced a coherent and biologically interpretable differential signal, so the outlier call should be documented rather than treated as an automatic reason to exclude the sample.

---

## Differential signal summary

The filtered DESeq2 results table contains 15 filtered hits.

This is a relatively compact set of differential genes, which is helpful for a first validated run because it suggests the contrast is not being dominated by thousands of diffuse changes or obvious instability. Instead, it produces a focused set of significant genes suitable for careful follow-up.

The presence of both up- and down-regulated genes also supports the view that this is a real perturbation signature rather than a one-directional technical shift.

---

## Key mechanistic result: validation of TDP-43 loss of function

The most important mechanistic interpretation point from this initial run is that the differential signal validates both the knockdown itself and the expected downstream biology.

Among the top down-regulated genes are:

- `TARDBP` (encoding TDP-43)
- `STMN2`

This is exactly what we would hope to see in a meaningful TDP-43 knockdown analysis.

The reduction in `TARDBP` validates that the perturbation is working at the transcript level. The reduction in `STMN2` is especially important because it represents the best-known and most biologically informative downstream hit from the Klim study and from the wider TDP-43 loss-of-function literature. In that sense, this initial run not only validates the computational workflow, but also recovers the central biological signal expected from the underlying publication.

This makes the run a strong reference example for the White Lab downstream pipeline because it does not merely complete technically — it reproduces a key mechanistic hallmark of TDP-43 dysfunction.

---

## Up-regulated signal

The up-regulated portion of the filtered result set includes genes such as:

- `MMP9`
- `EGR2`
- `MMP7`
- `GSTM4`

At this stage, these should be treated as part of the validated perturbation signature rather than over-interpreted individually. They will become more informative once the next analysis phase adds gene set enrichment and broader pathway-level context.

---

## What this run shows about the workflow

This initial run is a good example of why downstream interpretation should not rely only on PCA-style separation.

The sample-level views show that the TDP43 knockdown effect is present but not dominant across all variance, and the dendrogram of the 500 most variable genes does not give a perfectly clean case-control split. Yet the gene-level differential analysis still recovers a coherent and biologically meaningful signal, including the expected decrease in `TARDBP` and `STMN2`.

That makes this a good teaching example for the repo because it demonstrates that:

- meaningful biology can be present even when global variance is dominated by other influences
- bulk RNA-seq contrasts often sit within broader technical or biological heterogeneity
- careful differential modelling can recover a valid perturbation signature even without perfect sample separation
- known biology is a crucial benchmark for judging whether a run has succeeded meaningfully

---

## Cautions and limitations

Several points should be carried forward into later interpretation:

- the main contrast is detectable, but it explains only a minority of total variance
- other sources of variation likely contribute substantially to the overall dataset structure
- clustering of the 500 most variable genes does not show a perfectly clean TDP43 knockdown versus control split
- `TDP43KD_1` should be kept in mind as a possible outlier
- the current interpretation is gene-level only; pathway-level coherence has not yet been tested

These are not reasons to discount the run. Rather, they define the right context for the next stage of analysis.

---

## Conclusion

The initial downstream CREATE validation run for the Klim example was successful both technically and biologically.

It established a valid and interpretable DGE layer for the `control_scramble` versus `tdp43kd` comparison, recovered the expected knockdown-associated reduction in `TARDBP`, and identified `STMN2` as one of the key down-regulated hits, matching the main biological signal associated with the original Klim study.

At the same time, the PCA and clustering outputs show that this perturbation sits within a broader background of variance, likely reflecting additional biological and/or technical influences. This makes the run a realistic and useful White Lab worked example: the signal is real and meaningful, but interpretation benefits from care and from additional pathway-level follow-up.

This run should therefore be treated as the core retained downstream DGE layer for the Klim example, and as the appropriate starting point for later reruns introducing greater mechanistic depth through gene set enrichment analysis.
