# Retention and handover

This document explains how White Lab downstream bulk RNA-seq differential gene expression runs should be retained and handed over after analysis on CREATE.

The CREATE project is the active execution space for live downstream runs. It is where launches happen, logs accumulate, outputs are generated, and reruns or resumed runs are managed.

It is not, however, the final long-term study record.

This page defines the White Lab approach for deciding:

- what should be retained after a downstream DGE run
- what should remain only in the live CREATE project
- what should be handed over for future reuse
- how to preserve enough context for later interpretation, sharing, and integration

The goal is to ensure that a completed downstream analysis remains understandable and reusable months or years later.

---

## Why retention matters

A downstream DGE study often produces many files and may involve multiple runs, resumed pathway analyses, reporting layers, and interpretation notes.

If retention is handled poorly, the study may later become difficult to understand because:

- the key results were not separated from transient files
- the run identity was not preserved clearly
- the link to the upstream retained preprocessing package was lost
- only plots were kept but not the underlying tables
- custom reports survived but the pipeline provenance did not
- multiple reruns existed without a clear record of which one mattered most

Retention is therefore not only about saving files. It is about preserving the study in a form that remains interpretable and usable.

---

## Core principle

White Lab retention should preserve the **meaningful downstream study package**, not simply copy everything indiscriminately.

That means retaining:

- the core analytical outputs
- the most useful report and exploration outputs
- the launch and provenance context
- enough study notes to understand what was done
- enough linkage to the upstream preprocessing package to preserve continuity

At the same time, retention should avoid turning the retained package into a confusing archive of every transient intermediate or abandoned rerun.

---

## CREATE versus retained study package

It is useful to distinguish three layers clearly.

### 1. Repo
Contains reusable documentation, templates, configs, helper scripts, and worked examples.

### 2. Live CREATE project
Contains the active execution environment, run directories, logs, launch files, and study-specific working material.

### 3. Retained downstream study package
Contains the final or selected downstream outputs and run metadata that should persist as the long-term record of the downstream DGE analysis.

Retention is the step that moves from layer 2 to layer 3.

---

## Relationship to upstream retention

The downstream retained package should be understood as the companion to the already retained upstream preprocessing package.

In White Lab practice:

- preprocessing outputs are retained first
- downstream DGE begins from those retained preprocessing outputs
- downstream outputs are then retained in their own structured package
- both packages together form the broader study record

This means the downstream retained package should always preserve a clear reference to the exact upstream retained preprocessing package it depends on.

---

## What a retained downstream package should achieve

A good retained downstream package should allow a future user to answer the following questions without guesswork:

- which study is this?
- which upstream retained preprocessing package was used?
- which matrix strategy was used for downstream DGE?
- which metadata and contrasts were used?
- which pipeline version and run definition produced these outputs?
- which output directory contained the retained result set?
- were pathway analyses included?
- which files are the main result tables and reports?
- what are the main caveats or notes from the run review?

If the retained package cannot answer those questions, it is probably incomplete.

---

## What should usually be retained

For most White Lab downstream DGE studies, the retained package should usually include the following categories.

### 1. Core differential result tables
These are among the most important files in the entire study.

They should usually include the main contrast-level differential outputs that underpin later interpretation, figure generation, and downstream reuse.

### 2. Key visual outputs
This includes the most useful exploratory and differential plots that help communicate the study and support interpretation.

These should usually be retained selectively rather than indiscriminately.

### 3. Pathway or enrichment outputs if used
If the study included GSEA, g:Profiler, Hallmark, GO, or related enrichment layers, the key corresponding output tables and summaries should usually be retained.

### 4. Main reporting outputs
The HTML report is usually a strong candidate for retention.

The R Markdown reporting bundle and Shiny app outputs are also often valuable retained assets where generated and useful.

### 5. Run provenance and launch metadata
These files are essential for reproducibility and later understanding of the analysis.

### 6. Study-level notes
A short summary of what was run, what it showed, and any important caveats is extremely valuable and should usually be retained.

---

## What does not usually need to be retained in full

Not every file from the live CREATE project needs to be carried forward into the retained package.

Files that often do not need full long-term retention include:

- transient working files
- large Nextflow work directories
- repeated failed launch attempts with no analytical value
- duplicate or obsolete params drafts
- redundant logs where the final run metadata is already preserved clearly
- outputs from abandoned exploratory branches that are not part of the intended retained study record

