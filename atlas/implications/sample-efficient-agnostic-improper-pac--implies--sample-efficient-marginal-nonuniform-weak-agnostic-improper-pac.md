---
type: implication
id: sample-efficient-agnostic-improper-pac__implies__sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: sample-efficient-agnostic-improper-pac
target: sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[sample-efficient-agnostic-improper-pac|Sample-Efficient Agnostic Improper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (distribution: distribution-free-to-marginal-nonuniform; strength: strong-to-weak)."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: strong-to-weak
  realizability: same
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Agnostic Improper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


