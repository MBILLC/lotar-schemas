<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR STMD Archival Overlay — Schematron rule layer for the Credible Simulation Process record
  ================================================================================================

  Conformance identifier: LOTAR-STMD-ARCHIVAL

  Companion to STMD.xsd (vendored, unmodified — see STMD.xsd's own header for source/provenance)
  and to the risk-scaled lotar-stmd-risk-r1..r4.sch profiles (T-09). Applies IN ADDITION TO whichever
  risk profile governs the task (D-4): an archived record must satisfy risk-profile UNION
  archival-overlay. Built per LOTAR_Risk_Profile_Process_Plan_2026-07-24.md §3.3 (T-10, Phase C,
  2026-08-04).

  This file asserts ONLY the STMD-side obligations that are new relative to whatever the risk
  profile already requires. It does not restate the generic Resource fixity/size/URI rules already
  carried by lotar-stc-archival.sch (STC-ARCH-102, STC-ARCH-110/111) or lotar-srmd-archival.sch —
  those already apply to any stc:Resource anywhere, including inside an STMD instance, without
  needing a copy of the rule here. Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0),
  consistent with the other LOTAR archival profiles in this project.

  Three patterns, matching §3.3's table row by row:

  Pattern 1 (STMD-ARCH-01) — repeatability evidence. ExecuteSimulation must carry Input AND
  Procedure AND Output, each populated (not merely present, per Sec 3.2/T-06's rule) — this
  overrides R1/R2's own Input/Procedure optionality for the archival case specifically. A Low-risk
  archived run still needs its procedure and inputs recorded, or it is not repeatable (§3.3's own
  framing, unchanged since 2026-07-24).

  Pattern 2 (STMD-ARCH-02) — environment pinning. ImplementSimulationEnvironment must carry a
  populated Output — overrides R1/R2's optionality for the archival case. Ties to PD15
  (Dependencies), already closed at the LOTAR Core P520 level via integration.*-dependencies/
  environment.* keywords (§3.3's existing note, unchanged).

  Pattern 3 (STMD-ARCH-03) — signed fulfillment record. DecideSimulationObjectiveFulfillment must
  carry a non-empty LifeCycleInformation (at least one of Drafted/Defined/Validated/Approved/
  Archived/Retracted present) — NOT a new Signature rule: lotar-stc-archival.sch's STC-ARCH-100
  already mandates a Signature on every LifeCycleInformation *state that exists*, generically,
  wherever it exists in any STC-typed document. What that existing rule does NOT do is force a
  state to exist in the first place (an entirely empty <stc:LifeCycleInformation/> — confirmed as
  schema-legal in Sec 3.2/T-06's analysis, and confirmed as the actual, universal real-world
  practice in the DC-Motor corpus instance, see stmd-full-corpus-test-report.md, T-14) — that
  presence-forcing is this overlay's job, specifically for the archival-critical Fulfillment step.
  Once this rule forces a state to exist, STC-ARCH-100 automatically takes over and forces that
  state to carry a Signature — no duplicated rule, clean separation of concerns.

  Pattern 4 (STMD-ARCH-04) — risk profile reachable, not duplicated. **OD-19, RESOLVED 2026-08-04.**
  §3.3's original text named the obligation ("risk profile actually used is recorded and immutable")
  but left the mechanism open; this project's first draft of this pattern (Phase C, T-10) proposed
  copying `risk.level` inline onto the STMD instance's own GeneralInformation — shipped as
  `role="warning"` specifically because it was an unconfirmed proposal. **The user's answer: the
  opposite of that proposal.** The risk profile is NOT duplicated onto the STMD instance at all — it
  is reachable ONLY via a reference back to the governing DTMD instance, which is the single source
  of truth for `risk.level` (D-7/D-17/T-04, `DefineResultQuality`). This pattern now asserts three
  things instead: (1) GeneralInformation carries a `ResourceReference` to a `.dtmd` file, (2) that
  reference is a safe relative reference (same textual check as `lotar-stc-archival.sch`'s
  STC-ARCH-110, XPath 1.0, no filesystem access needed at this layer), and (3) GeneralInformation
  does NOT also carry an inline `risk.level` Classification entry — the absence is asserted
  explicitly so a future accidental reintroduction of the old proposal is itself a conformance
  failure, not a silent no-op. All four asserts are `role="error"`, since the mechanism is now
  decided, not proposed.

  The user's own constraint on the reference: "local only, file MUST be reachable from the same
  extra/ folder." Taken literally, a plain relative-to-the-containing-file reference would need a
  leading "../" to escape the STMD's own "extra/org.ssp-standard.ssp-traceability.stmd/" subfolder
  before descending into a sibling "extra/org.ssp-standard.ssp-traceability.dtmd/" subfolder — which
  would then fail the very ".." ban this pattern also wants (STMD-ARCH-04e), a direct contradiction.
  Resolved the same way this project already resolved the identical tension for fmi-ls-ref's
  `Related/@source` (see `lotar_uri_resolve_check.py`'s own docstring and `_fmu_root_via_extra()`):
  the reference is defined to resolve against the shared "extra/" directory itself, not against the
  STMD file's own directory — so the correct form is
  `org.ssp-standard.ssp-traceability.dtmd/DecisionTask.dtmd` (no leading ".." at all), and the ".."
  ban below is therefore never in tension with "reachable from the same extra/ folder" — it is
  exactly what makes that phrase enforceable as a hard "no escaping outside extra/" rule rather than
  a soft convention. Schematron has no filesystem access, so it can only check the reference's own
  syntax (safe-relative, per below); the actual resolution against the shared "extra/" directory —
  confirming both files truly sit under the same one — is performed by the companion script
  `lotar_uri_resolve_check.py` (new `_stmd_dtmd_same_extra_folder()` function, mirroring the existing
  `_fmu_root_via_extra()` convention), not by this file — the same two-layer division of labour this
  project uses everywhere else for URI restrictions (syntax here, resolution/existence/colocation in
  the Python companion).

  **D-20 (2026-08-06) — refines which "extra/" the reference resolves against.** OD-19's "the same
  extra/ folder" above meant the nearest one, i.e. wherever the STMD instance itself sits — correct
  for every topology this project has built or tested (one flat SSP/FMU archive, no nested
  per-component annexes), but never pinned down for an STMD packaged inside a component FMU's own
  nested "extra/" deep in an SSP's "resources/" tree. Per `LOTAR_CDP_Top_Level_Packaging_
  Analysis.md`'s Option B (user's decision), the reference now resolves against the **archive
  root's own top-level "extra/" directory** specifically, regardless of how deeply nested the
  referencing STMD instance is — for a flat archive this is the exact same directory as before (no
  behavior change to any existing fixture or corpus instance); it only differs for the
  nested-component case. If one CDP decision's sub-tasks are archived across more than one separate
  top-level package, the DTMD is duplicated into each consuming archive's own top-level "extra/"
  rather than referenced across archive boundaries (this schema and its companion script only ever
  see one archive at a time and cannot verify cross-archive duplicate consistency — a known,
  accepted gap, not solved here). This pattern's own asserts (syntax only, below) are unaffected by
  this refinement; only `lotar_uri_resolve_check.py`'s resolution base changed (its
  `top_level_extra_folder` base_kind / `_top_level_extra_folder()`, superseding the
  `same_extra_folder` base_kind for this specific reference).
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR STMD Archival Overlay (repeatability, environment pinning, signed fulfillment, risk profile reachable via DTMD reference only)</title>

  <ns prefix="stmd" uri="http://ssp-standard.org/SSPTraceability1/SimulationTaskMetaData"/>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>
  <ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>

  <pattern id="LOTAR-STMD-ARCHIVAL-repeatability">
    <rule context="//stmd:SimulationTaskMetaData//stmd:ExecuteSimulation" id="STMD-ARCH-01">
      <assert test="stc:Input[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]"
              id="STMD-ARCH-01a" role="error">
        Archived tasks must carry a populated Input on ExecuteSimulation regardless of risk level —
        an archived run whose inputs are not recorded is not repeatable.
      </assert>
      <assert test="stc:Procedure[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]"
              id="STMD-ARCH-01b" role="error">
        Archived tasks must carry a populated Procedure on ExecuteSimulation regardless of risk
        level — the run procedure is part of the repeatability evidence.
      </assert>
      <assert test="stc:Output[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]"
              id="STMD-ARCH-01c" role="error">
        Archived tasks must carry a populated Output on ExecuteSimulation — already mandatory at
        every risk level per §3.2 (Output is flat-M), restated here only for completeness of the
        overlay's own conformance ID.
      </assert>
    </rule>
  </pattern>

  <pattern id="LOTAR-STMD-ARCHIVAL-environment">
    <rule context="//stmd:SimulationTaskMetaData//stmd:ImplementSimulationEnvironment" id="STMD-ARCH-02">
      <assert test="stc:Output[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]"
              id="STMD-ARCH-02a" role="error">
        Archived tasks must carry a populated Output on ImplementSimulationEnvironment regardless
        of risk level — tool/version/solver/library/platform pinning is required for the archive to
        be re-executable, overriding R1/R2's own optionality for this step.
      </assert>
    </rule>
  </pattern>

  <pattern id="LOTAR-STMD-ARCHIVAL-fulfillment">
    <rule context="//stmd:SimulationTaskMetaData//stmd:DecideSimulationObjectiveFulfillment" id="STMD-ARCH-03">
      <assert test="stc:LifeCycleInformation[stc:Drafted or stc:Defined or stc:Validated or stc:Approved or stc:Archived or stc:Retracted]"
              id="STMD-ARCH-03a" role="error">
        Archived tasks must carry a non-empty LifeCycleInformation on
        DecideSimulationObjectiveFulfillment (at least one life-cycle state present) — an empty
        &lt;stc:LifeCycleInformation/&gt; is schema-legal but leaves the archived record without
        any recorded life-cycle state at all. Once a state is present, lotar-stc-archival.sch's
        STC-ARCH-100 already mandates that state carry a Signature — not repeated here.
      </assert>
    </rule>
  </pattern>

  <pattern id="LOTAR-STMD-ARCHIVAL-risk-profile-recorded">
    <!-- OD-19, resolved 2026-08-04: risk profile reachable via a DTMD reference only, never
         duplicated inline. See this file's header for the full rationale. -->
    <rule context="//stmd:SimulationTaskMetaData/stmd:GeneralInformation" id="STMD-ARCH-04">
      <assert test="stc:ResourceReference[substring(@xlink:href, string-length(@xlink:href) - 4) = '.dtmd']"
              id="STMD-ARCH-04a" role="error">
        Archived tasks must carry a ResourceReference on GeneralInformation to the governing DTMD
        instance (a ".dtmd" file) — OD-19: the risk profile actually used must be reachable, but is
        never recorded inline on the STMD instance itself.
      </assert>
      <assert test="not(stc:ResourceReference[substring(@xlink:href, string-length(@xlink:href) - 4) = '.dtmd'
                     and starts-with(@xlink:href,'/')])"
              id="STMD-ARCH-04b" role="error">
        The DTMD ResourceReference's @xlink:href must not be an absolute-path or network-path
        reference (same textual check as STC-ARCH-110a).
      </assert>
      <assert test="not(stc:ResourceReference[substring(@xlink:href, string-length(@xlink:href) - 4) = '.dtmd'
                     and contains(@xlink:href,'\')])"
              id="STMD-ARCH-04c" role="error">
        The DTMD ResourceReference's @xlink:href must not contain a backslash (same textual check as
        STC-ARCH-110b).
      </assert>
      <assert test="not(stc:ResourceReference[substring(@xlink:href, string-length(@xlink:href) - 4) = '.dtmd'
                     and contains(substring-before(concat(@xlink:href,'\'),'\'),':')])"
              id="STMD-ARCH-04d" role="error">
        The DTMD ResourceReference's @xlink:href must not carry a URI scheme or drive letter (same
        textual check as STC-ARCH-110c).
      </assert>
      <assert test="not(stc:ResourceReference[substring(@xlink:href, string-length(@xlink:href) - 4) = '.dtmd'
                     and contains(concat('/',@xlink:href,'/'),'/../')])"
              id="STMD-ARCH-04e" role="error">
        The DTMD ResourceReference's @xlink:href must not contain a ".." path segment (same textual
        check as STC-ARCH-110d). This reference resolves against the shared "extra/" directory, not
        the STMD file's own directory (see this file's header) — so a compliant reference never
        needs "..", making this ban directly equivalent to the user's own "reachable from the same
        extra/ folder" constraint. Same-folder colocation itself (i.e. that the reference actually
        resolves to a real .dtmd file under that shared "extra/") is checked by the companion script
        lotar_uri_resolve_check.py, not here — Schematron has no filesystem access.
      </assert>
      <assert test="not(stc:Classification/stc:ClassificationEntry[@keyword='credibility.level' or @keyword='risk.level'])"
              id="STMD-ARCH-04f" role="error">
        GeneralInformation must NOT carry an inline credibility level (credibility.level of the
        credible-process layer, or the retired LOTAR risk.level), in any Classification block. An
        archived task always has a governing DTMD (04a), and that DTMD is the single source of truth
        for the level (OD-19; updated 2026-09-22 for D-24 — the credible-process layer allows
        credibility.level on an STMD only when no DTMD governs it, which cannot happen in a LOTAR archive).
      </assert>
    </rule>
  </pattern>

</schema>
