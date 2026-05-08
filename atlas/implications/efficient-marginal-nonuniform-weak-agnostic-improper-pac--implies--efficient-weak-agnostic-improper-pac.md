---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__efficient-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: efficient-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
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
summary: "False under worst-case lattice hardness: halfspaces satisfy the marginal-nonuniform weak agnostic improper source via low-noise robustification from efficient realizable proper learning, but Tiegel rules out distribution-free weak agnostic improper learning with any fixed additive advantage."
family: halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: same
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness.

Boolean halfspaces satisfy the source, but Tiegel's lattice-based hardness rules out the distribution-free weak agnostic improper target.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

Assuming the worst-case lattice hardness assumption used in Tiegel's halfspace lower bound, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate marginal-nonuniform weak agnostic improper learning from distribution-free weak agnostic improper learning.

**Why the source holds.** Halfspaces are efficiently realizably properly PAC learnable by linear feasibility and VC generalization. The [[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]] argument turns this into an efficient marginal-nonuniform weak agnostic learner: in the low-OPT regime, a clean-transcript coupling with the realizable learner gives a weak predictor, while in the high-OPT regime a constant classifier gives the fixed-marginal weak fallback. The source is improper, so these hypotheses are allowed.

**Why the target fails.** The target would require one distribution-free polynomial-time learner and one fixed additive tolerance $\beta<1/2$, independent of the marginal. Let $a=1/2-\beta>0$.

Tiegel proves, under worst-case lattice hardness, that no efficient algorithm, even with improper output, achieves error below $1/2-\gamma$ on the hard halfspace distributions even though the best halfspace error is at most $\delta$. Choose the hard parameters so that $\delta+\gamma<a$. A target learner would return $h$ with

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+\beta
\le
\delta+\beta
<
1/2-\gamma,
$$

contradicting the hardness result.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
