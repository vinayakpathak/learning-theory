## Depth 1 Branch A: Fixed Marginal Does Not Remove Fixed Slack

I first read the assigned edge note
`atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
and the two endpoint definitions. I also checked the sibling
distribution-free weak-improper edge, the true monotone edge from proper weak
to improper weak, the marginal weak-proper-to-strong agnostic halfspace
separation, and the local `agnostic-boosting-open` and
`marginal-boosting-open` argument notes.

The edge remains unresolved in this branch. The best diagnosis is that the
target's marginal-nonuniform allowance solves the wrong problem for this
source. Since the source learner is already distribution-free, ordinary
boosting calls on reweighted distributions are already covered by the same
weak-learner polynomial. If one instead uses Feldman/Ghai-style
same-marginal relabeling, the marginal bookkeeping is also benign: all weak
calls can keep the feature marginal at the original $P$, and the final
$P$-dependent polynomial would be the right kind of resource bound. In both
cases, the remaining obstruction is the fixed additive agnostic slack.

In $\{\pm1\}$ notation, the source says that for every joint distribution $D$
the weak learner returns a proper $h\in\mathcal C$ with

$$
\operatorname{corr}_D(h,Y)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_D(c,Y)-2\beta ,
\qquad \beta<1/2 .
$$

Thus the weak learner is a coarse additive optimizer over $\mathcal C$. It is
forced to give useful positive correlation only when the best class
correlation exceeds the fixed floor $2\beta$. A strong agnostic learner must
recover correlations at scale $O(\varepsilon)$ above the best comparator, so a
label distribution with small but meaningful best correlation can still be
inside the target's regime while being below the source oracle's guaranteed
resolution.

Properness is helpful but not decisive. Because every weak output is already a
member of $\mathcal C$, a booster may safely build an improper final vote or
real-valued aggregate over proper hypotheses. The assigned target allows this.
So there is no properization obstruction here. The question is only whether a
fixed-slack proper base oracle can be boosted to arbitrary agnostic excess
error in fully polynomial time.

The known positive routes still stop short:

- Accuracy-sensitive agnostic boosters, including same-marginal relabeling
  routes, need threshold or correlation slack that can shrink with the final
  accuracy. Translating the atlas source into those interfaces leaves a
  constant residual term proportional to $\beta$.
- The da Cunha--Hogsgaard--Paudice fixed-slack theorem is semantically close:
  the atlas source fits its nontrivial fixed-slack weak-oracle condition, and
  the final improper aggregate would be allowed. But the generic runtime has
  weak sample and base-capacity parameters in the exponent, for example
  through enumeration of weak-learner sample tuples. Since those parameters
  may grow polynomially with the representation size $s$, this gives
  $n^{\operatorname{poly}(s)}$ rather than a polynomial in
  $(s,1/\varepsilon,\log(1/\delta))$.
- The marginal-nonuniform target cannot absorb that exponent. For each fixed
  marginal $P$, the polynomial $p_P$ may have $P$-dependent constants and
  degree, but the degree cannot itself grow with the represented concept size
  or with a weak sample parameter $m_0(s)$.

I also do not have a false witness. Halfspaces separate the marginal weak
proper source from the marginal strong improper target under Tiegel's
lattice-based hardness, but they fail the present distribution-free weak
agnostic proper source. Fixed-$k$ DNF and weak-handle constructions mostly
separate proper strong targets; once the target is improper, votes, lookup
tables, validation, or sparse aggregation tend to become available. Plain
parity, PRF, and noisy cryptographic classes have the opposite problem: they
can make strong low-signal agnostic learning hard under a fixed marginal, but
they also tend to destroy the required distribution-free weak agnostic source
on low-noise or hard-core distributions.

The most plausible negative template is still a shield-plus-hard-core class:
easy proper shields would certify the fixed-additive weak source whenever the
best correlation is above the coarse floor, while a hard low-signal core under
one fixed marginal would require recovering a direction with correlation
$\alpha$ where $\varepsilon\ll\alpha<2\beta$. This would match the intuitive
coarse-oracle barrier. I do not see an atlas-ready construction: the shields
must work under every marginal and label rule without making the hard core
strongly learnable by improper aggregation.

If editing the atlas were allowed, I would keep this edge `open` and sharpen
the summary: the source is distribution-free, so induced marginals are not the
main obstacle; the open point is fully polynomial fixed-additive agnostic
boosting from proper weak hypotheses to an improper strong aggregate.

Concrete depth 2 directions:

1. Prove or rule out a fully polynomial fixed-slack agnostic booster whose
   runtime is polynomial in the weak learner's sample/time bounds, base-class
   capacity parameters, $1/(1/2-\beta)$, $1/\varepsilon$, and
   $\log(1/\delta)$, with no weak parameter in the exponent.
2. Formalize a same-marginal coarse-oracle lower bound: with regression
   functions $g_i=\alpha c_i$ and $\varepsilon\ll\alpha<2\beta$, show that a
   fixed-additive proper optimization oracle can legally hide the identity of
   $c_i$ from any polynomial-query booster.
3. Search for a real shield-plus-hard-core witness satisfying the full
   distribution-free weak agnostic proper source while preserving fixed-marginal
   strong agnostic improper hardness below the fixed slack floor.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 2 Branch A: Proper Votes Still Hit The Slack Floor

### Question For This Branch

Depth 1 correctly isolated the main obstruction: the source learner is
distribution-free, so marginal changes caused by boosting are not the primary
problem. This branch asks whether the two extra relaxations in the assigned
target can nevertheless finish the proof:

1. the final resource bound may be marginal-nonuniform, with a polynomial
   $p_P(s,1/\varepsilon,\log(1/\delta))$ depending on the original instance
   marginal $P$;
2. the final hypothesis may be improper, so it may be a vote or aggregate over
   the proper weak hypotheses returned by the source learner.

I also compared the sibling edge
`efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac`.
The sibling is useful as a stress test, but this edge has one additional fact:
every weak output lies in the benchmark class $\mathcal C$.

### Properness Helps Syntax, Not The Quantitative Gap

Write labels in $\{-1,1\}$ and let

$$
\rho_C(D)=\sup_{c\in C}\mathbb E_D[Yc(X)].
$$

The source promise gives, for every queried joint distribution $D$,

$$
\mathbb E_D[Yh(X)]\ge \rho_C(D)-2\beta,
\qquad h\in C,
$$

where $\beta<1/2$ is fixed. Equivalently, with
$\gamma=1/2-\beta$, the weak learner is forced to give a genuine edge only
when the best proper comparator on the query distribution has error below
$\gamma$.

The fact that $h\in C$ is exactly what a successful booster would want for the
final target: an improper sign vote over proper weak hypotheses is allowed.
Thus there is no final-output properization issue. But properness does not
turn the additive oracle into a tunable oracle. On a query where
$\rho_C(D)\le 2\beta$, a neutral proper concept is still a legal response. A
strong agnostic learner needs to exploit comparator correlations at scale
$O(\varepsilon)$, including when those correlations lie below the fixed
$2\beta$ floor.

This is the same slack floor seen in the improper-source sibling, except that
the generated hypotheses here are syntactically cleaner. The sibling would
allow arbitrary weak outputs; here all weak outputs are in $C$. That helps any
positive theorem instantiate its base class as $H=C$, but it does not by itself
force the weak learner to reveal the near-optimal comparator.

### Why Marginal-Nonuniformity Does Not Supply A Hidden Advice Channel

The tempting positive route is same-marginal agnostic boosting. Feldman-style
and Ghai--Singh-style boosters change labels while preserving the feature
marginal. That fits the target's marginal-nonuniform accounting: once $P$ is
fixed, all weak calls can in principle stay over $P$, and the final polynomial
may depend on $P$.

The issue is that these efficient same-marginal boosters use an
accuracy-sensitive correlation oracle. If we try to dominate the atlas weak
guarantee by an interface of the form

$$
\operatorname{corr}(h,Y)\ge a\,\rho_C(D)-\tau,
$$

then evaluating at $\rho_C(D)=2\beta$ forces
$\tau\ge 2a\beta$, so $\tau/a\ge 2\beta$. The residual term inherited by the
booster remains constant. A $P$-dependent runtime can pay more for samples or
computation under the fixed marginal, but it cannot make the source's fixed
additive slack shrink with the requested final $\varepsilon$.

Put differently, marginal-nonuniformity is allowed to depend on the unlabeled
geometry of $P$, not on the hidden conditional label rule. In a noisy
near-comparator distribution

$$
X\sim P,\qquad Y=f(X)N,\qquad \Pr[N=-1]=\eta,
$$

with $f\in C$ and $\gamma<\eta<1/2$, the target still asks for error
$\eta+\varepsilon$ for arbitrarily small $\varepsilon$. But on the original
same-marginal distribution the best proper error is already $\eta>\gamma$, so
the fixed-additive weak learner may legally return a progress-neutral proper
decoy. The information needed to beat $\eta$ is not in $P$ alone; it is in the
unknown labeling rule $f$.

### The Fixed-Slack Theorem Is Still Only Fixed-Parameter Here

The da Cunha--Hogsgaard--Paudice theorem remains the strongest near-positive
result. The source fits its nontrivial weak-oracle semantics with

$$
\gamma_0=1,\qquad \epsilon_0=2\beta,\qquad
\theta=(\gamma_0-\epsilon_0)/2=1/2-\beta,
$$

and in this proper edge the base hypotheses are simply $H=C$. This gives a
statistical or fixed-parameter positive statement: if the weak sample
parameter, capacity terms, and $\theta^{-1}$ are treated as fixed, the theorem
can boost fixed slack to arbitrary agnostic excess using an improper final
aggregate.

It does not give the atlas target. The generic construction enumerates
weak-learner input tuples and has bounds of the form

$$
O(n^{m_0+3})
$$

weak calls and search terms like

$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$

Here $m_0$ is the weak learner's sample requirement and $d^*$ is a base-class
capacity parameter. In the atlas source, $m_0$ and $d^*$ may grow polynomially
with representation size $s$. With
$n=\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$, the displayed runtime
can be $n^{\operatorname{poly}(s)}$, not a polynomial in the target variables.

The marginal-nonuniform target cannot absorb this exponent. For each fixed
$P$, $p_P$ may have $P$-dependent constants and degree, but its degree is fixed
as $s$ varies. A runtime exponent $m_0(s)$ is representation-dependent, not
marginal-dependent.

### Why Improper Final Votes Do Not Find The Missing Weak Hypotheses

The known fixed-slack route pays the tuple enumeration because useful weak
calls may live on comparator-dependent low-noise subsets. If $f\in C$ is a
near-best comparator and

$$
S_f=\{(x,y):y=f(x)\},
$$

then distributions supported on $S_f$ are realizable by $f$, so the fixed
weak learner must output a proper hypothesis with real edge. But $S_f$ is
hidden. It depends on the conditional label rule, not merely on $P$.

An improper final vote is powerful after a useful pool of weak hypotheses has
been generated. It can aggregate proper hypotheses, validate weighted votes,
and avoid the strong proper hardness that defeats fixed-$k$ DNF and
one-way-handle witnesses. What it cannot do is conjure useful hypotheses that
never entered the pool. If all polynomially many observable weak calls have
best proper error at least $\gamma$, a legal proper weak learner may return
decoys throughout.

A simple diagnostic is the noisy-comparator channel above. An $m_0$-sample
drawn from the observable noisy distribution has empirical noise at most
$\gamma$ with probability roughly

$$
\Pr[\operatorname{Bin}(m_0,\eta)\le \gamma m_0]
\le \exp(-m_0D_{\mathrm{KL}}(\gamma\|\eta)).
$$

When $m_0=\operatorname{poly}(s)$, polynomially many random observable attempts
do not reliably hit the low-noise branch. This is not a class separation, but
it explains why the residual-free fixed-slack proof enumerates $n^{m_0}$
tuples and why neither marginal-nonuniform accounting nor improper voting
removes that combinatorial search.

### False Witness Search

I do not have a source-positive, target-negative witness.

Halfspaces fail the source: the same fixed-marginal hardness that blocks
strong agnostic improper learning also rules out the needed weak agnostic
learning.

Fixed-$k$ DNF, PCP active-slice classes, and one-way weak-handle classes
separate proper targets, but the assigned target is improper. Once public
proper weak handles or small slice tables are available, an improper learner
can often vote, validate, or memorize them. These families therefore do not
block the marginal-nonuniform agnostic improper target.

Parity/LPN, PRF, and noisy-code templates have the right high-noise flavor,
but they tend to be source-negative. The distribution-free weak source must
work on every low-noise weighted marginal, which becomes an arbitrary-weight
decoding or weak prediction problem. If that problem is easy enough to prove
the source, the same public structure often threatens the desired strong
improper hardness under the fixed marginal.

### Status For Atlas Purposes

I would not update the atlas edge to true or false from this branch. The best
atlas-ready summary remains:

> Open. A proper fixed-additive weak agnostic learner gives a nontrivial
> fixed-slack correlation oracle with base class $H=C$, and improper final
> votes are allowed. However, efficient same-marginal boosters require tunable
> weak slack, while the known residual-free fixed-slack booster has weak-sample
> and capacity parameters in the runtime exponent. Marginal-nonuniformity
> cannot absorb representation-dependent exponents, and no concrete
> source-positive / target-negative witness is known.

### Depth 3 Directions

1. Prove a fully polynomial fixed-slack proper-base booster: given a proper
   $\operatorname{OPT}_C+\beta$ learner with sample bound $m_0$, generate an
   improper vote in time polynomial in $s$, $m_0$, the weak runtime,
   $1/(1/2-\beta)$, $1/\varepsilon$, and $\log(1/\delta)$, with no $m_0$ or
   VC/capacity parameter in an exponent.
2. Formalize a single-marginal black-box lower bound for proper fixed-slack
   oracles: under a noisy hidden comparator with $\gamma<\eta<1/2$, show that
   any polynomial-query booster that does not enumerate $m_0$-tuples can be
   answered by proper decoys while failing to reach $\eta+\varepsilon$.
3. Audit one concrete threshold-decoding witness family. The needed object is
   a public class with efficient arbitrary-weight low-noise weak proper
   decoding for every marginal, but fixed-marginal high-noise hardness for
   improper $\operatorname{OPT}+\varepsilon$ prediction.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 3 Branch A: No Label-Nonuniform Escape

### Aim

This branch tried to decide whether the two target relaxations together are
strong enough to bypass the fixed-additive weak agnostic floor:

1. the running-time polynomial may depend on the instance marginal $P$;
2. the final classifier may be an improper vote over the proper weak
   hypotheses returned by the source learner.

I do not see a resolution. The branch did sharpen the obstruction: the
missing resource is not marginal advice and not final-output expressivity. It
is a way to generate, in representation-uniform polynomial time, the
comparator-dependent weak hypotheses that fixed-slack boosting currently gets
by enumerating clean weak-learner input tuples.

### The Near-Positive Theorem Still Leaves The Same Exponent

I checked the current da Cunha--Hogsgaard--Paudice theorem statement
([arXiv:2601.11265](https://arxiv.org/abs/2601.11265)). Their agnostic weak
learner interface is exactly the relevant correlation form:

$$
\operatorname{cor}_D(w)
\ge
\gamma_0 \sup_{f\in F}\operatorname{cor}_D(f)-\epsilon_0 .
$$

The atlas source instantiates this with $F=H=C$, $\gamma_0=1$, and
$\epsilon_0=2\beta$, so $\theta=(1-2\beta)/2>0$. Thus, semantically, the
proper fixed-additive learner is a nontrivial agnostic weak learner, and the
final sign of an average of proper hypotheses is allowed by the improper
target.

The runtime is still the blocker. The theorem's algorithm invokes the weak
learner on all $m_0$-tuples from a sample half and then searches signs of
$T$-wise averages. In the theorem statement, the number of weak calls is
$O(n^{m_0+3})$, and the displayed running time is

$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)} .
$$

This is polynomial in $n$ only with $m_0$, $d^*$, and $\theta^{-1}$ treated as
fixed parameters. In the atlas implication, $m_0=m_0(s)$ and $d^*=d^*(s)$ may
grow with representation size. Since the target asks for a polynomial
$p_P(s,1/\varepsilon,\log(1/\delta))$, a degree depending on $m_0(s)$ or
$d^*(s)$ is not admissible. The marginal-dependent constants and degree of
$p_P$ may depend on $P$, but they cannot depend on the hidden target labels or
grow with the represented concept size.

The comparison with Feldman/Ghai-style boosters points the same way. Those
algorithms are attractive for this edge because they can work by relabeling
under the original marginal, and Ghai--Singh explicitly emphasize the
distribution-specific setting with unlabeled samples
([PMLR 2025](https://proceedings.mlr.press/v267/ghai25a.html)). But the
efficient versions require an accuracy-sensitive weak-oracle slack, such as
$\epsilon_0=O(\varepsilon)$ or a threshold $\alpha=O(\varepsilon)$ in the
same-marginal relabeling formulation. The atlas source supplies only the
fixed value $2\beta$.

### Why $P$-Nonuniformity Cannot Pay For Clean Tuples

Consider the clean-subset explanation in the noisy-comparator model

$$
X\sim P,\qquad Y=f(X)N,\qquad \Pr[N=-1]=\eta ,
$$

where $f\in C$ and $\beta<\eta<1/2$. The target asks for error
$\eta+\varepsilon$, so it must recover the comparator direction to
$O(\varepsilon)$ excess. But on the original labeled distribution the best
correlation is $1-2\eta<1-2\beta$, so a fixed-additive weak learner may
legally return a neutral proper hypothesis.

The da Cunha-style route avoids this by running the weak learner on samples
from the clean conditional distribution $D_f=D\mid Y=f(X)$. If a weak learner
needs $m_0$ examples, then a random $m_0$-tuple from the observable noisy
sample is clean with probability approximately $(1-\eta)^{m_0}$, or more
generally with an exponentially small large-deviation rate when one only
requires noise below the weak threshold. With $m_0=\operatorname{poly}(s)$,
polynomially many random tuple attempts do not hit this event. Enumeration
does hit it, but costs $n^{m_0}$.

The important point for this edge is that the rarity is label-conditional, not
marginal-conditional. The fixed marginal $P$ does not say which examples are
clean for $f$, and the target's $p_P$ is not allowed to depend on $f$ or on
$\eta$. Thus marginal nonuniformity cannot be interpreted as advice for the
hidden clean subset. It can pay for awkward geometry of $P$, but not for a
representation-dependent search through $f$-dependent clean tuples.

Improper voting helps only after the useful weak hypotheses enter the pool.
Once the pool contains enough hypotheses correlated with $f$ on the clean
conditional distribution, validation can choose a good sign-average. But if
all polynomially many generated weak calls are made on distributions where
the best proper correlation is below the fixed slack floor, a legal weak
learner can keep returning proper decoys. The vote then aggregates decoys.

### False Witness Search Sharpened

A real separation must be noisily hard but realizably easy. This is forced by
the source: restricting the weak agnostic learner to realizable distributions
gives distribution-free weak realizable proper learning, and ordinary
realizable boosting gives distribution-free strong realizable improper
learning. Therefore a witness cannot hide behind noiseless recovery hardness;
its target failure has to occur only in the agnostic, below-slack regime.

This rules out the current families in a more precise way:

- **Halfspaces.** Tiegel's fixed-marginal agnostic hardness is exactly strong
  enough to refute the target, but it also refutes the distribution-free
  fixed-additive weak agnostic source. Halfspaces satisfy weaker
  marginal-nonuniform weak agnostic nodes by low-noise robustification, not
  this fixed-slack distribution-free source.
- **One-way image-coordinate weak handles.** The constants and bounded
  positive-atom handles can give fixed-additive weak proper learning and
  defeat strong proper learning. They do not defeat this target: under the
  coordinate marginal, sparse improper lookup or validation over visible
  atoms learns agnostically against the seed concepts.
- **PCP active-slice and finite-slice lookup classes.** Packing the hard
  instance into one fixed marginal either dilutes the active slice or makes
  the slice small enough for improper one-slice lookup ERM. These classes are
  useful for proper-output separations, but the assigned target explicitly
  allows improper hypotheses.
- **PRF, parity/LPN, and noisy-code templates.** These have the right
  fixed-marginal high-noise hardness flavor, but they fail the source unless
  one adds public weak handles. Public handles strong enough to give a
  constant weak agnostic edge under every marginal tend to be visible to the
  improper target as well; validation and voting then threaten the desired
  hardness.

So the still-plausible negative template is narrower than before. It would
need computationally nonboostable handles: one proper handle with constant
advantage is efficiently findable for every distribution where
$\operatorname{OPT}_C$ is below the fixed slack floor, but finding a
polynomial-size family of independent handles sufficient for
$\operatorname{OPT}_C+\varepsilon$ prediction under one fixed marginal is
hard even for improper algorithms. I do not know an atlas-valid construction
with this property.

### Depth 4 Directions

1. **Randomized clean-tuple replacement.** Try to replace $n^{m_0}$ tuple
   enumeration by a polynomial-size hitting distribution over weak-learner
   input transcripts. A useful lemma would have to hit
   $D\mid Y=f(X)$ for every near-optimal $f\in C$ without knowing $f$ and
   with sample/time polynomial in $m_0(s)$ rather than exponential in it.
2. **Noisy-only handle hardness.** Build or rule out a class with
   distribution-free constant-slack weak agnostic proper handles but
   fixed-marginal high-noise agnostic improper hardness. The construction
   must remain strongly realizably learnable improperly, so pure recovery
   hardness is not enough.
3. **Dual-dimension/sample-bound regimes.** Carve out positive subedges where
   the da Cunha theorem is atlas-polynomial, e.g. constant $m_0$ and
   polynomially bounded dual VC dimension with no representation-dependent
   exponent. This would not resolve the assigned edge, but it would isolate
   exactly which parameter growth causes the open case.

If the atlas were being edited, I would leave the implication `open` and
strengthen the note to say that marginal-nonuniformity and improper voting do
not remove the clean-tuple barrier; the unresolved point is a fully
polynomial fixed-slack agnostic booster or a noisy-only nonboostable-handle
separation.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 4 Branch A: No Label Advice Or Proper Handle Witness

### Goal

This branch focused on the two remaining handles from Depth 3:

1. Could the target's marginal-nonuniform polynomial hide the label-dependent
   information needed to beat the fixed weak slack?
2. Could one build a noisy-only nonboostable-handle class: distribution-free
   weak agnostic proper learning is easy, clean realizable improper learning is
   easy by ordinary boosting, but fixed-marginal high-noise
   $\operatorname{OPT}+\varepsilon$ improper learning is hard?

I do not see a resolution. The branch does sharpen both routes. The
marginal-nonuniform target is not a label-nonuniform target, and the false
witness would need a stronger proper threshold-decoding primitive than the
nearby improper-source scratchpads require.

### Marginal Nonuniformity Is Not Label Advice

Under the atlas pathwise resource convention, the assigned target is already
almost the distribution-free strong improper target. The implication

$$
\texttt{efficient-marginal-nonuniform-agnostic-improper-pac}
\Rightarrow
\texttt{efficient-agnostic-improper-pac}
$$

is recorded as true by full-support marginal uniformization: a full-support
reference marginal $P^\star$ bounds the runtime of the one uniform learner on
every finite transcript, while accuracy is still applied under the actual
marginal. Therefore, proving this assigned edge true would essentially settle
the distribution-free sibling

$$
\texttt{efficient-weak-agnostic-proper-pac}
\Rightarrow
\texttt{efficient-agnostic-improper-pac}.
$$

So there is no special marginal-only escape hatch in the atlas semantics.
Even without invoking that implication, the target polynomial $p_P$ may depend
only on the instance marginal. It must work for every conditional label rule
over that same $P$.

The noisy comparator channel makes this explicit. Let

$$
\beta=1/2-\gamma,\qquad
Y=f(X)N,\qquad
\Pr[N=-1]=\eta,\qquad
\gamma<\eta<1/2,
$$

with $f\in C$ and $X\sim P$. The original distribution has
$\operatorname{OPT}_C\le \eta$, so a fixed-additive weak learner is not forced
to reveal $f$. The hidden clean set

$$
G_f=\{(x,y):y=f(x)\}
$$

depends on $f$ and the label noise, not on $P$. A $P$-dependent preprocessing
stage, even with unlimited unlabeled samples, cannot know which points are in
$G_f$.

Agreement filtering has the same circularity. If a current predictor $g$ has
correlation

$$
r=\mathbb E_P[g(X)f(X)],
$$

then conditioning on the observable event $Y=g(X)$ gives noise relative to
$f$

$$
\Pr[Y\ne f(X)\mid Y=g(X)]
=
\frac{\eta(1-r)}
{(1-\eta)(1+r)+\eta(1-r)}.
$$

This is below the weak threshold $\gamma$ only when

$$
r>
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

Thus the observable filter produces a forced low-$\operatorname{OPT}$ weak
call only after the learner already has nontrivial correlation with the hidden
comparator. This is exactly the missing information. The same issue appears
for residual relabeling and same-marginal boosting: the $f$-dependent part of
any transcript-measurable label channel remains attenuated by the original
bias $1-2\eta$ unless the transcript already contains a correlated predictor
or hits a hidden clean tuple.

This also explains why the current positive theorems still stop short. I
rechecked the current primary pages for the relevant routes. Feldman-style
distribution-specific boosting keeps the instance marginal fixed by changing
labels (<https://arxiv.org/abs/0909.2927>), and Ghai--Singh 2025 gives a
modern efficient unlabeled-data version
(<https://proceedings.mlr.press/v267/ghai25a.html>). But these are
accuracy-sensitive weak-oracle results. The atlas source supplies only

$$
\operatorname{corr}(h,Y)\ge \rho_C-2\beta,
$$

which leaves a constant residual floor. The da
Cunha--Hogsgaard--Paudice 2026 theorem accepts this fixed nontrivial slack
semantically, and its arXiv page still states polynomial runtime in the sample
size with the other parameters fixed
(<https://arxiv.org/abs/2601.11265>). The known construction still pays
$n^{m_0}$-type clean-transcript enumeration. A marginal-dependent polynomial
cannot absorb an exponent $m_0(s)$ that grows with representation size.

Proper weak outputs help only after the useful hypotheses have appeared. Since
the final target is improper, it may validate, flip, weight, and vote over
proper weak hypotheses. But if every polynomially generated weak call has
$\operatorname{OPT}_C\ge\gamma$, a legal source learner may answer with proper
decoys throughout.

### The Needed False Witness Is A Proper Threshold Decoder

A false witness must be noisy-only. The source restricted to realizable labels
gives distribution-free weak realizable proper learning, and standard
realizable boosting then gives distribution-free strong realizable improper
learning. Thus a target-negative class cannot be hard on clean labels; the
hardness has to appear only above the fixed weak noise threshold.

The cleanest abstraction is a public code or seed class. Let
$C_s=\{c_m:X_s\to\{\pm1\}\}$, possibly augmented with constants and proper
handles, and let $U_s$ be the hard fixed marginal. To prove the source with
$\beta=1/2-\gamma$, constants can handle the high-$\operatorname{OPT}$ regime
when they are in the class:

$$
\operatorname{OPT}_C(D)\ge\gamma
\quad\Longrightarrow\quad
1/2\le \operatorname{OPT}_C(D)+1/2-\gamma.
$$

The low-$\operatorname{OPT}$ source obligation is the hard part:

**Proper arbitrary-weight threshold decoder.** For every coordinate marginal
$P$, every label rule $Y$, and every representation size $s$, if

$$
\eta=\inf_{c\in C_s}\Pr_{X\sim P}[c(X)\ne Y]<\gamma,
$$

then a polynomial-time learner must output a proper hypothesis
$h\in C_s$ with

$$
\Pr[h(X)\ne Y]\le \eta+1/2-\gamma<1/2.
$$

The target failure would then require fixed-marginal high-noise hardness: for
some $\eta\in(\gamma,1/2)$, no polynomial-time improper learner from samples
$X\sim U_s$ and noisy labels around a hidden $c_m$ achieves
$\eta+\varepsilon$ error.

This primitive is stronger than the code template for the improper-source
sibling. The weak learner here must output a member of $C$, not an arbitrary
predictor. If handles are added, the handles themselves are benchmark
concepts; the proper weak learner may output them, and the strong improper
target may also validate, memorize, and aggregate them.

### Why The Candidate Handles Still Miss

**One-way image-coordinate handles.** These separate weak proper sources from
strong proper targets, but the assigned target is improper. Under the fixed
coordinate marginal, an improper learner can sample enough at the requested
accuracy to memorize visible positive atoms or validate bounded handles. If the
handles are hidden enough to block this, then a distribution concentrated on
the hidden region defeats the distribution-free weak proper source.

**Parity/Hadamard and LPN-style codes.** These have the right high-noise
fixed-marginal hardness flavor. They fail the source side: arbitrary-weight
low-noise proper decoding is essentially weighted adversarial noisy parity or
nearest-codeword search. Standard LPN hardness does not switch on only above a
chosen threshold $\gamma$ while leaving all lower weighted noise efficiently
properly weak-decodable.

**Algebraic codes.** Reed--Solomon, Reed--Muller, and related codes have
public bounded-distance or soft-decision structure, but this does not yet give
the binary PAC proper threshold decoder above. Arbitrary coordinate weights,
puncturings, and bit-level labels are stronger than the usual Hamming or
symbol-reliability decoding guarantees. Conversely, if a public polynomial
list decoder works near the high-noise radius, an improper target learner can
validate the list on fresh samples.

**PCP/CSP and visible-handle encodings.** These mainly separate proper output
requirements. Once the final learner is improper, small active slices,
lookup-style hypotheses, constants, or validated handle votes tend to make the
target learnable. Signed-label variants that avoid constants make the weak
proper source look like the hard optimization problem again.

So I cannot build the noisy-only nonboostable handle. The desired object is
more specific now: easy proper weak handles for every low-noise weighted
marginal, but no polynomial-time way, even improperly, to assemble enough
high-noise information under one fixed marginal.

### Obstacles And Depth 5 Directions

1. Formalize a black-box lower bound with label-uniform marginal preprocessing.
   Allow unlimited unlabeled samples from a fixed $P$, arbitrary
   $P$-dependent preprocessing, and adaptive weak calls whose outputs are
   proper. Show that polynomially many same-marginal transcript-measurable
   calls cannot force $\operatorname{OPT}<\gamma$ in the noisy-comparator
   channel unless they already have correlation with $f$ or hit an
   $m_0$-tuple clean event. This would be an oracle barrier, not an atlas
   false witness.
2. Audit one proper threshold-decoder candidate in full. The sharpest test is:
   choose a binary concatenated Reed--Solomon or Reed--Muller family, then ask
   whether every arbitrary bit-weighted labeling at distance $<\gamma$ admits
   a polynomial-time proper weak decoder. If yes, check whether the same public
   machinery gives a validated improper learner at the proposed hard radius.
3. Search for a semi-agnostic proper approximation witness. It would suffice
   to find a class with efficient distribution-free proper
   $A\operatorname{OPT}+\varepsilon$ learning, for a constant $A$ strong enough
   to imply $\operatorname{OPT}+1/2-\gamma$ after validation with constants,
   but with fixed-marginal hardness for exact improper
   $\operatorname{OPT}+\varepsilon$ learning. I do not know such a class.

I would leave the atlas edge open. The strongest update is that the marginal
target supplies no label-dependent advice and, under the atlas full-support
resource convention, is no easier than the distribution-free strong improper
sibling. A proof still needs a fully polynomial fixed-slack forcing lemma; a
disproof still needs a proper threshold-decodable noisy-only handle class.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 5 Branch A: Parity Gives The Conditional Threshold Witness

### Branch Target

Depth 4 isolated the missing false witness as a public class with two
features:

1. a proper arbitrary-weight low-noise threshold decoder, strong enough to
   prove the distribution-free weak agnostic proper source;
2. fixed-marginal high-noise hardness against improper
   $\operatorname{OPT}+\varepsilon$ learning.

This branch found a real conditional witness for the inverse-polynomial weak
gap reading of the atlas source, but not for the strict constant-slack reading
used in much of this scratchpad. The witness is the affine parity class and
the hardness assumption is constant-noise decision-LPN.

This matters for the assigned marginal-nonuniform target because the hard
distribution has one fixed marginal, the uniform distribution on
$\{0,1\}^n$. A marginal-nonuniform learner would still have a polynomial
runtime bound for that marginal, so it would still break the LPN
distinguishing assumption.

### The Conditional Witness

Let $\mathcal C_n$ be the affine parities on $\{0,1\}^n$,

$$
c_{a,b}(x)=\langle a,x\rangle \oplus b,
\qquad a\in\{0,1\}^n,\ b\in\{0,1\}.
$$

This is proper, and it contains the two constants by taking $a=0$.
Set

$$
\lambda_n=\Theta(1/n),
\qquad
\beta_n=1/2-\lambda_n .
$$

I claim $\mathcal C_n$ has an efficient distribution-free proper weak
agnostic learner with tolerance $\beta_n$.

The learner forms a candidate list. First put the two constants in the list.
Then repeat $O(\log(1/\delta))$ times:

1. draw a fresh batch of $m=A n$ labeled examples, for a large enough absolute
   constant $A$;
2. solve the affine linear system over $\mathbb F_2$ imposed by the batch;
3. if the system is consistent, add any consistent affine parity.

Finally validate all candidates on a fresh sample to accuracy, say,
$\lambda_n/8$, and output the empirically best proper candidate.

Fix any distribution $D$ and let

$$
\alpha=\operatorname{OPT}_{\mathcal C_n}(D).
$$

If $\alpha\ge 2\lambda_n$, the better constant has error at most $1/2$, hence
after validation has error at most

$$
1/2+\lambda_n/8
\le
\alpha+1/2-\lambda_n
=
\alpha+\beta_n .
$$

If $\alpha<2\lambda_n$, let $f\in\mathcal C_n$ be a best affine parity. A
batch of $m=A n$ examples is clean relative to $f$ with probability

$$
(1-\alpha)^m\ge \exp(-O(A n\lambda_n)),
$$

which is a positive constant when the hidden constant in $\lambda_n=\Theta(1/n)$
is chosen small enough.

Condition on such a clean batch. For another affine parity $h$, write

$$
q=D[h(X)\ne f(X),Y=f(X)],
\qquad
r=D[h(X)\ne f(X),Y\ne f(X)].
$$

Then

$$
\operatorname{err}_D(h)-\operatorname{err}_D(f)=q-r .
$$

So any $h$ with

$$
\operatorname{err}_D(h)>\alpha+1/2-2\lambda_n
$$

has $q>1/2-2\lambda_n$. On the clean conditional distribution
$D\mid Y=f(X)$, such an $h$ disagrees with the clean label with probability at
least roughly $1/2-O(\lambda_n)$. Therefore the probability that this fixed
bad $h$ is consistent with all $A n$ clean examples is at most

$$
(1/2+O(\lambda_n))^{A n}.
$$

A union bound over the $2^{n+1}$ affine parities succeeds for sufficiently
large $A$. Thus, with constant probability in each repetition, every parity
consistent with the clean batch has error at most

$$
\alpha+1/2-2\lambda_n .
$$

Validation loses only $O(\lambda_n)$, so the final output satisfies

$$
\operatorname{err}_D(h)\le \alpha+1/2-\lambda_n .
$$

This is exactly the proper arbitrary-weight threshold decoder, but with an
inverse-polynomial threshold. It is arbitrary-weight because the argument used
only the unknown distribution $D_X$ through samples; no uniform-marginal or
Hamming-metric assumption appears.

### Fixed-Marginal High-Noise Hardness

Assume constant-noise decision-LPN: for some fixed
$\eta\in(0,1/2)$, no randomized polynomial-time algorithm distinguishes

$$
(X,\langle a,X\rangle\oplus b\oplus N),
\qquad
X\sim U_n,\quad N\sim\operatorname{Bernoulli}(\eta),
$$

from uniformly random labeled examples, with non-negligible advantage. This is
the standard noisy-parity pseudorandomness assumption from the Blum--Furst--
Kearns--Lipton line, and the agnostic parity connection is the one made by
Feldman--Gopalan--Khot--Ponnuswami.

Suppose the assigned target held for affine parities. Apply the
marginal-nonuniform learner to the fixed marginal $U_n$ and the noisy parity
label distribution above, with

$$
\varepsilon < (1/2-\eta)/4 .
$$

For every large enough $n$, $\eta>\lambda_n$, and the best parity has error
$\eta$. The target learner would output an arbitrary, possibly improper,
hypothesis $H$ with

$$
\operatorname{err}(H)\le \eta+\varepsilon<1/2
$$

in polynomial time for this fixed marginal. On fresh examples from the same
oracle, $H$ has positive correlation with the labels. On fresh uniformly
random labels, conditional on the training transcript and on $H$, the expected
correlation is $0$ and concentrates around $0$. Estimating this fresh
correlation distinguishes noisy parity from random labels in polynomial time,
contradicting decision-LPN.

The marginal-nonuniform relaxation does not help the learner evade this
reduction. The hard marginal is fixed and label-independent. The polynomial
$p_{U_n}$ may depend on the uniform marginal, but not on the hidden parity
$(a,b)$ or on the label noise realization. Thus a target learner gives a
polynomial-time LPN distinguisher.

### What This Does And Does Not Resolve

This branch answers the Depth 4 question in a useful but schema-sensitive way.
The low-noise proper threshold decoder does **not** automatically leak enough
structure to learn at high noise. For affine parities the decoder works by
finding an $O(n)$ clean batch. When
$\operatorname{OPT}=O(1/n)$, such a batch occurs with constant probability.
At constant LPN noise it occurs with probability $\exp(-\Omega(n))$, and the
decoder exposes no polynomial list that an improper high-noise learner can
validate.

So, under the parameterized inverse-polynomial weak-gap reading, this is a
conditional false solution suitable for an atlas update:

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions: ["constant-noise decision-LPN hardness"]`
- `witnesses: ["affine-parities"]`
- summary: affine parities have an efficient proper
  $\operatorname{OPT}+1/2-\Theta(1/n)$ weak agnostic learner by constants,
  clean-batch Gaussian elimination, and validation, but marginal-nonuniform
  strong agnostic improper learning under the uniform marginal would
  distinguish constant-noise LPN from random labels.

