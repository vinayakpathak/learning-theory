---
type: implication
id: multiclass-efficient-weak-agnostic-proper-pac__implies__multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac
source: multiclass-efficient-weak-agnostic-proper-pac
target: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac
source_note: "[[multiclass-efficient-weak-agnostic-proper-pac|Multiclass Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac|Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
result_origin: known
assumptions: []
witnesses: []
refs: []
summary: The target only relaxes requirements already met by the source learner.
family: multiclass-monotone-relaxation
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[multiclass-monotone-relaxation|Monotone Relaxation]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `same`
- `distribution`: `distribution-free-to-marginal-nonuniform`
- `strength`: `same`
- `realizability`: `agnostic-to-realizable`
- `properness`: `same`
