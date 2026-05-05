---
type: argument
id: properization-open
title: Properization Open
domain: binary-classification
model: pac
status: "open"
evidence: unknown
ref_keys:
  - schapire1990
  - pitt1988
  - khot2008dnf
  - hastad2005query
  - karp1972
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Properization Open

## Verdict

`open`.

This family records computationally efficient edges where the source allows an improper learner but the target requires a proper learner, and no generic polynomial-time properization theorem is known in the atlas model. In the sample-efficient layer, unbounded empirical risk minimization removes this as a computational obstruction; those edges are handled by [[sample-complexity-equivalence|Sample-Complexity Equivalence]], including the marginal-to-distribution-free sample cases covered by the marginal-nonuniform trichotomy.

Two subfamilies have now been carved out of this open bucket. [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]] shows, under $\mathrm{NP}\nsubseteq\mathrm{RP}$, that distribution-free weak improper realizable learning does not imply distribution-free weak proper realizable learning. [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]] shows, under one-way functions, that distribution-free strong improper realizable learning does not imply marginal-nonuniform strong proper realizable learning.

The remaining marginal-nonuniform cases are narrower. Fixed finite or effectively discrete marginals can make exhaustive properization plausible, because the relevant support or trace family may be bounded by a marginal-dependent polynomial. Classical lookup and PCP hardness attempts lose visibility when all hard instances are packed into one fixed marginal: the global error gap is multiplied by the slice mass. The one-way image-coordinate witness avoids this by making the hard target the hidden seed for one polynomial-mass coordinate block rather than one of exponentially many low-mass slices. For arbitrary continuous or infinite-support marginals, finite VC/sample theory still gives existence of proper hypotheses but not a generic polynomial-time projection back into $\mathcal C$.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
