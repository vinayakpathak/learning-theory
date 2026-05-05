---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-weak-handle-class
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: weak handles give marginal-nonuniform weak proper learning, but fixed-marginal strong proper learning would invert the one-way function."
family: one-way-image-coordinate-weak-handle-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]"
witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

Adding proper weak handles to the one-way image-coordinate class gives marginal-nonuniform weak proper learning, but strong proper learning under the fixed coordinate marginal would invert the one-way function.

## Proof Status

Use the [[one-way-image-coordinate-weak-handle-class|one-way image-coordinate weak-handle class]]. It consists of the image-coordinate seed concepts, the two constants, and every singleton-positive-atom concept.

**Weak source.** For a length-$n$ image-coordinate target, let $M$ be the positive mass. The all-zero concept has error $M$, the all-one concept has error $1-M$, and a singleton on a heaviest positive atom has error at most $M(1-1/n)$. The best of these handles has error at most $1/2-\Omega(1/n)$. Samples and validation find such a handle in polynomial time. The constant and singleton targets are weakly learnable by the same strategy.

**Strong target failure.** Under the fixed coordinate marginal with length-$n$ mass $\mu_n=6/(\pi^2n^2)$, accuracy $\mu_n/(3n)$ against a length-$n$ image-coordinate target excludes all added handles and forces a seed hypothesis with the same one-way image. A strong marginal-nonuniform proper learner would therefore invert a length-preserving one-way function.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
