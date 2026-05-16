---
type: argument
id: multiclass-fixed-k-term-dnf-proper-boosting-separation
title: Multiclass Fixed-k-Term DNF Proper Boosting Separation
domain: multiclass-classification
model: pac
status: 'false'
evidence: conditional-counterexample
witnesses:
- multiclass-fixed-k-term-DNF
witness_note: "[[multiclass-fixed-k-term-DNF|Fixed-k-Term DNF]]"
assumptions:
- RP != NP
ref_keys:
- schapire1990
- pitt1988
- haussler1990
refs:
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
- "`pitt1988`"
- "`haussler1990`"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Fixed-k-Term DNF Proper Boosting Separation

## Verdict

`false`, with evidence `conditional-counterexample`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- `pitt1988`
- `haussler1990`
