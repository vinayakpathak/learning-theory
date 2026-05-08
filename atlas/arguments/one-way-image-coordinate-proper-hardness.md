---
type: argument
id: one-way-image-coordinate-proper-hardness
title: One-Way Image Coordinate Proper Hardness
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - one-way-image-coordinate-class
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
assumptions:
  - length-preserving one-way functions exist
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# One-Way Image Coordinate Proper Hardness

## Verdict

`false`, under the assumption that length-preserving one-way functions exist.

The one-way image coordinate class is efficiently learnable by a distribution-free improper memorization learner. In fact, it is agnostically learnable by improper sparse ERM: for size parameter $n$, the improper class of lookup tables with at most $n$ positive atoms has VC dimension $n$ and contains all length-$n$ proper concepts. A marginal-nonuniform realizable proper learner would still invert the one-way function on a fixed marginal.

## Theorem Statement

Assuming length-preserving one-way functions exist, there is a binary concept class whose concepts encode the image coordinates of a one-way function such that the class is efficiently distribution-free learnable by improper memorization, and even efficiently agnostically learnable by improper sparse empirical risk minimization, but it has no single polynomial-time proper realizable PAC learner even if the polynomial resource bound may depend on the instance marginal. More precisely, for one fixed marginal distribution over instances, any proper learner achieving sufficiently small realizable error would recover a preimage of a one-way-function challenge with nonnegligible probability.

## Proof Sketch

Let $f:\{0,1\}^n\to\{0,1\}^n$ be length-preserving and one-way. The domain contains triples $(1^k,i,b)$ with $i\in[k]$ and $b\in\{0,1\}$. A seed $s\in\{0,1\}^n$ defines $c_s$ by

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f(s)_i .
$$

An improper realizable learner records the positive atoms observed in the sample and predicts $0$ elsewhere. For a length-$n$ target there are only $n$ positive atoms, so polynomially many samples reveal every positive atom with nonnegligible mass and leave at most $\varepsilon$ unseen positive mass.

For agnostic improper sources, use the larger sparse class of all hypotheses with at most $n$ positive atoms. This class has VC dimension $n$ and admits a polynomial-time sample ERM: compute the empirical benefit of predicting $1$ rather than $0$ at each sampled atom, keep the at most $n$ positive-benefit atoms with largest benefits, and predict $0$ elsewhere. Since the sparse class contains the proper concepts of size $n$, VC uniform convergence gives agnostic improper learning against the original class.

For the proper lower bound, fix the marginal $P$ that chooses $k$ with mass $\mu_k=6/(\pi^2k^2)$, then chooses $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a target seed $s$ of length $n$, set $\varepsilon_n=\mu_n/(3n)$. If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against $c_s$, then $|t|=n$ and $f(t)=f(s)$: the wrong length makes error $\mu_n/2$, and one wrong image bit makes error at least $\mu_n/n$.

Given a challenge $y=f(s)$, one can simulate labeled examples from this fixed marginal by labeling $(1^k,i,b)$ as positive exactly when $k=n$ and $b=y_i$. A marginal-nonuniform proper learner run with accuracy $\varepsilon_n$ outputs a seed $t$ satisfying $f(t)=y$ in time polynomial in $n$, contradicting one-wayness.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
