# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md
- verdict: unresolved-open
- confidence: medium-high

## Context

The source gives one uniform learner $A$ such that, for every instance marginal
$P$, there are a marginal-dependent polynomial resource bound and a weak
agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

with $1/\gamma_P(s)$ bounded by some $P$-dependent polynomial. For every joint
distribution $\mathcal D$ with marginal $P$,

$$
\operatorname{err}_{\mathcal D}(A)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

The target asks, for the same original marginal $P$ and every realizable target
$c\in\mathcal C$, for error at most arbitrary $\varepsilon$ in time and samples
bounded by a polynomial $q_P(s,1/\varepsilon,\log(1/\delta))$.

Restricting the source to realizable labels immediately gives a weak
marginal-nonuniform realizable improper learner under the original marginal
$P$. The unresolved part is whether this weak guarantee can be amplified to
arbitrary accuracy while keeping one polynomial attached to the original
marginal.

## Attempted Resolution

### 1. Direct realizable boosting still changes the marginal

Schapire/Freund boosting would call the weak learner on reweighted marginals
$Q_t$ that depend on the original marginal $P$, the target concept, previous
weak hypotheses, and the booster's randomness. The source does provide a weak
guarantee for each such $Q_t$, but only with its own advantage
$\gamma_{Q_t}(s)$.

Under the atlas worst-case transcript convention, full-support marginal
uniformization can control pathwise sample and running-time bounds for the
single weak learner. So the older "runtime polynomial may depend on $Q_t$"
obstacle is not the cleanest formulation anymore. The real remaining obstacle
is the weak advantage: the source gives no one polynomial depending only on
$P$ that lower-bounds all $\gamma_{Q_t}(s)$ generated during boosting.

Without such a bound, a standard booster can require
$\sum_t \gamma_{Q_t}^2 \gtrsim \log(1/\varepsilon)$ rounds but give no
$P$-dependent polynomial round bound uniform over all targets and histories.

### 2. Same-marginal relabeling is the natural positive route

Because the source is agnostic, one can try to avoid reweighted marginals by
keeping $X\sim P$ and changing only the conditional label distribution. This is
exactly the distribution-specific agnostic boosting idea in Feldman 2010:
weak calls preserve the instance marginal and only relabel examples.

This is the strongest reason to recheck the edge. Unfortunately, Feldman's
theorem uses a threshold-style weak agnostic oracle. In his notation, an
$(\alpha,\gamma)$ weak agnostic learner returns error at most $1/2-\gamma$
whenever the best concept has error at most $1/2-\alpha$, and the
same-marginal booster gives an $\alpha$-optimal agnostic learner.

The atlas fixed-additive source converts to this threshold form only as
follows. If

$$
\operatorname{OPT}(\mathcal D)\le 1/2-\alpha,
$$

then the source returns error at most

$$
1/2-\alpha+\beta_P(s)=1/2-(\alpha-\beta_P(s)).
$$

Thus it gives an $(\alpha,\alpha-\beta_P(s))$ threshold learner only for
$\alpha>\beta_P(s)$. Since $\beta_P(s)$ may be close to $1/2$, this cannot
choose $\alpha=O(\varepsilon)$. Feldman's marginal-preserving booster therefore
gets stuck at a constant floor around $\beta_P(s)$ in the realizable case, not
at arbitrary $\varepsilon$.

The same obstruction appears in a direct weighted-residual calculation. If we
try to simulate a reweighted distribution $Q$ with density $w=dQ/dP$ by
relabeling under $P$, choose conditional label expectation $a(x)c(x)$ with
$0\le a(x)\le 1$. The source guarantee, comparing with $c$, yields only

$$
E_P[a(X)\mathbf 1\{h(X)\ne c(X)\}]\le \beta_P(s).
$$

For normalized weights this implies weighted error at best
$\beta_P(s)/E_P[a]$. To be below $1/2$, one needs $E_P[a]>2\beta_P(s)$.
When $\beta_P(s)$ is close to $1/2$, this cannot focus on a small residual
region. So the agnostic same-marginal power is real, but the fixed additive
slack is too coarse for the small sets that strong realizable boosting must
eventually handle.

### 3. Newer agnostic boosting is close but not enough for this computational edge

The neighboring scratchpads for
`efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac`
identify da Cunha--Hogsgaard--Paudice as the closest fixed-additive route. In
correlation language, the atlas source gives a nontrivial gap
$\theta=\gamma_P(s)$.

If there were a marginal-preserving agnostic booster with runtime polynomial in
the weak learner's sample bound, weak learner runtime, $1/\theta$,
$1/\varepsilon$, and $\log(1/\delta)$, then the hidden marginal-dependent
exponent could plausibly be handled by dovetailing over guesses and validating
candidate hypotheses. That would be a serious route to resolving this edge
true.

The currently recorded issue is that the available very-general
nontrivial-gap boosters put weak-learner or capacity parameters in the exponent
or require stronger oracle formulations. If $m_0$ and $1/\theta$ are
$P$-dependent polynomials in $s$, bounds of the form

$$
n^{O(m_0/\theta^2)}
$$

are generally not atlas-polynomial in $(s,1/\varepsilon,\log(1/\delta))$.

### 4. Counterexample search did not produce a resolved false witness

A false witness would need to satisfy the source for every marginal while
failing strong improper realizable learning under some fixed marginal. The
standard candidates miss this exact shape.

Pseudorandom-function and noisy-parity style classes usually make even weak
prediction hard when $\operatorname{OPT}=0$ or very small, which attacks the
source. Halfspace and lattice hardness is evidence for agnostic hardness, but
the known fixed-marginal results are strong-excess lower bounds, not a proof
that the fixed-additive weak source holds while strong realizable improper
learning fails. One-way image-coordinate witnesses separate proper learning
from improper learning; they do not refute this improper target, and the
existing weak-handle version is explicitly a proper-output separation.

An oracle diagonalization could make the advantages on boosting-generated
marginals arbitrarily small, but that is not an atlas-ready counterexample
unless realized by a concrete concept class and one uniform learner satisfying
the source for all marginals.

## Proposed Atlas Update

