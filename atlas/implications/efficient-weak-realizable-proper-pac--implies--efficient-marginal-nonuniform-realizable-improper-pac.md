---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
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
summary: "Weak realizable proper learning can be boosted to strong realizable improper learning, then weakened to the marginal-nonuniform target."
family: realizable-boosting
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: proper-to-improper
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

Weak realizable proper learning can be boosted to strong realizable improper learning, then weakened to the marginal-nonuniform target.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Obtain the target guarantee from a weak proper realizable learner.

**Boosting step.** Schapire boosting treats the weak learner as a subroutine and combines its hypotheses by a vote. The final vote can be outside $\mathcal C$, so it is an improper hypothesis.

**Why the target follows.** The boosted learner is distribution-free and polynomial-time. The target permits the polynomial bound to depend on the marginal, so the same learner works.

**Conclusion.** The implication follows from weak-to-strong boosting and weakening the uniformity requirement.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
