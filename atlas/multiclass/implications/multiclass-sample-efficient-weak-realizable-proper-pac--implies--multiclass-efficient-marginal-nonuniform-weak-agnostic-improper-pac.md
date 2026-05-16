---
type: implication
id: multiclass-sample-efficient-weak-realizable-proper-pac__implies__multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: multiclass-sample-efficient-weak-realizable-proper-pac
target: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[multiclass-sample-efficient-weak-realizable-proper-pac|Multiclass Sample-Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: known
assumptions:
- standard cryptographic assumptions
witnesses:
- multiclass-pseudorandom-function-classes
ref_keys:
- goldreich1986
- kearns1994cryptographic
refs:
- "[goldreich1986](https://doi.org/10.1145/6490.6503)"
- "[kearns1994cryptographic](https://doi.org/10.1145/174644.174647)"
summary: Binary pseudorandom-function separations embed into multiclass classification by using two labels and ignoring the rest.
family: multiclass-sample-to-computational-hardness
axis_delta:
  resource: sample-efficient-to-computationally-efficient
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[multiclass-sample-to-computational-hardness|Sample-to-Computational Hardness]]"
witness_note: "[[multiclass-pseudorandom-function-classes|Pseudorandom Function Classes]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Sample-Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-pseudorandom-function-classes|Pseudorandom Function Classes]] satisfies the source while failing the target under standard cryptographic assumptions.

## Axis Delta

- `resource`: `sample-efficient-to-computationally-efficient`
- `distribution`: `distribution-free-to-marginal-nonuniform`
- `strength`: `same`
- `realizability`: `realizable-to-agnostic`
- `properness`: `proper-to-improper`


## References

- [goldreich1986](https://doi.org/10.1145/6490.6503)
- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