Under a strict constant-slack source, however, this does not settle the edge.
If $\gamma$ is a fixed positive constant and the source required
$\operatorname{OPT}+1/2-\gamma$, then the same parity class would need to
properly weak-learn constant-noise parities under the uniform marginal. That
already collides with the LPN hardness used for the target. In that stricter
reading, the false witness still needs a genuine constant-threshold public
decoder that remains high-noise hard.

I also do not see a fully polynomial fixed-slack positive route. The
da Cunha--Hogsgaard--Paudice theorem still supplies the nearest semantic
positive result, but the clean-transcript search remains
$n^{m_0}$-type in the weak sample parameter. The affine parity witness
explains why this search cost is not just proof slack: when the useful
low-noise certificate is an $m_0=\Theta(n)$ clean batch, polynomial random
search sees it only in the inverse-polynomial noise regime, not at constant
high noise.

### Depth 6 Directions

1. Decide the atlas convention for this edge: if inverse-polynomial weak gaps
   are allowed for `efficient-weak-agnostic-proper-pac`, promote affine
   parities to a conditional false witness under constant-noise decision-LPN.
   If the intended source is strict constant slack, record parity as a
   non-witness and keep the edge open.

2. For strict constant slack, audit noise-threshold public codes with
   exponential coordinate domains. The needed object is constant low-noise
   arbitrary-weight proper decoding under every marginal, but fixed uniform
   high-noise hardness against improper prediction. Polynomial-length public
   codes leak through repeated coordinate denoising and validation; parity-like
   exponential codes keep the high-noise hardness but fail the constant
   low-noise source.

