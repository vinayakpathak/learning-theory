# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-weak-realizable-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- worker constraint: scratchpad only; no atlas files edited
- verdict: unresolved-open
- confidence: 0.87

## Executive Verdict

I do not see an atlas-ready proof or counterexample. The edge should remain
`open`, but the reason should be sharpened.

The current edge note says the obstacle is the marginal-dependent resource
polynomial. After comparing with the sibling edge

```text
efficient-marginal-nonuniform-weak-agnostic-improper-pac
-> efficient-weak-realizable-improper-pac
```

and its weak-gap-uniformization scratchpad, I think the resource diagnosis is
not the binding obstruction under the atlas's pathwise transcript convention.
Full-support marginal uniformization gives one sample/time polynomial for a
single source learner. The unresolved step is the weak advantage:

$$
\forall P\ \exists k(P):\quad \gamma_P(s)\ge s^{-k(P)}
\quad\not\Rightarrow_{\text{known}}\quad
\exists k\ \forall P:\quad \gamma_P(s)\ge s^{-k}.
$$

The extra properness in this edge does not appear to fix that quantifier swap.
It rules out some improper-source counterexample templates, but on realizable
labels the proper source simply returns a proper weak hypothesis, which is also
allowed by the improper target. The target still needs one distribution-free
inverse-polynomial weak gap.

## Files Read

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--sample-efficient-weak-realizable-improper-pac.md`
- `atlas/implications/sample-efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`
- `atlas/registry/edge_families.yml`

## Current Atlas State

The assigned edge is currently:

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
```

This is directionally right, but it should no longer be phrased as only a
runtime/sample-bound issue. The newer `full-support-marginal-uniformization`
argument handles the pathwise resource part for a single learner. The gap
between this source and this target is a weak-gap uniformization problem.

## Reduction Of The Edge

The source gives one learner $A$ such that, for every instance marginal $P$,
there are a polynomial $p_P$ and a weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial. For every
joint distribution $\mathcal D$ with marginal $P$, the learner outputs
$h\in\mathcal C$ and satisfies

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

On realizable labels $Y=c(X)$, the optimum proper error is zero, so the same
learner gives

$$
\operatorname{err}_{P}(h,c)\le 1/2-\gamma_P(s),
\qquad h\in\mathcal C.
$$

Because the target is improper only in the permissive sense, this proper
hypothesis is an admissible target hypothesis. Thus the edge reduces to:

> Does marginal-nonuniform weak realizable proper learning, with a
> marginal-dependent weak gap, imply distribution-free weak realizable improper
> learning with one inverse-polynomial weak gap?

The answer is not known from the current notes.

## Comparison With The Sibling Improper-Source Edge

The sibling edge from marginal-nonuniform weak agnostic improper learning to
distribution-free weak realizable improper learning has the same core
obstruction. Restricting that source to realizable labels gives weak
realizable improper learning with advantage $\gamma_P(s)$, and full-support
uniformization controls resources. What remains is the lack of a uniform lower
envelope for $\gamma_P$.

The proper source is stronger than the improper source in one formal sense:

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
-> efficient-marginal-nonuniform-weak-agnostic-improper-pac
```

is a true monotone-relaxation edge. Therefore, if the sibling improper-source
edge were proved true, the assigned proper-source edge would follow by
composition.

But the sibling remains open, and properness does not supply the missing
uniform weak gap. It affects possible counterexamples more than possible
proofs: a false witness for this edge must have efficiently findable proper
weak handles for every marginal, not merely improper weak handles. None of the
existing proper-handle witnesses also refute the weak improper target.

## What Full-Support Uniformization Gives

Let $P^\star$ be a full-support reference marginal over every finite encoded
instance in each representation-size slice. Applying the source guarantee to
$P^\star$ gives a polynomial $p_{P^\star}$ bounding the sample use and runtime
of the single learner $A$.

Every finite labeled transcript that can occur under any target marginal also
has positive probability under $P^\star$ for a suitable conditional label rule.
Under the atlas worst-case/pathwise efficiency convention, $A$ cannot exceed
$p_{P^\star}$ on any such transcript. Thus the resource bound of one call to
$A$ becomes distribution-free.

Accuracy is different. For the actual marginal $P$, the guarantee must be read
at $P$, not at $P^\star$, and it yields only

$$
\operatorname{err}_{P}(h,c)\le 1/2-\gamma_P(s).
$$

There is no density-ratio control from $P^\star$ to $P$, and probabilistic PAC
accuracy under a reference mixture does not control accuracy under low-mass
conditional regions. So the full-support argument cannot turn
$\gamma_P(s)$ into a marginal-independent inverse polynomial.

## Attempted Positive Routes

### Strong-Source Monotonicity

Nearby strong-source edges are true:

```text
efficient-marginal-nonuniform-agnostic-proper-pac
-> efficient-weak-realizable-improper-pac
```

and

```text
efficient-marginal-nonuniform-realizable-proper-pac
-> efficient-weak-realizable-improper-pac.
```

Those proofs run the strong source learner at a fixed constant accuracy, such
as $\varepsilon=1/4$, and then use full-support resource uniformization. The
weak gap is chosen by the algorithm call and is independent of $P$.

This route fails here because the assigned source is already weak. There is no
accuracy parameter that can be set to create a constant gap. The source hands
us its hidden $\gamma_P(s)$.

### Same Learner After Resource Uniformization

Running $A$ directly gives one distribution-free runtime after the full-support
argument, but the weak advantage remains $\gamma_P(s)$. This proves the target
only if one can additionally prove

$$
\exists q\ \forall P:\quad \gamma_P(s)\ge 1/q(s).
$$

No such theorem is in the atlas.

### Finite-Slice Compactness

For a fixed representation size and a bounded-transcript learner, the set of
marginals on a finite encoded slice is compact. If every marginal has a
positive weak gap, one might hope the minimum gap is positive.

Even if this works for each fixed size, it does not give an inverse-polynomial
lower bound as the representation size grows. The minimum positive gap could
shrink faster than every inverse polynomial. That is compatible with the
source, since each individual marginal may still have some finite exponent
$k(P)$.

### Sample-Complexity Equivalence

The source implies the sample-efficient weak realizable improper target once
runtime is ignored, via the marginal-nonuniform trichotomy and VC theory. This
does not yield an efficient learner. The atlas already has sample-to-computing
separations from pseudorandom-function classes, so unbounded ERM cannot be
converted into a generic polynomial-time proof.

### Stronger Size-Conditional Semantics

There is a near-positive diagonal argument under a stronger interpretation of
marginals as size-indexed families with size-conditional risk. If no uniform
gap existed, one could choose bad marginals $P_d$ and sizes $s_d$ with
$\gamma_{P_d}(s_d)<s_d^{-d}$, stitch them into one diagonal marginal family,
and contradict the source guarantee for that single family.

Under the atlas's current global-marginal wording, this is not a proof. A
mixture over bad slices can assign tiny mass to each bad component, and a weak
additive guarantee can ignore sufficiently low-mass components while still
beating $1/2$ on the mixture.

## Counterexample Search

A false witness for the assigned edge must satisfy a tight package:

1. There is one polynomial-time learner that, for every marginal, outputs a
   proper hypothesis with an agnostic weak gap that is inverse-polynomial with
   a marginal-dependent exponent.
2. No polynomial-time improper learner achieves any one distribution-free
   inverse-polynomial weak advantage in the realizable case.
3. The separation cannot rely on marginal-dependent runtimes, because
   full-support resource uniformization would already rule those out for a
   valid single source learner.

I do not know a current atlas witness with these properties.

### Pseudorandom Function Classes

PRF classes are good target-negative witnesses: an efficient weak realizable
improper learner under the hard marginal would distinguish pseudorandom
functions from random labels. But they fail the source at that same hard
marginal. The source requires weak agnostic proper learnability for every
marginal, not merely sample-efficient learnability.

### Halfspaces

Halfspaces are source-positive but target-positive. Linear feasibility gives
realizable proper learning, constants are proper halfspaces, and low-noise
robustification gives weak agnostic proper learning. The weak realizable
improper target is then easy. Lattice-based agnostic hardness does not refute
realizable weak improper learning.

### PCP Active-Slice And Clause-Satisfaction Lookup Classes

The PCP active-slice witness is not a counterexample. It is source-negative
for this proper weak source under the usual NP-hardness assumption: a weak
proper learner on the active slice would recover accepting proof information.
It is also target-positive improperly, since the active slice has polynomial
support and can be learned by lookup/memorization.

Clause-satisfaction lookup classes separate improper from proper targets, but
the assigned target is improper. They do not give a failure of weak realizable
improper learning.

### One-Way Image-Coordinate Weak-Handle Classes

The weak-handle one-way image-coordinate class is closer to the proper-source
side: constants and singleton-like handles can provide proper weak advantages
under fixed marginals. However, the assigned target is weak and improper.
Improper memorization of the sparse positive coordinate atoms, or direct use
of the same handles, makes the target learnable. The one-way hardness bites
strong proper recovery, not weak improper prediction.

### Rare-Slice Weak-Gap Hierarchies

The most plausible false template is a hierarchy of blocks where block $k$
has cheap proper weak handles of advantage about $s^{-k}$, but no learner can
obtain advantage $s^{-d}$ uniformly over all high $k$ for any fixed $d$.

This remains only a template. If the handles require $s^k$ samples or time to
find, the source violates full-support pathwise resource uniformization. If
the handles are public and cheaply findable, the distribution-free target can
often use them too. If a hard residual is added so that improving the handle is
cryptographically hard, then arbitrary marginals that concentrate on the hard
near-balanced residual usually make the source fail.

For this edge, unlike the strong-realizable target, nonboostability is not even
the central issue. The target asks for one weak hypothesis. A counterexample
must ensure that all polynomial-time algorithms are limited to arbitrarily
small polynomial advantages on selected marginals, while the source learner
still gets some marginal-dependent inverse-polynomial advantage everywhere.
That is a calibrated weak-advantage hierarchy, not a standard PRF or time
hierarchy statement.

## Proposed Atlas Update

No status change is justified from this pass. If atlas edits are later allowed,
I would update the note along these lines:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
summary: "Open: full-support marginal uniformization gives one pathwise sample/time polynomial for the single proper source learner, but restricting to realizable labels yields only a marginal-dependent weak advantage; no known theorem turns those gaps into one distribution-free inverse-polynomial weak gap."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

Suggested body replacement:

```markdown
Full-support marginal uniformization handles the resource part under the atlas
worst-case transcript convention. Let `A` be the single proper weak agnostic
source learner and let `P^star` be a full-support reference marginal. The
source guarantee at `P^star` bounds every finite transcript that can arise
under any target marginal, so one distribution-free sample/time polynomial is
available for a call to `A`.

