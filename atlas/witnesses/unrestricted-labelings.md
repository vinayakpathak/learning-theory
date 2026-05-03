---
type: witness
id: unrestricted-labelings
title: Unrestricted Labelings
domain: binary-classification
model: pac
assumptions: []
ref_keys:
  - valiant1984
  - blumer1989
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# Unrestricted Labelings

## Role

This witness records an absolute impossibility baseline, not a sharp separation between adjacent atlas nodes. Let the instance space contain a nonatomic part, such as $[0,1]$ with Lebesgue marginal, and let the concept class contain all measurable binary labelings of that space. In the realizable setting, finitely many samples reveal labels only on the sampled points; the target can still disagree arbitrarily on almost all unseen points.

Consequently, no finite-sample learner can guarantee nontrivial error for this class under that marginal, even before imposing properness, distribution-free uniformity, or agnostic excess-error requirements. The example is useful in definition notes whose nearest sharper boundary question is still open in the atlas.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
