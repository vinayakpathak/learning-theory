---
type: witness
id: one-way-image-coordinate-class
title: One-Way Image Coordinate Class
domain: binary-classification
model: pac
assumptions:
  - length-preserving one-way functions exist
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# One-Way Image Coordinate Class

## Role

This witness separates improper prediction from proper representation recovery. Assuming a length-preserving one-way function $f:\{0,1\}^n\to\{0,1\}^n$, concepts are indexed by seeds $s$ and expose the bits of $f(s)$ as easy coordinate labels. An improper learner can memorize the positive coordinates that appear in the sample, so the class is efficiently distribution-free realizably learnable improperly. A sparse lookup-table ERM also gives agnostic improper learning, since the class of hypotheses with at most $n$ positive atoms has VC dimension $n$ and contains the proper length-$n$ concepts.

Proper hypotheses, however, must output a seed. Under a fixed marginal that puts inverse-polynomial mass on the length-$n$ coordinate block, sufficiently accurate proper learning must recover some $t$ with $f(t)=f(s)$. A marginal-nonuniform proper learner for this fixed marginal would therefore invert $f$ in polynomial time.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
