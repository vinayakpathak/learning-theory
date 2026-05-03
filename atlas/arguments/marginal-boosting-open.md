---
type: argument
id: marginal-boosting-open
title: Marginal-Nonuniform Boosting Open
domain: binary-classification
model: pac
status: "open"
evidence: unknown
ref_keys:
  - schapire1990
  - benedek1991fixed
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Marginal-Nonuniform Boosting Open

## Verdict

`open`.

This family records edges where boosting would have to preserve one polynomial bound that may depend on the marginal distribution. Standard realizable boosting explains the distribution-free weak-to-strong direction, but it does not by itself settle the marginal-dependent rate bookkeeping used by these nodes.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
