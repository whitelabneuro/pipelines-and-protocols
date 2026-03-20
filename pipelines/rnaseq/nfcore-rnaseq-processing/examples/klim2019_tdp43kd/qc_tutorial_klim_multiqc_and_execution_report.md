# Klim worked example QC tutorial: MultiQC and execution report

This tutorial walks through QC interpretation for the White Lab Klim worked example using the actual uploaded reports from the completed `nfcore-rnaseq-processing` run.

It is intended to show a new user how to move from the abstract QC principles in the general tutorial to a real worked example.

## Dataset context

This example corresponds to:

- Klim et al. 2019
- human iPSC-derived motor neuron RNA-seq
- TDP-43 knockdown setting
- White Lab worked example dataset ID: `klim2019_tdp43kd`
- CREATE project ID: `Klim_TDP_LOF`

## The two key reports reviewed here

The worked example uses:

- the uploaded MultiQC report
- the uploaded Nextflow execution report

These answer two different questions:

- **execution report**: did the workflow finish cleanly and produce interpretable output?
- **MultiQC**: do the samples look technically sound and broadly suitable for downstream analysis?

---

# 1. Step one — confirm the run completed cleanly

The execution report is the first thing to inspect.

In this Klim worked example, the final run completed successfully. The report shows:

- workflow execution completed successfully
- run time from **18-Mar-2026 13:33:30** to **18-Mar-2026 16:14:08**
- total duration **2 h 40 m 38 s**
- **680 tasks succeeded**
- **0 tasks cached**
- **0 ignored**
- **0 failed** in the final completed run
- Nextflow command used `nf-core/rnaseq` **3.23.0**, `-profile create`, `--aligner star_salmon`, and `--save_reference` :contentReference[oaicite:5]{index=5} :contentReference[oaicite:6]{index=6}

## Interpretation

This is a good starting position.

Why this matters:

- the workflow did not end in a partial or ambiguous state
- the downstream MultiQC summary can be interpreted as the output of a completed run
- the retained outputs are suitable to treat as a coherent processed dataset

This does **not** prove the samples are good, but it means the workflow itself completed in a trustworthy way.

## Additional execution observations

The execution report also records approximately **206.9 CPU-hours** and indicates that a small fraction of work was associated with failed attempts during execution history, even though the final run completed with zero failed tasks. This is a useful reminder that HPC retries and infrastructure wrinkles may occur without invalidating the final completed run. :contentReference[oaicite:7]{index=7}

For training purposes, this is a good example of the distinction between:

- **temporary instability during run development**
- **final successful workflow completion**

---

# 2. Step two — confirm what MultiQC is summarising

The uploaded MultiQC report is the nf-core/rnaseq MultiQC output for this run. :contentReference[oaicite:8]{index=8}

The report contains, among other things:

- STAR alignment summary columns
- FastQC-derived columns including GC and sequence length
- duplication-related columns
- strandedness checks
- RSeQC infer experiment panels :contentReference[oaicite:9]{index=9} :contentReference[oaicite:10]{index=10}

This means the report is appropriate for a first-pass technical review of:

- read-level quality
- trimming consequences
- mapping performance
- library orientation / strandedness consistency
- broad sample comparability

---

# 3. Step three — what this report tells us immediately about the Klim dataset

From the uploaded MultiQC summary structure, several immediate observations are possible.

## 3.1 Read length

The FastQC raw summary columns in this report include average and median sequence length, and the displayed maximum for average read length is **76.0 bp**. :contentReference[oaicite:11]{index=11}

### Interpretation

This is fully consistent with the working assumption that this dataset is a short-read paired-end RNA-seq run of approximately **75–76 bp** reads.

For this worked example, that matters because:

- it helps explain why the dataset is suitable for gene-level expression analysis
- it sets realistic expectations for junction and isoform resolution
- it reminds users that read length affects what later splicing workflows can recover

This is a good training point:

**read length is not just metadata — it changes what downstream biology you can ask of the data.**

## 3.2 Alignment performance

The STAR summary columns in the report include:

- aligned reads
- uniquely aligned reads
- multimapped reads
- average mapped length :contentReference[oaicite:12]{index=12}

The displayed maxima in this report show:

- aligned reads up to **99.56%**
- uniquely aligned reads up to **95.57%** :contentReference[oaicite:13]{index=13}

### Interpretation

These maxima are reassuring because they show that at least some samples in the Klim dataset align extremely well to the reference.

What this does **not** mean:

- it does not prove every sample is equally strong
- it does not remove the need to check sample-to-sample spread
- it does not by itself guarantee suitability for every downstream workflow

But as a first impression, this is a technically encouraging run.

For trainees, the important lesson is:

**very high alignment and unique alignment are reassuring, but always ask whether one or two samples are dragging behind the rest.**

## 3.3 GC content and duplication are explicitly part of the report

The STAR/FastQC summary table also includes:

- GC content
- duplicate read percentage
- total sequences :contentReference[oaicite:14]{index=14}

### Interpretation

That means the Klim run can and should be reviewed for:

- major GC outliers
- extreme duplication outliers
- strong depth imbalance between samples

Even when exact numbers are not the first thing you quote, these are essential parts of the review.

For a new user, the key point is:

