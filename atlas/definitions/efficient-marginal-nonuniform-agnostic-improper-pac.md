---
type: definition
id: efficient-marginal-nonuniform-agnostic-improper-pac
title: Efficient Marginal-Nonuniform Agnostic Improper PAC Learning
domain: binary-classification
model: pac
realizability: agnostic
properness: improper
strength: strong
resource: computational
distribution: marginal-nonuniform
loss: zero-one
output_constraint: improper
sample_complexity: marginal-dependent-polynomial
runtime: marginal-dependent-polynomial
characterization_status: partial
characterization: "A distribution-dependent agnostic PAC relaxation: one learner works for all joint distributions, but the polynomial bound may depend on the marginal distribution over instances."
characterization_ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
characterization_refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/definition
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Definition

A single learner $A$ receives i.i.d. examples from an arbitrary joint distribution $\mathcal D$ over $\mathcal X\times\{0,1\}$. Let $P=\mathcal D_X$ be its marginal over instances. The learner must output a hypothesis $h$, possibly outside $\mathcal C$.

For every marginal $P$, there is a polynomial $p_P$ such that for every joint distribution $\mathcal D$ with marginal $P$ and every $\varepsilon,\delta\in(0,1)$, with probability at least $1-\delta$,

$$
\operatorname{err}_{\mathcal D}(h)\le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon .
$$

The sample complexity and running time are at most

$$
p_P(s,1/\varepsilon,\log(1/\delta)).
$$

The polynomial $p_P$ may depend on the marginal distribution $P$, but not on the target concept, conditional label rule, $\varepsilon$, or $\delta$. The learner itself is still one uniform algorithm for the class, and it is not given a separate algorithm as advice for each $P$.

## Naming

Benedek and Itai studied learnability with respect to fixed distributions, and Ben-David, Benedek, and Mansour organized PAC models by their uniformity parameters. Recent work of Hanneke, Moran, and Thiessen calls the variant where rates may depend on the marginal distribution **marginal-nonuniform PAC learnability**.

## Characterization Status

`partial`: this note records the computational marginal-nonuniform version used by the atlas. No representation-sensitive characterization is asserted here.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-marginal-nonuniform-agnostic-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-marginal-nonuniform-agnostic-improper-pac"
SORT source ASC
```
