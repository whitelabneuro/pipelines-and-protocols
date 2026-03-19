# Klim worked example outputs

This document records the retained outputs from the White Lab worked example based on the Klim et al. 2019 TDP-43 knockdown motor neuron RNA-seq dataset.

## Purpose

The Klim example is the first fully worked CREATE example for the White Lab `nfcore-rnaseq-processing` workflow.

It serves two roles:

- a compact worked-example record inside the repository
- a real processed dataset whose retained outputs will support later downstream workflow development, including differential gene expression and splicing discovery pipelines

This document explains which outputs were retained, which were copied into the repo, and which were archived to RDS for continued use.

## Example dataset

- Study: Klim et al. 2019
- PMID: 30643292
- Example dataset ID: `klim2019_tdp43kd`
- CREATE project ID: `Klim_TDP_LOF`

## Primary processing run

- Workflow: `nfcore-rnaseq-processing`
- Underlying pipeline: `nf-core/rnaseq`
- nf-core/rnaseq version: `3.23.0`
- Nextflow version: `25.10.4`
- Aligner / quantification mode: `star_salmon`

Example completed output directory:

    /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF/out_20260318_133306

## Top-level output structure observed

The completed run produced the following major output areas:

- `fastqc/`
- `fq_lint/`
- `genome/`
- `multiqc/`
- `pipeline_info/`
- `samplesheets/`
- `star_salmon/`
- `trimgalore/`
- `run_manifest.txt`

Very large operational areas outside the retained output tree also included:

- live `fastq/`
- live `work/`

## Files retained in the repo example

The following files are appropriate for retention inside the repository because they are small, informative, and useful for documenting the worked example.

### Pipeline provenance and reporting

- `run_manifest.txt`
- `pipeline_info/execution_trace_*.txt`
- `pipeline_info/params_*.json`
- `pipeline_info/nf_core_rnaseq_software_mqc_versions.yml`
- `pipeline_info/pipeline_dag_*.html`
- `pipeline_info/execution_report_*.html`
- `pipeline_info/execution_timeline_*.html`

### QC and downstream-facing manifest files

- `multiqc/.../multiqc_report.html`
- `samplesheets/samplesheet_with_bams.csv`

These files are suitable for placement in the repo example structure, for example under:

    examples/klim2019_tdp43kd/
      reports/
      pipeline_info/
      downstream_inputs/

## Files retained on RDS

The Klim example is intended to support later downstream pipelines, so the retained RDS output layer includes both expression-focused and splicing-focused inputs.

### Quantification outputs retained for downstream expression workflows

Retain the merged Salmon-derived matrices and associated objects, including:

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

These are the primary retained inputs for future differential gene expression and transcript-level workflows.

### Alignment outputs retained for downstream splicing workflows

Coordinate-sorted genome BAMs and their index files should be retained on RDS because they are expected to be important for:

- splicing discovery workflows
- exon and junction analysis
- genome browser inspection
- later alignment-aware downstream tools

Retain at minimum:

- `*.sorted.bam`
- `*.sorted.bam.bai`

If duplicate-marked BAMs are also considered useful in your downstream framework, these may also be retained:

- `*.markdup.sorted.bam`
- `*.markdup.sorted.bam.bai`

### Reference outputs retained for reproducibility and downstream reuse

Because `--save_reference` was used, the retained reference layer should include:

- `genome/GRCh38.primary_assembly.genome.fa`
- `genome/GRCh38.primary_assembly.genome.fa.fai`
- `genome/GRCh38.primary_assembly.genome.fa.sizes`
- `genome/gencode.v49.primary_assembly.annotation.gtf`
- `genome/gencode.v49.primary_assembly.annotation.filtered.gtf`
- `genome/gencode.v49.primary_assembly.annotation.filtered.bed`
- `genome/genome.transcripts.fa`

If the pipeline-generated STAR and Salmon indices are stored separately in your CREATE or RDS backup layout, these should also be retained where appropriate.

### Provenance and QC retained on RDS alongside scientific outputs

The following should also be copied into the RDS retained-output area:

- `run_manifest.txt`
- `pipeline_info/`
- `multiqc/`
- `samplesheets/samplesheet_with_bams.csv`

This ensures that downstream use of the processed data remains tied to the exact run context.

## Files not prioritised for long-term retention in the repo

The following should not be committed into the repository:

- FASTQ files
- live `work/` directories
- copied reference output trees in full
- large BAM collections
- transcriptome BAMs unless a specific downstream use is defined
- large binary output directories generally

These should remain on scratch temporarily or be archived selectively to RDS where scientifically justified.

## Transcriptome BAMs

The Klim run produced `Aligned.toTranscriptome.out.bam` files, which were very large.

These are not currently the primary retained alignment outputs for the White Lab framework.

Unless a later downstream pipeline has a specific need for them, they are not the default retained BAM layer.

The preferred default retained alignment set is the coordinate-sorted genome BAM layer.

## Suggested RDS location

A suitable study-level RDS location for retained Klim outputs would be:

    /rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/

or an equivalent White Lab study identifier if a different naming convention is preferred.

A useful retained structure would be:

    GSE135041_Klim2019_TDP43KD_motor_neurons/
      primary_processing/
        out_20260318_133306/
          pipeline_info/
          multiqc/
          samplesheets/
          quantification/
          alignments_sorted_bam/
          reference_outputs/
          run_manifest.txt

## Suggested repo example structure

Within the repo, the compact worked-example record can be organised as:

    examples/klim2019_tdp43kd/
      README.md
      launch/
      notes.md
      outputs.md
      reports/
        multiqc_report.html
      pipeline_info/
        execution_report_*.html
        execution_timeline_*.html
        execution_trace_*.txt
        nf_core_rnaseq_software_mqc_versions.yml
        params_*.json
        pipeline_dag_*.html
      downstream_inputs/
        samplesheet_with_bams.csv
        run_manifest.txt

This keeps the repo example informative without introducing large storage burdens.

## Relationship to future pipelines

The Klim example is intended to support later workflow development in the White Lab RNA-seq framework.

Expected future reuse includes:

- differential gene expression examples using retained merged Salmon matrices
- transcript-level analysis examples using retained transcript matrices
- splicing discovery workflows using retained coordinate-sorted BAMs
- downstream reporting and interpretation examples using retained provenance and QC files

The goal is that future workflow directories can refer back to this retained output set as a stable worked-example input layer.

## White Lab principle

For the Klim example:

- the repo stores the compact worked-example record
- RDS stores the durable retained scientific outputs
- scratch remains the active execution environment

That separation should remain true as the White Lab RNA-seq pipeline stack grows.
