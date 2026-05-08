---
type: implication
id: sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__sample-efficient-marginal-nonuniform-realizable-proper-pac
source: sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: sample-efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "known"
assumptions: []
witnesses: []
ref_keys:
  - valiant1984
  - blumer1989
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - freund1995boosting
  - bendavid2001
  - kalai2008agnosticboosting
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
summary: "Ignoring runtime, VC/ERM sample-complexity equivalences give the strong target; boosting supplies the weak-to-strong reference point."
family: sample-complexity-equivalence
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[sample-complexity-equivalence|Sample-Complexity Equivalence]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`true`, by the sample-complexity theorem recorded in [[sample-complexity-equivalence|Sample-Complexity Equivalence]].

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size is bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$. No polynomial running-time bound is required.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size is bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$. No polynomial running-time bound is required.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Show that the source guarantee is enough for [[sample-efficient-marginal-nonuniform-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning]] once polynomial running time is not required.

**Weak-to-strong route.** The source gives a polynomial weak sample guarantee, meaning accuracy bounded away from random guessing. Classical boosting, such as Freund's boost-by-majority, is the algorithmic weak-to-strong conversion in the realizable case. For this sample-only implication, the safer route is the finite-sample characterization: a binary class that is weakly learnable with polynomial samples has the same finite-dimensional sample control needed for strong PAC learning, and runtime is unrestricted.

**Agnostic conversion.** If the source is weak agnostic, restrict it to realizable distributions: then $\inf_{c\in\mathcal C}\operatorname{err}(c)=0$, so the fixed tolerance $\beta<1/2$ gives a weak realizable guarantee. If the target is agnostic, use the finite-dimensional sample control obtained above to run exhaustive empirical risk minimization over $\mathcal C$; uniform convergence gives $\operatorname{err}(h)\le\inf_{c\in\mathcal C}\operatorname{err}(c)+\varepsilon$. This is the sample-complexity counterpart of agnostic boosting, but it does not claim an efficient black-box conversion for the atlas's fixed-additive weak agnostic learner.

**Distribution bookkeeping.** If the target is marginal-nonuniform, a distribution-free sample bound can be read marginal-by-marginal. If a marginal-nonuniform source must imply a distribution-free target, Hanneke, Moran, and Thiessen's trichotomy supplies the extra step: polynomial marginal-dependent weak rates force finite VC dimension, after which standard distribution-free VC bounds apply. If both source and target are marginal-nonuniform, the same fixed-marginal sample-complexity reasoning is applied with the polynomial allowed to depend on that marginal.

**Why the target follows.** With finite sample control in hand, standard VC and fixed-marginal uniform-convergence bounds give the requested strong realizable or agnostic guarantee. Because runtime is unrestricted, the learner may choose an empirical risk minimizer in $\mathcal C$; that handles proper targets, and improper targets may use the same proper hypothesis.

**Conclusion.** The implication is true as a sample-complexity statement. It should not be read as giving a polynomial-time algorithm.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
