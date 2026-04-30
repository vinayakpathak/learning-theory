---
type: implication
id: efficient-agnostic-proper-pac__implies__efficient-realizable-improper-pac
source: efficient-agnostic-proper-pac
target: efficient-realizable-improper-pac
source_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
target_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "Agnostic proper learning implies realizable proper learning, and proper learning is a special case of improper learning."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Proper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`true`, trivially.

This is the composition of two monotonicities: agnostic implies realizable, and proper implies improper.
