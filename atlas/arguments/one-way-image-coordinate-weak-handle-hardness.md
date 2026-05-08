---
type: argument
id: one-way-image-coordinate-weak-handle-hardness
title: One-Way Image Coordinate Weak-Handle Hardness
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - one-way-image-coordinate-weak-handle-class
witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
assumptions:
  - length-preserving one-way functions exist
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# One-Way Image Coordinate Weak-Handle Hardness

## Verdict

`false`, under the assumption that length-preserving one-way functions exist.

Adding constants and bounded positive-atom handle concepts to the one-way image-coordinate class makes weak proper learning easy, while strong proper learning under the fixed coordinate marginal still inverts the one-way function. Singleton handles are enough for inverse-polynomial weak realizable variants; bounded subset handles give a fixed additive weak agnostic tolerance.

## Theorem Statement

Assuming length-preserving one-way functions exist, there is a binary concept class obtained from the one-way image-coordinate construction by adding constants and bounded positive-atom handle concepts with the following two properties. First, the class has polynomial-time proper weak learners: in the realizable case a proper hypothesis can achieve error at most $1/2-1/\operatorname{poly}(s)$, and in the agnostic case a proper hypothesis can achieve error at most $\operatorname{OPT}_{\mathcal C}+1/2-\Omega(1)$. Second, the class has no polynomial-time strong proper learner whose polynomial resource bound is allowed to depend on the instance marginal. For one fixed marginal distribution, any proper learner achieving sufficiently small strong realizable error would recover a preimage of a one-way-function challenge with nonnegligible probability.

## Proof Sketch

For a length-$n$ image-coordinate target, let $M$ be the marginal mass of its positive set. The all-zero concept has error $M$ and the all-one concept has error $1-M$. A singleton on a heaviest positive atom has error at most $M(1-1/n)$, giving an inverse-polynomial weak edge. For fixed-additive weak agnostic sources, allow bounded subset handles: a handle containing the heaviest $\lfloor n/4\rfloor$ positive atoms has error at most $3M/4$, so the best of all-zero, all-one, and this handle has error at most $3/7<1/2$. Samples and validation find the best empirical bounded handle in polynomial time.

For strong proper hardness, use the fixed marginal with mass $\mu_k=6/(\pi^2k^2)$ on the length-$k$ block. Accuracy $\mu_n/(3n)$ against a length-$n$ image-coordinate target excludes the added handles and forces a seed hypothesis with the same image. A strong proper learner would therefore invert a length-preserving one-way function.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
