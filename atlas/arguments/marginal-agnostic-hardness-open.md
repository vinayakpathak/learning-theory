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
  - feldman2012monomials
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
  - "[Feldman et al. 2012](https://doi.org/10.1137/120865094)"
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

For realizable-source proper edges, the low-noise branch is better understood: a noisy run can be coupled to a clean realizable run for a near-optimal concept using the same original marginal. The unresolved part is the middle-noise regime. The improper robustification proof uses constant classifiers as neutralizers, but constants need not be legal proper concepts. A positive theorem would need a fixed-marginal proper neutralizer, balanced sampler, validation-searchable weak cover, or selector, none of which follows from clean realizable proper learning alone.

The strongest form of this obstruction is a selector equivalence. Once the low-noise branch is handled, the remaining target is equivalent up to constant slack to a same-marginal middle-noise proper selector: for every fixed marginal $P$, generate a polynomial list of legal concepts containing some $h$ with error at most $\operatorname{OPT}+1/2-\gamma_P$. In the middle-noise regime this can be weakened to finding any legal proper hypothesis whose correlation with the agnostic labels is at least $-1/\operatorname{poly}$. Clean proper learning supplies a promise-extension oracle after a clean trace has been guessed; it does not by itself optimize signed weights over traces or produce a neutral legal concept.

FGRW/PCP-style weak agnostic hardness has the right flavor but still falls short for these marginal-nonuniform edges. The Label-Cover or dictatorship-test structure normally affects the example marginal. Moving all instance identities into one fixed marginal dilutes the hard slice or allows unrelated satisfiable instances, random balanced concepts, singleton handles, or residual code correlations to serve as weak proper outputs. A future separation would need a wrong-output-usefulness gadget: every weakly legal proper hypothesis under one fixed marginal should decode the hard witness.

Finite-support attempts clarify the negative target but have not produced a witness. Under a uniform support of size $N$, the weak selector condition over set traces is additive half-range optimization, $W(F)\ge W^\star-N/2+\gamma N$, so ordinary hard ERM, nearest-codeword, set-cover, or independent-set hardness is too strong and misses the weak threshold. Known trace families with easy clean promise extension leak defaults, local moves, approximation algorithms, balanced samplers, wrong codewords, or wrong instances; templates that remove those handles tend to make clean promise extension hard or move the challenge into the marginal. A false result would require a new fixed-marginal weak signed-search primitive with efficient clean proper promise extension and no efficient neutral legal handles.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
- [Feldman et al. 2012](https://doi.org/10.1137/120865094)
