---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__multiclass-efficient-weak-realizable-improper-pac
source: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac
target: multiclass-efficient-weak-realizable-improper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac|Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
target_note: "[[multiclass-efficient-weak-realizable-improper-pac|Multiclass Efficient Weak Realizable Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
assumptions: []
witnesses: []
ref_keys:
- benedek1991fixed
- hanneke2025marginalnonuniform
refs:
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: 'Spike-tilt uniformization turns the marginal-nonuniform weak source into a distribution-free weak learner: after full-support resource uniformization, spiking a point where many low-edge deterministic outputs err rules out hidden marginal-dependent weak gaps.'
family: multiclass-spike-tilt-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: proper-to-improper
argument_note: "[[multiclass-spike-tilt-uniformization|Spike-Tilt Uniformization]]"
tags:
- atlas/implication
- learning/multiclass-classification
result_origin: new
---

# Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`, with evidence `theorem`.

The proof is recorded in [[multiclass-spike-tilt-uniformization|Spike-Tilt Uniformization]]. The multiclass atlas uses the majority-accuracy weak convention, so the binary-style conversion is applied to the correct-versus-incorrect zero-one loss event.

## Axis Delta

- `resource`: `same`
- `distribution`: `marginal-nonuniform-to-distribution-free`
- `strength`: `same`
- `realizability`: `same`
- `properness`: `proper-to-improper`


## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
