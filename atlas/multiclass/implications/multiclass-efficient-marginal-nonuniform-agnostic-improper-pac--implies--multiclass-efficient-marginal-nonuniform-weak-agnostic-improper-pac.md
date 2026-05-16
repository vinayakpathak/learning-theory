---
type: implication
id: multiclass-efficient-marginal-nonuniform-agnostic-improper-pac__implies__multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: multiclass-efficient-marginal-nonuniform-agnostic-improper-pac
target: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
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
  distribution: same
  strength: strong-to-weak
  realizability: same
  properness: same
argument_note: "[[multiclass-monotone-relaxation|Monotone Relaxation]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `strong-to-weak`
- `realizability`: `same`
- `properness`: `same`
