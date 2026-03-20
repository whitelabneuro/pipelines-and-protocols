# White Lab RNA-seq preprocessing guidebook

This document is the primary training guide for the White Lab `nfcore-rnaseq-processing` workflow.

It is intended for new PhD students, postdocs, research assistants, and other lab members who need to understand not only how to run the short-read RNA-seq primary processing workflow, but also why each step exists, what the outputs mean, and how to judge whether a run is technically suitable for downstream analysis.

This guide is deliberately comprehensive. It is written as a practical training handbook rather than a minimal quick-start page.

---

# 1. What this workflow is for

The White Lab `nfcore-rnaseq-processing` workflow provides a reusable structure for taking short-read bulk RNA-seq data from raw FASTQ files through primary processing using `nf-core/rnaseq`.

In practical terms, this workflow is the **intake and preprocessing layer** of a broader RNA-seq framework.

It is designed to handle:

- project setup
- metadata organisation
- samplesheet preparation
- run launching on CREATE
- primary alignment and quantification
- provenance capture
- QC review
- retention of downstream-useful outputs

It is **not** the final downstream analysis layer.

This workflow prepares data for later steps such as:

- differential gene expression
- transcript-level analysis
- splicing discovery
- genome browser inspection
- integrative analysis across datasets

---

# 2. The overall logic of the White Lab RNA-seq framework

A useful way to understand this pipeline is to separate the workflow into layers.

## 2.1 Reusable workflow core

The repository stores the reusable framework:

- templates
- configs
- scripts
- documentation
- worked examples

This is the “recipe”.

## 2.2 Live CREATE execution layer

Real project directories live outside the repo on CREATE, typically under project scratch.

This is where active runs are launched and produce outputs.

## 2.3 Durable retained output layer

After a successful run, important outputs are retained on RDS.

This is the long-term scientific output layer for downstream analyses.

## 2.4 Worked example layer

The repository also stores compact worked-example records such as the Klim example.

These show how the workflow was instantiated and what was retained, without storing huge outputs directly in Git.

---

# 3. What “primary processing” means

Primary processing in this workflow means turning raw sequencing reads into a coherent set of technically reviewed, provenance-rich outputs.

At a high level, that means:

1. start with FASTQ files
2. define the samples and metadata clearly
3. run the preprocessing workflow
4. generate QC outputs
5. generate alignments and quantifications
6. preserve references and provenance
7. decide what to retain for later analyses

The output of primary processing should be a dataset that is:

- interpretable
- reviewable
- reproducible
- ready for downstream analysis

---

# 4. The major conceptual inputs to a run

A completed run is only as good as its inputs. In this workflow, the most important inputs are not only the FASTQ files, but also the organisational and metadata files that define the run.

## 4.1 FASTQ files

These are the raw sequencing reads.

They are the starting material, but they are not sufficient by themselves.

A directory full of FASTQs without a well-defined samplesheet and metadata record is not a reproducible project.

## 4.2 Samplesheet

The samplesheet is the minimal pipeline input manifest.

It tells the workflow:

- which sample names exist
- which FASTQ files belong to each sample
- which files are read 1 and read 2
- how strandedness should be treated

This is the minimum structure needed for the pipeline to know what to process.

## 4.3 Sample metadata

This is where richer biological and technical context is stored.

Examples include:

- condition
- perturbation
- cell type
- genotype
- replicate structure
- batch
- library prep
- reference assumptions

The sample metadata is critical because later downstream analyses depend on clear and consistent sample annotation.

## 4.4 Run metadata

This stores run-level context such as:

- project ID
- dataset ID
- execution environment
- pipeline version
- reference version
- expected retained outputs
- notes and comments

If the samplesheet tells the pipeline what to process, the run metadata tells future users how to interpret the run itself.

## 4.5 Reference FASTA and GTF

The choice of reference genome and annotation is a scientific decision, not just a technical one.

Different references can change:

- alignment behaviour
- gene assignment
- transcript definitions
- junction interpretation
- downstream quantification consistency

For that reason, this workflow records references explicitly and also supports retaining reference outputs from the run.

---

# 5. Why the workflow uses CREATE in a structured way

