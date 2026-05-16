---
type: witness
id: multiclass-unrestricted-labelings
title: Multiclass Embedded Unrestricted Labelings
domain: multiclass-classification
model: pac
assumptions: []
ref_keys:
- valiant1984
- blumer1989
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
tags:
- atlas/witness
- learning/multiclass-classification
---

# Multiclass Embedded Unrestricted Labelings

## Role

This witness is obtained from the binary witness [[unrestricted-labelings|Unrestricted Labelings]] by fixing two labels $a,b$ in a finite multiclass label space $\mathcal Y$ with $|\mathcal Y|\ge 3$ and mapping binary labels to $a$ and $b$. The resulting class has type $\mathcal X\to\mathcal Y$, while zero-one errors and polynomial resource requirements on the active labels are preserved.

Therefore any learner or separation for the multiclass embedded class would restrict to the corresponding binary learner or separation. The extra labels are inert; their only role is to make the hypothesis class genuinely multiclass-typed.


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
