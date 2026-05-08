# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac

- date: 2026-05-07
- worker depth: 1 of 7
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: scratchpad only; no atlas files or bibliography edited

## Executive Verdict

I do not see an atlas-ready proof or counterexample. The edge should remain
`open`.

The source immediately gives the same-marginal weak realizable proper learner:
on realizable labels the agnostic optimum is zero, so the source outputs
$h\in\mathcal C$ with error at most $1/2-\gamma_P(s)$. If the usual
Schapire/Freund weak-to-strong booster could be run with one
original-marginal polynomial controlling all induced weak gaps, the target
would follow and the final vote would be allowed because the target is
improper.

The missing theorem is exactly that envelope. The source gives pointwise
marginal guarantees

$$
\forall Q\quad \gamma_Q(s)^{-1}\le \operatorname{poly}_Q(s),
$$

but the target needs, for every original marginal $P$, one polynomial
$r_P(s,1/\varepsilon,\log(1/\delta))$ controlling all reweighted or residual
marginals that a strong learner may need before reaching error $\varepsilon$.

The agnostic strength of the source is a real near miss, but it does not close
the gap. Same-marginal agnostic boosting can keep $X\sim P$ fixed by changing
the label distribution, yet Feldman/Ghai-style arguments need a
residual-responsive correlation or threshold oracle. The atlas source is only
fixed-additive:

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s).
$$

In correlation form this is useful only when the pseudo-label problem is
already nearly realizable by $\mathcal C$, not when the current residual has a
small but polynomially useful correlation.

## Files And Prior Scratchpads Read

Local atlas files:

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

Prior exact scratchpad:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

Related prior scratchpad:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

No exact 2026-05-04 scratchpad for this edge was present.

Primary sources checked:

- Schapire 1990, *The Strength of Weak Learnability*: https://doi.org/10.1023/A:1022648800760
- Benedek and Itai 1991, *Learnability with respect to fixed distributions*: https://doi.org/10.1016/0304-3975(91)90026-X
- Hanneke, Moran, and Thiessen 2025/2026, *Marginal-Nonuniform PAC Learnability*: https://openreview.net/forum?id=aoVCFtox89
- Feldman 2010, *Distribution-Specific Agnostic Boosting*: https://arxiv.org/abs/0909.2927
- Ghai and Singh 2025, *Sample-Optimal Agnostic Boosting with Unlabeled Data*: https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice 2026, *Sample-Near-Optimal Agnostic Boosting with Improved Running Time*: https://arxiv.org/abs/2601.11265
- Goldreich, Goldwasser, and Micali 1986 / Kearns and Valiant 1994 as recorded in the atlas PRF witness

## Current Edge State

The edge currently records:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: the agnostic same-marginal source avoids new instance marginals, but its fixed-additive guarantee is not residual-responsive enough to drive strong realizable boosting to arbitrary accuracy."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

This summary is accurate. I would not change the status from `open`.

## Positive Route 1: Reweighted Realizable Boosting

### Goal

Given an original marginal $P$ and realizable target $c\in\mathcal C$, produce
an improper hypothesis with $P$-error at most $\varepsilon$ in time polynomial
in $(s,1/\varepsilon,\log(1/\delta))$, where the polynomial may depend on
$P$ but not on $c$ or on the target-dependent boosting path.

### Reduction To Weak Realizable Proper Learning

On realizable data, $\operatorname{OPT}_{\mathcal C}=0$. The source learner
therefore satisfies

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s)
$$

with $h\in\mathcal C$. Thus the edge contains the already-open subproblem

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
-> efficient-marginal-nonuniform-realizable-improper-pac.
```

Properness is harmless at the final step: a majority or weighted vote of
proper hypotheses is legal for the improper target.

### Envelope Needed

Classical boosting asks the weak learner to work under induced marginals
$Q_t$, produced by filtering or reweighting according to the current ensemble.
The marginal-nonuniform source gives each such $Q_t$ its own weak gap
$\gamma_{Q_t}(s)$.

The target would follow from:

$$
\exists r_P\text{ polynomial}\quad
\forall t \text{ before error }\varepsilon,\qquad
\gamma_{Q_t}(s)\ge \frac{1}{r_P(s,1/\varepsilon,\log(1/\delta))}.
$$

The source definition does not imply this quantifier swap. Smooth boosting or
bounded-density boosting would only replace arbitrary $Q_t$ by
$Q_t\ll P$ with bounded density. A rare-block mixture can still have
conditionals $Q_j=P(\cdot\mid S_j)$ with
$dQ_j/dP\le 1/P(S_j)$ and weak gaps such as $s^{-j}$ or $s^{-j^2}$. Each
conditional has an inverse-polynomial gap, but no fixed polynomial in
$(s,1/P(S_j))$ controls all of them.

This is a proof-route obstruction, not a counterexample: the rare-block
quantifier pattern still has to be realized by a concrete class satisfying
the source under every marginal.

## Positive Route 2: Same-Marginal Agnostic Boosting

The agnostic source suggests a better plan: keep the instance marginal fixed
at $P$ and encode the booster's residual state in randomized labels. This is
the structural point of Feldman's distribution-specific agnostic boosting, and
Ghai-Singh use unlabeled access in a related fixed-marginal way.

The obstruction is quantitative. Use $\{\pm1\}$ labels. For a same-marginal
pseudo-label distribution, write

$$
r(x)=\mathbb E[Y\mid X=x],
\qquad
A^\star(r)=\sup_{g\in\mathcal C_s}\langle r,g\rangle_P.
$$

The source guarantee is equivalent to

$$
\langle r,h\rangle_P\ge A^\star(r)-1+2\gamma_P(s).
$$

So the returned hypothesis is guaranteed positive correlation only when

$$
A^\star(r)>1-2\gamma_P(s).
$$

That is a low-noise or near-realizable condition. A residual booster needs the
different promise that whenever $A^\star(r)\ge \alpha$, even for small
$\alpha$ near the current residual error, the oracle returns correlation at
least inverse-polynomial in $(s,1/\alpha)$ or a polynomial fraction of
$\alpha$.

The fixed-additive source has no $\alpha$ parameter. It can be silent on
residual signals that are perfectly useful for a threshold/correlation
agnostic booster.

The same point appears in density-ratio form. To simulate a reweighted
marginal $Q$ while keeping $X\sim P$, set

$$
\mathbb E[Y\mid X=x]
=
\lambda\frac{dQ}{dP}(x)c(x).
$$

Since $|\mathbb E[Y\mid X=x]|\le 1$,
$\lambda\le 1/\|dQ/dP\|_\infty$. The source only gives useful correlation
when $\lambda>1-2\gamma_P(s)$, so it can mimic only density ratios below
roughly

$$
\frac{1}{1-2\gamma_P(s)}.
$$

For small weak gap $\gamma_P(s)$, this is essentially no focusing. Strong
boosting eventually needs to focus on residual regions of mass comparable to
the requested accuracy.

The 2026 da Cunha-Hogsgaard-Paudice result is a near miss because it improves
agnostic boosting runtime for fixed problem parameters, but the arXiv summary
still phrases the polynomial-time statement as polynomial in the sample size
with other parameters fixed. That does not by itself give an atlas polynomial
when the hidden weak parameters are $P$-dependent functions of $s$ and must
remain polynomially accounted for.

## Counterexample Search

### Standard Witnesses Do Not Settle This Edge

Plain PRF classes give computational hardness under their hard marginal, but
they also fail the source there: no efficient weak learner gets an
inverse-polynomial advantage against pseudorandom labels.

Fixed-$k$ DNF and one-way image-coordinate weak-handle classes separate weak
proper or strong proper requirements, but the present target is improper.
The final learner may aggregate weak handles, use lookup-style hypotheses, or
memorize sparse atoms. The existing one-way weak-handle lower bound is a
proper-output lower bound, not an improper one.

Halfspaces are also irrelevant as a separation here: they are strongly
realizably learnable, while their hardness is agnostic.

### Best False Template: Rare-Block PRF With Proper Handles

The best remaining false direction is a rare-block direct sum. Put mass

$$
w_{n,j}\asymp 2^{-j}n^{-2}
$$

on a block $B_{n,j}$ of size $N_{n,j}=n^j$, and let a short PRF key define a
balanced target labeling on that block. Add constants and local handle
concepts, such as singleton or bounded subset handles, so that an isolated
block has a proper weak handle of advantage about $1/N_{n,j}$.

For the fixed mixture marginal $P^\star$, strong learning a target on
$B_{n,j}$ to $\varepsilon\ll w_{n,j}$ forces small conditional error on that
block. If a proposed target learner has polynomial degree $D$, choose a fixed
$j>D$ and then $n$ large. The learner's polynomial budget in
$(s,1/\varepsilon)$ gives too few samples from the active block to cover
$n^j$ coordinates, and PRF security or a random-oracle argument prevents
prediction on unseen coordinates. Improper output does not help against
unseen pseudorandom labels.

This is a credible target-hardness template, but it still fails to prove the
source.

The source must hold under every marginal, including marginals concentrated
on one near-balanced hard block. A proper handle learner must choose the
correct default orientation: all-zero plus positive exceptions on one side,
or all-one plus negative exceptions on the other. If the learner sees only
$m(s)$ samples and the block size $N$ is much larger than $m(s)^2$, two
near-balanced marginals

$$
P_+(\text{positive side})=1/2+\eta,
\qquad
P_-(\text{positive side})=1/2-\eta,
$$

with $\eta\asymp m(s)/N$ have almost indistinguishable finite transcript
distributions. Sparse sampled handles correct only $O(m(s)/N)$ mass. With
the wrong default orientation, the error stays at least $1/2$.

Thus the rare-block PRF/singleton template does not yet certify the
arbitrary-marginal weak agnostic proper source. Repairing it seems to require
an orientation-free deterministic proper handle, or some different way to
make one weak handle easy under every marginal while many independent handles
remain hard for improper prediction.

## What Would Resolve The Edge

A positive resolution would follow from either of these lemmas.

**Original-marginal weak-gap envelope.** For every original marginal $P$ and
target accuracy $\varepsilon$, all booster-induced marginals reachable before
accuracy $\varepsilon$ have weak gaps bounded below by one
$P$-dependent inverse polynomial in $(s,1/\varepsilon)$.

**Residual-responsive same-marginal oracle.** For every $P$, whenever a
bounded residual $r$ satisfies

$$
\sup_{c\in\mathcal C_s}\langle r,c\rangle_P\ge \alpha,
$$

the source learner can be converted into a proper hypothesis with correlation
at least $1/\operatorname{poly}_P(s,1/\alpha)$. Feldman-style
distribution-specific boosting would then give the target. The current
fixed-additive source does not imply this lemma.

A negative resolution would need a concrete, not merely oracle-schema,
concept class satisfying:

1. one uniform proper weak agnostic learner for every marginal;
2. weak handles whose advantage can deteriorate along rare blocks without
   violating the source;
3. a fixed original marginal under which strong improper learning requires
   too many independent handles or breaks a standard cryptographic primitive;
4. no hidden-orientation failure for arbitrary near-balanced marginals.

## Conclusion

The edge is not resolved. The current atlas status and family are still the
right ones:

```yaml
status: "open"
evidence: unknown
family: marginal-boosting-open
```

Best scratchpad summary:

```yaml
summary: "Open: the agnostic source can be queried on same-marginal noisy labels, but its fixed-additive OPT + 1/2 - gamma_P guarantee is not residual-responsive. Reweighted realizable boosting would need one original-marginal weak-gap envelope over booster-induced marginals; rare-block PRF/handle templates suggest possible target hardness but still fail to certify the arbitrary-marginal proper weak agnostic source."
```

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`


