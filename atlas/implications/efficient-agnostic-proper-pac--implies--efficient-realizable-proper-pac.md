---
type: implication
id: efficient-agnostic-proper-pac__implies__efficient-realizable-proper-pac
source: efficient-agnostic-proper-pac
target: efficient-realizable-proper-pac
source_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
target_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
assumptions: []
witnesses: []
refs: []
summary: "An agnostic proper learner specializes to a realizable proper learner when the optimum benchmark error is zero."
family: monotone-relaxation
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[monotone-relaxation|Monotone Relaxation]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Proper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`true`, trivially.

On realizable distributions, the benchmark error is zero:

$$
\inf_{c \in \mathcal C}\operatorname{err}_{\mathcal D}(c)=0.
$$

A proper agnostic learner therefore returns a proper hypothesis with error at most $\varepsilon$.