The CREATE execution model matters because RNA-seq processing produces a mixture of:

- large active work files
- lock-sensitive Nextflow state
- durable scientific outputs

The White Lab model separates these deliberately.

## 5.1 Project scratch

Use project scratch for:

- active project directories
- work directories
- heavy outputs during execution
- active logs

This is the compute-facing execution layer.

## 5.2 User scratch

Use user scratch for:

- Nextflow state
- Nextflow cache
- container cache
- local Nextflow binary

This is important because Nextflow and container systems can behave differently depending on filesystem locking and caching behaviour.

## 5.3 RDS

Use RDS for:

- retained processed outputs
- downstream-useful matrices
- retained BAM files
- retained references
- QC and provenance records

This is the durable output layer.

## 5.4 Why this separation matters

If everything lives in one place, you quickly lose clarity about:

- what is active
- what is transient
- what must be retained
- what can be cleaned later

Good RNA-seq preprocessing is not just computational. It is also organisational.

---

# 6. Project setup: how a new user should start

A new user should not copy a previous live project directory in an ad hoc way.

They should:

1. read the onboarding docs
2. copy the reusable launcher template
3. copy the reusable CREATE config
4. copy the samplesheet and metadata templates
5. copy the helper script for canonical samplesheet generation
6. edit the copied project-facing files
7. create a clean live project directory on CREATE

The key principle is:

- `templates/` and `configs/` are the source materials
- `examples/` are for illustration
- live projects are created outside the repo

---

# 7. The role of the launcher script

The launcher script does much more than just call Nextflow.

A well-designed RNA-seq launcher should:

- define project identity
- define reference paths
- define the CREATE execution model
- define where work and outputs go
- define where Nextflow state and cache live
- validate required input files
- generate a canonical samplesheet
- create a run-specific output directory
- record a run manifest
- install or verify the Nextflow binary
- launch the nf-core workflow reproducibly

This is why the launcher is worth treating as an important project-facing file rather than an incidental shell command.

---

# 8. Why the canonical samplesheet matters

The editable samplesheet is the human-facing source file.

The canonical samplesheet is the pipeline-facing resolved file.

## 8.1 Editable samplesheet

This is the file users maintain manually.

It is where sample naming and file associations are defined.

## 8.2 Canonical samplesheet

This is a derived file generated by the helper script.

Its purpose is to:

- resolve paths explicitly
- validate that expected FASTQs exist
- provide a clean frozen input manifest for the run

This matters because the path a user writes may not be the exact canonical path seen by the system underneath.

The canonical samplesheet turns the editable plan into an execution-ready manifest.

## 8.3 Why this is good practice

It creates a separation between:

- user-maintained project input
- execution-frozen project input

That is very useful for debugging, provenance, and reproducibility.

---

# 9. What nf-core/rnaseq is doing inside this workflow

This workflow uses `nf-core/rnaseq` as the primary processing engine.

Conceptually, the pipeline performs several major tasks.

## 9.1 Input validation and basic FASTQ checks

Before heavy alignment or quantification begins, the workflow checks whether the reads look structurally valid.

This helps catch:

- corrupt FASTQ files
- malformed inputs
- unexpected layout problems

## 9.2 Read QC and trimming

The workflow generates quality summaries and performs trimming where appropriate.

This addresses issues such as:

- adapter contamination
- poor-quality read ends
- variable effective read length after trimming

## 9.3 Reference preparation

The workflow unpacks and prepares the reference materials needed for alignment and quantification.

Depending on settings, it may also generate retained reference outputs and indices for later reuse.

## 9.4 Alignment

Reads are aligned to the genome using STAR in the `star_salmon` mode.

This generates alignment files that are useful for:

- mapping evaluation
- genome-browser inspection
- later splicing analysis
- alignment-aware downstream workflows

## 9.5 Quantification

The pipeline also produces transcript- and gene-level quantification outputs.

These become key inputs for later expression analysis.

## 9.6 QC aggregation

The workflow aggregates sample-level QC into MultiQC.

This makes it much easier to review the run coherently across all samples.

## 9.7 Provenance capture

Execution reports, traces, parameter snapshots, and run manifests are retained so that the run can be understood later.

