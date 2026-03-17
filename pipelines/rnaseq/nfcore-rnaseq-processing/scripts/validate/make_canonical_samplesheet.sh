#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   bash make_canonical_samplesheet.sh samplesheet.csv samplesheet.canon.csv
#
# Expected input columns:
#   sample,fastq_1,fastq_2,strandedness

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <input_samplesheet.csv> <output_samplesheet.canon.csv>" >&2
  exit 1
fi

INPUT_CSV="$1"
OUTPUT_CSV="$2"

if [[ ! -f "$INPUT_CSV" ]]; then
  echo "ERROR: input samplesheet not found: $INPUT_CSV" >&2
  exit 1
fi

awk -F',' '
BEGIN {
  OFS=","
}
NR==1 {
  if ($1 != "sample" || $2 != "fastq_1" || $3 != "fastq_2" || $4 != "strandedness") {
    printf "ERROR: unexpected header in input samplesheet: %s,%s,%s,%s\n", $1, $2, $3, $4 > "/dev/stderr"
    exit 1
  }
  print
  next
}
{
  sample = $1
  fq1_in = $2
  fq2_in = $3
  strand = $4

  if (sample == "" || fq1_in == "" || fq2_in == "" || strand == "") {
    printf "ERROR: missing required field on line %d\n", NR > "/dev/stderr"
    exit 1
  }

  cmd1 = "readlink -f \"" fq1_in "\""
  if ((cmd1 | getline fq1) <= 0 || fq1 == "") {
    printf "ERROR: could not resolve fastq_1 for sample %s: %s\n", sample, fq1_in > "/dev/stderr"
    exit 1
  }
  close(cmd1)

  cmd2 = "readlink -f \"" fq2_in "\""
  if ((cmd2 | getline fq2) <= 0 || fq2 == "") {
    printf "ERROR: could not resolve fastq_2 for sample %s: %s\n", sample, fq2_in > "/dev/stderr"
    exit 1
  }
  close(cmd2)

  test1 = "test -f \"" fq1 "\""
  if (system(test1) != 0) {
    printf "ERROR: resolved fastq_1 does not exist for sample %s: %s\n", sample, fq1 > "/dev/stderr"
    exit 1
  }

  test2 = "test -f \"" fq2 "\""
  if (system(test2) != 0) {
    printf "ERROR: resolved fastq_2 does not exist for sample %s: %s\n", sample, fq2 > "/dev/stderr"
    exit 1
  }

  print sample, fq1, fq2, strand
}
' "$INPUT_CSV" > "$OUTPUT_CSV"

echo "Canonical samplesheet written to: $OUTPUT_CSV"
head -n 5 "$OUTPUT_CSV"
