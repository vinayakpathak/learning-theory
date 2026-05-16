---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__multiclass-efficient-marginal-nonuniform-agnostic-proper-pac
source: multiclass-efficient-marginal-nonuniform-weak-realizable-improper-pac
target: multiclass-efficient-marginal-nonuniform-agnostic-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-realizable-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-agnostic-proper-pac|Multiclass Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
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
summary: Halfspaces satisfy the realizable source, but Tiegel's standard-Gaussian distribution-specific hardness rules out the marginal-nonuniform strong agnostic proper target under worst-case lattice assumptions.
family: multiclass-halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: realizable-to-agnostic
  properness: improper-to-proper
argument_note: "[[multiclass-halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[multiclass-halfspaces|Halfspaces]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Agnostic Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-halfspaces|Halfspaces]] satisfies the source while failing the target under worst-case lattice hardness.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `weak-to-strong`
- `realizability`: `realizable-to-agnostic`
- `properness`: `improper-to-proper`


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
