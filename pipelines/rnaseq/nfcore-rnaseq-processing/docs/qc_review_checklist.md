# RNA-seq QC review checklist

Use this checklist after a completed White Lab `nfcore-rnaseq-processing` run to review the two main QC outputs:

- the **Nextflow execution report**
- the **MultiQC report**

This document is intentionally shorter and more operational than the full QC tutorial. It is designed as a practical review sheet.

---

# 1. Execution report review

## Workflow completion

- [ ] Run completed successfully
- [ ] No final failed tasks
- [ ] Output directory is complete and readable
- [ ] Execution report, timeline, trace, and params files are present
- [ ] Run manifest is present

## Runtime and stability

- [ ] Total runtime looks plausible for the dataset size
- [ ] No obvious pattern of repeated failures or retries that would undermine confidence in the run
- [ ] Major workflow steps expected for the chosen pipeline mode appear to have run

## Run provenance

- [ ] nf-core/rnaseq version recorded
- [ ] Nextflow version recorded
- [ ] Reference FASTA and GTF recorded
- [ ] Samplesheet used is recorded
- [ ] Nextflow config used is recorded

## Initial decision

- [ ] The run is technically complete enough to interpret MultiQC
- [ ] The run should be repeated or investigated further before QC interpretation

---

# 2. MultiQC review

## Sample overview

- [ ] Expected number of samples present
- [ ] Sample names are correct and interpretable
- [ ] Replicate structure matches expectations
- [ ] No obvious duplicated or missing samples

## Raw read QC

- [ ] Total read counts are broadly comparable across samples
- [ ] No obvious low-depth outlier without explanation
- [ ] Per-base quality looks broadly acceptable
- [ ] GC content is broadly consistent across samples
- [ ] Read length is consistent with expectations
- [ ] Adapter content is not unexpectedly severe
- [ ] Overrepresented sequences do not suggest a major unresolved problem

## Trimming review

- [ ] Trimming occurred where expected
- [ ] Trimming was not excessively high for one or more outlier samples
- [ ] Post-trim read lengths still look usable
- [ ] Trimming behaviour is broadly consistent across replicates

## Alignment review

- [ ] Overall alignment rates are acceptable
- [ ] Unique alignment rates are acceptable
- [ ] No single sample has a markedly worse mapping profile than the rest
- [ ] Multimapping does not look unusually high in outlier samples
- [ ] Alignment metrics are broadly consistent within biological groups

## Strandedness review

- [ ] Strandedness check section reviewed
- [ ] Inferred or expected strandedness is consistent with the run
- [ ] No sample is marked fail or undetermined without explanation
- [ ] Any strandedness uncertainty has been documented

## Genomic feature distribution

- [ ] Exonic / intronic / intergenic signal looks plausible for the library type
- [ ] No sample shows an extreme feature-distribution outlier
- [ ] Gene-body coverage is broadly acceptable if reported
- [ ] Junction-related metrics are acceptable if downstream splicing analysis is planned

## Duplication and complexity

- [ ] Duplication levels are not unexpectedly extreme
- [ ] No sample is a clear duplication outlier across multiple metrics
- [ ] Duplication is interpreted in context of depth and library composition

---

# 3. Outlier assessment

## Sample-level concerns

- [ ] No major outlier identified
- [ ] One or more samples flagged for caution
- [ ] Same sample looks problematic across multiple QC metrics
- [ ] Potentially problematic samples have been documented explicitly

## Typical reasons to flag a sample

- [ ] unusually low read depth
- [ ] unusually poor alignment
- [ ] unusual GC distribution
- [ ] extreme duplication
- [ ] problematic strandedness
- [ ] unusual feature distribution
- [ ] inconsistent behaviour relative to biological replicates

---

# 4. Downstream suitability decision

## Differential gene expression

- [ ] Run is suitable for DGE
- [ ] Run is suitable for DGE with caveats
- [ ] Run is not suitable for DGE without further action

## Splicing discovery / alignment-aware downstream workflows

- [ ] Run is suitable for splicing workflows
- [ ] Run is suitable for splicing workflows with caveats
- [ ] Run is not suitable for splicing workflows without further action

## Retention and handoff

- [ ] MultiQC report retained
- [ ] Pipeline info retained
- [ ] BAM-linked samplesheet retained
- [ ] Run manifest retained
- [ ] Downstream-useful outputs archived to RDS
- [ ] Any sample exclusions or caveats recorded for future workflows

---

# 5. Reviewer summary

Fill in a brief written summary after completing the checklist.

## Reviewer

- Name:
- Date:

## Run reviewed

- Project ID:
- Dataset ID:
- Output directory:

## Overall QC assessment

- [ ] Technically strong run
- [ ] Acceptable run with caveats
- [ ] Major concerns requiring follow-up

## Key concerns noted

- 
- 
- 

## Recommended next step

- [ ] Proceed to downstream analysis
- [ ] Proceed with caveats clearly documented
- [ ] Re-review before downstream analysis
- [ ] Repeat or repair run before downstream analysis
