---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__sample-efficient-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: sample-efficient-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[sample-efficient-weak-realizable-proper-pac|Sample-Efficient Weak Realizable Proper PAC Learning]]"
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
summary: "Open: the source allows marginal-dependent polynomial sample bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Sample-Efficient Weak Realizable Proper PAC Learning

## Verdict

`open`.

## Proof Status

**Goal.** Decide whether a marginal-dependent polynomial sample bound can be replaced by one distribution-free polynomial bound for [[sample-efficient-weak-realizable-proper-pac|Sample-Efficient Weak Realizable Proper PAC Learning]].

**Obstacle.** The source permits a different polynomial $p_P$ for each marginal distribution $P$. The target requires one polynomial that works uniformly over all marginals. The source definition gives no quantitative control over how $p_P$ varies with $P$.

**Conclusion.** The edge remains open in this atlas. A proof would need a uniformization theorem; a counterexample would need a class with polynomial learning for each fixed marginal but no distribution-free polynomial sample bound for the target notion.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