No resolved status change is justified. I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
```

Suggested sharper summary:

```yaml
summary: "Open: the agnostic source specializes to a weak realizable learner, but same-marginal relabeling only gives threshold boosting above the fixed additive slack, while standard realizable boosting needs weak advantages on reweighted marginals not controlled by the original marginal."
```

Suggested body direction:

```markdown
The agnostic assumption removes part of the marginal-reweighting concern:
Feldman-style distribution-specific agnostic boosting keeps the instance
marginal fixed by changing labels. However, the atlas source is only a
fixed-additive `OPT + beta_P` weak learner. It yields a threshold weak oracle
at level `alpha` only when `alpha > beta_P`, so the same-marginal booster cannot
drive realizable error below the fixed slack scale. The distribution-independent
boosting route can go below this scale in realizable problems, but it does so by
reweighting the instance marginal; the source gives no original-marginal
polynomial controlling the weak advantages on those induced marginals.
```

References to add if the note is expanded:

```yaml
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - benedek1991fixed
```

## Obstacles

1. The source-to-weak-realizable specialization is easy, but the remaining
   weak-to-strong step is essentially the existing marginal boosting problem.

2. Marginal-preserving agnostic boosting is a near miss. It preserves $P$, but
   for the atlas fixed-additive source it only applies above the threshold
   $\alpha>\beta_P(s)$, leaving an error floor too large for arbitrary
   realizable accuracy.

3. Reweighted realizable boosting can target arbitrary $\varepsilon$, but the
   weak advantages $\gamma_{Q_t}(s)$ on induced marginals have no known
   polynomial envelope depending only on the original marginal $P$.

4. No concrete false witness is currently source-positive and target-negative
   for the improper target. Existing cryptographic and halfspace candidates
   either threaten weak learnability itself or separate only proper learning.

## Next Directions

1. Look for a fully polynomial nontrivial-correlation agnostic booster that
   preserves the original marginal and has no fixed $\alpha$ error floor. This
   would likely resolve the edge true when combined with marginal-nonuniform
   dovetailing over hidden weak parameters.

2. Prove or refute a local-uniformity lemma for reweighted marginals generated
   by smooth/realizable boosting: for each original $P$, are the induced weak
   advantages bounded below by one $P$-dependent inverse polynomial?

3. Formalize the relabeling calculation above as a barrier for any
   same-marginal reduction that only uses the atlas fixed-additive guarantee.
   It would not prove a false edge, but it would isolate what a positive proof
   must exploit beyond naive residual weighting.

4. Search for a concrete improper hardness witness where constant-additive
   agnostic prediction is efficient for every marginal but inverse-polynomial
   realizable accuracy under one fixed marginal is hard. The witness must avoid
   proper-output recovery barriers and must not make weak realizable prediction
   cryptographically hard.

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- Feldman 2010, Distribution-Specific Agnostic Boosting: https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf
- Hanneke, Moran, Thiessen 2025, Marginal-Nonuniform PAC Learnability: https://openreview.net/forum?id=aoVCFtox89
- Neighboring scratchpads for weak agnostic to strong agnostic and realizable to weak agnostic edges in `scratchpads/open-edge-resolution-2026-05-05/`

verdict: unresolved-open

confidence: 0.82

## Depth 2 Attempt: Reweighting Envelope vs. False Witness

- depth: 2
- date: 2026-05-05

### Refined Goal

The source learner $A$ gives, for every marginal $R$, some weak agnostic gap
$\gamma_R(s)>0$ with $1/\gamma_R(s)$ bounded by an $R$-dependent polynomial.
On realizable labels under the original marginal $P$, this immediately gives
weak error at most $1/2-\gamma_P(s)$. The target would follow if this weak
advantage could be boosted to arbitrary $\varepsilon$ while keeping the final
resource bound polynomial in $(s,1/\varepsilon,\log(1/\delta))$ with a
polynomial depending only on $P$.

The useful way to phrase the missing positive ingredient is an envelope. For
$B\ge 1$, define informally

$$
\Gamma_P(B,s)=\inf\{\gamma_Q(s): Q\ll P,\ dQ/dP\le B\}.
$$

A smooth realizable booster whose induced marginals always satisfy
$dQ_t/dP\le \operatorname{poly}(s,1/\varepsilon)$ would be polynomial-time under
the atlas target if, for every original $P$,

$$
\Gamma_P(B,s)\ge 1/r_P(s,B)
$$

for some $P$-dependent polynomial $r_P$. Then the usual
$O(\Gamma_P^{-2}\log(1/\varepsilon))$ boosting dependence could be absorbed into
the target polynomial. I do not see a way to derive this envelope from the
source definition: it assigns a polynomial/gap to each marginal separately, with
no local uniformity over even bounded-density perturbations of a fixed $P$.

### Same-Marginal Relabeling Still Has a Hard Floor

I rechecked whether the agnostic source can avoid the envelope problem by
simulating reweighted examples through randomized labels while keeping
$X\sim P$. Use $\{\pm1\}$ labels and let the realizable target be $c$. If a
same-marginal call uses conditional label expectation

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1,
$$

then $c$ has error $(1-\mathbb E_P a)/2$, and the source guarantee with
$\beta_P=1/2-\gamma_P$ gives

$$
\mathbb E_P[a(X)\mathbf 1\{h(X)\ne c(X)\}]\le \beta_P.
$$

If $a=\lambda\,dQ/dP$, this implies

$$
\operatorname{err}_Q(h,c)\le \beta_P/\lambda.
$$

Thus the call is a weak learner under $Q$ only when $\lambda>2\beta_P$. Since
$a\le1$, the largest possible $\lambda$ is $1/\|dQ/dP\|_\infty$. For
$\beta_P$ close to $1/2$, this only handles density ratios
$\|dQ/dP\|_\infty<1/(2\beta_P)=1/(1-2\gamma_P)$, essentially no focusing at all.
So the agnostic power preserves the original marginal, but the fixed-additive
slack is too coarse to simulate the residual reweightings needed for strong
realizable accuracy.

### Why the Counterexample Route Is Still Not Atlas-Ready

The tempting false witness is a rare-hard-slice construction. Under a fixed
mixture marginal $P=\sum_n\mu_nP_n$, make slice $n$ computationally hard to
learn strongly, but choose $\mu_n$ small enough that a weak learner can ignore
that slice and still get a nontrivial edge. This matches the envelope failure:
boosting toward accuracy below $\mu_n$ would eventually expose a hard reweighted
marginal close to $P_n$.

The obstruction is the source quantifier over every marginal. If $P_n$ itself is
a hard marginal, the source must still weakly agnostically learn there with
inverse-polynomial advantage. PRF-style or noisy-parity-style hard slices are
therefore source-negative, not just target-negative. Adding weak handles repairs
some proper-learning separations, as in the one-way image-coordinate weak-handle
witness, but it has not yielded this improper separation: polynomial-size slices
become strongly learnable by improper memorization, while exponentially large
slices make singleton/heavy-atom handles give exponentially small advantage
under near-uniform hard marginals. The known image-coordinate constructions also
separate proper representation recovery; their improper sparse-table learner is
already strong enough for the target.

So the plausible counterexample would need a much more delicate class:

1. for every marginal, even those concentrated on a hard slice, there is an
   efficient weak agnostic improper learner with inverse-polynomial advantage;
2. under one mixture marginal $P$, any strong improper learner to accuracy
   below a slice mass must solve a hard task;
3. the hard task cannot be bypassed by memorizing a polynomial-size active slice
   or by outputting the weak handles themselves.

I do not know such a witness, and the existing atlas witnesses do not meet these
three requirements.

### Proposed Atlas Update

No status change is justified. I would keep the edge open with the same
`family: marginal-boosting-open`. A sharper summary/body could say:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: the source specializes to weak realizable learning, but boosting would need one original-marginal polynomial controlling weak advantages on smooth reweightings of that marginal; same-marginal agnostic relabeling has a fixed-additive error floor, and no improper counterexample is currently known."
```

