# TSC_KO_neurons

## Purpose

Project record for nf-core/rnaseq primary preprocessing of collaborator-provided TSC1 KO and WT neuron RNA-seq FASTQs on Prometheus.

## Dataset summary

- 8 paired-end RNA-seq samples
- 4 × TSC1_KO
- 4 × TSC1_WT

Archived source FASTQs:

- `/rds/prj/bcn_whitema_rbp/RNA_seq_studies/input_sequencing_files/TSC_KO_Neurons/01.RawData`

Local staged execution copy on Prometheus:

- `/scratch1/projects/TSC_KO_neurons/fastq`

## Live run layout on Prometheus

- launch directory:
  - `/projects/active/TSC_KO_neurons`
- work directory:
  - `/scratch1/nextflow_work/TSC_KO_neurons_nfcore_rnaseq`
- output directory:
  - `/projects/active/TSC_KO_neurons/results`

## Notes

- FASTQs are staged locally to Prometheus scratch before execution.
- RDS is archive/shared storage only and should not be used as the live execution location.
- Samplesheet strandedness is currently set to `auto` pending explicit confirmation.
