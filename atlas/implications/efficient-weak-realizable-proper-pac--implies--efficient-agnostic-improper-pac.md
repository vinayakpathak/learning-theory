---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-agnostic-improper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
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
summary: "Halfspaces are weakly realizably properly learnable, but strong improper agnostic learning is hard under worst-case lattice assumptions."
family: halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness.

Halfspaces are weakly realizably properly learnable, but strong improper agnostic learning is hard under worst-case lattice assumptions.

## Proof Sketch

**Goal.** Refute the implication under worst-case lattice hardness assumptions.

**Construction.** Use halfspaces. Realizable proper learning of halfspaces is efficient by linear programming, hence halfspaces satisfy the weaker source node.

**Why the target fails.** Tiegel proves hardness of distribution-free improper agnostic learning of halfspaces under worst-case lattice assumptions.

**Conclusion.** The source node holds for halfspaces, while the target node fails under the stated assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
