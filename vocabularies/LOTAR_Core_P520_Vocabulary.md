# LOTAR Core vocabulary for SRMD — Part 2: P520 (Simulation Model Manifest)

## Purpose and scope

MIC Core defines a small, cross-domain core attribute set for classifying simulation
resources in the SRMD (Simulation Resource Meta Data) format used by SSP Traceability.
`P515_P520_vs_MIC_Core_Gap.md` identified the P515/P520 attributes that MIC Core does not
cover. This document is Part 2 of **LOTAR Core**, a complementary SRMD classification
vocabulary that fills that gap — covering the content specific to P520's simulation model
manifest (development/build/target environment, integration process, physics content, model
variables). The administrative/legal metadata P520 shares with P515 (via `GeneralPLMInfo`) is
covered once, separately, in `LOTAR_Core_Common_Vocabulary.md` — see that document first.

A P520 SRMD file would carry up to three `Classification` blocks side by side:
`org.mic-core.mic-core` (MIC Core), `org.lotar-international.lotar-core.common` (shared
administrative/legal), and `org.lotar-international.lotar-core.p520` (this document) — the same
multi-classification pattern MIC Core's own example file demonstrates.

**Out of scope by design:** `Verification_Validation_Scenario_Type.Validated_by`/`Verified_by`,
whose type is `Traceability_Link_Type`, are deliberately **not** given a keyword here. Per
direction, inter-model/inter-artifact linking is being deferred to a future P550 standard. The
rest of `Verification_Validation_Scenario_Type` (`Id`, `Verification_Credibility_Level`,
`Validation_Credibility_Level`, `Model_Summary_Report`) is already covered by MIC Core's
verification/validation attributes (see `MIC_Core_to_LOTAR_Mapping.md`), so it doesn't appear
below either.

**2026-08-06 (D-21):** `Verification_Validation_Scenario_Type` gained a new native element,
`Implements` (also `Traceability_Link_Type`, same treatment as `Validated_by`/`Verified_by` above —
out of scope for an SRMD Classification keyword here). Unlike `Validated_by`/`Verified_by` (which
per direction should point to the P515-governed test-case/reference-result artifacts that verify or
validate the model), `Implements` links this scenario's Model Report to the governing CDP/DTMD
record that commissioned the simulation effort in the first place — see
`P520_Risk_Profile_Normative_Clause.md` for the normative rule. The 2026-07-20 "already covered by
MIC Core" line above predates this and never considered it; `Implements` is new, not something MIC
Core's own verification/validation attributes were ever meant to satisfy.

SIC Core is intentionally not consulted here (per direction) — this vocabulary is scoped as a
complement to MIC Core only. A handful of items below would already be partially covered if SIC
Core were adopted (see `P515_P520_vs_MIC_and_SIC_Core_Gap.md`); they are included anyway so this
vocabulary stands on its own next to MIC Core alone.

**Confirmed 2026-07-20:** SIC Core is disregarded for the mandatory LOTAR Core baseline entirely
for now, not just for this vocabulary's authorship — `SRMDSICCore.xsd` remains in `WaitForLater/`
and this Core part plus MIC Core are treated as sufficient coverage.

**Decision (2026-07-21) — D10 Effectivity, domain-specific:** added `effectivity.applicability`
below, Recommended — closes D10 (Effectivity) for P520, per direction that effectivity be handled
domain-specifically (here and in `LOTAR_Core_P515_Vocabulary.md` separately) rather than in the
shared Common vocabulary. Same rationale as P515 Core's own addition: D10 is SHOULD-level and
conditional, with its exact structure left to the relevant domain part, so this is a single
free-text field tiered Recommended, not Mandatory. Same keyword name as P515 Core's own addition,
but a separate field under this file's own `Classification/@type`.

**2026-09-05 (D-23) — P515 behavioral-model content integrated into P520:** the test-case /
reference-result keyword cluster (`test-case.*`, 15 keywords) formerly defined in
`LOTAR_Core_P515_Vocabulary.md` under `org.lotar-international.lotar-core.p515` now lives in this
document under `org.lotar-international.lotar-core.p520`, see the new "Test case / reference
results cluster" below. Keyword names are unchanged. Source elements are now
`Verification_Validation_Scenario/TestCase/...` in `P520_SCHEMA.xsd`. The
`org.lotar-international.lotar-core.p515` classification type and the separate P515 copy of
`effectivity.applicability` are retired; `LOTAR_Core_P515_Vocabulary.md` is kept in `deprecated/`
for history. `Validated_by`/`Verified_by` are now optional in the schema (a scenario's evidence may
be its inline `TestCase` elements instead; `lotar-p520-archival.sch` P520-ARCH-003 requires one of
the three); they remain out of scope for a keyword here, as do the two FMI-LS-REF-typed file links
inside a test case (`BoundaryConditions/InputFile`, `ReferenceVariables/ReferenceResults`) — their
fixity/role/URI rules are native-XSD + `lotar-p520-archival.sch` P520-ARCH-100/101, not SRMD keywords.

