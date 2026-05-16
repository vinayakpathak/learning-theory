---
type: implication
id: multiclass-efficient-marginal-nonuniform-agnostic-improper-pac__implies__multiclass-sample-efficient-marginal-nonuniform-agnostic-proper-pac
source: multiclass-efficient-marginal-nonuniform-agnostic-improper-pac
target: multiclass-sample-efficient-marginal-nonuniform-agnostic-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-sample-efficient-marginal-nonuniform-agnostic-proper-pac|Multiclass Sample-Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'true'
evidence: theorem
result_origin: known
assumptions: []
witnesses: []
ref_keys:
- daniely2014optimal
- daniely2015multiclass
- brukhim2022
- cohen2025multiclass
refs:
- "[Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)"
- "[Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)"
- "[Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)"
- "[Cohen et al. 2025](https://arxiv.org/abs/2511.12659)"
summary: At the finite-label multiclass sample-complexity level, runtime is ignored and standard multiclass learnability characterizations give the target guarantee.
family: multiclass-sample-complexity-equivalence
axis_delta:
  resource: computationally-efficient-to-sample-efficient
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[multiclass-sample-complexity-equivalence|Sample-Complexity Equivalence]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Sample-Efficient Marginal-Nonuniform Agnostic Proper PAC Learning

## Verdict

`true`, with evidence `theorem`.

Since runtime is unrestricted at the target, the implication is a sample-complexity statement. For finite multiclass labels, the Natarajan/graph-dimension theory, DS-dimension characterization, and recent agnostic sample-complexity bounds provide the standard finite-sample side of the argument.

## Axis Delta

- `resource`: `computationally-efficient-to-sample-efficient`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `same`
- `properness`: `improper-to-proper`


## References

- [Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)
- [Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)
- [Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)
- [Cohen et al. 2025](https://arxiv.org/abs/2511.12659)
