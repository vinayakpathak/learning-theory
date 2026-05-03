---
type: witness
id: halfspaces
title: Halfspaces
domain: binary-classification
model: pac
assumptions:
  - worst-case lattice hardness
ref_keys:
  - tiegel2023
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# Halfspaces

## Role

Halfspaces witness several false implications from realizable source nodes to agnostic target nodes. They are efficiently realizably learnable by standard linear feasibility and VC generalization, while the atlas notes cite Tiegel's agnostic hardness result under worst-case lattice assumptions.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
