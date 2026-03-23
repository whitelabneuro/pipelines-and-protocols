# klim2019_tdp43kd

Worked downstream bulk RNA-seq differential gene expression example for the White Lab `differential-gene-expression/` workflow.

This example demonstrates how retained outputs from the completed White Lab preprocessing workflow can be handed into a downstream DGE analysis using `nf-core/differentialabundance`.

---

## Example identity

### Example dataset ID
`klim2019_tdp43kd`

### CREATE project ID
`Klim_TDP_LOF`

### Biological context
Human iPSC-derived motor neuron RNA-seq in a TDP-43 knockdown setting based on Klim et al. 2019.

### Purpose of this example
To show the White Lab downstream handoff from retained preprocessing outputs into downstream differential gene expression analysis, including project structure, launch files, input definitions, output review, and retention logic.

---

## Relationship to the upstream preprocessing example

This downstream worked example follows directly from the completed upstream example in:

`pipelines/rnaseq/nfcore-rnaseq-processing/examples/klim2019_tdp43kd/`

That upstream example established:

- the preprocessing run structure
- the retained preprocessing package
- the key quantification outputs
- the provenance and QC materials used as the downstream handoff

This downstream example therefore demonstrates the next stage of the same study lifecycle.

---

## What this example is intended to teach

This example is designed to show:

- how downstream DGE begins from retained preprocessing outputs
- how a live CREATE downstream project should be organised
- how matrix choice is documented
- how metadata and contrasts are handled
- how `nf-core/differentialabundance` is launched
- how reporting, pathway extensions, and retention may be organised
- how White Lab reusable repo resources map onto a real study

---

## Directory structure

This example is expected to include curated materials such as:

- study overview notes
- upstream handoff notes
- representative launch files
- representative input files
- output summaries
- retention summaries

The exact contents will expand as the example is built and validated.

---

## Important note

This example is a worked reference resource.

It is not the clean starting point for new downstream studies.

New studies should begin from:

`templates/create_project/`

and should use this example only as a guide.

---

## Planned validation role

This example will also serve as the reference case for the first real CREATE validation run of the downstream DGE workflow.

That means it will help demonstrate not only the intended repo structure, but also the actual launch and output patterns produced by a real study run.

---

## Suggested reading order within this example

A good order for reviewing this example will be:

1. `study_overview.md`
2. `upstream_handoff.md`
3. files in `inputs/`
4. files in `launch/`
5. `outputs_summary/`
6. `retention_summary/`

This will make it easier to understand the full study progression from handoff to retained downstream record.

---

## Next step

Start with:

`study_overview.md`
