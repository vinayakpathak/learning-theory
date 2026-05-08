# Edge: efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac

Date: 2026-05-05

Assigned edge: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`

Worker constraint: atlas files were read only; no atlas files edited.

## Verdict First

I do not resolve the edge. My recommendation is to keep the atlas edge

```yaml
status: "open"
evidence: unknown
family: agnostic-boosting-open
```

Marginal-nonuniformity helps less, and differently, than the current edge note suggests. Since the source here is already distribution-free weak agnostic learning, the ordinary "boosting calls reweighted marginals with uncontrolled marginal-dependent polynomials" obstruction is not the main blocker for this specific edge. One weak call has a distribution-free polynomial bound, so reweighted weak-call resources are controlled.

The remaining obstruction is the fixed-additive agnostic weak oracle itself. Known efficient same-marginal boosters need a tunable threshold/correlation oracle with additive slack at the final accuracy scale. The one recent theorem that accepts a fixed nontrivial slack, da Cunha--Hogsgaard--Paudice 2026, has runtime with the weak learner's sample size and base-class parameters in the exponent, so it does not give an atlas-polynomial learner.

## Sources Read

Atlas files:

- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/witnesses/halfspaces.md`
- nearby scratchpads for the distribution-free strong target and the marginal weak-to-strong sibling edge
- `references.bib`

Primary/source pages and TeX checked:

- Ben-David--Long--Mansour, "Agnostic Boosting", 2001, DOI `10.1007/3-540-44581-1_33`.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic Learning", JMLR 2003, https://www.jmlr.org/papers/v4/gavinsky03a.html.
- Feldman, "Distribution-Specific Agnostic Boosting", 2010, https://arxiv.org/abs/0909.2927.
- Ghai--Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", ICML 2025, https://proceedings.mlr.press/v267/ghai25a.html and arXiv source `2503.04706`.
- da Cunha--Hogsgaard--Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved Running Time", ALT 2026, https://arxiv.org/abs/2601.11265 and arXiv source.
- Hanneke--Moran--Thiessen, "Marginal-Nonuniform PAC Learnability", NeurIPS 2025, https://openreview.net/forum?id=aoVCFtox89.

## Definitions In Play

The source is distribution-free fixed-additive weak agnostic improper PAC learning. For some fixed $\beta<1/2$, one uniform polynomial-time learner returns an improper hypothesis $h$ such that for every joint distribution $\mathcal D$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta .
$$

The target is strong agnostic improper PAC learning with marginal-nonuniform resource bounds. For every instance marginal $P$, there must be a polynomial $p_P$ such that for every joint distribution $\mathcal D$ with marginal $P$ and every $\varepsilon,\delta$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon
$$

in time and samples at most $p_P(s,1/\varepsilon,\log(1/\delta))$.

Thus the target relaxes distribution uniformity, but it still requires a genuine polynomial in the representation size and $1/\varepsilon$. The degree may depend on $P$, but it cannot grow with $s$.

## Correlation Translation

Use labels in $\{\pm 1\}$ and write

$$
\rho^*(\mathcal D)
=\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)
=1-2\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

The source gives

$$
\operatorname{corr}_{\mathcal D}(h)
\ge
\rho^*(\mathcal D)-2\beta .
$$

So the atlas source is a fixed additive approximation to best correlation. It is nontrivial in the da-Cunha sense: it satisfies their correlation weak-oracle condition with

$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,\qquad
\theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta>0.
$$

But it is not a tunable correlation oracle. The additive correlation slack $2\beta$ is fixed, and can be close to $1$.

## Does Marginal-Nonuniformity Help?

It removes one obstacle but not the core one.

For the marginal-nonuniform weak source sibling, ordinary boosting is problematic because weak calls on reweighted marginals may have unrelated $P'$-dependent polynomials. That is not the main issue here: this source is distribution-free, so the weak learner's sample/time bound is one polynomial over all distributions.

Also, if there were a fully polynomial booster whose runtime were polynomial in the weak sample bound, weak runtime, $1/(1/2-\beta)$, capacity parameters, $1/\varepsilon$, and $\log(1/\delta)$, then a marginal-nonuniform target would be easier than a distribution-free target. Hidden marginal-dependent constants or cover exponents could often be absorbed into $p_P$, and unknown values could be searched for and validated by holdout.

But no such booster is currently available for the fixed-additive source. The surviving barriers are quantitative oracle/slack and parameter dependence.

## Near Miss: Feldman And Ghai--Singh

Feldman's distribution-specific agnostic boosting and Ghai--Singh's unlabeled-data booster are attractive because their weak calls preserve the feature marginal by relabeling examples. This is exactly the right shape for a marginal-nonuniform target: all calls could stay under the original marginal $P$.

The problem is the weak-oracle interface. Ghai--Singh use a correlation weak learner satisfying

