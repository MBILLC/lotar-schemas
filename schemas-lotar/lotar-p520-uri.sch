<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for NAS9300-520 P520_Manifest URI-typed fields
  ==================================================================================================

  Base schema (UNMODIFIED): P520_SCHEMA.xsd + the shared P500_Series_Common.xsd it imports.

  Conformance identifier: LOTAR-P520-URI

  Companion to P520_SCHEMA.xsd, not a replacement. Since 2026-09-05 (D-23) it is one of TWO
  Schematron layers for P520_SCHEMA.xsd: lotar-p520-archival.sch carries the test-case fixity/role/
  URI rules (P520-ARCH-100..103, integrated from P515) and the scenario-evidence guard
  (P520-ARCH-003); this file stays scoped to the URI-restriction concern raised 2026-07-22 plus
  the Implements/Link placement rule (P520-ARCH-002). Kept as separate files (OD-I5). A broader
  [M]/[R]/[I] mandate inventory for the rest of the manifest has still not been built.
  GeneralPLMInfo's own Copyright/License/Export_Controls/Model_Dependency/Model_Hierarchy/
  Privacy_Rules/ModelLinking-Link fields are already covered by lotar-p500-uri.sch (shared across
  every P5xx part) and are NOT restated here.

  Origin (2026-07-22): Model_Summary_Report is typed xs:anyURI in P520_SCHEMA.xsd ("URI to the
  summary report of the model verification/validation") — a co-archived-artifact reference in the
  same sense as SSP's Component/@source or STC's Resource/@source (documents the model's own V&V
  summary, which LOTAR's entire premise requires to be retrievable alongside the model decades
  later, not dependent on the producer's original filesystem or network location). Same four
  lettered failure modes as lotar-ssp2.0.1-archival.sch's SSP-ARCH-050 pattern (absolute/network
  path, backslash, scheme-or-drive-letter, ".." traversal) — see that file's header for the full
  rationale, not repeated here.

  NOTE: P510_SCHEMA.xsd declares a structurally identical Model_Summary_Report element (own
  p510# namespace, same xs:anyURI type, same documentation pattern) — out of scope for this file
  (this project's current work is P520 — P515 integrated into it 2026-09-05, D-23 — per the
  project's own scope statement), but the
  identical rule (context "//p510:Model_Summary_Report", same four assertions) would apply
  verbatim if/when a P510 Schematron layer is built. P550_SCHEMA.xsd's staticLink (also
  xs:anyURI) is likewise out of scope here for the same reason.

  Existence-on-disk is out of scope here — Schematron has no filesystem access; see the companion
  script lotar_uri_resolve_check.py.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with every other LOTAR
  Schematron profile in this project.

  Pattern 2 (P520-ARCH-002), added 2026-08-06 (D-21/D-21b), REVISED 2026-10-28 (D-25, WG decision
  S3 — see planning/WG_Decision_Request_Single_500_Series_Archive.md): Verification_Validation_
  Scenario_Type's Implements element (p520:Implements, type p500:Traceability_Link_Type) links a
  scenario's Model Report to its governing CDP/DTMD record. Since D-25 all 500-series artifacts of a
  baseline live in ONE archive, and the governing decision record has exactly ONE canonical copy at
  archive level, p520/_decisions/<guid>.dtmd (S3), referenced from every P520 manifest of the
  baseline by an archive-root-relative locator. The D-21b per-model-folder sibling copy is dropped;
  the package-INTERNAL copy an SSP/FMU carries under its own top-level extra/ (D-20, STMD-ARCH-04)
  stays, and lotar-tools' archive mode verifies it is byte-identical to the canonical one (the
  stale-copy gap noted in LOTAR_CDP_Top_Level_Packaging_Analysis.md is thereby closed).

  Rules: Link present (002a), under p520/_decisions/ (002b — replaces the former "bare filename"
  rule), no backslash (002c), ends in .dtmd (002d), Name = "implements" (002e), Target_Id =
  urn:uuid:<GUID> (002f), Type = Archive or absent (002g). P500-ARCH-001/002 (lotar-p500-uri.sch)
  still apply to Implements generically. Existence on disk, and that Target_Id's GUID equals the
  GUID attribute of the .dtmd at Link, are checked by lotar-tools (archive mode), not here.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for NAS9300-520 P520_Manifest URI-typed fields</title>

  <ns prefix="p520" uri="http://www.lotar.org/schemas/mbse/p520#"/>
  <ns prefix="p500" uri="http://www.lotar.org/schemas/mbse/p500#"/>

  <pattern id="p520-model-summary-report-uri-relative-only">

    <rule context="//p520:Model_Summary_Report" id="P520-ARCH-001">
      <assert test="not(starts-with(text(),'/'))" id="P520-ARCH-001a" role="error">
        [P520-ARCH-001a][I] Model_Summary_Report must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(contains(text(),'\'))" id="P520-ARCH-001b" role="error">
        [P520-ARCH-001b][I] Model_Summary_Report must not contain a backslash.
      </assert>
      <assert test="not(contains(substring-before(concat(text(),'/'),'/'),':'))"
              id="P520-ARCH-001c" role="error">
        [P520-ARCH-001c][I] Model_Summary_Report must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(contains(concat('/',text(),'/'),'/../'))" id="P520-ARCH-001d" role="error">
        [P520-ARCH-001d][I] Model_Summary_Report must not contain a ".." path segment.
      </assert>
    </rule>

  </pattern>

  <pattern id="p520-implements-dtmd-link">

    <rule context="//p520:Implements" id="P520-ARCH-002">
      <assert test="p500:Link" id="P520-ARCH-002a" role="error">
        [P520-ARCH-002a][M] Implements must carry a Link to the governing DTMD instance (D-21).
      </assert>
      <assert test="not(p500:Link) or starts-with(p500:Link,'p520/_decisions/')" id="P520-ARCH-002b" role="error">
        [P520-ARCH-002b][M] Implements/Link must locate the archive's canonical decision record,
        "p520/_decisions/&lt;guid&gt;.dtmd" (archive-root-relative, D-25/S3) — not a per-model
        sibling copy (the pre-D-25 D-21b layout) and not a copy inside the SSP/FMU package.
      </assert>
      <assert test="not(contains(p500:Link,'\'))" id="P520-ARCH-002c" role="error">
        [P520-ARCH-002c][M] Implements/Link must not contain a backslash.
      </assert>
      <assert test="not(p500:Link) or substring(p500:Link, string-length(p500:Link) - 4) = '.dtmd'"
              id="P520-ARCH-002d" role="error">
        [P520-ARCH-002d][M] Implements/Link must reference a .dtmd file — the governing CDP decision
        record, not some other artifact.
      </assert>
      <assert test="p500:Name = 'implements'" id="P520-ARCH-002e" role="error">
        [P520-ARCH-002e][M] Implements/Name must read exactly "implements" (D-21's normative
        relation label).
      </assert>
      <assert test="starts-with(p500:Target_Id,'urn:uuid:')" id="P520-ARCH-002f" role="error">
        [P520-ARCH-002f][M] Implements/Target_Id must identify the decision record by its GUID as
        "urn:uuid:&lt;GUID&gt;" (D-25/S2) — the identifier that survives relocation.
      </assert>
      <assert test="not(p500:Type) or p500:Type = 'Archive'" id="P520-ARCH-002g" role="error">
        [P520-ARCH-002g][M] Implements/Type must be "Archive" (or absent): the governing decision
        record is always in the same 500-series archive as the model it governs (D-25/S3).
      </assert>
    </rule>

  </pattern>

</schema>
