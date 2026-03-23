# Configs

This `configs/` directory contains reusable configuration resources for the White Lab downstream bulk RNA-seq differential gene expression workflow.

These files are intended to provide stable reference configuration material that can be reused across studies, especially for CREATE-based execution and common downstream pathway-analysis settings.

---

## What belongs here

Files in `configs/` should be:

- reusable across multiple studies
- stable enough to act as lab reference defaults
- clearly separated from study-specific launch files
- useful as canonical examples for templates and worked examples

Typical examples include:

- CREATE execution config defaults
- reference parameter presets for common pathway-analysis modes
- small reusable config fragments that represent recurring White Lab practice

---

## What does not belong here

This directory should not contain:

- live study launch files
- one-off params files for a specific analysis
- study-specific metadata or contrasts
- worked example outputs
- CREATE project folders
- files that only make sense in one study

Those belong in:

- `templates/` for reusable study starters
- `examples/` for worked reference cases
- live CREATE project space outside the repo for real execution

---

## Relationship to templates

The `templates/` directory contains the files a user is expected to copy into a new live downstream CREATE project.

The `configs/` directory contains the more stable reference versions of reusable configuration choices that inform those templates.

In simple terms:

- `templates/` = study starter files
- `configs/` = reusable reference config resources

The two directories are related, but they are not interchangeable.

---

## Current structure

This directory currently includes:

- `create/` for reusable CREATE execution configuration
- `pathway_presets/` for reusable pathway-analysis parameter presets

These are intended to support standard White Lab downstream DGE launches while keeping study-specific logic in the templates and live project directories.

---

## Next step

The next file to read is:

`create/README.md`