These may remain in the live CREATE project for a period, but they do not usually belong in the clean retained package.

---

## White Lab recommended retained downstream package structure

A study-level retained downstream package should be organised clearly and consistently.

A recommended model is:

    differential_expression/
    └── out_<RUN_TIMESTAMP>/
        ├── launch_metadata/
        ├── pipeline_info/
        ├── reports/
        ├── differential_results/
        ├── exploratory_plots/
        ├── differential_plots/
        ├── pathway_analysis/
        ├── shiny_app/
        └── study_notes/

This structure is analogous in spirit to the upstream retention approach: keep the retained package organised around meaningful output classes rather than preserving one large unstructured output tree.

The exact contents may vary by study, but the logic should remain stable.

---

## Purpose of each retained directory

### `launch_metadata/`
Contains the run identity and provenance material needed to understand how the analysis was launched.

Typical contents may include:

- params file used
- CREATE config used
- launch command record
- run manifest
- pipeline version note
- references to the upstream retained preprocessing package

This directory is one of the most important parts of the retained package.

### `pipeline_info/`
Contains pipeline-generated metadata and workflow information needed for reproducibility and interpretation.

Where available, this should be retained in a similar way to the upstream workflow.

### `reports/`
Contains the human-readable reporting assets.

Typical contents may include:

- HTML report
- R Markdown report bundle
- selected custom downstream reports where clearly linked to the run

### `differential_results/`
Contains the main contrast-level differential tables.

This is usually the scientific core of the retained downstream package.

### `exploratory_plots/`
Contains selected sample-level and exploratory visual outputs that help document study behaviour.

### `differential_plots/`
Contains selected visual summaries of contrast-level results such as MA-style and volcano-style outputs.

### `pathway_analysis/`
Contains retained pathway or enrichment outputs where these were part of the study.

### `shiny_app/`
Contains the generated Shiny app output if it is useful enough to retain.

### `study_notes/`
Contains short written interpretation and handover material.

This directory is strongly recommended and often overlooked.

---

## Retention should be selective but meaningful

White Lab retention should avoid two extremes.

### Extreme 1. Keep everything
This can produce an unwieldy retained package that is difficult to navigate and understand.

### Extreme 2. Keep only a few polished figures
This risks losing the actual analytical substance and provenance of the study.

The preferred approach is selective but meaningful retention.

That means keeping the files that a future user is most likely to need in order to:

- understand the analysis
- trust the results
- reuse the outputs
- compare them with later work
- communicate the study accurately

---

## Recommended minimum retained file set

For a standard downstream DGE study, the minimum retained set should usually include:

- main differential result tables
- key HTML report
- launch metadata sufficient to reconstruct the run context
- pipeline information
- key pathway result tables if pathway analysis was part of the run
- short study summary notes

Anything less than this risks weakening the long-term value of the study.

---

## Strongly recommended additional retained assets

Where practical, it is also often valuable to retain:

- selected exploratory plots
- selected differential plots
- R Markdown reporting bundle
- Shiny app output
- concise comparison notes between initial and resumed pathway runs
- contrast files and metadata files used in the retained run identity

These can make the retained study package much more useful later for teaching, collaboration, and manuscript preparation.

---

## White Lab study notes expectation

Every retained downstream package should ideally include a short study note summarising:

- study name
- biological context
- linked upstream retained preprocessing package
- downstream matrix strategy used
- metadata and contrast set used
- pipeline version used
- main retained run identity
- key findings at a high level
- important caveats or follow-up questions
- notes on any pathway extensions or resumed runs retained as part of the study record

This note does not need to be long, but it is incredibly valuable.

A short, well-written summary can save huge amounts of time later.

---

## How to handle multiple downstream runs in retention

Many studies will have more than one live downstream run.

For example:

- initial DGE run
- resumed Hallmark GSEA run
- resumed GO BP run
- rerun with updated reporting settings

White Lab retention should be explicit about which of these runs are retained as part of the long-term study package.

There are two common good approaches.

### Approach 1. Retain one primary downstream run
If one run clearly supersedes the others or already contains the key outputs needed, retain that run as the main downstream record.

### Approach 2. Retain multiple related downstream runs with clear identity
If the study genuinely benefits from keeping distinct pathway extension runs, they may be retained as separate named retained packages so long as their identity is clear.

