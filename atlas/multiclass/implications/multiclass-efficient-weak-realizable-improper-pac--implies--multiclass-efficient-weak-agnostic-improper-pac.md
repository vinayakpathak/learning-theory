---
type: implication
id: multiclass-efficient-weak-realizable-improper-pac__implies__multiclass-efficient-weak-agnostic-improper-pac
source: multiclass-efficient-weak-realizable-improper-pac
target: multiclass-efficient-weak-agnostic-improper-pac
source_note: "[[multiclass-efficient-weak-realizable-improper-pac|Multiclass Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[multiclass-efficient-weak-agnostic-improper-pac|Multiclass Efficient Weak Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: known
assumptions:
- worst-case lattice hardness
witnesses:
- multiclass-halfspaces
ref_keys:
- tiegel2023
refs:
- "[tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: Halfspaces are efficiently realizably properly learnable, but Tiegel rules out weak agnostic learning even with arbitrary binary hypotheses under worst-case lattice hardness.
family: multiclass-halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[multiclass-halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[multiclass-halfspaces|Halfspaces]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Multiclass Efficient Weak Agnostic Improper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-halfspaces|Halfspaces]] satisfies the source while failing the target under worst-case lattice hardness.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `realizable-to-agnostic`
- `properness`: `same`


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
