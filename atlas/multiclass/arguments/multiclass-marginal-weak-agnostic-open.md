---
type: argument
id: multiclass-marginal-weak-agnostic-open
title: Marginal Weak Agnostic Open
domain: multiclass-classification
model: pac
status: open
evidence: unknown
ref_keys:
- tiegel2023
refs:
- "[tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Marginal Weak Agnostic Open

## Verdict

`open`, with evidence `unknown`.

These edges were previously assigned to the halfspace agnostic hardness family. That target obstruction is real: a strong agnostic learner for the relevant multiclass embedded halfspaces would imply the corresponding binary learner ruled out by Tiegel's hardness theorem.

The missing part is the source. The current multiclass low-noise robustification proof does not show that halfspaces satisfy the marginal-nonuniform weak agnostic nodes with a fixed additive $\beta<1/2$. In binary, a constant fallback handles high-noise distributions because one of two constants has error at most $1/2$. With three or more labels, the best constant can have error $1-1/k$, so the same fallback can miss the majority weak threshold.

A true edge would need a generic fixed-gap multiclass weak agnostic learner or a valid multiclass neutralizer. A false edge would need a witness satisfying the marginal weak agnostic source while failing the stronger agnostic target. The present atlas records neither.


## References

- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
