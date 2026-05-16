---
type: implication
id: multiclass-efficient-realizable-proper-pac__implies__multiclass-efficient-agnostic-improper-pac
source: multiclass-efficient-realizable-proper-pac
target: multiclass-efficient-agnostic-improper-pac
source_note: "[[multiclass-efficient-realizable-proper-pac|Multiclass Efficient Realizable Proper PAC Learning]]"
target_note: "[[multiclass-efficient-agnostic-improper-pac|Multiclass Efficient Agnostic Improper PAC Learning]]"
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
summary: Halfspaces are efficiently realizably properly learnable, but distribution-free improper agnostic learning of halfspaces is hard under worst-case lattice assumptions.
family: multiclass-halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[multiclass-halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[multiclass-halfspaces|Halfspaces]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Agnostic Improper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-halfspaces|Halfspaces]] satisfies the source while failing the target under worst-case lattice hardness.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `realizable-to-agnostic`
- `properness`: `proper-to-improper`


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
