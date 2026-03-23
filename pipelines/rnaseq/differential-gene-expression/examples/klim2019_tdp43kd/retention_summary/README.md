# Retention summary

This directory contains curated notes describing how the downstream `klim2019_tdp43kd` worked example should be retained after live CREATE execution.

Its purpose is to summarise which parts of the downstream run are considered important enough to preserve as the long-term retained study package, and how that retained package relates to both:

- the live CREATE downstream project
- the archived upstream preprocessing package on RDS

---

## Purpose of this directory

This directory is intended to help users understand:

- what the primary retained downstream run is
- which outputs should be preserved long-term
- how launch metadata should be carried forward
- how the retained downstream package relates to the upstream retained preprocessing package
- how White Lab retention logic is applied in a real study

This makes the Klim example useful not only for launch and output review, but also for handover and long-term study organisation.

---

## What should eventually be recorded here

Once the first real CREATE validation run is completed and reviewed, this directory should usually contain short markdown summaries covering:

- the retained downstream run identity
- the retained output package structure
- the key files selected for retention
- the run manifest / provenance record
- any notes on later pathway extension runs if they are retained separately

Examples of useful summary files may include:

- `retained_package_overview.md`
- `retained_run_manifest.md`
- `retention_decisions.md`

---

## Expected retained downstream package for the initial run

For the first Klim downstream validation run, the retained package will likely prioritise:

- launch metadata
- pipeline information
- HTML report
- key differential result tables
- selected exploratory plots
- selected differential plots
- Shiny app output if useful
- short study summary notes

Because the first run is expected to be a standard DGE validation run without pathway extensions, the initial retained package may not yet include pathway-analysis outputs.

---

## Relationship to upstream retention

The downstream retained package should remain explicitly linked to the archived upstream retained preprocessing package for the Klim study.

That upstream archive remains the source of truth for:

- preprocessing provenance
- quantification outputs
- preprocessing QC
- original handoff files

The downstream retained package should preserve that continuity rather than standing alone as an isolated result set.

---

## Relationship to the full retained study record

In White Lab practice, the full study record for Klim should eventually be understood as two linked retained layers:

### Upstream retained preprocessing package
The archived preprocessing outputs on RDS.

### Downstream retained DGE package
The retained downstream results and run metadata derived from the live CREATE validation run.

This directory should document how the second layer is organised and why particular outputs were selected.

---

## Suggested first summary file

Once the first CREATE validation run completes and has been reviewed, the first file to add here should be something like:

`retained_package_overview.md`

That file should record:

- retained downstream run ID
- retained package location
- main retained file groups
- linked upstream retained package
- short note on why this run was chosen as the retained downstream reference run

---

## Current status

Initial scaffolding only.

To be completed after the first real CREATE validation run and downstream retention review.