### Depth 3 Directions

1. Prove or refute the smooth-envelope lemma above. It is enough to restrict to
   the bounded-density marginals generated by a concrete smooth booster. A
   positive polynomial lower bound $\Gamma_P(B,s)\ge 1/r_P(s,B)$ would likely
   resolve the edge true.

2. Formalize a black-box barrier for same-marginal reductions using only an
   `OPT + beta_P` oracle. The calculation above suggests such reductions cannot
   extract a weak edge from regions whose effective mass is below $2\beta_P$,
   but this is only a barrier to a proof technique, not a false edge.

3. Search for an improper rare-slice witness satisfying the three requirements
   above. The hard part must be weakly agnostically learnable under its own
   marginal, so plain PRF/noisy-parity hardness is the wrong ingredient unless
   combined with a non-boostable weak-handle mechanism.

4. Recheck fully polynomial fixed-additive agnostic boosting results. A
   marginal-preserving booster with runtime polynomial in
   $(1/\gamma_P,1/\varepsilon)$ and no threshold condition
   $\alpha>\beta_P$ would bypass reweighted marginals and resolve the edge true.

verdict: unresolved-open

confidence: 0.84

## Depth 3 Attempt: Smooth Envelopes and Improper Rare Slices

- depth: 3
- date: 2026-05-05

### What a Smooth-Envelope Lemma Would Have to Say

The bounded-density route needs more than the pointwise source quantifier. A
meaningful version cannot use the arbitrary certified gap written into the
definition, since any valid certificate can be weakened by replacing
$\gamma_Q(s)$ with a smaller inverse polynomial. It has to use either the best
gap delivered by the fixed source learner $A$, or the best efficiently
achievable weak gap for the class under $Q$.

Even with that repair, the desired envelope is a uniform rate statement:

$$
\forall P\ \exists r_P\ \forall B\ \forall Q\ll P,\quad
\|dQ/dP\|_\infty\le B
\Longrightarrow
\gamma_Q(s)\ge 1/r_P(s,B).
$$

The source only gives the pointwise statement

$$
\forall Q\ \exists r_Q\quad \gamma_Q(s)\ge 1/r_Q(s).
$$

There is no formal implication from the second statement to the first. The
missing step is not ordinary compactness. For a fixed size slice and a fixed
resource bound, compactness of a bounded-density family might give a positive
minimum gap. It does not give one polynomial in $s$ and $B$; the exponents of
the per-marginal polynomials can drift through the bounded-density
neighborhood.

A diagnostic diagonal pattern is:

$$
\gamma_{Q_j}(s)\asymp s^{-j},\qquad Q_j\ll P,\qquad
\|dQ_j/dP\|_\infty\le 2.
$$

Each $Q_j$ has a legitimate marginal-dependent inverse-polynomial gap, but no
single polynomial in $s$ lower-bounds all the gaps. This refutes the
black-box inference from the source definition to the smooth-envelope lemma.
It is not yet an atlas counterexample, because the pattern still has to be
realized by one concrete concept class and one uniform learner, with the
$Q_j$'s arising from actual realizable boosting transcripts rather than being
assigned by hand.

### Bounded Density Does Not Remove the Rare-Slice Problem

Smooth boosting only limits how much a residual region can be upweighted. A
cap $dQ/dP\le B$ still permits focusing on any region of $P$-mass about
$1/B$. Thus a fixed marginal can contain slices $S_j$ with masses
$\mu_j\approx 1/B_j$, where the weak gap available after focusing on $S_j$ is
only $s^{-j}$.

To learn below error $\mu_j$, any realizable booster must either obtain useful
weak hypotheses on a distribution close to the slice marginal or exploit a
same-marginal substitute. The depth-2 relabeling calculation rules out the
naive same-marginal substitute once the effective density ratio exceeds
$1/(2\beta_P)$; for $\beta_P=1/2-\gamma_P$ this is essentially
$1+O(\gamma_P)$. Standard smooth boosters need density ratios growing with
$1/\varepsilon$, so the relabeling floor and the envelope gap are the same
obstruction seen from two sides.

This gives a useful negative statement about proof strategy: bounded-density
smoothness alone is too weak to derive the target from the atlas source. A
positive proof would need an additional stability property of the weak learner
or a fully polynomial marginal-preserving agnostic booster whose oracle
condition is stronger than the fixed-additive `OPT + beta_P` guarantee.

### Rare-Slice Witness Attempt

I also tried to turn the diagonal pattern into a source-positive,
target-negative improper witness. The natural construction would pack hard
slices into

$$
P=\sum_j \mu_j P_j
$$

and choose $\varepsilon<\mu_j$ so that the target learner has to solve slice
$j$. The weak source would ignore or weakly handle that slice until boosting
forces attention onto it.

The same three requirements from depth 2 remain binding:

