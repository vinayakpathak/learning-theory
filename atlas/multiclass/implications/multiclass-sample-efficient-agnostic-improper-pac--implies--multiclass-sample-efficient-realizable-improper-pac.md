---
type: implication
id: multiclass-sample-efficient-agnostic-improper-pac__implies__multiclass-sample-efficient-realizable-improper-pac
source: multiclass-sample-efficient-agnostic-improper-pac
target: multiclass-sample-efficient-realizable-improper-pac
source_note: "[[multiclass-sample-efficient-agnostic-improper-pac|Multiclass Sample-Efficient Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-sample-efficient-realizable-improper-pac|Multiclass Sample-Efficient Realizable Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
result_origin: known
assumptions: []
witnesses: []
refs: []
summary: 'The target only relaxes requirements already met by the source (realizability: agnostic-to-realizable).'
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

# Multiclass Sample-Efficient Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Sample-Efficient Realizable Improper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `agnostic-to-realizable`
- `properness`: `same`
