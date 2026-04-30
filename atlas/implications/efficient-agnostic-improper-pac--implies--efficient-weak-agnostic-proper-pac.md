---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-agnostic-improper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
  - khot2008dnf
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
summary: "Still open: this asks for weak agnostic properization from a strong agnostic improper learner."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`open`.

Still open: this asks for weak agnostic properization from a strong agnostic improper learner.

## Proof Status

**Goal.** Decide whether a strong agnostic improper learner can always be converted into a weak agnostic proper learner.

**What is easy.** The source learner already gives a weak agnostic guarantee if improper final hypotheses are allowed: run it with any constant accuracy parameter. The only missing requirement is that the final hypothesis lie in $\mathcal C$.

**Why boosting references do not settle it.** Agnostic boosting theorems explain how to combine suitable weak agnostic hypotheses into stronger improper predictors, or use weak-oracle notions tailored to boosting. They do not give a general way to replace an arbitrary accurate improper predictor by a member of $\mathcal C$.

**Second-pass check: two near misses.** Recent agnostic boosting results, including Ghai and Singh and da Cunha et al., address weak-to-strong aggregation, but their final hypotheses are generally improper ensembles; they do not project a strong improper hypothesis back into $\mathcal C$. On the lower-bound side, Khot and Saket show constant-advantage hardness for proper weak DNF learning, but the atlas weak-agnostic node allows a fixed additive excess-error tolerance and the known DNF source conditions do not give an agnostic improper learner for this edge.

**Conclusion.** This remains a weak agnostic properization question. A proof would need a computationally efficient projection back into $\mathcal C$; a counterexample would need an agnostically improperly learnable class whose proper hypotheses are hard even to find with fixed weak additive excess error.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