## Depth 2 Branch A: Rare-Block Proper Handles And Orientation

- date: 2026-05-07
- branch: rare-block PRF with deterministic proper handles
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Branch Goal

Try to turn the rare-block PRF template into a source-positive,
target-negative witness for

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
  -> efficient-marginal-nonuniform-realizable-improper-pac.
```

The target-hard side remains plausible: under a fixed rare-block mixture
and an active block with $N_{n,j}=n^j$ coordinates, a strong improper learner
with a polynomial degree below $j$ sees too few active coordinates to predict
unseen PRF labels. The source side is the problem. Because the source is
proper and deterministic, a weak handle must output one binary concept, not a
coin-flipping or abstaining predictor. Under arbitrary marginals this creates
an orientation problem.

I use the paired-block notation

$$
B_{n,j}=\{(u,b):u\in [N_{n,j}],\ b\in\{0,1\}\},
\qquad
c_f(u,b)=1\{b=f(u)\},
$$

where $f$ is a PRF or random function on the coordinate set. A proper handle
may be a constant, a singleton/subset correction, a paired correction, or a
public-default concept added to the class, but the learner must output one
ordinary binary hypothesis in the class.

### Singleton Handles

The baseline repair adds all-zero, all-one, and positive singleton or bounded
positive-subset handles. On a uniform balanced block, a sampled positive
singleton gives a weak edge of order $1/N$; for fixed level $j$ this is still
an inverse polynomial in $n$.

This fails for arbitrary marginals by the already-identified orientation
test. Let a pathwise-polynomial source learner use at most $m=m(s)$ examples,
and take $N\gg m^2$. Put almost-uniform mass on the target-positive and
target-negative sides with

$$
P_+(\text{positive side})=1/2+\eta,
\qquad
P_-(\text{positive side})=1/2-\eta,
\qquad
\eta\asymp m/N.
$$

The transcript distributions have total variation $O(m\eta)=O(m^2/N)=o(1)$.
However, if the learner chooses the wrong constant/default orientation, the
wrong side costs $\eta$ mass while sampled singleton corrections cover only
$O(m/N)$ mass. Choosing the sign by validation needs $\Omega(1/\eta^2)$
samples, far above $m$ in this window. Thus singleton handles are not
source-positive for arbitrary marginals.

### Paired Handles

A natural next attempt is a pair handle: when the learner sees coordinate
$u$, output the concept that is correct on both atoms $(u,0),(u,1)$ and uses
some default elsewhere. This removes the positive-vs-negative ambiguity on
the sampled coordinate itself.

It does not remove the orientation problem on the unseen coordinates. The
handle still needs a deterministic default outside the sampled pair. If the
default is all-zero or all-one, this is exactly the singleton obstruction. If
the default chooses one atom per pair according to a public rule $d(u)$, then
the obstruction moves from the positive/negative side to the
match/mismatch partition $\{d=f\}$ and $\{d\ne f\}$.

For a fixed public default $d$, an adversarial marginal can put
$1/2+\eta$ mass on coordinates where $d$ mismatches $f$ and
$1/2-\eta$ on coordinates where it matches, or vice versa. The two cases are
again statistically indistinguishable at $m$ samples for
$\eta\asymp m/N$, while the wrong choice between $d$ and its complement has
error above $1/2$. Correcting the sampled coordinates changes only $O(m/N)$
mass.

### Balanced Default Pairs

Balanced default concepts are the cleanest deterministic idea. A default
$d$ labels exactly one atom in every coordinate pair positive. Unlike
all-zero/all-one defaults, its error on a pair is independent of whether the
marginal puts more mass on the positive atom or the negative atom: if
$d(u)=f(u)$ the pair is correct, and if $d(u)\ne f(u)$ the pair is wrong.

This solves the first orientation problem but creates a second one. The
learner must now choose a default $d$ whose coordinate-level agreement with
$f$ is above $1/2$ under the coordinate marginal. For arbitrary marginals, no
fixed public $d$ has this property. A marginal can concentrate on a
near-balanced mixture of the agreement and disagreement sets of $d$, and the
learner cannot decide whether $d$ or $\bar d$ is the weakly good orientation
inside the same tiny-bias window.

Making a large public family of balanced defaults does not obviously help.
If the family is small enough to search and validate in polynomial time, a
PRF target has no reliable public correlation on the uniform hard block
beyond sample collisions. If the family is rich enough that some member has
positive correlation for every PRF target and every marginal, then selecting
that member from samples is already a weak learner for PRF labels on arbitrary
subsets. That is much closer to the forbidden target-side prediction task
than to a harmless handle.

### Public Anchors

Public anchors also do not repair the source. A block-level anchor with known
target label can identify a global convention for the target, but the bad
orientation in this template is a property of the marginal: which side or
which default partition has slightly more mass. A public anchor has no force
if the arbitrary marginal gives it negligible mass.

Giving every coordinate a public anchor that reveals $f(u)$ would fix the
source, but it also destroys the PRF lower bound. A strong improper learner
could use the same public information to predict the active block. Sparse
anchors leave marginals that avoid them; dense anchors leak the target.

### Validation-Based Orientation Selection

Validation is useful away from the knife edge. If the better orientation has
an error advantage $\eta$ and the learner is allowed
$\tilde O(1/\eta^2)$ examples, empirical validation can choose between the
two defaults.

The rare-block obstruction lives exactly below that resolution. With
$N\gg m^2$ and $\eta\asymp m/N$, the two orientation marginals are
indistinguishable to an $m$-sample learner, while the mass corrected by
sampled handles is also only $O(m/N)$. Taking the hidden weak gap
$\gamma_P(s)$ smaller does not help when the wrong orientation has error
strictly above $1/2$; a positive weak edge requires some deterministic
orientation to be right.

### Barrier Shape

I do not have a fully general no-go theorem for every conceivable proper
handle extension, but the barrier now looks precise.

A deterministic binary handle cannot be neutral on unseen mass. After a
sample transcript is fixed, the output gives a total labeling of every unseen
coordinate. If this unseen labeling is independent of the PRF values, then
there is a large subset of coordinates on which it is slightly biased the
wrong way. An arbitrary marginal may concentrate on a near-balanced mixture
of that bad subset and its complement. The learner then has to choose between
two almost indistinguishable orientation marginals, while sampled corrections
repair only the collision mass.

Therefore an orientation-free deterministic proper handle seems to need one
of two stronger properties:

1. It predicts the hidden PRF labels on a non-collision fraction of the
   high-mass unseen coordinates. This undermines the target-side PRF lower
   bound, because the handle is no longer merely a weak sample-collision
   artifact.
2. It behaves neutrally outside the sampled set, contributing exactly
   $1/2$ error there. This is possible for a stochastic predictor that flips
   a fresh coin off the sample, but not for an ordinary deterministic binary
   proper concept.

This is the promised tension: deterministic orientation-free handles either
look too strong, in which case the improper strong target may become easy or
the PRF reduction no longer applies, or they are not actually
orientation-free under arbitrary marginals. I did not turn this into an
atlas-ready theorem because a formal statement would have to quantify over
data-dependent default families and over the exact representation of the
added proper handles.

### Agnostic Source Check

The weak agnostic source does not rescue the construction. The obstruction
already appears on realizable labels, where the agnostic optimum is zero. If
the learner cannot output a deterministic proper hypothesis with error below
$1/2$ on both orientation marginals in the realizable case, low-noise or
validation-based agnostic arguments have nothing to amplify. For genuinely
agnostic labels, the fixed-additive $\operatorname{OPT}+1/2-\gamma_P$ slack
only weakens the required performance when $\operatorname{OPT}$ is not tiny;
it does not solve the realizable near-balanced block.

### Conditional Variant Outside Current Semantics

If the atlas allowed stochastic final hypotheses, the rare-block handle
source would become much more plausible: memorize sampled coordinate pairs
and flip an independent fair coin on unseen coordinates. The unseen mass then
contributes exactly $1/2$ error, while sampled mass gives a weak edge without
choosing an orientation. A strong low-error learner under the fixed rare-block
mixture would still have to predict many unseen PRF labels.

That is a different model. The current atlas nodes use ordinary binary
hypotheses, and the source here is proper, so this stochastic neutralizer does
not resolve the present edge.

### Branch Conclusion

No orientation-free deterministic proper weak handle was found. The best
false template remains blocked on the arbitrary-marginal source proof. The
cleanest next formal task would be a no-go lemma for deterministic
sample-collision handles: under a PRF/random-function block with
$N\gg m(s)^2$, any learner whose unseen predictions do not carry real PRF
information fails one of two near-balanced orientation marginals. Such a lemma
would rule out this whole handle family, but it would still leave the main
edge open unless paired with a positive boosting-envelope theorem or a
different counterexample.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Deterministic Proper-Handle Orientation Barrier

- date: 2026-05-07
- branch: deterministic orientation barrier for proper rare-block handles
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Branch Goal

Try to make the orientation obstruction precise for rare-block constructions
whose weak learner is supposed to output a deterministic proper handle. The
desired false witness would have three features:

1. under every marginal, some proper handle gives a weak agnostic edge;
2. under one fixed rare-block marginal, a strong improper learner must predict
   many unseen PRF/random labels;
3. the weak handles do not themselves provide enough orientation information
   to make the strong improper target easy.

I did not find an orientation-free deterministic handle satisfying all three.
What I can formalize is a conditional no-go lemma for the usual
sample-collision handle family: constants, singleton corrections, paired
corrections, and public balanced defaults.

### Setup

Use a paired block

$$
B_N=[N]\times\{0,1\},
\qquad
c_f(u,b)=1\{b=f(u)\}.
$$

A sample-collision handle may memorize or correct the coordinates it has seen,
but on unseen coordinates it uses a deterministic default chosen from public
information and the sample transcript. This covers:

- all-zero/all-one with sampled positive exceptions;
- paired corrections at sampled coordinates;
- a public balanced default $d(u)$ that labels exactly one atom in each pair;
- bounded subsets found from the sample, as long as they only alter
  $O(m)$ sampled coordinates after an $m$-sample transcript.

The key restriction is not the exact syntax of the handle. It is:

> Outside the sampled coordinates, the handle's predictions do not contain
> fresh information about the hidden bits $f(u)$.

That is the regime in which the PRF lower bound is supposed to remain alive.

### Lemma 1: Deterministic Neutrality Is Impossible

**Statement.** Fix a target $c_f$ and an unseen set $U\subseteq B_N$. Let
$h:U\to\{0,1\}$ be deterministic. If $h$ is not equal to $c_f$ on all points
of $U$, then there is a marginal supported on $U$ under which $h$ has error
$1$. Consequently, a deterministic binary proper handle cannot be neutral on
arbitrary unseen mass. To be safe for every marginal without further samples,
it must actually predict the hidden labels on every high-mass unseen point.

**Proof.** Put all marginal mass on any point $x\in U$ with
$h(x)\ne c_f(x)$. Then $\operatorname{err}(h,c_f)=1$. If no such point
exists, $h=c_f$ on $U$.

This trivial lemma is useful because it identifies the only deterministic
escape hatch. A stochastic off-sample predictor could flip a fair coin and
contribute exactly $1/2$ error on unseen mass, but an ordinary proper binary
concept cannot. A deterministic handle that is robust to arbitrary unseen
marginals must know the labels there, which is exactly what the PRF hard side
tries to forbid.

### Lemma 2: Orientation Choice Has Validation Cost

**Statement.** Consider two orientation marginals on a block, both realizable
by the same $c_f$, which differ only by a bias $\eta$ toward one of two
complementary deterministic orientations. Any procedure that chooses the
correct orientation with probability at least $2/3$ in both cases requires
$\Omega(\eta^{-2})$ labeled examples. If the handle can correct at most
$O(m)$ sampled coordinates in a block of size $N$, then the wrong orientation
cannot be repaired when $\eta \gg m/N$.

**Proof sketch.** The learner's orientation evidence is a Bernoulli or bounded
mean test with means differing by $\Theta(\eta)$. Distinguishing
$\operatorname{Bernoulli}(1/2+\eta)$ from
$\operatorname{Bernoulli}(1/2-\eta)$ has KL divergence
$O(\eta^2)$ per sample, so by Pinsker or Le Cam, $m=o(\eta^{-2})$ samples
leave the two transcript distributions with total variation bounded away from
$1$. Thus some orientation is chosen with probability bounded away from $1$.

On the geometric side, sampled corrections cover only the sample-collision
mass. For diffuse block marginals this is $O(m/N)$. If the default orientation
is wrong by bias $\eta$ and $\eta$ is larger than that correction mass, the
handle's error remains at least $1/2$ up to lower-order terms. The window

$$
\frac{m}{N}\ll \eta \ll \frac{1}{\sqrt m}
$$

is nonempty whenever $N\gg m^{3/2}$.

### Instantiations

**Singleton/default handles.** Let $M=P(c_f=1)$. The two orientations are
$M=1/2+\eta$ and $M=1/2-\eta$. Constants pick the right side only after
estimating this bias. Positive singleton corrections change the error by only
the sampled positive mass, $O(m/N)$, under a diffuse block marginal. Hence
singletons are not orientation-free; they rely on validation at the hidden
gap scale.

**Paired handles.** Correcting both atoms in a sampled pair removes ambiguity
on that coordinate, but leaves the same default-orientation problem on unseen
pairs. With an all-zero or all-one default, the singleton calculation is
unchanged. With a balanced public default $d$, the orientation variable
becomes whether the coordinate lies in

$$
A_d=\{u:d(u)=f(u)\}
\quad\text{or}\quad
B_d=\{u:d(u)\ne f(u)\}.
$$

An adversarial marginal can give $A_d$ mass $1/2+\eta$ or $1/2-\eta$.
Samples reveal match/mismatch only on sampled coordinates, so the same
$\Omega(\eta^{-2})$ validation lower bound applies.

**Large public families of defaults.** A polynomial-size family only adds a
candidate-selection logarithm to the validation problem. If the family is so
rich that, for every $f$ and every marginal, some public default has visible
correlation without sample-scale validation, then the family is already a
weak predictor for PRF labels on arbitrary subsets. That threatens the target
lower bound rather than repairing the handle construction.

### What The Lemma Does And Does Not Prove

The lemma is a barrier for cheap deterministic orientation-free handles. It
does **not** prove that the source node fails. In the marginal-nonuniform
weak source, a learner may spend a marginal-dependent polynomial number of
samples. For a fixed heavy block of size $N=s^j$, spending on the order of
$N^2$ validation samples is still polynomial in $s$ with exponent depending
on the marginal. Thus constants plus sampled singleton or bounded-subset
handles can survive fixed heavy blocks by paying the validation cost.

The barrier instead says why this does not automatically produce a strong
improper target learner under one fixed rare-block marginal. Strong learning
would need one polynomial bound for all requested accuracies under that
fixed marginal, while the hard template can hide the active target in higher
and higher rare blocks. Local deterministic handles give only one weak,
orientation-validated correction at a time; aggregating enough of them to
predict unseen PRF labels still requires either many samples from the active
block or an evaluable predictor with real off-sample PRF information.

### Orientation-Free Handle Search

The only genuinely orientation-free idea I found is stochastic: memorize
sampled coordinates and flip an independent fair coin off-sample. This gives
exactly $1/2$ expected error on every unseen marginal and a positive edge on
the sampled mass. But it is not a deterministic proper concept in the atlas
semantics.

Every deterministic replacement seems to fall into one side of this
dichotomy:

1. It is local and default-based. Then Lemmas 1 and 2 give a near-balanced
   orientation marginal on which it needs gap-scale validation.
2. It predicts a non-collision fraction of the hidden paired labels. Then it
   is no longer a harmless weak handle; under the standard efficient-output
   convention, evaluating it on fresh paired points would undermine the PRF
   lower bound for the improper strong target.

So the deterministic proper-handle route is not dead, but any atlas-ready
counterexample has to state an additional structural assumption, such as
locality/no-unseen-PRF-information, or provide a new handle mechanism outside
the singleton/paired/default family.

### Branch Conclusion

I can turn the observed obstruction into a clean conditional barrier:
deterministic local proper handles cannot be neutral on arbitrary unseen
marginals, and choosing between complementary defaults costs
$\Omega(\eta^{-2})$ validation samples. This rules out the naive
orientation-free repair for singleton, paired, and public-default handles.

It does not resolve the edge. The source can still afford this validation
for fixed heavy blocks, and the target-hard PRF argument still needs the
usual efficient-evaluation convention for improper outputs. The main edge
should remain open unless this conditional barrier is paired with a fully
specified rare-block witness or a positive marginal-boosting envelope.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 4 Branch A: Stochastic Neutralization Model Fork

- date: 2026-05-07
- branch: stochastic neutralization versus deterministic binary simulation
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Branch Goal

Test whether the only clean orientation-free handle found in the previous
branches can be represented inside the current PAC semantics. The candidate
handle is:

1. from labeled samples on a paired block
   $B_N=[N]\times\{0,1\}$ with target
   $c_f(u,b)=1\{b=f(u)\}$, recover $f(u)$ for sampled coordinates $u$;
2. predict correctly on those sampled coordinate pairs;
3. on every unseen coordinate, output an independent fair coin.

This gives exact neutral behavior on unseen mass: conditional on the training
sample, every marginal assigns unseen points expected error $1/2$, while the
sampled mass gives a positive weak edge. It avoids all orientation tests
because it never chooses a deterministic default on unseen mass.

The question is whether this stochastic handle can be simulated by legal
deterministic binary proper hypotheses, perhaps by using randomized training,
randomized prediction encoded in the hypothesis, mixtures, pseudorandom
defaults, or validation.

### Current PAC Semantics

The source node says that the learner outputs $h\in\mathcal C$ and is a
binary zero-one PAC notion. The target node allows an improper hypothesis, but
still phrases the output as a hypothesis $h$ with zero-one error. The learner
may of course be a randomized algorithm, but after its samples and internal
coins are fixed, the usual reading is that it has output one binary classifier
whose error is then measured under $P$.

Thus two kinds of randomness must be separated.

- Randomized **training output** is allowed: the algorithm may randomly choose
  which deterministic $h\in\mathcal C$ to return.
- Randomized **prediction** is not part of the current node definitions: a
  fresh coin flipped every time $h(x)$ is evaluated is a stochastic kernel, not
  an ordinary binary hypothesis.

This distinction is fatal for the neutralizer. Its guarantee is an expected
loss statement over fresh prediction coins. The current source needs a
high-probability statement that the realized deterministic proper output has
error at most $\operatorname{OPT}+1/2-\gamma_P(s)$.

### Attempt 1: Randomized Training Output

Sampling a deterministic default at training time does not reproduce fresh
prediction neutrality. The simplest obstruction is the two-orientation test.
Suppose the randomized algorithm chooses between a default $d$ and its
complement $\bar d$. Under one near-balanced marginal, $d$ is the weakly good
orientation; under the opposite marginal, $\bar d$ is. If the two marginals
have bias only $\eta$, then with $m=o(\eta^{-2})$ samples their transcript
distributions are statistically close. Any randomized rule therefore chooses
the wrong orientation with constant probability on one of the two marginals.

That is enough to fail PAC confidence amplification: the source must work for
all $\delta$, including $\delta<1/3$. A constant probability of returning the
wrong deterministic classifier is not a weak PAC guarantee. Repetition only
helps if there is some validation signal that identifies the good draw, which
returns us to the validation-cost issue below.

More generally, if a distribution over deterministic hypotheses satisfies

$$
\mathbb E_R[\operatorname{err}_P(h_R,c_f)]
  = \frac12 - \alpha,
$$

this expectation alone says nothing about whether a sampled $h_R$ has error
below $1/2-\gamma$ with high probability. A fresh-coin predictor gets
neutrality pointwise in $x$; a sampled deterministic table only gets
neutrality after averaging over the algorithm's hidden seed.

### Attempt 2: Randomized Prediction Encoded In Hypotheses

One could declare that a hypothesis is allowed to be a stochastic map
$h(x)\in\Delta(\{0,1\})$ and measure expected zero-one loss over its prediction
coins. Then the neutralizer is legal and genuinely orientation-free.

But that is a model change. It changes the output object from a binary concept
to a stochastic kernel. It also changes properness: either $\mathcal C$ must
become a class of stochastic hypotheses, or the learner is no longer outputting
$h\in\mathcal C$ in the sense used by the atlas definition.

Encoding the coin as an extra input coordinate does not fix this inside the
current model. If the random seed is sampled freshly by the predictor, this is
again randomized prediction. If the seed is fixed at training time, we are back
to a deterministic classifier selected by randomized training output. If the
seed is part of the instance distribution, the learner no longer controls it
as private prediction randomness, and the target labels are ordinary
deterministic labels on the enlarged instance space.

### Attempt 3: Mixtures Of Proper Hypotheses

A distribution over proper hypotheses is just another way to describe
randomized prediction if the mixture component is resampled at prediction
time. Under expected loss, a $50$-$50$ mixture of complementary defaults can be
perfectly neutral on unseen mass.

This is not a legal proper source output in the current atlas node: the output
must be one $h\in\mathcal C$, not a point of $\Delta(\mathcal C)$. Sampling one
mixture component at training time has the same constant-failure orientation
problem as Attempt 1. Taking a deterministic majority or vote of the mixture
also does not preserve neutrality: a symmetric mixture ties and any tie-break
is a deterministic orientation; an asymmetric mixture chooses a side.

The target is improper, so a deterministic vote can be a legal final target
hypothesis. That does not help the source side of this edge, where the weak
handle must itself be proper.

### Attempt 4: Deterministic Pseudorandom Defaults

A subtler simulation would add many deterministic default hypotheses, for
example hash-seeded balanced labelings, and have the learner choose a random
seed. For a fixed diffuse marginal and fixed hidden target, a sufficiently
independent random default may have error close to $1/2$ with decent
probability.

This is not a generic repair under the current proper-agnostic source.

First, concentration depends on the marginal's collision mass and on the
scale of the desired weak edge. Heavy unseen atoms are not neutral after a
seed is fixed; they are either right or wrong. If they are not seen in the
training or validation samples, the algorithm has only randomized-output
success, not deterministic PAC success.

Second, if the seeded defaults are included in $\mathcal C$ so that the source
output is proper, then they also enter the agnostic benchmark. A distribution
realizable by one seeded default has $\operatorname{OPT}_{\mathcal C}=0$.
The source learner would then need to weakly learn that seeded-default class
under arbitrary marginals. A rich enough default family to simulate fresh
randomness is therefore dangerous: it tends to create exactly the kind of
large pseudorandom concept class that is not efficiently weakly learnable from
samples alone.

Third, if the family is kept small enough to search and validate efficiently,
it no longer behaves like fresh independent prediction randomness on arbitrary
subsets. It becomes another public-default family, and the previous
match/mismatch orientation marginal applies.

So deterministic pseudorandom defaults might be useful in a separately
specified construction with extra structure, but they do not simulate the
stochastic neutralizer in the abstract rare-block handle template.

### Attempt 5: Validation

Validation can choose between deterministic orientations when the advantage is
statistically visible. If two defaults differ by error gap $\eta$, choosing
the better one with constant confidence costs $\Omega(\eta^{-2})$ labeled
validation examples. For a finite candidate family, the usual bound is
roughly $O(\log M/\eta^2)$.

This does not reproduce stochastic neutrality; it pays to learn the missing
orientation. In the rare-block template, the weak edge from sampled
coordinates can be as small as the sampled block mass, and the bad orientation
can hide in the window already identified in Depth 3. If validation is allowed
to run at that scale for each fixed marginal, the weak source may survive, but
then the construction is no longer using an orientation-free deterministic
handle. It is using marginal-dependent validation, and the argument loops back
to the existing open issue: no single original-marginal polynomial is known to
control all rare blocks needed for strong target learning.

Validation therefore gives a conditional deterministic repair only when the
orientation gap is visible at a polynomial scale already permitted by the
source marginal. It does not turn the fresh-coin neutralizer into a legal
proper binary hypothesis with the same behavior.

### Model-Fork Counterexample Route

The stochastic handle would be a clean false-witness ingredient for a different
model:

- source learner may output a proper stochastic predictor, or a mixture over
  proper handles;
- loss is expected zero-one loss over the predictor's private coins;
- the target strong learner is still required to get small expected error
  under a fixed rare-block marginal.

In that fork, the source side becomes plausible because unseen mass is exactly
neutral without choosing an orientation. The target-hard side can still ask
for $\varepsilon$ far below a hard block's mass, forcing prediction of many
unseen PRF/random labels rather than fair-coin guessing.

But this is not the present atlas edge. Under the current semantics, the
source output is a deterministic binary proper hypothesis. The stochastic
neutralizer is therefore a diagnostic for why deterministic handles are hard,
not an atlas-ready counterexample.

### Branch Conclusion

I do not see a valid deterministic simulation of stochastic neutralization
inside the current binary proper PAC semantics.

Randomized training output gives only a distribution over deterministic
hypotheses and can fail with constant probability on one of two
near-indistinguishable orientation marginals. Randomized prediction and
mixtures work only if the model evaluates expected loss over private
prediction coins. Pseudorandom deterministic defaults either reintroduce
proper agnostic learnability problems by enlarging $\mathcal C$, or collapse
back to public-default orientation tests. Validation can choose a deterministic
orientation only at the usual $\eta^{-2}$ sample cost and does not preserve the
fresh-coin neutralizer's orientation-free behavior.

So this branch supports only a model-fork counterexample route. It does not
resolve the current edge as true or false.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Deterministic Atlas Implications After Stochastic Fork

- date: 2026-05-07
- branch: deterministic atlas implications after stochastic fork failure
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Branch Goal

Decide what the previous branches imply for the actual atlas edge, after
rejecting the stochastic neutralizer as outside the current binary proper PAC
semantics.

The working question is:

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
  -> efficient-marginal-nonuniform-realizable-improper-pac
```

