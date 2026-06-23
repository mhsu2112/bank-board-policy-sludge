# Memo: Instructions for Evaluating the Four Policy-Sludge Reports

Date: May 29, 2026

## Purpose

This memo explains how to evaluate four policy-sludge reports using three different LLMs as judges:

1. Claude Code, run from Terminal
2. Codex, run in the desktop app
3. Gemma 4 E4B, run locally from Terminal through Ollama

The goal is to run the same evaluation protocol for each judge and each report, save the judge outputs, and then enter the scores and flags into the scoring workbook.

Use the v2 evaluator artifacts unless you are intentionally reproducing the earlier v1 experiment.

## Working Folders

Main folder:

```text
/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace
```

Evaluator artifact folder:

```text
/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/Opus4.8 rubric and evaluator v1
```

Use these v2 files:

```text
policy-sludge-rubric-v2.md
policy-sludge-llm-judge-prompt-v2.md
policy-sludge-reviewer-protocol-v2.md
policy-sludge-scoring-workbook-v2.xlsx
```

Do not use these unless you are intentionally running the old v1 process:

```text
policy-sludge-rubric.md
policy-sludge-llm-judge-prompt.md
policy-sludge-reviewer-protocol.md
policy-sludge-scoring-workbook.xlsx
_test.xlsx
_tv2.xlsx
```

## Reports to Evaluate

Use these report labels consistently in prompts, saved files, and workbooks:

| Report label | File |
|---|---|
| Report A - RegGenome | `RegGenome + final_memo.pdf` |
| Report B - GPT 5.5 | `GPT 5.5 + final_memo.docx` |
| Report C - Opus 4.8 | `Opus 4.8 + final_memo.docx` |
| Report D - Caffrey | `Caffrey + final_memo.docx` |

Optional but recommended: if you want a blind evaluation, make neutral copies named `Report_A.pdf`, `Report_B.docx`, `Report_C.docx`, and `Report_D.docx`. Otherwise the judge may see the producing model name in the filename.

## Original Request to Use in Every Evaluation

Use this same original request for all 12 evaluations:

```text
Compile a comprehensive, citation-level inventory of all current, in-force obligations imposed on boards of directors of Category I global systemically important bank holding companies and their insured depository institution subsidiaries, drawing from all applicable federal regulations and agency guidance issued by the Federal Reserve, the OCC, the FDIC, and the CFPB, as well as relevant interagency standards. The inventory should capture obligations at every level of board structure, including obligations of the full board, obligations specific to individual board committees such as audit, risk, compensation, and nominating or governance committees, and any obligations that distinguish between inside and outside directors or between independent and non-independent directors. The research should address obligations arising across all major regulatory domains applicable to Category I GSIBs, including capital planning and stress testing, liquidity risk management, resolution planning, recovery planning, operational resilience, model risk governance, third-party risk management, incentive compensation, cybersecurity governance, BSA and AML program oversight, consumer compliance oversight, and safety and soundness standards generally. For each obligation identified, the inventory should specify the precise regulatory source, the nature of the board-level duty, whether the obligation falls on the full board or a specific committee, and any distinction between inside and outside or independent directors. The intended audience is bank directors and their legal counsel, as well as policymakers engaged in regulatory reform efforts aimed at identifying and reducing duplicative, overlapping, and unduly burdensome board-level requirements. The output should be granular and citation-specific, suitable for use as a working policy reform document, and is expected to be extensive, approximating 40 to 60 pages in depth.
```

## General Evaluation Rules

Run one report at a time. Do not give a judge all four reports in the same run.

Use the same judge prompt for every run:

```text
/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/Opus4.8 rubric and evaluator v1/policy-sludge-llm-judge-prompt-v2.md
```

Use these constants for every run:

```text
CITATION_SAMPLE_SIZE: 20
SOURCE_MATERIALS: None provided. Use official sources if retrieval tools are available; otherwise mark unverifiable citations as UNVERIFIABLE.
```

Use one of these sample seeds:

```text
Report A: 2026-05-29-Report-A
Report B: 2026-05-29-Report-B
Report C: 2026-05-29-Report-C
Report D: 2026-05-29-Report-D
```

The judge must return:

1. A JSON object using the v2 schema
2. A short markdown summary

Save every judge output. These saved outputs are the audit trail for later workbook entries.

## Set Up Output Folders

Open Terminal and run:

