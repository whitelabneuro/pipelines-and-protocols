# Input manifest

This file records the key upstream retained inputs and local study design files used by this live downstream CREATE project.

It should be completed for each real study so that a future user can understand exactly where the downstream inputs came from.

---

## Study identity

### Study name
`[STUDY_NAME]`

### Study ID
`[STUDY_ID]`

---

## Linked upstream retained preprocessing package

### Upstream study / example
`[UPSTREAM_STUDY_NAME_OR_ID]`

### Retained preprocessing package root
`[PATH_TO_RETAINED_UPSTREAM_PACKAGE]`

### Upstream processing run ID
`[UPSTREAM_RUN_ID]`

---

## Quantification inputs used by downstream DGE

### Selected matrix file
`[PATH_TO_SELECTED_MATRIX_FILE]`

### Transcript length matrix
`[PATH_TO_TRANSCRIPT_LENGTH_MATRIX_OR_NOT_USED]`

### Additional retained quantification files available
- `[OPTIONAL_PATH_TO_GENE_COUNTS_SCALED]`
- `[OPTIONAL_PATH_TO_GENE_COUNTS_LENGTH_SCALED]`
- `[OPTIONAL_PATH_TO_GENE_TPM]`
- `[OPTIONAL_PATH_TO_TRANSCRIPT_COUNTS]`
- `[OPTIONAL_PATH_TO_TX2GENE]`

### Matrix strategy note
[State clearly whether the downstream run uses raw gene counts plus transcript lengths, or a bias-corrected matrix without transcript lengths.]

---

## Feature annotation source

### GTF or features source
`[PATH_TO_GTF_OR_FEATURES_FILE]`

### Annotation note
[State whether this matches the upstream preprocessing reference annotation.]

---

## Local downstream design files

### Metadata file
`inputs/sample_metadata.csv`

### Initial contrasts file
`inputs/contrasts.initial.csv`

### Hallmark GSEA contrasts file
`inputs/contrasts.gsea_hallmark.csv`

### g:Profiler contrasts file
`inputs/contrasts.gprofiler_go.csv`

### Additional gene set files
- `[OPTIONAL_PATH_TO_GMT_FILE]`
- `[OPTIONAL_PATH_TO_BACKGROUND_FILE]`

---

## Input verification checklist

Confirm the following before launch:

- matrix sample IDs match metadata sample IDs exactly
- contrast variables exist in the metadata
- reference and target levels exist in the relevant metadata column
- transcript lengths are supplied if raw counts are used
- the feature annotation source matches the selected matrix appropriately
- the upstream retained package path is correct
- the intended biological comparison is clear

---

## Notes

[Add any study-specific notes about the input handoff, matrix choice, pathway inputs, or known caveats.]
