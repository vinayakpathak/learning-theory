---
type: implication
id: efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - feldman2010distributionspecific
  - hastad2005query
  - khot2008dnf
  - tiegel2023
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Open: no efficient marginal fixed properization is known, and fixed-marginal hardness attempts lose the weak gap through active-mass or shared-coordinate dilution."
family: properization-open
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[properization-open|Properization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`.

This is a marginal-nonuniform weak agnostic properization problem. The source gives a uniform learner whose output may lie outside $\mathcal C$ and whose error is at most $\operatorname{OPT}_{\mathcal C}+\beta_P(s)$ for a marginal-dependent $\beta_P(s)<1/2$. The target asks for a member of $\mathcal C$ with a comparable weak guarantee.

## Proof Status

**Positive route obstruction.** Uniform convergence can justify the existence of good proper hypotheses on a sample, but it does not provide a polynomial-time approximate proper ERM or projection procedure. Boosting-style arguments also do not solve the problem, since the combined predictor is generally an improper aggregate.

**Negative route obstruction.** Known properness-hardness witnesses do not currently survive the marginal-nonuniform weak setting. Clause-satisfaction and PCP active-slice reductions usually put the hard instance in the marginal; then the target may use an instance-dependent marginal polynomial. Packing many hard slices into one fixed marginal makes each slice too small for a weak guarantee whose advantage may be only inverse-polynomial.

Shared-coordinate code or pseudorandom-generator variants keep the marginal fixed and preserve easy improper lookup learning, but proper hardness requires a correlation scale roughly of the form $\alpha_P(s)^2N\gg\log|\mathcal C_s|$, where $\alpha_P(s)=1/2-\beta_P(s)$. The atlas definition permits $\alpha_P(s)$ to be too small relative to any polynomially visible coordinate block.

**Conclusion.** The edge remains open. A proof would need a general efficient properization principle under each fixed marginal. A separation would need a fixed-marginal proper-only hardness construction with an easy improper weak agnostic learner and a weak-gap scale strong enough to overcome the active-mass or shared-coordinate correlation obstruction.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
