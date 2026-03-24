# CREATE downstream project template

This directory provides the reusable White Lab template for a live CREATE downstream bulk RNA-seq differential gene expression project.

It is designed to be copied into a new study-specific CREATE project directory and then edited to match the needs of the real analysis.

This template reflects the White Lab structure described in the documentation and is intended to support:

- a standard initial DGE run
- later resumed pathway or reporting extensions
- clear separation of inputs, launch files, logs, and retained run metadata
- reproducible handover from retained upstream preprocessing outputs

---

## What this template is for

This template is the recommended starting point for creating a new live CREATE project for downstream DGE analysis.

It provides a clean project skeleton that helps users organise:

- study notes
- launch definitions
- input files
- logs
- run metadata

This should make a new study easier to understand, easier to reproduce, and easier to retain later.

---

## What this template is not for

This directory is not:

- a worked example
- a completed real study
- the retained downstream package
- a substitute for reading the docs

Users should read the relevant documentation first, then use this template to set up the live project, and finally use the worked example as a reference where needed.

---

## Recommended usage

A good workflow is:

1. copy this `create_project/` directory into a new live CREATE study location
2. rename or adapt the study-level `README`
3. populate `inputs/` with the real metadata, contrasts, manifests, and gene set files as needed
4. update the files in `launch/` for the specific study
5. preserve launch logs and notes in `logs/`
6. record run summaries and manifests in `retained_run_metadata/`
7. keep all real execution outside the repo

The template should therefore be treated as the reusable source, not as the execution location itself.

---

## Staging archived inputs for live CREATE execution

This template is intended for live execution on CREATE using scratch-accessible files.

Before running the pipeline, users should:

1. create the live study root on scratch
2. populate `launch/` with the study launch files
3. populate `inputs/` with the study metadata and contrasts
4. stage required archived preprocessing outputs into a scratch-local directory such as:

   `quantification/`

5. ensure that any GTF or feature annotation file used in the run is accessible from scratch

A typical live project may therefore contain:

- `launch/create.config`
- `launch/params.initial.yaml`
- `launch/run_initial.sh`
- `inputs/sample_metadata.csv`
- `inputs/contrasts.initial.csv`
- `quantification/salmon.merged.gene_counts.tsv`
- `quantification/salmon.merged.gene_lengths.tsv`

Archived retained preprocessing outputs on RDS should be treated as the source of truth, but not as direct compute-node inputs for downstream execution. In the validated White Lab CREATE launch pattern, the study params file should normally use absolute scratch-accessible paths for metadata, contrasts, matrices, and annotation files. The output directory is usually created dynamically by the launch script and passed with `--outdir` at run time.

---

## Template directory structure

This template contains the following main components.

### `README.template.md`
A starter README for the live CREATE study.

This should be copied or renamed to become the study-level `README.md` in the real project.

### `launch/`
Contains the files used to define and launch the run.

This includes:

- params files
- CREATE config
- launch scripts for initial and resumed runs

### `inputs/`
Contains the study-specific input files used for downstream DGE.

This includes:

- metadata
- contrasts
- input manifest notes
- optional pathway gene set files

### `logs/`
Provides a place to store launch logs, run notes, and related operational records.

### `retained_run_metadata/`
Provides a place to store compact run manifests and study summaries that help preserve the identity of the run independently of shell history.

---

## Principles behind this template

This structure is based on several White Lab principles.

### Keep the study root readable
A user should be able to open the project root and understand the study quickly.

### Keep launch logic together
All launch definitions should live in `launch/`.

### Keep design inputs together
Metadata, contrasts, and pathway input files should live in `inputs/`.

### Keep logs deliberate
Run logs and notes should be written to `logs/`, not left only in terminal history.

### Keep run identity explicit
Run manifests and summaries should be written to `retained_run_metadata/`.

This project structure is intended to support clarity across the entire study lifecycle.

---

## Relationship to upstream preprocessing

A downstream CREATE project built from this template should begin from a retained upstream preprocessing package.

That means the real project should point clearly back to:

- the retained quantification outputs
- the retained metadata and provenance files
- the upstream processing run package used as the handoff source

This template does not include those retained upstream outputs directly. Instead, it provides the structure for documenting and consuming them properly in a downstream live project.

---

## Relationship to examples

The worked example in `examples/` shows what a real downstream study looks like after this structure has been applied in practice.

The relationship is:

- `templates/` = clean starting point
- `examples/` = educational reference implementation

Users should therefore create new studies from this template and use the example only as a reference point.

---

## Files that should usually be edited first

When starting a new study, the files most likely to need early editing are:

- `README.template.md`
- files in `launch/`
- files in `inputs/`
- files in `retained_run_metadata/` if preparing run summary templates in advance

The `logs/` directory is more likely to be populated during or after execution rather than edited in advance.

---

## Expected study lifecycle

A live CREATE study based on this template will usually progress like this:

1. instantiate the template into a study-specific CREATE directory
2. define the study README
3. populate metadata, contrasts, and input manifest files
4. define the initial params file and launch script
5. run the initial DGE analysis
6. add resumed pathway or reporting runs if needed
7. record the important run metadata
8. review outputs and decide what should later be retained long-term

This workflow should remain consistent across White Lab downstream DGE studies wherever possible.

---

## Current scope of this template

This template is intended for:

- bulk short-read RNA-seq
- gene-level downstream DGE
- input from retained White Lab preprocessing outputs
- `nf-core/differentialabundance` execution on CREATE
- optional pathway and report extension runs

As the repo develops, additional templates may be added for more specialised use cases, but this initial template should remain a strong default starting point.

---

## Next step

The next file to read is:

`README.template.md`
