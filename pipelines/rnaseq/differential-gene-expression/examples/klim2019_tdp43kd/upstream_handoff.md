# Upstream handoff

This file records the relationship between the downstream `klim2019_tdp43kd` example and the retained upstream preprocessing package produced by the White Lab preprocessing workflow.

---

## Upstream source

### Upstream example
`pipelines/rnaseq/nfcore-rnaseq-processing/examples/klim2019_tdp43kd/`

### Upstream CREATE project ID
`Klim_TDP_LOF`

### Completed preprocessing output directory
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF/out_20260318_133306`

---

## Retained upstream preprocessing package

### Study-level retained directory
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/`

### Retained primary-processing package
`primary_processing/out_20260318_133306/`

---

## Important retained handoff files

### Quantification outputs
- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_counts_scaled.tsv`
- `salmon.merged.gene_counts_length_scaled.tsv`
- `salmon.merged.gene_tpm.tsv`
- `salmon.merged.gene_lengths.tsv`
- `salmon.merged.transcript_counts.tsv`
- `salmon.merged.transcript_tpm.tsv`
- `salmon.merged.transcript_lengths.tsv`
- `salmon.merged.tx2gene.tsv`
- `salmon.merged.gene.SummarizedExperiment.rds`
- `salmon.merged.transcript.SummarizedExperiment.rds`

### Metadata and provenance
- `sample_metadata.csv`
- `run_metadata.yaml`
- `samplesheet_with_bams.csv`
- `run_manifest.txt`

### QC and run context
- `multiqc_report.html`
- `pipeline_info/`

---

## Downstream handoff note

This downstream example is designed to begin from the retained preprocessing package above rather than from raw FASTQ files.

That continuity is a core White Lab workflow principle and one of the main teaching points of the worked example.

---

## Matrix strategy note

[To be completed when the first real downstream run is defined.]

Suggested fields to record:
- selected matrix file
- transcript length matrix use
- matching GTF source
- rationale for the chosen matrix strategy
