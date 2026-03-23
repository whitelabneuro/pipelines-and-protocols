# Run manifest template

Use this template to record the essential identity and provenance of a downstream DGE run.

A completed run manifest should make it possible for a future user to understand what was run, why it was run, and how it relates to both the upstream retained preprocessing package and the downstream output directory.

This template may be copied and renamed for each meaningful run, for example:

- `run_manifest_initial.md`
- `run_manifest_gsea_hallmark.md`
- `run_manifest_gprofiler_go.md`

---

## Run identity

### Study name
`[STUDY_NAME]`

### Study ID
`[STUDY_ID]`

### Run name
`[RUN_NAME]`

### Run type
`[INITIAL | RESUMED | EXTENSION | RERUN]`

### Launch date
`[YYYY-MM-DD]`

### Output directory
`[PATH_TO_OUTPUT_DIRECTORY]`

---

## Pipeline details

### Pipeline
`nf-core/differentialabundance`

### Pipeline version
`[PIPELINE_VERSION]`

### Profile
`[PROFILE]`

### CREATE config file
`[PATH_TO_CREATE_CONFIG]`

### Params file
`[PATH_TO_PARAMS_FILE]`

### Launch script
`[PATH_TO_LAUNCH_SCRIPT]`

### Resume status
`[YES | NO]`

### Resume note
[State whether this run resumed a prior execution and, if so, what it was intended to add or complete.]

---

## Linked upstream preprocessing package

### Upstream study / example
`[UPSTREAM_STUDY_NAME_OR_ID]`

### Retained preprocessing package root
`[PATH_TO_RETAINED_UPSTREAM_PACKAGE]`

### Upstream processing run ID
`[UPSTREAM_RUN_ID]`

---

## Downstream matrix strategy

### Matrix file
`[PATH_TO_SELECTED_MATRIX_FILE]`

### Transcript length matrix
`[PATH_TO_TRANSCRIPT_LENGTH_MATRIX_OR_NOT_USED]`

### Feature annotation source
`[PATH_TO_GTF_OR_FEATURES_FILE]`

### Matrix strategy note
[State clearly whether this run used raw gene counts plus transcript lengths, or a bias-corrected matrix without transcript lengths.]

---

## Design files

### Metadata file
`[PATH_TO_METADATA_FILE]`

### Contrasts file
`[PATH_TO_CONTRASTS_FILE]`

### Blocking variables
`[NONE OR LIST]`

### Exclusions
`[NONE OR DESCRIBE]`

### Design note
[Summarise the main biological comparison and any important design features.]

---

## Pathway and reporting settings

### GSEA enabled
`[TRUE | FALSE]`

### Gene set files
`[NONE OR LIST_PATHS]`

### g:Profiler enabled
`[TRUE | FALSE]`

### g:Profiler organism
`[NONE OR VALUE]`

### Custom background
`[NONE | DEFAULT | PATH]`

### Shiny app enabled
`[TRUE | FALSE]`

### Reporting note
[State any important notes about pathway layers, reporting outputs, or custom settings.]

---

## Run purpose

[Briefly explain why this run was performed.]

Examples:
- initial standard DGE run for core gene-level analysis
- resumed run adding Hallmark GSEA
- resumed run adding g:Profiler GO enrichment
- rerun with corrected contrasts
- rerun with adjusted resource settings but same analytical intent

---

## Outcome summary

### Run status
`[COMPLETED | FAILED | PARTIAL | SUPERSEDED]`

### Main output review note
[State briefly whether the expected outputs were produced.]

### Interpretation note
[Summarise the main outcome at a high level.]

### Caveats
[Record any important caveats, warnings, or follow-up needs.]

---

## Retention note

[State whether this run should be treated as:
- the primary retained downstream run
- a retained pathway extension run
- an exploratory branch not intended for long-term retention
- superseded by a later run]
