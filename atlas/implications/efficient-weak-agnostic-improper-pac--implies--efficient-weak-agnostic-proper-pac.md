---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - tiegel2023
  - khot2008dnf
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
summary: "Still open: this is weak agnostic properization, and the known halfspace lower bound fails the source while fixed-k DNF satisfies both sides."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`open`.

Still open: this is weak agnostic properization, and the known halfspace lower bound fails the source while fixed-k DNF satisfies both sides.

## Proof Status

**Goal.** Decide whether every weak agnostic improper learner can be made proper while keeping a fixed additive weak excess-error guarantee.

**Why the available lower bounds do not refute it.** Tiegel's halfspace theorem rules out weak agnostic improper learning itself, so halfspaces do not satisfy the source. Fixed-$k$ term DNF satisfies the target by a weak agnostic proper learner, so it also cannot separate the two nodes.

**Second-pass check: boosting and DNF hardness.** Agnostic boosting results such as Ghai and Singh and da Cunha et al. combine suitable weak hypotheses into stronger improper predictors, so they do not address the properization step. Khot and Saket give a much closer lower-bound near miss: proper fixed-term DNF cannot weakly learn two-term DNF with constant advantage under $\mathrm{NP}\not\subseteq\mathrm{RP}$.

**Why this still does not settle the edge.** The Khot-Saket lower bound is a constant-advantage statement, while the atlas weak-realizable convention permits inverse-polynomial advantage and the weak-agnostic convention uses fixed additive excess error. It also does not produce a class satisfying the weak agnostic improper source and failing exactly this weak agnostic proper target.

**What would settle it.** A proof would need a general computational projection from a weak improper hypothesis to a weak proper one. A counterexample would need a class where some outside hypothesis family gives fixed additive weak agnostic performance, but finding a comparably good member of $\mathcal C$ is hard.

**Conclusion.** This edge remains open.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
