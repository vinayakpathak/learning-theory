---
type: implication
id: efficient-realizable-proper-pac__implies__efficient-realizable-improper-pac
source: efficient-realizable-proper-pac
target: efficient-realizable-improper-pac
source_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
target_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "A proper learner is also an improper learner if the output class is allowed to contain the benchmark class."
family: monotone-relaxation
axis_delta:
  distribution: same
  strength: same
  realizability: same
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Proper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`true`, trivially.

Any proper realizable PAC learner outputs a hypothesis $h \in \mathcal C$. The same output is valid for the improper model, where the learner is allowed to output hypotheses from a larger class.
