---
type: implication
id: efficient-agnostic-proper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-agnostic-proper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "This follows by weakening one or more requirements: agnostic to realizable, proper to improper, or strong to weak."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Proper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`true`.

This follows by weakening one or more requirements: agnostic to realizable, proper to improper, or strong to weak.

## Proof

The target notion only relaxes requirements already met by the source learner. On realizable distributions the agnostic optimum is zero, proper hypotheses are allowed in the improper model, and a strong learner can be run with a fixed weak accuracy parameter. The same efficient learner therefore witnesses the target node.
