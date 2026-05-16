---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac
target: multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac|Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
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
summary: Open. By spike-tilt uniformization, the source reduces for this target to the distribution-free weak-realizable proper core up to the same middle-noise selector issue. Low-noise same-marginal coupling works, and classes with validation-searchable proper shadow covers or neutralizers satisfy the target, but the source node alone does not provide such an object. CSP, parity/code, and LPN templates leak neutral proper outputs or lose clean weak learnability.
family: multiclass-marginal-agnostic-hardness-open
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[multiclass-marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]].

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `realizable-to-agnostic`
- `properness`: `same`


## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [hopkins2024](https://doi.org/10.46298/theoretics.24.2)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
- [feldman2012monomials](https://doi.org/10.1137/120865094)
