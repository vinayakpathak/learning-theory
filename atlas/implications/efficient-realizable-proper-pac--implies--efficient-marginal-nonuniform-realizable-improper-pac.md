---
type: implication
id: efficient-realizable-proper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-realizable-proper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "A proper distribution-free realizable learner is also an improper marginal-nonuniform realizable learner."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: same
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

A proper distribution-free realizable learner is also an improper marginal-nonuniform realizable learner.

## Proof

**Goal.** Produce a target learner from the source learner.

**Construction.** Run the proper realizable learner. Its output $h\in\mathcal C$ is allowed in the improper target.

**Why the construction works.** The source learner has a uniform polynomial sample and time bound over all marginals. The target permits a separate polynomial $p_P$ for each marginal, so the uniform source polynomial can be reused as every $p_P$.

**Conclusion.** Properness and distribution-free uniformity are both stronger than the corresponding target requirements.