$$
\operatorname{corr}_{\mathcal D'}(W)
\ge
\gamma \max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D'}(h)-\varepsilon_0,
$$

and their final theorem has a residual term $2\varepsilon_0/\gamma+\varepsilon$. To get arbitrary excess error, $\varepsilon_0$ must be chosen at the final scale. The atlas source gives only the fixed slack $2\beta$.

Feldman's threshold form has the same issue in different notation. A fixed $\operatorname{OPT}+\beta$ learner gives a threshold weak learner only when the requested threshold $\alpha$ exceeds $\beta$; it cannot supply the $\alpha=O(\varepsilon)$ calls needed for arbitrary strong agnostic excess.

Conclusion: Feldman/Ghai would likely prove a true edge from a strengthened tunable threshold/correlation weak node, but they do not prove this fixed-additive edge.

## Near Miss: da Cunha--Hogsgaard--Paudice 2026

This is the closest positive route. Their theorem accepts any nontrivial fixed correlation gap $\gamma_0>\varepsilon_0$, so the atlas source fits with $\gamma_0=1$ and $\varepsilon_0=2\beta$. Unlike Ghai--Singh, their statistical guarantee removes the residual weak-slack term.

The theorem still does not yield the atlas target. The arXiv source states that the algorithm invokes the weak learner at most

$$
O(n^{m_0+3})
$$

times, and has running time

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)} .
$$

Here $m_0$ is the weak learner's sample size and $d^*$ is the dual VC dimension of the weak base class. In the atlas source, $m_0$ may be polynomial in the representation size $s$, not a fixed constant. Even with constant $\theta=1/2-\beta$, the call count $n^{m_0+3}$ is generally $(\operatorname{poly}(s,1/\varepsilon))^{\operatorname{poly}(s)}$, not a polynomial in $(s,1/\varepsilon,\log(1/\delta))$.

There is also a representation mismatch. The atlas improper weak learner need not come with a clean base class $\mathcal H$ of small VC and dual VC dimension. One can try to define a budgeted output class consisting of all hypotheses the weak learner can print within a given time budget; on finite encodings its log-cardinality is bounded by the budget. But plugging that into the da Cunha theorem still leaves budget/VC quantities in the exponent.

Conclusion: da Cunha et al. show that the fixed-additive source is statistically close to boostable, but their current runtime is not an atlas-polynomial reduction.

## False-Witness Search

I did not find a concrete separation.

Halfspaces do not work for this edge. They are a valid witness against several realizable-source-to-agnostic-target edges, and they even separate a marginal-nonuniform weak agnostic source from the strong marginal target after low-noise robustification. But the source here is distribution-free fixed-additive weak agnostic improper learning, and the halfspace notes explicitly record that halfspaces fail that source under Tiegel's worst-case lattice hardness.

Noisy parity/LPN-style candidates also fail the source: the hard part is already producing nontrivial correlation in low-noise or high-best-correlation regimes, exactly what the fixed-additive weak source requires.

CSP/PCP approximation templates are tempting because constant additive approximation can be easy while PTAS-level approximation is hard. The difficulty is making the learning source hold for every labeled distribution, not just the positive CSP instances used in the hardness reduction. Signed labels, realizable balanced instances, and improper outputs tend either to break the weak source or to make strong improper empirical lookup feasible.

Thus a real false witness would need a class where one weak handle is efficiently findable for every distribution, but finding enough handles for arbitrary excess error is hard under some fixed marginal. I do not know such a witness.

## Proposed Atlas Changes

Do not edit the atlas from this pass.

If a note update were allowed, I would revise the summary away from the marginal-reweighting obstacle and toward:

> Open: because the source weak learner is distribution-free, marginal reweighting does not by itself break the resource bound. The remaining gap is quantitative: same-marginal efficient boosters require tunable correlation/threshold slack, while the fixed-additive source only gives a fixed slack; the current fixed-slack residual-free booster has weak-learner sample/base-class parameters in the runtime exponent.

I would also keep `ref_keys` including `dacunha2026agnosticboosting`, and add `feldman2010distributionspecific` and `ghai2025agnosticboosting` if the body discusses the same-marginal near miss.

## Depth-2 Directions

1. Prove or find a fixed-slack agnostic booster whose runtime is polynomial in $m_0$, weak evaluation time, $1/(1/2-\beta)$, capacity of the weak-output class, $1/\varepsilon$, and $\log(1/\delta)$. This would likely resolve the edge true, and marginal-nonuniformity could absorb remaining $P$-dependent constants.

2. Strengthen the atlas source with a tunable threshold/correlation weak oracle. A marginal-preserving theorem edge to the strong marginal-nonuniform agnostic improper node should then follow from Feldman or Ghai--Singh.

3. Formalize the budgeted-output-class approach for arbitrary improper weak learners. Check whether any modern agnostic boosting proof can use polynomial dependence on the budgeted class dimension rather than putting it in an exponent.

4. Search for a source-positive fixed-marginal hardness witness: an optimization/learning class with efficient distribution-free fixed-additive weak agnostic improper learning for all labeled distributions, but super-polynomial strong agnostic improper learning under one fixed marginal. Standard halfspace, parity, and positive-CSP reductions do not currently meet both requirements.

5. Build an oracle or black-box separation only as a diagnostic. It would not settle the atlas edge, but it could isolate whether the da Cunha enumeration barrier is inherent for black-box use of fixed-additive weak learners.

verdict: open
confidence: 0.82

## Depth 3 Branch: distribution-specific fixed-additive agnostic boosting

Branch question: if the target only asks for a polynomial bound after fixing the
feature marginal $P$, can one use a distribution-specific agnostic booster with
the atlas source oracle

