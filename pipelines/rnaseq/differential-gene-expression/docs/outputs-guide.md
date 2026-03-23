# Outputs guide

This document explains the main output types produced by the White Lab downstream bulk RNA-seq differential gene expression workflow using `nf-core/differentialabundance`.

The purpose of this page is to help users understand:

- what the pipeline produces
- which outputs are most important
- which outputs are mainly exploratory
- which outputs are useful for communication and reporting
- which outputs should be prioritised for review and retention

A successful downstream run can generate many files. Not all of them have the same analytical importance. This guide is intended to help White Lab users distinguish between core differential results, pathway interpretation outputs, reporting artefacts, and supporting files.

---

## Why an outputs guide is needed

Downstream DGE runs often generate a large number of result tables, plots, reports, and auxiliary files.

Without a clear framework, users may struggle to answer basic questions such as:

- Which files contain the main differential expression results?
- Which outputs are most useful for first-pass review?
- Which files are pathway-related?
- Which files are meant for interactive exploration?
- Which outputs are temporary conveniences and which should be retained long-term?

This guide aims to make the output landscape easier to navigate.

---

## Core principle

A White Lab downstream DGE run should be interpreted in layers.

### Layer 1. Core differential results
These are the central outputs of the run and usually contain the main statistical results.

### Layer 2. Quality and exploratory outputs
These help the user assess sample behaviour, contrast behaviour, and general plausibility of the analysis.

### Layer 3. Pathway and enrichment outputs
These extend interpretation beyond individual genes.

### Layer 4. Reporting and communication outputs
These provide summaries, human-readable reports, and interactive exploration layers.

### Layer 5. Provenance and run-supporting outputs
These help preserve how the run was performed and how the outputs should be interpreted later.

Understanding outputs in these layers is much more useful than treating the output directory as one flat collection of files.

---

## High-level output categories

For a standard White Lab downstream DGE study, the outputs usually fall into the following broad categories:

- differential result tables
- exploratory plots
- differential plots
- pathway / enrichment outputs
- HTML report outputs
- R Markdown reporting bundle outputs
- Shiny app outputs
- pipeline information and provenance
- supporting files for later retention or handover

The exact output set depends on the parameters used in the run.

---

## Most important outputs for first-pass review

When reviewing a new downstream run, White Lab users should usually prioritise the following output classes first:

### 1. Main differential result tables
These are the core gene-level outputs and should usually be the first files reviewed.

### 2. Sample-level and exploratory plots
These help determine whether the analysis behaved sensibly at a high level.

### 3. Differential plots
These help visualise effect sizes, significance structure, and contrast behaviour.

### 4. Pathway outputs if enabled
These help move from gene lists to biological interpretation.

### 5. HTML report
This is often the quickest way to review the run in an integrated way.

### 6. Shiny app output if generated
This can be very helpful for interactive exploration and handover.

---

## Core differential result tables

These are usually the most important outputs in the entire run.

They represent the main feature-level statistical results for the defined contrasts.

In White Lab practice, these tables should usually be treated as the primary analytical outputs of the run.

They are typically the files that answer questions such as:

- which genes changed significantly?
- what is the log2 fold change for each gene?
- what is the adjusted p-value?
- how strong is the evidence for the comparison?
- which genes should be prioritised for further interpretation?

### White Lab view of these tables
These are the main outputs for:

- biological interpretation
- figure generation
- downstream annotation
- pathway analysis context
- sharing with collaborators
- long-term retention

A downstream run that completes without these tables being interpretable should not be regarded as fully successful.

---

## Exploratory sample-level outputs

These outputs help the user assess overall sample behaviour and study structure.

Typical exploratory outputs may include visual summaries such as:

- sample clustering views
- sample-to-sample similarity summaries
- PCA-type summaries
- exploratory heatmap-style outputs
- covariate or metadata-aware exploratory plots

These are not the main inferential outputs, but they are often essential for understanding whether the downstream analysis is behaving sensibly.

### White Lab role of exploratory outputs
These outputs are especially useful for:

- checking whether biological groups separate as expected
- identifying possible outliers
- spotting batch structure
- confirming replicate behaviour
- supporting interpretation discussions in lab meetings

These files should therefore be reviewed early, even if they are not the main retained result tables.

---

## Differential plots

These outputs visualise the contrast-level statistical results.

Typical examples may include:

