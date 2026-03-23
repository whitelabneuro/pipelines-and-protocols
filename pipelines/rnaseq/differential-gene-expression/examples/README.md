# Examples

This `examples/` directory contains worked reference examples for the White Lab downstream bulk RNA-seq differential gene expression workflow.

These examples are intended to show how the reusable repo structure is applied in practice using real or realistic study setups.

They are designed to complement the documentation and templates by helping users see what a finished downstream study should look like.

---

## What examples are for

Examples in this directory are intended to help users understand:

- how retained upstream preprocessing outputs are handed into downstream DGE
- how a real study is organised using White Lab conventions
- how launch files, inputs, outputs, and retained materials fit together
- how the repo structure maps onto a real study lifecycle

Examples are especially useful for:

- PhD student training
- postdoc onboarding
- checking how a study should be organised
- comparing a new live project against a worked reference

---

## What examples are not for

Examples are not:

- the clean starting point for new studies
- substitutes for the documentation
- live CREATE execution directories
- arbitrary archives of all files from a past run

New studies should be created from `templates/`, not by copying an example and editing it in place.

---

## Relationship to the rest of the repo

Within the overall `differential-gene-expression/` repo section:

- `docs/` explains the workflow and analysis logic
- `templates/` provides reusable starter material for new studies
- `configs/` provides reusable reference configuration resources
- `examples/` shows worked reference implementations

In simple terms:

- `docs/` explain the workflow
- `templates/` start a new project
- `examples/` show what good practice looks like

---

## Current example set

The first downstream worked example is:

- `klim2019_tdp43kd/`

This example is based on the same Klim et al. 2019 human iPSC-derived motor neuron RNA-seq dataset used for the upstream preprocessing example.

It is intended to demonstrate the real White Lab handoff from the completed preprocessing workflow into downstream differential gene expression analysis.

---

## How to use the examples

A good way to use this directory is:

1. read the core documentation first
2. inspect the relevant template structure
3. review the worked example to see how that structure is used in practice
4. build a new live CREATE project from the templates
5. compare the new project against the example where helpful

This keeps the examples educational without turning them into hidden templates.

---

## Example design principles

Examples in this repo should be:

- clearly annotated
- selective rather than bloated
- explicit about study identity and handoff
- explicit about matrix strategy and design logic
- explicit about which outputs matter most
- useful for both training and workflow validation

They should not simply be folders of copied files with no explanation.

---

## Next step

The next example to review is:

`klim2019_tdp43kd/README.md`
