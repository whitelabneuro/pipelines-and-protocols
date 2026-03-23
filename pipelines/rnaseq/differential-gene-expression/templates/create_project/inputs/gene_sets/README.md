# Gene sets

This directory is intended for pathway input files used by downstream extension runs, such as:

- Hallmark GMT files
- GO Biological Process GMT files
- GO Molecular Function GMT files
- GO Cellular Component GMT files
- curated pathway collections
- custom background files for enrichment where needed

These files are study-specific inputs for live CREATE projects and should be named clearly.

Examples of sensible filenames include:

- `h.all.v2024.1.Hs.symbols.gmt`
- `c5.go.bp.v2024.1.Hs.symbols.gmt`
- `c5.go.mf.v2024.1.Hs.symbols.gmt`
- `background_detected_genes.txt`

Keep enough context in the filename or nearby study notes that it remains obvious which collection and version were used.

This directory should not be confused with retained output directories or worked example outputs.
