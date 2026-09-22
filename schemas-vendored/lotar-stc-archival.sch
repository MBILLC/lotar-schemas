<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for general STC-typed content
  ==============================================================================

  Conformance identifier: LOTAR-STC-ARCHIVAL

  Companion to STC.xsd (vendored, unmodified — see STC.xsd's own header for source/pull-in
  details), not a replacement. Validate with the XSD first (structural conformance), then this
  Schematron layer (archival-mandatory completeness) — same two-pass pattern already established
  for the FMI 2.0.5/3.0.2, P515, and general-SRMD archival profiles (lotar-fmi2.0.5-archival.sch /
  lotar-fmi3.0.2-archival.sch / FMISchematron/lotar-p515-archival.sch / lotar-srmd-archival.sch).

  Origin (2026-07-20): created to close two of the profile opportunities flagged in
  FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md §4 that both constrain STC.xsd — PD17
  (approval/e-signature) and PD9/PD6 (DerivationChainEntry completeness). STC.xsd is vendored/
  external, same do-not-edit limitation already documented for SRMD.xsd in
  lotar-srmd-archival.sch's header, so both requirements are layered on here via Schematron
  instead of forced into the XSD.

  Revision (2026-07-20, later same day, PD4 Tier 2 closure): added Pattern 3, mandating an
  administrative.size-bytes ClassificationEntry on every stc:Resource element — the existing
  per-contained-artifact reference construct already used inside STMD's Input/Procedure/Output/
  Rationale particles (via the GResourceOrReference group). This is the "SSP-internal, per-
  contained-artifact" tier of a three-tier PD4 (Size) proposal: Tier 1 (whole-container size, on
  the governing SRMD instance) is enforced in SRMDLOTARCore_Common.xsd; Tier 3 (per-file-inside-
  an-FMU-zip manifest) was proposed but confirmed out of scope as redundant/overkill. No special
  casing is needed here for a Resource that denotes an embedded FMU vs. a native SSP file: STC's
  Resource model already treats an embedded FMU as one opaque node (it never looks inside the
  FMU's own zip), so the size value recorded against such a Resource is automatically the FMU's
  whole zipped size, exactly matching the confirmed "FMUs are a single artifact with their zipped
  size" framing. Same keyword name as Tier 1's SRMD-root mandate, reused for consistency (both
  ultimately express the same administrative/legal LOTAR Core Common vocabulary, just anchored at
  different context nodes) — see SRMDLOTARCore_Common.xsd's own 2026-07-20 update note.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with the other LOTAR
  archival profiles in this project.
