# Retained run metadata

This directory is intended to store compact run manifests and study summaries for the live CREATE downstream DGE project.

These files are important because they preserve the identity and meaning of each run independently of shell history, temporary notes, or the full output tree.

In White Lab practice, this directory should act as the bridge between:

- live CREATE execution
- later long-term retention
- study handover to future users

---

## What should go here

Typical files that may be stored in this directory include:

- run manifests
- study summary notes
- compact records of initial versus resumed runs
- notes linking a downstream run to the retained upstream preprocessing package
- brief summaries of pathway extension runs
- records of which run should be treated as the main retained study run

Examples of sensible filenames include:

- `run_manifest_initial.md`
- `run_manifest_gsea_hallmark.md`
- `run_manifest_gprofiler_go.md`
- `study_summary.md`
- `retention_notes.md`

---

## Why this directory matters

A future user should be able to open this directory and understand:

- which run or runs matter most
- what files defined those runs
- what the biological context of the study was
- which upstream retained preprocessing package was used
- which output directories were generated
- what the key findings or caveats were

This directory is especially valuable when a study contains multiple related runs and pathway extensions.

---

## Relationship to logs

The `logs/` directory captures operational history.

This directory captures the more structured study record.

In simple terms:

- `logs/` = what happened during execution
- `retained_run_metadata/` = what should be remembered about the study and its runs

---

## Relationship to later retention

When the downstream study is later prepared for long-term retention, the files in this directory should help define:

- which run is the primary retained run
- which pathway extension runs are worth retaining
- which launch files and provenance details must travel with the retained package
- what short explanatory notes should be included in the retained study record

For that reason, this directory should be kept clear, readable, and concise.
