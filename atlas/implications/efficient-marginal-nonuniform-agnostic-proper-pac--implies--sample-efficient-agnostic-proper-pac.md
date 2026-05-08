---
type: implication
id: efficient-marginal-nonuniform-agnostic-proper-pac__implies__sample-efficient-agnostic-proper-pac
source: efficient-marginal-nonuniform-agnostic-proper-pac
target: sample-efficient-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
target_note: "[[sample-efficient-agnostic-proper-pac|Sample-Efficient Agnostic Proper PAC Learning]]"
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
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "True: polynomial marginal-nonuniform sample rates collapse to finite VC dimension, and VC theory gives the distribution-free sample-efficient target."
family: sample-complexity-equivalence
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: same
argument_note: "[[sample-complexity-equivalence|Sample-Complexity Equivalence]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Agnostic Proper PAC Learning $\Rightarrow$ Sample-Efficient Agnostic Proper PAC Learning

## Verdict

`true`, by the binary sample-complexity equivalence and the marginal-nonuniform trichotomy.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size is bounded by $p(s,1/\varepsilon,\log(1/\delta))$. No polynomial running-time bound is required.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Show that the source guarantee is enough for [[sample-efficient-agnostic-proper-pac|Sample-Efficient Agnostic Proper PAC Learning]] once polynomial running time is not required.

**Why the source gives sample control.** The source is a polynomial-rate marginal-nonuniform sample guarantee after ignoring any runtime requirement. In the sample-only binary setting, the usual VC/ERM equivalences convert among realizable, agnostic, weak, strong, proper, and improper variants.

**Why marginal nonuniformity uniformizes here.** Hanneke, Moran, and Thiessen's marginal-nonuniform trichotomy says that binary classes with finite VC dimension have linear marginal-nonuniform rates, while classes with infinite VC dimension require arbitrarily slow marginal-nonuniform rates. Therefore a polynomial marginal-nonuniform sample guarantee forces finite VC dimension.

**Why the target follows.** Standard VC theory gives distribution-free polynomial sample complexity for binary PAC learning when VC dimension is finite. Since runtime is unrestricted, exhaustive empirical risk minimization can be used to obtain the requested proper or improper target variant.

**Conclusion.** The implication is true as a sample-complexity statement. It should not be read as giving a polynomial-time learner.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
