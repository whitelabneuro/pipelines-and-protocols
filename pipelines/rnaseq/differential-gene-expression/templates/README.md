# Templates

This `templates/` directory contains the reusable starter material for new White Lab downstream bulk RNA-seq differential gene expression projects.

The purpose of this directory is to provide a clean and consistent starting point for setting up a new live CREATE downstream analysis project outside the repo.

These templates are designed to support the White Lab workflow described throughout this repo section:

- begin from retained upstream preprocessing outputs
- organise a live CREATE downstream project clearly
- define matrix, metadata, contrasts, and launch files explicitly
- support standard DGE runs and later pathway-oriented extensions
- preserve good run metadata and handover practice from the start

---

## What these templates are for

These templates are intended to help users create a new downstream DGE project that is:

- structured consistently
- easy to understand
- reproducible
- aligned with White Lab conventions
- ready to support both initial analysis and later resumed runs

They are especially intended for:

- new PhD students
- postdocs setting up a study for the first time
- lab members returning to the workflow after time away
- any user who wants a clean downstream project structure rather than starting from scratch

---

## What these templates are not for

These templates are not:

- completed worked examples
- substitutes for the documentation
- the final retained study package
- live CREATE execution directories
- one-off analysis folders copied directly from a previous study

A new user should build a real downstream project from these templates, not by editing the worked example in place.

---

## Relationship to the rest of the repo

Within the overall `differential-gene-expression/` repo section:

- `docs/` explains the workflow and analysis logic
- `templates/` provides reusable starting material for new studies
- `configs/` provides reusable configuration resources
- `examples/` shows worked reference implementations
- live CREATE projects exist outside the repo and are built using these resources

The templates therefore sit between the documentation and the real execution environment.

---

## Recommended use of this directory

A typical White Lab workflow should be:

1. read the core documentation in `docs/`
2. copy the relevant template structure into a new live CREATE project
3. edit the study-specific README, metadata, contrasts, params, and launch files
4. launch the real downstream run outside the repo
5. use the worked example in `examples/` as a reference point if needed

This keeps the repo reusable and keeps real execution separate from the template source.

---

## Template structure

The main downstream project template is:

`create_project/`

This provides a reusable skeleton for a live CREATE downstream DGE study, including:

- a study-level README template
- launch files
- input file placeholders
- a place for logs
- a place for retained run metadata

This structure mirrors the White Lab live CREATE organisation described in the documentation.

---

## Design principles of these templates

The templates in this directory follow the same general White Lab principles used across the RNA-seq repos:

- repo-first and reusable
- clear separation between template, example, and live project
- educational and explicit
- designed for reproducibility and handover
- suitable for both initial runs and resumed pathway analysis layers

The aim is not only to give users files to edit, but to encourage good project organisation from the start.

---

## Important usage note

These templates should always be copied or instantiated into a new live CREATE project directory before editing.

They should not be edited directly in place inside the repo for real study execution.

This is important because the repo should remain the clean reusable source, while live study execution belongs in external project space.

---

## Current scope

At present, these templates are designed for:

- bulk short-read RNA-seq
- downstream gene-level differential expression analysis
- use of retained outputs from the White Lab preprocessing workflow
- standard execution with `nf-core/differentialabundance`
- optional resumed pathway and reporting extensions

As the repo grows, additional template variations may be added, but this initial structure is intended to provide a strong and general starting point for standard White Lab downstream DGE studies.

---

## Next step

The next file to read is:

`create_project/README.md`
