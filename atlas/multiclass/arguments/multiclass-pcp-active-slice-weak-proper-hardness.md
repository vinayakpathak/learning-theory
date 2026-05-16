---
type: argument
id: multiclass-pcp-active-slice-weak-proper-hardness
title: Multiclass PCP Active-Slice Weak Proper Hardness
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
witnesses:
- multiclass-pcp-active-slice-lookup-class
witness_note: "[[multiclass-pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
assumptions:
- NP not subset RP
ref_keys:
- hastad2005query
- karp1972
refs:
- "[hastad2005query](https://theoryofcomputing.org/articles/v001a007/)"
- "[karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass PCP Active-Slice Weak Proper Hardness

## Verdict

`false`, with evidence `conditional-counterexample`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [hastad2005query](https://theoryofcomputing.org/articles/v001a007/)
- [karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
