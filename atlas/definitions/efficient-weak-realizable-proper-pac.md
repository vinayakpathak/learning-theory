---
type: definition
id: efficient-weak-realizable-proper-pac
title: Efficient Weak Realizable Proper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: proper
strength: weak
resource: computationally-efficient
distribution: distribution-free
loss: zero-one
output_constraint: proper
sample_complexity: polynomial
runtime: polynomial
characterization_status: partial
characterization: "Weak and strong realizable PAC learning are equivalent if the boosted final hypothesis may be improper; proper final-output constraints remain representation-sensitive."
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

# Efficient Weak Realizable Proper PAC Learning

## Definition

A learner receives i.i.d. labeled examples $(x,c(x))$, where $x \sim D$ for an arbitrary distribution $D$ over $\mathcal X$ and $c \in \mathcal C$. With probability at least $1-\delta$, it must output $h \in \mathcal C$ such that

$$
\operatorname{err}_D(h,c) \le \frac{1}{2}-\gamma.
$$

Here $\gamma$ is an inverse-polynomial advantage over random guessing, fixed by the learner or by the representation-size regime rather than requested as an arbitrary accuracy parameter. The learner is efficient when its sample complexity and running time are polynomial in the relevant representation size, $1/\gamma$, and $\log(1/\delta)$.

## Characterization Status

`partial`: this note records the computational weak-learning notion used by the atlas. The realizable weak-to-strong conversion is available through boosting when the final output may be improper; proper final-output and agnostic weak-to-strong questions are tracked by implication notes rather than folded into the definition.

## Boundary Examples

The main positive boundary example is [[fixed-k-term-DNF|Fixed-$k$-Term DNF]]. It is weakly properly learnable, but strong proper realizable learning is hard unless $\mathrm{RP}=\mathrm{NP}$, so it sits close to the weak-versus-strong proper boundary.

No sharper negative example is currently recorded for this exact node. The pure weak properization question, from weak realizable improper learning to weak realizable proper learning, is still [[properization-open|open]]. As an absolute nonboundary failure, [[unrestricted-labelings|Unrestricted Labelings]] fail even this weak realizable proper requirement.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-weak-realizable-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-weak-realizable-proper-pac"
SORT source ASC
```
