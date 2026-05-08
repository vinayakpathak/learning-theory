---
type: implication
id: efficient-marginal-nonuniform-realizable-proper-pac__implies__efficient-weak-realizable-improper-pac
source: efficient-marginal-nonuniform-realizable-proper-pac
target: efficient-weak-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
target_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "unclear"
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial; source realizable proper accuracy then relaxes to weak realizable improper accuracy."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: proper-to-improper
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Proper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`, by full-support marginal uniformization plus monotone relaxation from strong proper learning to weak improper learning.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Status

**Goal.** Construct one distribution-free efficient weak realizable improper learner from the marginal-nonuniform realizable proper learner.

Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source guarantee at $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time.

Because $P^\star$ has full support, every finite realizable labeled transcript that can occur under any marginal $P$ and target $c\in\mathcal C$ has positive probability under $P^\star$ with the same target $c$. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Hence $p_{P^\star}$ is a distribution-free resource bound for $A$.

Accuracy is checked under the actual marginal $P$, not under $P^\star$. For any realizable distribution labeled by $c\in\mathcal C$, run $A$ with fixed accuracy parameter $\varepsilon=1/4$. With probability at least $1-\delta$, it outputs $h\in\mathcal C$ with error at most $1/4$, so it has weak advantage $\gamma=1/4$.

Finally, the target is improper only in the permissive sense: hypotheses outside $\mathcal C$ are allowed, but proper hypotheses are still valid. Thus the proper output of $A$ is already an admissible improper hypothesis. The same learner witnesses the target.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
