---
type: argument
id: multiclass-realizable-boosting
title: Multiclass Realizable Boosting
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
ref_keys:
- schapire1990
- freund1995boosting
- mukherjee2013multiclass
- brukhim2023boosting
refs:
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
- "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
- "[Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)"
- "[Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Realizable Boosting

## Verdict

`true`, with evidence `theorem`.

The multiclass weak axis uses the majority-accuracy convention: a weak learner has zero-one error below $1/2$ by an inverse-polynomial amount. Under this convention, boosting may output an improper vote or aggregation, so it supports the improper strong targets tracked by the edge family.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)
- [Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)
