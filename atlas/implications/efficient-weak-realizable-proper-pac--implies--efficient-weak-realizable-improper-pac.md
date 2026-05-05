---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-weak-realizable-improper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-weak-realizable-improper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "This follows by weakening one or more requirements: agnostic to realizable, proper to improper, or strong to weak."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: proper-to-improper
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`.

This follows by weakening one or more requirements: agnostic to realizable, proper to improper, or strong to weak.

## Proof

The target notion only relaxes requirements already met by the source learner. On realizable distributions the agnostic optimum is zero, proper hypotheses are allowed in the improper model, and a strong learner can be run with a fixed weak accuracy parameter. The same efficient learner therefore witnesses the target node.