$$
\operatorname{err}(W)
\le
\operatorname{OPT}_{\mathcal C}+\beta
\qquad(\beta<1/2\text{ fixed})
$$

to reach $\operatorname{OPT}_{\mathcal C}+\varepsilon$?  Or do the known
Feldman/Ghai/da-Cunha routes still need a slack parameter that tracks
$\varepsilon$?

Short answer: fixing the marginal is not enough.  Feldman and Ghai--Singh are
indeed same-marginal/distribution-specific in the relevant sense, but their
interfaces still require a tunable threshold/correlation slack.  da Cunha,
Hogsgaard, and Paudice remove the tunable-slack residual, so their theorem is
the real near miss; however their algorithm is not an atlas-polynomial
conversion for an arbitrary efficient improper weak learner, and it is not just
a same-marginal oracle theorem.

### Translation Of The Fixed-Additive Oracle

With $\{\pm1\}$ labels, write

$$
\rho^*(\mathcal D)=\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)
=1-2\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

The atlas weak source gives

$$
\operatorname{corr}_{\mathcal D}(W)
\ge
\rho^*(\mathcal D)-2\beta .
$$

So it is a fixed additive approximation to best correlation.  It does not
promise that, for every final scale $\varepsilon$, the weak learner can be run
with correlation slack $O(\varepsilon)$.

For Feldman's threshold notation, the same oracle implies an
$(\alpha,\gamma)$-weak agnostic learner only when $\alpha>\beta$, with
$\gamma=\alpha-\beta$: if
$\operatorname{OPT}\le 1/2-\alpha$, then

$$
\operatorname{err}(W)\le 1/2-(\alpha-\beta).
$$

Thus the threshold $\alpha$ cannot be pushed below the fixed $\beta$.  This is
exactly where the fixed-additive gap survives.

### Feldman 2010

Primary source checked: Feldman, "Distribution-Specific Agnostic Boosting",
ICS 2010, https://conference.iiis.tsinghua.edu.cn/ICS2010/content/paper/Paper_20.pdf
and arXiv page https://arxiv.org/abs/0909.2927.

Feldman's distribution-specific theorem is marginal-preserving: the booster
modifies only labels and keeps the same feature distribution $D$.  That is the
right shape for the marginal-nonuniform target.  But the theorem boosts an
$(\alpha,\gamma)$-weak agnostic learner to an $\alpha$-optimal learner, with
runtime polynomial in $1/\gamma$ and $1/\varepsilon$.  Feldman's Theorem 3.2
gets strong agnostic learning by assuming weak agnostic learning for every
threshold $\tau$, using an $(\varepsilon/3,p(1/n,\varepsilon/3))$ weak learner.

The atlas oracle cannot supply this for $\varepsilon<\beta$.  Taking
$\alpha=\beta+\eta$ only gives residual excess roughly $\beta+\eta$, not
arbitrary $\varepsilon$.  Feldman's distribution-independent variant can go
beyond the $\alpha$-optimal barrier only by changing the marginal and gives a
multiplicative $\operatorname{OPT}/(1-2\alpha)+\varepsilon$ style guarantee;
that is not the same-marginal route needed here, and it still does not turn a
fixed $\beta$ oracle into arbitrary additive excess.

Conclusion for Feldman: fixing the marginal helps with oracle availability, but
does not remove the need for a tunable threshold $\alpha=O(\varepsilon)$.

### Ghai--Singh 2025

Primary source checked: Ghai and Singh, "Sample-Optimal Agnostic Boosting with
Unlabeled Data", PMLR/ICML 2025, https://proceedings.mlr.press/v267/ghai25a.html
and arXiv TeX source https://arxiv.org/abs/2503.04706.

Ghai--Singh explicitly note that their algorithm applies in the
distribution-specific setting: their construction relabels examples and uses
unlabeled samples from $\mathcal D_X$, so samples sent to the weak learner have
the same feature marginal as the original problem.

Their weak oracle is correlation-style:

$$
\operatorname{corr}_{\mathcal D'}(W)
\ge
\gamma\max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D'}(h)
-\varepsilon_0 .
$$

The main theorem returns a classifier with correlation gap
$2\varepsilon_0/\gamma+\varepsilon$.  Plugging in the atlas fixed-additive
oracle gives, at best, $\gamma=1$ and $\varepsilon_0=2\beta$, hence a constant
residual correlation gap $4\beta$ and constant error residual $2\beta$ before
the booster's own $\varepsilon$ term.  To get atlas strong agnostic learning,
one would need to call the weak learner with $\varepsilon_0=O(\varepsilon)$.

Conclusion for Ghai--Singh: the fixed marginal is handled, but the theorem
still needs tunable additive weak slack.  The atlas fixed $\beta$ oracle is not
enough.

### da Cunha--Hogsgaard--Paudice 2026

Primary source checked: da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal
Agnostic Boosting with Improved Running Time", ALT 2026,
https://arxiv.org/abs/2601.11265.

This is the strongest positive evidence.  Their weak learner definition is also
correlation-style,

$$
\operatorname{corr}_{\mathcal D}(W)
\ge
\gamma_0\sup_{f\in\mathcal F}\operatorname{corr}_{\mathcal D}(f)
-\varepsilon_0,
$$

and their theorem only requires a fixed nontrivial gap
$\gamma_0>\varepsilon_0$.  The atlas oracle fits as
$\gamma_0=1$, $\varepsilon_0=2\beta$, and
$\theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta>0$.  Unlike Ghai--Singh, their
final statistical bound has no residual $2\varepsilon_0/\gamma$ term.  So if
all complexity parameters were harmless, this would close the fixed-additive
slack problem.

The complexity parameters are not harmless.  Their theorem invokes the weak
learner $O(n^{m_0+3})$ times and gives running time

$$
\operatorname{Eval}_{\mathcal H}(1)\,
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)} ,
$$

