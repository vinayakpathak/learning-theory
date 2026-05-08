# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- verdict: unresolved-open
- confidence: 0.86
- worker constraint: scratchpad only; no atlas files edited

## Executive Verdict

I do not see an atlas-ready proof or an atlas-ready counterexample. The edge
should remain `open`.

The source specializes immediately to marginal-nonuniform weak realizable
proper learning: on realizable labels, the agnostic benchmark error is zero.
Since the target is improper, proper outputs are allowed. Thus the whole edge
reduces to the marginal-nonuniform weak-to-strong realizable boosting problem:

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
-> efficient-marginal-nonuniform-realizable-improper-pac.
```

Classical Schapire/Freund boosting proves the analogous distribution-free
implication, but the current marginal-nonuniform source gives only pointwise
weak advantages for each marginal. The target needs one polynomial, depending
only on the original marginal $P$, that controls the whole strong learner.

The properness of the source does not currently help enough to resolve the
edge. It rules out some improper-source pathologies, but the target is
improper, so all proper weak hypotheses can be aggregated by the final learner.
The known proper-output witnesses therefore fail to separate this exact edge.

## Files And Sources Read

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/README.md`
- `atlas/registry/axes.yml`
- `atlas/registry/edge_families.yml`
- Neighboring scratchpad:
  `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`
