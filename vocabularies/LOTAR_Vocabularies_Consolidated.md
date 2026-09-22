# LOTAR Vocabularies — Consolidated

*Derived from the .md source files, which are authoritative; regenerate/re-copy this file on
demand rather than hand-editing it out of sync with the sources.*

**2026-07-20 update:** two new mandatory Common keywords (`administrative.generation-tool`,
`administrative.variable-naming-convention`), migrated from the now-deprecated FMI3 *and* FMI2
provenance schematron layers (`@numberOfEventIndicators`, FMI2-only, deliberately excluded);
export-control fields reconfirmed mandatory (no change). FMI 2.x rule-work pause lifted — corpus
now considered sufficient. See §1 for vocabulary details.

**2026-07-20 update (confirmed, later same day):** SIC Core is disregarded for the LOTAR Core
mandatory baseline for now — MIC Core + the three LOTAR Core parts are treated as sufficient
coverage; `SRMDSICCore.xsd` stays in `WaitForLater/`. The two deprecated provenance schematron
files (`lotar-fmi3.0.2-provenance.sch`, `lotar-fmi2.0.5-provenance.sch`) have been physically
moved to `FMISchematron/deprecated/` to match their deprecated status — provenance now lives
entirely in LOTAR Core.

**REVERSED 2026-08-04 (T-24, D-16):** the above SIC Core deferral is over. SIC Core has been
reinstated for the LOTAR Core mandatory baseline; `SRMDSICCore.xsd` has been moved out of
`WaitForLater/` to the project root. See `LOTAR_Risk_Profile_Process_Plan_2026-07-24.md` (D-16,
T-24) for the reinstatement rationale. `sic-core-risk-profile-matrix.csv` (T-25, ~85 rows) and
its generated Schematron (T-30) are not yet built — tracked as open follow-on work, not part of
this reversal itself.

**2026-08-06 update (Dublin Core absorption):** the standalone `SRMDLOTARCore_DublinCore.xsd` /
`LOTAR_Core_DublinCore_Vocabulary.md` pair (Classification type
`org.lotar-international.lotar-core.dublin-core`) is retired. Its 7 keywords (`dc.contributor`,
`dc.coverage`, `dc.language`, `dc.publisher`, `dc.relation`, `dc.source`, `dc.subject`) now live
under §1 Common's own Classification type instead, at the same Recommended tier — see the new
§1a below. The old schema file has moved to `deprecated/`; the old vocabulary doc is marked
superseded but retained for history. No keyword-name collision existed, so this is a pure
consolidation.

**2026-08-04 update (T-16/T-18/T-20, Phase E execution — full resync of §1's table against its
now-authoritative source, `LOTAR_Core_Common_Vocabulary.md`):** §1's table below had drifted out of
sync with its source across several prior updates (missing the `administrative.created-by`
promotion, the `administrative.variable-naming-convention` removal, and the
`administrative.submission-agreement-ref`/`administrative.size-bytes`/`administrative.disposal-
reason`/`risk.level`/`administrative.archiving-required` additions) — all now reconciled below.
Also newly added to the source this pass: `model-validation.mode` (T-16, MTMD external-validation
two-path scheme) and the four-keyword `signature.*` cluster (T-18 recommendation, not yet
confirmed by the working group). §3 (P520) below has NOT been re-verified (§2 P515 was folded into §3.5 on 2026-09-05) against
their own sources in this pass and may carry similar drift — flagged as follow-on work, not
silently assumed current.

**2026-08-14 update (D-22, T-18 resolved — signature.* rows re-synced against source):**
`signature.signer-role` and `signature.date` are removed (XAdES's own `xades:SignedProperties`
now carries those two facts cryptographically bound to the signature, per D-22 — see
`LOTAR_Digital_Signatures.md`); `signature.method` and `signature.validation-note` are kept and
their obligation status moves from "T-18 recommendation, not yet confirmed" to confirmed. Signature
cluster: 4 keywords → 2. Overall Common-vocabulary total: 37/18/19 → 35/18/17 (see
`LOTAR_Core_Common_Vocabulary.md`'s own recalculation note for the full history). §2/§3's
not-yet-reverified status from the note above still stands.

**2026-07-20 update (profile-opportunity closure pass):** one new mandatory-conditional Common
keyword, `administrative.disposal-reason` (Mandatory, conditional on a Retracted STC life-cycle
entry existing), closing the PD12 (Disposal) profile opportunity — enforced via a new conditional
`sch:assert` in `SRMDLOTARCore_Common.xsd`. Also new this pass: `lotar-srmd-archival.sch`
(general SRMD `checksum`/`checksumType` fixity, PD1), `lotar-stc-archival.sch` (universal
Signature on every STC life-cycle entry, PD17; `author`/`fileversion`/`generationDateAndTime`
mandatory on every `DerivationChainEntry`, PD9/PD6), and `LOTAR_Status_Vocabulary_Mapping.md` (D9
status mapping and PD14 QC-outcome interpretation). See §1 for the vocabulary-table update.

**2026-07-20 update (later still, PD4 Size closure):** one new mandatory Common keyword,
`administrative.size-bytes`, closing PD4 (Size) at two tiers — whole-container size on the
governing SRMD instance (`SRMDLOTARCore_Common.xsd`) and per-contained-artifact size on every
`stc:Resource` (new third pattern in `lotar-stc-archival.sch`). A proposed Tier 3 (per-file-inside-
FMU-zip manifest) was confirmed out of scope.

**2026-07-21 update (P6, D2, D10 closure):** one new mandatory Common keyword,
`administrative.submission-agreement-ref` (closes P6, modeled on METS `metsHdr/altRecordID`). One
new dedicated vocabulary file, `SRMDLOTARCore_DublinCore.xsd`
(`org.lotar-international.lotar-core.dublin-core`), with 7 new Recommended `dc.*` keywords
(Contributor, Coverage, Language, Publisher, Relation, Source, Subject) — closes D2 by mapping all
15 Dublin Core Metadata Element Set 1.1 terms (the other 8 reuse existing Mandatory/Recommended
fields, documented in `LOTAR_Core_DublinCore_Vocabulary.md` rather than duplicated). One new
Recommended keyword added separately to each of `SRMDLOTARCore_P515.xsd` (retired 2026-09-05, D-23) and
`SRMDLOTARCore_P520.xsd` — `effectivity.applicability` — closes D10 domain-specifically (not in
Common, per direction). See §1/§2/§3/new §1a for the vocabulary-table updates.

Collects every SRMD controlled-vocabulary document produced for this project into one place,
organized by LOTAR part number. Source-specific vocabulary that isn't tied to a single part (FMI/
SSP/SSP-LS-Traceability terms) gets its own section at the end rather than being force-fit under
Common/P515/P520.

