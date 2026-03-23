# Metadata and contrasts

This document explains how to prepare sample metadata and contrasts for the White Lab downstream bulk RNA-seq differential gene expression workflow.

For `nf-core/differentialabundance`, the abundance matrix is only one part of the required downstream input. A valid run also depends on a clean observations table describing the samples and a valid contrasts table describing which groups should be compared.

In practice, many downstream analysis problems arise not from the count matrix itself, but from mistakes in metadata structure, contrast definition, or mismatches between the matrix and the sample sheet.

This page therefore focuses on how to define metadata and contrasts clearly, consistently, and reproducibly in White Lab downstream DGE projects.

---

## Why metadata and contrasts matter

A downstream DGE pipeline does not decide the biological question for you.

The biological question is encoded in:

- the sample metadata table
- the variables included in that metadata
- the contrasts file
- any blocking variables or sample exclusions
- the way sample IDs are matched to the matrix

If these are unclear or inconsistent, the pipeline may fail, or worse, may run in a way that does not answer the intended question.

A successful downstream DGE analysis therefore requires that the user can state clearly:

- what each sample is
- which samples belong to which group
- what comparison is being made
- what additional variables should be modelled
- whether any samples should be excluded for a given contrast

---

## Core principle

The metadata and contrasts should be prepared as if another lab member will need to understand and reuse them months or years later without additional explanation.

That means they should be:

- explicit
- tidy
- human readable
- machine readable
- consistent with the matrix
- sufficiently documented to explain the intended comparison

In White Lab practice, the metadata and contrasts should never be treated as disposable launch files.

---

## The two key files

For a standard RNA-seq downstream DGE run, there are two main design files:

### 1. Sample metadata / observations table
This file describes the samples and their experimental attributes.

In White Lab practice, this will usually be a CSV file such as:

- `sample_metadata.csv`

This is typically supplied to the pipeline as the observations input.

### 2. Contrasts file
This file tells the pipeline which variable should be used to define a given comparison, which group is the reference, which group is the target, and whether any additional blocking variables should be included.

In White Lab practice, this will usually be a CSV file such as:

- `contrasts.csv`

These two files must agree with the abundance matrix and with one another.

---

## Relationship between matrix, metadata, and contrasts

The downstream design is built from three linked components.

### The matrix
Defines the abundance values for each sample.

### The metadata
Defines what each sample is and which variables describe it.

### The contrasts
Defines which variable is being compared and how the comparison should be made.

These three components must agree exactly.

If they do not, the analysis is not ready to launch.

---

## Sample metadata: required role

The sample metadata table must provide a row for each sample included in the downstream analysis.

At minimum, it should allow the user and the pipeline to determine:

- the sample ID
- the biological condition or group
- any replicate information
- any batch or technical variables to be considered
- any additional columns needed later for filtering, plotting, or contrast definition

The most important requirement is that the sample ID column must match the sample identifiers used in the abundance matrix.

---

## Minimum expected metadata fields

A minimal White Lab metadata table for standard bulk RNA-seq DGE will usually include at least:

- a sample identifier column
- a primary condition column
- a replicate column if relevant
- a batch column if relevant

For example:

- `sample`
- `condition`
- `replicate`
- `batch`

The exact additional columns will depend on the study, but the core requirement is that the variables needed for contrasts and blocking must be present and clearly named.

---

## White Lab metadata design principles

### Use explicit column names
Prefer clear names such as:

- `sample`
- `condition`
- `genotype`
- `treatment`
- `batch`
- `sex`
- `replicate`

Avoid vague names that require interpretation later.

### Keep one row per sample
Each sample should appear once in the metadata table for the relevant downstream analysis.

### Keep factor values consistent
Do not mix naming styles such as:

- `Ctrl`, `control`, `CONTROL`
- `WT`, `wildtype`, `WildType`

Choose one style and keep it consistent throughout the file.

### Match the matrix exactly
The sample ID values must match the matrix column names exactly unless there is a clearly documented transformation step.

### Include only useful variables
Do not add clutter columns that have no analytical or reporting value.

### Preserve study context
The metadata should contain enough information to understand the sample grouping without needing to reconstruct the experiment from memory.

---

## Sample identifier rules

The sample identifier column is the most critical field in the metadata table.

### It must match the matrix
The sample IDs in the metadata must match the observation columns in the matrix exactly.

That includes:

- spelling
- case
- punctuation
- separators
- suffixes

If the matrix contains `CONTROL_REP1`, the metadata should not contain `control_rep1` or `Control_Rep1`.

