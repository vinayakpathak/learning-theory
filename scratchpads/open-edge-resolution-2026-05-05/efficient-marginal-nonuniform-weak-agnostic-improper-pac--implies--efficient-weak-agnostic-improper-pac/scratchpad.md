# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac

- date: 2026-05-05
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- verdict: unresolved-open
- confidence: medium-high

## Context

The current edge note is marked `open` in the `marginal-uniformization-open`
family. Its stated obstacle is that the source allows a marginal-dependent
polynomial resource bound, while the target asks for one distribution-free
polynomial resource bound.

That is no longer the sharp obstruction under the current atlas convention.
`atlas/README.md` says efficient PAC sample use and running time are
worst-case/pathwise bounds on finite encoded sample transcripts. Under that
convention, `atlas/arguments/full-support-marginal-uniformization.md` gives a
valid resource-uniformization argument for any single marginal-nonuniform
learner.

The assigned edge is different from the nearby strong-agnostic edges because
the source is already weak. The source definition gives, for every marginal
$P$, a tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2
$$

where $1/\gamma_P(s)$ is bounded by a polynomial whose coefficients and degree
may depend on $P$. The distribution-free target instead needs one weak
agnostic tolerance, equivalently one weak gap, independent of the marginal
(a fixed $\beta<1/2$ in the target note, or a parameterized gap with one
distribution-free polynomial dependence on $1/(1/2-\beta)$).

## What Full-Support Uniformization Gives

Let $A$ be the single learner promised by the marginal-nonuniform source.
Choose a reference marginal $P^\star$ with full support on every finitely
encoded instance in each representation-size slice. Applying the source
resource guarantee to $P^\star$ gives a polynomial $p_{P^\star}$ bounding
sample use and running time on all finite labeled transcripts that can occur
with positive probability under $P^\star$.

Because $P^\star$ has full support, every finite labeled transcript that can
arise under any marginal $P$ and any conditional label rule can also arise with
positive probability under $P^\star$ for a suitable conditional label rule. If
$A$ exceeded $p_{P^\star}$ on that transcript, it would violate the source
resource guarantee at $P^\star$. Thus $p_{P^\star}$ is a single
distribution-free polynomial resource bound for $A$.

So the old resource-only obstacle is handled for this edge.

## Why This Does Not Prove the Target

Accuracy is not transferred from $P^\star$. For an actual joint distribution
$\mathcal D$ with marginal $P$, the source guarantee can only be applied to the
actual $P$, giving

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s).
$$

This does not imply

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta
$$

for any single $\beta<1/2$ independent of $P$. Equivalently, the proof gives no
distribution-free inverse-polynomial lower bound on $\gamma_P(s)$.

The full-support transcript argument is deliberately pathwise: it can rule out
long-running transcripts because even a rare transcript contradicts a
worst-case resource bound. PAC accuracy is probabilistic, so rare transcripts
under $P^\star$ may be safely absorbed into the failure probability. A marginal
$P$ can be viewed as concentrating on a region that is very rare under
$P^\star$; correctness of $A$ under $P^\star$ need not control correctness of
$A$ under that conditional marginal. The source separately promises correctness
under $P$, but only with the $P$-dependent weak gap.

For each fixed representation size $s$, one might try a compactness argument:
after resource uniformization, $A$ is a bounded finite-sample procedure, and if
it has some positive weak gap for every marginal on a finite slice, then the
worst gap over that slice is positive. This still falls short of the atlas
target. The resulting worst gap may shrink faster than every inverse
polynomial as $s$ grows. The source permits exactly this behavior, since each
individual marginal may have its own polynomial exponent and constants.

## Why Nearby True Edges Do Not Transfer

The sibling edge

`efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac`

is resolved true because the strong agnostic source can be run at a chosen
constant excess tolerance, say $\varepsilon=1/4$. Then full-support
uniformization handles only resources, while the weak gap is chosen by the
algorithm call and is already distribution-free.

Here there is no accuracy parameter to set. The source weak learner supplies
only its hidden marginal-dependent $\beta_P(s)$. The fact that both source and
target are weak agnostic improper removes properization and boosting issues,
but it leaves a genuine weak-gap uniformity issue.

The sample-only edge to `sample-efficient-weak-agnostic-improper-pac` is also
true by the Hanneke-Moran-Thiessen marginal-nonuniform trichotomy plus VC
theory. That route uses unbounded ERM after runtime is ignored. It does not
give the computationally efficient target; the atlas already records
pseudorandom-function classes as witnesses that sample-efficient weak learning
need not imply efficient weak learning under standard cryptographic
assumptions.

## Attempted Positive Routes

1. **Use the same learner after resource uniformization.** This gives one
   polynomial runtime but only the guarantee
   `OPT + beta_P(s)`. No bound in the current notes turns
   `sup_P beta_P(s)` into a value below `1/2`, let alone below
   `1/2 - 1/poly(s)`.

2. **Transfer accuracy from the full-support marginal.** This fails because
   PAC accuracy is not pathwise. Positive probability of a bad conditional
   region under $P^\star$ is not a contradiction if that region has probability
   below the allowed failure level.

3. **Use sample-complexity equivalence.** The source implies distribution-free
   sample-efficient weak agnostic learning, but converting the unbounded ERM
   learner to polynomial time is exactly the computational issue. The
   pseudorandom-function sample-to-computational separation blocks this as a
   generic proof strategy.

4. **Boost or validate the hidden gap.** The target is weak, so no
   weak-to-strong conversion is formally needed. Still, any attempt to improve
   a tiny $\gamma_P(s)$ to a fixed gap would require runtime depending
   polynomially on a distribution-free lower bound for $\gamma_P(s)$, which is
   the missing information.

## Counterexample Search

A resolved false witness would need a class with a single polynomial-time
learner $A$ such that every fixed marginal has an inverse-polynomial weak
agnostic gap, but the gaps have no distribution-free inverse-polynomial lower
bound and no other polynomial-time learner achieves such a uniform gap.

Standard candidates do not currently give this:

- Pseudorandom-function classes refute efficient weak learning under a hard
  distribution, but then they also threaten the marginal-nonuniform source at
  that marginal.