Under the atlas definitions, the weak source outputs a deterministic binary
proper hypothesis after its samples and internal randomness are fixed. The
target may be improper, but it is still an ordinary binary predictor. Thus the
stochastic fork cannot be smuggled back into the present edge by saying that
the learner is randomized: randomized training is legal, fresh randomized
prediction is a different output model.

### Deterministic Consequence Of The Stochastic Fork Failure

The stochastic fork failure does **not** create a positive theorem. It only
removes the cleanest false-witness mechanism.

The only handle that was genuinely orientation-free was:

1. memorize sampled paired coordinates;
2. predict them correctly;
3. flip a fresh fair coin on unseen coordinates.

This is exactly neutral on unseen mass, so it would make the arbitrary-marginal
source side much easier. But because current hypotheses are deterministic
binary maps, every legal proper handle must choose a definite label on unseen
mass. Once it does that, an adversarial marginal can ask whether the chosen
orientation is the right one. If the orientation signal is small, the learner
must pay validation cost; if it refuses to pay, it fails one of the two
near-balanced orientation marginals.

So the deterministic lesson is a barrier to a family of counterexamples, not a
boosting theorem. The source can still be satisfied by spending a
marginal-dependent polynomial number of validation samples on each fixed
isolated block. The atlas source allows that. What it does not give is one
original-marginal polynomial that would support strong boosting to every
accuracy under a fixed rare-block mixture.