This is one of the biggest differences between an ad hoc analysis and a well-run reusable lab workflow.

---

# 10. The major output classes and what they mean

A completed run produces several different classes of output, and they do not all serve the same purpose.

## 10.1 QC outputs

Examples include:

- FastQC-derived summaries
- fq_lint outputs
- Trim Galore reports
- MultiQC report

Purpose:

- technical review of read quality
- trimming behaviour
- alignment and library behaviour
- outlier detection

## 10.2 Pipeline provenance outputs

Examples include:

- execution report
- execution timeline
- execution trace
- parameter snapshot
- software versions summary
- run manifest

Purpose:

- reconstruct how the run was performed
- support reproducibility
- support future debugging and audit

## 10.3 Reference outputs

Examples include:

- genome FASTA
- FASTA index
- chromosome sizes
- filtered GTF
- BED derived from annotation
- transcript FASTA
- generated indices where applicable

Purpose:

- preserve the exact reference state used in the run
- support later downstream reuse with matching references

## 10.4 Alignment outputs

Examples include:

- coordinate-sorted genome BAMs
- BAI index files
- duplicate-marked BAMs
- transcriptome BAMs where generated

Purpose:

- inspect alignments
- support splicing workflows
- support genome browser review
- support alignment-aware downstream methods

## 10.5 Quantification outputs

Examples include:

- merged gene counts
- scaled gene counts
- length-scaled gene counts
- gene TPM
- transcript counts
- transcript TPM
- tx2gene mapping
- SummarizedExperiment R objects

Purpose:

- provide the main retained inputs for later expression analyses

---

# 11. How to interpret the different BAM types

A common point of confusion for new users is that the run may produce multiple BAM flavours.

These files are related, but not interchangeable.

## 11.1 `Aligned.out.bam`

This is a genome-aligned BAM produced by STAR.

Conceptually, it represents reads aligned back to genomic coordinates.

Why it exists:

- preserves the direct genomic alignment output
- can be useful for some alignment review purposes

Why it is often not the preferred retained BAM:

- later workflows usually prefer sorted/indexed BAMs
- this file is more of a workflow-stage product than a polished retained downstream object

## 11.2 `sorted.bam`

This is the coordinate-sorted genome BAM.

This is usually the most important retained BAM for downstream work.

Why it matters:

- required for many alignment-aware tools
- suitable for genome browser inspection
- suitable for splicing workflows
- suitable for tools expecting coordinate-sorted genomic alignments

For White Lab purposes, this is usually the core retained alignment layer.

## 11.3 `sorted.bam.bai`

This is the BAM index file.

It allows efficient random access into the BAM.

Why it matters:

- without the BAI, many tools cannot efficiently inspect or query the BAM
- required for browser viewing and many downstream tools

A BAM and its BAI should be treated as a pair.

## 11.4 `markdup.sorted.bam`

This is the duplicate-marked sorted BAM.

Conceptually, it is similar to the sorted BAM but with duplicate-related processing recorded.

Why it might be useful:

- downstream QC
- workflows where duplicate-aware interpretation matters
- retaining a richer alignment layer for later review

Why it may not always be the default downstream BAM:

- not every downstream tool needs duplicate-marked alignments
- keeping both sorted and markdup BAMs increases storage needs

## 11.5 `markdup.sorted.bam.bai`

Index for the duplicate-marked BAM.

Again, the BAM and BAI belong together.

## 11.6 `Aligned.toTranscriptome.out.bam`

This is a transcriptome-oriented alignment BAM produced for transcript-level processing contexts.

Why it exists:

- supports transcriptomic quantification-related workflow steps
- represents alignments against transcriptomic features rather than simply genomic coordinate space

Why it is often not the default retained BAM layer:

- very large
- less central than genome-sorted BAMs for many downstream workflows
- many downstream questions are already covered by the retained quantification matrices plus genome BAMs

These BAMs should usually be retained only if a future workflow explicitly needs them.

---

# 12. How to interpret the main Salmon quantification files

This is another area where new users often need careful training.

Different Salmon-derived files answer different downstream questions.

## 12.1 `salmon.merged.gene_counts.tsv`

Gene-level counts merged across samples.

What it represents:

- estimated counts aggregated at the gene level

What it is for:

- downstream gene-level analysis
- count-based statistical workflows
- quick exploratory summaries

## 12.2 `salmon.merged.gene_counts_scaled.tsv`

Scaled gene counts.

What it represents:

- count estimates that have been adjusted in a way intended to improve comparability across samples

What it is for:

- downstream workflows that expect scaled count-like gene-level inputs
- situations where raw estimated counts are not the most interpretable retained matrix

Users should always check the pipeline’s exact counting conventions and downstream method assumptions before substituting one count matrix for another.

## 12.3 `salmon.merged.gene_counts_length_scaled.tsv`

Length-scaled gene counts.

What it represents:

- counts adjusted with transcript/gene length considerations incorporated

Why it matters:

- transcript length affects expected counts
- length scaling can be important for some downstream interpretations and integrations

This is often one of the most useful retained matrices for expression work, especially when careful normalisation logic matters.

## 12.4 `salmon.merged.gene_tpm.tsv`

Gene-level TPM values.

What it represents:

- transcript-per-million style abundance summaries aggregated at gene level

What it is for:

- exploratory visualisation
- relative abundance inspection
- some integrative workflows

What it is usually **not** the primary input for:

- standard count-based DGE testing

## 12.5 `salmon.merged.gene_lengths.tsv`

Gene-level length information.

Why it matters:

- supports interpretation of count scaling
- useful for reproducibility and downstream modelling context

## 12.6 `salmon.merged.transcript_counts.tsv`

Transcript-level counts across samples.

What it is for:

- transcript-level analyses
- isoform-aware workflows
- integration with transcript-level downstream methods

This is much more relevant when moving beyond simple gene-level expression.

## 12.7 `salmon.merged.transcript_tpm.tsv`

Transcript-level TPM values.

What it is for:

- relative isoform abundance exploration
- transcript-level visualisation
- some downstream transcript/isoform workflows

## 12.8 `salmon.merged.transcript_lengths.tsv`

Transcript-level length metadata.

Important because transcript-level interpretation is strongly tied to transcript definitions and lengths.

## 12.9 `salmon.merged.tx2gene.tsv`

Transcript-to-gene mapping table.

This is a key bridge file.

What it does:

- maps transcript identifiers to their parent gene identifiers

Why it matters:

- helps connect transcript-level and gene-level analyses
- essential for many downstream summarisation and interpretation steps

## 12.10 `salmon.merged.gene.SummarizedExperiment.rds`

Gene-level R object containing expression data and associated metadata in a Bioconductor-friendly structure.

Why it matters:

- convenient direct handoff into R-based downstream workflows
- preserves structure more richly than plain TSV alone

## 12.11 `salmon.merged.transcript.SummarizedExperiment.rds`

Transcript-level equivalent of the above.

Useful for transcript-aware downstream work in R.

---

# 13. How to interpret the reference outputs

Reference outputs are often overlooked by new users, but they are scientifically important.

## 13.1 Genome FASTA

Example:
- `GRCh38.primary_assembly.genome.fa`

This is the exact genome sequence used for the run after preparation.

Why it matters:

- alignment depends on this exact sequence
- later downstream reuse is cleaner if the same retained reference is available

## 13.2 FASTA index

Example:
- `GRCh38.primary_assembly.genome.fa.fai`

This allows fast random access to the FASTA.

Required by many downstream tools.

## 13.3 Chromosome sizes

Example:
- `GRCh38.primary_assembly.genome.fa.sizes`

This is a simple but very useful file giving sequence names and lengths.

Useful for:

- BED-related work
- browser track generation
- interval tools
- downstream plotting and QC

## 13.4 Original or retained GTF

Example:
- `gencode.v49.primary_assembly.annotation.gtf`

This is the annotation used to define genes, transcripts, exons, and related features.

Why it matters:

- gene counts and transcript interpretation depend on this annotation
- splicing workflows are highly annotation-sensitive

## 13.5 Filtered GTF

Example:
- `gencode.v49.primary_assembly.annotation.filtered.gtf`

This reflects the annotation after preparation/compatibility filtering steps.

Why it matters:

