#!/bin/bash
# ------------------------------------------------------------------
# Runs the Gemma 4 E4B judge over every report in this folder.
#
# BEFORE running this you must have:
#   1. Installed Ollama and pulled the model:   ollama pull gemma4:e4b
#   2. Built the judge model:                   ollama create gemma4-judge -f Modelfile
#   3. Saved each report as plain text in THIS folder, named  Report_A.txt, Report_B.txt, etc.
#   4. Kept JUDGE-PROMPT-ready.txt in THIS folder
#
# To run: open Terminal, then drag this file onto the Terminal window and press Return.
# (Or: cd into this folder and run  bash run-gemma-evals.sh )
# ------------------------------------------------------------------
cd "$(dirname "$0")" || exit 1

shopt -s nullglob
reports=( Report_*.txt )

if [ ${#reports[@]} -eq 0 ]; then
  echo "No files named Report_*.txt found in this folder."
  echo "Convert each report to plain text first (see the memo, Step 2)."
  exit 1
fi

for f in "${reports[@]}"; do
  name="${f%.txt}"
  echo "----------------------------------------------------------"
  echo "Scoring: $name"
  cat "JUDGE-PROMPT-ready.txt" "$f" > "combined_${name}.txt"
  ollama run gemma4-judge < "combined_${name}.txt" > "result_gemma_${name}.json"
  echo "Saved: result_gemma_${name}.json"
done

echo "----------------------------------------------------------"
echo "Done. Open each result_gemma_*.json file to read the scores."
