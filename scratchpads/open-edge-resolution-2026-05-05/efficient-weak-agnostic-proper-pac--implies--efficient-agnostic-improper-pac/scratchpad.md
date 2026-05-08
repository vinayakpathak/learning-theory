# Open Edge Resolution Scratchpad

Edge: `efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac`
Depth: 1
Date: 2026-05-05
Assigned file: `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`
Family: `agnostic-boosting-open`
Atlas files edited: none

## Verdict First

I do not resolve the edge. Under the current atlas computational convention, it should remain

```yaml
status: "open"
evidence: unknown
```

The strongest positive evidence is still the da Cunha--Hogsgaard--Paudice ALT 2026
booster: the atlas fixed-additive weak agnostic proper learner gives exactly a nontrivial
fixed-constant correlation weak learner, and the 2026 theorem boosts such learners
statistically. The remaining gap is not semantic; it is representation-uniform running time.
The known fixed-slack residual-free booster enumerates all weak-learner samples of size
`m0`, and `m0` may grow polynomially with the representation size in this atlas node.

I found no separation witness. The properness of the source does not seem to create a new
negative route; it mostly sets the weak-output/base class to `C`, while the target already
allows an improper final vote over proper weak hypotheses.

## Endpoint Definitions

The source node `efficient-weak-agnostic-proper-pac` gives a randomized learner `W`, a fixed
additive tolerance `beta < 1/2`, and polynomial sample/time bounds such that for every
distribution `D` over examples,

$$
\operatorname{err}_{D}(W)
\le
\inf_{c\in C}\operatorname{err}_{D}(c)+\beta,
\qquad
W \in C.
$$

The target node `efficient-agnostic-improper-pac` asks for an algorithm that, for every
requested `epsilon > 0`, runs in time polynomial in the representation size, `1/epsilon`,
and `log(1/delta)`, and outputs some polynomially evaluable hypothesis `g`, not necessarily
in `C`, with

$$
\operatorname{err}_{D}(g)
\le
\inf_{c\in C}\operatorname{err}_{D}(c)+\epsilon.
$$

The target is improper, so a final majority/sign vote over hypotheses in `C` is allowed.

## Sources Checked

Local read-only context:

- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- Prior scratchpads for this proper edge from 2026-05-04.
- The 2026-05-05 sibling scratchpad
  `efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac`.

Primary/literature sources checked or rechecked:

- Ben-David, Long, and Mansour, "Agnostic Boosting", COLT/EuroCOLT 2001,
  https://doi.org/10.1007/3-540-44581-1_33.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic Learning",
  JMLR 2003, https://www.jmlr.org/papers/v4/gavinsky03a.html.
- Kalai, Mansour, and Verbin, "Agnostic Boosting and Parity Learning", STOC 2008,
  https://doi.org/10.1145/1374376.1374466.
- Kalai and Kanade, "Potential-Based Agnostic Boosting", NeurIPS 2009,
  https://papers.nips.cc/paper/3676-potential-based-agnostic-boosting.
- Feldman, "Distribution-Specific Agnostic Boosting", ICS 2010 / arXiv,
  https://arxiv.org/abs/0909.2927.
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", arXiv:2410.23632,
  https://arxiv.org/abs/2410.23632.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", ICML 2025,
  https://proceedings.mlr.press/v267/ghai25a.html and arXiv:2503.04706.
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting", NeurIPS 2025,
  https://arxiv.org/abs/2503.09384.
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved
  Running Time", ALT 2026 / arXiv:2601.11265, https://arxiv.org/abs/2601.11265.
- ALT 2026 accepted-papers and schedule pages; the talk title is
  "Sample-Near-Optimal Agnostic Boosting in Fixed-Parameter Tractable Time".
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems",
  COLT 2023, https://proceedings.mlr.press/v195/tiegel23a.html.

Live search on 2026-05-05 did not find a post-ALT 2026 primary source that removes the
fixed-parameter dependence for nontrivial fixed-additive agnostic weak learners.

## Quick Reduction To The Sibling Edge

There is a trivial atlas edge

$$
\text{efficient weak agnostic proper}
\Rightarrow
\text{efficient weak agnostic improper}.
$$

Thus the assigned edge would follow immediately from the sibling open edge

$$
\text{efficient weak agnostic improper}
\Rightarrow
\text{efficient agnostic improper}.
$$

This gives a useful sanity check: any proof here must either resolve that sibling edge or
use properness in an essential way. I found no such essential use. Properness identifies
the weak-output class with the benchmark class `C`, which is helpful for stating a clean
vote-over-`C` booster, but it does not remove the `m0` enumeration or the need for fully
polynomial fixed-slack agnostic boosting.

## Correlation Translation

Work with labels in `{-1,1}` and write

$$
\rho_C(D)=\sup_{c\in C}\operatorname{corr}_D(c)
=
\sup_{c\in C}\mathbb E_D[Yc(X)].
$$

Since

$$
\operatorname{corr}_D(h)=1-2\operatorname{err}_D(h),
$$

the source guarantee implies

$$
\operatorname{corr}_D(W)
\ge
\rho_C(D)-2\beta.
$$

If `rho_C(D)-2 beta < -1`, this bound is vacuous but still valid because every binary
hypothesis has correlation at least `-1`. Therefore the source is a
`(gamma0, epsilon0, delta0, m0)` agnostic weak learner in the da Cunha--Hogsgaard--Paudice
sense with

$$
\gamma_0=1,
\qquad
\epsilon_0=2\beta,
\qquad
\theta=(\gamma_0-\epsilon_0)/2=(1-2\beta)/2>0,
$$

reference class `F=C`, and base/output class `H=C`. The output is proper at each weak call,
but the final boosted classifier may be an improper sign vote over members of `C`.

So the source supplies a genuinely nontrivial fixed-slack agnostic weak oracle. The gap is
not that the weak learner is too weak in the statistical sense.

## Boosting Routes

### Older Fixed-Additive Agnostic Boosting