3. Try to prove a formal black-box barrier matching the parity calculation:
   any same-marginal fixed-slack booster that only sees polynomially many
   weak-call transcripts cannot turn a high-noise comparator channel into a
   low-$\operatorname{OPT}$ weak call without either prior correlation with the
   hidden comparator or an exponentially rare clean transcript. This would not
   be an atlas separation, but it would sharply delimit the positive route.

VERDICT: conditional-only scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 6 Branch A: Constant Slack Needs A Threshold Decoder

### Branch Target

This branch treats the source exactly as the atlas definition states it:
there is one fixed additive tolerance

$$
\beta=1/2-\gamma
$$

with $\gamma>0$ independent of the representation size. Under this reading,
the affine-parity construction from Depth 5 is only a diagnostic. It proves a
conditional false statement for inverse-polynomial weak gaps, but it is not a
fixed-constant source-positive witness.

The goal was therefore to find one of two things:

1. a class with a distribution-free proper
   $\operatorname{OPT}+1/2-\gamma$ weak agnostic learner for a fixed constant
   $\gamma$, but no fixed-marginal strong agnostic improper learner; or
2. a fully polynomial fixed-slack agnostic booster whose runtime is polynomial
   in the weak learner's sample/time bounds and in $1/\varepsilon$, with no
   weak-sample or capacity parameter in the exponent.

