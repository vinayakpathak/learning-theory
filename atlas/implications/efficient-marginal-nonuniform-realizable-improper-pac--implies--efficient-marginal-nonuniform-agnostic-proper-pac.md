---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-marginal-nonuniform-agnostic-proper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-marginal-nonuniform-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
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
summary: "Halfspaces satisfy the realizable source, but Tiegel's standard-Gaussian distribution-specific hardness rules out the marginal-nonuniform strong agnostic proper target under worst-case lattice assumptions."
family: halfspace-agnostic-hardness
axis_delta:
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: improper-to-proper
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Proper PAC Learning

## Verdict

`false`, under worst-case lattice hardness assumptions.

Halfspaces satisfy the realizable source, but Tiegel's standard-Gaussian distribution-specific hardness rules out the marginal-nonuniform strong agnostic proper target under worst-case lattice assumptions.

## Counterexample

**Goal.** Refute the implication by finding a class that satisfies the realizable source but fails the marginal-nonuniform strong agnostic target.

**Construction.** Use Boolean halfspaces, with the standard Gaussian marginal distribution in each dimension for the hard agnostic instances.

**Why the source property holds.** Halfspaces are efficiently realizably properly PAC learnable by solving the linear feasibility problem on a realizable sample and applying the VC generalization bound. Therefore halfspaces satisfy every realizable source node in this edge, including weak, improper, and marginal-nonuniform weakenings.

**Why the target property fails.** Tiegel proves a distribution-specific lower bound for agnostically learning halfspaces under the standard Gaussian marginal: under worst-case lattice hardness, learning to error $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$ requires time $d^{\widetilde{\Omega}(1/\varepsilon^{2-\beta})}$ for every constant $\beta>0$. This is not polynomial in $d$ and $1/\varepsilon$, even when the marginal is fixed to the standard Gaussian family. Since the marginal-nonuniform target still requires a polynomial bound for that fixed marginal, the target fails.

A proper agnostic learner would be a special case of an improper agnostic learner, so the same lower bound rules out the proper target as well.

**Conclusion.** The source can hold while the marginal-nonuniform strong agnostic target fails under the stated hardness assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
