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
  - feldman2010distributionspecific
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
summary: "Open: Feldman's distribution-specific boosting handles a stronger threshold/correlation weak learner, but the atlas source is fixed-additive."
family: agnostic-boosting-open
axis_delta:
  resource: same
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

**Known context.** Feldman's distribution-specific agnostic boosting is a strong near miss: it modifies labels rather than the instance marginal, so it is well matched to marginal-nonuniform bookkeeping. However, it uses a threshold/correlation-style weak agnostic learner. The current atlas source gives only a fixed additive guarantee $\operatorname{opt}+\beta_P(s)$, and that fixed $\beta_P(s)$ is not tunable to the arbitrary final excess $\varepsilon$ required by the strong target.

**False witness route checked.** Known hard improper agnostic examples usually also kill the weak source. Approximation-style candidates tend to become easy for an improper learner when the relevant constraint domain is polynomial-sized.

**Conclusion.** The edge remains open for the existing fixed-additive source. A separate threshold/correlation weak agnostic marginal-nonuniform node would likely have a true theorem edge to the strong agnostic improper node via Feldman's label-only boosting.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