-->
  <!-- D-24 (2026-09-05): STC-ARCH-100 (every life-cycle entry signed) and STC-ARCH-101
       (DerivationChainEntry author/fileversion/generationDateAndTime) moved to the credible-process
       layer as STC-INT-100/101 (credible-process-schemas/profiles/stc-integrity.sch), which
       scripts/lotar_check.py runs before this file. Only the archival rules remain here:
       STC-ARCH-102 (size) and STC-ARCH-110/111 (relative URIs). -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for general STC-typed content (LifeCycle signature, DerivationChain completeness, Resource size)</title>

  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>

  <!-- ==================================================================================
       Pattern 1 — PD17: Signature mandatory on every LifeCycleEntryType entry
       ================================================================================== -->
  <!--
    Item 2 origin/rationale: STC.xsd's LifeCycleEntryType (the shared complex type behind all six
    LifeCycleInformationType wrapper elements — Drafted/Defined/Validated/Approved/Archived/
    Retracted) already includes a required (minOccurs unset, i.e. 1) reference to the ssc:GSignature
    group in its content model — but ssc:GSignature's own definition lives in the unresolved
    external ssp-standard/schema/SystemStructureCommon.xsd (not vendored into this project; see
    SRMD.xsd's and STC.xsd's own "UNRESOLVED EXTERNAL DEPENDENCY" header notes). Since the group's
    inner element cardinality is opaque to us, the base XSD cannot be relied on to actually force a
    Signature to be present (a group can validly contribute zero elements if everything inside it
    is itself optional) — hence this Schematron mandate as a belt-and-braces archival requirement,
    matching PD17's own text ("evidence documenting the approval such as an Electronic Signature").

    Scope decision (2026-07-20, confirmed, broader than the original suggestion): Signature is
    mandated on EVERY life-cycle entry (Drafted/Defined/Validated/Approved/Archived/Retracted), not
    only Approved. Rationale: PD16 (Authentication Agents) and PD7 (Transforming Agents) both call
    for agent/signer accountability at each recorded event, not only the release-approval event, and
    a Retracted entry in particular needs the same signed accountability as an Approved one (who
    withdrew it, and on what authority) — see also item 4's disposal-reason mandate, which pairs
    with this one for the Retracted case specifically.

    Context is written as a union over all six wrapper elements' Signature-bearing children, since
    Schematron/XPath 1.0 contexts are path-based, not type-based, and LifeCycleEntryType itself has
    no addressable element name of its own (Drafted/Defined/.../Retracted are the only element
    names in the instance document). The element contributed by ssc:GSignature is referred to
    throughout this project's own documentation (e.g. FMI_SSP_Evaluation_vs_Requirements_v3_
    LOTARCore.md's PD17 rows: "STC (LifeCycleInformation 'Approved' + ResponsibleType +
    Signature)") simply as "Signature"; matched here by local-name() rather than a specific
    namespace prefix, since the exact namespace of that element cannot be confirmed from the
    unresolved external schema fragment.
  -->

  <!-- ==================================================================================
       Pattern 2 — PD9/PD6: DerivationChainEntry completeness
       ================================================================================== -->
  <!--
    Item 3 origin/rationale: STC.xsd's DerivationChainEntry (child of GeneralInformationType/
    DerivationChain) declares @GUID inline as use="required" (already XSD-mandatory — left alone,
    per instruction) plus the ssc:ABaseElement and ssc:ATopLevelMetaData attribute groups, both
    again defined only in the unresolved external SystemStructureCommon.xsd. @author, @fileversion,
    and @generationDateAndTime are assumed (consistent with PD9's own text — "what application and
    version was used to create or revise" a Product Data object, "a link to the report") to
    originate from ssc:ATopLevelMetaData, alongside @generatingTool (see the deliberate omission
    note below). Since their cardinality inside that external attribute group cannot be confirmed
    from the vendored schema fragment, they are mandated here as a belt-and-braces archival
    requirement rather than assumed already-enforced.

    Deliberate omission — @generatingTool is NOT mandated here (2026-07-20, confirmed): unlike
    @author/@fileversion/@generationDateAndTime, @generatingTool is judged redundant at this
    level. `administrative.generation-tool` is already a Mandatory ClassificationEntry keyword at
    the SRMD-Classification level (SRMDLOTARCore_Common.xsd, migrated in from FMI3's
    @generationTool — see that file's and LOTAR_Core_Common_Vocabulary.md's 2026-07-20 update
    notes), and every archive in this project's scope carries that Classification. Mandating the
    same fact a second time on every individual DerivationChainEntry would duplicate, not
    reinforce, an already-closed requirement — the same "don't duplicate an existing fixity/
    provenance mechanism" reasoning already applied once in this project to drop
    ReferenceResults/@checksum in favor of the sibling ReferenceFileHash element (see
    FMISchematron/lotar-p515-archival.sch's revision note). @generatingTool therefore remains
    structurally optional here; no rule for it is added.
  -->

  <!-- ==================================================================================
       Pattern 3 — PD4 (Tier 2): Size mandatory on every stc:Resource
       ================================================================================== -->
  <!--
    PD4 Tier 2 origin/rationale (2026-07-20): stc:Resource (ResourceType) is the existing per-
    contained-artifact reference construct used throughout STMD's Input/Procedure/Output/Rationale
    particles (via the GResourceOrReference choice group). Like SRMD's root element, ResourceType
    is a closed, vendored complex type with no size/length attribute and no xs:anyAttribute
    wildcard — but it does inherit stc:GElementCommon, so it already has its own Classification/
    ClassificationEntry content model, the same escape hatch used for every other LOTAR Core
    keyword in this project. This pattern mandates administrative.size-bytes there, matching
    Tier 1's SRMD-root mandate of the same keyword (see SRMDLOTARCore_Common.xsd).

    Deliberately no distinction is drawn in this rule between a Resource that denotes an embedded
    FMU and one that denotes a native SSP-internal file (.ssv/.ssm/document/etc.): STC's Resource
    model already treats an embedded FMU as a single opaque node (nothing in STC looks inside an
    FMU's own zip), so whatever size value is recorded against such a Resource is automatically
    the FMU's whole zipped size — exactly the confirmed "FMUs are a single artifact with their
    zipped size" behavior, obtained here without any special-case logic.
  -->
  <pattern id="stc-resource-size-mandatory">

    <rule context="//stc:Resource" id="STC-ARCH-102">
      <assert test="stc:Classification[@type='org.lotar-international.lotar-core.common']/stc:ClassificationEntry[@keyword='administrative.size-bytes']" id="STC-ARCH-102a" role="error">
        [STC-ARCH-102a][M] Every stc:Resource is required to carry an
        administrative.size-bytes ClassificationEntry (LOTAR Core Common), recording the size in
        bytes of the artifact this Resource refers to (PD4). Where the Resource denotes an
        embedded FMU, this is that FMU's whole zipped size — not exploded into its internal
        files (see PD4 Tier 3, confirmed out of scope 2026-07-20).
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 4 — URI restriction: Resource/@source, Resource/Summary/@source relative-only;
       Resource/@master no-local-filesystem-leakage
       ================================================================================== -->
  <!--
    Origin (2026-07-22): stc:Resource/@source and stc:Resource/Summary/@source are both typed
    xs:anyURI in STC.xsd and are true "this artifact is co-archived alongside the STC/STMD/SRMD
    document" references (STC.xsd's own documentation for @source: "For resources that are
    packaged inside an SSP that contains this STC, this is mandatory (in this way, the STC URIs
    remain valid after unpacking the SSP into the filesystem)"). Real-corpus evidence
    (SSPExamples/*/extra/org.ssp-standard.ssp-traceability.stmd/*.stmd) confirms every observed
    stc:Resource/@source is already a bare relative filename (e.g. source="Test.srmd"), so this
    mandate is zero-cost against the current corpus. Same four lettered failure modes as
    lotar-ssp2.0.1-archival.sch's SSP-ARCH-050 pattern (absolute/network path, backslash,
    scheme-or-drive-letter, ".." traversal) — see that file's header for the full rationale, not
    repeated here.

    Resource/@master is deliberately NOT subject to the same relative-only mandate: STC.xsd's own
    documentation defines it as a pointer to "the original, canonical master source for the
    resource" — i.e. the record-of-truth in the producer's PLM/PDM system, which by definition
    typically lives OUTSIDE the archived package (an archived copy cannot generally also contain
    a live PLM system). Forcing @master to be package-relative would misrepresent what the
    attribute means. Instead, a lighter rule applies: @master must not leak a producer-local
    filesystem path (Windows backslash path, or a bare drive-letter-absolute path such as
    "C:\..." or "C:/...") — such values are not just non-portable but actively meaningless to
    any future reader who is not sitting at the original producer's machine. Genuine external
    identifiers/locators (a PLM URN, an https:// URL into a document management system, etc.)
    remain fully permitted, consistent with how Copyright/License/Export_Controls/etc. are
    treated in lotar-p500-uri.sch.

    Resource/@source and Resource/Summary/@source are combined into ONE rule per context (not
    split across two rules sharing the same context) — ISO Schematron only fires the first rule
    in document order whose context matches a given node within a given pattern; two rules with
    an identical context in the same pattern would silently shadow each other. This exact bug was
    already hit and fixed once in this project (lotar-ssp2.0.1-archival.sch's SSP-ARCH-012 note,
    lotar-srmd-archival.sch's SRMD-ARCH-101/102 note) — avoided here by keeping @source and
    @master on the SAME //stc:Resource rule (STC-ARCH-110), and giving Resource/Summary/@source
    its own, genuinely different context (STC-ARCH-111).

    Existence-on-disk is out of scope here (Schematron has no filesystem access) — see the
    companion script lotar_uri_resolve_check.py.
  -->
  <pattern id="stc-resource-source-uri-relative-only">

    <rule context="//stc:Resource" id="STC-ARCH-110">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="STC-ARCH-110a" role="error">
        [STC-ARCH-110a][I] Resource/@source must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="STC-ARCH-110b" role="error">
        [STC-ARCH-110b][I] Resource/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="STC-ARCH-110c" role="error">
        [STC-ARCH-110c][I] Resource/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="STC-ARCH-110d" role="error">
        [STC-ARCH-110d][I] Resource/@source must not contain a ".." path segment.
      </assert>
      <assert test="not(@master) or not(contains(@master,'\'))" id="STC-ARCH-110e" role="error">
        [STC-ARCH-110e][I] Resource/@master must not contain a backslash — a producer-local
        Windows path is not a meaningful "canonical master" reference to any future reader.
      </assert>
      <assert test="not(@master) or not(
                       (contains('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', substring(@master,1,1)))
                       and substring(@master,2,1) = ':'
                       and (substring(@master,3,1) = '/' or substring(@master,3,1) = '\')
                     )" id="STC-ARCH-110f" role="error">
        [STC-ARCH-110f][I] Resource/@master must not be a bare Windows drive-letter-absolute path
        (e.g. "C:\..." or "C:/..."). Genuine external identifiers/URLs (urn:..., https://...) are
        still permitted — only a local-filesystem drive path is rejected.
      </assert>
      <assert test="not(@master) or not(starts-with(translate(@master,'FILE','file'),'file:'))"
              id="STC-ARCH-110g" role="error">
        [STC-ARCH-110g][I] Resource/@master must not use the file: scheme — a producer-local file
        URI is not a meaningful "canonical master" reference to any future reader.
      </assert>
    </rule>

    <rule context="//stc:Resource/stc:Summary" id="STC-ARCH-111">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="STC-ARCH-111a" role="error">
        [STC-ARCH-111a][I] Resource/Summary/@source must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="STC-ARCH-111b" role="error">
        [STC-ARCH-111b][I] Resource/Summary/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="STC-ARCH-111c" role="error">
        [STC-ARCH-111c][I] Resource/Summary/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="STC-ARCH-111d" role="error">
        [STC-ARCH-111d][I] Resource/Summary/@source must not contain a ".." path segment.
      </assert>
    </rule>

  </pattern>

</schema>
