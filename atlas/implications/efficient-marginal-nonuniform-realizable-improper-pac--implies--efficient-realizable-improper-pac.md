---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-realizable-improper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
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
summary: "Open: the source has a marginal-dependent polynomial bound, while the target requires one uniform polynomial over all marginals."
family: marginal-uniformization-open
axis_delta:
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: same
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`open`.

Open: the source has a marginal-dependent polynomial bound, while the target requires one uniform polynomial over all marginals.

## Proof Status

**Goal.** Decide whether marginal-dependent polynomial sample and time bounds can always be replaced by one distribution-free polynomial bound.

**What is known statistically.** Fixed-distribution and marginal-nonuniform learnability were introduced to study exactly this kind of distribution-sensitive sample behavior. Recent marginal-nonuniform work characterizes possible sample-rate behavior, but those results are information-theoretic and do not by themselves give a representation-sensitive computational uniformization theorem.

**Why the usual separations do not settle it.** Halfspaces do not refute this edge because they are already distribution-free realizably learnable. Fixed-$k$ term DNF also does not refute it because it is distribution-free realizably improperly learnable.

**Conclusion.** The edge remains open in this computational atlas. A proof would need a uniformization theorem for the marginal-dependent polynomial runtime/sample bounds; a counterexample would need a class whose realizable learner is polynomial for each fixed marginal but admits no distribution-free polynomial bound.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
