---
type: argument
id: multiclass-halfspace-agnostic-hardness
title: Multiclass Halfspace Agnostic Hardness
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
witnesses:
- multiclass-halfspaces
witness_note: "[[multiclass-halfspaces|Halfspaces]]"
assumptions:
- worst-case lattice hardness
ref_keys:
- tiegel2023
refs:
- "[tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Halfspace Agnostic Hardness

## Verdict

`false`, with evidence `conditional-counterexample`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
