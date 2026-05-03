---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - tiegel2023
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Open: known distribution-free agnostic hardness reductions do not automatically rule out marginal-dependent polynomial bounds."
family: marginal-agnostic-hardness-open
axis_delta:
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`open`.

Open: known distribution-free agnostic hardness reductions do not automatically rule out marginal-dependent polynomial bounds.

## Proof Status

**Goal.** Decide whether a realizable marginal-nonuniform learner implies the agnostic marginal-nonuniform target.

**Obstacle.** A realizable learner only has to compete with zero noise. The agnostic target must compete with the best concept under arbitrary label noise, uniformly over all conditional label distributions sharing the same marginal.

**Why known hardness is insufficient.** Distribution-free agnostic hardness results, such as Tiegel's halfspace lower bound, use hard families of distributions. They refute distribution-free targets, but they do not automatically refute a model whose polynomial may depend on the marginal distribution.

**Conclusion.** The edge remains open for the marginal-nonuniform target.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
