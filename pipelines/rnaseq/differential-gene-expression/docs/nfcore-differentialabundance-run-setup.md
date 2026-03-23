# nf-core/differentialabundance run setup

This document explains how White Lab downstream bulk RNA-seq differential gene expression runs should be set up and launched using `nf-core/differentialabundance`.

The purpose of this page is not to teach every possible option supported by the nf-core pipeline. Instead, it defines the White Lab approach for preparing and launching a clean, reproducible downstream DGE run from retained preprocessing outputs.

This document focuses on:

- what `nf-core/differentialabundance` is doing in this workflow
- which core inputs are required for a standard RNA-seq run
- how White Lab launch files should be organised
- how to use params files and config files correctly
- how to run reproducibly on CREATE
- how to think about resume behaviour and downstream extensions

This page should be read after:

- `required-inputs.md`
- `count-matrix-selection.md`
- `metadata-and-contrasts.md`

---

## Purpose of the pipeline in the White Lab workflow

In the White Lab downstream RNA-seq stack, `nf-core/differentialabundance` is the main execution engine for structured matrix-based differential analysis.

For standard bulk RNA-seq use, it takes:

- an abundance matrix
- a sample metadata table
- a contrasts file
- a feature annotation source

and performs downstream differential modelling together with reporting and optional enrichment / visualisation steps.

Within White Lab practice, this pipeline is used to provide:

- standardised DGE execution
- structured comparison handling
- report generation
- optional Shiny output
- optional pathway analysis layers
- a reproducible backbone for downstream study analysis

The pipeline therefore sits at the centre of the downstream execution layer, but it is surrounded by White Lab templates, documentation, interpretation practices, and retention rules.

---

## Standard RNA-seq inputs for a typical White Lab run

For standard bulk RNA-seq downstream DGE, a typical White Lab launch will require the following key inputs.

### 1. Observations / sample metadata
Supplied with:

`--input`

This is the sample metadata file describing the observations and the variables needed for downstream modelling.

In White Lab practice this will usually be a CSV file derived from the retained upstream metadata and extended where necessary for DGE design.

### 2. Contrasts file
Supplied with:

`--contrasts`

This file defines the comparisons to be performed, including the contrast variable, reference group, target group, and any optional blocking variables or exclusions.

### 3. Abundance matrix
Supplied with:

`--matrix`

For standard RNA-seq, this is the selected gene-level abundance matrix as described in `count-matrix-selection.md`.

### 4. Transcript length matrix when required
Supplied with:

`--transcript_length_matrix`

This should be used when the selected downstream strategy is raw gene counts plus transcript lengths.

### 5. Feature annotation source
Supplied with one of:

- `--gtf`
- `--features`

For standard White Lab RNA-seq DGE, the usual approach should be to provide the matching GTF used upstream wherever possible.

### 6. Output directory
Supplied with:

`--outdir`

This should point to the study-specific downstream output directory in the live CREATE project, not into the repo itself.

---

## White Lab preferred standard launch logic

For standard bulk RNA-seq DGE, the launch setup should usually follow this logic:

### Use the retained preprocessing handoff package
The downstream launch should begin from retained upstream outputs rather than copied ad hoc files of uncertain origin.

### Use a params file for pipeline parameters
Pipeline parameters should be stored in a YAML params file wherever possible.

### Use a Nextflow config file only for infrastructure and resource tuning
The `-c` config file should be used for process resources, executor behaviour, container/cache settings, and other infrastructural details, not for normal pipeline parameters.

### Run from a live CREATE project outside the repo
The repo provides templates, documentation, and examples. The real launch happens in a study-specific project directory outside the repo.

### Pin the pipeline version
A specific `nf-core/differentialabundance` release should be selected deliberately for reproducibility.

### Preserve launch metadata
The command, params file, config file, pipeline version, and relevant project notes should all be retained as part of the study record.

---

## White Lab launch components

A good live downstream DGE launch on CREATE should usually have the following pieces.

### Params file
This contains the pipeline parameters such as:

- input metadata file
- contrasts file
- matrix path
- transcript length matrix path if used
- GTF path or features table path
- output directory
- study name
- optional reporting and enrichment settings

### CREATE config file
This contains the execution environment and resource-related settings such as:

- process retry strategy
- executor behaviour
- Singularity settings
- cache settings
- any specific resource tuning for heavy steps
- environment variables if needed

### Launch script
A small launch script may be used to provide a stable and documented command for the study.

This is helpful for readability, reproducibility, and handover.

### Study directory structure
The launch should sit inside a study-specific live CREATE analysis folder with clean separation between inputs, launch files, and outputs.

