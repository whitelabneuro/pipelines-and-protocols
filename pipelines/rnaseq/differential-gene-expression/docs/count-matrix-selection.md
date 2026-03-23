# Count matrix selection

This document explains how to choose the appropriate abundance matrix for downstream bulk RNA-seq differential gene expression analysis in the White Lab `differential-gene-expression/` workflow.

Choosing the matrix is one of the most important decisions in the downstream handoff from preprocessing. Different matrix types may look superficially similar, but they are not interchangeable, and the correct choice depends on how the data were generated upstream and how the downstream analysis method expects to receive them.

This page focuses on the matrix types commonly retained from the White Lab upstream preprocessing workflow and how they should be used with `nf-core/differentialabundance`.

---

## Why matrix choice matters

A downstream DGE workflow does not begin simply by picking any count table and launching the pipeline.

The matrix supplied to downstream analysis determines:

- what the differential model is actually testing
- whether transcript length bias is handled appropriately
- whether the statistical assumptions of the workflow are respected
- whether the analysis is reproducible and interpretable later

Using the wrong matrix can lead to incorrect modelling choices, unclear provenance, or results that are difficult to justify.

For that reason, matrix selection should always be an explicit and documented decision.

---

## Core principle

For White Lab bulk RNA-seq DGE using `nf-core/differentialabundance`, the preferred matrix choice depends on whether transcript length information is also being supplied.

In practice, there are two main valid routes for gene-level RNA-seq analysis from `nf-core/rnaseq` outputs:

### Route 1. Raw gene counts plus transcript lengths
Use:

- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_lengths.tsv`

This is the preferred route when transcript length matrices are available and compatible with the retained preprocessing outputs.

### Route 2. Bias-corrected count matrix without offset
Use one of:

- `salmon.merged.gene_counts_length_scaled.tsv`
- `salmon.merged.gene_counts_scaled.tsv`

This route is appropriate when transcript lengths are not being provided and the analysis instead uses tximport-derived bias-corrected count matrices.

These two routes should not be confused with one another.

---

## Matrix types commonly retained from preprocessing

The White Lab upstream preprocessing workflow typically retains several gene-level and transcript-level matrices. The main files relevant to matrix choice are described below.

### `salmon.merged.gene_counts.tsv`
This is the raw gene-level counts matrix produced through the preprocessing workflow.

It represents gene-level abundances before the alternative tximport count transformations such as scaled or length-scaled counts are applied.

This file should **not** normally be used on its own for downstream DGE in `nf-core/differentialabundance`.

In White Lab practice, it is only appropriate when supplied together with:

- `salmon.merged.gene_lengths.tsv`

This pairing allows the downstream workflow to model transcript length bias appropriately.

### `salmon.merged.gene_lengths.tsv`
This is the gene-level transcript length matrix retained from preprocessing.

Its main importance is that it enables the raw gene counts matrix to be used correctly in downstream DESeq2-based modelling by providing the information needed to account for length bias across samples.

This file should therefore be treated as part of the same input decision as `salmon.merged.gene_counts.tsv`, not as an optional afterthought.

### `salmon.merged.gene_counts_length_scaled.tsv`
This is a gene-level count matrix transformed using length-scaled abundance logic derived from tximport.

It is intended for downstream use when transcript lengths are not being supplied separately.

In practice, this is one of the strongest candidate defaults for many standard White Lab downstream DGE runs when using a bias-corrected matrix without an offset.

### `salmon.merged.gene_counts_scaled.tsv`
This is a gene-level count matrix transformed using scaled abundance logic derived from tximport.

Like the length-scaled version, it is intended for downstream use when transcript lengths are not being provided separately.

In some situations it may be used as the selected downstream matrix, but the choice between scaled and length-scaled counts should be made deliberately and documented clearly.

### `salmon.merged.gene_tpm.tsv`
This is a TPM matrix.

It can be very useful for exploratory review, visualisation, expression summaries, or other descriptive tasks, but it is **not** the standard input matrix for count-based differential gene expression modelling in this workflow.

This file should therefore not normally be used as the main DGE launch matrix.

### Transcript-level matrices
These include files such as:

- `salmon.merged.transcript_counts.tsv`
- `salmon.merged.transcript_tpm.tsv`
- `salmon.merged.transcript_lengths.tsv`

These are important retained support files, but they are not the standard starting point for the gene-level DGE workflow described in this repo section.

They may become important for provenance, extension work, or future transcript-level analyses, but they are not the default matrix choice for standard gene-level differential expression.

---

## White Lab default recommendation

For standard gene-level bulk RNA-seq DGE in this repo section, White Lab should define the following default logic.

### Preferred default when transcript lengths are available
Use:

- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_lengths.tsv`

This is the preferred default because it preserves the raw count matrix while also supplying the information needed by downstream DESeq2-based modelling to handle transcript length bias properly.

### Preferred fallback when transcript lengths are not supplied
Use:

- `salmon.merged.gene_counts_length_scaled.tsv`

This is the preferred fallback because it represents a bias-corrected matrix intended for downstream use without a separate length offset.

### Secondary fallback
Use:

- `salmon.merged.gene_counts_scaled.tsv`

This may be used where appropriate, but the reason for selecting it instead of the length-scaled version should be recorded explicitly.

---

## Important rule: do not use raw counts without transcript lengths

A key rule for this workflow is:

**Do not use `salmon.merged.gene_counts.tsv` on its own as the downstream matrix input unless transcript lengths are also supplied.**

This is important because the upstream documentation for tximport-style RNA-seq handoff makes clear that raw counts should not simply be passed forward without the appropriate offset or bias correction.

In practical White Lab terms:

