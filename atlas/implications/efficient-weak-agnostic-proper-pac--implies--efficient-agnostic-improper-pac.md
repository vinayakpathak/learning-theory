---
type: implication
id: efficient-weak-agnostic-proper-pac__implies__efficient-agnostic-improper-pac
source: efficient-weak-agnostic-proper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
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
  - tiegel2023
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Open as an efficient PAC implication: recent agnostic boosting resolves the statistical/oracle version, but not the representation-uniform polynomial-time version recorded here."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`open`.

Open as an efficient PAC implication. The statistical/oracle version is essentially settled by recent agnostic boosting, but the known running-time bounds do not give the representation-uniform polynomial-time reduction required by this atlas node.

## Proof Status

**Goal.** Decide whether weak agnostic proper learning can be boosted to strong agnostic improper learning.

**What properness contributes.** The source hypotheses lie in $\mathcal C$, but the target allows an improper final vote. Thus properness of the weak hypotheses is not the obstacle; the real question is whether the fixed-additive weak agnostic learner supplies enough oracle power for efficient agnostic boosting.

**Translation to the boosting oracle.** Work in $\{-1,1\}$ labels. The fixed-additive condition
$$
\operatorname{err}(h) \le \operatorname{opt}_{\mathcal C}+\beta
$$
is equivalent to
$$
\operatorname{corr}(h,Y) \ge \max_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta .
$$
Thus a $\beta$-weak agnostic proper learner gives the agnostic weak oracle of da Cunha et al. with parameters $\gamma_0=1$ and $\epsilon_0=2\beta$. Since $\beta<1/2$, this is nontrivial: $\gamma_0>\epsilon_0$.

**What this proves statistically.** Da Cunha et al.'s theorem for nontrivial agnostic weak learners then yields an improper classifier $v$ with
$$
\operatorname{err}_{\mathcal D}(v)\le \operatorname{opt}_{\mathcal C}+O(\varepsilon)
$$
after choosing the sample size large enough. So, if the weak learner is treated as an oracle with fixed parameters and the cost measure is polynomial in the sample size, this edge should be regarded as true.

**Why this still does not settle the efficient edge.** The atlas edge is a representation-uniform computational claim. The da Cunha et al. running-time bound is polynomial in the sample size only when the weak-learner parameters are fixed; more explicitly, the displayed bound has an exponent depending on the weak learner's sample parameter $m_0$ and on the dual VC dimension of the base class. In an efficient PAC implication, $m_0$ and the relevant dimensions may grow with the representation size, so a bound of the form $n^{\operatorname{poly}(s)}$ is not polynomial time in the usual sense. Earlier efficient agnostic boosting results, including Ghai and Singh, require a more accuracy-sensitive oracle, for example $\epsilon_0=O(\varepsilon)$, while the atlas source gives only the fixed value $\epsilon_0=2\beta$. Ben-David, Long, and Mansour use exactly the fixed-additive weak notion, but their guarantee is weaker than $\operatorname{opt}_{\mathcal C}+\varepsilon$.

**Counterexample route checked.** Halfspaces would be the natural target-hard candidate, because Tiegel rules out even improper agnostic learning of halfspaces under worst-case lattice assumptions. But Tiegel's result also rules out the weak agnostic source for halfspaces: no efficient algorithm can output any binary hypothesis with nontrivial advantage even when the optimum halfspace error is tiny. Thus halfspaces cannot witness this implication's failure.

**Conclusion.** The best current classification is: true for the statistical/oracle or fixed-parameter boosting formulation, still open for the efficient PAC implication as stated here. To mark the edge true, one would need a boosting algorithm with polynomial dependence on the representation size and the weak learner's own polynomial bounds. To mark it false, one would need a class with efficient fixed-additive weak agnostic proper learning but hard strong agnostic improper learning.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
