# Post-run retention and archiving

This document explains what should be retained after a completed White Lab `nfcore-rnaseq-processing` run, what should be copied back into the repository as a worked-example record, and what should be stored durably on CREATE RDS for downstream workflows.

## Purpose

A completed RNA-seq processing run produces a mixture of:

- small provenance and reporting files
- downstream-useful processed outputs
- large intermediate or operational files

These should not all be treated the same way.

The aim of post-run retention is to ensure that:

- the repository keeps a compact, useful worked-example record
- downstream analysis inputs are retained durably on RDS
- very large operational files do not accumulate unnecessarily in the repo
- provenance is sufficient to understand and reproduce the run later

## Three retention layers

### 1. Repository retention

The repository should keep only small files that are useful for:

- worked-example documentation
- provenance
- reporting
- future pipeline development

These files should be small enough to version in Git without turning the repo into a storage archive.

Typical repo-retained files include:

- run manifest
- pipeline parameter snapshot
- execution trace
- software version summary
- execution report and timeline
- pipeline DAG
- selected worked-example reports such as MultiQC
- samplesheet or manifest files that help later workflows understand the run outputs

### 2. RDS retention

RDS should hold the durable processed outputs that are expected to support later downstream workflows.

These typically include:

- merged count matrices
- transcript-level matrices
- tx2gene mappings
- SummarizedExperiment objects
- alignment BAM and BAI files when downstream workflows require them
- retained reference outputs produced by the pipeline
- provenance and QC files needed alongside the scientific outputs

### 3. Scratch-only or transient retention

Some outputs are large, reproducible, or operationally specific and should remain on scratch only unless there is a clear reason to retain them.

These typically include:

- live `work/` directories
- copied FASTQ inputs
- very large temporary files
- rebuildable intermediates that are not required for downstream analysis

## General White Lab rule

After a successful run:

- keep small provenance and reporting records in the repo if they support the worked example
- archive downstream-useful scientific outputs to RDS
- avoid placing large BAMs, FASTQs, work directories, or full output trees in the repo

## Files typically copied into the repo

For a worked example such as `examples/klim2019_tdp43kd/`, the following are good candidates for repo retention:

- `run_manifest.txt`
- `pipeline_info/execution_trace_*.txt`
- `pipeline_info/params_*.json`
- `pipeline_info/nf_core_rnaseq_software_mqc_versions.yml`
- `pipeline_info/pipeline_dag_*.html`
- `pipeline_info/execution_report_*.html`
- `pipeline_info/execution_timeline_*.html`
- `multiqc/.../multiqc_report.html`
- `samplesheets/samplesheet_with_bams.csv`

These files provide a compact but useful record of:

- how the run was configured
- what software and parameters were used
- what outputs were produced
- what a future downstream workflow should expect as input

## Files typically archived to RDS

For short-read bulk RNA-seq runs, the following are usually the most important retained scientific outputs.

### Quantification outputs

Examples include:

- merged gene counts
- scaled gene counts
- length-scaled gene counts
- gene TPM matrices
- transcript counts
- transcript TPM matrices
- transcript length tables
- tx2gene mappings
- SummarizedExperiment RDS objects

These are usually the primary retained inputs for downstream expression workflows.

### Alignment outputs

If downstream workflows require genome-aligned BAMs, archive:

- coordinate-sorted BAMs
- BAI index files

These are especially important when the downstream plan includes:

- splicing discovery
- exon or junction analysis
- visualisation of alignments in a genome browser
- other alignment-dependent workflows

Transcriptome BAMs should only be retained if there is a specific planned downstream use for them.

### Reference outputs

If `--save_reference` is used, archive the generated reference outputs that may be useful later, for example:

- genome FASTA
- FASTA index files
- chromosome sizes
- original or filtered GTF files
- BED derived from annotation
- transcript FASTA
- generated STAR or Salmon indices where appropriate

These are useful when downstream workflows need to ensure consistency with the exact reference state used in the primary processing run.

### Provenance and QC

Also archive alongside the scientific outputs:

- run manifest
- pipeline info directory
- MultiQC report
- samplesheet with BAM locations
- any key run summary or handoff files

## Files usually not copied into the repo

The following should generally not be committed into the repo:

- FASTQ files
- live `work/` directories
- large BAM files
- large BAI collections
- full output trees containing heavy binary files
- copied reference genomes or large index directories
- bulk temporary files from the launcher environment

These should remain on scratch or be archived to RDS if scientifically needed.

## Suggested CREATE storage model after a completed run

A good White Lab pattern is:

- project scratch keeps the active run and immediate outputs during processing
- RDS receives the retained processed outputs and key provenance files
- the repo receives only the compact worked-example record

## Suggested RDS structure

One useful pattern is to group retained outputs by study, then by workflow stage.

For example:

    /rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/<STUDY_ID>/
      primary_processing/
        <RUN_ID>/
          pipeline_info/
          multiqc/
          samplesheets/
          quantification/
          alignments_sorted_bam/
          reference_outputs/
          run_manifest.txt

This makes it easier for later downstream pipelines to locate the relevant retained inputs.

## Suggested repo structure for a worked example

A useful repo pattern for a worked example is:

    examples/<EXAMPLE_NAME>/
      README.md
      launch/
      notes.md
      reports/
      pipeline_info/
      downstream_inputs/

This allows the repo to document:

- the project setup
- key execution records
- downstream-facing manifest files

without storing the full large outputs.

## Practical post-run checklist

After a run is completed and reviewed:

- confirm that the run finished successfully
- identify the run output directory to retain
- copy compact provenance and reporting files into the repo example if needed
- archive downstream-useful outputs to RDS
- record where the retained RDS outputs live
- decide whether large scratch outputs should be kept temporarily or cleaned later
- update worked-example notes so later pipelines know what was retained

## Relationship to worked examples

Worked examples such as `examples/klim2019_tdp43kd/` should document the run clearly enough that future users and future pipeline stages can understand:

- which run was used
- which key outputs were retained
- where the heavier downstream-useful files were archived
- which files in the repo are only documentation and provenance records

## White Lab principle

The repository is the documentation and workflow framework.

RDS is the durable retained scientific output layer.

Scratch is the active execution layer.

Those roles should remain distinct.
