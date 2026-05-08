# Open Edge Resolution Scratchpad

Edge: `efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`
Depth: 1
Date: 2026-05-05
Assigned file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
Family: `agnostic-boosting-open`
Atlas files edited: none

## Verdict First

I do not resolve the edge. In the atlas computational model, the implication should remain
`status: "open"` and `evidence: unknown`.

The fixed-additive source is not vacuous: it implies the recent "nontrivial" agnostic
correlation weak-oracle condition with fixed constants. This makes the da Cunha et al.
line very close to a positive resolution. The obstruction is that the known residual-free
fixed-slack booster is not a representation-uniform polynomial-time reduction: it uses an
enumeration over weak-learner samples of size `m0`, and in the atlas `m0` may be polynomial
in the representation size.

No separation witness was found. The likely right atlas action is no change: keep the edge
open, and record that the remaining gap is computational/uniform rather than purely
statistical.

## Definitions Read

Source node: `atlas/definitions/efficient-weak-agnostic-improper-pac.md`.

For one fixed additive tolerance `beta < 1/2`, the weak learner must, for every labeled
distribution `D`, output an efficiently evaluable improper hypothesis `h` with

$$
\operatorname{err}_D(h) \leq \operatorname{opt}_C(D)+\beta.
$$

Target node: `atlas/definitions/efficient-agnostic-improper-pac.md`.

For every requested `epsilon > 0`, the learner must run in time and samples polynomial in
the representation size, `1/epsilon`, and `log(1/delta)`, and output an improper hypothesis
`H` with

$$
\operatorname{err}_D(H) \leq \operatorname{opt}_C(D)+\epsilon.
$$

Edge and argument notes read:

- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- the earlier 2026-05-04 scratchpad for this same edge
- `references.bib` entries for the boosting papers

## Primary Sources Checked

- Ben-David, Long, and Mansour, "Agnostic Boosting", COLT/EuroCOLT 2001, DOI page and author
  metadata: https://doi.org/10.1007/3-540-44581-1_33 and
  https://cris.tau.ac.il/en/publications/agnostic-boosting/
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic Learning",
  JMLR 2003: https://www.jmlr.org/papers/v4/gavinsky03a.html
- Kalai, Mansour, and Verbin, "On Agnostic Boosting and Parity Learning", STOC 2008:
  https://doi.org/10.1145/1374376.1374466 and Microsoft Research PDF
- Kalai and Kanade, "Potential-Based Agnostic Boosting", NeurIPS 2009:
  https://papers.nips.cc/paper/3676-potential-based-agnostic-boosting
- Feldman, "Distribution-Specific Agnostic Boosting", ICS 2010 / arXiv:
  https://arxiv.org/abs/0909.2927
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", arXiv 2024:
  https://arxiv.org/abs/2410.23632
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", ICML 2025:
  https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting", arXiv 2025:
  https://arxiv.org/abs/2503.09384
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved
  Running Time", ALT 2026 / arXiv:
  https://arxiv.org/abs/2601.11265

## Lemma: Fixed Additive Weak Learning Gives A Fixed Nontrivial Correlation Oracle

Work with labels in `{-1,1}` and write

$$
\rho^*(D)=\sup_{c\in C}\operatorname{corr}_D(c)
       =\sup_{c\in C} \mathbb E_D[Yc(X)].
$$

Since `err(h)=(1-corr(h))/2`, the source guarantee gives

$$
\operatorname{corr}_D(h)\geq \rho^*(D)-2\beta.
$$

Also every binary hypothesis has correlation at least `-1`, so the actual lower bound is

$$
\operatorname{corr}_D(h)\geq
\max\{-1,\rho^*(D)-2\beta\}.
$$

The modern da Cunha/Ghai-Singh weak oracle asks for constants `(gamma0, epsilon0)` such that

$$
\operatorname{corr}_D(W)\geq
\gamma_0 \rho^*(D)-\epsilon_0.
$$

For any

$$
\gamma_0\in\left(\frac{1}{2(1-\beta)},1\right),
$$

set

$$
\epsilon_0 = 1-\gamma_0(1-2\beta).
$$

Then `gamma0 > epsilon0`, and for every `rho in [-1,1]`,

$$
\max\{-1,\rho-2\beta\}\geq \gamma_0\rho-\epsilon_0.
$$

Proof: the maximum of `gamma0*rho - max{-1,rho-2 beta}` over `[-1,1]` occurs at the
join point `rho=2 beta - 1`, where it equals `1 - gamma0(1-2 beta)`. The inequality
`gamma0 > epsilon0` is exactly `gamma0 > 1/(2(1-beta))`.

So the source is strong enough for any theorem that only needs fixed constants
`gamma0 > epsilon0`. It is not strong enough for theorems that need `epsilon0 =
O(gamma0 * epsilon)` for an arbitrary final target `epsilon`.

## Comparison Of Boosting Routes

### Ben-David--Long--Mansour and Gavinsky

Ben-David--Long--Mansour use essentially the atlas fixed-additive weak agnostic
definition: a beta-weak agnostic learner returns error at most `err_P(F)+beta`.
Their booster's guarantee is not the atlas target. The source page states a final
error of the form `max{c1(beta) er(F)^{c2(beta)}, epsilon}`, not `er(F)+epsilon`.

Gavinsky improves the standard fixed-beta agnostic boosting guarantee and gives
the smooth/adaptive optimum for that older model. The JMLR paper bounds final
error by roughly

$$
\frac{\operatorname{opt}_C(D)}{1/2-\beta}+\zeta,
$$

and also gives a lower-bound explanation for that boosting model. This is helpful
when `opt` is tiny, but it has a multiplicative loss when `opt` is bounded away
from zero. Thus these papers match the atlas source well but do not prove strong
agnostic learning.

### Kalai--Mansour--Verbin

Kalai--Mansour--Verbin explicitly changed the weak learner definition. Their
idealized `(alpha,gamma)` weak agnostic learner must return error at most
`1/2-gamma` whenever the class has optimum at most `1/2-alpha`.

The atlas source implies only the following threshold statement:

if `opt_C(D) <= 1/2-alpha`, then

$$
\operatorname{err}_D(h)\leq 1/2-(\alpha-\beta).
$$

This gives a positive weak edge only when `alpha > beta`. Full agnostic boosting
needs to operate at accuracy scales `alpha = O(epsilon)`, which eventually fall
below the fixed `beta`. So this route proves that full agnostic boosting is possible
under a stronger weak-interface, not under the atlas fixed-additive interface.

### Kalai--Kanade Potential Boosting

Kalai--Kanade use a correlation-style weak learner. In their Theorem 1, a
`(gamma, epsilon0, delta)` weak learner yields a final correlation guarantee of the
form

$$
\operatorname{corr}(h,D)\geq \operatorname{corr}(C,D)-\epsilon_0/\gamma-\epsilon.
$$

The algorithm has the right observable flavor: it can be implemented by relabeling
rather than by unobservable conditioning, and it keeps the feature marginal fixed.
The obstruction is quantitative. The atlas source gives a fixed `epsilon0`, so
the residual `epsilon0/gamma` is a fixed excess loss. To obtain arbitrary
`opt+epsilon`, this theorem needs a weak learner whose slack shrinks with the target
accuracy.

### Feldman Distribution-Specific Boosting

Feldman gives a clean distribution-specific weak-to-strong theorem, but the weak
definition is again parameterized. His `(alpha,gamma)` weak agnostic learner returns
error at most `1/2-gamma` whenever `Delta(A,C) <= 1/2-alpha`. Theorem 3.1 boosts
such a learner to `2 alpha`-optimal agnostic learning, and Theorem 3.2 derives strong
agnostic learning by invoking weak learning at `tau = epsilon/3`.

That last quantifier is exactly what the atlas source lacks. A fixed beta-optimal
learner can be viewed as useful only above a fixed threshold; it cannot provide
the `(tau, p(1/n,tau))` weak learner for every small `tau` required by Feldman's
strong conclusion. Feldman also notes that feeding a beta-optimal learner into the
distribution-independent variant recovers a Gavinsky-type multiplicative loss,
not `opt+epsilon`.