I found neither. The edge remains unresolved under the actual atlas semantics.

### Why Affine Parity Is Source-Negative At Constant Slack

For affine parities, Depth 5 used clean $O(n)$ batches. If
$\operatorname{OPT}=O(1/n)$, a clean batch appears with constant probability,
Gaussian elimination recovers a good parity, and validation gives
$\operatorname{OPT}+1/2-\Theta(1/n)$. This is exactly the
inverse-polynomial weak-gap route.

For fixed $\gamma$, the same proof would need to work when

$$
\operatorname{OPT}=\eta<\gamma
$$

is a positive constant. Then an $O(n)$ batch is clean with probability
$(1-\eta)^{\Theta(n)}=\exp(-\Theta(n))$, so the clean-batch decoder is no
longer polynomial. More importantly, if constant-noise LPN is assumed at some
$\eta<\gamma$, then a proper weak learner with tolerance $1/2-\gamma$ for
affine parities under the uniform marginal would output a parity with error

$$
\le \eta+1/2-\gamma < 1/2,
$$

which gives a polynomial-time noisy-parity distinguisher. Thus affine parity
does not merely fail to prove the source; under the same style of hardness
assumption used in Depth 5, it actively refutes the fixed-constant source.

This same check rules out the nearby parity/Hadamard code variants. They keep
the high-noise target hardness, but constant low-noise proper weak decoding is
already the hard LPN-type problem.

