---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
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
summary: "Halfspaces satisfy the source, but Tiegel rules out even weak agnostic improper learning under worst-case lattice assumptions."
family: halfspace-agnostic-hardness
axis_delta:
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness assumptions.

Halfspaces satisfy the source, but Tiegel rules out even weak agnostic improper learning under worst-case lattice assumptions.

## Counterexample

**Goal.** Refute the implication by exhibiting an easy realizable class that is hard even for weak agnostic improper learning.

**Construction.** Use Boolean halfspaces.

**Why the source property holds.** Halfspaces are efficiently realizably properly learnable by linear programming and VC generalization. This implies the marginal-nonuniform realizable improper source.

**Why the target fails.** Tiegel's halfspace hardness gives agnostic instances with a small optimum halfspace error but no efficient learner, even improper, achieving the fixed additive weak agnostic guarantee. Thus halfspaces fail the target under the stated assumption.

**Conclusion.** The implication is false under worst-case lattice hardness.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
