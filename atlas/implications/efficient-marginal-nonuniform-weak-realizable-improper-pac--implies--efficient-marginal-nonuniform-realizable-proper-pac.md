---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
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
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: image-coordinate concepts satisfy even distribution-free strong improper realizable learning, hence the weak marginal-nonuniform improper source, but fixed-marginal strong proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: improper-to-proper
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

The [[one-way-image-coordinate-class|one-way image-coordinate class]] satisfies even distribution-free strong improper realizable learning, hence the weak marginal-nonuniform improper source. But fixed-marginal strong proper learning would invert the one-way function.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the target concept or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

Assuming length-preserving one-way functions exist, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate weak marginal-nonuniform improper realizable learning from strong marginal-nonuniform proper realizable learning.

**Why the source holds.** For a seed $s\in\{0,1\}^n$, the target concept labels exactly one bit-atom positive for each coordinate of $f(s)$. An improper learner records observed positive atoms and predicts $0$ elsewhere. With $O((n/\varepsilon)\log(n/\delta))$ samples it sees every positive atom of marginal mass at least $\varepsilon/n$, and the remaining unseen positive mass is at most $\varepsilon$. This gives distribution-free strong realizable improper learning; running at constant accuracy gives the assigned weak marginal-nonuniform improper source.

**Why the target fails.** Fix the coordinate marginal with length-$k$ mass $\mu_k=6/(\pi^2 k^2)$ and uniform choice of coordinate and bit within each length block. For a length-$n$ target, set $\varepsilon_n=\mu_n/(3n)$. Any proper hypothesis with error at most $\varepsilon_n$ must have length $n$ and the same one-way image as the target; wrong lengths incur error at least $\mu_n/2$, and one wrong image coordinate incurs error at least $\mu_n/n$. Given a one-way challenge $y=f(s)$, labeled examples from this fixed marginal can be simulated using $y$. A proper learner run at accuracy $\varepsilon_n$ would output a seed $t$ with $f(t)=y$ in randomized polynomial time, contradicting one-wayness.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
