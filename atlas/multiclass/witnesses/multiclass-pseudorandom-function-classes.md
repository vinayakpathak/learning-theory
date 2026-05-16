---
type: witness
id: multiclass-pseudorandom-function-classes
title: Multiclass Embedded Pseudorandom Function Classes
domain: multiclass-classification
model: pac
assumptions:
- standard cryptographic assumptions
ref_keys:
- goldreich1986
- kearns1994cryptographic
refs:
- "[Goldreich et al. 1986](https://doi.org/10.1145/6490.6503)"
- "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
tags:
- atlas/witness
- learning/multiclass-classification
---

# Multiclass Embedded Pseudorandom Function Classes

## Role

This witness is obtained from the binary witness [[pseudorandom-function-classes|Pseudorandom Function Classes]] by fixing two labels $a,b$ in a finite multiclass label space $\mathcal Y$ with $|\mathcal Y|\ge 3$ and mapping binary labels to $a$ and $b$. The resulting class has type $\mathcal X\to\mathcal Y$, while zero-one errors and polynomial resource requirements on the active labels are preserved.

Therefore any learner or separation for the multiclass embedded class would restrict to the corresponding binary learner or separation. The extra labels are inert; their only role is to make the hypothesis class genuinely multiclass-typed.


## References

- [goldreich1986](https://doi.org/10.1145/6490.6503)
- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
