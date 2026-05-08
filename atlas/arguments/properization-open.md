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
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
  - plotkin1960
  - mceliece1977
  - guruswami2010list
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Plotkin 1960](https://doi.org/10.1109/TIT.1960.1057584)"
  - "[McEliece et al. 1977](https://doi.org/10.1109/TIT.1977.1055688)"
  - "[Guruswami and Vadhan 2010](https://doi.org/10.1109/TIT.2010.2070170)"
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

The depth-limited weak-properization search sharpened the remaining obstruction. On realizable labels, an agnostic improper learner can give an external predictor close to some $c^\star\in\mathcal C$, but the target asks for an efficient proper concept with even inverse-polynomial advantage under the same fixed marginal. This would follow from extra representation-level structure such as computable $L_1(P)$ covers by valid concepts, fixed-marginal proper ERM, effective finite support plus proper consistency search, or a constant-slack projection oracle. None is implied by the abstract improper source. Conversely, current false-witness templates still miss the weak marginal-nonuniform target: PCP active slices vary the marginal, one-way coordinate classes give strong recovery hardness but leak weak handles, and shared-code repairs run into a tension between weak-safe geometry and easy agnostic improper lookup learning.

The shared-code obstruction is quantitative. Exact safety would need every wrong proper certificate to have nonpositive correlation with the challenge labels, but Plotkin/Hadamard-style bounds allow only linearly many such binary codewords on an explicit coordinate domain. Approximate safety permits exponentially many certificates only by leaving inverse-polynomial residual correlations on polynomial-size domains, as reflected by coding and list-decoding bounds near distance $1/2$. Since the weak target hides the marginal-dependent inverse-polynomial advantage, those residual correlations can remain legal weak handles. Amplifying over all exponents either makes the coordinate domain superpolynomial for lookup ERM or merely moves the exponent into the representation size.

For finite-encoded computational witnesses there is an additional fixed-marginal obstruction. Any fixed countable marginal has a largest atom, and a large binary proper family contains a large subfamily that agrees on that atom. The positive-semidefinite Gram matrix on the remaining atoms then blocks exact or hidden-gap-safe pairwise orthogonality for an unbounded family. Thus a pure geometry construction cannot make every wrong proper hypothesis non-correlated under one fixed marginal. A future false witness for the weak marginal-nonuniform properization edges would need computational weak-handle hardness: weakly correlated non-witness proper hypotheses may exist, but finding any of them would itself have to be hard.

The one-way Hadamard image attempt is the sharpest model-boundary example. At one fixed length, an improper learner can recover the one-way image as a parity coefficient, and exact Hadamard orthogonality forces any positive-correlation proper output to invert. Low-noise robustification can make the weak agnostic improper source plausible at that length. But making one fixed finite-encoded marginal work across all hard lengths reintroduces active-mass dilution, wrong-length/default handles, or the finite-atom orthogonality barrier. If the atlas ever permits atomless product examples or oracle-valued infinite random strings as computational samples, this route should be revisited; under the present finite-transcript convention it remains only a diagnostic.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Plotkin 1960](https://doi.org/10.1109/TIT.1960.1057584)
- [McEliece et al. 1977](https://doi.org/10.1109/TIT.1977.1055688)
- [Guruswami and Vadhan 2010](https://doi.org/10.1109/TIT.2010.2070170)
