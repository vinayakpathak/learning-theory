# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-weak-realizable-proper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- worker constraint: scratchpad only; no atlas files edited
- verdict: unresolved-open
- confidence: 0.88

## Executive Verdict

I do not see an atlas-ready proof or counterexample. The edge should remain
`open`, but the current diagnosis should be sharpened.

The source immediately gives a proper weak learner on realizable labels:

$$
\operatorname{err}_P(h,c) \le 1/2-\gamma_P(s),
\qquad h\in\mathcal C,
$$

where the advantage $\gamma_P$ may depend on the marginal $P$. The target asks
for the same kind of proper weak learner, but with one distribution-free
inverse-polynomial advantage and one distribution-free polynomial resource
bound.

Under the atlas finite-transcript convention, the resource part is not the
main obstruction: full-support marginal uniformization controls the runtime
and sample use of one call to the single source learner. The unresolved
question is weak-gap uniformization:

$$
\forall P\ \exists k(P):\quad \gamma_P(s)\ge s^{-k(P)}
\quad\not\Rightarrow_{\text{known}}\quad
\exists k\ \forall P:\quad \gamma_P(s)\ge s^{-k}.
$$

Because the source is already proper and the target is only weak realizable,
this edge is not a standard properization or boosting question. It is the
proper-output version of the weak-gap envelope problem.

## Files Read

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- Neighboring scratchpads for the improper target and improper-source sibling edges.

## Current Atlas State

The assigned edge is currently:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
```

This is directionally right but incomplete. After the full-support
uniformization argument, the single-call resource polynomial can often be made
distribution-free. What remains hidden is the advantage $\gamma_P$.

## Reduction Of The Edge

Let $A$ be the source learner. For each marginal $P$ there are a polynomial
$p_P$ and a weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

with $1/\gamma_P$ bounded by a $P$-dependent polynomial. For every joint
distribution $\mathcal D$ with marginal $P$, $A$ outputs $h\in\mathcal C$ and
satisfies

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

On realizable labels $Y=c(X)$ the optimum error is zero, so

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s).
$$

Thus the edge reduces to:

> Does marginal-nonuniform weak realizable proper learning with a
> marginal-dependent weak gap imply distribution-free weak realizable proper
> learning with one inverse-polynomial weak gap?

No existing atlas argument proves this.

## Comparison With The Weak-Realizable-Improper Sibling

The sibling

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
-> efficient-weak-realizable-improper-pac
```

has the same weak-gap obstruction, but a weaker target properness requirement.
If the assigned edge were true, the improper-target sibling would follow by
forgetting properness of the output. Conversely, the sibling being open gives
no proof of this stronger proper-target edge.

The source-side properness does not add a new positive mechanism. On
realizable labels the source already returns $h\in\mathcal C$, which is exactly
the target's output constraint. The only missing target feature is a uniform
inverse-polynomial advantage.

The other sibling

```text
efficient-marginal-nonuniform-weak-agnostic-improper-pac
-> efficient-weak-realizable-proper-pac
```

is false by the PCP active-slice witness. That counterexample relies on the
source being improper: one-slice lookup ERM is easy improperly, while proper
weak learning would decide an NP-complete language. It does not transfer to
this edge, because the assigned source is proper.

## What Full-Support Uniformization Gives

Choose a full-support reference marginal $P^\star$ over finite encoded
instances in each size slice. Applying the source to $P^\star$ gives a
polynomial bound for the single learner $A$ on every finite transcript that
can occur with positive probability under $P^\star$. Under the atlas
worst-case finite-transcript convention, that bounds the runtime and sample
use of one call to $A$ under arbitrary target marginals.

Accuracy must still be read under the actual marginal $P$, not under
$P^\star$. For realizable labels it gives only

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s).
$$

There is no density-ratio or mixture argument that turns the $P$-dependent
weak advantage into a single lower envelope. A mixture can give tiny mass to
bad components, and an additive weak guarantee may ignore those components
while still beating $1/2$ globally.

## Positive Routes Tried

### Direct Use Of The Source Learner

Running $A$ directly gives the right proper output and, after full-support
resource uniformization, the right kind of runtime. It proves the target only
if the hidden advantages satisfy

$$
\exists q\ \forall P:\quad \gamma_P(s)\ge 1/q(s).
$$

The source definition gives only $\forall P\ \exists q_P$.

### Size-Indexed Diagonalization

There is a clean proof under stronger semantics. If a marginal were a
size-indexed family $P=(P_s)_{s\ge1}$ and risk at size $s$ were evaluated on
the size-$s$ component with full mass, then failure of a uniform weak gap would
let us choose bad marginals $Q_d$ at sizes $s_d$ with gaps below $s_d^{-d}$.
Stitching them into one diagonal family would contradict the source guarantee
for that single family.

This is not a proof under the current atlas wording. With one global marginal,
the bad size slices can be assigned rapidly decreasing masses. For a target
active only on a low-mass slice, the all-zero concept may have very small
global error even if it has no nontrivial accuracy on the slice itself.

### Compactness At Fixed Size

For a fixed finite size slice and fixed bounded transcript learner, one might
hope compactness gives a positive minimum advantage over all marginals on that
slice. Even if true, this minimum can shrink faster than every inverse
polynomial as the size grows. That is consistent with the source, since each
individual marginal may have its own polynomial exponent.

## Witness Checks

### Halfspaces

Halfspaces do not refute this edge.

They satisfy the source: realizable halfspaces are efficiently properly
learnable by linear feasibility plus VC generalization, constants are proper
halfspaces, and the low-noise robustification gives a proper weak agnostic
learner.

They also satisfy the target. The same realizable halfspace learner is
distribution-free and proper, hence gives weak realizable proper learning.
Tiegel-style agnostic hardness is relevant for weak agnostic targets, not for
this realizable weak target.