Ben-David--Long--Mansour and Gavinsky are close to the atlas source definition, but their
final guarantees do not give `opt_C + epsilon` for arbitrary `epsilon`. Gavinsky's smooth
boosting theorem gives a bound of the form `opt/(1/2-beta) + zeta` in the fixed-beta model,
which is useful when `opt` is small but has a multiplicative loss when `opt` is bounded away
from zero.

Thus the older fixed-additive line explains the source notion but does not settle this
strong agnostic target.

### Accuracy-Sensitive Potential/Relabeling Boosters

Kalai--Kanade, Feldman, and the Ghai--Singh 2024/2025 papers give efficient agnostic
boosting algorithms, often by relabeling examples so the feature marginal remains fixed.
These are computationally attractive and produce improper final hypotheses.

Their obstruction is the residual weak-oracle tolerance. In the correlation formulation,
Ghai--Singh 2024 state guarantees such as

$$
\operatorname{corr}_D(\bar h)
\ge
\max_{h\in H}\operatorname{corr}_D(h)
-2\epsilon_0/\gamma-\epsilon,
$$

and the ICML 2025 unlabeled-data theorem has the same `2 epsilon0/gamma + epsilon` residual
in its main correlation guarantee. With the atlas translation `gamma=1` and
`epsilon0=2 beta`, this leaves a fixed constant loss. To make the residual `O(epsilon)`,
one needs a weak learner whose slack can shrink with the final target accuracy. The atlas
source only promises one fixed additive `beta < 1/2`.

This is why the efficient potential/relabeling line does not prove the edge as currently
defined.

### da Cunha--Hogsgaard--Paudice 2026

The ALT 2026 theorem is the strongest positive near miss. It uses the same nontrivial
fixed-slack correlation weak learner:

$$
\operatorname{corr}_D(W)
\ge
\gamma_0 \sup_{f\in F}\operatorname{corr}_D(f)-\epsilon_0,
\qquad
\gamma_0>\epsilon_0.
$$

With the atlas source, `F=H=C` and `theta=(1-2 beta)/2`. The theorem gives an improper
classifier with near-optimal agnostic sample complexity. In particular, for fixed
parameters it can drive the excess error to `epsilon`.

The theorem's stated runtime is the unresolved part. In the non-vacuous sample regime, the
algorithm invokes the weak learner at most

$$
O(n^{m_0+3})
$$

times and has running time

$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)},
$$

where `m0` is the weak learner's sample parameter and `d*` is the dual VC dimension of the
base class. The proof explains the source of the exponent: the algorithm enumerates all
`m0`-tuples from half of the sample, repeats weak-learner random seeds, and then searches
over bounded-size votes from the generated pool.

For the atlas edge, the assumed efficient weak learner may have

$$
m_0=\operatorname{poly}(s,\log(1/\delta_0),1/(1/2-\beta)),
$$

where `s` is the representation size. Even with fixed `theta` and friendly `d*`, substituting
`m0 = poly(s)` into `n^{m0}` gives `n^{poly(s)}`, not a polynomial in `s`, `1/epsilon`, and
`log(1/delta)`. If `d*` also grows, the exponent is larger. Properness only makes `H=C`; it
does not make `m0` or `d*` constant.

The paper itself describes the algorithm as polynomial in the sample size when the other
parameters are fixed, and its conclusion asks whether one can obtain a statistically optimal
algorithm whose running time is fully polynomial in all parameters. The ALT 2026 schedule
also lists the talk as fixed-parameter tractable. This is exactly weaker than the atlas
efficient PAC implication.

## Why The Enumeration Matters

The 2026 proof fixes a near-optimal comparator `f in C` and considers the hidden clean set

$$
S_f=\{(x_i,y_i): f(x_i)=y_i\}.
$$

On distributions supported on `S_f`, labels are realizable by `f`, so the fixed-slack
agnostic weak learner gives a hypothesis with edge `theta`. The algorithm does not know
`f`, `S_f`, or the adaptive AdaBoost distributions supported on `S_f`. It therefore
generates a large pool by running the weak learner on every `m0`-tuple from the observed
sample, so that some tuple from `S_f^{m0}` witnesses each hidden weak call.

This is not equivalent to simply running the atlas learner on polynomially many observable
reweightings of the noisy distribution. On the noisy distribution, the best correlation in
`C` may be too small for the fixed additive guarantee to provide a positive edge. The
positive edge appears after conditioning to the comparator's unknown clean set. Current
fully polynomial observable boosters avoid this hidden-clean-set enumeration only by
requiring an accuracy-sensitive weak tolerance, which the atlas source lacks.

So the missing positive theorem would need a new way to simulate or avoid these hidden
clean-subset weak calls without enumerating `S_f^{m0}`.

## Counterexample Search

I did not find a valid source-true / target-false witness.

### Halfspaces

Halfspaces are target-hard under Tiegel's worst-case-lattice hardness for improper agnostic
learning. But they fail the source: Tiegel's lower bound rules out even weak agnostic
learning with arbitrary binary outputs when the best halfspace has very small error. Since
the assigned source is stronger and proper, halfspaces are not a witness.

### PRF Or Parity-Noise Style Classes

Cryptographic prediction-hard classes also fail in the wrong direction. On realizable
distributions, the source would already require a proper hypothesis with constant advantage
over random guessing. Standard PRF/noisy-parity assumptions are typically designed to rule
out that weak prediction, so they refute the source rather than separating the target.

### Fixed-k-Term DNF And Proper-Boosting Separations

Fixed-`k`-term DNF is a good atlas boundary example for weak proper versus strong proper
learning. It does not currently separate this edge because the target is improper. I did
not find a primary theorem showing fixed-`k`-term DNF is hard for strong improper agnostic
PAC learning while satisfying efficient fixed-additive weak agnostic proper learning.

### PCP / Constant-Approximation Templates

