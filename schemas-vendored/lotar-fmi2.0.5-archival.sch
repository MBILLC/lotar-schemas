<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for FMI 2.0.5 modelDescription.xml
  =================================================================================

  Base schema (UNMODIFIED, restriction-only profile):
    fmi2ModelDescription.xsd + includes, from
    https://github.com/modelica/fmi-standard/releases/tag/v2.0.5
    (schema/fmi2ModelDescription.xsd, fmi2ScalarVariable.xsd, fmi2AttributeGroups.xsd,
     fmi2Unit.xsd, fmi2Type.xsd, fmi2Annotation.xsd, fmi2VariableDependency.xsd)

  Conformance identifier: LOTAR-FMI-2.0.5-ARCHIVAL

  THIS FILE SUPERSEDES lotar-fmi2.0.5-archival-strict.sch AND
  lotar-fmi2.0.5-SEMANTIC-relaxed.sch. Those two encoded a binary "make
  everything mandatory, then relax by hand" strategy (MAXIMAL / SEMANTIC
  tags). This version is generated directly from the per-field LOTAR
  classification comments added to the fmi2*.xsd files themselves — see
  fmi2.0.5-rule-inventory.md for the full field-by-field mapping this file
  implements. There is exactly one profile now, not a strict/relaxed pair.

  Tier legend (every rule below is tagged inline with one of these):
    [M] Mandatory      — element/attribute must be explicitly present, even if
                          the base XSD allows omission or a silent default.
                          -> <assert role="error">
    [R] Report         — warn if missing; still XSD-valid without it.
                          -> <report role="warning">
    [I] Integrity      — always-on correctness/co-occurrence constraint that
                          closes a base-XSD expressiveness gap (uniqueness,
                          min/max/start ordering, cardinality). Independent of
                          the M/R/O axis; applies whenever the field is present
                          (or in the interface-cardinality case, always).
    (Plain "Optional" fields from the inventory get no rule at all — they are
    intentionally left as base-XSD-optional and are not listed here.)

  Validation order (per the standard LOTAR toolchain): XSD first, then this file.
  Compiles under queryBinding="xslt" (XPath 1.0 / XSLT 1.0) for broad processor
  compatibility — deliberate choice, don't change to xslt2 without reason.

  REVISION (2026-07-20, round 2): tuned against real-world corpus results
  (Reference-FMUs v0.0.39 + two user-supplied production FMUs from Dymola and
  OCT). Several rules were miscalibrated against what current-generation
  export tools actually produce, and were loosened based on explicit
  instruction:
    - ScalarVariable/@description: was [M], now Optional (no rule). Real
      tools vary too much on this to treat it as archival-blocking.
    - ScalarVariable/@causality: was [M] (force explicit per-variable), now
      Optional per-variable. Replaced with two model-level [R] checks (see
      FMI2-ARCH-072): warn if the FMU has no variable at all with
      causality="output", and warn if none with causality="parameter" — the
      structurally meaningful floor, without demanding every variable state
      it explicitly.
    - Real/@quantity (ScalarVariable only, not SimpleType): was [R], now
      Optional (no rule). SimpleType/Real/@quantity (FMI2-ARCH-081a) is
      unchanged — it never fired against the real corpus, unlike the
      per-variable one.
    - Unknown/@dependenciesKind: was [M], now [R]. The dependencies/
      dependenciesKind co-presence integrity rule (FMI2-ARCH-101c) is
      unaffected — it was already tier-independent.

  REVISION (2026-07-20, round 3): all 8 root-level PROVENANCE attributes
  (@description, @author, @copyright, @license, @generationTool,
  @generationDateAndTime, @variableNamingConvention, @numberOfEventIndicators
  — formerly FMI2-ARCH-010a through 010h) were MOVED OUT of this file
  entirely, to a separate schema: lotar-fmi2.0.5-provenance.sch. They are
  fully Optional here now — no assert, no report, nothing. Rationale: these
  were consistently the first/largest hard-failure group against every real
  FMU tested (both hand-authored Reference-FMUs and the two production FMUs
  from Dymola/OCT), and none of it is recoverable from data already present
  in the file (see the changelog for the vendor-annotation search that
  confirmed this — neither test FMU carries author/copyright/license/
  stepSize equivalents anywhere, including VendorAnnotations). Provenance
  completeness is a real, separate archival requirement from structural/
  numerical completeness — it's now its own additive conformance layer
  instead of being baked into the base profile and failing every FMU tested
  so far. (2026-07-20, later same day: lotar-fmi2.0.5-provenance.sch was itself
  deprecated and moved to FMISchematron/deprecated/ — provenance moved again,
  this time into SRMDLOTARCore_Common.xsd/SRMDMICCore.xsd, see the 2026-07-21
  REVISION below for the current, unified mechanism.) @version (FMI2-ARCH-010i)
  originally stayed here at round 3 — it was already [R], not part of the
  failing set, and isn't purely "provenance" in the same sense (it's FMU
  content versioning, not authorship/IP/generation metadata) — but see the
  2026-07-21 REVISION below: it has since been migrated too, to unify with
  SSP's equivalent @fileversion field under one shared keyword.

  Also in round 3: all of PATTERN 6 (DefaultExperiment section presence,
  @startTime, @stopTime, @tolerance, and the conditional @stepSize) downgraded
  from [M] to [R]. A LOTAR-specific experiment scheme is planned to be the
  real mandatory home for this data (analogous to the provenance split
  above); until it exists, this file only warns instead of failing on
  missing experiment metadata.

  REVISION (2026-07-21, provenance unification): @version (FMI2-ARCH-010i, formerly [R] directly
  in this file) is RETIRED from here — migrated to the same unified Classification-layer mechanism
  as the other 7 provenance attributes (see the round-3 note above). @version is FMU
  content-versioning, the same concept as SSP's SystemStructureDescription/@fileversion, which
  already maps onto SRMDLOTARCore_Common.xsd's administrative.version keyword (already Mandatory,
  unchanged). Per explicit direction to unify FMI2/FMI3/SSP provenance into a single mechanism
  rather than maintain a format-specific @version check here in addition to the shared one, this
  rule is removed with no replacement in this file — administrative.version is now its sole
  authoritative home, for FMI2, FMI3, and SSP alike.

  Also this revision: @variableNamingConvention and @numberOfEventIndicators (FMI2's one
  provenance-layer attribute with no FMI3 analog) are RESTORED here as native rules — per explicit
  direction, they don't belong in "provenance" (SRMDLOTARCore_Common.xsd) at all, for either FMI
  version: they're technical/structural completeness flags (how ModelVariables are named; how many
  event indicators the model declares), not authorship/legal/generation metadata. Both were
  removed entirely (no rule anywhere) when the round-3 provenance migration swept all 8 root
  attributes out of this file as a block, without re-examining these two individually. Restored at
  [R] (not [M]) per real-corpus evidence: 50/173 (29%) and 34/173 (20%) of files respectively omit
  them — meaningfully worse than the ~98-100% adoption that justified hard-mandating
  @generationTool/@generationDateAndTime, but much better than @author/@copyright's ~80-90%
  omission rate. [R] is the corpus-grounded call; [M] is defensible if you want stronger
  enforcement now that these are back in the structural layer rather than the deprecated
  provenance one.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for FMI 2.0.5 modelDescription.xml</title>

  <!-- fmiModelDescription.xml has no target namespace in the base XSD, so no ns bindings needed. -->

  <!-- =============================================================== -->
  <!-- PATTERN 1: Root element — version reporting only                 -->
  <!-- (all 8 provenance attributes moved to lotar-fmi2.0.5-provenance.sch, -->
  <!-- see header REVISION round 3 note; they are fully Optional here)     -->
  <!-- =============================================================== -->
  <pattern id="root-attributes">
    <rule context="fmiModelDescription" id="FMI2-ARCH-010">

      <!--
        FMI2-ARCH-010i (@version) RETIRED 2026-07-21, migrated to the unified provenance
        mechanism (SRMDLOTARCore_Common.xsd's administrative.version, already Mandatory, shared
        with SSP's @fileversion). See this file's header REVISION note. Not reassigned.
      -->

      <report test="not(@variableNamingConvention)" id="FMI2-ARCH-010j" role="warning">
        [FMI2-ARCH-010j][R] fmiModelDescription/@variableNamingConvention is missing. Restored
        2026-07-21 as a native structural-completeness rule (not provenance); see this file's
        header REVISION note. 50/173 (29%) of real corpus files omit it.
      </report>

      <report test="not(@numberOfEventIndicators)" id="FMI2-ARCH-010k" role="warning">
        [FMI2-ARCH-010k][R] fmiModelDescription/@numberOfEventIndicators is missing (FMI2-only, no
        FMI3 analog; see fmi3ModelDescription.xsd's ModelStructure/EventIndicator list instead).
        Restored 2026-07-21 as a native structural-completeness rule (not provenance); see this
        file's header REVISION note. 34/173 (20%) of real corpus files omit it.
      </report>

    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 2: Interface type — exactly one, SourceFiles reporting   -->
  <!-- =============================================================== -->
  <pattern id="interface-type">
    <rule context="fmiModelDescription" id="FMI2-ARCH-020">
      <!-- Base standard only implies "at least one of ModelExchange/CoSimulation"
           in a documentation comment; the XSD (two independent minOccurs=0
           elements) does NOT enforce even that much. It also permits BOTH to
           be present at once (a "hybrid" FMU). This profile requires exactly
           one: an archived artifact should declare one execution environment,
           not a bundle whose applicable rules depend on which importer picks
           it up. -->
      <assert test="(ModelExchange and not(CoSimulation)) or (CoSimulation and not(ModelExchange))"
              id="FMI2-ARCH-020a" role="error">
        [FMI2-ARCH-020a][I] Exactly one of ModelExchange or CoSimulation must
        be present — never both, never neither. (Base XSD permits zero, one,
        or both.)
      </assert>
    </rule>

    <rule context="fmiModelDescription/ModelExchange" id="FMI2-ARCH-021">
      <report test="not(SourceFiles)" id="FMI2-ARCH-021a" role="warning">
        [FMI2-ARCH-021a][R] ModelExchange/SourceFiles is missing. Only
        meaningful for source-code FMUs, but flagged so a binary-only FMU is a
        deliberate choice, not an oversight.
      </report>
    </rule>

    <rule context="fmiModelDescription/CoSimulation" id="FMI2-ARCH-022">
      <report test="not(SourceFiles)" id="FMI2-ARCH-022a" role="warning">
        [FMI2-ARCH-022a][R] CoSimulation/SourceFiles is missing (see
        FMI2-ARCH-021a).
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 3: UnitDefinitions — name-uniqueness integrity           -->
  <!-- =============================================================== -->
  <pattern id="unit-integrity">
    <!-- UnitDefinitions itself carries no LOTAR comment anywhere in
         fmi2Unit.xsd, so the section and its leaf attributes stay pure
         base-XSD-optional. Only the doc-stated uniqueness constraints (which
         the XSD cannot express at all) are enforced here, unconditionally. -->
    <rule context="fmiModelDescription/UnitDefinitions/Unit" id="FMI2-ARCH-030">
      <assert test="count(../Unit[@name = current()/@name]) = 1" id="FMI2-ARCH-030a" role="error">
        [FMI2-ARCH-030a][I] Unit/@name must be unique within UnitDefinitions
        (doc-stated in base standard, not enforceable by XSD).
      </assert>
    </rule>

    <rule context="fmiModelDescription/UnitDefinitions/Unit/DisplayUnit" id="FMI2-ARCH-031">
      <assert test="count(../DisplayUnit[@name = current()/@name]) = 1" id="FMI2-ARCH-031a" role="error">
        [FMI2-ARCH-031a][I] DisplayUnit/@name must be unique within its
        enclosing Unit (different Units may reuse DisplayUnit names).
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 4: TypeDefinitions                                       -->
  <!-- =============================================================== -->
  <pattern id="type-definitions">
    <rule context="fmiModelDescription/TypeDefinitions/SimpleType" id="FMI2-ARCH-040">
      <report test="not(@description)" id="FMI2-ARCH-040a" role="warning">
        [FMI2-ARCH-040a][R] SimpleType/@description is missing.
      </report>
      <assert test="count(../SimpleType[@name = current()/@name]) = 1" id="FMI2-ARCH-040b" role="error">
        [FMI2-ARCH-040b][I] SimpleType/@name must be unique within
        TypeDefinitions (doc-stated, not enforceable by XSD).
      </assert>
      <assert test="count(/fmiModelDescription/ModelVariables/ScalarVariable[@name = current()/@name]) = 0"
              id="FMI2-ARCH-040c" role="error">
        [FMI2-ARCH-040c][I] SimpleType/@name must differ from every
        ScalarVariable/@name (doc-stated, not enforceable by XSD).
      </assert>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/SimpleType/Enumeration" id="FMI2-ARCH-041">
      <report test="not(@quantity)" id="FMI2-ARCH-041a" role="warning">
        [FMI2-ARCH-041a][R] SimpleType/Enumeration/@quantity is missing.
      </report>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/SimpleType/Enumeration/Item" id="FMI2-ARCH-042">
      <report test="not(@description)" id="FMI2-ARCH-042a" role="warning">
        [FMI2-ARCH-042a][R] Enumeration/Item/@description is missing.
      </report>
      <assert test="count(../Item[@value = current()/@value]) = 1" id="FMI2-ARCH-042b" role="error">
        [FMI2-ARCH-042b][I] Item/@value must be unique within its enclosing
        Enumeration (doc-stated, not enforceable by XSD).
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 5: LogCategories                                         -->
  <!-- =============================================================== -->
  <pattern id="log-categories">
    <rule context="fmiModelDescription" id="FMI2-ARCH-050">
      <report test="not(LogCategories)" id="FMI2-ARCH-050a" role="warning">
        [FMI2-ARCH-050a][R] LogCategories is missing.
      </report>
    </rule>

    <rule context="fmiModelDescription/LogCategories/Category" id="FMI2-ARCH-051">
      <assert test="count(../Category[@name = current()/@name]) = 1" id="FMI2-ARCH-051a" role="error">
        [FMI2-ARCH-051a][I] Category/@name must be unique within
        LogCategories (doc-stated, not enforceable by XSD).
      </assert>
      <report test="not(@description)" id="FMI2-ARCH-051b" role="warning">
        [FMI2-ARCH-051b][R] Category/@description is missing (cascades from
        the LogCategories-level warning).
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 6: DefaultExperiment                                     -->
  <!-- All [M] asserts downgraded to [R] warnings (2026-07-20, round 3) — -->
  <!-- a LOTAR-specific experiment scheme is planned as the real home for -->
  <!-- mandatory experiment metadata; until that exists, missing          -->
  <!-- DefaultExperiment data is flagged here but no longer fails.        -->
  <!-- =============================================================== -->
  <pattern id="default-experiment">
    <rule context="fmiModelDescription" id="FMI2-ARCH-060">
      <report test="not(DefaultExperiment)" id="FMI2-ARCH-060a" role="warning">
        [FMI2-ARCH-060a][R] DefaultExperiment section is missing. A baseline
        simulation setup should be reproducible without external records;
        see the planned LOTAR experiment scheme for the mandatory home of
        this data.
      </report>
    </rule>

    <rule context="fmiModelDescription/DefaultExperiment" id="FMI2-ARCH-061">
      <report test="not(@startTime)" id="FMI2-ARCH-061a" role="warning">
        [FMI2-ARCH-061a][R] DefaultExperiment/@startTime is missing.
      </report>
      <report test="not(@stopTime)" id="FMI2-ARCH-061b" role="warning">
        [FMI2-ARCH-061b][R] DefaultExperiment/@stopTime is missing.
      </report>
      <report test="not(@tolerance)" id="FMI2-ARCH-061c" role="warning">
        [FMI2-ARCH-061c][R] DefaultExperiment/@tolerance is missing.
      </report>
      <report test="../CoSimulation and not(@stepSize)" id="FMI2-ARCH-061d" role="warning">
        [FMI2-ARCH-061d][R, conditional] DefaultExperiment/@stepSize is
        missing (its "preferred communicationStepSize" meaning is only
        applicable when the FMU declares CoSimulation).
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 7: ScalarVariable — common attributes                    -->
  <!-- =============================================================== -->
  <pattern id="scalar-variable-common">
    <!-- ScalarVariable/@description and @causality were both [M] in the
         first round; loosened to Optional (no per-variable rule) after
         real-world corpus testing showed current-generation export tools
         (Dymola, OCT) routinely omit one or both across large fractions of
         their variable lists. See header REVISION note. -->
    <rule context="fmiModelDescription/ModelVariables/ScalarVariable" id="FMI2-ARCH-070">
      <report test="not(@initial)" id="FMI2-ARCH-070c" role="warning">
        [FMI2-ARCH-070c][R] ScalarVariable/@initial is missing. Base XSD
        deduces it from causality/variability when absent; archival readers
        should not have to.
      </report>
      <assert test="count(../ScalarVariable[@name = current()/@name]) = 1" id="FMI2-ARCH-070d" role="error">
        [FMI2-ARCH-070d][I] ScalarVariable/@name must be unique within
        ModelVariables (doc-stated, not enforceable by XSD).
      </assert>
    </rule>

    <!-- Model-level floor replacing the retired per-variable @causality
         mandate: don't require every variable to state causality, but warn
         if the FMU has literally no output and no parameter — a model that
         can't be told what to observe or configure is of limited archival
         use regardless of how individual variables are tagged. -->
    <rule context="fmiModelDescription/ModelVariables" id="FMI2-ARCH-072">
      <report test="not(ScalarVariable[@causality = 'output'])" id="FMI2-ARCH-072a" role="warning">
        [FMI2-ARCH-072a][R] No ScalarVariable has causality="output". A model
        with no declared outputs cannot be observed without external
        knowledge of which variables matter.
      </report>
      <report test="not(ScalarVariable[@causality = 'parameter'])" id="FMI2-ARCH-072b" role="warning">
        [FMI2-ARCH-072b][R] No ScalarVariable has causality="parameter". A
        model with no declared parameters cannot be configured without
        external knowledge of which variables matter.
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 8: Real / Integer attribute groups (ScalarVariable and    -->
  <!-- SimpleType share the same fmi2RealAttributes/fmi2IntegerAttributes) -->
  <!-- =============================================================== -->
  <pattern id="real-integer-attributes">
    <!-- Real/@quantity was [R] in the first round; loosened to Optional (no
         rule) after real-world corpus testing — it was by far the single
         largest warning source (1,765 of 3,814 variables in one production
         FMU), and it's the kind of field real tools leave to unit/
         displayUnit instead. See header REVISION note. -->
    <rule context="fmiModelDescription/ModelVariables/ScalarVariable/Real" id="FMI2-ARCH-080">
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI2-ARCH-080b" role="error">
        [FMI2-ARCH-080b][I] Real/@max must be &gt;= @min when both are present
        (doc-stated, not enforceable by XSD).
      </assert>
      <assert test="not(@nominal) or @nominal &gt; 0" id="FMI2-ARCH-080c" role="error">
        [FMI2-ARCH-080c][I] Real/@nominal must be &gt; 0 when present
        (doc-stated, not enforceable by XSD).
      </assert>
      <assert test="not(@start) or ((not(@max) or @start &lt;= @max) and (not(@min) or @start &gt;= @min))"
              id="FMI2-ARCH-080d" role="error">
        [FMI2-ARCH-080d][I] Real/@start must satisfy @max &gt;= @start &gt;=
        @min when @start is present (doc-stated, not enforceable by XSD).
      </assert>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/SimpleType/Real" id="FMI2-ARCH-081">
      <report test="not(@quantity)" id="FMI2-ARCH-081a" role="warning">
        [FMI2-ARCH-081a][R] SimpleType/Real/@quantity is missing.
      </report>
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI2-ARCH-081b" role="error">
        [FMI2-ARCH-081b][I] SimpleType/Real/@max must be &gt;= @min when both
        are present.
      </assert>
      <assert test="not(@nominal) or @nominal &gt; 0" id="FMI2-ARCH-081c" role="error">
        [FMI2-ARCH-081c][I] SimpleType/Real/@nominal must be &gt; 0 when
        present.
      </assert>
    </rule>

    <rule context="fmiModelDescription/ModelVariables/ScalarVariable/Integer" id="FMI2-ARCH-082">
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI2-ARCH-082a" role="error">
        [FMI2-ARCH-082a][I] Integer/@max must be &gt;= @min when both are
        present.
      </assert>
      <assert test="not(@start) or ((not(@max) or @start &lt;= @max) and (not(@min) or @start &gt;= @min))"
              id="FMI2-ARCH-082b" role="error">
        [FMI2-ARCH-082b][I] Integer/@start must satisfy @max &gt;= @start
        &gt;= @min when @start is present.
      </assert>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/SimpleType/Integer" id="FMI2-ARCH-083">
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI2-ARCH-083a" role="error">
        [FMI2-ARCH-083a][I] SimpleType/Integer/@max must be &gt;= @min when
        both are present.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 9: ScalarVariable/Enumeration                            -->
  <!-- =============================================================== -->
  <pattern id="enumeration-variable">
    <rule context="fmiModelDescription/ModelVariables/ScalarVariable/Enumeration" id="FMI2-ARCH-090">
      <!-- Per confirmed inventory: Enumeration/@max uses a STRICT inequality
           (max > min), unlike Real/Integer's max >= min. Confirmed as
           intentional, not a copy-paste inconsistency. -->
      <assert test="not(@max) or not(@min) or @max &gt; @min" id="FMI2-ARCH-090a" role="error">
        [FMI2-ARCH-090a][I] Enumeration/@max must be strictly &gt; @min when
        both are present (confirmed intentional — stricter than Real/Integer).
      </assert>
      <assert test="not(@start) or ((not(@max) or @start &lt;= @max) and (not(@min) or @start &gt;= @min))"
              id="FMI2-ARCH-090b" role="error">
        [FMI2-ARCH-090b][I] Enumeration/@start must satisfy @max &gt;= @start
        &gt;= @min when @start is present (confirmed to apply the same as
        Real/Integer).
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 10: ModelStructure                                       -->
  <!-- =============================================================== -->
  <pattern id="model-structure">
    <rule context="fmiModelDescription/ModelStructure" id="FMI2-ARCH-100">
      <report test="not(Outputs)" id="FMI2-ARCH-100a" role="warning">
        [FMI2-ARCH-100a][R] ModelStructure/Outputs is missing.
      </report>
      <report test="not(Derivatives)" id="FMI2-ARCH-100b" role="warning">
        [FMI2-ARCH-100b][R] ModelStructure/Derivatives is missing (static
        FMUs with no exposed states are rare).
      </report>
      <report test="not(InitialUnknowns)" id="FMI2-ARCH-100c" role="warning">
        [FMI2-ARCH-100c][R] ModelStructure/InitialUnknowns is missing.
      </report>
    </rule>

    <!-- Outputs, Derivatives and InitialUnknowns all use the same Unknown
         structure (either fmi2VariableDependency's shared complexType, for
         Outputs/Derivatives, or the structurally identical inline type used
         by InitialUnknowns) — treated identically per the confirmed
         inventory decision. -->
    <rule context="fmiModelDescription/ModelStructure/Outputs/Unknown
                  | fmiModelDescription/ModelStructure/Derivatives/Unknown
                  | fmiModelDescription/ModelStructure/InitialUnknowns/Unknown"
          id="FMI2-ARCH-101">
      <report test="not(@dependencies)" id="FMI2-ARCH-101a" role="warning">
        [FMI2-ARCH-101a][R] Unknown/@dependencies is missing (base XSD
        silently assumes dependency on ALL knowns when absent).
      </report>
      <!-- Was [M] in the first round; loosened to [R] after real-world
           corpus testing (694 of 2000+ Unknowns missing it in one production
           FMU). See header REVISION note. -->
      <report test="not(@dependenciesKind)" id="FMI2-ARCH-101b" role="warning">
        [FMI2-ARCH-101b][R] Unknown/@dependenciesKind is missing (base XSD
        otherwise silently assumes unstructured "dependent" dependency).
      </report>
      <assert test="not(@dependenciesKind) or @dependencies" id="FMI2-ARCH-101c" role="error">
        [FMI2-ARCH-101c][I] Base standard requires: if @dependenciesKind is
        present, @dependencies must be present too (doc-stated, not
        enforceable by XSD). Both fields are now [R] tier, so this integrity
        rule no longer forces either into practical mandatoriness — it only
        catches the specific case of dependenciesKind present without
        dependencies.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 11: Tool annotations — name-uniqueness integrity          -->
  <!-- =============================================================== -->
  <pattern id="annotation-integrity">
    <!-- Added per confirmed inventory decision: doc-stated in the base
         standard ("name must be unique with respect to all other elements of
         the VendorAnnotation list") but never XSD-enforceable, and not
         covered by any per-field LOTAR comment since fmi2Annotation.xsd
         itself carries none. Scoped to immediate siblings so it applies
         correctly both under VendorAnnotations and under each
         ScalarVariable/Annotations. -->
    <rule context="//Tool" id="FMI2-ARCH-110">
      <assert test="count(../Tool[@name = current()/@name]) = 1" id="FMI2-ARCH-110a" role="error">
        [FMI2-ARCH-110a][I] Tool/@name must be unique within its enclosing
        annotation list.
      </assert>
    </rule>
  </pattern>

</schema>
