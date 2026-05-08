# Edge: efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-weak-realizable-improper-pac

- depth: 1
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- target: `efficient-weak-realizable-improper-pac`
- family: `marginal-uniformization-open`
- worker constraint: scratchpad only; no atlas files edited

## Executive Verdict

I do not have an atlas-ready proof or counterexample. The edge should remain
`open`, but the reason should be sharpened.

The current edge note says the source has marginal-dependent polynomial
resource bounds while the target needs one distribution-free polynomial bound.
Under the atlas convention that computational sample use and running time are
worst-case/pathwise bounds on finite encoded transcripts, that is not the
sharp obstruction. The reusable `full-support-marginal-uniformization` argument
can make the one-call sample/time bound of the single source learner
distribution-free.

The remaining issue is the hidden weak gap. The source gives, for each marginal
`P`, a possibly different inverse-polynomial advantage

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s),
\qquad
\gamma_P(s)\ge s^{-k(P)}
$$

up to polynomial factors. The target needs one inverse-polynomial lower bound
whose exponent is independent of `P`. I found no valid argument swapping

$$
\forall P\ \exists k(P)
\quad\text{to}\quad
\exists k\ \forall P.
$$

The best false route remains a rare-block PRF construction with proper weak
handles, but for this proper-source edge it runs into a serious
orientation/validation barrier under the pathwise runtime convention.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/README.md`
- `references.bib`

Neighboring scratchpads checked:

- `efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- `efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- `efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
- `efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

Primary-source anchors checked online:

- Hanneke, Moran, and Thiessen 2025, *Marginal-Nonuniform PAC Learnability*,
  OpenReview and PDF. The paper defines marginal-nonuniform learning with the
  rate constants depending on the marginal but uniformly over concepts, and its
  trichotomy records arbitrarily slow rates in the infinite VC-eluder case.
- Benedek and Itai 1991, *Learnability with Respect to Fixed Distributions*.
  The ScienceDirect abstract records the fixed-distribution setting, finite
  cover characterization, and the fact that discrete distributions make every
  class fixed-distribution learnable, mostly at the information-theoretic
  level.
- Ben-David, Benedek, and Mansour 1995, *A Parameterization Scheme for
  Classifying Models of PAC Learnability*. The abstract confirms that the
  parameterization is about uniformity choices and is information-theoretic
  rather than computational.
- Schapire 1990 and Freund 1995 for realizable weak-to-strong boosting.
  Freund's abstract also notes an extension where the weak learner's accuracy
  depends on the instance distribution, but this still needs quantitative
  control of the distribution-dependent accuracies.
- Goldreich, Goldwasser, and Micali 1986 and Kearns-Valiant 1994 for the PRF
  hardness background. Kearns-Valiant-style learning lower bounds rule out even
  slight prediction advantage in the relevant distribution-free computational
  setting.

## Current Edge State

The edge is currently:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

The status still looks right. The summary is stale after the full-support
resource-uniformization note.

## What Does Transfer

Let `A` be the single learner promised by the source. Choose a full-support
reference marginal `P^star` over every finitely encoded instance in each size
slice. Applying the source guarantee to `P^star` supplies a polynomial
`p_{P^star}` bounding the sample use and runtime of `A`.

Every finite labeled transcript that can occur under any marginal `P` and
target `c` has positive probability under `P^star` with the same target labels
on the sampled instances. Since atlas efficiency is pathwise over finite
transcripts, `A` cannot exceed `p_{P^star}` on such a transcript. Thus the
same learner has one distribution-free polynomial resource bound.

This proves only the resource part. For accuracy on the actual marginal `P`,
we still get only

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s),
$$

where the inverse-polynomial exponent may depend on `P`.

The proper-to-improper relaxation is harmless: a proper weak output is also an
allowed improper weak output. So the assigned edge reduces exactly to weak-gap
uniformization.

## Positive Proof Attempts

### Direct Gap Uniformization

A positive proof would need to show that a single pathwise-polynomial learner
with marginal-specific weak gaps has a distribution-free inverse-polynomial
gap, perhaps after a black-box transformation. I do not see such a theorem.

Fixed-size compactness is too weak. Even if for each representation size `s`
there were a positive worst-case gap over all marginals, that minimum could be
as small as `s^{-s}` or worse. The target needs `s^{-O(1)}` with one exponent.

### Diagonal Stitching

A tempting diagonal proof is: if no uniform exponent exists, choose hard
marginals `P_d` and sizes `s_d`, then stitch them into one marginal and
contradict the source guarantee for that single marginal.

This works only under a stronger size-indexed or slice-conditional marginal
semantics. In the current global-marginal reading, the mixture can assign the
bad slice tiny mass. A weak learner may ignore a low-mass bad slice and still
beat random guessing on the mixture by an inverse-polynomial amount. Accuracy
is averaged; the full-support resource argument is pathwise. That distinction
is exactly why resource uniformization transfers but weak-gap uniformization
does not.

### Validation And Dovetailing

Validation cannot create a uniform weak gap. Distinguishing error
`1/2 - gamma` from `1/2` costs on the order of `1/gamma^2` samples. If
`gamma = s^{-k(P)}`, the validation degree is still marginal-dependent.

Dovetailing over guessed exponents likewise finds a successful run eventually,
but the first successful guess can occur at a degree depending on `P`; the
target needs one distribution-free polynomial.

### Boosting

Classical Schapire/Freund boosting is not needed for a weak target, but it is
still informative. Boosting would amplify a supplied weak advantage with
quantitative dependence on that advantage. If the advantage can be
`s^{-k(P)}` with unbounded `k(P)`, boosting does not produce one
distribution-free polynomial. For strong neighboring targets, the same issue
appears as a need for one envelope over all booster-induced marginals.

## Counterexample Search

### Plain PRF Classes

Plain PRF concept classes have the right target-hardness flavor: a
distribution-free weak learner on the hard marginal would distinguish PRF
labels from random labels.

They fail the source. The marginal concentrated on the hard PRF domain is one
of the marginals quantified over by the source, and no efficient weak learner
is available there under standard PRF assumptions.

### One-Way Image-Coordinate Weak Handles

The one-way image-coordinate weak-handle witness satisfies weak proper
learning by using constants and singleton concepts. Its lower bound is for
strong proper learning. The assigned target is weak and improper, so an
improper learner can use the same cheap sparse information; this witness does
not refute the edge.

### Rare-Block PRF With Proper Handles

The closest false route is a hierarchy of paired PRF blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=N=n^j.
$$

A hard concept labels exactly one point in each pair positive, according to a
PRF bit, and is zero off its active block. Add constants and singleton-style
proper handles to the class.

For a uniform marginal on one high block, constants have error exactly `1/2`,
and a positive singleton has advantage about `1/(2N)=n^{-j}/2`. This is
consistent with a marginal-dependent weak exponent. A distribution-free weak
target with sample/runtime degree `D` and gap exponent `a` could be attacked by
choosing `j > D+a`: it sees too few pair indices to predict unseen PRF bits
with advantage `n^{-a}`.

This captures the desired hidden-gap geometry. It is not atlas-ready for the
proper source.

The source learner must work for every marginal on the block, not just the
balanced uniform one, and it must output one deterministic proper hypothesis.
Constants are good when the positive mass `M` is far from `1/2`. Sparse
positive singletons are good near or below balance; co-singleton/default-one
handles are good near or above balance. But the learner must choose the right
default orientation when

$$
M = 1/2 \pm \Theta(1/N).
$$

Choosing that orientation by validation costs about `N^2` samples. Under the
atlas pathwise transcript convention this is forbidden for unbounded `j`: a
full-support reference marginal would make such high-block transcripts
possible, forcing one global polynomial bound.

The obstruction can also be phrased statistically. Suppose a source learner
has a pathwise sample bound `m(s)`. Pick `N >> m(s)^2` and two marginals on the
same target block with positive masses

$$
1/2+\eta
\quad\text{and}\quad
1/2-\eta,
\qquad
\eta \asymp m(s)/N.
$$

Their `m(s)`-sample transcript distributions have total variation
`O(m(s)\eta)=O(m(s)^2/N)`, so no learner can reliably choose opposite default
orientations. Yet a wrong default has error at least `1/2` after only
`O(m(s)/N)` sparse corrections.

A prediction-time randomized classifier that guesses on the unsampled region
would avoid this orientation problem, but the atlas binary PAC notes use
ordinary deterministic hypotheses. A public deterministic handle strong enough
to be orientation-free under all marginals tends either to leak the weak target
to the improper learner or to fail on adversarial marginals.

## Proposed Atlas Update If Edits Are Later Allowed

Do not change the status yet:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
summary: "Open: full-support marginal uniformization gives one pathwise sample/time polynomial for the single source learner, but the source weak advantage may still have marginal-dependent polynomial degree; no known theorem turns those hidden weak gaps into one distribution-free inverse-polynomial gap."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

Suggested body replacement:

```markdown
## Verdict