A tempting route is to encode an optimization problem where constant additive approximation
is easy but PTAS-level approximation is hard. The learning translation is delicate. The
source must work for every signed/labeled distribution, not just positive constraint
instances, and it must weakly learn every realizable slice with error below `1/2`. Known
PCP-style gadgets usually either make weak proper learning hard already or separate only
proper targets.

## What Properness Does And Does Not Buy

Properness buys:

- the weak hypotheses lie in the benchmark class `C`;
- the da Cunha theorem can be instantiated with base class `H=C`;
- the final target's impropriety is exactly enough to allow a vote over proper weak
  hypotheses.

Properness does not buy:

- tunable weak slack `epsilon0=O(epsilon)`;
- constant weak sample parameter `m0`;
- small dual VC dimension `d*`;
- observable access to the clean set `S_f`;
- a way around the `n^{m0}` tuple enumeration.

Thus the proper source is conceptually cleaner than the weak-improper source, but I do not
see it resolving the computational obstruction.

## Proposed Atlas Changes If Edits Were Allowed

No atlas file should be changed from this pass.

If the edge note is later refreshed, I would keep `status: "open"` and `evidence: unknown`
with a summary like:

> Open as a representation-uniform efficient PAC implication. A fixed-additive proper weak
> agnostic learner gives a nontrivial correlation weak learner with `F=H=C`,
> `gamma0=1`, and `epsilon0=2 beta`, so da Cunha--Hogsgaard--Paudice proves the
> corresponding statistical and fixed-parameter theorem. However, its runtime enumerates
> weak-learner samples and includes `n^{O(m0 min{d*, log n}/(1-2 beta)^2)}`-type
> dependence. Since the weak sample parameter `m0` may grow polynomially with
> representation size, this is not polynomial time in the atlas sense. Fully efficient
> potential/relabeling boosters require weak-oracle slack shrinking with final accuracy or
> leave a constant residual loss. No source-true / target-false witness is known.

Suggested refs: `bendavid2001`, `gavinsky2003`, `kalai2008agnosticboosting`,
`feldman2010distributionspecific`, `ghai2025agnosticboosting`,
`dacunha2026agnosticboosting`, and optionally a new Kalai--Kanade 2009 key if the atlas
wants to cite that efficient potential-booster near miss directly.

## Depth-2 Directions

1. Prove or refute a fully polynomial fixed-additive agnostic booster. The desired theorem
   should take black-box access to a proper `opt_C + beta` learner and run in time
   polynomial in `s`, `1/epsilon`, `log(1/delta)`, `1/(1/2-beta)`, the weak learner's
   runtime, `m0`, and any VC parameter used, with none of these parameters in the exponent
   of `n`.

2. Replace the da Cunha all-`m0`-tuple enumeration by a polynomial-size hitting set,
   compression, or online-search argument for the hidden clean-subset distributions
   `S_f`. This is the most direct route to proving the edge true.

3. Look for a black-box lower bound for residual-free fixed-slack agnostic boosting. The
   lower bound would need to show that any booster using only a fixed-additive weak learner
   must pay superpolynomial dependence on `m0` or related representation parameters. I did
   not find such a result.

4. Search approximation-theoretic witnesses more narrowly: a representation class with an
   efficient all-distributions proper `opt + beta` approximator for some fixed
   `beta < 1/2`, but no efficient improper `opt + epsilon` learner under a standard
   assumption. Ordinary weak-agnostic hardness examples are too strong because they kill
   the source.

5. If the atlas adds a stronger source node with tunable correlation slack, e.g.
   `epsilon0=O(gamma epsilon)` or Feldman's threshold oracle for every small `alpha`, then
   the efficient Ghai--Singh / Feldman / Kalai--Kanade route should likely give a true
   edge to `efficient-agnostic-improper-pac`.

verdict: open
confidence: 0.84

## Depth 3 Branch: proper weak outputs in agnostic boosting

Focus question: can the fact that every weak hypothesis is proper, i.e. lies in
`C`, be used to bypass the hidden clean-subset enumeration in da
Cunha--Hogsgaard--Paudice and obtain a representation-uniform improper strong
agnostic learner? Or, failing that, is there a clean oracle/separation barrier?

Short answer: I do not see a positive conversion from properness alone. Proper
weak outputs make the final boosted hypothesis syntactically simple, a vote over
members of `C`, but they do not identify the comparator's clean examples or force
the weak learner to return hypotheses correlated with the hidden near-optimal
comparator.

### Why Properness Does Not Expose The Clean Set

Fix a near-optimal comparator `f in C` for the target distribution `D`, and let

$$
S_f=\{(x,y): f(x)=y\}.
$$

The residual-free boosting dream is to run the weak learner on distributions
supported mostly on `S_f`. On such distributions, `f` has tiny error, so the
fixed-additive guarantee `err <= opt_C + beta` gives an honest edge below
`1/2`. The obstruction is that `S_f` is not observable from labeled examples
without already knowing `f`.

Properness does not change this information pattern. A weak call on an
observable reweighting of `D` returns some `h in C`, but the guarantee is only

$$
\operatorname{err}(h)\le \operatorname{opt}_C+\beta.
$$

When `opt_C` under that observable query is close to `1/2 - beta`, this permits
an output with essentially zero usable correlation. The returned representation
being a valid concept in `C` is not a certificate that it was found from clean
examples, that it agrees with the hidden comparator, or that it is worth keeping
in the final vote.

Three natural validation ideas therefore fail at this level of generality:

1. **Validate by empirical error on the original distribution.** A hypothesis
   useful on the clean subset need not have low original noisy error by itself.
   Boosting can combine many such weak hypotheses, but a single one may look
   mediocre on `D`.

2. **Validate by membership in `C`.** Properness only says the hypothesis is in
   the benchmark class. It does not distinguish the near-optimal comparator from
   another concept that is merely within the fixed additive slack on the query
   distribution.

3. **Enumerate only returned proper hypotheses.** A polynomial number of weak
   calls may generate a polynomial pool in `C`, but the weak guarantee gives no
   reason that this pool contains, approximates, or list-decodes the comparator.
   The weak learner may consistently choose different slack-satisfying concepts.

