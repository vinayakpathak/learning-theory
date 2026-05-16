---
type: definition
id: multiclass-sample-efficient-realizable-proper-pac
title: Multiclass Sample-Efficient Realizable Proper PAC Learning
domain: multiclass-classification
model: pac
realizability: realizable
properness: proper
strength: strong
resource: sample-efficient
distribution: distribution-free
loss: zero-one
output_constraint: proper
sample_complexity: polynomial
runtime: unrestricted
characterization_status: known
characterization: Finite-label multiclass sample learnability is characterized by the multiclass dimension theory; runtime is unrestricted.
characterization_ref_keys:
- valiant1984
- daniely2014optimal
- daniely2015multiclass
- brukhim2022
- cohen2025multiclass
characterization_refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)"
- "[Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)"
- "[Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)"
- "[Cohen et al. 2025](https://arxiv.org/abs/2511.12659)"
tags:
- atlas/definition
- learning/multiclass-classification
label_space: finite-multiclass
label_count: finite, at least 3
weak_convention: majority-accuracy
---

# Multiclass Sample-Efficient Realizable Proper PAC Learning

## Definition

A multiclass class is a set $\mathcal C\subseteq \mathcal Y^{\mathcal X}$ with finite label space $\mathcal Y$ and $|\mathcal Y|\ge 3$. The finite label alphabet is part of the learning problem, so these nodes are kept separate from the binary-classification nodes even when a class uses only two labels.

A learner receives i.i.d. labeled examples $(x,c(x))$, where $x \sim P$ and $c \in \mathcal C$. With probability at least $1-\delta$, it must output $h\in\mathcal C$ such that

$$
\operatorname{err}_P(h,c) \le \varepsilon.
$$

Only the sample size must be polynomially bounded. Computation is unrestricted, so exhaustive search and nonconstructive learners are allowed.

One polynomial bound must work uniformly over all instance marginals.

## Characterization Status

`known`: Finite-label multiclass sample learnability is characterized by the multiclass dimension theory; runtime is unrestricted.

## Boundary Examples

Binary separation classes embed into this finite multiclass setting by choosing two labels $a,b\in\mathcal Y$ and mapping $0$ to $a$ and $1$ to $b$. The extra labels are inert, and zero-one error is preserved. This gives multiclass versions of the computational and sample-to-computational boundary examples recorded in [[multiclass-binary-embedded-separations|Binary-Embedded Separations]].

For sample-complexity boundaries, finite-label multiclass learning is governed by multiclass dimensions rather than plain VC dimension. The notes cite the Natarajan/graph-dimension and DS-dimension literature where those distinctions matter.


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)
- [Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)
- [Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)
- [Cohen et al. 2025](https://arxiv.org/abs/2511.12659)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/multiclass/implications"
WHERE type = "implication" AND source = "multiclass-sample-efficient-realizable-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/multiclass/implications"
WHERE type = "implication" AND target = "multiclass-sample-efficient-realizable-proper-pac"
SORT source ASC
```