### Positive-Theorem Route Remains The Envelope

The positive route is still the same original-marginal envelope problem.
Restricting the agnostic source to realizable labels gives, for each marginal
$P$, a weak proper learner with advantage

$$
\gamma_P(s)=1/2-\beta_P(s)>0
$$

whose inverse is bounded by some $P$-dependent polynomial. Ordinary
Schapire/Freund boosting would prove the target if the booster only needed
weak calls whose advantages are bounded below by one polynomial depending on
the original $P$, $s$, $1/\varepsilon$, and $\log(1/\delta)$.

The atlas source still lacks that quantifier swap. A reweighted booster visits
residual marginals $Q_t$, and the source gives each $Q_t$ its own polynomial.
No deterministic-hypothesis observation bounds the degrees hidden in those
polynomials. Smooth or bounded-density boosting would at most say
$Q_t\ll P$ with controlled density; the definition contains no local
continuity principle saying that weak gaps vary polynomially over such a
neighborhood of $P$.

The same-marginal agnostic route also remains blocked. In correlation form,
the fixed-additive source gives

$$
\langle r,h\rangle_P \ge \sup_{c\in\mathcal C}\langle r,c\rangle_P
  -1+2\gamma_P(s).
$$

This only forces useful correlation when the residual labeling is nearly
realizable by $\mathcal C$. A strong learner needs progress on residual
signals with smaller correlations. Determinism of the returned hypothesis does
not upgrade this fixed-additive oracle into a threshold or residual-responsive
oracle.

