# RNA-seq primary processing outputs guide

This document explains the major output file types produced by the White Lab `nfcore-rnaseq-processing` workflow, what they represent, why they are retained, and what they are used for in downstream analyses.

It is intended as a detailed companion to the main preprocessing guidebook.

---

# 1. Purpose of this guide

A completed primary-processing run produces many different file types.

New users often ask questions such as:

- Why are there several BAMs per sample?
- Which BAM is the important one?
- What is the difference between gene counts, TPM, and length-scaled counts?
- What is the transcript FASTA and why was it generated?
- Why do we retain reference outputs?
- What are the index files for?

These are good questions, because a workflow is only genuinely reusable if the team understands its outputs.

This document is therefore organised around the main output classes and their downstream meaning.

---

# 2. High-level output classes

A White Lab RNA-seq primary-processing run typically produces:

- QC outputs
- pipeline provenance outputs
- samplesheet / manifest outputs
- reference outputs
- alignment outputs
- quantification outputs

Each class exists for a different reason.

---

# 3. QC outputs

QC outputs are used to assess whether the run and samples are technically suitable for downstream interpretation.

## 3.1 MultiQC report

Example:
- `multiqc_report.html`

This is the main aggregated QC report across the run.

What it is for:

- first-pass technical review
- comparing samples side by side
- identifying outliers
- interpreting read quality, trimming, alignment, strandedness, duplication, and feature distribution

Why it is retained:

- compact and highly informative
- useful both in the repo example and on RDS
- helps future downstream users understand technical caveats

## 3.2 FastQC-derived outputs

These underlie the MultiQC aggregation and may also be kept as separate run outputs.

What they are for:

- detailed sample-level inspection
- troubleshooting if one sample looks odd in MultiQC

## 3.3 fq_lint outputs

These validate structural integrity of FASTQ files.

What they are for:

- confirming FASTQ structure
- early troubleshooting of malformed sequencing inputs

## 3.4 Trim Galore reports

These record trimming behaviour per sample.

What they are for:

- understanding adapter removal
- understanding read shortening after trimming
- checking whether trimming was unusually heavy in any sample

---

# 4. Pipeline provenance outputs

These outputs explain how the run happened.

## 4.1 Execution report

This is the run-summary HTML for workflow execution.

What it is for:

- confirming run completion
- reviewing runtime and task breakdown
- checking resource behaviour
- supporting audit and troubleshooting

## 4.2 Execution timeline

This provides a temporal view of workflow progress.

What it is for:

- understanding runtime bottlenecks
- visualising workflow progression
- troubleshooting delayed stages

## 4.3 Execution trace

This is a task-level tabular provenance record.

What it is for:

- detailed run inspection
- performance analysis
- troubleshooting specific tasks
- downstream audit

## 4.4 Parameter snapshot

Usually a JSON file.

What it is for:

- preserving the exact parameters used by the run
- avoiding ambiguity later about what settings were in effect

## 4.5 Software versions summary

Usually a YAML file.

What it is for:

- recording the software environment at run time
- improving reproducibility
- supporting comparison between runs

## 4.6 Pipeline DAG

Graphical summary of workflow structure.

What it is for:

- training
- documentation
- understanding major workflow modules

## 4.7 Run manifest

This is the launcher-generated provenance file.

What it is for:

- project-level run identity
- recording output directory, work directory, reference paths, config used, and samplesheet used
- bridging launcher logic and pipeline outputs

Why it matters:

- this is one of the most useful compact provenance files in the whole run

---

# 5. Samplesheet and manifest outputs

## 5.1 `samplesheet.csv`

The editable project samplesheet.

What it is for:

- defining the intended input structure for the run

## 5.2 `samplesheet.canon.csv`

The canonical execution-facing samplesheet.

What it is for:

- freezing resolved absolute input paths
- providing a validated input manifest for the run

## 5.3 `samplesheet_with_bams.csv`

Post-run samplesheet enriched with BAM associations.

What it is for:

- downstream workflows that need to know which BAM belongs to which sample
- preserving a compact bridge between sample identity and retained alignment outputs

This is particularly valuable for later splicing workflows.

---

# 6. Reference outputs

Reference outputs preserve the exact computational reference state used by the run.

## 6.1 Genome FASTA

Example:
- `GRCh38.primary_assembly.genome.fa`

What it is:

- the genome sequence used by the pipeline after preparation

Why it matters:

- genome alignment depends on this exact sequence
- later downstream reuse is cleaner when the same retained genome is available

## 6.2 FASTA index

Example:
- `GRCh38.primary_assembly.genome.fa.fai`