This is described in more detail in `create-run-structure.md`.

---

## Recommended White Lab command pattern

A standard launch should usually follow a pattern like this:

    nextflow run nf-core/differentialabundance \
        -r <PIPELINE_VERSION> \
        -profile singularity \
        -params-file params.yaml \
        -c create.config

This pattern reflects the core White Lab principles:

- version-pinned
- reusable
- params-file driven
- infrastructure config separated from analysis parameters

In some cases additional profiles or flags may be appropriate, but this should remain the default mental model.

---

## Why White Lab should prefer params files

For this pipeline, params files are strongly preferred because they:

- keep launches readable
- reduce command-line clutter
- make reruns easier
- support reproducibility
- are easier to review and retain with the study
- allow users to share settings across runs without rewriting long commands

In White Lab practice, a params file should usually be the main analysis definition for a run.

That file is often more useful than the raw terminal command when revisiting a study later.

---

## Important rule: do not use `-c` for normal pipeline parameters

A critical launch rule is:

**Do not use `-c` to define ordinary pipeline parameters.**

The custom config file supplied with `-c` should be reserved for:

- resource specifications
- executor and infrastructure behaviour
- process tuning
- module args where appropriate
- output environment behaviour

It should not be used as the main place to define pipeline inputs such as matrix paths, contrasts, metadata, or GTF selection.

Those belong in the params file or explicit command-line pipeline arguments.

This distinction is important because mixing these layers makes launches harder to understand and more error-prone.

---

## Version pinning and reproducibility

White Lab downstream runs should normally pin the pipeline version explicitly using:

`-r`

This is good practice because it ensures that:

- a known version of the pipeline was used
- future reruns can target the same release
- the study record remains reproducible
- version drift is reduced across time

Even if newer versions later become available, the original study should retain the exact version used for the production run.

Where a new version is adopted later, that should be a deliberate decision and documented accordingly.

---

## Recommended parameter categories in a White Lab params file

A White Lab DGE params file will usually contain parameters from the following categories.

### Study identity and output
Examples include:
- study name
- output directory

### Input tables
Examples include:
- metadata / observations file
- contrasts file

### Matrix selection
Examples include:
- matrix file
- transcript length matrix if required

### Feature annotations
Examples include:
- GTF file
- features table if used instead

### Reporting options
Examples include:
- report behaviour
- Shiny app settings
- palette or display settings where needed

### Enrichment options
Examples include:
- GSEA enablement
- gene set files
- g:Profiler options

The exact contents may vary between studies, but this broad structure is useful to keep in mind when building templates later.

---

## RNA-seq matrix setup patterns in White Lab practice

For standard RNA-seq downstream analysis, there are two main launch patterns.

### Pattern 1. Raw counts plus transcript lengths
Use:

- `--matrix` with `salmon.merged.gene_counts.tsv`
- `--transcript_length_matrix` with `salmon.merged.gene_lengths.tsv`

This is the preferred route when the retained transcript lengths matrix is available and matches the selected counts matrix.

### Pattern 2. Bias-corrected counts without transcript length matrix
Use:

- `--matrix` with `salmon.merged.gene_counts_length_scaled.tsv`

or, if specifically justified:

- `--matrix` with `salmon.merged.gene_counts_scaled.tsv`

This pattern is appropriate when transcript lengths are not being passed separately.

The selected matrix strategy should always be documented clearly in the study launch files.

---

## Feature annotation strategy in White Lab RNA-seq runs

For standard gene-level RNA-seq DGE, the default White Lab annotation strategy should be:

### Prefer the matching GTF
Use the same or equivalent GTF annotation source that corresponds to the retained preprocessing outputs.

This helps maintain a clean annotation chain between preprocessing and downstream analysis.

### Use a features table only when there is a good reason
Supplying a custom features table may sometimes be useful, but it should not be the default starting point if the standard GTF-based route is available and appropriate.

### Avoid annotation ambiguity
The feature annotation source should match the matrix feature identity clearly. If this is unclear, the run should be paused and checked before launch.

---

## Shiny app setup in White Lab practice

The pipeline is capable of building a Shiny app output using ShinyNGS.

In White Lab downstream analysis, this should generally be seen as:

- a useful interactive review layer
- a valuable handover and exploration tool
- an optional but encouraged output for many standard runs

By default, app generation may be enabled and the built app can be retained inside the output directory structure.

For most White Lab use cases, the app should normally be built locally into the pipeline outputs rather than automatically deployed externally unless there is a specific reason to do so.

The use and interpretation of the Shiny outputs are described in more detail in `report-rmarkdown-and-shiny.md`.

