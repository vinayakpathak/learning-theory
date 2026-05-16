---
type: implication
id: multiclass-efficient-weak-agnostic-proper-pac__implies__multiclass-efficient-marginal-nonuniform-agnostic-improper-pac
source: multiclass-efficient-weak-agnostic-proper-pac
target: multiclass-efficient-marginal-nonuniform-agnostic-improper-pac
source_note: "[[multiclass-efficient-weak-agnostic-proper-pac|Multiclass Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: open
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
- bendavid2001
- feldman2010distributionspecific
- kalai2008agnosticboosting
- ghai2025agnosticboosting
- dacunha2026agnosticboosting
- kearns1994cryptographic
- goldreich1986
- hastad1999prg
refs:
- "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
- "[feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)"
- "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
- "[ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)"
- "[dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)"
- "[kearns1994cryptographic](https://doi.org/10.1145/174644.174647)"
- "[goldreich1986](https://doi.org/10.1145/6490.6503)"
- "[hastad1999prg](https://doi.org/10.1137/S0097539793244708)"
summary: 'Open. This edge has a one-way positive reduction to the improper-source marginal edge, because a proper weak agnostic learner is automatically an improper weak agnostic learner. The reduction is not an equivalence: an improper-source counterexample need not have proper weak hypotheses. PRF/handle and public-neutralizer wrappers did not yield an atlas-valid separation; the remaining obstruction is still the fully polynomial fixed-additive agnostic boosting or threshold-decoding problem.'
family: multiclass-agnostic-boosting-open
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: proper-to-improper
argument_note: "[[multiclass-agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-agnostic-boosting-open|Agnostic Boosting Open]].

## Axis Delta

- `resource`: `same`
- `distribution`: `distribution-free-to-marginal-nonuniform`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `proper-to-improper`


## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)
- [dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)
- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
- [goldreich1986](https://doi.org/10.1145/6490.6503)
- [hastad1999prg](https://doi.org/10.1137/S0097539793244708)
