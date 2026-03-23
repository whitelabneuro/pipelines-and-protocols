# Study summary template

Use this template to create a concise study-level summary for a live CREATE downstream DGE project.

This file should summarise the study in a form that is useful for:

- future you
- other lab members
- project handover
- later retention to long-term study storage

The study summary should focus on the overall downstream project, not only one individual run.

---

## Study identity

### Study name
`[STUDY_NAME]`

### Study ID
`[STUDY_ID]`

### Biological context
[Briefly describe the study system, perturbation, and main comparison of interest.]

### Downstream analysis goal
[Describe the main goal of the downstream DGE analysis.]

---

## Linked upstream preprocessing package

### Upstream study / example
`[UPSTREAM_STUDY_NAME_OR_ID]`

### Retained preprocessing package root
`[PATH_TO_RETAINED_UPSTREAM_PACKAGE]`

### Upstream processing run ID
`[UPSTREAM_RUN_ID]`

### Handoff note
[Briefly describe what was carried forward from preprocessing.]

---

## Downstream analysis design

### Matrix strategy
[State clearly whether the study uses raw gene counts plus transcript lengths, or a bias-corrected matrix.]

### Metadata file
`[PATH_TO_METADATA_FILE]`

### Main contrasts file
`[PATH_TO_MAIN_CONTRASTS_FILE]`

### Feature annotation source
`[PATH_TO_GTF_OR_FEATURES_FILE]`

### Design note
[Summarise the main contrast logic, blocking variables, and any important exclusions.]

---

## Main runs in this project

### Initial DGE run
`[RUN_NAME_OR_OUTPUT_DIRECTORY]`

### Pathway extension runs
[List any important resumed or extension runs.]

Examples:
- Hallmark GSEA extension
- GO BP extension
- g:Profiler GO extension

### Primary retained downstream run
`[RUN_NAME_OR_OUTPUT_DIRECTORY]`

### Retention relationship note
[Explain whether one run supersedes the others or whether multiple retained runs are important.]

---

## Output summary

### Core differential results
[Brief summary of whether the main DGE outputs were generated and appear interpretable.]

### Pathway outputs
[Brief summary of which pathway analyses were run and whether they were useful.]

### Reporting outputs
[State whether the HTML report, R Markdown bundle, and Shiny app were generated.]

### Output review note
[Summarise whether the study outputs appear suitable for retention and sharing.]

---

## Interpretation summary

### Main findings
[Summarise the main biological signal or themes at a high level.]

### Key caveats
[Record important caveats, uncertainties, or review notes.]

### Follow-up ideas
[Note any obvious next analytical or biological follow-up steps.]

---

## Handover note

[Write a short note for a future user explaining what they should look at first and what matters most in this study.]

Examples:
- open the HTML report first, then review the main contrast tables
- the primary retained run is the initial DGE run, with Hallmark GSEA retained as a secondary extension
- batch structure was visible and should be kept in mind during interpretation

---

## Retention status

### Downstream retention prepared
`[YES | NO | IN PROGRESS]`

### Retained package location
`[PATH_TO_RETAINED_DOWNSTREAM_PACKAGE_OR_PENDING]`

### Notes
[Record any notes about what has already been retained or what still needs to be packaged.]
