---
type: witness
id: multiclass-one-way-image-coordinate-class
title: Multiclass Embedded One-Way Image Coordinate Class
domain: multiclass-classification
model: pac
assumptions:
- length-preserving one-way functions exist
ref_keys:
- kearns1994cryptographic
- hastad1999prg
refs:
- "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
- "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
tags:
- atlas/witness
- learning/multiclass-classification
---

# Multiclass Embedded One-Way Image Coordinate Class

## Role

This witness is obtained from the binary witness [[one-way-image-coordinate-class|One-Way Image Coordinate Class]] by fixing two labels $a,b$ in a finite multiclass label space $\mathcal Y$ with $|\mathcal Y|\ge 3$ and mapping binary labels to $a$ and $b$. The resulting class has type $\mathcal X\to\mathcal Y$, while zero-one errors and polynomial resource requirements on the active labels are preserved.

Therefore any learner or separation for the multiclass embedded class would restrict to the corresponding binary learner or separation. The extra labels are inert; their only role is to make the hypothesis class genuinely multiclass-typed.


## References

- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
- [hastad1999prg](https://doi.org/10.1137/S0097539793244708)
