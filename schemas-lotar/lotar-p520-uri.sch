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

  Pattern 2 (P520-ARCH-002), added 2026-08-06 (D-21/D-21b): Verification_Validation_Scenario_Type's
  new Implements element (p520:Implements, type p500:Traceability_Link_Type — see P520_SCHEMA.xsd's
  own documentation on that element) links a scenario's Model Report to its governing CDP/DTMD
  record. Per D-21b (LOTAR_Risk_Profile_Process_Plan_2026-07-24.md, P520_Risk_Profile_Normative_
  Clause.md §5.7), the governing .dtmd file is placed as a direct SIBLING of P520_Manifest.xml
  itself (same folder, no subdirectory) — deliberately stricter than P500-ARCH-001's general
  "relative, no .. traversal" rule for Traceability_Link_Type's Link element, since "same folder"
  additionally forbids ANY path separator, not just ".." segments. P500-ARCH-001 (lotar-p500-uri.sch)
  still applies to Implements/Link too (it matches any p500:Link generically) — this pattern adds
  the extra bare-filename and .dtmd-suffix constraints, plus the Name="implements" relation-label
  mandate, on top of it. Existence-on-disk and same-directory colocation are, as with every other
  file reference in this project, out of scope for Schematron — the companion script
  lotar_uri_resolve_check.py's existing, generic "Link (p500)" entry (base_kind "", resolves against
  the directory of the containing file) already does the right thing here with no changes, since
  P520_Manifest.xml is that containing file by construction.
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
      <assert test="not(p500:Link) or not(contains(p500:Link,'/'))" id="P520-ARCH-002b" role="error">
        [P520-ARCH-002b][M] Implements/Link must be a bare filename with no path separator at all —
        the governing .dtmd file is required to sit as a direct sibling of P520_Manifest.xml itself
        (D-21b), not merely somewhere relative to it.
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
    </rule>

  </pattern>

</schema>
