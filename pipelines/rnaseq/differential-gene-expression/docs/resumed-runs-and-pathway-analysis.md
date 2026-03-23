# Resumed runs and pathway analysis

This document explains how White Lab downstream bulk RNA-seq differential gene expression projects should handle resumed runs and pathway analysis layers when using `nf-core/differentialabundance`.

In White Lab practice, a downstream DGE study is often not a single one-off run. A study may begin with an initial differential expression analysis and then be extended through resumed or modified runs to add pathway-level interpretation, alternative reporting layers, or refined comparison sets.

This page defines how those extensions should be handled in a structured and reproducible way.

---

## Why resumed runs matter in White Lab practice

For many studies, the first successful DGE run is only the beginning of the downstream analysis lifecycle.

A typical progression may involve:

- an initial gene-level differential analysis
- a resumed run adding GSEA
- a resumed run adding g:Profiler-based enrichment
- separate resumed runs for different pathway collections
- reruns with updated contrasts or design settings
- reruns with adjusted reporting options

This is especially relevant in White Lab practice because pathway interpretation is often a major part of how DGE results are reviewed, summarised, and communicated.

The workflow should therefore be designed from the start to support multiple related downstream runs in a clear and traceable manner.

---

## Core principle

A resumed run is not just a technical convenience.

It is a new analytical event that must still be documented clearly.

Even when Nextflow reuses cached results through `-resume`, the study should still record:

- what the resumed run was intended to add or change
- which launch files were used
- whether the resumed run is analytically equivalent to the prior run or represents a meaningful extension
- which new outputs should be reviewed and retained

In White Lab practice, resumed execution is useful, but it should never replace proper run definition and provenance recording.

---

## What `-resume` means in practice

The `-resume` flag tells Nextflow to reuse cached results from previous steps where the relevant inputs and process definitions match.

This is very useful when:

- a previous run failed partway through
- the same run is being restarted after interruption
- a controlled extension is being made to add new downstream steps
- some outputs are already available and do not need to be recomputed

However, the presence of `-resume` does not by itself explain what kind of run is being performed.

A resumed run could mean:

- a simple restart of the same analysis
- a pathway extension run
- a reporting extension run
- a modified study branch with new settings

That is why White Lab practice should always document the meaning of the resumed run explicitly.

---

## Why pathway analysis often fits naturally into resumed runs

Pathway analysis is a common downstream extension because it often depends on the differential results generated earlier in the workflow.

In practical terms, a study may first need to confirm:

- that the DGE design is sensible
- that the contrast outputs look correct
- that the sample behaviour is broadly as expected

Only then may it be worth adding pathway interpretation layers.

This staged approach is often more efficient and easier to review than trying to activate every optional downstream layer in the very first launch.

It also makes it easier to compare how different pathway configurations affect the results.

---

## Typical White Lab pathway analysis use cases

In White Lab downstream DGE studies, common pathway-related extensions may include:

- Hallmark gene set analysis
- GO Biological Process
- GO Molecular Function
- GO Cellular Component
- curated pathway collections
- study-specific GMT files
- g:Profiler runs using organism-level annotation sets
- g:Profiler runs using a custom background or custom prior token

These may be activated through different parameter combinations and may therefore be better handled as separate named launch definitions rather than as invisible ad hoc adjustments.

---

## Two broad classes of resumed runs

In White Lab practice, it is useful to distinguish between two major kinds of resumed run.

### 1. Technical resume
This is a restart of essentially the same run after interruption or failure.

Examples:
- a run stopped because the session ended
- a run failed due to a temporary infrastructure issue
- a run is restarted after a resource adjustment that does not change the analytical meaning substantially

The goal here is to complete the intended original run.

### 2. Analytical extension or branch
This is a resumed or related run that changes or extends the study outputs in a meaningful way.

Examples:
- adding Hallmark GSEA after an initial DGE-only run
- adding g:Profiler GO analysis
- changing gene set files
- modifying contrasts
- adjusting reporting layers
- disabling or enabling specific output types

The goal here is not merely completion, but extension or refinement of the analysis.

This second class should be treated as a new run identity even if `-resume` is used technically.

---

## White Lab preferred mindset

A good White Lab rule is:

**Use `-resume` for efficiency, but define runs according to analytical meaning.**

That means a resumed run that adds pathway layers should usually be treated and named as a distinct study run, even if it reuses cached earlier steps.

This makes the project easier to understand later.

---

## When to use a resumed run for pathway analysis

A resumed run is often a good choice when:

