# Reviewer Protocol — Policy-Sludge Output Assessment (v2, merged)

A step-by-step workflow for a human reviewer scoring a policy-sludge output against the **v2 rubric** (integrity-weighted dimensions, scored subcriteria, seven flags with graduated severity), and for combining human review with an LLM-as-judge pass. Reproducible across different sludge requests.

---

## At a glance

| Phase | What you do | Output |
|---|---|---|
| A. Prep | Reconstruct the request spec; build the coverage map | Coverage map / ledger |
| B. Coverage pass | Mark which cells the output fills (incl. every actor class) | D1 evidence |
| C. Citation spot-check | Verify a defined sample; tag central/peripheral | D2/D3 evidence, flags + severity |
| D. Analysis pass | Judge sludge analysis + reform usefulness | D4 evidence |
| E. Usability + calibration | Judge structure/actor-mapping (D5) and honesty (D6) | D5/D6 evidence |
| F. Subcriteria + flags | Check the three subcriteria; set F1–F7 | Subcriteria verdicts, flags |
| G. Score + narrate | Enter raw scores + flags; sheet computes effective/weighted | Completed scorecard |
| H. Reconcile | Combine with LLM-judge pass | Final result |

Time budget for a ~40–60 page output: **90–150 min** solo, ~60 min if an LLM-judge pass runs first and you verify its findings.

---

## What's new in v2 (read first)

- **Weights, not equal.** Dimensions are weighted toward integrity: D1 20, **D2 25**, D3 20, D4 15, D5 10, D6 10. You still score each 0–4; the workbook applies the weights. Integrity (D2+D3+D6) carries 55 of 100.
- **Subcriteria you must check:** actor mapping (D1 coverage + D5 granularity), binding-vs-guidance distinction (D3), reform usefulness (D4). Each can cap its dimension — see below.
- **Two added flags:** F6 scope evasion, F7 unsupported central legal conclusion.
- **Graduated severity:** for F1/F3/F4, mark **Central** (touches main conclusions or recurs) or **Peripheral** (isolated). Central zeroes the dimension; peripheral caps it at ≤1.

---

## Phase A — Reconstruct the spec (rubric Step 0)

Read the **request** first. Write a one-paragraph coverage map: domain/jurisdiction, unit of analysis, structural axes (list **every actor class** the prompt distinguishes), source universe (named + implied; note statute/regulation/guidance tiers), substantive areas, audience/use, form/depth expectations. Turn it into a **coverage ledger** — the cells the answer should fill — defining a representative subset to check if the universe is large. This is your D1 measuring stick and the same template works for any sludge domain.

## Phase B — Coverage pass (D1)

Skim structure against the ledger: each cell **covered / thin / missing.** Flag material omissions (a named agency absent, a structural axis ignored, a whole topic skipped). **Missing an entire required actor class caps D1 at ≤2.** Note uneven depth (rich on easy areas, thin on hard ones).

## Phase C — Citation spot-check (D2 and D3) — the integrity core

Sample defensibly; you won't check every cite.

1. **Sample:** default **15–20 citations** (or ~10% for very large outputs, whichever is larger), composed of the most load-bearing claims, the most specific pin-cites, and a random remainder across sections.
2. **Verify each against the primary source** (eCFR / Federal Register / agency site for U.S. federal rules; the official source otherwise). Record one verdict — **SUPPORTS / WRONG-ATTRIBUTION / NOT-SUPPORTED / STALE / FABRICATED / UNVERIFIABLE** — with a one-line reason, and tag **central or peripheral**.
3. **Set flags + severity:** F1 (fabricated; central/peripheral), F2 (misattribution), F3 (stale-as-current; central/peripheral), F4 (invented obligation; central/peripheral), F7 (unsupported central legal conclusion). Evidence required.
4. **Score D2** (attribution/verifiability/fidelity) and **D3** (correctness/currency). The workbook applies caps: a central fabrication zeroes D2; a peripheral one caps it ≤1.

Log every sampled citation in the workbook's **Citation Sample Log** so D2/D3 are auditable.

## Phase D — Sludge-analysis pass (D4)

Judge whether it's a real analysis or a glorified list: does it **cross-map** requirements to surface duplication/overlap/layering/obsolescence? Does it **discriminate** genuine redundancy from distinct-but-similar requirements (false positives)? Does it explain **why** each item is sludge? **Reform-usefulness subcriterion:** does it point to reform levers (consolidate / delegate / clarify / what stays / statutory vs. regulatory vs. supervisory)? No reform framing caps D4 ≤3; a purely descriptive list caps D4 ≤2.

## Phase E — Usability and calibration (D5, D6)

- **D5:** organization mirrors the request? granularity at the demanded level? **Actor-mapping subcriterion:** duties tied to precise actors, not generic "board oversight" — pervasive vague-actor language caps D5 ≤2.
- **D6:** discloses method, source cutoff, gaps? distinguishes firm obligations from judgment calls? avoids unearned exhaustiveness? If it explicitly claims completeness but Phase B found material gaps, set **F5** (caps D6 ≤1).

## Phase F — Subcriteria and flags wrap-up

Record one-line verdicts on the three subcriteria (actor mapping, binding-vs-guidance, reform usefulness). **Binding-vs-guidance** is scored under D3: systematic blending of guidance with binding law caps D3 ≤2 even when citations are real. Confirm all flags F1–F7 with evidence and severities. Set **F6** if the output is polished but materially off-context (caps D1 ≤1, scope-flagged).

## Phase G — Score and narrate

Enter the six **raw** 0–4 scores and the flags (with severities) in the workbook; it computes effective scores, the weighted overall, tier, and reliability overlay. Write the narrative: 3–5 strengths, 3–5 weaknesses by severity, subcriteria verdicts, prioritized remediation, one-line reliance recommendation. Report tier **and** overlay together.

## Phase H — Reconcile with the LLM-judge pass

1. Compare dimension scores; **investigate any gap of ≥2 points** — usually an omission by one of you.
2. **Confirm the judge's FABRICATED / STALE verdicts and any CENTRAL severity by hand** before formally flagging; LLMs both miss and hallucinate citation problems and tend to over- or under-call centrality.
3. Use the LLM pass as a fast first reader (it builds the ledger, proposes citation checks); the human owns the final integrity call and the central/peripheral severities.

---

## Calibration and fairness

- **Blind where possible.** Strip author/system identity and randomize order when comparing outputs.
- **Two reviewers for high-stakes use.** Score independently, reconcile, track agreement; persistent disagreement usually means an anchor or a severity rule needs sharpening.
- **Re-anchor on drift.** If scores creep up over a batch, re-read the anchors and re-score the first item.
- **Severity discipline.** *Central* only if it touches main conclusions or recurs; default a fabrication to Central when unsure.
- **Score the output, not its ambition.** Difficult requests raise the value of D6; they don't lower the bar elsewhere.
- **Evidence or it didn't happen.** Every score and flag carries a concrete quote or a specific failing citation.

## Escalation triggers (stop and route to an expert)

- Any **central F1 fabrication** or **F4 invented obligation** → integrity-flag and route before any reliance.
- Two or more **STALE-as-current** items → currency review by a domain specialist.
- **F6 scope evasion** on a deliverable headed for external use → return to producer; the polish is masking a wrong-context answer.
- Overall **Tier D/E** on an external deliverable → return with the prioritized remediation list.
