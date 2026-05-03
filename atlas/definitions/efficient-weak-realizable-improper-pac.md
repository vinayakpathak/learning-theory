---
type: definition
id: efficient-weak-realizable-improper-pac
title: Efficient Weak Realizable Improper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: improper
strength: weak
resource: computational
distribution: distribution-free
loss: zero-one
output_constraint: improper
sample_complexity: polynomial
runtime: polynomial
characterization_status: partial
characterization: "Weak and strong realizable PAC learning are equivalent via boosting when the final hypothesis may be an improper ensemble."
characterization_ref_keys:
  - valiant1984
  - schapire1990
characterization_refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
tags:
  - atlas/definition
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning

## Definition

A learner receives i.i.d. labeled examples $(x,c(x))$, where $x \sim D$ for an arbitrary distribution $D$ over $\mathcal X$ and $c \in \mathcal C$. With probability at least $1-\delta$, it must output a hypothesis $h$, possibly outside $\mathcal C$, such that

$$
\operatorname{err}_D(h,c) \le \frac{1}{2}-\gamma.
$$

Here $\gamma$ is an inverse-polynomial advantage over random guessing. The learner is efficient when its sample complexity and running time are polynomial in the relevant representation size, $1/\gamma$, and $\log(1/\delta)$.

## Characterization Status

`partial`: this note records the computational weak-learning notion used by the atlas. The realizable weak-to-strong conversion is available through boosting when the final output may be improper; proper final-output and agnostic weak-to-strong questions are tracked by implication notes rather than folded into the definition.

## Boundary Examples

Positive boundary examples include classes that satisfy this weak realizable improper node but fail stronger neighboring requirements. [[halfspaces|Halfspaces]] satisfy even efficient realizable proper learning, but fail weak agnostic improper learning under worst-case lattice assumptions. [[clause-satisfaction-lookup-class|The Clause-Satisfaction Lookup Class]] satisfies this node through improper agnostic learning but fails proper realizable learning unless $\mathrm{NP}\nsubseteq\mathrm{RP}$.

No sharper negative example is currently recorded for this node. It is the weakest distribution-free realizable improper node, and the possible gap from marginal-nonuniform weak realizable improper learning is tracked as an open [[marginal-uniformization-open|marginal uniformization]] question. As an absolute nonboundary failure, [[unrestricted-labelings|Unrestricted Labelings]] fail even this weak requirement.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-weak-realizable-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-weak-realizable-improper-pac"
SORT source ASC
```
