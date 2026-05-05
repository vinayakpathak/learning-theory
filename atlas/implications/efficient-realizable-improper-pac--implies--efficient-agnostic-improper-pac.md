---
type: implication
id: efficient-realizable-improper-pac__implies__efficient-agnostic-improper-pac
source: efficient-realizable-improper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
target_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "known"
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
ref_keys:
  - tiegel2023
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Halfspaces are efficiently realizably learnable and therefore realizably improperly learnable, but improper agnostic learning is hard under worst-case lattice assumptions."
family: halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness assumptions.

Halfspaces witness the separation: realizable proper learnability implies realizable improper learnability, while Tiegel rules out distribution-free improper agnostic learning under worst-case lattice assumptions.

## Proof Sketch

**Goal.** Refute the universal implication under worst-case lattice hardness assumptions. It is enough to exhibit a class that is efficiently realizably improperly learnable but not efficiently agnostically improperly learnable.

**Construction.** Take $\mathcal C$ to be the class of Boolean halfspaces over $\mathbb R^d$.

**Why the source property holds.** Halfspaces are efficiently realizably properly learnable: on a realizable sample, linear programming can find a separating halfspace in polynomial time, and the VC dimension of halfspaces gives polynomial sample complexity. Since every proper learner is also an allowed improper learner, halfspaces are also efficiently realizably improperly learnable.

**Why the target property fails.** Tiegel proves that distribution-free agnostic learning of halfspaces is computationally hard even for improper learners, assuming worst-case lattice hardness. The reduction gives halfspace learning instances with a promise gap between the error of the best halfspace and the error achievable by any efficient learner. An efficient improper agnostic learner would close this gap and solve the underlying lattice problem.

**Conclusion.** Halfspaces satisfy the source node but fail the target node under the stated assumption. Thus efficient realizable improper PAC learning does not imply efficient agnostic improper PAC learning under worst-case lattice hardness assumptions.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
