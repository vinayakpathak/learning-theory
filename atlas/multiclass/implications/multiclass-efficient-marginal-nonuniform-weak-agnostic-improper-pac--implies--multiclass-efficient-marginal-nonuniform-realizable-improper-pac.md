---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__multiclass-efficient-marginal-nonuniform-realizable-improper-pac
source: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: multiclass-efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-realizable-improper-pac|Multiclass Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
assumptions: []
witnesses: []
ref_keys:
- benedek1991fixed
- hanneke2025marginalnonuniform
- schapire1990
- freund1995boosting
- mukherjee2013multiclass
- brukhim2023boosting
refs:
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
- "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
- "[Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)"
- "[Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)"
summary: 'True, but not by directly boosting a marginal-nonuniform weak learner: spike-tilt first gives distribution-free weak realizable learning, then multiclass boosting gives a distribution-free strong improper learner and hence the marginal target.'
family: multiclass-spike-tilt-uniformization-plus-boosting-to-marginal-target
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: agnostic-to-realizable
  properness: same
argument_note: "[[multiclass-spike-tilt-uniformization|Spike-Tilt Uniformization]]"
tags:
- atlas/implication
- learning/multiclass-classification
result_origin: new
---

# Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`, with evidence `theorem`.

The proof is recorded in [[multiclass-spike-tilt-uniformization|Spike-Tilt Uniformization]]. The multiclass atlas uses the majority-accuracy weak convention, so the binary-style conversion is applied to the correct-versus-incorrect zero-one loss event.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `weak-to-strong`
- `realizability`: `agnostic-to-realizable`
- `properness`: `same`


## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)
- [Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)