`open`.

The pathwise resource obstruction can be removed by a full-support reference
marginal. Let `A` be the single marginal-nonuniform weak proper learner and
choose a full-support reference marginal `P^star`. The source guarantee for
`P^star` gives one polynomial bound on every finite transcript that can arise
under any marginal.

The accuracy guarantee must still be applied to the actual marginal `P`.
There it gives only `err_P(h,c) <= 1/2 - gamma_P(s)`, where the
inverse-polynomial lower bound on `gamma_P` may depend on `P`. The
distribution-free weak target needs one inverse-polynomial gap independent of
`P`.

Known witnesses do not settle this edge. Plain PRF classes fail the source;
one-way weak-handle classes are target-positive improperly. Rare-block PRF
templates expose the right hidden-gap phenomenon, but for a proper source they
currently run into a near-balanced default-orientation problem whose
resolution appears to require gap-scale validation, contradicting the
pathwise resource convention.
```

## Promising Depth-2 Directions

1. Prove a weak-gap uniformization theorem under an added local-uniformity
   condition, such as bounded-density stability: for every original marginal
   `P` and polynomial density bound `B`, all `Q << P` with `dQ/dP <= B` have
   weak gaps dominated by one polynomial depending on `P` and `B`.

2. Decide whether the atlas should introduce a separate
   `weak-gap-uniformization-open` argument family. These edges are no longer
   blocked primarily by one-call resource bounds after
   `full-support-marginal-uniformization`.

3. Formalize the two-marginal orientation obstruction as a reusable lemma for
   deterministic proper sparse-handle witnesses. It explains why constants,
   singletons, co-singletons, and finite sparse corrections do not immediately
   produce source-positive rare-block counterexamples.

4. Search for an orientation-free deterministic proper handle. A successful
   false witness needs one cheap proper weak handle under every marginal while
   preventing any distribution-free improper learner from aggregating enough
   handles or predicting the hard residual.

5. Explore an oracle or randomized-hypothesis variant separately. A randomized
   default on unseen points seems to remove the orientation barrier, but that
   would be a different PAC hypothesis model unless the atlas explicitly adds
   randomized prediction rules.

6. Compare the current global-marginal semantics with a size-indexed
   slice-conditional semantics. Under the latter, a diagonal weak-gap theorem
   may become true; under the current global mixture semantics, low-mass bad
   slices can be ignored by a weak learner.

7. If the improper target lower bound is pursued using PRFs, first clarify the
   efficient-output evaluator convention. Existing atlas PRF witnesses rely on
   efficiently evaluable learned hypotheses, but the written definition notes
   do not explicitly spell this out for every improper output.

## Final

verdict: unresolved
confidence: 0.78

## Depth 2 Branch: diagonal weak-gap uniformization

### Setup

Keep the depth-1 reduction fixed. Let `A` be the single source learner. By
the full-support pathwise argument, we may treat the sample and time bound of
one call to `A` as one distribution-free polynomial `m(s)`. The only missing
target datum is a uniform inverse-polynomial weak advantage.

For this branch, write informally

$$
g_A(P,s)=\inf_{c\in\mathcal C_s}
\left(\frac12-\operatorname{err}_P(A(P,c),c)\right),
$$

with the usual PAC success probability suppressed, say fixed at `2/3`. The
source says

$$
\forall P\ \exists K(P)\ \forall s\qquad g_A(P,s)\ge s^{-K(P)}
$$

after absorbing constants and logarithmic confidence factors. The target would
need

$$
\exists K\ \forall P\ \forall s\qquad g_A(P,s)\ge s^{-K}.
$$

If the target fails for this learner, then for every `d` there are a marginal
`Q_d`, a size `s_d`, and a concept `c_d` for which the achieved weak advantage
is below about `s_d^{-d}`. The diagonal hope is to stitch the `Q_d` into one
global marginal `P`, then contradict the source guarantee for that single
`P`.

### The Size-Indexed Diagonal Would Work

There is a clean theorem under a stronger, slice-conditional semantics. Suppose
a "marginal" were a family `(P_s)_{s>=1}`, with accuracy at size `s` evaluated
under the corresponding conditional marginal `P_s`. Then the diagonal is
immediate: choose `P_{s_d}=Q_d` on the bad sizes and fill the remaining sizes
arbitrarily. For any claimed exponent `K(P)`, pick `d>K(P)`. The size
`s_d` slice violates

$$
g_A(P_{s_d},s_d)\ge s_d^{-K(P)}.
$$

So the diagonal route is not logically confused. It proves exactly the theorem
one would expect if the atlas used size-indexed marginals with per-size,
conditional error. The live question is whether this proof survives the actual
global-marginal semantics. I think it does not.

### Global Mixtures Lose The Bad Slice

Under the atlas semantics, a marginal is one distribution over the whole
instance space. If we stitch disjoint bad components as

$$
P=\sum_{i\ge 1} w_i Q_i,
\qquad \sum_i w_i=1,
$$

then for any fixed deterministic hypothesis `h` and target `c`,

$$
\frac12-\operatorname{err}_P(h,c)
=
\sum_i w_i\left(\frac12-\operatorname{err}_{Q_i}(h,c)\right).
$$

Thus badness on component `k` is only a weighted summand. Knowing that `A`
has tiny advantage on `(Q_k,c_k)` gives no upper bound on its advantage under
the global mixture for target `c_k`, for two independent reasons.

First, `A` sees a different transcript distribution under `P` than under
`Q_k`. When `w_k` is small, an `m(s_k)`-sample run usually sees no example
from the bad component at all. That is harmless for weak learning under `P`:
the learner may get its entire advantage from the complement.

Second, even if the restriction of the output to block `k` remains nearly
random, the complement can dominate the global error. In the most favorable
case for the learner, suppose the output is perfect off block `k` and random
on block `k`. Then

$$
\operatorname{err}_P(h,c_k)\approx \frac{w_k}{2},
\qquad
\frac12-\operatorname{err}_P(h,c_k)\approx \frac{1-w_k}{2}.
$$

For this global advantage to be smaller than `s_k^{-K}`, the bad block would
need

$$
1-w_k \lesssim 2s_k^{-K}.
$$

So component `k` must carry almost all of the global marginal mass, not merely
polynomially much mass. Infinitely many disjoint bad size slices cannot all
have mass `1-o(1)`. This is the core obstruction.

### Why Mass Scheduling Does Not Rescue It

A clever schedule can make `w_k` large compared with a chosen inverse
polynomial, for instance by taking `s_k` very large relative to `k`. That helps
when the goal is to sample from the component by rejection. It does not help
with weak error under the global marginal. To keep error close to `1/2`, the
easy complement must have mass smaller than the target gap itself. The
condition is not `w_k >= s_k^{-O(1)}`; it is

$$
1-w_k \le s_k^{-O(1)}.
$$

No summable disjoint schedule can satisfy this along an infinite sequence of
bad components.

Tail schedules have the same problem in another form. If `T_k` is the tail
union of all components from `k` onward, then `P(T_k)->0`. A target that is
hard only on later and later tails becomes ignorable. Prefix schedules have
large mass, but then the target would have to combine the first `k` independent
bad restrictions into one concept of controlled representation size. That is
a special closure property of a witness class, not something implied by the
source definition.

### Full Support Does Not Transfer Accuracy

Full-support marginals are powerful for resources because pathwise runtime is
tested on finite transcripts: a transcript with positive reference probability
cannot take longer than the reference marginal's polynomial bound.

There is no analogous accuracy transfer. If

$$
P^\star=\sum_i w_i Q_i + \rho R
$$

has full support, the guarantee for `P^\star` only says that `A` has some
weak advantage averaged over `P^\star`. The advantage may come from the
`R` dust or from earlier easy components. The guarantee does not imply a
comparable advantage on any conditional component `Q_i`, and conversely
badness on a conditional component does not make `P^\star` hard unless that
component has almost all the mass.

This also explains why bounded-density ideas would be an additional
assumption, not a consequence. If `Q_i << P^\star`, then typically
`dQ_i/dP^\star` is of order `1/w_i` on the component. The atlas source allows
the weak exponent for `P^\star` to depend on the entire marginal, including
these tiny weights. Nothing forces a polynomial envelope that is stable under
conditioning on a low-mass slice.

### Fixed-Size Compactness Is Too Weak

One might try to avoid mixtures by first fixing a representation size `s`.
If the relevant size slice is finite and the learner's behavior is continuous
in the marginal, then a positive gap for every marginal at that fixed size may
have a positive minimum `alpha_s`. This still does not give the target. The
sequence `alpha_s` may decay faster than every inverse polynomial.

The natural next move is to diagonalize over the near-minimizing marginals for
the bad sizes. But that is exactly the global mixture argument above: after
stitching the near-minimizers into one marginal, each bad size slice receives
only its global mass, and a weak learner can win on the complement.

### What A Successful Diagonal Would Need

To turn this into a positive theorem, one needs extra structure beyond the
current atlas semantics. Any of the following would change the situation:

1. Size-indexed marginals with per-size conditional error. Then the diagonal
   proof above works directly.

2. A slice-normalized learning requirement: when evaluating size `s`, error is
   measured after conditioning on the size-`s` slice, not under the whole
   global marginal.

3. A closure property of the class that lets one target concept of controlled
   size be simultaneously hard on a `1-o(1)` mass union of bad components.
   This would be a class-specific counterexample or theorem, not a black-box
   consequence of a single pathwise-polynomial learner.

4. A bounded-density stability axiom: weak gaps for `P` also control all
   conditionals or reweightings with polynomial density relative to `P`. The
   current source definition contains no such axiom.

Without one of these additions, the diagonal proof tries to convert
componentwise hardness into global hardness, but weak PAC error is an averaged
quantity. Low-mass bad components disappear in that average.

### Branch Verdict

verdict: unresolved for the edge; negative for the black-box diagonal route
under current atlas global-marginal semantics. A size-indexed diagonal would
prove weak-gap uniformization, but that is a different schema. Under the
actual global semantics, every stitching proof that only combines bad
marginals runs into the same mass obstruction: to make a weak learner fail
globally, the bad region must carry almost all the mass, and infinitely many
bad size slices cannot all do that in one distribution.

confidence: 0.86

next branch ideas if unresolved:

1. Formalize this as a reusable "no black-box diagonal from disjoint bad
   marginals" lemma, with the weighted-advantage identity as the proof.

2. Explore whether a bounded-density or slice-conditioned strengthening should
   be added as a separate schema node; under that strengthened semantics, the
   diagonal theorem likely becomes true.

3. Try a class-specific product or prefix construction where one concept is
   hard on a high-mass union of many bad components while still having
   controlled representation size.

4. Return to the rare-block PRF route and look specifically for an
   orientation-free deterministic proper handle, since the diagonal route does
   not remove the default-orientation barrier.

## Depth 3 Branch: overlapping-slice weak-gap witness

### Goal

This branch tests whether the depth-2 mass obstruction is an artifact of
using disjoint bad slices. The hoped-for false witness would replace disjoint
rare blocks by overlapping hard regions, nested high-mass sets, or one shared
coordinate domain. Ideally each hard marginal would put constant, even almost
all, mass on the hard part, while the source still has an efficient proper
weak learner whose advantage may be `n^{-j}` on the `j`th hard marginal.

The invariant from depth 1 remains decisive. After full-support resource
uniformization, the source learner must have one pathwise polynomial sample
and time bound. Only the weak gap may vary with the marginal. Thus a candidate
false witness must be a pure hidden-gap construction, not a construction that
spends `n^j` time on the `j`th level.

### Same Marginal Or Same High-Mass Domain

The strongest overlap idea is to use one reusable high-mass domain, perhaps
even one fixed marginal `P`, and place all hard levels on it. This would
completely avoid the disjoint-mixture problem: every bad level remains visible
with constant mass.

But this immediately collides with the source quantifiers. For a fixed
marginal `P`, the source guarantee gives one exponent `K(P)` such that the
single source learner has advantage at least `s^{-K(P)}` for every target of
size `s`. Therefore no lower bound can say that, under this same `P`, every
efficient learner fails to get advantage `s^{-a}` for arbitrarily large
`a`: once `a > K(P)`, the source learner itself is a counterexample to that
lower bound, and it is also a legal improper learner.

So a single fixed marginal cannot carry the unbounded hidden-gap hierarchy.
If the hard levels all live on the same coordinate set, the separating
marginals must still differ in an essential way, for example by reweighting
nested regions or changing which shared coordinates have high mass. The
overlap can remove literal disjointness, but it cannot remove the need for an
unbounded family of marginals.

### Nested High-Mass Sets

Nested sets are the next natural repair. Let

$$
S_1 \supseteq S_2 \supseteq \cdots
$$

and let the hard marginal `P_j` put most or all of its mass on `S_j`. Unlike a
summable disjoint mixture, each `P_j` can make its own bad region heavy. This
is compatible with a distribution-free lower bound strategy: a target learner
with claimed exponent `a` can be tested on `P_j` for `j >> a`.

The difficulty moves to the source learner. On each `P_j`, the proper source
needs a cheap deterministic weak handle. Constants handle large label
imbalance. Singleton or sparse-patch handles handle the exactly balanced case
with advantage about one atom, say `1/N_j`. The unsolved band is still the
near-balanced band:

$$
M = P_j(c^{-1}(1)) = 1/2 \pm \Theta(1/N_j).
$$

If the learner defaults to `0`, it is good on the negative side and bad on the
positive side; if it defaults to `1`, the signs reverse. A sparse positive
patch is useful only until the positive excess exceeds the patch mass, and
the co-sparse version is symmetric. Distinguishing the two sides at scale
`1/N_j` costs on the order of `N_j^2` validation samples. That violates the
pathwise polynomial bound when `j` is unbounded.

Nesting does not remove this two-marginal obstruction. For every proposed
deterministic default rule, one can make two nearby marginals on the same
nested level with positive masses `1/2 + eta` and `1/2 - eta`, where `eta` is
at the hidden atom/patch scale. Their short transcript distributions are too
close for the source learner to choose opposite orientations reliably, but a
wrong orientation loses the entire weak edge.

### Hadamard And Parity Shared-Domain Ideas

Hadamard/parity structure is attractive because it gives an orientation-free
deterministic default under the uniform marginal. If targets are parity
codewords on a common coordinate domain and the learner patches the observed
labels while using a fixed different parity as the default, the full-domain
correlation of two distinct parities cancels. The sample patch then gives a
small nonnegative advantage, roughly the sampled mass. This is the
deterministic analogue of "guess randomly off the sample", but with exact
orthogonality instead of prediction-time randomness.

This is a useful diagnostic, but it does not yield the assigned false edge.

First, ordinary parity/Hadamard targets are improperly learnable under the
uniform marginal. Labeled examples are linear equations for the parity
coefficient, so an improper learner can recover the coefficient and output the
parity. That helps properization separations, where outputting the underlying
seed may be hard, but here the target is improper.

Second, exact orthogonality is marginal-specific. It protects the default
under the uniform coordinate marginal, not under an arbitrary marginal. A
marginal can concentrate on points where the default parity disagrees with
the target. Then the source learner again has to detect and repair the
orientation or correlation sign at the hidden weak scale.

Third, replacing parity by a one-way-image Hadamard code keeps the same
problem for this edge. If the image coefficient is learnable from labels,
the improper target can output the image parity. If it is not learnable,
then the proper source also lacks an evident way to choose a weakly correlated
proper output under every marginal, except by public handles that the
improper target can reuse.

Thus the Hadamard idea explains exactly what a deterministic randomized
default would need to do, but it only works cleanly for a fixed friendly
marginal or for a proper-output lower bound. It does not preserve the
marginal-nonuniform weak proper source against all marginals while defeating
weak improper learning.

### PRF And Shared-Code Ideas

The PRF version has better target-hardness flavor. A level `j` could use a
large common domain `X_{n,j}` or a shared code domain, with labels given by a
PRF key. A source learner could memorize sampled labels and output a proper
patch/default handle. Under the uniform hard marginal this gives advantage
about

$$
\frac{\text{sampled mass corrected}}{|X_{n,j}|},
$$

which can be `n^{-j}`. A distribution-free weak learner with exponent `a`
would then be attacked by choosing `j >> a`; getting more advantage would
require predicting unseen PRF labels.

This remains a near miss for the same reason as the rare-block template.
The patch/default handle must be a deterministic proper hypothesis that works
for every marginal, not only the uniform PRF marginal. A shared public code
default can be nearly orthogonal to the PRF target under the designed
uniform marginal, but an arbitrary marginal may put its weight exactly where
that default is negatively correlated. To fix this, the source learner needs
one of the following:

1. a pointwise-safe default, which is impossible unless the default already
   agrees with the target on every high-mass point;

2. both orientations plus validation at the hidden scale, which costs
   `1/gamma^2` samples and reintroduces the forbidden `j`-dependent resource
   exponent;

3. prediction-time randomized hypotheses, which are outside the current atlas
   binary PAC convention; or

4. public weak handles with guaranteed positive correlation under every
   marginal, which the improper target can also use.

Approximate shared-code repairs add another leak. On a polynomially explicit
coordinate domain, one cannot make exponentially many wrong codewords exactly
orthogonal in every relevant weighted marginal. Residual correlations at
inverse-polynomial scale are harmless for a strong proper lower bound, but
they are dangerous here: the target only needs weak improper advantage, and
the hidden-gap construction is trying to make all available public advantages
smaller than every fixed inverse polynomial. If the residual correlations are
efficiently findable, they become target handles; if they are computationally
hidden, the source learner cannot rely on them as its uniform proper handle.

### What Overlap Actually Buys

Overlap does buy one thing: it removes the purely measure-theoretic complaint
that infinitely many disjoint bad slices cannot all have mass near one. A
nested or shared-domain lower bound may choose a different heavy marginal
`P_j` for each hidden exponent `j`, and that is exactly the quantifier pattern
needed to refute a distribution-free weak gap.

What overlap has not bought is a source-positive handle. The source is
stronger than it first appears because it is proper and must handle every
marginal. The target is weaker than it first appears because it is improper
and may reuse any public weak handle. The constructions I checked fall into
one of three bins:

1. Same fixed marginal: impossible for an unbounded hidden-gap hierarchy,
   because the source exponent `K(P)` is fixed.

2. Nested/reweighted high-mass marginals: viable for the target lower-bound
   quantifiers, but the deterministic proper source still faces the
   near-balanced orientation test at the hidden scale.

3. Shared-code or Hadamard defaults: good under a designed uniform marginal,
   but either improperly learnable, not safe under arbitrary marginals, or
   reliant on public residual handles that leak to the target.

### Atlas Readiness

I do not see an atlas-ready false edge from overlapping slices. The best
candidate would still be a PRF/shared-code hierarchy with proper
memorization handles, but it needs a new ingredient:

> an efficiently findable deterministic proper handle that gives positive
> hidden-scale correlation for every marginal, while no efficient improper
> learner can use the same handle family to obtain a fixed inverse-polynomial
> distribution-free edge.

That is stronger than ordinary PRF hardness and stronger than Hadamard
orthogonality. It is essentially computational weak-handle hardness: weak
handles may exist at the right hidden scale, but finding any handle above a
fixed public scale must be hard, while finding the marginal-specific hidden
handle remains easy for the source. I do not currently know a construction
with those two features simultaneously.

### Branch Verdict

verdict: unresolved for the edge; negative for the specific hope that
overlapping, nested, or shared-coordinate bad slices alone evade the mass
obstruction and produce a false witness. Overlap fixes the disjoint-mass
bookkeeping, but then either a fixed marginal gives the source a fixed
exponent, or varying high-mass marginals reintroduce the deterministic
orientation/validation problem. Hadamard/parity defaults are a useful model
for orientation-free patching under uniform marginals, but they are either
improperly learnable or not robust to arbitrary marginals. PRF/shared-code
templates still lack a source-safe proper handle that does not leak to the
improper target.

confidence: 0.82

next branch ideas if unresolved:

1. Try to formalize the near-balanced orientation obstruction for nested
   domains, not just disjoint rare blocks. The lemma should compare two
   marginals on the same high-mass domain whose transcript laws are close but
   whose correct deterministic defaults are opposite.

2. Search for a genuine computational weak-handle construction: handles are
   guaranteed to exist and are findable by the source at marginal-specific
   hidden scale, but any handle with a fixed inverse-polynomial edge would
   decode a PRF key or invert a one-way function.

3. Isolate a randomized-hypothesis variant. Hadamard patching suggests that
   prediction-time randomization would remove much of the orientation
   barrier; if the atlas ever adds randomized final hypotheses, this edge may
   have a different status.

4. Investigate whether a bounded-variation or two-sided-density stability
   condition on the family of hard marginals would force weak-gap
   uniformization. If so, any false witness must use marginals that separate
   by unbounded reweighting even when their supports overlap.

## Depth 4 Branch: validation-over-exponents positive route

### Question

This branch gives the positive route its best black-box form. After the
full-support pathwise argument, suppose one call to the source learner `A`
has a distribution-free sample and time bound

$$
m_0(s,\log(1/\delta)) \le s^{b_0}\operatorname{polylog}(1/\delta).
$$

For each actual marginal `P`, the accuracy guarantee may still be

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)\ge s^{-k(P)}
$$

with no uniform bound on `k(P)`. The route under test is:

1. run `A` repeatedly;
2. validate the outputs at geometrically many guessed gap scales;
3. perhaps aggregate the validated outputs, possibly by randomization; and
4. hope to obtain one final distribution-free inverse-polynomial edge.

The branch conclusion is negative for this route. The method proves only a
truncated statement: for any fixed searched exponent `D`, it gives a uniform
weak learner for all marginals with `k(P) <= D`, with sample cost roughly
`s^{2D}`. Letting `D` range over all possible `k(P)` reintroduces exactly the
marginal-dependent polynomial degree that the target forbids.

### The Truncated Positive Lemma

Fix a maximum searched exponent `D`. Consider candidate thresholds

$$
\tau_d=s^{-d},\qquad d=1,\ldots,D.
$$

For each `d`, run `A` enough times with confidence parameter small enough that
at least one run succeeds with high probability whenever the source gap is at
least `\tau_d`. Test each returned hypothesis on an independent validation
set of size

$$
v_d = C\tau_d^{-2}\log(ND/\delta)
    = C s^{2d}\log(ND/\delta),
$$

where `N` is the number of candidates. Accept a candidate at scale `d` only
if its empirical validation error is at most `1/2-\tau_d/2`, and output the
candidate with the largest certified scale.

Hoeffding's inequality gives the standard certification guarantee. If a
candidate has true error at most `1/2-\tau_d`, then it passes the scale-`d`
test with high probability. If a candidate has true error at least
`1/2-\tau_d/4`, then it fails the stronger scale-`d` certificate with high
probability, after adjusting constants. A union bound over the finite grid
keeps the total failure probability below `\delta`.

Therefore, if the actual marginal satisfies `k(P) <= D`, then one of the
successful runs of `A` is certified at some scale comparable to
`s^{-D}`. The final output has

$$
\operatorname{err}_P(h,c)\le \frac12-\Omega(s^{-D}).
$$

This is a real positive result, but it is not the target implication. Its
runtime and validation sample bound have polynomial degree proportional to
`D`. If `D` is chosen after seeing `P`, the guarantee is
marginal-nonuniform. If `D` is fixed in the algorithm, it only covers
marginals whose hidden exponent is at most that fixed `D`.

### Why Geometric Search Does Not Remove The Exponent

Searching over geometrically spaced gaps reduces the number of tests, not the
cost of the smallest tested gap. Testing all thresholds down to `s^{-D}` costs

$$
\sum_{d=1}^D \Theta(s^{2d}) = \Theta(s^{2D})
$$

up to logarithmic factors. The final, smallest scale dominates.

One might instead search over all `d` but stop after the global sample budget
is exhausted. If the transformation has total validation budget

$$
M(s)\le s^B,
$$

then the smallest statistically meaningful gap it can validate is on the
order of

$$
M(s)^{-1/2}\gtrsim s^{-B/2}.
$$

Any marginal with hidden source gap `\gamma_P(s)=s^{-k(P)}` and
`k(P)>B/2` lives below the validation noise floor. The grid may contain
smaller formal thresholds, but the algorithm has not bought the samples
needed to distinguish those thresholds from random guessing.

This is the exact place where the attempted positive route fails. A finite
polynomial budget implies a finite exponent floor. The source permits
marginals below every such floor.

### Validation Lower Bound

The obstruction is not an artifact of Hoeffding analysis; it is a lower
bound. Suppose a validation procedure observes `M` fresh labeled examples and
must distinguish a candidate with error `1/2-\eta` from one with error
`1/2`, or distinguish the two orientations with errors `1/2-\eta` and
`1/2+\eta`.

For a fixed candidate, the validation mistakes are Bernoulli samples with
parameter `1/2-\eta` or `1/2`. The per-sample KL divergence is
`O(\eta^2)`, so the total KL divergence over `M` samples is
`O(M\eta^2)`. By Pinsker or Le Cam, if `M\eta^2` is bounded by a small
constant, the two validation transcript distributions have bounded-away-from
one total variation distance. No test can reliably tell the worlds apart.

Equivalently, reliable validation at advantage scale `\eta` requires

$$
M=\Omega(\eta^{-2}).
$$

For orientation tests this is even more damaging. If the source learner has
to decide whether to output a default-zero or default-one proper handle when
the two corresponding errors are `1/2-\eta` and `1/2+\eta`, then using
`o(\eta^{-2})` validation samples leaves a constant probability of choosing
the wrong orientation. The wrong orientation has error above `1/2`, so it
does not merely miss the desired target gap; it fails weak learning outright.

Thus any validation-over-exponents transformation with total polynomial
degree `B` can only certify or orient gaps down to about `s^{-B/2}`. A
marginal with hidden exponent `k(P)>B/2` is invisible to that validation
budget.

### Repeated Runs Do Not Create A Uniform Gap

Repeated calls to `A` improve confidence that some output has the promised
hidden edge. They do not, by themselves, increase the edge above
`\gamma_P`.

In the worst case, all successful runs return the same proper weak handle, or
handles whose error sets are perfectly correlated. Then selecting the best
validated output cannot beat the same `\gamma_P` scale. This worst case is
allowed by the source definition; it promises existence of weak outputs, not
diversity of their errors.

Even under the optimistic model where independent runs have sufficiently
independent errors for majority vote to amplify, the dependence on
`\gamma_P` remains. A majority of `T` independent weak classifiers with edge
`\gamma_P` has edge on the order of `\gamma_P\sqrt{T}` in the small-edge
regime. To reach a target edge `s^{-a}` from a source edge `s^{-k(P)}`, one
needs

$$
T \gtrsim s^{2(k(P)-a)}.
$$

So amplification by repetition also has a polynomial degree depending on
`k(P)` unless `k(P)` is uniformly bounded. It cannot turn
`\forall P\ \exists k(P)` into `\exists a\ \forall P`.

### Randomized Aggregation

Randomized aggregation has two separate readings.

If the final predictor chooses one validated hypothesis at random at
prediction time, its correlation is a convex combination of the base
correlations. This can preserve a hidden advantage but cannot increase the
maximum available advantage. It therefore outputs edge at most on the order
of `\gamma_P` unless some base hypothesis already has a larger edge.

If the aggregation is a deterministic majority or weighted vote over a
randomly generated ensemble, then it can amplify only under assumptions on
the ensemble's diversity or on pointwise independence of errors. The source
definition gives no such assumptions. A black-box implication must also work
for a source learner whose repeated runs are identical after success.

If the final hypothesis is allowed to be genuinely randomized and to guess
independently on uncertain regions, that may remove the orientation problem
seen in the rare-block constructions. But that is a different hypothesis
model from the deterministic binary PAC notes currently used in the atlas,
and it still does not validate a deterministic distribution-free weak edge.

### Why Full-Support Bounds Are Not Enough

The full-support argument gives one pathwise bound on the runtime and sample
use of `A` because every finite transcript possible under any marginal also
has positive probability under the reference marginal. Runtime is a pointwise
property of transcripts.

The weak gap is not pointwise. It is an averaged correlation under the actual
marginal. The guarantee for `P` may be witnessed by a correlation of size
`s^{-k(P)}`, and the source places no continuity or bounded-density condition
forcing these correlations to have one envelope over all `P`. Validation is
also an averaged statistical task; seeing an averaged bias of size
`\eta` requires `\eta^{-2}` samples. Thus the same full-support trick that
uniformizes resources does not uniformize accuracy.

### Precise Obstruction

Any transformation of this type has a fixed polynomial budget. Write its
total number of source calls, validation examples, and aggregation work as
at most `s^B` after suppressing logarithmic confidence factors. Then:

1. Direct output of a source hypothesis gives edge only `\gamma_P(s)`.

2. Validation can certify or orient only gaps
   `\eta \gtrsim s^{-B/2}`.

3. Repetition or majority amplification can raise `\gamma_P` to a fixed
   target scale only when `s^B` is at least polynomially comparable to
   `1/\gamma_P^2`.

4. Randomized mixtures preserve average correlation but do not create a
   larger deterministic weak edge without extra diversity or model changes.

Consequently, if the source exponent `k(P)` is larger than the constant
implicit in `B`, the transformation either outputs a hypothesis with only the
hidden edge `s^{-k(P)}` or lacks enough validation information to safely
select, orient, or amplify it. Choosing `B` large enough for that `P` is
allowed in the marginal-nonuniform source world, but the distribution-free
target requires one `B` for all marginals.

### Branch Verdict

verdict: unresolved for the edge; negative for the validation-over-exponents
positive route as a black-box uniformization theorem. The route yields a
useful bounded-exponent lemma, but it cannot remove the hidden
marginal-dependent weak exponent. The exact lower-bound obstruction is the
quadratic validation and amplification cost `\Omega(1/\gamma_P^2)`: a
polynomial-time transform has one fixed exponent floor, while the source
permits marginals whose promised weak edge lies below every such floor.

confidence: 0.88

next branch ideas if unresolved:

1. Formalize the bounded-exponent lemma separately: if the source definition
   is strengthened by `k(P) <= K_0` for all marginals, then repeated runs plus
   validation over `d <= K_0` gives the target edge with exponent `O(K_0)`.

2. Look for a non-black-box structural theorem that forces diversity or
   amplifyability of the source learner's outputs. Without such structure,
   repeated runs may be perfectly correlated.

3. Investigate a deterministic-to-randomized model split. If randomized final
   hypotheses are added to the atlas, the orientation barrier changes, but
   the validation lower bound for certifying an inverse-polynomial edge still
   has to be tracked explicitly.

4. Turn the validation lower bound into a reusable scratch lemma for
   rare-block and nested-block witnesses: any proper source handle whose
   correct orientation changes across two marginals separated only at scale
   `\eta` requires `\Omega(\eta^{-2})` samples to choose reliably.

## Depth 5 Branch: hidden-gap final attack

### Question

The previous branch established the most useful positive fragment: after
full-support pathwise resource uniformization, a bounded hidden exponent can be
searched and validated. The unresolved question is whether the unbounded
hidden exponent can be removed by a less direct argument.

In reduced form, let `A` be the single proper source learner. Applying the
source guarantee to a full-support reference marginal gives one pathwise
polynomial bound on the finite transcripts of `A`. For each actual marginal
`P`, however, the accuracy guarantee may still be

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)\ge s^{-k(P)}.
$$

The target would follow if one could replace the family of exponents
`k(P)` by one exponent `K`, perhaps by changing the learner, postprocessing
the source learner, or using a non-black-box structural theorem.

### Candidate Positive Theorem Under Test

A tempting theorem is:

> If one pathwise-polynomial learner weakly succeeds for every marginal with a
> marginal-dependent inverse-polynomial edge, then there is another efficient
> learner with one distribution-free inverse-polynomial edge.

The finite-transcript viewpoint gives this theorem its best chance. For a
fixed representation size and confidence parameter, the resource-uniformized
learner has only a finite budget. Its possible outputs are generated from a
finite set of finite labeled transcripts and internal random strings. For a
fixed target concept `c`, the condition "for every marginal `P`, some output
of this finite process has positive correlation with `c` under `P`" resembles
a finite zero-sum game. A minimax argument can sometimes convert
distribution-by-distribution weak hypotheses into a randomized vote that has
positive pointwise margin against `c`.

This does not give the atlas target.

First, the minimax margin can be arbitrarily small. Even when a finite family
of candidate hypotheses has positive margin against every distribution, the
least pointwise margin may be exponentially small in the size or description
complexity of the family. The source only says that for each fixed global
marginal the margin is at least some inverse polynomial with a
`P`-dependent exponent. It supplies no bit-complexity, finite-precision, or
separation lower bound on the linear inequalities that define the finite game.

Second, the source guarantee is global in `P`, not a per-size lower envelope.
For every proposed exponent `K`, one may see a marginal and size where the
source edge is below `s^{-K}`. Stitching these failures into one global
marginal still runs into the old dilution problem: the stitched marginal can
put small mass on each bad slice, and weak error is averaged rather than
checked slice by slice.

Third, changing the learner does not create correlation for free. A
deterministic selector needs validation at the relevant margin. A majority or
weighted vote needs either diversity assumptions on the source outputs or
roughly `1/\gamma_P^2` repetitions in the worst case. Enumerating all finite
transcripts of `A` and solving the induced game is computationally uncontrolled
and may only expose a super-polynomially small margin anyway.

So the plausible normalizing theorem is not derivable from the current atlas
axioms. It would become reasonable under an added condition such as a uniform
finite-output margin, bounded hidden exponent, finite-precision marginals,
size-indexed per-slice accuracy, or bounded-density stability of weak gaps.
None of those conditions is present in the assigned edge.

### Relativized Finite-Transcript Barrier

There is, however, a clean oracle-style barrier against any black-box
normalizer for hidden exponents.

Consider a family of games indexed by a size parameter `s` and an exponent
`j`. The hidden weak source produces a proper hypothesis whose correlation
with the target under the current marginal is

$$
\eta_j=s^{-j}.
$$

The source oracle may be called repeatedly, but in the hard case every
successful call returns the same weak handle, or handles with perfectly
correlated error sets. The transform receives ordinary labeled validation
examples from the target marginal and must output a deterministic weak
hypothesis with some fixed edge `s^{-a}` independent of `j`.

Let the transform have total budget at most `s^B`, counting source calls,
fresh examples, oracle queries, and postprocessing. Choose
`j > B/2 + a + 10`. Now couple two worlds:

1. in world `+`, the candidate handle has error `1/2-\eta_j`;
2. in world `0`, the candidate has error exactly `1/2`, or in the orientation
   version world `-`, its complement is the weak handle.

For any transcript using at most `s^B` fresh labels, the KL divergence between
the validation distributions in worlds `+` and `0` is
`O(s^B\eta_j^2) = o(1)`. The same calculation distinguishes the two
orientations only when the budget is `\Omega(\eta_j^{-2})`. By Le Cam or
Pinsker, no finite-transcript procedure with budget `s^B` can reliably know
whether it has a genuine weak handle, a null handle, or the wrong orientation.

Amplification has the same exponent dependence. In the most optimistic
independent-errors model, boosting a handle from edge `s^{-j}` to edge
`s^{-a}` needs on the order of `s^{2(j-a)}` independent useful handles.
With perfectly correlated handles it cannot amplify at all. Thus every
relativizing black-box transformation has a finite exponent floor, while the
source interface permits exponents below that floor.

This is a genuine barrier, but it is only a barrier to black-box
normalization. It does not by itself settle the atlas edge. If the oracle that
reveals the correct hidden handle is granted only to the source learner, then
we have separated oracle interfaces, not concept classes. If the handle oracle
is encoded into the PAC instance so that the source learner can query it
efficiently, then an improper target learner may be able to query or simulate
the same information. If the source learner learns the handle orientation from
samples at scale `s^{-j}`, full-support pathwise resource uniformization rules
out unbounded `j`.

So the relativized result should be recorded, at most, as:

> No finite-transcript black-box transform can turn a hidden
> marginal-dependent weak exponent into one distribution-free exponent without
> additional structure.

It is not an atlas-ready counterexample.

### Best Remaining Counterexample Shape

The most plausible concrete false witness remains a biased dense hard block.
For each exponent `j`, take a large block with pseudorandom labels and plant a
public proper weak handle whose correlation under the designed hard marginal
is exactly `s^{-j}`. Under standard PRF-style hardness, no efficient improper
learner should obtain correlation `s^{-a}` on that block for fixed `a` once
`j>a`, because the public handle is too weak and the residual labels are
pseudorandom.

This fixes one earlier problem: the handle orientation on the designed hard
marginal can be public, so the source learner need not validate a
near-balanced sign at scale `s^{-j}`.

It does not fix the source requirement. The source learner must work for every
marginal, not just the uniform hard marginal. An arbitrary marginal can
concentrate on the anti-handle region, on a nearly balanced residual region,
or on a sparse set of pseudorandom coordinates. Constants handle strongly
unbalanced marginals; sparse proper patches handle heavy atoms; the public
biased handle handles the designed uniform marginal. The hard case is the
middle regime where no atom is heavy, constants are near chance, and the
public handle has correlation of unknown sign or magnitude below any fixed
validation floor. There the source learner either has to solve pseudorandom
labels, or choose an orientation at the hidden scale, or rely on an additional
public handle family.

That additional handle family would need to satisfy two opposed conditions:

1. for every marginal and target, some efficiently selectable proper handle
   has positive inverse-polynomial edge, possibly with hidden exponent;
2. under one hard marginal, no fixed-polynomial improper learner can obtain a
   larger inverse-polynomial edge from the same public structure.

If the handle is selectable without target-label information, the target
learner can use it too. If it is selectable from target-label samples, the
validation lower bound reappears. If it is selectable only by recovering a
hidden key, the source is no longer positive. This is the current reason the
biased-PRF route is still a near miss rather than a counterexample.

### Best Remaining Positive Shape

The strongest positive route would be a finite-output margin theorem for the
resource-uniformized learner. Such a theorem would have to show that the
source condition prevents the margins of the finite transcript game from
falling below `s^{-O(1)}`. I do not see a path to that bound under arbitrary
real-valued marginals: a marginal can encode very fine cancellations, and the
current definitions impose no quantitative lower bound on those cancellations.

The known positive fragments are therefore conditional:

- bounded hidden exponent `k(P) <= K_0`: validation search gives the target
  with edge `s^{-O(K_0)}`;
- size-indexed marginals with per-size accuracy: diagonalizing bad slices
  should force a uniform weak exponent;
- bounded-density stability of weak gaps: resource uniformization plus local
  control of reweighted marginals could support boosting or validation;
- finite-precision or margin-separated marginal families: the finite game may
  acquire an inverse-polynomial lower margin.

These are schema changes or strengthened nodes, not consequences of the
assigned source.

### Atlas Incorporation Synthesis

If atlas edits are later allowed, the edge should remain `open`, but the note
should stop saying that the main obstruction is the marginal-dependent
resource polynomial. Under the current pathwise finite-transcript convention,
the resource polynomial of the single source learner is uniformized by the
full-support reference marginal. The surviving obstruction is:

> The source gives `forall P exists k(P)` for the weak advantage. No current
> theorem turns this into `exists K forall P`, and finite-transcript
> validation/amplification has an `Omega(1/gamma_P^2)` lower-bound barrier.

The useful atlas-level additions would be:

1. keep the edge status `open`;
2. revise the summary toward hidden weak-gap uniformization;
3. add a reusable bounded-exponent lemma as a positive conditional result;
4. add a black-box/oracle-barrier paragraph to the marginal-uniformization
   argument, explicitly marked as non-counterexample evidence;
5. keep rare-block, biased-PRF, and shared-code constructions as witness
   templates only, with the arbitrary-marginal source audit highlighted.

verdict: unresolved for the edge. The hidden-gap exponent still blocks a
positive proof, and the finite-transcript/oracle attack gives a real
black-box barrier but not a PAC counterexample. The best current atlas action
is to sharpen the open note around weak-gap uniformization and record the
bounded-exponent lemma plus the oracle barrier as supporting context.

confidence: 0.90

depth-6 branch: Formalize the finite-output margin problem for the
resource-uniformized learner: for each fixed size, view all finite transcripts
of `A` as a finite hypothesis game, prove the minimax positive-margin
statement, and then determine whether arbitrary marginals can force that
margin to be super-polynomially small in `s`. This branch is the most direct
way to decide whether a non-black-box normalization theorem is possible or
whether a concrete biased-block witness should exist.

## Depth 6 Final Synthesis

### Final Hard Pass: Finite-Output Margin Normalization

After the earlier branches, the strongest remaining positive route is not
resource uniformization, validation, boosting, or mixture diagonalization. It
is a finite-output margin theorem for the already resource-uniformized source
learner.

Fix a representation size `s`, a target concept `c`, and the source learner
`A`. By the full-support transcript argument, `A` has one pathwise polynomial
sample/time bound. Hence for fixed `s` and confidence, only finitely many
sample transcripts, random strings, and output strings can occur within that
bound. Let `H_s(c)` denote the finite set of proper hypotheses that can be
output by `A` on realizable transcripts labeled by `c`.

For each marginal `P`, the source guarantee implies that with high
probability `A` outputs some hypothesis whose `P`-correlation with `c` is
positive, indeed at least `s^{-k(P)}`. Ignoring algorithmic access and looking
only at the finite hypothesis family, this suggests a game:

$$
\alpha_s(c) =
\inf_P \max_{h\in H_s(c)}
\mathbf E_{x\sim P}[(-1)^{c(x)}(-1)^{h(x)}].
$$

On a finite instance slice, if this value is strictly positive, minimax gives
a distribution over `H_s(c)` with positive pointwise margin against `c`.
Thresholding that vote would recover `c` pointwise on that slice. This is the
best possible shape of a non-black-box normalization theorem.

It still does not prove the edge, for three independent reasons.

First, the margin lower bound can be far below inverse-polynomial. The game
value is a separation margin of a finite system of linear inequalities. Even
when it is positive, the source assumptions impose no bit-complexity,
finite-precision, or conditioning lower bound that would force
`\alpha_s(c) >= s^{-O(1)}`. With large finite output/domain sets, positive
linear-program values can be exponentially or worse small as functions of the
representation size. On countable slices, mass can also escape to regions on
which every available output has smaller and smaller edge.

Second, the finite-game object is target-specific and not algorithmically
available. The family `H_s(c)` is defined using transcripts labeled by the
unknown target concept `c`; constructing the minimax vote would amount to
enumerating and solving against labeled behavior over the relevant domain,
not to an efficient PAC learner from random examples.

Third, even a per-size positive game value does not defeat the global-marginal
diagonal obstruction. If the values `\alpha_s` decay faster than every
inverse polynomial along a size sequence, stitching the corresponding bad
sizes into one global marginal dilutes them. Weak error is averaged; a bad
component must carry almost all the mass to force global error near `1/2`.
Infinitely many bad sizes cannot all carry almost all the mass in one global
distribution.

Thus the finite-output route gives a useful conceptual normal form but not an
atlas theorem. It identifies what a positive proof would have to add: a
uniform inverse-polynomial lower bound on the finite-game margin, or an
efficient way to construct a weak vote without solving the target-specific
game. Neither follows from the current source definition.

### Exact Hidden-Gap Obstruction

The edge is now reduced to a single quantifier gap:

$$
\forall P\ \exists k(P)\quad
\operatorname{err}_P(A,c)\le \frac12-s^{-k(P)}
$$

versus

$$
\exists K\ \forall P\quad
\operatorname{err}_P(B,c)\le \frac12-s^{-K}.
$$

Under the atlas pathwise finite-transcript convention, the resource part of
the marginal-nonuniform guarantee is not the live obstruction. The
full-support reference marginal gives one polynomial sample/time bound for
the single source learner on all finite transcripts. Proper-to-improper is
also harmless: a proper output is an allowed improper output.

The hidden obstruction is the weak advantage itself. The source permits the
inverse-polynomial exponent to depend on the marginal. A learner with total
polynomial budget `s^B` can validate, orient, or amplify only advantages down
to roughly `s^{-B/2}` without additional structure. For marginals whose
source edge is `s^{-k(P)}` with `k(P) >> B`, the edge is statistically below
the transform's resolution. Choosing a larger budget after seeing `P` is
exactly marginal-nonuniformity; the target requires one budget and one weak
edge for all `P`.

This is the precise atlas obstruction:

> Full-support transcript uniformization converts marginal-dependent
> resources into one pathwise polynomial, but it does not convert
> marginal-dependent weak gaps into one inverse-polynomial gap. The missing
> theorem would have to turn `forall P exists k(P)` into `exists K forall P`
> for averaged PAC correlations, where low-mass bad slices can be ignored and
> gap-scale validation costs `Omega(1/gamma_P^2)`.

### Positive Lemmas That Survive

1. **Full-support resource uniformization.** For a single
   marginal-nonuniform learner whose sample use and runtime are worst-case
   bounds on finite encoded transcripts, a full-support reference marginal
   gives one distribution-free polynomial resource bound for that learner.
   This does not transfer accuracy from the reference marginal.

2. **Trivial proper-to-improper relaxation.** If the source learner outputs a
   proper hypothesis, the same output is valid for an improper target. No
   properization issue remains on this edge.

3. **Bounded-hidden-exponent lemma.** If the source guarantee is strengthened
   by a uniform envelope `k(P) <= K_0` over all marginals, then the edge is
   true. The original source learner itself has a distribution-free weak edge
   `s^{-K_0}` after resource uniformization.

4. **Truncated validation lemma.** For any fixed searched exponent `D`,
   repeated runs plus validation over thresholds down to `s^{-D}` gives a
   certified weak output for all marginals with `k(P) <= D`, using
   `s^{O(D)}` samples/time. This is a valid conditional result, but choosing
   `D` as a function of `P` is not distribution-free.

5. **Size-indexed diagonal lemma under changed semantics.** If marginals were
   size-indexed families and error at size `s` were evaluated conditionally on
   the size-`s` slice, a diagonal argument would force a uniform weak
   exponent. This is not the current global-marginal atlas semantics.

6. **Finite-output positive-margin normal form.** For a fixed finite slice and
   fixed target, the possible outputs of the resource-bounded learner define a
   finite weak-hypothesis game. Positive per-marginal edge suggests a positive
   game value. What is missing is any inverse-polynomial lower bound or
   efficient construction of the target-specific vote.

### Why Plausible Counterexamples Still Fail

Plain PRF classes have the correct distribution-free hardness flavor, but
they fail the source: the hard marginal on the PRF domain is one of the
marginals quantified over by the source, and no efficient weak learner is
available there under the intended cryptographic assumption.

Rare-block or wide-block PRF templates create the right hidden-gap geometry.
Under a designed uniform block marginal, public singleton or lookup handles
can give only `n^{-j}` advantage, while any distribution-free learner with
fixed exponent can be challenged at `j` larger than its budget. The missing
piece is the source proof for arbitrary marginals. Near balance, the learner
must choose between default-zero and default-one proper handles when the sign
of the label bias is only `Theta(n^{-j})`. High-confidence orientation at that
scale needs `Omega(n^{2j})` validation samples, which is incompatible with
the full-support pathwise resource bound for unbounded `j`.

Overlapping, nested, and shared-slice versions fix the disjoint-mass
bookkeeping but not the source audit. If all levels use one fixed marginal,
the source guarantee for that marginal already gives one fixed exponent, so
there is no unbounded hidden-gap hierarchy. If the marginals vary while
remaining high-mass on overlapping regions, the deterministic orientation and
weighted-correlation problems return. Shared Hadamard or parity defaults are
orientation-free under friendly uniform marginals, but under arbitrary
weighted marginals they can be negatively correlated; moreover ordinary
parity structure is often improperly learnable.

Oracle and finite-transcript normalizers show a real black-box barrier but
not a PAC counterexample. An oracle that hands the source learner the hidden
weak handle separates interfaces, not concept classes. Once the handle
information is encoded in the learning problem, either the improper target can
use it too, or the source learner has to infer it from samples at the hidden
gap scale.

Prediction-time randomized hypotheses would remove part of the deterministic
orientation problem by guessing on uncertain regions. That is a different
hypothesis model from the current atlas binary PAC notes, where the learner
outputs an ordinary deterministic classifier or concept representation.

### Suggested Atlas Incorporation

Keep the edge open. The current edge note should be sharpened away from
generic marginal-dependent resource bounds and toward weak-gap
uniformization.

Suggested frontmatter:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
summary: "Open: full-support transcript uniformization gives one pathwise sample/time polynomial for the single source learner, and proper outputs are allowed by the improper target, but the source weak advantage may still have marginal-dependent polynomial degree; no known theorem turns those hidden weak gaps into one distribution-free inverse-polynomial edge."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

Suggested body replacement:

```markdown
## Verdict

