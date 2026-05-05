---
type: witness
id: pcp-active-slice-lookup-class
title: PCP Active-Slice Lookup Class
domain: binary-classification
model: pac
assumptions:
  - "NP not subset RP"
ref_keys:
  - hastad2005query
  - karp1972
refs:
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# PCP Active-Slice Lookup Class

## Role

This witness separates weak improper realizable learning from weak proper realizable learning. Proper hypotheses encode PCP proofs for one active NP instance slice. The active slice has polynomial size, so an improper learner can memorize positive sample points. A weak proper learner, however, would produce a proof accepted on more than half of the verifier random strings for satisfiable instances, while unsatisfiable instances have PCP soundness below one half.

## References

- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
