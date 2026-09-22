<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for NAS9300-520 P520_Manifest instances:
  behavioral-model test cases and scenario evidence
  =======================================================================================

  Conformance identifier: LOTAR-P520-ARCHIVAL

  Companion to P520_SCHEMA.xsd, not a replacement. Validate with the XSD first (structural
  conformance; use xmlschema.XMLSchema11 or lxml — both compile it since the D-23 chameleon
  include), then this Schematron layer, then lotar-p520-uri.sch (kept as a separate file, OD-I5).

  Origin (2026-09-05, D-23 — P515 integration): this file is lotar-p515-archival.sch carried over
  verbatim under the p520 namespace when P515's behavioral-model test-case content (TestCaseType and
  friends, now nested under Verification_Validation_Scenario/TestCase) was integrated into
  P520_SCHEMA.xsd. Rule ids renumbered 1:1 — P515-ARCH-100a..h -> P520-ARCH-100a..h,
  P515-ARCH-101a..f -> P520-ARCH-101a..f, P515-ARCH-102a -> P520-ARCH-102a, P515-ARCH-103a/b ->
  P520-ARCH-103a/b — and one new pattern, P520-ARCH-003 (scenario evidence present), added at the
  end. Rule contexts are anchored on the local element names with // descent, so the deeper nesting
  under a scenario changes nothing. P520-ARCH-001/002 live in lotar-p520-uri.sch.

  The original file's own design history (2026-07-20/21: checksum mandate on InputFile, the
  removal of the duplicate ReferenceResults checksum in favour of ReferenceFileHash as sole fixity
  mechanism, @role "configuration"/"result") is preserved below as received; read "P515" there as
  the pre-integration name of this content. lotar-p515-archival.sch itself is retired to deprecated/.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with the FMI archival
  profiles.

  ORIGINAL HEADER (2026-07-20/21) FOLLOWS, unchanged except for file/rule-id names:

  Origin (2026-07-20): created while executing P515_FMI_LS_Ref_Plan.md, on the explicit
  instruction "Make checksums mandatory for the P515 Schematron." P515_SCHEMA.xsd migrated
  BoundaryConditions/InputFile and ReferenceVariables/ReferenceResults from
  p500:Traceability_Link_Type to the new P520_Related_Type (an xs:extension of fmi-ls-ref's
  TRelated, vendored from modelica/fmi-ls-ref PR #36, assumed merged). TRelated declares
  @checksum as OPTIONAL (only @checksumType has a default). XSD extension cannot also tighten
  that inherited attribute's `use` to required in the same derivation step — restriction and
  extension are mutually exclusive for a single complex type — so, exactly as with
  FMI2-ARCH-010a-h / FMI3-ARCH-010a-g, the mandatory-for-archival requirement is layered on
  here instead of forced into the XSD.

  Revision (2026-07-20, later same day): the original version of this file also made
  ReferenceResults/@checksum + @checksumType mandatory (P520-ARCH-101a/101b), which duplicated
  the pre-existing sibling element ReferenceFileHash (sha256/sha1/md5 + hex value) — both were
  fixity digests of the same reference-results file. Resolved per explicit instruction: those
  two asserts are REMOVED (ReferenceResults/@checksum is no longer required for archival —
  still structurally permitted, since it's inherited from TRelated and left optional there, but
  no longer mandated here); ReferenceFileHash is now the sole authoritative fixity mechanism for
  the reference results file, and its presence/attributes are reinforced below (P520-ARCH-102/
  103) as an integrity cross-check — ReferenceFileHash was already structurally mandatory in
  P515_SCHEMA.xsd (minOccurs defaults to 1, @type/@value both use="required"), so this restates
  rather than changes that requirement, matching the same cross-check pattern already used for
  @sizeBytes. Also added this same revision: @role is now asserted for both InputFile
  ("parameter") and ReferenceResults ("result"), confirmed by the user (previously a flagged,
  unconfirmed judgment call — see P515_FMI_LS_Ref_Plan.md §8.3).

  Scope: only the two elements actually migrated to P520_Related_Type (InputFile,
  ReferenceResults), plus ReferenceResults' pre-existing sibling ReferenceFileHash. ModelLinking
  and Context.ContextLink stay on p500:Traceability_Link_Type — reconfirmed 2026-07-21 (they are
  inter-model/inter-context links, not the file artifacts InputFile/ReferenceResults are; deferred
  to P550 per the plan's §3 scope split) and are out of scope for this file.

  Revision (2026-07-21): InputFile/@role changed from "parameter" to "configuration" per explicit
  user instruction, superseding the 2026-07-20 "parameter" confirmation. P520-ARCH-100d updated
  accordingly; see P515_FMI_LS_Ref_Plan.md for the current status of all four plan open questions.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with the FMI archival
  profiles.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for NAS9300-520 P520_Manifest instances (test-case content and scenario evidence)</title>

  <ns prefix="tns" uri="http://www.lotar.org/schemas/mbse/p520#"/>

  <pattern id="p515-related-mandatory-attributes">

    <rule context="//tns:BoundaryConditions/tns:InputFile" id="P520-ARCH-100">
      <assert test="@checksum" id="P520-ARCH-100a" role="error">
        [P520-ARCH-100a][M] BoundaryConditions/InputFile/@checksum is required for archival
        (optional in the base fmi-ls-ref TRelated type). Fixity of the referenced boundary-
        condition input file must be verifiable without external records. (InputFile has no
        ReferenceFileHash-style sibling element, so @checksum remains its only fixity
        mechanism — unlike ReferenceResults below.)
      </assert>
      <assert test="@checksumType" id="P520-ARCH-100b" role="error">
        [P520-ARCH-100b][M] BoundaryConditions/InputFile/@checksumType must be stated
        explicitly for archival, even though the base type silently defaults to SHA3-256 when
        omitted — the algorithm must be self-evident from the instance, not inferred from a
        schema default that could change.
      </assert>
      <assert test="@sizeBytes" id="P520-ARCH-100c" role="error">
        [P520-ARCH-100c][M] BoundaryConditions/InputFile/@sizeBytes is required (PD4);
        structurally enforced already by P520_SCHEMA.xsd (integrated from P515, D-23) (use="required") — restated here as
        an integrity cross-check.
      </assert>
      <assert test="@role = 'configuration'" id="P520-ARCH-100d" role="error">
        [P520-ARCH-100d][M] BoundaryConditions/InputFile/@role must be "configuration" —
        confirmed (2026-07-21, supersedes the 2026-07-20 "parameter" confirmation) as the
        LOTAR-standard value for a scenario/boundary-condition input file, the closest fit in
        TRelated's closed role enum.
      </assert>
      <!--
        P520-ARCH-100e-h (2026-07-22): @source is inherited from fmi-ls-ref's TRelated (typed
        xs:anyURI there, "the source of the related resource as a URI... the base URI is the URI
        of the fmiReference file") — for archival it must be a relative reference resolvable
        against the package root, same reasoning as lotar-ssp2.0.1-archival.sch's SSP-ARCH-050.
        Added as extra lettered asserts on this EXISTING rule (not a new rule) because a second
        <rule> with the identical context in this same pattern would silently never fire — see
        that file's header and lotar-srmd-archival.sch's SRMD-ARCH-100c-f note for the same
        shadowing pitfall already caught once in this project. Real-corpus evidence
        (lotar-p515-test-valid.xml) already uses bare relative paths
        ("inputs/scenario1.csv") — zero-cost against the current fixture.
        Existence-on-disk is out of scope here — see the companion script
        lotar_uri_resolve_check.py.
      -->
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="P520-ARCH-100e" role="error">
        [P520-ARCH-100e][I] BoundaryConditions/InputFile/@source must not be an absolute-path or
        network-path reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="P520-ARCH-100f" role="error">
        [P520-ARCH-100f][I] BoundaryConditions/InputFile/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="P520-ARCH-100g" role="error">
        [P520-ARCH-100g][I] BoundaryConditions/InputFile/@source must not carry a URI scheme or
        drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="P520-ARCH-100h" role="error">
        [P520-ARCH-100h][I] BoundaryConditions/InputFile/@source must not contain a ".." path
        segment.
      </assert>
    </rule>

    <rule context="//tns:ReferenceVariables/tns:ReferenceResults" id="P520-ARCH-101">
      <assert test="@sizeBytes" id="P520-ARCH-101a" role="error">
        [P520-ARCH-101a][M] ReferenceVariables/ReferenceResults/@sizeBytes is required (PD4);
        structurally enforced already by P520_SCHEMA.xsd (integrated from P515, D-23) (use="required") — restated here as
        an integrity cross-check.
      </assert>
      <assert test="@role = 'result'" id="P520-ARCH-101b" role="error">
        [P520-ARCH-101b][M] ReferenceVariables/ReferenceResults/@role must be "result" —
        confirmed (2026-07-20) as the LOTAR-standard value, the closest fit in TRelated's
        closed role enum.
      </assert>
      <!-- No @checksum/@checksumType assert here (removed 2026-07-20): ReferenceFileHash
           (below) is the sole authoritative fixity mechanism for this element; see the
           revision note above. -->
      <!-- P520-ARCH-101c-f (2026-07-22): same @source relative-only mandate as
           P520-ARCH-100e-h above, applied to ReferenceResults/@source. See InputFile's rule
           for the full rationale (not repeated here). -->
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="P520-ARCH-101c" role="error">
        [P520-ARCH-101c][I] ReferenceVariables/ReferenceResults/@source must not be an
        absolute-path or network-path reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="P520-ARCH-101d" role="error">
        [P520-ARCH-101d][I] ReferenceVariables/ReferenceResults/@source must not contain a
        backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="P520-ARCH-101e" role="error">
        [P520-ARCH-101e][I] ReferenceVariables/ReferenceResults/@source must not carry a URI
        scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="P520-ARCH-101f" role="error">
        [P520-ARCH-101f][I] ReferenceVariables/ReferenceResults/@source must not contain a ".."
        path segment.
      </assert>
    </rule>

    <rule context="//tns:ReferenceVariables" id="P520-ARCH-102">
      <assert test="tns:ReferenceFileHash" id="P520-ARCH-102a" role="error">
        [P520-ARCH-102a][M] ReferenceVariables/ReferenceFileHash is required — the sole
        authoritative fixity mechanism for the reference results file (ReferenceResults/
        @checksum is deliberately not used for this purpose; see revision note above).
        Structurally enforced already by P520_SCHEMA.xsd (integrated from P515, D-23) (default cardinality 1) — restated
        here as an integrity cross-check.
      </assert>
    </rule>

    <rule context="//tns:ReferenceVariables/tns:ReferenceFileHash" id="P520-ARCH-103">
      <assert test="@type" id="P520-ARCH-103a" role="error">
        [P520-ARCH-103a][M] ReferenceFileHash/@type is required; structurally enforced already
        by P520_SCHEMA.xsd (integrated from P515, D-23) (use="required") — restated here as an integrity cross-check.
      </assert>
      <assert test="@value" id="P520-ARCH-103b" role="error">
        [P520-ARCH-103b][M] ReferenceFileHash/@value is required; structurally enforced already
        by P520_SCHEMA.xsd (integrated from P515, D-23) (use="required") — restated here as an integrity cross-check.
      </assert>
    </rule>

  </pattern>

  <!--
    Pattern P520-ARCH-003 (added 2026-09-05, D-23): scenario evidence completeness.
    On integration the XSD's Validated_by/Verified_by choice was relaxed to optional (a scenario's
    evidence may now be its inline TestCase elements). This rule closes the gap the relaxation
    opens: a Verification_Validation_Scenario without a TestCase, a Validated_by, or a Verified_by
    has no evidence at all and is not archivable. Scoped to scenarios that exist; it never
    requires a scenario to be present (Verification_Validation_Scenario stays minOccurs=0).
  -->
  <pattern id="p520-scenario-evidence-present">
    <rule context="//tns:Verification_Validation/tns:Verification_Validation_Scenario" id="P520-ARCH-003">
      <assert test="tns:TestCase or tns:Validated_by or tns:Verified_by" id="P520-ARCH-003a" role="error">
        Verification_Validation_Scenario '<value-of select="tns:Id"/>' carries no evidence: it must
        contain at least one TestCase (inline behavioral-model test case, D-23) or a Validated_by /
        Verified_by link to an external verification/validation artifact.
      </assert>
    </rule>
  </pattern>

</schema>
