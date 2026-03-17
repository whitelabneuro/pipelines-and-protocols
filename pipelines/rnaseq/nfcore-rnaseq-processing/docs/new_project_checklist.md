# New project checklist

Use this checklist when setting up a new RNA-seq project on CREATE.

## Project identity

- [ ] Project ID chosen
- [ ] Dataset ID chosen
- [ ] Project purpose clearly defined

## CREATE project structure

- [ ] Project directory created on project scratch
- [ ] `launch/` directory created
- [ ] `logs/` directory created
- [ ] `work/` directory created

## Templates copied into project launch directory

- [ ] `nextflow_run.template.sh` copied and renamed to `nextflow_run.sh`
- [ ] `nextflow.config.template` copied and renamed to `nextflow.config`
- [ ] `samplesheet_template.csv` copied and renamed to `samplesheet.csv`
- [ ] `sample_metadata_template.csv` copied and renamed to `sample_metadata.csv`
- [ ] `run_metadata_template.yaml` copied and renamed to `run_metadata.yaml`
- [ ] `make_canonical_samplesheet.sh` copied into the launch directory

## Scripts and permissions

- [ ] `nextflow_run.sh` made executable
- [ ] `make_canonical_samplesheet.sh` made executable

## Project-facing file edits completed

- [ ] `nextflow_run.sh` updated for project ID
- [ ] `nextflow_run.sh` updated for dataset ID
- [ ] `nextflow_run.sh` updated for email address
- [ ] `nextflow_run.sh` reviewed for reference FASTA/GTF paths
- [ ] `nextflow.config` reviewed
- [ ] `samplesheet.csv` populated
- [ ] `sample_metadata.csv` populated
- [ ] `run_metadata.yaml` populated

## References and defaults confirmed

- [ ] Reference FASTA confirmed
- [ ] Reference GTF confirmed
- [ ] nf-core/rnaseq version confirmed
- [ ] Nextflow version confirmed
- [ ] CREATE-specific assumptions reviewed against repo defaults

## Repo guidance checked

- [ ] `docs/new_project_on_create.md` read
- [ ] `docs/templates_guide.md` read
- [ ] relevant template README files checked
- [ ] example folder consulted only if needed for illustration

## Setup complete

- [ ] Project structure is ready for later validation
- [ ] Project structure is ready for later execution
