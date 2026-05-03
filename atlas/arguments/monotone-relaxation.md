---
type: argument
id: monotone-relaxation
title: Monotone Relaxation
domain: binary-classification
model: pac
status: "true"
evidence: trivial
tags:
  - atlas/argument
  - learning/binary-classification
---

# Monotone Relaxation

## Verdict

`true`, trivially.

The five atlas axes have a monotone direction:

- computationally efficient learning implies sample-efficient learning,
- agnostic learning implies realizable learning,
- proper learning implies improper learning,
- strong learning implies weak learning,
- distribution-free learning implies marginal-nonuniform learning.

Whenever the target is obtained from the source only by moving along these relaxation directions, the same learner witnesses the target.