- raw counts alone are not the default downstream input
- raw counts plus gene lengths are valid
- otherwise use a bias-corrected matrix such as length-scaled or scaled counts

This rule should be followed consistently across studies unless there is a strong and documented reason not to.

---

## Decision framework for matrix selection

A useful way to make the decision is to ask the following questions in order.

### Question 1. Is this a standard gene-level RNA-seq DGE analysis?
If yes, stay within the gene-level matrix set and do not begin from transcript-level matrices unless the workflow has been explicitly redesigned for that purpose.

### Question 2. Do I have the retained transcript length matrix?
If yes, the preferred choice is usually:

- `salmon.merged.gene_counts.tsv`
- together with `salmon.merged.gene_lengths.tsv`

### Question 3. If not, do I have a suitable bias-corrected counts matrix?
If yes, use:

- `salmon.merged.gene_counts_length_scaled.tsv`

or, where justified:

- `salmon.merged.gene_counts_scaled.tsv`

### Question 4. Am I accidentally reaching for TPM because it looks easier to read?
If yes, stop and check the intended analysis. TPM is useful for descriptive review but is not the standard count matrix for the DGE workflow described here.

### Question 5. Can I explain and document why I chose this matrix?
If no, the choice has not yet been made properly.

---

## Recommended interpretation of each gene-level matrix

### Raw gene counts
Best understood as the most direct gene-level count matrix, but only appropriate for downstream DGE when paired with the retained gene lengths matrix.

### Length-scaled gene counts
Best understood as a bias-corrected downstream matrix suitable when transcript lengths are not provided separately.

### Scaled gene counts
Best understood as an alternative tximport-derived bias-corrected downstream matrix that may be appropriate depending on the analysis strategy, but should be chosen deliberately.

### TPM
Best understood as an exploratory or descriptive abundance matrix, not the main statistical input for standard DESeq2-style differential gene expression in this repo section.

---

## White Lab documentation expectation

For every live downstream DGE project, the chosen matrix strategy should be written down explicitly.

At minimum, a project should record:

- which matrix file was used
- whether transcript lengths were supplied
- why that matrix strategy was chosen
- which retained preprocessing package the matrix came from

This should be clear from the launch metadata, params file comments, or project notes.

Users should never have to infer matrix choice retrospectively from scattered file names.

---

## Recommended study-level matrix policy

For consistency across White Lab studies, a good policy is:

### Retain all main matrix forms from preprocessing
Do not discard the alternative matrix outputs. Retaining the main alternatives makes it possible to revisit modelling decisions later if needed.

### Choose one primary matrix strategy per downstream run
A given downstream DGE run should have one clearly defined matrix strategy. Avoid ambiguous launches where multiple matrix versions are copied into a project without clear explanation.

### Record the choice once and clearly
The decision should be visible in the study launch setup, not buried in memory or informal chat history.

---

## Practical examples

### Example 1. Standard current White Lab gene-level DGE run
You have retained:

- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_lengths.tsv`
- `sample_metadata.csv`
- `contrasts.csv`
- matching annotation inputs

This is a valid and preferred setup for a standard gene-level DGE run.

### Example 2. Older retained package without usable transcript lengths in the downstream launch
You have retained:

- `salmon.merged.gene_counts_length_scaled.tsv`
- `sample_metadata.csv`
- `contrasts.csv`

This is an appropriate fallback setup for downstream DGE.

### Example 3. User tries to launch with TPM
You have:

- `salmon.merged.gene_tpm.tsv`

This may be useful for expression summaries or visual exploration, but it is not the standard launch matrix for count-based gene-level differential analysis in this workflow.

### Example 4. User has copied raw counts only into a working folder
You have:

- `salmon.merged.gene_counts.tsv`

but not the retained gene lengths matrix.

This is not the preferred downstream setup. The project should either bring in the corresponding `salmon.merged.gene_lengths.tsv` file or switch to an appropriate bias-corrected counts matrix.

---

## Interaction with feature annotations

Matrix choice should also be considered alongside the feature annotation strategy.

For RNA-seq gene-level DGE, the feature annotations should normally match the same annotation framework used upstream. In most White Lab cases, this means using the GTF file corresponding to the preprocessing reference build.

This does not usually change which matrix is selected, but it does affect whether the selected matrix can be interpreted and annotated cleanly downstream.

A matrix with unclear feature identity or mismatched annotation is not a good matrix choice, even if the file format itself looks valid.

---

## Common mistakes to avoid

### Using raw counts without supplying transcript lengths
This is one of the most important mistakes to avoid.

### Using TPM as though it were a standard DESeq2 count matrix
TPM is not the default statistical input for this workflow.

### Switching matrix types between runs without documenting it
This makes later comparison and interpretation much harder.

### Copying only one matrix into a project without preserving provenance
Users should always be able to trace the selected matrix back to the retained preprocessing package.

### Treating scaled and length-scaled counts as interchangeable without comment
If one is chosen over the other, the reason should be recorded.

---

## White Lab provisional default recommendation

Unless there is a study-specific reason to do otherwise, the downstream DGE workflow should follow this default order of preference:

1. `salmon.merged.gene_counts.tsv` together with `salmon.merged.gene_lengths.tsv`
2. `salmon.merged.gene_counts_length_scaled.tsv`
3. `salmon.merged.gene_counts_scaled.tsv`

This recommendation should be revisited only if the upstream preprocessing approach changes or the downstream modelling policy is deliberately updated.

---

## Relationship to the next documentation pages

This page explains **which matrix should be used**.

The next important step is to ensure that the selected matrix matches a clean and valid downstream design setup.

The next document to read is:

[`metadata-and-contrasts.md`](metadata-and-contrasts.md)
