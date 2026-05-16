---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__multiclass-efficient-agnostic-improper-pac
source: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: multiclass-efficient-agnostic-improper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-efficient-agnostic-improper-pac|Multiclass Efficient Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: open
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
- tiegel2023
refs:
- "[tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: 'Open: halfspace hardness gives the agnostic target obstruction, but the multiclass atlas has no fixed-gap marginal weak agnostic source proof for halfspaces.'
family: multiclass-marginal-weak-agnostic-open
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[multiclass-marginal-weak-agnostic-open|Marginal Weak Agnostic Open]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Agnostic Improper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-marginal-weak-agnostic-open|Marginal Weak Agnostic Open]].

## Axis Delta

- `resource`: `same`
- `distribution`: `marginal-nonuniform-to-distribution-free`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `same`


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
