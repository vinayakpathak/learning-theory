---
type: witness
id: fixed-k-term-DNF
title: Fixed-k-Term DNF
domain: binary-classification
model: pac
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
  - atlas/witness
  - learning/binary-classification
---

# Fixed-k-Term DNF

## Role

Fixed-$k$-term DNF witnesses proper weak-to-strong separation edges. The atlas notes use it for cases where weak proper learning is available but strong proper learning would contradict the cited hardness results unless $\mathrm{RP}=\mathrm{NP}$.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
