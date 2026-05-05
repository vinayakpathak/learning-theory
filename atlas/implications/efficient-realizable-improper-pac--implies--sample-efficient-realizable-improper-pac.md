---
type: implication
id: efficient-realizable-improper-pac__implies__sample-efficient-realizable-improper-pac
source: efficient-realizable-improper-pac
target: sample-efficient-realizable-improper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
target_note: "[[sample-efficient-realizable-improper-pac|Sample-Efficient Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (resource: computationally-efficient-to-sample-efficient)."
family: monotone-relaxation
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: same
  strength: same
  realizability: same
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Sample-Efficient Realizable Improper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


