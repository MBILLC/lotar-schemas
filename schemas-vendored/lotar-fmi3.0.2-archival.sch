<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for FMI 3.0.2 modelDescription.xml
  =================================================================================

  Base schema (UNMODIFIED, restriction-only profile):
    fmi3ModelDescription.xsd + includes (fmi3Variable.xsd, fmi3Type.xsd,
    fmi3Unit.xsd, fmi3Annotation.xsd, fmi3VariableDependency.xsd,
    fmi3InterfaceType.xsd, fmi3AttributeGroups.xsd), FMI 3.0.2, from
    FMISchematron/FMI3-schema/.

  Conformance identifier: LOTAR-FMI-3.0.2-ARCHIVAL

  Generated from fmi3.0.2-rule-inventory-suggestions.md (finalized, all
  open questions resolved). Every tier is either carried over from the
  FMI 2.0.5 archival profile's final (post round-3) state, or — for fields
  genuinely new in FMI3 (Clock, Dimension/arrays, the 8 sized integer
  types) — derived directly from the FMI 3.0.2 spec source text
  (docs/2_4_common_schema.adoc in the modelica/fmi-standard repo) and your
  explicit decisions, not invented.

  Tier legend (same meaning as FMI 2.0.5's archival.sch):
    [M] Mandatory  -> <assert role="error">  element/attribute must be
                       explicitly present even if base XSD allows omission.
    [R] Report     -> <report role="warning">  warn if missing, still
                       XSD-valid without it.
    [I] Integrity  -> always-on correctness/co-occurrence constraint that
                       closes a base-XSD expressiveness gap. Independent of
                       the M/R/O axis.
    (Plain "Optional" fields get no rule at all.)

  Validation order: XSD first, then this file. Provenance (root authorship/IP/generation metadata)
  is NOT this file's job — `lotar-fmi3.0.2-provenance.sch` (referenced here in earlier revisions)
  was deprecated 2026-07-20 and moved to `FMISchematron/deprecated/`; provenance now lives
  entirely in the unified SRMD Core mechanism (`SRMDLOTARCore_Common.xsd` + `SRMDMICCore.xsd`),
  shared identically with FMI 2.0.5 and SSP 2.0.1 (see the REVISION note further down this header).
  A LOTAR-specific experiment scheme (DefaultExperiment equivalent) is still only planned, not
  built — DefaultExperiment stays at [R] here, same as FMI2 post round-3.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), matching the FMI2
  file, EXCEPT that FMI3's array-valued @start attributes (space-separated
  lists — genuinely new, FMI2's Real/Integer/Enumeration @start were all
  scalar) require per-token bounds checking that plain XPath 1.0 cannot
  express. This file uses the EXSLT `str:tokenize()` extension function
  (declared via the <ns> element below) to do it — confirmed working against
  lxml's libxslt/libexslt at authoring time. If you ever move this profile
  to a Schematron/XSLT processor without EXSLT support, the array `@start`
  bounds rules (FMI3-ARCH-091d/092d/1?0d, see Pattern 9/10/12) are the ones
  that would need rewriting (e.g. to XPath 2.0's native every/some quantifiers
  if you switch queryBinding to xslt2).

  Ambiguities the FMI2 recalibration already resolved and this file inherits
  without re-litigating: ScalarVariable/@description and per-variable
  @causality are Optional (not Mandatory); Real/Float @quantity is Optional;
  dependenciesKind is [R] not [M]; DefaultExperiment section is [R] not [M].
  Expect the FMI3 exactly-one-interface rule to show a similar real-world
  failure rate to FMI2's ~32% once tested against a broad corpus — that is
  by design, not a bug (see lotar-fmi2.0.5-CHANGELOG.md / the FMI2 full-corpus
  test report for the reasoning: hybrid FMUs are useful test material but bad
  archival artifacts).

  REVISION (2026-07-21, provenance unification): @version (FMI3-ARCH-010i, formerly [R] directly
  in this file) is RETIRED from here — migrated to the same unified Classification-layer mechanism
  as the other 7 provenance attributes. @version is FMU content-versioning, the same concept as
  SSP's SystemStructureDescription/@fileversion, which already maps onto
  SRMDLOTARCore_Common.xsd's administrative.version keyword (already Mandatory, unchanged). Per
  explicit direction to unify FMI2/FMI3/SSP provenance into a single mechanism rather than
  maintain a format-specific @version check here in addition to the shared one, this rule is
  removed with no replacement in this file — administrative.version is now its sole authoritative
  home, for FMI2, FMI3, and SSP alike.

  Also this revision: @variableNamingConvention is RESTORED here as a native rule — per explicit
  direction, it doesn't belong in "provenance" (SRMDLOTARCore_Common.xsd) for either FMI version:
  it's a technical/structural completeness flag (how ModelVariables are named), not authorship/
  legal/generation metadata. It was removed entirely (no rule anywhere) when the provenance
  migration swept all 7 FMI3 root attributes out of this file as a block, without re-examining
  this one individually. Restored at [R] (not [M]) per real-corpus evidence: 13/89 (15%) of files
  omit it — meaningfully worse than the ~97-100% adoption that justified hard-mandating
  @generationTool/@generationDateAndTime in the SSD/SSV profiles, but much better than
  @author/@copyright's ~83-94% omission rate. [R] is the corpus-grounded call; [M] is defensible
  if you want stronger enforcement now that this is back in the structural layer. (FMI3 has no
  @numberOfEventIndicators analog — removed entirely from the base standard, replaced by
  ModelStructure/EventIndicator, already tiered Optional per Pattern 13's own reasoning.)
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for FMI 3.0.2 modelDescription.xml</title>

  <ns prefix="str" uri="http://exslt.org/strings"/>

  <!-- =============================================================== -->
  <!-- PATTERN 1: Root element                                          -->
  <!-- (provenance attributes moved to the unified SRMD Core mechanism  -->
  <!-- see header REVISION notes)                                      -->
  <!-- =============================================================== -->
  <pattern id="root-attributes">
    <rule context="fmiModelDescription" id="FMI3-ARCH-010">
      <!--
        FMI3-ARCH-010i (@version) RETIRED 2026-07-21, migrated to the unified provenance
        mechanism (SRMDLOTARCore_Common.xsd's administrative.version). Not reassigned.
      -->
      <report test="not(@variableNamingConvention)" id="FMI3-ARCH-010j" role="warning">
        [FMI3-ARCH-010j][R] fmiModelDescription/@variableNamingConvention is missing. Restored
        2026-07-21 as a native structural-completeness rule (not provenance); see this file's
        header REVISION note. 13/89 (15%) of real corpus files omit it.
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 2: Interface type — exactly one of three                 -->
  <!-- No SourceFiles analog: FMI3 moved source-file listing entirely   -->
  <!-- out of modelDescription.xml into buildDescription.xml, which is  -->
  <!-- out of scope for this round (see header + ToDo-Later in the      -->
  <!-- inventory doc).                                                  -->
  <!-- =============================================================== -->
  <pattern id="interface-type">
    <rule context="fmiModelDescription" id="FMI3-ARCH-020">
      <!-- Generalizes FMI2-ARCH-020a from two options to three. Base XSD
           permits zero, one, two, or all three of ModelExchange/
           CoSimulation/ScheduledExecution simultaneously; this profile
           requires exactly one, for the same reason as FMI2: an archived
           artifact should declare one execution environment, not a bundle
           whose applicable rules depend on which importer picks it up. -->
      <assert test="count(ModelExchange | CoSimulation | ScheduledExecution) = 1"
              id="FMI3-ARCH-020a" role="error">
        [FMI3-ARCH-020a][I] Exactly one of ModelExchange, CoSimulation, or
        ScheduledExecution must be present — never zero, two, or all three.
        (Base XSD permits any combination.)
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 3: UnitDefinitions — name-uniqueness integrity            -->
  <!-- =============================================================== -->
  <pattern id="unit-integrity">
    <rule context="fmiModelDescription/UnitDefinitions/Unit" id="FMI3-ARCH-030">
      <assert test="count(../Unit[@name = current()/@name]) = 1" id="FMI3-ARCH-030a" role="error">
        [FMI3-ARCH-030a][I] Unit/@name must be unique within UnitDefinitions
        (doc-stated in base standard, not enforceable by XSD). = FMI2-ARCH-030a.
      </assert>
    </rule>

    <rule context="fmiModelDescription/UnitDefinitions/Unit/DisplayUnit" id="FMI3-ARCH-031">
      <assert test="count(../DisplayUnit[@name = current()/@name]) = 1" id="FMI3-ARCH-031a" role="error">
        [FMI3-ARCH-031a][I] DisplayUnit/@name must be unique within its
        enclosing Unit (different Units may reuse DisplayUnit names). =
        FMI2-ARCH-031a.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 4: TypeDefinitions                                       -->
  <!-- 15 kinds share fmi3TypeDefinitionBase (@name, @description); this -->
  <!-- pattern's description/uniqueness rules apply to all of them via  -->
  <!-- a union context. Per-kind numeric constraints (Real/Integer/     -->
  <!-- Enumeration type-defs) get their own rules below, mirroring       -->
  <!-- Pattern 8/9's split for ModelVariables.                           -->
  <!-- =============================================================== -->
  <pattern id="type-definitions">
    <rule context="fmiModelDescription/TypeDefinitions/Float32Type
                  | fmiModelDescription/TypeDefinitions/Float64Type
                  | fmiModelDescription/TypeDefinitions/Int8Type
                  | fmiModelDescription/TypeDefinitions/UInt8Type
                  | fmiModelDescription/TypeDefinitions/Int16Type
                  | fmiModelDescription/TypeDefinitions/UInt16Type
                  | fmiModelDescription/TypeDefinitions/Int32Type
                  | fmiModelDescription/TypeDefinitions/UInt32Type
                  | fmiModelDescription/TypeDefinitions/Int64Type
                  | fmiModelDescription/TypeDefinitions/UInt64Type
                  | fmiModelDescription/TypeDefinitions/BooleanType
                  | fmiModelDescription/TypeDefinitions/StringType
                  | fmiModelDescription/TypeDefinitions/BinaryType
                  | fmiModelDescription/TypeDefinitions/EnumerationType
                  | fmiModelDescription/TypeDefinitions/ClockType"
          id="FMI3-ARCH-040">
      <report test="not(@description)" id="FMI3-ARCH-040a" role="warning">
        [FMI3-ARCH-040a][R] TypeDefinitions/*/@description is missing. =
        FMI2-ARCH-040a, now applies uniformly across all 15 type-definition
        kinds instead of just SimpleType.
      </report>
      <assert test="count(../*[@name = current()/@name]) = 1" id="FMI3-ARCH-040b" role="error">
        [FMI3-ARCH-040b][I] TypeDefinitions/*/@name must be unique within
        TypeDefinitions, across all kinds (doc-stated, not enforceable by
        XSD). = FMI2-ARCH-040b.
      </assert>
      <assert test="count(/fmiModelDescription/ModelVariables/*[@name = current()/@name]) = 0"
              id="FMI3-ARCH-040c" role="error">
        [FMI3-ARCH-040c][I] TypeDefinitions/*/@name must differ from every
        ModelVariables/*/@name (doc-stated, not enforceable by XSD). =
        FMI2-ARCH-040c.
      </assert>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/Float32Type
                  | fmiModelDescription/TypeDefinitions/Float64Type"
          id="FMI3-ARCH-041">
      <report test="not(@quantity)" id="FMI3-ARCH-041a" role="warning">
        [FMI3-ARCH-041a][R] Float32Type/Float64Type/@quantity is missing. =
        FMI2-ARCH-081a (SimpleType/Real/@quantity).
      </report>
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI3-ARCH-041b" role="error">
        [FMI3-ARCH-041b][I] Float32Type/Float64Type/@max must be &gt;= @min
        when both are present. = FMI2-ARCH-081b.
      </assert>
      <assert test="not(@nominal) or @nominal &gt; 0" id="FMI3-ARCH-041c" role="error">
        [FMI3-ARCH-041c][I] Float32Type/Float64Type/@nominal must be &gt; 0
        when present. = FMI2-ARCH-081c.
      </assert>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/Int8Type
                  | fmiModelDescription/TypeDefinitions/UInt8Type
                  | fmiModelDescription/TypeDefinitions/Int16Type
                  | fmiModelDescription/TypeDefinitions/UInt16Type
                  | fmiModelDescription/TypeDefinitions/Int32Type
                  | fmiModelDescription/TypeDefinitions/UInt32Type
                  | fmiModelDescription/TypeDefinitions/Int64Type
                  | fmiModelDescription/TypeDefinitions/UInt64Type"
          id="FMI3-ARCH-042">
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI3-ARCH-042a" role="error">
        [FMI3-ARCH-042a][I] Int*Type/UInt*Type/@max must be &gt;= @min when
        both are present, across all 8 sized integer kinds. = FMI2-ARCH-083a.
      </assert>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/EnumerationType" id="FMI3-ARCH-043">
      <report test="not(@quantity)" id="FMI3-ARCH-043a" role="warning">
        [FMI3-ARCH-043a][R] EnumerationType/@quantity is missing. =
        FMI2-ARCH-041a.
      </report>
      <assert test="not(@max) or not(@min) or @max &gt; @min" id="FMI3-ARCH-043b" role="error">
        [FMI3-ARCH-043b][I] EnumerationType/@max must be strictly &gt; @min
        when both are present (confirmed intentional, consistent with the
        variable-level Enumeration rule below). = FMI2-ARCH-090a in spirit.
      </assert>
    </rule>

    <rule context="fmiModelDescription/TypeDefinitions/EnumerationType/Item" id="FMI3-ARCH-044">
      <report test="not(@description)" id="FMI3-ARCH-044a" role="warning">
        [FMI3-ARCH-044a][R] EnumerationType/Item/@description is missing. =
        FMI2-ARCH-042a.
      </report>
      <assert test="count(../Item[@value = current()/@value]) = 1" id="FMI3-ARCH-044b" role="error">
        [FMI3-ARCH-044b][I] Item/@value must be unique within its enclosing
        EnumerationType (doc-stated, not enforceable by XSD). =
        FMI2-ARCH-042b.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 5: LogCategories                                         -->
  <!-- =============================================================== -->
  <pattern id="log-categories">
    <rule context="fmiModelDescription" id="FMI3-ARCH-050">
      <report test="not(LogCategories)" id="FMI3-ARCH-050a" role="warning">
        [FMI3-ARCH-050a][R] LogCategories is missing. = FMI2-ARCH-050a.
      </report>
    </rule>

    <rule context="fmiModelDescription/LogCategories/Category" id="FMI3-ARCH-051">
      <assert test="count(../Category[@name = current()/@name]) = 1" id="FMI3-ARCH-051a" role="error">
        [FMI3-ARCH-051a][I] Category/@name must be unique within
        LogCategories (doc-stated, not enforceable by XSD). = FMI2-ARCH-051a.
      </assert>
      <report test="not(@description)" id="FMI3-ARCH-051b" role="warning">
        [FMI3-ARCH-051b][R] Category/@description is missing. = FMI2-ARCH-051b.
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 6: DefaultExperiment                                     -->
  <!-- Same [R]-everywhere tier as FMI2 post round-3 — a LOTAR-specific -->
  <!-- experiment scheme is still only planned, not built.              -->
  <!-- =============================================================== -->
  <pattern id="default-experiment">
    <rule context="fmiModelDescription" id="FMI3-ARCH-060">
      <report test="not(DefaultExperiment)" id="FMI3-ARCH-060a" role="warning">
        [FMI3-ARCH-060a][R] DefaultExperiment section is missing. =
        FMI2-ARCH-060a.
      </report>
    </rule>

    <rule context="fmiModelDescription/DefaultExperiment" id="FMI3-ARCH-061">
      <report test="not(@startTime)" id="FMI3-ARCH-061a" role="warning">
        [FMI3-ARCH-061a][R] DefaultExperiment/@startTime is missing. =
        FMI2-ARCH-061a.
      </report>
      <report test="not(@stopTime)" id="FMI3-ARCH-061b" role="warning">
        [FMI3-ARCH-061b][R] DefaultExperiment/@stopTime is missing. =
        FMI2-ARCH-061b.
      </report>
      <report test="not(@tolerance)" id="FMI3-ARCH-061c" role="warning">
        [FMI3-ARCH-061c][R] DefaultExperiment/@tolerance is missing. =
        FMI2-ARCH-061c.
      </report>
      <report test="../CoSimulation and not(@stepSize)" id="FMI3-ARCH-061d" role="warning">
        [FMI3-ARCH-061d][R, conditional] DefaultExperiment/@stepSize is
        missing (its "preferred communicationStepSize" meaning is only
        applicable when the FMU declares CoSimulation). = FMI2-ARCH-061d.
        Inherited unchanged from FMI2 — not re-evaluated for whether
        ScheduledExecution should also trigger this check; flag for a future
        pass if that matters once a real ScheduledExecution corpus exists.
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 7: ModelVariables — common attributes, all 15 kinds       -->
  <!-- No ScalarVariable wrapper in FMI3 — union context over all 15    -->
  <!-- variable element names directly under ModelVariables.            -->
  <!-- =============================================================== -->
  <pattern id="variable-common">
    <rule context="fmiModelDescription/ModelVariables/Float32
                  | fmiModelDescription/ModelVariables/Float64
                  | fmiModelDescription/ModelVariables/Int8
                  | fmiModelDescription/ModelVariables/UInt8
                  | fmiModelDescription/ModelVariables/Int16
                  | fmiModelDescription/ModelVariables/UInt16
                  | fmiModelDescription/ModelVariables/Int32
                  | fmiModelDescription/ModelVariables/UInt32
                  | fmiModelDescription/ModelVariables/Int64
                  | fmiModelDescription/ModelVariables/UInt64
                  | fmiModelDescription/ModelVariables/Boolean
                  | fmiModelDescription/ModelVariables/String
                  | fmiModelDescription/ModelVariables/Binary
                  | fmiModelDescription/ModelVariables/Enumeration
                  | fmiModelDescription/ModelVariables/Clock"
          id="FMI3-ARCH-070">
      <assert test="count(../*[@name = current()/@name]) = 1" id="FMI3-ARCH-070d" role="error">
        [FMI3-ARCH-070d][I] Variable @name must be unique within
        ModelVariables, across all 15 kinds (doc-stated, not enforceable by
        XSD). = FMI2-ARCH-070d.
      </assert>
      <!-- No @initial rule here (FMI2-ARCH-070c had one): FMI3's @initial
           lives on fmi3InitializableVariable, which Clock does NOT extend
           (Clock extends fmi3TypedVariable directly) — applying it
           uniformly across all 15 kinds would misfire on every Clock
           variable. Handled per-kind instead where @initial actually
           exists; not carried forward as a blanket rule this round since
           it wasn't flagged as a must-have in the finalized inventory. -->
    </rule>

    <!-- Model-level floor replacing the retired per-variable @causality
         mandate, same reasoning as FMI2-ARCH-072. -->
    <rule context="fmiModelDescription/ModelVariables" id="FMI3-ARCH-072">
      <report test="not(*[@causality = 'output'])" id="FMI3-ARCH-072a" role="warning">
        [FMI3-ARCH-072a][R] No variable has causality="output". = FMI2-ARCH-072a.
      </report>
      <report test="not(*[@causality = 'parameter'])" id="FMI3-ARCH-072b" role="warning">
        [FMI3-ARCH-072b][R] No variable has causality="parameter". =
        FMI2-ARCH-072b. (structuralParameter deliberately excluded — no
        "at least one" check for it, per your confirmed answer.)
      </report>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 8: ModelVariables — arrayable variables (Dimension)       -->
  <!-- Entirely new in FMI3. Applies to every kind except Clock (Clock   -->
  <!-- extends fmi3TypedVariable directly, not fmi3ArrayableVariable —   -->
  <!-- Clocks are always scalar per the base standard).                  -->
  <!-- =============================================================== -->
  <pattern id="dimension-integrity">
    <rule context="fmiModelDescription/ModelVariables/Float32/Dimension
                  | fmiModelDescription/ModelVariables/Float64/Dimension
                  | fmiModelDescription/ModelVariables/Int8/Dimension
                  | fmiModelDescription/ModelVariables/UInt8/Dimension
                  | fmiModelDescription/ModelVariables/Int16/Dimension
                  | fmiModelDescription/ModelVariables/UInt16/Dimension
                  | fmiModelDescription/ModelVariables/Int32/Dimension
                  | fmiModelDescription/ModelVariables/UInt32/Dimension
                  | fmiModelDescription/ModelVariables/Int64/Dimension
                  | fmiModelDescription/ModelVariables/UInt64/Dimension
                  | fmiModelDescription/ModelVariables/Boolean/Dimension
                  | fmiModelDescription/ModelVariables/String/Dimension
                  | fmiModelDescription/ModelVariables/Binary/Dimension
                  | fmiModelDescription/ModelVariables/Enumeration/Dimension"
          id="FMI3-ARCH-080">
      <!-- Confirmed by you: exactly one of @start / @valueReference, not
           "at least one" or purely informational. Base XSD makes both
           optional and independent. -->
      <assert test="(@start and not(@valueReference)) or (@valueReference and not(@start))"
              id="FMI3-ARCH-080a" role="error">
        [FMI3-ARCH-080a][I] Dimension must have exactly one of @start or
        @valueReference — never both, never neither.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 9: ModelVariables — Float32 / Float64                    -->
  <!-- @start is now array-valued (xs:list) — uses EXSLT str:tokenize()  -->
  <!-- for per-element bounds checking, see file header note.           -->
  <!-- =============================================================== -->
  <pattern id="float-attributes">
    <rule context="fmiModelDescription/ModelVariables/Float32
                  | fmiModelDescription/ModelVariables/Float64"
          id="FMI3-ARCH-090">
      <!-- @quantity stays Optional (no rule) — FMI2 post-round-2 lesson:
           it was the single largest warning source in the real corpus. -->
      <let name="lo" value="@min"/>
      <let name="hi" value="@max"/>
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI3-ARCH-090b" role="error">
        [FMI3-ARCH-090b][I] Float32/Float64/@max must be &gt;= @min when
        both are present. = FMI2-ARCH-080b.
      </assert>
      <assert test="not(@nominal) or @nominal &gt; 0" id="FMI3-ARCH-090c" role="error">
        [FMI3-ARCH-090c][I] Float32/Float64/@nominal must be &gt; 0 when
        present. = FMI2-ARCH-080c.
      </assert>
      <assert test="not(@start) or (
                      not(str:tokenize(@start, ' ')[$hi != '' and number(.) &gt; number($hi)])
                      and
                      not(str:tokenize(@start, ' ')[$lo != '' and number(.) &lt; number($lo)])
                    )"
              id="FMI3-ARCH-090d" role="error">
        [FMI3-ARCH-090d][I] every token of Float32/Float64/@start (a
        space-separated list, one value per array element) must satisfy
        @max &gt;= token &gt;= @min when @start is present. In spirit =
        FMI2-ARCH-080d, generalized from a scalar comparison to a per-element
        one because FMI3 arrays make @start list-valued.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 10: ModelVariables — Int8/UInt8/.../Int64/UInt64          -->
  <!-- =============================================================== -->
  <pattern id="integer-attributes">
    <rule context="fmiModelDescription/ModelVariables/Int8
                  | fmiModelDescription/ModelVariables/UInt8
                  | fmiModelDescription/ModelVariables/Int16
                  | fmiModelDescription/ModelVariables/UInt16
                  | fmiModelDescription/ModelVariables/Int32
                  | fmiModelDescription/ModelVariables/UInt32
                  | fmiModelDescription/ModelVariables/Int64
                  | fmiModelDescription/ModelVariables/UInt64"
          id="FMI3-ARCH-100">
      <let name="lo" value="@min"/>
      <let name="hi" value="@max"/>
      <assert test="not(@max) or not(@min) or @max &gt;= @min" id="FMI3-ARCH-100a" role="error">
        [FMI3-ARCH-100a][I] Int*/UInt*/@max must be &gt;= @min when both are
        present, across all 8 sized integer kinds. = FMI2-ARCH-082a.
      </assert>
      <assert test="not(@start) or (
                      not(str:tokenize(@start, ' ')[$hi != '' and number(.) &gt; number($hi)])
                      and
                      not(str:tokenize(@start, ' ')[$lo != '' and number(.) &lt; number($lo)])
                    )"
              id="FMI3-ARCH-100b" role="error">
        [FMI3-ARCH-100b][I] every token of Int*/UInt*/@start must satisfy
        @max &gt;= token &gt;= @min when @start is present. = FMI2-ARCH-082b,
        generalized to a list per the same reasoning as FMI3-ARCH-090d.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 11: ModelVariables — Enumeration                         -->
  <!-- Note the STRICT max &gt; min (unlike Real/Integer's &gt;=),      -->
  <!-- confirmed intentional, matching FMI2-ARCH-090a.                  -->
  <!-- =============================================================== -->
  <pattern id="enumeration-variable">
    <rule context="fmiModelDescription/ModelVariables/Enumeration" id="FMI3-ARCH-110">
      <let name="lo" value="@min"/>
      <let name="hi" value="@max"/>
      <assert test="not(@max) or not(@min) or @max &gt; @min" id="FMI3-ARCH-110a" role="error">
        [FMI3-ARCH-110a][I] Enumeration/@max must be strictly &gt; @min when
        both are present (confirmed intentional). = FMI2-ARCH-090a.
      </assert>
      <assert test="not(@start) or (
                      not(str:tokenize(@start, ' ')[$hi != '' and number(.) &gt; number($hi)])
                      and
                      not(str:tokenize(@start, ' ')[$lo != '' and number(.) &lt; number($lo)])
                    )"
              id="FMI3-ARCH-110b" role="error">
        [FMI3-ARCH-110b][I] every token of Enumeration/@start must satisfy
        @max &gt;= token &gt;= @min when @start is present (non-strict here,
        same as FMI2-ARCH-090b — only the min/max relationship itself is
        strict, not the start bound).
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 12: ModelVariables — Clock                               -->
  <!-- Entirely new, no FMI2 analog. Every rule below is grounded in     -->
  <!-- specific "must"/"required"/"may only" language from the FMI 3.0.2 -->
  <!-- spec source (docs/2_4_common_schema.adoc), confirmed by you where -->
  <!-- flagged as needing a decision. See fmi3.0.2-rule-inventory-        -->
  <!-- suggestions.md §13 for the full quoted derivation.                -->
  <!-- =============================================================== -->
  <pattern id="clock-integrity">
    <rule context="fmiModelDescription/ModelVariables/Clock" id="FMI3-ARCH-120">
      <!-- @priority: forbidden for output Clocks, mandatory for input
           Clocks under ScheduledExecution. -->
      <assert test="not(@causality = 'output') or not(@priority)" id="FMI3-ARCH-120a" role="error">
        [FMI3-ARCH-120a][I] Clock/@priority must NOT be present when
        @causality = "output" (spec, verbatim: "Output Clocks must not have
        this attribute.").
      </assert>
      <assert test="not(@causality = 'input' and /fmiModelDescription/ScheduledExecution) or @priority"
              id="FMI3-ARCH-120b" role="error">
        [FMI3-ARCH-120b][I] Clock/@priority is mandatory for input Clocks
        when the FMU declares a ScheduledExecution interface (spec, verbatim:
        "This attribute is mandatory for input Clocks in Scheduled
        Execution."). Applies even when ScheduledExecution is only one of
        several declared interfaces on a mixed-interface FMU — though note
        FMI3-ARCH-020a already requires exactly one interface, so in
        practice this only fires when ScheduledExecution is the sole one.
      </assert>

      <!-- @intervalDecimal: required for constant, optional for
           fixed/tunable, forbidden otherwise. -->
      <assert test="not(@intervalVariability = 'constant') or @intervalDecimal" id="FMI3-ARCH-120c" role="error">
        [FMI3-ARCH-120c][I] Clock/@intervalDecimal is required when
        @intervalVariability = "constant" (spec: "required for constant
        periodic Clocks").
      </assert>
      <assert test="@intervalVariability = 'constant' or @intervalVariability = 'fixed' or @intervalVariability = 'tunable' or not(@intervalDecimal)"
              id="FMI3-ARCH-120d" role="error">
        [FMI3-ARCH-120d][I] Clock/@intervalDecimal must NOT be present unless
        @intervalVariability is "constant", "fixed", or "tunable" (spec,
        verbatim: "It must not be used otherwise.").
      </assert>
      <assert test="not(@intervalDecimal) or @intervalDecimal &gt; 0" id="FMI3-ARCH-120e" role="error">
        [FMI3-ARCH-120e][I] Clock/@intervalDecimal must be &gt; 0 when
        present (spec: "This value must be greater than 0.0.").
      </assert>

      <!-- @shiftDecimal: requires intervalDecimal, must be >= 0. -->
      <assert test="not(@shiftDecimal) or @intervalDecimal" id="FMI3-ARCH-120f" role="error">
        [FMI3-ARCH-120f][I] Clock/@shiftDecimal requires @intervalDecimal to
        be present (spec, verbatim: "This attribute requires that
        intervalDecimal is present.").
      </assert>
      <assert test="not(@shiftDecimal) or @shiftDecimal &gt;= 0" id="FMI3-ARCH-120g" role="error">
        [FMI3-ARCH-120g][I] Clock/@shiftDecimal must be &gt;= 0 when present
        (spec: "must be equal to or greater than 0.0").
      </assert>

      <!-- @resolution: forbidden unless periodic, required under a
           three-way condition. -->
      <assert test="@intervalVariability = 'constant' or @intervalVariability = 'fixed' or @intervalVariability = 'tunable' or not(@resolution)"
              id="FMI3-ARCH-120h" role="error">
        [FMI3-ARCH-120h][I] Clock/@resolution must NOT be present unless
        @intervalVariability is "constant", "fixed", or "tunable" (spec,
        verbatim: "This attribute must only be used for periodic Clocks.").
      </assert>
      <assert test="not(
                      (@intervalVariability = 'constant' or @intervalVariability = 'fixed' or @intervalVariability = 'tunable')
                      and @supportsFraction = 'true'
                      and @intervalCounter
                    ) or @resolution"
              id="FMI3-ARCH-120i" role="error">
        [FMI3-ARCH-120i][I] Clock/@resolution is required when
        @intervalVariability is a periodic type AND @supportsFraction =
        "true" AND @intervalCounter is present (spec: "required for
        time-based periodic clocks if supportsFraction = true and
        intervalCounter is present").
      </assert>

      <!-- @intervalCounter: conditional co-occurrence + value. -->
      <assert test="not(@intervalCounter) or (
                      @supportsFraction = 'true'
                      and (@intervalVariability = 'constant' or @intervalVariability = 'fixed' or @intervalVariability = 'tunable')
                    )"
              id="FMI3-ARCH-120j" role="error">
        [FMI3-ARCH-120j][I] Clock/@intervalCounter may only be present if
        @supportsFraction = "true" and @intervalVariability is "constant",
        "fixed", or "tunable" (spec, verbatim: "It must not be used
        otherwise.").
      </assert>
      <assert test="not(@intervalCounter) or @intervalCounter &gt; 0" id="FMI3-ARCH-120k" role="error">
        [FMI3-ARCH-120k][I] Clock/@intervalCounter must be &gt; 0 when
        present (spec: "the value of this attribute must be greater than
        0").
      </assert>

      <!-- @shiftCounter: requires intervalCounter, must be >= 0. -->
      <assert test="not(@shiftCounter) or @intervalCounter" id="FMI3-ARCH-120l" role="error">
        [FMI3-ARCH-120l][I] Clock/@shiftCounter requires @intervalCounter to
        be present (spec, verbatim: "This attribute requires that
        intervalCounter is present.").
      </assert>
      <assert test="not(@shiftCounter) or @shiftCounter &gt;= 0" id="FMI3-ARCH-120m" role="error">
        [FMI3-ARCH-120m][I] Clock/@shiftCounter must be &gt;= 0 when present
        (spec: "must be equal to or greater than 0").
      </assert>

      <!-- Decimal-group vs. counter-group mutual exclusivity — confirmed
           by you; not itself a direct spec quote, but your explicit call. -->
      <assert test="not((@intervalDecimal or @shiftDecimal) and (@intervalCounter or @shiftCounter or @resolution))"
              id="FMI3-ARCH-120n" role="error">
        [FMI3-ARCH-120n][I] Clock's decimal-form timing attributes
        (@intervalDecimal/@shiftDecimal) and counter-form timing attributes
        (@intervalCounter/@shiftCounter/@resolution) are mutually exclusive
        — a Clock must use one representation or the other, not both
        (confirmed by you; not explicitly stated in the spec text either
        way).
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 13: ModelStructure                                       -->
  <!-- =============================================================== -->
  <pattern id="model-structure">
    <rule context="fmiModelDescription/ModelStructure" id="FMI3-ARCH-130">
      <report test="not(Output)" id="FMI3-ARCH-130a" role="warning">
        [FMI3-ARCH-130a][R] ModelStructure/Output is missing. = FMI2-ARCH-100a.
      </report>
      <report test="not(ContinuousStateDerivative)" id="FMI3-ARCH-130b" role="warning">
        [FMI3-ARCH-130b][R] ModelStructure/ContinuousStateDerivative is
        missing (static FMUs with no exposed states are rare). =
        FMI2-ARCH-100b.
      </report>
      <report test="not(InitialUnknown)" id="FMI3-ARCH-130c" role="warning">
        [FMI3-ARCH-130c][R] ModelStructure/InitialUnknown is missing. =
        FMI2-ARCH-100c.
      </report>
      <!-- ClockedState: only meaningful if the FMU actually has Clock
           variables. R when it does, no rule (Optional) when it doesn't. -->
      <report test="/fmiModelDescription/ModelVariables/Clock and not(ClockedState)"
              id="FMI3-ARCH-130d" role="warning">
        [FMI3-ARCH-130d][R, conditional] ModelStructure/ClockedState is
        missing, despite the FMU declaring at least one Clock variable.
        No rule at all when the FMU has no Clocks (Optional in that case).
      </report>
      <!-- EventIndicator: confirmed Optional (no rule) — your original M
           note was self-contradictory ("not all FMUs have Events"),
           resolved to no rule at all rather than R or M. -->
    </rule>

    <!-- Output/ContinuousStateDerivative/ClockedState/InitialUnknown/
         EventIndicator all use the same fmi3Unknown structure. -->
    <rule context="fmiModelDescription/ModelStructure/Output
                  | fmiModelDescription/ModelStructure/ContinuousStateDerivative
                  | fmiModelDescription/ModelStructure/ClockedState
                  | fmiModelDescription/ModelStructure/InitialUnknown
                  | fmiModelDescription/ModelStructure/EventIndicator"
          id="FMI3-ARCH-131">
      <report test="not(@dependencies)" id="FMI3-ARCH-131a" role="warning">
        [FMI3-ARCH-131a][R] Unknown/@dependencies is missing (base XSD
        silently assumes dependency on ALL knowns when absent). =
        FMI2-ARCH-101a.
      </report>
      <report test="not(@dependenciesKind)" id="FMI3-ARCH-131b" role="warning">
        [FMI3-ARCH-131b][R] Unknown/@dependenciesKind is missing. =
        FMI2-ARCH-101b.
      </report>
      <assert test="not(@dependenciesKind) or @dependencies" id="FMI3-ARCH-131c" role="error">
        [FMI3-ARCH-131c][I] If @dependenciesKind is present, @dependencies
        must be present too (doc-stated, not enforceable by XSD). =
        FMI2-ARCH-101c.
      </assert>
    </rule>
  </pattern>

  <!-- =============================================================== -->
  <!-- PATTERN 14: Annotations — type-uniqueness integrity               -->
  <!-- Confirmed by you: treat as an [I] integrity rule despite no       -->
  <!-- xs:documentation in fmi3Annotation.xsd stating it explicitly —    -->
  <!-- an oversight in the base standard's documentation, per your note, -->
  <!-- not a reason to skip the check.                                  -->
  <!-- =============================================================== -->
  <pattern id="annotation-integrity">
    <rule context="//Annotation" id="FMI3-ARCH-140">
      <assert test="count(../Annotation[@type = current()/@type]) = 1" id="FMI3-ARCH-140a" role="error">
        [FMI3-ARCH-140a][I] Annotation/@type must be unique within its
        enclosing Annotations list (not explicitly documented in the base
        standard's XSD, confirmed by you as an oversight worth enforcing
        anyway). In spirit = FMI2-ARCH-110a (Tool/@name uniqueness), adapted
        to FMI3's restructured flat Annotations/Annotation[@type] shape.
      </assert>
    </rule>
  </pattern>

</schema>
