---
type: argument
id: realizable-boosting
title: Realizable Boosting
domain: binary-classification
model: pac
status: "true"
evidence: theorem
ref_keys:
  - schapire1990
  - freund1995boosting
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Realizable Boosting

## Verdict

`true`.

Schapire's weak-to-strong boosting theorem and Freund's boost-by-majority convert weak realizable learning into strong realizable learning with an improper final hypothesis, since the boosted vote need not lie in the original class. In implication notes, this family covers edges whose source gives a weak realizable learner, or gives a weak agnostic learner that specializes to weak realizable learning on realizable distributions.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
