---
type: implication
id: efficient-realizable-proper-pac__implies__efficient-agnostic-improper-pac
source: efficient-realizable-proper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
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
summary: "Halfspaces are efficiently realizably properly learnable, but distribution-free improper agnostic learning of halfspaces is hard under worst-case lattice assumptions."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Proper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness assumptions.

Halfspaces are efficiently learnable in the realizable proper setting, but Tiegel proves hardness for distribution-free agnostic learning of halfspaces even with improper hypotheses.

## Proof Sketch

**Goal.** Refute the universal implication under worst-case lattice hardness assumptions. It is enough to exhibit a class that is efficiently realizably properly learnable but not efficiently agnostically improperly learnable.

**Construction.** Take $\mathcal C$ to be the class of Boolean halfspaces over $\mathbb R^d$, represented by a weight vector and threshold.

**Why the source property holds.** In the realizable proper PAC problem, every labeled sample is assumed to be consistent with some halfspace. A learner can find a consistent halfspace by solving the corresponding linear feasibility problem:

$$
y_i(\langle w,x_i\rangle-\theta)>0
$$

for all labeled examples $(x_i,y_i)$. Standard linear programming gives a polynomial-time procedure in the usual finite-bit representation model. Together with the VC bound for halfspaces, this gives efficient realizable proper PAC learning.

**Why the target property fails.** Tiegel constructs, from worst-case lattice problems, distribution-free agnostic halfspace instances with an inverse-polynomial error gap: in the yes case, some halfspace has small error, while in the no case no efficient improper learner can output a hypothesis whose error is within the required agnostic tolerance. Thus an efficient improper agnostic learner for halfspaces would distinguish the lattice instances and violate the assumed lattice hardness.

**Conclusion.** Halfspaces satisfy the source node but fail the target node under the stated assumption. Therefore efficient realizable proper PAC learning does not imply efficient agnostic improper PAC learning under worst-case lattice hardness assumptions.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
