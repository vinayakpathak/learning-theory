---
type: implication
id: efficient-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
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
summary: "False under one-way functions: image-coordinate concepts are easy to predict improperly, but fixed-marginal proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

Image-coordinate concepts are easy to learn by improper memorization, but proper learning under one fixed marginal would recover a preimage of a one-way image.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. There is one polynomial $p$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

Assuming length-preserving one-way functions exist, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Witness.** Let $f:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving one-way function. The instance domain contains triples $(1^k,i,b)$ with $i\in[k]$ and $b\in\{0,1\}$. A seed $s\in\{0,1\}^n$ represents the concept
$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f(s)_i .
$$

**Why the source holds.** For a length-$n$ target, there are only $n$ positive atoms. An improper learner records every positive atom seen in the sample and predicts $0$ elsewhere. With
$$
O\left(\frac{n}{\varepsilon}\log\frac{n}{\delta}\right)
$$
examples, every positive atom of mass at least $\varepsilon/n$ is observed with probability at least $1-\delta$, and the unseen positive mass is at most $\varepsilon$. This gives efficient distribution-free improper realizable PAC learning.

**Why the target fails.** Fix the marginal $P$ that chooses $k$ with mass $\mu_k=6/(\pi^2k^2)$, then chooses $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a target seed $s$ of length $n$, set $\varepsilon_n=\mu_n/(3n)$, so $1/\varepsilon_n$ is polynomial in $n$.

If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against $c_s$, then $|t|=n$ and $f(t)=f(s)$. The wrong length makes error $\mu_n/2$, while one wrong image bit contributes error at least $\mu_n/n$.

Given a one-way challenge $y=f(s)$, simulate examples from the fixed marginal $P$ and label $(1^k,i,b)$ as positive exactly when $k=n$ and $b=y_i$. A marginal-nonuniform proper learner run at accuracy $\varepsilon_n$ would output a seed $t$ with $f(t)=y$ in polynomial time, contradicting one-wayness.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
