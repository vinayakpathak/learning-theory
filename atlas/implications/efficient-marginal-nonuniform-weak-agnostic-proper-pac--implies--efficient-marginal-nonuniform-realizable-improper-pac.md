---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-proper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-marginal-nonuniform-weak-agnostic-proper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - benedek1991fixed
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
summary: "Open: boosting from a marginal-nonuniform weak learner does not automatically give one marginal-dependent polynomial bound for the strong target."
family: marginal-boosting-open
axis_delta:
  distribution: same
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: proper-to-improper
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`open`.

Open: boosting from a marginal-nonuniform weak learner does not automatically give one marginal-dependent polynomial bound for the strong target.

## Proof Status

**Goal.** Decide whether the weak marginal-nonuniform source can be boosted to the strong target.

**Obstacle.** Standard boosting calls the weak learner on reweighted distributions. In the marginal-nonuniform model, the polynomial bound may depend on each reweighted marginal. The source does not guarantee one polynomial, depending only on the original marginal, that controls all reweighted calls needed for arbitrary final accuracy.

**Known context.** Distribution-free weak realizable learning boosts to strong improper realizable learning, and agnostic boosting has its own oracle requirements. Those theorems do not directly handle this marginal-dependent runtime convention.

**Conclusion.** The edge remains open unless additional uniform control over the weak learner's marginal-dependent polynomials is assumed.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
