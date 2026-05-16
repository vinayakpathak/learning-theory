---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__multiclass-efficient-realizable-proper-pac
source: multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac
target: multiclass-efficient-realizable-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-realizable-proper-pac|Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
target_note: "[[multiclass-efficient-realizable-proper-pac|Multiclass Efficient Realizable Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: known
assumptions:
- RP != NP
witnesses:
- multiclass-fixed-k-term-DNF
ref_keys:
- schapire1990
- pitt1988
- haussler1990
refs:
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
- "`pitt1988`"
- "`haussler1990`"
summary: Fixed-k-term DNF satisfies the source, but fails the distribution-free strong proper target unless RP = NP.
family: multiclass-fixed-k-term-dnf-proper-boosting-separation
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[multiclass-fixed-k-term-dnf-proper-boosting-separation|Fixed-k-Term DNF Proper Boosting Separation]]"
witness_note: "[[multiclass-fixed-k-term-DNF|Fixed-k-Term DNF]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Realizable Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-fixed-k-term-DNF|Fixed K Term Dnf]] satisfies the source while failing the target under RP != NP.

## Axis Delta

- `resource`: `same`
- `distribution`: `marginal-nonuniform-to-distribution-free`
- `strength`: `weak-to-strong`
- `realizability`: `same`
- `properness`: `same`


## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- `pitt1988`
- `haussler1990`