where $m_0$ is the weak learner sample size and $d^*$ is the dual VC dimension
of the base class $\mathcal H$.  The paper itself describes the running time as
polynomial in the sample size when the other parameters are fixed.

For the atlas source, $m_0$ is not a fixed constant; it may be a polynomial in
the representation size $s$ and confidence parameter.  Then
$n^{m_0}$ is generally not polynomial in $(s,1/\varepsilon,\log(1/\delta))$.
Marginal nonuniformity cannot absorb this, because $p_P$ may have
$P$-dependent coefficients and degree, but it still must be a polynomial in the
size parameter $s$; an exponent that grows like $m_0(s)$ is outside the target
definition.

There is also an improper-output mismatch.  The atlas source learner may print
arbitrary efficient hypotheses, with no distinguished base class $\mathcal H$
of controlled VC and dual VC dimension.  A budgeted-output-class repair gives a
finite class, but its dimension is tied to the weak runtime/output budget, and
da Cunha's theorem puts that dimension in the exponent.

Finally, if one tries to reinterpret da Cunha as a purely distribution-specific
same-marginal theorem, another issue appears: the proof uses the weak guarantee
for arbitrary distributions over subsamples/clean subsets, not merely for the
original marginal $P$.  Our actual source is distribution-free, so this is not
a blocker for the current edge; it is a blocker only for the stronger hope that
"fixed marginal alone" supplies a da-Cunha-style oracle.

Conclusion for da Cunha et al.: fixed additive slack is statistically enough,
but the known algorithm does not give the required polynomial-time atlas
reduction.

### Branch Takeaway

Fixing the marginal separates two obstructions:

1. Same-marginal oracle access: Feldman and Ghai--Singh solve this by relabeling
   rather than reweighting the feature distribution.

2. Fixed-additive slack: Feldman and Ghai--Singh do not solve this; da Cunha et
   al. solve it statistically but with $m_0$ and base-class parameters in the
   exponent.

Therefore the prior pass's conclusion survives depth 3.  Marginal
nonuniformity does not close the fixed-additive agnostic boosting gap for
`efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac`.

verdict: keep open; no theorem-backed implication from the known
distribution-specific boosters.

confidence: 0.86.

next branches:
1. Look for a residual-free fixed-slack agnostic booster with runtime polynomial
   in $m_0$, weak runtime, $1/(1/2-\beta)$, $1/\varepsilon$, and a capacity
   parameter not appearing in the exponent.
2. Check whether da Cunha's enumeration step can be replaced by adaptive calls
   to the atlas weak learner without requiring tunable $\varepsilon_0$ or
   exponential dependence on $m_0$.
3. Search for a concrete class showing that fixed-additive weak agnostic
   improper learning can be easy while same-marginal strong agnostic improper
   learning remains hard.

## Depth 4 Branch: can marginal nonuniform absorb fixed-parameter exponent

Branch question: da Cunha--Hogsgaard--Paudice give a residual-free fixed-slack
agnostic booster whose running time is polynomial in the final sample size
when the other parameters are fixed.  The marginal-nonuniform target also
allows the polynomial to depend on the fixed instance marginal $P$.  Can those
two facts be matched by declaring da Cunha's exponent to be part of $p_P$?

Short answer: only if the exponent is genuinely a function of $P$ alone.  In
the atlas edge, the problematic exponent is tied to the weak learner's sample
size, confidence schedule, output/base-class representation, and possibly the
weak gap.  Those are representation- and algorithm-parameters, not marginal
constants.  So the marginal-nonuniform quantifier does not by itself make the
da Cunha runtime atlas-polynomial.

### What The Target Can Absorb

The target says that for every marginal $P$ there is a polynomial $p_P$ such
that, for all representation sizes $s$, accuracies $\varepsilon$, and
confidences $\delta$, the learner runs within

$$
p_P(s,1/\varepsilon,\log(1/\delta)).
$$

Equivalently, after $P$ is fixed, the degree and coefficients of the polynomial
may depend on $P$, but they must be fixed before $s$, $\varepsilon$, and
$\delta$ vary.  Thus a runtime like

$$
C_P n^{K_P}
$$

is absorbable if $n$ is itself polynomial in
$(s,1/\varepsilon,\log(1/\delta))$.  A runtime like

$$
n^{m_0(s)} \quad\text{or}\quad n^{d^*(s)}
$$

is not absorbable unless $m_0(s)$ or $d^*(s)$ is bounded by a constant depending
only on $P$.

This is the key quantifier distinction.  Marginal-nonuniformity can hide
unknown marginal constants; it cannot hide a polynomial whose degree grows with
the representation size.

