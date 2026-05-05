---
type: argument
id: marginal-agnostic-hardness-open
title: Marginal-Nonuniform Agnostic Hardness Open
domain: binary-classification
model: pac
status: "open"
evidence: unknown
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - tiegel2023
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Marginal-Nonuniform Agnostic Hardness Open

## Verdict

`open`.

This family records edges where known distribution-free agnostic hardness does not automatically rule out marginal-nonuniform agnostic learning. The obstruction is that marginal-nonuniform learning permits the polynomial bound to depend on the instance marginal.

The low-noise robustification resolves the analogous edges whose source learner is distribution-free realizable. It also resolves the marginal-nonuniform realizable proper to marginal-nonuniform weak agnostic improper edge once written in marginal-preserving coupling form: the noisy and realizable runs use the same original $P$-distributed instance sequence, so the proof never invokes the learner under a clean conditional marginal $Q$. Other marginal-source agnostic-hardness edges remain open when they lack that low-noise realizable-source structure.

The main false-witness routes remain near misses. Halfspace and random-CSP hardness results generally vary the marginal or prove a strong agnostic hardness statement rather than a low-OPT weak no-advantage statement. LPN under a fixed uniform marginal has the right fixed-marginal flavor, but the weak additive gap can be chosen so small that standard low-noise assumptions are too noisy, while very-low-noise parity can be attacked by clean-sample Gaussian elimination.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
