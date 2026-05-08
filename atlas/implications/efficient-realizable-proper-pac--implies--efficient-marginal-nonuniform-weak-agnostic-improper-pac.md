---
type: implication
id: efficient-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "unclear"
assumptions: []
witnesses: []
ref_keys:
  - valiant1984
  - blumer1989
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: "A distribution-free realizable proper learner can be robustified into an improper weak agnostic learner with an inverse-polynomial marginal-nonuniform gap."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`.

A distribution-free realizable proper learner can be turned into an improper weak agnostic learner with an inverse-polynomial gap. This is stronger than needed for the marginal-nonuniform target.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. There is one polynomial $p$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Status

**Goal.** Build a weak agnostic learner from a distribution-free realizable learner.

**Construction.** Run the realizable learner repeatedly on small fresh batches, pretending the labels are realizable, and validate the resulting hypotheses together with the two constant classifiers. If $\operatorname{OPT}_{\mathcal C}$ is at least the chosen inverse-polynomial gap $\alpha(s)$, a constant classifier already satisfies the weak agnostic target. If $\operatorname{OPT}_{\mathcal C}<\alpha(s)$, then with inverse-polynomial probability a small batch is entirely consistent with a best concept $c^\star$, so the realizable learner sees a clean sample from a conditional marginal. Because the source learner is distribution-free, its same polynomial bound applies to that conditional marginal.

**Why validation works.** The clean conditional marginal differs from the original marginal by $O(\operatorname{OPT}_{\mathcal C})$ in total variation. Thus a hypothesis with a weak advantage on the clean conditional distribution keeps an inverse-polynomial weak advantage on the original agnostic distribution. A polynomial validation sample selects such a candidate with high probability.

**Conclusion.** This proves the target with an improper output. The argument would not automatically apply from a merely marginal-nonuniform realizable source, because the clean conditional marginal might have its own unrelated polynomial.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
