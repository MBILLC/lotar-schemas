# Changelog

## 2026-10-28 — single 500-series archive (D-25; WG decisions S1–S6 accepted)

- **New `schemas-lotar/P500_Archive_Manifest.xsd`** (p500# namespace, includes `P500_Series_Common.xsd`):
  the top-level manifest of a 500-series archive (`lotar-500-manifest.xml` — package identifier/type/
  version, producer, baseline, one `Entry` per part manifest with fixity, canonical `Decision_Records`,
  schemas, package-level rights, identifier-only `External_References`, signature reference) and the
  `Baseline_Link_Set` record format of a metadata-only baseline link archive. Drafted by P520, owned by
  500/011–014. **New `schemas-lotar/lotar-p500-archive.sch`** (P500-ARCH-100..109).
- **`P500_Series_Common.xsd` link model revised:** `Traceability_Link_Type` gains the required
  `Target_Id` (persistent identifier) and optional `Target_Version`; `Link` is now optional and an
  archive-root-relative locator (with `#fragment`); `LinkTypeInterpretation` = `Local | Archive |
  External` (`Global` deprecated).
- **`lotar-p500-uri.sch`:** P500-ARCH-001 re-based on the archive root (+001e: no link into a package);
  new P500-ARCH-002a..e (identifier/locator consistency) and P500-ARCH-003 (fragment syntax).
- **`lotar-p520-uri.sch`:** P520-ARCH-002 rewritten — `Implements/Link` locates the archive's canonical
  record `p520/_decisions/<GUID>.dtmd` (002b), `Target_Id` = `urn:uuid:<GUID>` (002f), `Type` Archive
  (002g). The D-21b "bare filename sibling" rule is gone. `P520_SCHEMA.xsd` documentation updated.
- Fixtures migrated to the new link model (`lotar-p500-uri-test-*`, `lotar-p520-implements-test-*`,
  `lotar-p520-test-full-VALID`, `lotar-p520-archival/evidence-test-INVALID`); new
  `lotar-p500-archive-manifest-test-{VALID,INVALID}.xml`, `lotar-p500-baseline-links-test-VALID.xml`;
  four archive-shaped directory fixtures `fixtures-archive/lotar-aip-500-test-{VALID,
  INVALID-stale-dtmd-copy, INVALID-dangling-link, INVALID-fixity}`. The two D-21b directory fixtures
  retired to the project's `deprecated/`.

Verified with lotar-tools 0.2.0: `lotar ci` ALL CHECKS PASSED; `SSPExamples/EVRangeExampleV3_AIP`
passes `lotar check` (archive mode).

## 2026-09-22 — repository created

Split out of the LOTAR 2026 project folder: `schemas-lotar/`, `schemas-vendored/`, `vocabularies/`,
`fixtures/` moved unchanged; the eight directory-shaped resolver fixtures (`lotar-*-test-*`) moved
into `fixtures-archive/`. Same day:

- `lotar-stmd-archival.sch` **STMD-ARCH-04f** now forbids an inline credibility level in *any*
  Classification block of an archived STMD's GeneralInformation — `credibility.level` (the
  credible-process layer's keyword since D-24) as well as the retired `risk.level`. New fixture
  `fixtures/lotar-stmd-archival-inline-level-test-INVALID.xml` (fires exactly STMD-ARCH-04f).

Verified with lotar-tools 0.1.0: `lotar ci` ALL CHECKS PASSED; the EV-range worked example passes
`lotar check`.
