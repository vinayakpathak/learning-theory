---
type: argument
id: multiclass-marginal-boosting-open
title: Multiclass Marginal-Nonuniform Boosting Open
domain: multiclass-classification
model: pac
status: open
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
- "[feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)"
- "[ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)"
- "[dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)"
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Marginal-Nonuniform Boosting Open

## Verdict

`open`, with evidence `unknown`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [feldman2010distributionspecific](https://arxiv.org/abs/0909.2927)
- [ghai2025agnosticboosting](https://proceedings.mlr.press/v267/ghai25a.html)
- [dacunha2026agnosticboosting](https://arxiv.org/abs/2601.11265)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
