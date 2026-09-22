<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for SSP 2.0.1 SystemStructureParameterValues (.ssv)
  =====================================================================================================

  Base schema (UNMODIFIED, restriction-only profile):
    SystemStructureParameterValues.xsd + SystemStructureCommon.xsd, from
    https://github.com/modelica/ssp-standard (tag v2.0.1, commit 800e899, 2026-05-05)
    vendored locally at FMISchematron/SSP-schema/2.0.1/

  Conformance identifier: LOTAR-SSV-2.0.1-ARCHIVAL

  Companion to SystemStructureParameterValues.xsd, not a replacement. Validate with the XSD first
  (structural conformance), then this Schematron layer, same two-pass pattern as
  lotar-ssp2.0.1-archival.sch (the .ssd sibling profile).

  Origin (2026-07-21): added per explicit instruction ("Add ssv schematron rules to the plan...
  Not sure if that would even add any Mandatory rules"). That skepticism is honored below: the
  real-corpus evidence for .ssv is thin (only 4 real files gathered so far — see
  ssp-corpus-manifest.md — all from one tool, EasySSP/orchideo, both a 2025 and a 2026 export run of
  the same two underlying parameter sets, so effectively 2 distinct authored files exercised twice).
  Given that thinness, only two [M] mandates are made here (both mirroring an already-established,
  already-corpus-grounded [M] tier on the .ssd side), plus a set of [I] integrity rules that close
  genuine base-XSD expressiveness gaps regardless of adoption — no new [R] tier is used at all in
  this file, to avoid inventing a report-tier mandate on a 4-file sample that could easily be
  measurement noise. Every field considered and NOT promoted is recorded below with its corpus count
  and reasoning, following the same corpus-grounded discipline as ssp2.0.1-rule-inventory.md.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with every other LOTAR
  Schematron profile in this project. Uniqueness/referential checks below use the same
  preceding-sibling / ancestor-scoped existential-comparison idiom as lotar-ssp2.0.1-archival.sch's
  SSP-ARCH-040/041, to avoid current() (unsupported by xmllint's schematron mode; this project
  validates with lxml.isoschematron instead — see reference_schematron_validation_tooling.md).

  Pattern-scoping caution (see lotar-ssp2.0.1-archival.sch's own header/comments for the full
  writeup): ISO Schematron only fires the FIRST <rule> in a <pattern> whose context matches a given
  node. Every context below is either (a) unique to one element name (ssv:String vs. ssv:Enumeration
  vs. ssv:Binary — disjoint, no node can match more than one), or (b) the sole rule for that context
  in its pattern, so this file does not hit that bug — flagged here as a standing check for any
  future addition to this file.

  ## Fields considered and left [O] (no rule) — root ssv:ParameterSet attributes

  ssv:ParameterSet shares ssc:ABaseElement (@id, @description) and ssc:ATopLevelMetaData (@author,
  @fileversion, @copyright, @license, @generationTool, @generationDateAndTime) with
  ssd:SystemStructureDescription's root — the same attribute groups examined in
  ssp2.0.1-rule-inventory.md §1. Corpus counts across the 4 real .ssv files:

    - @id            : 0/4 present  -> left [O]. Unlike the .ssd root (where @id was kept [M] as
                       the one fragment-referenceable document identity despite a 25% real-corpus
                       gap), a 0/4 real-corpus result here is a materially weaker basis for a hard
                       mandate on a 4-file sample from a single tool. Not promoted.
    - @description   : 4/4 present (2 of the 4 as an empty string "" — structurally present,
                       semantically empty) -> left [O], not promoted to [M]. Mirrors the .ssd-side
                       decision to make SRMD, not the SSD/SSV root, the authoritative home for
                       @description (see lotar-srmd-archival.sch SRMD-ARCH-101) — extending that
                       same authority model to .ssv roots is a reasonable analogy but was NOT part
                       of the user's original migration instruction (scoped explicitly to "ssd"),
                       so it is flagged here as an open question rather than silently applied.
    - @author        : 0/4 present -> left [O], consistent with the .ssd-side 0% finding.
    - @fileversion   : 0/4 present -> left [O], same.
    - @copyright     : 0/4 present -> left [O], same.
    - @license       : 0/4 present -> left [O], same.
    - @generationTool: 4/4 present -> promoted [M] below (SSV-ARCH-001). Mirrors the already
                       corpus-grounded SSP-ARCH-003a mandate on the .ssd side; same tool
                       (orchideo/easySSP) populates it without exception in both corpora.
    - @generationDateAndTime: 4/4 present -> promoted [M] below (SSV-ARCH-002). Same reasoning as
                       @generationTool.

  Open question flagged, not resolved: whether the SRMD-authoritative-on-conflict model
  (lotar-srmd-archival.sch / ssp2.0.1-rule-inventory.md §1) should be formally extended to .ssv (and
  .ssm/.ssb) root provenance fields, or whether standalone parameter-value resource files need their
  own, separate provenance story. Left for a future pass.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for SSP 2.0.1 SystemStructureParameterValues (.ssv) instances</title>

  <ns prefix="ssv" uri="http://ssp-standard.org/SSP1/SystemStructureParameterValues"/>
  <ns prefix="ssc" uri="http://ssp-standard.org/SSP1/SystemStructureCommon"/>

  <!-- ============================================================================ -->
  <!-- 1. Root ParameterSet provenance (the only two [M] mandates in this file)     -->
  <!-- ============================================================================ -->
  <pattern id="ssv-root-attributes">

    <rule context="/ssv:ParameterSet">
      <assert test="@generationTool" id="SSV-ARCH-001" role="error">
        [SSV-ARCH-001][M] ParameterSet/@generationTool is required for archival. 4/4 real corpus
        files carry it (mirrors the already corpus-grounded SSP-ARCH-003a mandate on the .ssd
        root). Corpus is thin (single tool, 4 files) — flagged for re-confirmation once more real
        .ssv examples are gathered from other tools.
      </assert>
      <assert test="@generationDateAndTime" id="SSV-ARCH-002" role="error">
        [SSV-ARCH-002][M] ParameterSet/@generationDateAndTime is required for archival. 4/4 real
        corpus files carry it — same reasoning and same thin-corpus caveat as SSV-ARCH-001.
      </assert>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 2. Parameter/@name uniqueness within the ParameterSet                       -->
  <!-- ============================================================================ -->
  <pattern id="ssv-parameter-name-uniqueness">

    <rule context="//ssv:Parameter">
      <assert test="not(@name = preceding-sibling::ssv:Parameter/@name)"
              id="SSV-ARCH-010" role="error">
        [SSV-ARCH-010][I] Parameter/@name must be unique within the enclosing parameter set,
        exactly as TParameter's own documentation states ("must be unique within the parameter
        set") — not XSD-enforceable (xs:string, no key/unique constraint declared). Untested by
        the current 4-file corpus (each file has only 1-2 Parameter entries, no collisions
        observed) but kept because it closes a genuine, doc-stated structural gap, same posture as
        SSP-ARCH-040/041 on the .ssd side.
      </assert>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 3. String/Enumeration/Binary: @value vs. inline Value children              -->
  <!-- ============================================================================ -->
  <!--
    ssv:TParameter's String, Enumeration, and Binary choice-elements each offer BOTH a scalar
    @value attribute AND repeatable inline Value children as alternative ways of stating the same
    parameter value — the schema's own documentation says plainly "If any Value element is
    present, then the value attribute on the parent element MUST NOT be used," but the XSD leaves
    both independently optional (no xs:choice or co-occurrence constraint). This is structurally
    the same "source XOR inline content" expressiveness gap as SSP-ARCH-030/031/032/033/034 on the
    .ssd side, applied here to value-representation instead of source-reference. Each context below
    (ssv:String / ssv:Enumeration / ssv:Binary) is disjoint from the others, so all three rules can
    safely coexist in one pattern without the first-rule-wins gotcha.
  -->
  <pattern id="ssv-value-representation-integrity">

    <rule context="//ssv:String">
      <assert test="not(@value) or not(ssv:Value)" id="SSV-ARCH-020" role="error">
        [SSV-ARCH-020][I] String must not carry both a scalar @value attribute and inline Value
        children simultaneously — per its own documentation ("If any Value element is present,
        then the value attribute...MUST NOT be used"). Untested by the current corpus (no ssv:String
        parameters observed in any of the 4 real .ssv files gathered so far); kept because it
        closes a genuine, doc-stated structural gap regardless of current adoption.
      </assert>
    </rule>

    <rule context="//ssv:Enumeration">
      <assert test="not(@value) or not(ssv:Value)" id="SSV-ARCH-021" role="error">
        [SSV-ARCH-021][I] Enumeration must not carry both a scalar @value attribute and inline
        Value children simultaneously — same documentation-stated constraint as String above. All
        Enumeration parameters observed in the real corpus (4/4 files) already use the @value form
        exclusively, so this rule is corpus-confirmed-compliant, not merely untested.
      </assert>
      <assert test="not(@name) or (@name = ancestor::ssv:ParameterSet/ssv:Enumerations/ssc:Enumeration/@name)"
              id="SSV-ARCH-022" role="error">
        [SSV-ARCH-022][I] Enumeration/@name, when present, is a reference into the enclosing
        ParameterSet's own Enumerations collection ("references into the set of defined
        enumerations of the system structure description") — the base XSD does not enforce this as
        a keyref. @name is documented as optional (omitting it leaves interpretation "solely to the
        variables that are being parameterized"), so this rule only fires when @name is actually
        given, and only checks that it then resolves. Corpus-confirmed: all 4 real files declare
        @name="EVExample.Choices.BatteryTypes" and define a matching
        Enumerations/ssc:Enumeration[@name="EVExample.Choices.BatteryTypes"] in the same file.
      </assert>
    </rule>

    <rule context="//ssv:Binary">
      <assert test="not(@value) or not(ssv:Value)" id="SSV-ARCH-023" role="error">
        [SSV-ARCH-023][I] Binary must not carry both a scalar @value attribute and inline Value
        children simultaneously — same documentation-stated constraint as String/Enumeration
        above. Untested by the current corpus (no ssv:Binary parameters observed in any of the 4
        real .ssv files gathered so far).
      </assert>
    </rule>

  </pattern>

  <!-- ============================================================================ -->
  <!-- 4. Real/Float64/Float32 @unit referential integrity                         -->
  <!-- ============================================================================ -->
  <pattern id="ssv-unit-reference-integrity">

    <rule context="//ssv:Real[@unit] | //ssv:Float64[@unit] | //ssv:Float32[@unit]">
      <assert test="@unit = ancestor::ssv:ParameterSet/ssv:Units/ssc:Unit/@name"
              id="SSV-ARCH-030" role="error">
        [SSV-ARCH-030][I] Real/Float64/Float32's @unit, when present, must reference one of the
        Unit definitions in the enclosing ParameterSet's own Units collection ("must reference one
        of the unit definitions provided in the Units element of the enclosing file") — the base
        XSD types @unit as a plain xs:string with no keyref, so this closes a genuine referential-
        integrity gap. @unit itself is optional (only fires when given). Corpus-confirmed:
        both real files using ssv:Real declare unit="kg" and define a matching
        Units/ssc:Unit[@name="kg"] in the same file.
      </assert>
    </rule>

  </pattern>

</schema>
