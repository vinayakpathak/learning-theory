---
type: implication
id: multiclass-efficient-agnostic-proper-pac__implies__multiclass-efficient-realizable-proper-pac
source: multiclass-efficient-agnostic-proper-pac
target: multiclass-efficient-realizable-proper-pac
source_note: "[[multiclass-efficient-agnostic-proper-pac|Multiclass Efficient Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-efficient-realizable-proper-pac|Multiclass Efficient Realizable Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
result_origin: known
assumptions: []
witnesses: []
refs: []
summary: An agnostic proper learner specializes to a realizable proper learner when the optimum benchmark error is zero.
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

# Multiclass Efficient Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Efficient Realizable Proper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `agnostic-to-realizable`
- `properness`: `same`
