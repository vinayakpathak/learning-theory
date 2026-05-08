---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
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
summary: "False under one-way functions: image-coordinate concepts are marginal-nonuniformly learnable improperly, but fixed-marginal proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

The one-way image-coordinate class is easy to predict improperly but hard to learn properly under one fixed marginal.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

Assuming length-preserving one-way functions exist, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

Use the [[one-way-image-coordinate-class|one-way image-coordinate class]]. For a seed $s\in\{0,1\}^n$, the concept labels a coordinate point $(1^n,i,b)$ positively exactly when $b=f(s)_i$.

**Why the source holds.** The distribution-free improper memorization learner from [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]] records observed positive atoms and predicts $0$ elsewhere. This is stronger than the marginal-nonuniform improper source.

**Why the target fails.** Under the fixed marginal with mass $\mu_n=6/(\pi^2n^2)$ on the length-$n$ coordinate block, any proper hypothesis with error at most $\mu_n/(3n)$ against a length-$n$ target must output a seed $t$ with $f(t)=f(s)$. A marginal-nonuniform proper learner for this fixed marginal would therefore invert $f$ in polynomial time.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