**Included, by original file:**
- `LOTAR_Core_Common_Vocabulary.md` → §1 Common / P500, including §1a Dublin Core mapping (D2
  closure) — absorbed into this source file 2026-08-06 (see that document directly for the full
  15-term table; not reproduced here in full).
- ~~`LOTAR_Core_DublinCore_Vocabulary.md` (2026-07-21)~~ — **superseded 2026-08-06**, folded into
  `LOTAR_Core_Common_Vocabulary.md` above; kept only for history.
- ~~`LOTAR_Core_P515_Vocabulary.md` → §2 P515~~ — **integrated into P520 2026-09-05 (D-23)**; its table is now §3.5, file kept in `deprecated/`
- `LOTAR_Core_P520_Vocabulary.md` → §3 P520
- `FMI_SSP_Recommended_Vocabulary.md` and `SSP_LS_Traceability_Recommended_Vocabulary.md` → §4 FMI /
  SSP / SSP-LS-Traceability. These two source files overlap almost entirely — the former already
  incorporates every term from the latter (it says so in its own intro) — so §4 reproduces the
  single merged table from `FMI_SSP_Recommended_Vocabulary.md` rather than duplicating rows. The
  one place they differ (the `SRMD` entry's exact wording) is noted inline.

**Not included** (see the earlier scope conversation): `FMI_SSP_Controlled_Vocabulary_Extract.md`
(raw native FMI/SSP extraction, superseded by the recommended vocab in §4) and
`Merged_Glossary_v6.md` (general M&S terminology glossary, not a controlled-vocabulary document).

Each of the LOTAR Core parts (Common/P520; P515 integrated into P520, D-23) maps to an SRMD `Classification/@type`
value and, ultimately, to a `Classification` block an SRMD file for that part would carry. See
`SRMDLOTARCore_Common.xsd` / `SRMDLOTARCore_P520.xsd` for the
corresponding machine-checkable Schematron profiles.

---

## 1. Common / P500 (`P500_Series_Common.xsd`, shared by the P5xx domain parts)

**Classification type:** `org.lotar-international.lotar-core.common`

The shared administrative/legal part of LOTAR Core — fills the gap MIC Core leaves against
`GeneralPLMInfoType`, the block of PLM metadata every P515 and P520 manifest carries via
`GeneralPLMInfo`. Obligation levels are derived directly from `GeneralPLMInfoType`'s own XSD
cardinality (Mandatory where required, Optional where `minOccurs="0"`).

**Out of scope by design:** `Traceability_Link_Type` fields (deferred to a future P550 standard).
SIC Core was not consulted for this vocabulary's original authorship (MIC-Core-only complement, per
direction). **Reversed 2026-08-04 (T-24, D-16):** SIC Core has since been reinstated for the LOTAR
Core mandatory baseline — `SRMDSICCore.xsd` has been moved out of `WaitForLater/` to the project
root; see the dated note at the top of this file.