What it is:

- index of FASTA sequence names and coordinates

Why it matters:

- needed for fast random access
- required by many tools
- often essential for browser and interval operations

## 6.3 Chromosome sizes

Example:
- `GRCh38.primary_assembly.genome.fa.sizes`

What it is:

- sequence names and lengths derived from the retained genome FASTA

Why it matters:

- useful for interval-based tools
- useful for plotting and browser track work
- useful for BED-based downstream processing

## 6.4 Original retained GTF

Example:
- `gencode.v49.primary_assembly.annotation.gtf`

What it is:

- the annotation used to define genes, transcripts, and exon structures

Why it matters:

- downstream interpretation depends on it
- expression and splicing analyses are annotation-sensitive

## 6.5 Filtered GTF

Example:
- `gencode.v49.primary_assembly.annotation.filtered.gtf`

What it is:

- annotation after compatibility filtering or preprocessing steps

Why it matters:

- often the most faithful retained representation of the annotation state actually used in the run

## 6.6 BED derived from annotation

Example:
- `gencode.v49.primary_assembly.annotation.filtered.bed`

What it is for:

- feature-based tools
- genomic interval operations
- some QC modules and downstream utilities

## 6.7 Transcript FASTA

Example:
- `genome.transcripts.fa`

What it is:

- transcript sequences generated from the retained genome and annotation

Why it matters:

- useful for transcript-aware work
- useful for transcript-level downstream methods
- useful for some isoform and splicing workflows
- useful when you want a retained transcriptome consistent with the exact primary-processing run

This is one of the more conceptually important retained reference files for labs doing transcript- and isoform-focused biology.

## 6.8 STAR index

What it is:

- a tool-specific searchable alignment index built from the retained genome and annotation

What it contains conceptually:

- sequence structures and metadata optimised for STAR alignment

Why it matters:

- allows reproducible reuse of the exact alignment reference state
- saves time in future reruns or alignment-dependent downstream workflows

## 6.9 Salmon index

What it is:

- a tool-specific searchable index used for transcript quantification

What it contains conceptually:

- transcriptome-derived sequence structures optimised for Salmon quantification

Why it matters:

- preserves the exact quantification reference state
- helps keep future transcript-level analyses consistent with the original run

---

# 7. Alignment outputs

Multiple BAM types may be produced. These are related but serve different purposes.

## 7.1 `Aligned.out.bam`

What it is:

- a genome-aligned BAM direct from the aligner

What it is for:

- rawer alignment output
- some workflow-internal stages
- occasional inspection or debugging

Why it is not usually the preferred long-term retained BAM:

- later downstream work usually prefers sorted/indexed BAMs
- this file is more of a stage-specific product than the most user-friendly retained object

## 7.2 `sorted.bam`

What it is:

- coordinate-sorted genome BAM

What it is for:

- the main retained genome-aligned BAM layer
- genome browser viewing
- splicing discovery
- exon/junction analysis
- alignment-aware downstream tools

Why it matters:

- this is usually the most important retained BAM for later White Lab splicing workflows

## 7.3 `sorted.bam.bai`

What it is:

- index file for the coordinate-sorted BAM

What it is for:

- efficient random access to the BAM
- required for many tools and genome browsers

Always think of the BAM and BAI as a pair.

## 7.4 `markdup.sorted.bam`

What it is:

- duplicate-marked coordinate-sorted BAM

What it is for:

- duplicate-aware review
- some downstream QC
- retaining a richer alignment layer

Why it may or may not be the preferred default BAM:

- useful, but not always strictly required for downstream biology
- keeping both sorted and markdup BAMs increases storage

## 7.5 `markdup.sorted.bam.bai`

Index for the duplicate-marked BAM.

## 7.6 `Aligned.toTranscriptome.out.bam`

What it is:

- transcriptome-oriented alignment BAM

What it is for:

- transcript-level processing contexts
- certain workflow-internal or tool-specific stages

Why it is often not retained by default:

- extremely large
- less central than sorted genome BAMs for many downstream workflows
- many downstream needs are already covered by quantification matrices plus genome BAMs

Retain only if a future workflow explicitly requires it.

---

# 8. Quantification outputs

These files are among the most important retained scientific outputs of the run.

## 8.1 Gene-level count matrices

### `salmon.merged.gene_counts.tsv`

What it is:

- merged gene-level counts across all samples

What it is for:

- gene-level downstream analysis
- count-based modelling
- baseline retained count matrix

### `salmon.merged.gene_counts_scaled.tsv`

What it is:

- scaled gene-level counts

What it is for:

- downstream workflows where scaled count estimates are preferred
- some expression analyses and comparisons

### `salmon.merged.gene_counts_length_scaled.tsv`

What it is:

- gene counts incorporating length-related scaling

What it is for:

- downstream workflows sensitive to transcript/gene length effects
- often a particularly useful retained matrix for expression interpretation

## 8.2 Gene-level abundance and length files

### `salmon.merged.gene_tpm.tsv`

What it is:

- gene-level TPM abundance matrix

What it is for:

- exploratory analysis
- visualisation
- relative abundance interpretation

Usually not the primary input for count-based DGE testing.

### `salmon.merged.gene_lengths.tsv`

What it is:

- gene-level length metadata

What it is for:

- context for scaling and abundance interpretation
- reproducibility and audit of quantification assumptions

## 8.3 Transcript-level matrices

### `salmon.merged.transcript_counts.tsv`

What it is:

- merged transcript-level counts

What it is for:

- transcript-level analysis
- isoform-aware workflows
- transcript-level differential usage frameworks

### `salmon.merged.transcript_tpm.tsv`

What it is:

- transcript-level TPM abundance matrix

What it is for:

- transcript abundance exploration
- isoform visualisation
- transcript-level downstream workflows

### `salmon.merged.transcript_lengths.tsv`

What it is:

- transcript-level length metadata

Why it matters:

- transcript interpretation is tightly tied to transcript definitions and lengths

## 8.4 Transcript-gene mapping

### `salmon.merged.tx2gene.tsv`

What it is:

- mapping of transcript IDs to gene IDs

What it is for:

- bridging transcript-level and gene-level analyses
- helping downstream tools summarise transcript data to genes
- tracking transcript membership across interpretations

This is a key file for connecting expression and isoform layers.

## 8.5 R/Bioconductor handoff objects

### `salmon.merged.gene.SummarizedExperiment.rds`

What it is:

- R object containing gene-level data and associated metadata in a structured Bioconductor format

What it is for:

- convenient direct import into R
- preserving structure beyond plain TSV files

### `salmon.merged.transcript.SummarizedExperiment.rds`

What it is:

- transcript-level equivalent of the above

What it is for:

- transcript-level downstream work in R
- more structured and reusable object-based handoff

---

# 9. Which files matter for which downstream workflows

## 9.1 Differential gene expression

Most important retained inputs:

- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_counts_scaled.tsv`
- `salmon.merged.gene_counts_length_scaled.tsv`
- `salmon.merged.gene_tpm.tsv`
- `salmon.merged.gene.SummarizedExperiment.rds`
- `sample_metadata.csv`
- `run_metadata.yaml`

## 9.2 Transcript-level or isoform-aware work

Most important retained inputs:

- `salmon.merged.transcript_counts.tsv`
- `salmon.merged.transcript_tpm.tsv`
- `salmon.merged.transcript_lengths.tsv`
- `salmon.merged.tx2gene.tsv`
- `salmon.merged.transcript.SummarizedExperiment.rds`
- `genome.transcripts.fa`

## 9.3 Splicing discovery

Most important retained inputs:

- `*.sorted.bam`
- `*.sorted.bam.bai`
- GTF files
- genome FASTA and FASTA index
- transcript FASTA where relevant
- `samplesheet_with_bams.csv`
- QC records including MultiQC and run manifest

## 9.4 Reproducibility and audit

Most important retained inputs:

- run manifest
- pipeline info files
- MultiQC report
- parameter snapshot
- software versions file
- launch metadata
- retained references

---

# 10. Retention logic

## Keep in repo

Small, informative files:

- run manifest
- pipeline info
- MultiQC HTML
- BAM-linked samplesheet
- worked-example launch and metadata files

## Keep on RDS

Durable scientific outputs:

- quantification matrices
- SummarizedExperiment objects
- coordinate-sorted BAMs and BAIs
- retained references
- pipeline info and QC
- launch metadata

## Usually do not keep in repo

- FASTQs
- work dirs
- large BAM collections
- heavy binary directories
- large indices

---

# 11. Final principle

Every retained file type should answer a question.

Examples:

- “How good was the run?” → MultiQC, execution report
- “How was the run configured?” → params JSON, run manifest, launch metadata
- “What can I use for gene-level expression?” → merged gene count matrices
- “What can I use for transcript-level work?” → transcript matrices, tx2gene, transcript FASTA
- “What can I use for splicing?” → sorted BAMs, BAIs, retained references
- “How do I reproduce the exact reference state?” → retained genome, GTF, filtered annotation, transcriptome FASTA, indices

That is why these files exist, why they are retained, and why users need to understand them.