The remaining obstruction is quantitative. On realizable labels with actual
marginal `P`, the source gives a proper hypothesis with error at most
`1/2 - gamma_P(s)`, where the inverse-polynomial lower bound on `gamma_P`
may depend on `P`. The improper target allows this proper output, but it
requires one inverse-polynomial weak advantage independent of `P`. Properness
does not supply such a lower envelope.

Thus the edge remains open. A proof would need a weak-gap uniformization
theorem, or a clarified size-conditional marginal semantics under which a
diagonal argument applies. A counterexample would need a class with efficient
proper marginal-specific weak agnostic handles for every global marginal while
still ruling out all polynomial-time improper learners with a uniform weak
advantage.
```

I would also consider adding or splitting a sharper family such as
`weak-gap-uniformization-open` for weak-to-weak marginal-nonuniform edges whose
resource part is handled but whose hidden weak gaps may have unbounded
marginal-dependent polynomial degree.

## Promising Directions And Obstacles

1. **Weak-gap uniformization theorem.** Prove or disprove the quantifier swap
   for a single bounded-transcript learner under global marginals. Obstacle:
   finite-slice compactness gives at most a positive minimum per size, not an
   inverse-polynomial lower bound across sizes.

2. **Schema clarification.** If the atlas intends size-conditional marginals,
   diagonal stitching could plausibly make this edge true. Obstacle: current
   notes use global marginals and explicitly distinguish resource transfer
   from accuracy transfer.

3. **Calibrated weak-advantage hierarchy.** Build blocks with level-dependent
   proper weak handles and prove no uniform exponent works for improper weak
   learning. Obstacle: known PRF/hierarchy tools tend either to kill the source
   on isolated hard marginals or to give the target the same cheap handle.

4. **No-transfer lemma for mixtures.** Formalize that a weak additive guarantee
   on a global mixture need not control low-mass components. This would not
   resolve the edge, but it would explain why the diagonal proof is not valid
   under current semantics.

## Final

verdict: unresolved-open

confidence: 0.87

## Depth 2 Branch: weak agnostic proper to distribution-free weak realizable improper

- depth: 2
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- worker constraint: append-only scratchpad pass; no atlas files edited

### Question

This branch repairs the depth-1 analysis around the exact weak target:

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
-> efficient-weak-realizable-improper-pac
```

The focus is whether the realizable/improper target removes enough structure
to prove the edge, or whether a hidden-gap class can satisfy the source while
refuting every distribution-free weak realizable improper learner.

### Reduction Still Leaves A Weak-Gap Problem

Let `A` be the single source learner. For each instance marginal `P`, the
source gives a proper hypothesis and an additive tolerance

$$
\beta_P(s)=1/2-\gamma_P(s),
\qquad
\gamma_P(s)\ge s^{-k(P)}
$$

up to a marginal-dependent polynomial exponent. On realizable labels,
`OPT_C=0`, so the same call gives

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s),
\qquad h\in\mathcal C.
$$

The target is improper, so this proper output is admissible. Full-support
marginal uniformization also handles the one-call sample/time resource bound
under the atlas pathwise transcript convention. Thus the only missing target
datum is still

$$
\exists k\ \forall P:\quad \gamma_P(s)\ge s^{-k}.
$$

The realizable/improper restriction removes the agnostic benchmark and output
constraints, but it does not itself swap
`\forall P exists k(P)` into `exists k forall P`.

### Positive Route Audit

The strong-source proof does not transfer. For strong marginal-nonuniform
agnostic proper learning, one runs the learner with a fixed accuracy such as
`1/4`, and the weak gap is chosen by the algorithm call. Here the source is
already weak; there is no tunable fixed accuracy parameter.

