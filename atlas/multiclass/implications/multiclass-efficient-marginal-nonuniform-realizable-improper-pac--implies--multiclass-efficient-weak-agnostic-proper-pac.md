---
type: implication
id: multiclass-efficient-marginal-nonuniform-realizable-improper-pac__implies__multiclass-efficient-weak-agnostic-proper-pac
source: multiclass-efficient-marginal-nonuniform-realizable-improper-pac
target: multiclass-efficient-weak-agnostic-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-realizable-improper-pac|Multiclass Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[multiclass-efficient-weak-agnostic-proper-pac|Multiclass Efficient Weak Agnostic Proper PAC Learning]]"
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
summary: Halfspaces satisfy the source, but fail weak agnostic learning even with improper hypotheses, so they also fail the proper target.
family: multiclass-halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: improper-to-proper
argument_note: "[[multiclass-halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[multiclass-halfspaces|Halfspaces]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Multiclass Efficient Weak Agnostic Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-halfspaces|Halfspaces]] satisfies the source while failing the target under worst-case lattice hardness.

## Axis Delta

- `resource`: `same`
- `distribution`: `marginal-nonuniform-to-distribution-free`
- `strength`: `strong-to-weak`
- `realizability`: `realizable-to-agnostic`
- `properness`: `improper-to-proper`


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