### Applying The Quantifier Test To da Cunha

The da Cunha theorem was already the near miss because it accepts fixed
nontrivial correlation slack.  In the notation used above, the atlas source
fits the oracle form with

$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,\qquad
\theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta>0.
$$

The running time obstruction is the dependence

$$
O(n^{m_0+3})\text{ weak calls}
$$

and

$$
\operatorname{Eval}_{\mathcal H}(1)\,
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)} .
$$

Here $m_0$ is the weak learner sample size and $d^*$ is the dual VC dimension
of the weak base class $\mathcal H$.  For an atlas efficient weak agnostic
improper learner, $m_0$ is generally some polynomial in the representation size
and in the confidence parameter needed for a boosting schedule.  It is not a
number determined by the marginal $P$.  Likewise, for an arbitrary improper
weak learner there need not be a small fixed base class $\mathcal H$ at all; a
budgeted-output repair makes $\mathcal H$ finite, but its dimension is tied to
the weak runtime/output budget and therefore to $s$.

If $m_0(s)=s^a$ and $n=\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$,
then the call count already looks like

$$
n^{s^a+3},
$$

which cannot be bounded by a single $P$-dependent polynomial degree
$K_P$.  If $d^*$ also grows with the representation or budgeted output class,
the exponent is larger.  If the weak tolerance is parameterized rather than
constant, then $\theta^{-2}$ may contribute another representation-dependent
factor in the exponent.  None of these quantities is made marginal-only by
fixing $P$.

### Why Fixed Marginal Does Not Make The Representation Fixed

One tempting escape is to say that, after fixing $P$, all problem-size
dependence has become a constant.  That is not the atlas convention.  A fixed
marginal may place mass across infinitely many encoded instance sizes, and the
learner must still have a polynomial resource bound as a function of the
representation size parameter used in the learning problem.  The polynomial
$p_P$ may be very bad, but it has one degree for all $s$.

Finite-support marginals are not a useful counterpoint.  If $P$ has support on
only bounded-size instances, then many learning questions become degenerate or
can be solved by marginal-specific lookup.  The edge asks for every fixed
marginal, including marginals with unbounded support where $s$ remains a live
parameter.

### What Would Be Enough

A da-Cunha-style positive proof for this edge would need one of the following
extra facts.

1. For each fixed $P$, the atlas weak learner can be replaced by a
   $P$-specific oracle with sample size $m_{0,P}$ and dual dimension $d^*_P$
   independent of $s$, while preserving the fixed-slack guarantee for all
   labeled distributions with marginal $P$.

2. The residual-free fixed-slack booster can be reanalyzed with polynomial,
   not exponential, dependence on $m_0$, $d^*$, and $1/\theta$.

3. The base class entering da Cunha can be chosen as a $P$-specific effective
   class whose capacity grows slowly enough that
   $m_0\min\{d^*,\ln n\}/\theta^2$ is bounded by $K_P$.

The first and third options look stronger than what the source gives.  The
source weak learner is distribution-free and improper; its sample and output
budgets are guaranteed to be polynomial, not marginal-constant.  The second
option is the cleanest possible theorem route: it would turn da Cunha from a
fixed-parameter near miss into an atlas-polynomial reduction.

### Branch Conclusion

The phrase "polynomial when the other parameters are fixed" is not enough for
the marginal-nonuniform target.  The target fixes $P$; it does not fix the weak
learner's sample size, the representation size, the confidence schedule, the
budgeted output class, or the weak-gap parameter.  Since da Cunha's exponent
contains exactly those quantities, the current theorem cannot be absorbed into
$p_P$ for the atlas edge.

verdict: keep open; marginal nonuniformity can absorb only genuinely
$P$-dependent exponents, while da Cunha's known exponent depends on weak
learner/base-class/representation parameters.

confidence: 0.89.

next branches:
1. Inspect whether da Cunha's $m_0$ can be treated as a constant for any
   natural atlas subfamily, for example finite-dimensional base classes with a
   fixed weak learner independent of representation size.
2. Look for a residual-free fixed-slack agnostic booster with runtime
   polynomial in $m_0$, $d^*$, $1/\theta$, $1/\varepsilon$, and
   $\log(1/\delta)$.
3. Try to prove a black-box lower bound showing that fixed-slack residual-free
   boosting from arbitrary sample-based weak learners requires
   $n^{\Omega(m_0)}$ calls or an equivalent enumeration step.
4. Search for a fixed-marginal hardness witness where weak agnostic improper
   learning has a distribution-free polynomial $m_0(s)$ but strong agnostic
   learning under one unbounded-support marginal would require
   super-polynomial time.

## Depth 5 Branch: can advice absorb the fixed-additive overhead?

depth: 5

Branch question: the source weak learner is already distribution-free, so every
weak call has one polynomial resource bound.  Can the target's
marginal-nonuniform polynomial $p_P$ absorb the remaining fixed-additive
agnostic boosting overhead, including the weak parameters and representation
length?  Or is there a source-positive obstruction showing that this absorption
cannot work?

verdict: unresolved-open

Short answer: marginal advice can absorb a genuinely fixed weak gap, but not the
known dependence on weak sample size, output-class capacity, or representation
length.  I still do not have a concrete source-positive counterexample, so this
is not a resolved false edge.  The best current position is that the edge
remains open for a sharper reason than the atlas implication note currently
states.

