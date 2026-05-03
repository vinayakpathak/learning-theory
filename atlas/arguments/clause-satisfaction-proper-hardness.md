---
type: argument
id: clause-satisfaction-proper-hardness
title: Clause-Satisfaction Proper Hardness
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - clause-satisfaction-lookup-class
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
assumptions:
  - "NP not subset RP"
ref_keys:
  - blumer1989
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Clause-Satisfaction Proper Hardness

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The clause-satisfaction lookup class is efficiently agnostically learnable by an improper lookup-table learner. Proper hypotheses encode assignments, so a sufficiently accurate proper realizable learner would yield a randomized polynomial-time one-sided algorithm for 3-SAT.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
