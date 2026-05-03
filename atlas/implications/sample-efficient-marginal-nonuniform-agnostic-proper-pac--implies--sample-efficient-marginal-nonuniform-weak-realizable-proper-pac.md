---
type: implication
id: sample-efficient-marginal-nonuniform-agnostic-proper-pac__implies__sample-efficient-marginal-nonuniform-weak-realizable-proper-pac
source: sample-efficient-marginal-nonuniform-agnostic-proper-pac
target: sample-efficient-marginal-nonuniform-weak-realizable-proper-pac
source_note: "[[sample-efficient-marginal-nonuniform-agnostic-proper-pac|Sample-Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (strength: strong-to-weak; realizability: agnostic-to-realizable)."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Marginal-Nonuniform Agnostic Proper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


