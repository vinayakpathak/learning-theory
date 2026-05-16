---
type: implication
id: multiclass-efficient-realizable-proper-pac__implies__multiclass-efficient-agnostic-proper-pac
source: multiclass-efficient-realizable-proper-pac
target: multiclass-efficient-agnostic-proper-pac
source_note: "[[multiclass-efficient-realizable-proper-pac|Multiclass Efficient Realizable Proper PAC Learning]]"
target_note: "[[multiclass-efficient-agnostic-proper-pac|Multiclass Efficient Agnostic Proper PAC Learning]]"
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
result_origin: known
assumptions:
- RP != NP
witnesses:
- multiclass-conjunctions
ref_keys:
- valiant1984
- kearns1994
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[kearns1994](https://doi.org/10.1023/A:1022615600103)"
summary: Conjunctions are efficiently properly learnable in the realizable PAC model, but proper agnostic learning is hard unless RP = NP.
family: multiclass-conjunction-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[multiclass-conjunction-agnostic-hardness|Conjunction Agnostic Hardness]]"
witness_note: "[[multiclass-conjunctions|Conjunctions]]"
tags:
- atlas/implication
- learning/multiclass-classification
---

# Multiclass Efficient Realizable Proper PAC Learning $\Rightarrow$ Multiclass Efficient Agnostic Proper PAC Learning

## Verdict

`false`, with evidence `conditional-counterexample`.

A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus [[multiclass-conjunctions|Conjunctions]] satisfies the source while failing the target under RP != NP.

## Axis Delta

- `resource`: `same`
- `distribution`: `same`
- `strength`: `same`
- `realizability`: `realizable-to-agnostic`
- `properness`: `same`


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [kearns1994](https://doi.org/10.1023/A:1022615600103)
