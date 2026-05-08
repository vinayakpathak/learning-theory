---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-proper-pac__implies__efficient-marginal-nonuniform-agnostic-improper-pac
source: efficient-marginal-nonuniform-weak-agnostic-proper-pac
target: efficient-marginal-nonuniform-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "known"
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
witness_note: "[[halfspaces|Halfspaces]]"
ref_keys:
  - tiegel2023
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "False under worst-case lattice hardness: halfspaces satisfy the proper weak marginal-nonuniform agnostic source via low-noise robustification, but Tiegel's standard-Gaussian hardness rules out the strong marginal-nonuniform agnostic improper target."
family: halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: proper-to-improper
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness.

Use Boolean halfspaces. They satisfy the proper weak marginal-nonuniform agnostic source, but Tiegel's standard-Gaussian distribution-specific hardness rules out the strong marginal-nonuniform agnostic improper target.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

Assuming the worst-case lattice hardness assumption used in Tiegel's halfspace lower bound, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate weak marginal-nonuniform agnostic proper learning from strong marginal-nonuniform agnostic improper learning.

**Why the source holds.** Halfspaces are efficiently realizably properly PAC learnable by linear feasibility plus VC generalization, and constant classifiers are proper halfspaces. The low-noise weak agnostic robustification can therefore be made proper for this witness. Constants handle the regime where the best halfspace error is already at least an inverse-polynomial threshold; in the low-noise regime, repeated runs of the realizable proper learner on small batches find a proper halfspace with nontrivial advantage, and validation selects one. Thus halfspaces satisfy the source.

**Why the target fails.** Tiegel proves, under worst-case lattice hardness, distribution-specific hardness for agnostically learning halfspaces under the standard Gaussian marginal. In the atlas formulation, for every constant $\rho>0$, learning to error $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$ under this fixed marginal requires time $d^{\widetilde{\Omega}(1/\varepsilon^{2-\rho})}$. This is not polynomial in $(d,1/\varepsilon)$, contradicting the target node even though the target permits improper output.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
