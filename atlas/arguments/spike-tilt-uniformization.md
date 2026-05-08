---
type: argument
id: spike-tilt-uniformization
title: Spike-Tilt Uniformization
domain: binary-classification
model: pac
status: "true"
evidence: theorem
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Spike-Tilt Uniformization

## Verdict

`true`.

Under the atlas deterministic-output and pathwise finite-transcript conventions, marginal-nonuniform weak realizable learning already contains a distribution-free inverse-polynomial weak edge.

## Theorem Statement

Let $\mathcal C$ be a binary concept class. Suppose there is a single weak realizable learner $A$ such that, for every marginal distribution $P$, there are a polynomial $p_P$ and an inverse-polynomial advantage $\gamma_P(s)>0$ with the following property: for every target $c\in\mathcal C$, with high probability $A$ outputs a hypothesis of error at most $1/2-\gamma_P(s)$ under $P$, and its sample and running-time bounds are pathwise bounded by $p_P$. If the learner's output can be treated deterministically after fixing its internal randomness, then there is one polynomial $p$ and one inverse-polynomial advantage $\gamma(s)>0$, independent of $P$, giving a distribution-free weak realizable learner for $\mathcal C$.

## Proof Sketch

Fix constant confidence and use a full-support reference marginal to obtain one pathwise polynomial sample and runtime bound $m(s)$ for the marginal-nonuniform weak learner. This step uses only that every finite transcript possible under any marginal has positive probability under the reference marginal.

Write labels and hypotheses as $\{\pm1\}$-valued functions. For a target $c$, define the signed edge

$$
e_P(h)=\mathbb E_P[c(X)h(X)].
$$

Suppose the learner has no uniform weak edge. Then for some marginal $P$, with constant probability it outputs deterministic hypotheses with

$$
0<e_P(h)<O(1/m(s)).
$$

Among those low-edge outputs, averaging over $x\sim P$ finds a point $x^\star$ where a constant fraction of the outputs are wrong. Form the spiked marginal

$$
Q=(1-\varepsilon)P+\varepsilon\delta_{x^\star},
\qquad
\varepsilon=\Theta(1/m(s)).
$$

The $m(s)$-sample transcript laws under $P$ and $Q$ have only constant total variation distance, since a sample sees the spike with probability $O(m(s)\varepsilon)$. But every low-edge output that is wrong at $x^\star$ has nonpositive edge under $Q$, contradicting the source guarantee for the marginal $Q$.

Therefore the source learner has a uniform inverse-polynomial weak advantage $\Omega(1/m(s))$. Standard validation amplifies confidence. When a strong realizable improper target is desired, Schapire-style boosting applies to the resulting distribution-free weak learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
