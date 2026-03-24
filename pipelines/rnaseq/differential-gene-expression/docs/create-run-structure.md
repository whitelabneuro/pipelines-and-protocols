# CREATE run structure

This document explains how live downstream differential gene expression projects should be organised on CREATE for the White Lab `differential-gene-expression/` workflow.

A central principle of this repo is that the repository should remain a reusable source of documentation, templates, configs, scripts, and worked examples. Real execution should happen outside the repo in live CREATE project directories.

This page therefore defines the White Lab structure for setting up and running a real downstream DGE study on CREATE while preserving:

- reproducibility
- provenance
- separation between repo and live execution
- clean handover from preprocessing to downstream analysis
- consistency across studies and users

---

## Core principle

The GitHub repo is the reusable source.

The live CREATE project is the execution environment.

These are related, but they are not the same thing and should not be mixed.

In practical terms:

- the repo contains templates, documentation, reference configs, helper scripts, and worked examples
- the live CREATE project contains study-specific launch files, copied templates, params files, logs, outputs, and run records

This separation is one of the most important structural decisions in the White Lab workflow.

---

## Why this separation matters

Keeping the repo and the live project separate makes it easier to:

- train new users consistently
- reuse the same structure across multiple studies
- avoid cluttering the repo with run-specific files
- preserve a clean distinction between template and execution
- make real analyses easier to audit and revisit later
- update the repo without overwriting study records

A downstream study should therefore be launched from a live CREATE directory that is informed by the repo, but not embedded inside it.

---

## Relationship to the upstream preprocessing workflow

This structure should be understood as the downstream counterpart to the upstream preprocessing project model already established in:

`pipelines/rnaseq/nfcore-rnaseq-processing/`

In White Lab practice:

- preprocessing is run in a live CREATE project
- key outputs are retained to RDS
- downstream DGE then starts from that retained package
- a new live downstream CREATE project is created for the DGE stage

This means the downstream CREATE project should point clearly back to the retained upstream package rather than duplicating or rebuilding the preprocessing stage.

---

## What belongs in the live CREATE project

A live downstream CREATE project should contain the files and directories needed to define, launch, track, and review a study-specific DGE run.

This typically includes:

- launch files
- params files
- CREATE config files
- copies of study-specific metadata and contrasts
- optional local manifests or notes
- output directories
- logs
- retained summaries of what was run

It may also contain convenience symlinks or copied lightweight inputs where useful, depending on lab preference, but the structure should always make the origin of those files clear.

---

## What should not belong in the repo

The GitHub repo should not become the place where live CREATE execution takes place.

The following should therefore remain outside the repo:

- work directories
- `.nextflow*` execution state files
- large live output trees
- transient rerun files
- temporary edited copies of study metadata
- scratch notes that define only one run and have no reusable value

If a file is useful only because of one specific live run and has no reusable or illustrative value, it probably belongs in the live project rather than in the repo.

---

## Recommended White Lab live project structure

A live CREATE downstream DGE study should usually have a clear top-level study directory.

A recommended structure is:

    <STUDY_PROJECT_DIR>/
    ├── README.md
    ├── launch/
    ├── inputs/
    ├── quantification/
    ├── logs/
    ├── retained_run_metadata/
    ├── work/
    └── out_<RUN_TIMESTAMP>/

This structure is intentionally simple and should be easy for a new user to understand.

The exact paths will depend on the CREATE project location, but the internal logic should stay consistent across studies.

---

## Purpose of each live project directory

### `README.md`
A short study-level overview of what this live project is, what retained upstream package it depends on, and what the major runs represent.

This file is extremely useful and should not be skipped.

It should allow another lab member to understand the project at a glance.

### `launch/`
Contains the files needed to define and launch the run.

Typical contents may include:

- params YAML files
- CREATE config files
- launch shell scripts
- contrast variants for specific reruns
- notes on run purpose

This is one of the most important directories in the live project.

### `inputs/`
Contains study-specific copies or links to the files used for launch.

Typical contents may include:

- metadata files
- contrasts files
- gene set files
- feature tables if used
- small local manifests describing the selected retained upstream inputs

Depending on lab preference, this may contain copied files or symlinks, but the provenance must remain clear.

### `logs/`
Contains saved launch logs, command records, and run notes.

This is useful for preserving:

- launch commands
- terminal captures
- error notes
- rerun rationale
- resume notes

### `out_<RUN_TIMESTAMP>/`
Contains the primary pipeline outputs for a particular run.

Timestamped output directories are strongly recommended because they make different runs easier to distinguish and retain.

### `work/`
Contains Nextflow working files if these are stored within the project.

Some groups prefer to place work directories elsewhere for storage or quota reasons. Either is acceptable so long as the location is documented clearly.

### `retained_run_metadata/`
Contains run-level metadata and summary files that should persist even if the full live execution environment changes later.

This might include:

- a copy of the params file used
- a copy of the config file used
- a launch command record
- pipeline version notes
- run summary notes
- references to the upstream retained package

This directory is highly recommended because it helps preserve the identity of the run independently of shell history.

---

## White Lab recommended launch directory layout

A good `launch/` directory might look like:

    launch/
    ├── params.initial.yaml
    ├── params.gsea_hallmark.yaml
    ├── params.gprofiler_go.yaml
    ├── create.config
    ├── run_initial.sh
    ├── run_gsea_hallmark_resume.sh
    └── run_notes.md

This is only an example, but it illustrates an important principle:

the launch directory should make it obvious which run definitions exist and how they differ.

Avoid vague file names such as:

- `params.yaml`
- `params2.yaml`
- `run_new.sh`
- `test_resume.sh`

Those names become difficult to interpret once several runs accumulate.

---

## White Lab recommended inputs directory layout

A good `inputs/` directory might look like:

    inputs/
    ├── sample_metadata.csv
    ├── contrasts.initial.csv
    ├── contrasts.gsea.csv
    ├── hallmark_2024.gmt
    ├── c5_go_bp_2024.gmt
    └── input_manifest.md

The purpose of `inputs/` is not to duplicate the entire retained preprocessing package. Rather, it should hold the study-specific downstream input files needed to define the run clearly.

The main retained quantification files may instead be referenced directly from the retained upstream location if that is the cleaner option.

---

## Referencing retained upstream inputs

A downstream CREATE project should be explicit about where its core upstream inputs come from.

There are two broad ways to handle this.

### Option 1. Reference retained upstream files in place
The downstream params file points directly to the retained preprocessing package on RDS or other long-term storage.

This is often the cleanest and most provenance-preserving option.

### Option 2. Create carefully documented local copies or symlinks
If needed for convenience or portability, a project may use copied or linked inputs in the live CREATE project.

If this is done, the origin of those files must be documented clearly.

White Lab should generally prefer whichever option keeps provenance clearest while avoiding unnecessary duplication.

---

## Staging inputs from archived retention into scratch

In White Lab practice, retained preprocessing outputs on RDS are the archival source of truth, but live CREATE downstream runs must use scratch-accessible files.

This means a downstream study should normally be set up as follows:

1. create a live downstream project root on scratch, for example:

   `/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/`

2. create the core live project directories:

   - `launch/`
   - `inputs/`
   - `quantification/`
   - `logs/`
   - `retained_run_metadata/`

3. copy or instantiate the relevant template files into the live project:

   - launch files into `launch/`
   - metadata and contrasts into `inputs/`

4. stage the required archived preprocessing outputs from RDS into scratch, usually into:

   `/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/`

5. ensure that any GTF or features file used by the downstream run is also accessible from scratch during execution

6. confirm that the downstream params file points only to scratch-accessible inputs for all files that will be read by CREATE compute jobs

The live CREATE run should never depend on direct compute-node access to archived RDS files.

---

## Recommended output naming practice

Each real run should have an output directory whose name makes it obvious:

- when the run was launched
- which run it corresponds to
- whether it is initial or extended if relevant

A good default pattern is:

- `out_YYYYMMDD_HHMMSS`

This mirrors the style already used successfully in the preprocessing workflow and makes chronology very easy to follow.

Where needed, a short suffix may also be added to distinguish major analysis phases, but this should be used sparingly and consistently.

---

## Handling multiple downstream runs within one study

A single study may involve more than one downstream run.

For example:

- an initial DGE run
- a resumed run adding GSEA
- a resumed run adding g:Profiler enrichment
- a rerun with updated contrasts
- a rerun with modified reporting settings

This is normal and should be expected.

The live CREATE structure should therefore make it easy to understand:

- which run came first
- which launch files belong to which run
- whether a later run is a resume or a distinct branch
- what changed between runs

Good naming and run notes are essential here.

---

## README expectation for a live CREATE study

Every live downstream CREATE project should ideally include a short `README.md`.

It does not need to be long, but it should state:

- study name
- biological context
- linked retained upstream preprocessing package
- main matrix strategy used
- current launch files of interest
- major run output directories
- any important caveats or special design features

This file is especially useful when returning to a study later or when handing the project over to another user.

---

## Suggested study-level provenance record

In addition to the live project README, White Lab should preserve a compact provenance record for each downstream run.

This should include:

- pipeline name
- pipeline version
- launch date
- params file used
- config file used
- matrix file used
- transcript length matrix used if applicable
- metadata file used
- contrasts file used
- feature annotation source used
- output directory
- whether the run was initial or resumed
- short note describing the purpose of the run

This information may be stored in:

- `retained_run_metadata/`
- a run manifest text file
- a launch notes markdown file
- or a combination of these

What matters most is that the information is easy to find and interpret.

---

## Recommended handling of logs

Logs should not be left only in terminal scrollback.

