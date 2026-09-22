<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for P500_Series_Common.xsd URI-typed fields
  ==============================================================================================

  Base schema (UNMODIFIED): P500_Series_Common.xsd, the shared base imported by every NAS9300
  5xx-series manifest schema (P510, P515, P520, P550, ...).

  Conformance identifier: LOTAR-P500-URI

  Companion to P500_Series_Common.xsd, not a replacement. Since P500_Series_Common.xsd has no
  document root of its own (its types are only ever embedded inside a part-specific manifest —
  P510_Manifest, P515_Manifest, P520_Manifest, ...), this file's rules apply uniformly to any
  document that embeds p500:GeneralPLMInfoType or p500:Traceability_Link_Type, regardless of
  which part-specific schema it belongs to — one file, not one per part.

  Origin (2026-07-22): Copyright/License/Export_Controls/Model_Dependency/Model_Hierarchy/
  Privacy_Rules/Link are all typed xs:anyURI in the base schema.

  IMPORTANT SCOPE DISTINCTION from the SSP/STC/SRMD/fmi-ls-ref URI patterns elsewhere in this
  project (lotar-ssp2.0.1-archival.sch's SSP-ARCH-050, lotar-stc-archival.sch's STC-ARCH-110/111,
  lotar-srmd-archival.sch's SRMD-ARCH-100c-f, lotar-fmi-ls-ref-uri.sch's FMILSREF-ARCH-001): those
  attributes are genuine "this artifact is co-archived alongside the document" resource locators,
  so they are mandated to be package-relative. The P500 fields below are semantically different —
  Copyright/License/Export_Controls/Model_Dependency/Model_Hierarchy/Privacy_Rules are rights,
  policy, and dependency IDENTIFIERS/REFERENCES, not resource locators for files that need to be
  co-archived. Real-corpus evidence confirms this: the project's own P515 test fixture
  (FMISchematron/lotar-p515-test-valid.xml) uses values like "urn:copyright:example",
  "urn:license:example", "urn:export:none" for exactly these fields — legitimate absolute
  identifier references with a urn: scheme, which the SSP-ARCH-050-style relative-only mandate
  would incorrectly reject. A license field in particular is very often meant to point to a
  public, canonical, external URL (e.g. https://creativecommons.org/licenses/by/4.0/) — forcing
  that to be package-relative would be actively wrong, not just inconvenient.

  So this file applies a DELIBERATELY LIGHTER rule to those six fields: reject only values that
  leak a producer-local filesystem path (Windows backslash path, bare drive-letter-absolute path,
  or file: scheme) — values that are not just non-portable but actively meaningless to any future
  reader who isn't sitting at the original producer's machine. Genuine external identifiers/URLs
  (urn:..., https://..., doi:...) remain fully permitted. This mirrors the same no-local-leakage
  rule already applied to STC's Resource/@master (lotar-stc-archival.sch's STC-ARCH-110e-g), which
  is semantically the same kind of field (a reference to something outside the archived package,
  by design).

  Link (inside Traceability_Link_Type, used for ModelLinking/ContextLink/etc. across P510/P515/
  P520/P550) is documented differently — "URI of the linked resource. Target path in the
  referencing part" — which does read as a co-archived resource locator, so Link gets the
  stricter relative-only mandate (same four lettered failure modes as SSP-ARCH-050), not the
  lighter no-local-leakage rule. NOTE: this is a genuine judgment call, not a corpus-confirmed
  fact — ModelLinking/ContextLink in the P515 test fixture currently use urn: values too
  ("urn:model:example-fmu"), and lotar-p515-archival.sch's own header explicitly states
  ModelLinking/ContextLink "link to other Digital Objects/contexts... rather than to a single
  concrete file" (deferred to P550). Flagged here for explicit confirmation before treating
  P500-ARCH-001 as final: if Link is in practice used the same identifier-like way as
  Copyright/License, it should move to the no-local-leakage pattern below instead of staying on
  the relative-only one. Left on the stricter rule for now because the element's own
  documentation text ("Target path") is the only concrete textual evidence available, and it
  points at a resource locator, not an identifier.

  Existence-on-disk is out of scope here for Link — Schematron has no filesystem access; see the
  companion script lotar_uri_resolve_check.py.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with every other LOTAR
  Schematron profile in this project.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for P500_Series_Common.xsd URI-typed fields</title>

  <ns prefix="p500" uri="http://www.lotar.org/schemas/mbse/p500#"/>

  <!-- ==================================================================================
       Pattern 1 — Link: relative-only (co-archived resource locator; see header caveat)
       ================================================================================== -->
  <pattern id="p500-link-uri-relative-only">

    <rule context="//p500:Link" id="P500-ARCH-001">
      <assert test="not(starts-with(text(),'/'))" id="P500-ARCH-001a" role="error">
        [P500-ARCH-001a][I] Link must not be an absolute-path or network-path reference.
      </assert>
      <assert test="not(contains(text(),'\'))" id="P500-ARCH-001b" role="error">
        [P500-ARCH-001b][I] Link must not contain a backslash.
      </assert>
      <assert test="not(contains(substring-before(concat(text(),'/'),'/'),':'))"
              id="P500-ARCH-001c" role="error">
        [P500-ARCH-001c][I] Link must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(contains(concat('/',text(),'/'),'/../'))" id="P500-ARCH-001d" role="error">
        [P500-ARCH-001d][I] Link must not contain a ".." path segment.
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 2 — Copyright/License/Export_Controls/Model_Dependency/Model_Hierarchy/
       Privacy_Rules: no-local-filesystem-leakage only (identifier/reference fields, absolute
       external references intentionally allowed — see header)
       ================================================================================== -->
  <pattern id="p500-identifier-fields-no-local-leak">

    <rule context="//p500:Copyright
                  | //p500:License
                  | //p500:Export_Controls
                  | //p500:Model_Dependency
                  | //p500:Model_Hierarchy
                  | //p500:Privacy_Rules" id="P500-ARCH-010">
      <assert test="not(contains(text(),'\'))" id="P500-ARCH-010a" role="error">
        [P500-ARCH-010a][I] <name/> must not contain a backslash — a producer-local Windows path
        is not a meaningful rights/policy/dependency reference to any future reader.
      </assert>
      <assert test="not(
                       (contains('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', substring(text(),1,1)))
                       and substring(text(),2,1) = ':'
                       and (substring(text(),3,1) = '/' or substring(text(),3,1) = '\')
                     )" id="P500-ARCH-010b" role="error">
        [P500-ARCH-010b][I] <name/> must not be a bare Windows drive-letter-absolute path (e.g.
        "C:\..." or "C:/..."). Genuine external identifiers/URLs (urn:..., https://...) remain
        permitted — only a local-filesystem drive path is rejected.
      </assert>
      <assert test="not(starts-with(translate(text(),'FILE','file'),'file:'))"
              id="P500-ARCH-010c" role="error">
        [P500-ARCH-010c][I] <name/> must not use the file: scheme — a producer-local file URI is
        not a meaningful rights/policy/dependency reference to any future reader.
      </assert>
    </rule>

  </pattern>

</schema>
