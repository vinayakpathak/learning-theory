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
  - freund1995boosting
  - benedek1991fixed
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Marginal-Nonuniform Boosting Open

## Verdict

`open`.

This family records edges where boosting would have to preserve one polynomial bound that may depend on the marginal distribution. Standard realizable boosting explains the distribution-free weak-to-strong direction, but it does not by itself settle the marginal-dependent rate bookkeeping used by these nodes.

The obstruction is not merely that the final boosted hypothesis is improper. Schapire-style and boost-by-majority procedures call the weak learner on filtered or reweighted example distributions. Freund's boost-by-majority analysis includes distribution-dependent weak accuracy as a near miss, but it still needs quantitative control over how the weak guarantee behaves on those induced distributions. The atlas marginal-nonuniform nodes only promise a polynomial for each marginal separately, so they do not supply one original-marginal polynomial controlling every reweighted marginal generated during boosting.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
