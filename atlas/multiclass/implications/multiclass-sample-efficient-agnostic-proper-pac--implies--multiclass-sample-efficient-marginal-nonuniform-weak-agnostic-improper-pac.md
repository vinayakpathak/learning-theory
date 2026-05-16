---
type: implication
id: multiclass-sample-efficient-agnostic-proper-pac__implies__multiclass-sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: multiclass-sample-efficient-agnostic-proper-pac
target: multiclass-sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[multiclass-sample-efficient-agnostic-proper-pac|Multiclass Sample-Efficient Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
result_origin: known
assumptions: []
witnesses: []
refs: []
summary: 'The target only relaxes requirements already met by the source (distribution: distribution-free-to-marginal-nonuniform; strength: strong-to-weak; properness: proper-to-improper).'
family: multiclass-monotone-relaxation
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: strong-to-weak
  realizability: same
  properness: proper-to-improper
argument_note: "[[multiclass-monotone-relaxation|Monotone Relaxation]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Sample-Efficient Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, with evidence `trivial`.

The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.

## Axis Delta

- `resource`: `same`
- `distribution`: `distribution-free-to-marginal-nonuniform`
- `strength`: `strong-to-weak`
- `realizability`: `same`
- `properness`: `proper-to-improper`
