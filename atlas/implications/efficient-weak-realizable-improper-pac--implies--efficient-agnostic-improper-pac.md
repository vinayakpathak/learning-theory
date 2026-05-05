---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-agnostic-improper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
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
summary: "Halfspaces are weakly realizably improperly learnable, but strong improper agnostic learning is hard under worst-case lattice assumptions."
family: halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness.

Halfspaces are weakly realizably improperly learnable, but strong improper agnostic learning is hard under worst-case lattice assumptions.

## Proof Sketch

**Goal.** Refute the implication under worst-case lattice hardness assumptions.

**Construction.** Use halfspaces. They are efficiently realizably properly learnable, hence also weakly realizably improperly learnable.

**Why the target fails.** Tiegel rules out efficient distribution-free improper agnostic learning of halfspaces under worst-case lattice assumptions.

**Conclusion.** The source node holds for halfspaces, while the target node fails under the stated assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
