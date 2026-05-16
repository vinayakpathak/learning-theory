---
type: witness
id: multiclass-fixed-k-term-DNF
title: Multiclass Embedded Fixed-k-Term DNF
domain: multiclass-classification
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
- learning/multiclass-classification
---

# Multiclass Embedded Fixed-k-Term DNF

## Role

This witness is obtained from the binary witness [[fixed-k-term-DNF|Fixed-k-Term DNF]] by fixing two labels $a,b$ in a finite multiclass label space $\mathcal Y$ with $|\mathcal Y|\ge 3$ and mapping binary labels to $a$ and $b$. The resulting class has type $\mathcal X\to\mathcal Y$, while zero-one errors and polynomial resource requirements on the active labels are preserved.

Therefore any learner or separation for the multiclass embedded class would restrict to the corresponding binary learner or separation. The extra labels are inert; their only role is to make the hypothesis class genuinely multiclass-typed.


## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- `pitt1988`
- `haussler1990`
