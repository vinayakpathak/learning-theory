---
type: implication
id: efficient-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "The target is the same realizable improper guarantee with the distribution-free polynomial bound relaxed to a marginal-dependent one."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: same
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

The target is the same realizable improper guarantee with the distribution-free polynomial bound relaxed to a marginal-dependent one.

## Proof

**Goal.** Convert a distribution-free realizable improper learner into the marginal-nonuniform version.

**Construction.** Use the same learner. It already outputs an allowed improper hypothesis with error at most $\varepsilon$ on every realizable distribution.

**Why the construction works.** A distribution-free polynomial bound is a special case of a marginal-dependent polynomial bound: for every marginal $P$, set $p_P$ equal to the source polynomial.

**Conclusion.** The implication is immediate from weakening the uniformity requirement.
