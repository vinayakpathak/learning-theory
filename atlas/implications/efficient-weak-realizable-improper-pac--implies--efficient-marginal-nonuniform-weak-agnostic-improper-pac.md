---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
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
summary: "A distribution-free weak realizable improper learner can be robustified into an improper weak agnostic learner with an inverse-polynomial marginal-nonuniform gap."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`.

The distribution-free weak realizable source can be robustified into the marginal-nonuniform weak agnostic improper target.

## Proof Status

**Goal.** Build a weak agnostic learner from a distribution-free weak realizable learner.

**Construction.** Run the weak realizable learner on many small fresh batches, as if the labels were realizable, and validate the outputs together with the two constants. Let $\gamma(s)$ be the source's realizable weak advantage and $m(s)$ its sample bound. Choose the target weak gap $\alpha(s)$ smaller than both $\gamma(s)$ and $1/m(s)$ by a fixed polynomial factor.

If $\operatorname{OPT}_{\mathcal C}\ge 2\alpha(s)$, a constant classifier has error at most $1/2$ and already meets the weak agnostic guarantee. If $\operatorname{OPT}_{\mathcal C}<2\alpha(s)$, a fresh batch is clean relative to a best concept with inverse-polynomial probability. On such a batch the weak learner returns a hypothesis with advantage $\gamma(s)$ under the clean conditional marginal, and total-variation stability transfers an inverse-polynomial advantage back to the original agnostic distribution.

**Conclusion.** Polynomial repetition and validation give the target learner.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
