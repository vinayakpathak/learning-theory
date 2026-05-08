---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
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
  - blumer1989
  - hastad2005query
  - karp1972
  - hanneke2025marginalnonuniform
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "False under NP not subset RP: the PCP active-slice lookup class satisfies the improper source via efficient agnostic one-slice lookup-table ERM, but a marginal-nonuniform weak realizable proper learner would have pathwise uniform runtime under a full-support marginal and would produce a proof accepted on more than half of the active slice."
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
# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] satisfies the source because it is efficiently agnostically learnable by an improper one-slice lookup-table ERM. It fails the target because a marginal-nonuniform weak realizable proper learner is exactly enough to weakly learn realizable active-slice labels.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the target concept or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the target concept or $\delta$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate the improper source from Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning.

**Witness construction.** Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. Choose a perfect-completeness PCP for an NP-complete language with $O(\log n)$ random bits and soundness $q<1/2$. A proper concept is indexed by an instance-proof pair $(\varphi,\pi)$ and, on an example $(\psi,r)$, outputs the verifier decision $V(\varphi,\pi,r)$ when $\psi=\varphi$ and outputs $0$ otherwise.

**Why the source holds.** The verifier randomness has polynomial-size support for each active slice. ERM over the improper finite class of one-slice lookup tables, together with the all-zero hypothesis, is polynomial on a sample because only sampled slices need be considered and the best table on each sampled slice is obtained by empirical majority vote. This improper class contains every proper concept and has polynomial logarithmic size, so standard finite-class uniform convergence gives efficient agnostic improper learning. This distribution-free strong agnostic improper learner is stronger than the source node of this edge.

**Why the target fails.** Suppose the target learner existed. The atlas uses worst-case/pathwise running-time bounds on finite encoded sample transcripts. Fix a full-support reference marginal $P^\star$ over encoded examples. The marginal-nonuniform guarantee for $P^\star$ gives one polynomial pathwise bound for the learner on all finite transcripts, including transcripts supported on any active slice.

Given an NP instance $\varphi$, run the learner on examples sampled uniformly from the active slice $\{(\varphi,r)\}$ and labeled constantly by $1$. If $\varphi$ is satisfiable, perfect completeness makes the distribution realizable, so the learner returns, with constant probability, a proper concept accepted on strictly more than half the verifier random strings. If $\varphi$ is unsatisfiable, PCP soundness keeps every proper concept indexed by $\varphi$ at acceptance at most $q<1/2$, and concepts indexed by $\psi\ne\varphi$ output $0$ on the $\varphi$ slice. Since the slice is polynomial size, enumerate all random strings and accept iff the returned proper hypothesis is accepted on more than half of them. This gives an RP algorithm for the NP-complete language.

**Why marginal-nonuniformity does not save the target.** The hidden weak advantage $\gamma_{P_\varphi}(s)>0$ need not be known: any positive advantage crosses the exact threshold $1/2$, while soundness stays below it. The only apparent loophole is a formula-dependent runtime polynomial, but the current pathwise finite-transcript convention closes it via the fixed full-support marginal bound.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