This is exactly why the da Cunha enumeration is doing real work. It is not just
making the final output proper or improper; it is ensuring that among all
`m0`-tuples, some weak-learner training samples are drawn entirely from the
unknown `S_f`, so useful weak hypotheses enter the candidate pool regardless of
which comparator was optimal.

The current web check is consistent with this reading. The ALT 2026 arXiv
abstract says the improved agnostic booster runs in time polynomial in the sample
size when the other parameters are fixed, not polynomial uniformly in all weak
learner parameters. The Ghai--Singh efficient boosters are computationally
attractive but use accuracy-sensitive weak-oracle assumptions that leave a fixed
residual under the atlas `epsilon0 = 2 beta` translation.

### Candidate Black-Box Selector Barrier

A plausible barrier is adversarial selection by the weak oracle. Model the
booster as a black-box algorithm that adaptively chooses query distributions and
receives any proper hypothesis satisfying `opt_C + beta` on that query. To prove
the atlas edge by a black-box reduction, the booster must succeed for every such
valid selector, not just for a helpful selector that returns the hidden
comparator when possible.

The adversarial selector can answer as follows:

- if a query distribution does not put enough mass on the hidden clean region
  `S_f`, return a decoy concept in `C` whose error is within `beta` of optimal
  but whose correlation with `f` is negligible;
- only return a useful clean-subset witness on queries that already isolate
  `S_f` to the degree needed for a positive edge.

This oracle is still proper: every answer is a member of `C`. The issue is that
properness makes the answers look syntactically legitimate while leaving the
booster with no certificate that distinguishes decoys from useful witnesses.
The da Cunha all-tuple enumeration can be viewed as defeating this selector by
forcing many possible clean samples into the query pool. A fully polynomial
booster would need a polynomial-size hitting, compression, or search mechanism
with the same effect.

This is only a barrier sketch, not a separation. To mark the edge false, one
would need an actual representation class satisfying the source uniformly for
all labeled distributions, while strong agnostic improper learning is hard. The
selector story by itself does not provide that class; it only suggests why
properness of weak outputs is not enough for a generic black-box proof.

The closest external analogy I found is the Massart-noise black-box lower-bound
line: Diakonikolas--Impagliazzo--Kane--Lei--Sorrell--Tzamos show that their
Massart booster is best possible for polynomial-time black-box boosters under
cryptographic assumptions. This supports caution about black-box boosting in
noisy settings, but it is not an atlas separation for this edge: Massart noise is
between realizable and agnostic learning, and the lower bound targets that
model's noise-rate benchmark rather than `opt_C + epsilon` agnostic learning.

### What Would Make Properness Useful

Properness could become decisive only with an extra structural promise not
present in the source node, for example:

- the weak learner is a stable approximate proper ERM oracle, not merely some
  `opt_C + beta` selector;
- polynomially many proper weak outputs are guaranteed to form a list containing
  a near-optimal comparator;
- the class has an efficient projection or denoising operation from weak votes
  back to a small candidate set in `C`;
- the weak oracle has a tunable correlation slack, so observable residual-based
  boosters can drive the excess error to `epsilon`.

Without such a promise, proper weak outputs help describe the final improper
vote but do not remove the hidden clean-subset problem.

verdict: open; properness alone does not currently avoid clean-subset
enumeration, and I only have a black-box/adversarial-selector barrier sketch, not
a source-true / target-false separation.
confidence: 0.82
next branches:
1. Formalize the adversarial-selector barrier in a finite-domain oracle model:
   for every polynomial-query booster, construct query-adaptive decoy concepts
   satisfying `opt_C + beta` while hiding the clean comparator.
2. Check whether Massart black-box lower bounds can be adapted from an
   `eta`-benchmark to an `opt_C + epsilon` agnostic benchmark without killing the
   weak agnostic proper source.
3. Investigate positive results under strengthened properness assumptions:
   stable approximate ERM, list-decodable proper weak learners, or finite
   candidate-generation/compression for `C`.
4. Search for an approximation-hard class with an efficient all-distributions
   constant-additive proper approximator but no efficient improper PTAS-style
   agnostic learner.

## Depth 4 Branch: coarse proper weak oracle barrier

**Question.** Can the coarse weak-oracle picture be upgraded into an actual
source-true / target-false class for

$$
\text{efficient weak agnostic proper}
\Rightarrow
\text{efficient agnostic improper},
$$

or does it only explain why black-box fixed-slack boosting is hard?

**Additional checks.** I used the prior sources in this scratchpad and rechecked
nearby oracle-complexity literature. The relevant external anchors are
Diakonikolas--Impagliazzo--Kane--Lei--Sorrell--Tzamos on Massart-noise
black-box boosters
`https://proceedings.mlr.press/v134/diakonikolas21d.html`, Kalai--Servedio on
classification-noise black-box barriers
`https://www.cs.columbia.edu/~rocco/papers/stoc03boost.html`,
Alon--Gonen--Hazan--Moran on weak-learner oracle complexity for simple learners
`https://arxiv.org/abs/2001.11704`, and Daskalakis--Golowich on weaker learning
oracles than ERM `https://proceedings.mlr.press/v247/daskalakis24a.html`.
These support caution about oracle models, but I did not find a primary theorem
that gives the exact fixed-additive agnostic proper source and strong improper
target separation.

### Coarse Proper Oracle Model

Let the source tolerance be `beta < 1/2`, and write

$$
\gamma = 1/2-\beta.
$$

The source weak learner is coarse in a very specific sense. On a query
distribution `Q`, it is forced to output a nontrivial hypothesis only when

$$
\operatorname{OPT}_C(Q) < \gamma.
$$

If `OPT_C(Q) >= gamma`, then an error-`1/2` response is legal because

$$
1/2 \le \operatorname{OPT}_C(Q)+\beta.
$$