1. Under every marginal concentrated on a slice, the class must still have an
   efficient weak agnostic improper learner with inverse-polynomial advantage.

2. Under the mixture marginal, strong improper realizable learning below the
   slice mass must require solving a hard task.

3. The hard task must not be bypassable by polynomial-time memorization,
   outputting the weak handle, or aggregating many improper weak handles.

The existing witness families fail one of these conditions. PRF, noisy-parity,
and LPN-style hard cores threaten the weak source when the marginal is
concentrated on the hard slice. PCP active-slice and lookup-table witnesses
usually make improper learning easy once the active slice has polynomial
support. One-way image-coordinate witnesses produce strong proper hardness,
but the sparse improper table learner already defeats the improper target.
Adding weak handles helps for proper-output separations, but here the target
is improper, so any efficiently found handle is also available to the final
learner.

The missing false witness would need "nonboostable weak handles": finding one
nontrivial handle is easy under every marginal, but finding enough handles to
drive error below a selected slice mass is computationally hard even for
improper output. I do not know a standard construction with that shape.

### Proposed Atlas Posture

No status change is justified. The sharpest safe update would keep
`status: "open"` and `family: marginal-boosting-open`, with the depth-2
summary strengthened by the point that the smooth-envelope lemma is not a
consequence of the source quantifiers alone:

```yaml
summary: "Open: the source specializes to weak realizable learning, but boosting would need one original-marginal polynomial controlling weak advantages on smooth reweightings of that marginal. Such a smooth-envelope bound is not implied by the pointwise marginal-nonuniform source definition; same-marginal relabeling has a fixed-additive floor, and no improper rare-slice witness is currently known."
```

### Depth 4 Directions

1. Formalize the diagonal rate obstruction as a black-box or oracle model:
   construct bounded-density marginals $Q_j\ll P$ with best weak gaps
   $\gamma_{Q_j}(s)\asymp s^{-j}$. This would refute the envelope proof
   principle, though not the atlas edge.

2. Fix one concrete smooth booster and characterize which capped slice
   marginals can actually appear as transcripts on realizable data. A false
   witness must make the hard $Q_j$'s transcript-realizable, not merely
   bounded-density perturbations of $P$.

3. Search specifically for computational weak-handle hardness: an improper
   class where one weak handle is efficiently findable for every marginal, but
   producing a low-error aggregation of handles under a fixed mixture marginal
   solves a standard hard search problem.

4. Identify restricted positive theorems. The edge should become true under an
   explicit bounded-density stability condition for the source learner, under
   effective finite-support/ERM assumptions, or under a fully polynomial
   same-marginal agnostic booster for fixed-additive weak learners.

verdict: unresolved-open

confidence: 0.86

## Depth 4 Attempt: Booster-Generated Envelopes and Rare-Slice Schemas

- depth: 4
- date: 2026-05-05

### A Narrow Smooth-Envelope Theorem That Is True but Too Narrow

I tried to isolate the smallest positive statement that follows from the source
without adding a genuine stability assumption. The following version is valid:

**Finite-template envelope.** Fix the original marginal $P$, a finite family
$\mathcal F=\{F_1,\ldots,F_N\}$ of measurable density maps, and a weak source
learner $A$. Suppose every booster call has marginal

$$
Q_i(dx)=F_i(x)P(dx),\qquad 0\le F_i\le B,\quad E_PF_i=1.
$$

For each $i$, the source gives an inverse-polynomial weak gap
$\gamma_{Q_i}(s)\ge 1/r_i(s)$. Therefore

$$
\min_i\gamma_{Q_i}(s)\ge 1/\max_i r_i(s),
$$

and the finite family is controlled by one $P,\mathcal F$-dependent polynomial.
If a booster were known in advance to use only this fixed finite template
family, standard weak-to-strong analysis would keep a polynomial round bound.

This does not resolve the edge. A realizable booster's marginals are not a
fixed finite family depending only on $P$. They depend on the target concept,
the weak hypotheses returned so far, validation randomness, and the requested
accuracy. For each target and each finite accuracy level there are only
finitely many actual calls, but taking a maximum over those calls gives a
polynomial that depends on the target/transcript/accuracy path. The target node
allows dependence on $P$ only, not on $c$ or on the particular sequence of
reweightings.

The same proof gives a slightly more general but still non-atlas theorem:
if one can supply, as an extra hypothesis, a $P$-dependent countable cover of
all booster-generated density paths such that the per-cover gaps are dominated
by a single polynomial $r_P(s,1/\varepsilon)$, then boosting works. This is just
the smooth-envelope condition in cover language; it is not a consequence of
pointwise marginal-nonuniformity.

### Why Booster-Generated Marginals Still Can Encode Rare Slices

The bounded-density cap of a smooth booster does not prevent rare-slice
focusing; it only delays it. If a slice $S_j$ has $P(S_j)=\mu_j$ and the booster
is allowed densities up to $B\ge 1/\mu_j$, then the slice marginal

$$
P(\cdot\mid S_j)
$$

is a valid bounded-density perturbation. Even when the booster never jumps
directly to the exact conditional marginal, its weight update can make the
normalized density essentially supported on the current residual set. Thus any
counterexample only needs the hard slice to become the residual set for some
realizable target. Bounded-density smoothness changes the required accuracy
scale from "below $\mu_j$" to "below about $1/B$"; it does not remove the need
for an envelope over the family of possible slices.

This gives a restricted positive theorem in the opposite direction:

**Transcript-restricted theorem.** For a fixed smooth booster, the edge is true
for any class/source pair satisfying the following extra condition. For every
original marginal $P$ there is a polynomial $r_P$ such that, for every target
$c$, every accuracy $\varepsilon$, and every marginal $Q_t$ that can appear in
the booster's transcript before its validation error falls below $\varepsilon$,

$$
\gamma_{Q_t}(s)\ge 1/r_P(s,1/\varepsilon).
$$

Then the usual dependence on $\sum_t\gamma_{Q_t}^2$ is polynomial in
$(s,1/\varepsilon,\log(1/\delta))$ with a polynomial depending only on $P$.
This is a clean sufficient condition, but it is an assumption, not a theorem
from the source node.

### Rare-Slice Witness Schema and the New Failure Point

The most concrete false-witness schema I can formulate is a direct-sum of
slice classes:

$$
\mathcal X_s=\bigsqcup_{j\ge 1}\{j\}\times X_{s,j},\qquad
P=\sum_{j\ge 1}\mu_j P_j.
$$

The desired local behavior on slice $j$ would be:

1. Under $P_j$, there is an efficient weak agnostic improper learner with gap
   about $s^{-j}$.

2. Under $P_j$, every strong improper realizable learner with error below a
   fixed constant needs time at least $s^{\Omega(j)}$ or solves a standard hard
   search problem.

3. Under the mixture $P$, weak learning can ignore all sufficiently small
   tail slices and still obtain some inverse-polynomial advantage depending
   only on $P$.

If this existed with, say, $\mu_j\asymp 2^{-j}$, then the marginal-nonuniform
target under $P$ would be in trouble. Asking for
$\varepsilon\ll\mu_j$ would force the learner to solve slice $j$, while a
single polynomial $q_P(s,1/\varepsilon)$ cannot absorb a cost like $s^j$ as
$j$ grows with $\log(1/\varepsilon)$.

The obstruction is now sharper than in depth 3. The local slice lower bound
must be against **improper** learners, but the local slice must also remain
weakly agnostically learnable under its own marginal. Standard hard cores such
as PRFs, LPN, or random labelings give the lower bound but destroy the weak
source. Standard weak-handle repairs give the source, but then the final
improper learner can aggregate the same handles. Proper-output witnesses avoid
this by forcing recovery of a valid representation; that escape hatch is not
available here because the target may output any efficient predictor.

There is also a uniform-algorithm runtime trap. A local learner whose running
time is $s^j$ on slice $j$ is acceptable for the fixed marginal $P_j$, since
the polynomial attached to $P_j$ may have exponent $j$. But the same algorithm
cannot simply run for $s^j$ whenever a rare sample from slice $j$ appears under
the mixture $P$, because the atlas convention treats the source learner as one
uniform algorithm with pathwise polynomial resource bounds for each marginal.
So a source-positive rare-slice construction likely needs cheap weak handles
whose **advantage**, not running time, deteriorates with $j$.

### Why the Cheap-Handle Repair Still Falls Short

A tempting repair is to give every slice $j$ an efficiently findable handle
with correlation $s^{-j}$ and hide the remaining labels behind a hard function.
This makes weak learning under $P_j$ plausible with a gap $s^{-j}$ and cheap
runtime. However, for a realizable strong learner under the mixture $P$, two
bad things can happen:

1. If the handle is explicit enough for the weak learner to find under every
   marginal, an improper strong learner can usually call the same handle finder
   repeatedly on residual distributions and vote. The only obstruction is the
   deteriorating gap, which is exactly the open envelope problem rather than a
   concrete hardness proof.

2. If finding many independent handles is made computationally hard, then it
   becomes hard to prove the weak agnostic source for arbitrary marginals
   concentrated on parts of the slice where the first handle has negligible
   correlation.

Thus the needed object is not merely a hard slice plus an easy weak handle. It
is a "nonboostable weak-handle" family: one handle is efficiently findable for
every marginal, the handle advantage can be inverse-polynomial with a
slice-dependent exponent, but producing enough independent handles for
low-error improper prediction is computationally hard. I do not know a standard
PAC witness with these three properties.

### Depth 5 Directions and Obstacles

1. Try to build a relativized rare-slice witness first. An oracle could enforce
   that slice $j$ has cheap weak advantage $s^{-j}$ but requires $s^{\Omega(j)}$
   adaptive oracle queries for strong improper prediction. This would not be
   atlas-ready, but it would test whether the schema is internally consistent.

2. Search for cryptographic direct-product or hard-core-set statements where
   finding one weakly correlated predictor is easy but finding a low-error
   aggregate is hard even with arbitrary improper output. The obstacle is that
   ordinary hard-core results usually power positive boosting algorithms rather
   than nonboostability.

3. Characterize transcript-realizable residual sets for one specific smooth
   booster. A rare-slice witness only needs to plant hard slices among those
   residuals; arbitrary bounded-density marginals are too broad.

4. Look for a positive theorem under a named stability assumption:
   KL-stability, bounded-density stability, or a computable cover of
   booster-generated marginals with one $P$-dependent polynomial envelope. This
   would give an atlas-ready conditional theorem, even if the unconditional edge
   stays open.

5. Revisit whether the atlas runtime convention could be weakened from
   pathwise to high-probability. Under high-probability running time, the
   rare-slice direct-sum schema becomes easier to make source-positive, because
   a learner may spend $s^j$ only when the empirical evidence says slice $j$ is
   not rare. Under the current pathwise convention, that move is blocked.

verdict: unresolved-open

confidence: 0.87

## Depth 5 Attempt: Diagonal Envelopes and the Source-Positive Slice Trap

- depth: 5
- date: 2026-05-05
- worker note: appended only to this scratchpad; no atlas files edited.

### A Countable Diagonal Envelope That Would Prove the Edge Under a Stronger Convention

Depth 4's finite-template envelope has one obvious attempted extension. Instead
of a fixed finite list of densities $F_i$, consider a countable list of
transcript templates indexed by representation size and target:

$$
\mathcal T=\{Q_{s,k}: s\ge 1,\ k\ge 1\},
$$

where each $Q_{s,k}$ is a marginal that can appear as a booster call at size
$s$ before reaching some requested accuracy. If the atlas source forced one
inverse-polynomial lower bound over every such countable transcript family,
then standard realizable boosting would go through. The proof would be a
diagonal contradiction:

1. Suppose no $P$-dependent polynomial envelope controls the transcript
   family.
2. Then for each degree $d$ choose a size $s_d$ and transcript marginal
   $Q_{s_d,k_d}$ on which the source learner's realizable weak advantage is
   smaller than $s_d^{-d}$.
3. Form a diagonal marginal $Q^\dagger$ whose size-$s_d$ conditional marginal
   is $Q_{s_d,k_d}$.
4. The source guarantee for $Q^\dagger$ gives some polynomial
   $r_{Q^\dagger}(s)\le C s^D$.
5. For $d>D$ and $s_d$ large, the required weak advantage under the
   $s_d$-slice of $Q^\dagger$ contradicts the choice of $Q_{s_d,k_d}$.

