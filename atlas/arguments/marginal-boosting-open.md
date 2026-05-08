---
type: argument
id: marginal-boosting-open
title: Marginal-Nonuniform Boosting Open
domain: binary-classification
model: pac
status: "open"
evidence: unknown
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Marginal-Nonuniform Boosting Open

## Verdict

`open`.

This family records edges where boosting would have to preserve one polynomial bound that may depend on the marginal distribution. Standard realizable boosting explains the distribution-free weak-to-strong direction, but it does not by itself settle the marginal-dependent rate bookkeeping used by these nodes.

The obstruction is not merely that the final boosted hypothesis is improper. Schapire-style and boost-by-majority procedures call the weak learner on filtered or reweighted example distributions. Freund's boost-by-majority analysis includes distribution-dependent weak accuracy as a near miss, but it still needs quantitative control over how the weak guarantee behaves on those induced distributions. The atlas marginal-nonuniform nodes only promise a polynomial for each marginal separately, so they do not supply one original-marginal polynomial controlling every reweighted marginal generated during boosting.

The depth-limited search sharpened this into an envelope problem. A positive theorem would follow from a KL-stable or bounded-density-stable family of induced marginals whose weak-learner polynomials are all dominated by one polynomial depending only on the original marginal. The current source definition has no such local-uniformity assumption. Conversely, oracle-style diagonal examples that assign unrelated polynomials to reweighted marginals are not atlas counterexamples until they are realized by one concrete concept class and one uniform learner satisfying the source for every marginal.

The weak-agnostic-to-realizable-improper edge sharpened the issue further. Distribution-specific agnostic boosting is attractive because it can keep the instance marginal fixed by changing labels, but existing Feldman/Ghai-style theorems require threshold or correlation weak oracles with tunable additive slack. The atlas weak agnostic source provides only a fixed additive tolerance $\operatorname{OPT}+1/2-\gamma_P(s)$, and same-marginal relabeling cannot shrink this floor enough to drive realizable error to arbitrary $\varepsilon$.

There is a near-positive countable diagonal argument: if marginal-nonuniform guarantees are interpreted size-conditionally, any unbounded deterioration of the weak gaps over booster-induced transcript marginals can be stitched into one bad marginal, forcing an original-marginal envelope. Under the current global-mixture reading, however, weak learning may ignore sufficiently low-mass bad slices, so the diagonalization is not yet an atlas theorem.

The remaining false-witness route would need more than rare hard slices. Since the source quantifies over all marginals, including marginals that isolate a hard slice, a witness must remain weakly learnable on each slice. Cheap weak handles strong enough to certify that source tend to be available to an improper boosted learner as well. A genuine counterexample would need computationally nonboostable handles: one weak handle is easy under every marginal, but finding enough independent handles for low-error improper prediction is hard.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
