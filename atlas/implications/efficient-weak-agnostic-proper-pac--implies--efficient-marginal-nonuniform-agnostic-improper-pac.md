---
type: implication
id: efficient-weak-agnostic-proper-pac__implies__efficient-marginal-nonuniform-agnostic-improper-pac
source: efficient-weak-agnostic-proper-pac
target: efficient-marginal-nonuniform-agnostic-improper-pac
source_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
summary: "Open. A distribution-free proper fixed-additive weak agnostic learner supplies proper hypotheses suitable for an improper final vote, and same-marginal boosting shows that marginal changes are not the main obstruction. The open point is quantitative: known accuracy-sensitive agnostic boosters need weak slack at the final epsilon scale, while known residual-free fixed-slack boosters put weak sample or capacity parameters in the runtime exponent."
family: agnostic-boosting-open
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: proper-to-improper
argument_note: "[[agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Improper PAC Learning

## Verdict

`open`.

Open. The source is distribution-free, so the live obstruction is fixed-additive agnostic boosting rather than marginal reweighting.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether [[efficient-weak-agnostic-proper-pac|efficient weak agnostic proper PAC learning]] implies [[efficient-marginal-nonuniform-agnostic-improper-pac|efficient marginal-nonuniform agnostic improper PAC learning]].

**Fixed-slack source.** The source uses a fixed additive tolerance $\beta=1/2-\gamma$ with constant $\gamma>0$. In correlation form it gives only a constant-slack approximation to the best proper correlation, so it is forced to reveal useful information only on weak-call distributions where the best proper error is below $\gamma$.

**Why the target relaxations do not settle it.** Since the weak outputs are already proper and the target is improper, a positive proof may output a vote or aggregate over weak hypotheses. Since the source is distribution-free, ordinary reweighting is allowed; same-marginal relabeling is also compatible with the target's marginal-nonuniform accounting. The obstruction is that a fixed marginal polynomial cannot identify the hidden label-dependent clean subsets needed to force below-threshold weak calls.

**Known positive evidence.** Accuracy-sensitive same-marginal boosters prove the desired kind of conclusion from a tunable weak oracle, but the atlas weak oracle has fixed slack. The fixed-slack boosting theorem of da Cunha--Hogsgaard--Paudice semantically accepts this source and permits an improper aggregate, but the current generic runtime has weak sample and capacity parameters in the exponent. This is polynomial only in fixed-parameter regimes, not in the full representation-uniform atlas sense.

**Known negative evidence.** Affine parities, under constant-noise decision-LPN, separate an inverse-polynomial weak-gap variant from the target: clean-batch Gaussian elimination gives proper weak learning at gap $\Theta(1/n)$, while strong improper agnostic learning under the uniform marginal would distinguish LPN. For fixed constant slack, the same witness fails the source, since weak learning below a constant LPN noise rate would itself distinguish noisy parities.

**What would resolve the edge.** A true proof would require a fully polynomial fixed-slack agnostic booster, with runtime polynomial in the weak learner's sample/time bounds and capacity parameters rather than exponential in them. A false proof would require a class with arbitrary-weight proper threshold decoding below a fixed constant noise level, but fixed-marginal high-noise hardness even for improper prediction. Neither object is currently known.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