Under a size-conditional reading of marginal-nonuniform PAC learning, this
would be enough: the finite-template theorem would upgrade to a countable
diagonal-template theorem, and the edge would be `resolved-true`. The hidden
weak gaps would no longer be an obstacle, because any super-polynomial drift
over booster-generated marginals could be stitched into one bad marginal and
would violate the source itself.

I do not think this is atlas-ready as an unconditional proof. The current notes
use full-support marginals to uniformize **pathwise resource bounds**, but they
are careful not to transfer accuracy from a global full-support mixture to its
low-mass conditionals. If one realizes the diagonal object as a single
probability distribution over all finite encoded slices, each bad slice must
receive some weight $w_d$. Weak PAC accuracy is a global statement. A learner
can perform badly on the $d$-th conditional slice while still satisfying the
global weak guarantee whenever $w_d$ is below the hidden gap scale. Thus the
diagonal proof needs an extra convention: either risks are evaluated
conditioned on the active size slice, or marginal-nonuniform rates are attached
to size-indexed marginal families rather than to one weighted global mixture.
Without making that convention explicit, the argument is a near-proof, not a
proof.

### Why This Makes the Rare-Slice Witness Harder, Not Easier

The same diagonal calculation creates a sharper obstruction for a false
witness. A rare-slice construction wants slices $S_j$ such that:

$$
P=\sum_j \mu_j P_j,
$$

weak learning under the mixture can ignore small $S_j$'s, but strong
realizable learning to $\varepsilon\ll\mu_j$ must solve the hard task on
$S_j$. Depth 4 proposed letting the weak advantage on slice $j$ be about
$s^{-j}$ while the strong improper cost is $s^{\Omega(j)}$.

That cannot be the whole story if arbitrary marginals may concentrate on the
slice. The source must also hold for the marginal $P_j$ itself, and for any
diagonal marginal that chooses slice indices $j=j(s)$ across sizes. If the
only available weak advantage on such a marginal is $s^{-j(s)}$, then choosing
$j(s)=s$ gives a super-polynomially small gap and violates the source. So a
source-positive rare-slice witness cannot merely hide worse and worse weak
advantages in rarer and rarer blocks.

This rules out the simplest rate-diagonal witness. The hard slice must instead
have the following stronger local behavior:

1. When a marginal is concentrated on the slice, there is still a cheap weak
   agnostic learner with an inverse-polynomial gap whose exponent does not
   grow along legal size-diagonal marginals.
2. Nevertheless, under the original mixture $P$, driving error below the slice
   mass requires super-polynomial work in $(s,1/\varepsilon)$ for every
   improper learner.
3. Repeatedly calling the same weak learner on residual or reweighted
   conditionals must not yield a polynomial-time aggregation.

This is a more severe "nonboostable weak-handle" requirement than depth 4's
version. It is not enough for one handle to have tiny slice-dependent
correlation. The handle source must remain genuinely inverse-polynomial under
every marginal that can isolate the hard block, while the family of handles
must still resist arbitrary improper aggregation.

### A Failed Cheap-Handle Direct-Sum Instantiation

I tried the following abstract direct-sum shape as a sanity check. On slice
$j$, let every target be determined by many locally findable handles
$g_{j,1},g_{j,2},\ldots$, each with correlation at least
$1/\operatorname{poly}(s,j)$ under any residual marginal on the slice. Then the
source is plausible even for marginals concentrated on the slice: run the
handle finder and validate.

But this no longer blocks the target. Since the final learner is improper, it
can run the same handle finder on boosted or residual distributions and output
a vote or a table of handles. If the gap is $1/\operatorname{poly}(s,j)$ and
the slice index $j$ is visible in the examples or bounded by a polynomial in
the representation size, ordinary boosting costs only
$\operatorname{poly}(s,j,\log(1/\varepsilon))$. If $j$ is instead allowed to
grow like $\log(1/\varepsilon)$ under the mixture, this is still polynomial in
$1/\varepsilon$ unless the handle-finding or aggregation cost is something
like $s^j$ or worse. But putting $s^j$ into the local weak learner violates
the source for marginals concentrated on large-$j$ slices; putting it only into
the strong aggregation step is exactly the missing nonboostability assumption.

So the direct-sum recipe collapses in one of two ways:

- cheap, polynomial-gap handles are boostable by an improper learner; or
- handles with unbounded slice-dependent cost/gap make the all-marginals
  weak agnostic source fail.

This does not prove the edge true, because it is only an attack on one witness
template. It does explain why the improper target is much harder to separate
than the proper weak-handle edges: any handle strong enough to certify the
source under isolated marginals is also available as an improper prediction
primitive for the final learner.

### Current State

I do not have a resolved theorem or an atlas-ready counterexample.

The positive side has a precise conditional theorem:

> If the marginal-nonuniform source is interpreted size-conditionally, or if
> one can otherwise diagonalize countable booster-generated marginals without
> losing accuracy into low-mass slices, then the finite-template envelope
> extends to the needed transcript envelope and the edge should be true.

The negative side now has a sharper necessary condition:

> A rare-slice/improper witness must not rely on weak advantages or weak
> runtimes that deteriorate with the slice index along marginal-selectable
> size diagonals. It needs a genuinely local polynomial weak agnostic learner
> for every isolated hard slice, plus a separate hardness statement saying
> that polynomially many such local weak handles cannot be aggregated into a
> low-error improper predictor.

I do not know a standard construction satisfying that second condition. It
looks closer to an adaptive oracle or direct-product lower bound for weak
handle aggregation than to the existing one-way image-coordinate, PCP
active-slice, PRF, LPN, or lookup-table witnesses.

### Final Depth-6 Directions and Obstacles

1. **Pin down the size-conditioning convention.** Decide whether a marginal in
   these notes is formally a size-indexed family with accuracy evaluated on
   each active size slice, or a single weighted distribution over all finite
   encodings. Under the former, the countable diagonal envelope above is a
   plausible route to `resolved-true`; under the latter, low-mass slices remain
   an accuracy leak.

2. **Prove a transcript-diagonal lemma if allowed.** Formalize the object
   $\Gamma_A(Q,s)$ as the best realizable weak advantage of the fixed source
   learner on marginal $Q$. Show that super-polynomial decay over
   booster-generated transcript marginals can be stitched into one source
   violation. The delicate point is preserving conditional rather than global
   error.

