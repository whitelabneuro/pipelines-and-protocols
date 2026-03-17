# CREATE execution model decisions
Date: 2026-03-17

## Decision 1: active runs on project scratch
Active RNA-seq runs will be executed under:
`/scratch/prj/bcn_whitema_rbp`

Rationale:
- suitable for heavy temporary workflow I/O
- appropriate for Nextflow work directories and active outputs

## Decision 2: Nextflow state on user scratch
Nextflow runstate, cache, and Singularity cache will be stored under:
`/scratch/users/k1643702`

Rationale:
- reduces risk of file-lock issues
- keeps lock-sensitive state away from shared project execution directories

## Decision 3: selected validated outputs archived to RDS
Selected final outputs, manifests, and summaries will be copied to:
`/rds/prj/bcn_whitema_rbp`

Rationale:
- more durable storage for retained outputs
- separates live execution from longer-term retention

## Decision 4: launcher pattern
The White Lab CREATE launcher will retain:
- SLURM submission wrapper
- pinned Nextflow version
- pinned `nf-core/rnaseq` version
- reusable outdir recording
- resume-aware execution

Rationale:
- this pattern already works in practice for CREATE
- should be formalised rather than replaced
