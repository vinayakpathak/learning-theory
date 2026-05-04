---
type: implication
id: sample-efficient-weak-realizable-improper-pac__implies__sample-efficient-marginal-nonuniform-realizable-proper-pac
source: sample-efficient-weak-realizable-improper-pac
target: sample-efficient-marginal-nonuniform-realizable-proper-pac
source_note: "[[sample-efficient-weak-realizable-improper-pac|Sample-Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[sample-efficient-marginal-nonuniform-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
assumptions: []
witnesses: []
ref_keys:
  - valiant1984
  - blumer1989
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - freund1995boosting
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
summary: "Ignoring runtime, VC/ERM sample-complexity equivalences give the strong target; boosting supplies the weak-to-strong reference point."
family: sample-complexity-equivalence
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: improper-to-proper
argument_note: "[[sample-complexity-equivalence|Sample-Complexity Equivalence]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning

## Verdict

`true`, by the sample-complexity theorem recorded in [[sample-complexity-equivalence|Sample-Complexity Equivalence]].

## Proof Sketch

**Goal.** Show that the source guarantee is enough for [[sample-efficient-marginal-nonuniform-realizable-proper-pac|Sample-Efficient Marginal-Nonuniform Realizable Proper PAC Learning]] once polynomial running time is not required.

**Weak-to-strong route.** The source gives a polynomial weak sample guarantee, meaning accuracy bounded away from random guessing. Classical boosting, such as Freund's boost-by-majority, is the algorithmic weak-to-strong conversion in the realizable case. For this sample-only implication, the safer route is the finite-sample characterization: a binary class that is weakly learnable with polynomial samples has the same finite-dimensional sample control needed for strong PAC learning, and runtime is unrestricted.

**Realizable conversion.** On realizable labeled distributions, the weak source already gives accuracy below $1/2$. The finite-sample characterization then upgrades this to the usual strong realizable PAC guarantee with arbitrary requested $\varepsilon$; equivalently, this is the sample-only shadow of realizable boosting. Runtime is unrestricted, so proper targets can be handled by exhaustive ERM over $\mathcal C$, and improper targets may use the same proper output.

**Distribution bookkeeping.** If the target is marginal-nonuniform, a distribution-free sample bound can be read marginal-by-marginal. If a marginal-nonuniform source must imply a distribution-free target, Hanneke, Moran, and Thiessen's trichotomy supplies the extra step: polynomial marginal-dependent weak rates force finite VC dimension, after which standard distribution-free VC bounds apply. If both source and target are marginal-nonuniform, the same fixed-marginal sample-complexity reasoning is applied with the polynomial allowed to depend on that marginal.

**Why the target follows.** With finite sample control in hand, standard VC and fixed-marginal uniform-convergence bounds give the requested strong realizable or agnostic guarantee. Because runtime is unrestricted, the learner may choose an empirical risk minimizer in $\mathcal C$; that handles proper targets, and improper targets may use the same proper hypothesis.

**Conclusion.** The implication is true as a sample-complexity statement. It should not be read as giving a polynomial-time algorithm.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
