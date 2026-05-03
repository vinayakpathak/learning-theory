---
type: witness
id: pseudorandom-function-classes
title: Pseudorandom Function Classes
domain: binary-classification
model: pac
assumptions:
  - standard cryptographic assumptions
ref_keys:
  - goldreich1986
  - kearns1994cryptographic
refs:
  - "[Goldreich et al. 1986](https://doi.org/10.1145/6490.6503)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# Pseudorandom Function Classes

## Role

This witness separates sample-efficient learning from computationally efficient learning. A keyed family with polynomial key length has finite VC dimension, so unbounded empirical risk minimization gives proper agnostic sample-efficient PAC learning. Under standard cryptographic assumptions, however, no randomized polynomial-time learner can even weakly learn the family on the hard marginal distribution; such a learner would distinguish pseudorandom functions from random labelings.

Thus the class satisfies every sample-efficient source node in this binary PAC atlas but fails every computationally efficient target node.

## References

- [Goldreich et al. 1986](https://doi.org/10.1145/6490.6503)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