Thus a black-box booster using only this interface must somehow manufacture
queries on which the benchmark class has low error. Observable residual queries
usually do not have this property at the end of agnostic boosting: the residual
advantage can be `O(epsilon)`, while the fixed weak threshold is the constant
`gamma`.

The clean oracle barrier uses a hidden comparator `f_z in C` and a noisy
distribution `D_z` obtained by flipping `f_z` on an `eta` fraction of the mass,
where

$$
\gamma < \eta < 1/2.
$$

Then

$$
\operatorname{OPT}_C(D_z)=\eta,
$$

but the weak learner may legally return a proper neutral decoy `d in C` on the
original noisy distribution, since `eta + beta > 1/2`. A strong agnostic learner
run with `epsilon << 1/2-\eta` must still approach error `eta`, so it needs
substantial information about `f_z`.

Where is that information forced to appear? Only on low-OPT restrictions. For
the hidden clean set

$$
S_z=\{(x,y):y=f_z(x)\},
$$

the labels are realizable by `f_z`, so any legal proper weak learner must output
a hypothesis with error at most `beta`, hence edge at least `gamma`. But `S_z`
is not observable without knowing `f_z`. If the weak learner has sample
parameter `m0`, and a booster forms an `m0`-sample from the noisy distribution,
the probability that all examples are clean is roughly

$$
(1-\eta)^{m_0}.
$$

For `m0 = poly(s)`, polynomially many random or ordinary residual calls will miss
the useful branch with overwhelming probability. The da Cunha--Hogsgaard--Paudice
enumeration over all `m0`-tuples defeats exactly this obstacle: once the global
sample contains enough clean points for the hidden comparator, some enumerated
tuple is a clean weak-learner input.

Properness is compatible with the whole barrier. The decoy response is a member
of `C`, and the useful response on clean queries is also a member of `C`, namely
or at least correlated with the hidden proper comparator. The final target being
improper only permits votes over whatever proper hypotheses were generated; it
does not help if the generated pool contains only decoys.

### What A Black-Box Lower Bound Would Say

A formal black-box lower bound should model a booster that adaptively constructs
finite query distributions from:

- samples from the original noisy distribution;
- previous proper weak hypotheses;
- holdout evaluations; and
- public randomness.

The adversarial weak oracle answers every high-OPT query by a proper decoy and
answers low-OPT clean queries by a useful proper hypothesis. The intended proof
would show that, for a random hidden comparator `f_z`, any polynomial-query
booster that does not enumerate a superpolynomial menu of `m0`-tuples sees
essentially the same transcript for many choices of `z`. Its final hypothesis
therefore cannot correlate with the hidden comparator enough to reach
`eta + epsilon`.

This is a good explanation of the `n^{m0}` term. The fixed-additive oracle is not
weak because it fails on clean data; it is weak because it is allowed to be
silent on noisy observable data whose optimum exceeds the fixed threshold. A
residual-free booster must find comparator-dependent clean evidence, and clean
evidence has the flavor of a password.

The key robustness condition for such a lower bound is important. It is not
enough that one legal weak output on a query is useful. A black-box booster must
force every legal output on at least one polynomially found query to be useful.
Otherwise the weak oracle can choose a progress-neutral proper decoy. This
matches the Depth 3 conclusion: properness makes decoys syntactically valid
rather than eliminating them.

### Why This Is Not Yet A Class Separation

The above barrier is not an atlas-ready source-true / target-false class.

To mark the edge false, one needs an ordinary represented concept class `C` with
one uniform polynomial-time proper weak agnostic learner for every labeled
distribution, and at the same time no polynomial-time improper strong agnostic
learner. The coarse oracle construction instead gives an adversarial interface.
It says that a generic booster cannot rely on arbitrary legal weak responses.
It does not rule out a strong learner that ignores the supplied weak learner and
uses the representation of `C` directly.

The usual attempts to turn the oracle picture into a class run into one of three
failure modes.

1. **Hard hidden region.** If `f_z` is cryptographically or randomly hidden well
   enough to defeat strong improper agnostic learning under the noisy marginal,
   then the source weak learner also fails on realizable distributions
   concentrated on that region. In the realizable subcase, the source already
   demands error below `1/2` by a fixed margin.

2. **Public weak handles.** If we add proper handles that make weak learning easy
   on every marginal, those handles tend to be available to the strong improper
   learner as well. A final improper learner can aggregate handles, memorize
   sampled support, or exploit the same candidate-generation structure. This is
   exactly why proper weak outputs alone do not create a lower bound.

3. **CSP or approximation gaps.** Constant-additive approximation can be easy
   while PTAS-style approximation is hard for optimization problems, but the
   learning translation must handle arbitrary signed labels and improper
   outputs. Positive-only CSP hardness often collapses to all-one or lookup
   hypotheses in the improper PAC target; signed variants tend to make the weak
   source hard as well.

A relativized construction may still be possible if the learning model is
allowed to include a coarse weak oracle as part of the world: the source learner
queries that oracle and returns its proper response, while polynomial target
learners cannot extract the hidden clean passwords without `n^{m0}` work. But
that would be a black-box or oracle separation for reductions, not a standard
atlas witness. Translating it into a represented class would require hiding the
comparator from all strong learners while giving one explicit proper weak
learner enough information to handle every distribution. That is the unresolved
part, and it is much stronger than the current oracle story.

### Interim Answer

I can make the coarse proper weak-oracle barrier quite coherent:

- fixed `beta` means the oracle can be silent whenever `OPT_C >= gamma`;
- noisy near-comparator distributions with `eta > gamma` force strong learning
  but not weak-oracle progress on observable queries;
- useful weak calls live on hidden clean subsets;
- polynomially many non-enumerative calls can miss those subsets when
  `m0 = poly(s)`;
- properness does not prevent legal decoys.

I cannot currently make this into a source-true / target-false atlas class. The
barrier is strongest as a black-box lower-bound program against fully polynomial
fixed-slack boosters. It justifies keeping the edge open and explains why the
known positive theorem pays clean-subset enumeration, but it does not justify
changing the edge to false.