Thus the depth-7 atlas consolidation should not state a positive theorem
unless a new lemma supplies one of:

- an original-marginal weak-gap envelope for all booster-induced marginals;
- a local-uniformity theorem for bounded-density residual marginals;
- a conversion from fixed-additive weak agnostic learning to a
  residual-responsive correlation oracle.

None has been found in this branch.

### Counterexample Route Still Exists, But Not Via Stochastic Neutrality

The deterministic orientation barrier also does **not** rule out every false
witness. It rules out the naive local handle idea when the handle is supposed
to be orientation-free without validation.

A remaining counterexample route would have to combine:

1. a fixed rare-block marginal $P^\star$ under which strong improper learning
   to $\varepsilon\ll w_j$ forces prediction on a hard block $B_j$;
2. arbitrary-marginal weak agnostic proper learnability, including marginals
   concentrated on a single hard block;
3. deterministic proper handles that choose orientation by validation or by
   some nonlocal structure, with a polynomial allowed to depend on the
   isolated marginal;
4. a proof that, under $P^\star$, assembling enough such handles into a
   low-error improper predictor remains computationally hard.

This route is narrow but not dead. The orientation barrier says that local
sample-collision handles must either validate the unseen orientation or
contain real off-sample information about the hidden labels. Validation is
permitted by the source on fixed isolated marginals. Real off-sample
information threatens the target lower bound. A successful false witness has
to navigate exactly this tension.

