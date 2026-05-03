---
type: definition
id: efficient-weak-agnostic-improper-pac
title: Efficient Weak Agnostic Improper PAC Learning
domain: binary-classification
model: pac
realizability: agnostic
properness: improper
strength: weak
resource: computationally-efficient
distribution: distribution-free
loss: zero-one
output_constraint: improper
sample_complexity: polynomial
runtime: polynomial
characterization_status: partial
characterization: "This note uses the additive weak agnostic guarantee err <= opt_C + beta for a fixed beta < 1/2, with no proper final-output constraint."
characterization_ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
characterization_refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
tags:
  - atlas/definition
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning

## Definition

A learner receives i.i.d. examples from an arbitrary distribution $\mathcal D$ over $\mathcal X \times \{0,1\}$. With probability at least $1-\delta$, it must output a hypothesis $h$, possibly outside $\mathcal C$, such that

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c \in \mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta,
$$

where $\beta<1/2$ is a fixed additive weak-agnostic tolerance. The learner is efficient when sample complexity and running time are polynomial in the relevant representation size and $\log(1/\delta)$, and polynomial in $1/(1/2-\beta)$ if $\beta$ is parameterized.

## Characterization Status

`partial`: this note records the computational weak-learning notion used by the atlas. The realizable weak-to-strong conversion is available through boosting when the final output may be improper; proper final-output and agnostic weak-to-strong questions are tracked by implication notes rather than folded into the definition.

## Boundary Examples

Positive boundary examples again show the value of allowing improper hypotheses. [[clause-satisfaction-lookup-class|The Clause-Satisfaction Lookup Class]] satisfies the stronger agnostic improper node, hence this weak node, while proper realizable learning for it is conditionally hard.

Negative boundary examples show that even weak agnostic learning can be too strong. [[halfspaces|Halfspaces]] satisfy efficient realizable proper PAC learning but fail weak agnostic improper learning under worst-case lattice assumptions. The weak-to-strong agnostic direction from this node is still tracked separately as [[agnostic-boosting-open|open]].

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-weak-agnostic-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-weak-agnostic-improper-pac"
SORT source ASC
```
