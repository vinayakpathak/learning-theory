---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-agnostic-improper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
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
ref_keys:
  - blumer1989
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: image-coordinate concepts are distribution-free agnostically learnable by improper sparse ERM, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

The [[one-way-image-coordinate-class|One-Way Image Coordinate Class]] is distribution-free agnostically learnable by improper sparse ERM. A marginal-nonuniform realizable proper learner under one fixed marginal would recover a preimage of a one-way image.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

Assuming length-preserving one-way functions exist, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate efficient agnostic improper learning from marginal-nonuniform realizable proper learning.

**Witness construction.** Let $f:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving one-way function. The instance domain contains triples $(1^k,i,b)$ with $i\in[k]$ and $b\in\{0,1\}$. A seed $s\in\{0,1\}^n$ represents the concept
$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f(s)_i .
$$

**Why the source holds.** For size parameter $s$, allow improper lookup tables with at most $s$ positive atoms. This class contains every proper concept of size at most $s$, has VC dimension at most $s$, and has a polynomial-time ERM: keep the at most $s$ sampled atoms with largest positive empirical benefit and predict $0$ elsewhere. VC uniform convergence gives efficient distribution-free agnostic improper PAC learning.

**Why the target fails.** Fix the marginal $P$ with length-$k$ block mass $\mu_k=6/(\pi^2k^2)$ and uniform coordinates inside each block. For a target seed $s$ of length $n$, any proper hypothesis with error at most $\mu_n/(3n)$ must have the same length and the same image $f(s)$. Given a challenge $y=f(s)$, one can simulate realizable examples from this fixed marginal using the bits of $y$. A marginal-nonuniform proper learner would therefore output a seed $t$ with $f(t)=y$ in polynomial time, contradicting one-wayness.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
