---
type: implication
id: efficient-marginal-nonuniform-agnostic-proper-pac__implies__efficient-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-agnostic-proper-pac
target: efficient-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
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
summary: "True under the atlas worst-case efficiency convention: full-support marginal uniformization gives a distribution-free strong agnostic proper learner, and strong proper agnostic learning trivially implies weak improper agnostic learning."
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

# Efficient Marginal-Nonuniform Agnostic Proper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Improper PAC Learning

## Verdict

`true`, by full-support marginal uniformization followed by monotone relaxation.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform agnostic proper source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under $P^\star$.

Because $P^\star$ has full support, every finite labeled transcript possible under any marginal has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Hence $p_{P^\star}$ is one distribution-free resource polynomial for $A$.

For accuracy, fix the actual joint distribution $\mathcal D$ with marginal $P$. The source guarantee applied to $P$ directly gives proper agnostic excess error at most $\varepsilon$ under $\mathcal D$. Run $A$ with any fixed $\varepsilon \le \beta$, where $\beta<1/2$ is the weak agnostic tolerance. The output is proper, hence allowed by the improper target, and it satisfies
$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta .
$$

Therefore the same learner witnesses efficient distribution-free weak agnostic improper PAC learning.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
