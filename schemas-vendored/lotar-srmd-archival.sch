<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for general SRMD instances
  ===========================================================================

  Conformance identifier: LOTAR-SRMD-ARCHIVAL

  Companion to SRMD.xsd (vendored, unmodified — see SRMD.xsd's own header for source/pull-in
  details), not a replacement. Validate with the XSD first (structural conformance), then this
  Schematron layer (archival-mandatory completeness) — same two-pass pattern already established
  for the FMI 2.0.5/3.0.2 and P515 archival profiles (lotar-fmi2.0.5-archival.sch /
  lotar-fmi3.0.2-archival.sch / FMISchematron/lotar-p515-archival.sch).

  Origin (2026-07-20): created to close the general-SRMD half of the PD1 (Fixity) profile
  opportunity flagged in FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md §4 — "mandate
  checksum+checksumType on the SRMD instance generally" — as distinct from
  lotar-p515-archival.sch's narrower, already-closed fixity mandate on the two P515-manifest
  elements migrated to P515_Related_Type (InputFile, ReferenceResults). That prior closure was
  scoped to files a P515 manifest references; this one is scoped to the SRMD file's own top-level
  fixity statement about the resource it describes.

  Structural basis: SRMD.xsd defines exactly one element, srmd:SimulationResourceMetaData, which
  is itself the only element in the file that structurally carries @checksum/@checksumType (both
  declared use="optional" there; @checksumType additionally defaults silently to "SHA3-256" when
  omitted). There is no separate "Resource"/"ResourceType" element inside SRMD.xsd itself — the
  ResourceType complex type lives in the imported STC.xsd and is a different, nested construct
  (resources referenced from within a phase/step/particle), out of scope for this file. XSD
  restriction cannot tighten an inherited/optional attribute's `use` to required without also
  being a restriction derivation (not applicable here — the attributes are declared directly on
  SimulationResourceMetaData, not inherited from an external base type), and SRMD.xsd is a vendored
  file this project does not edit (same do-not-edit-the-vendored-XSD limitation already documented
  for TRelated/fmi-ls-ref in lotar-p515-archival.sch's header) — so, as with that file, the
  mandatory-for-archival requirement is layered on here via Schematron instead of forced into the
  XSD directly.

  Scope decision (2026-07-20, confirmed): the mandate below applies to every
  SimulationResourceMetaData instance unconditionally — i.e. it is NOT conditioned on whether the
  @data attribute (which points to the resource this SRMD describes, when the resource is stored
  separately/"by reference") is present or absent. SRMD.xsd's own documentation for @data notes
  that when @data is missing, "the data this resource meta data applies to is provided outside of
  the meta data (e.g. by embedding SRMD into the data format, or providing it as meta data in an
  STMD file)" — i.e. an "inline"/embedded case as opposed to @data's "by reference" case. Fixity
  information about the resource being described is equally necessary in both cases (an
  embedded/self-describing resource is just as vulnerable to unauthorized/undetected change as a
  by-reference one, and PD1's own requirement text draws no such distinction), so both @checksum
  and @checksumType are asserted here regardless of whether @data is present.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with the other LOTAR
  archival profiles in this project.

  REVISION (2026-07-21): added SRMD-ARCH-101/102, mandating SimulationResourceMetaData's own
  native @description and @author attributes (both inherited via ssc:ABaseElement/
  ssc:ATopLevelMetaData — the identical attribute groups SystemStructureDescription's root also
  uses). This is the direct result of the user's decision to make SRMD the authoritative home for
  SSD-root provenance fields that were previously only [R] (recommended) on the SSD side:

    - @fileversion -> already covered by the existing `administrative.version` Mandatory
      Classification keyword in SRMDLOTARCore_Common.xsd — no new rule needed here.
    - @copyright   -> already covered by `legal.copyright` (Mandatory) — no new rule needed.
    - @license     -> already covered by `legal.license` (Mandatory) — no new rule needed.
    - @description -> NOT previously covered by any Mandatory keyword or native-attribute rule —
      SRMD-ARCH-101 closes this gap directly on SRMD's own native @description attribute (simpler
      and non-duplicative vs. inventing a parallel Classification keyword for a concept the base
      SRMD schema already expresses natively).
    - @author      -> NOT previously covered (the existing `administrative.created-by` /
      `administrative.author-organization` keywords in SRMDLOTARCore_Common.xsd are Recommended,
      not Mandatory, and capture different nuances — who-created vs. organizational authorship —
      not a straight substitute). SRMD-ARCH-102 closes this gap directly on SRMD's own native
      @author attribute, same rationale as @description above.

  SRMD is authoritative on conflict: if a value is present on both the SSD root and the
  corresponding SRMD field and they disagree, the SRMD value governs. This is a documented
  process rule, not something a Schematron assert can adjudicate on its own — see
  FMISchematron/lotar-ssp2.0.1-archival.sch's own header note and
  FMISchematron/ssp2.0.1-rule-inventory.md §1 for the SSD side of this same decision.

  Side observation, not acted on: `administrative.generation-tool` and `administrative.created-on`
  in SRMDLOTARCore_Common.xsd are already Mandatory there, and SSD's own @generationTool/
  @generationDateAndTime are also [M] on the SSD side (SSP-ARCH-003a/003b) — meaning those two
  fields are currently dual-mandated across both layers. The user's migration instruction did not
  include @id/@generationTool/@generationDateAndTime, so this overlap is left as-is; flagged here
  in case it's worth resolving in a future pass.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for general SRMD instances</title>

  <ns prefix="srmd" uri="http://ssp-standard.org/SSPTraceability1/SimulationResourceMetaData"/>

  <pattern id="srmd-root-fixity-mandatory">

    <rule context="/srmd:SimulationResourceMetaData" id="SRMD-ARCH-100">
      <assert test="@checksum" id="SRMD-ARCH-100a" role="error">
        [SRMD-ARCH-100a][M] SimulationResourceMetaData/@checksum is required for archival
        (optional in the base SRMD.xsd). Applies unconditionally — not conditioned on whether
        @data is present (by-reference) or absent (embedded/inline); see the scope decision above.
        Fixity of the resource this metadata describes must be verifiable without external
        records.
      </assert>
      <assert test="@checksumType" id="SRMD-ARCH-100b" role="error">
        [SRMD-ARCH-100b][M] SimulationResourceMetaData/@checksumType must be stated explicitly for
        archival, even though the base type silently defaults to SHA3-256 when omitted — the
        algorithm must be self-evident from the instance, not inferred from a schema default that
        could change. Applies unconditionally, same as @checksum above.
      </assert>
      <!--
        SRMD-ARCH-100c-f (2026-07-22): @data is typed xs:anyURI in SRMD.xsd ("a URI to the data
        item this resource meta data applies to") and is a co-archived-artifact reference exactly
        like STC's Resource/@source (lotar-stc-archival.sch's STC-ARCH-110) — when present, it
        must be a relative reference resolvable purely against the unzipped package root, for the
        same self-contained-archive reasoning documented in lotar-ssp2.0.1-archival.sch's
        SSP-ARCH-050 header. Added as extra lettered asserts on the EXISTING SRMD-ARCH-100 rule
        (not a new rule) because a second <rule> with the identical context
        "/srmd:SimulationResourceMetaData" in this same pattern would silently never fire — ISO
        Schematron only evaluates the first matching rule per node per pattern; this exact
        shadowing bug is already documented as caught once in this project (see the RETIRED
        SRMD-ARCH-101/102 note below and lotar-ssp2.0.1-archival.sch's SSP-ARCH-012 note).
        Existence-on-disk is out of scope here — see the companion script
        lotar_uri_resolve_check.py.
      -->
      <assert test="not(@data) or not(starts-with(@data,'/'))" id="SRMD-ARCH-100c" role="error">
        [SRMD-ARCH-100c][I] SimulationResourceMetaData/@data must not be an absolute-path or
        network-path reference.
      </assert>
      <assert test="not(@data) or not(contains(@data,'\'))" id="SRMD-ARCH-100d" role="error">
        [SRMD-ARCH-100d][I] SimulationResourceMetaData/@data must not contain a backslash.
      </assert>
      <assert test="not(@data) or not(contains(substring-before(concat(@data,'/'),'/'),':'))"
              id="SRMD-ARCH-100e" role="error">
        [SRMD-ARCH-100e][I] SimulationResourceMetaData/@data must not carry a URI scheme or drive
        letter.
      </assert>
      <assert test="not(@data) or not(contains(concat('/',@data,'/'),'/../'))"
              id="SRMD-ARCH-100f" role="error">
        [SRMD-ARCH-100f][I] SimulationResourceMetaData/@data must not contain a ".." path segment.
      </assert>
    </rule>

  </pattern>

  <!--
    SRMD-ARCH-101/102 RETIRED (2026-07-21, same day they were added): these two rules asserted
    SimulationResourceMetaData's native @description/@author (via ssc:ABaseElement/
    ssc:ATopLevelMetaData) were Mandatory, as the authoritative home for the SSD root's migrated-
    away @description/@author. That created exactly the "stale doubles" / "two mechanisms, two
    tiers" problem flagged the same day: the Classification-keyword layer
    (SRMDLOTARCore_Common.xsd's administrative.created-by, SRMDMICCore.xsd's
    purpose-objectives.model) already covered the same two facts, but at Recommended tier only —
    so a document could satisfy one mechanism's Mandatory bar while failing the other's, or vice
    versa, with nothing reconciling the two. Per explicit direction to unify FMI2/FMI3/SSP
    provenance into a single mechanism rather than maintain parallel checks: administrative.created-by
    was promoted to Mandatory in SRMDLOTARCore_Common.xsd, and a new LOTAR-authored override
    promotes purpose-objectives.model to Mandatory too (SRMDLOTARCore_Common.xsd's "MIC Core
    Mandatory Additions" pattern, since purpose-objectives.model itself lives in the vendored,
    do-not-edit SRMDMICCore.xsd). Those two Classification-layer mandates are now the SOLE
    authoritative provenance mechanism for @description/@author-equivalent information, applying
    uniformly to any SRMD instance regardless of whether it's embedded in/sidecar to an FMI2, FMI3,
    or SSP artifact. Native @description/@author on SimulationResourceMetaData itself remain
    structurally present in the base SRMD.xsd but are back to fully Optional here — no rule, to
    avoid re-introducing the exact duplication just removed.

    While fixing this, also found and fixed two real, pre-existing compile bugs in
    SRMDLOTARCore_Common.xsd (never actually validated before this revision): sch:let variables
    referenced inside a rule's context= match-pattern attribute don't compile under this project's
    lxml/libxslt toolchain (only test=/select= expressions support them), and the allowed-keywords
    membership list used XPath 2.0 sequence syntax under a queryBinding="xslt" (XPath 1.0) file.
    Both fixed in that file directly; see its own header REVISION note for detail. The same
    context=-variable anti-pattern also exists in SRMDLOTARCore_DublinCore.xsd/_P515.xsd/_P520.xsd
    — NOT fixed here (out of scope for this revision), flagged as a follow-up in
    FMISchematron/FMI_vs_SSP_LOTAR_Rule_Comparison.md and the artifacts/decisions log.
    (2026-08-06: SRMDLOTARCore_DublinCore.xsd itself is now retired/moved to deprecated/ — its
    content was absorbed into SRMDLOTARCore_Common.xsd, written without this anti-pattern, per
    that file's own header. The deprecated copy still carries the original, unfixed bug, since it
    is left as written for historical accuracy. _P515.xsd/_P520.xsd still carry the bug and are
    still open follow-up work.)
  -->
  <pattern id="srmd-root-provenance-mandatory-RETIRED">
    <!-- Intentionally empty pattern (no rules) — kept as a placeholder/marker so a future reader
         searching for "SRMD-ARCH-101"/"SRMD-ARCH-102" finds this explanation rather than nothing.
         The provenance-layer IDs SRMD-ARCH-101/102 are retired, not reassigned. -->
  </pattern>

</schema>
