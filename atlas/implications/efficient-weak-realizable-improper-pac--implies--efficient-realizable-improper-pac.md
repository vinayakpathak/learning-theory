---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-realizable-improper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-realizable-improper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
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
summary: "Schapire boosting converts weak realizable learning into strong realizable improper learning; weak agnostic learning specializes to weak realizable learning on realizable distributions."
family: realizable-boosting
axis_delta:
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`true`.

Schapire boosting converts weak realizable learning into strong realizable improper learning; weak agnostic learning specializes to weak realizable learning on realizable distributions.

## Proof Sketch

**Goal.** Derive strong realizable improper learning from the weak source node.

**Reduction.** If the source is weak agnostic, first restrict it to realizable distributions. Since $\inf_{c\in\mathcal C}\operatorname{err}(c)=0$, the additive weak agnostic guarantee gives error below $1/2$ and hence a weak realizable learner. If the source is already weak realizable, no restriction is needed.

**Boosting step.** Schapire's weak-to-strong boosting theorem repeatedly calls the weak learner under reweighted distributions and combines the returned hypotheses by a vote. The combined vote need not lie in $\mathcal C$, so the target is the improper strong realizable node.

**Conclusion.** The boosted learner achieves arbitrary realizable PAC accuracy in polynomial time, with an improper final hypothesis.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
