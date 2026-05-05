---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__sample-efficient-weak-agnostic-proper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: sample-efficient-weak-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[sample-efficient-weak-agnostic-proper-pac|Sample-Efficient Weak Agnostic Proper PAC Learning]]"
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
summary: "True: polynomial marginal-nonuniform sample rates collapse to finite VC dimension, and VC theory gives the distribution-free sample-efficient target."
family: sample-complexity-equivalence
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[sample-complexity-equivalence|Sample-Complexity Equivalence]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Sample-Efficient Weak Agnostic Proper PAC Learning

## Verdict

`true`, by the binary sample-complexity equivalence and the marginal-nonuniform trichotomy.

## Proof Sketch

**Goal.** Show that the source guarantee is enough for [[sample-efficient-weak-agnostic-proper-pac|Sample-Efficient Weak Agnostic Proper PAC Learning]] once polynomial running time is not required.

**Why the source gives sample control.** The source is a polynomial-rate marginal-nonuniform sample guarantee after ignoring any runtime requirement. In the sample-only binary setting, the usual VC/ERM equivalences convert among realizable, agnostic, weak, strong, proper, and improper variants.

**Why marginal nonuniformity uniformizes here.** Hanneke, Moran, and Thiessen's marginal-nonuniform trichotomy says that binary classes with finite VC dimension have linear marginal-nonuniform rates, while classes with infinite VC dimension require arbitrarily slow marginal-nonuniform rates. Therefore a polynomial marginal-nonuniform sample guarantee forces finite VC dimension.

**Why the target follows.** Standard VC theory gives distribution-free polynomial sample complexity for binary PAC learning when VC dimension is finite. Since runtime is unrestricted, exhaustive empirical risk minimization can be used to obtain the requested proper or improper target variant.

**Conclusion.** The implication is true as a sample-complexity statement. It should not be read as giving a polynomial-time learner.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
