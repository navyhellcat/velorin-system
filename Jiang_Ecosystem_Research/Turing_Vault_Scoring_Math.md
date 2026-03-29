# TURING VAULT — IQ VAULT SCORING SYSTEM

Finalized March 27, 2026 | Source: Jiang + Christian Taylor session

---

## FORMULA

**Step 1 — Raw Accuracy**

raw_score = (correct_answers / total_questions) × 100

**Step 2 — Calibration Modifier**

adjusted_score = raw_score + calibration_modifier

Calibration modifier reflects how well the user's confidence ratings matched their actual correctness. Well-calibrated confidence adds points. Dunning-Kruger pattern (high confidence, low accuracy) subtracts points.

**Step 3 — Difficulty Multiplier (Christian Taylor global modifiers)**

final_score = adjusted_score × difficulty_multiplier

| Mode | Multiplier | Cap |
|---|---|---|
| Standard | × 0.85 | 80 |
| Hard | × 0.90 | 90 |
| Adversarial | × 1.15 | 100 |

If final_score exceeds the cap, it is set to the cap.

---

## VALIDATED SCENARIOS

### High Performers

| Scenario | Raw | Calibration | Adjusted | × Multiplier | Final |
|---|---|---|---|---|---|
| 10/10 Standard, high confidence (+6) | 100 | +6 | 100 | × 0.85 = 85 | **80 (capped)** |
| 10/10 Hard, high confidence (+6) | 100 | +6 | 100 | × 0.90 = 90 | **90 (capped)** |
| 10/10 Adversarial, high confidence (+7) | 100 | +7 | 100 | × 1.15 = 115 | **100 (capped)** |
| 8/10 Adversarial, great calibration (+8) | 80 | +8 | 88 | × 1.15 = 101 | **100 (capped)** |
| 9/10 Adversarial, great calibration (+7) | 90 | +7 | 97 | × 1.15 = 112 | **100 (capped)** |

### Realistic 99.9th Percentile Verbal User

| Scenario | Raw | Calibration | Adjusted | × Multiplier | Final |
|---|---|---|---|---|---|
| 7/10 Adversarial, good calibration (+5) | 70 | +5 | 75 | × 1.15 | **86** |
| 6/10 Adversarial, good calibration (+5) | 60 | +5 | 65 | × 1.15 | **75** |
| 7/10 Hard, good calibration (+6) | 70 | +6 | 76 | × 0.90 | **68** |
| 6/10 Hard, good calibration (+5) | 60 | +5 | 65 | × 0.90 | **59** |
| 8/10 Standard, good calibration (+6) | 80 | +6 | 86 | × 0.85 | **73** |

### Low Performers

| Scenario | Raw | Calibration | Adjusted | × Multiplier | Final |
|---|---|---|---|---|---|
| 5/10 Standard, Dunning-Kruger (+1) | 50 | +1 | 51 | × 0.85 | **43** |
| 4/10 Hard, confidently wrong (-5) | 40 | -5 | 35 | × 0.90 | **32** |
| 6/10 Hard, all minimum confidence (+0) | 60 | +0 | 60 | × 0.90 | **54** |
| 5/10 Adversarial, no calibration (+0) | 50 | +0 | 50 | × 1.15 | **58** |

---

## DESIGN VALIDATION

- 6/10 Adversarial (75) outscores 8/10 Standard (73) — rewards harder test selection
- Only Adversarial can produce scores of 100
- Perfect Standard maxes at 80 — strong score, clear signal to level up
- Perfect Hard maxes at 90 — excellent but not ceiling
- 8/10 Adversarial with good calibration hits cap — top tier requires real performance

## OPEN FLAG

5/10 Adversarial with zero calibration (58) scores higher than 5/10 Standard Dunning-Kruger (43). The multiplier rewards attempting Adversarial even at coin-flip accuracy. Optional fix raised: floor the 1.15 boost to only apply above 50 adjusted. Decision: **not yet made.**

---

## SCORE BANDS — AI JOB-DISPLACEMENT RISK

Corrected for 50% binary baseline. Timelines updated March 2026 (v2 timelines reduced 20%, reflecting accelerated AI deployment pace).

| Score | Risk Label | Probability | Timeframe |
|---|---|---|---|
| Below 50 | NO MEASURABLE DISCRIMINATION | Not assessable | Not assessable |
| 50-57 | CRITICAL EXPOSURE | 70-90% | Already underway / 10-19 months |
| 58-65 | HIGH EXPOSURE | 55-75% | 10-29 months |
| 66-74 | ELEVATED EXPOSURE | 40-60% | 19-38 months |
| 75-82 | MODERATE EXPOSURE | 25-45% | 29-48 months |
| 83-90 | LOW EXPOSURE | 15-30% | 3-5.5 years |
| 91-96 | VERY LOW EXPOSURE | 5-15% | 5-8+ years |
| 97-100 | NEGLIGIBLE | <5% | Not foreseeable |

### Resource Tier Mapping

| Score | Resource Tier | Verbal Fluency Level |
|---|---|---|
| Below 50 + 50-57 | TIER 1 — SURVIVAL | Floor to minimal. Visual-first, step-by-step, no jargon. |
| 58-74 | TIER 2 — INTEGRATION | Low-moderate to moderate. Guided tutorials, example-driven. |
| 75-90 | TIER 3 — BUILDING | Above-average to high. Technical docs, API concepts, system design. |
| 91-100 | TIER 4 — OPERATING | High to ceiling. Primary source docs, SDK refs, architecture. |

### Override Tiers (Toggle-Activated, Not Score-Driven)

| Toggle | Risk Label | Probability | Timeframe |
|---|---|---|---|
| Blue Collar / Trades | VERY UNLIKELY | <5% | Not foreseeable |
| Homemaker / Mother | VERY UNLIKELY | <5% | Not foreseeable |