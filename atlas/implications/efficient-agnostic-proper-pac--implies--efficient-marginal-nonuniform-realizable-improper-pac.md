---
type: implication
id: efficient-agnostic-proper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-agnostic-proper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "Proper strong agnostic learning is stronger than the marginal-nonuniform realizable improper target."
family: monotone-relaxation
axis_delta:
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: agnostic-to-realizable
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

Proper strong agnostic learning is stronger than the marginal-nonuniform realizable improper target.

## Proof

**Goal.** Produce a marginal-nonuniform realizable improper learner.

**Construction.** On realizable examples, the agnostic optimum over $\mathcal C$ is $0$. Run the proper agnostic learner with accuracy $\varepsilon$. Its output lies in $\mathcal C$, which is allowed because the target permits improper output.

**Why the distribution dependence is harmless.** The source has a distribution-free polynomial sample and time bound. The target permits the polynomial to depend on $P$, so the same uniform polynomial works for every $P$.

**Conclusion.** The source node implies the target by weakening agnostic to realizable, proper to improper, and distribution-free to marginal-nonuniform.
