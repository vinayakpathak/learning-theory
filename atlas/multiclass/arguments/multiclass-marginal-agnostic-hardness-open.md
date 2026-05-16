---
type: argument
id: multiclass-marginal-agnostic-hardness-open
title: Multiclass Marginal-Nonuniform Agnostic Hardness Open
domain: multiclass-classification
model: pac
status: open
evidence: unknown
ref_keys:
- benedek1991fixed
- hanneke2025marginalnonuniform
- tiegel2023
- feldman2012monomials
refs:
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
- "[tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
- "[feldman2012monomials](https://doi.org/10.1137/120865094)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Marginal-Nonuniform Agnostic Hardness Open

## Verdict

`open`, with evidence `unknown`.

This family also remains open in the multiclass atlas. Hopkins--Kane--Lovett--Mahajan give broad realizable-to-agnostic reductions, including distribution-family and finite-label settings, but the reduction constructs a finite cover by running the realizable learner over possible labelings of an unlabeled sample. That is a sample-complexity theorem rather than a representation-sensitive polynomial-time implication, so it does not close these efficient edges.

The target here is additionally proper. The existing low-noise robustification argument gives improper weak agnostic targets by validating arbitrary hypotheses and neutral defaults. It does not automatically provide a legal proper multiclass hypothesis when the class has no constant labels, complements, balanced sampler, or other proper neutralizer. Conversely, known distribution-free agnostic hardness witnesses do not by themselves rule out marginal-dependent polynomial bounds. The right fixed-marginal proper weak selector or no-neutral separation is still missing.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [tiegel2023](https://proceedings.mlr.press/v195/tiegel23a.html)
- [feldman2012monomials](https://doi.org/10.1137/120865094)
