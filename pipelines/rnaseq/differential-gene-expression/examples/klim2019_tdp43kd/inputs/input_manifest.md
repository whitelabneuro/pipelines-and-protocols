# Input manifest

This file records the relationship between the archived retained preprocessing package for the Klim 2019 TDP-43 knockdown study and the scratch-local inputs used for live downstream DGE execution on CREATE.

This distinction is important in White Lab practice:

- the retained preprocessing package on RDS is the archival source of truth
- the live downstream run on CREATE must use scratch-local copies or staged inputs
- CREATE compute jobs cannot access RDS directly

---

## Study identity

### Study name
`Klim 2019 TDP-43 knockdown motor neuron RNA-seq`

### Study ID
`klim2019_tdp43kd`

### CREATE project ID
`Klim_TDP_LOF`

---

## Archived upstream retained preprocessing package

### Archived study-level retained directory
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/`

### Archived retained primary-processing package
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/primary_processing/out_20260318_133306/`

### Archived quantification directory
`/rds/prj/bcn_whitema_rbp/RNA_seq_studies/Data_processed/GSE135041_Klim2019_TDP43KD_motor_neurons/primary_processing/out_20260318_133306/quantification/`

### Archived metadata / provenance files
- `sample_metadata.csv`
- `run_metadata.yaml`
- `samplesheet_with_bams.csv`
- `run_manifest.txt`

### Archived QC / pipeline context
- `multiqc/`
- `pipeline_info/`

---

## Scratch-local inputs for live downstream execution

These are the files that should be copied or staged into scratch for actual CREATE runs.

### Scratch project root
`[PATH_TO_LIVE_SCRATCH_DOWNSTREAM_PROJECT]`

### Scratch-local quantification directory
`[PATH_TO_SCRATCH_LOCAL_QUANTIFICATION_DIR]`

### Scratch-local selected matrix file
`[PATH_TO_SCRATCH_LOCAL_QUANTIFICATION_DIR]/salmon.merged.gene_counts.tsv`

### Scratch-local transcript length matrix
`[PATH_TO_SCRATCH_LOCAL_QUANTIFICATION_DIR]/salmon.merged.gene_lengths.tsv`

### Scratch-local GTF or feature annotation source
`[PATH_TO_SCRATCH_LOCAL_GTF_OR_FEATURES_FILE]`

### Scratch-local metadata file used for launch
`inputs/sample_metadata.csv`

### Scratch-local contrasts file used for launch
`inputs/contrasts.initial.csv`

---

## Matrix strategy

### Selected downstream strategy
`raw gene counts plus transcript lengths`

### Selected matrix file
`salmon.merged.gene_counts.tsv`

### Selected transcript length matrix
`salmon.merged.gene_lengths.tsv`

### Strategy note
This example uses the White Lab preferred default strategy of raw gene counts together with transcript lengths for downstream `nf-core/differentialabundance` analysis.

---

## Initial downstream comparison

### Initial contrast
`control_scramble` vs `tdp43kd`

### Initial analysis subset
The first validation run is intended to compare the six scramble-control samples against the six TDP-43 knockdown samples.

### Additional sample groups present in the archived study
- `control_none`
- `control_fluorescent`

These groups are retained in the metadata for completeness and future use, but are not part of the initial downstream validation contrast.

---

## Input verification checklist

Confirm the following before launch:

- the scratch-local matrix file is copied from the archived retained preprocessing package
- the scratch-local transcript length matrix is copied from the archived retained preprocessing package
- the metadata sample IDs match the matrix sample IDs exactly
- the contrasts file matches the metadata values exactly
- the GTF or features source is accessible from scratch during execution
- no CREATE compute job is configured to read directly from RDS

---

## Notes

This manifest should be updated once the live scratch project path and staged scratch input paths are finalised for the actual CREATE validation run.