verdict: open; the coarse proper weak oracle gives a plausible black-box barrier
to fully polynomial fixed-slack boosting, not an atlas-ready source-true /
target-false separation.
confidence: 0.84
next branches:
1. Formalize the finite-domain oracle lower bound: random hidden comparator,
   noise rate `eta in (gamma,1/2)`, adversarial proper decoy replies on
   high-OPT queries, and a transcript indistinguishability proof for
   polynomial-query boosters.
2. Try a relativized class version where concept evaluation and weak learning
   have oracle access, then isolate exactly which oracle access the target
   learner must be denied or allowed.
3. Search for an oracle-to-representation compiler: cryptographic obfuscation,
   one-way addressed concepts, or planted clean-set passwords that preserve a
   uniform proper weak learner without enabling improper strong learning.
4. Look for positive structural assumptions that kill decoys: stable approximate
   proper ERM, list-decodable weak outputs, polynomial clean-subset hitting
   families, or tunable correlation slack.

## Depth 5 Branch: fixed-additive proper weak boosting under non-black-box access

depth: 5
date: 2026-05-05
verdict: unresolved-open

**Question.** Can the proper fixed-additive source be turned into a fully
polynomial strong improper agnostic learner by using the weak learner more
cleverly than the da Cunha--Hogsgaard--Paudice all-`m0`-tuple enumeration? Or,
if not, can the coarse oracle barrier be upgraded to a separation that still
holds when the strong learner is allowed to use the weak learner's code as a
subroutine?

### Strongest Positive Attempt

The most optimistic route is to view the source learner as an additive linear
optimization oracle over `C`. For a signed distribution `Q`, the proper weak
learner returns `h in C` with

$$
\operatorname{corr}_Q(h)
\ge
\sup_{c\in C}\operatorname{corr}_Q(c)-2\beta.
$$

If this oracle had additive accuracy `O(epsilon)`, the standard
potential/online-gradient style boosters would be fully polynomial: build an
improper vote over concepts, use the current residual as a signed distribution,
and call the oracle to get a descent direction. This is essentially the
efficient Kalai--Kanade/Feldman/Ghai--Singh line.

The fixed-additive atlas source stalls exactly where an approximate linear
optimization method should stall. Once the residual objective gap is below
`2 beta`, the oracle may legally return a direction with no useful correlation.
Rescaling the residual does not help, because correlations are normalized by a
probability distribution. Duplicating examples or changing weights only changes
which normalized signed measure is queried; it does not convert a constant
additive optimizer into an `O(epsilon)` additive optimizer. Repeated independent
calls to the same query also do not help, since the source guarantee permits the
same slack-satisfying proper hypothesis every time.

I also tried the "proper final dictionary" idea: run the proper weak learner on
many observable reweightings and then do empirical risk minimization over all
small votes of the returned proper hypotheses. This is fully polynomial if the
pool is polynomial. But there is no proof that a polynomial observable pool
contains the clean-subset witnesses needed by the da Cunha analysis. The paper's
Algorithm 1 explicitly enumerates `I in [n/2]^{m0}` and then validates small
votes. Its proof uses the fact that, for each hidden AdaBoost distribution on
the clean set of a near-optimal comparator `f*`, some enumerated subsample
`S1|I` equals an `m0`-sample from that clean set. This is the point at which
`n^{m0}` enters. Properness changes `H` to `C`, but it does not make the hidden
index `I` observable.

The latest checked primary source still frames this as a quantitative gap. The
ALT 2026 theorem gives a nontrivial fixed-slack agnostic booster whose running
time is polynomial in the sample size only with other parameters fixed, and the
authors explicitly ask whether there is a statistically optimal algorithm whose
time is fully polynomial in all parameters. Their theorem calls the weak learner
`O(n^{m0+3})` times and searches over a pool with exponent
`O(m0 min{d*, log n}/theta^2)`. For the atlas node, `m0` is allowed to be
`poly(s)`, so this remains quasipolynomial or worse in the representation size.

### Why A Non-Black-Box Separation Is Harder Than The Oracle Barrier

The Depth 4 barrier treats the weak learner as an adversarial proper selector:
on high-`OPT` observable queries it returns decoys, and on hidden clean queries
it returns useful hypotheses. That explains why black-box boosting is hard, but
it does not by itself refute the atlas implication. In the atlas setting the
source is an ordinary polynomial-time algorithm. A would-be strong learner may
use that algorithm as a subroutine, inspect its representation, enumerate its
random seeds when feasible, and combine all returned proper hypotheses
improperly.

To survive this non-black-box access, a false witness must hide information from
every polynomial-time strong learner while still making one uniform
polynomial-time proper weak learner succeed for every labeled distribution. I
tried three separation templates; each fails for a structural reason.

1. **Hard hidden comparator with noise.** Choose a hidden `f_z in C`, corrupt an
   `eta` fraction of labels with `gamma < eta < 1/2`, and ask the strong learner
   to reach `eta + epsilon`. This defeats naive boosting because the original
   noisy distribution has `OPT_C = eta`, so the fixed weak oracle may be silent.
   But if `f_z` is cryptographically hidden enough to defeat every improper
   strong learner, then the source weak learner is also in trouble on realizable
   distributions labeled by `f_z`. The source must weakly learn those
   distributions with a proper output, so the hidden comparator cannot be too
   hidden from the same representation.

2. **Public handles or trapdoors for weak learning.** Add simple proper
   "handles" that let a weak learner get constant advantage on every
   distribution. This makes the source plausible, but the target is improper:
   it can also call the handle generator, collect handles from samples, and
   vote or memorize with them. If the weak learner's code contains a uniform
   trapdoor, a non-black-box target can use the same code. If the trapdoor is
   nonuniform or instance-specific, it no longer witnesses the distribution-free
   efficient source node.

