# RNA-seq QC tutorial: reading MultiQC and the Nextflow execution report

This tutorial explains how to review the two most important first-pass QC outputs from a completed White Lab `nfcore-rnaseq-processing` run:

- the **MultiQC report**
- the **Nextflow execution report**

The aim is to help a new user move from “the pipeline ran” to “I understand whether my dataset is technically sound, what the main risks are, and whether the outputs are suitable for downstream analysis”.

This tutorial is intentionally detailed. It is intended as a training aid rather than a short checklist.

---

# 1. Why these two reports matter

The first thing to understand is that these two reports answer different questions.

## MultiQC answers:

- Are the sequencing reads broadly good quality?
- Did trimming behave as expected?
- Do samples look internally consistent?
- Do mapping and alignment metrics support the intended study design?
- Are there any outlier samples that may need caution or exclusion?
- Does the library appear stranded or unstranded as expected?
- Is there evidence of technical problems such as poor complexity, contamination, unusual duplication, or unexpectedly weak alignment?

## The execution report answers:

- Did the workflow actually complete successfully?
- Were there retries, failures, or suspicious bottlenecks?
- How long did the run take?
- How much compute did it use?
- Did the run finish cleanly enough that the MultiQC output can be trusted as the result of a stable completed run?

A good habit is:

1. open the execution report first
2. confirm the run finished successfully
3. then open MultiQC and interpret the biological and technical QC

---

# 2. The correct order for reviewing QC

A sensible White Lab review order is:

1. **Execution status**
2. **Sample identity and sample count**
3. **Raw read QC**
4. **Trimming behaviour**
5. **Alignment performance**
6. **Library strandedness**
7. **Read distribution across genomic features**
8. **Duplication / complexity**
9. **Cross-sample consistency**
10. **Decision on downstream suitability**

Do not jump straight to one favourite metric such as alignment rate. RNA-seq QC is about patterns across metrics, not single numbers in isolation.

---

# 3. Part A — how to read the execution report

The execution report is not primarily a biological QC document. It is a workflow health document.

It helps answer a simple but important question:

**Did the pipeline complete in a stable and interpretable way?**

## 3.1 Confirm overall workflow completion

The first thing to look for is a clear success state.

You want to see that the workflow execution completed successfully, with no final failed tasks.

If the execution report shows final failure, everything downstream becomes harder to interpret because:

- some samples may be incomplete
- some modules may be missing
- MultiQC may summarize only partial output
- output directories may contain mixed successful and failed states

A run that “mostly completed” is not the same as a trustworthy completed run.

## 3.2 Check task success, failure, caching, and retries

A clean run should show:

- most or all tasks succeeded
- zero final failed tasks
- retries, if present, should be understood

Important nuance:

- **a retry does not automatically mean the run is bad**
- some transient HPC or filesystem issues can trigger retries
- however, repeated retries in one module may indicate fragility in the workflow or environment

Things to ask:

- Did failures occur in random places, suggesting infrastructure instability?
- Did repeated failures cluster in one module, suggesting tool/config/data issues?
- Was the final result still complete and consistent?

## 3.3 Review runtime

Look at:

- workflow start and completion time
- total duration

This matters because unusual runtime can be informative.

Examples:

- a run that finishes far faster than expected may have skipped work or processed fewer samples than intended
- a run that takes far longer than expected may indicate excessive retries, queue delays, very large inputs, or resource mis-sizing

Runtime on its own is not a QC metric, but it is part of run interpretation.

## 3.4 Review compute/resource summary

Look at:

- CPU hours
- memory usage summaries if available
- task-level resource hotspots

Why this matters:

- very memory-hungry steps may need tuning in future runs
- unexpectedly heavy alignment or reference-generation steps may reveal scaling issues
- if one step repeatedly dominates runtime, that is useful for future workflow refinement

This is particularly important for a lab workflow intended to scale across projects.

## 3.5 Review the task breakdown

The task section helps you understand:

- which modules ran
- how many times they ran
- which steps dominate runtime
- whether any sample-specific steps behaved oddly

For example:

- if one sample’s alignment step runs much longer than the rest, that can point to sample-specific complexity or corruption
- if trimming runs are unusually imbalanced, that may indicate varying adapter burden or read quality between samples

