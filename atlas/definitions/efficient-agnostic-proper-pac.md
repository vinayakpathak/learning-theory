---
type: definition
id: efficient-agnostic-proper-pac
title: Efficient Agnostic Proper PAC Learning
domain: binary-classification
model: pac
realizability: agnostic
properness: proper
strength: strong
resource: computational
distribution: distribution-free
loss: zero-one
output_constraint: proper
sample_complexity: polynomial
runtime: polynomial
characterization_status: partial
characterization: "The sample-complexity analogue is characterized by finite VC dimension; efficient empirical risk minimization is a sufficient route, but no general computational characterization is recorded here."
characterization_ref_keys:
  - blumer1989
  - kearns1994
  - hopkins2024
characterization_refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)"
  - "[Hopkins et al. 2024](https://doi.org/10.46298/theoretics.24.2)"
tags:
  - atlas/definition
  - learning/binary-classification
---

# Efficient Agnostic Proper PAC Learning

## Definition

A learner receives i.i.d. examples from an arbitrary distribution $\mathcal D$ over $\mathcal X \times \{0,1\}$. With probability at least $1-\delta$, it must output $h \in \mathcal C$ such that

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c \in \mathcal C} \operatorname{err}_{\mathcal D}(c) + \varepsilon.
$$

The learner is efficient when both sample complexity and running time are polynomial in the relevant representation size, $1/\varepsilon$, and $\log(1/\delta)$.

This is the strong version of the notion: the learner must achieve every requested accuracy parameter $\varepsilon>0$.

## Characterization Status

`partial`: finite VC dimension characterizes the corresponding sample-complexity notion in binary distribution-free PAC learning. For the computational version, polynomial-time empirical risk minimization is a useful sufficient condition, but not a general characterization.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)
- [Hopkins et al. 2024](https://doi.org/10.46298/theoretics.24.2)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-agnostic-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-agnostic-proper-pac"
SORT source ASC
```