### What Marginal Nonuniformity Can Absorb

Fix the source learner $W$ and its additive tolerance
$\beta<1/2$.  In correlation notation the source says

$$
\operatorname{corr}_{\mathcal D}(W)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)-2\beta .
$$

Thus $W$ is a nontrivial fixed-slack correlation oracle with

$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,\qquad
\theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta .
$$

If a booster used this only through factors such as
$\operatorname{poly}(1/\theta)$, then the fixed-additive overhead would be
harmless.  If $\beta$ is treated as a parameter of the source learner, the
definition already permits polynomial dependence on $1/(1/2-\beta)$; if $\beta$
is simply fixed, the dependence is a class-level constant.  A target
marginal-polynomial $p_P$ can certainly hide constants depending on $P$, and
ordinary fixed constants not depending on $P$ are even less problematic.

So the obstruction is not "fixed slack costs a large constant."  The obstruction
is that the only residual-free fixed-slack theorem I found routes through
parameters that grow with the problem representation.

### The Known Residual-Free Route Still Fails The Quantifier Test

The live arXiv records checked at this depth are:

- da Cunha--Hogsgaard--Paudice--Sun, "Revisiting Agnostic Boosting",
  arXiv:2503.09384, last revised 2025-12-30, NeurIPS 2025.
- da Cunha--Hogsgaard--Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", arXiv:2601.11265, last revised 2026-02-03, ALT 2026.

The 2025 "Revisiting" paper is useful because it confirms that fixed
nontrivial slack is statistically boostable under a very general weak-oracle
definition.  It explicitly says the method is not computationally efficient.
It therefore strengthens the case that the atlas obstruction is computational,
not sample-theoretic.

The 2026 ALT paper is the computational near miss.  It turns the 2025
statistical route into a polynomial-in-$n$ algorithm when the other parameters
are fixed.  But its full theorem still invokes the weak learner

$$
O(n^{m_0+3})
$$

times and has running time

$$
\operatorname{Eval}_{\mathcal H}(1)\,
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)} .
$$

Here $m_0$ is the weak learner sample size and $d^*$ is the dual VC dimension of
the weak base class $\mathcal H$.  In the atlas source, an efficient weak
agnostic improper learner only promises

$$
m_0(s,\delta_0) \le \operatorname{poly}(s,\log(1/\delta_0)).
$$

Even taking $\delta_0$ constant, $m_0$ may grow as $s^a$.  With
$n=\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$, the factor $n^{m_0(s)}$
is not bounded by any single polynomial

$$
p_P(s,1/\varepsilon,\log(1/\delta))
$$

whose degree is fixed after $P$ is fixed.  Marginal nonuniformity lets the
degree depend on $P$; it does not let the degree depend on the representation
size $s$.

The same problem appears if one tries to manufacture a base class from an
arbitrary improper weak learner.  A budgeted-output class

$$
\mathcal H_{s,T}
=
\{ \text{hypotheses printed by } W \text{ within budget } T
   \text{ on size } s \}
$$

is finite, and its hypotheses have efficient evaluation if the weak learner's
outputs are evaluable.  But its logarithmic size, VC dimension, or dual VC
dimension is controlled by the budget and output length, hence by a polynomial
in $s$.  Plugging this into the ALT theorem puts that polynomial in the
exponent.  This is exactly the kind of dependence that $p_P$ cannot absorb.

### Why Same-Marginal Relabeling Still Does Not Fix It

Feldman and Ghai--Singh remain attractive because their boosters can preserve
the feature marginal by relabeling examples or using unlabeled data from the
original marginal.  For this edge, that removes the usual "boosting calls
uncontrolled reweighted marginals" worry.

But these algorithms pay for efficiency by using a tunable threshold/correlation
weak oracle.  With the atlas source, the best direct plug-in has additive
correlation slack $2\beta$, so their final residual is still constant unless
the weak learner can be rerun with slack $O(\varepsilon)$.  Same-marginal
oracle access does not convert fixed $\beta$ into tunable $\varepsilon_0$.

The 2026 ALT method is the opposite tradeoff: fixed nontrivial slack is enough,
but the algorithm simulates a clean realizable boosting run by generating
hypotheses from all $m_0$-subsamples of the observed sample and then searching
over short combinations.  That enumeration is where the $n^{m_0}$ dependence
comes from.  Since the clean subset is determined by a best comparator and the
label noise, it is not marginal-only advice; $p_P$ is not allowed to depend on
the conditional label rule or on the best concept.

### Attempted Source-Positive Obstruction

A false edge would need a class $\mathcal C$ with two properties:

1. There is a distribution-free polynomial-time improper learner achieving
   $\operatorname{OPT}_{\mathcal C}+\beta$ for some fixed $\beta<1/2$ on every
   labeled distribution.
2. For some fixed marginal $P$, no polynomial-time improper learner achieves
   $\operatorname{OPT}_{\mathcal C}+\varepsilon$ for arbitrary $\varepsilon$.

The usual atlas witnesses still do not provide this.

Halfspaces fail the source under Tiegel-style worst-case lattice hardness: the
hardness already rules out weak agnostic improper learning, not merely strong
agnostic learning.

