---
type: implication
id: multiclass-efficient-weak-agnostic-improper-pac__implies__multiclass-efficient-marginal-nonuniform-agnostic-improper-pac
source: multiclass-efficient-weak-agnostic-improper-pac
target: multiclass-efficient-marginal-nonuniform-agnostic-improper-pac
source_note: "[[multiclass-efficient-weak-agnostic-improper-pac|Multiclass Efficient Weak Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: open
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
- bendavid2001
- kalai2008agnosticboosting
- feldman2010distributionspecific
- ghai2025agnosticboosting
- dacunha2026agnosticboosting
refs:
- "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
- "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
- "[feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)"
- "[ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)"
- "[dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)"
summary: 'Open: no known theorem turns distribution-free fixed-additive weak agnostic improper learning into marginal-nonuniform strong agnostic improper learning. Known boosters need tunable weak accuracy or have weak-sample/capacity parameters in representation-dependent exponents, while threshold-decoding and P-specific preprocessing templates remain near misses rather than atlas-valid separations.'
family: multiclass-agnostic-boosting-open
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[multiclass-agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-agnostic-boosting-open|Agnostic Boosting Open]].

## Axis Delta

- `resource`: `same`
- `distribution`: `distribution-free-to-marginal-nonuniform`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `same`


## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)
- [ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)
- [dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)
