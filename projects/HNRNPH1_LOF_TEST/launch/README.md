# HNRNPH1_LOF_TEST launch files

This directory contains the project-facing launch and metadata files for primary RNA-seq preprocessing of the `HNRNPH1_LOF_TEST` dataset on CREATE HPC using the reusable White Lab `nfcore-rnaseq-processing` workflow.

These files are copied and adapted from the reusable workflow templates. They are specific to this project and should be edited here, not in the reusable pipeline template directories.

## Files in this directory

### `nextflow_run.sh`
SLURM launcher for the project.

This script:

- defines the project ID and dataset ID
- points to the project scratch structure on CREATE
- points to the chosen reference FASTA and GTF
- generates a canonical samplesheet before launch
- creates a timestamped output directory unless resuming
- records a simple run manifest
- launches `nf-core/rnaseq`

Important project values currently set:

- `PROJECT_ID=HNRNPH1_LOF_TEST`
- `DATASET_ID=h1_kolf_hnrnph1_lof_11j_rnaseq`
- `nf-core/rnaseq=3.23.0`
- `Nextflow=25.10.4`
- `aligner=star_salmon`

## `nextflow.config`
Project-local CREATE configuration.

This is a lightweight copy of the standard White Lab CREATE config and controls:

- retry behaviour
- Singularity enablement
- Singularity cache location

This file will usually remain unchanged unless:

- the CREATE username changes
- cache paths need to be updated
- project-specific execution behaviour requires adjustment

## `samplesheet.csv`
Editable project samplesheet used as the source input for preprocessing.

Expected columns:

- `sample`
- `fastq_1`
- `fastq_2`
- `strandedness`

For this project, sample identities are populated, but FASTQ file paths should be treated as requiring confirmation against the actual delivered files before launch.

## `samplesheet.canon.csv`
Derived canonical samplesheet generated automatically from `samplesheet.csv`.

This file should:

- not be manually edited
- be regenerated using `make_canonical_samplesheet.sh`

The canonical version is used to ensure:

- FASTQ paths are resolved consistently
- missing files are detected before launch

## `sample_metadata.csv`
Richer sample-level metadata for the project.

This file captures:

- sample identity
- combined condition label
- main experimental factors:
  - `perturbation`
  - `treatment`
- model/line distinction:
  - `cell_line`
  - `genotype`
- biological replication structure
- reference and library metadata
- project notes

For this dataset, an important design principle is preserved explicitly:

- `n=4` represents **biological replicates**
- each replicate corresponds to an **independent differentiation batch**

## `run_metadata.yaml`
Run-level project metadata.

This file records:

- project and dataset identifiers
- execution paths on CREATE
- pipeline and version information
- dataset summary
- reference genome and annotation choice
- project role and design summary
- notes requiring later confirmation

This file is intended to give a concise provenance record for the preprocessing run.

## `make_canonical_samplesheet.sh`
Helper script used to generate `samplesheet.canon.csv` from `samplesheet.csv`.

This script:

- checks the expected header
- checks required fields are present
- canonicalises FASTQ paths with `readlink -f`
- verifies both FASTQ files exist
- writes the derived canonical samplesheet

## Current project-specific points to confirm before launch

The following items should be checked and updated before running preprocessing:

1. **FASTQ filenames and paths**
   - confirm the actual delivered FASTQ names
   - update `samplesheet.csv` if filenames differ from the current placeholder pattern

2. **Read length**
   - currently left as `unknown` in project metadata
   - update once confirmed from sequencing delivery information

3. **Library preparation details**
   - currently left as `unknown`
   - update if confirmed from vendor documentation or sequencing paperwork

4. **Final strandedness interpretation**
   - `samplesheet.csv` currently uses `auto`
   - retain unless a confirmed library strandedness is known and should be enforced

5. **CREATE user path assumptions**
   - current config assumes launch under user `k1643702`
   - update cache paths if another user executes the run

## Project design reminder

This dataset contains:

### Main KOLF arm
A 2 × 2 design in KOLF-1-3 cortical neurons:

- `scramble_control` vs `hnrnph1_shrna`
- `dmso` vs `nmd_inhibition`

### Secondary H1-tagged arm
A comparison arm in the endogenous H1-tagged H1-6a line:

- `scramble_control`
- `hnrnph1_shrna`

The endogenous tag distinction is important, but it is kept separate from the main perturbation and treatment factors in the metadata.

## Operational rule

Edit only:

- `samplesheet.csv`
- `sample_metadata.csv`
- `run_metadata.yaml`
- `nextflow_run.sh` if project-specific updates are needed

Do not manually maintain:

- `samplesheet.canon.csv`

## Related project files

For the broader project record, see:

- `../README.md`
- `../notes.md`

For the reusable workflow source and guidance, see:

- `pipelines/rnaseq/nfcore-rnaseq-processing/`
