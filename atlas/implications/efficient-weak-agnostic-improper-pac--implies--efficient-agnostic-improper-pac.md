---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-agnostic-improper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
  - gavinsky2003
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
summary: "Still open under the atlas fixed-additive weak agnostic convention; standard agnostic boosting uses stronger oracle conditions than this edge assumes."
family: agnostic-boosting-open
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`open`.

Still open under the atlas fixed-additive weak agnostic convention; standard agnostic boosting uses stronger oracle conditions than this edge assumes.

## Proof Status

**Goal.** Decide whether the atlas weak agnostic guarantee $\operatorname{err}(h)\le \operatorname{opt}_{\mathcal C}+\beta$ for a fixed $\beta<1/2$ can be boosted to arbitrary excess error with improper final hypotheses.

**Why this is delicate.** In the realizable case, weak error below $1/2$ can be boosted. In the agnostic case, a fixed additive tolerance can be nearly vacuous when $\operatorname{opt}_{\mathcal C}$ is not tiny. To reach $\operatorname{opt}_{\mathcal C}+\varepsilon$, a boosting procedure needs useful information at scales comparable to $\varepsilon$, not merely at one fixed additive scale.

**Second-pass check: agnostic boosting.** In $\{-1,1\}$ notation, the atlas guarantee
$$
\operatorname{err}(h) \le \operatorname{opt}_{\mathcal C}+\beta
$$
is the same as
$$
\operatorname{corr}(h,Y) \ge \max_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta .
$$
Thus the source gives a fixed-slack approximation to the best correlation in $\mathcal C$. Ben-David, Long, and Mansour, Gavinsky, Kalai, Mansour, and Verbin, and more recent work of Ghai and Singh and da Cunha et al. give agnostic boosting theorems for weak-oracle formulations designed for iterative boosting.

**Why this still does not settle the edge.** These results are very close to the desired statement, but not a clean polynomial-time implication for this atlas node. Ghai and Singh assume an oracle interface tailored to their boosting procedure, not merely a single fixed-additive PAC learner. The da Cunha et al. result removes much of the statistical obstacle for broad nontrivial weak learners, but its generic running time is polynomial in the sample size only when the weak-learner parameters are fixed; it is not stated as a black-box polynomial-time reduction in the representation size and the weak learner's own polynomial bounds.

**Conclusion.** The implication remains open for the atlas convention. The obstacle is now mainly computational and definitional: a proof would need to show that the fixed-additive weak learner can be used with enough quantitative control to reach arbitrary excess error in polynomial time.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
