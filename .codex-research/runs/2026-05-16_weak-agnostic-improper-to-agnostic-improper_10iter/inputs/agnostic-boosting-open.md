---
type: argument
id: agnostic-boosting-open
title: Agnostic Boosting Open
domain: binary-classification
model: pac
status: "open"
evidence: unknown
ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
  - gavinsky2003
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Agnostic Boosting Open

## Verdict

`open`.

This family records edges that ask whether the atlas fixed-additive weak agnostic guarantee can be boosted to arbitrary excess error. Existing agnostic boosting theorems are close in spirit, but they use oracle formulations or quantitative assumptions stronger than the current node definition.

The current obstruction is quantitative rather than purely conceptual. Feldman's distribution-specific boosting theorem supports a stronger threshold-or-correlation style weak node, and Ghai-Singh give an efficient modern route when the weak oracle supplies a tunable advantage/slack. The atlas node only promises one fixed additive tolerance of the form $\operatorname{OPT}+\beta$ for some fixed $\beta<1/2$.

The da Cunha et al. analysis is a useful near miss for this exact fixed-additive setting: it points to a finite-parameter reduction, but the relevant running time depends exponentially or otherwise nonuniformly on parameters that would have to remain polynomial in $1/\varepsilon$ for the atlas target. Until that quantitative gap is closed, these edges remain open rather than theorem-backed.

The depth-8 search sharpened the missing positive primitive into a polynomial clean-witness generator. A fully polynomial fixed-slack booster would need, from a medium-noise agnostic sample, a polynomial menu of weak-learner calls containing one call that behaves like a low-noise or clean conditional call for a near-optimal comparator. Random traces hit that clean slice with probability exponentially small in the weak learner's sample size, while any efficient filter that raises the clean probability appears to require a hypothesis already correlated with the hidden comparator.

The depth-9 search did not change the verdict. It did harmonize the relevant distribution-free weak agnostic edges with their definition notes: the source is a single fixed additive tolerance $\beta<1/2$, not a tunable final-accuracy slack. Under that convention, da Cunha--style residual-free boosting is still the closest positive route, but the known implementation has weak-sample or dual-capacity parameters in exponents. If one weakens the source to a merely inverse-polynomial nonconstant gap, parity/LPN and halfspace robustification routes become different conditional-separation questions rather than resolutions of the current atlas edges.

The negative route remains equally constrained. Halfspace, parity/LPN, code, CSP, PRF, and public-handle templates all miss the fixed-additive source or the strong improper target: either the weak source is already hard on a concentrated marginal or the public handles make an improper strong learner plausible by validation and voting. Thus the present status is still `open`, not `false`.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
