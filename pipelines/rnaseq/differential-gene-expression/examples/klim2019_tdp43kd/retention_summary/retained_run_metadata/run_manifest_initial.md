# Run manifest

## Run identity

### Study name
`Klim 2019 TDP-43 knockdown motor neuron RNA-seq`

### Study ID
`klim2019_tdp43kd`

### Run name
`initial_dge`

### Run type
`INITIAL`

### Launch date
`2026-03-24`

### Output directory
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/out_20260324_105218/`

---

## Pipeline details

### Pipeline
`nf-core/differentialabundance`

### Pipeline version
`1.5.0`

### Profile
`singularity`

### CREATE config file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/launch/create.config`

### Params file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/launch/params.initial.yaml`

### Launch script
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/launch/run_initial.sh`

### Resume status
`YES`

### Resume note
The final successful launch followed early setup corrections for path resolution, local Nextflow bootstrap, and Singularity cache configuration.

---

## Linked upstream preprocessing package

### Upstream study / example
`klim2019_tdp43kd`

### Retained preprocessing package root
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/primary_processing/out_20260318_133306/`

### Upstream processing run ID
`out_20260318_133306`

---

## Downstream matrix strategy

### Matrix file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_counts.tsv`

### Transcript length matrix
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_lengths.tsv`

### Feature annotation source
`/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz`

### Matrix strategy note
Raw gene counts plus transcript lengths.

---

## Design files

### Metadata file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/sample_metadata.csv`

### Contrasts file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/contrasts.initial.csv`

### Design note
Initial validation run comparing `control_scramble` versus `tdp43kd`, excluding samples with `include_initial_dge = no`.

---

## Pathway and reporting settings

### GSEA enabled
`FALSE`

### g:Profiler enabled
`FALSE`

### Shiny app enabled
`TRUE`

---

## Outcome summary

### Run status
`COMPLETED`

### Main output review note
Initial successful downstream DGE run completed and produced the expected output directory structure.

### Caveats
Core output review and downstream retention packaging still to be completed before pathway extension runs.
