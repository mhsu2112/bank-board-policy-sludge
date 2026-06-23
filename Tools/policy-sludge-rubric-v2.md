# Policy-Sludge Output Evaluation Rubric — v2 (merged)

**Purpose.** A general-purpose instrument for assessing AI outputs that *identify policy sludge* — inventories and analyses that surface duplicative, overlapping, redundant, obsolete, ambiguous, or disproportionately burdensome requirements in a defined regulatory/policy context, for reform, compliance, or oversight.

**What changed from v1.** This version merges v1's operational scaffolding (request-spec reconstruction, citation sampling, dual human/LLM use, scoring workbook, reviewer protocol) with the strongest ideas from the alternative GPT-5.5 framework:

1. **Integrity-weighted scoring** (no longer equal weight). The six dimensions now carry deliberately unequal weights that put the heaviest pressure on source integrity and accuracy.
2. **Explicit scored subcriteria** inside the dimensions: *actor mapping* (under D1 and D5), *binding-vs-guidance distinction* (under D3), and *reform usefulness* (under D4).
3. **Two added critical flags**: F6 material scope evasion, F7 unsupported central legal conclusion.
4. **Graduated cap severity**: integrity flags now cap the affected dimension to **0 if central** to the output's conclusions, or **≤1 if peripheral** — replacing v1's single blunt cap.

Companion documents: the **LLM-as-Judge Evaluator Prompt (v2)**, the **Reviewer Protocol (v2)**, and the **Scoring Workbook (v2 .xlsx)**.

---

## 1. What counts as "policy sludge"

Defects in a body of requirements: **duplication** (same obligation imposed twice), **overlap** (partially redundant, inconsistent demands), **layering/accretion** (stacked over time without consolidation), **obsolescence** (superseded or vestigial), **ambiguity/vagueness** (unclear scope or addressee), **disproportionate burden** (cost large relative to benefit, or on the wrong actor), and **process friction** (filings, attestations, approvals that add drag without value). An output identifies sludge well when it does not merely inventory requirements but **maps and characterizes these defects** actionably.

---

## 2. Step 0 — Reconstruct the request specification (before scoring)

Comprehensiveness is judged against a target derived from each prompt — this is what keeps the rubric reusable. From the prompt under evaluation, extract a **coverage map**:

1. **Domain / context** and jurisdiction.
2. **Unit of analysis** (what is inventoried).
3. **Structural axes** the answer must span (list each — e.g., full board vs. committee vs. director type; entity level).
4. **Source universe** (authorities/agencies/instruments named or implied; statute vs. regulation vs. guidance tiers).
5. **Substantive coverage areas** (topics named or implied).
6. **Audience and use** (sets the granularity and actionability bar).
7. **Form / depth / citation-granularity expectations.**

Record this as a checklist of the cells the answer should fill. Comprehensiveness (D1) is scored against this derived map, with sampling where the universe is large. The map is a *reasonable-completeness target*, not exhaustive ground truth; where the true universe is unknowable without research, judge against (a) what the prompt names and (b) what a domain expert would expect, and treat unflagged unknowns conservatively (D6).

---

## 3. Scoring dimensions, weights, and subcriteria

Each dimension is scored **0–4** on the anchors below, then **weighted**. Weights sum to 100 and are skewed toward integrity per the chosen design:

| Dim | Dimension | Weight | Maps to your interests |
|---|---|---|---|
| D1 | Coverage & Comprehensiveness | **20** | comprehensiveness |
| D2 | Source & Citation Integrity | **25** | integrity (primary) |
| D3 | Substantive Accuracy & Currency | **20** | integrity / accuracy |
| D4 | Sludge-Analysis Quality | **15** | the core analytic value |
| D5 | Structure, Granularity & Fitness-for-Purpose | **10** | usability |
| D6 | Calibration & Transparency | **10** | integrity (honesty about limits) |

Integrity-bearing dimensions (D2 + D3) carry **45** of 100, and with D6 the integrity-leaning total is **55** — a deliberate tilt so an output cannot earn a high headline number while its sourcing is unreliable. The user's four headline interests map as: **comprehensiveness** → D1; **integrity** → D2 (primary), D3, D6; **strengths/weaknesses** → the required narrative (§6).

### Dimension 1 — Coverage & Comprehensiveness (weight 20)
*Does the output fill the cells of the reconstructed coverage map across every structural axis, source, and substantive area?*

- **4** — All structural axes, the full named source universe, and all substantive areas covered; few/no material omissions on sampling; even depth.
- **3** — All axes and areas with only minor, non-material gaps; source universe substantially complete.
- **2** — Main axes/areas covered but noticeable gaps (a named agency or axis thinly treated); uneven depth.
- **1** — Only a subset; multiple named axes/sources/areas missing or token.
- **0** — Fails the requested scope; answers a narrower/different question.

