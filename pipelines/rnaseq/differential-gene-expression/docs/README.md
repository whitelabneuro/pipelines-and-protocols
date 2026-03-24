# Documentation

This `docs/` directory contains the core training and reference material for the White Lab downstream bulk RNA-seq differential gene expression workflow.

The `differential-gene-expression/` repo section is designed to start from retained upstream preprocessing outputs, not from raw FASTQ files. It provides the documentation needed to understand how to move from processed quantification outputs into reproducible downstream DGE analysis using the White Lab repo structure and `nf-core/differentialabundance`.

This documentation is intended for:

- PhD students learning the workflow for the first time
- postdocs setting up new studies
- lab members revisiting an analysis after time away
- anyone needing a clear explanation of how White Lab downstream RNA-seq analysis is organised

---

## What this documentation covers

The pages in this directory explain:

- where the downstream DGE workflow begins
- which retained preprocessing outputs are required
- how to choose the correct count matrix
- how to prepare metadata and contrasts
- how to organise a live CREATE downstream project outside the repo
- how to launch and interpret `nf-core/differentialabundance`
- how to work with reports, R Markdown outputs, and Shiny outputs
- how to handle resumed runs for pathway analysis layers
- what to retain after a downstream analysis is complete
- how to use the worked Klim example for training and reference

---

## Recommended reading order for new users

If you are new to this repo section, read the following pages in order:

1. [`workflow-overview.md`](workflow-overview.md)  
   Start here for the big-picture view of where this downstream pipeline fits in the White Lab RNA-seq workflow.

2. [`required-inputs.md`](required-inputs.md)  
   Explains which retained preprocessing outputs are needed before you can begin downstream DGE.

3. [`count-matrix-selection.md`](count-matrix-selection.md)  
   Describes the different matrix types available from preprocessing and how to decide which should be used for analysis.

4. [`metadata-and-contrasts.md`](metadata-and-contrasts.md)  
   Explains how to structure sample metadata and contrasts correctly for downstream differential analysis.

5. [`nfcore-differentialabundance-run-setup.md`](nfcore-differentialabundance-run-setup.md)  
   Describes how White Lab downstream DGE runs are launched and configured using `nf-core/differentialabundance`.

6. [`create-staging-checklist.md`](create-staging-checklist.md)  
   Practical checklist for building the live CREATE project, staging archived inputs into scratch, and confirming the run is ready to submit.

7. [`outputs-guide.md`](outputs-guide.md)  
   Explains the major output types produced by the downstream pipeline and how to interpret them.

8. [`dge-qc-and-interpretation.md`](dge-qc-and-interpretation.md)  
   Covers downstream QC, result review, and good interpretation practice.

---

## Additional documentation

Once you are comfortable with the core workflow, the following pages provide more detailed guidance:

- [`create-run-structure.md`](create-run-structure.md)  
  How to organise live CREATE downstream project directories outside the repo.

- [`create-staging-checklist.md`](create-staging-checklist.md)  
  Practical step-by-step checklist for staging archived preprocessing outputs into scratch and preparing a live CREATE downstream run.

- [`resumed-runs-and-pathway-analysis.md`](resumed-runs-and-pathway-analysis.md)  
  How White Lab uses resumed `nf-core/differentialabundance` runs to extend analyses with pathway layers such as GO BP, GO MF, and related downstream enrichments.

- [`hallmark-gsea-run-guide.md`](hallmark-gsea-run-guide.md)  
  Practical guide for downloading the correct MSigDB Hallmark Gene Symbols GMT, staging it on scratch, and running a separate Hallmark GSEA extension on CREATE.

- [`shiny-app-local-run.md`](shiny-app-local-run.md)  
  Explains how to launch and use the generated ShinyNGS app locally from a completed downstream output directory.

- [`report-rmarkdown-and-shiny.md`](report-rmarkdown-and-shiny.md)  
  How to use the HTML report, R Markdown outputs, and Shiny outputs for data review, communication, and further exploration.

- [`retention-and-handover.md`](retention-and-handover.md)  
  What to retain after a downstream DGE analysis and what should be passed forward into later analysis stages.

- [`worked-example-guide.md`](worked-example-guide.md)  
  Introduces the worked example and explains how it should be used as a training resource.

---

## Documentation principles

These docs follow the same core principles established for the upstream preprocessing pipeline:

- clear separation between reusable repo resources and live analysis projects
- explicit explanation of why each file and step exists
- educational writing aimed at training new lab members
- emphasis on reproducibility, provenance, and interpretation
- consistency across White Lab RNA-seq pipeline layers

The aim is not only to tell users what to do, but to help them understand the structure and logic of the workflow.

---

## Relationship to the rest of the repo

This `docs/` directory is only one part of the overall downstream DGE repo section.

At top level:

- `README.md` provides the repo-wide overview
- `docs/` provides training and reference documentation
- `configs/` contains reusable configuration material
- `templates/` contains clean starter material for new studies
- `scripts/` contains reusable helper utilities
- `examples/` contains worked studies
- `decisions/` records important White Lab conventions and rationale

The documentation in this folder should therefore be read alongside the top-level `README.md` and, when relevant, the worked example in `examples/`.

---

## Suggested use of this documentation

A good way to use this documentation is:

- first, understand the workflow and required inputs
- next, review matrix choice, metadata, and contrasts carefully
- then, use templates to set up a new live downstream project outside the repo
- finally, use the worked example to compare your setup against a completed reference analysis

This approach helps keep new projects consistent, interpretable, and easier to troubleshoot.

---

## Current scope

At present, this documentation is focused on:

- bulk short-read RNA-seq
- downstream differential gene expression analysis
- use of retained outputs from the White Lab preprocessing workflow
- standardised downstream analysis using `nf-core/differentialabundance`

As the broader White Lab transcriptomic workflow expands, further downstream modules may be added elsewhere in the repository structure, but this `docs/` directory is specifically focused on the DGE layer.

---

## Next step for users

If you are starting from scratch, begin with:

[`workflow-overview.md`](workflow-overview.md)
