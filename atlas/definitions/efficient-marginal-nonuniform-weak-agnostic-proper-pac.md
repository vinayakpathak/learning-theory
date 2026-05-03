---
type: definition
id: efficient-marginal-nonuniform-weak-agnostic-proper-pac
title: Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning
domain: binary-classification
model: pac
realizability: agnostic
properness: proper
strength: weak
resource: computational
distribution: marginal-nonuniform
loss: zero-one
output_constraint: proper
sample_complexity: marginal-dependent-polynomial-weak
runtime: marginal-dependent-polynomial-weak
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

# Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Definition

A single learner $A$ receives i.i.d. examples from an arbitrary joint distribution $\mathcal D$ over $\mathcal X\times\{0,1\}$. Let $P=\mathcal D_X$ be its marginal over instances. The learner must output $h\in\mathcal C$.

For every marginal $P$, there are a polynomial $p_P$ and an additive weak-agnostic tolerance $\beta_P(s)<1/2$ whose gap from $1/2$ is inverse-polynomial in $s$ under a marginal-dependent polynomial. For every joint distribution $\mathcal D$ with marginal $P$ and every $\delta\in(0,1)$, with probability at least $1-\delta$,

$$
\operatorname{err}_{\mathcal D}(h)\le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

The sample complexity and running time are bounded by $p_P(s,\log(1/\delta))$.

The polynomial $p_P$ may depend on the marginal distribution $P$, but not on the target concept, conditional label rule, $\varepsilon$, or $\delta$. The learner itself is still one uniform algorithm for the class, and it is not given a separate algorithm as advice for each $P$.

## Naming

Benedek and Itai studied learnability with respect to fixed distributions, and Ben-David, Benedek, and Mansour organized PAC models by their uniformity parameters. Recent work of Hanneke, Moran, and Thiessen calls the variant where rates may depend on the marginal distribution **marginal-nonuniform PAC learnability**.

## Characterization Status

`partial`: this note records the computational marginal-nonuniform version used by the atlas. No representation-sensitive characterization is asserted here.

## Boundary Examples

The main positive boundary example inherited from the distribution-free weak proper world is [[fixed-k-term-DNF|Fixed-$k$-Term DNF]]. It satisfies the weak proper agnostic node and therefore this marginal-nonuniform relaxation, while strong proper learning is conditionally hard in the distribution-free setting. The corresponding marginal weak-to-strong question is recorded as [[agnostic-boosting-open|open]], so this should not be read as a marginal strong-learning separation.

No sharper negative example is currently recorded for this exact node. The halfspace hardness used elsewhere does not settle the atlas's marginal-nonuniform weak agnostic target. As an absolute nonboundary failure, [[unrestricted-labelings|Unrestricted Labelings]] fail even this relaxed proper weak agnostic requirement.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-marginal-nonuniform-weak-agnostic-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-marginal-nonuniform-weak-agnostic-proper-pac"
SORT source ASC
```
