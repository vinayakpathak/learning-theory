---
type: implication
id: sample-efficient-weak-agnostic-proper-pac__implies__sample-efficient-weak-realizable-proper-pac
source: sample-efficient-weak-agnostic-proper-pac
target: sample-efficient-weak-realizable-proper-pac
source_note: "[[sample-efficient-weak-agnostic-proper-pac|Sample-Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[sample-efficient-weak-realizable-proper-pac|Sample-Efficient Weak Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (realizability: agnostic-to-realizable)."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Sample-Efficient Weak Realizable Proper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