3. **Approximation-hard CSP/PCP classes.** Constant-additive approximation can
   be easy while PTAS-level approximation is hard for proper hypotheses. The
   atlas has proper-hard witnesses of this flavor. They do not separate this
   edge because the final learner is improper. On polynomial active slices,
   lookup-table or memorization predictors compete with the class directly. On
   exponentially large slices, memorization no longer suffices, but then making
   the proper source work for all signed label distributions appears to require
   exactly the kind of weak prediction that the hardness construction is meant
   to forbid.

These failures are useful. They indicate that a real false witness cannot be
just "constant approximation is easy but PTAS is hard" and cannot merely rely on
adversarial weak-oracle choices. It must thread a narrower needle: the class
must have a public, uniform, all-distributions proper constant-additive learner,
yet the information exposed by that learner must be insufficient for any
polynomial improper learner to obtain arbitrary excess accuracy.

### Sharpened Barrier Statement

The sharpest statement I can currently defend is a conditional barrier to a
specific proof strategy, not an atlas separation:

> Any fully polynomial booster that treats the source only as a fixed-additive
> proper agnostic learner must replace the clean-subset enumeration in the ALT
> 2026 algorithm by a polynomial-size hitting or candidate-generation mechanism.
> Observable reweighting alone cannot certify progress once the queried
> distribution has `OPT_C >= 1/2 - beta`, because a proper neutral decoy is a
> legal weak output. Non-black-box access to the weak learner helps only if the
> code reveals additional structure, such as stability, list generation,
> projection, or tunable slack; none is present in the atlas source.

This barrier is robust to the final learner being improper: impropriety only
allows votes over the proper hypotheses that were generated. It is not robust
enough to prove `resolved-false`, because a future fully polynomial algorithm
could discover clean-subset witnesses by a new compression, hard-core-set, or
online search argument rather than by all-tuple enumeration.

### Obstacles

- The known fixed-slack statistical booster is still fixed-parameter rather
  than fully polynomial in `m0`, `d*`, and the representation size.
- Efficient observable boosters require an accuracy-sensitive weak slack; the
  atlas source supplies only one fixed `beta`.
- Proper weak outputs do not identify the hidden clean set of a near-optimal
  comparator and do not certify that a returned hypothesis is useful for the
  final vote.
- A black-box decoy oracle does not automatically become a represented PAC
  class separation, because the strong learner may ignore the oracle interface
  and exploit the representation or the weak learner's code.
- Candidate false witnesses based on PRFs, noisy parities, halfspaces, PCP
  slices, or fixed-`k` DNF either kill the weak proper source or only separate
  proper strong learners.

### Next Directions For Depth 6

1. Try to formalize a polynomial-size clean-subset hitting theorem. A positive
   theorem would replace the `n^{m0}` enumeration by a sampler/compressor whose
   size is polynomial in `m0`, `1/epsilon`, and the representation size.

2. Search the hard-core-set literature for an algorithmic construction that is
   fully polynomial in the weak learner's sample parameter, not merely
   fixed-parameter. The da Cunha analysis already points at this connection.

3. Build a relativized lower-bound model in which the target learner is allowed
   oracle access to the weak learner itself, not just to an adversarial response
   transcript. This would test whether the decoy barrier survives the strongest
   black-box/non-black-box hybrid one can state cleanly.

4. Look for classes with stable approximate proper ERM. If stability plus
   fixed-additive weak agnostic learning implies that returned hypotheses form a
   polynomial list containing clean witnesses, that would be a meaningful
   positive subcase and would explain exactly what the atlas source lacks.

5. Continue checking new agnostic boosting papers for the phrase "fully
   polynomial in all parameters" under a nontrivial fixed `(gamma0, epsilon0)`
   oracle. As of the May 5, 2026 check, I found no primary source that closes
   this quantitative gap.

confidence: 0.86

## Depth 6 Branch: final attempt at fixed-additive proper weak agnostic boosting

depth: 6
date: 2026-05-05
verdict: unresolved-open

**Final question.** Does a distribution-free polynomial-time proper learner with

$$
\operatorname{err}_D(W(D)) \le \operatorname{opt}_C(D)+\beta,
\qquad \beta<1/2
$$

force a distribution-free polynomial-time improper learner with

$$
\operatorname{err}_D(H) \le \operatorname{opt}_C(D)+\varepsilon?
$$

Equivalently, in correlations, the source is a proper oracle returning
`h in C` with

$$
\operatorname{corr}_D(h)
\ge
\sup_{c\in C}\operatorname{corr}_D(c)-2\beta .
$$

This is a nontrivial fixed-slack oracle because `2 beta < 1`. The target,
however, needs excess error tending to zero.

### Last Positive Attempt: Can The Fixed Slack Be Self-Improved?

The only plausible fully polynomial proof would have to turn the
constant-additive correlation oracle into an accuracy-sensitive oracle on demand.
In a convex-optimization picture, strong agnostic learning is approximately
linear optimization over the closed convex hull of `C`, followed by thresholding.
If we could query, for each residual signed measure `R_t`, an `h_t in C`
satisfying

$$
\operatorname{corr}_{R_t}(h_t)
\ge
\sup_{c\in C}\operatorname{corr}_{R_t}(c)-O(\varepsilon),
$$

then the Kalai--Kanade/Feldman/Ghai--Singh style potential methods would give a
fully polynomial improper vote. The atlas source only gives the same display
with `2 beta` in place of `O(epsilon)`.

I tried three ways to shrink this slack, and each hits the same normalization
barrier.

1. **Reweighting.** Query the weak learner on distributions emphasizing the
   current residual mistakes. This can make a perfect or nearly perfect clean
   subproblem when the right clean set is known, but it does not make an
   arbitrary observable residual easier. If the best correlation on the queried
   distribution is at most `2 beta`, the weak output may have zero or negative
   useful correlation and still be legal.

2. **Replication/rescaling.** Duplicate examples, split weights, or encode a
   signed measure by a distribution over relabeled examples. Correlation is
   normalized by total mass, so these transformations preserve the additive
   slack scale. They cannot turn a `2 beta` approximate maximizer into an
   `O(epsilon)` approximate maximizer.

