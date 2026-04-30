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