- MA-style plots
- volcano-style plots
- ranked significance summaries
- comparison-specific visual overviews

These are extremely helpful because they give users a quick visual sense of:

- overall effect size distribution
- significance structure
- symmetry or asymmetry in changes
- whether the contrast appears biologically plausible
- whether there are obvious anomalies

### White Lab role of differential plots
These outputs are important for:

- rapid first-pass interpretation
- slide preparation
- communication with collaborators
- deciding which contrasts deserve deeper follow-up
- identifying unusual behaviour that may require checking metadata or matrix choice

They are often among the most useful files for immediate human review.

---

## Pathway and enrichment outputs

If pathway analysis has been enabled, the run may also generate outputs related to:

- GSEA
- Hallmark gene sets
- GO Biological Process
- GO Molecular Function
- GO Cellular Component
- curated pathway collections
- g:Profiler-based enrichment
- other configured gene set analyses

These outputs typically move the study from individual-gene interpretation toward process-level interpretation.

### White Lab role of pathway outputs
These are especially useful for:

- identifying broader biological themes
- summarising large DGE result sets
- prioritising mechanisms for discussion
- preparing figures and summaries for presentations and grants
- comparing pathway behaviour across contrasts

However, pathway outputs are not a substitute for reviewing the core differential result tables. They are an interpretation layer built on top of them.

---

## HTML report outputs

The HTML report is usually one of the most useful outputs for initial review.

It provides an integrated, human-readable summary of the run and often serves as the easiest entry point for understanding what happened.

### White Lab role of the HTML report
The HTML report is valuable because it:

- brings together multiple output types in one place
- helps users review a run without manually opening many files
- supports quick triage after a run completes
- is useful for communication and handover
- provides a compact summary of the study state

For many users, the HTML report will be the first file they open after a run finishes.

That is good practice, but it should be followed by direct review of the core result tables for any serious downstream interpretation.

---

## R Markdown reporting bundle outputs

The pipeline can also produce report materials that support later customisation.

These outputs are particularly valuable in White Lab practice because they provide a bridge between standard pipeline reporting and more tailored reporting for presentations, manuscripts, internal review, or teaching.

### White Lab role of the R Markdown bundle
These outputs are useful for:

- understanding how the standard report was constructed
- making controlled report edits later
- re-rendering a modified report
- adapting the default output into a more study-specific summary

These outputs should generally be seen as a reporting resource rather than the main statistical result layer.

---

## Shiny app outputs

If Shiny app generation is enabled, the run may also produce an interactive app output.

This can be one of the most valuable outputs for data exploration and handover.

### White Lab role of the Shiny outputs
The Shiny app is useful for:

- interactive exploration of differential results
- browsing contrasts more flexibly than in static plots
- allowing others to inspect the run without opening many raw files
- supporting lab discussion and result exploration
- creating a more accessible interface for a completed analysis

In many studies, this will be a strongly recommended output even if it is not the core retained statistical file set.

---

## Provenance and pipeline information outputs

In addition to the biological result files, downstream runs will also produce supporting files that help document how the run was performed.

These may include:

- pipeline execution metadata
- software or versioning information
- run summaries
- command traces
- pipeline-specific information directories
- workflow logs

### White Lab role of provenance outputs
These files are important for:

- reproducibility
- troubleshooting
- rerun planning
- retention
- auditability
- helping later users understand what happened

These outputs may not be biologically interesting, but they are part of the identity of the run and should not be ignored.

---

## Output interpretation hierarchy

When a White Lab downstream run completes, outputs should usually be reviewed in the following order.

### 1. Confirm the run completed properly
Check that the pipeline completed successfully and that the expected output structure exists.

### 2. Open the HTML report
This provides the fastest integrated overview of the run.

### 3. Review sample-level exploratory outputs
Confirm that the overall study behaviour looks plausible.

### 4. Review main differential result tables
Identify the main statistical results and contrast behaviour.

### 5. Review differential plots
Check whether fold changes and significance patterns look sensible.

### 6. Review pathway outputs if enabled
Interpret process-level signals only after the core DGE layer appears sound.

### 7. Review Shiny and R Markdown outputs as needed
Use these for deeper exploration, communication, or report refinement.

This order helps prevent over-interpreting enrichment outputs before the underlying DGE layer has been checked properly.

---

## White Lab distinction between primary and secondary outputs

It is useful to classify outputs explicitly.

### Primary outputs
These are the main analytical deliverables of the run.

