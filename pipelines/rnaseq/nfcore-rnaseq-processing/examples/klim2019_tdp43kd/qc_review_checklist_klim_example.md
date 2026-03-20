# Klim worked example QC review checklist

This document is a worked example of how to complete the White Lab RNA-seq QC review checklist for the Klim et al. 2019 TDP-43 knockdown motor neuron dataset after primary processing with `nfcore-rnaseq-processing`.

It is intended as a practical companion to:

- `docs/qc_review_checklist.md`
- `docs/qc_tutorial_multiqc_and_execution_report.md`
- `examples/klim2019_tdp43kd/qc_tutorial_klim_multiqc_and_execution_report.md`

---

# 1. Execution report review

## Workflow completion

- [x] Run completed successfully
- [x] No final failed tasks
- [x] Output directory is complete and readable
- [x] Execution report, timeline, trace, and params files are present
- [x] Run manifest is present

## Runtime and stability

- [x] Total runtime looks plausible for the dataset size
- [x] No final failure undermining confidence in the completed run
- [x] Major workflow steps expected for the chosen pipeline mode appear to have run

### Worked-example notes

The completed run finished successfully and produced the expected top-level output structure, including:

- `pipeline_info/`
- `multiqc/`
- `samplesheets/`
- `star_salmon/`
- `genome/`
- `run_manifest.txt`

The execution report indicates a completed final run suitable for QC interpretation and downstream retention.

## Run provenance

- [x] nf-core/rnaseq version recorded
- [x] Nextflow version recorded
- [x] Reference FASTA and GTF recorded
- [x] Samplesheet used is recorded
- [x] Nextflow config used is recorded

### Worked-example notes

The Klim run retained the key provenance files needed for later reuse, including:

- run manifest
- pipeline parameter snapshot
- execution trace
- software versions file
- samplesheet with BAM associations

## Initial decision

- [x] The run is technically complete enough to interpret MultiQC
- [ ] The run should be repeated or investigated further before QC interpretation

---

# 2. MultiQC review

## Sample overview

- [x] Expected number of samples present
- [x] Sample names are correct and interpretable
- [x] Replicate structure matches expectations
- [x] No obvious duplicated or missing samples

### Worked-example notes

The Klim dataset includes the expected sample groups:

- `CONTROL_NONE`
- `CONTROL_SCRAMBLE`
- `CONTROL_FLUORESCENT`
- `TDP43KD`

These names are preserved consistently across the worked example and retained outputs.

## Raw read QC

- [x] Total read counts are broadly comparable across samples
- [x] No obvious low-depth outlier identified at first-pass review
- [x] Per-base quality appears broadly acceptable
- [x] GC content appears broadly consistent across samples
- [x] Read length is consistent with expectations
- [x] No major unresolved adapter problem identified in first-pass review
- [x] No obvious report-wide signal of severe contamination in first-pass review

### Worked-example notes

The MultiQC report is consistent with a short-read paired-end dataset of approximately 75–76 bp reads. This matches expectations for the Klim worked example and supports interpretation of the dataset as a conventional short-read bulk RNA-seq study.

## Trimming review

- [x] Trimming occurred where expected
- [x] Trimming reports were generated for all samples
- [x] No major report-wide evidence of catastrophic over-trimming
- [x] Post-trim outputs appear usable

### Worked-example notes

Trim Galore outputs and trimming reports were produced for all samples. At the worked-example level, trimming appears to have functioned as expected and does not appear to have prevented successful downstream alignment and quantification.

## Alignment review

- [x] Overall alignment rates are acceptable
- [x] Unique alignment rates are acceptable
- [x] No obvious report-wide alignment failure identified
- [x] Alignment metrics are broadly consistent with a technically usable dataset

### Worked-example notes

The MultiQC summary includes strong best-sample alignment performance, with aligned reads and uniquely aligned reads reaching high values in the report. This is technically reassuring and supports the use of this run as a White Lab worked example.

## Strandedness review

