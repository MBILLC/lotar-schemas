# LOTAR Status Vocabulary Mapping

*Origin (2026-07-20): published to close two related profile opportunities flagged in
`FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md` §4 — the D9 status mapping ("mapping not
published") and the PD14 QC outcome literal ("not literal"). Both close via the same underlying
mechanism (STC's `LifeCycleInformationType` states, now universally Signature-bearing per
`lotar-stc-archival.sch`), but answer different requirement questions, so they are kept in
separate sections below rather than merged into one table.*

## Scope and structure

- **§1** maps Requirements.md's D9 status vocabulary (`configured`/`frozen`/`released`, sourced
  from EN-NAS9300-500 §7.4.1 PLM status text) onto STC's `LifeCycleInformationType` six states
  (`Drafted`/`Defined`/`Validated`/`Approved`/`Archived`/`Retracted`). One combined mapping table.
- **§2** describes MIC Core's `verification-status`/`validation-status` vocabulary
  (`SRMDMICCore.xsd`, `Classification/@type='org.mic-core.mic-core'`) independently, cross-
  referenced against §1 but **not merged into the same table** — confirmed 2026-07-20: D9's
  configured/frozen/released vocabulary answers "what PLM lifecycle state is this data in?"; MIC
  Core's verification-status/validation-status answers "what was the V&V outcome for this data?"
  These are different questions that happen to both be expressed as STC-adjacent status-like
  values, and conflating them into one table would obscure that distinction.
- **§3** maps PD14's required pass/fail/not-performed QC-outcome literal onto the same STC
  `LifeCycleInformationType` states used in §1, as a documented interpretation rather than a new
  schema-enforced field (see §3 for why).

## 1. D9 status mapping — LOTAR PLM status ↔ STC LifeCycleInformationType

D9 (Status) requires: *"If the Content Information has an applicable status according to the
relevant LOTAR domain part (e.g. part 200) then each Information Package SHOULD contain this
information according to a standard vocabulary defined in the relevant domain part (e.g.
configured, frozen, released for part 200 PLM data)."* EN-NAS9300-500 §6.7.3 additionally
requires that "only static-stable data SHALL be subject to long term archiving" and that "the
data SHALL be clearly identified with an indication of configuration change, state and status" —
i.e. the mapping below is not just a nice-to-have cross-reference, it is how 515/520 satisfies
D9's "standard vocabulary" clause using a mechanism that already exists (STC's
`LifeCycleInformationType`) rather than inventing a new one.

| D9 LOTAR status | Mapped STC `LifeCycleInformationType` state | Rationale |
| --- | --- | --- |
| *(none — pre-configuration)* | `Drafted` | STC: "in draft state and still in progress... information is not complete." No D9 equivalent — D9's vocabulary only starts once data reaches at least `configured`; `Drafted` covers the pre-archival working state EN-NAS9300-500 §6.7.3 excludes from long-term archiving ("only static-stable data SHALL be subject to long term archiving"). |
| `configured` | `Defined` | STC: "considered complete and may be subject to review or validation." A configured baseline is content-complete and established, but not yet formally reviewed/validated — the closest STC state to "configured" in EN-NAS9300-500's PLM sense. |
| `frozen` | `Validated` | STC: "reviewed and validated." A frozen baseline has been locked down following review/validation, but has not yet received final release approval — matching STC's distinction between "validated" and "approved." |
| `released` | `Approved` | STC: "approved based on review and validation." `released` is EN-NAS9300-500's terminal PLM state for data cleared for use/distribution, matching STC's "approved" (which in turn is the state PD17's Approval-Prior-to-Release requirement and `lotar-stc-archival.sch`'s Signature mandate both attach to). |
| *(none — post-release archival)* | `Archived` | STC: "set as valid and remains valid for this instance... but may not be reused for similar steps or phases in other GlueParticles." No D9 equivalent — this is an STC-internal reuse-scoping state, not a PLM lifecycle state EN-NAS9300-500's vocabulary distinguishes. |
| *(none — disposal)* | `Retracted` | STC: "withdrawn and is considered invalid or may need to be revised." No direct D9 equivalent, but directly relevant to PD12 (Disposal) — a `Retracted` entry is what triggers the `administrative.disposal-reason` conditional-mandatory keyword (see `LOTAR_Core_Common_Vocabulary.md`) and the universal Signature mandate in `lotar-stc-archival.sch`. |

**Mechanism note:** with `lotar-stc-archival.sch`'s item-2 closure (Signature mandatory on every
`LifeCycleInformationType` entry, not only `Approved`), every state in the right-hand column now
carries the same accountability guarantee, so this mapping table can be cited as a complete,
schematron-backed status vocabulary for D9 rather than one with gaps at the non-`Approved` states.

