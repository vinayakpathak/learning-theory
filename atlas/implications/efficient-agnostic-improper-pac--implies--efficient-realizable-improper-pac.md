---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-realizable-improper-pac
source: efficient-agnostic-improper-pac
target: efficient-realizable-improper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "An agnostic improper learner specializes to a realizable improper learner when the optimum benchmark error is zero."
family: monotone-relaxation
axis_delta:
  distribution: same
  strength: same
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`true`, trivially.

On realizable distributions, the benchmark error is zero:

$$
\inf_{c \in \mathcal C}\operatorname{err}_{\mathcal D}(c)=0.
$$

An improper agnostic learner therefore returns an allowed hypothesis with error at most $\varepsilon$.
