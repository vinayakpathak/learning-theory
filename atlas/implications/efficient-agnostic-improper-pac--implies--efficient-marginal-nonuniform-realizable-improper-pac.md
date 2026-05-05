---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-agnostic-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "A distribution-free strong agnostic improper learner restricts to realizable data and remains valid when the polynomial bound is allowed to depend on the marginal."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

A distribution-free strong agnostic improper learner restricts to realizable data and remains valid when the polynomial bound is allowed to depend on the marginal.

## Proof

**Goal.** Produce a marginal-nonuniform realizable improper learner.

**Construction.** Run the agnostic improper learner on realizable examples $(X,c(X))$. Since the benchmark error is $0$, the agnostic guarantee with accuracy $\varepsilon$ gives a hypothesis $h$ with $\operatorname{err}_P(h,c)\le\varepsilon$.

**Why the running-time requirement holds.** The source learner has one distribution-free polynomial bound. For each marginal $P$, use that same polynomial as $p_P$.

**Conclusion.** The source learner satisfies every requirement of the target node after restricting to realizable distributions.
