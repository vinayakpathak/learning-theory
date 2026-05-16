---
type: implication
id: multiclass-efficient-weak-realizable-proper-pac__implies__multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: multiclass-efficient-weak-realizable-proper-pac
target: multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[multiclass-efficient-weak-realizable-proper-pac|Multiclass Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: open
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
- benedek1991fixed
- hopkins2024
- hanneke2025marginalnonuniform
- tiegel2023
- feldman2012monomials
refs:
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[hopkins2024](https://doi.org/10.46298/theoretics.24.2)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
- "[tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
- "[feldman2012monomials](https://doi.org/10.1137/120865094)"
summary: 'Open after depth-8 search: the low-noise branch follows by clean-transcript coupling, but the middle-noise regime still needs an efficient same-marginal proper selector or neutralizer. A negative resolution would need a strengthened fixed-ensemble no-neutral signed-search primitive (NNSS) with clean extension and hardness against all polynomial-size proper outputs. Halfspace, CSP/PCP, parity/code, and oracle-diagonal routes remain near misses rather than atlas-valid witnesses.'
family: multiclass-marginal-agnostic-hardness-open
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[multiclass-marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]].

## Axis Delta

- `resource`: `same`
- `distribution`: `distribution-free-to-marginal-nonuniform`
- `strength`: `same`
- `realizability`: `realizable-to-agnostic`
- `properness`: `same`


## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [hopkins2024](https://doi.org/10.46298/theoretics.24.2)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
- [feldman2012monomials](https://doi.org/10.1137/120865094)