## Classification type

```
type="org.lotar-international.lotar-core.p520"
```

Reverse-domain identifier under the LOTAR International project domain (`lotar-international.org`),
matching the convention MIC Core/SIC Core use under `org.mic-core.*`. Combine with
`org.lotar-international.lotar-core.common` (see `LOTAR_Core_Common_Vocabulary.md`) for the full
P520 administrative + model-manifest vocabulary.

## Obligation levels

Derived directly and traceably from the current P520 schema's own cardinality: **Mandatory**
where the source element is required (`minOccurs` unset or `1`), **Optional** where
`minOccurs="0"`. This keeps the vocabulary auditable against the schema rather than introducing
a new, separately-maintained judgment call.

## Development / build environment cluster

MIC Core covers this whole area with a single generic attribute ("Software and hardware
environment requirements"); every field below is additional granularity beyond that one attribute.

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Dev Tool Name | `environment.dev-tool.name` | Mandatory | `DevTool_Name` | Name of the development tool. |
| Dev Tool Version | `environment.dev-tool.version` | Mandatory | `DevTool_Version` | Version of the development tool. |
| Dev Tool License | `environment.dev-tool.license` | Mandatory | `DevTool_License` | License of the development tool. |
| Dev OS Name | `environment.dev-os.name` | Mandatory | `DevOS_Name` | Name of the development operating system. |
| Dev OS Version | `environment.dev-os.version` | Mandatory | `DevOS_Version` | Version of the development operating system. |
| Dev OS License | `environment.dev-os.license` | Mandatory | `DevOS_License` | License of the development operating system. |
| Dev OS Compiler Name | `environment.dev-os.compiler.name` | Mandatory | `DevOS_Compiler_Name` | Name of the development OS compiler. |
| Dev OS Compiler Version | `environment.dev-os.compiler.version` | Mandatory | `DevOS_Compiler_Version` | Version of the development OS compiler. |
| Dev OS Compiler License | `environment.dev-os.compiler.license` | Optional | `DevOS_Compiler_License` | License of the development OS compiler. |
| Dev Language | `environment.dev-language` | Optional | `Dev_Language` | Programming language used for development. |
| CPU Number | `environment.cpu-number` | Mandatory | `CPU_Number` | Number of CPUs used in the development environment. |
| RAM Size | `environment.ram-size` | Mandatory | `RAM_Size` | RAM size (MB) used in the development environment. |
| Target Tool Name | `environment.target-tool-name` | Optional | `Target_Tool_Name` | Name of the tool used for integration/execution (distinct from the development tool above). |

## Integration process cluster

FMI/SSP-style co-simulation integration technicalities; no MIC Core equivalent at all.

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Coupling Mode | `integration.coupling-mode` | Optional | `Coupling_Mode` | Mode of coupling for the model integration. |
| Communication Mode | `integration.communication-mode` | Optional | `Communication_Mode` | Mode of communication for the model integration. |
| Model Format | `integration.model-format` | Optional | `Model_Format` | Format of the model used in the integration. |
| Real Time | `integration.real-time` | Optional | `Real_Time` | Whether the model operates in real time. |
| Parallelization | `integration.parallelization` | Optional | `Parallelization` | Whether the model supports parallelization. |
| Model Type | `integration.model-type` | Mandatory | `Model_Type` | Type of the model used in the integration. |
| Libraries Dependencies | `integration.libraries-dependencies` | Mandatory (repeatable) | `Libraries_Dependencies` | Library dependencies required for the model integration. |
| OS Functions Dependencies | `integration.os-functions-dependencies` | Optional (repeatable) | `OS_Functions_Dependencies` | OS function dependencies required for the model integration. |
| Solver Dependencies | `integration.solver-dependencies` | Mandatory (repeatable) | `Solver_Dependencies` | Solver dependencies required for the model integration. |
| Link Resources | `integration.link-resources` | Optional (repeatable) | `Link_Resources` | Linked resources required for the model integration (a plain string field in the source schema despite the name — not a `Traceability_Link_Type`, so it is in scope here). |

## Physics content and usage cluster

Physics-modeling detail; neither MIC Core nor SIC Core addresses dimensionality, linearity, or
fidelity. (`Method`, `Physics_Domain`, `Validate_Range` from the same source type *are* already
covered by MIC Core's "Modeling choice," "Model classification," and "Model limitations," so they
don't appear here.)

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Dimension | `physics.dimension` | Optional | `Dimension` | Dimension of the physical model. |
| Time Scale | `physics.time-scale` | Optional | `TimeScale` | Whether the model includes time-scale considerations. |
| Linearity | `physics.linearity` | Optional | `Linearity` | Whether the model is linear. |
| Model Type Usage | `physics.model-type-usage` | Optional | `Model_Type_Usage` | Usage type of the model. |
| Environment | `physics.environment` | Optional | `Environment` | Environment in which the model is used. |
| Fidelity Represented Phenomena | `physics.fidelity.represented-phenomena` | Mandatory | `Fidelity_Represented_Phenomena` | Fidelity of the represented phenomena in the model. |
| Fidelity Neglected Phenomena | `physics.fidelity.neglected-phenomena` | Optional | `Fidelity_Neglected_Phenomena` | Fidelity of the neglected phenomena in the model. |

## Model variables cluster

Variable/signal dictionary; no equivalent in MIC Core (SIC Core's "Entity Parameter" only loosely
covers `Key_Parameters`, not the rest).

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Key Input | `variables.key-inputs` | Mandatory (repeatable) | `Key_Inputs` (`Name`/`Value`/`Description`) | A key input variable of the model. |
| Key Output | `variables.key-outputs` | Mandatory (repeatable) | `Key_Outputs` | A key output variable of the model. |
| Key Parameter | `variables.key-parameters` | Mandatory (repeatable) | `Key_Parameters` | A key parameter variable of the model. |
| Signal Dictionary | `variables.signal-dictionary` | Optional | `Signal_Dictionary` | Signal dictionary of the model. |
| Other Variable | `variables.other-variables` | Optional (repeatable) | `Other_Variables` | Another relevant variable of the model. |

## Test case / reference results cluster

*(Integrated from P515, D-23, 2026-09-05. Obligations derived from the moved types' own cardinalities, unchanged.)*

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Test Case Context Number | `test-case.context.number` | Mandatory | `TestCase/Context.Number` | Sequential identifier of the test case context. |
| Test Case Context Relative Path | `test-case.context.relative-path` | Optional (repeatable) | `TestCase/Context.Relative_path` | Relative file path(s) associated with the test case context. |
| Experiment Algorithm | `test-case.experiment.algorithm` | Mandatory | `TestCase/Scenario/ExperimentDefinition.Algorithm` | Numerical algorithm used (`FMICSAlg`, `Euler-Explicit`, `Euler-Implicit`, `Runge-Kutta-2`). |
| Experiment Communication Points | `test-case.experiment.communication-points` | Mandatory | `TestCase/Scenario/ExperimentDefinition.Ncp` | Number of communication points in the experiment. |
| Experiment Start Time | `test-case.experiment.start-time` | Mandatory | `TestCase/Scenario/ExperimentDefinition.Start_time` | Start time of the experiment. |
| Experiment Stop Time | `test-case.experiment.stop-time` | Mandatory | `TestCase/Scenario/ExperimentDefinition.Stop_time` | Stop time of the experiment. |
| Experiment Tolerance | `test-case.experiment.tolerance` | Mandatory | `TestCase/Scenario/ExperimentDefinition.Tolerance` | Overall solver tolerance for the experiment. |
| Scenario Property Modification | `test-case.scenario.property-modification` | Optional (repeatable) | `TestCase/Scenario/PropertyModifications.Property` | Name/value override applied to a model property for the scenario. |
| Scenario Boundary Constant | `test-case.scenario.boundary-constant` | Optional (repeatable) | `TestCase/Scenario/BoundaryConditions.Constant` | Name/value constant boundary condition for the scenario. |
| Reference Variable | `test-case.reference.variable` | Mandatory (repeatable) | `TestCase/ReferenceVariables.Variable` | Name of a reference variable checked by the test case. |
| Reference Tolerance Absolute X | `test-case.reference.tolerance.absolute-x` | Mandatory | `TestCase/ReferenceVariables/Tolerance.Absolute_tolx` | Absolute tolerance for the x variable. |
| Reference Tolerance Absolute Y | `test-case.reference.tolerance.absolute-y` | Mandatory | `TestCase/ReferenceVariables/Tolerance.Absolute_toly` | Absolute tolerance for the y variable. |
| Reference Tolerance Relative X | `test-case.reference.tolerance.relative-x` | Mandatory | `TestCase/ReferenceVariables/Tolerance.Relative_tolx` | Relative tolerance for the x variable. |
| Reference Tolerance Relative Y | `test-case.reference.tolerance.relative-y` | Mandatory | `TestCase/ReferenceVariables/Tolerance.Relative_toly` | Relative tolerance for the y variable. |
| Reference File Hash | `test-case.reference.file-hash` | Mandatory | `TestCase/ReferenceVariables/ReferenceFileHash` (`@type`, `@value`) | Fixity hash (`sha256`/`sha1`/`md5` + hex digest) of the reference results file. |

Implementation note on `test-case.reference.file-hash`: the source element carries the
algorithm and digest as two *attributes* (`type`, `value`), not as separate keyword/value pairs.
Recommended SRMD encoding: put the digest as the `ClassificationEntry` element content and the
algorithm as a `:`-separated prefix in the value (e.g. `sha256:9f86d0...`), since
`ClassificationEntry` itself has no room for a second attribute of this kind. This is flagged as
an open design question for review rather than settled unilaterally.

Implementation note on `Property`/`Constant` name/value pairs: since a `ClassificationEntry`'s
`keyword` must come from the fixed vocabulary above (not the property's own name), the
recommended encoding is `name=value` as the entry's text content (repeating the
`test-case.scenario.property-modification` / `...boundary-constant` keyword once per pair), e.g.
`<ClassificationEntry keyword="test-case.scenario.boundary-constant">T_ambient=293.15</ClassificationEntry>`.

## Effectivity cluster

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Effectivity Applicability | `effectivity.applicability` | Optional | *(new — closes D10 Effectivity, domain-specific)* | Free-text date range, event, serial number(s), or batch number(s) this model manifest is applicable to, where relevant (D10). |

Implementation note: each source element (`Key_Value_Type`) is itself a name/value/description
triple, not a scalar. Since a `ClassificationEntry`'s `keyword` must come from the fixed
vocabulary above (not the variable's own name), recommended encoding is a compact
`name=value` (optionally `; description`) string as the entry's text content, repeating the
keyword once per variable — e.g.
`<ClassificationEntry keyword="variables.key-inputs">mass_flow_rate=2.4; kg/s at inlet</ClassificationEntry>`.
Producers needing fully structured content can instead use `ClassificationEntry`'s permissive
child-element model (`stc:GElementCommon`'s `ClassificationEntry` is `mixed="true"` with an
`xs:any` content particle), embedding a small `<Name>`/`<Value>`/`<Description>` structure
directly — flagged here as an open design choice rather than settled unilaterally.

## Summary table (quick reference)

| Cluster | Keywords | Mandatory | Optional |
| --- | --- | --- | --- |
| Common (see `LOTAR_Core_Common_Vocabulary.md`) | 25 | 18 | 7 |
| Development / build environment | 13 | 10 | 3 |
| Integration process | 10 | 3 | 7 |
| Physics content and usage | 7 | 1 | 6 |
| Model variables | 5 | 3 | 2 |
| Test case / reference results (from P515, D-23) | 15 | 12 | 3 |
| Effectivity | 1 | 0 | 1 |
| **P520-specific subtotal (this document)** | **51** | **29** | **22** |
| **P520 total** | **76** | **47** | **29** |

*Counts updated 2026-09-05 (D-23): +15 test-case keywords; Common row re-synced to its source's current 25/18/7 (it had read 24/18/6). Common's count previously updated 2026-07-21 (now includes `administrative.disposal-reason`,
`administrative.size-bytes`, and `administrative.submission-agreement-ref` in addition to the
2026-07-20 `administrative.generation-tool`/`administrative.variable-naming-convention` additions
— see `LOTAR_Core_Common_Vocabulary.md` for the full history). This document's own cluster updated
2026-07-21 to add the new Effectivity cluster (`effectivity.applicability`, Optional, D10 closure).*

See `SRMDLOTARCore_P520.xsd` for the corresponding SRMD-conformant XML Schema (extends `SRMD.xsd`
with Schematron rules for classification presence, mandatory-attribute checks, and an allowed-
keyword whitelist), built the same way as `SRMDMICCore.xsd` / `SRMDSICCore.xsd`.
