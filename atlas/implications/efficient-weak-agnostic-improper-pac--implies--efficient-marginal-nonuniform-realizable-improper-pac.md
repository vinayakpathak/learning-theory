---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
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
summary: "On realizable distributions the weak agnostic learner becomes a weak realizable learner, and Schapire boosting gives strong realizable improper learning before weakening to marginal-nonuniform bounds."
family: realizable-boosting
axis_delta:
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

On realizable distributions the weak agnostic learner becomes a weak realizable learner, and Schapire boosting gives strong realizable improper learning before weakening to marginal-nonuniform bounds.

## Proof Sketch

**Goal.** Derive strong marginal-nonuniform realizable improper learning.

**Reduction to weak realizable learning.** On realizable examples, $\operatorname{opt}_{\mathcal C}=0$. The weak agnostic learner therefore returns a hypothesis with error at most $\beta<1/2$, giving a weak realizable learner.

**Boosting step.** Schapire's theorem boosts this weak realizable learner to arbitrary error $\varepsilon$ by combining weak hypotheses into an improper vote.

**Conclusion.** The boosted learner has a distribution-free polynomial bound, so it also satisfies the target's weaker marginal-dependent polynomial requirement.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
