---
type: argument
id: marginal-uniformization-open
title: Marginal Uniformization Open
domain: binary-classification
model: pac
status: "open"
evidence: unknown
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Marginal Uniformization Open

## Verdict

`open`.

This family records computational edges from marginal-nonuniform nodes to distribution-free nodes. The source may use a polynomial running-time bound depending on the marginal distribution, while the target asks for one polynomial-time bound uniform over all marginals.

The analogous sample-only polynomial-rate question is no longer recorded as open here. Hanneke, Moran, and Thiessen's marginal-nonuniform trichotomy implies that polynomial marginal-nonuniform sample rates force finite VC dimension, and standard VC theory then gives the distribution-free sample-efficient nodes.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