`open`.

The live issue is weak-gap uniformization, not the one-call resource bound.
Let `A` be the source learner. Under the atlas pathwise finite-transcript
efficiency convention, a full-support reference marginal gives one polynomial
bound on the sample use and running time of `A` over every finite transcript
that can occur under any marginal. Since the target is improper, the proper
output of `A` is also allowed.

For accuracy, however, the guarantee must be applied to the actual marginal
`P`. It gives only
`\operatorname{err}_P(h,c) <= 1/2 - \gamma_P(s)`, where
`1/\gamma_P(s)` is polynomial in `s` with a degree that may depend on `P`.
The distribution-free weak target needs one inverse-polynomial advantage
independent of `P`.

Known positive fragments require extra uniformity. A uniform bound on the
hidden exponent, bounded-density stability of the weak gaps, finite-precision
margin separation, or size-indexed conditional marginals would support a
uniformization theorem. These assumptions are not part of the source node.

Known counterexample templates are also not atlas-ready. Plain PRF classes
fail the source on the hard marginal. Rare-block and shared-code PRF
templates expose the desired hidden-gap phenomenon, but their proper source
learners must handle arbitrary marginals; near-balanced marginals force
gap-scale orientation or validation, while public handles strong enough for
the source tend to be reusable by the improper target.

Thus the edge remains open pending either a weak-gap uniformization theorem
or a concrete hidden-gap class whose proper marginal-nonuniform source
learner works for every marginal without leaking a distribution-free improper
weak handle.
```

Suggested companion edits, if broader atlas maintenance is allowed later:

1. Add `bendavid1995parameterization` to this edge's `ref_keys`, matching the
   source definition's uniformity-parameter background.

2. Add a short paragraph to `marginal-uniformization-open` naming this as a
   `weak-gap-uniformization` subcase: resources uniformize by full support,
   but weak advantages need an exponent envelope.

3. Record the bounded-hidden-exponent lemma as a conditional positive note,
   separate from the open edge.

4. Record the validation/orientation lower bound as non-counterexample
   evidence: it blocks black-box normalization and explains why rare-block
   proper-handle witnesses have not yet become valid separations.

verdict: unresolved-open
confidence: 0.91
