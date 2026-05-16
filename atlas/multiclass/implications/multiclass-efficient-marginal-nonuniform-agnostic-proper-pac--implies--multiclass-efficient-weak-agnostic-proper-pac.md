---
type: implication
id: multiclass-efficient-marginal-nonuniform-agnostic-proper-pac__implies__multiclass-efficient-weak-agnostic-proper-pac
source: multiclass-efficient-marginal-nonuniform-agnostic-proper-pac
target: multiclass-efficient-weak-agnostic-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-agnostic-proper-pac|Multiclass Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
target_note: "[[multiclass-efficient-weak-agnostic-proper-pac|Multiclass Efficient Weak Agnostic Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
result_origin: unclear
assumptions: []
witnesses: []
ref_keys:
- benedek1991fixed
- bendavid1995parameterization
- hanneke2025marginalnonuniform
refs:
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: 'True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, while source strong agnostic proper accuracy can be run at the fixed weak tolerance.'
family: multiclass-full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: same
argument_note: "[[multiclass-full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Agnostic Proper PAC Learning $\Rightarrow$ Multiclass Efficient Weak Agnostic Proper PAC Learning

## Verdict

`true`, with evidence `theorem`.

The proof is recorded in [[multiclass-full-support-marginal-uniformization|Full-Support Marginal Uniformization]]. The multiclass atlas uses the majority-accuracy weak convention, so the binary-style conversion is applied to the correct-versus-incorrect zero-one loss event.

## Axis Delta

- `resource`: `same`
- `distribution`: `marginal-nonuniform-to-distribution-free`
- `strength`: `strong-to-weak`
- `realizability`: `same`
- `properness`: `same`


## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
