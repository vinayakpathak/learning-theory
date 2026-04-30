---
type: implication
id: efficient-weak-agnostic-proper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-weak-agnostic-proper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
summary: "Weak agnostic proper learning specializes to weak realizable learning, and Schapire boosting gives the improper strong realizable target."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

Weak agnostic proper learning specializes to weak realizable learning, and Schapire boosting gives the improper strong realizable target.

## Proof Sketch

**Goal.** Build a strong realizable improper learner with marginal-dependent polynomial bounds.

**Reduction.** Restrict the source learner to realizable distributions. Since the benchmark error is zero, the additive weak agnostic guarantee gives error below $1/2$.

**Boosting step.** Apply Schapire's weak-to-strong boosting theorem. The final majority vote need not lie in $\mathcal C$, which is allowed by the target.

**Conclusion.** The result is a distribution-free strong realizable improper learner, hence also a marginal-nonuniform one.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
