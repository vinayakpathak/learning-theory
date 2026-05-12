---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-agnostic-improper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-agnostic-improper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
summary: "Open: no known theorem turns distribution-free fixed-additive weak agnostic improper learning into marginal-nonuniform strong agnostic improper learning. Known boosters need tunable weak accuracy or have weak-sample/capacity parameters in representation-dependent exponents, while threshold-decoding and P-specific preprocessing templates remain near misses rather than atlas-valid separations."
family: agnostic-boosting-open
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Verdict

`open`.

Open. The source is distribution-free, so reweighted weak calls are not the marginal-uniformity problem here. The remaining gap is the lack of a fully polynomial fixed-additive agnostic booster or a matching deterministic-improper separation.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\beta$ for one fixed additive weak-agnostic tolerance $\beta<1/2$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$, and by a polynomial in $1/(1/2-\beta)$ if this tolerance is treated as a parameter. The tolerance is not a final-accuracy parameter that the learner may tune down to $\varepsilon$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether a distribution-free fixed-additive weak agnostic improper learner implies strong agnostic improper learning with marginal-dependent polynomial resources.

**Fixed-slack translation.** In correlation form, the source gives
$$
\operatorname{corr}(W,Y)\ge \sup_{c\in \mathcal C}\operatorname{corr}(c,Y)-2\beta
$$
for one fixed $\beta<1/2$. This is a nontrivial fixed-slack weak oracle, so the issue is not induced marginals: the same weak learner is valid on every reweighted distribution queried by a booster.

**Fixed-additive slack barrier.** Let the source tolerance be $\beta=1/2-\gamma$. The weak learner is forced to provide signal only on query distributions with $\operatorname{OPT}_{\mathcal C}<\gamma$. In correlation form it gives $\rho-2\beta$, not a tunable residual-scale oracle. Consequently Feldman/Ghai-style same-marginal agnostic boosters preserve the right marginal but do not drive excess error below the fixed slack floor.

**Marginal-nonuniform bookkeeping.** The target allows a polynomial $p_P$ for each marginal $P$, but this one polynomial must work for all conditional label rules over $P$. It cannot depend on the hidden comparator or have degree growing with the weak sample bound, representation-dependent capacity, or other parameters that vary with $s$.

**Known fixed-slack near positive.** Da Cunha--Hogsgaard--Paudice accepts the source as a fixed-slack weak oracle, but the available construction pays $n^{m_0}$-type or capacity-in-the-exponent costs. The apparent reason is a clean-tuple search for comparator-dependent low-noise structure. Since that structure is conditional-label information inside a fixed marginal, the marginal-nonuniform allowance does not remove the search.

**No atlas-valid separation.** A false witness would need a class that is distribution-free $\operatorname{OPT}+\beta$ weakly learnable by deterministic improper hypotheses on every marginal, while exact $\operatorname{OPT}+\varepsilon$ deterministic improper learning is hard under one fixed marginal. The sharp code template requires arbitrary-weight low-noise threshold decoding below $\gamma$ and high-noise fixed-marginal improper hardness above $\gamma$. Reed--Solomon soft-decision decoding is a near miss, but the binary arbitrary-bit-weight source condition, average-case PAC hardness, and improper-list-validation issues are not resolved by known theorems.

**Depth-8 search outcome.** Marginal-nonuniformity does not appear to give free preprocessing advice. The target permits a $P$-dependent polynomial bound for one uniform learner, but the missing clean traces are label-conditional and comparator-dependent, not determined by $P$ alone. The closest threshold-decoding and PRF/list-decodable-code templates found in the search have a fixed-marginal easy side rather than the distribution-free weak source required here.

**Depth-9 final check.** The final pass again found that the marginal allowance does not remove the clean-witness search. A $P$-specific preprocessing menu can depend on the unlabeled geometry, but it cannot identify which comparator-dependent traces or residual labels are below the fixed weak threshold. The closest PRF/code threshold separation remains fixed-marginal on the easy side rather than distribution-free on the source side, so it is still a near miss rather than a counterexample.

**Conclusion.** Keep the edge open. A fully polynomial fixed-slack agnostic booster or same-marginal low-OPT forcing lemma would resolve it true. A public threshold-decodable code family, or a semi-agnostic class with exact fixed-marginal hardness, would resolve it false. Neither is currently known.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
