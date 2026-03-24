# Hallmark GSEA run guide

This document explains how to add a Hallmark gene set enrichment analysis (GSEA) extension run to a White Lab downstream bulk RNA-seq differential gene expression study using `nf-core/differentialabundance`.

This guide is based on the first validated Hallmark extension run performed for the Klim worked example and is intended to capture the exact practical pattern that worked on CREATE.

It focuses on:

- choosing the correct Hallmark gene set download
- staging the gene set file correctly on scratch
- preparing the Hallmark-specific contrasts and params files
- launching the Hallmark extension as a distinct downstream run
- keeping the Hallmark run clearly linked to, but separate from, the validated baseline DGE run

---

## Purpose of a Hallmark extension run

A Hallmark extension run is intended to add a pathway-level interpretation layer after the baseline DGE run has already been completed and reviewed.

In White Lab practice, Hallmark GSEA should not be the first thing run on a new downstream study. The correct sequence is:

1. validate the baseline DGE run
2. review the main gene-level outputs
3. document the initial interpretation
4. add Hallmark GSEA as a separate extension run

This keeps the gene-level and pathway-level layers clearly separated and easier to interpret.

---

## Core principle

A Hallmark GSEA run should be treated as a **new extension run**, not as a replacement for the baseline DGE run.

That means it should have:

- its own contrasts file
- its own params file
- its own launch script
- its own output directory
- its own run manifest and interpretation notes

The Hallmark run should remain directly linked to the baseline DGE run, but it should not overwrite or blur that earlier validated layer.

---

## Which Hallmark file to download

For White Lab RNA-seq downstream work, the correct MSigDB Hallmark download format is:

- **Gene Symbols**

Do **not** use:

- NCBI (Entrez) Gene IDs
- JSON bundle

The Gene Symbols GMT format matches the gene-centric downstream workflow much more naturally and avoids unnecessary identifier-conversion complexity.

---

## Example Hallmark file used in the Klim run

The first validated Hallmark extension run for the Klim example used:

`h.all.v2026.1.Hs.symbols.gmt`

This was staged into:

`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/gene_sets/`

and referenced in the Hallmark params file using an absolute scratch-accessible path.

---

## Recommended storage location for gene set files

For live CREATE execution, gene set files should be staged into the study input tree under:

`inputs/gene_sets/`

For example:

`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/gene_sets/h.all.v2026.1.Hs.symbols.gmt`

This keeps pathway input files:

- close to the rest of the study inputs
- easy to document
- clearly separated from output files

---

## Minimal files needed for a Hallmark extension run

A standard Hallmark extension run usually needs:

### In `inputs/`
- `sample_metadata.csv`
- `contrasts.gsea_hallmark.csv`
- `gene_sets/h.all.v2026.1.Hs.symbols.gmt`

