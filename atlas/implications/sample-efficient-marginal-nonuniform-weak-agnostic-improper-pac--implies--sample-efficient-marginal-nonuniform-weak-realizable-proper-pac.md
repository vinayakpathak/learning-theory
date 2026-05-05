---
type: implication
id: sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__sample-efficient-marginal-nonuniform-weak-realizable-proper-pac
source: sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: sample-efficient-marginal-nonuniform-weak-realizable-proper-pac
source_note: "[[sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-weak-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "known"
assumptions: []
witnesses: []
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
summary: "Ignoring runtime, standard sample-complexity characterizations and unbounded ERM give the target sample-efficient guarantee."
family: sample-complexity-equivalence
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[sample-complexity-equivalence|Sample-Complexity Equivalence]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Verdict

`true`, by the sample-complexity theorem recorded in [[sample-complexity-equivalence|Sample-Complexity Equivalence]].

## Proof Sketch

**Goal.** Show that the source guarantee is enough for [[sample-efficient-marginal-nonuniform-weak-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]] once polynomial running time is not required.

**Why the source gives sample control.** The source gives a polynomial sample bound at the relevant distribution-uniformity level. In the sample-only setting, the learner may use exhaustive empirical risk minimization over the benchmark class, so computational hardness of ERM is irrelevant.

**Why the target follows.** For binary PAC learning, the finite-sample characterizations underlying VC theory allow realizable, agnostic, weak, strong, proper, and improper sample guarantees to be converted at the same distribution-uniformity level. If the target is marginal-nonuniform, a distribution-free sample bound is also valid marginal-by-marginal.

**Conclusion.** The implication is true as a sample-complexity statement. It should not be read as giving a polynomial-time algorithm.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
