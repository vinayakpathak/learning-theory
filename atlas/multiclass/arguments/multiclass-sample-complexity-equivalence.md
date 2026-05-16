---
type: argument
id: multiclass-sample-complexity-equivalence
title: Multiclass Sample-Complexity Equivalence
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
ref_keys:
- daniely2014optimal
- daniely2015multiclass
- brukhim2022
- cohen2025multiclass
- benedek1991fixed
- hanneke2025marginalnonuniform
refs:
- "[Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)"
- "[Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)"
- "[Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)"
- "[Cohen et al. 2025](https://arxiv.org/abs/2511.12659)"
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Sample-Complexity Equivalence

## Verdict

`true`, with evidence `theorem`.

For finite label spaces, multiclass PAC sample complexity is controlled by multiclass combinatorial dimensions rather than plain VC dimension. The atlas uses those results to keep the sample-only nodes comparable across realizable, agnostic, weak, strong, proper, and improper variants, while keeping computational questions separate.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)
- [Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)
- [Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)
- [Cohen et al. 2025](https://arxiv.org/abs/2511.12659)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
