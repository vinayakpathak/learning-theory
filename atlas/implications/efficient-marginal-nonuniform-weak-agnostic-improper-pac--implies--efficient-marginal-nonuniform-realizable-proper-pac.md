---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-class
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: image-coordinate concepts are distribution-free agnostically learnable by improper sparse ERM, hence satisfy the weak marginal-nonuniform agnostic improper source, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]. It is efficiently agnostically learnable by improper sparse ERM, so it satisfies the weaker marginal-nonuniform weak agnostic improper source. A marginal-nonuniform realizable proper learner under one fixed marginal would invert the one-way function.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

Assuming length-preserving one-way functions exist, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate weak marginal-nonuniform agnostic improper learning from strong marginal-nonuniform realizable proper learning.

**Why the source holds.** For size parameter $n$, let the improper class be all lookup tables with at most $n$ positive atoms. This sparse class has VC dimension $n$, contains every length-$n$ proper image-coordinate concept, and admits polynomial-time sample ERM by keeping the sampled atoms with largest positive empirical benefit. VC uniform convergence gives efficient distribution-free agnostic improper learning against the proper class. Running this stronger learner at fixed constant accuracy gives the assigned weak marginal-nonuniform agnostic improper source.

**Why the target fails.** Fix the marginal that chooses a length block $k$ with mass $\mu_k=6/(\pi^2k^2)$ and then chooses $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a length-$n$ target seed $s$, any proper hypothesis with error at most $\mu_n/(3n)$ must have the same length and the same one-way image as $s$: a wrong length costs $\mu_n/2$, and one wrong image bit costs at least $\mu_n/n$.

Given a challenge image $y=f(s)$, labeled examples from this fixed marginal can be simulated using only $y$ by labeling $(1^k,i,b)$ positive exactly when $k=n$ and $b=y_i$. A marginal-nonuniform realizable proper learner run with accuracy $\mu_n/(3n)$ would output a seed $t$ satisfying $f(t)=y$ in polynomial time, contradicting one-wayness.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
