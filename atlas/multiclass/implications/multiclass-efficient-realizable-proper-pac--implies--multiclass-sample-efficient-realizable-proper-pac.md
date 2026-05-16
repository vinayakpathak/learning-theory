---
type: implication
id: multiclass-efficient-realizable-proper-pac__implies__multiclass-sample-efficient-realizable-proper-pac
source: multiclass-efficient-realizable-proper-pac
target: multiclass-sample-efficient-realizable-proper-pac
source_note: "[[multiclass-efficient-realizable-proper-pac|Multiclass Efficient Realizable Proper PAC Learning]]"
target_note: "[[multiclass-sample-efficient-realizable-proper-pac|Multiclass Sample-Efficient Realizable Proper PAC Learning]]"
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

# Multiclass Efficient Realizable Proper PAC Learning $\Rightarrow$ Multiclass Sample-Efficient Realizable Proper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `computationally-efficient-to-sample-efficient`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `same`
- `properness`: `same`