- the main DGE layer has already been run successfully
- the core inputs such as matrix, metadata, and contrasts are unchanged
- the goal is to add pathway analysis or related downstream interpretation layers
- the new analysis logically builds on the prior run rather than replacing it entirely
- the launch history can be documented clearly

This is often the most efficient and most interpretable way to extend a study.

---

## When not to rely on resume alone

`-resume` should not be used as a substitute for a fresh and clearly defined launch when:

- the matrix strategy has changed
- the sample metadata has changed substantially
- the contrasts structure has changed substantially
- the biological question has changed
- the output set now represents a different branch of analysis rather than a straightforward extension
- the user can no longer explain what cached steps belong to which analytical definition

In such cases, a fresh run definition may be more appropriate even if some technical reuse would have been possible.

---

## White Lab naming principles for resumed runs

Every resumed or extended run should have a name that makes its purpose obvious.

Good file and run names should make clear:

- whether the run is initial or extended
- what pathway layer or other change is being added
- whether the run is a restart, extension, or alternative branch

Examples of sensible launch file names:

- `params.initial.yaml`
- `params.gsea_hallmark.yaml`
- `params.gsea_go_bp.yaml`
- `params.gprofiler_go.yaml`
- `run_initial.sh`
- `run_gsea_hallmark_resume.sh`
- `run_gprofiler_go_resume.sh`

Avoid vague names such as:

- `params2.yaml`
- `resume_test.sh`
- `new_go_run.sh`

The aim is that another lab member should understand the study progression without needing extra explanation.

---

## Common White Lab pathway extension patterns

A downstream study may progress in several sensible ways.

### Pattern 1. Initial DGE first, enrichment second
This is often the clearest route.

Step 1:
- run standard DGE
- review the core differential outputs

Step 2:
- add one or more pathway layers through clearly named resumed runs

This is often the best default White Lab approach.

### Pattern 2. Initial DGE plus one standard pathway layer
If a study has a highly standard pathway analysis requirement, one enrichment layer may be included in the first run.

Additional pathway collections can then be added later if needed.

### Pattern 3. Separate pathway branches for different gene set sources
For example:
- one resumed run for Hallmark GMT files
- one resumed run for GO BP gene sets
- one resumed run for g:Profiler organism-based enrichment

This approach can be especially useful when the goal is to compare complementary pathway outputs rather than merge them all into one run history.

---

## GSEA in White Lab practice

GSEA is useful when the user wants to test differential signal across predefined gene sets supplied to the workflow.

In practice, this often means working with:

- Hallmark collections
- curated pathway GMT files
- GO-derived GMT files
- study-specific collections if justified

A White Lab GSEA-oriented resumed run should record clearly:

- which gene set file was used
- which contrast set was active
- whether the run was initial or resumed
- whether the analysis is intended as exploratory or part of the standard study deliverable

Where multiple GMT files are used in different runs, each should be named clearly in the launch structure and notes.

---

## g:Profiler in White Lab practice

g:Profiler-based enrichment is also a natural extension layer in many White Lab studies.

It may be used with:

- organism-level annotations such as `hsapiens` or `mmusculus`
- prior g:Profiler tokens
- custom background files
- no background file where explicitly justified

A White Lab g:Profiler run should record clearly:

- the organism used if applicable
- whether custom gene sets were used
- whether a custom background was supplied
- whether the run is intended to complement or replace another pathway analysis layer

This is important because different enrichment settings may change the interpretation of the study significantly.

---

## Background gene set policy

Where pathway analysis is used, White Lab should be explicit about the background strategy.

At minimum, the study should record:

- whether the default abundance-filtered background was used
- whether a custom background file was supplied
- whether no background was used
- why that choice was made

This matters because pathway enrichment results are affected by the chosen background universe.

Even when the pipeline has sensible defaults, the study should still make the background choice visible in the launch record.

---

## Recommended White Lab pathway run documentation

Each resumed pathway-oriented run should preserve a short written note describing:

- what this run adds relative to the prior run
- which params file was used
- which gene set source or enrichment mode was used
- whether the same contrasts were reused
- whether the same matrix and metadata were reused
- whether the run is an extension of the main study or an exploratory side branch

This can live in:

- `launch/run_notes.md`
- `logs/run_notes.md`
- `retained_run_metadata/run_manifest_<name>.txt`

or a similar clearly named file.

The exact storage location matters less than clarity and consistency.

---

## Recommended launch structure for resumed pathway runs

A clean live project often benefits from keeping each resumed analysis layer visible through distinct launch files.