## 3.6 Why the execution report matters even when MultiQC looks fine

A polished MultiQC does not guarantee a healthy run.

For example:

- a partially failed run can still generate a visually plausible MultiQC
- a run with heavy retries may complete but still expose environmental fragility
- missing modules or incomplete outputs may not be obvious unless you confirm run completion separately

So the execution report is the gatekeeper for trusting downstream QC.

---

# 4. Part B — how to read MultiQC

MultiQC is where technical sample QC is aggregated across the run.

The key idea is:

**do not treat MultiQC as a place to hunt for a single “pass/fail” number.**

Instead, ask:

- Do samples cluster around similar values?
- Are there obvious outliers?
- Are patterns biologically plausible?
- Do multiple metrics point to the same concern?

---

# 5. Start with sample overview and naming sanity

Before interpreting any metric, confirm:

- the expected number of samples is present
- sample names are correct and readable
- grouping is sensible
- no sample appears duplicated under unexpected names

Why this matters:

a surprising amount of downstream confusion starts with simple sample-sheet problems, not biology.

Check:

- are all expected biological groups present?
- do replicate counts make sense?
- are sample labels interpretable without cross-referencing five files?

If the report is already confusing at the level of sample identity, fix that first.

---

# 6. Raw read QC: what to look for

Raw FastQC-derived panels are usually your first real look at input data quality.

Important modules often include:

- total sequences / read counts
- per-base sequence quality
- GC content
- sequence length
- duplication
- adapter content
- overrepresented sequences

## 6.1 Total reads

Ask:

- do samples have roughly comparable sequencing depth?
- are there major outliers?
- are depth differences explainable by study design?

Why it matters:

large depth imbalances can affect:

- detection power
- dispersion estimates
- apparent sensitivity for low-expression genes
- interpretation of sample-to-sample consistency

One low-depth sample is not automatically unusable, but it should be flagged early.

## 6.2 Per-base quality

This gives a sense of whether read qualities remain high across the read length.

Questions:

- do qualities remain strong across most positions?
- does quality drop sharply at read ends?
- is the pattern consistent across samples?

Interpretation:

- mild end-of-read decline is common
- severe collapse toward the ends may justify trimming or caution
- if one sample is much worse than the others, suspect sample- or lane-specific problems

## 6.3 GC content

GC content should usually be fairly consistent within a given experiment of the same library type and organism.

Ask:

- do samples show a similar GC distribution?
- is any sample shifted relative to the rest?
- is the distribution biologically plausible for the sample type?

Possible interpretations of unusual GC:

- contamination
- strong rRNA or non-target content
- poor library composition
- genuine biology in unusual assays, though this should be justified

GC alone rarely decides sample exclusion, but a GC outlier is a useful warning sign.

## 6.4 Sequence length

This seems simple, but it matters.

Questions:

- is the read length what you think it should be?
- is it consistent across all samples?
- is there evidence of aggressive trimming producing inconsistent lengths?

Why it matters:

- confirms consistency with sequencing expectations
- helps interpret mapping and trimming behaviour
- can reveal mixed runs or upstream preprocessing differences

## 6.5 Duplication

Duplication is often misunderstood.

High duplication is not automatically “bad”, but it must be interpreted in context.

Possible causes include:

- low library complexity
- heavy PCR duplication
- extremely abundant transcripts
- very deep sequencing of a limited-complexity library

Ask:

- are duplication levels broadly similar across replicates?
- is one sample much higher than others?
- is high duplication accompanied by other warning signs such as low complexity or poor mapping?

Interpret duplication as part of a pattern, not as a standalone exclusion criterion.

## 6.6 Adapter content and overrepresented sequences

These panels help you decide whether trimming was necessary and whether contamination remains.

Questions:

- is adapter content widespread or sample-specific?
- does trimming remove the issue?
- are overrepresented sequences biologically interpretable, or suspicious?

Persistent adapter or odd overrepresented content can indicate:

- incomplete trimming
- unusual library artefacts
- contamination
- bias toward specific fragments

---

# 7. Trimming metrics: how to think about Trim Galore results

Trimming is not a goal in itself. It is a corrective step.

