---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
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
summary: "Weak realizable proper learning can be boosted to strong realizable improper learning, then weakened to the marginal-nonuniform target."
family: realizable-boosting
axis_delta:
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: proper-to-improper
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

Weak realizable proper learning can be boosted to strong realizable improper learning, then weakened to the marginal-nonuniform target.

## Proof Sketch

**Goal.** Obtain the target guarantee from a weak proper realizable learner.

**Boosting step.** Schapire boosting treats the weak learner as a subroutine and combines its hypotheses by a vote. The final vote can be outside $\mathcal C$, so it is an improper hypothesis.

**Why the target follows.** The boosted learner is distribution-free and polynomial-time. The target permits the polynomial bound to depend on the marginal, so the same learner works.

**Conclusion.** The implication follows from weak-to-strong boosting and weakening the uniformity requirement.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
