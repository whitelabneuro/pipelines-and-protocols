# DGE QC and interpretation

This document explains how White Lab downstream bulk RNA-seq differential gene expression outputs should be reviewed, quality checked, and interpreted after a run completes.

A successful pipeline execution is not the same thing as a successful analysis.

Even when `nf-core/differentialabundance` completes without error, the resulting outputs still need to be reviewed carefully to determine:

- whether the study behaved as expected
- whether the comparison was modelled sensibly
- whether the outputs are biologically plausible
- whether the key results are robust enough to take forward
- whether any warnings, caveats, or follow-up checks are needed

This page focuses on the quality-control and interpretation mindset that should be applied after downstream DGE runs in White Lab practice.

---

## Why downstream QC still matters

Upstream preprocessing already provides sequencing and mapping QC, but that does not remove the need for downstream review.

At the DGE stage, users still need to ask questions such as:

- do the samples cluster as expected for the comparison being made?
- do replicates behave sensibly?
- is there evidence of strong batch structure?
- do the contrasts produce plausible effect sizes and significance patterns?
- are the top results biologically credible?
- are the pathway outputs consistent with the gene-level results?

These are downstream analytical questions, not just upstream technical QC checks.

---

## Core principle

A White Lab downstream analysis should not be considered complete until both of the following are true:

### 1. The run completed successfully
The pipeline produced the expected outputs.

### 2. The outputs have been reviewed critically
The study has been assessed for sample behaviour, contrast behaviour, result plausibility, and interpretability.

This distinction is extremely important.

A technically successful run can still represent a poorly understood or poorly specified analysis if the outputs are not reviewed properly.

---

## Downstream QC is a layered process

A useful way to think about downstream QC is to review the study in layers.

### Layer 1. Run sanity
Did the pipeline complete and produce the expected output types?

### Layer 2. Sample-level behaviour
Do the samples behave sensibly in exploratory outputs?

### Layer 3. Contrast-level behaviour
Do the differential results look statistically and biologically plausible?

### Layer 4. Gene-level interpretation
Do the main significant features make sense in context?

### Layer 5. Pathway-level interpretation
If enrichment was run, do the pathway results align with the underlying DGE signal?

### Layer 6. Study-level conclusion
Is the analysis credible enough to retain, share, and build upon?

This layered approach helps prevent users from jumping too quickly to pathway summaries or headline genes before the foundational checks have been done.

---

## Step 1. Confirm that the run completed sensibly

Before interpreting any biological result, confirm the basic run state.

Check:

- that the pipeline completed successfully
- that the expected output directories are present
- that the main differential result tables exist
- that the HTML report is available
- that the expected plots were generated
- that pathway outputs are present if they were intended
- that the Shiny app or R Markdown bundle exists if expected

If these outputs are missing or incomplete, the run may need troubleshooting before interpretation goes further.

---

## Step 2. Review exploratory sample-level outputs

Sample-level behaviour is one of the most important parts of downstream QC.

The first analytical question is not usually “which genes are significant?”

It is usually:

**Do the samples behave in a way that makes this comparison interpretable?**

This means checking whether the samples cluster or separate in a way that is broadly consistent with the known study design.

---

## What to look for in sample-level outputs

Exploratory outputs should help you assess:

- whether biological groups show expected separation
- whether replicates cluster reasonably well
- whether any samples appear as clear outliers
- whether batch effects may be prominent
- whether a supposed main effect is weak, noisy, or absent
- whether any unexpected structure dominates the dataset

A perfect separation is not required, but the study should at least appear coherent and interpretable.

---

## How to think about outliers

An unusual sample does not automatically mean the analysis is wrong.

However, an apparent outlier should trigger careful questions such as:

- is the sample identity correct?
- does the sample have an upstream QC issue?
- is there a metadata problem?
- is the sample biologically unusual but still valid?
- is the outlier behaviour affecting the contrast strongly?

In White Lab practice, outliers should not be removed casually. Any exclusion should be justified, documented, and reflected clearly in the design logic.

---

## How to think about batch structure

Visible batch structure does not automatically invalidate a study.

The important questions are:

- is the batch effect known and already modelled?
- does the batch structure overwhelm the biological effect of interest?
- is the metadata sufficient to support sensible blocking?
- should interpretation be more cautious because of the batch pattern?