- Halfspace/lattice hardness gives useful agnostic hardness separations, but it
  does not establish the positive marginal-nonuniform weak source for this
  edge while refuting only the uniform weak gap.
- Properness witnesses such as clause-satisfaction lookup or one-way
  image-coordinate classes separate proper from improper targets, but the
  assigned target is improper.

An artificial diagonalization over marginals might realize the hidden-gap
phenomenon, but I do not have an atlas-ready concept class and source learner
that satisfy the source while violating the distribution-free weak target.

## Suggested Atlas Refinement

No status change is justified. I would keep the edge open, but revise the
explanation so it no longer says the main obstacle is just the
marginal-dependent resource polynomial.

Suggested frontmatter direction:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
  - bendavid2001
  - kalai2008agnosticboosting
summary: "Open: full-support marginal uniformization gives one transcript-wise resource polynomial, but the weak agnostic source still allows the additive gap beta_P(s) to depend on the actual marginal; the target needs a marginal-independent weak gap."
```

Potential family options:

- Keep `family: marginal-uniformization-open`, but update the shared argument
  note to distinguish resource uniformization from weak-gap uniformization.
- Or introduce a sharper family such as `weak-gap-uniformization-open` for weak
  marginal-nonuniform to weak distribution-free edges whose only remaining
  issue is the marginal-dependent advantage.

Suggested body replacement:

```markdown
## Verdict

`open`.

Full-support marginal uniformization handles the sample/time part under the
atlas worst-case transcript convention. Let `A` be the single source learner
and let `P^star` be a full-support reference marginal. The source guarantee at
`P^star` gives a polynomial `p_{P^star}` bounding every finite transcript that
can arise under any marginal, hence one distribution-free resource bound.

However, accuracy for an actual marginal `P` still comes from the source
guarantee at `P`, yielding only
`err_D(h) <= OPT_C(D) + beta_P(s)`. The target requires one weak tolerance
`beta < 1/2`, or equivalently a distribution-free inverse-polynomial lower
bound on `1/2 - beta_P(s)`. The full-support argument does not transfer the
accuracy gap from `P^star` to `P`, and the source definition gives no
quantitative control over how the weak gap varies with `P`.

Thus the edge remains open. A proof would need a weak-gap uniformization
theorem or a different efficient learner; a counterexample would need a class
that is weakly learnable with marginal-dependent inverse-polynomial advantages
for every marginal but has no polynomial-time distribution-free weak agnostic
learner with a uniform inverse-polynomial advantage.
```

## Next Directions

1. Formalize the weak-gap uniformization question separately from resource
   uniformization. The full-support note should be treated as resolving only
   pathwise sample/time bounds.

2. Check whether a bounded finite-transcript learner with positive gap for
   every marginal can have a worst marginal gap that is superpolynomially small
   in the representation size. If yes, this gives the right abstract shape for
   a false witness; if no, it may yield a true theorem.

3. Search for concrete classes with polynomial-time "barely weak" learners
   whose marginal-specific advantages have unbounded polynomial degree, while
   known cryptographic hardness rules out any uniform inverse-polynomial weak
   learner.

4. If the atlas intends marginal-nonuniform weak nodes to require a
   marginal-independent weak gap, then the source definition should be changed.
   Under the current definition, the hidden gap is the blocker.

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/sample-efficient-weak-agnostic-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--sample-efficient-weak-agnostic-improper-pac.md`
- OpenReview page for Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability": https://openreview.net/forum?id=aoVCFtox89
- ScienceDirect page for Benedek and Itai, "Learnability with respect to fixed distributions": https://www.sciencedirect.com/science/article/pii/030439759190026X
- ScienceDirect page for Ben-David, Benedek, and Mansour, "A Parameterization Scheme for Classifying Models of PAC Learnability": https://www.sciencedirect.com/science/article/pii/S0890540185710942

verdict: unresolved-open
confidence: medium-high

## Depth 2: Weak-Gap Diagonalization Attempt

- date: 2026-05-05
- depth: 2
- worker note: appended only to this scratchpad; no atlas files edited.

### Endpoint Recheck

The source definition is stronger on algorithms but weaker on quantitative
advantage than the target. It gives one learner $A$ for all joint
distributions, and for each marginal $P$ there are a polynomial $p_P$ and a
gap

$$
\gamma_P(s)=1/2-\beta_P(s)>0
$$

with $1/\gamma_P(s)$ bounded by a polynomial whose constants and degree may
depend on $P$. The target asks for an efficient weak agnostic learner with a
single distribution-free gap, equivalently one inverse-polynomial lower bound
on $\gamma(s)$ uniform over marginals.

After the depth-1 full-support argument, I am treating sample use and runtime
as already uniformized. The remaining question is therefore:

> Given a single polynomial-time learner $A$ such that every fixed marginal
> has some inverse-polynomial agnostic weak gap, must there be one
> inverse-polynomial gap working for all marginals?

For the same learner $A$, a useful formal object is

$$
\Gamma_A(P,s)=\sup\{\gamma:\ A\text{ satisfies }
\operatorname{err}_{\mathcal D}(h)\le \operatorname{OPT}_{\mathcal C}(\mathcal D)
+1/2-\gamma
\text{ for every }\mathcal D\text{ with marginal }P\}.
$$

The source says: for every $P$, $\Gamma_A(P,s)\ge 1/q_P(s)$ for some
$P$-dependent polynomial $q_P$. The target would follow from the same learner
only if there were one polynomial $q$ with
$\Gamma_A(P,s)\ge 1/q(s)$ for all $P$.

### Conditional Positive Route That Almost Works

There is a clean diagonal proof under a stronger size-family interpretation of
the marginal quantifier.

Assume that a "marginal" in the source is allowed to be an arbitrary
size-indexed family $(P_s)_s$, and that accuracy at representation size $s$ is
measured conditionally on the $s$-slice. If no uniform inverse-polynomial gap
exists, then for each $r$ we can choose a size $s_r$ and a marginal $P^{(r)}$
with

$$
\Gamma_A(P^{(r)},s_r)<s_r^{-r}.
$$

