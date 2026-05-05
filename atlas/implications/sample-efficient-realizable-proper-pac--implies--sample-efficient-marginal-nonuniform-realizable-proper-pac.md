---
type: implication
id: sample-efficient-realizable-proper-pac__implies__sample-efficient-marginal-nonuniform-realizable-proper-pac
source: sample-efficient-realizable-proper-pac
target: sample-efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[sample-efficient-realizable-proper-pac|Sample-Efficient Realizable Proper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: trivial
result_origin: "known"
assumptions: []
witnesses: []
refs: []
summary: "The target only relaxes requirements already met by the source (distribution: distribution-free-to-marginal-nonuniform)."
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

# Sample-Efficient Realizable Proper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`true`, trivially.

The same learner witnesses the target notion, because the target only relaxes requirements already imposed by the source.