### Positive Route Check

The current primary agnostic-boosting results still do not close the edge.

Feldman-style and Ghai--Singh style distribution-specific boosters are
well-aligned with the marginal part of the target: they can use unlabeled data
from the fixed instance marginal and work by changing labels rather than by
needing new instance marginals. But their efficient guarantees are
accuracy-sensitive. They need a threshold or correlation slack that shrinks
with the final excess error, whereas the atlas source supplies only

$$
\operatorname{corr}(h,Y)\ge \rho_C(D)-2\beta
$$

with the fixed residual $2\beta$.

The da Cunha--Hogsgaard--Paudice line remains the closest semantic match. Its
weak-oracle form accepts the atlas source with
$\gamma_0=1$, $\epsilon_0=2\beta$, and fixed
$\theta=(1-2\beta)/2>0$. The final aggregate is improper, so output format is
also fine. The obstruction is still quantitative: the current algorithm is
polynomial in the sample size only with the weak sample size, capacity
parameters, and $\theta^{-1}$ treated as fixed. In the atlas edge, the weak
sample size $m_0(s)$ and capacity parameter $d^*(s)$ may grow polynomially
with the representation size. Runtime terms of the form

$$
n^{\Omega(m_0(s))}
$$

are not allowed by a target polynomial
$p_P(s,1/\varepsilon,\log(1/\delta))$. The target's marginal-nonuniformity
does not help because $p_P$ may depend on the unlabeled marginal $P$, not on
the hidden comparator $f$, the label noise, or a representation-dependent
clean-transcript search exponent.