```zsh
cd '/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace'
mkdir -p judge_runs/claude judge_runs/codex judge_runs/gemma/inputs judge_runs/gemma/results scoring_results
```

## A. Claude Code Evaluation, Terminal

Claude Code can read local files from the working folder. You do not need to upload files. Start Claude Code from the main folder so it can see the reports and rubric files.

### A1. Start Claude Code

Open Terminal and run:

```zsh
cd '/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace'
claude
```

### A2. Run One Report

Paste the following task into Claude Code, replacing the report label and file path for each report:

```text
Run one policy-sludge evaluation.

Use this evaluator prompt exactly:
/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/Opus4.8 rubric and evaluator v1/policy-sludge-llm-judge-prompt-v2.md

Evaluate only this report:
[REPORT FILE PATH]

Original request:
[PASTE THE ORIGINAL REQUEST FROM THIS MEMO]

CITATION_SAMPLE_SIZE: 20
SAMPLE_SEED: [REPORT SEED]
SOURCE_MATERIALS: None provided. Use official sources if you have retrieval tools. If you cannot verify a citation, mark it UNVERIFIABLE rather than guessing.

Return the required JSON object followed by the short markdown summary. Save the full result to:
[OUTPUT FILE PATH]
```

Use these four Claude runs:

| Report | Report file path | Save result to |
|---|---|---|
| Report A | `/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/RegGenome + final_memo.pdf` | `judge_runs/claude/Report_A_RegGenome_eval.md` |
| Report B | `/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/GPT 5.5 + final_memo.docx` | `judge_runs/claude/Report_B_GPT55_eval.md` |
| Report C | `/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/Opus 4.8 + final_memo.docx` | `judge_runs/claude/Report_C_Opus48_eval.md` |
| Report D | `/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/Caffrey + final_memo.docx` | `judge_runs/claude/Report_D_Caffrey_eval.md` |

### A3. Important Claude Notes

Start a fresh Claude Code conversation for each report if possible. This reduces carryover from one report to the next.

If Claude says it cannot read a `.docx` or `.pdf`, tell it:

```text
Please convert the file to text locally, then continue the evaluation.
```

Do not ask Claude to edit the scoring workbook unless you specifically want it to. The safer process is to save the judge result, then enter the scores into the workbook manually.

## B. Codex Desktop Evaluation

Use one Codex run per report. Do not upload all four reports at once.

### B1. Start a New Codex Thread

Open Codex Desktop.

Set the workspace or working folder to:

```text
/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace
```

### B2. What to Upload or Provide

For each Codex run, provide only:

1. The evaluator prompt file:

```text
Opus4.8 rubric and evaluator v1/policy-sludge-llm-judge-prompt-v2.md
```

2. One report file, for example:

```text
RegGenome + final_memo.pdf
```

Do not upload the scoring workbook to the judge run. Fill the workbook afterward.

If Codex can access local paths directly, you may paste the file paths instead of uploading the files.

### B3. Paste This Codex Task

Use this task for each report:

```text
Run one policy-sludge evaluation.

Use the attached or local evaluator prompt file exactly:
policy-sludge-llm-judge-prompt-v2.md

Evaluate only the attached or local report:
[REPORT LABEL AND FILE NAME]

Original request:
[PASTE THE ORIGINAL REQUEST FROM THIS MEMO]

CITATION_SAMPLE_SIZE: 20
SAMPLE_SEED: [REPORT SEED]
SOURCE_MATERIALS: None provided. Use official sources if retrieval tools are available. If you cannot verify a citation, mark it UNVERIFIABLE rather than guessing.

Return the required JSON object followed by the short markdown summary. Also save the full result to:
[OUTPUT FILE PATH]
```

Use these four Codex output paths:

```text
judge_runs/codex/Report_A_RegGenome_eval.md
judge_runs/codex/Report_B_GPT55_eval.md
judge_runs/codex/Report_C_Opus48_eval.md
judge_runs/codex/Report_D_Caffrey_eval.md
```

### B4. Important Codex Notes

Use a fresh thread for each report if practical.

If Codex asks whether to browse or verify sources, allow verification against official sources where possible.

If Codex cannot verify most citations, it should still complete the evaluation, but it must keep D2 conservative and mark citations as `UNVERIFIABLE`.

## C. Gemma 4 E4B Local Evaluation, Terminal

