---
type: implication
id: multiclass-efficient-weak-realizable-improper-pac__implies__multiclass-sample-efficient-weak-realizable-improper-pac
source: multiclass-efficient-weak-realizable-improper-pac
target: multiclass-sample-efficient-weak-realizable-improper-pac
source_note: "[[multiclass-efficient-weak-realizable-improper-pac|Multiclass Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[multiclass-sample-efficient-weak-realizable-improper-pac|Multiclass Sample-Efficient Weak Realizable Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
result_origin: known
assumptions: []
witnesses: []
refs: []
summary: 'The target only relaxes requirements already met by the source (resource: computationally-efficient-to-sample-efficient).'
family: multiclass-monotone-relaxation
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: same
  strength: same
  realizability: same
  properness: same
argument_note: "[[multiclass-monotone-relaxation|Monotone Relaxation]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Multiclass Sample-Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `computationally-efficient-to-sample-efficient`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `same`
- `properness`: `same`
