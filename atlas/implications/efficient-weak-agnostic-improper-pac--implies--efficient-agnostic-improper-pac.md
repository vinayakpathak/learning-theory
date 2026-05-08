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
summary: "Still open. A fixed-additive weak agnostic improper learner gives useful guarantees only on query distributions with OPT_C below the weak gap. Known observable polynomial agnostic boosters require weak slack at the final accuracy scale, while known residual-free fixed-slack boosters use candidate enumeration whose runtime is not polynomial uniformly in the atlas representation parameters."
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

Still open under the atlas fixed-additive weak agnostic convention. The closest positive results are agnostic boosting theorems, but the known fully observable polynomial boosters use weak-oracle information at a scale that shrinks with the target accuracy, while the fixed-slack residual-free constructions are not known to be polynomial uniformly in the atlas representation parameters.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether the atlas weak agnostic guarantee $\operatorname{err}(h)\le \operatorname{opt}_{\mathcal C}+\beta$ for a fixed $\beta<1/2$ can be boosted to arbitrary excess error with improper final hypotheses.

**Why this is delicate.** Write the weak tolerance as $\beta=1/2-\gamma$. On a query distribution $Q$, the weak guarantee is forced to return a hypothesis with error below $1/2$ only when
$$
\operatorname{opt}_{\mathcal C}(Q)<\gamma .
$$
Thus a fixed-additive weak learner may be progress-neutral on noisy residual tasks even when a strong learner must still recover information about a near-optimal comparator.

**Second-pass check: agnostic boosting.** In $\{-1,1\}$ notation, the atlas guarantee
$$
\operatorname{err}(h) \le \operatorname{opt}_{\mathcal C}+\beta
$$
is the same as
$$
\operatorname{corr}(h,Y) \ge \max_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta .
$$
Thus the source gives a fixed-slack approximation to the best correlation in $\mathcal C$. Ben-David, Long, and Mansour, Gavinsky, Kalai, Mansour, and Verbin, and more recent work of Ghai and Singh and da Cunha et al. give agnostic boosting theorems for weak-oracle formulations designed for iterative boosting.

**Why known boosters do not settle the edge.** Efficient observable boosters with tunable weak oracles inherit a residual term proportional to the weak oracle's additive slack. The atlas source has a flat region:

$$
\max\{0,\rho-2\beta\}.
$$

Any bound of the form $\operatorname{corr}\ge a\rho-\tau$ valid for this flat region has $\tau/a\ge 2\beta$, so the residual cannot be driven to $O(\varepsilon)$. The fixed-slack residual-free boosters avoid this residual, but their known candidate-generation step has weak-sample or capacity parameters in exponents. This is not a representation-uniform polynomial-time reduction when those parameters may grow with the concept representation.

**Posterior certification obstruction.** In a noisy-comparator distribution $Y=F(X)N$ with noise rate $\eta\in(\gamma,1/2)$, the original distribution has $\operatorname{OPT}_{\mathcal C}\le\eta$, so the weak learner may be progress-neutral. To force a useful weak call, an observable booster must create or certify a lower-noise subproblem. But posterior updating through one noisy label can cross the weak threshold only on mass where the transcript already predicts the hidden comparator with correlation at least

$$
r_\star(\eta,\gamma)
=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

Thus generic reweighting, relabeling, filtering, validation, and compression do not start the process unless substantial comparator information is already present.

**Clean-tuple barrier.** A tempting replacement is to sample only the useful weak-learner inputs instead of enumerating them. If the needed weak input is an $m_0$-sample whose empirical corruption is at most $\gamma$, a random attempt succeeds with probability exponentially small in $m_0$. The known fixed-slack construction avoids this by exhaustive menu enumeration; no observable polynomial sampler is currently known.

**Why this is not a false edge.** The password picture is a black-box obstruction, not an atlas separation. A false edge would require a class that is distribution-free $\operatorname{opt}+\beta$ improperly learnable on every labeled distribution while strong improper agnostic learning remains hard. Cryptographic hidden-comparator templates usually make the weak source hard on distributions supported inside the hidden region, and public-handle variants let adversarial distributions avoid the handles.

**Conditional true principles.** The implication would be true under tunable weak slack, a fully polynomial fixed-slack booster, a fixed-parameter regime where the known exponents are constant, or an extra stability/generosity condition forcing the weak learner to return useful hypotheses on noisy comparator distributions.

**Why this is not a false edge.** The posterior and clean-tuple arguments are black-box barriers. A false atlas edge would need an explicit concept class that has a public polynomial-time $\operatorname{OPT}+\beta$ improper learner on every distribution, while $\operatorname{OPT}+\varepsilon$ improper learning remains hard. Halfspaces, parities/LPN, code families, CSP templates, cryptographic hidden regions, public-handle constructions, and known semi-agnostic examples do not currently provide such a witness.

**Missing lemma.** A positive resolution would follow from an observable fixed-slack forcing lemma: whenever a current predictor has excess error more than $\varepsilon$, a polynomial-time observable procedure should generate polynomially many weak-learner query distributions, one of which has $\operatorname{OPT}_{\mathcal C}<\gamma$ and whose valid response yields inverse-polynomial progress. The corresponding negative route would need to embed the posterior or clean-tuple barrier into a class that still satisfies the distribution-free weak improper source. Neither lemma is currently known.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
