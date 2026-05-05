---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-marginal-nonuniform-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - freund1995boosting
  - benedek1991fixed
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
summary: "Open: Schapire/Freund boosting calls the weak learner on reweighted marginals, and the atlas source gives no original-marginal polynomial controlling target- and history-dependent reweightings."
family: marginal-boosting-open
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`open`.

Open: Schapire/Freund boosting calls the weak learner on reweighted marginals, and the atlas source gives no original-marginal polynomial controlling those target- and history-dependent reweightings.

## Proof Status

**Goal.** Decide whether the weak marginal-nonuniform source can be boosted to the strong target.

**Required construction.** Starting from one weak learner $A$, we would need a strong learner $B$ such that, for every original marginal $P$, one polynomial $q_P(s,1/\varepsilon,\log(1/\delta))$ bounds all samples and running time on realizable data drawn from $P$.

**Obstacle.** Schapire-style boosting works in the distribution-free model because the weak guarantee is uniform over every distribution created by filtering or reweighting the sample stream. In the marginal-nonuniform source, applying the weak learner to a reweighted marginal $Q_t$ only gives a polynomial $p_{Q_t}$ and advantage $\gamma_{Q_t}$ for that induced marginal. The induced $Q_t$ can depend on $P$, the target concept, earlier hypotheses, and the booster's randomness.

**Missing uniformity.** To prove the edge true by boosting, one would need an additional statement saying that, for each original marginal $P$, every boosting-generated $Q_t$ has $p_{Q_t}$ and $1/\gamma_{Q_t}$ bounded by one polynomial depending only on $P$. The atlas source definition does not include such a filter-stable or KL-stable modulus.

**Near miss.** Freund's boost-by-majority theorem studies distribution-dependent weak accuracy, but it assumes quantitative control of how that accuracy behaves on the filtered distributions used by the booster. This is close in spirit, but it is stronger than the bare marginal-nonuniform promise recorded here.

**Counterexample route checked.** Oracle-style diagonal sketches can make filtered marginals hostile to a fixed booster, but this does not give an atlas-valid false edge: a separation must rule out every possible strong learner while still proving the source for every marginal.

**Conclusion.** The edge remains open unless additional uniform control over the weak learner's marginal-dependent polynomials is assumed, or a non-black-box separation is found.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
