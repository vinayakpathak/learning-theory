---
type: implication
id: efficient-realizable-proper-pac__implies__sample-efficient-marginal-nonuniform-weak-realizable-improper-pac
source: efficient-realizable-proper-pac
target: sample-efficient-marginal-nonuniform-weak-realizable-improper-pac
source_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-realizable-improper-pac|Sample-Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (resource: computationally-efficient-to-sample-efficient; distribution: distribution-free-to-marginal-nonuniform; strength: strong-to-weak; properness: proper-to-improper)."
family: monotone-relaxation
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: distribution-free-to-marginal-nonuniform
  strength: strong-to-weak
  realizability: same
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Proper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