### Ghai--Singh

Ghai--Singh 2024 and 2025 use the correlation oracle

$$
\operatorname{corr}_{D'}(W)\geq
\gamma\max_{h\in H}\operatorname{corr}_{D'}(h)-\epsilon_0.
$$

Their algorithms are computationally efficient and use observable relabeled or
resampled data. But the final guarantees retain a residual weak-slack term:

- 2024 finite and VC results: `corr >= max corr - 2 epsilon0/gamma - epsilon`.
- 2025 unlabeled-data theorem: `corr >= max corr - 2 epsilon0/gamma - epsilon`.
- 2025 reuse theorem: `corr >= max corr - 3 epsilon0/gamma - epsilon`.

The 2025 paper explicitly observes that `epsilon0` can be made arbitrarily small
by feeding more samples to the weak learner. That is true for their weak-oracle
interface. It is not supplied by the atlas source, which gives only one fixed
additive beta. After the lemma above, the residual term is still a fixed constant,
so Ghai--Singh does not settle this edge.

### da Cunha et al.

The da Cunha 2025/2026 line is the strongest positive evidence. Their Definition 1
uses the same fixed `(gamma0, epsilon0, delta0, m0)` correlation weak learner, and
the 2026 theorem sets

$$
\theta=(\gamma_0-\epsilon_0)/2.
$$

The lemma above gives `theta > 0` from the atlas source. Unlike Ghai--Singh, the
da Cunha theorem removes the residual `epsilon0/gamma0` loss statistically, so for
fixed parameters it can reach arbitrary agnostic excess.

The problem is runtime and uniformity. The 2026 theorem states that the algorithm
invokes the weak learner at most

$$
O(n^{m_0+3})
$$

times and runs in time

$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$

The arXiv page and paper describe this as polynomial in the sample size when the
other problem parameters are fixed. In the atlas computational node, those parameters
are not fixed constants. The weak learner sample size `m0` may be polynomial in the
representation size, and the output/base-class dimensions may also grow with the
representation. Since the final sample size `n` is itself polynomial in the
representation size and `1/epsilon`, an `n^{m0}` enumeration is not a polynomial-time
atlas reduction.

## Why The da Cunha Enumeration Is Hard To Remove

The 2026 proof fixes a near-optimal comparator `f` and considers the clean subset

$$
S_f=\{(x_i,y_i): f(x_i)=y_i\}.
$$

On distributions supported on `S_f`, the labels are realizable by `f`, so the fixed
nontrivial weak oracle gives a hypothesis with positive edge `theta`. The algorithm
does not know `f` or `S_f`. It handles this by enumerating all `m0`-tuples from the
observable sample, with repeated weak-learner randomness, so that a successful hidden
tuple from `S_f^{m0}` is included in the generated menu.

This is not the same as calling the atlas weak learner on polynomially many observable
adaptive reweightings. If we call the atlas learner on the observable noisy sample
distribution instead, the best comparator correlation may be small, and the fixed
additive guarantee may give no positive edge. The residual-free proof needs the
realizable edge on `S_f`; the algorithm obtains it by exhaustive enumeration.

Thus a direct black-box proof would need a new idea that either:

- simulates the clean-subset edge without identifying `S_f` and without enumerating
  `n^{m0}` samples, or
- obtains arbitrary `opt+epsilon` from observable noisy reweightings despite fixed
  additive slack and without a residual `epsilon0/gamma` term.

I did not find such a theorem.

## Separation Search

A tempting separation template is an approximation problem where constant-additive
approximation is easy but PTAS-level approximation is hard. Translating this to learning
is subtle. A Max-CSP-style class with examples as constraints and hypotheses as assignments
can make random assignments a constant approximation on positive instances, while PCP
theorems can rule out near-optimal approximation. But agnostic PAC distributions may label
examples arbitrarily. Negative labels introduce complement predicates, and the easy random
assignment guarantee often becomes too weak to give beta `< 1/2` for every signed instance.

Constant prediction also fails on balanced realizable distributions: it gives error near `1/2`
while the weak source requires error strictly below `1/2` when `opt=0`.

So the usual Max-CSP/PTAS-hardness story does not immediately produce an atlas-valid
class satisfying fixed-additive weak agnostic improper learning for all labeled distributions
while failing strong improper agnostic learning.

## Proposed Atlas Changes

No atlas file should be changed from this depth-1 pass.

If atlas edits were later allowed, the current edge summary is already basically right. A slightly
sharper future summary would be:

> Open. The fixed-additive weak agnostic guarantee implies a nontrivial fixed-constant
> correlation weak oracle, so the da Cunha et al. residual-free statistical boosting theorem is
> close. However, known fully efficient observable boosters need weak-oracle slack shrinking
> with the final accuracy or retain a residual weak-slack term, while the da Cunha et al. fixed-slack
> construction uses an `n^{m0}` clean-subset enumeration and is polynomial-time only when
> weak-learner/base-class parameters are fixed. No separation witness is known.

## Promising Depth-2 Directions

1. Try to prove an observable fixed-slack booster: use only distributions samplable from the
   original noisy data and the feature marginal, tolerate fixed beta, and avoid any residual
   `epsilon0/gamma` term.

2. Try to replace da Cunha's enumeration over all `m0`-tuples by a polynomial search or
   compression argument. The key target is to find enough hypotheses that behave as if trained
   on the unknown clean subset `S_f` without knowing `f`.

3. Formulate a strengthened atlas node with a tunable weak agnostic oracle, such as Feldman's
   `(alpha,gamma)` weak learner for every `alpha` or Ghai-Singh's correlation oracle with
   `epsilon0=O(gamma epsilon)`. That strengthened node would imply the strong target by known
   theorems.

4. Search for a signed-CSP or valued-CSP witness rather than an ordinary positive Max-CSP
   witness. The witness must have a polynomial-time additive-beta approximation with
   `beta<1/2` for every signed/labeled distribution, while arbitrary additive approximation is
   hard.

5. Clarify the atlas convention for improper output representations. If outputs are polynomial-size
   circuits/strings, the base class generated by a weak learner has polynomial log-cardinality and
   evaluability bounds, which helps with VC bookkeeping. This does not remove the `n^{m0}`
   obstacle, but it isolates it as the main blocker.

verdict: open
confidence: 0.78

## Depth 2 Branch: da Cunha enumeration uniformity

**Goal.** Decide whether the `n^{m0}`-type enumeration in da Cunha--Hogsgaard--Paudice
can be treated as polynomial in the atlas representation size `s` and final accuracy
`1/epsilon`, perhaps because `m0` depends only on the fixed weak advantage, or whether it
is a genuine representation-uniformity obstruction.

**Sources read.** I checked the arXiv v3 source for da Cunha--Hogsgaard--Paudice 2026
`arXiv:2601.11265`: the weak-learner definition and theorem statement in `intro.tex`,
Algorithm 1 in `alg-main.tex`, the runtime proof in `proof.tex`, and the proof sketch
around the hidden clean subset. The arXiv page describes the result as polynomial in the
sample size when the other parameters are fixed; the conclusion also flags fully
polynomial dependence on all parameters as an interesting open question.

### Parameter Translation From The Atlas Source

The atlas source gives one fixed additive tolerance `beta < 1/2`. Depth 1 already showed
that this can be converted to da Cunha's fixed nontrivial correlation condition:

$$
\operatorname{corr}(W) \ge \gamma_0 \sup_{f \in \mathcal F}\operatorname{corr}(f)-\epsilon_0
$$

for constants `gamma0 > epsilon0`, hence constant

$$
\theta=(\gamma_0-\epsilon_0)/2>0.
$$

This fixed `theta` is the good news. It removes the usual residual-slack obstruction and
keeps all factors polynomial in `1/theta`.

The bad news is that da Cunha's `m0` is not a function only of this weak advantage. It is
the sample size of the supplied agnostic weak learner. Under the atlas efficient weak
agnostic node, after fixing the weak confidence `delta0` to a constant such as `1/3`, we
only know

$$
m_0 \le p(s,\log(1/\delta_0)) = p(s,O(1)),
$$

where `s` is the relevant representation size. Thus `m0` may be polynomial in `s`. The
fixed additive gap makes `theta` constant; it does not make the weak learner
constant-sample.

This matches the paper's own parameter discussion: common weak-oracle sample sizes are of
order roughly `(d + log(1/delta0))/epsilon0^2`. Allowing `epsilon0` and `delta0` to be
large constants still leaves dependence on the base-class dimension/representation
complexity `d`, which is allowed to grow in the atlas.

### What The Enumeration Does

Algorithm 1 splits the data into `S1` and `S2`. For

$$
R=\lceil \ln(n)/\theta^2\rceil,\qquad
M=\left\lceil \frac{\ln(5R/\delta)}{\ln(1/\delta_0)}\right\rceil,
$$

it loops over every index tuple

$$
I \in [n/2]^{m_0}
$$

and calls the weak learner on `S1|I`, with `M` independent seeds, in each boosting round.
It then validates over signs of averages of

$$
T=\left\lceil \min\left\{\frac{\ln n}{\theta^2},
260^2\frac{4d^*+2}{\theta^2}\right\}\right\rceil
$$

generated hypotheses. The theorem states, in the non-vacuous regime, at most

$$
O(n^{m_0+3})
$$

weak-learner calls and total running time

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$

For an atlas strong learner, the final sample size `n` would be polynomial in `s`,
`1/epsilon`, and `log(1/delta)` if the VC/output-complexity parameters are polynomially
bounded. But even in the friendly case where `theta` and `d*` are constants, the call count
contains

$$
n^{m_0}.
$$

If `m0 = s^a` and `n = poly(s,1/epsilon)`, this is

$$
\exp(\Omega(s^a\log n)),
$$

not a fixed-degree polynomial in `s` and `1/epsilon`. If `d*` also grows, the displayed
runtime exponent is larger. Including `m0` itself as a known parameter would not fix this:
`n^{m0}` is exponential in `m0 log n`, not polynomial in `m0`.

### Why Fixed Advantage Does Not Bound `m0`

The possible rescue would be: perhaps once `gamma0 > epsilon0` is fixed, the weak learner's
sample size is also fixed. That is not part of either definition.

In da Cunha's definition, `(gamma0, epsilon0, delta0, m0)` are all parameters of the weak
oracle. Fixing the first three leaves `m0` as the actual sample requirement of the oracle.
In the atlas source, efficient weak learning only promises a polynomial sample/time bound
in representation size and confidence. Therefore `m0` can grow with the concept-family
parameter even when the weak tolerance is an absolute constant.

So the exponent is not bounded by the weak advantage alone. It is bounded by the weak
learner's sample complexity, and the atlas intentionally allows that sample complexity to
scale polynomially with representation size.

### Why The Enumeration Seems Structural For This Proof

The proof fixes a near-optimal comparator `f` and the hidden clean subset

$$
S_f=\{(x_i,y_i)\in S_1: f(x_i)=y_i\}.
$$

For any distribution `D'` supported on `S_f`, the labels are realizable by `f`, so the
agnostic weak-oracle guarantee gives a hypothesis with error at most `1/2 - theta` with
high probability over an `m0`-sample from `D'` and the weak learner's seed. Because the
algorithm does not know `f`, `S_f`, or the adaptive AdaBoost distributions on `S_f`, the
proof turns this average guarantee into an existence statement: for each needed adaptive
distribution, there is some deterministic sequence `S' in S_f^{m0}` and a good seed.

Enumerating all tuples in `S1^{m0}` is what guarantees that the hidden witness tuple is in
the generated menu. Repeating `M` seeds then amplifies the chance of seeing the good
hypothesis for that tuple.

This is not equivalent to making polynomially many calls to the atlas weak learner on
observable reweightings of the noisy sample. On the noisy distribution, the best
correlation in `C` may be small enough that the fixed additive atlas guarantee gives no
positive edge. The positive `theta` edge appears after conditioning to the unknown clean
subset, and that conditioning is exactly the non-observable object the enumeration is
covering.

A smaller menu might be possible with extra structure, but it is not supplied by the
black-box theorem. One would need a polynomial-size hitting set or compression argument
that, for every possible hidden comparator and every adaptive distribution over its clean
subset, includes a weak-learner input tuple that is good for an arbitrary black-box weak
learner. The current proof gives no such structure, and the paper does not claim it.

### Branch Verdict

The da Cunha theorem is a genuine near-positive result, but the known algorithm does not
give a representation-uniform polynomial-time implication for the atlas edge.

The exponent cannot be bounded polynomially from the atlas source merely because the weak
advantage is fixed. Fixed advantage makes `theta` constant; it does not prevent
`m0 = poly(s)`, and then the enumeration `n^{m0}` is superpolynomial in the atlas
representation size. The result is polynomial-time only in the constant-parameter sense
used by the paper, not in the atlas strong-learning sense.

This branch therefore supports leaving

`efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`

as `open`. It does not prove a separation and does not rule out a different fully
polynomial fixed-slack booster.

verdict: unresolved/open; da Cunha as-is is uniformity-breaking for the atlas edge
confidence: 0.87

### Next Branch Ideas

1. Look for a follow-up or variant giving fully polynomial dependence on `m0`, `d*`, and
   `1/theta`; da Cunha et al. explicitly isolate this as the natural next computational
   question.

2. Try to replace the `S_f^{m0}` enumeration with a polynomial-size hitting set for the
   adaptive clean-subset distributions. This would need assumptions beyond the present
   black-box weak learner, or a new argument that exploits VC/dual-VC structure more
   aggressively.

3. Define a restricted positive subnode: fixed-additive weak agnostic learning with
   constant `m0` and constant/polynomially tame `d*`. For that narrower model, da Cunha's
   theorem may become an atlas-valid efficient implication.

4. Search for a black-box oracle lower bound showing that residual-free fixed-slack
   boosting must make about `n^{m0}` tuple queries in the absence of clean-subset access.

5. Continue the separation route with signed/valued CSP classes: find a class where
   constant-additive agnostic approximation is polynomial-time but arbitrary additive
   approximation is hard, while still satisfying the weak guarantee on every labeled
   distribution.

## Depth 3 Branch: agnostic boosting oracle/separation

**Goal.** Push on the two remaining possibilities after Depth 2:

1. find a real separation, or at least an oracle/black-box barrier, showing that the atlas
   fixed-additive weak agnostic improper source need not yield efficient strong agnostic
   improper learning; or
2. find a newer or alternative agnostic boosting theorem that avoids da Cunha's
   `n^{m0}` clean-tuple enumeration while still accepting fixed additive slack.

**Sources checked.** I rechecked the atlas source/target definitions and edge note, the
Depth 1 and Depth 2 scratchpad conclusions, and the following external sources:

- Ben-David--Long--Mansour 2001, "Agnostic Boosting":
  https://doi.org/10.1007/3-540-44581-1_33 and the TAU abstract page
  https://cris.tau.ac.il/en/publications/agnostic-boosting/
- Feldman 2010, "Distribution-Specific Agnostic Boosting":
  https://arxiv.org/abs/0909.2927 and the available PDF.
- Ghai--Singh 2024, "Sample-Efficient Agnostic Boosting":
  https://arxiv.org/abs/2410.23632.
- Ghai--Singh 2025, "Sample-Optimal Agnostic Boosting with Unlabeled Data":
  https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha--Hogsgaard--Paudice--Sun 2025, "Revisiting Agnostic Boosting":
  https://arxiv.org/abs/2503.09384 and the OpenReview PDF.
- da Cunha--Hogsgaard--Paudice 2026, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time": https://arxiv.org/abs/2601.11265.
- Diakonikolas--Impagliazzo--Kane--Lei--Sorrell--Tzamos 2021, "Boosting in the
  Presence of Massart Noise": https://proceedings.mlr.press/v134/diakonikolas21d.html.
- Feldman--Guruswami--Raghavendra--Wu, "Agnostic Learning of Monomials by Halfspaces
  is Hard": https://arxiv.org/abs/1012.0729 and the IBM summary page.
- Daskalakis--Golowich 2024/2025, "Is Efficient PAC Learning Possible with an Oracle
  That Responds 'Yes' or 'No'?": https://arxiv.org/abs/2406.11667.

### Starting Point

The branch starts from the fixed-additive source:

$$
\operatorname{err}_D(A(D)) \leq \operatorname{OPT}_C(D)+\beta
$$

for one fixed `beta < 1/2`. Let `gamma = 1/2 - beta`. This guarantee is genuinely weak:
if `OPT_C(D) >= gamma`, then an error-`1/2` hypothesis is already legal. The source only
forces a nontrivial prediction edge on distributions where the benchmark class has error
below `gamma`.

That observation explains why the da Cunha result is so close. It converts the problem to
weak learning on hidden near-realizable pieces: if a near-optimal comparator `f` is fixed,
then on the clean subset where `f(x)=y`, the optimum is zero and the fixed-additive source
must provide a real edge. The cost is that the clean subset is not observable. Depth 2
confirmed that da Cunha's algorithm handles this by enumerating all `m0`-tuples, which is
not representation-uniform polynomial when `m0 = poly(s)`.

### Alternative Theorem Search

I did not find a theorem that simultaneously has all three properties needed by the atlas
edge:

1. accepts the atlas fixed-additive weak promise with fixed `beta`;
2. removes the residual weak-slack term, reaching `OPT + epsilon` for arbitrary
   `epsilon`; and
3. runs in time polynomial in the representation size, `1/epsilon`, `log(1/delta)`, and
   the weak learner's own polynomial resource bounds.

The current theorem landscape still splits as follows.

**Efficient observable boosters.** Feldman, Kalai--Kanade, and Ghai--Singh style
algorithms make calls on observable reweighted or relabeled distributions. This avoids
the hidden-clean-subset enumeration and gives good computational behavior. But the weak
interface is stronger than the atlas source: either an `(alpha,gamma)` threshold must be
available at the final scale `alpha = O(epsilon)`, or a correlation oracle must have slack
`epsilon0 = O(gamma epsilon)`. A fixed `beta` source cannot be tuned this way.

**Fixed-slack residual-free boosters.** The da Cunha 2025/2026 line accepts any
nontrivial fixed correlation weak learner with `gamma0 > epsilon0` and statistically
removes the residual slack. The 2026 version improves the old exponential-in-`n`
algorithm to time polynomial in `n` when the other parameters are fixed, but the theorem
still has `n^{m0}` and

$$
n^{O(m_0 \min\{d^*,\log n\}/\theta^2)}
$$

terms. Since the atlas weak learner may have `m0 = poly(s)`, this does not give the
target efficient implication.

**General oracle-learning theorems.** Daskalakis--Golowich show that very weak
decision-style oracles can support efficient learning, including agnostic extensions with
a stronger oracle. This is useful context because it says ERM is not always the only
oracle route. But the oracle is not derivable from an atlas fixed-additive weak agnostic
learner: it decides or certifies empirical realizability/near-optimality questions,
whereas the weak learner only returns a hypothesis that may be legally uninformative
whenever `OPT_C + beta >= 1/2`.

So the positive route remains exactly as in Depth 2: either make the da Cunha clean-tuple
search fully polynomial in `m0`, or strengthen the source node to a tunable weak oracle.

### Why Standard Separation Templates Miss The Improper Target

A real separation would need a class with an efficient distribution-free weak agnostic
improper learner but no efficient distribution-free strong agnostic improper learner. This
is subtler than the neighboring proper separations.

**CSP/PTAS hardness.** A tempting idea is to encode Max-CSP: random assignments often give
a constant additive approximation, while arbitrary additive approximation is NP-hard. This
does not directly separate the atlas improper target. On a finite formula distribution
with all labels positive, the all-one improper hypothesis has zero error. More generally,
if the hard instance has only polynomial support, an improper learner can often memorize
the observed support and labels in polynomial samples. CSP hardness is a good proper
learning obstruction, but for the improper target it must be embedded in a way that
prevents trivial all-one or lookup-table hypotheses while keeping weak agnostic learning
easy on every distribution. I did not find such an embedding.

**PRF or one-way-function classes.** Cryptographic classes naturally make strong improper
agnostic learning hard over high-entropy marginals. But they also tend to destroy the
source. On realizable labels from a pseudorandom function under the uniform marginal, even
error `1/2 - gamma` prediction is already a PRF distinguisher. Adding public weak handles
is not enough in a distribution-free model: the adversary may put all mass on the hidden
region. To keep the source true, the weak learner needs a nontrivial predictor on every
high-entropy marginal where a concept is realizable, and that is already the kind of
information PRF hardness denies.

**Known weak agnostic hardness.** Results such as Feldman--Guruswami--Raghavendra--Wu
and Tiegel-style halfspace hardness point in the wrong direction for this edge. They show
that even weak agnostic learning is hard for natural classes or representations, so they
refute the source rather than separating the source from the target.

This does not rule out a separation. It says the witness must be more surgical than the
usual proper-learning, Max-CSP, or PRF templates: weak prediction must be genuinely easy
for every labeled distribution at the fixed additive scale, while arbitrary excess-error
prediction remains computationally hard even with improper outputs.

### Candidate Black-Box Oracle Barrier

There is a plausible black-box barrier explaining why a residual-free fixed-slack booster
might need an `n^{m0}`-type search without extra structure.

Consider a target distribution whose labels are generated by a near-optimal comparator
`f` and then corrupted on an `eta` fraction of the mass, where

$$
\gamma = 1/2-\beta < \eta < 1/2.
$$

The original distribution has `OPT_C(D)=eta`. Since `eta + beta > 1/2`, the atlas weak
guarantee allows the weak learner to be completely uninformative on the original noisy
distribution. But the strong learner with `epsilon << 1/2-eta` must still approach error
`eta`, which requires recovering substantial information about `f`.

On the hidden clean subset

$$
S_f = \{(x_i,y_i): f(x_i)=y_i\},
$$

the optimum is zero, so the fixed-additive weak learner must output a hypothesis with
error at most `beta`, equivalently advantage at least `gamma`. This is the useful signal
used by da Cunha. The problem is access: if a booster draws `m0` examples from the noisy
sample without knowing which points are clean, the probability of drawing an all-clean
tuple is roughly

$$
(1-\eta)^{m0}.
$$

For `m0 = poly(s)`, polynomially many random tuple calls miss such clean inputs with
overwhelming probability. Enumerating `S_1^{m0}` is the brute-force way to ensure that
the menu contains clean tuples for the hidden comparator.

This can be turned into an oracle story. Let the weak oracle be adversarial but valid:
on distributions/samples whose benchmark optimum is at least `gamma`, it returns a legal
but uninformative hypothesis; on realizable or near-realizable clean-subset samples, it
returns a useful weak hypothesis. Then any booster that treats the weak learner as a
black box and only makes polynomially many non-enumerative calls has no reason to see the
useful branch. A holdout set can compare hypotheses that were generated, but it cannot
certify that the ungenerated menu contains an `OPT + epsilon` hypothesis, because that
would amount to certifying the agnostic optimum.

This is not yet a formal lower bound. The missing pieces are:

- a precise oracle model specifying what distributions or finite samples the booster may
  feed to the weak learner;
- an adversarial weak oracle that satisfies the fixed-additive guarantee for all queried
  distributions, not just the intended hard distribution;
- a proof that every polynomial-query booster fails, not merely boosters that sample
  random tuples from the noisy sample; and
- a translation, if possible, from the oracle barrier to an actual represented concept
  class. This last step is the hardest because the atlas implication is not restricted to
  black-box use of the supplied weak learner; a strong learner could exploit the class
  representation directly.

The barrier nevertheless pinpoints the computational issue: fixed-additive weak agnostic
learning may only reveal signal below the `OPT < gamma` threshold, while the strong
agnostic problem asks for accuracy on distributions with much larger `OPT`. The known
residual-free proof reaches below that threshold by guessing clean evidence for a hidden
comparator.

### Relation To Massart Black-Box Lower Bounds

The Massart-noise boosting paper gives a useful warning but not a separation for this
edge. It proves that, in a different noise model, the achievable error for polynomial-time
black-box boosters is optimal under cryptographic assumptions. This supports the general
idea that black-box boosting in noisy settings can have real computational barriers.
However, Massart noise is structured label noise with a bounded pointwise noise rate,
whereas this edge is fully agnostic and benchmarks against `OPT_C`. The lower bound does
not directly say that fixed-additive weak agnostic improper learning fails to imply strong
agnostic improper learning.

### What Would Count As A Positive Escape

A fully positive branch would need one of the following.

1. **A polynomial clean-subset hitting argument.** Replace enumeration of all
   `m0`-tuples by a menu of size `poly(n,m0,d*,1/theta)` that still hits, for every
   hidden comparator `f` and every adaptive distribution over its clean subset, enough
   weak-learner inputs to run the residual-free proof.

2. **A noisy-sample weak-call theorem.** Show that the atlas fixed-additive weak learner,
   when called on carefully relabeled or reweighted observable noisy samples, must produce
   enough gradient information even when `OPT_C` is above the fixed threshold `gamma`.
   Existing Feldman/Ghai-style theorems get this from a stronger tunable oracle, not from
   fixed `beta`.

3. **Extra regularity of the weak learner.** Stability, monotonicity under label noise,
   SQ access with controlled tolerance, or a small explicit base class might let one avoid
   adversarial clean-tuple passwords. None of these regularities is part of the atlas
   source node.

4. **A different oracle supplied by the class.** A threshold/near-ERM decision oracle or
   empirical agnostic oracle might be enough by general oracle-learning theorems, but it
   would be an additional assumption, not a consequence of fixed-additive weak agnostic
   learning as currently defined.

### Branch Conclusion

This branch did not find a real separation and did not find a fully polynomial fixed-slack
booster. It does strengthen the reason for keeping the edge open:

- a separation cannot be a routine properness/CSP/PRF argument, because improper outputs
  and distribution-free weak learning defeat those simple templates;
- a black-box barrier is plausible: when `OPT_C(D)` is above the fixed weak threshold, the
  weak learner may legally reveal no signal on observable noisy distributions, so a
  residual-free booster must somehow locate hidden low-OPT clean evidence;
- da Cunha's `n^{m0}` enumeration is exactly one way to locate that evidence, and no
  checked theorem replaces it by a representation-uniform polynomial search.

verdict: unresolved/open; no separation found, but a clean-subset/password oracle barrier is the sharpest current obstruction to a fully polynomial fixed-additive booster
confidence: 0.83
next branches:
1. Formalize the oracle barrier: define an admissible fixed-additive weak oracle and prove
   a polynomial-query lower bound for boosters that only access it through sampled or
   reweighted finite distributions.
2. Search for polynomial-size clean-subset hitting sets using VC/dual-VC structure,
   compression, or list-decodable hard-core-set methods; this is the most direct route to
   removing the `n^{m0}` term.
3. Try a separation with high-entropy hard regions plus distribution-free weak handles,
   but require the handles to work on every marginal and prevent lookup/all-one improper
   hypotheses.
4. Check whether a strengthened atlas node with tunable `(alpha,gamma)` or
   correlation-slack weak oracles should be added separately; known Feldman/Ghai-style
   boosters would likely resolve that strengthened edge positively.

## Depth 4 Branch: fully polynomial fixed-slack boosting search

**Goal.** Test whether the `n^{m0}` clean-subset enumeration can be avoided by a more
algorithmic reduction using randomized labels, calibration/multicalibration, or online
convex optimization. The target is a representation-uniform reduction whose runtime is
polynomial in the concept representation size, `1/epsilon`, `log(1/delta)`, and the weak
learner's own polynomial sample/time bounds, while using only the atlas fixed-additive
weak agnostic improper source.

**Additional sources checked.**

- Kalai--Kanade, "Potential-Based Agnostic Boosting":
  https://www.microsoft.com/en-us/research/publication/potential-based-agnostic-boosting/
- Brukhim--Chen--Hazan--Moran, "Online Agnostic Boosting via Regret Minimization":
  https://arxiv.org/abs/2003.01150.
- Globus-Harris--Harrison--Kearns--Roth--Sorrell, "Multicalibration as Boosting for
  Regression": https://proceedings.mlr.press/v202/globus-harris23a.html.
- Casacuberta--Gopalan--Kanade--Reingold, "How Global Calibration Strengthens
  Multiaccuracy": https://arxiv.org/abs/2504.15206.
- da Cunha--Hogsgaard--Paudice--Sun, "Revisiting Agnostic Boosting":
  https://arxiv.org/abs/2503.09384.

### The Fixed-Slack Bottleneck

Write `beta < 1/2` for the source tolerance and `gamma = 1/2 - beta`. In correlation
language, the weak learner guarantees only

$$
\operatorname{corr}_Q(h) \geq \rho_C(Q)-2\beta,
$$

where `rho_C(Q)=sup_{c in C} corr_Q(c)`. Thus a black-box call forces a positively
correlated output only when `rho_C(Q) > 2 beta`, equivalently when
`OPT_C(Q) < gamma`. If `OPT_C(Q) >= gamma`, an adversarial but valid weak learner may
return a hypothesis with no useful correlation for the booster.

This is the core distinction between two families of methods:

- observable gradient methods are polynomial because their query distributions are
  samplable from the noisy data, current predictor, and fresh randomness;
- fixed-slack residual-free methods can make the weak learner useful by querying a
  low-OPT clean distribution, but the clean distribution depends on a hidden near-optimal
  comparator.

The former family lacks a fixed-slack forcing condition; the latter family lacks
polynomial observable access.

### Randomized Labels

The Kalai--Kanade/Ghai--Singh style move is attractive because it keeps the instance
marginal observable and changes labels instead. Given a current score `F`, the booster
constructs synthetic labels whose conditional expectation is a clipped residual or
negative gradient, then asks the weak oracle for a hypothesis correlated with those
synthetic labels.

This avoids clean-subset enumeration, but it changes the required weak interface. If the
best remaining direction has correlation

$$
\alpha = \sup_{c\in C} \mathbb E[c(X) r_F(X)],
$$

then the randomized-label distribution has `rho_C(Q)` on the order of `alpha` after
normalization. To drive excess error down to arbitrary `epsilon`, the algorithm must keep
getting useful outputs when `alpha = poly(epsilon)`. The fixed-additive source only gives
a positive edge once `alpha > 2 beta`, a fixed constant. When `alpha <= 2 beta`, returning
a constant predictor or any progress-neutral hypothesis is still compatible with
`err_Q(h) <= OPT_C(Q)+beta`.

Bias amplification does not remove this obstacle. One can sample labels with larger
variance, mix with constants, or clip the residual more aggressively, but a binary label
has conditional expectation in `[-1,1]`. These transformations can change constants and
weights; they do not turn an arbitrarily small observable residual correlation into a
constant-correlation weak-learning instance without also knowing where the comparator is
right. That knowledge is exactly the hidden clean-subset information.

So randomized labels give the right computational shape and the wrong oracle scale. They
prove positive results for tunable correlation oracles; they do not derive such an oracle
from the atlas fixed `beta` learner.

### Calibration And Multicalibration

Calibration suggests a different possible escape: maintain a probabilistic predictor
`p(x)` and audit residuals on level sets. If the predictor is calibrated and no audit
function from the weak class correlates with the residual on any level set, then
multicalibration/omniprediction theorems can imply optimality against a comparator class.
Recent calibration results make this route look especially tempting because calibration
plus multiaccuracy can recover strong agnostic learning-like conclusions.

The problem is again the auditing oracle. On a level set `S={x:p(x)=v}`, the useful
certificate is roughly

$$
\mathbb E[(Y-v)c(X)\mid X\in S] \neq 0
$$

or, in regression form, that some `c in C` improves squared loss over the best constant
on `S`. A calibration booster therefore needs an oracle that finds weak residual
correlation on every observable level set whenever such a residual correlation exists at
the target accuracy scale.

The atlas fixed-additive learner does not provide this. If we encode the residual as a
randomized binary label and the best audit correlation on `S` is `alpha`, the weak learner
is again allowed to ignore it when `alpha <= 2 beta`. If we instead try to condition on a
subset where the comparator is clean enough to make `OPT < gamma`, that subset is not an
observable calibration level set in general. In the noisy comparator example from Depth 3,
the useful set is

$$
S_c = \{(x,y): c(x)=y\},
$$

which depends on the unknown comparator `c`. A predictor can be globally calibrated on the
noisy labels without revealing `S_c`; calibration removes marginal bias, not the password
identifying which examples are uncorrupted relative to the hidden comparator.

Thus calibration gives a clean language for the missing object: an auditor that is
complete at arbitrarily small residual scales, or an observable partition that contains
low-OPT slices for every near-optimal comparator. Neither property follows from fixed
additive weak agnostic learning.

### Online Convex Optimization

OCO reductions recast boosting as optimization over the convex hull of weak hypotheses.
At each round, the booster has a gradient vector `g_t` on the current sample and needs a
linear optimization, separation, or weak optimization oracle returning `h` with

$$
\langle g_t,h\rangle
$$

competitive with `max_{c in C} <g_t,c>`, up to tolerance small enough for the final
regret/excess target.

This is not the same as the atlas source. One can convert `g_t` into weighted or
randomized labels and call the weak learner, but the induced weak guarantee is only

$$
\langle g_t,h\rangle
  \geq \max_{c\in C}\langle g_t,c\rangle - O(\beta \|g_t\|_1)
$$

after normalization. The additive error is fixed at the weak scale. A convex-optimization
analysis that wants final excess `epsilon` needs a separation/linear-optimization oracle
with tolerance `O(epsilon)` or a multiplicative correlation oracle whose additive slack is
tunable. Otherwise the OCO algorithm stalls once the remaining gradient advantage is below
the fixed slack.

This is exactly the same obstruction in optimization language. OCO supplies the outer
algorithm but not the inner oracle. The inner oracle needed for polynomial strong
agnostic learning is a weak agnostic gradient oracle, not merely a fixed-additive
classification weak learner.

### Formal Missing Oracle Property

The failed escape routes point to a precise missing property. A fully polynomial
fixed-slack booster would need an **observable fixed-slack forcing oracle**.

For a current predictor `F`, original distribution `D`, target accuracy `epsilon`, and
fixed source tolerance `beta`, the booster should be able to construct in polynomial time
a polynomial-size list of samplable query distributions

$$
Q_1,\ldots,Q_L
$$

using only samples from `D`, unlabeled samples from the marginal, `F`, previous weak
hypotheses, and public randomness, such that whenever some comparator `c in C` beats `F`
by more than `epsilon`, at least one query `Q_j` has all three properties below.

1. **Fixed-slack forcing.**

   $$
   \operatorname{OPT}_C(Q_j) \leq 1/2-\beta-\tau
   $$

   for some `tau >= 1/poly(s,1/epsilon)`. This ensures that the fixed-additive source is
   forced to return a nontrivial hypothesis on `Q_j`.

2. **Robust progress for every legal weak output.**

   Every hypothesis `h` satisfying

   $$
   \operatorname{err}_{Q_j}(h)\leq \operatorname{OPT}_C(Q_j)+\beta
   $$

   must yield detectable progress for the original objective, for example a
   `1/poly(s,1/epsilon)` decrease in the chosen potential or a comparable positive
   correlation with the original residual.

3. **Observable construction.**

   The sampler for `Q_j` and the progress test must not use the hidden comparator `c`, the
   clean set `{(x,y):c(x)=y}`, or an enumeration of `m0`-tuples whose size is
   superpolynomial when the weak learner's sample bound `m0` is polynomial in the
   representation size.

Existing approaches satisfy different subsets of these requirements:

- randomized-label and OCO boosters satisfy observable construction and progress if the
  oracle returns a good gradient direction, but they fail fixed-slack forcing at small
  residual scales;
- calibration methods satisfy observable construction over level sets, but need a
  complete residual auditor at the final scale, which is again stronger than fixed
  `beta`;
- da Cunha-style clean-subset boosting satisfies fixed-slack forcing and robust progress
  on the hidden clean query, but obtains observable construction by enumerating a
  superpolynomial menu when `m0 = poly(s)`.

So the missing property is not merely "find some useful weak hypothesis." It is stronger:
construct an observable query on which every valid fixed-additive weak response is useful.
Without this robustness, an adversarial weak learner can always choose a legal
progress-neutral output on high-OPT observable queries.

### Branch Conclusion

I did not find an alternate fully polynomial fixed-slack reduction. Randomized labels,
calibration, and OCO all clarify the same interface gap rather than closing it: they avoid
clean-subset enumeration by querying observable residual distributions, but observable
residual distributions require weak responses at arbitrarily small correlation scales.
The atlas source supplies only one fixed additive tolerance. The only checked route that
turns fixed slack into arbitrary excess is still to locate hidden low-OPT evidence for a
near-optimal comparator, and the known way to do that is the da Cunha `m0`-tuple
enumeration.

verdict: unresolved/open; no fully polynomial fixed-slack booster found, and the missing oracle property is an observable fixed-slack forcing oracle with robust progress for every legal weak output
confidence: 0.86
next branches:
1. Try to prove a black-box lower bound against polynomial-size observable forcing lists:
   construct an adversarial fixed-additive weak oracle whose only useful replies are
   protected by comparator-dependent clean-set passwords.
2. Search for structural conditions that imply observable fixed-slack forcing, such as
   small compression schemes, polynomial dual-VC clean-set hitting families, stable weak
   learners, or explicit finite base classes.
3. Formulate a strengthened atlas node for tunable residual/correlation weak oracles; the
   randomized-label, calibration, and OCO reductions appear positive for that stronger
   interface.
4. Check whether da Cunha's margin-filtering proof can replace full `m0`-tuple coverage by
   approximate clean coverage under additional distributional regularity, while keeping
   the original distribution-free edge unchanged.

## Depth 5 Branch: low-noise passwords for fixed-additive weak agnostic boosting

depth: 5
date: 2026-05-05
verdict: unresolved-open

**Goal.** Push the fixed-additive question one level closer to a theorem or obstruction:
either find a fully polynomial booster from a coarse atlas learner

$$
\operatorname{err}_D(W) \leq \operatorname{OPT}_C(D)+\beta,
\qquad \beta < 1/2,
$$

to arbitrary `OPT + epsilon`, or isolate an oracle/separation obstruction that is sharp
enough to inform the atlas.

### Sources Rechecked

I rechecked the current scratchpad, the source and target definition notes, the edge note,
`atlas/arguments/agnostic-boosting-open.md`, and the arXiv TeX for da
Cunha--Hogsgaard--Paudice 2025 and 2026. The 2026 theorem is still the closest positive
route: it accepts a `(gamma0, epsilon0, delta0, m0)` agnostic weak learner with
`theta=(gamma0-epsilon0)/2>0`, obtains residual-free agnostic excess, and calls the weak
learner at most `O(n^{m0+3})` times with total runtime

$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$

The same paper explicitly describes the runtime as polynomial in the sample size when the
other parameters are fixed and asks whether a statistically optimal algorithm can be
fully polynomial in all parameters. That is almost exactly the atlas gap: in this edge,
`m0` is allowed to be polynomial in the representation size.

### Positive Attempt: Can Fixed Slack Be Turned Into A Fully Polynomial Gradient Oracle?

Let

$$
\gamma = 1/2-\beta.
$$

The source forces useful information only on query distributions `Q` with
`OPT_C(Q) < gamma`. If `OPT_C(Q) >= gamma`, a hypothesis of error `1/2` is already within
`OPT_C(Q)+beta`, so an adversarial but valid weak learner may return a progress-neutral
classifier.

Every polynomial outer method I tried to fit into this interface reduces to a weak
gradient/auditing call. Given a current predictor `F`, it constructs an observable
distribution or randomized-label task whose best correlation with `C` is the remaining
improvement direction. Near optimum, that correlation can be `Theta(epsilon)`. The atlas
weak learner only approximates this best correlation to fixed additive error `2 beta`.
Thus the call is not forced to return the sign of the small gradient unless the weak
interface is strengthened to have tunable slack.

This blocks the usual polynomial shapes:

- randomized-label boosting needs residual correlation at scale `epsilon`;
- online convex optimization needs linear optimization or separation to tolerance
  `O(epsilon)`;
- calibration and multiaccuracy need an auditor that detects residuals on observable
  cells at the final scale.

All three can be powered by Feldman/Kalai--Kanade/Ghai--Singh style tunable oracles, but I
do not see a way to derive the required small-tolerance oracle from a single fixed
`beta`.

### Sharper Obstruction: Low-Noise Passwords Rather Than Fully Clean Tuples

Depths 2--4 described da Cunha's hidden clean subset as the source of useful signal. A
slightly sharper version is that the booster does not necessarily need an all-clean tuple;
it needs a training/query distribution whose effective optimum is below the fixed weak
threshold `gamma`.

Consider a diagnostic distribution generated by a hidden near-optimal comparator
`f in C`, then corrupted at independent noise rate

$$
\eta \in (\gamma+\kappa,\,1/2)
$$

for some constant or inverse-polynomial margin `kappa > 0`. The original distribution has
`OPT_C(D)=eta`. Since `eta > gamma`, the fixed-additive source is allowed to be completely
uninformative on `D`; an error-`1/2` answer is legal. But the strong target with
`epsilon << 1/2-\eta` must still get close to `eta`, which requires learning information
about `f`.

A weak call becomes forced only if the booster can feed the learner a distribution or
finite training sample with corruption rate below `gamma`. If it obtains candidate weak
training samples by drawing `m0` labeled examples from the observable noisy distribution,
the probability of seeing empirical corruption at most `gamma m0` is

$$
\Pr[\operatorname{Bin}(m_0,\eta)\leq \gamma m_0]
\leq
\exp(-m_0 D_{\mathrm{KL}}(\gamma\|\eta)).
$$

For `m0 = poly(s)`, polynomially many random observable attempts will miss these
low-noise passwords with overwhelming probability. Enumerating all `m0`-tuples from the
sample, as in da Cunha, is the brute-force way to ensure that the menu contains enough
passwords for every hidden comparator and every adaptive distribution over the region
where that comparator is reliable.

This is stronger than the "all-clean tuple" story. Even allowing near-clean tuples does
not change the representation-uniform problem: once the target noise `eta` is separated
above the weak threshold `gamma`, low-OPT weak-call inputs are large-deviation events
unless the algorithm can identify comparator-dependent reliable points.

### What A Black-Box Barrier Would Say

A meaningful oracle obstruction for the atlas would be:

1. The booster may query a fixed-additive weak learner on polynomially many samplable
   distributions or empirical samples constructed from the original sample, unlabeled
   marginal samples, previous weak hypotheses, validation tests, and public randomness.
2. The weak oracle is adversarial among all legal responses. On any queried distribution
   with `OPT_C >= gamma`, it may return a progress-neutral hypothesis. On low-OPT queries
   it must return a valid weak hypothesis.
3. There is a family of noisy-comparator distributions for which every polynomial-size
   observable query list misses all low-OPT/password queries with high probability, unless
   the booster already has substantial information about the hidden comparator.

This would not by itself prove `resolved-false` for the atlas edge, because the atlas does
not require a strong learner to use the supplied weak learner as a black box. A strong
learner could exploit the representation of `C` in a non-black-box way. Still, such a
barrier would be meaningful: it would explain why the only known residual-free fixed-slack
booster pays `n^{m0}` and why observable polynomial boosters need tunable slack.

The missing formal step is the third item. One has to define "observable query" broadly
enough to include relabeling, reweighting, validation, and adaptive mixtures, then prove
that these operations cannot manufacture `OPT < gamma` queries without essentially
guessing a hidden reliable subset. I do not have that proof.

### Separation Search Update

I still do not have an atlas-valid false witness.

CSP/PTAS templates remain blocked by improper output and signed labels. Positive CSP
instances allow random assignments to give constant approximations, but agnostic learning
distributions contain both positive and negative labels. For a predicate with random
acceptance probability `p`, negative labels correspond to the complement with acceptance
probability `1-p`; both sides cannot have random success strictly above `1/2`. A weak
learner must also handle realizable signed instances, where constant prediction and
ordinary random assignment can fail to beat `1/2`.

Cryptographic templates have the opposite problem. If a PRF-like hidden region makes
strong improper learning hard, then realizable or low-noise prediction on that region is
already weakly hard under the uniform/high-entropy marginal. Adding easy public handles
usually makes a proper or marginal-nonuniform weak source plausible, but in the
distribution-free improper source an adversary can put all mass on the hidden region.
Then the fixed-additive weak source itself fails.

The current source node is therefore surprisingly strong. Any false witness must make
coarse agnostic approximation easy for every labeled distribution while preserving
computational hardness of arbitrary excess approximation against improper hypotheses. I
did not find such a construction.

### Branch Verdict

The edge remains open.

The fixed-additive source is strong enough to satisfy the modern nontrivial correlation
condition with fixed constants, so the obstruction is not statistical. The obstruction is
also no longer just "clean subsets are hidden": the sharper issue is that, when the
original optimum lies above the weak threshold `gamma=1/2-beta`, any weak call that forces
progress must somehow construct a low-OPT query. Random observable construction finds
such low-noise/password queries with probability exponentially small in `m0`, and `m0`
may be polynomial in the atlas representation size. da Cunha's enumeration solves this by
paying `n^{m0}`; known polynomial observable methods avoid the enumeration only by
assuming tunable weak slack.

So I would not change the atlas edge. It should remain `status: "open"` and
`evidence: unknown`.

verdict: unresolved-open
confidence: 0.88

### Depth 6 Directions

1. Formalize the low-noise-password oracle model. The target statement should show that
   polynomially many observable queries fail to hit any `OPT < gamma` weak-call instance
   for a noisy hidden-comparator distribution when `m0=poly(s)`.
2. Look for a polynomial clean-set hitting theorem using more than VC/dual-VC dimension:
   sample compression, stable weak learners, or an explicit finite base class might give
   extra structure absent from the black-box atlas source.
3. Isolate a restricted true subedge: constant-sample fixed-additive weak learners, or
   fixed `m0,d*,theta`, should be boostable by da Cunha 2026. A note could record this as
   a conditional/parameter-fixed positive theorem without resolving the computational
   atlas edge.
4. Continue the signed-CSP search only if the construction prevents both all-one/lookup
   improper predictors and complement-label random-baseline failures. Ordinary Max-CSP
   does not meet the source.
5. Consider adding a separate strengthened weak node with tunable threshold/correlation
   slack. Feldman, Kalai--Kanade, Ghai--Singh, and OCO/calibration routes appear to give
   positive polynomial implications for that stronger interface.

## Depth 6 Branch: final low-noise-password synthesis

depth: 6
date: 2026-05-05
verdict: unresolved-open

**Goal.** Make one final attempt to resolve

$$
\texttt{efficient-weak-agnostic-improper-pac}
\Rightarrow
\texttt{efficient-agnostic-improper-pac}
$$

by either upgrading the depth-5 low-noise-password obstruction to an atlas-valid
separation, or finding a polynomial booster that avoids comparator-dependent low-noise
queries.

### Rechecked Interface

Write the fixed weak tolerance as

$$
\beta = 1/2-\gamma,\qquad \gamma>0.
$$

For a query distribution `Q`, the atlas weak learner is forced to return a classifier of
error below `1/2` only when

$$
\operatorname{OPT}_C(Q)+\beta < 1/2,
\qquad\text{equivalently}\qquad
\operatorname{OPT}_C(Q)<\gamma.
$$

In correlation notation the guarantee is only a fixed-additive approximation to the best
correlation:

$$
\operatorname{corr}(h,Y)
\geq
\sup_{c\in C}\operatorname{corr}(c,Y)-2\beta.
$$

Thus, on high-OPT residual or relabeled tasks, a valid adversarial weak learner may return
a progress-neutral hypothesis even when a near-optimal strong learner still needs
information about the best comparator.

The relevant modern positive results do not remove this mismatch. Ghai--Singh-style
observable boosters are polynomial and residual-based, but need weak-oracle accuracy at
the final scale. Feldman-style distribution-specific relabeling gives a clean positive
route for a threshold/correlation oracle with tunable parameters. da Cunha--Hogsgaard--
Paudice 2026 accepts fixed nontrivial agnostic weak parameters and removes the residual
term, but its stated running time contains

$$
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}
$$

and the proof explicitly constructs the weak-hypothesis menu by calling the weak learner
on all `m0`-tuples from the sample. This is polynomial in `n` only with `m0,d*,theta`
treated as fixed; in the atlas edge `m0` may be polynomial in the representation size.

### Final Positive Attempt: Can One Sample Low-OPT Queries Instead Of Enumerating Them?

The natural hope is to replace da Cunha's `n^{m0}` tuple enumeration by random or
adaptive sampling. The depth-5 obstruction says this fails on noisy-comparator
diagnostics.

Let `f in C` be a hidden comparator and let labels be independently corrupted at rate

$$
\eta \in (\gamma+\kappa,1/2)
$$

under some marginal `P`. The original distribution has `OPT_C(D) <= eta`, and if `f` is
the unique useful comparator, a strong learner with
`\epsilon << 1/2-\eta` must recover nontrivial information about `f`. But the weak
learner is not forced to reveal anything on `D`, because `eta > gamma`.

A call becomes forced only if the booster supplies a query whose effective noise relative
to some comparator is below `gamma`. If the query is produced by an `m0`-sample drawn
from the observable noisy distribution, the chance that the training tuple has empirical
noise at most `gamma` is bounded by

$$
\Pr[\operatorname{Bin}(m_0,\eta)\leq \gamma m_0]
\leq
\exp(-m_0D_{\mathrm{KL}}(\gamma\|\eta)).
$$

For `m0=poly(s)`, polynomially many random attempts miss these low-noise passwords with
overwhelming probability. Adaptive reweighting does not obviously help before the booster
has already identified where `f` is reliable. This exactly explains da Cunha's brute-force
menu: it guarantees that, for every hidden clean/reliable subset needed by the proof, the
menu contains the corresponding weak-learner input.

I do not see a replacement polynomial sampler. Any candidate sampler would need a
distribution-free way to enrich low-noise tuples without knowing either `f` or the clean
indicator. Existing observable boosters avoid this by never trying to force fixed-slack
weak calls; instead they ask for a tunable residual/correlation oracle.

### Final False Attempt: Why The Password Obstruction Is Not Yet An Atlas Separation

The low-noise-password story is a credible black-box barrier, but it is not an atlas-valid
false witness.

To mark the edge `false`, one needs a concept class `C` such that:

1. for every distribution over labeled examples, there is a polynomial-time improper
   learner with error at most `OPT_C + beta`; and
2. for some distributions, no polynomial-time improper learner can achieve
   `OPT_C + epsilon`.

The password construction only threatens black-box reductions that insist on using the
given weak learner. It does not rule out a non-black-box strong learner exploiting the
representation of `C`. More importantly, it does not by itself build a class satisfying
the source. If the hidden region is cryptographically hard, then distributions supported
entirely on a realizable or low-noise hidden region usually make even weak agnostic
learning hard. If public handles are added to make weak learning easy, the
distribution-free improper source lets the adversary put all mass where the handles carry
no information. This was the fatal issue for PRF, LPN, and one-way-function variants.

CSP and hardness-of-approximation variants also do not currently work. Constant-additive
optimization can be easy while PTAS is hard for some proper optimization problems, but
agnostic improper learning must handle signed labels and may output arbitrary prediction
rules, not assignments. Random-assignment baselines for positive constraints do not give
simultaneous weak prediction for negative labels, and lookup/memorization-style improper
hypotheses can destroy the intended proper optimization gap unless the construction adds
extra restrictions that are not part of this atlas node.

Thus the obstruction does not certify `status: "false"`. It certifies only that the most
plausible black-box route is blocked unless one proves a new observable low-OPT extraction
lemma.

### Missing Lemma, In Both Directions

The decisive positive lemma would be:

> **Observable fixed-slack forcing lemma.** Given samples from an arbitrary agnostic
> distribution `D`, a fixed-additive weak learner with tolerance `beta=1/2-gamma`, and a
> current predictor whose excess error is more than `epsilon`, there is a polynomial-time
> observable procedure producing polynomially many weak-learner query distributions
> `Q_1,...,Q_N` such that at least one `Q_i` has `OPT_C(Q_i)<gamma` and every valid weak
> response on that query yields inverse-polynomial progress toward `OPT_C(D)+epsilon`.

This would convert the atlas source into the target using a standard potential/OCO or
boosting argument. It is stronger than existing Ghai--Singh and Feldman hypotheses
because it must manufacture a low-OPT query from fixed slack rather than ask the oracle
to solve a small residual correlation problem directly.

The decisive negative lemma would be:

> **Password lower-bound lemma.** There is a representation family and a distribution over
> noisy hidden comparators such that every polynomial-time observable query generator,
> before it has already learned the comparator, produces only polynomially many query
> distributions with `OPT_C(Q)\geq gamma` with high probability; yet achieving
> `OPT_C(D)+epsilon` requires learning the comparator.

Even this would first be a black-box or oracle lower bound. To become an atlas false edge,
it would need to be embedded into a concept class that still has a distribution-free
polynomial-time `OPT+beta` improper learner on all labeled distributions. I do not have
that embedding.

### Atlas-Ready Synthesis

Recommended edge status remains:

```yaml
status: "open"
evidence: unknown
family: agnostic-boosting-open
```

Suggested summary text:

> Open. Fixed-additive weak agnostic learning gives useful forced responses only on
> query distributions with `OPT < gamma = 1/2 - beta`. Polynomial observable boosters
> such as residual, calibration, or OCO methods need weak information at the final
> `epsilon` scale, while da Cunha--Hogsgaard--Paudice obtain residual-free fixed-slack
> boosting by enumerating `m0`-tuples, with runtime `n^{O(m0 min{d*,log n}/theta^2)}`.
> When `m0` is polynomial in the representation size, noisy hidden-comparator examples
> make low-OPT weak-call inputs look like exponentially rare low-noise passwords. This
> explains the gap but does not yield a false witness, because an atlas separation would
> still need a class that is distribution-free `OPT+beta` improperly learnable while
> strong improper agnostic learning is hard.

Near-miss positive theorem worth recording elsewhere:

> If the weak learner's sample parameter `m0`, dual dimension parameter `d*`, and edge
> `theta` are treated as constants or otherwise bounded so that
> `n^{O(m0 min{d*,log n}/theta^2)}` is polynomial in the representation and accuracy
> parameters, then da Cunha--Hogsgaard--Paudice gives a fixed-slack agnostic boosting
> route. This is a parameter-restricted true subedge, not the full atlas implication.

Final verdict: unresolved/open. I would not edit the atlas implication except possibly to
sharpen the explanatory prose around low-noise passwords and the missing observable
fixed-slack forcing lemma.

confidence: 0.91