3. **Make nonboostable handles computational, not quantitative.** A false
   witness cannot just assign gap $s^{-j}$ to slice $j$. It needs weak handles
   that are easy enough for the source under every isolated marginal, while
   finding enough independent handles for low-error improper prediction is
   hard. This likely needs an oracle or cryptographic direct-product statement
   tailored to adaptive residual queries.

4. **Test a relativized version first.** Build an oracle class where every
   marginal has a polynomial-gap weak handle, but any algorithm that obtains
   error below the $j$-th slice mass must make super-polynomially many adaptive
   handle queries. If even the oracle version fails because adaptive boosting
   recovers enough handles, that is evidence for the true edge.

5. **Separate global-mixture weakness from conditional weakness.** Any future
   rare-slice witness should explicitly verify the source for marginals
   conditioned on the hard slice and on residual subsets of that slice. If the
   proof only shows weak performance under the original mixture, it is not
   source-positive for this edge.

verdict: unresolved-open

confidence: 0.89

## Depth 6 Final Attempt: Conditional Diagonalization, Rare Slices, and Final Open Posture

- depth: 6
- date: 2026-05-05
- worker note: final allowed depth; appended only to this scratchpad; no atlas files edited.

### Executive Verdict

I do not see an atlas-ready proof of the implication, and I do not see an
atlas-ready counterexample. The edge should remain `open`.

The final serious attempt sharpened the two live routes:

1. A `resolved-true` proof is very close if marginal-nonuniform accuracy is
   interpreted size-conditionally, or if one assumes a transcript-envelope
   lemma for booster-generated marginals. Under the current atlas wording, the
   diagonal proof loses conditional accuracy into low-mass slices.

2. A `resolved-false` proof would need a rare-slice or direct-sum witness whose
   weak agnostic source remains valid under marginals that isolate the hard
   slices. The usual quantitative trick "slice $j$ has weak gap $s^{-j}$" is
   not source-positive once marginals can isolate or diagonalize over slices.
   Cheap weak handles, on the other hand, are normally boostable by an improper
   learner.

So the remaining obstruction is not just bookkeeping. It is the missing theorem
or witness at exactly the boundary between:

$$
\text{pointwise marginal weak advantages}
$$

and

$$
\text{one original-marginal polynomial controlling all residual/reweighted calls.}
$$

### Final Positive Attempt

The source learner $A$ specializes on realizable labels to a weak learner: for
each marginal $Q$ there is a $Q$-dependent inverse-polynomial gap
$\gamma_Q(s)$ such that

$$
\operatorname{err}_{Q}(A,c)\le 1/2-\gamma_Q(s)
$$

for every target $c\in\mathcal C$. A standard realizable booster would prove
the target if, for each original marginal $P$, every booster-call marginal
$Q_t$ before final error $\varepsilon$ satisfied one envelope

$$
\gamma_{Q_t}(s)\ge 1/r_P(s,1/\varepsilon)
$$

for a polynomial $r_P$ depending only on $P$. Smooth boosting reduces the
family of possible $Q_t$'s to bounded-density perturbations of $P$, but the
source definition is still only pointwise in $Q_t$.

Depth 5 suggested a countable diagonal proof. I rechecked whether that proof
can be repaired without changing semantics. The tempting argument is:

1. If no envelope exists, choose booster-generated marginals $Q_d$ at sizes
   $s_d$ with weak gaps smaller than $s_d^{-d}$.
2. Stitch the $Q_d$'s into one diagonal marginal $R$ across the size slices.
3. Apply the source guarantee to $R$ to get one polynomial weak gap, contradicting
   the chosen $Q_d$'s.

This works under a size-conditional reading: if risk at size $s_d$ is evaluated
conditioned on the active size slice, then $R$ forces a single polynomial
envelope over the countable family. Under that convention, the edge should be
`resolved-true` by combining:

- the transcript-diagonal envelope;
- a smooth realizable booster;
- dovetailing over hidden gap/sample-budget guesses;
- holdout validation of the finite candidate list.

But under the current global-mixture reading, the proof still leaks. If the
diagonal slice has mass $w_d<1/2$, a weak learner under $R$ can ignore that
slice entirely and still have global realizable error at most $w_d$, which is
already below the allowed weak threshold $1/2-\gamma_R(s_d)$ for all large
enough $d$ unless $w_d$ is nearly constant. Since infinitely many slices cannot
all have constant mass, the global weak source for $R$ does not force the
learner to have a weak edge on every conditional $Q_d$.

This is stronger than the earlier "low mass below the hidden gap" objection.
For weak learning, low mass below the constant $1/2$ threshold can already be
invisible. The diagonal proof therefore genuinely needs a size-conditional
accuracy convention, or an additional theorem saying booster-call conditionals
inherit weak accuracy from some global marginal source.

The same-marginal agnostic route remains a near miss. Feldman-style
distribution-specific agnostic boosting preserves the instance marginal by
changing labels, and Ghai-Singh's unlabeled-data booster is also naturally
distribution-specific. However those theorems require threshold/correlation
weak oracles with tunable additive slack. The atlas source supplies only

$$
\operatorname{err}(h)\le \operatorname{OPT}+1/2-\gamma_P(s),
$$

or, in correlation form, an additive slack close to $1$. The fixed slack can be
searched for, but it cannot be shrunk to the final $\varepsilon$ scale. The
da-Cunha-Hogsgaard-Paudice nontrivial-gap line is conceptually closer, but the
known runtime places weak-learner/sample/capacity parameters in an exponent;
when $1/\gamma_P(s)$ is itself polynomial in $s$, that is not an
atlas-polynomial bound.

### Final Negative Attempt

The best false-witness template is still a rare-slice direct sum. One would
like a fixed marginal

$$
P=\sum_j\mu_jP_j
$$

such that weak learning under $P$ can ignore small or hard slices, but strong
learning to $\varepsilon\ll\mu_j$ must solve slice $j$. The obstacle is the
source quantifier over **all** marginals.

If a marginal can isolate slice $j$, then the source must weakly agnostically
learn that isolated slice with an inverse-polynomial gap. Moreover, if a
legal marginal can diagonalize over the hard slices as $j=j(s)$, then weak
advantages or weak runtimes that behave like $s^{-j}$ or $s^j$ violate the
source. Thus a source-positive false witness cannot merely hide worse weak
parameters in rarer blocks.

