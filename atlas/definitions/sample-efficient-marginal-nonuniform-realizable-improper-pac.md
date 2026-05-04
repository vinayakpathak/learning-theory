---
type: definition
id: sample-efficient-marginal-nonuniform-realizable-improper-pac
title: Sample-Efficient Marginal-Nonuniform Realizable Improper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: improper
strength: strong
resource: sample-efficient
distribution: marginal-nonuniform
loss: zero-one
output_constraint: improper
sample_complexity: marginal-dependent-polynomial
runtime: unrestricted
characterization_status: partial
characterization: "This is the marginal-nonuniform sample-complexity analogue: one learner works for all marginals, but the polynomial sample bound may depend on the marginal distribution."
characterization_ref_keys:
  - valiant1984
  - blumer1989
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
characterization_refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/definition
  - learning/binary-classification
---

# Sample-Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Definition

A single learner receives i.i.d. labeled examples $(x,c(x))$, where $x \sim P$ for an arbitrary marginal distribution $P$ over $\mathcal X$ and $c \in \mathcal C$.

With probability at least $1-\delta$, it must output a hypothesis $h$, possibly outside $\mathcal C$, such that

$$
\operatorname{err}_P(h,c) \le \varepsilon.
$$

This is the strong version of the notion: the learner must achieve every requested accuracy parameter $\varepsilon>0$.

For every marginal $P$, there is a polynomial $p_P$ bounding the number of samples as a function of the relevant representation size, $1/\varepsilon$, and $\log(1/\delta)$. The polynomial may depend on $P$, but not on the target concept, conditional labeling rule, requested accuracy, or confidence parameter. No polynomial running-time requirement is imposed.

## Characterization Status

`partial`: This is the marginal-nonuniform sample-complexity analogue: one learner works for all marginals, but the polynomial sample bound may depend on the marginal distribution.

## Boundary Examples

Every distribution-free sample-efficient class also satisfies this marginal-nonuniform relaxation. Conversely, at the polynomial-rate binary sample-complexity level, Hanneke, Moran, and Thiessen's marginal-nonuniform trichotomy rules out a separation: polynomial marginal-dependent sample rates force finite VC dimension, so the corresponding distribution-free sample-efficient nodes follow by standard VC theory.

The computational boundary remains visible through [[pseudorandom-function-classes|Pseudorandom Function Classes]], which are sample-efficient but not computationally efficiently weakly learnable under standard cryptographic assumptions. As an absolute nonboundary failure, [[unrestricted-labelings|Unrestricted Labelings]] fail even fixed-marginal finite-sample learnability under suitable nonatomic marginals.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "sample-efficient-marginal-nonuniform-realizable-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "sample-efficient-marginal-nonuniform-realizable-improper-pac"
SORT source ASC
```
