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
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Properization Open

## Verdict

`open`.

This family records computationally efficient edges where the source allows an improper learner but the target requires a proper learner, and no generic polynomial-time properization theorem is known in the atlas model. In the sample-efficient layer, unbounded empirical risk minimization removes this as a computational obstruction; those edges are handled by [[sample-complexity-equivalence|Sample-Complexity Equivalence]], including the marginal-to-distribution-free sample cases covered by the marginal-nonuniform trichotomy.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
