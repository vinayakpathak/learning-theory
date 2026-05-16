---
type: argument
id: multiclass-agnostic-boosting-open
title: Multiclass Agnostic Boosting Open
domain: multiclass-classification
model: pac
status: open
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
- "[gavinsky2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
- "[feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)"
- "[ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)"
- "[dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Agnostic Boosting Open

## Verdict

`open`, with evidence `unknown`.

This family remains open for the finite-label multiclass atlas. The source node supplies only a fixed-additive weak agnostic learner, $\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta$ for one $\beta<1/2$. Modern agnostic boosters, including the Ghai--Singh and da Cunha--Hogsgaard--Paudice lines cited here, use stronger oracle formulations: in binary language, they ask for a relative-correlation weak learner, often with a tunable tolerance parameter. Those assumptions do not follow from the atlas node.

Binary agnostic boosting papers therefore give close positive routes but not a source-grounded closure of these edges. Multiclass boosting papers likewise show how to combine appropriate multiclass weak hypotheses, but they do not turn this atlas's fixed-additive multiclass weak learner into arbitrary-excess-error PAC learning for every finite-label class. A false witness is also not recorded: binary hard classes embedded into two multiclass labels either fail the weak source or remain vulnerable to improper aggregation.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [gavinsky2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)
- [ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)
- [dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)
