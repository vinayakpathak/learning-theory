---
type: implication
id: multiclass-efficient-marginal-nonuniform-realizable-improper-pac__implies__multiclass-efficient-realizable-proper-pac
source: multiclass-efficient-marginal-nonuniform-realizable-improper-pac
target: multiclass-efficient-realizable-proper-pac
source_note: "[[multiclass-efficient-marginal-nonuniform-realizable-improper-pac|Multiclass Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[multiclass-efficient-realizable-proper-pac|Multiclass Efficient Realizable Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: unclear
assumptions:
- NP not subset RP
witnesses:
- multiclass-clause-satisfaction-lookup-class
ref_keys:
- blumer1989
- karp1972
refs:
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
- "[karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: The clause-satisfaction lookup class is efficiently agnostically improperly learnable, but any efficient proper realizable learner would put 3-SAT in RP.
family: multiclass-clause-satisfaction-proper-hardness
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[multiclass-clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
witness_note: "[[multiclass-clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Multiclass Efficient Realizable Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-clause-satisfaction-lookup-class|Clause Satisfaction Lookup Class]] satisfies the source while failing the target under NP not subset RP.

## Axis Delta

- `resource`: `same`
- `distribution`: `marginal-nonuniform-to-distribution-free`
- `strength`: `same`
- `realizability`: `same`
- `properness`: `improper-to-proper`


## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