- Primary sources checked online:
  [Feldman 2010](https://arxiv.org/abs/0909.2927),
  [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html),
  [da Cunha, Hogsgaard, and Paudice 2026](https://arxiv.org/abs/2601.11265),
  [Hanneke, Moran, and Thiessen 2025](https://openreview.net/forum?id=aoVCFtox89)

## Current Edge State

The edge note currently says:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - benedek1991fixed
summary: "Open: boosting from a marginal-nonuniform weak learner does not automatically give one marginal-dependent polynomial bound for the strong target."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

That posture is still justified, but the sharp obstruction should be stated in
terms of weak-advantage envelopes, not only runtime. The atlas pathwise runtime
convention plus a full-support reference marginal can often control the fixed
learner's transcript runtime. The hard part is that the weak gap may depend on
the induced marginal.

## Definitions In This Edge

The source gives one uniform learner $A$ such that, for every instance marginal
$P$, there are a marginal-dependent polynomial $p_P$ and a weak agnostic
tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

where $1/\gamma_P(s)$ is bounded by a marginal-dependent polynomial. For every
joint distribution $\mathcal D$ with marginal $P$, $A$ outputs a proper
$h\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

The target asks, for every marginal $P$, for a possibly improper learner with a
$P$-dependent polynomial $q_P$ such that, for every realizable target
$c\in\mathcal C$ and every $\varepsilon,\delta\in(0,1)$, it outputs $h$ with

$$
\operatorname{err}_P(h,c)\le \varepsilon
$$

using at most

$$
q_P(s,1/\varepsilon,\log(1/\delta))
$$

samples and time.

## Attempted Positive Proof

### Step 1: Reduction To Weak Realizable Proper Learning

On realizable labeled distributions, the agnostic optimum is zero. The source
therefore gives

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s)
$$

with $h\in\mathcal C$. Since the target permits improper output, this is also
a weak realizable improper learner. This part is just the existing monotone
relaxation edge

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
-> efficient-marginal-nonuniform-weak-realizable-proper-pac.
```

The unresolved subgoal is to boost this weak learner to arbitrary
$\varepsilon$ while preserving one polynomial attached only to the original
marginal $P$.

### Step 2: Standard Realizable Boosting Needs An Envelope

A Schapire/Freund style booster calls the weak learner on reweighted marginals
$Q_t$ that depend on $P$, the target $c$, previous weak hypotheses, and the
requested accuracy. The source gives a weak guarantee for each $Q_t$, but only
with a $Q_t$-dependent inverse-polynomial advantage $\gamma_{Q_t}(s)$.

The target would follow from the following extra condition:

**Transcript-envelope condition.** For every original marginal $P$, there is a
polynomial $r_P$ such that every booster-call marginal $Q_t$ appearing before
accuracy $\varepsilon$ satisfies

$$
\gamma_{Q_t}(s)\ge 1/r_P(s,1/\varepsilon).
$$

Then the usual boosting dependence on $1/\gamma^2$ and $\log(1/\varepsilon)$
would be absorbed into $q_P$. But the source definition only gives

$$
\forall Q\ \exists r_Q,
$$

not a single $r_P$ controlling the family of reweightings reachable from $P$.
This is the central missing positive theorem.

### Step 3: Same-Marginal Agnostic Relabeling Has A Fixed Floor

The agnostic source tempts a different route: keep the instance marginal fixed
at $P$ and modify only the conditional labels, as in distribution-specific
agnostic boosting.

Use labels and hypotheses in $\{\pm1\}$. Let the realizable target be $c$.
For a same-marginal relabeling call with

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1,
$$

the target concept $c$ has error $(1-\mathbb E_P a)/2$. Applying the source
guarantee with $\beta_P=1/2-\gamma_P$ gives

$$
\operatorname{err}(h)
\le
\frac{1-\mathbb E_P a}{2}+\beta_P.
$$

Equivalently,

$$
\mathbb E_P[a(X)1\{h(X)\ne c(X)\}]\le \beta_P.
$$

If $a=\lambda\,dQ/dP$, this implies

$$
\operatorname{err}_Q(h,c)\le \beta_P/\lambda.
$$

To get a weak hypothesis under $Q$, one needs $\lambda>2\beta_P$. Since
$a\le1$, the largest possible $\lambda$ is
$1/\|dQ/dP\|_\infty$. Thus this simulation only handles density ratios

$$
\|dQ/dP\|_\infty < \frac{1}{2\beta_P}
= \frac{1}{1-2\gamma_P(s)}.
$$

When the weak gap $\gamma_P(s)$ is small, this ratio is essentially $1$. It
cannot focus on the small residual regions that a strong realizable booster
eventually needs to learn below arbitrary $\varepsilon$.

This matches the literature check. Feldman's distribution-specific agnostic
boosting preserves the instance marginal, but it assumes a threshold-style weak
agnostic oracle. Ghai and Singh give an efficient unlabeled-data agnostic
booster in a related oracle model. The 2026 da Cunha-Hogsgaard-Paudice result
improves running time, but the arXiv abstract states polynomial time in the
sample size with other parameters fixed. That is not enough, by itself, for an
atlas-polynomial bound when the hidden weak parameters are inverse-polynomial
functions of $s$ and must be part of the final polynomial accounting.

### Step 4: Countable Diagonalization Is A Near-Proof Under Stronger Semantics

There is a tempting diagonal proof of the transcript envelope. If no
$P$-dependent envelope exists, choose booster-generated marginals $Q_d$ at
sizes $s_d$ with gaps below $s_d^{-d}$, then stitch these conditionals into one
diagonal marginal $R$. The source guarantee for $R$ would provide a single
polynomial gap, contradicting the choice of $Q_d$ for large $d$.

This would likely resolve the edge `true` under a size-conditional
interpretation of marginal-nonuniform accuracy: risk at size $s_d$ would be
evaluated on the active size slice, so the diagonal marginal would force a
single polynomial envelope.

I do not think this is safe under the current atlas wording. The README states
pathwise resource bounds but does not explicitly make risk size-conditional.
Under a global-mixture reading, each bad diagonal slice can receive small mass.
A weak learner can ignore low-mass bad slices and still satisfy the global
weak guarantee, because weak learning only needs error below about $1/2$.
Therefore the diagonal proof is a promising direction, not an atlas-ready
proof.

## Counterexample Search

### Halfspaces

Halfspaces do not separate this edge. They satisfy the source via realizable
proper learning plus low-noise weak agnostic robustification. They also satisfy
the target, since they are efficiently realizably properly PAC learnable
distribution-free. Tiegel-style hardness only refutes strong agnostic targets,
not realizable improper targets.

### One-Way Image-Coordinate Weak Handles

The one-way image-coordinate weak-handle class is the main nearby proper-output
witness. It satisfies the source: constants and singleton handles give weak
proper realizable learning, and the constants are legal proper concepts, so
the low-noise robustification remains proper.

It does not refute this target. The strong lower bound is a proper-output
lower bound: to output a valid seed concept under the fixed coordinate marginal
one must invert the one-way function. The present target is improper. An
improper learner can use sparse lookup/memorization for image-coordinate
targets and can handle the added constants and singleton concepts directly.
This is exactly why the witness separates strong proper learning but not
strong improper realizable learning.

### Fixed-k-Term DNF

Fixed-$k$-term DNF is a proper weak-to-strong proper separation family. It is
not a separation here because the target is improper. Classical distribution-
free realizable boosting can aggregate the weak proper hypotheses into an
improper strong predictor.

### PRF, Noisy-Parity, And Sample-To-Computational Hardness Classes

Pseudorandom-function and noisy-parity style classes are good candidates for
making strong efficient learning hard, but they usually make even weak
prediction hard under the relevant fixed marginal when $\operatorname{OPT}=0$
or very small. That attacks the source, so they are not source-positive
witnesses for this edge.

### PCP And Lookup Classes

PCP active-slice and lookup-table witnesses separate improper from proper
requirements, or weak improper from weak proper requirements. They do not give
this edge: either the proper weak source is not available, or the improper
target can memorize/evaluate the polynomial-size active slice.

### Rare-Slice Witness Schema

The most plausible false-witness template is a rare-slice direct sum:

$$
P=\sum_j \mu_j P_j.
$$

Weak learning under $P$ might ignore hard low-mass slices, while strong
learning to $\varepsilon\ll\mu_j$ would have to solve slice $j$.

The source quantifier over all marginals blocks the simple version. The source
must also hold for marginals concentrated on $P_j$ and on residual subsets of
slice $j$. A construction where slice $j$ has weak gap $s^{-j}$ is not
source-positive if a legal marginal can diagonalize by choosing larger and
larger $j$ across representation sizes. Conversely, if every isolated hard
slice has cheap polynomial-gap weak handles, then an improper final learner can
try to run the same handle finder on residual distributions and vote.

Thus a false witness would need computationally nonboostable weak handles:
one proper weak handle is easy under every marginal, but finding enough
handles for low-error improper prediction is hard. I do not know a standard
PAC, cryptographic, PCP, or lookup construction with this property.

## Proposed Atlas Posture

No status change is justified. I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

A sharper summary would be:

```yaml
summary: "Open: the source gives weak realizable proper learning under each marginal, but strong improper realizable boosting would need one original-marginal polynomial controlling weak advantages on booster-induced marginals. Same-marginal agnostic relabeling has a fixed-additive floor, and the known proper-output witnesses do not refute the improper target."
```

If the edge note is expanded, I would add the boosting references already used
by the shared argument note:

```yaml
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
```

Suggested body text:

```markdown
The source specializes to marginal-nonuniform weak realizable proper learning:
on realizable labels the agnostic optimum is zero, and the proper output is
allowed by the improper target. Standard realizable boosting would prove the
target if, for each original marginal $P$, the weak advantages on all
booster-induced marginals were bounded below by one $P$-dependent inverse
polynomial. The source only gives pointwise marginal guarantees.

The agnostic source is a near miss. Distribution-specific agnostic boosting can
preserve the instance marginal by relabeling examples, but available
Feldman/Ghai-style theorems require threshold or correlation weak oracles with
tunable additive slack. The atlas source gives only the fixed tolerance
`OPT + 1/2 - gamma_P`, which has too large a floor to simulate heavily focused
residual distributions.

Known false witnesses do not settle the edge. Halfspaces refute agnostic
targets but are realizably learnable. The one-way image-coordinate weak-handle
class refutes strong proper targets, but the present target is improper and can
use sparse lookup or aggregate weak handles.
```

## Concrete Obstacles

1. **Original-marginal envelope.** The source gives
   $\forall Q\,\exists r_Q$. Boosting needs a single $r_P$ controlling every
   reweighted marginal reachable from $P$ before final accuracy
   $\varepsilon$.

2. **Same-marginal relabeling floor.** The fixed additive guarantee
   `OPT + beta_P` only gives useful weighted error when the simulated
   reweighting has very small density ratio, essentially no focusing when
   $\beta_P$ is close to $1/2$.

3. **Diagonal proof semantics.** Countable diagonalization would be strong
   evidence for `true` under size-conditional risk, but under a global-mixture
   reading weak accuracy can ignore low-mass bad slices.

4. **Proper witnesses miss the improper target.** One-way image-coordinate
   weak handles force proper representation recovery. The target here can
   output arbitrary predictors, so sparse lookup and handle aggregation are
   available.

5. **Hard weak slices fail the source.** PRF/noisy-parity style hard cores can
   defeat strong learning, but they usually defeat weak source learning under
   marginals that isolate the hard slice.

## Promising Directions

1. Formalize a transcript-envelope lemma for a fixed smooth realizable booster.
   Prove or refute that marginal-nonuniform weak learnability forces one
   $P$-dependent inverse-polynomial lower bound on all booster-call marginals.

2. Pin down the atlas semantics for representation-size slices. If risks are
   intended to be size-conditional, the diagonal-envelope proof may resolve
   the edge `true`.

3. Prove a black-box barrier for same-marginal reductions using only an
   `OPT + beta_P` weak oracle. The calculation above is a concrete starting
   point.

4. Search for a nonboostable proper weak-handle class: every marginal admits an
   easy proper weak handle, but arbitrary improper aggregation to low error is
   computationally hard.

5. Recheck future agnostic boosting results for a fully polynomial,
   marginal-preserving theorem whose runtime is polynomial in the weak
   parameters, $1/\varepsilon$, and the weak learner's own resource bound.

## Final

verdict: unresolved-open

confidence: 0.86

## Depth 2 Followup: Fixed-Marginal Boosters And Nonboostable Handles

- depth: 2
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited

### Reframed Subproblem

The source-to-target reduction still normalizes to one question. On realizable
labels, the source learner $A$ gives a proper weak learner for every marginal
$R$, but with an $R$-dependent gap

$$
\gamma_R(s)=1/2-\beta_R(s).
$$

For this edge, the target is only marginal-nonuniform, so a proof does not need
a distribution-free lower bound on all $\gamma_R$. It needs the weaker envelope:
for each original marginal $P$, there is a polynomial $r_P$ controlling every
marginal that the final strong learner uses before reaching accuracy
$\varepsilon$.

For a fixed smooth realizable booster, a sufficient condition is:

$$
\inf\{\gamma_Q(s):
Q \text{ is a booster-call marginal reachable from } P
\text{ before accuracy } \varepsilon\}
\ge \frac{1}{r_P(s,1/\varepsilon)}.
$$

Then the usual $O(\gamma^{-2}\log(1/\varepsilon))$ weak-to-strong analysis and
the full-support transcript resource bound would give the target. I do not see
a derivation of this envelope from the source definition. The source still only
says $\forall Q\,\exists r_Q$, and the reachable $Q$'s may depend on the
target concept, previous weak hypotheses, and the requested accuracy.

### Same-Marginal Agnostic Boosting Rechecked

The best positive hope is to avoid reweighted marginals entirely. Feldman-style
distribution-specific boosting keeps $X\sim P$ fixed and changes only the label
distribution. Ghai-Singh's unlabeled-data line is also relevant because its
motivation is fixed-marginal agnostic boosting.

The atlas source can be written in correlation form as

$$
\operatorname{corr}_{\mathcal D}(h,Y)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c,Y)-2\beta_P(s).
$$

Equivalently, for a fixed $P$, it is a nontrivial correlation weak oracle with
parameters $\gamma_0=1$, $\varepsilon_0=2\beta_P(s)$, and nontriviality margin
$\theta_P(s)=1-\varepsilon_0=2\gamma_P(s)$.

This observation improves the earlier diagnosis but does not resolve the edge.
The marginal-preserving Feldman/Ghai-style theorems need a tunable slack or
threshold at the final accuracy scale. In the same notation, their final excess
terms force $\varepsilon_0=O(\varepsilon)$, or a threshold
$\alpha=O(\varepsilon)$. The atlas source has a fixed
$\varepsilon_0=1-2\gamma_P(s)$, usually close to $1$, so those algorithms still
hit the fixed-additive floor.

The direct relabeling calculation remains the clean barrier. If a same-marginal
call uses

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1,
$$

then the source gives

$$
\mathbb E_P[a(X)\mathbf 1\{h(X)\ne c(X)\}]\le \beta_P(s).
$$

To simulate $Q$ with $a=\lambda\,dQ/dP$, one gets

$$
\operatorname{err}_Q(h,c)\le \beta_P(s)/\lambda.
$$

This is weak under $Q$ only if $\lambda>2\beta_P(s)$, while
$\lambda\le 1/\|dQ/dP\|_\infty$. Thus same-marginal relabeling can only mimic
density ratios below

$$
\frac{1}{2\beta_P(s)}=\frac{1}{1-2\gamma_P(s)},
$$

which is essentially no focusing when the weak gap is small.

### The 2026 Fixed-Additive Booster Is A Near Miss

The 2026 da Cunha-Hogsgaard-Paudice result is important because it can use a
nontrivial correlation weak learner with large $\varepsilon_0$; unlike the
older marginal-preserving algorithms, it does not require
$\varepsilon_0=O(\varepsilon)$. This is exactly the kind of theorem one would
want for the fixed-additive atlas source.

It still does not settle this edge for two reasons.

First, the stated running time is polynomial in the final sample size only when
the weak-learner parameters are fixed. The theorem's explicit bound contains
exponents depending on the weak sample size $m_0$ and on $1/\theta^2$. In the
atlas source, $m_0$ and $1/\theta_P(s)$ may be $P$-dependent polynomials in the
representation size $s$. A runtime like

$$
n^{O(m_0/\theta_P(s)^2)}
$$

is generally not polynomial in $(s,1/\varepsilon,\log(1/\delta))$.

Second, the proof route is not a purely same-marginal oracle simulation. It
uses hypotheses obtained from many subsamples and effectively needs weak
behavior on empirical/reweighted distributions over the clean part of the
sample. For the marginal-nonuniform atlas source, those empirical marginals
again have their own hidden gaps and resource polynomials. Without a
$P$-dependent envelope over those marginals, the theorem cannot be inserted as
a black box.

So the recent literature narrows the obstruction: fixed-additive weak agnostic
learning may be boostable in principle, but the available fully general
fixed-additive booster is not an atlas-polynomial marginal-preserving
conversion.

### Fixed Smooth Realizable Boosters Still Need The Envelope

A smooth realizable booster softens the reweighting problem by keeping
$dQ_t/dP$ bounded, say by a function $B_t=\operatorname{poly}(1/\varepsilon)$.
But bounded density does not imply a polynomial weak-gap envelope. A fixed
global marginal can contain slices $S_j$ with $P(S_j)\approx 1/B_j$ and weak
gaps on $P(\cdot\mid S_j)$ of order $s^{-j}$. Smoothness only delays the time
at which the booster can focus on $S_j$; it does not force
$\gamma_{P(\cdot\mid S_j)}$ to be bounded below by one $P$-dependent polynomial
unless that stability is assumed separately.

The countable diagonal proof would resolve this positively under a
size-indexed marginal semantics: stitch the bad $Q_j$ into one marginal family
and contradict the source polynomial for that family. Under the current
weighted-global reading, the bad slices can have tiny mass, and a weak
additive guarantee may ignore them. That is why the diagonal proof remains a
schema-level direction rather than an atlas-ready proof.

### Source-Positive False Witness Search

A false witness for this exact edge must be more delicate than a rare hard
slice. Since the source quantifies over all marginals, including marginals
conditioned on a hard slice or residual set, the hard part must remain weakly
agnostically and properly learnable there. Since the target is improper, any
proper weak handle found by the source can be aggregated by the final learner.

The needed object is therefore a source-positive nonboostable handle family:

1. one fixed-polynomial transcript-wise learner finds a proper weak handle
   under every marginal;
2. on slice $j$, the handle advantage may be as small as $s^{-j}$, but the
   runtime for finding one handle cannot have exponent $j$;
3. under some original marginal $P$, learning to $\varepsilon$ forces attention
   to slices with unbounded $j$, so no single $P$-polynomial strong learner is
   available;
4. finding enough independent handles, or predicting the residual after a few
   handles, remains computationally hard even for improper output.

The standard candidates still fail one of these requirements. PRF, LPN, and
random-code slices make strong prediction hard but usually destroy weak
prediction on the residual marginal. One-way image-coordinate weak handles are
source-positive, but the lower bound is for proper recovery; an improper learner
can memorize sparse positive atoms or aggregate the singleton handles. PCP and
lookup witnesses either make the proper weak source fail or leave the improper
target easy by table lookup on the active slice.

The closest toy model is an addressed-code slice with $N=s^j$ coordinates:
one observed coordinate gives a proper handle of advantage about $1/N$, while
strong prediction would require many coordinates or prediction of unseen
coordinates. This is not yet source-positive. An agnostic
`OPT + 1/2 - \Omega(1/N)` guarantee appears to require validating among
$N$ possible handles, which costs the forbidden slice-dependent exponent. If a
single noisy handle can be found cheaply under every residual marginal, a slow
improper booster can reuse that same finder.

### Depth 3 Directions

1. Formalize the $P$-envelope for one named smooth booster. Characterize exactly
   which capped density marginals can occur before accuracy $\varepsilon$, then
   try either to prove a $P$-dependent lower bound or to build a bounded-density
   diagonal obstruction inside that family.

2. Recheck whether any fixed-additive agnostic booster is both
   marginal-preserving and polynomial in $(m_0,1/\theta,1/\varepsilon)$ rather
   than polynomial in the sample size with $m_0/\theta^2$ in the exponent. Such
   a theorem would likely prove this edge true.

3. Turn the same-marginal relabeling calculation into a formal black-box
   barrier: an `OPT + beta_P` oracle cannot simulate residual distributions
   whose density ratio exceeds $1/(2\beta_P)$ by label randomization alone.

4. Try a relativized addressed-code construction before a concrete PAC class.
   The oracle should certify one cheap agnostic proper handle under every
   residual marginal, while forcing any polynomially bounded improper learner
   to fail on some slice requiring too many independent handles.

5. Decide the representation-size marginal convention. A size-conditional
   convention favors a true diagonal-envelope theorem; the current
   weighted-global convention leaves the edge open and demands a genuine
   nonboostable-handle witness for false.

### Depth 2 Verdict

verdict: unresolved-open

confidence: 0.88

## Depth 3 Followup: Relativized Rare-Block Handle Barrier

- depth: 3
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited

### Verdict Of This Pass

I still would not change the atlas edge from `open`, but the best false
direction is now sharper: there is a credible relativized rare-block
construction in which every marginal has a proper weak agnostic handle, while
one fixed original marginal defeats every polynomial-time improper strong
learner. This is not yet a concrete PAC witness because it uses oracle-random
block labels, but it is a real black-box obstruction to any proof that only
boosts the promised weak learner.

The construction also explains why the improper target does not automatically
save the edge. Improper aggregation can collect singleton handles, but on the
hard blocks it needs polynomially many handles in the block size
$N=n^j$. The original marginal can hide blocks with unbounded $j$ at small
mass, so no one polynomial attached to that original marginal covers all
accuracy requests.

### Oracle Construction Sketch

Work relative to a random oracle. The instance space is partitioned into finite
blocks

$$
B_{n,j}=\{(n,j,i): i\in[N_{n,j}]\},\qquad N_{n,j}=n^j,
$$

for $n,j\ge1$. For each seed $z\in\{0,1\}^n$, the oracle chooses an independent
balanced subset $S_{n,j,z}\subseteq[N_{n,j}]$.

The concept class contains:

1. the block concepts
   $c_{n,j,z}(n',j',i)=1$ iff $(n',j')=(n,j)$ and $i\in S_{n,j,z}$;
2. the two constants;
3. every singleton atom $a_{n,j,i}$.

The intended representation size of $c_{n,j,z}$ is $s\asymp n+j$ plus the seed
length. For a fixed block marginal on $B_{n,j}$, the degree $j$ may be absorbed
into that marginal's polynomial, so a runtime $n^j$ is still
marginal-nonuniform polynomial. For the hard original marginal below, however,
$j$ ranges over all integers and cannot be absorbed into one polynomial.

### Why The Source Is Plausible

Fix an arbitrary marginal $R$. A proper weak learner uses validation over a
small candidate set: constants and singleton atoms observed in the sample.

If the active target block has small $R$-mass, one of the constants is already
within a constant weak tolerance. More precisely, the target block is the only
place where a block concept can be nonzero. If that block has mass bounded away
from $1$, the all-zero hypothesis makes only the positive-block error, while
the all-one hypothesis covers the opposite imbalance. A fixed constant gap is
available unless the block carries enough mass and is balanced enough that a
local handle is needed.

Only finitely many blocks of $R$ can be heavy. For example, there are at most
four blocks with $R(B_{n,j})\ge1/4$. Let $d_R$ be the maximum $j$ among those
heavy blocks, or $1$ if there are none. On a heavy block $B_{n,j}$, a target
positive set has a heaviest positive atom of mass at least
$\Omega(R(B_{n,j})/N_{n,j})$. Sampling and validation find a useful singleton
in time polynomial in $N_{n,j}\le s^{d_R}$ for the relevant target size.

The same argument can be made weak-agnostic at the fixed-additive level. If
the best concept has error at least the intended weak gap, a validated constant
or any hypothesis with error at most $1/2$ is enough for
`OPT + 1/2 - gamma_R`. If the best concept has error below that gap, the labels
are nearly realizable on the heavy block, so a heavy low-noise positive atom
exists and a singleton handle gives advantage $\Omega(1/N_{n,j})$.

Thus each marginal $R$ gets a polynomial weak gap such as

$$
\gamma_R(s)\ge s^{-O(d_R)}.
$$

The uniform learner is the same for all $R$; only the analysis polynomial
changes with the marginal. This matches the source's marginal-nonuniform
quantifiers.

### Why The Improper Target Fails Relativized

Define one fixed original marginal $P$ by putting mass

$$
w_{n,j}=Z^{-1}\,2^{-j}n^{-2}
$$

on block $B_{n,j}$ and then distributing it uniformly inside the block.
Every individual block has small mass, so for this $P$ the weak source can
usually ignore the block and use a constant. Hence $P$ itself has a small
degree weak polynomial.

Now consider the target $c_{n,j,z}$ and ask for accuracy

$$
\varepsilon_{n,j}=w_{n,j}/16.
$$

Any hypothesis with total $P$-error at most $\varepsilon_{n,j}$ must have
conditional error at most $1/16$ on $B_{n,j}$. Since the oracle labels on
$B_{n,j}$ are random subject only to balance, an improper learner that has not
seen or queried a constant fraction of the $N_{n,j}=n^j$ atoms cannot predict
the unseen atoms with conditional error below a constant. A standard
coupon/no-free-label argument gives a lower bound

$$
\Omega(N_{n,j}/w_{n,j})
$$

labeled examples, up to constants.

Let $q_P(s,1/\varepsilon,\log(1/\delta))$ be any proposed target polynomial,
and let $D$ bound its total degree in $s$ and $1/\varepsilon$. For fixed $j$,

$$
q_P(s,1/\varepsilon_{n,j},O(1))
\le C_j n^{3D}
$$

because $1/\varepsilon_{n,j}=\Theta(2^j n^2)$. The sample lower bound is

$$
\Omega(N_{n,j}/w_{n,j})
=\Omega(2^j n^{j+2}).
$$

Choose $j>3D$ and then take $n$ large. The lower bound exceeds the proposed
polynomial. Since $q_P$ was arbitrary, no marginal-dependent polynomial works
for this fixed $P$.

This defeats improper learners, not only proper learners. The learner may
output an arbitrary table or vote of singleton handles, but it must still
learn a constant fraction of a random balanced block. One handle covers one
atom; there is no hidden seed structure that an improper hypothesis can exploit.

### Relation To Boosting

The weak learner is perfectly boostable on a fixed conditioned block
$B_{n,j}$ if its polynomial is allowed to have degree depending on that block:
one can find enough singleton handles in time roughly $n^j$. The failure is
exactly the marginal-envelope failure. The original $P$ contains all levels
$j$, and strong accuracy requests can force conditioning on a block whose
required handle count has degree larger than the degree of any proposed
$P$-polynomial.

This also clarifies why smooth boosters do not close the edge by themselves.
Even if the booster only reaches a block after paying a density cap about
$1/w_{n,j}$, the number of independent handles needed inside the block is
$N_{n,j}=n^j$. The accuracy parameter exposes the block mass through
$1/\varepsilon=\Theta(1/w_{n,j})$, but it does not expose the unbounded exponent
$j$ as a fixed polynomial degree.

### What Is Missing For An Atlas Counterexample

The oracle sketch must be replaced by a concrete efficiently evaluable concept
family. Random block concepts are doing two jobs that a real witness would have
to reproduce:

1. a singleton observed from samples is always a legal proper weak handle;
2. unseen labels on a hard block remain unpredictable even to an improper
   polynomial-time learner.

Cryptographic PRF blocks give the second property, but they usually destroy
the first because weak prediction on a conditioned hard block becomes hard.
One-way image-coordinate handles give the first property, but they lose the
second for improper learners because sparse lookup/memorization suffices on
the positive coordinates. The new target is therefore a hybrid: random-code
unpredictability plus sample-discoverable proper handles.

### Restricted Positive Theorem

The positive side can now be stated cleanly. A fixed realizable booster proves
the edge for any class satisfying the following extra local-envelope condition:
for every original marginal $P$ and every accuracy $\varepsilon$, all
booster-call marginals $Q$ that are reachable before accuracy $\varepsilon$
have weak gaps

$$
\gamma_Q(s)\ge 1/r_P(s,1/\varepsilon)
$$

for one polynomial $r_P$ depending only on $P$. Under this condition, standard
realizable boosting and improper voting give an
efficient-marginal-nonuniform-realizable-improper learner with polynomial
overhead in $r_P$ and $\log(1/\varepsilon)$.

The oracle construction above is designed precisely to violate this condition:
conditioning on $B_{n,j}$ gives $\gamma_Q(s)\asymp s^{-j}$ for unbounded $j$,
while the original marginal $P$ has no polynomial envelope over all those
conditioned blocks.

### Depth 3 Verdict

verdict: unresolved-open for the atlas edge; relativized evidence against a
black-box boosting proof

confidence: 0.90 that the current atlas `open` status is still the right
posture; 0.72 that a concrete false witness, if it exists, should look like the
rare-block random-code/handle hybrid above

## Depth 4 Branch: agnostic-source marginal boosting to realizable

The tempting positive move is now very sharp. Since the source is agnostic
rather than merely realizable, perhaps one can avoid reweighted booster
marginals entirely. Keep drawing $X\sim P$, generate artificial labels whose
conditional law depends on the current ensemble and the true realizable labels,
call the source learner on this same instance marginal $P$, and aggregate the
proper hypotheses. This is exactly the structural promise of distribution-
specific agnostic boosting: Feldman keeps the domain marginal fixed and changes
only the label distribution, while Ghai and Singh improve the labeled-sample
economics in a setting where unlabeled samples from the fixed marginal are
available essentially for free.

This route would be decisive if the atlas source were a Feldman-style weak
agnostic oracle. It is not. The source is a fixed-additive oracle:

$$
\operatorname{err}(h)\le \Delta_{\mathcal C}+\beta_P,
\qquad
\beta_P=1/2-\gamma_P.
$$

In correlation notation, for labels $Y\in\{\pm1\}$ and proper hypotheses
$g\in\mathcal C$, let

$$
A^\star=\sup_{g\in\mathcal C}\mathbb E[Yg(X)].
$$

The guarantee only implies

$$
\mathbb E[Yh(X)]\ge A^\star-1+2\gamma_P.
$$

Thus the call gives a positive-correlation hypothesis only when
$A^\star>1-2\gamma_P$. This is a low-noise or nearly-realizable guarantee, not
a weak agnostic guarantee that recovers a polynomial fraction of whatever
advantage $A^\star$ is currently present.

Feldman's algorithm needs the latter kind of oracle. In his notation an
$(\alpha,\gamma)$ weak agnostic learner must return error at most
$1/2-\gamma$ whenever the best concept has error at most $1/2-\alpha$, and
the booster has running time polynomial in $1/\gamma$ and $1/\varepsilon$.
The theorem is distribution-specific because these calls preserve the same
domain marginal $D$, but the hypothesis-producing oracle must still work when
the best available advantage is only $\alpha$. The paper explicitly phrases
the useful weak agnostic condition as recovering at least a polynomial fraction
of the best advantage, not merely having one fixed additive tolerance near
$1/2$. See Feldman 2010, Theorem 1.1 and the definitions around weak agnostic
advantage: [arXiv:0909.2927](https://arxiv.org/abs/0909.2927).

The mismatch already appears at the first gradient-style call. Feldman's
same-marginal booster may call the weak learner on a randomized label
distribution whose conditional expectation is proportional to the residual,
for instance $(c-h_t)/2$. Even when the original target $c$ is perfectly
realizable, this artificial label distribution is not close to realizable by a
concept in $\mathcal C$. At $h_t=0$, the best correlation can be only $1/2$ in
the scaled-label view. A fixed-additive source with small inverse-polynomial
$\gamma_P$ gives no nontrivial output from such a call, because it only
guarantees positive correlation when the best correlation is almost $1$.

The same obstruction can be stated in the rare-block language. Suppose a
same-marginal relabeling tries to make the weak learner pay attention to a
block $B$ of $P$-mass $w$. Any label signal supported mainly on $B$ has global
best advantage at most $O(w)$ unless the rest of the space is also labeled in
a way that remains close to some concept. Feldman/Ghai-type boosting can use
such a weak signal if the oracle returns a hypothesis with advantage
poly$(w)$. The atlas fixed-additive source may return nothing useful unless
the pseudo-label distribution is already within about $\gamma_P$ error of
being realizable by $\mathcal C$. For the hidden-gap construction, the strong
accuracy request is exactly what forces attention onto rare blocks whose
global signal is too small for this fixed-additive promise.

Ghai and Singh's unlabeled-data result does not change this point. Its benefit
is that agnostic boosting can match ERM-style labeled sample complexity while
using polynomially many additional unlabeled samples, and the paper notes that
this is natural in distribution-specific settings. But unlabeled access to
$P$ helps estimate and reuse the marginal; it does not upgrade the atlas source
from

$$
\Delta+\left(1/2-\gamma_P\right)
$$

to an oracle that, whenever $A^\star\ge \alpha$, returns advantage
poly$_P(\alpha,1/s)$. The missing ingredient is still quantitative
responsiveness to the current residual advantage.

So the agnostic source helps conceptually but not enough for an atlas theorem.
It explains the exact strengthening that would resolve the edge positively:
for every original marginal $P$, require a polynomial $r_P$ such that every
same-marginal pseudo-label distribution with best concept advantage at least
$\alpha$ yields a proper hypothesis of advantage at least
$1/r_P(s,1/\alpha)$. Under that strengthened source, Feldman's
distribution-specific boosting, with the modern Ghai-Singh sample refinements
as optional bookkeeping, would give a marginal-nonuniform strong improper
realizable learner. The current source lacks this $\alpha$ parameter.

### Depth 4 Verdict

verdict: unresolved-open; the agnostic source does not by itself close the
edge, because same-marginal agnostic boosting requires a residual-responsive
weak agnostic oracle, while the atlas source supplies only a fixed-additive
near-realizable guarantee

confidence: 0.91 that Feldman/Ghai do not imply this atlas edge as stated;
0.80 that a positive theorem should be possible under the strengthened
same-marginal advantage-envelope condition above; 0.68 that the relativized
rare-block barrier remains the right negative model

next branches:

- Formalize the fixed-additive-to-correlation lemma as a reusable obstruction:
  $\Delta+\beta_P$ gives output advantage at least $A^\star-1+2\gamma_P$ and
  is useless on small residual signals.
- Check whether Feldman's low-weight threshold application, where strong PAC
  learning of $\operatorname{TH}(W,\mathcal C)$ follows from agnostic learning
  of $\mathcal C$, gives any special closure condition under which this edge
  becomes true.
- Search for a concrete rare-block class whose proper weak agnostic learner is
  source-positive for every marginal but whose strong improper realizable
  learner still faces the block-by-block hidden exponent.

## Depth 5 Followup: Residual Responsiveness And Advice Dependence

- depth: 5
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited

### Verdict Of This Pass

verdict: unresolved-open

The agnostic source removes one superficial obstruction: a learner satisfying
the source may be called on arbitrary noisy labels with the same instance
marginal $P$. That makes Feldman-style same-marginal boosting structurally
available. It does not remove the weak-gap obstruction recorded in this edge,
because the atlas weak agnostic guarantee is fixed-additive rather than
residual-responsive.

For a positive proof, a same-marginal booster would need the following kind of
oracle. Given a pseudo-label distribution with regression/residual signal $r$
over the original marginal $P$, if

$$
A^\star(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P\ge \alpha,
$$

then the oracle should return a proper $h\in\mathcal C_s$ with

$$
\langle r,h\rangle_P\ge 1/r_P(s,1/\alpha)
$$

or at least a polynomial fraction of $\alpha$. This is the
residual-responsive condition that lets a boosting potential keep decreasing
until the remaining realizable error is at most $\varepsilon$.

The source gives only

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s).
$$

In $\{\pm1\}$ notation this implies

$$
\langle r,h\rangle_P\ge A^\star(r)-1+2\gamma_P(s).
$$

Thus the output is guaranteed to have positive correlation only in the
low-noise regime $A^\star(r)>1-2\gamma_P(s)$. It is not a response to a small
but polynomial residual advantage. The same hidden weak gap has therefore
reappeared as a missing $\alpha$ parameter.

### Fixed-Additive Gaps Do Not Drive Residual Boosting

On realizable labels, the source specializes cleanly to weak proper learning:
$\operatorname{OPT}=0$, so the learner returns error at most
$1/2-\gamma_P(s)$. If standard realizable boosting could call the learner on
all its reweighted marginals with one $P$-dependent lower bound on the
resulting gaps, the edge would be true.

The agnostic same-marginal route tries to replace those reweighted marginals
by pseudo-labels under the original $P$. But after the first few rounds, the
pseudo-label problem seen by a gradient or residual booster is usually not
nearly realizable by $\mathcal C$. Its best correlation is the current
residual advantage, often of order the mass of the remaining hard region or
the current error. A fixed-additive oracle can legally return a useless
hypothesis whenever this advantage is below $1-2\gamma_P(s)$, even if the
advantage is still polynomially detectable and sufficient for Feldman/Ghai
style boosting.

This also explains why low-weight threshold closure is not enough by itself.
The target is improper, so a final majority or threshold of proper weak
hypotheses would be allowed. Feldman's threshold applications become relevant
if the source can agnostically learn $\mathcal C$ with the threshold/correlation
oracle strength needed at each residual scale. The atlas source is weaker:
it can certify one low-noise weak handle, but it does not promise the
sequence of residual handles needed to build the threshold predictor.

### Same-Marginal Low-Noise Conversion Is Only A Weak Wrapper

The low-noise robustification note gives the right intuition for why
realizable weak learning implies a weak agnostic learner under the same
marginal. In the high-noise branch, constants or neutral hypotheses are enough
for a weak target. In the low-noise branch, the data are close enough to a
realizable distribution that a clean weak learner remains useful.

For this edge, the target is strong realizable learning. A boosting proof
cannot stop at a high-noise neutralizer, because the remaining residual mass is
exactly what must be reduced below arbitrary $\varepsilon$. Once the residual
pseudo-label distribution is no longer low-noise with respect to a single
concept in $\mathcal C$, the fixed-additive source gives no descent guarantee.
Iterating the low-noise wrapper therefore does not become a strong learner;
the wrapper has no mechanism forcing attention onto the residual set.

The earlier density-ratio calculation is the same issue in another language.
To simulate a reweighted marginal $Q$ while keeping $X\sim P$, use labels with
conditional expectation

$$
\mathbb E[Y\mid X=x]=\lambda\,\frac{dQ}{dP}(x)c(x).
$$

The fixed-additive guarantee only yields

$$
\operatorname{err}_Q(h,c)\le \frac{\beta_P(s)}{\lambda}.
$$

This is weak under $Q$ only when $\lambda>2\beta_P(s)$. Since
$\lambda\le 1/\|dQ/dP\|_\infty$ and
$2\beta_P(s)=1-2\gamma_P(s)$, the allowed focusing factor is essentially
$1+O(\gamma_P(s))$ when the hidden weak gap is small. Same-marginal
randomized labels preserve the original marginal, but they do not create the
bounded-density envelope needed for ordinary boosting.

### Advice Dependence Is Still The Marginal-Nonuniform Bottleneck

There is also a nonuniformity issue that a same-marginal proof must handle
carefully. The atlas source has one uniform algorithm, while the polynomial
$p_P$ and gap $\gamma_P$ may depend on $P$ only in the analysis. The learner is
not given $P$, $\gamma_P$, an exponent for $p_P$, or a list of residual scales
as advice.

A successful marginal-nonuniform strong learner may likewise have an
analysis polynomial depending on $P$, so it need not know the polynomial in
advance. Standard dovetailing can hide unknown constants if every candidate
schedule eventually makes monotone progress and validation detects success.
The obstacle is that current same-marginal reductions do not merely have an
unknown schedule; they need a premise that may be false. They need that for
every residual advantage $\alpha$ encountered before accuracy $\varepsilon$,
the weak learner returns advantage at least inverse-polynomial in
$(s,1/\alpha)$ under the same original $P$.

The source permits marginals where the realizable gap $\gamma_P(s)$ is
inverse-polynomial but arbitrarily small, and it says nothing about the
response curve

$$
\alpha\mapsto
\inf\{\langle r,A(r)\rangle_P : A^\star(r)\ge \alpha\}.
$$

Without a $P$-dependent polynomial lower bound on that curve, a booster cannot
know, validate, or search its way to a polynomial runtime. This is the same
advice-dependence problem as the reweighted-marginal envelope, translated
from "which induced marginals have which gaps" to "which residual signals have
which usable correlations."

### Current Obstacles

1. **Residual-responsive oracle missing.** The source guarantees
   $\langle r,h\rangle_P\ge A^\star(r)-1+2\gamma_P(s)$, not a polynomial
   fraction of $A^\star(r)$.

2. **Fixed-additive floor.** The guarantee is meaningful for strong residual
   descent only when the pseudo-label problem is nearly realizable by
   $\mathcal C$; residual boosting must work far below that regime.

3. **Low-noise conversion stops too early.** Same-marginal low-noise
   robustification proves weak agnostic learnability, but its high-noise
   branch is a neutral weak fallback, not a way to reduce residual error to
   arbitrary $\varepsilon$.

4. **Same-marginal focusing is too weak.** Randomized labels can simulate
   only density ratios below about $1/(2\beta_P)=1/(1-2\gamma_P)$, which is
   essentially no focusing for small hidden gaps.

5. **Advice dependence remains.** A positive theorem must produce one
   $P$-dependent polynomial for all residual scales without giving the learner
   the hidden weak gap, the response curve, or a residual schedule as advice.

6. **No concrete false witness yet.** The rare-block oracle model captures the
   obstruction, but a real atlas counterexample still needs a source-positive
   class where every marginal has cheap proper weak agnostic handles while
   some original marginal makes strong improper prediction require
   unboundedly many independent handles.

### Concrete Depth-6 Directions

1. Prove a formal black-box lower bound for fixed-additive same-marginal
   oracles: construct residual signals with $A^\star=\alpha$ on which every
   oracle satisfying only `OPT + 1/2 - gamma` may return zero or negative
   useful correlation unless $\alpha>1-2\gamma$.

2. Isolate a positive theorem under a named strengthened source:
   residual-responsive marginal-nonuniform weak agnostic proper learning
   implies efficient marginal-nonuniform realizable improper learning. The
   proof should use Feldman-style distribution-specific boosting and state the
   exact polynomial dependence on $r_P(s,1/\alpha)$.

3. Test whether any known fixed-additive agnostic booster has runtime
   polynomial in the weak learner's sample/time bound, $1/\gamma_P$, and
   $1/\varepsilon$, rather than with the weak sample size or $1/\gamma_P$ in
   an exponent. Such a theorem would be the most direct route to
   `resolved-true`.

4. Turn the rare-block oracle sketch into a concrete representation class:
   combine sample-discoverable legal proper handles with unpredictability of
   unseen labels for improper predictors, while preserving the weak agnostic
   source on marginals concentrated on one block.

5. Analyze whether validation/dovetailing can remove advice dependence for a
   residual-responsive oracle with unknown $P$-polynomial. If yes, separate
   the harmless "unknown polynomial" issue from the substantive missing
   response-curve issue.

6. Check closure under low-weight thresholds for special classes. If
   $\mathcal C$ is closed under the threshold aggregations produced by a
   same-marginal booster, the edge may become true for that subclass even
   though the general atlas edge remains open.

### Depth 5 Verdict

verdict: unresolved-open

confidence: 0.92 that the current agnostic source does not remove the
same-marginal weak-gap obstruction; 0.84 that a residual-responsive
strengthening would resolve the edge true; 0.70 that any false witness must
look like a rare-block/nonboostable-handle construction rather than a standard
properness or cryptographic hardness example

## Depth 6 Final Attempt: Fixed-Additive Weak Gaps Versus Residual Boosting

- depth: 6
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited

### Final Verdict

verdict: unresolved-open

I do not see a sound atlas theorem in either direction. The strongest final
conclusion is negative for the natural proof route, not negative for the edge:
the agnostic source does not supply residual-responsive same-marginal boosting.
Its fixed-additive weak gap is enough to certify a weak handle when the current
labeling problem is nearly realizable, but it can become completely silent on
the smaller residual signals that a strong realizable improper learner must
keep reducing.

So the recommended atlas posture is to keep

```yaml
status: "open"
evidence: unknown
family: marginal-boosting-open
```

and, if the edge note is revised, to sharpen the summary away from generic
"reweighted marginals only" language. The current best summary is:

```yaml
summary: "Open: the agnostic source can be queried on same-marginal noisy labels, but its fixed-additive OPT + 1/2 - gamma_P guarantee is not residual-responsive. Same-marginal boosting would need polynomial correlation at every residual scale, while reweighted realizable boosting would need one original-marginal polynomial envelope over booster-induced marginals."
```

### Last Positive Attempt

The source gives one uniform proper learner $A$. For every marginal $P$, there
is a $P$-dependent polynomial resource bound and a $P$-dependent weak gap
$\gamma_P(s)>0$ with inverse-polynomial lower bound, such that on every joint
distribution with instance marginal $P$,

$$
\operatorname{err}(A)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s).
$$

Restricting to realizable labels immediately gives a marginal-nonuniform weak
proper learner under $P$. If this weak learner could be boosted while retaining
one polynomial depending only on the original marginal $P$, the target would
follow, and the final hypothesis could be the usual improper majority vote.

There are two possible boosting routes.

1. **Reweighted-marginal route.** Run a Schapire/Freund-style realizable
   booster. This asks $A$ to learn under induced marginals $Q_t$ that depend on
   the target concept and the previous weak hypotheses. The source supplies a
   weak gap for each $Q_t$ separately, but it does not supply one
   $P$-dependent polynomial lower bound on all those gaps. This is the original
   marginal-boosting envelope problem.

2. **Same-marginal agnostic route.** Keep $X\sim P$ fixed and encode the
   current residual, weighting, or gradient in randomized labels. This is the
   route suggested by Feldman-style distribution-specific agnostic boosting and
   by the later unlabeled-data agnostic boosting refinements. It avoids the
   reweighted-marginal runtime envelope, because every call has marginal $P$.

The second route is the one this pass tried hardest to close. It fails on the
weak-gap semantics.

### The Same-Marginal Calculation

Use $\{\pm1\}$ labels. For a same-marginal pseudo-label distribution, write

$$
r(x)=\mathbb E[Y\mid X=x]
$$

and define the best achievable correlation by concepts in the size-$s$ class as

$$
A^\star(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P.
$$

For any hypothesis $h$,

$$
\operatorname{err}(h)=\frac{1-\langle r,h\rangle_P}{2},
\qquad
\operatorname{OPT}_{\mathcal C}
=\frac{1-A^\star(r)}{2}.
$$

The source guarantee therefore implies only

$$
\langle r,h\rangle_P
\ge A^\star(r)-1+2\gamma_P(s).
$$

This is the decisive obstruction. If the best residual correlation is
$A^\star(r)=\alpha$, the guarantee is positive only when

$$
\alpha>1-2\gamma_P(s).
$$

For small hidden gap $\gamma_P(s)$, this means the pseudo-label problem must be
almost perfectly realizable by a concept in $\mathcal C$. But residual boosting
needs the opposite kind of promise: whenever a residual has any polynomially
detectable concept correlation $\alpha$, the weak oracle should return a
hypothesis with correlation at least $1/\operatorname{poly}_P(s,1/\alpha)$,
or at least a polynomial fraction of $\alpha$.

The atlas source has no parameter corresponding to $\alpha$. It is an
`OPT + fixed beta` oracle, not a correlation oracle with tunable slack.

### Why Fixed-Additive Gaps Stop The Known Strong-Learning Reduction

This is not a merely cosmetic mismatch. In a realizable boosting proof, after
some rounds the remaining hard region may have marginal mass $\mu$, and the
next useful descent direction may have best concept correlation on the order
of $\mu$ or of the current excess error. To reach arbitrary $\varepsilon$, the
booster must keep making progress when these signals are much smaller than a
constant.

The fixed-additive weak agnostic guarantee can legally return a useless
hypothesis on such a residual distribution. Even if
$A^\star(r)=\alpha$ is inverse-polynomial and perfectly usable by a
Feldman/Ghai-style correlation booster, the lower bound
$\alpha-1+2\gamma_P(s)$ may be nonpositive. Validation cannot repair this:
validation can detect that a candidate has no correlation, but the source
does not promise that another run or larger sample size will produce one at
that residual scale.

The density-ratio formulation gives the same conclusion. To simulate a
reweighted marginal $Q$ while preserving $X\sim P$, one can try labels with

$$
\mathbb E[Y\mid X=x]=\lambda\frac{dQ}{dP}(x)c(x).
$$

The condition $|\mathbb E[Y\mid X=x]|\le 1$ forces
$\lambda\le 1/\|dQ/dP\|_\infty$. The best concept correlation under the
same-marginal problem is then $\lambda$. The source gives useful correlation
only if $\lambda>1-2\gamma_P(s)$. Thus the allowed density ratio is at most
about $1/(1-2\gamma_P(s))$, which is essentially no focusing when
$\gamma_P(s)$ is small. Strong boosting eventually needs much sharper
focusing.

### Near-Miss Results

The standard weak-to-strong realizable theorems remain near misses. Schapire
and Freund show exactly how to amplify weak hypotheses once the weak advantage
is controlled on the distributions generated by the booster. The atlas source
does not provide the required original-$P$ envelope over those generated
marginals.

Distribution-specific agnostic boosting is also a near miss. Feldman-style
boosting keeps the instance marginal fixed, which is exactly what this edge
would like. But those theorems use a threshold/correlation weak oracle with a
usable advantage at the current residual scale. Ghai-Singh-style refinements
improve sample bookkeeping in related oracle models, but they do not turn an
`OPT + 1/2 - gamma_P` source into a residual-responsive oracle.

The low-noise robustification argument explains why the source is plausible
from realizable weak learning, but it also explains why the proof stops early.
In the high-noise case, constants or neutral hypotheses are good enough for a
weak agnostic target. A strong realizable target cannot use that stopping rule:
the "high-noise" residual mass is exactly what must be driven below
$\varepsilon$.

The sample-only marginal-nonuniform theory is another near miss. Ignoring
runtime, polynomial marginal-nonuniform weak sample guarantees collapse to the
usual finite-dimensional sample regime, and unrestricted ERM can obtain strong
learning. The edge here is computational. Finite-dimensional sample control
does not supply an efficient improper ERM or an efficient booster with the
missing residual-response/envelope property.

### Why I Still Cannot Mark It False

A black-box barrier is not an atlas counterexample. To mark the edge false, one
needs a concrete representation class satisfying the marginal-nonuniform weak
agnostic proper source while failing marginal-nonuniform strong realizable
improper learning.

The attempted false-witness families all miss one side of this demand.

- Halfspaces and similar classes give useful hardness for agnostic targets,
  but they are already strongly realizably learnable, so they do not refute the
  target.

- PCP/lookup classes separate properness well, but this target is improper.
  The same lookup structure that makes weak or agnostic improper learning easy
  tends to make the strong improper target easy too.

- One-way image-coordinate and weak-handle constructions can make proper
  recovery hard, but if a cheap weak handle is findable on every residual
  marginal, an improper booster can often aggregate those handles. If the
  handle is made too weak or too hidden to aggregate, the weak agnostic source
  itself becomes hard to prove for marginals isolating the hard slice.

- Rare-block diagonal constructions model the obstruction well, but because
  the source quantifies over every marginal, including marginals concentrated
  on a single rare block, each block must remain weakly agnostically properly
  learnable. That same per-block learnability tends to leak enough information
  for an improper strong learner unless one builds a genuinely nonboostable
  handle mechanism.

Thus fixed-additive weak gaps fundamentally stop the known strong marginal
boosting reductions, but they do not yet furnish a separation.

### Concrete Missing Lemma

The positive missing lemma is:

**Residual-responsive same-marginal lemma.** For every original marginal $P$,
there is a polynomial $r_P$ such that for every size $s$ and every bounded
residual function $r:\mathcal X\to[-1,1]$, if

$$
\sup_{c\in\mathcal C_s}\langle r,c\rangle_P\ge \alpha,
$$

then the source learner, run on samples with conditional label expectation
$r(x)$, can be converted in time
$r_P(s,1/\alpha,\log(1/\delta))$ into a proper $h\in\mathcal C_s$ satisfying

$$
\langle r,h\rangle_P\ge 1/r_P(s,1/\alpha)
$$

with probability at least $1-\delta$.

This lemma would make the edge true. A Feldman-style same-marginal booster
could then aggregate the returned proper hypotheses into an improper predictor
with realizable error at most $\varepsilon$, and the resulting runtime would be
polynomial in $s$, $1/\varepsilon$, and the $P$-dependent response polynomial.

The current source does not imply this lemma. The calculation above shows that
it only gives

$$
\langle r,h\rangle_P\ge A^\star(r)-1+2\gamma_P(s),
$$

which is a low-noise promise rather than a residual-response promise.

The alternative positive missing lemma is the reweighted version:

**Original-marginal booster-envelope lemma.** For a fixed realizable booster
and original marginal $P$, all booster-induced marginals $Q$ reachable before
accuracy $\varepsilon$ have weak gaps and resource polynomials dominated by one
polynomial depending only on $P$, $s$, and $1/\varepsilon$.

This would also make the edge true. The atlas source does not imply it either.

### Recommended Atlas-Facing Synthesis

Keep the implication open in `marginal-boosting-open`. The edge is now best
understood as the intersection of two obstacles:

1. Reweighted realizable boosting needs an original-marginal envelope over
   target-dependent booster marginals.

2. Same-marginal agnostic boosting avoids new marginals but needs a
   residual-responsive correlation oracle, while the source gives only a
   fixed-additive near-realizable guarantee.

The decisive sentence for the edge note should be something like:

> The agnostic source lets us keep the instance marginal fixed by changing the
> label distribution, but the resulting guarantee is useful only when the
> residual labeling is already nearly realizable; strong realizable boosting
> requires progress at residual correlations down to the requested accuracy.

Do not move this edge to `true` unless a residual-responsive same-marginal
lemma or a booster-envelope lemma is proved. Do not move it to `false` unless
a concrete class is built with source-positive proper weak agnostic handles
that are computationally nonboostable even for improper predictors.

### Final Confidence

verdict: unresolved-open

confidence: 0.94 that the agnostic source, as currently defined, does not
provide residual-responsive same-marginal boosting; 0.88 that fixed-additive
weak gaps are the right technical obstruction to the known positive routes;
0.62 that the edge is genuinely false rather than merely missing a clever
non-black-box marginal-nonuniform booster; 0.78 that the atlas should keep the
current `marginal-boosting-open` family and revise only the explanatory
summary, not the status.
