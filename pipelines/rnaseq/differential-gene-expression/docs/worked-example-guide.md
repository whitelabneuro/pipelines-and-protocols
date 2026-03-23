# Worked example guide

This document explains the purpose and use of the worked example for the White Lab downstream bulk RNA-seq differential gene expression workflow.

The worked example is an important part of this repo section because it shows how the reusable White Lab structure is applied in practice using a real study handoff from upstream preprocessing into downstream DGE analysis.

This page explains:

- what the worked example is for
- what it is not for
- how it relates to the upstream preprocessing example
- how users should learn from it
- how it will support later validation on CREATE and long-term training in the lab

---

## Why the worked example exists

The documentation and templates explain the intended structure of the workflow, but many users learn best by seeing a concrete study laid out in full.

The worked example exists to show:

- how retained upstream preprocessing outputs feed into downstream DGE
- how a real study is organised using the repo structure
- how launch files, inputs, reports, and retained outputs relate to one another
- what a finished reference analysis looks like in White Lab practice

In other words, the worked example is where the abstract workflow becomes tangible.

---

## Core principle

The worked example is a **teaching and reference resource**.

It is not the template source for new studies.

That distinction is very important.

In White Lab practice:

- `templates/` should provide the clean starting point for new projects
- `examples/` should show a completed or realistic reference implementation

Users should study the example to understand the workflow, but they should start new analyses from the templates, not by cloning or editing the example directly.

---

## The first worked example in this repo

The first worked example for the downstream DGE repo section is based on:

- **Example dataset ID:** `klim2019_tdp43kd`
- **CREATE project ID:** `Klim_TDP_LOF`

This study is based on the same Klim et al. 2019 human iPSC-derived motor neuron RNA-seq dataset already used to build and validate the upstream preprocessing example.

That continuity is a major strength because it allows the downstream example to demonstrate a real handoff from the completed White Lab preprocessing workflow into downstream differential analysis.

---

## Relationship to the upstream preprocessing example

The downstream worked example is not a standalone case invented in isolation.

It follows directly from the completed upstream preprocessing example in:

`pipelines/rnaseq/nfcore-rnaseq-processing/examples/klim2019_tdp43kd/`

This means the downstream example should demonstrate the actual White Lab workflow chain:

### Upstream preprocessing example
Raw FASTQ files are processed through the preprocessing pipeline and key outputs are retained.

### Downstream DGE example
Those retained preprocessing outputs are then used as the handoff package for downstream differential analysis.

This relationship is one of the most valuable educational aspects of the overall repo design.

It teaches users that downstream DGE should begin from retained, traceable processed outputs rather than from detached matrices of unclear origin.

---

## What the worked example should teach

A good worked example should help a user understand all of the following.

### 1. How a downstream study begins
It should show exactly which retained upstream files are used to start the DGE analysis.

### 2. How live CREATE structure maps to repo structure
It should show how launch files, inputs, outputs, and retained materials are organised in practice.

### 3. How matrix choice is documented
It should show which matrix strategy was used and why.

### 4. How metadata and contrasts are defined
It should show how the study design is represented in actual files.

### 5. How `nf-core/differentialabundance` is launched
It should show the launch pattern and run identity clearly.

### 6. How outputs are reviewed and retained
It should show which outputs were considered important enough to carry forward into the retained package.

### 7. How downstream reporting and pathway layers fit in
Where relevant, it should show how the HTML report, R Markdown bundle, Shiny app, and resumed pathway runs are handled.

If the example can teach those things clearly, it will be extremely valuable for the lab.

---

## What the worked example is not meant to do

The example should not try to do everything.

It is not intended to be:

- the only valid way to run downstream DGE
- a substitute for reading the docs
- the place where all future studies are edited in place
- a general dumping ground for every exploratory side branch
- a replacement for clean templates

The example should remain focused, readable, and educational.

It should demonstrate good practice, not become the only place where workflow logic exists.

---

## White Lab recommended role of the example directory

Within the repo, the example directory should act as a bridge between documentation and real execution.

In practical terms, it should help users move from:

- “I understand the docs in principle”

to:

- “I can see what this looks like in a real study”

That makes it especially useful for:

- new PhD students
- postdocs onboarding to the workflow
- revisiting the workflow after time away
- checking whether a new live project has been organised sensibly

---

## What the worked example should eventually contain

Once built, the worked example should normally include a structured subset of the materials that define and illustrate the study.

Typical contents may include:

- a local example README
- a short study overview
- references to the upstream retained preprocessing package
- representative input files such as metadata and contrasts
- representative launch files
- notes on matrix choice
- notes on pipeline version and run identity
- selected example outputs or output summaries
- notes on retention structure
- possibly selected report artefacts where practical and appropriate

The example should be rich enough to teach from, but not so large or messy that it becomes difficult to browse in the repo.

---

## Relationship between the example and real CREATE validation

The worked example becomes much more valuable once it is backed by a real CREATE validation run.

