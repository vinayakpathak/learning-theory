---
type: argument
id: halfspace-agnostic-hardness
title: Halfspace Agnostic Hardness
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - halfspaces
witness_note: "[[halfspaces|Halfspaces]]"
assumptions:
  - worst-case lattice hardness
ref_keys:
  - tiegel2023
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Halfspace Agnostic Hardness

## Verdict

`false`, under worst-case lattice hardness.

Boolean halfspaces satisfy the relevant realizable source nodes by efficient proper realizable learning. Tiegel's hardness result rules out the corresponding agnostic target nodes for halfspaces, including improper agnostic targets in the distribution-free setting and the marginal-nonuniform agnostic targets captured in the existing implication notes.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
