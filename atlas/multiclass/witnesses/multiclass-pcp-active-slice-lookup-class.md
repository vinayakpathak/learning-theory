---
type: witness
id: multiclass-pcp-active-slice-lookup-class
title: Multiclass Embedded PCP Active-Slice Lookup Class
domain: multiclass-classification
model: pac
assumptions:
- NP not subset RP
ref_keys:
- hastad2005query
- karp1972
refs:
- "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
- "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
tags:
- atlas/witness
- learning/multiclass-classification
---

# Multiclass Embedded PCP Active-Slice Lookup Class

## Role

This witness is obtained from the binary witness [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] by fixing two labels $a,b$ in a finite multiclass label space $\mathcal Y$ with $|\mathcal Y|\ge 3$ and mapping binary labels to $a$ and $b$. The resulting class has type $\mathcal X\to\mathcal Y$, while zero-one errors and polynomial resource requirements on the active labels are preserved.

Therefore any learner or separation for the multiclass embedded class would restrict to the corresponding binary learner or separation. The extra labels are inert; their only role is to make the hypothesis class genuinely multiclass-typed.


## References

- [hastad2005query](https://theoryofcomputing.org/articles/v001a007/)
- [karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
