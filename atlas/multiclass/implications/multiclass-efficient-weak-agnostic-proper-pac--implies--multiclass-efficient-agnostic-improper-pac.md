---
type: implication
id: multiclass-efficient-weak-agnostic-proper-pac__implies__multiclass-efficient-agnostic-improper-pac
source: multiclass-efficient-weak-agnostic-proper-pac
target: multiclass-efficient-agnostic-improper-pac
source_note: "[[multiclass-efficient-weak-agnostic-proper-pac|Multiclass Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-efficient-agnostic-improper-pac|Multiclass Efficient Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: open
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
- bendavid2001
- kalai2008agnosticboosting
- gavinsky2003
- feldman2010distributionspecific
- ghai2025agnosticboosting
- dacunha2026agnosticboosting
- tiegel2023
refs:
- "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
- "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
- "[gavinsky2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
- "[feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)"
- "[ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)"
- "[dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)"
- "[tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: Open. Efficient weak agnostic proper learning immediately relaxes to efficient weak agnostic improper learning, so any positive resolution of the improper weak-to-strong agnostic boosting edge would prove this edge. Current boosting/OCO routes require an accuracy-tunable weighted correlation, cost-sensitive ERM, or residual-separation oracle; properness alone gives legal base hypotheses for voting but not that oracle.
family: multiclass-agnostic-boosting-open
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: proper-to-improper
argument_note: "[[multiclass-agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Efficient Agnostic Improper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-agnostic-boosting-open|Agnostic Boosting Open]].

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `proper-to-improper`


## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [gavinsky2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)
- [ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)
- [dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)
- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
