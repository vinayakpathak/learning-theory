---
type: implication
id: efficient-marginal-nonuniform-agnostic-improper-pac__implies__sample-efficient-marginal-nonuniform-weak-realizable-improper-pac
source: efficient-marginal-nonuniform-agnostic-improper-pac
target: sample-efficient-marginal-nonuniform-weak-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-realizable-improper-pac|Sample-Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (resource: computationally-efficient-to-sample-efficient; strength: strong-to-weak; realizability: agnostic-to-realizable)."
family: monotone-relaxation
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: same
  strength: strong-to-weak
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