Define a diagonal marginal family $P^\dagger$ by setting its $s_r$-slice to
$P^{(r)}$ (and filling the other sizes arbitrarily). The source applied to
$P^\dagger$ gives a polynomial $q_{P^\dagger}(s)\le C s^d$. For $r>d$ and
$s_r$ large enough, the source would require

$$
\Gamma_A(P^\dagger,s_r)\ge 1/q_{P^\dagger}(s_r) \ge C^{-1}s_r^{-d},
$$

contradicting $\Gamma_A(P^{(r)},s_r)<s_r^{-r}$ after absorbing constants.
Under that strengthened convention, the edge would be resolved true once
runtime has been uniformized.

I do not think this is an atlas-ready proof for the current edge. The
depth-1 notes and the full-support argument treat a reference marginal as a
distribution with full support on finite encoded instances, not explicitly as
an adversarial sequence of conditionals with slice-conditional risk. If one
tries to encode the diagonal family as a single global distribution by giving
the bad sizes weights $w_r$, weak agnostic accuracy no longer forces
conditional performance on those slices. A hard slice of small mass can be
hidden in the additive target because the guarantee is global:

- If the hard slice has small mass and labels outside it are noisy, then
  $\operatorname{OPT}_{\mathcal C}$ is already close to $1/2$, so
  `OPT + 1/2 - gamma` is nearly vacuous.
- If labels outside it are easy and realizable, good performance outside the
  hard slice can supply a large global weak advantage even when the learner has
  only $s_r^{-r}$ conditional advantage on the bad slice.
- Giving constant mass to infinitely many bad slices is impossible in one
  probability distribution.

So the diagonal idea identifies a possible definitional route to `true`, but
it does not extract a uniform gap from the source as currently written.

### Semi-Formal False-Witness Template

A false witness would need a block hierarchy of learning tasks. The intended
shape is:

1. The instance space is a disjoint union of blocks $B_{s,k}$, where $s$ is
   representation size and $k$ is a difficulty or scale index.
2. There is one uniform polynomial-time learner $A$ whose guaranteed agnostic
   weak advantage on block $k$ is about
   $\gamma_k(s)=s^{-k}$.
3. For every fixed marginal $P$, the blocks that matter to $P$ have a
   polynomially bounded effective scale $k_P$, so $A$ satisfies the source
   with gap at least $s^{-k_P}$.
4. For every candidate distribution-free polynomial $s^{-d}$, there is a
   marginal concentrated on a block $k>d$ where no polynomial-time learner can
   achieve agnostic weak advantage $s^{-d}$.

This would realize exactly the hidden-gap phenomenon: every fixed marginal has
some inverse-polynomial gap, but the exponents are unbounded over marginals.

I do not yet have a valid class instantiating this template. The obstacles are
substantial:

- The source quantifies over all marginals. If a marginal can put constant mass
  on blocks $k=k(s)$ growing with $s$, then the source learner's gap
  $s^{-k(s)}$ is not inverse-polynomial. The construction must either rule out
  that marginal by the formal model or make the global weak condition
  insensitive to such moving blocks.
- The target failure must keep $\operatorname{OPT}_{\mathcal C}$ small on the
  bad marginal. Otherwise a weak agnostic additive tolerance near $1/2$ is too
  easy to satisfy.
- A public "barely weak" signal can give $A$ an advantage schedule
  $s^{-k}$, but it does not by itself prove that no other polynomial-time
  learner has a larger uniform advantage.
- Standard PRF-style hardness is too strong in the wrong way: if it rules out
  every inverse-polynomial advantage on some fixed marginal, then that marginal
  also violates the source.

Thus the natural false-witness plan needs a calibrated hardness hierarchy:
block $k$ should admit efficient advantage $s^{-k}$, but should resist
advantage $s^{-d}$ for every $d<k$. I do not know a standard atlas witness
with that precise "barely weak but not more weak" behavior.

### Depth-3 Directions

1. Pin down the marginal semantics. If atlas marginals can be formalized as
   size-indexed families with slice-conditional PAC risk, the diagonal argument
   above likely resolves the edge true. If marginals are global distributions
   over encoded instances, the weak-gap obstruction survives.

2. Define $\Gamma_A(P,s)$ for bounded transcript learners and study its
   semicontinuity on each finite size slice. This may prove that each fixed
   slice has a positive minimum while still allowing the minima to shrink
   superpolynomially with $s$.

3. Search for calibrated block hierarchies rather than ordinary cryptographic
   hard classes. The needed lower bound is not "no weak learner"; it is "no
   learner with a better exponent than the block permits."

4. In any proposed counterexample, first test the realizable restriction
   $\operatorname{OPT}=0$. If the construction only works when OPT is near
   $1/2$, it probably exploits vacuity of the additive weak agnostic guarantee
   rather than separating the edge.

5. Compare with the sibling strong-agnostic source. There the learner can be
   run at a chosen excess tolerance, so full-support resource uniformization is
   enough. Any proof here must replace that missing tunable tolerance with a
   genuine weak-gap uniformization theorem.

### Depth-2 Conclusion

No atlas-safe resolution found. I can prove the edge only under a stronger
slice-family reading of "marginal"; under the current scratchpad reading, the
gap can still vary over marginals with unbounded polynomial degree. I also do
not have a concrete false witness, only the calibrated block-hierarchy shape
and the obstacles above.

verdict: unresolved-open
confidence: medium

## Depth 3: Coordinate-Block Completion of the False Template

- date: 2026-05-05
- depth: 3
- worker note: appended only to this scratchpad; no atlas files edited.

### Short Verdict

The calibrated block hierarchy looks completable, conditionally on standard
PRF hardness, if the current atlas semantics are read as the depth-2 scratchpad
reads them: a marginal is not an arbitrary adversarial size-indexed family with
slice-conditional risk. Under the stronger slice-family semantics from depth 2,
the same construction is killed by the diagonal $k=k(s)$ marginal and the edge
would instead look true.

So this is a conditional false-witness completion for the present semantics,
not a semantics-independent theorem.

### Construction Sketch

Use a hierarchy of PRF-backed coordinate blocks. For every security/size
parameter $n$ and scale $k$, let

$$
B_{n,k}=[r]\times\{0,1\},\qquad r=n^k.
$$

A seed $a$ for a length-preserving PRF defines a concept on this block by