Validation over guessed exponents gives only a truncated theorem. If we search
down to gap `s^{-D}`, validation costs about `s^{2D}` samples and time. This
works uniformly for marginals whose hidden exponent is at most `D`, but the
target needs one fixed `D` that covers all marginals.

Diagonal stitching also remains blocked under the current global-marginal
semantics. Bad behavior on a low-mass slice is averaged away in weak error.
The full-support argument transfers resources because resources are pathwise;
it does not transfer accuracy from a reference marginal to conditionals or
low-mass components.

So I do not see a proof made possible merely by restricting the target to
realizable/improper learning.

### Hidden-Gap Witness Audit

The best candidate shape is the paired rare-block PRF/singleton-handle idea
from the neighboring weak-realizable-improper scratchpad:

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

with a concept labeling exactly one point in each pair according to a PRF bit,
and with constants and singleton-like handles included as proper hypotheses.
On the uniform paired block, constants have error exactly `1/2`, and one
observed positive singleton has advantage about `1/(2n^j)`. Choosing `j`
larger than an alleged target learner's resource and weak-gap exponents gives
the right target-negative geometry: any larger advantage would require
predicting unseen PRF bits.

That target-negative side is plausible under the standard computational-PAC
convention that efficient improper outputs are polynomial-time evaluable. A
weak learner with advantage `n^{-a}` on a high paired PRF block could be
turned into a PRF distinguisher by evaluating its output on fresh paired
points.

The source-positive side is the problem after the repair. A source learner for
this edge must be weak agnostic proper for every marginal, and after the
full-support argument it cannot hide level-dependent sample or validation
costs. In particular, any algorithm that spends `n^j`, or worse `n^{2j}`, to
find or validate a singleton handle on level `j` is not a valid source learner
under the atlas pathwise convention. A full-support reference marginal gives
positive probability to the same finite high-level transcripts and would force
one polynomial bound over all `j`.

Trying to avoid validation brings back the deterministic orientation barrier.
For an active target whose positive mass is

$$
M=1/2\pm \Theta(1/n^j),
$$

the useful default orientation changes at the same hidden scale as the desired
weak advantage. Constants, positive singletons, co-singletons, or sparse
patches can each be made good for one side of this near-balanced band, but a
deterministic proper learner must choose the right side. Distinguishing the
two nearby marginals by samples costs on the order of the inverse squared
hidden gap, which is exactly the forbidden level-dependent resource.

This obstruction is even sharper in the agnostic source. The usual
disagreement-to-the-best-concept argument would make constants and singleton
handles sufficient if the learner could identify a good handle at the hidden
scale. But when `OPT` is below that scale, the learner still has to locate and
orient the handle; when `OPT` is above that scale, constants are enough but
the algorithm must know this through validation. The agnostic relaxation does
not remove the hidden-scale test.

Thus the paired rare-block PRF construction is a useful diagnostic, but I do
not think it is currently a source-positive/target-negative witness for the
assigned edge. It either relies on hidden level-dependent source resources, or
it needs a new orientation-free deterministic proper handle that the improper
target cannot also reuse.

### What A Real False Witness Must Do

A valid hidden-gap separation for this edge would have to be a pure weak-gap
hierarchy:

1. The same source learner has one pathwise polynomial sample/time bound after
   full-support uniformization.
2. For every marginal `P`, that learner gets some inverse-polynomial proper
   weak agnostic edge, possibly with exponent `k(P)`.
3. For every fixed distribution-free exponent `a` and polynomial-time
   improper learner, some realizable marginal/concept pair defeats advantage
   `s^{-a}`.
4. The source's weak handles are not public handles usable by the improper
   target, and finding them does not require validation at the hidden scale.

No checked PRF, rare-block, one-way-coordinate, singleton-handle, or
Hadamard/default construction currently satisfies all four requirements.

### Branch End

verdict: unresolved-open. Restricting the target to realizable/improper does
not yield a proof; it only reduces the edge to weak-gap uniformization. I also
do not see an atlas-ready source-positive/target-negative hidden-gap witness:
the paired rare-block PRF idea has the right target-negative shape but fails
the repaired source audit unless one finds an orientation-free deterministic
proper handle with uniform pathwise resources.

confidence: 0.84

next branches:

1. Formalize the near-balanced orientation obstruction as a lemma comparing
   two marginals with positive masses `1/2 +/- eta` whose short transcript
   laws are close but whose correct deterministic defaults are opposite.
2. Search specifically for orientation-free deterministic proper handles that
   give hidden-scale positive correlation under every marginal while remaining
   unusable by improper distribution-free learners.
3. Separate model-convention work from witness work: clarify efficient
   evaluation of improper outputs for PRF lower bounds, but do not treat that
   as enough for this edge without a source-positive handle.
4. Revisit size-indexed or slice-conditional marginal semantics separately;
   under that different schema a diagonal weak-gap theorem may become true.

## Depth 3 Branch: agnostic-source weak-gap uniformization

The new question is whether the source's agnostic quantifier over all label
distributions with the same marginal can do more than the realizable reduction
used above. The tempting thought is:

1. the target examples give samples from an unknown realizable marginal-label
   pair $(P,c)$;
2. the source learner also works on synthetic agnostic labelings over the same
   marginal $P$;
3. perhaps synthetic calls can calibrate the hidden weak gap, identify the
   active marginal scale, or convert a marginal-dependent gap into one fixed
   inverse-polynomial target gap.

I do not see such a conversion. The same-marginal agnostic structure is useful
for auditing candidate witnesses, but it still does not change the core
quantifier:

$$
\forall P\ \exists k(P):\quad \gamma_P(s)\ge s^{-k(P)}
\quad\text{versus}\quad
\exists k\ \forall P:\quad \gamma_P(s)\ge s^{-k}.
$$

### Synthetic Agnostic Calls Do Not Calibrate The Target Gap

A target learner can ignore the true labels, draw $X\sim P$, attach synthetic
labels, and run the source learner on that artificial joint distribution. This
is legitimate because the source guarantee is agnostic at the fixed marginal
$P$.

However, a synthetic call only proves that the source can weakly learn the
synthetic labeling. If the synthetic labeling is independent of the unknown
target concept $c$, the returned proper hypothesis need not correlate with
$c$. If the synthetic labeling is a known concept $c_0\in\mathcal C$, the call
may reveal that $A$ does well on $c_0$ under $P$, but this does not lower-bound
the worst target-concept gap. The source guarantee permits $A$ to be much
better on public calibration concepts than on the hardest concept at the same
marginal.

Noisy-label calls have the same problem. Suppose we form labels
$Y'=c(X)Z$, where $Z\in\{\pm1\}$ has mean $\lambda=1-2\eta>0$. For any fixed
output $h$,

