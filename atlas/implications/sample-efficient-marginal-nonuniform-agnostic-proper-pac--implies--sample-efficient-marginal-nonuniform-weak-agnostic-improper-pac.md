---
type: implication
id: sample-efficient-marginal-nonuniform-agnostic-proper-pac__implies__sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: sample-efficient-marginal-nonuniform-agnostic-proper-pac
target: sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[sample-efficient-marginal-nonuniform-agnostic-proper-pac|Sample-Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (strength: strong-to-weak; properness: proper-to-improper)."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: same
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Marginal-Nonuniform Agnostic Proper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