- **GC** helps you check library composition consistency
- **duplication** helps you think about complexity and over-sequencing
- **total sequences** helps you judge depth balance across samples

---

# 4. Step four — strandedness is a major interpretive checkpoint in this example

The MultiQC report contains a **Strandedness Checks** section and an **Infer experiment** section based on RSeQC. The report itself explains that:

- strandedness used for analysis may be user-supplied or inferred by Salmon
- it is then checked against genomic alignments using RSeQC
- a pass indicates agreement
- a fail indicates mismatch or undetermined strandedness
- undetermined strandedness can signal QC issues including possible genomic DNA contamination :contentReference[oaicite:15]{index=15}

## Why this matters in the Klim example

In this White Lab worked example, the samplesheet used `auto` strandedness during processing. That makes this section especially important, because it tells the reviewer whether automated inference and alignment-based verification agree.

## Training interpretation

A new user should learn the following rule here:

- do **not** trust `auto` strandedness blindly
- always inspect the strandedness check table
- if a sample fails, that is not a cosmetic problem — it can affect gene assignment and downstream interpretation

## What to do when reviewing the Klim report

For this Klim dataset, a reviewer should explicitly note:

- whether all samples pass strandedness checks
- whether any samples are marked fail or undetermined
- whether any failures cluster within one biological condition

That note should then travel forward into the run summary and downstream pipeline handoff.

---

# 5. Step five — what to look for in the Klim MultiQC review

Even with good top-line execution and alignment signals, a proper worked-example review should still ask:

## 5.1 Are all samples present and sensibly grouped?

In this dataset, the expected sample naming scheme includes groups such as:

- `CONTROL_NONE`
- `CONTROL_SCRAMBLE`
- `CONTROL_FLUORESCENT`
- `TDP43KD`

That is good because it makes within-group and between-group comparison visually manageable.

A reviewer should still confirm:

- expected replicate counts are present
- no sample is duplicated under a strange name
- no sample is missing from the report

## 5.2 Are sequencing depths broadly balanced?

Because the report includes total sequence counts, a reviewer should check whether any sample has markedly fewer reads than the rest. :contentReference[oaicite:16]{index=16}

In a dataset intended for later DGE and potentially splicing-aware work, a low-depth outlier matters more than it might in a quick pilot study.

## 5.3 Does any sample look like a technical outlier across multiple metrics?

The most important practical QC question is not “is every metric perfect?”

It is:

**does one sample repeatedly look worse than the rest?**

For Klim, that means checking whether the same sample is repeatedly unusual in:

- total reads
- duplication
- GC
- alignment
- strandedness

If the same sample looks odd in several places, it deserves explicit flagging even if the study overall still looks usable.

---

# 6. Step six — what this Klim example suggests about downstream suitability

Based on the uploaded execution report and the structure of the MultiQC summary, the Klim example looks like a technically credible worked example for White Lab primary processing.

## Strong points visible from the reports

- completed workflow execution
- zero final failed tasks
- clear provenance
- STAR alignment metrics available
- FastQC-derived metrics available
- strandedness verification available
- reference-saving enabled for retained downstream reuse :contentReference[oaicite:17]{index=17} :contentReference[oaicite:18]{index=18}

## Why this is useful for future White Lab workflows

This makes the Klim run a strong anchor example for:

- gene-level differential expression workflow development
- transcript-level matrix handling
- alignment-aware downstream work
- training new users in QC review before interpretation begins

## Important caution

The execution report and top-level MultiQC structure are enough to say the run is a sound worked example.

They are **not** by themselves the same thing as a final biological sign-off.

A full sign-off should still include:

- checking for sample-specific outliers in the MultiQC tables and plots
- explicitly recording strandedness outcomes
- explicitly recording whether any sample should be treated cautiously in downstream work

---

# 7. Practical training summary for a new user reading the Klim reports

If you are new to the White Lab workflow, this is the thought process you should learn from the Klim example:

## First ask:
Did the workflow finish cleanly?

For Klim, yes. The final run completed successfully with 680 succeeded tasks and no final failures. :contentReference[oaicite:19]{index=19}

## Then ask:
Do the summary QC panels contain the expected information?

For Klim, yes. The uploaded MultiQC includes alignment, FastQC, duplication, and strandedness-related sections. :contentReference[oaicite:20]{index=20} :contentReference[oaicite:21]{index=21}

## Then ask:
Do the headline metrics look technically plausible?

For Klim, yes. The report structure shows short reads around 76 bp and very strong best-sample alignment performance, with aligned reads up to 99.56% and uniquely aligned reads up to 95.57%. :contentReference[oaicite:22]{index=22}

## Then ask:
What still needs manual judgment?

Always:

- sample balance
- outlier identification
- strandedness consistency
- downstream suitability for DGE versus splicing

That final judgment is the reviewer’s responsibility, not the pipeline’s.

---

# 8. Final take-home message from the Klim worked example

The Klim example is useful not because the report looks pretty, but because it shows the full White Lab logic in practice:

1. confirm the run finished properly
2. inspect the aggregated QC carefully
3. interpret metrics as patterns, not isolated numbers
4. document caveats before moving into downstream analysis

That habit is what turns a pipeline run into a reproducible study record.
