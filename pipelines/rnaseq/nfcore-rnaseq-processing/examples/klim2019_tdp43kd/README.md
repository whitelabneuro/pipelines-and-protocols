# Klim et al. 2019 TDP-43 knockdown example

This folder contains the first fully worked example for the White Lab `nfcore-rnaseq-processing` workflow.

## Purpose of this example

This example exists to show how the reusable White Lab RNA-seq processing workflow can be instantiated for a real dataset and carried through to an actual CREATE run.

It is intended to serve as:

- a proof of concept for the repo structure
- a worked example for lab members
- a reference showing how project-facing files are populated
- a real CREATE-based example that generates outputs, QC, provenance, and reporting
- a continuing anchor dataset for later downstream pipeline development in the White Lab RNA-seq framework

This example uses a representative public short-read RNA-seq dataset associated with Klim et al. 2019 as a development and training use case.

## Long-term role of this example

The Klim example is intended to continue beyond primary processing.

Outputs and documentation from this example will be reused as the White Lab repository expands to support later RNA-seq workflow layers, including for example:

- differential gene expression
- splicing discovery
- downstream interpretation and reporting workflows

In this sense, the Klim dataset acts as a consistent cross-pipeline worked example as the RNA-seq framework grows.

## Important boundary

This folder is a worked example, not the reusable template source for new projects.

For a new project, users should start with:

- `docs/new_project_on_create.md`
- `docs/new_project_checklist.md`
- `templates/`
- `configs/`

and use this example only for illustration and reference.

## Dataset summary

Representative public RNA-seq dataset used for workflow development:

- Klim et al. 2019
- PMID: 30643292

Biological context:

- human iPSC-derived motor neurons
- TDP-43 knockdown setting
- used here as a representative public development dataset for White Lab pipeline building

## What this example demonstrates

This example is intended to demonstrate a White Lab RNA-seq project on CREATE from setup through execution and reporting, including:

- a populated project `launch/` directory
- a copied and edited launcher script
- a copied CREATE `nextflow.config`
- a populated `samplesheet.csv`
- a populated `sample_metadata.csv`
- a populated `run_metadata.yaml`
- a copied helper script for canonical samplesheet generation
- real pipeline execution on CREATE
- provenance capture and run manifest generation
- QC review and run summary reporting
- documented handoff into future downstream workflow examples

## Relationship to the reusable workflow

This example should be read alongside:

- `README.md`
- `docs/`
- `templates/`
- `configs/`
- `scripts/`

The guiding rule is:

- `templates/` and `configs/` define the reusable starting materials
- `examples/klim2019_tdp43kd/` shows one real worked instantiation of those materials

## Expected contents

This example folder is expected to develop into a structured worked example, including project-facing setup files and later run-associated documentation.

Typical contents may include:

    examples/klim2019_tdp43kd/
      README.md
      launch/
        nextflow_run.sh
        nextflow.config
        samplesheet.csv
        sample_metadata.csv
        run_metadata.yaml
        make_canonical_samplesheet.sh
      notes.md
      reports/

Live FASTQs, active `work/` directories, and large pipeline outputs should still remain outside the repo in the appropriate CREATE project locations.

## Tutorials and worked-example guidance

For detailed QC interpretation of this completed worked example, see:

- `qc_tutorial_klim_multiqc_and_execution_report.md`
- `qc_review_checklist_klim_example.md`

For a detailed record of the retained outputs from this example, see:

- `outputs.md`

For the general White Lab training documents that apply across projects, see:

- `docs/rnaseq_preprocessing_guidebook.md`
- `docs/rnaseq_primary_processing_outputs_guide.md`
- `docs/qc_tutorial_multiqc_and_execution_report.md`
- `docs/qc_review_checklist.md`

## White Lab design principle

The reusable workflow should remain independent of this example.

The Klim dataset is valuable as a proof of concept and continuing worked reference, but it should not become the default template source for future users.

New projects should still be created from the reusable repo components, with this folder serving as a real worked illustration of the result.
