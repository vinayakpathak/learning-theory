---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
assumptions: []
witnesses: []
ref_keys:
- benedek1991fixed
- hanneke2025marginalnonuniform
- schapire1990
refs:
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
summary: Spike-tilt uniformization first gives distribution-free weak realizable improper learning; Schapire boosting gives distribution-free strong realizable improper learning, which is stronger than the marginal-nonuniform realizable improper target.
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
result_origin: known
---
# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

The marginal-nonuniform weak source first uniformizes to distribution-free weak realizable improper learning, then boosts to distribution-free strong realizable improper learning; the target is weaker.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Sketch

**Goal.** Derive Efficient Marginal-Nonuniform Realizable Improper PAC Learning from Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning.

**Realizable restriction.** On realizable labels, the weak agnostic source has comparator error zero, so it is a marginal-nonuniform weak realizable learner with the same output constraint.

**Full-support resource uniformization.** Fix constant confidence, say $\delta_0=1/100$. Since the source is one uniform learner and atlas efficiency is pathwise over finite sample transcripts, a full-support reference marginal gives one polynomial pathwise sample/runtime bound $m(s)$ for this constant-confidence weak call, independent of the target marginal.

**Spike-tilt weak-gap uniformization.** Write labels and hypotheses as $\{\pm1\}$-valued functions and let $e_P(h)=\mathbb E_P[c(X)h(X)]$. Suppose the learner had no uniform weak edge under some marginal $P$: with constant probability it outputs deterministic hypotheses with $0<e_P(h)<O(1/m(s))$. Among those low-edge outputs, averaging finds a point $x^\star$ where a constant fraction are wrong. Form the spiked marginal

$$
Q=(1-\varepsilon)P+\varepsilon\delta_{x^\star},
\qquad \varepsilon=\Theta(1/m(s)).
$$

The $m(s)$-sample transcript laws under $P$ and $Q$ have constant total variation distance, because a sample sees the spike with probability only $O(m(s)\varepsilon)$. But every low-edge output that is wrong at $x^\star$ has nonpositive edge under $Q$, contradicting the source guarantee for the marginal $Q$. Hence the same learner has a uniform inverse-polynomial weak edge $\Omega(1/m(s))$ under every marginal. The target is also improper, so the source outputs have the right final-output type.

**Confidence amplification.** Repeating the constant-confidence weak learner and validating on a fresh sample selects, with probability at least $1-\delta$, a hypothesis retaining a $1/\operatorname{poly}(s)$ advantage. The final boosted vote may be improper, as allowed by the target.
**Boosting and weakening the distribution requirement.** The uniform weak learner has inverse-polynomial advantage and polynomial sample/time bounds independent of the marginal. Schapire's realizable weak-to-strong boosting theorem gives distribution-free strong realizable improper learning. A distribution-free strong learner is, in particular, a marginal-nonuniform strong learner.

**Conclusion.** The implication is true.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
