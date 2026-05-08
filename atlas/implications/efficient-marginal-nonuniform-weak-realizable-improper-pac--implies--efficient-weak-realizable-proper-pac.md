---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
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
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is distribution-free strongly learnable improperly, hence marginal-nonuniform weakly realizably learnable improperly, but weak proper realizable learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is distribution-free strongly learnable by an improper memorization learner, and therefore satisfies the marginal-nonuniform weak realizable improper source. An efficient weak proper realizable learner would decide an NP-complete language with one-sided randomized error.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the target concept or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate marginal-nonuniform weak realizable improper learning from distribution-free weak realizable proper learning.

**Witness construction.** Use a perfect-completeness PCP with logarithmic randomness and soundness $s<1/2$. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** For a target concept, all positive examples lie in one active slice of polynomial size. An improper learner memorizes positive sample points and predicts $0$ elsewhere. With polynomially many samples, the unseen positive mass is at most $\varepsilon$ with probability at least $1-\delta$, giving efficient distribution-free realizable improper learning. Running at $\varepsilon=1/4$ gives weak improper learning with constant advantage, so the assigned marginal-nonuniform weak source holds.

**Why the target fails.** Given an instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by a proper concept, so a weak proper learner returns a proof accepted on more than half of the verifier random strings. If $\varphi$ is unsatisfiable, every proof is accepted on at most an $s<1/2$ fraction, and wrong-slice concepts output $0$. Since the active slice is polynomial size, acceptance can be checked exactly, yielding an RP algorithm for an NP-complete language. Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

The analogous marginal-nonuniform weak proper target is not refuted by this active-slice reduction, because there the runtime polynomial and weak advantage may depend on the active-slice marginal chosen from the input instance.

## References

- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
