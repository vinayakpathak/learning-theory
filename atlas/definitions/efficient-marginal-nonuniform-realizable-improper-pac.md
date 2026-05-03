---
type: definition
id: efficient-marginal-nonuniform-realizable-improper-pac
title: Efficient Marginal-Nonuniform Realizable Improper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: improper
strength: strong
resource: computationally-efficient
distribution: marginal-nonuniform
loss: zero-one
output_constraint: improper
sample_complexity: marginal-dependent-polynomial
runtime: marginal-dependent-polynomial
characterization_status: partial
characterization: "A distribution-dependent relaxation of realizable PAC learning: one learner works for all marginals, but the polynomial sample/runtime bound may depend on the marginal distribution."
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

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Definition

A single learner $A$ receives i.i.d. labeled examples $(X,c(X))$, where $X\sim P$ for an arbitrary marginal distribution $P$ over the instance space $\mathcal X$ and $c\in\mathcal C$.

The class $\mathcal C$ is efficiently marginal-nonuniformly realizably learnable with improper hypotheses if, for every marginal $P$, there is a polynomial $p_P$ such that for every target $c\in\mathcal C$ and every $\varepsilon,\delta\in(0,1)$, the learner outputs a hypothesis $h$, possibly outside $\mathcal C$, satisfying

$$
\operatorname{err}_P(h,c)\le \varepsilon
$$

with probability at least $1-\delta$, using at most

$$
p_P(s,1/\varepsilon,\log(1/\delta))
$$

samples and time, where $s$ denotes the relevant representation-size parameter.

The polynomial $p_P$ may depend on the marginal distribution $P$, but not on the target concept $c$, $\varepsilon$, or $\delta$. The learner itself is still a single uniform algorithm for the class. This prevents the definition from becoming a separate, distribution-by-distribution hard-coding notion.

## Naming

Benedek and Itai studied learnability with respect to fixed distributions, and Ben-David, Benedek, and Mansour organized several PAC learnability models by their uniformity parameters. Recent work of Hanneke, Moran, and Thiessen calls the version where the rate constants may depend on the marginal distribution but remain uniform over target concepts **marginal-nonuniform PAC learnability**.

This atlas note adds the computational requirement that the learner's running time, not only its sample size, is polynomial in the accuracy and confidence parameters with a marginal-dependent polynomial.

## Characterization Status

`partial`: the information-theoretic marginal-nonuniform sample-complexity setting has modern characterizations in terms of distribution-sensitive rates. This note records the computational analogue needed for the implication graph, and no representation-sensitive characterization is asserted here.

## Boundary Examples

Positive boundary examples include distribution-free examples that already exploit weaker axes. [[clause-satisfaction-lookup-class|The Clause-Satisfaction Lookup Class]] satisfies this node through improper agnostic learning but fails proper realizable learning in the distribution-free sense unless $\mathrm{NP}\nsubseteq\mathrm{RP}$. [[halfspaces|Halfspaces]] satisfy this node and fail the marginal-nonuniform strong agnostic nodes under worst-case lattice assumptions.

No sharper negative example is currently recorded for this node. In particular, the reverse move from marginal-nonuniform realizable learning to distribution-free realizable learning is an open [[marginal-uniformization-open|uniformization]] question. As an absolute nonboundary failure, [[unrestricted-labelings|Unrestricted Labelings]] fail even this marginal-nonuniform realizable improper requirement.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-marginal-nonuniform-realizable-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-marginal-nonuniform-realizable-improper-pac"
SORT source ASC
```
