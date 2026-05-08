---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-proper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-agnostic-proper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-weak-handle-class
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: proper constants and bounded subset handles give the weak agnostic marginal-nonuniform proper source, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-weak-handle-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]"
witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the [[one-way-image-coordinate-weak-handle-class|one-way image-coordinate weak-handle class]]: image-coordinate seed concepts, the two constants, and bounded positive-atom subset handles. The handles give the weak agnostic marginal-nonuniform proper source, but strong realizable proper learning under the fixed coordinate marginal would invert the one-way function.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

Assuming length-preserving one-way functions exist, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate weak agnostic marginal-nonuniform proper learning from strong realizable marginal-nonuniform proper learning.

**Why the source holds.** The class is marginal-nonuniform weak agnostically learnable by proper handles. For a length-$n$ image-coordinate target with positive mass $M$, the all-zero concept has error $M$, the all-one concept has error $1-M$, and the bounded handle on the heaviest $\lfloor n/4\rfloor$ positive atoms has error at most $3M/4$. The best of these has error at most $3/7<1/2$, and samples plus validation find the best empirical handle in polynomial time. On agnostic data, the same searchable handle family is within a fixed additive tolerance of any near-optimal seed concept, while constants and handle targets are handled directly.

**Why the target fails.** Fix the coordinate marginal with length-$k$ mass $\mu_k=6/(\pi^2 k^2)$. On a length-$n$ one-way challenge $y=f(s)$, label the length-$n$ coordinate block according to $y$. This distribution is realizable by a seed concept. A realizable proper learner run with $\varepsilon=\mu_n/(3n)$ must output a seed concept of length $n$ with the same image, since constants, bounded handles, wrong lengths, and wrong images all have larger error. This recovers a preimage of $y$ in randomized polynomial time, contradicting one-wayness.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
