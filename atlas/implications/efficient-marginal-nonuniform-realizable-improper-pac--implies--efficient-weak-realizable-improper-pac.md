---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-weak-realizable-improper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-weak-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
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
summary: "Open: the target needs a distribution-free polynomial weak learner, while the source only gives strong learning with marginal-dependent polynomial bounds."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`open`.

Open: the target needs a distribution-free polynomial weak learner, while the source only gives strong learning with marginal-dependent polynomial bounds.

## Proof Status

**Goal.** Decide whether strong marginal-nonuniform realizable learning gives even weak distribution-free realizable learning.

**Why this is not immediate.** The source learner may have a different polynomial $p_P$ for each marginal $P$. A weak distribution-free learner needs one polynomial bound and one inverse-polynomial advantage that work uniformly over all marginals.

**Known routes.** If the source bound could be made distribution-free, then the target would follow immediately by weakening strong learning to weak learning. But that is exactly the unresolved uniformization issue recorded in the edge to efficient realizable improper PAC learning.

**Conclusion.** The edge remains open. A proof would need to extract a uniform weak guarantee from marginal-dependent strong guarantees; a counterexample would need to show that distribution-dependent strong learning can fail to provide any uniform weak learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
