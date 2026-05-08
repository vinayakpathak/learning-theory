---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-realizable-improper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-realizable-improper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
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
summary: "Schapire boosting converts weak realizable learning into strong realizable improper learning; weak agnostic learning specializes to weak realizable learning on realizable distributions."
family: realizable-boosting
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`true`.

Schapire boosting converts weak realizable learning into strong realizable improper learning; weak agnostic learning specializes to weak realizable learning on realizable distributions.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. There is one polynomial $p$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Derive strong realizable improper learning from the weak source node.

**Reduction.** If the source is weak agnostic, first restrict it to realizable distributions. Since $\inf_{c\in\mathcal C}\operatorname{err}(c)=0$, the additive weak agnostic guarantee gives error below $1/2$ and hence a weak realizable learner. If the source is already weak realizable, no restriction is needed.

**Boosting step.** Schapire's weak-to-strong boosting theorem repeatedly calls the weak learner under reweighted distributions and combines the returned hypotheses by a vote. The combined vote need not lie in $\mathcal C$, so the target is the improper strong realizable node.

**Conclusion.** The boosted learner achieves arbitrary realizable PAC accuracy in polynomial time, with an improper final hypothesis.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