PCP active-slice lookup classes satisfy too much on the improper side.  The
finite active slice allows one-slice lookup-table ERM or memorization, so the
same structure that gives weak improper learning also gives strong improper
learning.

One-way image-coordinate weak-handle classes are better for proper separations:
constants and bounded handles make weak proper learning easy, while strong
proper learning can force inversion.  For the current improper target, however,
the handles are also usable by an improper learner.  Moreover, strong improper
learning can memorize observed positive coordinate atoms and predict the
default elsewhere on the fixed coordinate marginal.  The candidate therefore
separates proper targets, not this improper agnostic target.

A real obstruction would need "computationally nonboostable handles": one
efficiently findable weak handle for every distribution, but no efficient way,
even with improper voting or lookup-style postprocessing, to assemble enough
independent handles to drive the excess error below $\varepsilon$ under a fixed
unbounded-support marginal.  I do not know a concrete class with that behavior.

### Depth 5 Conclusion

The edge is not resolved.

What depth 5 does settle is the bookkeeping question: marginal nonuniform advice
can absorb fixed constants such as $1/\theta=1/(1/2-\beta)$, but it cannot
absorb overhead whose exponent grows with $m_0(s)$, $d^*(s)$, output length, or
other representation-dependent weak-learner parameters.  The known residual-free
fixed-slack booster has exactly that kind of dependence.  Conversely, the known
same-marginal efficient boosters avoid the exponent problem only by requiring
tunable weak slack, which the atlas source does not supply.

obstacles:

1. No known booster simultaneously accepts fixed additive weak agnostic slack
   and has runtime polynomial in $m_0$, weak runtime, $1/\theta$,
   $1/\varepsilon$, and $\log(1/\delta)$ with representation parameters outside
   the exponent.
2. Budgeting the arbitrary improper weak learner's output class gives finite
   capacity, but that capacity grows with representation length and enters the
   known ALT running time exponent.
3. Marginal advice can depend on $P$ only, not on the conditional labels, best
   comparator, clean subset, or weak learner transcript structure needed by the
   fixed-slack residual-free simulation.
4. Existing hardness templates either fail the distribution-free weak agnostic
   source or become easy for the improper strong target.

next directions for depth 6:

1. Try to turn the da Cunha enumeration into an adaptive same-marginal procedure
   that calls the atlas weak learner on relabeled distributions, preserving
   fixed slack without an $n^{m_0}$ search.
2. Prove a black-box lower bound for fixed-slack residual-free agnostic boosting
   showing that some dependence like $n^{\Omega(m_0)}$ is unavoidable without a
   tunable weak oracle.
3. Search specifically for computationally nonboostable weak-handle classes:
   weak handles must be efficiently findable distribution-free, but collections
   of many useful handles must encode a hard object even for improper outputs.
4. Check whether any restricted atlas subfamily has $m_0$ and dual VC dimension
   bounded by constants depending only on $P$; that would give a true theorem
   for that subfamily, though not for the full edge.

confidence: 0.90

## Depth 6 Final Attempt: advice, fixed slack, and an atlas-valid verdict

depth: 6

### Final Verdict

I still do not resolve the implication.

Recommended atlas status:

```yaml
status: "open"
evidence: unknown
family: agnostic-boosting-open
```

The best final summary is:

> Open: the source is distribution-free, so ordinary reweighted weak calls are not the main obstacle. The true gap is fixed-additive agnostic boosting. Marginal-nonuniform advice can absorb hidden marginal constants and fixed weak gaps, and it could absorb hidden inverse-polynomial guesses by dovetailing, but it cannot absorb the representation/sample-size dependent exponents in the known residual-free fixed-slack boosters. Conversely, no concrete class is known that has efficient distribution-free fixed-additive weak agnostic improper learning while strong improper agnostic learning is hard under one fixed marginal.

### Quantifier Test For Marginal Advice

The target allows, for every fixed marginal $P$, a polynomial

$$
p_P(s,1/\varepsilon,\log(1/\delta)).
$$

Thus $P$ may choose the coefficients and degree once and for all. This can hide
constants depending on $P$, and it can hide an unknown inverse-polynomial weak
gap if a booster is polynomial in that gap: a uniform learner can dovetail over
candidate exponents and validate the resulting hypotheses on a holdout sample.

It cannot hide a runtime of the form

$$
n^{m_0(s)}
$$

or

$$
n^{d^*(s)}
$$

when $m_0$ or $d^*$ grows with the representation size. After $P$ is fixed, the
degree of $p_P$ must be fixed as $s$ and $\varepsilon$ vary. This is the decisive
bookkeeping obstruction for the da-Cunha-style route.

### Fixed Slack Translation

With $\{\pm 1\}$ labels, write

$$
\rho^*(\mathcal D)
= \sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)
= 1-2\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

The source gives, for one fixed $\beta<1/2$,

$$
\operatorname{corr}_{\mathcal D}(W)
\ge \rho^*(\mathcal D)-2\beta .
$$

So it satisfies the nontrivial fixed-correlation oracle condition used in the
da Cunha line with

$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,\qquad
\theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta>0.
$$

This is genuinely stronger than the marginal weak source with only
inverse-polynomial advantage. The halfspace false-witness route available for
some marginal weak edges therefore does not apply here: Tiegel-style hardness is
also evidence that halfspaces fail this distribution-free fixed-additive weak
source.

