# Run manifest

## Run identity

### Study name
`Klim 2019 TDP-43 knockdown motor neuron RNA-seq`

### Study ID
`klim2019_tdp43kd`

### Run name
`gsea_hallmark`

### Run type
`EXTENSION`

### Launch date
`2026-03-24`

### Output directory
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/out_20260324_130120_gsea_hallmark/`

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
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/launch/params.gsea_hallmark.yaml`

### Launch script
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/launch/run_gsea_hallmark.sh`

### Resume status
`NO`

### Resume note
Fresh Hallmark extension run launched after successful validation of the baseline DGE layer.

---

## Linked baseline DGE run

### Baseline output directory
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/out_20260324_105218/`

### Rationale
This run extends the validated `control_scramble` versus `tdp43kd` baseline DGE analysis with Hallmark gene set enrichment.

---

## Input configuration

### Metadata file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/sample_metadata.csv`

### Contrasts file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/contrasts.gsea_hallmark.csv`

### Matrix
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_counts.tsv`

### Transcript lengths
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/quantification/salmon.merged.gene_lengths.tsv`

### GTF
`/scratch/users/k1643702/index_inputs/Homo_sapien_GRCh38/Gencode/gencode.v49.primary_assembly.annotation.gtf.gz`

### Gene set file
`/scratch/prj/bcn_whitema_rbp/Klim_TDP_LOF_dge/inputs/gene_sets/h.all.v2026.1.Hs.symbols.gmt`

---

## Outcome summary

### Run status
`COMPLETED`

### Main output review note
Completed output groups include:
- `other/`
- `pipeline_info/`
- `plots/`
- `report/`
- `shinyngs_app/`
- `tables/`

The Hallmark extension also produced a full GSEA results tree under:
- `report/gsea/condition_control_scramble_tdp43kd_hallmark/`

### Interpretation note
This run successfully added pathway-level enrichment outputs while preserving the validated baseline DGE analysis structure.

### Caveats
Biological interpretation of the Hallmark results is still pending and should be documented before further extension runs.
