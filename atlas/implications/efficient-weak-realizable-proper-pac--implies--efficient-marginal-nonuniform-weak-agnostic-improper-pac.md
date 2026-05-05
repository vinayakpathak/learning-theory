---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "unclear"
assumptions: []
witnesses: []
ref_keys:
  - valiant1984
  - blumer1989
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: "A distribution-free weak realizable proper learner can be robustified into an improper weak agnostic learner with an inverse-polynomial marginal-nonuniform gap."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`.

The distribution-free weak realizable proper source can be robustified into the marginal-nonuniform weak agnostic improper target.

## Proof Status

**Goal.** Build a weak agnostic learner from a distribution-free weak realizable learner.

**Construction.** Run the weak realizable learner on many small fresh batches and validate its outputs together with the two constants. The target is improper, so the robustified learner may output either a proper hypothesis from the source learner or a constant classifier.

If $\operatorname{OPT}_{\mathcal C}$ is not tiny, a constant classifier suffices for the weak agnostic guarantee. If $\operatorname{OPT}_{\mathcal C}$ is below the chosen inverse-polynomial gap, then a small batch is clean relative to a best concept with inverse-polynomial probability. The source learner applies to the clean conditional marginal because its guarantee is distribution-free; total-variation stability transfers the weak advantage back to the original agnostic distribution.

**Conclusion.** Polynomial repetition and validation give the target learner.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