### Why The Positive Routes Still Miss

**Feldman/Ghai same-marginal boosters.** These are the right shape for
marginal-nonuniform learning because they can preserve the instance marginal by
relabeling examples or using unlabeled samples from the original $P$. If the
source were a tunable threshold/correlation weak oracle, this would likely prove
the target.

But their final guarantees keep a residual proportional to the weak oracle's
additive correlation slack, such as $\varepsilon_0/\gamma$. The atlas source
supplies only the fixed slack $2\beta$, not slack $O(\varepsilon)$. Dovetailing
over hidden parameters cannot shrink this slack.

**da Cunha--Hogsgaard--Paudice fixed-slack boosters.** This is the closest
positive result because fixed nontrivial slack is enough statistically. The
current improved-time theorem still uses terms of the form

$$
O(n^{m_0+3})
$$

weak calls and

$$
\operatorname{Eval}_{\mathcal H}(1)\,
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$

For the atlas source, $m_0$ is the weak learner's sample size and may be a
polynomial in $s$. For an arbitrary improper weak learner, a budgeted output
class can make the base class finite, but its VC or dual-VC parameters are tied
to the weak runtime/output budget and can also grow with $s$. These quantities
then sit in the exponent. Marginal advice cannot convert
$(\operatorname{poly}(s,1/\varepsilon))^{\operatorname{poly}(s)}$ into an
atlas-polynomial bound.

### Why The False Routes Still Miss

To make the edge false, one needs a class $\mathcal C$ such that:

1. $\mathcal C$ has an efficient distribution-free improper learner with
   $\operatorname{err}\le \operatorname{OPT}_{\mathcal C}+\beta$ for a fixed
   $\beta<1/2$ on every labeled distribution.
2. For some fixed marginal $P_0$, every improper learner achieving
   $\operatorname{OPT}_{\mathcal C}+\varepsilon$ needs super-polynomial time.

The known atlas witnesses do not fit this shape.

Halfspaces fail the first condition under the same lattice-hardness evidence
used for their strong agnostic hardness: the hard instances already rule out
weak prediction better than random guessing by even tiny advantages when
$\operatorname{OPT}$ is very small.

PCP and finite active-slice lookup classes usually satisfy too much: once
improper lookup tables or sparse ERM are allowed, the same mechanism that gives
the fixed-additive weak source tends to give strong agnostic improper learning.

One-way image-coordinate weak-handle classes are useful for proper targets, but
the handles are visible to an improper learner. Voting, lookup-style
postprocessing, or memorizing observed atoms prevents them from forcing strong
improper learning to recover the hidden proper seed.

So an atlas-valid false witness would need computationally nonboostable weak
handles: one efficiently findable handle for every distribution, but no
efficient way for an arbitrary improper learner to assemble enough handles to
obtain low excess error under one fixed marginal. I do not know such a concrete
class.

### Concrete Missing Lemma

A theorem of the following form would resolve the edge true.

**Fully polynomial nontrivial-gap agnostic booster.** Given an improper weak
learner $W$ satisfying

$$
\operatorname{corr}_{\mathcal D}(W)
\ge \gamma_0\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)
-\varepsilon_0
$$

for fixed $\gamma_0>\varepsilon_0$, construct an improper hypothesis with
error at most $\operatorname{OPT}_{\mathcal C}+\varepsilon$ in time polynomial
in

$$
m_0,\ T_W,\ 1/(\gamma_0-\varepsilon_0),\
1/\varepsilon,\ \log(1/\delta),
$$

and in a reasonable capacity/evaluation parameter for the weak output class,
with no $m_0$, dual-VC, output-length, or representation-size term in the
exponent.

For this edge, the weak learner is distribution-free, so the booster need not
solve the induced-marginal problem that appears in purely marginal weak-source
edges. After such a theorem, any unknown fixed gap or hidden polynomial degree
could be handled by dovetailing and holdout validation and absorbed into
$p_P$.

### Atlas-Ready Synthesis

Suggested replacement for the current edge explanation:

> The source is a distribution-free fixed-additive weak agnostic improper
> learner. Therefore, unlike marginal weak-source edges, reweighted weak calls
> do not by themselves violate the resource bound. In correlation form the
> source gives a nontrivial fixed-slack oracle
> $\operatorname{corr}(W)\ge \rho^*-2\beta$, which matches the statistical
> hypothesis of recent da-Cunha-style agnostic boosters. The remaining obstacle
> is quantitative. Feldman/Ghai-style same-marginal boosters require tunable
> additive correlation slack, while the fixed-slack residual-free boosters put
> the weak sample size, dual-VC/base-class parameters, or budgeted output
> complexity in the runtime exponent. A marginal-nonuniform polynomial may
> depend on the original marginal $P$, but it cannot have degree growing with
> the representation size or weak sample size. No concrete source-positive
> fixed-marginal hardness witness is currently known.

Recommended family remains `agnostic-boosting-open`, not
`marginal-boosting-open`: the remaining issue is not original-marginal
bookkeeping but the lack of a fully polynomial fixed-additive agnostic boosting
theorem, or a concrete nonboostable-handle separation.

verdict: unresolved-open

confidence: 0.91