$$
c_{a,k}(i,b)=1 \quad\text{iff}\quad b=F_a(i).
$$

Thus each coordinate pair has exactly one positive atom. The full class is the
disjoint union over $k$, with concepts active on one coordinate block and easy
off that block. Improper hypotheses may be lookup tables on sampled
coordinates, so they do not need to recover the PRF seed.

This is the same geometry as the one-way image-coordinate class, but with
$n^k$ coordinates rather than $n$ coordinates. The scale $k$ is the hidden weak
gap exponent.

### Why the Marginal-Nonuniform Source Should Hold

Fix a constant $T$ and let one uniform learner draw

$$
t=s^T\log(1/\delta)
$$

examples, independent of $k$. From a labeled example $(i,b,y)$ in a coordinate
block, the learner can infer the positive atom of that coordinate: it is
$(i,b)$ if $y=1$ and $(i,1-b)$ if $y=0$. The learner forms improper lookup
hypotheses that correct the observed coordinates and use one of the two
constants elsewhere; validation chooses among the constants and these lookup
candidates.

For a fixed block scale $k$, this gives a realizable weak edge of order

$$
\gamma_{P,k}(s)\gtrsim s^{T-k}
$$

up to constants depending on the marginal. Intuitively, if constants are not
already weakly good, then the active block has nontrivial mass and the target
is not too label-skewed. A polynomial number $t$ of samples then covers a
$t/r$ fraction of the relevant coordinate mass in the worst balanced case; if
the marginal is spiky, coverage only improves. Since $r=s^k$ on the block,
the resulting advantage is inverse-polynomial for every fixed $k$, with degree
depending on $k$.

For a fixed global marginal $P$, concepts on blocks with small $P$-mass are
handled by a constant hypothesis, because the concepts are easy off their
active block. Only finitely many disjoint active blocks can have constant
mass, so $P$ has a finite worst relevant scale $k_P$. The same uniform learner
therefore has a $P$-dependent inverse-polynomial weak realizable gap.

The runtime and sample use are already bounded by the single polynomial
$s^T\log(1/\delta)$, so this avoids the depth-1 full-support resource
obstruction.

Finally, the atlas low-noise weak agnostic robustification should upgrade this
realizable marginal-nonuniform learner to an agnostic marginal-nonuniform
learner, shrinking the gap to something like

$$
\alpha_P(s)\le \min\{\gamma_P(s)/4,\;1/(8s^T)\}.
$$

That still has a marginal-dependent inverse-polynomial gap. Thus the source
node is satisfied.

### Why the Distribution-Free Target Fails

Assume there is a distribution-free efficient weak agnostic improper learner
with runtime/sample bound $s^D$ and weak gap at least $s^{-d}$ on realizable
distributions. Choose a fixed scale

$$
k>D+d+3.
$$

On the hard marginal uniform over $B_{n,k}$, a sample reveals the PRF value on
only the sampled coordinate. A learner using at most $s^D$ samples can directly
learn at most $s^D$ of the $r=s^k$ coordinates. On unseen coordinates, PRF
security says no randomized polynomial-time learner predicts $F_a(i)$ with
inverse-polynomial correlation. Hence its realizable advantage over random
guessing is at most

$$
O(s^{D-k})+\operatorname{negl}(s),
$$

so its error is at least
$\frac12-O(s^{D-k})-\operatorname{negl}(s)$, which is worse than
$\frac12-s^{-d}$ for the chosen $k$. Since weak agnostic learning would
specialize to weak realizable learning when $\operatorname{OPT}=0$, this
contradicts the assumed target learner.

This lower-bound shape is calibrated rather than absolute: block $k$ is
learnable with advantage about $s^{-k}$ by cheap improper memorization, but
beating that exponent requires predicting unseen PRF coordinates.

### Remaining Checks Before Promoting to an Atlas Edge

1. Write the source lemma cleanly for arbitrary marginals. The needed estimate
   is an occupancy/coverage bound for coordinate blocks: constants handle
   skewed or low-mass cases, while $t$ samples and coordinate lookup reduce
   error by $\Omega(t/r)$ in the balanced case. This should be a short lemma,
   but it is the main proof detail not fully formalized here.

2. State the semantics caveat explicitly. If a source marginal may be an
   arbitrary size-indexed family that puts constant slice mass on block
   $k(s)\to\infty$, then this witness fails and the depth-2 diagonal proof
   points to `true`. The false witness uses the current global-marginal
   reading under which moving high-$k$ blocks can be made weakly irrelevant to
   any fixed marginal by constants unless the marginal gives one of them
   constant mass.

3. Decide how to encode $k$ in the representation-size convention. The clean
   version treats $k$ as a fixed block scale for the hard marginal chosen
   against a candidate uniform learner; the source polynomial degree may depend
   on that fixed scale through $P$.

4. Cite the standard PRF learning lower bound, probably through the existing
   pseudorandom-function witness notes. The target failure is the usual
   Kearns-Valiant style argument, applied to unseen coordinates after removing
   the polynomially many memorized sampled coordinates.

### Depth-3 Conclusion

The depth-2 block hierarchy is not refuted. A PRF coordinate hierarchy appears
to instantiate it: every fixed marginal gets some inverse-polynomial weak
agnostic gap from constants plus polynomially many memorized coordinates, but
no distribution-free polynomial-time learner can promise one uniform
inverse-polynomial gap across all scales.

verdict: resolved-false
assumptions: standard PRF hardness and current global-marginal semantics
confidence: medium-low

## Depth 4: Audit of the PRF Coordinate-Block Hierarchy

- date: 2026-05-05
- depth: 4
- worker note: appended only to this scratchpad; no atlas files edited.

### Short Verdict

The depth-3 PRF hierarchy can be made atlas-ready under the current atlas
reading in which a marginal $P$ is one global distribution on encoded
instances, not an adversarial size-indexed family $(P_s)_s$ with
slice-conditional risk. Under that current reading the edge should be marked
`false`, conditionally on standard PRF hardness.

