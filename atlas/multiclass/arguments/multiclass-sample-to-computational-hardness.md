---
type: argument
id: multiclass-sample-to-computational-hardness
title: Multiclass Sample-to-Computational Hardness
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
witnesses:
- multiclass-pseudorandom-function-classes
witness_note: "[[multiclass-pseudorandom-function-classes|Pseudorandom Function Classes]]"
assumptions:
- standard cryptographic assumptions
ref_keys:
- goldreich1986
- kearns1994cryptographic
refs:
- "[goldreich1986](https://doi.org/10.1145/6490.6503)"
- "[kearns1994cryptographic](https://doi.org/10.1145/174644.174647)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Sample-to-Computational Hardness

## Verdict

`false`, with evidence `conditional-counterexample`.

Any binary cryptographic hard class can be viewed as a multiclass class by using two labels in a larger finite alphabet. A polynomial-time multiclass learner would restrict to a polynomial-time learner for the embedded binary class.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [goldreich1986](https://doi.org/10.1145/6490.6503)
- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
