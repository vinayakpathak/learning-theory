---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
ref_keys:
  - hastad2005query
  - karp1972
refs:
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: "The PCP active-slice lookup class is weakly improperly learnable, but weak proper learning would put NP in RP."
family: pcp-active-slice-weak-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is efficiently weakly learnable by an improper memorization learner, but weak proper learning would decide an NP-complete language with one-sided randomized error.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate weak improper realizable learning from weak proper realizable learning.

**Witness construction.** Use a perfect-completeness PCP with logarithmic randomness and soundness $s<1/2$. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on input $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** For each target, the only possible positive examples live in the active slice for one instance $\varphi$, which has polynomial size. An improper learner memorizes positive sample points from this slice and predicts $0$ elsewhere, giving even strong realizable improper learning.

**Why the target fails.** Given an instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes the distribution realizable by a proper concept, so a weak proper learner must return a proof accepted on more than half the verifier random strings. If $\varphi$ is unsatisfiable, every proper hypothesis has acceptance at most $s<1/2$. Since the active slice is polynomial, the acceptance probability can be estimated or enumerated, yielding an RP algorithm for an NP-complete language.

## References

- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
