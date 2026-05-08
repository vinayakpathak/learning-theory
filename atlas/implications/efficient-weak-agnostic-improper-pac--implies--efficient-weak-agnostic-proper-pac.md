---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
ref_keys:
  - bendavid2001
  - hastad2005query
  - karp1972
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is weak agnostic improperly learnable, but weak agnostic proper learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The PCP active-slice lookup class is weak agnostic learnable by an improper one-slice lookup-table learner, but weak agnostic proper learning would decide an NP-complete language.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

Use the PCP active-slice lookup class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. Proper hypotheses encode an instance/proof pair and are nonzero only on that instance's verifier-randomness slice.

**Why the source holds.** Enlarge the improper hypothesis space to all one-slice lookup tables, plus the all-zero hypothesis. The active slice has polynomial size because the PCP uses logarithmic randomness, and the slice name has polynomial encoding length. Hence this finite improper class has polynomial logarithmic size. Empirical risk minimization over it is polynomial time: only slices appearing in the sample can improve over the all-zero hypothesis, and the best table on a sampled slice is obtained by majority vote on sampled random strings. Since every proper hypothesis is one such lookup table, this gives efficient agnostic improper learning, and therefore weak agnostic improper learning.

**Why the target fails.** On input an NP instance $\varphi$, sample uniformly from the active slice $\{(\varphi,r)\}$ and label every example by $1$. If $\varphi$ is satisfiable, perfect completeness gives a proof whose proper hypothesis has error $0$, so a weak agnostic proper learner returns a proper hypothesis accepted on more than half of verifier random strings. If $\varphi$ is unsatisfiable, PCP soundness keeps every proper hypothesis below $1/2$ acceptance on that slice. Since the active slice is polynomial size, the reduction can estimate or enumerate acceptance and decide the NP-complete language with one-sided randomized error.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
