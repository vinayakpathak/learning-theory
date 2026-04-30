---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-agnostic-proper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
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
summary: "Halfspaces satisfy the source, but Tiegel's improper agnostic hardness also rules out proper agnostic learning."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`false`, under worst-case lattice hardness assumptions.

Halfspaces satisfy the source, but Tiegel's improper agnostic hardness also rules out proper agnostic learning.

## Counterexample

**Goal.** Refute the implication with a class that is easy in the source model and hard in the target model.

**Construction.** Use Boolean halfspaces.

**Why the source property holds.** Realizable proper learning of halfspaces is efficient by linear programming plus the VC generalization bound. This is stronger than the marginal-nonuniform realizable improper source.

**Why the target fails.** Tiegel rules out efficient distribution-free agnostic learning of halfspaces even when improper hypotheses are allowed. A proper agnostic learner is a special case of an improper agnostic learner, so it is ruled out as well.

**Conclusion.** The implication is false under the stated lattice-hardness assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
