---
type: witness
id: polynomial-time-erm-classes
title: Polynomial-Time ERM Classes
domain: binary-classification
model: pac
assumptions: []
ref_keys:
  - valiant1984
  - blumer1989
  - kearns1994
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# Polynomial-Time ERM Classes

## Role

This witness records the standard positive baseline for the strongest proper agnostic nodes. If a class has polynomial sample complexity and admits a polynomial-time empirical risk minimization procedure over the proper class, then the ERM learner is an efficient proper agnostic PAC learner.

This is not meant as a sharp separation witness. Its role is to mark the top of the atlas as nonempty: familiar simple classes with efficient ERM, such as finite polynomial-size classes, thresholds, intervals, and other low-complexity classes with explicit optimization procedures, satisfy the strongest node and hence all monotone relaxations.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)
