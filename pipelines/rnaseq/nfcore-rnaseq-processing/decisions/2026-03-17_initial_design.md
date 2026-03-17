# Initial design decisions
Date: 2026-03-17

## Decision 1: pipeline identity
Canonical workflow name: `nfcore-rnaseq-processing`

Rationale:
- stable and descriptive
- clearly linked to nf-core/rnaseq
- suitable for long-term reuse across datasets

## Decision 2: scope
This workflow covers:
- raw FASTQ intake
- metadata and samplesheet preparation
- nf-core/rnaseq execution
- alignment, quantification, QC, and provenance capture

This workflow does not yet cover:
- DE analysis
- splicing analysis
- isoform-level analysis
- downstream interpretation

## Decision 3: execution environment
Primary development environment: King's College London CREATE HPC

Rationale:
- existing lab access
- current availability before in-house Linux workstation deployment
- existing nf-core RNA-seq execution experience on platform

## Decision 4: representative development dataset
Public dataset from Klim et al. 2019, PMID 30643292

Rationale:
- biologically relevant to White Lab interests
- TDP-43 loss-of-function context
- human iPSC-derived motor neuron RNA-seq
- raw data already available for local development

## Decision 5: repository strategy
Reusable workflow logic remains separate from dataset-specific examples.

Rationale:
- preserves generalisability
- allows future internal datasets to slot in cleanly
- prevents public test case from defining pipeline structure
