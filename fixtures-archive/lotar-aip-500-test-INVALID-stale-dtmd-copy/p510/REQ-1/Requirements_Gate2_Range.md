# InfiniRange Gate 2 — range and efficiency requirements (excerpt)

*Worked-example content for the LOTAR 2026 500-series archive `EVRangeExampleV3_AIP` (D-25). Illustrative,
not a real program document. Object id `InfiniRange-Gate2-Requirements`, version 1.2, baseline
`InfiniRange-Gate2-Baseline`.*

| ID | Requirement | Verified by |
|---|---|---|
| REQ-RANGE-001 | The vehicle shall achieve a combined WLTP/NEDC range gain of at least 4 % with the aggressive regenerative-brake blending strategy relative to the standard strategy, for the Standard battery variant at 20 °C ambient. | P520 scenario `VV-1-RangeGain` (ElectricRange_V2, test case 1) |
| REQ-RANGE-002 | The range gain of REQ-RANGE-001 shall be demonstrated for all four battery variants (Standard, Extended, ExtendedPlus, Degraded L1) with no variant falling below 2.5 %. | P520 scenario `VV-1-RangeGain` |
| REQ-RANGE-003 | The combined-cycle range prediction shall remain within 3 % of the predecessor-platform field data across the four representative ambient climate zones. | P520 scenario `VV-1-RangeGain` (validation summary) |

Constraint: the battery-variant lineup is bounded by the battery-pack envelope of CAD part 4711, held in
the 100-series archive of the same baseline (identifier-only reference, see the P510 manifest's
`Constrained_by`).
