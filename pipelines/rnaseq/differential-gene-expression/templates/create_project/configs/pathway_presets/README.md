# Pathway presets

This directory contains reusable parameter presets for common White Lab downstream pathway-analysis modes in `nf-core/differentialabundance`.

These presets are intended as reference starting points for recurring pathway-analysis patterns, not as full study launch files.

They are especially useful when setting up:

- resumed Hallmark GSEA runs
- resumed g:Profiler GO runs
- future common pathway-analysis extensions built from standard White Lab defaults

---

## Purpose

The goal of these files is to capture recurring pathway-analysis settings in a reusable and readable form.

This helps reduce repeated manual setup and makes it easier for lab members to use a standard pathway-analysis approach across studies.

---

## What these presets are not

These files are not:

- complete study params files
- substitutes for study-specific launch definitions
- replacements for metadata and contrasts
- live CREATE run files

They should be combined with study-specific params files or used as reference material when creating resumed pathway runs in real projects.

---

## Current presets

This directory currently includes:

- `gsea_hallmark.yaml`
- `gprofiler_go.yaml`

These correspond to two common White Lab extension patterns:

- Hallmark GSEA
- g:Profiler GO-style enrichment

Further presets can be added later if they become stable recurring lab practice.

---

## How to use these presets

A user may either:

- consult them as reference examples when editing study-specific params files, or
- selectively copy the relevant settings into a live project params file

The exact workflow can remain flexible, but the meaning of the preset should remain stable.

---

## Important note

These presets should still be used in the context of:

- a clearly defined matrix strategy
- a valid metadata file
- a valid contrasts file
- a documented run identity

They define pathway-analysis settings, not the entire analysis.

---

## Next step

Review the preset files in this directory.
