---
type: argument
id: sample-to-computational-hardness
title: Sample-to-Computational Hardness
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - pseudorandom-function-classes
witness_note: "[[pseudorandom-function-classes|Pseudorandom Function Classes]]"
assumptions:
  - standard cryptographic assumptions
ref_keys:
  - goldreich1986
  - kearns1994cryptographic
refs:
  - "[Goldreich et al. 1986](https://doi.org/10.1145/6490.6503)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Sample-to-Computational Hardness

## Verdict

`false`, under standard cryptographic assumptions.

The purpose of the new resource axis is to separate information-theoretic sample bounds from polynomial-time algorithms. A finite keyed concept family has VC dimension at most logarithmic in its size, so an unbounded empirical-risk search gives sample-efficient proper agnostic learning. Cryptographic pseudorandomness can still rule out any randomized polynomial-time learner with even a weak realizable guarantee under the hard marginal distribution.

Consequently, a sample-efficient source node does not imply a computationally efficient target node, even when the target is weaker along the realizability, strength, properness, or distribution axes.

## References

- [Goldreich et al. 1986](https://doi.org/10.1145/6490.6503)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