The depth-7 atlas note should therefore phrase the deterministic orientation
barrier as a reason no current counterexample is atlas-ready, not as a proof
that counterexamples are impossible.

### What To Consolidate At Depth 7

The edge note and linked argument notes should probably consolidate three
separate points.

**Marginal boosting envelope.** The central unresolved positive lemma is an
envelope over booster-induced marginals. The source gives

$$
\forall Q\ \exists \operatorname{poly}_Q,
$$

but the target needs, for a fixed original marginal $P$,

$$
\exists \operatorname{poly}_P\ \forall Q_t \text{ reached before }
\varepsilon.
$$

This is the cleanest explanation for why classical boosting does not settle
the edge.

**Deterministic orientation barrier.** For rare-block proper-handle
counterexamples, deterministic binary hypotheses cannot be neutral on unseen
mass. Near-balanced marginals force an orientation choice, and selecting the
right orientation costs $\Omega(\eta^{-2})$ validation samples. This blocks
singleton, paired, and public-default handles from serving as effortless
arbitrary-marginal source witnesses.

**Stochastic model fork.** A fresh-coin off-sample predictor would make the
handle source side plausible, but it is a stochastic kernel or mixture model,
not a deterministic proper hypothesis in the present atlas semantics. It
should be recorded only as a nearby model fork, not as evidence for the
current edge's status.

### Branch Conclusion

The accumulated barriers point to an open status, not to `resolved-true` or
`resolved-false`.

The positive theorem still needs a marginal boosting envelope or a
residual-responsive same-marginal oracle. The deterministic orientation
barrier explains why the most natural rare-block false witnesses have not
closed the edge, but it is conditional on local/no-off-sample-information
handles and does not rule out a more sophisticated deterministic witness. The
stochastic neutralizer would support a different model, not the current
deterministic binary proper source.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 6 Branch A: Deterministic Boosting Consolidation

- date: 2026-05-07
- branch: deterministic boosting consolidation
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Branch Goal

Try one last time to classify the edge under the current deterministic binary
PAC semantics:

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
  -> efficient-marginal-nonuniform-realizable-improper-pac
```

Here "deterministic" means that after the learner's sample and internal
randomness are fixed, the source output is an ordinary binary concept
$h\in\mathcal C$. A randomized training algorithm is legal, but its PAC
success event must contain a deterministic proper hypothesis with the promised
error. A fresh prediction-time coin, stochastic kernel, or expected-loss
mixture is a different output model.

I still do not see either an atlas-ready positive theorem or an atlas-ready
counterexample. The status should remain `open`.

### One More Positive Attempt

The source immediately gives same-marginal weak realizable proper learning.
On clean labels from $c\in\mathcal C$,

$$
\operatorname{OPT}_{\mathcal C}=0,
\qquad
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s),
$$

where $\gamma_P(s)=1/2-\beta_P(s)$ has inverse bounded by a
$P$-dependent polynomial. If the ordinary realizable booster could be run with
one polynomial depending only on the original marginal $P$, the target would
follow because the final weighted vote is allowed to be improper.

The missing step is still the quantifier swap. A reweighted booster asks for
weak hypotheses under marginals $Q_t$ depending on the current ensemble and
the target. The source gives

$$
\forall Q\quad \exists p_Q,\gamma_Q
$$

but the target needs, for the fixed original marginal $P$,

$$
\exists r_P\quad
\forall t \le T(s,\varepsilon,\delta):
\quad p_{Q_t},\gamma_{Q_t}^{-1}
\text{ are dominated by } r_P(s,1/\varepsilon,\log(1/\delta)).
$$

Smooth boosting or rejection sampling does not by itself supply this. It can
restrict $Q_t$ to bounded-density perturbations of $P$, but the definition has
no continuity principle saying that marginal-dependent weak gaps vary
polynomially over bounded-density neighborhoods.

The same-marginal agnostic route also stops at the same quantitative wall.
With labels in $\{\pm1\}$ and residual conditional expectation
$r(x)=\mathbb E[Y\mid X=x]$, the source guarantee implies

$$
\langle r,h\rangle_P
\ge
\sup_{c\in\mathcal C_s}\langle r,c\rangle_P - 1 + 2\gamma_P(s).
$$

This is useful when the residual task is nearly realizable by $\mathcal C$,
namely when the best correlation is close to $1$. A strong booster needs a
threshold or residual-responsive oracle: if the best residual correlation is
at least $\alpha$, return a hypothesis with positive correlation polynomially
related to $\alpha$. The atlas source has no $\alpha$ parameter. Changing only
the conditional label distribution while keeping $X\sim P$ avoids induced
instance marginals, but it cannot amplify a small residual region past the
fixed additive floor.

So the positive theorem still requires one of the following new lemmas:

- an original-marginal envelope over all booster-induced marginals;
- a local-uniformity theorem for bounded-density perturbations of $P$;
- a conversion from fixed-additive weak agnostic learning to a
  residual-responsive correlation oracle.

None follows from the current definitions.

### One More False Attempt

The best false template is still a rare-block hard class with deterministic
proper weak handles. The intended shape is:

1. under a fixed rare-block mixture $P^\star$, strong learning to
   $\varepsilon \ll w_j$ forces low conditional error on a hard block $B_j$;
2. the block size is chosen so that every fixed target learner's polynomial
   budget under $P^\star$ is too small to learn that block;
3. under marginals that isolate one block, the source survives because a
   marginal-dependent polynomial may spend enough samples to find a weak
   proper handle;
4. under the global mixture, low-mass hard blocks can be ignored by the weak
   source but not by a strong learner asked for sufficiently small
   $\varepsilon$.

This is still not a proof. The source is agnostic and quantifies over every
marginal, including marginals concentrated on a hard block and with arbitrary
label noise. If the proper handles are local deterministic classifiers, they
must choose definite labels on unseen mass. For near-balanced or
orientation-swapped marginals, one deterministic default is good and the
opposite default is bad. Choosing the right one costs validation samples at
scale roughly $\Omega(\eta^{-2})$ when the orientation gap is $\eta$.

That validation cost is not automatically fatal, because the source polynomial
may depend on the isolated marginal. But it prevents the easy
orientation-free source proof. A successful deterministic counterexample must
show all of the following at once:

- every fixed marginal has polynomially visible orientation information, or
  some nonlocal deterministic structure that replaces orientation validation;
- the proper weak learner remains agnostic, not merely realizable;
- the handles do not leak enough information for an improper learner under
  $P^\star$ to aggregate them to low error in polynomial time;
- the construction satisfies one uniform algorithm requirement, with only the
  rate polynomial depending on the marginal.

I do not have such a construction. The deterministic orientation barrier rules
out the cleanest singleton, paired, and public-default handle sketches, but it
does not rule out every possible deterministic witness.

### Stochastic Model Fork

The only simple orientation-free handle found in the previous branches is
stochastic: memorize sampled coordinates and flip a fresh fair coin on unseen
coordinates. This is exactly neutral on unseen mass, so it dodges the
orientation problem and makes the arbitrary-marginal weak source side much
more plausible.

That observation belongs to a different model. Under current atlas semantics,
the source output must be a deterministic binary proper hypothesis. Randomized
training output gives a distribution over deterministic hypotheses, and one
orientation marginal can still fail with constant probability. A prediction
kernel or mixture evaluated by expected loss changes both the loss model and
the meaning of properness.

Thus the stochastic neutralizer is useful diagnostic evidence: it identifies
why deterministic proper handles are hard. It is not evidence that the present
edge is false.

### Exact Text Depth 7 Should Propose

Depth 7 should not propose changing `status`, `evidence`, `assumptions`, or
`witnesses`. It should propose tightening the existing open explanation. The
following text is atlas-ready in content, but should be applied only by the
depth-7 editor if they decide to update atlas files.

For the edge frontmatter, propose replacing the current `summary` with:

```yaml
summary: "Open under deterministic binary proper semantics: same-marginal agnostic calls avoid induced instance marginals, but the fixed-additive weak guarantee is only low-noise. Reweighted boosting still needs an original-marginal envelope, and rare-block counterexamples run into deterministic orientation/validation barriers unless the model is changed to stochastic predictors."
```

For the edge body, propose replacing the `## Proof Status` section with:

