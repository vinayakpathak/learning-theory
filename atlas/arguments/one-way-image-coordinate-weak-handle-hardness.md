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

Adding constants and singleton concepts to the one-way image-coordinate class makes weak proper realizable learning easy, but strong proper learning under the fixed coordinate marginal still inverts the one-way function.

## Proof Sketch

For a length-$n$ image-coordinate target, let $M$ be the marginal mass of its positive set. The all-zero concept has error $M$, the all-one concept has error $1-M$, and a singleton on a heaviest positive atom has error at most $M(1-1/n)$. The best of these proper handles has error at most $1/2-\Omega(1/n)$. Samples and validation find such a handle in polynomial time; the handle targets themselves are weakly learnable by the same constants-or-singleton strategy.

For strong proper hardness, use the fixed marginal with mass $\mu_k=6/(\pi^2k^2)$ on the length-$k$ block. Accuracy $\mu_n/(3n)$ against a length-$n$ image-coordinate target excludes the added handles and forces a seed hypothesis with the same image. A strong proper learner would therefore invert a length-preserving one-way function.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