I also checked the older Ben-David--Long--Mansour/Gavinsky style weak
agnostic boosting route. It gives useful weak-to-better guarantees for the
fixed-additive weak notion, but not an
$\operatorname{OPT}+\varepsilon$ agnostic learner. The residual gap is exactly
what this edge is asking to remove.

### Fixed-Constant False Witness Search

The fixed-constant false witness would have to be a threshold phenomenon:
easy proper weak decoding below one constant noise level, but hard improper
strong prediction above that level under one fixed marginal.

The following candidates still fail.

**Halfspaces and monomials.** Tiegel-style halfspace hardness is strong enough
for the target, but halfspaces are not source-positive. The
Feldman--Guruswami--Raghavendra--Wu monomial result is a useful sanity check:
for every constant $\epsilon>0$, weak agnostic learning of monomials is hard
even by halfspaces when a monomial has error $\epsilon$. Since monomials are
halfspaces, any distribution-free constant-slack weak learner for halfspaces
would solve such instances for $\epsilon<\gamma$. So halfspaces and
monomial/DNF variants do not supply the source.

**DNF and conjunction hardness.** Modern improper DNF hardness and classical
conjunction hardness have the right target flavor only if the source is
weakened. For the fixed-constant source they either become source-negative
through weak agnostic hardness, or they are only proper-output hardness
witnesses. Proper-output hardness is irrelevant here because the target is
improper.