3. **Validation and pooling.** Generate a polynomial pool of proper hypotheses
   by querying many adaptive reweightings, then run empirical ERM over small
   votes from that pool. This is fully polynomial once the pool is polynomial,
   but the missing statement is exactly that the pool contains the hidden clean
   witnesses used by the statistical fixed-slack booster. I do not see a proof
   from the atlas assumptions alone.

Thus the optimistic route reduces to one concrete missing lemma:

> **Polynomial clean-witness generation lemma.** Given only sample access to
> `D` and black-box/code access to a proper fixed-additive weak agnostic learner
> with sample bound `m0 = poly(s)`, there is a procedure running polynomially in
> `s`, `m0`, `1/epsilon`, and `log(1/delta)` that produces a list `L subset C`
> such that ERM over small votes from `L` achieves
> `opt_C(D)+epsilon`.

The known da Cunha--Hogsgaard--Paudice ALT 2026 algorithm proves an
information-theoretic version of this by exhaustive clean-subset enumeration:
enumerate all `m0`-tuples from part of the sample, run the weak learner on each,
and validate small votes. The arXiv record for `2601.11265` says the algorithm
runs in time polynomial in sample size when the other parameters are fixed; the
paper was last revised on 2026-02-03 and accepted at ALT 2026. Substituting the
atlas-allowed `m0 = poly(s)` into the enumeration gives `n^{poly(s)}`, not a
PAC polynomial in the representation size. I found no later primary source, as
of this 2026-05-05 check, that replaces this enumeration by a fully polynomial
clean-witness generator.

### Last Negative Attempt: Can The Decoy Oracle Become A Class Separation?

The cleanest obstruction is the coarse-oracle picture. Let
`gamma = 1/2 - beta`. On any query distribution with
`opt_C >= gamma`, the source guarantee is compatible with a useless or decoy
proper output. To beat `opt_C + epsilon` when the original distribution has
moderate noise `eta > gamma`, a booster must somehow locate subdistributions on
which the comparator has error below `gamma`; those are the hidden clean sets.
The fixed-parameter booster locates them by trying all weak-learner samples of
size `m0`.

This obstruction can be made into a convincing black-box lower-bound program:
hide a near-optimal comparator behind many candidate clean subsets; answer
observable high-`opt` queries with legal decoys; reveal useful proper hypotheses
only when the query sample hits the hidden clean subset. A polynomial-query
booster misses with high probability when the hidden subset has entropy
`Omega(m0 log n)`, while all-tuple enumeration succeeds.

But this still does not make the atlas edge false. An atlas false edge needs an
ordinary represented concept class satisfying the source and failing the target.
The decoy oracle is not such a class, because a target learner in the PAC model
is not forced to interact through the weak-oracle interface. It may inspect the
representation, ignore the supplied weak learner, run another algorithm, or
combine all public handles it can find.

I tried to force the oracle behavior into a represented class, and the same
trilemma reappears:

- If the hidden comparator is cryptographic enough to defeat every strong
  improper learner, then the source weak learner also fails on realizable
  distributions labeled by that comparator.
- If public proper handles make the source weak learner succeed on every
  marginal and labeling distribution, an improper strong learner can usually
  collect and vote over those handles, or memorize the sampled active support.
- If a PCP/CSP approximation gap makes constant approximation easy but PTAS
  hard for proper hypotheses, the improper target can often use lookup-style
  predictors unless the construction prevents local memorization; preventing
  local memorization tends to make the weak proper source hard as well.

So the decoy/coarse-oracle obstruction is atlas-relevant as a proof-strategy
barrier, but not atlas-valid evidence for `status: false`.

### Final Synthesis For The Edge

Recommended atlas status:

```yaml
status: "open"
evidence: unknown
family: agnostic-boosting-open
```

Recommended summary:

> Open. The source is exactly a proper fixed-additive agnostic weak learner,
> which translates to a nontrivial constant-slack correlation oracle. Recent
> agnostic boosting gives a statistical/fixed-parameter improper booster, but
> the known construction enumerates weak-learner samples of size `m0`; since
> `m0` may grow polynomially with representation size, this is not a
> representation-uniform polynomial-time implication. Existing fully polynomial
> potential/relabeling boosters require tunable `O(epsilon)` weak slack, which
> the atlas source does not provide.

Recommended obstruction paragraph:

> The obstruction is not properness of the weak outputs: the target is improper
> and may output a vote over proper hypotheses. The obstruction is quantitative.
> A fixed-additive weak learner may legally return decoys whenever the queried
> distribution has `opt_C >= 1/2 - beta`. To drive excess error below an
> arbitrary `epsilon`, a booster must discover distributions or clean subsets on
> which a near-optimal comparator becomes visible below this threshold. The
> current fixed-slack theorem does this by exhaustive clean-subset enumeration,
> giving fixed-parameter rather than fully polynomial running time.

Concrete missing lemma:

> Prove a polynomial clean-witness generation lemma: from sample access to `D`
> and a proper `opt_C + beta` weak agnostic learner with sample bound `m0`, build
> in time `poly(s,m0,1/epsilon,log(1/delta))` a polynomial list of proper
> hypotheses whose small improper votes contain an `opt_C + epsilon` classifier.
> Equivalently, replace the `n^{m0}` clean-subset enumeration in the ALT 2026
> fixed-slack booster by a polynomial-size hitting, compression, stability, or
> hard-core-search procedure.

Separation standard:

> To mark the edge false, one needs more than an adversarial weak-oracle decoy
> construction. A valid witness must be a represented class with a uniform
> polynomial-time proper `opt_C + beta` learner for every labeled distribution,
> while every polynomial-time improper learner fails to achieve `opt_C+epsilon`
> for some distribution. Current PRF/one-way, handle, PCP, halfspace, and
> fixed-`k` DNF templates miss one side of this requirement.

Final confidence: `0.88` that the correct atlas action is to keep the edge open
in `agnostic-boosting-open`, with the above missing lemma as the next decisive
target.
