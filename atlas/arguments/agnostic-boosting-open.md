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

The current obstruction is quantitative rather than purely conceptual. Feldman's distribution-specific boosting theorem supports a stronger threshold-or-correlation style weak node, and Ghai-Singh give an efficient modern route when the weak oracle supplies a tunable advantage/slack. The atlas node only promises one fixed additive tolerance of the form $\operatorname{OPT}+1/2-\gamma$ for some inverse-polynomial $\gamma$.

The da Cunha et al. analysis is a useful near miss for this exact fixed-additive setting: it points to a finite-parameter reduction, but the relevant running time depends exponentially or otherwise nonuniformly on parameters that would have to remain polynomial in $1/\varepsilon$ for the atlas target. Until that quantitative gap is closed, these edges remain open rather than theorem-backed.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
