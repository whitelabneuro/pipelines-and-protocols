# Logs

This directory is intended to store launch logs, run notes, and other operational records for the live CREATE downstream DGE project.

These files are important because shell history and terminal scrollback are not reliable long-term records of what was launched, what failed, what resumed, and what changed between runs.

---

## What should go here

Typical files that may be stored in this directory include:

- launch stdout / stderr captures
- copied terminal log files
- notes on failed runs
- notes on resumed runs
- notes on pathway extension runs
- troubleshooting notes
- short records of resource changes or config adjustments

Examples of sensible filenames include:

- `launch_initial.log`
- `launch_gsea_hallmark.log`
- `launch_gprofiler_go.log`
- `run_notes.md`
- `resume_notes.md`

---

## Why this directory matters

A good downstream study should preserve enough operational context that a future user can understand:

- what command was launched
- when it was launched
- whether the run completed successfully
- whether the run was resumed
- what changed between related runs
- whether any problems occurred during execution

This is especially useful when a study includes multiple resumed runs or pathway analysis branches.

---

## Good practice

A good White Lab habit is to save:

- the exact launch command
- the date of launch
- the main output directory produced
- whether the run was initial or resumed
- any important notes on failures, retries, or reruns

These can be recorded either in plain log files or in short markdown summaries.

---

## Relationship to retained run metadata

This `logs/` directory is for operational run history during live CREATE execution.

It complements, but does not replace, the more structured summary material that should be stored in:

`../retained_run_metadata/`

In simple terms:

- `logs/` = operational history
- `retained_run_metadata/` = compact study record and run identity

Both are useful, and they serve different purposes.
