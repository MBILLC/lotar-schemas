# Changelog

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