That validation run will allow the example to contain:

- real launch definitions
- real output structure
- real report outputs
- real retained downstream package structure
- realistic study notes based on actual run review

This is one of the reasons we have been building the docs and structure first.

A strong example is best created once the repo design is mature enough that the validation run can reflect the intended final workflow rather than a provisional draft.

---

## When the worked example should be built

The worked example becomes appropriate once the following are in place:

- the top-level repo structure is defined
- the core documentation pages are written
- the first `templates/` structure exists
- the first reusable `configs/` structure exists
- the repo clearly distinguishes template, example, and live CREATE project roles

At that point, building the example is no longer premature. It becomes a useful way to validate the design and generate real training material.

That is the stage we are now approaching.

---

## Recommended White Lab sequence from here

A sensible sequence is:

### 1. Finish the core docs
This is now essentially complete.

### 2. Define the first `templates/` and `configs/`
This will create the reusable source material for real studies.

### 3. Build the Klim example structure in the repo
This should reflect the intended final organisation.

### 4. Run the first real CREATE validation study
Use the retained Klim preprocessing outputs and the repo templates/configs to perform the first downstream validation run.

### 5. Feed the real outputs back into the example
Use the actual run outputs, reports, and retention decisions to strengthen the example and the docs.

This is the best way to ensure the example is both realistic and aligned with the final repo design.

---

## How users should use the worked example

A new user should ideally use the worked example in the following way.

### First, read the docs
The documentation explains the logic of the workflow.

### Next, inspect the example
The worked example shows how that logic appears in a real study.

### Then, compare against the templates
This helps the user understand what is reusable versus what is study-specific.

### Finally, build a new live CREATE project from the templates
The example is the reference point, not the starting point.

This sequence keeps the workflow educational and avoids the common mistake of using old examples as hidden templates.

---

## What makes a good worked example

A good worked example should be:

- real rather than purely hypothetical
- clearly linked to the upstream retained package
- structured in a way that mirrors the docs
- explicit about matrix strategy and design choices
- clear about what was launched and why
- clear about what outputs matter most
- selective rather than bloated
- well annotated for teaching

It should not simply be a folder of copied files with minimal explanation.

The example is most useful when its contents make sense even to someone who did not build the original run.

---

## Example-specific README expectations

The worked example should eventually include its own local README.

That README should explain:

- what the study is
- how it relates to the upstream preprocessing example
- which retained preprocessing package it starts from
- which downstream matrix strategy was used
- what the main contrast(s) are
- what major run(s) are represented
- what parts of the example are illustrative versus reusable
- where the user should look first

This will make the example much easier to browse and teach from.

---

## Example versus retention

The worked example in the repo should not try to be a complete mirror of the retained study package on RDS.

Instead, it should present a curated and educational view of the study.

That means it may contain:

- representative launch files
- representative input files
- selected output summaries
- documentation of retained structure

rather than every retained file itself.

The full retained package lives in the retained study location. The repo example teaches users how that retained package is structured and why.

---

## White Lab benefits of a strong example

A well-designed worked example provides several benefits.

### Training
New users can see the workflow in practice rather than only in abstract documentation.

### Consistency
The example becomes a reference point for what a good White Lab downstream study should look like.

### Validation
A real example reveals where the docs, templates, or configs still need improvement.

### Handover
The example helps future users understand old studies more easily.

### Confidence
Users are more likely to set up a correct project when they can compare it against a finished reference case.

This is why the example should be treated as an important part of the repo, not an optional extra.

---

## Common mistakes to avoid when building the example

### Turning the example into the template source
This makes the repo harder to maintain and confuses users.

### Including too much unstructured output
The example should be curated, not dumped.

### Leaving the example under-explained
A folder of files is less useful than an example with clear notes and a local README.

### Breaking continuity with the upstream example
The handoff from preprocessing is one of the most valuable teaching points and should remain explicit.

### Building the example before the repo structure is stable
This often leads to rewrites and inconsistencies later.

We have deliberately avoided that problem by defining the docs and structure first.

---

## White Lab recommendation on the next step

Now that the core documentation is in place, the next best step is to define:

- `templates/`
- `configs/`
- top-level `examples/` structure

Once those exist, it becomes appropriate to build the Klim worked example and then perform the first real CREATE validation run using the retained preprocessing outputs.

That validation run should then feed directly back into the example and the repo documentation.

---

## Summary

The worked example is the practical reference implementation of the White Lab downstream DGE workflow.

Its purpose is to show how:

- retained preprocessing outputs are handed into downstream DGE
- a real study is structured
- launch files, inputs, reports, and retained outputs fit together
- the White Lab repo philosophy works in practice

For this repo section, the first worked example will be based on the Klim 2019 TDP-43 knockdown study and will provide the bridge between the completed upstream preprocessing example and the first validated downstream DGE analysis.

The next major stage after this document is to define the first reusable `templates/` and `configs/`, then build the Klim example and use it for the first real CREATE validation run.
