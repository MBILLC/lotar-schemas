# LOTAR Core vocabulary for SRMD — Common (shared by the P5xx domain parts; currently P520)

> **2026-09-05 (D-24):** the four process keywords (`risk.level`, `model-validation.mode`,
> `signature.method`, `signature.validation-note`) left this vocabulary for the industry-neutral
> credible-process layer (`org.credible-process.core`, `credible-process-schemas/vocabulary/`). LOTAR
> now cites the layer's `credibility.level` (CL1–CL4) instead of its own `risk.level` (R1–R4). Rows
> below are struck through, not deleted, per this project's history convention. Count: 21 keywords /
> 17 Mandatory / 4 Optional.

## Purpose and scope

This is the shared administrative/legal part of the **LOTAR Core** vocabulary, a complementary
SRMD classification vocabulary that fills the gap MIC Core leaves against `GeneralPLMInfoType` in
`P500_Series_Common.xsd` — the block of PLM metadata every P5xx domain-part manifest (currently P520; P515's behavioral-model content was integrated into P520 2026-09-05, D-23) carries via
`GeneralPLMInfo`. It mirrors, at the vocabulary level, the same split already made at the XSD
level: `P500_Series_Common.xsd` is the schema shared by both parts, and this document is its SRMD
classification counterpart, referenced by `LOTAR_Core_P520_Vocabulary.md` (and, historically, `LOTAR_Core_P515_Vocabulary.md`, now in `deprecated/`) and
`LOTAR_Core_P520_Vocabulary.md` rather than duplicated in each.

An SRMD file for a P520 archive would carry up to three `Classification` blocks side by
side: `org.mic-core.mic-core` (MIC Core), `org.lotar-international.lotar-core.common` (this
document), and `org.lotar-international.lotar-core.p520` (the part-specific one; the former `...p515` type is retired, D-23) —
the same multi-classification pattern MIC Core's own example file demonstrates.

**Out of scope by design:** `Traceability_Link_Type` and everything built from it are excluded
here, since inter-model/inter-artifact linking is being deferred to a future P550 standard.
Every other `GeneralPLMInfoType` field not already covered by MIC Core is included below (see
`P515_P520_vs_MIC_Core_Gap.md` for how each item was identified as a gap). SIC Core is not
consulted here per direction — this vocabulary complements MIC Core only (it is itself still
preliminary at this time, not a finished baseline to build against).

**Decision (2026-07-20, confirmed) — SIC Core disregarded:** SIC Core is disregarded for the
LOTAR Core mandatory baseline for now; the administrative/legal ground it would add is treated
as already sufficiently covered by MIC Core + this Common vocabulary (plus the P515/P520 parts).
`SRMDSICCore.xsd` stays in `WaitForLater/` and is excluded from every "mandatory schema" list
this project produces (e.g. `FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md`) until this is
revisited.

**Decision (2026-07-20) — Export control / ITAR:** confirmed that export-control fields live
mandatory in this Common vocabulary rather than as a LOTAR annotation or solely in the wrapping
Digital Information. They already were: `Export_Controls`, `Export_control_marking`, and
`Special_markings` (below) are all `[M]` here and enforced as mandatory asserts in
`SRMDLOTARCore_Common.xsd` — this decision closes that previously-open question rather than
changing anything structurally.

**Decision (2026-07-20) — FMI provenance migration (both FMI 3.0.2 and FMI 2.0.5):** the FMI root
provenance attributes (`@description`, `@author`, `@copyright`, `@license`, `@generationTool`,
`@generationDateAndTime`, `@variableNamingConvention` — previously enforced directly on
`modelDescription.xml` by `lotar-fmi3.0.2-provenance.sch` and `lotar-fmi2.0.5-provenance.sch`) now
live here instead and are **no longer checked against FMU files**. Both `.sch` files are
deprecated for that purpose (see their own headers) and have been moved to
`FMISchematron/deprecated/` (confirmed 2026-07-20, later same day) since provenance now lives
entirely in LOTAR Core. Mapping (identical for both FMI versions —
FMI2's provenance layer has these same 7 attributes plus one FMI2-only exception, below):

| FMI provenance attribute | Common vocabulary equivalent | Notes |
| --- | --- | --- |
| `@description` | MIC Core `Model_Objective` (keyword `purpose-objectives.model`) | Already covered — no new keyword needed. Promoted to Mandatory 2026-07-21, see below. |
| `@author` | `administrative.created-by` | Already covered. Promoted to Mandatory 2026-07-21, see below. |
| `@copyright` | `legal.copyright` | Already covered. |
| `@license` | `legal.license` | Already covered. |
| `@generationDateAndTime` | `administrative.created-on` | Already covered (treated as equivalent — both anchor the artifact in time). |
| `@generationTool` | `administrative.generation-tool` (**new**) | Gap — no existing Common keyword named the generating tool itself. |
| ~~`@variableNamingConvention`~~ | ~~`administrative.variable-naming-convention`~~ | **Reverted 2026-07-21 — see below.** |

**FMI2-only exception — `@numberOfEventIndicators` (FMI2-ARCH-010h) is NOT migrated here.** FMI2's
provenance layer has an 8th attribute with no FMI3 analog (FMI3 removed it in favor of
`ModelStructure/EventIndicator`, already tiered Optional/no-rule per an earlier resolved
decision). It's a structural count, not authorship/IP/generation metadata, so it doesn't belong
in this administrative/legal vocabulary — if it still needs checking, that's an
`lotar-fmi2.0.5-archival.sch` integrity rule, not a Common-vocabulary keyword. Not added
unilaterally; flag if you want it revisited.

**Decision (2026-07-21) — provenance unification, three follow-on changes.** Per explicit
direction that (a) `@variableNamingConvention` and `@numberOfEventIndicators` don't belong in
"provenance" for either FMI version, (b) FMI's native `@version` should migrate to the single
provenance source, and (c) basic description should become mandatory in the provenance
Schematron:

1. **`administrative.variable-naming-convention` removed entirely from this vocabulary.**
   The 2026-07-20 migration above swept all 7 FMI3 root attributes into this Common vocabulary as
   a block, including `@variableNamingConvention`, without weighing it individually against the
   others. On reflection it is a technical/structural-completeness flag (how `ModelVariables` are
   named), not authorship/legal/generation metadata, so it does not belong in an administrative
   provenance vocabulary regardless of FMI version. Reverted: `lotar-fmi2.0.5-archival.sch`
   (`FMI2-ARCH-010j`, `[R]`, 50/173 = 29% of corpus missing it) and
   `lotar-fmi3.0.2-archival.sch` (`FMI3-ARCH-010j`, `[R]`, 13/89 = 15% of corpus missing it) now
   check it natively again, as a structural rule, not a provenance one.
   `@numberOfEventIndicators` was never migrated here in the first place (see the FMI2-only
   exception above) and stays exactly where it already was: restored alongside
   `@variableNamingConvention` as `FMI2-ARCH-010k` (`[R]`, 34/173 = 20% missing), native to
   `lotar-fmi2.0.5-archival.sch`, no FMI3 analog.
2. **FMI's native `@version` migrated here.** `@version` is FMU content-versioning — the same
   concept as SSP's `SystemStructureDescription/@fileversion`, which already mapped onto
   `administrative.version` (Mandatory, unchanged in this table). `FMI2-ARCH-010i`/`FMI3-ARCH-010i`
   (the former native `@version` rules) are retired with no replacement in their own files;
   `administrative.version` is now `@version`'s sole authoritative home too, for FMI2, FMI3, and
   SSP alike. No new keyword needed — this closes the one asymmetry the unification effort set out
   to fix (`FMI_vs_SSP_LOTAR_Rule_Comparison.md` §1 previously flagged `@version`/`@fileversion` as
   the last unaligned pair).
3. **Basic description and creator promoted to Mandatory**, closing the "two mechanisms, two
   tiers" gap `FMI_vs_SSP_LOTAR_Rule_Comparison.md` flagged: `purpose-objectives.model` (MIC Core's
   own keyword, Recommended-only in the base MIC Core schema) is promoted to Mandatory via a new
   LOTAR-authored override pattern in `SRMDLOTARCore_Common.xsd` (MIC Core itself is vendored and
   not directly edited); `administrative.created-by` (row below) moves from Optional to Mandatory
   in this table directly, since it is native to this vocabulary. Net effect: `@description` and
   `@author`-equivalent information are now Mandatory through exactly one mechanism — the
   Classification-keyword layer — for FMI2, FMI3, and SSP alike, replacing the short-lived
   `SRMD-ARCH-101`/`102` native-attribute rules in `lotar-srmd-archival.sch` (added and retired the
   same day, 2026-07-21) that would otherwise have created a second, independently-checked copy of
   the same two facts.

Net result of all three changes: provenance for FMI2, FMI3, and SSP now runs through exactly one
mechanism (this Common vocabulary + MIC Core, both consulted via the shared Classification layer),
with no format-native provenance attribute independently enforced anywhere else. This matches the
observation that real-world tools typically don't populate FMI's/SSP's native provenance
attributes reliably — a single checked source is more defensible than several loosely-synchronized
ones.

**Decision (2026-07-20) — PD12 disposal reason:** added `administrative.disposal-reason` below,
Mandatory but conditional — required whenever a `Retracted` life-cycle entry exists anywhere in
the SRMD instance (mirrors the P515-ARCH pattern of conditional "required if X exists" asserts
already used in `FMISchematron/lotar-p515-archival.sch`). Closes the PD12 (Disposal) profile
opportunity flagged in `FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md` §4 — PD12's own text
requires "the name of the authorising agent and reasons for deletion" once a disposal/retraction
event exists; the authorising-agent half is now covered by `lotar-stc-archival.sch`'s universal
Signature mandate on the `Retracted` entry itself (item 2), and this keyword covers the reasons-
for-deletion half. Enforced as a conditional `sch:assert` in `SRMDLOTARCore_Common.xsd` (context:
the Common `Classification` element; test checks for a `stc:Retracted` life-cycle entry anywhere
in the instance).

**Decision (2026-07-20) — PD4 Size, Tier 1 of 2:** added `administrative.size-bytes` below,
unconditionally Mandatory — recording the size in bytes of the whole Digital Object the SRMD
instance describes (the entire zipped FMU or entire zipped SSP, whichever container this SRMD is
embedded in or sidecar to). This is the archive-level tier of a three-tier PD4 (Size) proposal
confirmed the same day: Tier 1 (here) covers the whole-container size; Tier 2 covers each
contained artifact's size inside an SSP, enforced separately on `stc:Resource` in
`lotar-stc-archival.sch` using the same keyword name for consistency; Tier 3 (a per-file manifest
inside an FMU's own zip) was proposed but confirmed out of scope — judged redundant/overkill given
Tiers 1+2 already satisfy PD4's per-Digital-Object requirement. The keyword name deliberately
echoes `P515_SCHEMA.xsd`'s pre-existing `@sizeBytes` attribute (`FMISchematron/lotar-p515-archival.sch`,
P515-ARCH-100c/101a) even though it is a `ClassificationEntry` keyword rather than a native XSD
attribute — `SRMD.xsd`'s root has no size/length attribute and no `xs:anyAttribute` wildcard to
extend via Schematron, the same constraint already noted above for `administrative.disposal-reason`
and `administrative.generation-tool`.

**Decision (2026-07-21) — P6 Submission Agreement reference:** added
`administrative.submission-agreement-ref` below, unconditionally Mandatory — closes P6
(Submission Agreement), whose text requires SIPs to "contain information that reference the
Submission Agreement between Producer and Archive," citing METS `metsHdr/altRecordID` as the
example mechanism. This keyword is the SRMD-Classification equivalent of `altRecordID`: see METS's
own definition of that element for the pattern it mirrors —
[mets_xsd_Complex_Type_metsType.html#metsType_metsHdr_altRecordID](https://mets.github.io/METS_Docs/mets_xsd_Complex_Type_metsType.html#:~:text=The%20alternative%20record%20identifier%20element,in%20the%20root%20%3Cmets%3E%20element)
("The alternative record identifier element `<altRecordID>` allows one to use alternative record
identifier values for the digital object represented by the METS document; the primary record
identifier is stored in the OBJID attribute in the root `<mets>` element.") Unlike
`administrative.disposal-reason`, this keyword is unconditionally Mandatory, since P6's own text
is an unconditional SHALL — every SIP is assumed to be covered by some Submission Agreement with
the Archive, per OAIS's own foundational producer-archive relationship.

**Decision (2026-08-04) — risk-profile and archiving-decision keywords (T-04, executing
`LOTAR_Risk_Profile_Process_Plan_2026-07-24.md`):** added `risk.level` and
`administrative.archiving-required` below. Both are new LOTAR-native keywords with no
`GeneralPLMInfoType` analogue — they close **D-5/D-7** (the risk assessment needs a
closed-vocabulary field DTMD itself doesn't have) and **D-17/OD-17** (the archiving decision needs
a home) respectively. **Unlike every other keyword in this cluster, their primary, Mandatory
attachment point is not a generic SRMD root's `Classification` block — it is a specific `Output`
particle inside a `DTMD.xsd` instance** (`DefinitionPhase/DefineResultQuality/Output` for
`risk.level`; `FulfillmentPhase/DecideObjectiveFulfillment/Output` for
`administrative.archiving-required` — see `LOTAR_Risk_Assessment_Method.md` §4 for the full
placement rationale). Both keywords are added to this Common vocabulary's whitelist so they are
recognized wherever the `org.lotar-international.lotar-core.common` Classification type appears
(including, optionally, mirrored onto an SRMD sidecar for cross-reference convenience), but their
obligation is listed as **Optional at the generic-SRMD level** below — the real Mandatory
enforcement is DTMD-context-specific and belongs to **`lotar-dtmd-archival.sch`** (task T-09a —
**built 2026-08-04**, corpus-validated; see `LOTAR_Risk_Profile_Process_Plan_2026-07-24.md` §5).
This mirrors the existing conditional pattern already used for `administrative.disposal-reason`,
just with the condition being "attached inside a DTMD instance" rather than "a `Retracted`
life-cycle entry exists."

**Decision (2026-08-04, continued) — `model-validation.mode` (T-16/T-20, Phase E, resolving the
user's two-path MTMD-validation question):** added `model-validation.mode` below, a closed-enum
(`internal`\|`copied-in`\|`externally-attested`) keyword attached to an **MTMD instance's**
`GeneralInformation` Classification block. It records which of the two accepted paths a given
modeling task's V&V evidence took when the model itself is sourced from an external library (the
common case) rather than authored fresh inside the archive: `copied-in` means the library's V&V
artifacts were automation-copied into the archive and are expected to be genuinely present at the
relevant QA steps' `Output`/`Rationale`; `externally-attested` means those artifacts are NOT copied
in, and instead the QA steps' particles are satisfied by an `Approved`/`Validated`
`LifeCycleInformation`/`Signature` (role `Simulation Engineer`) attesting the external evidence
exists and was reviewed; `internal` (the default/no-attestation case) means ordinary in-archive
population applies with no alternate path. The attestation alternative applies **only** to the five
QA/verification steps (`VerifyAnalysis`, `VerifyRequirements`, `VerifyDesignSpecification`,
`AssureSimulationSetupQuality`, `DeriveSimulationSetupQualityVerdict`) — enforced in
`generate_process_profile_schematron.py`'s MTMD emission path, not the Requirements/Design/
Implementation content, which is never eligible for attestation. **Implementation/documentation
note (user's instruction):** the Requirements/Design/Implementation portions of an MTMD record MAY
instead be copied from a library-specific, external MTMD template when the model comes from a
library — this is a convenience/consistency note only, with no Schematron effect, since
verification is usage-specific but the rest of an MTMD record commonly is not. See
`P520_Risk_Profile_Normative_Clause.md` §4.4 and the plan document's MTMD subsection for the full
write-up.

**Decision (2026-08-04, continued) — `signature.*` cluster (T-18 recommendation, Phase E, not yet
confirmed by the working group):** added four new keywords below —
`signature.signer-role`, `signature.method`, `signature.date`, `signature.validation-note` — as a
PREMIS-`signatureInformation`-equivalent Classification cluster, recommended as a companion to (not
a replacement for) `stc:Signature`'s own XML-DSig payload. Rationale: `ssc:SignatureType`'s own
schema documentation states "it is left unspecified what types of signatures are used and/or
available for now"; a cryptographic signature verifiable today may not remain verifiable across
LOTAR's multi-decade archival horizon (algorithm deprecation, certificate expiry, missing
verification chains), so this cluster records the signature's provenance in plain, durable metadata
independent of whether the crypto payload itself can still be checked. This is a recommendation
pending working-group confirmation, not a closed decision — flagged as such in
`LOTAR_Risk_Profile_Process_Plan_2026-07-24.md` §6 (T-18) and
`FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md` (PD18).

**Decision (2026-08-06) — Dublin Core absorbed into Common:** the standalone
`LOTAR_Core_DublinCore_Vocabulary.md` / `SRMDLOTARCore_DublinCore.xsd` pair (its own Classification
type, `org.lotar-international.lotar-core.dublin-core`, closing D2) is retired. The 7 keywords it
defined — `dc.contributor`, `dc.coverage`, `dc.language`, `dc.publisher`, `dc.relation`,
`dc.source`, `dc.subject` — now live under **this** document's Classification type
(`org.lotar-international.lotar-core.common`) instead, at the same Recommended tier, with the same
repeatability rule (`dc.contributor`/`dc.relation`/`dc.source`/`dc.subject` remain repeatable). No
keyword-name collision existed with any pre-existing Common keyword. The relationship to Dublin
Core Metadata Element Set 1.1 is kept as **documentation only** from here on — see
"Dublin Core mapping (D2)" below for the full 15-term table; it is no longer a second
Classification type in the schema itself. Rationale: the Dublin Core mapping was never
architecturally independent (8 of its 15 terms already reused Common/MIC-Core fields; the other 7
always co-resided in the same SRMD document as this vocabulary's own Classification block), so a
second type/file bought no isolation benefit and cost a second schema, a second `.sch` to gate, and
a second Classification-presence check every consuming instance would otherwise need to satisfy.
The old files are retained (`deprecated/SRMDLOTARCore_DublinCore.xsd`,
`LOTAR_Core_DublinCore_Vocabulary.md` itself, marked superseded) for historical reference, per this
project's non-destructive convention.

## Classification type

```
type="org.lotar-international.lotar-core.common"
```

## Obligation levels

Derived directly from `GeneralPLMInfoType`'s own cardinality in `P500_Series_Common.xsd`:
**Mandatory** where the source element is required (`minOccurs` unset or `1`), **Optional** where
`minOccurs="0"`.

## Administrative / legal cluster

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
| ~~Variable Naming Convention~~ | ~~`administrative.variable-naming-convention`~~ | *Removed 2026-07-21* | *(was: migrated from FMI3 `@variableNamingConvention`)* | Reverted to a native structural rule in `lotar-fmi2.0.5-archival.sch`/`lotar-fmi3.0.2-archival.sch` — not authorship/legal/generation metadata, doesn't belong in provenance. See decision note above. |
| Disposal Reason | `administrative.disposal-reason` | Mandatory, conditional on a Retracted life-cycle entry existing | *(new — closes PD12 Disposal)* | Reason(s) for deletion/retraction, required once the object has a `Retracted` STC life-cycle entry (STC's own authorising-agent half is covered separately by `lotar-stc-archival.sch`'s universal Signature mandate). |
| Size (Bytes) | `administrative.size-bytes` | Mandatory | *(new — closes PD4 Size, Tier 1)* | Size, in bytes, of the whole Digital Object (entire zipped FMU or SSP) this SRMD instance describes. Tier 2 (per-contained-artifact size inside an SSP) is the same keyword, enforced separately on `stc:Resource` in `lotar-stc-archival.sch`. |
| Submission Agreement Reference | `administrative.submission-agreement-ref` | Mandatory | *(new — closes P6 Submission Agreement)* | Identifier or URI referencing the Submission Agreement between Producer and Archive — the SRMD-Classification equivalent of METS `metsHdr/altRecordID`. |
| Copyright | `legal.copyright` | Mandatory | `Copyright` | URI to the intellectual property rights statement. |
| License | `legal.license` | Mandatory | `License` | URI to the license. |
| Export Controls | `legal.export-controls` | Mandatory | `Export_Controls` | URI to export control information. |
| Export Control Marking | `legal.export-control-marking` | Mandatory | `Export_control_marking` | Export marking text. |
| Special Markings | `legal.special-markings` | Mandatory | `Special_markings` | Other marking text. |
| ~~Risk Level~~ | ~~`risk.level`~~ | *Moved to the credible-process layer 2026-09-05 (D-24)* | — | Replaced by `credibility.level` (`CL1`–`CL4`) under `org.credible-process.core`, same DTMD attachment point; LOTAR no longer names tiers (R1–R4 retired). See `credible-process-schemas/vocabulary/Credible_Process_Core_Vocabulary.md`. |
| Archiving Required | `administrative.archiving-required` | Optional here / **Mandatory when attached to DTMD `FulfillmentPhase/DecideObjectiveFulfillment/Output`** (T-09a, built 2026-08-04) | *(new — no `GeneralPLMInfoType` analogue; closes D-17/OD-17)* | Whether this decision task's evidence should be archived at all — closed enum `yes`\|`no`. Answers §3.3's "R1 + archive is stricter than R1" tension by putting the archiving filter at the CDP decision point rather than inside the risk-scaled Schematron profile. See `LOTAR_Risk_Assessment_Method.md`. |
| ~~Model Validation Mode~~ | ~~`model-validation.mode`~~ | *Moved to the credible-process layer 2026-09-05 (D-24)* | — | Same keyword, now under `org.credible-process.core`. |
| ~~Signature — Signer Role~~ | ~~`signature.signer-role`~~ | *Not adopted — see D-22* | *(was: T-18 recommendation, PREMIS-`signatureInformation` analogue)* | **Superseded 2026-08-14 (D-22).** XAdES's own `xades:SignedProperties/xades:SignerRole/ClaimedRoles` already carries this fact, cryptographically bound to the signature it describes — a separate plaintext copy would be redundant, not a durability improvement, since it isn't itself signed. See `LOTAR_Digital_Signatures.md`. |
| ~~Signature — Method~~ | ~~`signature.method`~~ | *Moved to the credible-process layer 2026-09-05 (D-24)* | — | Same keyword, now under `org.credible-process.core`. |
| ~~Signature — Date~~ | ~~`signature.date`~~ | *Not adopted — see D-22* | *(was: T-18 recommendation, PREMIS-`signatureInformation` analogue)* | **Superseded 2026-08-14 (D-22).** XAdES's own `xades:SignedProperties/xades:SigningTime` already carries this fact, cryptographically bound to the signature it describes, for the same reason `signature.signer-role` was dropped. See `LOTAR_Digital_Signatures.md`. |
| ~~Signature — Validation Note~~ | ~~`signature.validation-note`~~ | *Moved to the credible-process layer 2026-09-05 (D-24)* | — | Same keyword, now under `org.credible-process.core`. |

Implementation note: `Copyright`, `License`, `Export_Controls`, `Model_Dependency`,
`Model_Hierarchy` and `Privacy_Rules` are URIs in the source schema. `ClassificationEntry`
already supports an optional `xlink:href` attribute for exactly this case — a producer may put
the URI there instead of (or in addition to) the element content, keeping the value itself
human-readable if desired.

Not listed here because they're already covered by MIC Core: `Model_Name`, `Unique_object_id`,
`Unique_baseline_id`, `Model_Objective`, `Organization`, `Maturity_State`, `Model_Purpose`,
`System_Designation` (see `MIC_Core_to_LOTAR_Mapping.md`).

## Dublin Core mapping (D2)

Closes **D2** (Core Attributes): *"Descriptive Metadata schema used SHALL be defined within each
organization using the Archive, containing at a minimum, the set of Dublin Core Metadata Element
Set 1.1, namely: contributor, coverage, creator, date, description, format, identifier, language,
publisher, relation, rights, source, subject, title and type."* Absorbed into this document
2026-08-06 (see the decision note above); originally authored 2026-07-21 as a standalone vocabulary
(`LOTAR_Core_DublinCore_Vocabulary.md`).

**Why reuse over duplication:** of the 15 Dublin Core Metadata Element Set 1.1 terms, 8 already
have a genuine 1:1 counterpart elsewhere in this project (MIC Core's model identity fields, this
document's own administrative/legal cluster, or STC's structural `ResourceType` attributes) and are
NOT duplicated as new keywords — only documented as equivalent below. This follows this project's
established preference for mapping over duplication (the same reasoning that dropped
`ReferenceResults/@checksum` in favor of the pre-existing `ReferenceFileHash` sibling element, and
that keeps FMI/SSP provenance running through one mechanism rather than several). Only the 7 terms
with no existing counterpart at all get new keywords, at Recommended tier (see the "Dublin Core
Recommended Attributes" pattern in `SRMDLOTARCore_Common.xsd`): unlike this cluster's
administrative/legal keywords (populated on every archive regardless of content), these 7 Dublin
Core roles are not universally applicable to every archived simulation artifact (e.g. a component
model with no distinguishable "contributor" separate from its creator, or no meaningful
spatial/temporal "coverage"). D2's own SHALL is read as "the schema SHALL be defined to include
these fields" (a capability requirement, satisfied by this mapping's existing at all) rather than
"every field SHALL be populated in every instance" — Dublin Core's own specification makes all 15
of its elements optional and repeatable in general use.

| Dublin Core term | Mechanism | Obligation | Rationale |
| --- | --- | --- | --- |
| Creator | reuse `administrative-data.model.supplier` (MIC Core) | Mandatory (reused) | "entity primarily responsible for making the resource" ≈ the organization that supplied/produced the model. |
| Date | reuse `administrative.created-on` (this document) | Mandatory (reused) | Direct match — both anchor the artifact's creation in time. |
| Format | reuse structural `stc:ResourceType/@type` (mandatory MIME) + FMI-native format itself | Mandatory (reused, structural) | DC "format" = the file/media type, already a mandatory structural attribute, not a Classification keyword. |
| Title | reuse `administrative-data.model.name` (MIC Core) | Mandatory (reused) | Direct match — the resource's name/title. |
| Type | reuse structural `stc:ResourceType/@kind` (mandatory enumerated nature-of-resource) | Mandatory (reused, structural) | DC "type" = the nature/genre of the resource, already captured by `@kind`'s closed enumeration. |
| Rights | reuse `legal.copyright` + `legal.license` + `legal.export-controls` cluster (this document) | Mandatory (reused) | DC "rights" = "information about rights held in and over the resource" — directly covered by the existing mandatory legal cluster. |
| Identifier | reuse `administrative-data.model.identifier` (MIC Core) | Recommended (reused, not promoted) | MIC Core's own identifier keyword is Recommended, not Mandatory; not overridden here, since MIC Core's obligation tiers are that specification's own. |
| Description | reuse `administrative-data.model.description` / `purpose-objectives.model` (MIC Core) | Mandatory (reused; promoted 2026-07-21, provenance unification) | Direct match — see the provenance-unification decision above. |
| Contributor | **new** `dc.contributor` | Recommended, repeatable | Secondary-contributor role varies by archive; not universally distinguishable from Creator. |
| Coverage | **new** `dc.coverage` | Recommended | Spatial/temporal coverage doesn't apply to every simulation artifact. |
| Language | **new** `dc.language` | Recommended | Most simulation models are language-agnostic; relevant mainly for embedded documentation. |
| Publisher | **new** `dc.publisher` | Recommended | Distinct from Creator (the archiving/distributing entity vs. the authoring one) but not always meaningfully distinguishable in practice. |
| Relation | **new** `dc.relation` | Recommended, repeatable | Overlaps conceptually with STC Links/Arc and `administrative.model-dependency`, but those are structural, not a DC-labeled descriptive field; kept as a lightweight, human-readable cross-reference. |
| Source | **new** `dc.source` | Recommended, repeatable | Overlaps conceptually with `ResourceType.master`/DerivationChain, but this is a DC-specific human-readable source citation, not a structural provenance link. |
| Subject | **new** `dc.subject` | Recommended, repeatable | Topical keywords for retrieval; no existing equivalent anywhere in MIC Core or this document. |

7 of 15 terms are Mandatory via reuse of already-mandatory fields (Creator, Date, Format, Title,
Type, Rights, Description); 1 (Identifier) is Recommended via reuse of an already-Recommended MIC
Core field; the remaining 7 are new, all Recommended, 4 of them repeatable.

## Summary table (quick reference)

| Cluster | Keywords | Mandatory | Optional |
| --- | --- | --- | --- |
| Administrative | 18 | 13 | 5 |
| Legal | 5 | 5 | 0 |
| Risk / Archiving Decision | 3 | 0 | 3 |
| Signature (confirmed 2026-08-14, D-22) | 2 | 0 | 2 |
| Dublin Core (D2, absorbed 2026-08-06) | 7 | 0 | 7 |
| **Total** | **35** | **18** | **17** |

*Note: this table's Administrative split was recalculated during the 2026-07-20 update — the
prior version stated 9/5, which didn't match the per-row obligations (8/6 before this update's
two additions); corrected here alongside the two new mandatory keywords. Recalculated again later
the same day to add `administrative.disposal-reason` (Mandatory, conditional) — counted as
Mandatory per the PD12-closure decision above, bringing Administrative to 17/11/6 and the overall
total to 22/16/6. Recalculated a third time, later the same day still, to add
`administrative.size-bytes` (Mandatory, PD4 Tier 1) — Administrative now 18/12/6, overall total
23/17/6. Recalculated a fourth time, 2026-07-21, to add `administrative.submission-agreement-ref`
(Mandatory, P6 closure) — Administrative now 19/13/6, overall total 24/18/6. Recalculated a fifth
time, 2026-07-21 (provenance unification, same day): removed `administrative.variable-naming-
convention` (was Mandatory, -1 keyword) and promoted `administrative.created-by` from Optional to
Mandatory (no keyword-count change, Optional -1/Mandatory +1) — net Administrative 18/13/5,
overall total 23/18/5. Recalculated a sixth time, 2026-08-04 (T-04, risk-profile plan execution):
added `risk.level` and `administrative.archiving-required` as a new "Risk / Archiving Decision"
cluster, both counted Optional here since their real Mandatory enforcement is DTMD-context-specific
(T-09a, not yet built) rather than generic-SRMD-level — net Administrative unchanged at 18/13/5,
overall total 25/18/7. `administrative.archiving-required` keeps the `administrative.*` keyword
prefix for consistency with its sibling `administrative.*` keywords despite being counted in the
new cluster row, not the Administrative row, since its DTMD-anchored obligation logic is genuinely
different from the rest of that cluster. Recalculated a seventh time, 2026-08-04 (T-16/T-18/T-20,
Phase E execution): added `model-validation.mode` to the "Risk / Archiving Decision" cluster
(Optional, MTMD-specific two-path scheme) and a new "Signature" cluster of four keywords
(`signature.signer-role`/`-.method`/`-.date`/`-.validation-note`, all Optional, T-18
recommendation not yet confirmed by the working group) — Risk/Archiving Decision now 3/0/3,
Signature 4/0/4, overall total 30/18/12. Recalculated an eighth time, 2026-08-06 (Dublin Core
absorption): added a new "Dublin Core (D2)" cluster of 7 keywords (`dc.contributor`, `dc.coverage`,
`dc.language`, `dc.publisher`, `dc.relation`, `dc.source`, `dc.subject`), all Optional (Recommended
tier), absorbed from the retired `SRMDLOTARCore_DublinCore.xsd` — overall total now 37/18/19.
Recalculated a ninth time, 2026-08-14 (D-22, T-18 resolved): removed `signature.signer-role` and
`signature.date` (-2 keywords) — XAdES's own `xades:SignedProperties` now carries those two facts
cryptographically bound to the signature itself, so a separate unsigned plaintext copy would be
redundant rather than durability-adding (see `LOTAR_Digital_Signatures.md`). `signature.method` and
`signature.validation-note` are kept and their obligation status changed from "T-18 recommendation,
not yet confirmed" to confirmed — Signature cluster now 2/0/2, overall total 35/18/17.*

See `SRMDLOTARCore_Common.xsd` for the corresponding SRMD-conformant XML Schema (extends
`SRMD.xsd` with Schematron rules for classification presence, mandatory-attribute checks, and an
allowed-keyword whitelist), built the same way as `SRMDMICCore.xsd` / `SRMDSICCore.xsd`.
