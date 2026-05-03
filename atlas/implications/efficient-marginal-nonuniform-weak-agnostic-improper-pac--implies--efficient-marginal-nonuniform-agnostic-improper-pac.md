---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-agnostic-improper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
summary: "Open: boosting from a marginal-nonuniform weak learner does not automatically give one marginal-dependent polynomial bound for the strong target."
family: agnostic-boosting-open
axis_delta:
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Verdict

`open`.

Open: boosting from a marginal-nonuniform weak learner does not automatically give one marginal-dependent polynomial bound for the strong target.

## Proof Status

**Goal.** Decide whether the weak marginal-nonuniform source can be boosted to the strong target.

**Obstacle.** Standard boosting calls the weak learner on reweighted distributions. In the marginal-nonuniform model, the polynomial bound may depend on each reweighted marginal. The source does not guarantee one polynomial, depending only on the original marginal, that controls all reweighted calls needed for arbitrary final accuracy.

**Known context.** Distribution-free weak realizable learning boosts to strong improper realizable learning, and agnostic boosting has its own oracle requirements. Those theorems do not directly handle this marginal-dependent runtime convention.

**Conclusion.** The edge remains open unless additional uniform control over the weak learner's marginal-dependent polynomials is assumed.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
