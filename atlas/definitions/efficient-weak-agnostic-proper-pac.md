---
type: definition
id: efficient-weak-agnostic-proper-pac
title: Efficient Weak Agnostic Proper PAC Learning
domain: binary-classification
model: pac
realizability: agnostic
properness: proper
strength: weak
resource: computationally-efficient
distribution: distribution-free
loss: zero-one
output_constraint: proper
sample_complexity: polynomial
runtime: polynomial
characterization_status: partial
characterization: "This note uses the additive weak agnostic guarantee err <= opt_C + beta for a fixed beta < 1/2; stronger correlation-style weak agnostic notions are not used here."
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

# Efficient Weak Agnostic Proper PAC Learning

## Definition

A learner receives i.i.d. examples from an arbitrary distribution $\mathcal D$ over $\mathcal X \times \{0,1\}$. With probability at least $1-\delta$, it must output $h \in \mathcal C$ such that

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c \in \mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta,
$$

where $\beta<1/2$ is a fixed additive weak-agnostic tolerance. This is the Ben-David--Long--Mansour style weak agnostic notion, not the stronger correlation-style weak learner used in some full agnostic boosting frameworks. The learner is efficient when sample complexity and running time are polynomial in the relevant representation size and $\log(1/\delta)$, and polynomial in $1/(1/2-\beta)$ if $\beta$ is parameterized.

## Characterization Status

`partial`: this note records the computational weak-learning notion used by the atlas. The realizable weak-to-strong conversion is available through boosting when the final output may be improper; proper final-output and agnostic weak-to-strong questions are tracked by implication notes rather than folded into the definition.

## Boundary Examples

The main positive boundary example is [[fixed-k-term-DNF|Fixed-$k$-Term DNF]]. It satisfies the weak proper agnostic notion used by the atlas, while strong proper learning for the same family would contradict the cited hardness results unless $\mathrm{RP}=\mathrm{NP}$.

The main negative boundary example is [[halfspaces|Halfspaces]]. They are efficiently realizably properly learnable, but Tiegel's hardness result rules out weak agnostic learning even with improper hypotheses under worst-case lattice assumptions, and therefore also rules out this proper weak agnostic node.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-weak-agnostic-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-weak-agnostic-proper-pac"
SORT source ASC
```
