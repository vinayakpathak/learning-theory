---
type: implication
id: multiclass-efficient-weak-agnostic-improper-pac__implies__multiclass-efficient-agnostic-improper-pac
source: multiclass-efficient-weak-agnostic-improper-pac
target: multiclass-efficient-agnostic-improper-pac
source_note: "[[multiclass-efficient-weak-agnostic-improper-pac|Multiclass Efficient Weak Agnostic Improper PAC Learning]]"
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
refs:
- "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
- "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
- "[gavinsky2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
- "[feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)"
- "[ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)"
- "[dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)"
summary: Still open. The source gives only one fixed additive slack. Known observable polynomial agnostic boosters need tunable weak slack at the final accuracy scale, while known residual-free fixed-slack boosters use clean-slice or relabeling searches with exponents depending on weak-sample or capacity parameters. No explicit class is known that separates the two nodes.
family: multiclass-agnostic-boosting-open
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[multiclass-agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Agnostic Improper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-agnostic-boosting-open|Agnostic Boosting Open]].

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `same`


## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [gavinsky2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)
- [ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)
- [dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)
