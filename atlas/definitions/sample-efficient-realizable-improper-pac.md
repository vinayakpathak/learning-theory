---
type: definition
id: sample-efficient-realizable-improper-pac
title: Sample-Efficient Realizable Improper PAC Learning
domain: binary-classification
model: pac
realizability: realizable
properness: improper
strength: strong
resource: sample-efficient
distribution: distribution-free
loss: zero-one
output_constraint: improper
sample_complexity: polynomial
runtime: unrestricted
characterization_status: known
characterization: "Finite VC dimension characterizes the corresponding binary distribution-free sample-complexity notion; runtime is unrestricted."
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

# Sample-Efficient Realizable Improper PAC Learning

## Definition

A learner receives i.i.d. labeled examples $(x,c(x))$, where $x \sim D$ for an arbitrary distribution $D$ over $\mathcal X$ and $c \in \mathcal C$.

With probability at least $1-\delta$, it must output a hypothesis $h$, possibly outside $\mathcal C$, such that

$$
\operatorname{err}_D(h,c) \le \varepsilon.
$$

This is the strong version of the notion: the learner must achieve every requested accuracy parameter $\varepsilon>0$.

The learner is sample-efficient when the number of samples is bounded by one polynomial in the relevant representation size, $1/\varepsilon$, and $\log(1/\delta)$. No polynomial running-time requirement is imposed; the learner may use unbounded computation, such as exhaustive empirical risk minimization.

## Characterization Status

`known`: Finite VC dimension characterizes the corresponding binary distribution-free sample-complexity notion; runtime is unrestricted.

## Boundary Examples

Positive examples include any finite-VC class, since unbounded empirical risk minimization is allowed. [[pseudorandom-function-classes|Pseudorandom Function Classes]] are especially useful boundary examples for the new resource axis: they satisfy this sample-efficient node but fail the corresponding computationally efficient weak realizable targets under standard cryptographic assumptions.

Negative examples are classes with no finite-sample control. [[unrestricted-labelings|Unrestricted Labelings]] fail even the weakest realizable improper sample-efficient PAC requirement under a nonatomic marginal, so they also fail this node when its requirements are stronger.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND source = "sample-efficient-realizable-improper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND target = "sample-efficient-realizable-improper-pac"
SORT source ASC
```
