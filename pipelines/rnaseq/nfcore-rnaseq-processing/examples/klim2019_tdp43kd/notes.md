# Klim example notes

## Role of this example

The `klim2019_tdp43kd` example is the primary worked CREATE example for the White Lab short-read RNA-seq processing workflow.

It is intended to serve several purposes:

- demonstrate how the reusable repo files are instantiated for a real dataset
- provide a concrete CREATE-based example for lab members
- generate a real primary processing run with documented provenance and QC
- act as the continuing anchor dataset for later downstream workflow examples in this repository

As additional RNA-seq pipeline layers are developed, including differential gene expression and splicing discovery workflows, this example dataset is intended to be carried forward where appropriate.

## Sample groups represented

The worked example includes the following sample groups:

- `CONTROL_FLUORESCENT`
- `CONTROL_NONE`
- `CONTROL_SCRAMBLE`
- `TDP43KD`

These sample names were carried forward from prior White Lab processing of the Klim dataset and preserved here so that the example remains consistent with earlier CREATE optimisation work.

## FASTQ path convention used here

The example `samplesheet.csv` uses FASTQ paths in the form:

    /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF/fastq/<SAMPLE>_R1.fastq.gz
    /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF/fastq/<SAMPLE>_R2.fastq.gz

These paths reflect the intended White Lab CREATE live project layout.

They may differ from paths used in earlier optimisation runs, but they are used here deliberately so that the worked example matches the current repo guidance for new project setup.

## Relationship to the repo templates

The files in `examples/klim2019_tdp43kd/launch/` are intended to represent a filled-in project launch directory produced by following the reusable repo structure.

In other words:

- `nextflow_run.sh` is the filled-in example derived from `templates/launch/nextflow_run.template.sh`
- `nextflow.config` is the copied CREATE config derived from `configs/nextflow/create.config`
- `samplesheet.csv` is the populated example derived from `templates/samplesheets/samplesheet_template.csv`
- `sample_metadata.csv` and `run_metadata.yaml` are populated examples derived from `templates/metadata/`
- `make_canonical_samplesheet.sh` is the copied helper script from `scripts/validate/`

This example is therefore intended to prove that the repo structure, templates, configs, and docs work together coherently.

## Library and read metadata

Current example metadata is based on the best available information from:

- the Klim study methods
- prior White Lab CREATE processing records
- MultiQC review from the earlier optimised run

For this worked example, the dataset is treated as:

- paired-end
- unstranded
- approximately 75 bp reads after trimming / QC review
- prepared using Illumina TruSeq RNA kit v2, consistent with polyA-enriched mRNA library preparation

If stronger source metadata is identified later, these fields can be updated in a controlled way.

## Future downstream use

This worked example is expected to support future repository development beyond primary processing.

Likely future reuse includes:

- differential gene expression workflow examples
- splicing discovery workflow examples
- run reporting examples
- downstream handoff and interpretation templates

The intention is that a user should be able to trace the same example dataset across multiple White Lab RNA-seq workflow layers.
