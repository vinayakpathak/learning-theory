---
type: implication
id: sample-efficient-realizable-proper-pac__implies__sample-efficient-realizable-improper-pac
source: sample-efficient-realizable-proper-pac
target: sample-efficient-realizable-improper-pac
source_note: "[[sample-efficient-realizable-proper-pac|Sample-Efficient Realizable Proper PAC Learning]]"
target_note: "[[sample-efficient-realizable-improper-pac|Sample-Efficient Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (properness: proper-to-improper)."
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

# Sample-Efficient Realizable Proper PAC Learning $\Rightarrow$ Sample-Efficient Realizable Improper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