```markdown
## Proof Status

**Goal.** Decide whether a deterministic proper weak agnostic learner with
marginal-dependent polynomial rates can be converted into a deterministic
improper strong realizable learner with a polynomial rate depending only on
the original marginal.

**Positive route blocked by an envelope gap.** On realizable labels, the
source gives a weak proper learner under each marginal $P$. Classical
realizable boosting would prove the target if all booster-induced marginals
$Q_t$ reachable before accuracy $\varepsilon$ had weak gaps and resource
bounds dominated by one polynomial depending on the original $P$,
$s$, $1/\varepsilon$, and $\log(1/\delta)$. The source gives separate
polynomials for each $Q_t$, and no local-uniformity or bounded-density
continuity principle supplies this original-marginal envelope.

**Same-marginal agnostic near miss.** Because the source is agnostic, one can
try to keep $X\sim P$ fixed and encode boosting residuals by changing the
conditional label distribution. In correlation form the guarantee is

$$
\langle r,h\rangle_P
\ge
\sup_{c\in\mathcal C_s}\langle r,c\rangle_P - 1 + 2\gamma_P(s).
$$

This is a low-noise promise: it forces positive correlation only when the
residual task is nearly realizable. Known agnostic boosting routes need a
threshold or residual-responsive oracle that remains useful whenever the best
residual correlation is merely inverse-polynomial.

**False route blocked by deterministic orientation.** Rare-block
counterexamples would need proper weak handles that work under every marginal
while remaining computationally nonboostable under a fixed rare-block mixture.
For local deterministic handles, unseen mass must receive a definite binary
default. Near-balanced orientation marginals can make one default weakly good
and the opposite default bad, so selecting the right orientation requires
validation at the scale of the orientation gap. This blocks the simple
singleton, paired, and public-default handle constructions but is not a
general impossibility theorem.

**Stochastic fork.** A fresh-coin off-sample predictor would be neutral on
unseen mass and would make the rare-block source side much easier. Such a
predictor is a stochastic kernel or mixture model, not a deterministic proper
hypothesis in the present atlas semantics. It should be treated as a nearby
model fork, not as a resolution of this edge.

**Conclusion.** The edge remains open pending an original-marginal boosting
envelope, a fixed-additive-to-residual-responsive agnostic boosting lemma, or
a fully deterministic nonboostable-handle separation.
```

For `atlas/arguments/marginal-boosting-open.md`, propose adding this paragraph
after the current paragraph about the weak-agnostic-to-realizable-improper
edge:

```markdown
Under the current deterministic binary proper semantics, the leading
rare-block false-witness route has its own obstruction. Local proper handles
must choose a definite label on unseen mass, so near-balanced orientation
marginals can make one deterministic default weakly useful and the opposite
default worse than random. A fresh prediction-time coin would neutralize the
unseen mass, but that is a stochastic-kernel model rather than a deterministic
proper PAC output. Thus the stochastic handle is best recorded as a nearby
model fork; the present deterministic edge still needs either an
original-marginal boosting envelope or a deterministic nonboostable-handle
separation.
```

### Branch Conclusion

The deterministic current semantics do not resolve the edge.

The true direction is blocked by the same marginal boosting envelope problem
and by the fact that fixed-additive weak agnostic learning is not
residual-responsive. The false direction is blocked by the deterministic
orientation barrier for proper handles; the only clean orientation-free
neutralizer is stochastic and therefore belongs to a model fork. The correct
atlas action is to preserve `status: "open"` and clarify these obstructions.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 7 Final Consolidation

- date: 2026-05-07
- depth: 7 of 7
- task: final allowed follow-up for this edge
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Final Verdict

`unresolved`.

I do not see an atlas-ready proof of the implication, and I do not see an
atlas-ready counterexample. The current edge should stay `status: "open"` with
`evidence: unknown`.

The final attempt did sharpen the obstruction. The source is a fixed-additive
weak agnostic proper learner:

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
\qquad
\beta_P(s)=1/2-\Gamma_P(s),
$$

where $\Gamma_P(s)^{-1}$ is bounded by a polynomial depending on the marginal
$P$. On clean labels this gives weak realizable proper learning under the same
marginal. The unresolved step is still weak-to-strong amplification with one
polynomial depending only on the original marginal.

### Last Positive Check

There are two boosting theorems close enough to be dangerous, but neither
settles this edge under the present definitions.

**Reweighted beta-optimal agnostic boosting.** Feldman's distribution-specific
paper records that a $\beta$-optimal agnostic learner can be boosted to error
roughly $\Delta/(1-2\beta)+\varepsilon$. In the realizable case $\Delta=0$,
this would give arbitrary accuracy. However, this beta-optimal route is the
version that changes the instance distribution, and Feldman's smoothness
remark only bounds the density ratio of induced distributions. For the atlas
edge that reintroduces the same missing envelope: every induced marginal
$Q_t$ has its own hidden polynomial and weak gap. The target needs one
original-$P$ polynomial controlling all such $Q_t$ before accuracy
$\varepsilon$.

**Same-marginal threshold/correlation agnostic boosting.** Feldman's
label-changing booster, and the later Ghai-Singh style correlation boosters,
preserve the instance marginal. They require a threshold or
residual-responsive oracle with slack at the final accuracy scale. The atlas
source is weaker. In $\{\pm1\}$ notation it gives

$$
\langle r,h\rangle_P
\ge
\sup_{c\in\mathcal C_s}\langle r,c\rangle_P-1+2\Gamma_P(s).
$$

Equivalently, if a relabeled same-marginal task has
$\operatorname{OPT}\le 1/2-\alpha$, the source only guarantees a useful
proper weak hypothesis when

$$
\alpha>\beta_P(s)=1/2-\Gamma_P(s).
$$

Since $\beta_P(s)$ may be close to $1/2$, this is a low-noise promise, not a
residual-responsive one. It can certify the first clean-label weak step, but
it does not force progress on the small residual correlations that remain
when the desired error is $\varepsilon\ll \beta_P(s)$.

The density-simulation calculation says the same thing. To mimic a reweighted
marginal $Q\ll P$ by same-marginal noisy labels, set
$\mathbb E[Y\mid X=x]=\lambda(dQ/dP)(x)c(x)$. The source implies

$$
\operatorname{err}_Q(h,c)\le \beta_P(s)/\lambda.
$$