### PCP Active-Slice Lookup Class

The PCP active-slice class is target-negative but source-negative.

For a fixed formula $\varphi$, a marginal concentrated on its active PCP slice
and labeled all-positive is realizable when $\varphi$ is satisfiable. Any
proper weak learner on that distribution returns a proof accepted on more than
half of the verifier random strings. If $\varphi$ is unsatisfiable, soundness
keeps every proper proof below one half.

Thus the class separates improper-source edges: an improper one-slice lookup
table learner is easy, but proper weak learning would imply
$\mathrm{NP}\subseteq\mathrm{RP}$. For the assigned edge, however, the source
itself requires a proper weak agnostic learner. Under full-support transcript
uniformization, such a source learner would already give the same randomized
NP decision procedure. So the witness cannot satisfy the source.

Adding obvious proper handles also breaks the lower bound. For example, an
all-one proper handle would weakly learn the satisfiable active-slice
distribution, but it would also destroy the soundness test because unsatisfiable
instances would then have a proper hypothesis accepting more than half the
slice.

### One-Way Image-Coordinate Weak-Handle Class

The one-way image-coordinate weak-handle class is source-positive but
target-positive.

Adding constants and singleton-positive-atom concepts gives proper weak
handles for every marginal. The same handles, together with the low-noise
robustification, make the weak agnostic proper source plausible and are already
used by nearby atlas edges.

But the target here is only weak. For a length-$n$ image-coordinate target, a
constant or a singleton handle gives $\Omega(1/n)$ advantage under every
marginal. Hence the class is efficiently weak realizably properly learnable
distribution-free. The one-way lower bound only applies to strong proper
learning, where high accuracy under a fixed coordinate marginal forces
recovery of the hidden image.

### Dense Code / Hadamard Repairs

The most promising false route is to replace sparse image coordinates by dense
balanced code blocks. A Hadamard-style encoding of a one-way image has the
right target-negative geometry: under the uniform length-$n$ block, every
wrong seed is exactly uncorrelated with the target, so any proper hypothesis
with even inverse-polynomial advantage would recover the one-way image.

The source side is the obstacle. Dense codes remove the sparse lookup or
singleton handles that made weak agnostic learning easy. If one adds sparse
proper handles back in, they may satisfy the marginal-nonuniform source with a
block-dependent tiny advantage, but then the agnostic proof must avoid
validation to the tiny scale; otherwise the source learner's pathwise runtime
would violate full-support uniformization on marginals containing infinitely
many block parameters.

A more refined candidate is a dense PRF block with sparse observed-label
handles:

1. Blocks $B_{n,k}$ have $N=n^k$ or larger coordinate sets.
2. Hard concepts are random-access pseudorandom labels on $B_{n,k}$.
3. Proper handles record a few labeled coordinates and have advantage about
   $1/N$ under the uniform block marginal.
4. For a fixed block marginal, $1/N=n^{-k}$ is still inverse-polynomial with a
   marginal-dependent exponent.
5. A distribution-free target learner with any fixed inverse-polynomial
   advantage could be beaten by choosing $k$ larger than the learner's exponent,
   unless it predicts the dense pseudorandom labels.

This is not atlas-ready. The missing lemmas are substantial: a uniform
finite-transcript proof of the weak agnostic proper source, a clean
representation model for random-access dense concepts and sparse handles, and
a cryptographic reduction showing that no proper hypothesis with polynomial
description can obtain the target's fixed inverse-polynomial advantage.

## Proposed Atlas Update

I would keep the edge open and revise the explanation away from pure
resource-polynomial uniformization.

