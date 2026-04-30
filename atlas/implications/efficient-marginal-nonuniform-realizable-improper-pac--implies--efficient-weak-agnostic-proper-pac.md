---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
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
summary: "Halfspaces satisfy the source, but fail weak agnostic learning even with improper hypotheses, so they also fail the proper target."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`false`, under worst-case lattice hardness assumptions.

Halfspaces satisfy the source, but fail weak agnostic learning even with improper hypotheses, so they also fail the proper target.

## Counterexample

**Goal.** Refute the implication by using a class with easy realizable learning and hard weak agnostic learning.

**Construction.** Use Boolean halfspaces.

**Why the source property holds.** Realizable proper learning of halfspaces is efficient; hence the marginal-nonuniform realizable improper source holds.

**Why the target fails.** Tiegel rules out efficient weak agnostic learning of halfspaces even when the learner may output improper hypotheses. A weak agnostic proper learner would be a special case, so it is also ruled out.

**Conclusion.** The implication fails under the stated hardness assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
