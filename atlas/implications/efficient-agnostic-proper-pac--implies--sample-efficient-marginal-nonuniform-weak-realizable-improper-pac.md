---
type: implication
id: efficient-agnostic-proper-pac__implies__sample-efficient-marginal-nonuniform-weak-realizable-improper-pac
source: efficient-agnostic-proper-pac
target: sample-efficient-marginal-nonuniform-weak-realizable-improper-pac
source_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-realizable-improper-pac|Sample-Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (resource: computationally-efficient-to-sample-efficient; distribution: distribution-free-to-marginal-nonuniform; strength: strong-to-weak; realizability: agnostic-to-realizable; properness: proper-to-improper)."
family: monotone-relaxation
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: distribution-free-to-marginal-nonuniform
  strength: strong-to-weak
  realizability: agnostic-to-realizable
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Proper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