### In `quantification/`
- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_lengths.tsv`

### In `launch/`
- `create.config`
- `params.gsea_hallmark.yaml`
- `run_gsea_hallmark.sh`

The Hallmark run normally reuses the same metadata and matrix strategy as the validated baseline DGE run.

---

## Recommended contrast structure

For the Klim example, the Hallmark extension used the same biological comparison as the baseline DGE run:

- `control_scramble` versus `tdp43kd`

with the same exclusion logic for samples not included in the initial DGE subset.

A suitable contrasts file is:

    id,variable,reference,target,exclude_samples_col,exclude_samples_values
    condition_control_scramble_tdp43kd_hallmark,condition,control_scramble,tdp43kd,include_initial_dge,no

This keeps the Hallmark extension tightly aligned with the validated core comparison.

---

## Recommended params structure

A Hallmark params file should usually:

- reuse the same absolute scratch-accessible metadata path
- reuse the same absolute scratch-accessible contrast path
- reuse the same matrix and transcript-length strategy
- reuse the same GTF
- enable `gsea_run`
- point `gene_sets_files` at the staged Hallmark GMT
- disable `gprofiler2_run`

A working pattern looks like:

    input: "/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/sample_metadata.csv"
    contrasts: "/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/contrasts.gsea_hallmark.csv"

    matrix: "/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_counts.tsv"
    transcript_length_matrix: "/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_lengths.tsv"

    gtf: "/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz"

    study_name: "klim2019_tdp43kd_hallmark"

    observations_id_col: "sample"
    features_id_col: "gene_id"
    features_name_col: "gene_name"
    features_metadata_cols: "gene_id,gene_name,gene_biotype"

    study_type: "rnaseq"

    shinyngs_build_app: true

    gsea_run: true
    gene_sets_files: "/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/gene_sets/h.all.v2026.1.Hs.symbols.gmt"

    gprofiler2_run: false

The exact path values will vary by study, but the structure should remain similar.

---

## Recommended launch pattern

The Hallmark extension should use the same validated CREATE-native launch pattern as the baseline DGE run.

That means the launch script should:

- run as a login-shell batch script
- load Java explicitly
- define the project root and key directories
- define scratch-local Nextflow runstate and caches
- verify or bootstrap a local `nextflow` binary
- create a distinct output directory for the Hallmark run
- record a run manifest
- launch `nf-core/differentialabundance` using the Hallmark params file

This keeps the extension run operationally consistent with the validated baseline run.

---

## Recommended output naming

The Hallmark extension run should have a distinct output directory name.

A good pattern is:

`out_<TIMESTAMP>_gsea_hallmark`

For example:

`out_20260324_130120_gsea_hallmark`

This makes it immediately obvious that the run is:

- downstream
- distinct from the baseline run
- Hallmark-specific

---

## Should the first Hallmark run use resume?

No, not by default.

The first Hallmark extension run should usually be launched as a **fresh run**, because it is a new analytical branch with:

- a new params file
- a new contrasts file
- a new output directory
- additional pathway settings

Resume should only be used later if that specific Hallmark run needs to be continued after interruption or partial failure.

---

## What to inspect after the Hallmark run completes

The first files to review are usually:

### Main HTML report
- `report/[study_name].html`

### GSEA summary reports
- `...gsea_report_for_<reference>.tsv`
- `...gsea_report_for_<target>.tsv`

### GSEA overview pages
- `...index.html`
- `...pos_snapshot.html`
- `...neg_snapshot.html`

### Ranked gene list
- `...ranked_gene_list_*.tsv`

### Per-pathway files
- individual pathway HTML pages
- individual pathway TSV files
- enrichment plot PNGs

The phenotype-level summary reports are usually the best place to start before drilling into individual pathways.

---

## What the Klim Hallmark run produced

The first validated Klim Hallmark run produced:

- a new HTML report
- a new Shiny app
- a full GSEA results tree under `report/gsea/`
- phenotype-level GSEA summary tables
- per-pathway HTML, TSV, and PNG outputs
- full pipeline provenance outputs

This confirms that the White Lab workflow supports Hallmark GSEA as a stable second-stage enrichment layer.

---

## How to interpret Hallmark results

Hallmark GSEA should be interpreted as a **pathway-level extension** of the baseline DGE run.

This means:

- the baseline DGE result remains the primary validated layer
- Hallmark adds mechanistic context
- Hallmark should not be used to rescue a poorly understood baseline DGE run
- modest enrichment results can still be useful if they align with the known biology

In the Klim example, the Hallmark run suggested a modest interferon / inflammatory-response programme in the knockdown direction, which complemented the already validated gene-level TDP-43 loss-of-function signal.

---

## Recommended documentation after the Hallmark run

After a successful Hallmark extension run, it is good practice to create or update:

### In the live project
- `retained_run_metadata/run_manifest_gsea_hallmark.md`

### In the repo example
- `outputs_summary/hallmark_run_outputs.md`
- `outputs_summary/hallmark_interpretation.md`
- `retention_summary/hallmark_extension_overview.md`

This keeps the extension run clearly documented and linked to the baseline run.

---

## Common mistakes to avoid

### Downloading the wrong MSigDB format
Use Gene Symbols GMT, not Entrez IDs or JSON.

### Pointing `gene_sets_files` at a non-scratch path
The gene set file must be accessible from CREATE compute nodes.

### Reusing the baseline output directory
The Hallmark run should have its own distinct output directory.

### Treating the Hallmark run as a replacement
It is an extension run, not the new baseline.

### Over-interpreting weak enrichment
Hallmark support should be judged in the context of both:
- the baseline DGE signal
- the adjusted enrichment statistics

---

## Summary

A White Lab Hallmark GSEA run should be set up as a distinct extension of a validated baseline DGE analysis.

The key practical choices are:

- download **Gene Symbols** GMT from MSigDB
- stage the GMT in `inputs/gene_sets/`
- use a Hallmark-specific contrasts file and params file
- launch as a separate CREATE-native run
- review the phenotype-level GSEA summary reports first
- document the run as an extension layer, not a replacement for the baseline DGE run

The first validated Klim Hallmark run provides the working reference example for this approach.
