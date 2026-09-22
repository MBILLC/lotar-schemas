<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for standalone fmi-ls-ref manifest instances
  ===============================================================================================

  Base schema (vendored, unmodified): fmi3LayeredStandardReferenceManifest.xsd (see that file's
  own header for full provenance — vendored from modelica/fmi-ls-ref PR #36, not yet merged
  upstream as of retrieval).

  Conformance identifier: LOTAR-FMI-LS-REF-ARCHIVAL

  Companion to fmi3LayeredStandardReferenceManifest.xsd, not a replacement. Validate with the XSD
  first (structural conformance), then this Schematron layer — same two-pass pattern established
  for the FMI 2.0.5/3.0.2, P515, SRMD, STC, and SSP 2.0.1 archival profiles.

  Scope: this file targets a STANDALONE fmiReferences document (an FMU's own embedded
  fmi-ls-ref manifest file, root element fmiReferences), as distinct from
  lotar-p515-archival.sch's P515-ARCH-100/101, which enforce the same underlying TRelated/@source
  attribute where it appears via P520_Related_Type inside a P520_Manifest TestCase (formerly
  P515_Related_Type / P515_Manifest — integrated 2026-09-05, D-23) (InputFile,
  ReferenceResults). Both are genuinely needed: an FMU can carry its own fmi-ls-ref manifest
  independent of whether a P515 manifest also references files through the same base type.

  Origin (2026-07-22): TRelated/@source is required (use="required") and typed xs:anyURI in the
  base schema — "the source of the related resource as a URI... the base URI is the URI of the
  fmiReference file". Being required (not merely optional, as in most SSP/STC cases), an absolute
  or scheme-qualified value here is even more directly consequential: every Related entry MUST
  resolve to something, and if that something is an absolute/producer-local reference, the entry
  is useless after the FMU is extracted onto a different machine. Same four lettered failure modes
  as lotar-ssp2.0.1-archival.sch's SSP-ARCH-050 pattern (absolute/network path, backslash,
  scheme-or-drive-letter, ".." traversal) — see that file's header for the full rationale, not
  repeated here. Unlike the other patterns in this project, the guard "not(@source) or ..." is
  kept anyway for defensive symmetry even though @source is XSD-required, since Schematron runs
  independently of XSD validity and should not raise a confusing secondary error on a document
  that already fails XSD validation for a missing @source.

  CORRECTED RESOLUTION BASE (confirmed 2026-07-22, IMPORTANT — read before relying on the base
  schema's own wording above): "the base URI is the URI of the fmiReference file" is the vendored
  XSD's literal text, and would mean Related/@source resolves against the manifest's OWN
  containing directory. That is NOT what LOTAR uses. Per the FMI Layered Standard packaging
  convention, a layered standard's manifest is stored inside the FMU at
  "extra/<fmi-ls-name>/..." — a subdirectory of "extra" named after the manifest's own
  reverse-domain-name fmi-ls:fmi-ls-name identifier (fixed to "org.fmi-standard.fmi-ls-ref" for
  this layered standard). Relative Related/@source values resolve against the FMU's OWN ROOT — the
  level that CONTAINS "extra/" (i.e. also containing resources/, documentation/, sources/,
  modelDescription.xml, etc.) — not against "extra/org.fmi-standard.fmi-ls-ref/" itself. This is
  not an arbitrary preference: it is what makes FMILSREF-ARCH-001d's ".." ban (below) usable in
  practice instead of self-contradictory. If the base really were the manifest's own directory,
  every reference to an FMU-root-level resource (e.g. "resources/Comp1.fmu") would have to climb
  back out of "extra/org.fmi-standard.fmi-ls-ref/" first — i.e. "../resources/Comp1.fmu" — which
  FMILSREF-ARCH-001d forbids outright. Basing resolution at the FMU root instead removes any
  legitimate need for ".." at all, which is exactly why forbidding it is safe.

  This correction — and the requirement that the manifest actually BE packaged at
  "extra/org.fmi-standard.fmi-ls-ref/..." in the first place — is filesystem-layer information a
  Schematron rule has no way to see (Schematron only ever receives the parsed XML content; it has
  no visibility into where that content's own file lives inside the unzipped archive). Both are
  therefore enforced in the companion script, not here: see lotar_uri_resolve_check.py's
  _fmu_root_via_extra(), which locates the FMU root by finding the nearest ancestor directory
  literally named "extra" and verifies the manifest sits directly beneath it in a directory named
  "org.fmi-standard.fmi-ls-ref", failing the check if either does not hold.

  No target namespace: fmi3LayeredStandardReferenceManifest.xsd declares no targetNamespace of its
  own (see that file's header, item (2), for why <xs:include> rather than <xs:import> is required
  for its own dependency on fmi3Annotation.xsd) — so Related/@source is addressed here with an
  unprefixed context, matching the instance document's own (absent) namespace.

  Existence-on-disk, and the corrected FMU-root resolution base described above, are both out of
  scope here — Schematron has no filesystem access; see the companion script
  lotar_uri_resolve_check.py, which re-resolves Related/@source against the FMU root and verifies
  both containment and existence.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with every other LOTAR
  Schematron profile in this project.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for standalone fmi-ls-ref (fmiReferences) manifest instances</title>

  <pattern id="fmilsref-related-source-uri-relative-only">

    <rule context="//Related" id="FMILSREF-ARCH-001">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="FMILSREF-ARCH-001a" role="error">
        [FMILSREF-ARCH-001a][I] Related/@source must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="FMILSREF-ARCH-001b" role="error">
        [FMILSREF-ARCH-001b][I] Related/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="FMILSREF-ARCH-001c" role="error">
        [FMILSREF-ARCH-001c][I] Related/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="FMILSREF-ARCH-001d" role="error">
        [FMILSREF-ARCH-001d][I] Related/@source must not contain a ".." path segment.
      </assert>
    </rule>

  </pattern>

</schema>
