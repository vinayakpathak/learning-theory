---
type: argument
id: multiclass-conjunction-agnostic-hardness
title: Multiclass Conjunction Agnostic Hardness
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
witnesses:
- multiclass-conjunctions
witness_note: "[[multiclass-conjunctions|Conjunctions]]"
assumptions:
- RP != NP
ref_keys:
- valiant1984
- kearns1994
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[kearns1994](https://doi.org/10.1023/A:1022615600103)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Conjunction Agnostic Hardness

## Verdict

`false`, with evidence `conditional-counterexample`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [kearns1994](https://doi.org/10.1023/A:1022615600103)