Gemma runs locally through Ollama. It cannot browse the web and usually cannot read `.docx` or `.pdf` directly. For Gemma, create text prompt packets first, then pipe each packet into Ollama.

Because Gemma has no retrieval tools, treat its citation judgments as weaker than Claude/Codex if those judges can browse or retrieve official sources. Gemma should mark citations `UNVERIFIABLE` unless the relevant support is present in the report text itself or otherwise provided in the prompt.

### C1. Confirm Ollama and Model

Open Terminal and run:

```zsh
command -v ollama
```

You should see something like:

```text
/opt/homebrew/bin/ollama
```

Then make sure Ollama is running. If the Ollama desktop app is installed, open it. Or start it from Terminal in a separate window:

```zsh
ollama serve
```

The local model name on this machine is expected to be:

```text
gemma4:e4b
```

### C2. Create Gemma Prompt Packets

Run this from Terminal. It extracts text from the four reports and creates one Gemma input file per report.

```zsh
cd '/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace'

/Users/michaelhsu/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3 - <<'PY'
from pathlib import Path
from docx import Document
from pypdf import PdfReader

base = Path("/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace")
artifact_dir = base / "Opus4.8 rubric and evaluator v1"
prompt_file = artifact_dir / "policy-sludge-llm-judge-prompt-v2.md"
out_dir = base / "judge_runs" / "gemma" / "inputs"
out_dir.mkdir(parents=True, exist_ok=True)

original_request = """Compile a comprehensive, citation-level inventory of all current, in-force obligations imposed on boards of directors of Category I global systemically important bank holding companies and their insured depository institution subsidiaries, drawing from all applicable federal regulations and agency guidance issued by the Federal Reserve, the OCC, the FDIC, and the CFPB, as well as relevant interagency standards. The inventory should capture obligations at every level of board structure, including obligations of the full board, obligations specific to individual board committees such as audit, risk, compensation, and nominating or governance committees, and any obligations that distinguish between inside and outside directors or between independent and non-independent directors. The research should address obligations arising across all major regulatory domains applicable to Category I GSIBs, including capital planning and stress testing, liquidity risk management, resolution planning, recovery planning, operational resilience, model risk governance, third-party risk management, incentive compensation, cybersecurity governance, BSA and AML program oversight, consumer compliance oversight, and safety and soundness standards generally. For each obligation identified, the inventory should specify the precise regulatory source, the nature of the board-level duty, whether the obligation falls on the full board or a specific committee, and any distinction between inside and outside or independent directors. The intended audience is bank directors and their legal counsel, as well as policymakers engaged in regulatory reform efforts aimed at identifying and reducing duplicative, overlapping, and unduly burdensome board-level requirements. The output should be granular and citation-specific, suitable for use as a working policy reform document, and is expected to be extensive, approximating 40 to 60 pages in depth."""

reports = [
    ("Report_A_RegGenome", "RegGenome + final_memo.pdf", "2026-05-29-Report-A"),
    ("Report_B_GPT55", "GPT 5.5 + final_memo.docx", "2026-05-29-Report-B"),
    ("Report_C_Opus48", "Opus 4.8 + final_memo.docx", "2026-05-29-Report-C"),
    ("Report_D_Caffrey", "Caffrey + final_memo.docx", "2026-05-29-Report-D"),
]

def read_docx(path: Path) -> str:
    doc = Document(path)
    parts = []
    for p in doc.paragraphs:
        if p.text.strip():
            parts.append(p.text)
    for table in doc.tables:
        for row in table.rows:
            cells = [cell.text.strip().replace("\n", " ") for cell in row.cells]
            if any(cells):
                parts.append(" | ".join(cells))
    return "\n".join(parts)

def read_pdf(path: Path) -> str:
    reader = PdfReader(str(path))
    pages = []
    for i, page in enumerate(reader.pages, start=1):
        pages.append(f"\n[Page {i}]\n" + (page.extract_text() or ""))
    return "\n".join(pages)

judge_prompt = prompt_file.read_text()

for label, filename, seed in reports:
    path = base / filename
    if path.suffix.lower() == ".docx":
        report_text = read_docx(path)
    elif path.suffix.lower() == ".pdf":
        report_text = read_pdf(path)
    else:
        report_text = path.read_text()

    packet = f"""Use the following evaluator prompt exactly.

=== EVALUATOR PROMPT START ===
{judge_prompt}
=== EVALUATOR PROMPT END ===

Now run one evaluation using these inputs.

ORIGINAL_REQUEST:
{original_request}

CITATION_SAMPLE_SIZE: 20
SAMPLE_SEED: {seed}
SOURCE_MATERIALS: None provided. You do not have browsing or retrieval tools. Mark citations UNVERIFIABLE unless they can be verified from the supplied text itself. Do not guess.

OUTPUT_UNDER_EVALUATION:
{report_text}
"""
    out_path = out_dir / f"{label}_gemma_prompt.txt"
    out_path.write_text(packet)
    print(out_path)
PY
```

