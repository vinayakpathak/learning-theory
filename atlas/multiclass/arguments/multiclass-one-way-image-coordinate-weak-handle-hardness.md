---
type: argument
id: multiclass-one-way-image-coordinate-weak-handle-hardness
title: Multiclass One-Way Image Coordinate Weak-Handle Hardness
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
witnesses:
- multiclass-one-way-image-coordinate-weak-handle-class
witness_note: "[[multiclass-one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
assumptions:
- length-preserving one-way functions exist
ref_keys:
- kearns1994cryptographic
- hastad1999prg
refs:
- "[kearns1994cryptographic](https://doi.org/10.1145/174644.174647)"
- "[hastad1999prg](https://doi.org/10.1137/S0097539793244708)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass One-Way Image Coordinate Weak-Handle Hardness

## Verdict

`false`, with evidence `conditional-counterexample`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
- [hastad1999prg](https://doi.org/10.1137/S0097539793244708)
