---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-proper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-marginal-nonuniform-weak-agnostic-proper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
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
summary: "False under worst-case lattice hardness: halfspaces satisfy the marginal-nonuniform weak agnostic proper source via low-noise robustification, but Tiegel rules out distribution-free weak agnostic learning even with arbitrary binary hypotheses."
family: halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: same
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`false`, under worst-case lattice hardness.

Use Boolean halfspaces. They satisfy the marginal-nonuniform weak agnostic proper source, but Tiegel's hardness result rules out distribution-free weak agnostic learning even with arbitrary binary hypotheses, and hence rules out proper weak agnostic learning.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

Assuming the worst-case lattice hardness assumption used in Tiegel's halfspace lower bound, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate marginal-nonuniform weak agnostic proper learning from distribution-free weak agnostic proper learning.

**Why the source holds.** Halfspaces are efficiently realizably properly PAC learnable by linear feasibility and VC generalization, and constant classifiers are themselves halfspaces. The low-noise weak agnostic robustification can therefore be made proper: include the two constants, repeatedly run the realizable halfspace learner on small batches, and validate all candidate halfspaces. Constants handle the case where the optimum error is above the chosen inverse-polynomial weak gap; when the optimum is below that gap, a fresh batch is clean relative to a near-optimal halfspace with constant probability, and a separating halfspace from that batch gives a proper weak candidate. Thus halfspaces satisfy the marginal-nonuniform weak agnostic proper source, in fact with distribution-free resources and an inverse-polynomial gap.

**Why the target fails.** The target requires one fixed additive tolerance $\beta<1/2$. Let $a=1/2-\beta$. Tiegel proves, under worst-case lattice hardness, that no efficient algorithm outputting arbitrary binary hypotheses can achieve error below $1/2-\gamma$ on certain halfspace distributions even when the best halfspace error is at most $\delta$. Choose the hard parameters so that $\delta+\gamma<a$. A target learner would output a proper halfspace $h$ with

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+\beta
\le
\delta+\beta
<
1/2-\gamma,
$$

contradicting the lower bound. Since Tiegel rules out even improper binary outputs, it certainly rules out proper outputs.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