### It should be stable
The sample ID should not change repeatedly between preprocessing and downstream analysis.

### It should be unique
Each row in the metadata should correspond to one unique sample.

### It should be clean
Avoid spaces, trailing punctuation, or hidden formatting issues.

---

## Example metadata structure

A simple example might look like this:

    sample,condition,replicate,batch
    CONTROL_REP1,control,1,A
    CONTROL_REP2,control,2,B
    CONTROL_REP3,control,3,A
    TREATED_REP1,treated,1,B
    TREATED_REP2,treated,2,A
    TREATED_REP3,treated,3,B

This is only an example of structure. Real White Lab studies may instead use variables such as genotype, treatment, clone, differentiation_batch, sequencing_batch, or donor depending on the experiment.

---

## Contrasts: required role

The contrasts file tells the pipeline what statistical comparison to make.

For each comparison, it defines:

- an ID for the comparison
- the metadata column that contains the grouping variable
- the reference level
- the target level
- any optional blocking variables
- any optional contrast-specific sample exclusions

This means the contrasts file is where the biological comparison becomes explicit.

---

## Core required contrasts fields

For a standard contrast, the required fields are:

- `id`
- `variable`
- `reference`
- `target`

These define:

### `id`
An arbitrary but meaningful identifier for the contrast.

This is used in output naming, so it should be informative and stable.

### `variable`
The metadata column that defines the groups to compare.

Examples:
- `condition`
- `genotype`
- `treatment`

### `reference`
The baseline or reference level.

If a feature is higher in this group than in the target group, the fold change will be negative.

### `target`
The non-reference group.

If a feature is higher in this group than in the reference group, the fold change will be positive.

---

## Optional contrasts fields

The contrasts file can also include optional fields that make the design more flexible.

### `blocking`
A semicolon-delimited list of metadata columns to include alongside the main contrast variable.

Examples:
- `batch`
- `replicate;batch`
- `donor;sequencing_batch`

This is useful where additional known variables should be modelled in the analysis.

### `exclude_samples_col`
A metadata column used for contrast-specific filtering.

### `exclude_samples_values`
A semicolon-delimited list of values from that column that should be excluded before modelling that contrast.

This can be helpful if a particular contrast should ignore a subset of samples based on a predefined metadata variable.

---

## Example contrasts structure

A simple example might look like this:

    id,variable,reference,target,blocking
    condition_control_treated,condition,control,treated,
    condition_control_treated_blockrep,condition,control,treated,replicate;batch

This indicates two related comparisons using the same grouping variable, one without blocking variables and one with replicate and batch modelled alongside the contrast.

---

## How to think about the `reference` and `target` fields

These fields define the direction of the comparison.

This matters because the sign of the reported fold change depends on the ordering.

### Positive fold change
A positive log2 fold change means the feature is higher in the `target` group than in the `reference` group.

### Negative fold change
A negative log2 fold change means the feature is higher in the `reference` group than in the `target` group.

For that reason, the `reference` and `target` values should never be entered casually. They determine how the results will be interpreted and labelled.

---

## White Lab naming conventions for contrasts

Contrast IDs should be clear, readable, and stable.

A good contrast ID should make it obvious:

- which variable is being compared
- which groups are involved
- whether any special modelling or exclusion has been applied

Examples of sensible IDs:

- `condition_control_treated`
- `genotype_wt_q331khet`
- `treatment_vehicle_lps`
- `condition_scramble_tdp43kd_batchadjusted`

Avoid IDs that are too vague, such as:

- `contrast1`
- `testA`
- `run2`

These names become unhelpful very quickly when results accumulate.

---

## Blocking variables: when to use them

Blocking variables are used when there is a known source of structured variation that should be modelled alongside the main comparison variable.

Examples may include:

- batch
- donor
- replicate pairing
- sequencing batch
- differentiation batch

Blocking should be used deliberately, not automatically.

A blocking variable should only be included if:

- it is present in the metadata
- it has been defined consistently
- it makes biological and statistical sense to include it
- the user understands how it changes the model being fitted

The purpose of blocking is to improve modelling of structured variation, not to add complexity for its own sake.

---

## Contrast-specific exclusions

Sometimes a study contains samples that are part of the wider dataset but should not be included for a particular contrast.

In such cases, the contrast can use:

- `exclude_samples_col`
- `exclude_samples_values`

This is useful when the exclusion rule can be expressed using an existing metadata column.