---

## R Markdown report outputs in White Lab practice

The pipeline can also generate report materials that can be reused or customised later.

In White Lab terms, this is valuable because it supports:

- quick standard reporting
- further custom report editing
- communication of study results
- downstream adaptation for presentations or lab review

The pipeline-generated reporting layer should usually be treated as the first reporting pass, after which custom White Lab analysis summaries can be built if needed.

Again, this is covered in more detail in `report-rmarkdown-and-shiny.md`.

---

## Pathway analysis and resumed downstream runs

In White Lab practice, it is common to extend a DGE study through resumed runs or modified downstream runs that add enrichment layers such as:

- GSEA
- GO BP
- GO MF
- GO CC
- other gene set collections where appropriate

This means the initial launch should be thought of as part of a broader study lifecycle rather than as the only run the project will ever contain.

A clean launch structure makes these later extensions much easier to understand and manage.

The specific use of resumed runs and pathway layers is described in:

`resumed-runs-and-pathway-analysis.md`

---

## Recommended resume practice

The `-resume` flag should be used deliberately.

It is useful when:

- a run failed and should continue from cached completed steps
- a controlled extension of a previous run is being performed
- the same study is being rerun with unchanged relevant inputs

However, users should remember that resume behaviour depends on input identity and content, not only file names.

In White Lab practice, resumed execution is helpful, but it should not be used in place of proper launch documentation.

A user should always be able to explain:

- which original run is being resumed
- what has changed since the prior run
- whether the resumed run is functionally equivalent to the original or represents a new analysis layer

---

## CREATE execution environment principles

For CREATE-based use, White Lab should normally follow the same broad execution philosophy used in the preprocessing repo.

### Prefer containerised execution
Use Singularity where appropriate for reproducibility and consistency.

### Keep infrastructure settings centralised
Use a stable CREATE config template rather than scattering infrastructure settings across commands.

### Avoid launching into the repo
All working directories, logs, and outputs should remain in the live CREATE project space.

### Keep launch files human-readable
A study should be understandable from its launch files without reconstructing the command from shell history.

---

## Large-study considerations

For larger studies with high sample numbers, some reporting steps may become expensive or unstable.

In such cases, it may be appropriate to disable heavy reporting processes while preserving the core differential analysis outputs.

This should be treated as an intentional run design choice and documented clearly in the study launch record.

If reporting is reduced for scale reasons, the project should record:

- which reporting steps were disabled
- why this was done
- what interpretation outputs remain available
- whether an alternative reporting strategy will be used later

Large-cohort adjustments should be a documented exception, not an invisible shortcut.

---

## Suggested White Lab launch checklist

Before launching a downstream DGE run, confirm all of the following.

### Inputs
- the selected matrix is the correct one for the analysis strategy
- transcript lengths are supplied if raw counts are used
- the metadata file matches the matrix
- the contrasts file matches the metadata
- the annotation source is appropriate

### Launch definition
- the params file is complete and readable
- the config file contains only infrastructure/resource logic
- the output directory is correct
- the study name and run identity are clear
- the pipeline version is pinned

### Provenance
- the retained preprocessing package has been identified clearly
- the launch files are stored in the live project
- the command is documented
- the intended comparison is explicit

If any of these are unclear, the run setup should be fixed before execution.

---

## Common mistakes to avoid

### Putting pipeline parameters into the config file
This is one of the most important setup mistakes.

### Launching without a pinned pipeline version
This weakens reproducibility and makes later comparison harder.

### Running from copied files with weak provenance
The launch should point back clearly to the retained upstream study package.

### Using the wrong matrix strategy
For example, passing raw counts without transcript lengths.

### Treating resume as a substitute for documentation
A resumed run still needs a clear recorded rationale.

### Mixing too many changes into one rerun
If the matrix, contrasts, and enrichment settings all change at once, it becomes much harder to track what the run actually represents.

---

## White Lab recommended run setup summary

A standard White Lab RNA-seq downstream DGE run should usually be:

- launched outside the repo in a live CREATE project
- driven by a YAML params file
- supported by a separate CREATE config file
- version pinned with `-r`
- containerised with a suitable profile such as Singularity
- linked clearly to the retained upstream preprocessing package
- documented well enough for another lab member to understand later

This structure makes downstream DGE runs easier to reproduce, extend, interpret, and retain.

---

## Relationship to the next documentation pages

This page explains how the pipeline should be set up conceptually for launch.

The next document should explain how the live project is organised outside the repo.

The next document to read is:

[`create-run-structure.md`](create-run-structure.md)
