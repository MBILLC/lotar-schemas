# lotar-schemas

Draft working material for **LOTAR NAS9300-520** (long-term archiving and retrieval of analytical
behavior models) and for the **500-series archive** that holds all MBSE artifacts of one baseline
(top-level manifest, link model — WG decision of 2026-10-15, executed 2026-10-28): the LOTAR-authored XML
schemas, the controlled vocabularies, the archival Schematron overlays on the base standards, and the
test fixtures that pin them down.

It builds on the industry-neutral credible-process layer
([credible-process-schemas](https://github.com/MBILLC/credible-process-schemas)): credibility
levels CL1–CL4, the DTMD/STMD/MTMD process profiles, signatures and role separation live there.
This repository adds only what archiving needs. The checks are run by
[lotar-tools](https://github.com/MBILLC/lotar-tools) (`lotar ci`, `lotar check`).

## Layout

| Folder | What |
|---|---|
| `schemas-lotar/` | LOTAR-authored XSDs (`P500_Series_Common`, `P500_Archive_Manifest` — the top-level manifest of a 500-series archive —, `P510`, `P520`, `P550`, `SRMDLOTARCore_Common`, `SRMDLOTARCore_P520`) and the Schematron that validates them (`lotar-p500-uri`, `lotar-p500-archive`, `lotar-p520-archival`, `lotar-p520-uri`) |
| `schemas-vendored/` | Base-standard schemas LOTAR validates against (SSP-LS-Traceability STC/SRMD/STMD/DTMD/MTMD, MIC/SIC Core, FMI-LS-REF, SSP common types, a minimal xlink.xsd), each with a provenance header, plus the LOTAR archival overlays written on top of them (`lotar-fmi2.0.5/fmi3.0.2/ssp2.0.1/ssv2.0.1/stc/srmd/stmd-archival.sch`, `lotar-fmi-ls-ref-uri.sch`) |
| `vocabularies/` | The controlled vocabularies (LOTAR Core Common, LOTAR Core P520 incl. `test-case.*`, status mapping, MIC/SIC Core mappings, FMI/SSP recommended vocabulary) |
| `fixtures/` | Single-file VALID/INVALID fixtures; each INVALID fixture fails with an exact, registered set of rule ids |
| `fixtures-archive/` | Directory-shaped fixtures: package layouts for the filesystem reference resolver, and whole 500-series archives (`lotar-aip-500-test-*`) for the archive mode of `lotar check` |

`schemas-lotar/` includes files from `schemas-vendored/` by relative path (`../schemas-vendored/`);
keep the two folders side by side.

## Checking

```
pip install -e ../lotar-tools          # pulls in credible-process-tools
lotar ci                                # compiles every schema and Schematron file, runs every fixture pair
lotar check <archive-root>...           # a 500-series archive (root holds lotar-500-manifest.xml): manifest, branches,
                                        #   decision-record copies, every package, cross-branch links; or a bare package
lotar manifest <archive-root>           # refresh fixity/size values in lotar-500-manifest.xml
```

Run from this folder or from a parent folder that contains it (or set `LOTAR_ROOT`).

## Status and licence

Draft material of the NAS9300-520 working group, hosted here temporarily. See `LICENSE` for the
LOTAR-authored files and `schemas-vendored/*_header.txt` / the header comments for each vendored
file's origin and licence.
