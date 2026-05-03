---
type: implication
id: efficient-weak-agnostic-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-weak-agnostic-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source learner."
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

# Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`.

The target only relaxes requirements already met by the source learner.

## Proof

**Goal.** Show that the source learner already satisfies the target requirements.

**Construction.** Run the source learner unchanged. If the target is realizable and the source is agnostic, restrict attention to realizable labeled distributions, where the benchmark error is zero. If the target is improper and the source is proper, the same proper output is allowed. If the target is weak and the source is strong, run the strong learner with a fixed constant accuracy parameter.

**Distribution dependence.** If the source is distribution-free and the target is marginal-nonuniform, use the same source polynomial as $p_P$ for every marginal $P$. If both notions are marginal-nonuniform, use the source polynomial for the same marginal.

**Conclusion.** Every target requirement is a relaxation of a source requirement.