A strong batch pattern may be manageable if it is understood and modelled appropriately, but it should never be ignored.

---

## Step 3. Review contrast-level outputs

Once sample-level behaviour appears broadly sensible, the next stage is to review the differential outputs for each contrast.

At this stage, the aim is to determine whether the statistical results look coherent and whether the contrast appears to be answering the intended biological question.

---

## What to look for in differential plots

Differential plots such as MA-style or volcano-style views can quickly reveal whether a contrast looks plausible.

Questions to ask include:

- is the distribution of fold changes broadly sensible?
- is there evidence of a real signal or almost no signal?
- is the result dominated by a small number of extreme points?
- is the significance structure plausible given the study?
- does the contrast appear excessively noisy?
- is there any obvious asymmetry or unusual pattern that needs explanation?

These plots are not the final interpretation, but they are extremely useful for deciding whether the contrast behaves in a believable way.

---

## Interpreting the number of significant genes

Users often focus heavily on the number of significant genes.

This can be useful, but it should not be treated as the only quality metric.

A very large number of significant genes may reflect:

- a strong biological effect
- large sample size
- strong technical or batch structure
- a broad stress response or experimental perturbation
- a design issue if the result is unexpected

A very small number of significant genes may reflect:

- a subtle biological effect
- insufficient power
- noisy samples
- weak perturbation
- an over-complicated design
- a problem with the comparison definition

In White Lab practice, the number of significant genes should always be interpreted in the context of study design, effect size, and sample behaviour.

---

## Step 4. Review the result tables directly

The core differential result tables should always be reviewed directly.

Do not rely only on summary plots or pathway outputs.

The result tables allow you to examine:

- feature identity
- log2 fold change
- p-value
- adjusted p-value
- ranking of significant features
- consistency of the most strongly changing genes with the expected biology

This is where much of the serious interpretation begins.

---

## Questions to ask when reading the result tables

For each important contrast, ask:

- do the top genes make biological sense?
- are the direction and magnitude of effect plausible?
- are known positive controls behaving as expected, if any exist?
- are there obvious artefacts or suspicious features?
- do the most significant genes belong to coherent biological themes?
- are there signs that the contrast may be capturing something other than the intended effect?

These questions often reveal much more than the mere count of significant genes.

---

## Log2 fold change interpretation

The log2 fold change direction depends on the contrast definition.

A positive value means the feature is higher in the `target` group than in the `reference` group.

A negative value means the feature is higher in the `reference` group than in the `target` group.

This should always be checked carefully before making biological claims.

Misreading the contrast direction is one of the simplest and most avoidable interpretation errors.

---

## Adjusted p-value interpretation

The adjusted p-value is usually the main measure used to assess statistical significance in the result tables.

However, statistical significance alone is not enough.

A feature may be statistically significant but biologically minor.

Conversely, a feature with a meaningful effect size but borderline adjusted p-value may still be worth noting in context, especially in small or noisy studies.

In White Lab practice, significance and effect size should be interpreted together.

---

## Significance thresholds should be explicit

When reviewing and discussing results, users should be explicit about the thresholds being applied.

For example:

- adjusted p-value threshold
- log2 fold change threshold if used
- abundance or filtering context if relevant

This is important because different thresholds can substantially change the apparent size and interpretation of a result set.

A result is more interpretable when the filtering logic is transparent.

---

## Step 5. Compare findings against study expectations

A useful downstream QC habit is to compare the outputs against what you expected before running the analysis.

This does not mean forcing the data to confirm prior beliefs.

It means asking whether the result is:

- broadly consistent with the known experimental perturbation
- unexpectedly weak
- unexpectedly strong
- unexpectedly dominated by unrelated biology
- suggestive of sample mix-up or metadata issues
- pointing to a genuinely surprising biological signal

This kind of reflective check is often one of the most informative parts of the interpretation process.

---

## Step 6. Review pathway outputs only after core DGE review

If pathway or enrichment analysis was enabled, it should be reviewed only after the core DGE layer appears sensible.

This order matters because pathway outputs are downstream summaries of the gene-level signal.

If the underlying contrast is poorly specified or biologically unclear, the pathway results may look polished but still be misleading.

