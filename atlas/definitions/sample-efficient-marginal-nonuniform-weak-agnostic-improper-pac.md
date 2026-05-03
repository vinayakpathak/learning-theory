---
type: definition
id: sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
title: Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning
domain: binary-classification
model: pac
realizability: agnostic
properness: improper
strength: weak
resource: sample-efficient
distribution: marginal-nonuniform
loss: zero-one
output_constraint: improper
sample_complexity: marginal-dependent-polynomial-weak
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

# Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Definition

A single learner receives i.i.d. examples from an arbitrary joint distribution $\mathcal D$ over $\mathcal X\times\{0,1\}$. Let $P=\mathcal D_X$ be its marginal over instances.

With probability at least $1-\delta$, it must output a hypothesis $h$, possibly outside $\mathcal C$, such that

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c \in \mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta,
$$

where $\beta<1/2$ is a fixed additive weak-agnostic tolerance.

For every marginal $P$, there is a polynomial $p_P$ bounding the number of samples as a function of the relevant representation size, the inverse weak advantage parameter, and $\log(1/\delta)$. The polynomial may depend on $P$, but not on the target concept, conditional labeling rule, requested accuracy, or confidence parameter. No polynomial running-time requirement is imposed.

## Characterization Status

`partial`: This is the marginal-nonuniform sample-complexity analogue: one learner works for all marginals, but the polynomial sample bound may depend on the marginal distribution.

## Boundary Examples

Every distribution-free sample-efficient class also satisfies this marginal-nonuniform relaxation. The possible separation in the reverse direction is tracked by [[marginal-uniformization-open|Marginal Uniformization Open]], because the polynomial sample bound here may depend on the marginal distribution.

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
WHERE type = "implication" AND source = "sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac"
SORT source ASC
```
