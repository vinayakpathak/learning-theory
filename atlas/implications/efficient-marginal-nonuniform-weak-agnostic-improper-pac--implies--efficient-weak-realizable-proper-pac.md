---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
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
ref_keys:
  - blumer1989
  - hastad2005query
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Hastad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is efficiently agnostically learnable improperly, hence satisfies the marginal-nonuniform weak agnostic improper source, but weak realizable proper learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is efficiently agnostically learnable by an improper one-slice lookup-table ERM, hence satisfies the marginal-nonuniform weak agnostic improper source. An efficient weak realizable proper learner for the same class would decide an NP-complete language with one-sided randomized error.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate marginal-nonuniform weak agnostic improper learning from distribution-free weak realizable proper learning.

**Witness construction.** Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** The class satisfies the stronger [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]] node. The verifier has $O(\log n)$ random bits, so each active slice is polynomial size. The improper learner runs ERM over one-slice lookup tables and the all-zero hypothesis; only sampled slices need be considered, and the best table on a sampled slice is obtained by empirical majority vote. Since this finite improper class contains all proper concepts and has polynomial logarithmic size, finite-class uniform convergence gives efficient agnostic improper learning. Restricting to a fixed weak tolerance gives the assigned marginal-nonuniform weak source.

**Why the target fails.** Given an NP instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by a proper concept, so a weak proper learner returns a proof accepted on more than half the random strings. If $\varphi$ is unsatisfiable, PCP soundness keeps every proof below one-half acceptance. The active slice is polynomial size, so the returned proper hypothesis's acceptance can be checked exactly, distinguishing satisfiable from unsatisfiable instances in randomized polynomial time. Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Hastad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