I tried the remaining natural repair: give every hard slice a cheap weak
handle. The desired behavior would be:

1. for every isolated slice and every residual marginal on that slice, an
   efficient weak agnostic improper learner finds a handle with polynomial gap;
2. for the fixed mixture $P$, driving error below $\mu_j$ requires aggregating
   many handles from slice $j$;
3. finding enough handles is computationally hard even for arbitrary improper
   output.

This is exactly where the known witness families fail:

- PRF, noisy-parity, and LPN-style hard cores usually make even weak prediction
  hard on an isolated slice, so they threaten the source.
- PCP active-slice and lookup-table constructions become easy for improper
  learners once the active domain is polynomial-size.
- One-way image-coordinate witnesses force proper representation recovery, but
  the present target is improper; sparse-table or coordinate-output predictors
  defeat the strong improper lower bound.
- Cheap handles that are robust enough to certify the source under every
  isolated residual marginal are also available to the final improper learner,
  which can call the same handle finder on boosted/residual distributions and
  vote.

So a false witness would need "computationally nonboostable handles": one weak
handle is easy under every marginal, but any low-error improper aggregation is
hard. I do not know a standard PAC, cryptographic, PCP, halfspace, or lookup
construction with this exact property.

### Atlas-Ready Open Summary

Keep the edge open.

Suggested frontmatter posture:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
summary: "Open: the source gives weak realizable learning under each marginal, but known boosting routes either need a single original-marginal envelope over booster-induced marginals or a stronger tunable same-marginal agnostic oracle. Countable diagonalization would prove the envelope under size-conditional semantics, while rare-slice counterexamples must survive marginals isolating the hard slices; no theorem or improper witness is currently known."
```

Suggested body text:

```markdown
The source specializes to weak realizable improper learning under every
marginal. Standard realizable boosting would prove the target if, for each
original marginal $P$, the weak advantages on all booster-induced marginals
were bounded below by one $P$-dependent inverse polynomial. The source gives
only pointwise marginal guarantees.

The agnostic nature of the source is a near miss. Distribution-specific
agnostic boosting can preserve the instance marginal by relabeling examples,
but the available Feldman/Ghai-style theorems require threshold or correlation
weak oracles with tunable additive slack. The atlas source only gives the fixed
additive tolerance $\operatorname{OPT}+1/2-\gamma_P(s)$, which has a floor too
large to drive realizable error to arbitrary $\varepsilon$ by same-marginal
relabeling.

A countable diagonal envelope would resolve the edge true under a
size-conditional interpretation of marginal-nonuniform accuracy: any
super-polynomial drift of weak advantages over booster transcripts could be
stitched into one bad marginal. Under the current global-mixture reading, weak
accuracy can ignore low-mass slices, so this diagonalization is not yet a
proof.

Conversely, no concrete false witness is known. Rare-slice constructions must
verify the source not only under the original mixture but also under marginals
that isolate the hard slices. Quantitative weak gaps that deteriorate with the
slice index fail this test, while cheap weak handles tend to be boostable by an
improper learner.
```

### Obstacles To Record

1. **No original-marginal envelope.** The source gives
   $\forall Q\,\exists r_Q$, but boosting needs a single $r_P$ controlling all
   $Q_t$ reachable from the original $P$ before accuracy $\varepsilon$.

2. **Same-marginal relabeling has a fixed floor.** Relabeling with
   $\mathbb E[Y\mid X=x]=a(x)c(x)$ only yields
   $E_P[a1\{h\ne c\}]\le\beta_P(s)$, so it cannot simulate heavily focused
   residual distributions when $\beta_P(s)$ is close to $1/2$.

3. **Countable diagonalization needs conditional accuracy.** A global weak
   guarantee on a mixture marginal can ignore every sufficiently low-mass bad
   slice; it does not force a weak edge on the conditional slice marginal.

4. **Rare-slice witnesses must be locally source-positive.** It is not enough
   that the original mixture has an easy weak learner. The source must also
   hold for marginals concentrated on each hard slice and on residual subsets
   of that slice.

5. **Improper output makes weak handles dangerous.** Any handle finder strong
   enough to certify the weak source is also a primitive the final improper
   learner can try to boost or aggregate.

### Future Directions

1. **Clarify the marginal semantics.** If atlas marginals are really
   size-indexed families with risk evaluated per active representation-size
   slice, formalize that convention. Then the countable transcript-diagonal
   proof should be promoted to a serious `resolved-true` attempt.

2. **Prove a transcript-envelope lemma.** For one fixed smooth booster, define
   the set of all marginals reachable before validation error $\varepsilon$.
   Show, or refute, that the all-marginals source forces one
   $P$-dependent polynomial lower bound on the weak advantage over that set.

3. **Search for nonboostable weak handles.** A false witness likely needs a
   cryptographic or oracle direct-product statement where finding one weakly
   correlated predictor is easy under every residual marginal, but finding
   enough independent predictors for low-error improper prediction is hard.

4. **Build a relativized diagnostic.** An oracle construction could test
   whether source-positive, nonboostable handles are internally consistent. If
   adaptive boosting defeats even the oracle version, that would be evidence
   for a true theorem.

5. **Track fully polynomial nontrivial-gap agnostic boosting.** If a future
   version of the da-Cunha-Hogsgaard-Paudice line gives runtime polynomial in
   the weak sample size, $1/\gamma$, capacity parameters, and $1/\varepsilon$
   with same-marginal calls, the hidden marginal-dependent parameters can be
   handled by dovetailing and validation.

### References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- neighboring 2026-05-05 scratchpads for weak agnostic to strong agnostic,
  realizable to weak agnostic, and marginal/distribution-free variants.
- Feldman 2010, *Distribution-Specific Agnostic Boosting*:
  https://arxiv.org/abs/0909.2927
- Ghai and Singh 2025, *Sample-Optimal Agnostic Boosting with Unlabeled Data*:
  https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice 2026, *Sample-Near-Optimal Agnostic
  Boosting with Improved Running Time*: https://arxiv.org/abs/2601.11265
- Hanneke, Moran, and Thiessen 2025, *Marginal-Nonuniform PAC Learnability*:
  https://openreview.net/forum?id=aoVCFtox89

verdict: unresolved-open

confidence: 0.91
