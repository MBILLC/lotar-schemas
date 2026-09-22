<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for SSP 2.0.1 SystemStructureDescription (.ssd)
  =================================================================================================

  Base schema (UNMODIFIED, restriction-only profile):
    SystemStructureDescription.xsd + SystemStructureCommon.xsd, from
    https://github.com/modelica/ssp-standard (tag v2.0.1, commit 800e899, 2026-05-05)
    vendored locally at FMISchematron/SSP-schema/2.0.1/

  Conformance identifier: LOTAR-SSP-2.0.1-ARCHIVAL

  Companion to SystemStructureDescription.xsd, not a replacement. Validate with the XSD first
  (structural conformance), then this Schematron layer (archival-mandatory completeness) — same
  two-pass pattern established for FMI 2.0.5/3.0.2 and P515 (lotar-fmi2.0.5-archival.sch /
  lotar-fmi3.0.2-archival.sch / FMISchematron/lotar-p515-archival.sch).

  Scope (per P520_SSP_Schematron_Plan.md §3, confirmed 2026-07-21): SystemStructureDescription.xsd
  (.ssd) ONLY. .ssv/.ssm deferred to a later pass; .ssb (SystemStructureSignalDictionary) deferred
  indefinitely — rarely used, currently no test corpus (user's explicit call). STMD.xsd
  (SSP-LS-Traceability) is a separate, still-undecided open item (plan §3b) — not touched here.

  Tier legend (same as FMI/P515 — see ssp2.0.1-rule-inventory.md for the full derivation and
  corpus evidence behind every call below):
    [M] Mandatory  — element/attribute must be explicitly present, even if the base XSD allows
                     omission or a silent default.       -> <assert role="error">
    [R] Report     — warn if missing; still XSD-valid without it.  -> <report role="warning">
    [I] Integrity  — always-on correctness/co-occurrence constraint that closes a base-XSD
                     expressiveness gap, independent of the M/R/O axis; applies whenever the
                     relevant element is present.          -> <assert role="error">
    (Plain "Optional" fields get no rule at all — intentionally left as base-XSD-optional.)

  Unlike the FMI inventories, there were no inline "for LOTAR" comments in the SSP schema to start
  from — every tier below was derived directly from Requirements.md + the SSP-specific findings in
  FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md §2, then checked against real corpus behavior
  across the 24 real .ssd files in SSP-Tests/ (two independent tools: EasySSP and Dymola) BEFORE
  being finalized here — several fields that would be tempting to mandate by direct analogy to FMI
  (@author, @copyright, @license, @fileversion) show 0% real-world adoption and were deliberately
  kept at [R], not [M], to avoid repeating FMI2's round-1 over-eager-mandate mistake. See the
  inventory doc for the full per-field evidence table.

  Version handling: SSP's own @version attribute ("1.0" or "2.0") does NOT gate which elements
  SystemStructureDescription.xsd (2.0.1) structurally permits — both values validate against the
  identical schema file, and real corpus files use both. Investigated whether @version-conditional
  rules were needed (per explicit user instruction to "handle both versions") and found: no. Every
  rule below applies uniformly regardless of the instance's declared @version. See rule-inventory
  §9 for the full reasoning.

  No PD1 (fixity) / PD17 (signature) / PD12 (disposal) / P6 (submission agreement) mandates are
  restated here even though they appear in the requirements evaluation — those are already ✔ CLOSED
  at the SRMD/STC layer (lotar-srmd-archival.sch / lotar-stc-archival.sch). Duplicating them here
  would repeat the exact mistake caught and reverted in lotar-p515-archival.sch on 2026-07-20 (the
  ReferenceResults/@checksum vs. ReferenceFileHash duplication) — see rule-inventory §0.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with every other LOTAR
  Schematron profile in this project.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for SSP 2.0.1 SystemStructureDescription (.ssd) instances</title>

  <ns prefix="ssd" uri="http://ssp-standard.org/SSP1/SystemStructureDescription"/>
  <ns prefix="ssc" uri="http://ssp-standard.org/SSP1/SystemStructureCommon"/>

  <!-- ============================================================================ -->
  <!-- 1. Root SystemStructureDescription attributes                                -->
  <!-- ============================================================================ -->
  <pattern id="ssp-root-attributes">

    <rule context="/ssd:SystemStructureDescription" id="SSP-ARCH-001">
      <report test="not(@id)" id="SSP-ARCH-001a" role="warning">
        [SSP-ARCH-001a][R] SystemStructureDescription/@id is recommended but not mandated for
        archival. This is the only SSP-native, fragment-referenceable persistent identifier on the
        root element, but persistent identification is also independently covered by the SRMD/
        MIC-Core Classification layer's `administrative-data.model.identifier` keyword (Recommended
        tier there too — see SRMDMICCore.xsd) — the same "separate LOTAR provenance" mechanism this
        rule was migrated out of scope of on 2026-07-21 and now, per 2026-07-22 explicit instruction,
        migrated INTO scope of after all. Real-corpus evidence: 18/24 original-corpus files carry
        it; absent in all five DC-Motor package files, the Dymola-exported CauerLowPassAnalog
        example, and every non-EasySSP source added since (sources 4-6) — 16/35 by the time this
        was downgraded (see ssp2.0.1-full-corpus-test-report.md).
      </report>
      <!--
        DOWNGRADED [M]->[R] 2026-07-22 (explicit user instruction, reversing the 2026-07-21 note
        below that deliberately excluded @id from the SRMD-provenance migration): "This should be
        covered by our separate LOTAR provenance." Rationale: SRMD/MIC-Core's
        `administrative-data.model.identifier` keyword already provides a persistent-identifier
        mechanism at the provenance layer (Recommended there, same as this rule now) — mandating a
        second, SSD-native identifier on top of it is the same "two mechanisms, two tiers"
        duplication risk the @description/@author/@fileversion/@copyright/@license migration below
        was built to avoid, not a genuinely separate archival concern. Unlike SSP-ARCH-012's
        downgrade (justified by an independent *structural* guarantee — exactly-one-of
        ModelExchange/CoSimulation — making the value always resolvable), this one is justified by
        an independent *provenance-layer* mechanism already covering the same need. Mechanically:
        `<assert test="@id" role="error">` -> `<report test="not(@id)" role="warning">`, same
        pattern as SSP-ARCH-011/012.

        SSP-ARCH-001b/002a/002b/002c/002d (formerly [R] reports on @description/@author/
        @fileversion/@copyright/@license) REMOVED 2026-07-21 per explicit instruction: these five
        fields are now [O] here (no rule at all on the SSD side). Per the same
        don't-duplicate-across-layers discipline as §0's PD1/PD17 note (and the P515
        ReferenceResults/@checksum-vs-ReferenceFileHash duplication caught and reverted
        2026-07-20), this information now has its own mandatory, authoritative home instead —
        the SRMD Classification-keyword layer, and ONLY that layer (see the follow-on provenance-
        unification note below for why native SRMD attribute rules were tried and then retired the
        same day):

          - @fileversion  -> SRMD's `administrative.version` (SRMDLOTARCore_Common.xsd, already
                              Mandatory); also FMI2/FMI3's shared home for @version as of the
                              provenance-unification revision below.
          - @copyright    -> SRMD's `legal.copyright` (already Mandatory)
          - @license      -> SRMD's `legal.license` (already Mandatory)
          - @description  -> MIC Core's `purpose-objectives.model` Classification keyword,
                              promoted from Recommended to Mandatory (see below), NOT SRMD's own
                              native @description attribute.
          - @author       -> SRMD's `administrative.created-by` Classification keyword,
                              promoted from Recommended to Mandatory (see below), NOT SRMD's own
                              native @author attribute.

        SRMD Classification is authoritative on conflict: if a value is present on both the SSD
        root and the corresponding SRMD/MIC-Core Classification keyword and they disagree, the
        Classification-layer value governs. (This is a documentation/process statement — a
        Schematron assert can detect such a conflict if both values are present, but cannot itself
        adjudicate "which one is right.") See ssp2.0.1-rule-inventory.md §1 for the full rationale.
        This mandate is conditional on the package-level SRMD-presence check (see
        ssp-package-srmd-presence-check.py) — an SSP with no SRMD at all has nowhere for this
        information to live and fails that separate, package-level check instead.

        @id (SSP-ARCH-001a, downgraded not migrated — see above) and @generationTool/
        @generationDateAndTime (SSP-ARCH-003a/003b) were explicitly NOT included in the original
        2026-07-21 migration — @generationTool/@generationDateAndTime stay [M] here on the SSD side
        (not moved to SRMD) and remain genuinely dual-mandated (SSD side + SRMD/LOTAR-Core side);
        addressed via a consistency-check tool (check-provenance-consistency.py) rather than a tier
        change — see the provenance-unification note below. @id's status changed on 2026-07-22 (see
        above); @generationTool/@generationDateAndTime were not revisited and stay [M].

        REVISION (2026-07-21, provenance unification — same day, follow-on to the migration above):
        `SRMD-ARCH-101`/`SRMD-ARCH-102` — the native SimulationResourceMetaData/@description/@author
        rules originally added in lotar-srmd-archival.sch as the authoritative home for the two
        rows above — were themselves RETIRED the same day. Reason: they recreated the exact
        "two mechanisms, two tiers" problem this migration exists to close, because the
        Classification-keyword equivalents (`purpose-objectives.model`, `administrative.created-by`)
        already existed at Recommended tier, so a document could satisfy one Mandatory bar while
        failing the other. Resolution: promote the two Classification keywords to Mandatory
        directly (done in SRMDLOTARCore_Common.xsd) and retire SRMD-ARCH-101/102, leaving exactly
        ONE authoritative, Mandatory mechanism — the Classification layer — for @description/
        @author-equivalent information across FMI2, FMI3, and SSP alike. Per explicit direction,
        this is also why FMI's native @version rule was migrated into the shared
        `administrative.version` keyword rather than kept as a separate FMI-only check (see
        FMISchematron/lotar-fmi2.0.5-archival.sch / lotar-fmi3.0.2-archival.sch headers), and why
        @variableNamingConvention/@numberOfEventIndicators were confirmed to NOT belong in this
        provenance layer for either FMI version (restored as native FMI-side structural rules
        instead). See lotar-srmd-archival.sch's own header and
        FMISchematron/FMI_vs_SSP_LOTAR_Rule_Comparison.md for the full cross-format picture.
      -->
      <assert test="@generationTool" id="SSP-ARCH-003a" role="error">
        [SSP-ARCH-003a][M] SystemStructureDescription/@generationTool is required for archival.
        Universal in the real corpus (24/24, both EasySSP and Dymola) — a safe, well-grounded
        mandate.
      </assert>
      <assert test="@generationDateAndTime" id="SSP-ARCH-003b" role="error">
        [SSP-ARCH-003b][M] SystemStructureDescription/@generationDateAndTime is required for
        archival. Universal in the real corpus (24/24) — same grounding as @generationTool.
      </assert>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 2. Component (extends TElement)                                              -->
  <!-- ============================================================================ -->
  <pattern id="ssp-component-attributes">

    <rule context="//ssd:Component">
      <assert test="@type" id="SSP-ARCH-010" role="error">
        [SSP-ARCH-010][M] Component/@type must be stated explicitly for archival, even though the
        base type silently defaults to application/x-fmu-sharedlibrary when omitted — the
        component kind (FMU vs. referenced sub-SSD vs. sub-SSP) must be self-evident from the
        instance. 24/24 real test files across all three corpus sources already state it
        explicitly, so this is a zero-cost mandate that removes a real ambiguity.
      </assert>
      <report test="not(@source)" id="SSP-ARCH-011" role="warning">
        [SSP-ARCH-011][R] Component/@source is recommended but not mandated. The spec explicitly
        sanctions omitting it for "a simulation architecture design without complete executable
        implementation" — and the corpus's Dymola-exported CauerLowPassAnalog example (0/11
        components with @source) is exactly that legitimate, spec-sanctioned case. A hard mandate
        would incorrectly fail architecture-only SSDs from an independent, real tool.
      </report>
    </rule>

  </pattern>

  <!--
    SSP-ARCH-012 is deliberately its own pattern, not folded into "ssp-component-attributes" above.
    ISO Schematron only fires the FIRST rule (in document order) within a pattern whose context
    matches a given node — a more specific //ssd:Component[@type='...'] rule placed after the
    general //ssd:Component rule in the SAME pattern would never fire for any node, since the
    general rule already claims every Component first. Discovered 2026-07-21 while validating this
    exact rule (it silently never fired against the test fixtures until moved out to its own
    pattern) — same bug independently hit and fixed in lotar-srmd-archival.sch's SRMD-ARCH-101/102
    the same day (there, two separate <rule> elements with the identical context in one pattern —
    fixed by merging into one rule instead of splitting into a pattern, the only difference being
    that fix merges same-context rules while this one separates different-context rules that would
    otherwise nest/shadow). Keep any future FMU-only or otherwise-narrower-context Component rule
    in its own pattern too, unless deliberately placed before the general rule to take priority.
  -->
  <pattern id="ssp-component-implementation">

    <rule context="//ssd:Component[@type='application/x-fmu-sharedlibrary']">
      <report test="not(@implementation)" id="SSP-ARCH-012" role="warning">
        [SSP-ARCH-012][R] Component/@implementation is recommended but not mandated on FMU-typed
        Components, even though the base type silently defaults to "any" when omitted.

        HISTORY: Originally [O], promoted to [M] (2026-07-21) on the reasoning that LOTAR already
        disallows multiple interface types for archived FMUs (the FMI archival profiles' hard
        exactly-one-of ModelExchange/CoSimulation mandate), so the value is always deterministically
        resolvable and a resolvable default is still a silent one worth forcing explicit — same
        discipline as Component/@type (SSP-ARCH-010). Kept at [M] on 2026-07-22 despite a growing
        real-corpus failure rate (7/34, including a Dymola export), on the reasoning that this was a
        tool-conformance gap rather than a reason to relax the rule.

        DOWNGRADED [M]->[R] (2026-07-22, explicit user instruction, superseding the same-day [M]
        decision above): accepted that @implementation is not strictly necessary given LOTAR's own
        exactly-one-of ModelExchange/CoSimulation constraint already makes the value deterministically
        resolvable and checked elsewhere in the archival profile — omitting it is redundant, not
        ambiguous, once that constraint is enforced. Still worth recommending (an archived file that
        states it explicitly needs no downstream resolution step), but no longer worth hard-failing
        real, otherwise-conformant files over. Scoped to FMU-typed components only (@type is
        meaningless for referenced sub-SSD/sub-SSP/Modelica components).
      </report>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 3. Connector type choice                                                     -->
  <!-- ============================================================================ -->
  <pattern id="ssp-connector-type">

    <rule context="//ssd:Connector">
      <assert test="ssc:Real or ssc:Float64 or ssc:Float32 or ssc:Integer or ssc:Int8 or ssc:UInt8 or ssc:Int16 or ssc:UInt16 or ssc:Int32 or ssc:UInt32 or ssc:Int64 or ssc:UInt64 or ssc:Boolean or ssc:String or ssc:Enumeration or ssc:Binary or ssc:Clock"
              id="SSP-ARCH-020" role="error">
        [SSP-ARCH-020][M] Connector's type (Real/Integer/Boolean/.../Clock) must be stated
        explicitly for archival. Promoted from [R] to [M] per explicit instruction (2026-07-21):
        the spec allows inferring the type from the underlying FMU, but real-corpus adoption is
        100% (24/24 files, both tools, zero exceptions found) — see
        ssp2.0.1-full-corpus-test-report.md — so the inferable-from-FMU escape hatch is not
        actually exercised by any real tool in this corpus, and forcing the explicit statement
        removes a real (if currently theoretical) ambiguity, consistent with the same discipline
        already applied to Component/@type and Component/@implementation.
      </assert>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 4. Source-vs-inline-content integrity (the base-SSP layer's main contribution) -->
  <!-- ============================================================================ -->
  <pattern id="ssp-source-or-inline-integrity">

    <rule context="//ssc:MetaData">
      <assert test="(@source and not(ssc:Content)) or (not(@source) and ssc:Content)"
              id="SSP-ARCH-030" role="error">
        [SSP-ARCH-030][I] MetaData must have exactly one of @source (external reference) or an
        inline Content child — never both, never neither. The base XSD leaves both independently
        optional even though MetaData's own documentation states this as a strict either/or; this
        closes that expressiveness gap. (0/24 real test files use MetaData at all — untested by
        this corpus, kept because it closes a genuine, spec-stated structural gap regardless of
        current adoption.)
      </assert>
    </rule>

    <rule context="//ssc:Signature">
      <assert test="(@source and not(ssc:Content)) or (not(@source) and ssc:Content)"
              id="SSP-ARCH-031" role="error">
        [SSP-ARCH-031][I] Signature must have exactly one of @source (external reference) or an
        inline Content child — never both, never neither. Same expressiveness gap as MetaData
        above (see SSP-ARCH-030); consistent with PD17 (approval/signature) being owned by STC,
        not the SSD itself (rule-inventory §0). (0/24 real test files use Signature.)
      </assert>
    </rule>

    <rule context="//ssd:SignalDictionary">
      <assert test="(@source and not(*)) or (not(@source) and *)"
              id="SSP-ARCH-032" role="error">
        [SSP-ARCH-032][I] SignalDictionary must have exactly one of @source (external reference)
        or non-empty inline content — never both, never neither, per its own documentation.
        Real-world usage of this element could not be confirmed in the current corpus (a raw
        string match mostly hits the always-declared-but-possibly-unused ssb: namespace prefix,
        not confirmed actual SignalDictionary elements); the rule is kept because it is structural
        and doc-stated, not adoption-dependent.
      </assert>
    </rule>

    <rule context="//ssd:ParameterBinding">
      <assert test="(@source and not(ssd:ParameterValues)) or (not(@source) and ssd:ParameterValues)"
              id="SSP-ARCH-033" role="error">
        [SSP-ARCH-033][I] ParameterBinding must have exactly one of @source (external parameter
        file) or an inline ParameterValues child — never both, never neither, exactly as its own
        documentation states ("...must not be present otherwise"). ParameterBinding itself appears
        in all 24 real corpus test files, so this pairing is real-world load-bearing, not
        theoretical.
      </assert>
    </rule>

    <rule context="//ssd:ParameterMapping">
      <assert test="(@source and not(*)) or (not(@source) and *)"
              id="SSP-ARCH-034" role="error">
        [SSP-ARCH-034][I] ParameterMapping must have exactly one of @source (external mapping
        file) or non-empty inline content — never both, never neither, per its own documentation.
        Self-contained on the same element (unlike ParameterBinding/ParameterValues above, which
        spans parent/child).
      </assert>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 5. Enumerations / Units name-uniqueness integrity                            -->
  <!-- ============================================================================ -->
  <pattern id="ssp-enumerations-units-uniqueness">

    <rule context="//ssc:Enumeration">
      <assert test="not(@name = preceding-sibling::ssc:Enumeration/@name)"
              id="SSP-ARCH-040" role="error">
        [SSP-ARCH-040][I] Enumeration/@name must be unique within the enclosing Enumerations
        collection. Required by XSD when the Enumeration element exists; cross-collection
        uniqueness is doc-stated only ("must be unique within the system description"), not
        XSD-enforceable — same pattern as FMI2's SimpleType/Unit uniqueness rules.
      </assert>
    </rule>

    <rule context="//ssc:Unit">
      <assert test="not(@name = preceding-sibling::ssc:Unit/@name)"
              id="SSP-ARCH-041" role="error">
        [SSP-ARCH-041][I] Unit/@name must be unique within the enclosing Units collection. Same
        doc-stated-only uniqueness gap as Enumeration/@name above (SSP-ARCH-040).
      </assert>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 6. Source/iconSource URI restriction — relative references only (archival)   -->
  <!-- ============================================================================ -->
  <!--
    Origin (2026-07-22): every @source/@iconSource attribute below is typed xs:anyURI in the base
    SSP schema, which permits absolute references (scheme-qualified http://, file://, or a bare
    Windows drive-letter path like C:\...) as well as relative ones. An archived SSP must be
    self-contained and independently retrievable decades from now without depending on the
    producer's original filesystem or network location, so LOTAR restricts every such reference to
    a relative reference (RFC 3986 relative-ref, no scheme, no authority) rooted at the unzipped
    SSP's own directory tree. This cannot be expressed as an XSD restriction on xs:anyURI (XSD has
    no relative-vs-absolute facet), hence the Schematron layer.

    Four failure modes are checked per attribute, each its own lettered assertion for a precise
    diagnostic:
      a) absolute-path / network-path reference (starts with "/", including "//host/...")
      b) Windows-style backslash path
      c) scheme-qualified or drive-letter-qualified reference (a colon appears in the reference's
         first path segment, before any "/" — this single test catches both "http:"/"file:"
         schemes AND "C:\..."/"C:/..." drive letters, since neither is legal as the leading path
         segment of a genuine RFC 3986 relative reference)
      d) path traversal that would escape the archive root via a ".." segment

    Deliberately NOT checked here: the empty-string case. SystemStructureDescription.xsd's own
    documentation for Component/@source explicitly states that an empty relative URI is a valid
    same-document reference (distinct from omitting @source entirely) — only using it to mean "no
    implementation" is disallowed, which is a semantic distinction Schematron/XPath 1.0 cannot make
    (it cannot tell a legitimate empty same-document reference from a "no implementation" one).
    Existence-on-disk (the second half of "relative AND exists") is also out of scope here —
    Schematron has no filesystem access; see the companion script lotar_uri_resolve_check.py, which
    re-resolves every one of these same attributes against an actual unzipped archive root and
    verifies both containment and existence.

    Every assert is guarded by "not(@attr) or ..." so it is vacuously satisfied when the attribute
    is absent — presence/absence of @source itself is governed separately (SSP-ARCH-011 for
    Component/@source; the source-vs-inline-content choice for the other elements is governed by
    SSP-ARCH-030/031/032/034 above). This pattern only tightens the FORM of the value when present,
    so it is safe to run unconditionally alongside those.
  -->
  <pattern id="ssp-source-uri-relative-only">

    <rule context="//ssd:Component" id="SSP-ARCH-050">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="SSP-ARCH-050a" role="error">
        [SSP-ARCH-050a][I] Component/@source must not be an absolute-path or network-path
        reference (must not start with "/"). Archived components must be locatable purely
        relative to the unzipped SSP root.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="SSP-ARCH-050b" role="error">
        [SSP-ARCH-050b][I] Component/@source must not contain a backslash — Windows-style absolute
        paths are not portable references and are not permitted for archival.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="SSP-ARCH-050c" role="error">
        [SSP-ARCH-050c][I] Component/@source must not carry a URI scheme (e.g. "file:", "http:")
        or a drive letter (e.g. "C:") — detected by a colon appearing in the reference's first
        path segment, which is never legal in a genuine relative reference.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="SSP-ARCH-050d" role="error">
        [SSP-ARCH-050d][I] Component/@source must not contain a ".." path segment — such a
        reference could escape the archive root once resolved, which LOTAR does not permit even
        though the base SSP spec merely says implementations are not required to support it.
      </assert>
      <assert test="not(@iconSource) or not(starts-with(@iconSource,'/'))" id="SSP-ARCH-051a" role="error">
        [SSP-ARCH-051a][I] Component/@iconSource must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(@iconSource) or not(contains(@iconSource,'\'))" id="SSP-ARCH-051b" role="error">
        [SSP-ARCH-051b][I] Component/@iconSource must not contain a backslash.
      </assert>
      <assert test="not(@iconSource) or not(contains(substring-before(concat(@iconSource,'/'),'/'),':'))"
              id="SSP-ARCH-051c" role="error">
        [SSP-ARCH-051c][I] Component/@iconSource must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@iconSource) or not(contains(concat('/',@iconSource,'/'),'/../'))"
              id="SSP-ARCH-051d" role="error">
        [SSP-ARCH-051d][I] Component/@iconSource must not contain a ".." path segment.
      </assert>
    </rule>

    <rule context="//ssc:MetaData" id="SSP-ARCH-052">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="SSP-ARCH-052a" role="error">
        [SSP-ARCH-052a][I] MetaData/@source must not be an absolute-path or network-path reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="SSP-ARCH-052b" role="error">
        [SSP-ARCH-052b][I] MetaData/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="SSP-ARCH-052c" role="error">
        [SSP-ARCH-052c][I] MetaData/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="SSP-ARCH-052d" role="error">
        [SSP-ARCH-052d][I] MetaData/@source must not contain a ".." path segment.
      </assert>
    </rule>

    <rule context="//ssc:Signature" id="SSP-ARCH-053">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="SSP-ARCH-053a" role="error">
        [SSP-ARCH-053a][I] Signature/@source must not be an absolute-path or network-path reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="SSP-ARCH-053b" role="error">
        [SSP-ARCH-053b][I] Signature/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="SSP-ARCH-053c" role="error">
        [SSP-ARCH-053c][I] Signature/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="SSP-ARCH-053d" role="error">
        [SSP-ARCH-053d][I] Signature/@source must not contain a ".." path segment.
      </assert>
    </rule>

    <rule context="//ssd:SignalDictionary" id="SSP-ARCH-054">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="SSP-ARCH-054a" role="error">
        [SSP-ARCH-054a][I] SignalDictionary/@source must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="SSP-ARCH-054b" role="error">
        [SSP-ARCH-054b][I] SignalDictionary/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="SSP-ARCH-054c" role="error">
        [SSP-ARCH-054c][I] SignalDictionary/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="SSP-ARCH-054d" role="error">
        [SSP-ARCH-054d][I] SignalDictionary/@source must not contain a ".." path segment.
      </assert>
    </rule>

    <rule context="//ssd:ParameterMapping" id="SSP-ARCH-055">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="SSP-ARCH-055a" role="error">
        [SSP-ARCH-055a][I] ParameterMapping/@source must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="SSP-ARCH-055b" role="error">
        [SSP-ARCH-055b][I] ParameterMapping/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="SSP-ARCH-055c" role="error">
        [SSP-ARCH-055c][I] ParameterMapping/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="SSP-ARCH-055d" role="error">
        [SSP-ARCH-055d][I] ParameterMapping/@source must not contain a ".." path segment.
      </assert>
    </rule>

    <rule context="//ssd:ParameterValues" id="SSP-ARCH-056">
      <assert test="not(@source) or not(starts-with(@source,'/'))" id="SSP-ARCH-056a" role="error">
        [SSP-ARCH-056a][I] ParameterValues/@source must not be an absolute-path or network-path
        reference.
      </assert>
      <assert test="not(@source) or not(contains(@source,'\'))" id="SSP-ARCH-056b" role="error">
        [SSP-ARCH-056b][I] ParameterValues/@source must not contain a backslash.
      </assert>
      <assert test="not(@source) or not(contains(substring-before(concat(@source,'/'),'/'),':'))"
              id="SSP-ARCH-056c" role="error">
        [SSP-ARCH-056c][I] ParameterValues/@source must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(@source) or not(contains(concat('/',@source,'/'),'/../'))"
              id="SSP-ARCH-056d" role="error">
        [SSP-ARCH-056d][I] ParameterValues/@source must not contain a ".." path segment.
      </assert>
    </rule>

  </pattern>

</schema>