*Subcriterion — Actor mapping (coverage side):* the output must cover **every actor the prompt distinguishes** (e.g., full board vs. each named committee; entity tiers such as holding company vs. subsidiary; director classes). Missing an entire required actor class is a material omission that caps D1 at ≤2.

### Dimension 2 — Source & Citation Integrity (weight 25)
*Are cited authorities real, correctly attributed, precisely located, and faithfully represented? The integrity core.*

- **4** — Citations specific (section/paragraph where expected), verifiable, correctly attributed; cited text genuinely supports the claim; quotations accurate.
- **3** — Specific and verifiable with trivial slips; no misattribution/fabrication on sampling.
- **2** — Mostly verifiable but imprecise locators, over-broad pin-cites, or claims that strain the source.
- **1** — Vague/hard-to-verify sourcing; ≥1 misattribution or unsupported-by-source claim, but no outright fabrication.
- **0** — One or more **fabricated** citations, invented quotations, or misleading misattribution.

*Cap interactions:* F1 (fabrication) caps D2 at **0 if central / ≤1 if peripheral**; F2 (misattribution) caps D2 ≤1; F7 (unsupported central legal conclusion) caps D2 ≤1.

### Dimension 3 — Substantive Accuracy & Currency (weight 20)
*Are the characterizations correct and in force now?*

- **4** — Characterizations correct; in-force status accurate; superseded/proposed/stale items excluded or labeled; effective dates and applicability thresholds handled correctly.
- **3** — Accurate with at most minor imprecision; currency correct on sampling.
- **2** — Generally accurate but some scope/effect mischaracterizations or one or two currency errors.
- **1** — Several substantive errors or stale characterizations a practitioner would catch.
- **0** — Pervasive inaccuracy, or repealed/superseded/proposed material presented as current.

