---
type: definition
id: efficient-marginal-nonuniform-realizable-proper-pac
title: Efficient Marginal-Nonuniform Realizable Proper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: proper
strength: strong
resource: computationally-efficient
distribution: marginal-nonuniform
loss: zero-one
output_constraint: proper
sample_complexity: marginal-dependent-polynomial
runtime: marginal-dependent-polynomial
characterization_status: partial
characterization: "A distribution-dependent realizable PAC relaxation: one learner works for all marginals, but the polynomial bound may depend on the marginal distribution."
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

# Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Definition

A single learner $A$ receives i.i.d. labeled examples $(X,c(X))$, where $X\sim P$ for an arbitrary marginal distribution $P$ over $\mathcal X$ and $c\in\mathcal C$. It must output $h\in\mathcal C$.

For every marginal $P$, there is a polynomial $p_P$ such that for every target $c\in\mathcal C$ and every $\varepsilon,\delta\in(0,1)$, with probability at least $1-\delta$,

$$
\operatorname{err}_P(h,c)\le \varepsilon .
$$

The sample complexity and running time are at most

$$
p_P(s,1/\varepsilon,\log(1/\delta)),
$$

where $s$ denotes the relevant representation-size parameter.

The polynomial $p_P$ may depend on the marginal distribution $P$, but not on the target concept, conditional label rule, $\varepsilon$, or $\delta$. The learner itself is still one uniform algorithm for the class, and it is not given a separate algorithm as advice for each $P$.

## Naming

Benedek and Itai studied learnability with respect to fixed distributions, and Ben-David, Benedek, and Mansour organized PAC models by their uniformity parameters. Recent work of Hanneke, Moran, and Thiessen calls the variant where rates may depend on the marginal distribution **marginal-nonuniform PAC learnability**.

## Characterization Status

`partial`: this note records the computational marginal-nonuniform version used by the atlas. No representation-sensitive characterization is asserted here.

## Boundary Examples

Positive boundary examples are inherited from distribution-free realizable proper learning. [[halfspaces|Halfspaces]] satisfy this node and, under worst-case lattice assumptions, fail the marginal-nonuniform strong agnostic nodes. They are therefore useful near the realizable-versus-agnostic boundary, even though they are not marginal-only examples.

No sharper negative example is currently recorded for this node. The incoming candidates from weak, improper, or distribution-free-adjacent relaxations are tied to open [[marginal-boosting-open|marginal boosting]], [[properization-open|properization]], and [[marginal-uniformization-open|uniformization]] questions. As an absolute nonboundary failure, [[unrestricted-labelings|Unrestricted Labelings]] fail even this marginal-nonuniform realizable proper requirement.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-marginal-nonuniform-realizable-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-marginal-nonuniform-realizable-proper-pac"
SORT source ASC
```