**Decisions (2026-07-20):** export-control fields (`Export_Controls`, `Export_control_marking`,
`Special_markings`) are confirmed mandatory here — they already were, this closes a previously
open question rather than changing anything. Separately, both the FMI 3.0.2 and FMI 2.0.5
provenance layers (`@description`/`@author`/`@copyright`/`@license`/`@generationTool`/
`@generationDateAndTime`/`@variableNamingConvention`, formerly checked directly against
`modelDescription.xml` by `lotar-fmi3.0.2-provenance.sch` and `lotar-fmi2.0.5-provenance.sch`,
both now moved to `FMISchematron/deprecated/`) now live here instead and are no longer validated
against FMU files; `administrative.generation-tool`
and `administrative.variable-naming-convention` below are new keywords added for the two
attributes that had no existing Common equivalent (the other five map to existing keywords
already in this table). FMI2's one extra attribute, `@numberOfEventIndicators`, was deliberately
NOT migrated (not authorship/provenance metadata). See `LOTAR_Core_Common_Vocabulary.md` for the
full mapping table.

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Version | `administrative.version` | Mandatory | `Version_identifier` | Version identifier of the object. |
| Created On | `administrative.created-on` | Mandatory | `Created_on` | Date/time the object was created. |
| Last Modified Date | `administrative.last-modified-date` | Optional | `Last_Modified_Date` | Date/time of the last modification. |
| Created By | `administrative.created-by` | Mandatory (promoted 2026-07-21, provenance unification) | `Created_by` | Name of the creator — the unified provenance layer's `@author`-equivalent field for FMI2, FMI3, and SSP alike. |
| Author Organization | `administrative.author-organization` | Optional | `Author_Organization` | Organization that authored the object. |
| Approver | `administrative.approver` | Optional | `Approver` | Name of the approver. |
| Approval State | `administrative.approval-state` | Optional | `Approval_State` | Approval workflow state. |
| Authorization | `administrative.authorization` | Optional | `Authorization` | Authorization information. |
| Usage | `administrative.usage` | Mandatory (repeatable) | `Usage` | Use(s) of the model. |
| Model Dependency | `administrative.model-dependency` | Mandatory (repeatable) | `Model_Dependency` | URI(s) of dependencies of the model. |
| Model Hierarchy | `administrative.model-hierarchy` | Mandatory | `Model_Hierarchy` | URI describing the model's position in a hierarchy. |
| Abstraction Level | `administrative.abstraction-level` | Mandatory | `Abstraction_Level` | Category/abstraction level of the model. |
| Privacy Rules | `administrative.privacy-rules` | Mandatory | `Privacy_Rules` | URI to the rules protecting access to the model. |
| Specification Type Objectives | `administrative.specification-type-objectives` | Mandatory (repeatable) | `Specification_Type_Objectives` | Objectives of the specification type (placeholder text in the source schema — "FIXME"). |
| Generation Tool | `administrative.generation-tool` | Mandatory | *(new — migrated from FMI3 `@generationTool`)* | Name of the tool that generated the archived model/data. |
| ~~Variable Naming Convention~~ | ~~`administrative.variable-naming-convention`~~ | *Removed 2026-07-21* | *(was: migrated from FMI3 `@variableNamingConvention`)* | Reverted to a native structural rule in `lotar-fmi2.0.5-archival.sch`/`lotar-fmi3.0.2-archival.sch` — not authorship/legal/generation metadata, doesn't belong in provenance. |
| Disposal Reason | `administrative.disposal-reason` | Mandatory, conditional on a Retracted life-cycle entry existing | *(new — closes PD12 Disposal)* | Reason(s) for deletion/retraction, required once the object has a `Retracted` STC life-cycle entry (STC's own authorising-agent half is covered separately by `lotar-stc-archival.sch`'s universal Signature mandate). |
| Size (Bytes) | `administrative.size-bytes` | Mandatory | *(new — closes PD4 Size, Tier 1)* | Size, in bytes, of the whole Digital Object (entire zipped FMU or SSP) this SRMD instance describes. Tier 2 (per-contained-artifact size inside an SSP) is the same keyword, enforced separately on `stc:Resource` in `lotar-stc-archival.sch`. |
| Submission Agreement Reference | `administrative.submission-agreement-ref` | Mandatory | *(new — closes P6 Submission Agreement)* | Identifier or URI referencing the Submission Agreement between Producer and Archive — the SRMD-Classification equivalent of METS `metsHdr/altRecordID`. |
| Copyright | `legal.copyright` | Mandatory | `Copyright` | URI to the intellectual property rights statement. |
| License | `legal.license` | Mandatory | `License` | URI to the license. |
| Export Controls | `legal.export-controls` | Mandatory | `Export_Controls` | URI to export control information. |
| Export Control Marking | `legal.export-control-marking` | Mandatory | `Export_control_marking` | Export marking text. |
| Special Markings | `legal.special-markings` | Mandatory | `Special_markings` | Other marking text. |
| Risk Level | `risk.level` | Optional here / **Mandatory when attached to DTMD `DefinitionPhase/DefineResultQuality/Output`** (T-09a, built 2026-08-04) | *(new — no `GeneralPLMInfoType` analogue; closes D-5/D-7)* | The assigned LOTAR risk profile for a simulation sub-task — closed enum `R1`\|`R2`\|`R3`\|`R4`, mapped 1:1 onto prostep M&S Credibility Levels CL1-4 (D-1). See `LOTAR_Risk_Assessment_Method.md`. |
| Archiving Required | `administrative.archiving-required` | Optional here / **Mandatory when attached to DTMD `FulfillmentPhase/DecideObjectiveFulfillment/Output`** (T-09a, built 2026-08-04) | *(new — no `GeneralPLMInfoType` analogue; closes D-17/OD-17)* | Whether this decision task's evidence should be archived at all — closed enum `yes`\|`no`. |
| Model Validation Mode | `model-validation.mode` | Optional here / **Mandatory when attached to MTMD `GeneralInformation`, IF the external-attestation path is used** (T-16/T-20, 2026-08-04) | *(new — MTMD-specific two-path scheme)* | Closed enum `internal`\|`copied-in`\|`externally-attested`, recording how an externally-sourced (library) model's V&V evidence is represented in the archive. |
| Signature — Method | `signature.method` | Optional (confirmed 2026-08-14, D-22) | *(new — PREMIS-`signatureInformation` analogue)* | The signature mechanism/algorithm used (e.g. `XAdES-B`), recorded in durable plain metadata. |
| Signature — Validation Note | `signature.validation-note` | Optional (confirmed 2026-08-14, D-22) | *(new — PREMIS-`signatureInformation` analogue)* | Free-text note on how/when the signature was last verified. |

