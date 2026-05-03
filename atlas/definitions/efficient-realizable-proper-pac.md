---
type: definition
id: efficient-realizable-proper-pac
title: Efficient Realizable Proper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: proper
strength: strong
resource: computationally-efficient
distribution: distribution-free
loss: zero-one
output_constraint: proper
sample_complexity: polynomial
runtime: polynomial
characterization_status: partial
characterization: "The sample-complexity analogue is characterized by finite VC dimension; no general representation-sensitive characterization of polynomial-time proper realizable PAC learnability is recorded here."
characterization_ref_keys:
  - valiant1984
  - blumer1989
characterization_refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
tags:
  - atlas/definition
  - learning/binary-classification
---

# Efficient Realizable Proper PAC Learning

## Definition

A learner receives i.i.d. labeled examples $(x,c(x))$, where $x \sim D$ for an arbitrary distribution $D$ over the instance space $\mathcal X$ and $c \in \mathcal C$. With probability at least $1-\delta$, it must output a hypothesis $h \in \mathcal C$ such that

$$
\operatorname{err}_D(h,c) \le \varepsilon.
$$

The learner is efficient when both sample complexity and running time are polynomial in the relevant representation size, $1/\varepsilon$, and $\log(1/\delta)$.

This is the strong version of the notion: the learner must achieve every requested accuracy parameter $\varepsilon>0$.

## Characterization Status

`partial`: finite VC dimension characterizes the corresponding sample-complexity notion in binary distribution-free PAC learning. The computational version depends on representation and algorithmic access, and no general structural characterization is recorded here.

## Boundary Examples

Positive boundary examples include classes that are properly learnable in the realizable model but become hard when one strengthens the requirement. [[conjunctions|Conjunctions]] satisfy this node, but proper agnostic learning is hard unless $\mathrm{RP}=\mathrm{NP}$. [[halfspaces|Halfspaces]] also satisfy this node and, under worst-case lattice assumptions, fail even improper agnostic learning.

Negative boundary examples isolate the cost of properness or strong accuracy. [[clause-satisfaction-lookup-class|The Clause-Satisfaction Lookup Class]] is efficiently agnostically improperly learnable but fails efficient proper realizable learning unless $\mathrm{NP}\nsubseteq\mathrm{RP}$. [[fixed-k-term-DNF|Fixed-$k$-Term DNF]] is weakly properly learnable but fails strong proper realizable learning unless $\mathrm{RP}=\mathrm{NP}$.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "efficient-realizable-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "efficient-realizable-proper-pac"
SORT source ASC
```