### C3. Run Gemma on Each Prompt Packet

Run these commands:

```zsh
cd '/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace'

ollama run gemma4:e4b < 'judge_runs/gemma/inputs/Report_A_RegGenome_gemma_prompt.txt' > 'judge_runs/gemma/results/Report_A_RegGenome_eval.md'

ollama run gemma4:e4b < 'judge_runs/gemma/inputs/Report_B_GPT55_gemma_prompt.txt' > 'judge_runs/gemma/results/Report_B_GPT55_eval.md'

ollama run gemma4:e4b < 'judge_runs/gemma/inputs/Report_C_Opus48_gemma_prompt.txt' > 'judge_runs/gemma/results/Report_C_Opus48_eval.md'

ollama run gemma4:e4b < 'judge_runs/gemma/inputs/Report_D_Caffrey_gemma_prompt.txt' > 'judge_runs/gemma/results/Report_D_Caffrey_eval.md'
```

If the result is cut off or Ollama reports that the prompt is too long, record that limitation. Do not silently treat the run as complete. Either rerun with a longer-context local setup or mark the Gemma evaluation as incomplete.

## Filling Out the Scoring Workbooks

Use the v2 scoring workbook:

```text
/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace/Opus4.8 rubric and evaluator v1/policy-sludge-scoring-workbook-v2.xlsx
```

Make three copies, one per judge:

```zsh
cd '/Users/michaelhsu/Work/03-agent-reliability/agent benchmarks/bank board sludge horserace'

cp 'Opus4.8 rubric and evaluator v1/policy-sludge-scoring-workbook-v2.xlsx' 'scoring_results/Claude_scoring_workbook.xlsx'
cp 'Opus4.8 rubric and evaluator v1/policy-sludge-scoring-workbook-v2.xlsx' 'scoring_results/Codex_scoring_workbook.xlsx'
cp 'Opus4.8 rubric and evaluator v1/policy-sludge-scoring-workbook-v2.xlsx' 'scoring_results/Gemma_scoring_workbook.xlsx'
```

### Workbook Tab 1: Comparison

Use the `Comparison` tab as the main place to enter the four report scores for each judge.

For each judge workbook:

1. Open the workbook.
2. Go to the `Comparison` tab.
3. In row 3, replace the column labels:

| Cell | Enter |
|---|---|
| B3 | Report A - RegGenome |
| C3 | Report B - GPT 5.5 |
| D3 | Report C - Opus 4.8 |
| E3 | Report D - Caffrey |

4. From each judge result JSON, copy the raw scores into rows 4-9:

| Workbook row | JSON field |
|---|---|
| Row 4 | `scores.D1_coverage.raw` |
| Row 5 | `scores.D2_integrity.raw` |
| Row 6 | `scores.D3_accuracy.raw` |
| Row 7 | `scores.D4_sludge_analysis.raw` |
| Row 8 | `scores.D5_structure.raw` |
| Row 9 | `scores.D6_calibration.raw` |

5. Enter flags in rows 11-20:

| Workbook row | What to enter |
|---|---|
| Row 11 | `Y` if JSON has F1, otherwise `N` |
| Row 12 | F1 severity: `Central` or `Peripheral`; leave default if F1 is `N` |
| Row 13 | `Y` if JSON has F2, otherwise `N` |
| Row 14 | `Y` if JSON has F3, otherwise `N` |
| Row 15 | F3 severity: `Central` or `Peripheral`; leave default if F3 is `N` |
| Row 16 | `Y` if JSON has F4, otherwise `N` |
| Row 17 | F4 severity: `Central` or `Peripheral`; leave default if F4 is `N` |
| Row 18 | `Y` if JSON has F5, otherwise `N` |
| Row 19 | `Y` if JSON has F6, otherwise `N` |
| Row 20 | `Y` if JSON has F7, otherwise `N` |

