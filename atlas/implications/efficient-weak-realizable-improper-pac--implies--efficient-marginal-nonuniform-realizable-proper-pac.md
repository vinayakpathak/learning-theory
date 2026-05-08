---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-proper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
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
summary: "False under one-way functions: image-coordinate concepts are distribution-free strongly learnable by improper memorization, hence satisfy the weak realizable improper source, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: improper-to-proper
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]. It is efficiently distribution-free strongly learnable by an improper memorization learner, so it satisfies the weaker efficient weak realizable improper source. A marginal-nonuniform realizable proper learner under one fixed coordinate marginal would invert the one-way function.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

Assuming length-preserving one-way functions exist, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate efficient weak realizable improper learning from efficient marginal-nonuniform realizable proper learning.

**Why the source holds.** For a length-$n$ target seed, the concept has exactly $n$ positive atoms. The improper learner records positive atoms seen in the sample and predicts $0$ elsewhere. With polynomially many samples, every positive atom of mass at least $\varepsilon/n$ is seen with high probability, and the total unseen low-mass positive region is at most $\varepsilon$. Thus the class is efficiently distribution-free realizably learnable improperly, and hence weakly learnable improperly.

**Why the target fails.** Fix the coordinate marginal with length-$k$ block mass $\mu_k=6/(\pi^2k^2)$ and uniform coordinates inside each block. For a length-$n$ target seed $s$, any proper hypothesis with error at most $\mu_n/(3n)$ must have length $n$ and the same image $f(s)$: a wrong length costs $\mu_n/2$, and one wrong image coordinate costs at least $\mu_n/n$.

Given a one-way challenge $y=f(s)$, labeled examples from this fixed marginal can be simulated using $y$ by labeling $(1^k,i,b)$ positive exactly when $k=n$ and $b=y_i$. A marginal-nonuniform realizable proper learner run at accuracy $\mu_n/(3n)$ would output a seed $t$ with $f(t)=y$ in randomized polynomial time, contradicting one-wayness.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