The questions are:

- how much trimming happened?
- was that expected?
- did trimming improve the data without destroying too much read material?

## 7.1 Percent trimmed

A little trimming is normal.

Very high trimming may suggest:

- strong adapter contamination
- poor end quality
- short inserts causing read-through into adapters
- library-prep issues

Ask:

- are all samples similar?
- is one replicate much more trimmed than the others?
- does heavy trimming correspond to lower mapping or other QC problems?

## 7.2 Read length after trimming

If trimming creates a broad spread of effective read lengths, consider:

- whether this was expected from library properties
- whether some samples became much shorter than others
- whether downstream alignment or quantification might be affected

## 7.3 Trimming should be judged by outcome

The real question is not “was much trimmed?”

It is:

- did trimming improve the data?
- are post-trim quality and mapping sensible?
- was too much useful sequence lost?

---

# 8. Alignment metrics: one of the most important QC layers

STAR and related alignment summaries are central to RNA-seq interpretation.

Important metrics often include:

- total aligned reads
- uniquely aligned reads
- multimapped reads
- average mapped length
- mismatch or splice-related statistics
- unmapped categories where available

## 8.1 Overall alignment rate

This is often the first number people look at, but it should not be the only one.

High alignment is generally reassuring, but ask:

- is it consistent across replicates?
- do lower-alignment samples also show other issues?
- is alignment appropriate for the organism, reference, and library design?

Lower alignment can reflect:

- contamination
- poor library quality
- reference mismatch
- degraded RNA
- genomic DNA carryover
- unexpected sample identity

## 8.2 Uniquely mapped reads

This is often more informative than total mapped reads.

Why it matters:

- a high total mapping rate with weak unique mapping can still signal ambiguity
- repetitive or low-complexity content may inflate non-unique mapping
- downstream quantification confidence is helped by strong unique mapping

Ask:

- are unique mapping rates consistent across samples?
- does one sample show unusually weak unique mapping compared with the group?

## 8.3 Multimapping

Some multimapping is expected, especially in transcriptomes with repetitive or homologous regions.

Concern rises when:

- multimapping is unusually high for one or a few samples
- high multimapping co-occurs with poor unique mapping, odd GC, or high duplication

## 8.4 Average mapped read length

This helps connect trimming and alignment.

If mapped lengths are much shorter than expected, think about:

- aggressive trimming
- degraded input
- poor-quality tails
- library artefacts

---

# 9. Strandedness: one of the most important interpretive checks

Strandedness errors can seriously damage downstream interpretation.

If library strandedness is wrong, you can get:

- incorrect assignment of reads to overlapping genes
- distorted counts
- misleading antisense signal
- noisy results in gene-dense loci

MultiQC commonly presents two helpful layers:

- inferred strandedness statistics
- a pass/fail strandedness check comparing expected or inferred settings with alignment-based verification

## 9.1 Why strandedness matters so much

A wrong strandedness setting can make technically decent data look biologically messy.

This is especially important when users set strandedness to `auto` and assume the problem is solved. Automated inference is useful, but it still needs validation.

## 9.2 How to interpret strandedness checks

You generally want:

- a clear, internally consistent strandedness pattern
- agreement between the analysis setting and alignment-based verification

A fail or undetermined result can suggest:

- incorrect library-strand specification
- weak signal for inference
- mixed library behaviour
- contamination, including possible genomic DNA contribution

## 9.3 What to do with strandedness concerns

If strandedness is unclear:

- do not rush into downstream DGE
- inspect the strandedness panel carefully
- compare replicates
- consider whether metadata about library prep supports the observed signal
- document the uncertainty explicitly

---

# 10. Read distribution across genomic features

RSeQC-style panels are extremely informative.

They help answer whether reads are going where you expect them to go.

Relevant categories often include:

- exonic
- intronic
- intergenic
- UTR-related distributions
- gene-body coverage
- junction saturation

## 10.1 Exonic vs intronic vs intergenic signal

For standard polyA-selected bulk RNA-seq, you often expect strong exonic signal.

If intronic or intergenic fractions are unexpectedly high, possible causes include:

- genomic DNA contamination
- pre-mRNA enrichment
- unusual library prep
- degraded or poor-quality RNA
- mismatched expectations about assay type

