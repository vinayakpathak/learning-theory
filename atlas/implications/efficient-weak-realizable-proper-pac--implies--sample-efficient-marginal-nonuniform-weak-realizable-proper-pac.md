---
type: implication
id: efficient-weak-realizable-proper-pac__implies__sample-efficient-marginal-nonuniform-weak-realizable-proper-pac
source: efficient-weak-realizable-proper-pac
target: sample-efficient-marginal-nonuniform-weak-realizable-proper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (resource: computationally-efficient-to-sample-efficient; distribution: distribution-free-to-marginal-nonuniform)."
family: monotone-relaxation
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: same
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


