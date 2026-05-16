---
type: implication
id: multiclass-efficient-weak-realizable-improper-pac__implies__multiclass-efficient-realizable-improper-pac
source: multiclass-efficient-weak-realizable-improper-pac
target: multiclass-efficient-realizable-improper-pac
source_note: "[[multiclass-efficient-weak-realizable-improper-pac|Multiclass Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[multiclass-efficient-realizable-improper-pac|Multiclass Efficient Realizable Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
result_origin: known
assumptions: []
witnesses: []
ref_keys:
- schapire1990
- freund1995boosting
- mukherjee2013multiclass
- brukhim2023boosting
refs:
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
- "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
- "[Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)"
- "[Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)"
summary: Schapire boosting converts weak realizable learning into strong realizable improper learning; weak agnostic learning specializes to weak realizable learning on realizable distributions.
family: multiclass-realizable-boosting
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[multiclass-realizable-boosting|Realizable Boosting]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Multiclass Efficient Realizable Improper PAC Learning

## Verdict

`true`, with evidence `theorem`.

The proof is recorded in [[multiclass-realizable-boosting|Realizable Boosting]]. The multiclass atlas uses the majority-accuracy weak convention, so the binary-style conversion is applied to the correct-versus-incorrect zero-one loss event.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `same`


## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)
- [Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)
