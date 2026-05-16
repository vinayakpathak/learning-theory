---
type: witness
id: multiclass-halfspaces
title: Multiclass Embedded Halfspaces
domain: multiclass-classification
model: pac
assumptions:
- worst-case lattice hardness
ref_keys:
- tiegel2023
refs:
- "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
tags:
- atlas/witness
- learning/multiclass-classification
---

# Multiclass Embedded Halfspaces

## Role

This witness is obtained from the binary witness [[halfspaces|Halfspaces]] by fixing two labels $a,b$ in a finite multiclass label space $\mathcal Y$ with $|\mathcal Y|\ge 3$ and mapping binary labels to $a$ and $b$. The resulting class has type $\mathcal X\to\mathcal Y$, while zero-one errors and polynomial resource requirements on the active labels are preserved.

Therefore any learner or separation for the multiclass embedded class would restrict to the corresponding binary learner or separation. The extra labels are inert; their only role is to make the hypothesis class genuinely multiclass-typed.


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
