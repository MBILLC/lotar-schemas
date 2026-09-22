# LOTAR Core vocabulary for SRMD — Dublin Core mapping (closes D2)

> **SUPERSEDED 2026-08-06 — kept for historical reference only.** This mapping has been absorbed
> into `LOTAR_Core_Common_Vocabulary.md`'s own "Dublin Core mapping (D2)" section: the 7 new
> keywords below (`dc.contributor`, `dc.coverage`, `dc.language`, `dc.publisher`, `dc.relation`,
> `dc.source`, `dc.subject`) now live under `org.lotar-international.lotar-core.common` (this
> document's own `org.lotar-international.lotar-core.dublin-core` type is retired), and the
> corresponding schema, `SRMDLOTARCore_DublinCore.xsd`, has moved to `deprecated/`. Do not cite
> this file or its Classification type in new work — cite `LOTAR_Core_Common_Vocabulary.md`
> instead. The content below is left unchanged for historical accuracy; see
> `LOTAR_Artifacts_and_Decisions_Log_current.md`'s 2026-08-06 entry for the full rationale.

## Purpose and scope

D2 (Core Attributes) requires: *"Descriptive Metadata schema used SHALL be defined within each
organization using the Archive, containing at a minimum, the set of Dublin Core Metadata Element
Set 1.1, namely: contributor, coverage, creator, date, description, format, identifier, language,
publisher, relation, rights, source, subject, title and type."*

Before this document, D2 scored ▲ (Classification) in every pass — a generic extension point,
with no purpose-built 1:1 mapping onto the 15 Dublin Core (DC) terms anywhere in MIC Core or
LOTAR Core. This document closes that gap with a dedicated mapping, choosing option (a) from the
two considered when this was proposed:

- **(a) — chosen:** a documented mapping that reuses an already-existing Mandatory/Recommended
  keyword wherever a genuine 1:1 correspondence exists, and adds new keywords only for the DC
  terms that have no existing counterpart at all.
- **(b) — not chosen:** a dedicated, fully independent `dublin-core` Classification type
  containing all 15 terms as new keywords, with no reuse of existing fields.

## Why option (a), and why D2 stays at ◐ (not ●)

Option (a) was chosen because it follows this project's established preference for mapping over
duplication — the same reasoning that dropped `ReferenceResults/@checksum` in favor of the
pre-existing `ReferenceFileHash` sibling element (`FMISchematron/lotar-p515-archival.sch`), and
that deliberately excluded `generatingTool` from `lotar-stc-archival.sch`'s `DerivationChainEntry`
mandate because `administrative.generation-tool` already covers the same fact
(`SRMDLOTARCore_Common.xsd`). Option (b) would have created seven or eight parallel fields
(`dc.creator`, `dc.date`, `dc.title`, ...) holding the exact same information as fields that
already exist and are already asserted elsewhere — two keywords that can drift out of sync with
each other, for no gain over a documented equivalence.

D2's own text is SHALL-level, but that SHALL attaches to the *schema being defined* to contain the
15-element set ("Descriptive Metadata schema used SHALL be defined... containing at a minimum,
the set of..."), not to every one of the 15 elements being populated in every archived instance.
Read literally, Dublin Core's own specification makes all 15 of its elements optional and
repeatable in general use — DC's own ethos is that not every element applies to every resource
(a component model, for instance, rarely has a meaningful spatial/temporal "coverage" or a
"contributor" distinct from its creator). Because of this, 7 of the 15 terms below are tiered
Recommended rather than Mandatory, by design, not oversight. Since this document's own status
legend defines ● as requiring mandatory-strength provision, D2 is upgraded from ▲ to **◐** — a
dedicated, purpose-built mapping now exists (stronger than a bare extension point), but it is
honestly not a full closure, the same distinction already drawn for GR3, D4, and PD13/PD14
elsewhere in this evaluation.

## Classification type (new keywords only)

```
type="org.lotar-international.lotar-core.dublin-core"
```

Only the 7 DC terms with no existing counterpart get new keywords under this type (see
`SRMDLOTARCore_DublinCore.xsd`). The other 8 are documented below as equivalent to fields that
already live under `org.mic-core.mic-core` or `org.lotar-international.lotar-core.common`, or as
structural (non-Classification) attributes elsewhere in SRMD/STC.

## Full 15-element mapping

| Dublin Core term | Mechanism | Obligation | Rationale |
| --- | --- | --- | --- |
| Creator | reuse `administrative-data.model.supplier` (MIC Core) | Mandatory (reused) | "entity primarily responsible for making the resource" ≈ the organization that supplied/produced the model. |
| Date | reuse `administrative.created-on` (Common) | Mandatory (reused) | Direct match — both anchor the artifact's creation in time. |
| Format | reuse structural `stc:ResourceType/@type` (mandatory MIME) + FMI-native format itself | Mandatory (reused, structural) | Already established via PD2's own closure; DC "format" = the file/media type, which is already a mandatory structural attribute, not a Classification keyword. |
| Title | reuse `administrative-data.model.name` (MIC Core) | Mandatory (reused) | Direct match — the resource's name/title. |
| Type | reuse structural `stc:ResourceType/@kind` (mandatory enumerated nature-of-resource) | Mandatory (reused, structural) | DC "type" = the nature/genre of the resource, which `@kind`'s closed enumeration (document/model/result/report/...) already captures. |
| Rights | reuse `legal.copyright` + `legal.license` + `legal.export-controls` cluster (Common) | Mandatory (reused) | DC "rights" = "information about rights held in and over the resource" — directly covered by the existing mandatory legal cluster. |
| Identifier | reuse `administrative-data.model.identifier` (MIC Core) | **Recommended (reused, not promoted)** | Honest carry-over of the same gap already flagged at D4 — MIC Core's own identifier keyword is Recommended, not Mandatory. Not promoted here: MIC Core's obligation tiers are that specification's own, not LOTAR's to unilaterally override as a side effect of closing D2. |
| Description | reuse `administrative-data.model.description` (MIC Core) | Recommended (reused) | Direct match, already Recommended in MIC Core. |
| Contributor | **new** `dc.contributor` (this document) | Recommended | Secondary-contributor role varies by archive; not universally distinguishable from Creator. |
| Coverage | **new** `dc.coverage` (this document) | Recommended | Spatial/temporal coverage doesn't apply to every simulation artifact. |
| Language | **new** `dc.language` (this document) | Recommended | Most simulation models are language-agnostic; relevant mainly for embedded documentation. |
| Publisher | **new** `dc.publisher` (this document) | Recommended | Distinct from Creator (the archiving/distributing entity vs. the authoring one) but not always meaningfully distinguishable in practice. |
| Relation | **new** `dc.relation` (this document) | Recommended | Overlaps conceptually with STC Links/Arc and `administrative.model-dependency`, but those are structural, not a DC-labeled descriptive field; kept as a lightweight, human-readable cross-reference. |
| Source | **new** `dc.source` (this document) | Recommended | Overlaps conceptually with `ResourceType.master`/DerivationChain, but this is a DC-specific human-readable source citation, not a structural provenance link. |
| Subject | **new** `dc.subject` (this document) | Recommended | Topical keywords for retrieval; no existing equivalent anywhere in MIC Core or LOTAR Core. |

8 of 15 terms are Mandatory via reuse of already-mandatory fields (Creator, Date, Format, Title,
Type, Rights) or documented as Recommended-via-reuse where the existing field is itself
Recommended (Identifier, Description). The remaining 7 are new, all Recommended by design.

## Summary table (quick reference)

| Tier | Count | Terms |
| --- | --- | --- |
| Mandatory (all reused, no new keywords) | 6 | Creator, Date, Format, Title, Type, Rights |
| Recommended (reused, existing tier not promoted) | 2 | Identifier, Description |
| Recommended (new keyword, this document) | 7 | Contributor, Coverage, Language, Publisher, Relation, Source, Subject |
| **Total** | **15** | |

See `SRMDLOTARCore_DublinCore.xsd` for the corresponding SRMD-conformant XML Schema (extends
`SRMD.xsd` with Schematron rules for classification presence, recommended-attribute checks, and an
allowed-keyword whitelist for the 7 new terms), built the same way as the other LOTAR Core parts.
