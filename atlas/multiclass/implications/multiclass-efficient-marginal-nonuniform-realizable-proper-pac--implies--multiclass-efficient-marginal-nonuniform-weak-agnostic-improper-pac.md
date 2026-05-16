---
type: implication
id: multiclass-efficient-marginal-nonuniform-realizable-proper-pac__implies__multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: multiclass-efficient-marginal-nonuniform-realizable-proper-pac
target: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-realizable-proper-pac|Multiclass Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: multiclass-classification
model: pac
status: open
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
- valiant1984
- blumer1989
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: 'Open: the binary low-noise robustification uses a constant-label fallback that does not meet the finite-label multiclass majority weak threshold.'
family: multiclass-low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[multiclass-low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`open`, with evidence `unknown`.

No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in [[multiclass-low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]].

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `strong-to-weak`
- `realizability`: `realizable-to-agnostic`
- `properness`: `proper-to-improper`


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