Interpret this in light of:

- known library chemistry
- sample type
- experimental design

## 10.2 Junction saturation

This is especially useful for splice-aware workflows.

It asks whether sequencing depth is sufficiently sampling splice junctions.

Poor saturation may mean:

- under-sequencing
- weak support for more ambitious splicing analyses
- greater risk of missing lower-abundance splice events

For White Lab use, this matters a great deal when deciding whether a run is suitable for later splicing discovery.

## 10.3 Gene body coverage

Uneven coverage across transcripts can indicate:

- degradation
- library bias
- priming bias
- 3’ or 5’ bias from protocol effects

A consistent protocol-specific bias may be acceptable if understood. A sample-specific extreme bias is more concerning.

---

# 11. Cross-sample consistency is often more important than absolute perfection

A technically “imperfect” dataset can still be highly useful if:

- all replicates behave similarly
- the biological groups are balanced
- no single sample is an extreme outlier
- key metrics support the downstream question

By contrast, one very odd sample can distort downstream analysis even if the group average looks fine.

So always ask:

- Are the replicates coherent?
- Are any samples clear outliers across multiple metrics?
- Do all the warning signs point to the same sample?

Outliers should be judged using multiple metrics, not one.

---

# 12. How to decide whether a sample is a real QC concern

A sample becomes more concerning when several issues stack together, for example:

- low read depth
- weak alignment
- unusual GC
- unusual duplication
- odd strandedness
- abnormal feature distribution

One mildly unusual metric is usually not enough.

Three or four converging warning signs deserve serious attention.

---

# 13. How to decide whether the whole study is suitable for downstream analysis

At the end of QC, you should be able to classify the run broadly as one of the following:

## 13.1 Clearly suitable

Characteristics:

- workflow completed cleanly
- samples are present and named correctly
- read quality is broadly good
- trimming is reasonable
- alignment is strong and consistent
- strandedness is clear
- no major outliers

## 13.2 Suitable with caveats

Characteristics:

- workflow completed
- most metrics are acceptable
- one or two samples need caution
- some bias or imbalance exists, but not enough to invalidate the study

In this case, document the caveats clearly.

## 13.3 Questionable for some downstream uses

Characteristics:

- expression-level analysis may still be possible
- but splicing-sensitive analysis may be underpowered or unreliable
- or strandedness / feature distribution issues create interpretive risk

This distinction is important: a dataset can be usable for DGE but weak for splicing discovery.

## 13.4 Not suitable without major caution or rerun

Characteristics:

- incomplete or unstable workflow
- strong sample outliers
- widespread strandedness problems
- poor alignment across many samples
- severe inconsistencies that undermine biological interpretation

---

# 14. A practical White Lab QC review workflow

For each completed run, a reviewer should record:

- whether the execution report indicates a successful stable run
- expected number of samples and groups
- broad read-depth distribution
- any obvious FastQC outliers
- trimming behaviour
- alignment strength and consistency
- strandedness assessment
- feature distribution comments
- whether the run is suitable for:
  - downstream DGE
  - downstream splicing analysis
- whether any samples should be flagged or excluded

This should eventually feed into the run summary report.

---

# 15. Common mistakes new users make

## Mistake 1: trusting one metric too much

A high alignment rate does not rescue bad strandedness.
A good GC distribution does not rescue a failed run.
A clean execution report does not rescue a biologically poor library.

## Mistake 2: ignoring outliers because the group average looks fine

RNA-seq QC is often about finding the one bad sample that would otherwise distort downstream analysis.

## Mistake 3: treating MultiQC as pass/fail

It is not a certificate.
It is a decision-support tool.

## Mistake 4: forgetting the downstream question

A dataset suitable for gene-level expression is not automatically suitable for splicing discovery.

## Mistake 5: not documenting decisions

If you decide a sample is acceptable despite a concern, record why.
If you exclude a sample, record why.
Future-you will need that reasoning.

---

# 16. Final principle

Good QC is not about chasing perfection.

It is about deciding, honestly and explicitly:

- what the data can support
- what the data cannot support
- which samples are trustworthy
- which caveats must travel forward into downstream analysis