For example, a metadata table might contain a column indicating whether a sample passed a predefined inclusion rule for a particular analysis subset.

This is preferable to deleting rows manually and creating multiple slightly different metadata files with unclear provenance.

---

## White Lab preference on exclusions

Where possible:

- keep the main metadata table complete
- make contrast-specific exclusions explicit in the contrasts file
- avoid maintaining multiple nearly identical metadata tables unless there is a strong reason

This keeps the analysis logic more transparent and makes it easier to understand later why a given contrast used only a subset of samples.

---

## Metadata preparation checklist

Before launch, confirm that the metadata table satisfies all of the following:

- every sample included in the matrix has a metadata row
- every metadata row corresponds to a valid sample
- the sample ID column matches the matrix exactly
- the variable needed for each contrast is present
- any blocking variables named in the contrasts file are present
- factor values are consistently named
- there are no duplicated sample rows
- there are no empty or ambiguous group labels
- the file format is valid and readable

If any of these conditions fail, the metadata file should be corrected before launch.

---

## Contrasts preparation checklist

Before launch, confirm that the contrasts file satisfies all of the following:

- each contrast has a unique `id`
- the `variable` column refers to a real metadata column
- the `reference` value exists in that metadata column
- the `target` value exists in that metadata column
- any blocking variables exist in the metadata table
- any exclusion columns exist in the metadata table
- any exclusion values are spelled exactly as they appear in the metadata
- the contrast direction matches the intended biological interpretation

If any of these conditions are not met, the contrast is not ready to run.

---

## Most common metadata and contrast mistakes

### Sample names do not match the matrix
This is one of the most common and most important problems.

### The contrast variable is not present in the metadata
For example, the contrasts file says `variable = condition` but the metadata column is actually called `group`.

### Reference or target values do not exist
For example, the contrasts file uses `reference = control` but the metadata contains `Control`.

### Blocking variables are named but not present
For example, `blocking = batch` is supplied but there is no `batch` column in the metadata.

### Factor values are inconsistent
For example, some rows use `WT` and others use `wt`.

### Multiple metadata files drift apart
Different versions of the metadata table appear in different folders, with no clear indication which one is authoritative.

### Contrast IDs are uninformative
Results files named `contrast1` and `contrast2` are difficult to interpret later.

### Manual sample removal is undocumented
Samples disappear between the matrix and the final run with no explicit exclusion logic.

---

## White Lab preferred workflow for metadata and contrasts

A good downstream setup usually follows this order:

### 1. Start from retained upstream metadata
Bring forward the sample metadata from preprocessing rather than rebuilding it from scratch if possible.

### 2. Add only the columns needed for downstream analysis
Extend the metadata carefully with any additional grouping or blocking variables needed for DGE.

### 3. Check matrix-to-metadata identity matching
Confirm that the matrix observation names and metadata sample IDs agree exactly.

### 4. Define contrasts explicitly
Create a contrasts file that names the variable, reference, target, and any optional blocking variables clearly.

### 5. Validate both files together
Check that metadata and contrasts agree before the run is launched.

This is much safer than trying to fix design issues after a failed or ambiguous analysis.

---

## Documenting the design choice

For every White Lab downstream run, the design should be documented clearly.

At minimum, the project should record:

- which metadata file was used
- which contrasts file was used
- which sample ID column matched the matrix
- which variables were modelled
- whether blocking variables were included
- whether any samples were excluded for specific contrasts

This information should be obvious from the project setup and not depend on memory alone.

---

## Relationship to more complex study designs

This document describes the basic White Lab design framework for standard downstream DGE runs.

More complex studies may involve:

- multiple conditions
- genotype-by-treatment structures
- donor-aware designs
- subset-specific comparisons
- repeated resumed runs with different contrast sets

The same core principles still apply:

- metadata must describe the samples clearly
- contrasts must define the comparison explicitly
- both must match the matrix and the intended biological question

Complexity is not a reason to become less explicit.

---

## Summary

For downstream bulk RNA-seq DGE, the abundance matrix alone is not enough.

A valid and interpretable analysis depends on:

- a clean sample metadata table
- a well-defined contrasts file
- exact agreement between metadata, contrasts, and matrix sample identities

In White Lab practice, metadata and contrasts should be treated as core analytical documents. They define the comparison, preserve the study logic, and make the downstream analysis understandable to other users and to your future self.

The next document to read is:

[`nfcore-differentialabundance-run-setup.md`](nfcore-differentialabundance-run-setup.md)
