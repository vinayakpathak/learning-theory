---
type: implication
id: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac__implies__multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac
target: multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-improper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
target_note: "[[multiclass-efficient-marginal-nonuniform-weak-agnostic-proper-pac|Multiclass Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: unclear
assumptions:
- NP not subset RP
witnesses:
- multiclass-pcp-active-slice-lookup-class
ref_keys:
- blumer1989
- hastad2005query
- karp1972
- hanneke2025marginalnonuniform
refs:
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
- "[hastad2005query](https://theoryofcomputing.org/articles/v001a007/)"
- "[karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: 'False under NP not subset RP: the PCP active-slice lookup class satisfies the improper source via efficient agnostic one-slice lookup-table ERM, but a marginal-nonuniform weak agnostic proper learner would have pathwise uniform runtime under a full-support marginal and would produce a proof accepted on more than half of the active slice.'
family: multiclass-pcp-active-slice-weak-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[multiclass-pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[multiclass-pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning $\Rightarrow$ Multiclass Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-pcp-active-slice-lookup-class|Pcp Active Slice Lookup Class]] satisfies the source while failing the target under NP not subset RP.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `same`
- `properness`: `improper-to-proper`


## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [hastad2005query](https://theoryofcomputing.org/articles/v001a007/)
- [karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