Not listed here because they're already covered by MIC Core: `Model_Name`, `Unique_object_id`,
`Unique_baseline_id`, `Model_Objective` (also now doubling as the Common-vocabulary equivalent of
FMI3's `@description`), `Organization`, `Maturity_State`, `Model_Purpose`, `System_Designation`.

**Summary:** 35 keywords (18 Mandatory, 17 Optional) — see
`LOTAR_Core_Common_Vocabulary.md`'s own summary table for the cluster breakdown.

### 1a. Dublin Core mapping (D2)

**Classification type:** `org.lotar-international.lotar-core.common` (absorbed 2026-08-06 — was
previously its own `org.lotar-international.lotar-core.dublin-core` type, now retired).

Closes D2 (Core Attributes — the Dublin Core Metadata Element Set 1.1's 15 terms). 8 of the 15
terms reuse already-existing Mandatory/Recommended fields (Creator, Date, Format, Title, Type,
Rights, Description, Identifier) and are not duplicated as new keywords; the remaining 7 are new,
all Recommended:

| LOTAR Attribute | SRMD Keyword | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Contributor | `dc.contributor` | Recommended (repeatable) | Secondary-contributor role, not always distinguishable from Creator. |
| Coverage | `dc.coverage` | Recommended | Spatial/temporal scope of the resource. |
| Language | `dc.language` | Recommended | Relevant mainly for embedded documentation. |
| Publisher | `dc.publisher` | Recommended | The archiving/distributing entity, distinct from Creator. |
| Relation | `dc.relation` | Recommended (repeatable) | Lightweight, human-readable cross-reference to a related resource. |
| Source | `dc.source` | Recommended (repeatable) | Human-readable citation of a source resource this one derives from. |
| Subject | `dc.subject` | Recommended (repeatable) | Topical keywords for retrieval. |

See `LOTAR_Core_Common_Vocabulary.md`'s own "Dublin Core mapping (D2)" section for the full
15-term table (including the 8 reused terms) and the rationale for reuse over duplication.

---

## 2. P515 — integrated into P520 (2026-09-05, D-23)

The behavioral-model test-case vocabulary formerly listed here under
`org.lotar-international.lotar-core.p515` now appears as **§3.5 Test case / reference results**
under P520's classification type. The `...p515` type is retired; the source document
`LOTAR_Core_P515_Vocabulary.md` is kept in `deprecated/`. What NAS9300-515 formally remains
(text/parameter-based requirement V&V, expanding P510) has no vocabulary in this project and is
out of the 2026 scope (OD-I1, `planning/P515_P520_Integration_Plan.md`).

---

## 3. P520 — Simulation Model Manifest (NAS9300-520)

**Classification type:** `org.lotar-international.lotar-core.p520` (combine with §1 Common for the
full P520 vocabulary)

Covers P520's simulation model manifest content — development/build/target environment,
integration process, physics content, and model variables — beyond §1 Common and MIC Core.

**Out of scope by design:** `Verification_Validation_Scenario_Type.Validated_by`/`Verified_by`
(`Traceability_Link_Type`, deferred to P550). SIC Core not consulted (MIC-Core-only complement,
per direction).

### 3.1 Development / build environment

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

### 3.2 Integration process

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
| Link Resources | `integration.link-resources` | Optional (repeatable) | `Link_Resources` | Linked resources required for the model integration (plain string field despite the name — not a `Traceability_Link_Type`, so in scope here). |

### 3.3 Physics content and usage

Neither MIC Core nor SIC Core addresses dimensionality, linearity, or fidelity.

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Dimension | `physics.dimension` | Optional | `Dimension` | Dimension of the physical model. |
| Time Scale | `physics.time-scale` | Optional | `TimeScale` | Whether the model includes time-scale considerations. |
| Linearity | `physics.linearity` | Optional | `Linearity` | Whether the model is linear. |
| Model Type Usage | `physics.model-type-usage` | Optional | `Model_Type_Usage` | Usage type of the model. |
| Environment | `physics.environment` | Optional | `Environment` | Environment in which the model is used. |
| Fidelity Represented Phenomena | `physics.fidelity.represented-phenomena` | Mandatory | `Fidelity_Represented_Phenomena` | Fidelity of the represented phenomena in the model. |
| Fidelity Neglected Phenomena | `physics.fidelity.neglected-phenomena` | Optional | `Fidelity_Neglected_Phenomena` | Fidelity of the neglected phenomena in the model. |

### 3.4 Model variables

No equivalent in MIC Core (SIC Core's "Entity Parameter" only loosely covers `Key_Parameters`).

| LOTAR Attribute | SRMD Keyword | Obligation | Source Element | Short Explanation |
| --- | --- | --- | --- | --- |
| Key Input | `variables.key-inputs` | Mandatory (repeatable) | `Key_Inputs` (`Name`/`Value`/`Description`) | A key input variable of the model. |
| Key Output | `variables.key-outputs` | Mandatory (repeatable) | `Key_Outputs` | A key output variable of the model. |
| Key Parameter | `variables.key-parameters` | Mandatory (repeatable) | `Key_Parameters` | A key parameter variable of the model. |
| Signal Dictionary | `variables.signal-dictionary` | Optional | `Signal_Dictionary` | Signal dictionary of the model. |
| Other Variable | `variables.other-variables` | Optional (repeatable) | `Other_Variables` | Another relevant variable of the model. |

Open design note carried from the source doc: `Key_Inputs`/`Key_Outputs`/`Key_Parameters`/
`Other_Variables` are name/value/description triples, not scalars — recommended encoding is
`name=value; description` as the entry's text content, repeating the keyword once per variable.

**Summary:** 35 P520-specific keywords across the four clusters (17 Mandatory, 18 Optional) + 21
from Common = **56 total** (32 Mandatory, 24 Optional).

---

### 3.5 Test case / reference results (integrated from P515, D-23)

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

Open design note on `test-case.reference.file-hash`: the source element carries the
algorithm and digest as two *attributes* (`type`, `value`), not as separate keyword/value pairs.
Recommended SRMD encoding: put the digest as the `ClassificationEntry` element content and the
algorithm as a `:`-separated prefix in the value (e.g. `sha256:9f86d0...`), since
`ClassificationEntry` itself has no room for a second attribute of this kind. This is flagged as
an open design question for review rather than settled unilaterally.

Open design note on `Property`/`Constant` name/value pairs: since a `ClassificationEntry`'s
`keyword` must come from the fixed vocabulary above (not the property's own name), the
recommended encoding is `name=value` as the entry's text content (repeating the
`test-case.scenario.property-modification` / `...boundary-constant` keyword once per pair), e.g.
`<ClassificationEntry keyword="test-case.scenario.boundary-constant">T_ambient=293.15</ClassificationEntry>`.

**Summary:** 15 test-case keywords (12 Mandatory, 3 Optional), added to the P520 part 2026-09-05.

---

## 4. FMI 3.0.2 / SSP 2.0.1 / SSP-LS-Traceability — Recommended Reference Vocabulary

Not part-specific — this is the controlled vocabulary LOTAR should reference or adopt from the
Digital Object formats themselves (FMI, SSP, and the SSP-LS-Traceability layered standard), as
opposed to LOTAR-local terms newly minted in §1–§3. Split conceptually into: terms already
normatively fixed by the FMI/SSP schemas (cite, don't re-mint), new LOTAR-local vocabulary needed
for packaging/file-role/signature/addressing concepts these formats don't close, and
SSP-LS-Traceability's DTMD/STMD/SRMD/STC formats and enumerations. Terms judged "likely not needed
for archiving" (status codes, Clock timing, model element types, geometry terms) are excluded, as
are ~40 schema-internal DTMD/STMD phase/step element names and XLink mechanics reused unchanged
from the W3C standard.

**Known duplicate:** `SRMD` is defined independently (slightly different wording) by both SSP
2.0.1 §4.5.4.1 and SSP-LS-Traceability 1.0.0 — both rows are kept below since they're genuinely
separate source definitions, not merged.

**Data-quality note (SSP-LS-Traceability spec, not LOTAR's own text):** two internal
inconsistencies reproduced faithfully rather than silently corrected — (1) §9.3 states DTMD's file
extension is `.stmd` (same as STMD) rather than a DTMD-specific extension; (2) `kind='rationale'`'s
§5.9 definition is a near-verbatim repeat of `kind='method'`. Flag both with the
ssp-standard.org maintainers before treating either as authoritative.

| Term | Definition | Source |
|---|---|---|
| Annotation | A generic, namespaced XML extension element (ssc:Annotation) insertable into any SSP model entity. | SSP 2.0.1 §2.1.1 |
| approx | The start value is an initial guess, refined by an iteration/initialization algorithm. (FMI initial) | FMI 3.0.2, fmi3Variable.xsd |
| binaries/ | FMU directory holding the platform-specific compiled shared libraries (.dll/.so) implementing the C-API. | FMI 3.0.2 §2.5 |
| Binary | An arbitrary-length byte-sequence variable, with an associated mimeType, new in FMI 3.0 (used e.g. for sensor data, images). | FMI 3.0.2, fmi3Variable.xsd |
| Boolean | A two-valued (true/false) variable. | FMI 3.0.2, fmi3Variable.xsd |
| BooleanMappingTransformation | A lookup-table transform remapping Boolean connection/parameter values. | SSP 2.0.1 §4.5.2.2 |
| BuildConfiguration | XML element describing how to compile a source-code FMU (new in FMI 3.0). | FMI 3.0.2 §2.4.10 |
| calculated | The initial value is computed from other variables during initialization; no start value given. (FMI initial) | FMI 3.0.2, fmi3Variable.xsd |
| calculatedParameter (FMI) | A parameter whose value is calculated by the FMU during initialization and afterward remains constant, and which cannot be set by the environment. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| calculatedParameter (SSP) | A connector for a parameter computed by the component during initialization. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| Checksum algorithm = SHA3-256 | The only currently-permitted value of SRMD's `checksumType` attribute (SHA3, 256-bit, per FIPS 202); the spec notes future algorithms may be added later, making this a closed set of one value today. | SSP-LS-Traceability 1.0.0 §8.1 |
| Classification | A `GElementCommon` sub-element attaching a set of namespaced keyword/value pairs (via repeatable `ClassificationEntry` children) to a modeling element, for uses such as searchable keywords, quality/validation levels, or variant tracking; the `type` attribute (recommended in reverse-domain-name notation) names the classification scheme. | SSP-LS-Traceability 1.0.0 §5.2.1 |
| ClassificationEntry | A single keyword/value pair within a Classification; `keyword` (mandatory) names the entry, `type` (optional, default `text/plain`) gives the MIME type of its value/content, and it may carry an `xlink:href` link instead of or alongside inline content. | SSP-LS-Traceability 1.0.0 §5.2.1.1 |
| Clock | A discrete, scalar variable representing a time or event base that activates model partitions/other variables. | FMI 3.0.2, fmi3Variable.xsd |
| Co-Simulation (CS) | FMI interface type in which the FMU carries its own internal solver and advances itself across communication steps (fmi3DoStep). | FMI 3.0.2 §1.2.2 |
| constant | A connector whose value never changes. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| constant (dependency) | The dependency is via a factor known to be constant during the whole simulation. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| constant (variability) | The variable's value never changes during a simulation run. (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| Content addressing | The URI-based mechanism (relative or absolute) by which SSP files reference other files/resources. | SSP 2.0.1 §2.3 |
| continuous | No restriction on when the value changes. (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| Credible Decision Process | The 5-phase decision-making process (Analysis of Decision Task, Definition of Sub-Tasks, Performing Sub-Tasks, Evaluation, Fulfillment) that a Simulation Request originates from and a Simulation Delivery returns to; documented via a DTMD file. | SSP-LS-Traceability 1.0.0 §2.1 |
| Credible Simulation Process | The 7-phase process (Analysis of Simulation Task, Definition of Simulation Requirements, Design Specification, Implementation, Simulation Execution, Evaluation, Fulfillment) that performs a simulation in response to a Simulation Request; documented via an STMD file. | SSP-LS-Traceability 1.0.0 §2.2 |
| Credible Simulation Process Framework | The overall procedural framework linking a Credible Decision Process and a Credible Simulation Process via a Simulation Request and Simulation Delivery, that SSP-LS-Traceability's DTMD/STMD/SRMD files exist to document. | SSP-LS-Traceability 1.0.0 §1.1, §2 |
| dependent | The unknown depends on the referenced variable in an otherwise unspecified way (most general case). (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| DerivationChain | A `GeneralInformationType` sub-element recording the provenance chain of prior file versions a GlueParticle was derived from, via repeatable `DerivationChainEntry` records (each carrying a GUID, author, file version, copyright, license, generating tool, and generation date/time) — the mechanism directly relevant to the LOTAR Provenance requirement (PD9). | SSP-LS-Traceability 1.0.0 §5.1.1 |
| discrete (dependency) | The dependency factor may change only at events. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| discrete (variability) | The value changes only at events (not continuously between them). (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| documentation/ | Optional FMU directory for human-readable documentation. | FMI 3.0.2 §2.5 |
| DTMD (Decision Task Meta Data) | The XML file format documenting a Credible Decision Process, MIME type `application/x-dtmd-decisiontask`; packaged at `extra/org.ssp-standard.ssp-traceability.stmd/DecisionTask.dtmd` inside an SSP archive. | SSP-LS-Traceability 1.0.0 §3.2, Ch. 6, §9.3 |
| Enumeration | A variable restricted to a named, integer-backed set of items defined by an EnumerationType. | FMI 3.0.2, fmi3Variable.xsd |
| EnumerationMappingTransformation | A lookup-table transform remapping Enumeration values by item name. | SSP 2.0.1 §4.5.2.4 |
| exact | The variable's start value is used unmodified as its initial value. (FMI initial) | FMI 3.0.2, fmi3Variable.xsd |
| Extension Namespace | A reverse-domain-name-notation namespace (e.g. org.modelica.ssp.*) used to avoid collisions in Annotations and extra files. | SSP 2.0.1 §2.1.3 |
| Extra Files mechanism | The reserved extra/ ZIP-entry prefix used to bundle additional, arbitrarily-formatted data/metadata into an SSP package. | SSP 2.0.1 §2.1.2 |
| fixed (dependency) | The dependency factor only changes at initialization/(re-)configuration. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| fixed (variability) | The value only changes at initialization or (re-)configuration. (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| flat | Variable names have no hierarchical/structured meaning. (FMI variableNamingConvention) | FMI 3.0.2, fmi3ModelDescription.xsd |
| Float32 / Float64 | IEEE single/double precision floating-point variable ("Real" in FMI 2.0). | FMI 3.0.2, fmi3Variable.xsd |
| FMU (Functional Mock-up Unit) | The ZIP-archive container (.fmu) that packages a model's XML description, binaries/sources, and resources. | FMI 3.0.2 §1.2 |
| GlueParticle | A bundle of process-relevant information and resources for a step of a Credible Decision or Simulation Process; its file-based representation (a conformant DTMD or STMD file — SRMD instances are explicitly excluded from this term) is called a "GlueParticle file". | SSP-LS-Traceability 1.0.0 §3.1 |
| independent | The independent variable of the model (normally time). (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| inout | A connector that is both input and output (only valid on SignalDictionaryReferences; not valid for FMI-backed components). (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| input (FMI) | A variable whose value is provided by the environment / another connected component. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| input (SSP) | A connector receiving a value into the model element. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| instantiationToken | Required unique token in modelDescription.xml (successor of FMI 2.0's guid) used by the importer to check that the correct FMU is being loaded. | FMI 3.0.2, fmi3ModelDescription.xsd |
| Int8 / UInt8 / Int16 / UInt16 / Int32 / UInt32 / Int64 / UInt64 | Signed/unsigned integer variable of the given bit width ("Integer" in FMI 2.0, now split by width/signedness). | FMI 3.0.2, fmi3Variable.xsd |
| IntegerMappingTransformation | A lookup-table transform remapping integer or Enumeration-typed values. | SSP 2.0.1 §4.5.2.3 |
| Layered Standard | A backward-compatible extension to core SSP defined via Annotations, extra files, and/or additional MIME types. | SSP 2.0.1 §2.2 |
| licenses/ | Optional FMU directory holding license text files bundled with the FMU. | FMI 3.0.2 §2.5.1.1.1 |
| Life-cycle status = Approved | The GlueParticle life-cycle state indicating the entity has been approved on the basis of prior review and validation. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Archived | The GlueParticle life-cycle state indicating the entity remains valid for this specific GlueParticle instance but is not to be reused for similar steps/phases in other GlueParticles. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Defined | The GlueParticle life-cycle state indicating the entity is considered complete and may be subject to further review or validation. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Drafted | The GlueParticle life-cycle state indicating a draft, still-in-progress and possibly incomplete entity. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Retracted | The GlueParticle life-cycle state indicating the entity has been withdrawn, considered invalid or in need of revision. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Validated | The GlueParticle life-cycle state indicating the entity has been reviewed and validated. | SSP-LS-Traceability 1.0.0 §5.4 |
| LinearTransformation | A target = factor × source + offset transform applied to a connection or parameter mapping value (Real/Float types only). | SSP 2.0.1 §4.5.2.1 |
| local (FMI) | A variable internal to the FMU, not intended for connection; default causality. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| local (SSP) | A connector for a model-internal variable, not intended for connection; behaves as output if connected anyway. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| MAP SSP layered standard | A layered standard defined/adopted and published by the Modelica Association Project SSP itself. | SSP 2.0.1 §2.2 |
| MetaData | A generic element attaching arbitrary typed metadata (inline or by reference) to any SSP model element. | SSP 2.0.1 §4.5.4.1 |
| MIME-type based format dispatch | The mechanism by which every SSP reference to external/potentially-external data carries a MIME type identifying its format. | SSP 2.0.1 §2.1.4 |
| Model Exchange (ME) | FMI interface type in which the FMU exposes its state derivatives/outputs and the importer supplies its own numerical solver. | FMI 3.0.2 §1.2.1 |
| modelDescription.xml | The required root XML file of an FMU, conforming to fmi3ModelDescription.xsd, describing all variables, capabilities, and structure. | FMI 3.0.2 §2.4 |
| output (FMI) | A variable computed by the FMU and provided to the environment / another connected component. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| output (SSP) | A connector providing a value out of the model element. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| parameter | A connector for a settable, fixed-during-run parameter. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| parameter (SSP) | A variable set by the environment before or during initialization; its value is not changed afterward except during (re-)configuration. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| Parameter Mapping (SSM, `.ssm`) | An XML file mapping/transforming parameter values from one naming/value scheme to another. | SSP 2.0.1 (referenced in §3, ADR-LOTAR-SSP) |
| Parameter Values (SSV, `.ssv`) | An XML file recording a self-contained, typed set of parameter values for a system or component. | SSP 2.0.1 (referenced in §3, ADR-LOTAR-SSP) |
| Resource kind = configuration | Resource is a detailed description of the simulation environment setup configuration. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = delivery | Resource contains information for the "client" about task execution and results (the Simulation/Decision Delivery). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = document | The generic/default resource kind used when no more specific `kind` value applies. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = executable | Resource is an executable file (e.g. a script, or an Office file with an executable macro). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = method | Resource describes how a process step is, or should be, performed. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = model | Resource contains a simulation model (parameterized or unparameterized; the kind does not distinguish between the two). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = parameter | Resource contains parameters or a parameter set for a simulation model. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = rationale | Resource describes why a related process step was performed the way it was, especially covering deviations, assumptions, or simplifications. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = report | Resource provides requested results in human-readable, aggregated/condensed report form. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = request | Resource contains information provided by the requesting party to perform the task. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = requirement | Resource contains a requirements document or a consistent set of requirements. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = result | Resource contains information directly answering the requester's questions or goals (use `report` instead if it is an aggregated/condensed presentation of such information). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = specification | Resource contains a specifications document or a consistent set of specifications. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = system | Resource is, or references, the "system under test" as described in a PDM/IT system or elsewhere. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = testcase | Resource describes how simulation objectives are operationally achieved via one or more test cases; a set of these can represent a technical breakdown of the simulation objectives. | SSP-LS-Traceability 1.0.0 §5.9 |
| resources/ | FMU directory for auxiliary data used by the model at run time (e.g. tables, maps). | FMI 3.0.2 §2.5 |
| ResourceType `scope` attribute | Optional attribute on a Resource indicating its global/system/subsystem/component scope level, used only where meaningful. | SSP-LS-Traceability 1.0.0 §5.9 |
| Responsible | The party (organization, role, and/or name) accountable for a given life-cycle entry — mandatory on every life-cycle state assignment. | SSP-LS-Traceability 1.0.0 §5.10 |
| Scheduled Execution (SE) | FMI interface type for real-time/embedded use in which the importer activates individual model partitions via a scheduler rather than a single doStep. | FMI 3.0.2 §1.2.3 |
| Signal Dictionary (SSB, `.ssb`) | An XML file defining a reusable, named collection of signals/connectors referenceable via SignalDictionaryReference. | SSP 2.0.1 (referenced in §3) |
| Signature (role = authenticity) | A digital signature asserting only the authenticity/origin of the referenced data or metadata. | SSP 2.0.1 §4.5.5.1 |
| Signature (role = suitability) | A digital signature additionally claiming the referenced data's suitability for a stated purpose (detailed suitability claims expected in the signature's own format). | SSP 2.0.1 §4.5.5.1 |
| sources/ | Optional FMU directory holding C source code and a BuildConfiguration for source-distributed FMUs. | FMI 3.0.2 §2.5 |
| SRMD - Simulation Resource Meta Data (SSP-LS-Traceability) | The XML file format carrying Classification/Annotation metadata (and, optionally, a checksum) about a single external data item (`data` attribute = URI of that item); MIME type `application/x-srmd-meta-data`, file extension `.srmd`. | SSP-LS-Traceability 1.0.0 §3.4, Ch. 8 |
| SRMD (SSP) | The metadata schema defined by the SSP Traceability layered standard, referenced via a MetaData element with type application/x-srmd-meta-data. | SSP 2.0.1 §4.5.4.1 |
| SRMD packaging path | The two reserved SSP "extra files" locations for SRMD instances: `extra/org.ssp-standard.ssp-traceability.srmd/resourceMetaData.srmd` (embedded in an FMU or in an SSP), or, when placed beside the resource it describes, a file named like that resource with a `.srmd` extension. | SSP-LS-Traceability 1.0.0 §9.5.2–§9.5.4 |
| STC (Simulation Traceability Common) | The shared XML Schema (`stc.xsd`) defining the common element/attribute vocabulary (Classification, LifeCycleInformation, Resource, Step, Link, etc.) used by DTMD and STMD; never instantiated as a standalone file itself. | SSP-LS-Traceability 1.0.0 §3.5, Ch. 5 |
| STMD (Simulation Task Meta Data) | The XML file format documenting a Credible Simulation Process, MIME type `application/x-stmd-simulationtask`, file extension `.stmd`; packaged at `extra/org.ssp-standard.ssp-traceability.stmd/SimulationTask.stmd` inside an SSP archive. | SSP-LS-Traceability 1.0.0 §3.3, Ch. 7, §9.4 |
| String | A variable-length text variable. | FMI 3.0.2, fmi3Variable.xsd |
| structuralParameter (FMI) | A parameter that can additionally be set during (re-)configuration mode and may change the structure (e.g. array sizes) of the FMU. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| structuralParameter (SSP) | A connector for a parameter that can be set during (re-)configuration mode. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| structured | Variable names follow the FMI structured-naming convention (dot-separated hierarchy, array indices, derivative notation, etc.). (FMI variableNamingConvention) | FMI 3.0.2, fmi3ModelDescription.xsd |
| System Structure Description (SSD, `.ssd`) | The XML file describing a system's hierarchy, connectors, and connections; SystemStructure.ssd is the mandatory default variant at package root. | SSP 2.0.1 §5 |
| System Structure Package (SSP, `.ssp`) | The ZIP-archive container bundling one or more SSDs together with referenced FMUs and parameter files. | SSP 2.0.1 §3 |
| terminalsAndIcons/ | Optional FMU directory holding terminalsAndIcons.xml (grouped-port/terminal and icon metadata). | FMI 3.0.2 §2.4.9/§2.5.1.2 |
| Third-party layered standard | A layered standard defined outside MAP SSP, with no MAP SSP representation as to suitability or content. | SSP 2.0.1 §2.2 |
| tunable (dependency) | The dependency factor may change at communication points. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| tunable (variability) | The value may change at communication points during a simulation run (e.g. via fmi3Set{Type}). (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| unspecified | A connector whose data-flow direction is not fixed by SSP and is resolved by the underlying modeling language (used for acausal/Modelica connections); acts as a wildcard in connection validity rules. (SSP connector kind) | SSP 2.0.1 §5.2.1 / §5.3.2.1 |
| Version Mixing | The explicit SSP allowance for a single package to contain XML files and referenced FMUs conforming to different SSP/FMI versions. | SSP 2.0.1 §2.2.1 |

---

## Index

| Section | LOTAR part / standard number | Classification type | Keyword count | Source file(s) |
| --- | --- | --- | --- | --- |
| §1 (+ §1a) | Common / P500 (`P500_Series_Common.xsd`), incl. Dublin Core (D2) | `org.lotar-international.lotar-core.common` | 37 | `LOTAR_Core_Common_Vocabulary.md` (Dublin Core absorbed 2026-08-06, was `LOTAR_Core_DublinCore_Vocabulary.md`) |
| §2 | P515 (NAS9300-515) — integrated into P520, D-23 | *(retired: `org.lotar-international.lotar-core.p515`)* | 0 (see §3.5) | `deprecated/LOTAR_Core_P515_Vocabulary.md` |
| §3 (+ §3.5) | P520 (NAS9300-520), incl. test cases from P515 (D-23) | `org.lotar-international.lotar-core.p520` | 50 (71 incl. Common) | `LOTAR_Core_P520_Vocabulary.md` |
| §4 | Not part-specific — FMI 3.0.2 / SSP 2.0.1 / SSP-LS-Traceability | n/a (external formats, referenced not minted) | ~110 | `FMI_SSP_Recommended_Vocabulary.md` (incorporates `SSP_LS_Traceability_Recommended_Vocabulary.md`) |
