---
type: implication
id: efficient-marginal-nonuniform-agnostic-proper-pac__implies__efficient-weak-realizable-improper-pac
source: efficient-marginal-nonuniform-agnostic-proper-pac
target: efficient-weak-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
target_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: agnostic-to-realizable
  properness: proper-to-improper
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Agnostic Proper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`open`.

Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound.

## Proof Status

**Goal.** Decide whether a marginal-dependent polynomial guarantee can be made distribution-free.

**Obstacle.** The source permits a different polynomial $p_P$ for each marginal $P$. The target requires one polynomial bound that works uniformly over all marginals. The definition gives no quantitative control over how the polynomial changes with $P$.

**Known context.** Fixed-distribution and marginal-nonuniform learning were introduced to study exactly this relaxation of uniform PAC bounds. The known characterizations are primarily information-theoretic and do not yield a representation-sensitive computational uniformization theorem for this edge.

**Conclusion.** The edge remains open in this atlas. A proof would need a uniformization theorem; a counterexample would need a class with polynomial learning for each fixed marginal but no distribution-free polynomial learner for the target notion.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