Suggested frontmatter direction:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: the source specializes to a proper weak realizable learner with a marginal-dependent hidden advantage; full-support uniformization controls one-call resources, but no theorem gives a distribution-free inverse-polynomial lower envelope for the weak gap."
family: weak-gap-uniformization-open
argument_note: "[[weak-gap-uniformization-open|Weak-Gap Uniformization Open]]"
```

If no new family is added, keep `family: marginal-uniformization-open` but
replace the body with the weak-gap explanation.

Suggested body paragraph:

```markdown
On realizable labels, the source learner already outputs a proper hypothesis
with error at most `1/2 - gamma_P(s)`. A full-support reference marginal
controls the runtime and sample use of this single learner under the atlas
finite-transcript convention. The open step is quantitative: the source gives
a separate inverse-polynomial weak gap for each marginal, while the
distribution-free target requires one inverse-polynomial lower bound over all
marginals. The PCP active-slice witness fails the proper source, halfspaces
satisfy the realizable target, and the one-way weak-handle witness is weakly
learnable properly; a counterexample would need source-positive proper handles
whose advantages can be marginal-dependent and super-polynomially small across
blocks, while still preventing any fixed-polynomial weak proper learner.
```

## Obstacles

- **Weak-gap envelope:** The source gives $\forall P\exists k(P)$, while the
  target needs $\exists k\forall P$.
- **PCP source failure:** The best weak proper target-negative witness already
  violates the assigned proper source.
- **Handle leakage:** Adding easy proper handles to repair the source tends to
  make the weak proper target true.
- **Halfspace mismatch:** Halfspace hardness is agnostic; the assigned target
  is realizable.
- **Dense-code source problem:** Balanced cryptographic encodings can make
  weak proper learning hard, but then proving weak agnostic proper learning
  without fine-scale validation is nontrivial.
- **Global-mixture dilution:** Size-indexed diagonalization would likely prove
  a nearby true theorem, but one global marginal can hide bad components under
  small mass.

## Next Directions

1. Split out a `weak-gap-uniformization-open` argument family for edges where
   full-support resource uniformization is available but weak advantages remain
   marginal-dependent.
2. Formalize the size-indexed marginal theorem separately; under that schema,
   this edge likely becomes true.
3. Try to turn the dense PRF block plus sparse proper handles into a real
   conditional separation. Start with the realizable weak source and only then
   attempt the agnostic robustification.
4. Prove a no-transfer lemma showing that weak additive guarantees under a
   global mixture need not imply any useful guarantee on low-mass components.

## Final

verdict: unresolved-open

confidence: 0.88

## Depth 2 Followup: Proper-Handle False-Witness Stress Test

- date: 2026-05-05
- followup depth: 2
- changed_files: this scratchpad only
- verdict: unresolved-open
- confidence: 0.86

### Focus

This pass tested whether the edge can be made `false` for a genuinely
proper-specific reason. The target is weak and proper, so a counterexample
does not need to defeat improper aggregation or boosting. It only needs to
defeat every distribution-free polynomial-time proper learner with one fixed
inverse-polynomial advantage.

That makes the false-witness requirements narrower but sharper:

1. The class must satisfy the source with a single polynomial-time proper
   learner.
2. For each marginal $P$, the source may have a $P$-dependent weak gap
   $\gamma_P(s)\ge s^{-k(P)}$.
3. There must be no distribution-free exponent $d$ and polynomial-time proper
   learner with advantage at least $s^{-d}$ on all realizable marginals.
4. The construction cannot hide source work in a block-dependent runtime:
   full-support transcript uniformization would catch any pathwise runtime
   whose exponent grows with the hard block parameter.

I did not find an atlas-ready witness. The existing candidates still fail for
distinct, useful reasons.

### One-Way Image-Coordinate Weak Handles

The existing one-way image-coordinate weak-handle class is not a witness for
this edge.

It is source-positive in the way recorded by
`one-way-image-coordinate-weak-handle-hardness`: constants and
singleton-positive atoms give proper weak handles, and the marginal-preserving
low-noise robustification supports the weak agnostic proper source. But it is
also target-positive. For a length-$n$ image-coordinate target, the best of
the constants and a singleton on a positive atom has advantage $\Omega(1/n)$
under every marginal. Samples find such a handle in polynomial time, and the
handle is itself a legal proper hypothesis. Thus the distribution-free weak
realizable proper target holds.

The natural repair is to enlarge a block so that the best cheap handle has
advantage about $1/N$, with $N=s^k$. For the fixed marginal concentrated on
that block this is still inverse-polynomial, with exponent depending on the
marginal. A target learner with any fixed exponent $d<k$ would then need more
than the cheap handle.

This repair is promising only as a template. It has three hard obstacles:

- **Runtime cannot scale with $N$.** A valid source learner may output a tiny
  handle quickly, but it cannot validate or search to accuracy $1/N$ by using
  $N$ samples or $N$ time when $k$ is unbounded. Such behavior would violate
  the full-support reference-marginal resource bound.
- **Wrong seed concepts become weak handles.** In the raw image-coordinate
  representation, a wrong image can agree with the target on many coordinates.
  Weak proper learning does not force exact inversion; exact inversion only
  followed in the strong-accuracy one-way argument.
- **Dense codes shift the burden.** Hadamard or hard-core encodings can make
  wrong seeds exactly uncorrelated, but then the source learner sees a dense
  codeword rather than sparse positive atoms. Polynomial-length approximate
  codes leave inverse-polynomial residual correlations, and those residuals
  may exceed the hidden target gap.

So the one-way route would need a new dense-code/handle construction, not a
minor edit of the current weak-handle witness.

### PCP Active-Slice Repairs

The PCP active-slice lookup class has the right target-negative conclusion but
the wrong source behavior.

On the active marginal for an instance $\varphi$, all-positive labels are
realizable when $\varphi$ is satisfiable. Any proper weak learner must return
a proof accepted on more than half of the verifier random strings. If
$\varphi$ is unsatisfiable, PCP soundness keeps every proper proof below that
threshold. Therefore a proper weak source learner for this active-slice class
would already give the same one-sided randomized NP decision procedure used
against the target.

Adding simple proper handles destroys the lower bound. An all-one active-slice
handle would satisfy the satisfiable all-positive distribution, but it would
also be a proper hypothesis accepting more than half the slice for
unsatisfiable instances, eliminating the soundness certificate. A slice handle
that exists only for satisfiable formulas would have to be certificate-bearing;
then it is essentially the original proof concept and does not repair the
source.

The active-slice gate is also essential. If the gate is removed to use a
shared PCP randomness marginal, unrelated satisfiable formulas with perfect
completeness become high-acceptance weak handles. If the gate is kept, the
hard marginal names the input instance, and the assigned source quantifies
over that marginal too. Thus the PCP route cannot currently satisfy the
proper weak agnostic source while preserving weak proper target hardness.

### New Construction Template: Dense Blocks With Tiny Legal Handles

The best remaining false direction is a calibrated proper-handle hierarchy.
At a high level, blocks $B_{n,k}$ would have $N=n^k$ or $s^k$ visible
coordinates. Hard concepts would be dense, balanced, and certificate-indexed
one-way/PRF/PCP codewords on the block. The proper class would also contain
very small legal handles, for example one-coordinate corrections witnessed by
samples.

The intended behavior would be:

1. Under the fixed block marginal, a cheap proper handle gives advantage
   $\Theta(1/N)=s^{-k}$.
2. For each such marginal, this is enough for the source because $k$ is
   absorbed into the marginal-dependent gap.
3. No distribution-free target exponent works: choose a block with
   $k>d$, so the cheap handles are below the target's required advantage.
4. Any proper hypothesis with advantage at least $s^{-d}$ must decode the hard
   certificate, contradicting one-wayness or NP-hardness.

This is not atlas-ready. The missing lemmas are substantial:

- A **source lemma** must prove weak agnostic proper learning with uniform
  transcript resources. Constants handle high-OPT regimes, but in the low-OPT
  regime the learner must find a legal tiny handle without empirical
  validation at the $1/N$ scale.
- A **geometry lemma** must rule out all non-certificate proper weak handles
  above the fixed target scale. Exact orthogonality suggests Hadamard-style
  encodings; finite polynomial domains suggest residual correlations.
- A **hardness lemma** must show that finding any target-scale proper
  hypothesis decodes the one-way image, PCP proof, or other certificate. This
  has to tolerate the extra handle concepts added to make the source true.
- A **marginal lemma** must check arbitrary global marginals. The source can
  absorb a fixed block exponent into $k(P)$, but mixtures over many blocks
  must not create a diagonal marginal whose required gaps shrink faster than
  every inverse polynomial. The earlier global-mixture dilution helps, but it
  has to be proved for the proposed class.

### Proper-Specific Obstacles

- **Weak handles leak to the target.** If the source handle has
  distribution-free advantage $\Omega(s^{-d})$ for some fixed $d$, then it is
  already a target learner.
- **Tiny handles are hard to certify agnostically.** If the handle advantage is
  $s^{-k}$ with unbounded $k$, empirical selection at that scale violates the
  full-support pathwise runtime bound.
- **Proper hardness usually proves too much or too little.** PCP active slices
  prove weak proper hardness but fail the proper source. One-way image
  coordinates preserve the source but prove only strong proper recovery
  hardness.
- **Balanced encodings fight the source.** The geometry needed to make weak
  proper prediction force certificate recovery tends to remove the sparse
  lookup structure that made weak agnostic learning easy.
- **Wrong proper hypotheses need not be certificates.** A target lower bound
  must exclude every legal proper output with fixed inverse-polynomial
  correlation, not merely exact wrong certificates.

### Depth-3 Directions

1. Formalize the dense-block one-coordinate-handle source lemma. Start with a
   realizable low-noise statement and check whether constants plus one sampled
   legal handle give an `OPT + 1/2 - \Theta(1/N)` guarantee without validation
   at scale $1/N$.

2. Build an oracle version of the dense-block hierarchy. Let block labels be
   random or pseudorandom, include legal singleton handles, and prove a
   relativized separation for weak proper target learners before trying to
   encode it as a concrete PAC class.

3. Test a Hadamard one-way image block with explicit size accounting. The key
   question is whether exact orthogonality can coexist with source weak gaps
   that are inverse-polynomial in the representation size rather than
   exponentially small.

4. Prove a PCP handle-soundness lemma: any added proper handle that makes the
   satisfiable active all-one distribution weakly learnable either destroys
   unsatisfiable soundness or encodes a genuine accepting proof. This would
   close the direct PCP repair route cleanly.

5. Separate the schema issue from the witness issue. Under size-indexed
   marginals the weak-gap diagonal likely proves the edge true; under the
   current global-marginal semantics, a false witness must exploit diluted
   mixtures and calibrated tiny handles.

### Depth 2 Verdict

The edge should remain `open`. I do not see a proper-specific counterexample
ready for atlas promotion. The one-way weak-handle witness satisfies the source
but also satisfies the weak proper target; the PCP active-slice witness fails
the proper source; and the dense-block/tiny-handle construction still lacks the
source, geometry, and hardness lemmas needed for a conditional false edge.

confidence: 0.86

## Depth 3 Followup: Dense Tiny-Handles Under Standard And Oracle Assumptions

- date: 2026-05-05
- followup depth: 3
- changed_files: this scratchpad only
- verdict: unresolved-open; dense tiny-handles are not yet a counterexample
- confidence: 0.84

### Question

This pass stress-tests the remaining template from depth 2:

1. Build dense balanced hard blocks $B_{n,k}$ of size $N=N(n,k)$, for example
   $N=n^k$.
2. Let the real concepts be dense codewords, PRF codewords, one-way image
   codewords, or PCP certificate codewords.
3. Add legal proper tiny handles, such as one-coordinate concepts, whose
   advantage under the uniform block marginal is $\Theta(1/N)$.
4. Use marginal nonuniformity to absorb the exponent $k$ in the source weak
   gap.
5. Refute the distribution-free weak realizable proper target by choosing
   $k$ larger than the target learner's fixed exponent.

The target-side intuition is sound at a single block. The source-side and
global-marginal requirements are still the blockers.

### Target-Side Stress Test

At one fixed block, the target lower-bound geometry can be made plausible.
Assume the uniform marginal on a balanced dense block $B_{n,k}$ of size
$N=n^k$.

If the only cheap non-certificate proper hypotheses are singleton or
constant-style handles, then their advantage is at most $O(1/N)$. For any
candidate distribution-free target exponent $d$, choosing $k>d$ puts those
handles below the required $n^{-d}$ weak advantage. A target learner would
then have to output a dense certificate hypothesis with nontrivial correlation
against the true block codeword.

This target-side statement is easiest in an oracle model. Let an oracle define
independent balanced random codewords for the dense seed concepts, while
singleton handles are explicit legal hypotheses. A polynomial-time proper
learner sees only polynomially many coordinates of a block of size $N=n^k$.
For $k$ larger than its query/sample exponent, every unqueried dense seed
looks essentially random, and a singleton handle has advantage only $1/N$.
So the oracle should support a clean target-side diagonal: no fixed exponent
$d$ works uniformly over all $k$.

The same target-side idea has standard-assumption analogues, but they are less
clean. A PRF or one-way image code can make dense prediction computationally
hard, and PCP codewords can force certificate recovery when the active slice
is named. These are exactly the familiar hardness resources checked in the
atlas notes: Kearns--Valiant style weak-learning hardness, PRG/PRF hardness
from one-wayness, and Hastad--Khot perfect-completeness PCP soundness below
$1/2$. None of these by itself proves this edge false, because each only
addresses the target side after the source has already been repaired.

### Source-Side Stress Test

The source requires efficient marginal-nonuniform weak agnostic proper
learning. This is stronger than the realizable one-sample handle story.

For a perfectly realizable balanced block, a sampled labeled point can define
a correct singleton-style handle. If the block is uniform and the handle
defaults to the opposite label off the sampled coordinate, it beats error
$1/2$ by $\Theta(1/N)$. This explains why the template is tempting: the source
could have gap $\gamma_{P_k}(n)\asymp n^{-k}$ on the fixed block marginal
$P_k$.

The agnostic guarantee breaks the simple argument. Constants handle the
regime $\operatorname{OPT}\ge \gamma$: a constant error at most $1/2$ already
satisfies

$$
\operatorname{err}(h)\le \operatorname{OPT}+1/2-\gamma .
$$

The hard regime is $\operatorname{OPT}<\gamma$. A sampled tiny handle is good
only if the sampled label is not corrupted relative to a best concept. If
$\operatorname{OPT}=\gamma/2$, a single sampled handle fails with probability
about $\gamma/2$. The PAC confidence parameter can be much smaller than this.
Amplifying requires selecting a clean handle among candidates, but
distinguishing a $\Theta(1/N)$ advantage from noise by holdout validation
costs at least polynomially in $N$ samples, and usually $\Omega(N^2)$ samples
for direct correlation testing.

That validation cost is not harmless. The atlas finite-transcript convention
forces the single source learner to have one pathwise polynomial bound under
a full-support marginal. If the learner spends $n^{\Theta(k)}$ time or
samples on block parameter $k$, a full-support marginal over unbounded $k$
sees transcripts with unbounded exponents. The exponent can live in the
weak gap, but not in the uniform algorithm's transcript cost.

So the source would need a stronger mechanism:

- a way to find a clean legal handle in the low-noise regime without
  validating at scale $1/N$;
- or public certificates attached to handles that prove they are aligned with
  the best concept;
- or a structural theorem saying constants suffice whenever clean handle
  selection is unreliable.

I do not see such a mechanism in the current dense-block template.

### Handle Leakage Tradeoff

Making handles wider repairs the source only by leaking the target.

Suppose a handle covers $M$ coordinates rather than one coordinate. Then
validation and discovery become easier as $M/N$ grows, and in the realizable
case the handle advantage is about $M/N$. But if $M/N\ge n^{-d_0}$ for one
fixed $d_0$, the same handles give a distribution-free weak proper target
learner with exponent $d_0$. If $M/N$ is kept below every fixed target scale
by choosing unbounded $k$, then the source is back to the certification and
full-support runtime problem.

This is the central tradeoff:

$$
\text{source-visible handle} \quad\Longrightarrow\quad
\text{target-visible handle},
$$

unless "visible" means visible only through a marginal-dependent weak gap and
not through any validation or runtime cost. The current template has no
separate knob that achieves this.

### Global Marginal Stress Test

The block-marginal story is also not enough for the source. The source must
hold for arbitrary marginals, including marginals that mix many dense blocks.

For a fixed marginal concentrated on one $k$-block, $\Theta(n^{-k})$ is an
inverse polynomial with a marginal-dependent exponent. But a single global
marginal can place nonnegligible mass on a sequence of blocks whose parameters
$k(n)$ grow with the represented size. On those blocks, the best tiny-handle
advantage can shrink faster than every inverse polynomial in the concept size.
Constants may save marginals where the hard blocks have tiny total mass, but
that has to be proved from the construction. It is not automatic.

This is different from the target diagonal. For target failure, we may choose
one hard block marginal after seeing the target exponent. For source
satisfaction, one uniform source learner must work for every marginal,
including adversarial mixtures that try to diagonalize against the handle
scale.

### Standard-Assumption Assessment

I do not see a standard-assumption counterexample from dense tiny-handles.

Under length-preserving one-way functions or PRF assumptions, dense block
labels can make target-scale proper prediction hard. But a bare dense
cryptographic block is source-negative: weak agnostic proper learning on the
hard uniform marginal is just the hard prediction task. Adding tiny handles
restores realizable weak handles, but the agnostic high-confidence source
proof then needs clean-handle selection at the tiny scale.

Under $\mathrm{NP}\nsubseteq\mathrm{RP}$ and PCP active slices, the local
target gap is even cleaner because perfect completeness and soundness below
$1/2$ turn weak proper learning into proof finding. But any handle strong
enough to make the satisfiable all-one active distribution source-positive
either gives an unsatisfiable proof-like hypothesis above soundness, or it is
itself a genuine accepting certificate. Packing many active slices into one
fixed marginal again multiplies the weak gap by slice mass.

Thus the standard assumptions support individual pieces of the template, not
the whole source-positive/target-negative witness.

### Oracle Assessment

A relativized target-side separation looks plausible, but a full relativized
counterexample for this edge still needs a source oracle.

Random oracle codewords can make every nonqueried dense seed uncorrelated and
can keep singleton handles below any chosen target exponent. This would show
that the target failure is not the implausible part of the template.

The missing oracle feature is source-side agnostic certification. If the oracle
also tells the learner which sampled handles are clean, then the oracle is
granting source advice that may itself be enough to find target-scale
structure. If it does not, the same low-noise corruption problem remains.
So even in an oracle world, the construction currently proves at most a
"target half-separation," not a false edge.

### Exact Blockers

1. **Agnostic confidence blocker.** One sampled tiny handle is enough in the
   realizable block model, but not for high-confidence agnostic learning when
   $\operatorname{OPT}$ is between $\delta$ and the hidden weak gap.

2. **Tiny-scale validation blocker.** Empirically certifying a
   $\Theta(1/N)$ handle costs polynomially in $N$, which is an unbounded
   exponent when $N=n^k$ and $k$ is the diagonal parameter.

3. **Full-support transcript blocker.** A marginal-nonuniform weak gap may
   have a $P$-dependent exponent, but the single source learner cannot have
   pathwise runtime exponent growing with the observed block parameter under
   a full-support marginal.

4. **Handle leakage blocker.** Increasing handle mass enough to make source
   selection easy tends to give the distribution-free weak proper target.

5. **Dense hardness/source conflict.** PRF, one-way, PCP, and random-oracle
   dense labels help prove target hardness precisely because they hide the
   dense structure. The source needs some efficiently findable proper
   structure under the same marginal.

6. **Mixture blocker.** The source must survive arbitrary global marginals,
   not only the fixed block marginals used for target diagonalization.

### Depth-4 Directions

1. Prove a small no-go lemma for unvalidated sampled handles: if a source
   learner chooses among $\Theta(1/N)$-advantage handles using only
   $o(N)$ validation information, then there is a low-noise agnostic
   distribution with $\operatorname{OPT}<\gamma$ on which confidence cannot be
   driven below the corruption mass.

2. Write the oracle target half-separation cleanly. It would not resolve the
   edge, but it would isolate the remaining missing source oracle and prevent
   future work from rechecking target hardness from scratch.

3. Search for **certified tiny handles**: legal proper handles whose
   correctness is checkable from a short public witness or from the example
   itself, without estimating a $1/N$ correlation. Then test immediately
   whether the certificate gives a target learner the same weak advantage.

4. Formalize the mixture obstruction for dense-block sources. A useful lemma
   would say that any source proof relying only on block-local
   $\Theta(n^{-k})$ handles must either restrict the allowed marginals or
   provide a non-handle mechanism on marginals with unbounded visible $k$.

5. Revisit PCP handles through a soundness-preserving handle lemma: any added
   handle that weakly learns the satisfiable all-one active slice must either
   violate soundness on some unsatisfiable instance or encode an accepting PCP
   proof. If true, this would close the standard PCP repair route.

6. Separate nearby weakened claims. The dense tiny-handle template may work
   for a realizable source, a constant-confidence source, or a size-indexed
   marginal schema. Those would be useful diagnostics, but they would not
   settle this atlas edge.

### Depth 3 Verdict

Dense tiny-handles remain the best false-witness template, but I do not see
an atlas-ready separation under either standard assumptions or a clean oracle
assumption. The target-negative half can be made plausible, especially with
random-oracle or PRF-style dense blocks. The source-positive half is blocked
by agnostic high-confidence clean-handle selection, tiny-scale validation,
full-support transcript bounds, and arbitrary global marginals.

The atlas edge should remain `open`.

confidence: 0.84

## Depth 4 Followup 2026-05-05: Hidden-Gap Theorem Barrier Under Global Mixtures

- date: 2026-05-05
- followup depth: 4
- changed_files: this scratchpad only
- focus: theorem/barrier for hidden weak gaps and global mixtures
- verdict: unresolved-open
- confidence: 0.83

### Question

This pass stops trying to repair the dense tiny-handle witness and asks the
positive question directly:

> Does the proper marginal-nonuniform weak agnostic source already force the
> distribution-free weak realizable proper target under the current atlas
> semantics?

The answer I find is still no theorem. There is, however, a fairly formal
barrier to the natural proof. The source specializes on realizable labels to a
proper weak learner with a marginal-dependent hidden advantage. Full-support
uniformization controls the transcript resources of that learner, but the
current global-marginal semantics do not turn the hidden advantages into one
distribution-free inverse polynomial.

### Same-Learner Gap Functional

After the full-support resource argument, fix the single source learner $A$ and
ignore runtime. For a marginal $P$ and representation size $s$, define
informally

$$
\Gamma_A(P,s)
$$

to be the largest weak advantage that $A$ can be certified to achieve on
realisable labels under $P$ at some fixed confidence, say $2/3$. The exact
definition can absorb constants and confidence amplification; the point is the
quantifier pattern. The source gives

$$
\forall P\ \exists K(P)\ \forall s \gg 1:\quad
\Gamma_A(P,s)\ge s^{-K(P)}.
$$

Using the same learner for the target would require

$$
\exists K\ \forall P\ \forall s \gg 1:\quad
\Gamma_A(P,s)\ge s^{-K}.
$$

The target definition permits a different learner, so failure to uniformize
$\Gamma_A$ is not by itself a separation. It is only a diagnosis of the
obvious proof route: run the source learner directly after resource
uniformization.

### Conditional Size-Indexed Theorem

There is a clean theorem under a stronger semantics. Suppose a marginal is a
size-indexed family

$$
P=(P_s)_{s\ge 1}
$$

and the accuracy guarantee at size $s$ is evaluated conditionally under
$P_s$, with full mass on the size-$s$ slice. If no distribution-free weak gap
exists for $A$, then for every $d$ there are a size $s_d$ and a marginal
$Q_d$ such that

$$
\Gamma_A(Q_d,s_d)<s_d^{-d}.
$$

Stitch these into one size-indexed marginal family by setting
$P^\dagger_{s_d}=Q_d$ and filling the other sizes arbitrarily. The source
guarantee for this single $P^\dagger$ gives some exponent $K(P^\dagger)$.
Choosing $d>K(P^\dagger)$ contradicts the bad slice at size $s_d$.

Thus, under slice-conditional semantics, the source learner's pointwise
inverse-polynomial gaps would collapse to a distribution-free inverse
polynomial. Since the source learner is already proper on realizable labels,
this would prove the assigned edge true.

### Global-Mixture Barrier

The current atlas wording does not use that size-conditioned semantics. A
marginal is a global distribution over encoded instances, and PAC error is a
global expectation. A diagonal family therefore has to be represented as a
weighted mixture

$$
P^\dagger=\sum_i w_i Q_i.
$$

For any fixed hypothesis $h$ and target $c$,

$$
\operatorname{err}_{P^\dagger}(h,c)
=
\sum_i w_i\,\operatorname{err}_{Q_i}(h,c).
$$

So bad behavior on component $Q_i$ changes the global risk by at most $w_i$.
Equivalently, in advantage notation, a learner can lose all useful advantage
on a low-mass component while still beating $1/2$ on the mixture if the
remaining mass supplies enough advantage. Taking weights such as

$$
w_i < s_i^{-i^2}
$$

makes component $i$ invisible to every fixed inverse-polynomial global gap
$s_i^{-K}$ for all sufficiently large $i>K$. This blocks the diagonal
contradiction: the source guarantee for the stitched global marginal may be
true with exponent $K(P^\dagger)$ even though the conditional gaps on the
hidden components decay faster than every fixed inverse polynomial.

This is the formal barrier from global mixtures. Full-support marginals are
excellent for pathwise resource control because rare transcripts still have
positive probability. They do not provide accuracy control on rare regions,
because additive PAC error is allowed to average those regions away.

### Why Properness Does Not Remove The Barrier

The properness axis is not the live positive mechanism here. On realizable
labels the source already outputs $h\in\mathcal C$, exactly as the target
requires. If a uniform weak gap were available, properness would line up
perfectly.

But properness does not force a globally good hypothesis to be conditionally
good on every low-mass component of a mixture. A proper hypothesis can still
be chosen because it is useful on the heavy part of the marginal and useless
on a rare block. This is an error-averaging issue, not an output-class issue.

Properness mainly affects the negative direction. It invalidates the clean
PCP active-slice improper-source witness, and it makes the dense-handle
counterexample harder because every source repair must be a legal proper
hypothesis. Depth 3 already found that the obvious dense tiny-handles do not
give an atlas-ready false witness.

### Hidden Gap And Validation

One might try to convert the pointwise gap into a uniform gap by running $A$
and validating its output. Validation can certify a candidate advantage
$s^{-d}$ using a polynomial budget depending on $d$. It cannot discover that
some smaller hidden gap $s^{-K(P)}$ should be accepted while still producing a
fixed distribution-free exponent.

If the source gap on a marginal is $s^{-K(P)}$ with $K(P)>d$, a holdout test
budgeted for exponent $d$ cannot reliably distinguish the source output from
random guessing at the actual scale. Dovetailing over exponents only helps if
the final target may have an exponent growing with $s$, such as
$K=\log s$, which is not an inverse polynomial of fixed degree. Thus
validation is a useful selector after a uniform lower bound exists; it is not
the missing weak-gap uniformization theorem.

### What Is Resolved By This Pass

This pass gives a barrier to the main positive proof family:

1. direct use of the proper source learner;
2. full-support transcript uniformization for resources;
3. compactness or diagonal stitching to extract a uniform weak gap;
4. holdout validation to find the gap.

Steps 1 and 2 work. Steps 3 and 4 fail under the current global-marginal
semantics. The size-indexed version of step 3 would likely prove the edge
true, but that is a schema change, not the present atlas edge.

This pass does not prove the edge false. A counterexample still needs a
concrete class satisfying the proper weak agnostic source for every global
marginal while defeating every distribution-free weak realizable proper
learner. The previous dense tiny-handle attempts have not supplied that class.

### Depth-5 Directions

1. Formalize a reusable **global-mixture no-transfer lemma**: an
   `OPT + 1/2 - gamma` guarantee on a mixture need not imply any weak
   guarantee on components whose weights are below the global weak-gap scale.

2. Write the **conditional size-indexed theorem** cleanly. Under
   slice-conditional marginals, the diagonal weak-gap proof should yield the
   assigned edge as true by running the source learner directly.

3. Identify extra hypotheses that recover the theorem without changing the
   whole schema: inverse-polynomial lower mass on every active size slice,
   bounded density ratios to a reference marginal, or locally bounded weak-gap
   exponents over neighborhoods of marginals.

4. Revisit the false direction only through a source-positive hierarchy with
   gap-oblivious proper handles. It must survive arbitrary global mixtures,
   not merely fixed uniform hard blocks, and it must avoid handles with any
   fixed distribution-free advantage.

5. Check whether sample-only marginal-nonuniform collapse can be paired with
   the efficient source learner to enumerate a polynomial-size proper
   candidate family. My current expectation is no, because finite VC gives
   unbounded ERM rather than efficient representation-sensitive search, but
   this is the one remaining positive route not covered by the weak-gap
   calculation.

### Depth 4 Verdict

The edge remains `open`. The proper source could imply the proper weak target
under a stronger size-indexed marginal semantics, but under the current
global-marginal semantics the hidden weak-gap quantifier is not uniformized by
full-support resources, compactness, diagonal mixtures, or validation.

confidence: 0.83

## Depth 6 Final Synthesis

- date: 2026-05-05
- followup depth: 6
- changed_files: this scratchpad only
- edge: `efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-weak-realizable-proper-pac`

### Final Hard Pass

I still do not see an atlas-ready proof or counterexample. The edge should
remain `open`, but the atlas note should stop presenting the obstruction as
only a marginal-dependent resource polynomial.

On realizable labels, the source learner already has the target's proper
output form. For each marginal $P$ it gives

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s),
\qquad h\in\mathcal C,
$$

where $1/\gamma_P(s)$ is bounded by a polynomial whose exponent may depend on
$P$. The full-support marginal argument can make the sample and running-time
bound of this same learner distribution-free, because those bounds are
pathwise finite-transcript resource bounds. It does not change the accuracy
statement, which must still be applied under the actual marginal $P$.

Thus the live gap is exactly

$$
\forall P\ \exists k(P):\gamma_P(s)\ge s^{-k(P)}
\quad\not\Rightarrow_{\text{known}}\quad
\exists k\ \forall P:\gamma_P(s)\ge s^{-k}.
$$

If the atlas instead used size-indexed, slice-conditional marginals, a
diagonal stitching argument would likely prove this implication true: bad
exponents at sizes $s_i$ could be stitched into one marginal family that is
seen at full mass on its own size slice. Under the current global-marginal
reading, stitching becomes a weighted mixture, and a low-mass hard slice can
be averaged away in additive PAC error. This is why full support helps
resources but not weak gaps.

Compactness and validation also do not close the gap. Compactness at a fixed
size might give a positive minimum advantage over finitely many bounded
transcripts, but gives no inverse-polynomial rate as size grows. Holdout
validation can certify a hypothesized gap $s^{-d}$ with polynomial resources
depending on $d$, but it cannot discover that the hidden source gap has some
larger marginal-dependent exponent $k(P)>d$ while still producing one fixed
distribution-free target exponent.

### Proper Target Diagnosis

The target being proper is not a new positive obstruction: the source is
already proper, so the direct route outputs a legal $h\in\mathcal C$ on
realizable labels. If a uniform weak gap were available, the properness axis
would line up cleanly.

Properness matters on the negative side. A false witness must make the proper
source true for every marginal while making the distribution-free weak proper
target false. That is much harder than the improper-source sibling: any easy
proper handle used to satisfy the source is itself a legal target output, and
if it has any fixed inverse-polynomial advantage then the target is already
true. Conversely, PCP-style witnesses that make weak proper learning hard tend
to fail the assigned source, because the source itself would have to output
the proof-like proper hypothesis on the hard active marginal.

So this edge is best classified as a proper-output weak-gap uniformization
problem, not as a generic properization problem. The source properness removes
the usual improper-to-proper projection issue, but it also blocks the cleanest
known proper-target lower bounds.

### Why The Known Witnesses Fail

**Halfspaces.** They are not a witness. Realizable halfspaces are efficiently
properly learnable distribution-free, so they satisfy the weak realizable
proper target. Agnostic hardness for halfspaces is aimed at agnostic targets,
not at this realizable weak target.

**PCP active-slice lookup class.** This gives a clean false edge for the
improper-source/proper-target sibling, but it is source-negative here. On the
active marginal for an NP instance $\varphi$, all-positive labels are
realizable when $\varphi$ is satisfiable. A proper weak learner would output a
proof accepted on more than half the verifier strings, while soundness keeps
unsatisfiable instances below one half. Thus the assigned proper source would
already imply the forbidden randomized NP decision procedure. Adding obvious
proper handles either destroys soundness or encodes the original accepting
proof.

**One-way image-coordinate weak handles.** This route is source-positive but
target-positive. Constants and singleton-positive-atom handles give proper
weak advantages of order $\Omega(1/n)$ on length-$n$ coordinate blocks, so the
distribution-free weak realizable proper target holds. The one-way lower bound
only forces strong proper recovery, where high accuracy under a fixed
coordinate marginal reveals the hidden image.

**Dense PRF, Hadamard, or rare-block handle repairs.** These remain useful
diagnostics, not atlas witnesses. Dense balanced blocks can make the
target-negative geometry plausible: for block size $N=s^k$, cheap handles have
only $1/N$ advantage, and any fixed target exponent can be beaten by choosing
$k$ larger. But the source side is not verified. A weak agnostic proper source
must find and orient a useful legal proper handle with high confidence, under
arbitrary marginals, without validation or runtime depending on $N$. Near
balanced blocks with bias $1/2\pm\Theta(1/N)$ force an orientation decision at
the hidden scale; empirical tests at that scale cost polynomially in $N$, an
unbounded exponent under the full-support transcript convention. If a public
or wider handle avoids this, it tends to leak a fixed inverse-polynomial
target learner.

### Proposed Atlas Sharpening

Suggested frontmatter direction, if atlas edits are later allowed:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
summary: "Open: restricting the marginal-nonuniform weak agnostic proper source to realizable labels gives a proper weak learner with a marginal-dependent advantage; full-support uniformization controls one-call resources, but no known theorem uniformizes the weak gap to one distribution-free inverse polynomial."
family: weak-gap-uniformization-open
argument_note: "[[weak-gap-uniformization-open|Weak-Gap Uniformization Open]]"
```