## 2. MIC Core V&V status vocabulary (kept separate — different question)

`SRMDMICCore.xsd` (`Classification/@type='org.mic-core.mic-core'`) separately defines two
Recommended (`role="info"`, not Mandatory) `ClassificationEntry` keywords under the
`verification-validation` prefix:

| MIC Core keyword | Obligation | Value | What it answers |
| --- | --- | --- | --- |
| `verification-validation.verification-status` | Recommended | Free text (placeholder value `"Status"` in the schema's own Quick Fix) | Was this Content Information *verified*, and with what outcome? |
| `verification-validation.validation-status` | Recommended | Free text | Was this Content Information *validated*, and with what outcome? |
| `verification-validation.procedure-criteria` | Recommended | Free text | What procedure/criteria was the V&V judged against? |
| `verification-validation.report` | Recommended | Free text / link | Link to the V&V report itself. |

These four keywords are a **V&V outcome vocabulary**, not a PLM lifecycle-state vocabulary — they
answer "did this pass verification/validation, against what criteria, with what report," which is
a different question from D9's "what lifecycle state is this data in" (§1). Both happen to sit
conceptually near STC's `LifeCycleInformationType` (a `Validated` STC state and a
`verification-status`/`validation-status` value can both be true of the same object at the same
time, without one implying the other's specific content), which is exactly why they are
documented here side by side but kept in separate tables rather than merged: merging them would
imply a 1:1 correspondence between "STC lifecycle state" and "V&V outcome value" that the schemas
themselves do not assert. `verification-status`/`validation-status` remain Recommended, free-text
fields in `SRMDMICCore.xsd` — this mapping document does not change their obligation level or
add a controlled enumeration for them; that remains a candidate for future work if 515/520 wants
to formalize a closed value set (e.g. pass/fail/pending) for these two keywords specifically.

## 3. PD14 QC outcome — documented interpretation via STC LifeCycleInformationType

PD14 (Quality Control Events) requires event outcomes that "distinguish between 'passed', 'failed'
and 'not performed'." EN-NAS9300-500 §7.1.2 reinforces this: V&V "SHALL be assigned one of three
values (pass, fail, or not performed)."

**Approach chosen (2026-07-20, confirmed) — option (a): reuse the D9-style STC LifeCycle mapping**
rather than adding a new literal-outcome `ClassificationEntry` keyword. Mapping:

| PD14 outcome | Mapped condition | Rationale |
| --- | --- | --- |
| `passed` | A `Validated` (or later — `Approved`/`Archived`) `LifeCycleInformationType` entry is present | STC's own definition of `Validated` ("has been reviewed and validated") is a direct semantic match for "passed." Per `LifeCycleInformationType`'s own documented ordering rule, only the last/highest-maturity entry in document order is authoritative for current status, so `Approved`/`Archived` (both later than `Validated` in the progression) also imply a pass. |
| `failed` | A `Retracted` `LifeCycleInformationType` entry is present | STC's definition of `Retracted` ("withdrawn and is considered invalid or may need to be revised") maps directly onto "failed" — the object did not survive V&V and was withdrawn as a result. |
| `not performed` | No `LifeCycleInformationType` entry is present at all (or only `Drafted`, which precedes any review/validation step) | Absence of life-cycle information — or a status no further along than `Drafted` — means no V&V event has yet occurred to record an outcome, matching "not performed" directly. |

**Important caveat — this is a documentation-level interpretation, not a new schema-enforced
literal field.** PD14's own requirement text asks for an event outcome that literally
"distinguishes between 'passed', 'failed' and 'not performed'"; the mapping above satisfies that
need at the interpretation/documentation level by reusing the already-existing (and, per item 2 of
the 2026-07-20 closure pass, now-universally-Signature-bearing) `LifeCycleInformationType` states,
without adding a redundant keyword that would just restate the same three-way distinction a second
time in `ClassificationEntry` form. If a future revision of 515/520 needs a literal, directly-
queryable pass/fail/not-performed field (e.g. for tooling that should not have to know this
mapping), that remains a candidate follow-up — not implemented here, per the explicit choice of
option (a) over adding a new keyword.

## Sources

`Requirements.md` (D9, PD14; EN-NAS9300-500 §6.7.3, §7.1.2). `STC.xsd`
(`LifeCycleInformationType`, `LifeCycleEntryType`). `SRMDMICCore.xsd`
(`verification-validation.*` keywords). `lotar-stc-archival.sch` (universal Signature mandate,
item 2 of the 2026-07-20 closure pass). `LOTAR_Core_Common_Vocabulary.md`
(`administrative.disposal-reason`). `FMI_SSP_Evaluation_vs_Requirements_v3_LOTARCore.md` §4 (D9
and PD14 profile-opportunity rows this document closes).