**Algebraic or concatenated codes.** A plausible route is a binary public code
with polynomial-time arbitrary-weight proper decoding below a constant radius
$\gamma$, but computational hardness of prediction at a larger constant
noise rate $\eta\in(\gamma,1/2)$ under the uniform coordinate marginal. I do
not have such a code. Standard algebraic list/soft-decision decoders do not
immediately give the required binary PAC statement for arbitrary coordinate
weights and arbitrary label rules. Conversely, if they produce a polynomial
list near the high-noise radius, an improper target learner can validate that
list on fresh labeled samples.

**Semi-agnostic approximation classes.** A source-positive witness could also
come from a proper learner with

$$
\operatorname{err}(h)\le A\operatorname{OPT}_C+\varepsilon
$$

for a fixed constant $A$: constants handle $\operatorname{OPT}_C\ge\gamma$,
and for $\gamma<1/(2A)$ the approximation handles the low-optimum regime. The
missing class would still need exact fixed-marginal improper agnostic learning
to be hard. I do not know a legal example. Known halfspace and monomial
hardness results tend to rule out the constant-factor source itself, while
lookup/PCP/properization gadgets become learnable once the final hypothesis is
allowed to be improper.

### Current State

The best current statement is still open, not conditional-false. The fixed
constant source is much stronger than the inverse-polynomial source used by
the affine-parity branch, but I do not see a theorem that converts that
strength into a fully polynomial strong learner.

The obstruction can be summarized as follows. In a noisy comparator channel

$$
Y=f(X)N,\qquad \Pr[N=-1]=\eta,\qquad \gamma<\eta<1/2,
$$

the target must recover $f$ to excess $\varepsilon$, but the source weak
learner is not forced to reveal any information on the original distribution.
To make a forced weak call, a booster must either already have correlation
with $f$ or manufacture a low-noise distribution such as a clean conditional
sample. The known generic way to do the latter enumerates weak-learner input
tuples and pays $n^{m_0(s)}$. No marginal-only preprocessing can identify the
$f$-dependent clean set.

### Depth 7 Directions

1. **Audit one code threshold candidate end to end.** Pick a specific binary
   concatenated Reed--Solomon or Reed--Muller family. Prove or refute the
   exact source lemma: for every coordinate marginal and every label rule with
   weighted distance $<\gamma$ from a codeword, there is a polynomial-time
   proper learner returning a codeword of error $<1/2$. Then check whether the
   same decoder/list decoder gives a validated improper high-noise learner,
   which would kill the witness.

2. **Search for a constant-factor semi-agnostic witness.** The target object
   is a class with efficient distribution-free proper
   $A\operatorname{OPT}+\varepsilon$ learning for a fixed constant $A$, but
   fixed-marginal exact improper agnostic hardness. This would immediately
   imply the fixed-additive source for $\gamma<1/(2A)$. Existing monomial,
   halfspace, DNF, and properization witnesses should be treated as failed
   baselines unless they satisfy both sides of this sentence.

3. **Prove a black-box clean-transcript barrier.** Formalize the noisy
   comparator model with a fixed marginal, unlimited unlabeled preprocessing,
   and polynomially many adaptive calls to a proper
   $\operatorname{OPT}+1/2-\gamma$ weak learner. Show that any transcript that
   forces $\operatorname{OPT}<\gamma$ must either contain prior correlation
   with the hidden comparator or hit a clean/low-noise weak sample event. This
   would not be an atlas counterexample, but it would explain why a fully
   polynomial fixed-slack booster needs a genuinely new idea.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 7 Branch A: Final Consolidation

### Final Goal And Verdict

This final branch treats the source in the fixed-constant form recorded in
the atlas:

$$
\operatorname{err}_D(h)\le
\operatorname{OPT}_C(D)+\beta,
\qquad
\beta=1/2-\gamma,
\qquad
\gamma>0
$$

where $\gamma$ is independent of the representation size. Under this reading I
cannot resolve the edge. The best final status is still `open`: no fully
polynomial fixed-slack agnostic booster is known, and no source-positive /
target-negative fixed-constant witness is known.

The main lesson from all seven depths is that the target relaxations remove
two distractions but not the quantitative obstruction. Proper weak outputs are
exactly what an improper final vote wants, and marginal-nonuniformity is
compatible with same-marginal boosting. The missing piece is a way to turn a
fixed additive weak agnostic guarantee into arbitrary
$\operatorname{OPT}+\varepsilon$ accuracy in time polynomial in the
representation size, the weak learner's own polynomial resources, and
$1/\varepsilon$.

### Fixed-Constant Slack Barrier

In $\{\pm1\}$ notation the source gives

$$
\operatorname{corr}_D(h,Y)
\ge
\rho_C(D)-2\beta
=
\rho_C(D)-1+2\gamma,
$$

where

$$
\rho_C(D)=\sup_{c\in C}\mathbb E_D[Yc(X)].
$$

Equivalently, it is forced to output a hypothesis with positive advantage over
random guessing only on distributions where the best proper comparator has
error below $\gamma$. On query distributions whose best proper error is at
least $\gamma$, the weak learner may legally return a proper decoy. A strong
agnostic learner, however, must still recover comparator information in
noisy channels with

$$
Y=f(X)N,
\qquad
\Pr[N=-1]=\eta,
\qquad
\gamma<\eta<1/2,
$$

because the target asks for error $\eta+\varepsilon$ for arbitrarily small
$\varepsilon$. Thus the source has a fixed resolution floor while the target
asks for accuracy below that floor.

This is not a marginal issue. If the original marginal is $P$, the clean set
or low-noise conditional distribution that would force a useful weak call
depends on the hidden comparator $f$ and on the labels, not on $P$ alone.
Marginal-nonuniformity lets the runtime polynomial depend on $P$, but it does
not provide label advice.

### Proper Weak Outputs And Improper Final Votes

Properness is helpful but not decisive. Every weak output already lies in
$C$, so a successful booster could output an improper majority, weighted vote,
or real-valued aggregate over proper hypotheses. This means there is no final
properization obstruction in the assigned edge.

The problem is earlier in the pipeline: the booster has to generate enough
useful proper hypotheses. If all polynomially many weak calls are made on
distributions whose best proper error is at least $\gamma$, the source learner
can answer with legal proper decoys. Improper aggregation can validate,
weight, flip, and combine useful hypotheses after they appear; it cannot force
them to appear from a fixed-slack oracle.

### Known Positive Routes Still Stop Short

Same-marginal agnostic boosting is the right syntactic shape for the target.
Feldman-style distribution-specific boosting and the Ghai--Singh unlabeled-data
route work by keeping the instance marginal fixed or by using unlabeled
samples from it. These results support the conditional principle:

> If the weak interface had tunable slack at scale $O(\varepsilon)$, or an
> equivalent accuracy-sensitive threshold oracle, then the marginal part of
> the target would not be the obstruction.

But the atlas source supplies only the fixed residual $2\beta=1-2\gamma$ in
correlation form. Translating a fixed-additive oracle into an
accuracy-sensitive booster leaves a constant residual term.

The da Cunha--Hogsgaard--Paudice fixed-slack theorem is the closest semantic
match. The atlas source fits its nontrivial weak-oracle form with
$\gamma_0=1$, $\epsilon_0=2\beta$, and
$\theta=(1-2\beta)/2=\gamma$. The final aggregate is improper, so the output
format is also compatible.

The obstruction remains runtime. The known generic construction pays for
clean weak-learner transcripts by enumerating weak sample tuples and searching
over aggregates. Its displayed bounds include terms of the form

$$
n^{O(m_0)}
\quad\text{or}\quad
n^{O(m_0\min\{d^*,\log n\}/\theta^2)},
$$

where $m_0$ is a weak sample parameter and $d^*$ is a capacity parameter. In
the atlas source these parameters may grow polynomially with representation
size $s$. Then the runtime can be $n^{\operatorname{poly}(s)}$, not a
polynomial in $(s,1/\varepsilon,\log(1/\delta))$.

This gives another conditional true principle:

> In regimes where $m_0$, $d^*$, and $\theta^{-1}$ are fixed constants, the
> current fixed-slack boosting theorem gives the desired semantic implication.
> To prove the atlas edge, one needs a version whose runtime is polynomial in
> these weak parameters rather than using them in the exponent.

### Affine Parity Fork

Depth 5 found a real conditional counterexample for an
inverse-polynomial weak-gap variant, but Depth 6 showed why it does not apply
to this fixed-constant edge.

For affine parities on $\{0,1\}^n$, constants plus clean-batch Gaussian
elimination give a proper distribution-free weak agnostic learner with

$$
\beta_n=1/2-\Theta(1/n).
$$

If $\operatorname{OPT}=O(1/n)$, an $O(n)$ sample batch is clean with constant
probability, and a union bound over $2^{n+1}$ parities makes the proper
decoder work. Under constant-noise decision-LPN, marginal-nonuniform strong
agnostic improper learning under the uniform marginal would distinguish noisy
parity labels from random labels. So the inverse-polynomial version is
conditionally false.

For fixed constant slack, the same class is source-negative. If
$\eta<\gamma$ is a constant LPN noise rate, then a fixed-slack proper weak
learner for affine parities under the uniform marginal would output a parity
with error

$$
\eta+1/2-\gamma<1/2,
$$

which already gives a noisy-parity distinguisher. The clean-batch method also
fails quantitatively, since an $O(n)$ batch is clean with probability
$\exp(-\Theta(n))$ at constant noise. Thus affine parity is a useful model
fork, not a fixed-constant atlas witness.

### Threshold Decoder Requirement For A False Witness

A fixed-constant false witness would need a genuine threshold phenomenon.
For some constant $\gamma>0$, it would need:

1. **Source side:** for every marginal $P$, every label rule, and every
   distribution with $\operatorname{OPT}_C(D)<\gamma$, a polynomial-time
   learner outputs a proper $h\in C$ with error below $1/2$ and in fact at
   most $\operatorname{OPT}_C(D)+1/2-\gamma$.
2. **Target side:** for some fixed marginal $U$ and some higher constant
   noise $\eta\in(\gamma,1/2)$ around a hidden $c\in C$, no polynomial-time
   improper learner achieves error $\eta+\varepsilon$.

Equivalently, the class would need an arbitrary-weight proper threshold
decoder below one constant radius, while remaining high-noise hard for
improper prediction above that radius under one fixed marginal.

No checked candidate has this shape. Halfspaces, monomials, DNF variants, and
parity-like codes are source-negative under known hardness results once the
low-noise threshold is a fixed constant. Public handles, lookup gadgets,
PCP-slice constructions, and algebraic-code lists tend to become target-easy
once the final learner is allowed to be improper and can validate or aggregate
visible candidates.

### No Known Separation

The separation template remains plausible but unrealized:

$$
\text{easy proper weak decoding below fixed noise}
\quad+\quad
\text{hard improper high-noise prediction above it}.
$$

The difficulty is that the source is distribution-free and proper. If the
handles or decoder are public enough to satisfy every low-noise weighted
marginal, an improper target learner often sees enough structure to validate,
memorize, or vote. If the hard core is hidden enough to defeat the target, a
distribution concentrated on that hard region usually defeats the source too.

So there is no atlas-ready false witness. There is also no unconditional
positive theorem that removes the fixed slack in fully polynomial time.

### Atlas-Ready Proposed Summary

Open. A distribution-free proper fixed-additive weak agnostic learner supplies
proper hypotheses suitable for an improper final vote, and same-marginal
boosting shows that marginal changes are not the main obstruction. The open
point is quantitative: known accuracy-sensitive agnostic boosters need weak
slack at the final $\varepsilon$ scale, while known residual-free fixed-slack
boosters put weak sample or capacity parameters in the runtime exponent.
Affine parities give a conditional inverse-polynomial-gap separation under
decision-LPN, but they are source-negative for fixed constant slack. No
fixed-constant source-positive / target-negative witness is known.

### Atlas-Ready Proof Status Body

**Goal.** Decide whether
[[efficient-weak-agnostic-proper-pac|efficient weak agnostic proper PAC
learning]] implies
[[efficient-marginal-nonuniform-agnostic-improper-pac|efficient
marginal-nonuniform agnostic improper PAC learning]].

**Verdict.** Open. The source uses a fixed additive tolerance
$\beta=1/2-\gamma$ with constant $\gamma>0$. In correlation form it gives only
a constant-slack approximation to the best proper correlation, so it is forced
to reveal useful information only on weak-call distributions where the best
proper error is below $\gamma$.

**Why the target relaxations do not settle it.** Since the weak outputs are
already proper and the target is improper, a positive proof may output a vote
or aggregate over weak hypotheses. Since the source is distribution-free,
ordinary reweighting is allowed; same-marginal relabeling is also compatible
with the target's marginal-nonuniform accounting. The obstruction is that a
fixed marginal polynomial cannot identify the hidden label-dependent clean
subsets needed to force below-threshold weak calls.

**Known positive evidence.** Accuracy-sensitive same-marginal boosters prove
the desired kind of conclusion from a tunable weak oracle, but the atlas weak
oracle has fixed slack. The fixed-slack boosting theorem of da
Cunha--Hogsgaard--Paudice semantically accepts this source and permits an
improper aggregate, but the current generic runtime has weak sample and
capacity parameters in the exponent. This is polynomial only in
fixed-parameter regimes, not in the full representation-uniform atlas sense.

**Known negative evidence.** Affine parities, under constant-noise
decision-LPN, separate an inverse-polynomial weak-gap variant from the target:
clean-batch Gaussian elimination gives proper weak learning at gap
$\Theta(1/n)$, while strong improper agnostic learning under the uniform
marginal would distinguish LPN. For fixed constant slack, the same witness
fails the source, since weak learning below a constant LPN noise rate would
itself distinguish noisy parities.

**What would resolve the edge.** A true proof would require a fully
polynomial fixed-slack agnostic booster, with runtime polynomial in the weak
learner's sample/time bounds and capacity parameters rather than exponential
in them. A false proof would require a class with arbitrary-weight proper
threshold decoding below a fixed constant noise level, but fixed-marginal
high-noise hardness even for improper prediction. Neither object is currently
known.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md
