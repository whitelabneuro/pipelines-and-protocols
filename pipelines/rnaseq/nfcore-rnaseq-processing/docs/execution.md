# Execution on CREATE

## Standard execution pattern

White Lab runs `nf-core/rnaseq` on CREATE using:

- SLURM submission for the launcher job
- project scratch for active workflow directories
- user scratch for Nextflow runstate and caches
- a recorded outdir per run to support robust resume behaviour

## Standard launcher

Primary launcher script:
`scripts/launch/nextflow_run.sh`

## Core behaviour

The launcher should:

1. define the project base directory on project scratch
2. create or reuse a run-specific output directory
3. place Nextflow lock-sensitive state on user scratch
4. keep the workflow `work/` directory on project scratch
5. record the active outdir for future resume
6. execute a pinned `nf-core/rnaseq` version
7. write stdout/stderr logs to the project log directory

## Resume modes

### First run
```bash
sbatch nextflow_run.sh
