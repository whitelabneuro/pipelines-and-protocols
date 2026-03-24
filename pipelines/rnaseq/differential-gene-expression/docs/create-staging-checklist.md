# CREATE staging checklist

This document provides a practical checklist for staging and launching a White Lab downstream bulk RNA-seq differential gene expression study on CREATE.

Its purpose is to make the transition from archived retained preprocessing outputs on RDS to live downstream execution on scratch as explicit and reproducible as possible.

This is an operational companion to:

- `create-run-structure.md`
- `nfcore-differentialabundance-run-setup.md`
- `retention-and-handover.md`

---

## Core principle

In White Lab practice:

- **RDS is the archive and retained source of truth**
- **scratch is the live execution location for downstream CREATE runs**

This means:

- archived preprocessing outputs should remain preserved on RDS
- the files required for a live downstream run must be staged into scratch-accessible locations
- CREATE compute jobs should not depend on direct access to RDS

---

## When to use this checklist

Use this checklist when:

- starting a new downstream DGE study on CREATE
- instantiating a live project from the repo templates
- preparing the first run from a retained preprocessing package
- checking whether a study is actually ready to submit

---

## Step 1. Create the live downstream project root on scratch

Create a study-specific live project directory on scratch.

Example:

`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/`

This should be the main live CREATE project root for the downstream study.

---

## Step 2. Create the core live project directories

Inside the project root, create the main working directories:

- `launch/`
- `inputs/`
- `quantification/`
- `logs/`
- `retained_run_metadata/`

A minimal runnable project will usually look like:

    /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/
    ├── launch/
    ├── inputs/
    ├── quantification/
    ├── logs/
    └── retained_run_metadata/

---

## Step 3. Copy the study launch files into `launch/`

The `launch/` directory should contain the files needed to define and launch the run.

For an initial standard DGE run, this will usually include:

For an initial standard DGE run, this will usually include:

- `create.config`
- `params.initial.yaml`
- `run_initial.sh`

In White Lab CREATE practice, `run_initial.sh` is typically a batch launch script that also handles:

- Java module loading
- scratch-local Nextflow bootstrap
- cache and runstate setup
- dynamic output directory creation
- compact run-manifest recording

---

## Step 4. Copy the study metadata and contrasts into `inputs/`

The `inputs/` directory should contain the study-specific design files required by the downstream pipeline.

For an initial standard DGE run, this will usually include:

- `sample_metadata.csv`
- `contrasts.initial.csv`

Optional later additions may include:

- additional contrasts files
- pathway gene set files
- custom background files
- an `input_manifest.md`

---

## Step 5. Stage required archived preprocessing outputs into `quantification/`

The archived retained preprocessing package on RDS remains the source of truth, but the downstream run must use scratch-local staged files.

For a standard White Lab initial DGE run, stage at least:

- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_lengths.tsv`

into:

`quantification/`

Example:

- `/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_counts.tsv`
- `/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_lengths.tsv`

If a different matrix strategy is being used, stage the appropriate alternative matrix instead.

---

## Step 6. Confirm the GTF or features source is scratch-accessible

The annotation source used in the downstream run must be readable from CREATE compute nodes.

This may be:

- a scratch-local copy
- another compute-node-accessible scratch location
- a project-accessible path outside the study root but still on scratch-accessible storage

Example:

`/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz`

Do not point the downstream run at an RDS-only path for compute execution.

---

## Step 7. Check the params file carefully

Before launch, confirm that the params file points only to scratch-accessible execution inputs.

For a standard run, check:

- `input`
- `contrasts`
- `matrix`
- `transcript_length_matrix` if used
- `gtf` or `features`

Make sure:

- paths are correct
- matrix strategy is explicit
- no compute-read input path points to RDS

Under the CREATE-native launch pattern validated in the Klim example, these paths should normally be absolute scratch-accessible paths.

The output directory should usually be created dynamically by the launch script and passed with `--outdir`, rather than fixed in the params file.

---

## Step 8. Check the working directory logic of the launch script

If the launch script uses relative paths such as:

- `launch/params.initial.yaml`
- `launch/create.config`
- `inputs/sample_metadata.csv`

then the script should `cd` into the project root before running Nextflow.

A good pattern is:

    cd /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge

before the `nextflow run` command.

This prevents path-resolution mistakes when submitting from a subdirectory such as `launch/`.

---

## Step 9. Make sure the logs directory exists

If the launch or SLURM submission script writes logs to:

`logs/`

then create that directory before submission.

Example:

    mkdir -p /scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/logs

This avoids avoidable early failures due to missing log output locations.

---

## Step 10. Verify matrix-to-metadata-to-contrast consistency

Before submitting, confirm all of the following:

- matrix sample IDs match metadata sample IDs exactly
- metadata contains the variable used by the contrast
- contrast reference and target values exist exactly in the metadata
- any exclusion columns or values are present and spelled correctly
- transcript lengths are supplied if raw counts are used

This is one of the most important pre-launch checks.

---

## Step 11. Confirm the minimal runnable project contents

Before the first launch, a minimal standard DGE project should usually contain at least:

### In `launch/`
- `create.config`
- `params.initial.yaml`
- `run_initial.sh`

### In `inputs/`
- `sample_metadata.csv`
- `contrasts.initial.csv`

### In `quantification/`
- `salmon.merged.gene_counts.tsv`
- `salmon.merged.gene_lengths.tsv`

### Elsewhere
- scratch-accessible GTF or features source
- `logs/` directory

If any of these are missing, the run may not yet be ready.

---

## Step 12. Submit the run

Once the project is staged and checked, launch the run using the agreed White Lab method.

Examples may include:

- running the launch script directly from the project root
- submitting the launch script via `sbatch`
- submitting a dedicated SLURM wrapper that runs the launch script

Whichever method is used, the run should remain clearly documented in:

- `logs/`
- `retained_run_metadata/`

---

## Common mistakes to avoid

### Pointing compute-node inputs directly at RDS
RDS is the archive, not the live execution input location.

### Forgetting to stage transcript lengths
If raw counts are used, transcript lengths must also be staged and supplied.

### Launching from the wrong directory
Relative paths can break if the script does not `cd` to the project root.

### Forgetting to create `logs/`
This can cause immediate SLURM output path problems.

### Mixing template and live project files
The live CREATE project should contain copied or instantiated files, not rely on editing the repo template in place.

### Losing the link to the archived retained preprocessing package
The live project should always remain traceable back to the upstream retained archive.

---

## Suggested first-run checklist

Before first submission, confirm:

- live project root exists on scratch
- `launch/`, `inputs/`, `quantification/`, `logs/`, and `retained_run_metadata/` exist
- launch files are in `launch/`
- metadata and contrasts are in `inputs/`
- required quantification files are staged in `quantification/`
- GTF is scratch-accessible
- params file paths are correct
- launch script changes into the project root
- matrix, metadata, and contrast values agree
- output directory name is set appropriately

If all of these are true, the study is ready for the first downstream CREATE run.

---

## Summary

A White Lab downstream CREATE run should begin from:

- an archived retained preprocessing package on RDS
- a scratch-local live downstream project on CREATE
- a staged set of scratch-accessible inputs for actual compute execution

The key operational rule is:

**archive on RDS, execute on scratch**

This checklist is intended to make that distinction explicit and to reduce avoidable setup mistakes for future studies.