The missing source proof is repairable. The key point is that high-$k$ blocks
with inverse-polynomial or otherwise nonnegligible global mass are not
automatically dangerous for a weak learner. They are dangerous only when the
target concept's positive mass is close enough to $1/2$ that constants do not
already give a weak advantage. For a single global marginal, only finitely many
disjoint blocks can have that much mass. Hence every fixed marginal has a
finite worst relevant scale $k_P$, even if it puts visible mass on infinitely
many blocks with $k$ growing with the representation size.

If the atlas instead changes the marginal-nonuniform semantics so that a
single source marginal may specify, for each representation size $s$, a
conditional marginal concentrating constant mass on a block with $k=k(s)\to
\infty$, this witness fails and the depth-2 diagonal argument points toward
`resolved-true`.

### Semantics Used

I am reading the current notes literally:

- A marginal $P$ is a single probability distribution over the encoded
  instance space $\mathcal X$.
- The representation size $s$ is the target concept's description size.
- The marginal-dependent polynomial may have constants and degree depending on
  the whole global distribution $P$.
- The distribution-free target may still choose a different hard marginal for
  each target size; that is exactly what the target quantifier permits.

Thus a hard marginal $P_{n,k}$ uniform on one finite block is a different
global marginal for each pair $(n,k)$. The source may attach a different
polynomial degree to each such fixed marginal, while the target needs one
polynomial-time weak gap working across all scales.

### Counterexample Class

Assume a standard secure pseudorandom function family. For each security
parameter $n$ and scale $k$, create a tagged coordinate block

$$
B_{n,k}=\{(n,k,i,b): i\in [n^k],\ b\in\{0,1\}\}.
$$

For a PRF seed $a$, define the concept

$$
c_{n,k,a}(n',k',i,b)=1
\quad\Longleftrightarrow\quad
(n',k')=(n,k)\text{ and }b=F_a(i).
$$

The concept is zero off its active block. Encode $k$ as part of the concept
description, say in unary or any polynomially equivalent convention. For every
fixed $k$, the representation size is polynomially equivalent to $n$, and the
block has $r=n^k=s^{\Theta(k)}$ coordinates. The learner below never
enumerates the block, so growing $k$ only affects the analysis of the hidden
weak gap, not the learner's pathwise runtime.

Improper hypotheses are sparse coordinate lookup tables with a default bit.
After seeing any example from coordinate $i$ in a candidate active block, the
learner knows the correct labels of both $(i,0)$ and $(i,1)$ for that block.

### Source Lemma: Arbitrary Global Marginals

Use one uniform learner $L$. On input size $s$ and confidence $\delta$, draw

$$
m=C s^T\log(1/\delta)
$$

examples for a fixed constant $T$. Build the two constant hypotheses. Also,
for every block tag appearing in the sample and for each default bit
$b_0\in\{0,1\}$, build the sparse lookup hypothesis that uses default $b_0$
off the sampled coordinates of that block and labels each sampled coordinate
consistently with the observed label. Validate all candidates on a fresh
sample and output the empirical winner.

Fix a global marginal $P$ and a realizable target $c_{n,k,a}$. Let $B$ be its
active block and let $M=P(c_{n,k,a}^{-1}(1))$ be the positive mass of the
target. If $\min\{M,1-M\}\le 1/4$, one of the two constants already has
realizable error at most $1/4$, so the weak gap is at least $1/4$.

The only remaining case is

$$
1/4 < M < 3/4.
$$

Then the active block itself has mass at least $1/4$, because all positive
points lie inside $B$. Since the blocks are disjoint, a fixed global marginal
$P$ has only finitely many such blocks; in fact at most three or four above
this threshold. Let $K_P$ be the maximum scale $k$ among them, with $K_P=1$ if
there are none.

For one such heavy balanced block, the standard weighted occupancy estimate
gives the needed quantitative gain. Write the two atoms in coordinate $i$ as
having total mass $w_i$ and let $e_i$ be the mass on which the better default
bit errs. Since $\sum_i e_i\ge 1/4$ and $e_i\le w_i$, one has

$$
\sum_i e_i w_i \ge \frac{(\sum_i e_i)^2}{r}=\Omega(1/r).
$$

Consequently, after $m$ samples, the expected error mass corrected by the
lookup table for the true active block is $\Omega(\min\{1,m/r\})$, and the
usual second-moment or bounded-differences form of the occupancy bound plus
validation makes this a high-probability improvement. Since
$r=n^k\le s^{O(K_P)}$ on every heavy balanced block for this fixed $P$, the
validated learner has realizable error at most

$$
1/2 - s^{-O(K_P)}
$$

for all sufficiently large $s$, after absorbing the finitely many small sizes
into the $P$-dependent polynomial constant.

This proves marginal-nonuniform weak realizable improper learning for the
hierarchy. The runtime and sample use are actually bounded by a fixed
polynomial in $s$ and $\log(1/\delta)$; only the certified weak gap has
$P$-dependent degree.

The "moving high-scale block" objection is handled by the same threshold
argument. A global marginal may put, for example, $1/s^2$ or $1/\log^2 s$ mass
on blocks whose scale $k$ grows with $s$. Such blocks have small positive mass
for the active concept, so the all-zero hypothesis is already much better than
random guessing. To force lookup rather than constants, the block must carry a
constant amount of label mass near the $1/2$ balance point, and that can occur
for only finitely many disjoint blocks under one global $P$.

Finally, the atlas's low-noise weak agnostic robustification converts this
marginal-nonuniform weak realizable learner into the required
marginal-nonuniform weak agnostic improper learner. For each fixed $P$, choose
the agnostic gap below both the realizable gap above and the inverse of the
$P$-specific validation/sample polynomial. When $\operatorname{OPT}$ is larger
than this gap, a constant hypothesis is already within
$\operatorname{OPT}+1/2-\alpha_P(s)$; when $\operatorname{OPT}$ is smaller,
the marginal-preserving coupling version of the robustification compares the
noisy run with the realizable run under the same original $P$.

Thus the source node is satisfied.

### Target Failure

Suppose toward contradiction that there is a distribution-free efficient weak
agnostic improper learner $A$ with runtime/sample bound $s^D$ and weak
realizable gap at least $s^{-d}$ for some fixed $D,d$. Choose a fixed scale

$$
k>D+d+3.
$$

