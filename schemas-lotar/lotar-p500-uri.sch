<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for P500_Series_Common.xsd URI-typed fields
  ==============================================================================================

  Base schema (UNMODIFIED): P500_Series_Common.xsd, the shared base imported by every NAS9300
  5xx-series manifest schema (P510, P515, P520, P550, ...).

  Conformance identifier: LOTAR-P500-URI

  Companion to P500_Series_Common.xsd (link model revised D-25, 2026-10-28), not a replacement. Since P500_Series_Common.xsd has no
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

  Link (inside Traceability_Link_Type, used for ModelLinking/ContextLink/Validated_by/Verified_by/
  Implements across P510/P520) — REVISED 2026-10-28 (D-25, WG decision S2, see
  planning/WG_Decision_Request_Single_500_Series_Archive.md). The 2026-07-22 judgment call flagged
  below the original header ("is Link a locator or an identifier?") is now settled by splitting the
  two: Link is a LOCATOR relative to the ROOT of the 500-series archive (the directory holding
  lotar-500-manifest.xml), with an optional "#fragment"; the new sibling element Target_Id is the
  IDENTIFIER (a URN, always present). The pre-D-25 fixtures' "urn:model:example-fmu" values were
  identifiers in a locator field and have been migrated to Target_Id.

  Consequences for the rules in this file:
    - P500-ARCH-001 keeps its four lettered failure modes (absolute/network path, backslash,
      scheme-or-drive-letter, ".." segment) but the base is now the ARCHIVE ROOT, not the containing
      file's directory. Because every locator is root-relative, ".." is never needed to reach another
      branch (p510/, p520/, p550/, p520/_decisions/), so the ".." ban (001d) stays. A link may
      therefore legitimately point at another branch of the archive — that is exactly what the WG
      decided — but never out of the archive, and never INTO an SSP/FMU package: it targets part
      manifests, their fragments, and the canonical decision records only (anything inside a package
      that must be reachable gets an anchor in its part manifest).
    - New P500-ARCH-002 enforces identifier/locator consistency: Target_Id present and
      scheme-qualified (a URN, not a path); Link present iff Type is not External; Type "Global"
      deprecated (warning).

  Existence-on-disk is out of scope here for Link — Schematron has no filesystem access; see the
  companion script lotar_uri_resolve_check.py.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with every other LOTAR
  Schematron profile in this project.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for P500_Series_Common.xsd URI-typed fields</title>

  <ns prefix="p500" uri="http://www.lotar.org/schemas/mbse/p500#"/>

  <!-- ==================================================================================
       Pattern 1 — Link: archive-root-relative locator (D-25; see header)
       ================================================================================== -->
  <pattern id="p500-link-uri-relative-only">

    <rule context="//p500:Link" id="P500-ARCH-001">
      <assert test="not(starts-with(text(),'/'))" id="P500-ARCH-001a" role="error">
        [P500-ARCH-001a][I] Link must not be an absolute-path or network-path reference — it is a
        locator relative to the 500-series archive root (no leading "/").
      </assert>
      <assert test="not(contains(text(),'\'))" id="P500-ARCH-001b" role="error">
        [P500-ARCH-001b][I] Link must not contain a backslash.
      </assert>
      <assert test="not(contains(substring-before(concat(text(),'/'),'/'),':'))"
              id="P500-ARCH-001c" role="error">
        [P500-ARCH-001c][I] Link must not carry a URI scheme or drive letter — an identifier
        (urn:..., https://...) belongs in Target_Id, a locator in Link.
      </assert>
      <assert test="not(contains(concat('/',substring-before(concat(text(),'#'),'#'),'/'),'/../'))"
              id="P500-ARCH-001d" role="error">
        [P500-ARCH-001d][I] Link must not contain a ".." path segment — locators are
        archive-root-relative, so another branch is reached as "p5xx/..." and never by climbing.
      </assert>
      <assert test="not(contains(substring-before(concat(text(),'#'),'#'),'.ssp/'))
                    and not(contains(substring-before(concat(text(),'#'),'#'),'.fmu/'))"
              id="P500-ARCH-001e" role="error">
        [P500-ARCH-001e][I] Link must not point into an SSP/FMU package (".ssp/", ".fmu/") — links
        target part manifests, their fragments and canonical decision records; anything inside a
        package that must be reachable gets an anchor in its part manifest (D-25, S2).
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 1b — Traceability link: identifier/locator consistency (D-25, S2)
       Context = any element that carries a p500:Target_Id (i.e. any Traceability_Link_Type
       instance), regardless of its part-specific element name.
       ================================================================================== -->
  <pattern id="p500-traceability-link-identifier">

    <rule context="//*[p500:Target_Id]" id="P500-ARCH-002">
      <assert test="normalize-space(p500:Target_Id) != ''" id="P500-ARCH-002a" role="error">
        [P500-ARCH-002a][M] Target_Id (the target's persistent identifier) must be present and
        non-empty on every traceability link.
      </assert>
      <assert test="contains(substring-before(concat(p500:Target_Id,'/'),'/'),':')"
              id="P500-ARCH-002b" role="error">
        [P500-ARCH-002b][M] Target_Id must be a scheme-qualified identifier (urn:..., including
        urn:uuid:&lt;GUID&gt; for a credible-process record), not a relative path — paths go in Link.
      </assert>
      <assert test="not(p500:Type = 'External') or not(p500:Link)" id="P500-ARCH-002c" role="error">
        [P500-ARCH-002c][M] A link of Type "External" (target in another archive) must not carry a
        Link locator — nothing that is a path crosses an archive boundary (D-25, S6).
      </assert>
      <assert test="p500:Type = 'External' or normalize-space(p500:Link) != ''"
              id="P500-ARCH-002d" role="error">
        [P500-ARCH-002d][M] A link of Type "Local" or "Archive" (or with Type absent) targets this
        archive and must carry a Link locator.
      </assert>
      <assert test="not(p500:Type = 'Global')" id="P500-ARCH-002e" role="warning">
        [P500-ARCH-002e][R] Type "Global" is deprecated since D-25 — use "Archive" (same archive)
        or "External" (other archive).
      </assert>
    </rule>

    <rule context="//p500:Link[contains(text(),'#')]" id="P500-ARCH-003">
      <assert test="normalize-space(substring-after(text(),'#')) != ''" id="P500-ARCH-003a" role="error">
        [P500-ARCH-003a][I] A "#" in Link must be followed by a fragment identifier (an element id
        in the target document).
      </assert>
      <assert test="not(contains(substring-after(text(),'#'),'/'))" id="P500-ARCH-003b" role="error">
        [P500-ARCH-003b][I] The fragment of a Link is an element identifier, not a path.
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
