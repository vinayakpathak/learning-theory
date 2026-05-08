---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
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
summary: "On realizable distributions the weak agnostic learner becomes a weak realizable learner, and Schapire boosting gives strong realizable improper learning before weakening to marginal-nonuniform bounds."
family: realizable-boosting
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

On realizable distributions the weak agnostic learner becomes a weak realizable learner, and Schapire boosting gives strong realizable improper learning before weakening to marginal-nonuniform bounds.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Derive strong marginal-nonuniform realizable improper learning.

**Reduction to weak realizable learning.** On realizable examples, $\operatorname{opt}_{\mathcal C}=0$. The weak agnostic learner therefore returns a hypothesis with error at most $\beta<1/2$, giving a weak realizable learner.

**Boosting step.** Schapire's theorem boosts this weak realizable learner to arbitrary error $\varepsilon$ by combining weak hypotheses into an improper vote.

**Conclusion.** The boosted learner has a distribution-free polynomial bound, so it also satisfies the target's weaker marginal-dependent polynomial requirement.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