For each $n$, take the realizable distribution that is uniform on
$B_{n,k}$ and labeled by a random PRF seed $a$. A learner using at most
$s^D$ samples sees at most $s^D$ of the $r=n^k=s^{\Theta(k)}$ coordinates, so
direct memorization accounts for only $O(s^{D-k})$ of the block mass.

On an unseen coordinate, any inverse-polynomial correlation with
$F_a(i)$ would distinguish the PRF from a truly random function by running
$A$, estimating its prediction correlation on fresh unseen coordinates, and
comparing the PRF oracle with a random oracle. Standard PRF security therefore
bounds the learner's additional unseen-coordinate advantage by
negligible$(s)$.

Hence every randomized polynomial-time learner has realizable advantage at
most

$$
O(s^{D-k})+\operatorname{negl}(s) < s^{-d}
$$

for the chosen $k$ and large enough $s$. Its error is therefore greater than
$1/2-s^{-d}$ on a realizable distribution, contradicting the assumed weak
agnostic target since $\operatorname{OPT}_{\mathcal C}=0$.

This is the calibrated separation depth 2 wanted: block $k$ is efficiently
learnable with a marginal-specific inverse-polynomial advantage by sparse
memorization, but no polynomial-time learner can promise one uniform
inverse-polynomial advantage across all scales.

### Proposed Atlas Update

Suggested frontmatter direction for the assigned edge:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - standard cryptographic assumptions
witnesses:
  - prf-coordinate-block-hierarchy
ref_keys:
  - goldreich1986
  - kearns1994cryptographic
  - valiant1984
  - blumer1989
summary: "False under standard PRF hardness: a PRF coordinate-block hierarchy is marginal-nonuniform weak agnostic learnable because every fixed global marginal has only finitely many balanced heavy active blocks, but no polynomial-time learner has one distribution-free weak gap across all block scales."
```

The body should explicitly state the global-marginal convention. I would add a
new witness note rather than reusing the existing `pseudorandom-function-classes`
note unchanged, because the important feature here is not ordinary PRF
unlearnability but the calibrated coordinate-block hierarchy with scale
$k$ controlling the weak-gap exponent.

Suggested verdict paragraph:

```markdown
`false`, under standard cryptographic assumptions and the atlas convention
that marginal-nonuniformity quantifies over one global marginal distribution
on encoded instances.

The source is witnessed by a PRF coordinate-block hierarchy. Constants handle
all active blocks whose target-positive mass is bounded away from `1/2`.
For any fixed global marginal, only finitely many disjoint blocks can have
balanced constant mass, and a sparse lookup learner gives an
inverse-polynomial weak advantage on those blocks with a polynomial degree
depending on that marginal. Low-noise weak agnostic robustification gives the
source weak agnostic improper learner.