---

## Questions to ask about pathway outputs

When reviewing pathway results, ask:

- do the pathway themes align with the major gene-level results?
- are the top enrichments biologically coherent?
- do different pathway methods tell a broadly similar story?
- are the results dominated by generic stress or housekeeping signals?
- was the background choice sensible and documented?
- are the pathway outputs consistent with what is known about the study system?

Pathway outputs are often helpful, but they are not immune to poor upstream choices or noisy input signal.

---

## Interpretation should include uncertainty

White Lab users should not feel pressured to turn every run into a strong narrative immediately.

A good interpretation often includes uncertainty, for example:

- the signal is present but weaker than expected
- the study shows separation, but batch effects appear important
- the contrast works, but the pathway outputs are not yet compelling
- the top genes look plausible, but more validation is needed
- the analysis is technically clean, but biological interpretation remains preliminary

This kind of cautious language is a strength, not a weakness.

---

## Common downstream QC and interpretation mistakes

### Jumping straight to pathway results
This can lead to over-interpretation before the core DGE signal has been checked properly.

### Equating significance count with study quality
A larger number of significant genes does not automatically mean a better or more meaningful study.

### Ignoring sample-level structure
A contrast may look statistically interesting even when the underlying sample behaviour is problematic.

### Misreading contrast direction
This can invert the biological interpretation completely.

### Ignoring effect size
Features should not be prioritised on adjusted p-value alone.

### Treating the HTML report as sufficient on its own
The report is a useful interface, but the tables still need to be examined directly.

### Removing samples informally
Any exclusion should be justified, documented, and reflected clearly in the design logic.

---

## White Lab recommended review sequence

A robust review sequence usually looks like this:

### 1. Check run completion
Confirm that the expected output files exist.

### 2. Open the HTML report
Use it as a first integrated overview.

### 3. Examine exploratory sample-level outputs
Review clustering, separation, replicate behaviour, and possible outliers.

### 4. Examine differential plots
Look for plausible contrast behaviour and effect size structure.

### 5. Read the core result tables directly
Inspect top genes, effect directions, and adjusted p-values.

### 6. Review pathway outputs if enabled
Interpret them in the context of the validated DGE layer.

### 7. Record key conclusions and caveats
Write down what seems robust, what seems uncertain, and what may need follow-up.

This sequence helps ensure that interpretation remains grounded.

---

## White Lab recommended output from the review process

A completed downstream review should ideally produce a short written summary of:

- whether the run completed successfully
- whether sample behaviour looked acceptable
- whether the main contrasts appeared interpretable
- the approximate scale of the DGE signal
- the main biological themes observed
- any caveats, warnings, or surprises
- whether the run is ready for retention, sharing, or follow-up analysis

This can be a short markdown file, lab note, or run summary saved with the study.

That summary is often extremely valuable later.

---

## Signs that a run may need further work before retention

A study may need more checking or refinement if:

- sample-level behaviour looks inconsistent or confusing
- the top genes appear implausible for the study context
- the contrast direction was initially unclear
- pathway outputs dominate interpretation but the DGE layer is weak
- there are missing or incomplete expected outputs
- metadata or contrast definitions may have been incorrect
- the run answer seems to differ strongly from expectation without a clear explanation

In such cases, it is better to pause and investigate than to move straight into retention and reuse.

---

## Relationship to later downstream use

Good QC and interpretation review should make it easier to decide whether a run is ready for:

- long-term retention
- collaborator sharing
- pathway extension
- figure generation
- custom reporting
- integration into later transcriptomic workflows

The purpose of review is not only to catch problems, but also to establish confidence in what the run can now support.

---

## Summary

A White Lab downstream DGE run should be reviewed critically even after the pipeline completes successfully.

The key questions are:

- do the samples behave sensibly?
- do the contrasts look plausible?
- do the top genes make sense?
- do the effect sizes and significance patterns support interpretation?
- do the pathway results align with the core DGE signal?
- what caveats or uncertainties remain?

Good downstream QC is not just about detecting failure. It is about deciding whether the study is understood well enough to retain, communicate, and build upon.

The next document to read is:

[`retention-and-handover.md`](retention-and-handover.md)
