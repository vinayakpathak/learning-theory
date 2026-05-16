---
type: argument
id: multiclass-clause-satisfaction-proper-hardness
title: Multiclass Clause-Satisfaction Proper Hardness
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
witnesses:
- multiclass-clause-satisfaction-lookup-class
witness_note: "[[multiclass-clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
assumptions:
- NP not subset RP
ref_keys:
- blumer1989
- karp1972
refs:
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
- "[karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Clause-Satisfaction Proper Hardness

## Verdict

`false`, with evidence `conditional-counterexample`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
