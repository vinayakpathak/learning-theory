---
type: witness
id: clause-satisfaction-lookup-class
title: Clause-Satisfaction Lookup Class
domain: binary-classification
model: pac
assumptions:
  - "NP not subset RP"
ref_keys:
  - blumer1989
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# Clause-Satisfaction Lookup Class

## Role

This witness separates improper learning from proper learning. The instance domain consists of polynomially many clauses, so an improper lookup-table learner can compete with the class. Proper hypotheses encode assignments, and a highly accurate proper learner on realizable clause distributions would solve 3-SAT with one-sided randomized error.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
