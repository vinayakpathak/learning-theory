---
type: witness
id: multiclass-binary-embedded-separations
title: Binary-Embedded Separations
domain: multiclass-classification
model: pac
assumptions: []
ref_keys:
- valiant1984
- daniely2015multiclass
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)"
tags:
- atlas/witness
- learning/multiclass-classification
---

# Binary-Embedded Separations

## Role

Let $\mathcal B\subseteq\{0,1\}^{\mathcal X}$ be a binary class and let $\mathcal Y$ be a finite label set with distinct labels $a,b$ and at least one additional label. The embedding sends each binary concept $c$ to the multiclass concept $\tilde c$ with $\tilde c(x)=a$ when $c(x)=0$ and $\tilde c(x)=b$ when $c(x)=1$.

For zero-one loss, errors are preserved under this embedding. Thus binary lower bounds remain valid multiclass lower bounds, even though the multiclass nodes have their own type and no implication edges to the binary nodes.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)
