---
type: implication
id: efficient-agnostic-proper-pac__implies__efficient-agnostic-improper-pac
source: efficient-agnostic-proper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
target_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "A proper agnostic learner is also an improper agnostic learner if the output class is allowed to contain the benchmark class."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Proper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`true`, trivially.

Any proper agnostic learner outputs in $\mathcal C$. The same output is valid for the improper model.
