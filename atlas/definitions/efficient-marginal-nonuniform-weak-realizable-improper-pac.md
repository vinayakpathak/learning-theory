---
type: definition
id: efficient-marginal-nonuniform-weak-realizable-improper-pac
title: Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: improper
strength: weak
resource: computational
distribution: marginal-nonuniform
loss: zero-one
output_constraint: improper
sample_complexity: marginal-dependent-polynomial-weak
runtime: marginal-dependent-polynomial-weak
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

# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning

## Definition

A single learner $A$ receives i.i.d. labeled examples $(X,c(X))$, where $X\sim P$ for an arbitrary marginal distribution $P$ over $\mathcal X$ and $c\in\mathcal C$. It must output a hypothesis $h$, possibly outside $\mathcal C$.

For every marginal $P$, there are a polynomial $p_P$ and an inverse-polynomial advantage $\gamma_P(s)>0$ such that for every target $c\in\mathcal C$ and every $\delta\in(0,1)$, with probability at least $1-\delta$,

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s).
$$

The sample complexity and running time are bounded by $p_P(s,\log(1/\delta))$. Equivalently, the advantage may depend on $P$, but $1/\gamma_P(s)$ is bounded by a marginal-dependent polynomial in the representation size.

The polynomial $p_P$ may depend on the marginal distribution $P$, but not on the target concept, conditional label rule, $\varepsilon$, or $\delta$. The learner itself is still one uniform algorithm for the class, and it is not given a separate algorithm as advice for each $P$.

## Naming

Benedek and Itai studied learnability with respect to fixed distributions, and Ben-David, Benedek, and Mansour organized PAC models by their uniformity parameters. Recent work of Hanneke, Moran, and Thiessen calls the variant where rates may depend on the marginal distribution **marginal-nonuniform PAC learnability**.

## Characterization Status

`partial`: this note records the computational marginal-nonuniform version used by the atlas. No representation-sensitive characterization is asserted here.

## Boundary Examples

Positive boundary examples include [[halfspaces|Halfspaces]], which satisfy even distribution-free realizable proper learning but fail marginal-nonuniform strong agnostic learning under worst-case lattice assumptions. [[clause-satisfaction-lookup-class|The Clause-Satisfaction Lookup Class]] also satisfies this node through improper agnostic learning while failing proper realizable learning in the distribution-free sense under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

No sharper negative example is currently recorded for this weakest marginal-nonuniform realizable improper node. Candidate failures would resolve one of the open marginal boosting or uniformization questions. As an absolute nonboundary failure, [[unrestricted-labelings|Unrestricted Labelings]] fail even this weak improper realizable requirement.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-marginal-nonuniform-weak-realizable-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-marginal-nonuniform-weak-realizable-improper-pac"
SORT source ASC
```
