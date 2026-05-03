---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-weak-realizable-improper-pac
source: efficient-agnostic-improper-pac
target: efficient-weak-realizable-improper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "This follows by weakening one or more requirements: agnostic to realizable, proper to improper, or strong to weak."
family: monotone-relaxation
axis_delta:
  distribution: same
  strength: strong-to-weak
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`.

This follows by weakening one or more requirements: agnostic to realizable, proper to improper, or strong to weak.

## Proof

The target notion only relaxes requirements already met by the source learner. On realizable distributions the agnostic optimum is zero, proper hypotheses are allowed in the improper model, and a strong learner can be run with a fixed weak accuracy parameter. The same efficient learner therefore witnesses the target node.
