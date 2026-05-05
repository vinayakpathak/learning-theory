---
type: witness
id: one-way-image-coordinate-weak-handle-class
title: One-Way Image Coordinate Weak-Handle Class
domain: binary-classification
model: pac
assumptions:
  - length-preserving one-way functions exist
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
tags:
  - atlas/witness
  - learning/binary-classification
---

# One-Way Image Coordinate Weak-Handle Class

## Role

This witness separates marginal-nonuniform weak proper realizable learning from marginal-nonuniform strong proper realizable learning. Start with the one-way image-coordinate class and add proper weak handles: the two constant concepts and every singleton-positive-atom concept.

The handles give a proper weak learner an inverse-polynomial edge for every target and every marginal: either a constant is already good, or a heavy positive atom can be found and output as a singleton. Under the fixed image-coordinate marginal, however, strong proper learning an image-coordinate target to inverse-polynomial accuracy still forces recovery of a seed whose image is the one-way challenge.

## References

- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
