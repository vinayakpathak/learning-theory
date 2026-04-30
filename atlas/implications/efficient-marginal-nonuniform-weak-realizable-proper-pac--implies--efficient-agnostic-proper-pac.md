---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__efficient-agnostic-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-proper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
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
summary: "Halfspaces satisfy the source, but fail the distribution-free agnostic target under worst-case lattice assumptions."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`false`, under worst-case lattice hardness.

Halfspaces satisfy the source, but fail the distribution-free agnostic target under worst-case lattice assumptions.

## Counterexample

**Goal.** Refute the implication with a class satisfying the source but not the distribution-free agnostic target.

**Construction.** Use Boolean halfspaces. Halfspaces are efficiently realizably properly PAC learnable by linear feasibility and VC generalization. Therefore they satisfy every realizable source node here, including marginal-nonuniform and improper weakenings.

**Why the target fails.** Tiegel proves that distribution-free agnostic learning of halfspaces is hard even for improper hypotheses under worst-case lattice assumptions. This rules out the agnostic target, and it also rules out the proper target when properness is required.

**Conclusion.** The source can hold while the target fails under the stated hardness assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