- [x] Strandedness check section reviewed
- [x] RSeQC infer experiment section present
- [x] Strandedness was explicitly considered rather than assumed
- [ ] All samples individually confirmed here as pass
- [ ] Any sample-specific fail or undetermined calls ruled out here

### Worked-example notes

This worked example is a good reminder that `auto` strandedness should still be checked against the strandedness validation sections in MultiQC. For a formal run summary, the reviewer should record explicitly whether any sample failed or was undetermined. The current worked example confirms that strandedness was reviewed, but does not hard-code a per-sample pass statement without that explicit table-by-table note being captured.

## Genomic feature distribution

- [x] Feature-distribution-related sections are present
- [x] The run appears broadly compatible with an mRNA-focused library
- [x] Exonic enrichment is consistent with expectations for this study type
- [ ] No sample-specific outlier formally documented here yet

### Worked-example notes

The overall profile is consistent with a conventional mRNA-focused RNA-seq dataset and supports the use of the retained quantification outputs for downstream gene- and transcript-level analyses.

## Duplication and complexity

- [x] Duplication metrics are available in the QC summary
- [x] No report-wide evidence of catastrophic complexity failure
- [ ] No formal sample-by-sample duplication outlier decision documented here yet

### Worked-example notes

Duplication should still be interpreted in context of sequencing depth and library composition. For this worked example, duplication does not appear to undermine the overall technical usability of the run.

---

# 3. Outlier assessment

## Sample-level concerns

- [x] No major report-wide outlier identified in first-pass review
- [ ] One or more samples flagged for caution
- [ ] Same sample looks problematic across multiple QC metrics
- [ ] Potentially problematic samples have been documented explicitly

### Worked-example notes

At the worked-example level, the Klim run is best classified as technically usable with no immediate strong evidence of a catastrophic outlier from the first-pass QC review.

However, a full study sign-off should still document explicitly whether any one sample is consistently weaker across:

- read depth
- alignment
- strandedness
- duplication
- feature distribution

---

# 4. Downstream suitability decision

## Differential gene expression

- [x] Run is suitable for DGE
- [ ] Run is suitable for DGE with caveats
- [ ] Run is not suitable for DGE without further action

### Worked-example notes

The completed run produced the expected merged Salmon quantification outputs and the QC profile is consistent with a dataset suitable for downstream gene-level expression analysis.

## Splicing discovery / alignment-aware downstream workflows

- [x] Run is suitable for splicing workflows
- [ ] Run is suitable for splicing workflows with caveats
- [ ] Run is not suitable for splicing workflows without further action

### Worked-example notes

The run retained coordinate-sorted genome BAMs and associated BAI files, which are intended to support downstream splicing discovery workflows. The retained alignment layer is therefore appropriate for later alignment-aware analyses.

## Retention and handoff

- [x] MultiQC report retained
- [x] Pipeline info retained
- [x] BAM-linked samplesheet retained
- [x] Run manifest retained
- [x] Downstream-useful outputs archived or identified for RDS retention
- [x] Reference outputs retained for reproducibility and downstream reuse

---

# 5. Reviewer summary

## Reviewer

- Name: White Lab worked example
- Date: 2026-03-18 primary processing run review

## Run reviewed

- Project ID: `Klim_TDP_LOF`
- Dataset ID: `klim2019_tdp43kd`
- Output directory: `/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF/out_20260318_133306`

## Overall QC assessment

- [x] Technically strong run
- [ ] Acceptable run with caveats
- [ ] Major concerns requiring follow-up

## Key concerns noted

- final QC interpretation should still explicitly document strandedness outcomes at the per-sample level
- sample-by-sample outlier judgment should still be recorded in any formal run summary
- transcriptome BAMs were generated but are not the default preferred retained BAM layer for the White Lab downstream framework

## Recommended next step

- [x] Proceed to downstream analysis
- [ ] Proceed with caveats clearly documented
- [ ] Re-review before downstream analysis
- [ ] Repeat or repair run before downstream analysis
