---
type: implication
id: multiclass-efficient-agnostic-improper-pac__implies__multiclass-efficient-realizable-improper-pac
source: multiclass-efficient-agnostic-improper-pac
target: multiclass-efficient-realizable-improper-pac
source_note: "[[multiclass-efficient-agnostic-improper-pac|Multiclass Efficient Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-efficient-realizable-improper-pac|Multiclass Efficient Realizable Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
result_origin: known
assumptions: []
witnesses: []
refs: []
summary: An agnostic improper learner specializes to a realizable improper learner when the optimum benchmark error is zero.
family: multiclass-monotone-relaxation
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[multiclass-monotone-relaxation|Monotone Relaxation]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Realizable Improper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `agnostic-to-realizable`
- `properness`: `same`
