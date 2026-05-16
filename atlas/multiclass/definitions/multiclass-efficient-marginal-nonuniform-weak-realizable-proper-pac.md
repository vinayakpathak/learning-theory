---
type: definition
id: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac
title: Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning
domain: multiclass-classification
model: pac
realizability: realizable
properness: proper
strength: weak
resource: computationally-efficient
distribution: marginal-nonuniform
loss: zero-one
output_constraint: proper
sample_complexity: marginal-dependent-polynomial-weak
runtime: marginal-dependent-polynomial-weak
characterization_status: partial
characterization: The sample-complexity analogue is governed by multiclass dimension theory, but polynomial-time learnability remains representation-sensitive.
characterization_ref_keys:
- valiant1984
- daniely2014optimal
- daniely2015multiclass
- brukhim2022
- cohen2025multiclass
- schapire1990
- freund1995boosting
- mukherjee2013multiclass
- brukhim2023boosting
characterization_refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)"
- "[Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)"
- "[Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)"
- "[Cohen et al. 2025](https://arxiv.org/abs/2511.12659)"
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
- "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
- "[Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)"
- "[Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)"
tags:
- atlas/definition
- learning/multiclass-classification
label_space: finite-multiclass
label_count: finite, at least 3
weak_convention: majority-accuracy
---

# Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Definition

A multiclass class is a set $\mathcal C\subseteq \mathcal Y^{\mathcal X}$ with finite label space $\mathcal Y$ and $|\mathcal Y|\ge 3$. The finite label alphabet is part of the learning problem, so these nodes are kept separate from the binary-classification nodes even when a class uses only two labels.

A learner receives i.i.d. labeled examples $(x,c(x))$, where $x \sim P$ and $c \in \mathcal C$. With probability at least $1-\delta$, it must output $h\in\mathcal C$ such that

$$
\operatorname{err}_P(h,c) \le \frac{1}{2}-\gamma.
$$

The weak axis deliberately uses the same majority-accuracy threshold as the binary atlas. It is stronger than merely beating uniform random guessing over $k$ labels, but it gives a clean comparison with the binary implication graph.

Both sample complexity and running time must be bounded by a polynomial in the representation size, the relevant accuracy parameter, $\log(1/\delta)$, and the finite label-set description size.

The learner is marginal-nonuniform: for each fixed instance marginal $P$, the polynomial bound may depend on $P$, while remaining uniform over targets or conditional label distributions with that marginal.

## Characterization Status

`partial`: The sample-complexity analogue is governed by multiclass dimension theory, but polynomial-time learnability remains representation-sensitive.

## Boundary Examples

Binary separation classes embed into this finite multiclass setting by choosing two labels $a,b\in\mathcal Y$ and mapping $0$ to $a$ and $1$ to $b$. The extra labels are inert, and zero-one error is preserved. This gives multiclass versions of the computational and sample-to-computational boundary examples recorded in [[multiclass-binary-embedded-separations|Binary-Embedded Separations]].

For sample-complexity boundaries, finite-label multiclass learning is governed by multiclass dimensions rather than plain VC dimension. The notes cite the Natarajan/graph-dimension and DS-dimension literature where those distinctions matter.


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)
- [Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)
- [Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)
- [Cohen et al. 2025](https://arxiv.org/abs/2511.12659)
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)
- [Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)

## Outgoing Implications

```dataview
TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/multiclass/implications"
WHERE type = "implication" AND source = "multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac"
SORT target ASC
```

## Incoming Implications

```dataview
TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
FROM "atlas/multiclass/implications"
WHERE type = "implication" AND target = "multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac"
SORT source ASC
```