What should be avoided is a retained directory full of multiple ambiguous run trees with no explanation of their relationship.

---

## White Lab recommendation for multiple-run retention

A good default is:

- retain the main initial DGE run
- retain any meaningfully distinct pathway extension runs only if they add important interpretive value
- preserve a note explaining how the retained runs relate to one another

This keeps the retained package useful without making it chaotic.

---

## Relationship to the live CREATE project

The retained package should not be expected to preserve every operational detail of the live CREATE project.

The live project remains the richer execution history.

The retained package should instead preserve the final or selected analytical record in a cleaner form.

In practical terms:

- live CREATE holds execution complexity
- retained package holds the study record

This distinction is healthy and should be maintained.

---

## Suggested retained provenance record

For each retained downstream run, White Lab should preserve a compact run manifest that records at least:

- study ID
- run ID
- run date
- pipeline name
- pipeline version
- output directory retained
- matrix file used
- transcript length matrix used if applicable
- metadata file used
- contrasts file used
- feature annotation source used
- whether pathway analysis was enabled
- whether the run was initial or resumed
- location of the linked upstream retained preprocessing package
- short note describing purpose and outcome

This can be stored as a plain text, markdown, or YAML summary in `launch_metadata/`.

What matters most is clarity and consistency.

---

## Handling custom reports and follow-up outputs

Some studies will generate additional White Lab outputs after the pipeline run, such as:

- custom R Markdown summaries
- presentation-ready figure collections
- collaborator update PDFs
- lab meeting notes

These may also be valuable for retention, but they should be distinguished clearly from the pipeline-native outputs.

A good practice is to retain them only if:

- they are clearly linked to the study
- they are versioned or named sensibly
- they do not replace the core pipeline outputs and provenance
- they add real interpretive or communication value

Custom outputs can be retained alongside the main downstream package, but they should never become the only surviving record of the analysis.

---

## Handover to future users

A retained downstream package is also a handover tool.

A future user should be able to take the retained package and understand:

- what was done
- what the major outputs are
- what the study found at a high level
- what caveats remain
- where the upstream inputs came from
- how to revisit or extend the analysis if needed

This is especially important for:

- new lab members
- student handover
- collaborator continuity
- revisiting old studies for grants, talks, or publications

Good retention makes handover much easier.

---

## Common retention mistakes to avoid

### Keeping only plots and not tables
This leaves the study hard to reuse computationally.

### Keeping only polished reports and not launch metadata
This weakens reproducibility and trust.

### Retaining multiple run outputs with no explanation
This creates confusion about which run is the authoritative one.

### Losing the link to the upstream retained preprocessing package
This breaks the study continuity.

### Preserving every transient file
This makes the retained package harder to navigate and understand.

### Failing to include a short summary note
This often makes later reuse much slower than necessary.

---

## White Lab retention review checklist

Before finalising the retained package, ask:

### Core analytical outputs
- Are the main differential result tables present?
- Are key pathway outputs retained if relevant?

### Reporting outputs
- Is the HTML report retained?
- Are R Markdown and Shiny outputs retained if useful?

### Provenance
- Is the pipeline version recorded?
- Are the params and config records preserved?
- Is the upstream retained preprocessing package referenced clearly?

### Study understanding
- Is there a concise study summary note?
- Are key caveats or interpretation notes preserved?

### Run identity
- Is it clear which run or runs were retained?
- Is the relationship between initial and resumed runs understandable?

If the answer to any of these is no, the retention package may need improvement.

---

## Relationship to the worked example

The worked Klim example should eventually demonstrate not only how the downstream run is launched, but also how the retained downstream package is structured and why particular outputs were selected for retention.

This will be especially useful for training because retention is often easier to understand from a real example than from abstract rules alone.

---

## Summary

White Lab downstream DGE retention should preserve a clean, interpretable long-term study package rather than a copy of the entire live CREATE execution environment.

At minimum, the retained package should usually include:

- core differential result tables
- key pathway outputs if relevant
- the main HTML report
- pipeline and launch metadata
- a clear link to the upstream retained preprocessing package
- a concise study summary note

A good retained package makes the downstream study easier to trust, revisit, share, and build upon.

The next document to read is:

[`worked-example-guide.md`](worked-example-guide.md)