A good practice is to preserve:

- the exact launch command
- the standard output / error log if captured
- notes about failures or reruns
- resume context
- any manual decisions made during setup

These can be placed in `logs/` or reflected in `retained_run_metadata/`.

The aim is that another lab member should be able to reconstruct what happened without relying on memory.

---

## How this structure supports resumed runs

A well-organised live CREATE project makes resumed runs much easier to manage.

For example, if pathway analyses are added later, the project should make it easy to identify:

- the original run
- the modified params file
- the new gene set inputs
- the resumed launch script
- the new output directory
- the reason the run was extended

This is another reason why `launch/`, `inputs/`, `logs/`, and timestamped output directories are all useful.

---

## Interaction with RDS retention

The live CREATE project is not the final retention destination.

Instead, White Lab practice should normally be:

1. launch and execute in CREATE
2. review outputs
3. decide what should be retained long-term
4. move or copy the key downstream outputs to a structured RDS retained directory

This means the CREATE project is the active execution space, whereas RDS retention is the long-term study record.

The exact retained downstream structure is described in more detail in:

`retention-and-handover.md`

---

## White Lab practical rules

A few practical rules help keep live CREATE projects clean.

### One study, one clear project root
Do not scatter launch files across multiple unrelated folders.

### Keep launch files together
Params files, configs, and launch scripts should stay in `launch/`.

### Keep study-specific design files together
Metadata, contrasts, and gene set inputs should stay in `inputs/`.

### Preserve run identity
Every major run should be identifiable from its output directory and launch files.

### Do not rely on shell history alone
Important run information should be stored in files.

### Do not edit templates in place inside the repo for live use
Copy or instantiate them into the live project first.

These rules are simple but extremely helpful over time.

---

## Example conceptual layout for a real study

A White Lab downstream study might conceptually look like:

    /scratch/prj/<GROUP>/<STUDY_NAME>/
    ├── README.md
    ├── launch/
    │   ├── params.initial.yaml
    │   ├── params.gsea_hallmark.yaml
    │   ├── create.config
    │   ├── run_initial.sh
    │   └── run_gsea_hallmark_resume.sh
    ├── inputs/
    │   ├── sample_metadata.csv
    │   ├── contrasts.initial.csv
    │   ├── hallmark_2024.gmt
    │   └── input_manifest.md
    ├── logs/
    │   ├── launch_initial.log
    │   ├── launch_gsea_hallmark.log
    │   └── run_notes.md
    ├── out_20260323_103000/
    ├── out_20260324_141500/
    └── retained_run_metadata/
        ├── run_manifest_initial.txt
        ├── run_manifest_gsea_hallmark.txt
        └── pipeline_versions.md

This is not a mandatory exact filesystem layout, but it is a good model for how a clean live project should feel.

---

## Common mistakes to avoid

### Launching directly from the repo
This blurs the line between template and execution and should be avoided.

### Keeping only one generic params file name
This becomes confusing once multiple runs exist.

### Copying matrices into random folders with no provenance note
Every important input should remain traceable.

### Mixing logs, launch scripts, and analysis notes in the same directory
This makes projects much harder to read later.

### Failing to preserve what changed between resumed runs
A resumed run should still have a clear identity.

### Treating the CREATE project itself as the final archive
CREATE is the execution space, not the final retained record.

---

## White Lab recommendation on when to build the Klim example and test on CREATE

We are very close to the point where that becomes worthwhile.

My recommendation is:

### Build the Klim worked example structure once the core docs and top-level repo directories are defined
That means after we have at least:

- `docs/outputs-guide.md`
- `docs/report-rmarkdown-and-shiny.md`
- `docs/resumed-runs-and-pathway-analysis.md`
- `docs/retention-and-handover.md`

plus the top-level definitions for:

- `templates/`
- `configs/`
- `examples/`
- `decisions/`

At that point, the example can be built in a way that reflects the final intended repo design rather than needing major rewrites.

### Test on CREATE once the first template set exists
The best moment for a real CREATE test is when we have:

- a first reusable params template
- a first reusable CREATE config
- a draft live project structure
- a Klim example input set defined from the retained preprocessing outputs

That is the point where a real run starts becoming informative rather than premature.

In other words, I would **not** jump to CREATE yet, but I would aim to do it soon after we finish the core docs and the first template/config layer. That will let the test both validate the workflow and feed real output examples back into the repo.

---

## Summary

A White Lab downstream DGE project should run in a live CREATE study directory, not in the repo itself.

A good live project should clearly separate:

- launch files
- study inputs
- logs
- outputs
- retained run metadata

and it should preserve a clear link back to the retained upstream preprocessing package.

This structure keeps the repo reusable, the live project interpretable, and later retention much easier.

The next document to read is:

[`resumed-runs-and-pathway-analysis.md`](resumed-runs-and-pathway-analysis.md)
