---
type: implication
id: multiclass-sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__multiclass-sample-efficient-marginal-nonuniform-agnostic-improper-pac
source: multiclass-sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: multiclass-sample-efficient-marginal-nonuniform-agnostic-improper-pac
source_note: "[[multiclass-sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-sample-efficient-marginal-nonuniform-agnostic-improper-pac|Multiclass Sample-Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: counterexample
result_origin: new
assumptions: []
witnesses:
- multiclass-unrestricted-labelings
ref_keys:
- valiant1984
- blumer1989
- benedek1991fixed
- hanneke2025marginalnonuniform
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: 'False: countable unrestricted multiclass labelings are weakly learnable for each fixed marginal, but slow tails block polynomial strong marginal rates and no-free-lunch blocks distribution-free weak learning.'
family: multiclass-marginal-weak-sample-collapse-counterexample
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[multiclass-marginal-weak-sample-collapse-counterexample|Marginal Weak Sample Collapse Counterexample]]"
tags:
- atlas/implication
- learning/multiclass-classification
witness_note: "[[multiclass-unrestricted-labelings|Unrestricted Labelings]]"
---

# Multiclass Sample-Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Sample-Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Verdict

`false`, with evidence `counterexample`.

The counterexample is recorded in [[multiclass-marginal-weak-sample-collapse-counterexample|Marginal Weak Sample Collapse Counterexample]]. Countable unrestricted multiclass labelings are weakly learnable for each fixed marginal, but slow tails prevent polynomial strong marginal-nonuniform rates and no-free-lunch prevents distribution-free weak learning.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `same`


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
