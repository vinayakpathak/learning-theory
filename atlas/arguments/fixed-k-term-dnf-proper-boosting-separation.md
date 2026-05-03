---
type: argument
id: fixed-k-term-dnf-proper-boosting-separation
title: Fixed-k-Term DNF Proper Boosting Separation
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - fixed-k-term-DNF
witness_note: "[[fixed-k-term-DNF|Fixed-k-Term DNF]]"
assumptions:
  - RP != NP
ref_keys:
  - schapire1990
  - pitt1988
  - haussler1990
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Fixed-k-Term DNF Proper Boosting Separation

## Verdict

`false`, under the assumption $\mathrm{RP}\ne\mathrm{NP}$.

Fixed-$k$-term DNF gives the atlas's proper weak-to-strong separation family. The class is weakly properly learnable, but strong proper realizable learning is hard under the stated complexity assumption.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