$$
\mathbb E[h(X)Y'] = \lambda\,\mathbb E[h(X)c(X)].
$$

The agnostic guarantee gives positive correlation with $Y'$ only when the
noise level is below the hidden gap scale. In error notation it yields

$$
\operatorname{err}(h,Y')\le \eta + 1/2-\gamma_P(s),
$$

so the resulting correlation with $Y'$ is at least $2(\gamma_P(s)-\eta)$.
Thus choosing a useful noise level already requires knowing the hidden scale
$\gamma_P(s)$. A grid search over $\eta=s^{-d}$ only gives a theorem for
marginals whose exponent is at most the searched depth $d$, with validation
costs of the same order.

The agnostic source therefore lets us create additional experiments at the
same marginal, but it does not provide a distribution-free meter for the
unknown weak advantage on the unknown realizable target.

### Why Agnostic Labels Do Not Reweight Rare Blocks

The diagonal proof one wants would concentrate attention on the bad block of a
mixture marginal. Agnostic labels cannot do that. They can change the
conditional law of $Y$ given $X$, but they cannot change the marginal mass of
the block.

If a global marginal $P$ assigns mass $\mu_j$ to a hard block $B_j$, then any
additive weak agnostic guarantee over $P$ can lose the entire block whenever
$\mu_j$ is below the promised advantage scale. Labeling $B_j$ adversarially
does not amplify its contribution to the source loss:

$$
\operatorname{err}_P(h)-\operatorname{err}_P(c^\star)
=
\sum_j \mu_j\,
\bigl(\operatorname{err}_{P_j}(h)-\operatorname{err}_{P_j}(c^\star)\bigr).
$$

The same-marginal condition is exactly what blocks reweighting. To force the
source to solve $B_j$ at full strength, one would need to change the instance
marginal to $P_j$ or work under size-conditional semantics. Under the current
global-marginal reading, the agnostic quantifier over labels does not repair
the weak-gap uniformization gap.

### A Useful Barrier From Same-Marginal Agnosticism

The agnostic source does sharpen the rare-block counterexample audit. A valid
source learner must handle many labelings over the same marginal, including
opposite orientations of a hidden small-mass signal.

Let $S\subseteq X_s$ be a signal set of mass $\mu$, and consider two realizable
concepts $c_+$ and $c_-$ that agree off $S$ but have opposite useful
orientations on $S$. If an $m(s)$-sample learner sees no point of $S$, then its
transcript has the same law under $(P,c_+)$ and $(P,c_-)$. Any deterministic
output chosen from that transcript cannot have the right oriented advantage
for both concepts. With randomized learners, the same coupling gives the
usual high-probability obstruction unless the learner sees $S$ with constant
probability or has a public orientation rule independent of the labels.

This gives the right hidden-gap barrier:

$$
m(s)\,\mu \ll 1
\quad\Longrightarrow\quad
\text{no source guarantee with gap comparable to }\mu
\text{ for both orientations.}
$$

But this barrier hurts false-witness attempts more than it proves the edge.
For the rare-block PRF/singleton-handle construction, taking
$\mu\approx s^{-j}$ with unbounded $j$ makes target-negative gaps easy to hide
from every fixed distribution-free exponent. The same choice makes the source
fail unless the proper learner can orient the handle without seeing the rare
signal. If the orientation is public enough for the source to choose it, an
improper target can usually reuse the same public rule.

So the agnostic same-marginal requirement produces a dilemma for hidden-gap
witnesses:

1. If the hidden useful mass must be sampled to orient the proper handle, the
   source is negative at high levels because full-support resource
   uniformization gives only one fixed polynomial sample bound.
2. If the handle is orientation-free or publicly oriented, the source may be
   positive, but then the weak realizable improper target often becomes
   positive too.
3. If cryptographic residuals are added after the public handle, the target
   lower bound may survive, but arbitrary same-marginal agnostic labelings tend
   to expose source-negative near-balanced tasks.

This is the clearest reason the repaired rare-block PRF idea still fails:
the PRF side can hide a uniform target gap, but the agnostic-source side must
also solve same-marginal opposite-orientation tasks with one pathwise
polynomial resource bound.

### No Positive Uniformization From Properness Alone

Properness also does not appear to add a calibration mechanism. On realizable
labels, the proper output is already an admissible improper target output. The
only missing target datum is the exponent of the advantage. Properness can
make some hidden handles unavailable to an improper-source counterexample, but
it cannot by itself turn a marginal-dependent weak gap into a uniform one.

A possible theorem would need an additional structural premise, for example a
finite public proper subfamily whose empirical correlations approximate the
best proper concept at every marginal with a known polynomial resolution. That
premise is not part of the source node. Without it, agnostic calls provide
more label experiments but no way to certify that the weakest target concept
at $P$ has advantage at least $s^{-k}$ for a fixed $k$.

### Branch End

verdict: unresolved-open. The same-marginal agnostic source structure does
not presently yield weak-gap uniformization for the realizable improper
target. It does give a strong diagnostic barrier for hidden-gap witnesses:
rare oriented signals defeat the source unless they are sampled at the hidden
scale, while public or orientation-free handles tend to be reusable by the
improper target. No atlas-ready proof or counterexample follows from this
branch.

confidence: 0.83

next branches:

1. Try to formalize the opposite-orientation barrier as a lemma: two
   realizable labelings over the same marginal, indistinguishable until a
   signal set of mass $\mu$ is sampled, force any weak agnostic proper source
   gap to be $O(m(s)\mu)$ or require a public orientation rule.
2. Search for an orientation-free proper handle whose evaluation is cheap for
   the source but whose use by an arbitrary improper target would still imply
   a PRF distinguisher.
3. Test whether a strengthened source node with known public calibration
   concepts or finite proper covers would make the synthetic-label
   calibration route prove a true edge.
4. Keep the current atlas edge open unless the schema is changed to
   size-conditional marginals, where agnostic labels plus diagonal stitching
   may have more force.

## Depth 4 Branch: finite-margin weak-gap route

- depth: 4
- date: 2026-05-05
- focus: whether finite transcript/output structure forces a bounded weak-gap
  exponent, or whether hidden-gap oracle examples still evade it
- prior: the agnostic source quantifier over labels does not itself uniformize
  the weak advantage because the instance marginal is fixed

### Goal

The positive route would prove the assigned edge by adding one missing step to
the previous analysis. Full-support marginal uniformization already gives a
single pathwise polynomial sample/time bound for the source learner $A$. On
realizable labels, the only remaining target datum is a distribution-free weak
advantage:

$$
\exists K\ \forall P,c,s:\quad
\Pr\left[
  \operatorname{err}_P(A,c)\le \frac12-s^{-K}
\right]\ge \frac23 .
$$

The source gives the same statement with $K$ allowed to depend on $P$. This
branch asks whether the finite number of transcripts and proper outputs at
each size can force the exponents $K(P)$ to be bounded.

### Finite-Output Reduction

Fix the full-support resource polynomial $q(s)$ obtained from the source
learner. For a fixed size $s$, only finitely many labeled transcripts and
random-bit prefixes of length at most $q(s)$ can affect the output. Therefore
there is a finite set $\mathcal H_s$ of proper hypotheses that $A$ can output
on size-$s$ inputs within the resource bound.

For a realizable concept $c$, define the learner's high-probability margin at
$(P,c)$ by

$$
g_s(P,c)=
\sup\left\{\gamma:
\Pr\left[
  \frac12-\operatorname{err}_P(A(S),c)\ge \gamma
\right]\ge \frac23
\right\}.
$$

The source restricted to realizable labels says that for every fixed marginal
$P$ there is an exponent $K(P)$ such that

$$
\inf_c g_s(P,c)\ge s^{-K(P)}
$$

for all relevant sizes $s$. The target asks for one exponent $K$ that works
after taking the infimum over all $P$ as well.

Finite output makes $g_s(P,c)$ a finite-transcript quantity: transcript
probabilities are polynomial expressions in the atom masses of $P$, and each
output's correlation with $c$ is linear in $P$. This is enough to support a
compactness-style statement at a fixed size if the domain slice and concept
slice are finite: strict positivity over all marginals gives a positive
minimum for that fixed $s$.

But this only gives a number $\eta_s>0$. It does not imply
$\eta_s\ge s^{-K}$ for one constant $K$. The sequence $\eta_s$ can decay faster
than every inverse polynomial unless some additional finite-margin or
bounded-bit-complexity condition is present.

### What Would Make The Positive Route Work

A conditional positive theorem would be straightforward under any of the
following extra hypotheses:

1. **Bounded exponent premise.** There is a constant $K_0$ such that the
   realizable high-probability margin of the source learner is either zero or
   at least $s^{-K_0}$ for every size, marginal, and target concept.
2. **Public finite-margin premise.** Every proper output that beats random on a
   realizable distribution does so through a public witness event whose
   marginal mass is either zero or at least $s^{-K_0}$.
3. **Finite cover with calibrated resolution.** For each size there is an
   efficiently searchable proper cover $\mathcal G_s\subseteq\mathcal C$ such
   that the best cover correlation on every realizable marginal is within an
   additive $s^{-K_0}$ of the best proper correlation.

Under any of these, the edge becomes true: restrict the agnostic source to
realizable labels, use full-support resource uniformization for the sample/time
bound, and plug the bounded exponent into the weak target.

The problem is that none of these premises is part of
`efficient-marginal-nonuniform-weak-agnostic-proper-pac`. The definition allows
the weak gap for a fixed marginal to have an arbitrary finite exponent. It
does not require the exponent to be discoverable, public, stable under nearby
marginals, or drawn from a bounded list.

### Why Finite Output Does Not Bound The Exponent

Finite output controls the number of possible hypotheses, not the masses on
which their correlations are witnessed. A marginal can place mass $s^{-d}$ on a
distinguishing region, with $d$ as large as desired. For that particular
marginal this is still an inverse-polynomial signal, so the source can satisfy
its marginal-dependent guarantee with exponent about $d$. A distribution-free
target cannot choose $d$ after seeing the marginal; it needs one exponent in
advance.

This is not contradicted by fixed-size compactness. For each fixed $s$, a
positive minimum over a finite-dimensional simplex may exist, but the atlas
target needs a lower bound with controlled dependence on $s$. Compactness gives
no reason that the sequence of fixed-size minima cannot look like
$s^{-1},s^{-2},s^{-3},\ldots$ along an adversarial family of marginals.

The agnostic same-marginal quantifier does not repair this. Arbitrary labels
can change the conditional distribution of $Y$ given $X$, but they cannot
increase the mass of the distinguishing event. If the useful correlation is
hidden behind mass $s^{-d}$, every same-marginal agnostic task still sees that
event with mass $s^{-d}$.

### Hidden-Gap Oracle Barrier

The natural barrier family is a keyed or oracle block construction indexed by
an exponent $d$.

For each size $s$ and exponent $d$, let there be a block $B_{s,d}$ of size
roughly $s^d$ or larger, with labels determined by a hidden oracle concept.
Under the uniform marginal on the block, a polynomial-time learner can only
inspect $\operatorname{poly}(s)$ labeled points. Memorizing or otherwise using
those inspected points gives advantage at most about

$$
\frac{\operatorname{poly}(s)}{|B_{s,d}|},
$$

which is inverse-polynomial for each fixed $d$ but below $s^{-K}$ once $d$ is
chosen much larger than the target exponent $K$.

This is the right shape for a target lower bound. For any claimed
distribution-free weak learner with exponent $K$ and polynomial resource
$s^a$, choose $d>a+K$ and use the oracle block $B_{s,d}$. Without structural
access to the hidden labels, the learner cannot get inverse-polynomial
advantage at the demanded exponent.

The source side is the fragile part. A marginal-nonuniform source may allow
the exponent to depend on the block marginal, so an advantage
$s^{a-d}$ is acceptable for fixed $d$. However, the source is agnostic and
proper. The learner must also handle same-marginal low-noise labelings and
opposite orientations of the hidden signal. If the proper weak handle requires
sampling the hidden orientation, then for large $d$ the deterministic source
learner cannot orient it with high probability. If the orientation is public
enough for the source to choose safely, then the target learner often gets the
same public handle and the lower bound collapses.

Thus the oracle barrier has the right exponent geometry but not yet the right
source proof. It is a hidden-gap near-counterexample, not an atlas-ready false
witness.

### Provisional Lemma Boundary

The branch suggests the following clean separation between what is known and
what would be needed.

**Conditional positive lemma.** If the source learner's realizable
high-probability margin has a bounded exponent after full-support resource
uniformization, then the edge is true.

**Barrier lemma to try.** There are oracle block families where every
distribution-free weak improper learner has advantage at most
$\operatorname{poly}(s)/|B_{s,d}|$ on block $B_{s,d}$, while a marginal-specific
source analysis can get the same hidden advantage for each fixed $d$.

The missing bridge is the agnostic proper source analysis for the barrier
lemma. It must be deterministic at prediction time, robust to low-noise
same-marginal labels, and proper. The previous opposite-orientation argument
is exactly the obstruction to filling this gap.

### Branch End

verdict: unresolved-open. The finite-output route identifies a sufficient
bounded-exponent condition, but that condition is not implied by the present
source definition. Finite transcript/output structure gives per-size finite
margins, not a uniform inverse-polynomial exponent. The hidden-gap oracle route
still looks like the best route to a false edge, but its agnostic proper source
side remains blocked by deterministic orientation and low-noise robustness.

confidence: 0.84

next branches:

1. Formalize the conditional positive lemma: source plus full-support resource
   uniformization plus bounded realizable margin exponent implies the target.
2. Try to prove an oracle lower bound for keyed blocks of size $s^d$ that
   bounds every polynomial-time improper learner's advantage by
   $\operatorname{poly}(s)/s^d$.
3. Search for a deterministic proper source learner for the same keyed blocks
   that is weak agnostic under each fixed block marginal without estimating a
   hidden orientation at the scale $\operatorname{poly}(s)/s^d$.
4. If that source learner cannot exist, promote the opposite-orientation
   argument into a no-go lemma for hidden-gap oracle barriers rather than for
   the edge itself.

## Depth 5 Branch: transcript certificates and weak-gap uniformization

- depth: 5
- date: 2026-05-05
- focus: whether the full-support finite-transcript argument can be upgraded
  from resource uniformization to weak-gap uniformization, especially using
  finite output descriptions, validation over transcripts, or the properness
  of the source learner
- constraint: scratchpad-only; no atlas files edited

### Question

The depth-4 branch left a narrow possible positive route. After applying the
full-support reference marginal $P^\star$, the source learner $A$ has one
pathwise sample/time polynomial $q(s,\log(1/\delta))$. For each fixed size
$s$, bounded transcripts and bounded random-bit prefixes induce only finitely
many output descriptions. Can this finite transcript/output structure force a
single inverse-polynomial weak advantage for all marginals?

Equivalently, can one strengthen

$$
\forall P\ \exists K(P):
\quad
\operatorname{err}_P(A,c)\le \frac12-s^{-K(P)}
$$

into

$$
\exists K\ \forall P:
\quad
\operatorname{err}_P(A,c)\le \frac12-s^{-K},
$$

using only the fact that $A$ is a single finite-transcript proper learner?

My conclusion is still no. The finite-transcript argument is powerful for
runtime because runtime is a pointwise property of each transcript. It does
not analogously control accuracy, because the size of the correlation witnessed
by a transcript is a marginal-weighted quantity and those weights may be
arbitrarily small inverse polynomials with unbounded exponent.

### What Full-Support Transcripts Actually Prove

Let $T_s$ be the finite set of labeled transcripts and random-bit prefixes
visible to $A$ within the full-support resource bound at size $s$. For every
$\tau\in T_s$, if $\tau$ can occur under some marginal and labeling rule, then
it also occurs with positive probability under $P^\star$ and a suitable
conditional labeling. Therefore $A$ cannot take more than $q(s)$ time or
samples on $\tau$.

This gives a uniform resource theorem because the bad event is local:

$$
\text{``$A$ exceeds $q(s)$ on transcript $\tau$''}
$$

is a transcript-level violation.

Weak accuracy is not local in that sense. A transcript may output a proper
hypothesis $h_\tau$, but its useful margin against a target concept $c$ is

$$
\frac12-\operatorname{err}_P(h_\tau,c)
=
\frac12\mathbb E_{X\sim P}[(-1)^{h_\tau(X)\oplus c(X)}],
$$

which depends on all of $P$, not only on the observed finite transcript. The
full-support reference marginal says $\tau$ has positive probability; it says
nothing quantitative about the $P$-mass of the set where $h_\tau$ and $c$
correlate. A positive transcript probability under $P^\star$ can coexist with
an arbitrarily small useful correlation under the target marginal $P$.

Thus full support can uniformize the cost of producing $h_\tau$, but not the
amount by which $h_\tau$ beats random guessing.

### Finite-Output Enumeration Does Not Remove Validation At The Gap Scale

One might try to convert the finite set of possible outputs into a target
learner:

1. enumerate every output description reachable by $A$ at size $s$;
2. evaluate each candidate on fresh labeled examples from the target marginal;
3. return the candidate with the largest empirical advantage.

This route fails at the same hidden scale. If the best guaranteed source
advantage at a marginal is only $s^{-K(P)}$, distinguishing a useful candidate
from a random or wrong-orientation candidate needs about $s^{2K(P)}$ validation
samples. A distribution-free weak target can validate down to $s^{-K}$ for one
chosen $K$, but it cannot search all possible exponents.

The finite number of candidates also does not imply that the smallest positive
candidate correlation is inverse-polynomial with bounded exponent. For fixed
$s$, the minimum over a finite candidate list and finite domain slice may be a
positive real number $\eta_s$. Across sizes, the sequence $\eta_s$ can decay
like

$$
s^{-1},\ s^{-2},\ s^{-3},\ldots
$$

or faster along selected marginals. The atlas weak target needs a polynomial
lower envelope in $s$, not merely a positive minimum at each fixed $s$.

### Transcript-Certificate Route And Its Boundary

A more refined positive route would look for certificates of weak success.
For example, perhaps every successful run of $A$ has a short transcript
certificate proving that the output's correlation is at least a known
$s^{-K_0}$. Then the target learner could enumerate or validate certificates
rather than estimate tiny correlations directly.

But the source node does not include such a certificate promise. The only
certificate supplied by the definition is semantic: for each marginal $P$,
there exists some exponent $K(P)$ in the analysis of $A$. The learner need not
print $K(P)$, need not know it, and need not expose any public event whose mass
is bounded below by a fixed inverse polynomial.

The distinction is important. The following conditional theorem would be
valid:

> If, after full-support resource uniformization, every realizable successful
> output of the proper source learner has a transcript-checkable certificate of
> advantage at least $s^{-K_0}$ for one fixed $K_0$, then the edge is true.

But this is an added finite-margin/certification assumption, not a consequence
of marginal-nonuniform weak agnostic proper learning. The present source
allows the proof of weak advantage to use a marginal-specific tiny set with
mass $s^{-K(P)}$ and no uniform lower bound.

### Properness Helps Audit False Witnesses, Not Prove The Edge

Properness is asymmetric for this edge. On the positive side, it gives no
extra target burden: the target is improper, so every proper output of $A$ is
already legal. Once we restrict to realizable labels, properness does not
amplify the weak advantage or reveal the exponent.

On the negative side, properness makes counterexamples harder. A false witness
must supply an efficient proper weak agnostic learner for every fixed marginal.
The easy rare-block lower-bound idea usually gives one of two bad outcomes:

- the weak handle is public and proper, in which case the distribution-free
  improper target can also use it;
- the weak handle is hidden behind a small oriented signal, in which case the
  source learner needs validation or orientation samples at the hidden scale
  and fails the full-support pathwise resource audit.

This is why the proper source has not produced a separation even though it also
does not yield a proof. Properness blocks many sloppy hidden-handle witnesses,
but it does not create a generic weak-gap lower envelope.

### Full-Support Does Not Let Us Transfer Accuracy Through A Mixture

Another tempting route is to choose a full-support mixture

$$
P^\star=\sum_i w_iP_i
$$

over bad marginals and argue that a weak hypothesis for $P^\star$ must be weak
on each component. This is false for the weak target unless the component
weight is quantitatively controlled. A hypothesis can ignore component $P_i$
and lose only $w_i$ in global error. If $w_i$ is smaller than the hidden weak
gap promised for $P^\star$, the source guarantee need not notice the failure
on that component.

The component-to-mixture calculation works only for strong accuracy demands
or when the desired component error is scaled by $w_i$. Here the desired
conclusion is an unscaled weak advantage under the target marginal. The
full-support construction deliberately uses tiny positive masses only to
force pathwise resource behavior; those masses are far too small to force
componentwise weak accuracy.

This also explains why size-conditional semantics would change the problem.
If each size slice were normalized before the weak guarantee is evaluated, the
bad-slice diagonal would have more force. Under the current global-marginal
reading, low-mass slices can remain invisible to a weak additive guarantee.

### Current Verdict

verdict: unresolved-open

confidence: 0.86

The edge is still not resolved. Full-support transcript arguments uniformize
the source learner's pathwise resources, including all finite-output
descriptions reachable by bounded transcripts. They do not uniformize the
weak advantage. Finite-output enumeration merely moves the problem to
validation at the unknown gap scale, and properness is target-permissive rather
than gap-amplifying.

### Obstacles

1. **Weak-gap quantifier.** The source supplies
   $\forall P\,\exists K(P)$, while the target needs
   $\exists K\,\forall P$. No read atlas theorem performs this swap for
   computational weak learners.
2. **Accuracy is not transcript-local.** Runtime violations are witnessed on a
   finite transcript; weak advantage is an expectation under the actual
   marginal and can be supported on sets of mass $s^{-K(P)}$.
3. **Validation costs know the exponent.** Enumerating finite outputs requires
   fresh labels to identify a weakly useful output, and that costs roughly the
   inverse square of the unknown hidden advantage.
4. **Properness is not a calibration device.** It restricts source outputs and
   makes false witnesses harder, but because the target is improper, it does
   not add any positive conversion beyond admissibility of the output.
5. **Mixtures dilute weak failures.** A full-support or diagonal mixture can
   force pathwise resource behavior, but weak additive accuracy may ignore
   sufficiently small components.

### Concrete Depth-6 Directions

1. **Certificate lemma.** Prove the conditional positive statement precisely:
   source plus full-support resource uniformization plus transcript-checkable
   advantage certificates at resolution $s^{-K_0}$ implies the target. Then
   identify which common concept classes satisfy this stronger premise.
2. **No-certificate example.** Build a toy finite-slice learner where every
   marginal has a positive finite-output weak margin, but the minimum margin
   sequence over sizes decays with unbounded polynomial exponent. This would
   not be a full atlas counterexample, but it would formally refute the naive
   finite-output compactness proof.
3. **Orientation lower bound.** Turn the same-marginal opposite-orientation
   argument into a lemma: if two realizable labelings differ only on a set of
   mass $\mu$ and require opposite proper defaults, then any high-confidence
   proper source learner with $m$ samples has weak gap at most
   $O(\mu+\sqrt{\mu m})$ unless it has a public orientation rule.
4. **Public-handle dichotomy.** Formalize the counterexample dilemma: public
   proper handles tend to make the improper target positive, while hidden
   handles tend to violate the source under arbitrary same-marginal agnostic
   labels.
5. **Semantic fork.** Separately analyze the edge under size-conditional
   marginal semantics. If slice masses are normalized before evaluating weak
   accuracy, diagonal weak-gap uniformization may become provable; if so, this
   should be recorded as a schema-dependent theorem rather than an atlas
   resolution under current global marginals.

## Depth 6 Branch: final transcript enumeration and hidden-gap audit

- depth: 6
- date: 2026-05-05
- focus: one last hard attempt at finite transcript/output enumeration,
  full-support transcript arguments, resource versus weak-advantage
  uniformization, hidden gap scale validation, and the role of properness in
  possible false witnesses
- constraint: scratchpad-only; no atlas files edited

### Executive Verdict

I still do not see an atlas-ready proof or counterexample. The edge should
remain `open`, but the atlas-facing explanation should be sharpened:

```text
full-support transcript arguments uniformize pathwise resources for the single
source learner; they do not uniformize the hidden weak advantage.
```

The remaining obstruction is exactly the weak-gap quantifier swap

$$
\forall P\ \exists K(P):\quad \gamma_P(s)\ge s^{-K(P)}
\qquad\not\Rightarrow_{\text{known}}\qquad
\exists K\ \forall P:\quad \gamma_P(s)\ge s^{-K}.
$$

Properness neither proves nor refutes the edge. It makes the source stronger
than the corresponding improper-source edge, and it disqualifies some sloppy
hidden-handle counterexamples, but after restricting to realizable labels the
proper hypothesis is already legal for the improper target. Properness does
not reveal, certify, or amplify the hidden weak advantage.

### Last Positive Attempt: Enumerate All Finite Transcripts

Fix the source learner $A$. By applying the source guarantee to a full-support
reference marginal $P^\star$, the atlas pathwise convention gives one
polynomial bound $q(s,\log(1/\delta))$ on every finite labeled transcript that
can arise under any target marginal. Therefore, for each size $s$ and
confidence setting, the following objects are finite:

1. sample transcripts of length at most $q(s)$;
2. random-bit prefixes inspected by $A$ within time $q(s)$;
3. proper hypotheses output by $A$ on those transcripts.

This is enough to enumerate a finite candidate set $\mathcal H_s(A)$ in
principle. If a target learner could also identify a candidate with advantage
at least $s^{-K_0}$ for one fixed $K_0$, the edge would be true. The learner
would enumerate $\mathcal H_s(A)$, validate candidates with
$O(s^{2K_0})$ fresh examples, and return an empirically best one.

The obstruction is that the source does not imply such a $K_0$. For a marginal
$P$ whose best guaranteed candidate has advantage $s^{-K(P)}$, validation
costs $s^{2K(P)}$. Enumerating finitely many transcripts does not avoid this:
it only converts the original source call into a finite list whose useful
correlations may all be at the hidden marginal-specific scale.

In more invariant terms, resource failure is transcript-local:

$$
\text{``$A$ runs too long on transcript }\tau\text{''}
$$

is witnessed by a single finite transcript, so positive probability under
$P^\star$ suffices. Accuracy is not transcript-local:

$$
\frac12-\operatorname{err}_P(h,c)
=
\frac12\mathbb E_{X\sim P}[(-1)^{h(X)\oplus c(X)}]
$$

is an expectation under the actual marginal. Full support only says that
transcripts can occur; it gives no lower bound on the $P$-mass carrying their
correlation. Thus transcript enumeration gives a clean conditional theorem,
not a proof of the edge.

### Conditional Positive Lemma

The following is the strongest positive statement I can defend from the depth
search.

**Lemma.** Suppose the source learner $A$ satisfies the assigned source node
and, after full-support resource uniformization, there is a constant $K_0$
such that for every realizable marginal-target pair $(P,c)$ the high
probability output of $A$ has advantage at least $s^{-K_0}$. Then the assigned
edge is true.

**Reason.** The full-support argument supplies one pathwise polynomial
resource bound for a call to $A$. On realizable labels, the agnostic benchmark
is zero, so $A$ outputs a proper $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le 1/2-s^{-K_0}.
$$

The target is improper, so this proper output is allowed. The same learner,
with the full-support resource polynomial and weak advantage $s^{-K_0}$,
satisfies the distribution-free weak realizable improper target.

This lemma is not an atlas resolution because the bounded-exponent premise is
exactly the missing content. The current source definition permits
$K(P)$ to depend on $P$ with no uniform envelope.

### No-Certificate Toy Obstruction

The finite-output compactness proof fails even before computational hardness
enters. Consider an abstract finite-slice situation where at size $s$ the
only possible useful proper output differs from the target on all but a
distinguishing set of marginal mass $\eta_s$. If

$$
\eta_s=s^{-s},
$$

then every fixed size has a positive margin, and every fixed marginal
supported on a single exponent level has an inverse-polynomial margin in the
local sense of that level. But there is no constant $K$ with
$\eta_s\ge s^{-K}$ for all sizes.

This toy model is not a PAC counterexample, since it does not by itself
construct one uniform agnostic proper learner for all marginals. It is useful
because it isolates the flaw in the finite-enumeration route: finiteness gives
positivity at a fixed slice, not a polynomial lower envelope across slices.
Any proof of the assigned edge must add real learning-theoretic structure
beyond "finite transcripts, finite outputs."

### Hidden-Gap Scale Validation

The same scale obstruction appears in every attempted algorithmic
uniformization. Suppose a target learner runs the source learner several
times, collects candidate proper hypotheses, and validates them from fresh
labeled target examples. If the true available advantage is $\gamma$, then
even distinguishing advantage $\gamma$ from zero requires on the order of
$1/\gamma^2$ validation samples. With

$$
\gamma=\gamma_P(s)\ge s^{-K(P)},
$$

this validation is polynomial for each fixed $P$, but may have unbounded
polynomial degree over all marginals. A distribution-free weak learner must
choose its validation depth before knowing $K(P)$.

Trying to grid over exponents only proves a truncated statement:

```text
for all marginals with K(P) <= D, the edge holds with resources depending on D.
```

The atlas target is stronger: it requires a single fixed exponent and one
polynomial resource bound for all marginals.

### Full-Support Mixtures Do Not Transfer Weak Accuracy

The final possible positive move is to diagonalize over bad marginals by
forming a full-support mixture

$$
P^\dagger=\sum_j w_jP_j.
$$

This works for pathwise resources because every bad transcript has positive
probability. It does not work for weak accuracy. If $A$ fails completely on
component $P_j$, the global loss penalty is at most $w_j$. When $w_j$ is below
the weak advantage scale promised for $P^\dagger$, the source guarantee can
ignore that component.

This is the precise reason the size-conditional semantic fork matters. If
risks were normalized separately on each size/block slice, diagonal stitching
could plausibly force a uniform weak-gap contradiction. Under the current
global-marginal atlas reading, component failures can be diluted by small
mixture weights.

### Last False-Witness Audit

A false witness would need all of the following at once:

1. one uniform polynomial-time learner satisfying the marginal-nonuniform weak
   agnostic proper source;
2. for each marginal $P$, some inverse-polynomial advantage
   $s^{-K(P)}$, with $K(P)$ allowed to be large;
3. for every fixed distribution-free exponent $K$ and every polynomial-time
   improper learner, a realizable marginal-target pair on which advantage
   $s^{-K}$ is impossible;
4. no reliance on marginal-dependent runtime, since full-support transcript
   uniformization already rules that out for a single valid source learner.

The natural block hierarchy has the right target-negative geometry. On a
block of effective size $N=s^d$, a learner that only sees $\operatorname{poly}(s)$
labels can get at most about $\operatorname{poly}(s)/N$ advantage unless it
can predict hidden labels. Choosing $d$ larger than the target exponent defeats
any fixed distribution-free weak guarantee.

The source-positive side is still missing. If the weak proper handle is found
by sampling a rare oriented signal of mass $1/N$, then the source learner
needs validation or orientation samples at the hidden scale, contradicting the
one pathwise polynomial bound for unbounded $d$. If the orientation is public
or deterministic enough for the source learner to use without sampling the
rare signal, the improper target can usually reuse the same handle and the
lower bound collapses. If a cryptographic residual is added, marginals that
concentrate on the residual tend to make the weak agnostic proper source fail.

So the false-witness family is not "PRFs plus rare blocks." It would need a
more delicate public-handle/private-residual split:

```text
the public handle gives every fixed marginal some proper weak agnostic edge,
but no improper distribution-free learner can turn the handles into one fixed
inverse-polynomial weak advantage.
```

I do not know such a construction in the atlas, and the same-marginal agnostic
requirement makes it especially hard: arbitrary label noise over the same
marginal forces the source learner to be robust to opposite orientations and
near-balanced conditionals.

### Does Properness Change The False-Witness Construction?

Yes, but only negatively for the counterexample route.

For a proof, properness is inert. On realizable labels, a proper output is a
valid improper output, so the only target-missing parameter is the weak
advantage exponent.

For a counterexample, properness removes easy source-positive tricks based on
arbitrary randomized or improper predictions. A source learner must output an
actual concept $h\in\mathcal C$ that is weakly competitive with the best
concept under every agnostic labeling at the marginal. This blocks constructions
where the fixed-marginal learner succeeds by prediction-time randomization,
by a non-concept lookup table, or by a validation-dependent mixture of
concepts.

But this does not produce a target lower bound. Since the target is improper,
anything proper and public enough to give the source a uniform pathwise weak
handle is also admissible to the target. Thus properness mainly explains why
verified false witnesses are hard; it does not point to a clean separation.

### Atlas-Facing Synthesis

Recommended status: keep `status: "open"` and `evidence: unknown`.

Recommended family: keep `family: marginal-uniformization-open`, but consider
splitting or adding a more precise family such as
`weak-gap-uniformization-open` for weak-to-weak marginal-nonuniform edges where
full-support transcript uniformization handles one-call resources.

Recommended summary:

```text
Open: full-support transcript uniformization gives one pathwise sample/time
polynomial for the single proper source learner, but on realizable labels the
source yields only a marginal-dependent weak advantage; no known theorem
turns those hidden gaps into one distribution-free inverse-polynomial weak
gap.
```

Recommended proof-status body:

```markdown
Restrict the source learner to realizable labels. For each marginal `P`, the
agnostic optimum is zero, so the source returns a proper hypothesis with error
at most `1/2 - gamma_P(s)`, where `gamma_P` is inverse-polynomial only with a
`P`-dependent exponent. Because the target is improper, this proper output is
admissible.

Under the atlas worst-case transcript convention, a full-support reference
marginal controls the sample use and runtime of this single learner on every
finite transcript that can arise under any marginal. This uniformizes the
one-call resource bound.

The remaining issue is quantitative accuracy. Finite transcript/output
enumeration does not give a lower envelope for the correlations of the
reachable hypotheses, and validating candidate hypotheses costs inverse
quadratic in the hidden advantage. Full-support mixtures can force transcript
coverage but cannot force weak accuracy on low-mass components. Thus the edge
would follow from a weak-gap uniformization theorem or from an added
bounded-exponent/certificate premise, but neither is part of the current
source definition.

Known false-witness templates also fall short. PRF or large-block residuals
can obstruct distribution-free weak prediction, but then the source fails on
marginals concentrating on the hard residual. Public proper handles make the
source plausible but tend to make the improper weak target plausible as well.
Properness therefore sharpens the obstruction for counterexamples without
resolving the implication.
```

### Missing Lemma

The exact missing positive lemma is:

> For every single bounded-transcript learner satisfying marginal-nonuniform
> weak agnostic proper learning, the realizable weak advantages
> $\gamma_P(s)$ have one inverse-polynomial lower envelope independent of
> $P$.

The exact missing negative lemma is:

> There exists a represented concept class with a single pathwise-polynomial
> proper weak agnostic learner whose advantage under each marginal is
> inverse-polynomial with marginal-dependent exponent, but such that every
> polynomial-time improper learner fails to achieve any fixed
> inverse-polynomial weak advantage on some realizable marginal.

Neither lemma is currently supported by the atlas notes or by the depth-6
search.

### Final Depth-6 Verdict

verdict: unresolved-open

confidence: 0.88

Do not change the atlas status based on this pass. The edge is best recorded
as a weak-gap uniformization open problem, not as a pure resource
uniformization problem. The most valuable future work is either a
schema-level decision about size-conditional marginal semantics or a targeted
search for calibrated weak-gap hierarchy witnesses with source-positive
proper agnostic handles.
