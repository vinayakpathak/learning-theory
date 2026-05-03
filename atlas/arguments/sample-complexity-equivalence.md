---
type: argument
id: sample-complexity-equivalence
title: Sample-Complexity Equivalence
domain: binary-classification
model: pac
status: "true"
evidence: theorem
ref_keys:
  - valiant1984
  - blumer1989
  - benedek1991fixed
  - hanneke2025marginalnonuniform
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Sample-Complexity Equivalence

## Verdict

`true`, for the sample-only binary PAC notions tracked here.

Once running time is ignored, empirical risk minimization over the benchmark class is an admissible learner. In the distribution-free binary setting, finite VC dimension characterizes realizable and agnostic PAC learnability, and the same uniform-convergence bounds support proper learning whenever the benchmark class itself is the output class.

For weak-to-strong directions, the sample-only setting can also use the standard finite-sample characterizations instead of asking for a computationally efficient boosting procedure. In the marginal-nonuniform setting, the same reasoning is applied at a fixed marginal, with the polynomial allowed to depend on that marginal.

This argument does not settle marginal-to-distribution-free uniformization: a learner whose polynomial bound may depend on the marginal distribution need not come with one polynomial that works uniformly over all marginals. Those edges remain in [[marginal-uniformization-open|Marginal Uniformization Open]].

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
