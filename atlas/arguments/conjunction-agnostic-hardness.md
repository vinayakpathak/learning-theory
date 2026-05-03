---
type: argument
id: conjunction-agnostic-hardness
title: Conjunction Agnostic Hardness
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - conjunctions
witness_note: "[[conjunctions|Conjunctions]]"
assumptions:
  - RP != NP
ref_keys:
  - valiant1984
  - kearns1994
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Conjunction Agnostic Hardness

## Verdict

`false`, under the assumption $\mathrm{RP}\ne\mathrm{NP}$.

Conjunctions are efficiently learnable in the realizable proper PAC model, but the existing implication notes use them as a conditional separation against agnostic proper learning.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)