6. Do not edit rows 22-32. They calculate effective scores, weighted overall score, tier, reliability overlay, and rank automatically.

7. If the judge's reported `overall_score` differs from the workbook's row 29, use the workbook number and check whether the flags were entered correctly.

### Workbook Tab 2: Scorecard

The `Scorecard` tab records one detailed evaluation at a time. It is useful for formal documentation, but it is not necessary if the saved judge result files are your detailed record.

If you use it:

1. Make a separate workbook copy per judge/report, or overwrite the tab after saving a copy.
2. Fill:

| Cell or area | Enter |
|---|---|
| B2 | Output ID, for example `Report A - RegGenome` |
| E2 | Reviewer or judge, for example `Claude Code` |
| B3 | Date |
| E3 | Run mode, for example `LLM judge` |
| B4 | Short version of the original request/context |
| C7:C12 | Raw D1-D6 scores from the JSON |
| B16:B22 | Y/N flags F1-F7 |
| C16, C18, C19 | Severity for F1, F3, F4 if present |
| D16:D22 | Specific evidence for any flags |
| G7:G12 | Short evidence quote for each dimension |
| H7:H12 | Rationale for each score |
| B25:B27 | Y/N subcriteria checks |
| B34:B38 | Strengths, weaknesses, subcriteria verdicts, remediation, reliance recommendation |

Important: the workbook automatically applies flag caps, but it does not automatically apply the subcriteria caps. If the judge says actor mapping, binding-vs-guidance, or reform usefulness caps a raw score, enter the already-capped raw score from the judge result.

### Workbook Tab 3: Citation Sample Log

The `Citation Sample Log` is optional if the judge result JSON already preserves the sampled citations.

Use it for a formal audit trail or if a human reviewer is verifying the judge's citation checks.

For each sampled citation in the judge result JSON, enter:

| Column | Enter |
|---|---|
| B | Section in output |
| C | Citation as stated |
| D | Claim it supports |
| E | Verified against source or URL |
| F | Verdict: SUPPORTS, WRONG-ATTRIBUTION, NOT-SUPPORTED, STALE, FABRICATED, or UNVERIFIABLE |
| G | Central or Peripheral |
| H | One-line reason |
| I | Reviewer or judge |

Do not mix citation logs for many reports in one sheet unless you clearly label the rows. The simpler method is to keep the saved judge result files as the citation audit trail.

## Human Review and Reconciliation

After all 12 LLM-judge runs are complete:

1. Open each judge result file.
2. Confirm that it includes valid JSON plus a markdown summary.
3. Enter the scores and flags into that judge's comparison workbook.
4. Check row 31, `Reliability overlay`, before relying on any high numeric score.
5. Manually confirm any `FABRICATED`, `STALE`, or `Central` finding before treating it as final. LLM judges can both miss and overstate citation problems.
6. Compare the three judges:
   - If all three broadly agree, use the average directionally.
   - If one judge is an outlier by 2 or more points on a 0-4 dimension, inspect its rationale.
   - Treat Gemma's D2 citation-integrity score cautiously because Gemma has no browsing or retrieval tools.

## Deliverables After the Eval

At the end, the folder should contain:

```text
judge_runs/claude/Report_A_RegGenome_eval.md
judge_runs/claude/Report_B_GPT55_eval.md
judge_runs/claude/Report_C_Opus48_eval.md
judge_runs/claude/Report_D_Caffrey_eval.md

judge_runs/codex/Report_A_RegGenome_eval.md
judge_runs/codex/Report_B_GPT55_eval.md
judge_runs/codex/Report_C_Opus48_eval.md
judge_runs/codex/Report_D_Caffrey_eval.md

judge_runs/gemma/results/Report_A_RegGenome_eval.md
judge_runs/gemma/results/Report_B_GPT55_eval.md
judge_runs/gemma/results/Report_C_Opus48_eval.md
judge_runs/gemma/results/Report_D_Caffrey_eval.md

scoring_results/Claude_scoring_workbook.xlsx
scoring_results/Codex_scoring_workbook.xlsx
scoring_results/Gemma_scoring_workbook.xlsx
```

The final reported result for each report should always include:

```text
Judge name
Report label
Weighted overall score
Tier
Reliability overlay
Top 2-3 strengths
Top 2-3 weaknesses
Any critical flags
Reliance recommendation
```

