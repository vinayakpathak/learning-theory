---
type: implication
id: multiclass-efficient-weak-realizable-improper-pac__implies__multiclass-efficient-weak-realizable-proper-pac
source: multiclass-efficient-weak-realizable-improper-pac
target: multiclass-efficient-weak-realizable-proper-pac
source_note: "[[multiclass-efficient-weak-realizable-improper-pac|Multiclass Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[multiclass-efficient-weak-realizable-proper-pac|Multiclass Efficient Weak Realizable Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: unclear
assumptions:
- NP not subset RP
witnesses:
- multiclass-pcp-active-slice-lookup-class
witness_note: "[[multiclass-pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
ref_keys:
- hastad2005query
- karp1972
refs:
- "[hastad2005query](https://theoryofcomputing.org/articles/v001a007/)"
- "[karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: The PCP active-slice lookup class is weakly improperly learnable, but weak proper learning would put NP in RP.
family: multiclass-pcp-active-slice-weak-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[multiclass-pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Multiclass Efficient Weak Realizable Proper PAC Learning

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

- [hastad2005query](https://theoryofcomputing.org/articles/v001a007/)
- [karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
