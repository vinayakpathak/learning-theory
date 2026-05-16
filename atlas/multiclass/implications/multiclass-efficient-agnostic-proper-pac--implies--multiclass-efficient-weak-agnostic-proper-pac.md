---
type: implication
id: multiclass-efficient-agnostic-proper-pac__implies__multiclass-efficient-weak-agnostic-proper-pac
source: multiclass-efficient-agnostic-proper-pac
target: multiclass-efficient-weak-agnostic-proper-pac
source_note: "[[multiclass-efficient-agnostic-proper-pac|Multiclass Efficient Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-efficient-weak-agnostic-proper-pac|Multiclass Efficient Weak Agnostic Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
result_origin: known
assumptions: []
witnesses: []
refs: []
summary: 'This follows by weakening one or more requirements: agnostic to realizable, proper to improper, or strong to weak.'
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

# Multiclass Efficient Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Efficient Weak Agnostic Proper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `strong-to-weak`
- `realizability`: `same`
- `properness`: `same`
