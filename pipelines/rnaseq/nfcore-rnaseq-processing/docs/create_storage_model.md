# CREATE storage model

This document defines the standard White Lab storage model for running `nf-core/rnaseq` on King's College London CREATE HPC.

## Storage roles

### 1. Project scratch
Example:
`/scratch/prj/bcn_whitema_rbp`

Use for:
- active project directories
- FASTQ inputs for active runs
- workflow work directories
- live output directories
- run logs

Rationale:
- suitable for large active compute workloads
- appropriate for Nextflow work directories and large pipeline outputs

### 2. User scratch
Example:
`/scratch/users/k1643702`

Use for:
- Nextflow binary installation
- `.nextflow` state
- lock-sensitive runstate
- Nextflow cache
- Singularity/Apptainer cache

Rationale:
- avoids file-lock issues on shared filesystems
- keeps personal cache/state separate from project outputs

### 3. Project RDS
Example:
`/rds/prj/bcn_whitema_rbp`

Use for:
- selected completed outputs for longer-term retention
- archived run manifests
- run summary reports
- frozen metadata snapshots
- handoff files for downstream analyses

Rationale:
- more appropriate for durable storage than active scratch workspaces

### 4. Home directories
Examples:
`/users/k1643702`

Use for:
- lightweight scripts
- editing
- small text-based work only

Do not use for:
- FASTQ storage
- large outputs
- work directories
- container caches

## White Lab standard

Live execution should happen from project scratch, with Nextflow state and container cache on user scratch. Selected final outputs should be archived to RDS once a run is validated.