*Subcriterion — Binding-vs-guidance distinction:* the output must clearly separate **binding requirements** (statute/regulation) from **non-binding material** (supervisory guidance, examination expectations, best practice, the output's own recommendations). Systematic blending of guidance with law caps D3 at ≤2 even if the underlying citations are real — overstating guidance as law is a core reform-credibility failure.

*Cap interactions:* F3 (stale-as-current) and F4 (invented obligation) each cap D3 at **0 if central / ≤1 if peripheral**.

### Dimension 4 — Sludge-Analysis Quality (weight 15)
*Beyond inventorying, does it identify and characterize sludge, and discriminate genuine sludge from necessary requirements?*

- **4** — Systematically cross-maps requirements to surface duplication/overlap/layering/obsolescence; distinguishes true redundancy from superficially similar but distinct requirements; avoids false positives; explains *why* each item is sludge.
- **3** — Identifies the major sludge patterns with sound reasoning and few false positives.
- **2** — Surfaces some overlap/duplication but largely as inventory with light analysis; mixes genuine and dubious examples.
- **1** — Little genuine analysis; lists requirements without mapping defects, or labels normal requirements as sludge without support.
- **0** — No identification of sludge; undifferentiated list; or treats all regulation as sludge.

*Subcriterion — Reform usefulness:* strong outputs go beyond diagnosis to indicate **reform levers** — what could be consolidated, delegated, or clarified; what is duplicative across authorities; what should remain intact; and whether a fix needs statutory vs. regulatory vs. supervisory change. Absence of any reform-actionable framing caps D4 at ≤3; a purely descriptive list with no reform signal caps D4 at ≤2.

### Dimension 5 — Structure, Granularity & Fitness-for-Purpose (weight 10)
*Organized, granular, and usable for the stated audience and use?*

- **4** — Organization mirrors the request; granularity matches the citation-level demand; navigable; directly usable as the working document needed.
- **3** — Well organized and appropriately granular; minor frictions.
- **2** — Serviceable but uneven; would need reformatting before use.
- **1** — Disorganized, inconsistent entries, or wrong level of detail.
- **0** — Structure defeats the stated purpose.

*Subcriterion — Actor mapping (granularity side):* duties must be mapped to **precise actors/offices/decision points**, not collapsed into generic "board oversight" language. Pervasive vague-actor phrasing caps D5 at ≤2.

### Dimension 6 — Calibration & Transparency (weight 10)
*Honest about its own scope, gaps, uncertainty, and method, without overclaiming?*

- **4** — States method and source cutoff; flags uncovered/unverifiable areas; distinguishes firm obligations from judgment calls; avoids false exhaustiveness; invites verification.
- **3** — Generally transparent with minor self-disclosure gaps.
- **2** — Some hedging where due, but overstates completeness or under-flags uncertainty in places.
- **1** — Little transparency; partial work presented as comprehensive.
- **0** — Affirmatively claims exhaustiveness/certainty it has not earned.

*Cap interaction:* F5 (false exhaustiveness) caps D6 ≤1.

---

## 4. Critical flags (with graduated severity)

Binary flags recorded separately from scores. Each requires **evidence** (a specific failing citation/claim), not suspicion. Flags do not change the weights; they **cap the affected dimension** and set the **reliability overlay**. For the cap-bearing integrity flags, record a **severity**: *Central* (affects the output's main conclusions or recurs across the document) or *Peripheral* (isolated, non-load-bearing).

| Flag | Definition | Severity | Effect |
|---|---|---|---|
| **F1 Fabricated source** | Cited authority doesn't exist, or invented quotation. | Central / Peripheral | Caps D2 = 0 (central) or ≤1 (peripheral); **Integrity-flagged**. |
| **F2 Misattribution** | Real provision attributed to wrong agency/instrument/section, misleadingly. | — | Caps D2 ≤1; Integrity-flagged if material. |
| **F3 Stale-as-current** | Repealed/superseded/proposed-only presented as in force. | Central / Peripheral | Caps D3 = 0 (central) or ≤1 (peripheral); Integrity-flagged. |
| **F4 Invented obligation** | Requirement asserted with no traceable basis. | Central / Peripheral | Caps D3 = 0 (central) or ≤1 (peripheral); Integrity-flagged. |
| **F5 False exhaustiveness** | Explicit completeness claim contradicted by material, undisclosed gaps. | — | Caps D6 ≤1. |
| **F6 Scope evasion** | Polished output that materially fails to answer the requested context. | — | Caps D1 ≤1; **Scope-flagged**. |
| **F7 Unsupported central legal conclusion** | Confident, load-bearing legal conclusion with no citation-level support. | — | Caps D2 ≤1; Integrity-flagged. |

**Reliability overlay** (reported alongside the numeric tier):
- **Clean** — no flags.
- **Integrity-flagged** — any of F1–F5 or F7.
- **Scope-flagged** — F6 (may co-occur, e.g., "Integrity + Scope-flagged").

---

## 5. Scoring math and tiers

- Each dimension: integer **0–4**, then apply flag caps to get the **effective** score.
- **Overall (0–100)** = Σ(weightᵢ × effective_scoreᵢ) ÷ 4. (Equivalently, each dimension contributes weightᵢ × effective/4; a perfect 4 across all dimensions yields 100.)
- Per-dimension maximum contribution = its weight (D2 up to 25 pts, D1/D3 up to 20, D4 up to 15, D5/D6 up to 10).

**Quality tiers (numeric):**

| Tier | Score | Meaning |
|---|---|---|
| A — Publication-ready | 85–100 | Reliable; minor polish only. |
| B — Strong | 70–84 | Sound; minor fixes before use. |
| C — Usable with revision | 50–69 | Real value; substantial gaps to close. |
| D — Weak | 30–49 | Major rework required. |
| E — Inadequate | 0–29 | Does not serve the purpose. |

**Reliability overlay overrides the tier for reliance decisions.** A result reads, e.g., *"Tier B (78/100) — Integrity-flagged (F1 central in §3)."* Because integrity now carries 45+ of the weight and central integrity flags zero out their dimension, a genuinely compromised output will usually fall a full tier or more *and* carry the overlay — closing v1's "high number despite a fabrication" gap.

---

## 6. Required narrative outputs

1. **Scope reconstruction summary** — the coverage map from Step 0.
2. **Top strengths** — 3–5 bullets, each tied to a dimension and a concrete example.
3. **Top weaknesses** — 3–5 bullets, each tied to a dimension and example, ordered by severity.
4. **Critical flags** — each flag raised, with the specific failing citation/claim and its severity.
5. **Subcriteria check** — one line each on actor mapping, binding-vs-guidance, and reform usefulness.
6. **Prioritized remediation** — the 3–5 highest-value fixes, in order.
7. **Bottom line** — tier, reliability overlay, and a one-sentence reliance recommendation.

---

## 7. Calibration and consistency notes

- **Score the output, not the topic's difficulty.** Hard requests raise the value of transparency (D6); they don't lower the bar elsewhere.
- **Sample, don't boil the ocean.** Verify a defined citation sample (see Reviewer Protocol) and project; never infer fabrication from a single unverifiable cite without attempting verification.
- **Separate the failure types.** Missing items → D1; wrong/stale items → D3; unverifiable/fake items → D2; guidance-as-law → D3 subcriterion; generic-actor language → D5 subcriterion.
- **Severity discipline.** Mark a flag *Central* only if it touches the output's main conclusions or recurs; otherwise *Peripheral*. When in doubt on a fabrication, default to Central (conservative).
- **Avoid leniency drift.** Length, confidence, and authoritative tone are not evidence of accuracy or integrity.
- **Anchor every score to evidence.** Each dimension score cites at least one concrete instance from the output.