If no new argument family is added, keep
`family: marginal-uniformization-open`, but make the body explicitly split
resource uniformization from weak-gap uniformization.

Suggested body replacement:

```markdown
**Goal.** Decide whether a marginal-dependent weak advantage can be made
distribution-free when the source learner is already proper.

On realizable labels, the source learner outputs $h\in\mathcal C$ and gives
$\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s)$ for the actual marginal $P$.
The full-support marginal argument can uniformize the pathwise sample and
running-time bounds of this single learner, but it does not provide one
inverse-polynomial lower bound on $\gamma_P$ over all marginals. The target
requires such a bound.

This is not a standard properization obstacle: the source output is already
proper. Known witnesses do not settle the edge. Halfspaces satisfy the
realizable proper target; the PCP active-slice class fails the assigned proper
source; one-way image-coordinate weak handles make the target true; and dense
hidden-gap handle templates have not supplied a source-positive proper weak
agnostic learner with uniform pathwise resources. A proof would need a
weak-gap uniformization theorem, while a counterexample would need a concrete
proper source-positive hierarchy whose weak handles remain below every fixed
distribution-free inverse-polynomial target gap.

**Conclusion.** The edge remains open under the current global-marginal atlas
semantics.
```

### Final Verdict

No status change is justified. The best final atlas diagnosis is:

- resource uniformization: essentially handled by full-support finite
  transcripts for the single source learner;
- weak-gap uniformization: unresolved and the central obstruction;
- proper target: aligned with the source for the positive route, but it
  invalidates the clean improper-source witnesses;
- false-witness status: no PCP, one-way-coordinate, halfspace, dense-code,
  PRF, or rare-block handle construction is currently source-positive and
  target-negative for this exact edge.

verdict: unresolved-open

confidence: 0.84
