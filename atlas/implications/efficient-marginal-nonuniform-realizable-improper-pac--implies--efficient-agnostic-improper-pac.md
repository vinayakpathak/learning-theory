---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-agnostic-improper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
ref_keys:
  - tiegel2023
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Halfspaces satisfy the marginal-nonuniform realizable source, but improper agnostic learning of halfspaces is hard under worst-case lattice assumptions."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness assumptions.

Halfspaces satisfy the marginal-nonuniform realizable source, but improper agnostic learning of halfspaces is hard under worst-case lattice assumptions.

## Counterexample

**Goal.** Refute the implication by finding a class satisfying the source but not the agnostic improper target.

**Construction.** Let $\mathcal C$ be the class of Boolean halfspaces.

**Why the source property holds.** Halfspaces are efficiently realizably properly PAC learnable by solving a linear feasibility problem on a realizable sample and applying the VC bound. Proper distribution-free realizable learning implies improper marginal-nonuniform realizable learning.

**Why the target fails.** Tiegel proves that distribution-free improper agnostic learning of halfspaces is hard under worst-case lattice assumptions. Therefore no efficient agnostic improper learner exists for this class under the stated assumption.

**Conclusion.** The source can hold while the target fails.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
