---
type: implication
id: multiclass-efficient-weak-agnostic-proper-pac__implies__multiclass-efficient-marginal-nonuniform-realizable-proper-pac
source: multiclass-efficient-weak-agnostic-proper-pac
target: multiclass-efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[multiclass-efficient-weak-agnostic-proper-pac|Multiclass Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-realizable-proper-pac|Multiclass Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: unclear
assumptions:
- length-preserving one-way functions exist
witnesses:
- multiclass-one-way-image-coordinate-weak-handle-class
ref_keys:
- kearns1994cryptographic
- hastad1999prg
refs:
- "[kearns1994cryptographic](https://doi.org/10.1145/174644.174647)"
- "[hastad1999prg](https://doi.org/10.1137/S0097539793244708)"
summary: 'False under one-way functions: bounded proper handles give distribution-free weak agnostic proper learning, but fixed-marginal strong realizable proper learning would recover a one-way preimage.'
family: multiclass-one-way-image-coordinate-weak-handle-hardness
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[multiclass-one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]"
witness_note: "[[multiclass-one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-one-way-image-coordinate-weak-handle-class|One Way Image Coordinate Weak Handle Class]] satisfies the source while failing the target under length-preserving one-way functions exist.

## Axis Delta

- `resource`: `same`
- `distribution`: `distribution-free-to-marginal-nonuniform`
- `strength`: `weak-to-strong`
- `realizability`: `agnostic-to-realizable`
- `properness`: `same`


## References

- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
- [hastad1999prg](https://doi.org/10.1137/S0097539793244708)