For example:

    launch/
    ├── params.initial.yaml
    ├── params.gsea_hallmark.yaml
    ├── params.gsea_go_bp.yaml
    ├── params.gsea_go_mf.yaml
    ├── params.gprofiler_go.yaml
    ├── create.config
    ├── run_initial.sh
    ├── run_gsea_hallmark_resume.sh
    ├── run_gsea_go_bp_resume.sh
    ├── run_gsea_go_mf_resume.sh
    ├── run_gprofiler_go_resume.sh
    └── run_notes.md

This structure makes it much easier to understand the study history and compare outputs later.

---

## Relationship between resumed runs and output directories

Each meaningful run should normally have its own output directory.

For example:

- `out_20260323_103000/`
- `out_20260324_141500/`
- `out_20260325_090000/`

Even when `-resume` is used, the output location should still make it clear which output tree belongs to which run identity.

A resumed run that adds a pathway layer should therefore normally produce a new, clearly named output directory rather than silently writing over the prior interpretation context.

This makes retention and handover much easier later.

---

## How to describe different kinds of resumed runs

It is useful to be consistent in study notes.

### Resume after interruption
Describe this as:
- restart of the same intended run
- no intended analytical change unless otherwise stated

### Resume with pathway layer added
Describe this as:
- analytical extension of the prior DGE run
- same core DGE inputs, added pathway interpretation layer

### Resume with modified contrasts
Describe this as:
- related but analytically distinct run
- new or altered comparison structure

### Resume with altered reporting settings
Describe this as:
- reporting branch or output-style branch
- analytical core may be unchanged, but deliverables differ

This language helps distinguish technical continuity from analytical meaning.

---

## White Lab preferred workflow for pathway-oriented study progression

A robust progression often looks like this:

### 1. Initial DGE run
Launch the standard differential analysis with the agreed matrix, metadata, contrasts, and annotation setup.

### 2. Review core outputs
Check:
- sample behaviour
- contrast sanity
- result plausibility
- whether the design is behaving as expected

### 3. Add pathway extensions deliberately
Create clearly named resumed or related runs for:
- Hallmark GSEA
- GO BP
- GO MF
- GO CC
- g:Profiler or other configured enrichment modes

### 4. Compare pathway outputs across runs
Interpret pathway results in the context of:
- the same underlying DGE study
- the specific gene set collection used
- the background logic
- the reporting outputs produced

### 5. Retain the key pathway outputs clearly
Retain enough information that it remains obvious:
- which pathway collections were tested
- in which run
- using which settings

This progression is usually more interpretable than trying to do everything in one opaque launch.

---

## Common mistakes to avoid

### Using `-resume` without recording what changed
This is one of the most common causes of confusion later.

### Reusing generic params file names
A study quickly becomes unreadable when all pathway runs point to files like `params_new.yaml`.

### Mixing multiple pathway changes into one undocumented rerun
For example changing gene sets, reporting options, and contrasts all at once with no note.

### Forgetting the background choice
Pathway enrichment interpretation depends on it.

### Treating all enrichment outputs as equivalent
Hallmark, GO BP, GO MF, and g:Profiler outputs are related but not interchangeable.

### Overwriting output meaning
Even if a run resumes efficiently, the new result set should still have its own clear identity.

---

## Relationship to interpretation

Pathway analysis is an interpretation layer, not a replacement for core DGE review.

A pathway result should always be read in the context of:

- the underlying contrast
- the quality of the differential analysis
- the sample behaviour
- the gene set collection used
- the background choice
- any study-specific biological hypotheses

This is why White Lab should treat pathway analysis as an extension of a well-defined DGE study rather than as an isolated output.

---

## White Lab retention expectation for pathway runs

For each meaningful pathway-oriented run, the study should retain enough material to answer:

- what was added in this run
- which gene sets or enrichment method were used
- which contrasts were active
- which output directory contains the relevant results
- how this run relates to the original DGE run

This should later feed naturally into the retained downstream package described in `retention-and-handover.md`.

---

## Summary

In White Lab downstream DGE studies, resumed runs are often the natural way to extend a project beyond the initial differential expression layer.

They are especially useful for adding pathway analysis layers such as:

- Hallmark GSEA
- GO BP
- GO MF
- GO CC
- g:Profiler-based enrichment

However, a resumed run should always be treated as a clearly defined analytical event, not just a technical cache reuse.

The key White Lab rule is:

- use `-resume` for efficiency
- define runs according to analytical meaning
- name them clearly
- document what changed
- retain their outputs distinctly

The next document to read is:

[`outputs-guide.md`](outputs-guide.md)
