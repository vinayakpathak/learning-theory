---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "known"
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
summary: "Schapire boosting converts weak realizable improper learning into strong realizable improper learning, which is stronger than the marginal-nonuniform target."
family: realizable-boosting
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

Schapire boosting converts weak realizable improper learning into strong realizable improper learning, which is stronger than the marginal-nonuniform target.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Derive arbitrary realizable accuracy from the weak source.

**Boosting step.** Schapire's weak-to-strong theorem repeatedly calls the weak learner under reweighted realizable distributions and returns an improper vote with error at most $\varepsilon$.

**Why the target follows.** The boosted learner has a distribution-free polynomial bound in the usual PAC parameters. A distribution-free polynomial is also a valid marginal-dependent polynomial.

**Conclusion.** The source implies the target.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