The target fails because, for every proposed distribution-free polynomial
weak gap, one chooses a larger fixed block scale `k`. Under the uniform
marginal on that block, polynomially many samples reveal only a vanishing
fraction of coordinates, and PRF security rules out predicting unseen
coordinates with inverse-polynomial correlation.
```

### Depth-5 Directions

1. Write the new witness note `prf-coordinate-block-hierarchy` with the
   weighted occupancy lemma as a named sublemma.
2. Decide the cleanest representation convention for $k$ and PRF input length.
   The lower bound only needs fixed $k$, but the source proof should say that
   large encoded $k$ is allowed and is harmless unless the block is one of the
   finitely many balanced heavy blocks of the fixed global marginal.
3. Add a short semantics warning to the edge body or reusable argument note:
   the separation uses global marginals. Under size-indexed marginal-family
   semantics the depth-2 diagonalization would need to be revisited and may
   prove the implication true.
4. Reuse the existing `goldreich1986`, `kearns1994cryptographic`, `valiant1984`,
   and `blumer1989` bibliography keys; no new citation seems necessary unless
   the PRF construction is written in more detail.

verdict: resolved-false
assumptions: standard PRF hardness and current global-marginal semantics
confidence: medium

## Depth 5: Hard Audit of the PRF Coordinate-Block Hierarchy

- date: 2026-05-05
- depth: 5
- worker note: appended only to this scratchpad; no atlas files edited.

### Short Verdict

I do **not** think the depth-4 PRF coordinate-block hierarchy is ready to
promote to an atlas counterexample. The target lower-bound side is plausible,
but the arbitrary-global-marginal source lemma is not verified. As written, it
appears to fail already in the realizable case, before the agnostic
robustification step.

The core issue is not just whether a good sparse lookup hypothesis exists. It
is whether one fixed-polynomial uniform learner can select the right
constant/default orientation on a high-scale block. For block scale $k$ and
fixed pathwise sample bound $m=s^T\log(1/\delta)$, lookup only buys about
$m/r$ mass, where $r=n^k$. If $k$ is large, this edge can be far below the
sampling noise needed to decide whether the target-positive mass is slightly
above or slightly below $1/2$.

### Source Lemma Obstruction

By the atlas pathwise resource convention and the full-support marginal
argument, any single learner satisfying the marginal-nonuniform source must
have some global polynomial transcript bound, say $m(s,\delta)\le
s^T\log(1/\delta)$ after constants are absorbed.

Fix a large block $B_{n,k}$ with $r=n^k$ and choose $k$ and $n$ so that
$r\gg m(s,0.1)^2$. Fix a PRF seed $a$ and let $c_a$ be the active-block
target. Define two global marginals on this one block:

$$
P_+(i,F_a(i))=\frac{1+2\varepsilon}{2r},\qquad
P_+(i,1-F_a(i))=\frac{1-2\varepsilon}{2r},
$$

and $P_-$ with the two weights swapped. Take
$\varepsilon=10m/r$ for $m=m(s,0.1)$. Both labeled distributions are
realizable by the same concept $c_a$. Under $P_+$, the all-one/block-one
orientation has error $1/2-\varepsilon$; under $P_-$, the all-zero orientation
has error $1/2-\varepsilon$.

A default-zero sparse lookup hypothesis under $P_+$ can correct at most
$O(m/r)$ positive mass from sampled coordinates, so it still has error above
$1/2$ with high probability for this choice of $\varepsilon$. Symmetrically,
the one-oriented default is wrong under $P_-$. Thus the learner must determine
the sign of a bias of order $\varepsilon$.

But the $m$-sample transcript distributions under $P_+$ and $P_-$ have total
variation at most $O(m\varepsilon)=O(m^2/r)$, which is negligible by the
choice of $r$. So the same algorithm cannot, with probability at least
$0.9$, choose opposite orientations for the two marginals. PRF security rules
out an alternative efficient strategy that predicts the unseen PRF coordinates
well enough to avoid choosing an orientation. This is exactly the scale where
the depth-4 occupancy gain exists but is too small to be selected by a fixed
polynomial learner.

This attacks the proposed source lemma for arbitrary global marginals. The
"only finitely many heavy balanced blocks" observation is true, but it does
not solve this problem: one fixed global marginal may concentrate on a single
very high-scale block, and the single uniform learner still cannot spend
$s^{\Theta(k)}$ samples or validation time because the full-support marginal
would then violate the pathwise polynomial bound.

### Constants, Positive Mass, and OPT Checks

The first constants branch is fine: if the target-positive mass $M$ satisfies
$\min\{M,1-M\}\le 1/4$, a global constant has realizable error at most $1/4$.

The balanced branch is not justified as stated. From $1/4<M<3/4$ one gets
$P(B)>1/4$, but not
$\sum_i e_i\ge 1/4$ for the "better default" inside the active block. If the
active block has little negative mass, the block-one/default-one hypothesis is
already good; if it does not, a lookup improvement exists. This can be fixed
as an existence proof by adding cases, but it still leaves the selection
problem above.

The target-failure OPT argument is sound in isolation: on the uniform hard
block the distribution is realizable, so
$\operatorname{OPT}_{\mathcal C}=0$, and a weak agnostic target would restrict
to a weak realizable learner. The flaw is on the source side, not in this
realizable-target reduction.

For agnostic source learning, the depth-4 appeal to low-noise weak agnostic
robustification is not enough until the realizable arbitrary-marginal learner
is actually established. Moreover, the agnostic proof would need to specify a
single pathwise-polynomial validation/repetition schedule and prove the
guarantee for all conditional label rules with the same marginal $P$. The
current notes only sketch the low-OPT coupling branch and do not address the
default-selection obstruction.

### Registry Encoding Check

If the hierarchy were valid, it would not be cleanly encodable as a new atlas
witness without touching `atlas/registry/edge_families.yml`.

The checker matches false conditional edges by registered families. A new
witness id such as `prf-coordinate-block-hierarchy` alone would match no
existing family. One could mechanically force the existing
`sample-to-computational-hardness` family by also listing
`pseudorandom-function-classes` in `witnesses`, because that family matches on
that witness id. But then the required `argument_note` and `witness_note`
remain the old PRF sample-to-computational notes, which do not state the
special marginal-nonuniform source proof. That would be a registry hack, not a
faithful encoding.

So a valid version would need either a new edge family, for example
`weak-gap-hierarchy-hardness`, or an intentional broadening of
`sample-to-computational-hardness`. Under the user's constraint not to change
the registry, I would not promote the proposed witness.

### Depth-6 Directions

1. Formalize the two-marginal obstruction above. It should be possible to turn
   it into a short lemma showing that the depth-4 coordinate hierarchy does
   not satisfy the marginal-nonuniform weak realizable source under the
   atlas's pathwise resource convention.

2. If trying to repair the false witness, add a public orientation handle that
   lets the source learner choose the correct default on every marginal while
   still preventing any distribution-free learner from obtaining a uniform
   inverse-polynomial gap. This is delicate: a handle strong enough to solve
   the $P_+/P_-$ problem may also give the target learner a uniform weak edge.

3. Keep the target PRF lower-bound calculation, but separate it from the
   source proof. The lower bound is useful only after an arbitrary-marginal
   agnostic source learner with a fixed pathwise polynomial runtime is proved.

4. Revisit the depth-2 diagonal positive route under any future
   size-indexed/slice-conditional marginal semantics. Under the current global
   marginal semantics it is not a proof, but it remains the cleanest route to
   `resolved-true` if the atlas semantics are strengthened.

5. For atlas metadata, do not add `prf-coordinate-block-hierarchy` or change
   this edge to `false` until the source lemma is repaired. If a repaired
   witness is found, plan on adding both a witness note and a registry family,
   rather than squeezing it into the existing PRF sample-to-computational
   family.

verdict: unresolved-open
confidence: medium-high

## Depth 6: Final Repair Attempt and Atlas-Ready Open Summary

- date: 2026-05-05
- depth: 6
- worker note: final allowed depth; appended only to this scratchpad; no atlas
  files edited.

### Short Verdict

I do not see an atlas-ready proof or counterexample. The edge should remain
`open`.

The depth-1 correction still looks right: full-support marginal
uniformization handles the pathwise sample/time polynomial for the single
source learner. The live issue is only weak-gap uniformization. The source
allows

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$

with $1/\gamma_P(s)$ bounded by a polynomial whose degree and constants may
depend on the marginal $P$. The target needs one distribution-free
inverse-polynomial weak gap, or a fixed additive weak tolerance in the
unparameterized wording. None of the attempted arguments forces such a
uniform lower bound on $\gamma_P(s)$.

### Last Repair Attempt: Orientation-Free PRF Blocks

Depth 5 identifies the fatal flaw in the PRF coordinate-block hierarchy: a
sparse lookup learner must choose the right default orientation on a nearly
balanced high-scale block, and that sign can require far more samples than
the fixed pathwise polynomial permits.

The natural repair is to make the unsampled part orientation-free. I checked
three variants.

1. **Public orientation handle.** Add an easy region whose labels reveal which
   default should be used. This only helps on marginals that put enough mass
   on the handle. Since the source quantifies over arbitrary marginals, an
   adversary can put all mass back on the hard coordinate block and recreate
   the $P_+/P_-$ obstruction. If the handle is made unavoidable with enough
   mass to solve every marginal, the distribution-free target learner can use
   the same handle and the calibrated lower bound disappears.

2. **Random default on unseen coordinates.** If stochastic hypotheses were
   allowed, the learner could correct sampled coordinates and predict by an
   independent fair coin on all unseen coordinates. On the uniform hard block
   this would give expected advantage about $m/r$, independent of the
   positive/negative mass orientation. But the atlas PAC notes use binary
   hypotheses, not randomized prediction rules. Replacing the coin by a
   compact random hash is not enough for the high-scale regime: on a uniform
   block of size $r=s^k$, the unsampled hash correlation fluctuates at scale
   about $r^{-1/2}$, while the memorization gain is only $m/r=s^{T-k}$ for a
   learner using $m=s^T$ samples. For $k>2T$ the hash fluctuation is larger
   than the desired gain, so the learner cannot certify a high-probability
   weak edge for every target seed and marginal. A truly random table would
   remove the fluctuation but is not a polynomial-time hypothesis.

3. **Many hashes plus validation.** Drawing many compact hashes and validating
   them does not repair the previous point. To select a candidate whose edge
   is only $m/r$, validation needs resolution on the order of $m/r$, hence
   about $(r/m)^2$ validation samples in the worst balanced case. For the
   high-$k$ blocks needed by the target lower bound, this is superpolynomial
   in the representation size under the fixed pathwise runtime convention.

So the most plausible repair of the false witness still fails at the same
place: source learning under arbitrary global marginals. The target PRF lower
bound remains plausible in isolation, but it is not useful without a valid
source lemma.

### Why I Cannot Promote `resolved-true`

There is also no atlas-ready positive theorem. The clean diagonal argument
would work under a slice-conditional semantics where a marginal is a
size-indexed family $(P_s)_s$ and weak error is measured within each size
slice. Then any sequence of marginals with gaps smaller than $s^{-r}$ could be
stitched into one bad marginal family, contradicting the source polynomial for
that family.

Under the atlas text currently in use, however, a marginal is a single global
distribution over encoded instances. Trying to encode infinitely many bad
slices into one global marginal gives each slice some mass $w_i$. A weak
agnostic additive guarantee is global: a component of mass $w_i$ can
contribute at most $w_i/2$ excess error above the best concept. If $w_i$ is
small, poor conditional performance on that slice is hidden inside the
allowed additive $1/2-\gamma$ slack. This is why the diagonal proof does not
extract a distribution-free weak gap from the current definition.

Finite-slice compactness is also insufficient. For each fixed representation
size and bounded transcript learner, a positive minimum gap over marginals
may exist, but the minima can still shrink faster than every inverse
polynomial as the size grows. The marginal-nonuniform source permits exactly
that kind of deterioration unless one proves a new quantitative
uniformization theorem.

### Atlas-Ready Open Summary

Suggested frontmatter direction:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
  - bendavid2001
  - kalai2008agnosticboosting
summary: "Open: full-support marginal uniformization gives one pathwise sample/time polynomial for the single source learner, but the source weak agnostic advantage may still have marginal-dependent polynomial degree; no known theorem turns those marginal-specific weak gaps into one distribution-free inverse-polynomial gap."
```