This is weak only if $\lambda>2\beta_P(s)$. Since
$\lambda\le\|dQ/dP\|_\infty^{-1}$, this handles only density ratios below
$1/(1-2\Gamma_P(s))$, essentially no focusing when $\Gamma_P(s)$ is small.

### Conditional True Statements

The edge would be true under any one of the following additional principles.

**Original-marginal envelope.** For every original marginal $P$ and target
accuracy $\varepsilon$, every booster-induced marginal $Q_t$ reached before
error $\varepsilon$ has source sample/time bounds and weak gap dominated by
one polynomial

$$
r_P(s,1/\varepsilon,\log(1/\delta)).
$$

Then ordinary realizable boosting applies to the clean-label restriction of
the source, and the final vote is legal because the target is improper.

**Local-uniformity for smooth marginals.** It would be enough to prove the
envelope for the smooth or bounded-density marginals generated by a fixed
booster, for example all $Q\ll P$ with density ratio
$\operatorname{poly}(s,1/\varepsilon)$. The current definition has no such
continuity axiom.

**Residual-responsive same-marginal oracle.** If the source were strengthened
so that for every bounded residual $r$,

$$
\sup_{c\in\mathcal C_s}\langle r,c\rangle_P\ge\alpha
\quad\Longrightarrow\quad
\langle r,h\rangle_P\ge 1/\operatorname{poly}_P(s,1/\alpha),
$$

or more generally supplied tunable correlation slack
$\epsilon_0/\gamma=O(\varepsilon)$, then Feldman/Ghai-style
distribution-specific agnostic boosting would keep the marginal fixed and
give the target.

### Model Fork Statements

Two nearby forks are worth recording, but neither is the present edge.

**Stochastic proper predictors.** If the source learner could output a
proper stochastic kernel or a mixture evaluated by fresh prediction-time
randomness, the rare-block handle route would become much more plausible:
memorize sampled coordinates and flip a fair coin off-sample. This is exactly
neutral on unseen mass. It is not a deterministic binary proper hypothesis in
the atlas semantics.

**Size-conditional marginal semantics.** If marginal-nonuniform guarantees
were interpreted in a size-conditional way that prevented low-mass bad slices
from being ignored in a global mixture, a diagonalization over bad induced
marginals might force an original-marginal envelope. Under the current
global-marginal reading, rare low-mass slices can be harmless for weak error
while still mattering when the strong learner asks for sufficiently small
$\varepsilon$.

### Failed Counterexample Routes

**Plain hard classes.** PRF, LPN, random-code, and PCP-style hard blocks can
make strong prediction hard under a fixed marginal, but they generally fail
the source on marginals concentrated on the hard block: even weak proper
agnostic prediction is computationally hard there.

**Proper-output hardness witnesses.** Existing one-way or PCP witnesses for
proper strong hardness do not separate this edge because the target is
improper. A final boosted vote, lookup table, or aggregate of legal weak
proper handles is allowed.

**Rare-block PRF with singleton or paired handles.** The target-hard side is
plausible: under a fixed mixture, learning below the mass of a high-index
block would require predicting many unseen hard labels. The source side fails
to be atlas-ready. A deterministic proper handle must choose definite labels
on unseen mass. Near-balanced orientation marginals can make one default
weakly good and the opposite default worse than random. Selecting the right
orientation costs validation at scale $\Omega(\eta^{-2})$ for orientation gap
$\eta$.

**Public defaults and anchors.** Public balanced defaults merely move the
orientation question to the match/mismatch partition with the hidden target.
Sparse anchors can be avoided by arbitrary marginals; dense anchors reveal
too much and undermine the target-hard side.

**Staged algebraic or residual handles.** If the handle finder works robustly
on every isolated residual marginal, an improper strong learner can usually
call the same finder on residuals and aggregate the handles. If the residual
is hidden well enough to block aggregation, the weak agnostic source tends to
fail on the marginal isolating that residual.

### Exact Obstacle

The unresolved point is a quantifier mismatch plus a fixed-additive floor.

The source gives pointwise marginal data:

$$
\forall Q\quad \exists p_Q,\Gamma_Q
$$

with $\Gamma_Q(s)^{-1}$ polynomial for that particular $Q$. A strong
marginal-nonuniform learner under original $P$ needs

$$
\exists q_P\quad
\forall c\in\mathcal C_s,\ \forall \varepsilon,\ \forall\text{ booster calls }Q_t,
$$

one polynomial $q_P$ controlling every call before reaching error
$\varepsilon$. Classical reweighted boosting needs exactly this envelope.
Same-marginal relabeling avoids the $Q_t$'s but loses because
$\operatorname{OPT}+\beta_P$ is only useful on near-realizable relabelings,
not on arbitrary inverse-polynomial residual correlations.

A false proof has the opposite problem. To refute the target, one wants rare
hard blocks whose weak gaps deteriorate faster than any original-$P$
polynomial. But to satisfy the source, each isolated block and every
low-noise labeling over it must still have an efficiently findable
deterministic proper weak handle. Known handles are either orientation-bound,
stochastic-outside-the-model, or strong enough for improper aggregation.

### Proposed Atlas Summary

Do not change the status, evidence, assumptions, or witnesses. If the atlas
edge is edited later, I would use:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open under deterministic binary proper semantics: clean labels give a same-marginal weak proper learner, but reweighted boosting needs one original-marginal envelope over induced weak gaps. Same-marginal agnostic boosting avoids induced marginals only for stronger threshold/correlation oracles; the atlas fixed-additive OPT + 1/2 - gamma_P guarantee is merely low-noise. Rare-block counterexamples remain blocked by deterministic orientation and agnostic-source requirements."
```

Optional additional `ref_keys` for the edge, if the editor wants the body to
cite the agnostic-boosting near misses, are already present in
`references.bib`:

```yaml
  - freund1995boosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
```

### Proposed Atlas Body Text

```markdown
## Proof Status

**Goal.** Decide whether a deterministic proper weak agnostic learner with
marginal-dependent polynomial rates can be converted into a deterministic
improper strong realizable learner whose polynomial depends only on the
original marginal.

**Clean-label reduction.** On realizable labels, the agnostic benchmark error
is zero. The source therefore gives, for each marginal $P$, a proper weak
learner with error at most $1/2-\Gamma_P(s)$. Properness is not a final-output
obstacle, since the target is improper.

**Envelope gap for reweighted boosting.** Classical realizable boosting would
prove the edge if every booster-induced marginal $Q_t$ reached before target
accuracy $\varepsilon$ had weak gaps and resource bounds dominated by one
polynomial depending on the original $P$, $s$, $1/\varepsilon$, and
$\log(1/\delta)$. The source supplies a separate polynomial for each $Q_t$,
and the definition has no local-uniformity principle for smooth or
bounded-density perturbations of $P$.

**Same-marginal agnostic near miss.** Because the source is agnostic, one can
try to keep $X\sim P$ fixed and encode residuals by changing the conditional
label distribution. In correlation form the source only guarantees

$$
\langle r,h\rangle_P
\ge
\sup_{c\in\mathcal C_s}\langle r,c\rangle_P-1+2\Gamma_P(s).
$$

Thus it forces positive correlation only when the residual task is nearly
realizable. Feldman/Ghai-style distribution-specific agnostic boosting would
apply to a threshold or residual-responsive oracle with tunable slack, but the
atlas fixed-additive guarantee has a floor independent of the desired final
accuracy.

**False-witness obstruction.** Rare-block PRF or random-code templates suggest
target hardness under one fixed mixture marginal, but they must also satisfy
the source under every isolated block marginal and every low-noise labeling.
Local deterministic proper handles have to choose definite labels on unseen
mass; near-balanced orientation marginals make that choice require validation
at the orientation-gap scale. Stochastic off-sample neutralization would avoid
this, but it is a different output model.

**Conclusion.** The edge remains open pending an original-marginal boosting
envelope, a fixed-additive-to-residual-responsive same-marginal boosting
lemma, or a fully deterministic nonboostable-handle separation satisfying the
weak agnostic proper source.
```

### Final Recommendation

Keep the edge in `marginal-boosting-open`. The best atlas update would be a
clarifying rewrite, not a status change.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`