- often more relevant than the raw original annotation for strict run reproducibility
- can differ subtly from the input GTF in ways that matter for later workflow alignment

## 13.6 BED derived from annotation

Example:
- `gencode.v49.primary_assembly.annotation.filtered.bed`

Useful for feature-based analyses and some QC tools.

## 13.7 Transcript FASTA

Example:
- `genome.transcripts.fa`

This file contains transcript sequences derived from the retained reference and annotation.

Why it matters:

- useful for transcriptomic interpretation
- useful for transcript-aware downstream methods
- useful for ensuring consistency between quantification and later transcript-level analyses

For White Lab splicing and isoform work, this can be a particularly valuable retained file.

## 13.8 Indices

Pipeline-generated STAR and Salmon indices encode searchable representations of the retained reference for those tools.

What they contain conceptually:

- sequence structures optimised for alignment or quantification
- annotation-linked information needed by the tools

Why they matter:

- they can save large amounts of time in repeated or downstream processing
- they preserve the exact computational reference state used by the run

Why they are not usually committed into the repo:

- they are large
- they belong in RDS or other retained compute-oriented storage, not version control

---

# 14. How to review QC after the run

The most important QC outputs for a new user are:

- the **execution report**
- the **MultiQC report**

## 14.1 Execution report

Use it to confirm:

- the run completed successfully
- there were no final failed tasks
- runtime was plausible
- the task breakdown makes sense
- the run is stable enough to trust

## 14.2 MultiQC

Use it to review:

- sample presence and naming
- read depth
- per-base quality
- GC content
- read length
- duplication
- trimming behaviour
- alignment strength
- strandedness
- feature distribution
- outliers

QC is not about finding one magic number.
It is about understanding the pattern across metrics.

---

# 15. How to decide what to retain after the run

A completed run generates too much output to keep everything everywhere.

The White Lab retention logic is:

## 15.1 Keep in the repo

Keep only small, useful worked-example records, such as:

- run manifest
- parameter snapshot
- execution trace
- software versions file
- pipeline DAG
- execution report and timeline
- MultiQC HTML
- BAM-linked samplesheet

## 15.2 Keep on RDS

Keep the durable downstream-useful outputs, such as:

- merged quantification matrices
- SummarizedExperiment R objects
- coordinate-sorted BAMs and BAIs
- reference outputs
- pipeline info
- MultiQC
- launch metadata

## 15.3 Keep on scratch only temporarily

Usually do not treat these as permanent scientific records:

- live `work/`
- copied FASTQs
- huge intermediate outputs with no defined downstream need

---

# 16. How to think about downstream suitability

A technically completed run is not automatically equally suitable for all downstream analyses.

## 16.1 Suitable for DGE

Usually requires:

- stable workflow completion
- acceptable read depth
- acceptable alignment
- no catastrophic outliers
- coherent sample metadata

## 16.2 Suitable for transcript-level workflows

Requires the above plus confidence in transcript-level quantification and annotation compatibility.

## 16.3 Suitable for splicing workflows

Requires particular attention to:

- coordinate-sorted genome BAMs
- read length
- alignment quality
- library strandedness
- junction-related QC
- consistency across replicates

A dataset can be suitable for DGE but weaker for splicing discovery.

That distinction must always be considered explicitly.

---

# 17. Common mistakes to avoid

## Mistake 1

Treating FASTQs as the whole project.

They are only the raw input layer.

## Mistake 2

Failing to maintain metadata properly.

A technically polished run with weak metadata is still hard to analyse correctly.

## Mistake 3

Ignoring reference provenance.

Reference choice shapes downstream interpretation.

## Mistake 4

Looking only at alignment rate.

RNA-seq QC is multi-dimensional.

## Mistake 5

Keeping huge outputs in the repo.

The repo is for documentation and compact example records, not bulk storage.

## Mistake 6

Not understanding what each output file class is for.

A pipeline is only as useful as the team’s understanding of what the outputs actually mean.

---

# 18. Final White Lab principle

A good preprocessing workflow is not just a way to get counts.

It is a way to produce a study record that is:

- technically interpretable
- scientifically reusable
- reproducible
- documented clearly enough that another lab member can understand it later

That is the standard this workflow aims to support.