Suggested verdict body:

```markdown
`open`.

The resource part is not the binding obstruction under the atlas pathwise
runtime convention. For the single source learner, a full-support reference
marginal gives one worst-case polynomial bound on every finite encoded sample
transcript.

The remaining obstruction is quantitative. For an actual marginal `P`, the
source gives only
`err_D(h) <= OPT_C(D) + 1/2 - gamma_P(s)`, where the inverse-polynomial lower
bound on `gamma_P(s)` may depend on `P`. The distribution-free target needs
one weak gap, independent of `P`.

The known sample-complexity route through the marginal-nonuniform trichotomy
and VC theory removes computation and therefore does not give the efficient
target. A PRF coordinate-block hierarchy gives a plausible target lower bound,
but the proposed source learner cannot currently be proved for arbitrary
marginals: near-balanced high-scale blocks require selecting a default
orientation from too little information. Public handles or compact random
defaults either fail for adversarial marginals or give the target learner the
same weak edge.

Thus the edge remains open. A proof would need a genuine weak-gap
uniformization theorem, or a clarified slice-conditional marginal semantics
under which the diagonal argument applies. A counterexample would need a class
with efficient marginal-specific weak agnostic gaps for every global marginal,
while still ruling out any distribution-free polynomial-time learner with one
uniform inverse-polynomial gap.
```

### Strongest Obstacles

- Full-support marginal uniformization is only pathwise. It transfers
  sample/time bounds, not probabilistic accuracy gaps.
- The source's weak gap can have unbounded marginal-dependent polynomial
  degree. No current note bounds `inf_P gamma_P(s)` by an inverse polynomial.
- The sample-only implication is true by the Hanneke-Moran-Thiessen
  trichotomy and VC theory, but that route uses unbounded ERM and bypasses the
  computational issue.
- The PRF block lower bound has the right target flavor, but arbitrary
  marginal source learning fails at default/orientation selection near
  positive mass $1/2$.
- Public-handle repairs face a sharp tension: handles weak enough to preserve
  target hardness can be ignored by a marginal, while handles strong enough to
  fix every marginal tend to give a distribution-free weak learner.
- Registry-wise, a valid false witness would need its own witness note and
  edge family, not just reuse the existing `pseudorandom-function-classes`
  sample-to-computational family.

### Future Directions

1. Clarify marginal semantics. If the atlas adopts size-indexed,
   slice-conditional marginals, the depth-2 diagonal argument should be
   revisited as a likely proof of `resolved-true`.
2. Formalize the depth-5 two-marginal obstruction as a reusable negative test
   for proposed calibrated PRF hierarchies.
3. Search for an orientation-free deterministic calibrated hardness class:
   block $k$ should be learnable with advantage $s^{-k}$ for every fixed
   marginal, but cryptographically hard to learn with advantage $s^{-d}$ for
   every $d<k$.
4. Check whether the atlas ever intends to allow stochastic prediction
   hypotheses. If so, the random-default PRF repair deserves a fresh audit;
   under the current binary-hypothesis reading it is not enough.
5. Look for a general weak-gap uniformization theorem for single bounded
   transcript learners. The theorem would have to overcome the global-mixture
   vacuity described above, so it likely needs an additional nondegeneracy or
   slice-conditional assumption.

verdict: unresolved-open
confidence: high
