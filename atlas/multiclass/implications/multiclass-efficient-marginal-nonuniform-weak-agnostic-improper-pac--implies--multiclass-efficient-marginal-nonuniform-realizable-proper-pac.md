---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__multiclass-efficient-marginal-nonuniform-realizable-proper-pac
source: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: multiclass-efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-realizable-proper-pac|Multiclass Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: unclear
assumptions:
- length-preserving one-way functions exist
witnesses:
- multiclass-one-way-image-coordinate-class
witness_note: "[[multiclass-one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
ref_keys:
- kearns1994cryptographic
- hastad1999prg
refs:
- "[kearns1994cryptographic](https://doi.org/10.1145/174644.174647)"
- "[hastad1999prg](https://doi.org/10.1137/S0097539793244708)"
summary: 'False under one-way functions: image-coordinate concepts are distribution-free agnostically learnable by improper sparse ERM, hence satisfy the weak marginal-nonuniform agnostic improper source, but fixed-marginal realizable proper learning would invert the one-way function.'
family: multiclass-one-way-image-coordinate-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[multiclass-one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-one-way-image-coordinate-class|One Way Image Coordinate Class]] satisfies the source while failing the target under length-preserving one-way functions exist.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `weak-to-strong`
- `realizability`: `agnostic-to-realizable`
- `properness`: `improper-to-proper`


## References

- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
- [hastad1999prg](https://doi.org/10.1137/S0097539793244708)
