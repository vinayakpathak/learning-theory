---
type: implication
id: sample-efficient-weak-agnostic-improper-pac__implies__sample-efficient-weak-realizable-proper-pac
source: sample-efficient-weak-agnostic-improper-pac
target: sample-efficient-weak-realizable-proper-pac
source_note: "[[sample-efficient-weak-agnostic-improper-pac|Sample-Efficient Weak Agnostic Improper PAC Learning]]"
target_note: "[[sample-efficient-weak-realizable-proper-pac|Sample-Efficient Weak Realizable Proper PAC Learning]]"
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
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: "Ignoring runtime, standard sample-complexity characterizations and unbounded ERM give the target sample-efficient guarantee."
family: sample-complexity-equivalence
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[sample-complexity-equivalence|Sample-Complexity Equivalence]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Sample-Efficient Weak Realizable Proper PAC Learning

## Verdict

`true`, by the sample-complexity theorem recorded in [[sample-complexity-equivalence|Sample-Complexity Equivalence]].

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size is bounded by $p(s,\log(1/\delta))$. No polynomial running-time bound is required.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size is bounded by $p(s,\log(1/\delta))$. No polynomial running-time bound is required.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Show that the source guarantee is enough for [[sample-efficient-weak-realizable-proper-pac|Sample-Efficient Weak Realizable Proper PAC Learning]] once polynomial running time is not required.

**Why the source gives sample control.** The source gives a polynomial sample bound at the relevant distribution-uniformity level. In the sample-only setting, the learner may use exhaustive empirical risk minimization over the benchmark class, so computational hardness of ERM is irrelevant.

**Why the target follows.** For binary PAC learning, the finite-sample characterizations underlying VC theory allow realizable, agnostic, weak, strong, proper, and improper sample guarantees to be converted at the same distribution-uniformity level. If the target is marginal-nonuniform, a distribution-free sample bound is also valid marginal-by-marginal.

**Conclusion.** The implication is true as a sample-complexity statement. It should not be read as giving a polynomial-time algorithm.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