Examples include:
- core differential result tables
- key contrast-level plots
- pathway result tables if pathway analysis was a main aim
- the integrated HTML report
- selected Shiny outputs where used for exploration or handover

### Secondary outputs
These are useful but not usually the main scientific deliverables.

Examples include:
- intermediate summary plots
- auxiliary report files
- diagnostic graphics that are only locally informative
- internal supporting files generated during reporting

### Provenance-supporting outputs
These are essential for reproducibility even if not central to biological interpretation.

Examples include:
- pipeline metadata
- config records
- run summaries
- execution logs
- launch records

This classification is useful later when deciding what to retain.

---

## Which outputs matter most for different purposes

Different outputs matter for different downstream tasks.

### For first-pass QC and sanity checking
Most important:
- HTML report
- exploratory sample-level outputs
- differential plots

### For biological interpretation
Most important:
- differential result tables
- pathway outputs
- key visual summaries

### For collaborator sharing
Most important:
- HTML report
- selected tables
- selected plots
- Shiny app if available

### For custom reporting and presentation
Most important:
- result tables
- differential plots
- pathway outputs
- R Markdown bundle outputs

### For long-term reproducibility
Most important:
- result tables
- pipeline provenance outputs
- launch records
- selected report outputs

---

## Common output misunderstandings to avoid

### Treating the HTML report as the only output that matters
The HTML report is very useful, but it is not a replacement for the actual result tables.

### Treating pathway outputs as primary evidence without checking DGE first
Pathway results are only as meaningful as the underlying differential analysis.

### Ignoring exploratory outputs
These are often crucial for detecting design problems or unexpected sample behaviour.

### Retaining only plots and not tables
Plots are useful for communication, but tables are essential for reuse and auditability.

### Failing to preserve provenance outputs
A run without a clear provenance trail is much harder to trust and revisit.

### Confusing interactive and static outputs
The Shiny app and HTML report are useful interfaces, but they do not replace careful retention of the underlying results.

---

## Suggested White Lab review checklist after a run

After a downstream run completes, ask the following.

### Completion and structure
- Did the pipeline complete successfully?
- Are the expected output groups present?

### Exploratory behaviour
- Do the sample-level outputs look plausible?
- Are there obvious outliers or strange separations?

### Differential results
- Are the contrast result tables present?
- Do the fold changes and significance patterns make sense?

### Pathway interpretation
- If enabled, do the pathway outputs align with the differential signal?
- Are the enrichment settings understood and documented?

### Reporting
- Is the HTML report usable?
- Was the R Markdown bundle generated as expected?
- Was the Shiny app generated if intended?

### Provenance
- Are the run identity, pipeline version, and launch context preserved?

This review should happen before deciding what to retain long-term.

---

## Output review in the context of resumed runs

When a study includes resumed runs, output interpretation should stay aware of run identity.

Users should be able to tell:

- which output directory belongs to the initial DGE run
- which output directory belongs to a pathway extension run
- whether the results come from the same core design or a modified branch
- whether reporting differences reflect analytical differences or only output settings

This is another reason why output directories and launch files should be named clearly.

---

## White Lab recommended priority outputs for retention review

When planning later retention, the outputs most likely to be prioritised are:

- the main differential result tables
- key contrast plots
- pathway result tables and summaries if used
- the HTML report
- Shiny app output where useful
- pipeline provenance / run metadata
- enough launch information to reconstruct the run context

The exact retention package is described in more detail in `retention-and-handover.md`.

---

## Relationship to the next documents

This page explains what the pipeline produces in broad practical terms.

The next documents focus on two key areas in more detail:

- `report-rmarkdown-and-shiny.md` explains the reporting and interactive output layers
- `dge-qc-and-interpretation.md` explains how to review and interpret the outputs properly

---

## Summary

A White Lab downstream DGE run produces more than just one results table.

The outputs should be understood in layers:

- core differential result tables
- exploratory and differential plots
- pathway and enrichment outputs
- HTML reporting outputs
- R Markdown reporting bundle outputs
- Shiny app outputs
- provenance and run-supporting outputs

The most important rule is that users should review the outputs in a structured way and distinguish clearly between:

- core statistical results
- interpretation layers
- reporting layers
- reproducibility-supporting files

The next document to read is:

[`report-rmarkdown-and-shiny.md`](report-rmarkdown-and-shiny.md)
