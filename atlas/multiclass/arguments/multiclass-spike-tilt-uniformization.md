---
type: argument
id: multiclass-spike-tilt-uniformization
title: Multiclass Spike-Tilt Uniformization
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
ref_keys:
- benedek1991fixed
- hanneke2025marginalnonuniform
refs:
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Spike-Tilt Uniformization

## Verdict

`true`, with evidence `theorem`.

The spike-tilt construction is stated for multiclass zero-one correctness, not for a literal binary product $c(x)h(x)$. Given a target multiclass concept $c$ and a candidate $h$, the binary correctness variable is $+1$ on the event $h(x)=c(x)$ and $-1$ otherwise. Tilting the marginal by this correctness event lets a marginal-nonuniform weak learner reveal a distribution-free weak gap.

Once the weak learner is distribution-free in this correctness sense, standard finite-label multiclass boosting can aggregate weak hypotheses into an improper strong learner whenever the target edge is realizable and improper.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
