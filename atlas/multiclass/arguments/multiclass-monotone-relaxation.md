---
type: argument
id: multiclass-monotone-relaxation
title: Multiclass Monotone Relaxation
domain: multiclass-classification
model: pac
status: 'true'
evidence: trivial
tags:
- atlas/argument
- learning/multiclass-classification
ref_keys: []
refs: []
---

# Multiclass Monotone Relaxation

## Verdict

`true`, with evidence `trivial`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.
