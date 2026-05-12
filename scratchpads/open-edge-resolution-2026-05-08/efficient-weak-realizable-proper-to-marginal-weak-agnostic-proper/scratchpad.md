# Scratchpad: Efficient Weak Realizable Proper PAC -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC

Edge file: `atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

### Files and Sources Read

- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- sibling open edges:
  - `efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
  - `efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
  - `efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- nearby resolved edges:
  - `efficient-weak-realizable-proper-pac--implies--efficient-weak-agnostic-proper-pac.md`
  - `efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
  - `efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- argument notes:
  - `atlas/arguments/marginal-agnostic-hardness-open.md`
  - `atlas/arguments/low-noise-weak-agnostic-robustification.md`
  - `atlas/arguments/halfspace-agnostic-hardness.md`
  - `atlas/arguments/agnostic-boosting-open.md`
  - `atlas/arguments/spike-tilt-uniformization.md`
  - `atlas/arguments/full-support-marginal-uniformization.md`
  - `atlas/arguments/properization-open.md`
  - `atlas/arguments/marginal-boosting-open.md`
  - `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
  - `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
  - `atlas/arguments/clause-satisfaction-proper-hardness.md`
- witness notes for halfspaces, conjunctions, fixed-$k$-term DNF, PCP active slices, clause-satisfaction lookup, and one-way weak handles.
- sibling scratchpad `efficient-marginal-nonuniform-weak-realizable-proper-to-marginal-weak-agnostic-proper/scratchpad.md`.
- primary-source pages:
  - Tiegel 2023 PMLR page: https://proceedings.mlr.press/v195/tiegel23a.html
  - Hanneke--Moran--Thiessen OpenReview page: https://openreview.net/forum?id=aoVCFtox89
  - Feldman--Guruswami--Raghavendra--Wu arXiv page: https://arxiv.org/abs/1012.0729

### Current Conclusion

I did not resolve the edge. I do **not** recommend changing the atlas fields at this depth. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
```

The edge still appears to be the core proper-output middle-noise selector problem:

```text
efficient-weak-realizable-proper-pac
  ?=> efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

The sibling marginal-source scratchpad argues, using spike-tilt uniformization, that the corresponding marginal-nonuniform weak realizable proper source is equivalent to this distribution-free weak source for purposes of this target. I agree with that reduction under the atlas's deterministic-output/pathwise finite-transcript convention. Thus the remaining issue is not source-side marginal uniformization; it is whether clean weak proper learnability supplies a same-marginal proper neutralizer/selector for agnostic labels.

### Formal Shape of the Obstruction

Use $\{\pm1\}$ labels and fix a marginal $P$. For an agnostic regression

$$
r(x)=\mathbf E[Y\mid X=x],
$$

write

$$
M_{\mathcal C}(r)=\sup_{c\in\mathcal C_s}\mathbf E_P[r(X)c(X)].
$$

The target asks for an efficient proper output $h\in\mathcal C_s$ satisfying

$$
\mathbf E_P[r(X)h(X)]\ge M_{\mathcal C}(r)-1+2\alpha_P(s)
$$

for some inverse-polynomial, marginal-dependent $\alpha_P(s)>0$.

The low-noise branch is solid. Let the source learner inspect at most $m(s)$ labels and have clean weak advantage $\gamma(s)$. If a near-optimal comparator $c^\star$ has agnostic error below roughly $1/m(s)$, repeated noisy calls couple to clean realizable calls on the same $P$-distributed instances with inverse-polynomial probability. Validation over the returned proper hypotheses gives the weak agnostic target in this low-OPT regime.

The middle-noise branch remains unsolved. When $\operatorname{OPT}$ is above the clean-transcript scale, the target may be satisfied by any legal proper hypothesis with merely non-catastrophic correlation against $r$. The improper sibling uses constants as such neutral hypotheses. This proper target cannot assume constants, complements, balanced samplers, or a validation-searchable proper cover.

### Routes Checked

#### 1. Tiegel Halfspace Hardness

Tiegel's PMLR abstract gives two relevant statements. The distribution-independent result rules out efficient algorithms that output any binary hypothesis with error below $1/2-\gamma$ even when the best halfspace error is $\delta$, where $\gamma$ can be very small and $\delta$ can be as small as $\exp(-\Omega(\log^{1-c}d))$. The distribution-specific result gives standard-Gaussian strong agnostic hardness for achieving $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$.

This does not settle the present edge.

- For ordinary Boolean halfspaces, constants are legal halfspaces, so the improper low-noise robustification becomes proper.
- In Tiegel's weak distribution-independent regime, the stated $\delta$ scale is subpolynomial rather than below every inverse polynomial. A marginal-nonuniform weak target may choose $\alpha_P(d)$ much smaller than this $\delta$, after which a neutral error-$1/2$ hypothesis is already within $\operatorname{OPT}+1/2-\alpha_P$.
- The standard-Gaussian result is a strong $\operatorname{OPT}+\varepsilon$ lower bound. It refutes marginal-nonuniform strong agnostic targets, but the current target allows the much looser $\operatorname{OPT}+1/2-\alpha_P$ error.
- Removing constants or complements from a halfspace-like class might revive this route, but I found no source-grounded Tiegel variant that simultaneously preserves efficient clean weak proper learning and rules out all legal neutral outputs.

Obstacle for deeper work: adapt a Tiegel-style fixed-marginal hardness theorem to a class with no proper constants, no easy complement pair, and no other validation-searchable neutral halfspace, while preserving distribution-free weak realizable proper learning.

#### 2. Feldman--Guruswami--Raghavendra--Wu Monomial/Halfspace Hardness

Feldman et al. prove weak agnostic hardness with the right high-level flavor: given labeled examples from the hypercube, even when some monomial is correct on a $1-\epsilon$ fraction, it is NP-hard to find a halfspace correct on a $1/2+\epsilon$ fraction, for arbitrary constant $\epsilon>0$.

This also does not settle the present edge.

- The known statement is distributional: the reduction supplies a labeled distribution, and the example marginal is part of the hard instance.
- The target here is marginal-nonuniform. If the marginal varies with the NP instance, the polynomial runtime and weak gap may also vary with that marginal, so the standard reduction does not yield a uniform polynomial-time contradiction.
- More importantly, the hard noise/advantage scale in the theorem is constant. The present target may choose an inverse-polynomial $\alpha_P$ much smaller than that constant noise level. Then a neutral proper output can satisfy the weak additive target even though it has no constant advantage.
- Packing all Label-Cover instances into one fixed marginal seems to reintroduce active-mass dilution or wrong-instance handles, matching the warning in `marginal-agnostic-hardness-open`.

Obstacle for deeper work: produce an FGRW-style reduction where the marginal is fixed independently of the hard instance and where every weakly legal proper hypothesis, even one with only $-1/\operatorname{poly}$ correlation, decodes the instance.

#### 3. Conjunction/Clause-Satisfaction Witnesses

Conjunctions and clause-satisfaction lookup classes explain strong proper agnostic hardness, and they are tempting because realizable proper learning is easy for ordinary conjunctions.

I do not see a weak marginal-nonuniform separation here.

- Clause-satisfaction-style fixed marginals encode the input formula in labels, but the usual hardness needs high accuracy, not the loose $\operatorname{OPT}+1/2-\alpha_P$ target.
- For plain 3-CNF clauses labeled positive, a random assignment satisfies a large constant fraction, so it is already a legal weak proper handle.
- PCP predicates with soundness below $1/2$ remove that handle, but then on all-positive satisfiable active slices a weak proper learner would already find a proof accepted on more than half the verifier randomness. That breaks the source node.

Obstacle for deeper work: find predicates/handles that make every clean target weakly learnable under every marginal, yet do not give agnostic labels any legal weak handle. Existing clause and PCP templates seem to give one of these two properties by sacrificing the other.

#### 4. Parity, LPN, and Code Geometry

Clean parities are efficiently properly learnable, and noisy parity/LPN has the desired fixed uniform marginal flavor. But it misses this target for the same quantitative reason.

- Under the uniform marginal, wrong parities are neutral with respect to a planted parity.
- If the noise rate is below the inverse transcript scale, low-noise coupling learns.
- If the noise rate is above the target's hidden weak gap, a neutral wrong parity satisfies the additive target.

Code variants would need all wrong proper hypotheses to be inverse-polynomially negatively correlated with the planted one. For exponentially many hidden targets on a fixed finite support, PSD/Plotkin-style barriers prevent such pairwise negative correlation at inverse-polynomial scale. If only polynomially many targets remain, brute-force or validation tends to become possible.

Obstacle for deeper work: separate information-theoretic existence of neutral codewords from computational findability. A false witness would need neutral or weakly safe proper hypotheses to exist but be hard to find, without making clean weak learning hard.

#### 5. One-Way Image/Handle Constructions

The one-way image-coordinate weak-handle class is useful for weak-versus-strong proper separations. It does not refute this edge.

- Without handles, clean weak proper learning can fail on balanced hidden marginals.
- With singleton or bounded positive-atom handles, the clean source becomes easy, but those same handles are validation-searchable from agnostic data.
- Constants and bounded handles are exactly the neutralizer structure the present target needs.

Obstacle for deeper work: design clean-label-useful handles that become useless on agnostic labels. The existing handles are too public and too searchable.

### A Possible Positive Route I Could Not Complete

One tempting positive lemma would be:

> For every fixed marginal $P$, distribution-free weak realizable proper learning yields a $P$-polynomial, validation-searchable list or sampler of proper hypotheses such that for every agnostic regression $r$ the list contains some $h$ with $\langle r,h\rangle_P\ge M_{\mathcal C}(r)-1+1/\operatorname{poly}_P(s)$.

This would prove the edge by combining the list with the known low-noise candidates and validation.

I could not derive such a lemma. Running the source learner on all labelings of a polynomial unlabeled sample gives at most a weak cover in principle, but it is generally exponential in the source sample size. Running the source learner on random, flipped, filtered, or residual agnostic labels is off-promise; an arbitrary proper learner may behave adversarially on those transcripts. Observable error filters are clean for $-h$, not for the hidden comparator $c^\star$, unless the class has complements or patching structure.

### Best Next Subagent Directions

1. **Fixed-marginal FGRW packing.** Try to encode Label-Cover/FGRW constraints into labels over a single polynomial-size marginal per input length, rather than a marginal depending on the instance. The target is a no-neutral theorem: any proper output with correlation at least $-1/\operatorname{poly}$ should decode a satisfying labeling. The obstacle is wrong-instance handles and active-mass dilution.

2. **No-neutral signed set system.** Build a finite-support concept family with efficient clean promise extension but NP-hardness of finding any set with signed weight at least $-1/\operatorname{poly}$ whenever the optimum is positive. Ordinary Max-Cover/Set-Cover/nearest-codeword hardness is too strong and leaves weak approximate solutions.

3. **Halfspace subclass without neutralizers.** Investigate whether Tiegel's distribution-specific or distribution-independent machinery survives restriction to a cleanly learnable halfspace subclass with constants/complements removed. The obstacle is that most natural restrictions either remain complement-paired or lose efficient realizable weak learning.

4. **Computationally hidden neutral codewords.** Search for a pseudorandom code/concept family where neutral proper hypotheses exist but finding any neutral one is hard, while clean labels still permit weak proper learning. Pure pairwise geometry cannot do this at inverse-polynomial scale because of PSD/Plotkin barriers.

5. **Positive selector theorem.** Try to prove that distribution-free weak realizable proper learning implies a polynomial-size weak cover under each fixed marginal. The apparent obstacle is the $2^{m(s)}$ blowup from enumerating labels of a source sample; a successful proof would need to exploit the learner's pathwise polynomial runtime or stability in a way not currently present in the atlas notes.

### Atlas Update Recommendation

No status change. If a later main-agent pass incorporates scratchpad notes into the atlas, the useful additions are explanatory rather than resolving:

- Mention FGRW monomial-by-halfspace hardness explicitly as a checked near miss for this exact edge.
- Emphasize the quantitative reason Tiegel/FGRW/LPN miss the marginal-nonuniform weak target: the target may hide an arbitrarily small inverse-polynomial gap depending on the marginal, while known hard noise levels are above that gap and neutral hypotheses then suffice.
- Keep the edge in `family: marginal-agnostic-hardness-open`.

### Resolved?

No.

## Depth 2 Attempt: Positive Selector Theorem

### Question Pursued

Can the distribution-free weak realizable proper source be upgraded, for each fixed
marginal $P$, into a polynomial-size validation-searchable proper weak cover or
neutralizer?  If yes, the edge would become true: combine the existing low-noise
coupling candidates with this middle-noise selector and validate on fresh
agnostic data.

I could not prove this theorem, and I did not find a counterexample to the edge.
The main outcome of this pass is sharper: the pure "weak cover" version is
false, and the available black-box routes do not seem to upgrade it to a
cover-or-neutralizer theorem.  The edge remains unresolved.

### Algebraic Target For A Selector

Use $\{\pm 1\}$ labels.  For a fixed marginal $P$ and agnostic regression
$r(x)=\mathbf E[Y\mid X=x]$, write

$$
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P.
$$

The weak agnostic target asks for a proper $h\in\mathcal C_s$ with

$$
\langle r,h\rangle_P \ge M(r)-1+2\alpha_P(s)
$$

for inverse-polynomial $\alpha_P(s)>0$.  If $c^\star$ nearly attains $M(r)$
and a candidate $h$ has clean correlation

$$
\langle h,c^\star\rangle_P \ge 2\gamma,
$$

then the triangle inequality for zero-one error gives

$$
\langle r,h\rangle_P
\ge
\langle r,c^\star\rangle_P + \langle c^\star,h\rangle_P - 1
\ge
M(r)-1+2\gamma-o(1).
$$

Thus a fixed-$P$ list that weakly covers every clean target would be enough:
validate the list on agnostic data and choose the best.  The source learner
does give such a list in the following exponential sense.  Fix an unlabeled
sample $U=(x_1,\ldots,x_m)$ of the source learner's sample length and enumerate
every realizable label trace $c|_U$; running the source learner on each trace
produces candidates, and for every $c$ at least one candidate is weakly
correlated with $c$ with high probability over $U$ and the learner's internal
randomness.

The problem is exactly the size of this trace list.

### Pure Weak Covers Are Not Implied

The strongest cover-only selector theorem is refuted by parities.  Let
$\mathcal C_s$ be the parity functions on $\{0,1\}^d$ with $s\simeq d$ under
the uniform marginal.  The class is efficiently distribution-free realizably
properly learnable by Gaussian elimination.  But distinct parities are
orthogonal under the uniform marginal.  Therefore any list $L\subseteq
\mathcal C_s$ that has positive clean edge with every parity target must
contain every parity, so $|L|=2^d$.

This does not refute the atlas edge, because parities also have abundant
neutral wrong hypotheses in the agnostic middle-noise regime.  It does rule out
one tempting proof: distribution-free weak realizable proper learning cannot,
by itself, imply a polynomial-size clean weak cover under each fixed marginal.
Any positive selector theorem must be a genuine cover-or-neutralizer dichotomy,
not merely a compressed cover theorem.

### Pathwise Polynomial Runtime Does Not Remove The Branching

The atlas pathwise convention gives a useful finite number $m(s)$ of inspected
labels for a constant-confidence weak source call.  It does not make the
label-decision tree searchable.  After fixing the learner's random bits, the
learner is a map

$$
(x_1,y_1,\ldots,x_m,y_m)\mapsto h\in\mathcal C_s.
$$

The source guarantee constrains this map only on traces of the form
$(x_i,c(x_i))_{i\le m}$.  For a fixed unlabeled path $(x_1,\ldots,x_m)$ there
can be $2^{m(s)}$ possible label branches, and the successful branches for
different clean targets may be disjoint.  The pathwise runtime bound says this
tree has polynomial depth and polynomial-time leaf computation; it does not say
that good leaves have polynomial density, monotone structure, low decision-tree
influence, or a polynomial hitting set.

This is not just a pathological-learner issue.  Parity learning under the
uniform marginal needs $\Omega(d)$ labels to identify the target with high
probability, because all wrong parities have exactly zero edge.  Thus
$m(s)=\Theta(s)$ can be intrinsic even for a cleanly and efficiently learnable
proper class.  Enumerating clean traces of a legitimate source learner can
therefore require $2^{\Theta(s)}$ branches.

### Random Relabeling Does Not Densify Good Branches

Random labels sample the $2^m$ branch cube, but the source learner has no
off-promise guarantee on non-realizable traces.  A valid realizable learner may
behave adversarially on those traces without violating the source node.
Validation can reject bad candidates after they are generated, but it cannot
force the generation process to visit a rare useful branch.

Using the agnostic labels themselves gives the known low-noise coupling and no
more.  If a near-optimal comparator $c^\star$ has error $\eta$ on the agnostic
distribution, then an $m$-label source call exactly matches a clean
$c^\star$-trace with probability about $(1-\eta)^m$.  This is inverse
polynomial only when $\eta\lesssim (\log s)/m$; for middle noise it is
exponentially small.  Adding independent random flips only shrinks this clean
trace probability unless one already knows how to bias flips toward
$c^\star$, which is the hidden object being searched for.

Synthetic random labels on a small empirical marginal $Q$ do not fix this.
The source guarantee applies to $Q$ only when the labels are realized by some
concept in $\mathcal C_s$.  Producing many diverse realizable traces on $Q$ is
again the weak-cover problem; arbitrary random traces are off-promise unless
the sampled set is known to be shattered, and even then the induced output
distribution need not be neutral with respect to the original agnostic
regression $r$.

### Spike-Tilt Uniformization Does Not Supply A Selector

Spike-tilt uniformization is powerful for a different quantifier problem: it
turns marginal-dependent weak edges into one distribution-free inverse
polynomial weak edge by spiking a point where many low-edge clean outputs are
wrong.  It still works with clean realizable labels and a fixed target concept.

The present selector problem has no fixed clean target.  A bad middle-noise
candidate can be bad because it is anti-correlated with the signed regression
$r$, not because it has low clean edge against some $c\in\mathcal C_s$ on a
realizable distribution.  Spiking a point where such candidates are bad changes
the marginal, but it does not produce a realizable labeling under which the
source guarantee forces the learner to output a neutral concept for $r$.
Spike-tilt gives a uniform weak advantage and pathwise sample bound; it does
not reduce the $2^{m(s)}$ label search, and it does not constrain off-promise
random-relabeling calls.

### Sample Compression Would Help Only In A Stronger Form

There is a clean conditional theorem here.  Suppose that, for each fixed
marginal $P$, the source learner could be represented by a proper weak
compression scheme using only

$$
k(s)=O(\log p_P(s))
$$

labeled examples, with polynomial-time reconstruction and inverse-polynomial
clean edge.  Then the agnostic target would follow: draw an unlabeled sample,
enumerate all $2^{k(s)}=\operatorname{poly}_P(s)$ labelings of the compressed
positions, reconstruct all proper candidates, and validate them on agnostic
data.  The triangle inequality calculation above turns clean edge against
$c^\star$ into the desired weak agnostic edge.

The actual source node gives no such logarithmic compression.  Storing the
entire source transcript is a compression scheme of size $m(s)$, but
enumerating its labels is still $2^{m(s)}$.  General VC/sample-compression
information is also not enough for the computational atlas target: weak
learnability permits VC dimension and necessary clean sample size growing like
$\Theta(s)$, and even an $O(s)$ compression would still create exponentially
many label branches.  The parity example again shows that this obstruction is
not an artifact of an inefficient learner.

### What This Attempt Rules Out

This pass rules out the following proof strategy:

1. Use pathwise polynomial runtime to get a polynomial transcript length.
2. Replace enumeration over all clean labels by random relabeling, spike-tilt,
   or generic compression.
3. Validate the resulting polynomial candidate set.

Step 2 is unsupported.  Random relabeling is off-promise and can miss useful
branches exponentially often; spike-tilt uniformizes clean weak advantage but
does not create neutral candidates; generic compression is too large unless it
is logarithmic in the representation size.

### Remaining Possible Positive Theorem

A cover-or-neutralizer dichotomy could still be true, but it needs a new idea.
The parity obstruction says large clean covers are sometimes necessary, while
the parity neutralizer says large clean covers are not always needed for the
weak agnostic target.  A successful theorem would have to show something like:

> For every fixed $P$, if the clean trace family is too large to search, then
> the same largeness can be converted into an efficiently generatable balanced
> proper sampler or neutralizer for every middle-noise regression $r$.

I do not see how to prove the efficient generation part from the abstract
source learner.  Benedek--Itai/VC style covers are information-theoretic, and
the source learner supplies a promise-extension procedure only after the right
clean trace has been named.

### Recommended Next Directions

1. **Formalize the conditional logarithmic-compression theorem.**  This would
   be a useful positive lemma for structured classes even though it does not
   settle the edge.

2. **Search for an efficient cover-or-neutralizer dichotomy.**  The missing
   ingredient is not existence of many concepts, but a polynomial-time way to
   sample a balanced legal concept from the large trace family without first
   enumerating realizable labels.

3. **Separate black-box from existential statements.**  A black-box reduction
   using arbitrary off-promise calls to the source learner seems impossible.
   The edge could still be true by a non-black-box argument about the class.

4. **Look for hidden-neutralizer hardness.**  A false witness should not merely
   make clean covers exponential; parities already do that harmlessly.  It
   must make every efficiently findable middle-noise neutral proper hypothesis
   hard to find while preserving distribution-free clean weak proper learning.

### Resolved?

No.

## Depth 3 Attempt: Halfspace Subclass Without Neutralizers

### Question Pursued

Can the halfspace hardness route be repaired by restricting the proper class so
that constants, complements, and other easy balanced pairs are no longer legal,
while distribution-free weak realizable proper learning remains easy?

I could not make this route resolve the edge.  The strongest conclusion of this
pass is negative but local: the known Tiegel-style Gaussian hardness statements
do not survive this restriction in the form needed for the atlas edge.  Removing
the explicit neutralizers from the representation is not enough, because the
existing Gaussian hard distributions still leave public unrelated halfspaces
with essentially neutral correlation, and the known hardness theorems target
much stronger OPT-plus-epsilon accuracy than the marginal-nonuniform weak
agnostic target requires.

### Sources Checked

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html): worst-case
  lattice hardness for agnostically learning halfspaces, including a
  distribution-independent weak-improper lower bound and a standard-Gaussian
  `OPT + epsilon` lower bound.
- [Diakonikolas--Kane--Kontonis--Tzamos--Zarifis 2021](https://proceedings.mlr.press/v134/diakonikolas21b.html):
  proper agnostic learning of Gaussian halfspaces and a proper PTAS-style
  result competitive with the best homogeneous halfspace.
- [Diakonikolas--Kane--Ren 2023](https://arxiv.org/abs/2302.06512):
  near-optimal LWE hardness for standard-Gaussian `OPT + epsilon` halfspace
  learning.
- [Huang--Juba 2026](https://arxiv.org/abs/2604.26446): a recent extension of
  near-optimal cryptographic hardness to homogeneous halfspaces under Gaussian
  marginals.

### Quantitative Target

For a fixed marginal $P$ and regression $r(x)=\mathbf E[Y\mid X=x]$, the target
asks for a proper $h\in\mathcal C_s$ with

$$
\langle r,h\rangle_P \ge M_{\mathcal C}(r)-1+2\alpha_P(s),
$$

where $M_{\mathcal C}(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P$ and
$\alpha_P(s)$ may be any inverse-polynomial marginal-dependent weak gap.

Thus a false halfspace witness needs more than strong agnostic hardness.  It
needs a fixed marginal and agnostic labels for which every polynomial-time
proper output has correlation below this very low threshold, for every
inverse-polynomial gap the marginal-nonuniform learner might choose.  In the
middle-noise regime, the threshold is often negative and close to $-1$, so an
unrelated legal halfspace with correlation near zero is already enough.

### Audit Of Known Gaussian Halfspace Algorithms

Full affine halfspaces are not a witness.  The 2021 proper Gaussian algorithm
outputs a halfspace with error at most `OPT + epsilon` in time roughly
$d^{\operatorname{poly}(1/\epsilon)}$.  For the atlas's weak target, constant
$\epsilon<1/2$ is already stronger than needed under the standard Gaussian
marginal.  Ordinary affine halfspaces also contain proper constants or
near-constants, so they have the neutralizers that the earlier attempts already
identified.

Homogeneous halfspaces remove affine constants, but not complements:
$x\mapsto\operatorname{sign}\langle w,x\rangle$ and
$x\mapsto\operatorname{sign}\langle -w,x\rangle$ are both legal.  This alone is
enough to keep the usual validation trick alive once any candidate direction is
generated: at least one of the two signs has nonnegative correlation with the
regression.  The 2021 Gaussian algorithmic results also include constant-factor
and PTAS-style guarantees around homogeneous comparators.  The exact properness
bookkeeping is a little delicate--the stated PTAS is competitive with the best
homogeneous halfspace but returns a halfspace--but in either interpretation it
does not create a no-neutral homogeneous subclass.

The recent homogeneous-halfspace hardness result is closer to the desired
subclass because it removes affine constants from the comparator class.  It
still proves strong `OPT + epsilon` hardness, not failure of the weak
`OPT + 1/2 - alpha` target, and homogeneous halfspaces still come in antipodal
pairs.  So it does not settle this edge either.

### Subclass Representations Tried

1. **Remove constants only.**  Restrict affine halfspaces to bounded thresholds,
   nonzero normals, or homogeneous separators.  Distribution-free clean proper
   learning remains easy by linear feasibility, but complements remain legal in
   the homogeneous case and near-complements remain available in many affine
   variants.  Tiegel-style strong hardness is unaffected, but the weak target is
   still protected by validation over paired signs or by unrelated balanced
   halfspaces.

2. **Hemisphere-oriented homogeneous halfspaces.**  Keep exactly one of
   $w,-w$, for example by requiring the first nonzero coordinate of $w$ to be
   positive.  Clean realizable proper learning still looks feasible: add the
   orientation constraint to the usual homogeneous linear feasibility problem.
   The hardness theorem no longer applies as stated.  Tiegel's Gaussian hard
   instances use a hidden direction with symmetric sign; if the good orientation
   is excluded, the best concept in the restricted class can fall back toward
   error $1/2$, making the weak target vacuous.  Restricting the CLWE/LWE secret
   to one public hemisphere might be possible, but I found no source-grounded
   statement giving the required hardness.

3. **Anchor-oriented halfspaces.**  Require a fixed anchor point $x_0$ to be
   labeled $+1$, thereby quotienting complements without changing the Gaussian
   marginal on typical samples.  This has the same problem as the hemisphere
   rule: the existing hard distribution does not promise that the correlated
   halfspace has the anchor orientation.  Conditioning the hard secret to make
   it so is an extra average-case hardness claim, not a consequence of the cited
   theorems.

4. **Fixed-bias classes such as $\operatorname{sign}(\langle w,x\rangle+1)$.**
   These remove exact complements and can approximate homogeneous separators by
   taking large $\|w\|$.  But the standard-Gaussian hard labels in Tiegel-style
   reductions have only a small halfspace edge in the hard regime.  A public
   unrelated legal halfspace has correlation about zero with the hidden
   one-dimensional label pattern, which is already above
   $M_{\mathcal C}(r)-1+2\alpha_P(s)$ unless the problem is in the low-noise
   branch already handled by clean coupling.

5. **Finite no-antipode codebooks of halfspace normals.**  If the codebook is
   polynomial-size and efficiently enumerable, the agnostic target can simply
   validate all legal hypotheses.  If it is exponentially large, no generic
   distribution-free clean proper learner is apparent unless the representation
   adds extra algebraic structure.  Adding such structure tends to reintroduce
   either efficient neutral sampling or an easy search path.

### Why Tiegel-Style Hardness Still Misses

The distribution-independent Tiegel lower bound says weak learning is hard even
when the best halfspace error is
$\delta=\exp(-\Omega(\log^{1-c} d))$.  For the marginal-nonuniform weak target,
however, the learner may choose a gap $\alpha_P(d)=d^{-K}$ with $K$ large.
Eventually $\delta\gg\alpha_P(d)$, so the allowed error
$\delta+1/2-\alpha_P(d)$ is above $1/2$.  A neutral output is enough.

The standard-Gaussian Tiegel lower bound, and the later LWE-based Gaussian
lower bounds, rule out efficient `OPT + epsilon` learning for small
$\epsilon$.  The atlas target only asks for excess error
$1/2-\alpha_P(d)$.  Taking $\epsilon$ constant gives at most a fixed-polynomial
exponent lower bound, not a contradiction to polynomial time; taking
$\epsilon$ inverse-polynomial gives a strong-learning lower bound that the weak
target never requested.

Removing complements from the class does not change this quantitative mismatch.
For the known Gaussian hard distributions, the label signal is hidden in a
direction.  A fixed or randomly sampled legal halfspace in an unrelated
direction has near-zero correlation with that signal under the Gaussian
marginal.  Since the weak target's middle-noise threshold is typically close to
$-1$, this public balanced output satisfies the target even though it learns
nothing useful about the hidden direction.  A successful halfspace-subclass
separation would need to make all efficiently findable legal halfspaces
strongly anti-correlated with the hard regression, not merely remove the exact
constant and complement functions.

### Remaining Promising Direction

The only plausible continuation I see is not a direct restriction of the cited
halfspace theorems.  One would need a new no-public-neutral reduction with all
of the following properties:

1. The class is still distribution-free weak realizably properly learnable,
   probably by a transparent linear feasibility or convex feasibility routine.
2. Under one fixed marginal, the agnostic hard labels have a legal comparator
   with enough edge that the weak threshold is nontrivial.
3. Every polynomial-time findable legal halfspace outside the hidden structured
   family is almost maximally anti-correlated with the regression, not merely
   uncorrelated.
4. The reduction's hidden orientation is compatible with the subclass rule, so
   the best legal comparator is not accidentally excluded.

I do not know how to get property 3 from Gaussian halfspace geometry.  The
rotational symmetry that powers the existing algorithms and lower bounds also
creates many easy near-neutral directions.

### Resolved?

RESOLVED: no.


## Depth 4 Attempt: Oracle Diagonal No-Neutral Witness

### Question Pursued

Can one build an oracle or diagonal concept class where clean weak proper
learning is easy, but the same-marginal weak agnostic proper task fails because
every efficiently findable proper hypothesis is made anti-correlated with the
agnostic regression?

I can sketch a reasonably rigorous relativized model.  It looks like a real
black-box barrier to proving the implication by generic use of the clean learner.
I do not think it is atlas-compatible as an ordinary separation, because the
construction relies on an oracle for clean proper ERM and on diagonal
off-promise behavior.

### Sign Convention

Use labels in $\{\pm 1\}$.  For a fixed marginal $P$ and regression
$r(x)=\mathbf E[Y\mid X=x]$, the weak agnostic proper target is equivalent to
finding $h\in\mathcal C_s$ such that

$$
\langle r,h\rangle_P
\ge
M_{\mathcal C}(r)-1+2\alpha_P(s),
$$

where $M_{\mathcal C}(r)=\max_{c\in\mathcal C_s}\langle r,c\rangle_P$.

This is the quantitative reason neutralizers are so hard to avoid.  If
$M_{\mathcal C}(r)$ is bounded away from $1$, a merely uncorrelated output often
satisfies the target.  A no-neutral witness must make the hypotheses found by
the target learner genuinely anti-correlated, not just uninformative.

### Relativized Concept-Class Scaffold

For each size $n$, let $X_n$ be a huge finite block, say
$|X_n|=N_n=2^{n^4}$, and let the proper concepts be names
$k\in K_n$ with $|K_n|=2^n$.  The oracle stores a truth table

$$
c_{n,k}:X_n\to\{\pm 1\}.
$$

The learner has oracle access to:

1. `Eval(n,k,x)`, returning $c_{n,k}(x)$.
2. `Cons(n,S,y)`, returning the lexicographically first $k$ such that
   $c_{n,k}(x_i)=y_i$ for every labeled example $(x_i,y_i)$ in the finite
   sample, or $\bot$ if no such $k$ exists.

The source learner is then simple.  Draw
$m=O((n+\log(1/\delta))/\varepsilon)$ clean examples from an arbitrary marginal
$P$ and a target concept $c_{n,k^\star}$.  Query `Cons` on the labeled sample
and output the returned proper concept.  Since $|K_n|=2^n$, the usual finite
class/Occam bound says every sample-consistent concept has true error at most
$\varepsilon$ with probability $1-\delta$.  Thus, relative to the oracle, the
class is actually strongly realizably properly PAC learnable under every
marginal.  In particular it satisfies the clean weak proper source.

This avoids the earlier information-theoretic problem with random concepts:
the clean learner does not recover the hidden name from labels alone.  Instead
it uses an ERM oracle over an exponentially large proper class, and finite-class
generalization supplies the statistical guarantee.

### Diagonal Agnostic Stage

Enumerate oracle polynomial-time target learners $M_1,M_2,\ldots$.  At stage
$e$, choose a fresh block size $n_e$ so large that previous oracle commitments
are disjoint from $X_{n_e}$ and the time/query bound of $M_e$ on size $n_e$ is
tiny compared with $2^{n_e}$ and $N_{n_e}$.

Run $M_e$ on examples from the marginal $P_{n_e}$ uniform on $X_{n_e}$, while
answering its oracle queries consistently but lazily.  Let $Q_e\subseteq K_{n_e}$
be every concept name that $M_e$ queries, receives from `Cons`, or outputs with
nonnegligible probability in this simulation.  With high probability
$|Q_e|=\operatorname{poly}(n_e)$.

Now reserve a hidden name $k_e^\star\notin Q_e$ and define an agnostic
regression

$$
r_e(x)=\rho\, c_{n_e,k_e^\star}(x)
$$

with a constant $\rho$, for instance $\rho=2/3$.  Fill the still-uncommitted
truth tables so that

$$
\langle r_e,c_{n_e,k_e^\star}\rangle_{P_{n_e}}=\rho
$$

but, for every $q\in Q_e$,

$$
\langle r_e,c_{n_e,q}\rangle_{P_{n_e}}\le -\rho+o(1).
$$

One concrete way is to set the hidden vector first, set each queried/output
concept to its pointwise negation on all but the already-queried coordinates,
and then fill all untouched concepts independently at random.  Since
$M_e$ has inspected only polynomially many coordinates and names while
$N_{n_e}$ is enormous, the finite-injury constraints are compatible.  The
random untouched concepts have near-zero correlation with $r_e$, but they are
not public: by construction this particular machine has not found their names.

For $\rho=2/3$, the target threshold is

$$
M_{\mathcal C}(r_e)-1+2\alpha(n_e)
= -1/3+2\alpha(n_e)+o(1).
$$

Every concept in $Q_e$ has correlation roughly $-2/3$, so it fails by a
constant margin for all sufficiently small inverse-polynomial gaps.  The hidden
concept $k_e^\star$ is a valid proper comparator, but finding it from noisy
examples is computationally blocked relative to the oracle: `Cons` only solves
exact consistency, and with constant noise a polynomial learner cannot obtain a
large clean transcript by subset search.

This is the promised no-public-neutral feature.  Merely random or unrelated
concepts would be neutral and would satisfy the weak target.  The diagonal
stage instead makes every concept that this learner can actually produce
anti-correlated with the hard regression.

### Same-Marginal Bookkeeping

The finite-block version is not enough for the atlas as written, because a
single hard finite marginal can be absorbed into the marginal-dependent
polynomial constants.  A cleaner relativized statement should use either:

1. A dimension-wise fixed marginal family $P=\{P_n\}$, with $P_n$ uniform on
   $X_n$, which is the convention many asymptotic learning formulations use
   implicitly; or
2. A single sparse direct-sum marginal with infinitely many blocks assigned to
   each learner, choosing block sizes $n_t$ so fast-growing that weights such as
   $1/t^2$ are still larger than every inverse polynomial in $n_t$ eventually.

The second version needs more care because the weak OPT-relative threshold is
global.  If a hard block has tiny mass, a neutral global hypothesis may again
satisfy the target.  The diagonal would have to anti-correlate the learner's
output on the high-mass complement as well, or define the representation-size
slice so that the relevant marginal is $P_n$ rather than one small component of
one global distribution.

So the oracle idea is cleanest under a size-indexed marginal-family model.  It
is less clean under a literal single distribution over all sizes.

### Atlas Compatibility Test

This does not currently resolve the atlas edge.

The construction is relativized.  The clean source learner is efficient only
because `Cons` performs exponential proper ERM.  If `Cons` is removed, the
source side becomes computationally hard for the same reason the agnostic side
is hard.  If `Cons` is built into the representation as an ordinary efficient
procedure, then the construction has smuggled in an oracle-dependent algorithm,
not a standard concept class with a primary-source theorem.

The lower bound is also diagonal and machine-specific.  For each target learner
we make the concepts it can find anti-correlated.  That is enough for a
relativized separation by finite injury, but it does not identify a natural
complexity assumption, cryptographic primitive, or explicit concept class that
would justify changing the atlas implication status.

Finally, the model still has hidden neutral concepts: untouched random names
are near-neutral under the hard marginal.  The point is only that they are not
efficiently findable by the diagonalized learner.  This is exactly what an
oracle lower bound should show, but it is weaker than a structural
"no neutralizer exists" theorem.

### What This Suggests

The oracle construction is a useful warning sign.  A proof of the implication
probably cannot treat the clean weak proper learner as a black-box consistency
or ERM subroutine and hope to get the middle-noise agnostic selector for free.
Such a proof would have to exploit additional structure that rules out the
diagonal anti-correlation trick, for example an efficiently enumerable
near-neutral proper family, closure under signs or regional complements, a
canonical stable ERM, or a genuine cover-or-neutralizer theorem.

Conversely, a real negative atlas witness would need to de-oracleize this
picture: replace `Cons` with an explicit polynomial-time clean learner, replace
the diagonal anti-correlation with a standard hardness assumption or explicit
pseudorandom object, and handle the marginal-nonuniform asymptotics without
finite-block advice being absorbed into $p_P$.

### Resolved?

RESOLVED: no.
## Depth 5 Attempt: Minimal No-Neutral Signed-Search Primitive

### Question Pursued

Can the missing middle-noise selector be isolated as a finite-support search
problem?  The target is a primitive whose NP-hardness would refute

```text
efficient-weak-realizable-proper-pac
  -> efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

while a clean promise extension for the same hypothesis family would establish
the source side.  I focused only on no-neutral proper selector primitives, not
on halfspaces, PCPs, or boosting.

I can state such a minimal conditional primitive.  I do not know an explicit
family satisfying it, so this does not resolve the atlas edge.

### Finite-Support Setup

For each size $n$, let $X_n$ be a finite support and let $P_n$ be a fixed,
efficiently samplable marginal on $X_n$.  Let

$$
\mathcal C_n\subseteq \{\pm 1\}^{X_n}
$$

be the proper hypothesis family, with polynomial-time evaluation from a
representation of size $\operatorname{poly}(n)$ and
$|\mathcal C_n|\le 2^{\operatorname{poly}(n)}$.

For a signed regression $r:X_n\to[-1,1]$, define

$$
\operatorname{score}_r(c)=\mathbf E_{X\sim P_n}[r(X)c(X)]
$$

and

$$
\operatorname{Opt}(r)=\max_{c\in\mathcal C_n}\operatorname{score}_r(c).
$$

The agnostic proper weak target, restricted to this marginal, is exactly the
search problem of finding $c\in\mathcal C_n$ with

$$
\operatorname{score}_r(c)
\ge
\operatorname{Opt}(r)-1+2\alpha_{P}(n),
$$

where $\alpha_P(n)$ is the marginal-dependent inverse-polynomial weak gap
chosen by the hypothetical learner.

### Minimal No-Neutral Signed Selector Problem

Fix a constant $\rho\in(0,1)$, say $\rho=2/3$.  For every inverse-polynomial
scale $\eta(n)$, define the promise search problem
`NNSS(C, P, rho, eta)`:

**Input.**  A succinct circuit or other polynomial-time sampler/evaluator for
a signed regression $r_I:X_n\to[-1,1]$.  The marginal $P_n$ and class
$\mathcal C_n$ are fixed for the size $n$ and do not depend on the input
instance $I$.

**Promise.**

1. $\rho\le \operatorname{Opt}(r_I)\le \rho+\eta(n)/10$.
2. Samples from the joint distribution with marginal $P_n$ and conditional
   label mean $r_I(x)$ can be generated in polynomial time from $I$.

**Goal.**  Output a proper hypothesis $c\in\mathcal C_n$ satisfying

$$
\operatorname{score}_{r_I}(c)\ge \rho-1+\eta(n).
$$

This is the cleanest finite-support no-neutral formulation I found.  It asks
for a proper output that is only barely better than the OPT-relative agnostic
floor.  With $\rho=2/3$, the threshold is roughly $-1/3+\eta(n)$, so a
genuinely neutral hypothesis with score $0$ would immediately solve the
problem.  Thus NP-hardness of this problem is precisely a computational
no-neutral statement: not necessarily that neutral proper concepts do not
exist, but that no polynomial-time procedure can find any proper hypothesis
above the weak threshold.

The upper promise on $\operatorname{Opt}(r_I)$ is bookkeeping.  Without it,
the natural threshold would be
$\operatorname{Opt}(r_I)-1+\eta(n)$, which matches the learning guarantee more
directly but makes the search relation depend on an unknown optimum.  The
promise pins the optimum to a narrow band so the success threshold is explicit.

For the atlas edge, the hardness needs to be robust over the possible hidden
weak gap of the marginal-nonuniform learner.  A sufficient version is:

> For every polynomially bounded inverse scale $\eta(n)$, `NNSS(C, P, rho,
> eta)` is NP-hard, or hard under the desired complexity assumption, even
> though $P_n$ is fixed for each $n$.

Equivalently, one can include a unary parameter $k$ and require hardness for
$\eta(n)=n^{-k}$ for every fixed $k$.

### Why This Would Refute The Target

Assume, for contradiction, that $\mathcal C=\bigcup_n\mathcal C_n$ satisfies
the target node under the fixed marginal family $P=\{P_n\}$.  Then there is a
single learner $B$ and, for this fixed marginal, some inverse-polynomial
$\alpha_P(n)$ and polynomial runtime bound.

Given an `NNSS` instance $I$, simulate labeled examples from the joint
distribution with mean $r_I(x)$ and run $B$.  With high probability it returns
a proper $c\in\mathcal C_n$ with

$$
\operatorname{score}_{r_I}(c)
\ge
\operatorname{Opt}(r_I)-1+2\alpha_P(n).
$$

Choose the hardness scale $\eta(n)\le \alpha_P(n)$ up to constants.  Since
$\operatorname{Opt}(r_I)\ge\rho$, the learner's output satisfies

$$
\operatorname{score}_{r_I}(c)
\ge
\rho-1+\eta(n),
$$

and therefore solves the NP-hard signed selector problem.  This is why the
hardness has to hold at every inverse-polynomial scale: the marginal-nonuniform
target is allowed to pick a very small weak gap for the fixed marginal.

The fixed-marginal condition is essential.  If the marginal changed with the
NP instance, the target's marginal-dependent polynomial could hide
instance-specific advice in $p_P$.  Here the instance lives only in the signed
conditional label rule $r_I$, while $P_n$ is common to all instances of length
$n$.

### Clean Promise Extension Proving The Source

The corresponding clean extension should be stronger and simpler than signed
optimization:

`CLEAN-EXT(C)`: Given a finite labeled sample

$$
S=((x_1,y_1),\ldots,(x_m,y_m))
$$

that is promised to be realizable by some $c^\star\in\mathcal C_n$, output
a proper $c\in\mathcal C_n$ consistent with all labels in $S$.

If `CLEAN-EXT(C)` runs in polynomial time, then the class satisfies the
source node, indeed a strong finite-class realizable proper PAC guarantee.
On arbitrary clean examples from any marginal $D$ over $X_n$ and any target
$c^\star\in\mathcal C_n$, draw

$$
m=O((\log|\mathcal C_n|+\log(1/\delta))/\varepsilon)
$$

examples, run `CLEAN-EXT`, and output the returned proper concept.  By the
standard finite-class/Occam argument, every proper concept consistent with the
sample has $D$-error at most $\varepsilon$ with probability at least
$1-\delta$.  Taking any fixed $\varepsilon<1/2$ gives a weak proper learner,
and taking smaller constant $\varepsilon$ gives a strong realizable learner at
polynomial sample size because $\log|\mathcal C_n|=\operatorname{poly}(n)$.

This is the clean promise extension I would require of the same class used in
`NNSS`.  It deliberately applies only to exact realizable finite samples.  It
does not solve `NNSS`, because the signed regression $r_I$ is noisy or
inconsistent rather than an exact partial labeling by one concept.

### Internal Consistency Checks

1. **No contradiction with low-noise coupling.**  If $r_I$ were deterministic,
   or if its noise relative to the best concept were below the clean transcript
   scale, `CLEAN-EXT` plus the usual coupling argument would solve the target
   case.  Therefore hard `NNSS` instances must live in a moderate-noise regime,
   for example $r_I\approx \rho c_I^\star$ with constant $\rho<1$, where an
   $m(n)$-label clean trace is hit with probability about
   $((1+\rho)/2)^{m(n)}$, potentially exponentially small.

2. **No structural no-neutral requirement.**  It is too strong, and probably
   unnecessary, to demand that no neutral concepts exist.  Exponentially many
   hidden concepts may have near-zero score.  The learning target would still
   be refuted if finding any such neutral or above-threshold proper concept is
   NP-hard.  The primitive is therefore computational no-neutral, not
   existential no-neutral.

3. **Support lookup is not fatal.**  Even if $X_n$ is polynomial-size and the
   learner can estimate all coordinates of $r_I$, the remaining proper
   optimization over $\mathcal C_n$ may be NP-hard.  What would trivialize the
   primitive is polynomial enumeration of $\mathcal C_n$ or an efficiently
   samplable above-threshold proper family, not finite support itself.

4. **Clean extension must handle arbitrary marginals.**  A consistency
   algorithm for samples from $P_n$ alone would not prove the source node.  The
   `CLEAN-EXT` formulation avoids this by taking arbitrary realizable samples;
   the Occam proof then works for every marginal $D$ over the finite support.

5. **The optimum band matters.**  The promise
   $\rho\le\operatorname{Opt}(r_I)\le\rho+\eta/10$ prevents a mismatch between
   the explicit search threshold and the OPT-relative learning guarantee.  A
   reduction could replace it by an efficiently certified upper bound on
   $\operatorname{Opt}(r_I)$, but some such calibration is needed.

### What Remains Missing

This primitive is internally coherent as a route to a false edge, but it is
only a route.  I do not have an explicit concept family for which both parts
hold:

1. polynomial-time clean proper extension for every realizable sample, hence
   distribution-free clean weak proper learning; and
2. fixed-marginal NP-hardness of `NNSS` at every inverse-polynomial scale.

Known templates fail one side or leak a neutralizer.  Linear/parity-like
classes have excellent clean extension but neutral wrong concepts.  CSP and
code-style classes can make signed optimization hard, but their clean
realizable extension problem is often hard as well, or they leave a public
random/legal sampler with nonnegative score.  The minimal primitive above makes
clear what a successful construction would need to add: easy exact extension
without an efficiently findable moderate-noise neutral proper output.

### Resolved?

RESOLVED: no.

## Depth 6 Attempt: NNSS Primitive Stress Test

### Question Pursued

Stress-test the depth 5 conditional route.  Suppose a finite-support
`NNSS` primitive exists.  Does it actually yield a concept class that is
distribution-free weak realizable proper PAC learnable but not
marginal-nonuniform weak agnostic proper PAC learnable?

My conclusion is adversarial but not fatal: the primitive as written is
missing several quantifiers needed for an atlas-level separation.  Once those
quantifiers are added, the conditional reduction survives.  I still do not
have an explicit primitive, so the original edge remains open.

### Source Side

The source side is the most stable part.  If the global class is a size-indexed
family

$$
\mathcal C=\bigcup_n \mathcal C_n
$$

over efficiently encoded finite supports $X_n$, and if `CLEAN-EXT` takes any
realizable finite sample from $X_n$ and returns a consistent member of
$\mathcal C_n$ in time polynomial in $n$ and the sample length, then the class
has distribution-free proper realizable learning on each size parameter.

The proof is the usual Occam argument.  Draw

$$
m=O((\log |\mathcal C_n|+\log(1/\delta))/\varepsilon)
$$

clean examples from an arbitrary marginal $D$ over $X_n$, run `CLEAN-EXT`, and
return the consistent proper concept.  Since
$\log|\mathcal C_n|=\operatorname{poly}(n)$, every consistent output has
$D$-error at most $\varepsilon$ with high probability.  In particular, taking
any fixed $\varepsilon<1/2$ gives weak proper learning.

This remains true even when $X_n$ is exponentially large, provided points have
polynomial-length encodings and `CLEAN-EXT` sees only the sampled points.  The
finite support is used only to make the Occam bound finite; it is not a lookup
assumption.

### Target-Side Reduction, With The Missing Quantifiers Exposed

For a fixed marginal ensemble $P=\{P_n\}$, an agnostic learner for the target
would have one polynomial runtime bound and one inverse-polynomial weak gap
for that ensemble.  Suppose its weak gap is

$$
\alpha_P(n)\ge n^{-k}
$$

after changing constants.  Given an `NNSS` instance with signed regression
$r_I$ and $\operatorname{Opt}(r_I)\ge \rho$, simulate examples with marginal
$P_n$ and conditional label mean $r_I(x)$.  If the learner returns $h$, then
in $\{\pm 1\}$ notation the target guarantee implies

$$
\operatorname{score}_{r_I}(h)
\ge
\operatorname{Opt}(r_I)-1+2\alpha_P(n)
\ge
\rho-1+2\alpha_P(n).
$$

Thus, for any hardness scale $\eta(n)\le 2\alpha_P(n)$, the learner solves the
corresponding `NNSS` search problem.  Since the marginal learner is allowed to
choose a hidden inverse-polynomial gap, the primitive must be hard for every
fixed scale $\eta(n)=n^{-K}$.

This part is sound only if the fixed marginal is treated as a single
size-indexed ensemble, not as a different unrelated marginal for each $n$.  If
each $P_n$ were allowed to receive its own unrelated marginal-nonuniform
polynomial, the exponent of that polynomial could vary with $n$ and hide a
superpolynomial algorithm across the sequence.  The separation needs one fixed
distribution-specific regime $P=\{P_n\}$ with one polynomial bound across all
sizes.

### Hidden Output-Space Issue

The depth 5 statement made `NNSS` a search over $\mathcal C_n$.  A target PAC
learner, however, may output any legal proper representation whose size is
polynomial in the target size, depending on the atlas convention.  If larger
representations $\mathcal C_{q(n)}$ contain constants, complements, padded
neutralizers, or other easy above-threshold concepts, then the learner can
satisfy the target without solving the literal $\mathcal C_n$ search problem.

So a separation primitive must quantify over the whole legal output range:
for every polynomial $q$, finding

$$
h\in \mathcal C_{\le q(n)}
$$

with score at least $\rho-1+\eta(n)$ must be hard.  Equivalently, the class
must be size-canonical so that target learners for size $n$ really output
inside the same family covered by `NNSS`.  Without this strengthening, padded
or larger-size neutralizers are an escape hatch.

### Hidden Neutralizers

The `NNSS` threshold is deliberately weak.  With $\rho=2/3$, the required
score is about $-1/3+\eta$, so any efficiently findable concept with
nonnegative score solves the instance.  Several neutralizer leaks have to be
ruled out by the primitive, not merely absent from the informal construction.

1. **Complements.**  If the class has an efficiently constructible complement
operation, then from any legal $c$, one of $c$ or $-c$ has nonnegative score.
Validation on labeled samples finds the better one.

2. **Constants or biased defaults.**  If legal constants exist and
$\mathbf E_{P_n} r_I(X)$ is not forced to be negative enough, a constant
classifier solves the weak threshold.  Even one fixed default concept can be a
neutralizer if every hard instance has score above the threshold against it.

3. **Balanced legal samplers.**  If there is an efficient sampler $Q_n$ over
proper concepts with average prediction close to zero on each point, then
sampling candidates and validating their empirical scores may find a neutral
proper output.  This is exactly the leak seen in CSP/legal-assignment
templates.

4. **`CLEAN-EXT` as a sampler.**  Even if no public sampler is given, one can
try random short labeled traces, run `CLEAN-EXT`, and validate the returned
concept.  The existence of `CLEAN-EXT` alone does not prove this works, but a
candidate primitive has to survive this attack.  If random trace extension
places noticeable mass on neutral concepts, `NNSS` is easy.

These are not objections to a fully quantified `NNSS` assumption.  They are
ways an attempted explicit construction would accidentally fail.  A true
`NNSS` hardness theorem against randomized polynomial-time algorithms with
sample access to the signed distribution would already rule out all of them.

### Support-Size Lookup

Finite support by itself is not fatal.  There are two distinct lookup issues.

First, if $|X_n|$ is polynomial and $P_n$ has no tiny effective tail, a learner
can estimate $r_I(x)$ on essentially all relevant points.  This reduces the
learning problem to an explicit signed optimization problem over the proper
class.  That does not automatically make the target easy: proper signed
optimization can still be NP-hard.  Therefore polynomial support is compatible
with `NNSS` only if the hardness remains true even after the learner knows the
entire signed weight vector.

Second, if the class itself has polynomially many relevant proper hypotheses,
or if the finite support plus `CLEAN-EXT` gives a polynomial enumeration of all
realizable traces, validation will find an above-threshold output.  This is the
real lookup failure.  The primitive must avoid polynomial enumeration of the
legal output family and any polynomial-size cover that contains a neutral
candidate for every instance.

For exponential supports, coordinate lookup disappears, but another
bookkeeping issue appears: the fixed marginal ensemble $P_n$ must be
efficiently samplable, and the `NNSS` hardness should be stated for learners
with the same kind of sample access the PAC learner receives.  Hardness with
explicit evaluator access to $r_I$ is stronger and would cover this.

### Stress-Test Verdict

Under the strengthened formulation, the route really would give a conditional
false edge:

1. `CLEAN-EXT` plus $\log|\mathcal C_n|=\operatorname{poly}(n)$ gives
   distribution-free weak realizable proper PAC learning.
2. Fixed-ensemble `NNSS` hardness at every inverse-polynomial scale, against
   all polynomial-size legal proper outputs, refutes marginal-nonuniform weak
   agnostic proper learning for that marginal ensemble.

Strictly as written at depth 5, however, `NNSS(C_n,P_n,\rho,\eta)` is not yet
an atlas-valid separation theorem.  It must be upgraded to handle the global
size-indexed marginal, larger proper outputs, randomized neutralizer
generators, and support-lookup algorithms.  Those upgrades are natural, but
they are additional requirements on the still-missing primitive.

RESOLVED: no.

## Depth 7 Attempt: Final Proper Selector Theorem Check

### Question Pursued

This pass checked whether the remaining middle-noise obstacle is already
covered by a known theorem:

1. a positive theorem deriving a same-marginal proper neutralizer or selector
   from distribution-free weak realizable proper learning; or
2. a standard fixed-marginal no-neutral signed-search hardness theorem that
   would instantiate the conditional `NNSS` primitive from the previous
   attempts.

I did not find either theorem.  The edge remains open.

### Positive Theorem Check

The closest positive result is the Hopkins--Kane--Lovett--Mahajan
realizable-to-agnostic framework, "Realizable Learning is All You Need"
([arXiv:2111.04746](https://arxiv.org/abs/2111.04746),
[TheoretiCS 2024](https://theoretics.episciences.org/13009)).  Its abstract
advertises a black-box equivalence between realizable and agnostic
learnability, including arbitrary distributional assumptions and other
learning models.  This is important evidence that the statistical version of
the problem should not be viewed as exotic.

However, I do not see it supplying the atlas lemma needed here.  The edge is
not asking only for statistical agnostic learnability.  It asks for a uniform
polynomial-time learner whose output is a single legal proper hypothesis in
the original class, and whose polynomial bound is marginal-nonuniform but not
label-conditional.  The known realizable-to-agnostic reductions use finite
class/statistical search or transformations that do not obviously preserve an
efficient proper selector.  They also do not turn a clean-label weak learner
into an oracle that optimizes arbitrary signed residuals over the same proper
class.

The modern agnostic-boosting line has the same limitation.  Kalai--Mansour--
Verbin's agnostic boosting theorem
([Microsoft Research page](https://www.microsoft.com/en-us/research/publication/agnostic-boosting-parity-learning/))
and Feldman's distribution-specific agnostic boosting
([arXiv:0909.2927](https://arxiv.org/abs/0909.2927)) boost an agnostic weak
learner.  Feldman's version is especially relevant because it keeps the
instance marginal fixed while modifying labels, but it assumes a
distribution-specific weak agnostic learner for those relabelings.  That is
exactly stronger than the source node: the source learner is justified only
on clean labels from a concept in the class.

Recent sample-efficient agnostic boosting papers sharpen the same point.
Da Cunha--Hogsgaard--Paudice--Sun define an agnostic weak learner by the
condition

$$
\operatorname{corr}_{D}(W(S)) \ge \gamma\sup_{f\in F}
\operatorname{corr}_{D}(f)-\varepsilon_0
$$

for every agnostic distribution $D$; see Definition 1.1 and Theorem 1.3 in
their NeurIPS 2025 paper
([OpenReview PDF](https://openreview.net/pdf?id=aFf30XJpl4),
[arXiv:2503.09384](https://arxiv.org/abs/2503.09384)).  This is already the
missing signed-residual oracle, not a consequence of clean weak proper
learning.  Their booster also outputs a sign of an aggregate score, not
necessarily one member of the original proper class.  The 2026 improved-time
version has near-optimal sample complexity and runtime polynomial in the
sample size when other parameters are fixed
([arXiv:2601.11265](https://arxiv.org/abs/2601.11265)), but that still does
not yield a polynomial-time proper selector when the relevant weak-sample
scale, dual dimension, or clean-transcript parameters grow with the
representation size.

Hanneke--Moran--Thiessen's marginal-nonuniform PAC learnability paper
([OpenReview](https://openreview.net/forum?id=aoVCFtox89)) confirms that
marginal-dependent rates are a natural statistical object and gives a
trichotomy of possible rates.  It does not appear to provide an efficient
proper agnostic selector from a distribution-free weak realizable proper
learner.

So the positive theorem landscape still leaves the exact missing lemma:

> Given only a distribution-free weak realizable proper learner for
> $\mathcal C$, and a fixed marginal $P$, construct in polynomial time a legal
> proper $h\in\mathcal C$ whose correlation with an arbitrary regression
> $r(x)=\mathbf E[Y\mid X=x]$ meets the weak OPT-relative threshold, or else
> construct a validation-searchable legal proper neutralizer.

I found no known theorem deriving this.

### Negative Theorem Check

I also looked for a standard fixed-marginal no-neutral signed-search hardness
result.  The known hardness templates are close but still miss one of the
required quantifiers.

Tiegel's halfspace hardness from worst-case lattice assumptions gives both
distribution-independent and distribution-specific agnostic hardness
([PMLR 2023](https://proceedings.mlr.press/v195/tiegel23a.html)).  The
fixed-Gaussian part rules out efficient algorithms for the strong
$\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$ target.  It does not by
itself rule out the much weaker atlas target
$\operatorname{OPT}+1/2-\gamma_P(s)$, and ordinary halfspaces contain legal
near-neutral handles such as constants or easy low-degree/low-accuracy
approximants.  Thus it is not a no-neutral proper-output witness for this
edge.

Feldman--Guruswami--Raghavendra--Wu show strong NP-hardness for weak
agnostic learning of monomials by halfspaces
([IBM summary](https://research.ibm.com/publications/agnostic-learning-of-monomials-by-halfspaces-is-hard)).
Their result is a distribution-free hardness template based on hard labeled
instances.  It does not give one fixed marginal ensemble $P=\{P_n\}$ under
which all hard labelings live while exact clean labels remain
distribution-free weak properly learnable.  It also does not rule out all
proper neutralizers or wrong-instance handles at the weak OPT-relative
threshold needed here.

Parity, LPN, and code-style templates have the opposite failure mode.  They
often give a fixed natural marginal, such as the uniform distribution, but
wrong parities or wrong codewords are nearly neutral under noisy labels.  In
the middle-noise regime a neutral proper output already satisfies the weak
additive target.  To force proper learning to decode the hidden comparator,
one would need the noise/correlation scale to be so low that the source or
hardness side usually changes into a different problem.

CSP and PCP templates have repeatedly leaked balanced legal samplers.  Random
legal assignments, complements, constants, or public defaults supply
validation-searchable proper hypotheses with score high enough for the weak
target.  Removing those handles tends either to break the distribution-free
clean weak source on concentrated marginals or to make the construction
instance-dependent in the marginal, which is not allowed for this edge.

I found no standard theorem whose conclusion is:

> For one efficiently samplable fixed marginal ensemble $P_n$, and for a
> size-indexed proper class $\mathcal C_n$ with efficient clean extension,
> it is hard for every randomized polynomial-time algorithm to find any legal
> polynomial-size proper output with score even slightly above the weak
> threshold against a signed regression $r_I$.

That is the missing no-neutral signed-search theorem.

### Atlas-Ready Conditional Primitive

The cleanest conditional negative primitive is the strengthened `NNSS`
formulation from the depth 5 and depth 6 attempts.

Fix a size-indexed class $\mathcal C=\bigcup_n\mathcal C_n$ over efficiently
encoded domains $X_n$ and one efficiently samplable marginal ensemble
$P=\{P_n\}$.  The primitive should provide:

1. **Clean extension.**  There is a polynomial-time `CLEAN-EXT` procedure
   that, for every realizable finite sample from $X_n$, returns a consistent
   member of $\mathcal C_n$, and $\log|\mathcal C_n|=\operatorname{poly}(n)$.
   By the Occam argument this gives distribution-free weak realizable proper
   PAC learning.

2. **Fixed-marginal signed instances.**  For infinitely many $n$, there are
   efficiently samplable or evaluable signed regressions
   $r_I:X_n\to[-1,1]$ under the same marginal $P_n$ with
   $M_I=\sup_{c\in\mathcal C_n}\mathbf E_{P_n}[r_I(X)c(X)]\ge\rho$ for some
   fixed $\rho>0$.

3. **No-neutral proper search hardness.**  For every polynomial output-size
   bound $q$ and every inverse-polynomial scale $\eta(n)$, no randomized
   polynomial-time algorithm, given the same sample access available to a PAC
   learner, can find any legal $h\in\mathcal C_{\le q(n)}$ with

   $$
   \mathbf E_{P_n}[r_I(X)h(X)] \ge M_I-1+\eta(n).
   $$

   Equivalently, the hardness must block not only exact decoding but every
   legal neutralizer, complement trick, default hypothesis, balanced proper
   sampler, padded larger representation, and random-trace extension that
   reaches the weak threshold.

Under this primitive, a marginal-nonuniform weak agnostic proper learner for
the fixed marginal ensemble $P$ would solve `NNSS`: simulate labels with
conditional mean $r_I(x)$, run the learner, and translate its weak
OPT-relative error guarantee into the score inequality above with
$\eta(n)$ chosen below twice its hidden inverse-polynomial gap.  This would
make the atlas edge conditionally false.

### Obstacles To Making NNSS Standard

The primitive is not currently supplied by any standard assumption I found.
The main obstacles are:

- **Proper output range.**  The hardness must cover every legal output size
  that the PAC learner may use, not only $\mathcal C_n$.

- **Neutral handles.**  Constants, complements, biased defaults, balanced
  legal samplers, and random `CLEAN-EXT` traces all solve the weak target if
  they produce even mildly neutral score.

- **Fixed marginal.**  Hardness reductions that place the instance in the
  marginal do not refute marginal-nonuniform learning, because $p_P$ may
  depend on that marginal.  The hard information must live in the conditional
  labels or signed regression while $P$ stays fixed across the ensemble.

- **Source side.**  Distribution-free clean weak learning is unforgiving on
  concentrated marginals.  Any construction with hidden hard patches must
  still allow efficient proper extension of exact clean labels on arbitrary
  finite samples.

- **Lookup and explicit optimization.**  Polynomial supports let the learner
  estimate the whole signed vector, so hardness must survive explicit signed
  optimization over the proper class.  Exponential supports avoid lookup but
  require efficient sampling and a hardness statement matching PAC sample
  access.

### Verdict

I found no known theorem implying the proper neutralizer/selector from the
source node, and no standard fixed-marginal no-neutral signed-search hardness
theorem instantiating `NNSS`.  The atlas-ready state is therefore:

> The edge remains open.  A positive proof needs an efficient same-marginal
> proper residual selector or neutralizer derived from clean weak proper
> learnability.  A negative proof needs a strengthened fixed-ensemble `NNSS`
> primitive with clean extension and hardness against all polynomial-size
> legal proper neutralizers.

RESOLVED: no.

## Depth 8 Final Incorporation Recommendation

RESOLVED: no for the original atlas edge.

The depth-8 recommendation is to keep the edge open and incorporate the
subagent tree as a sharper proof-status note.  No atlas file should be marked
`true` or `false` from the current evidence.

### Exact Suggested Frontmatter Update

For
`atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`,
preserve the stable graph fields:

```yaml
id: efficient-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
```

Replace the current `summary` with:

```yaml
summary: "Open after depth-8 search: the low-noise branch follows by clean-transcript coupling, but the middle-noise regime still needs an efficient same-marginal proper selector or neutralizer. A negative resolution would need a strengthened fixed-ensemble no-neutral signed-search primitive (NNSS) with clean extension and hardness against all polynomial-size proper outputs. Halfspace, CSP/PCP, parity/code, and oracle-diagonal routes remain near misses rather than atlas-valid witnesses."
```

Keep the current `ref_keys`:

```yaml
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - tiegel2023
```

Add these `ref_keys`, all already present in `references.bib`, because they
are the most useful citations for the refined open-problem explanation:

```yaml
  - hopkins2024
  - kalai2008agnosticboosting
  - feldman2010distributionspecific
  - dacunha2026agnosticboosting
  - feldman2012monomials
```

Suggested full `refs` list:

```yaml
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hopkins et al. 2024](https://doi.org/10.46298/theoretics.24.2)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Feldman et al. 2012](https://doi.org/10.1137/120865094)"
```

Do not add a conditional assumption to `assumptions` yet.  The strengthened
`NNSS` primitive is a proposed missing primitive, not a standard assumption
with an instantiated class.

### Exact Suggested Body Update

Keep the theorem statement, but replace `## Proof Status` with the following
atlas-ready text.

```markdown
## Proof Status

**Goal.** Decide whether efficient distribution-free weak realizable proper
learning implies efficient marginal-nonuniform weak agnostic proper learning.

**Verdict.** The edge remains open.  The low-noise part has a robust positive
argument, but the depth-8 search found neither a theorem deriving the needed
middle-noise proper selector nor a standard separation blocking every proper
neutral output.

**Low-noise branch.** Let the source learner have inverse-polynomial clean
advantage $\gamma(s)$ and sample bound $m(s,\log(1/\delta))$.  If the
agnostic labels have small error relative to a near-optimal comparator
$c^\star\in\mathcal C$, then a noisy sample agrees with the clean sample
$(X,c^\star(X))$ on all labels in one source call with inverse-polynomial
probability at the clean-transcript scale.  Repeating the source learner and
validating the resulting proper hypotheses gives a weak agnostic proper
output.  This part uses only distribution-free clean weak proper learning and
is uniform over marginals.

**Middle-noise obstruction.** When $\operatorname{OPT}_{\mathcal C}(\mathcal D)$
is above the clean-transcript scale, the target weak guarantee can be met by a
legal proper hypothesis with sufficiently nonnegative correlation against the
same-marginal regression $r(x)=\mathbf E[Y\mid X=x]$.  The source learner,
however, only works on exactly clean labels from a member of $\mathcal C$.
It does not provide an efficient same-$P$ proper neutralizer, nor an
OPT-relative selector for hidden disagreement regions
$\{x:g(x)\ne h(x)\}$ with $g,h\in\mathcal C$.

Equivalently, after a failing proper candidate $h$, the missing primitive is
weak signed optimization over legal residual regions under the same marginal:

$$
\mathbf E_P[-r(X)h(X)\mathbf 1_D(X)]
$$

for $D$ ranging over proper disagreement regions.  Clean weak realizable
learning gives this only when a clean legal target is already available; it
does not identify such regions from agnostic labels.

**Positive route still missing.** A proof of the implication would follow from
an efficient cover-or-neutralizer theorem: from distribution-free weak
realizable proper learning, construct for every fixed marginal $P$ either a
validation-searchable proper neutralizer for middle-noise regressions or a
polynomial-size menu/list of proper residual selectors.  The depth-8 search
found conditional versions of this statement under extra assumptions such as
explicit fixed-$P$ proper ERM, small proper compression, or a polynomial
clean-witness generator, but none of these follows from the source node.

**Negative route still missing.** A separation would follow from a strengthened
fixed-ensemble no-neutral signed-search primitive (`NNSS`).  Such a primitive
would provide one efficiently samplable marginal ensemble $P_n$, a proper
class with efficient clean extension for all realizable samples, and signed
regressions $r_I$ such that some proper comparator has constant positive
score, but every randomized polynomial-time learner fails to find any legal
polynomial-size proper output whose score reaches even the weak
OPT-relative threshold.  The hardness must rule out constants, complements,
biased defaults, balanced legal samplers, padded larger representations,
random clean-extension traces, and every other proper neutralizer.

No standard assumption checked in the depth-8 search instantiates this `NNSS`
primitive.

**Near misses.**

- Halfspace hardness, including Tiegel's lattice-based agnostic hardness,
  targets stronger `OPT + epsilon` accuracy or distribution-independent
  hardness notions.  Ordinary halfspaces also contain legal constants or
  near-neutral hypotheses, and homogeneous/restricted halfspace variants still
  leak complements or unrelated near-neutral directions at the weak threshold.
- CSP/PCP and Max-kLIN style constructions give attractive fixed-marginal
  hardness templates, but legal random assignments, complements, constants, or
  public default handles repeatedly provide proper balanced samplers.  Removing
  those handles tends to break distribution-free clean weak proper learning on
  concentrated marginals.
- Parity, LPN, and code-style constructions often have the desired fixed
  natural marginal, but wrong parities or wrong codewords are neutral enough
  in the middle-noise regime to satisfy the weak target.  Strengthening the
  correlation requirement changes the problem into a different strong
  agnostic or decoding task.
- Oracle diagonal constructions illustrate why a no-neutral witness is
  plausible: clean proper learning can be made easy while target learners are
  diagonalized against hidden signed regressions.  These constructions are not
  atlas-valid separations because the clean learner uses an oracle and the
  marginal/nonuniform bookkeeping has not been de-oracleized.

**Conclusion.** The implication should remain in
`marginal-agnostic-hardness-open`.  The shortest current description is:
the source gives low-noise robustification, but the middle-noise branch is
equivalent to finding a same-marginal proper selector or neutralizer; the
opposite direction would require a strengthened fixed-ensemble `NNSS`
separation that blocks all polynomial-size legal proper neutralizers while
preserving efficient distribution-free clean weak proper learning.
```

### Reference Notes

Keep Benedek--Itai and Hanneke--Moran--Thiessen for fixed/marginal-nonuniform
learnability background.  Keep Tiegel for the halfspace hardness near miss.
Add Hopkins--Kane--Lovett--Mahajan for the clean realizable-to-agnostic
context, Kalai--Mansour--Verbin and Feldman for agnostic boosting and
distribution-specific boosting context, da Cunha--Moller Hogsgaard--Paudice
for the current residual-free boosting near miss, and
Feldman--Guruswami--Raghavendra--Wu for the monomial-by-halfspace weak
agnostic hardness near miss.

Do not add CSP/PCP citations to this edge unless the body is expanded beyond
the short near-miss bullet.  If it is expanded later, the best next references
to add to `references.bib` would be Hastad's optimal inapproximability work
and an Austrin-style approximation-resistance/factor-graph source, but the
current atlas note can simply record the CSP route as a checked near miss.

Final verdict for this subagent tree: the problem remains genuinely open.

RESOLVED: no.

## Depth 9 Attempt: Final Distribution-Free Proper Selector Search

RESOLVED: no.

### Question Pursued

This pass asked whether the extra strength in the source edge--a single
distribution-free weak realizable proper learner with one uniform polynomial
sample/runtime bound--can be converted into the missing same-marginal proper
selector.  Earlier depths already reduced the edge to the middle-noise problem,
so I focused on whether distribution-freeness itself supplies a final escape
from the selector obstruction.

I reread the edge, the two definition notes, the depth-1 through depth-8
scratchpad tree, and the nearby argument notes
`marginal-agnostic-hardness-open`, `low-noise-weak-agnostic-robustification`,
`properization-open`, `agnostic-boosting-open`, `marginal-boosting-open`, and
`sample-complexity-equivalence`.  I also checked the primary-source landing
pages for the most relevant near misses: Hopkins--Kane--Lovett--Mahajan's
realizable-to-agnostic framework, Hanneke--Moran--Thiessen's
marginal-nonuniform rates, Tiegel's halfspace hardness, Feldman's
distribution-specific agnostic boosting, da Cunha--Hogsgaard--Paudice's 2026
agnostic boosting paper, and Feldman--Guruswami--Raghavendra--Wu's
monomial-by-halfspace hardness.

The conclusion is unchanged: I do not see a source-grounded proof or
separation.  The edge should remain open.

### Score Form And What Distribution-Freeness Adds

Use $\{\pm1\}$ labels.  For a fixed marginal $P$ and agnostic regression
$r(x)=\mathbf E[Y\mid X=x]$, write

$$
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P.
$$

The target asks for a proper $h\in\mathcal C_s$ such that

$$
\langle r,h\rangle_P\ge M(r)-1+2\alpha_P(s)
$$

for some inverse-polynomial marginal-dependent gap $\alpha_P$.

The distribution-free source improves the earlier marginal-source situation in
exactly two ways:

1. it gives one clean weak advantage and one source sample bound independent
   of $P$; and
2. it lets a clean-transcript coupling work under any marginal or conditional
   marginal once the labels are exactly those of a concept in $\mathcal C$.

These two facts fully explain the low-noise branch.  If a near-optimal
$c^\star$ has agnostic error below the inverse source-transcript scale, noisy
examples agree with clean $c^\star$ labels often enough that repeated proper
source calls and validation find a weak agnostic proper output.

They do not explain the middle-noise branch.  Distribution-freeness lets us
run the source learner under any clean marginal, but it does not tell us how to
obtain clean labels for the unknown comparator, nor how to choose a clean
residual distribution whose legal target is observable from agnostic data.
The missing primitive remains a same-$P$ proper neutralizer or a proper signed
selector.

### Final Positive Search

I checked four possible distribution-free selector routes.

**1. Realizable-to-agnostic black-box reductions.**  Hopkins--Kane--Lovett--
Mahajan give a broad statistical framework in which realizable and agnostic
learnability are equivalent, including settings with arbitrary distributional
assumptions.  This is strong evidence that the statistical version of the
problem is not pathological.  It still does not settle this computational
proper edge.  The known black-box reductions rely on finite-class search,
sample/compression-style enumeration, or otherwise statistical operations that
can be exponential in the representation size.  If the realizable learner is
proper, such enumeration may produce proper candidates, but it does not give a
polynomial-time selector for one member of the original class.

This matches the parity obstruction from depth 2.  Under the uniform marginal,
parities are efficiently cleanly properly learnable, but any clean weak cover
with positive edge against every parity has to contain all parities.  Large
clean covers are therefore sometimes intrinsic; a positive proof must exploit
a cover-or-neutralizer dichotomy, not merely distribution-free learnability.

**2. Reusing realizable boosting traces.**  A distribution-free weak
realizable proper learner can be boosted in the realizable setting, but the
boosted predictor is generally an improper vote.  More importantly, the weak
calls in a clean boosting proof are labeled by the clean target under
reweighted distributions.  In the agnostic middle-noise regime the comparator
$c^\star$ is hidden, and calls on observed noisy labels or residual labels are
off-promise.

The agnostic boosting sources go in the opposite direction.  Kalai--Mansour--
Verbin, Feldman, and the recent da Cunha--Hogsgaard--Paudice work assume a
weak agnostic/correlation oracle on agnostic relabelings or residuals.  That
oracle is essentially the selector needed here.  Feldman's
distribution-specific boosting is especially close because it preserves the
instance marginal by changing labels, but it still starts from a
distribution-specific weak agnostic learner, not from a clean weak proper
learner.

**3. Self-labeling from known proper hypotheses.**  One can generate legal
clean labels from any already-known proper concept $h_0$, run the source
learner on distributions labeled by $h_0$, and validate the resulting proper
hypotheses on the agnostic sample.  This explores a source-dependent closure
around $h_0$.  It does not solve the selector problem: if every efficiently
available seed is anti-correlated with $r$, clean relabelings by those seeds
need not expose a profitable disagreement region with $c^\star$.  Repairing a
bad seed requires complements, patching, regional flips, or a residual
selector, none of which follows from the source node.

**4. Contradicting the source from absence of neutralizers.**  A tempting
minimax proof would say: if no proper $h$ has enough score against $r$, then
construct a clean marginal/target on which the distribution-free source
learner fails.  I do not see a valid construction.  Badness against $r$ is a
signed agnostic statement, not a clean realizable error statement.  A failing
candidate $h$ only implies that some near-optimal comparator $c^\star$ hides
mass on a disagreement region where replacing $h$ by $c^\star$ would improve
score.  The source learner can exploit that region only after it is given
clean labels of a legal target on the relevant marginal.  The agnostic data
identifies the observable filter $\{Y\ne h(X)\}$, which is clean for $-h$ on
realized mistakes, not for the hidden comparator or for a legal proper patch.

Thus distribution-freeness gives a uniform clean oracle, but not the label
oracle needed to invoke it in middle noise.

### Final Negative Search

I also tried to turn the obstruction into an ordinary fixed-marginal hardness
template rather than the abstract `NNSS` primitive.

The most promising generic template is a fixed feasible set with easy clean
extension but hard signed optimization.  Let the domain be coordinates, and
let proper hypotheses be feasible $\{\pm1\}$ assignments for a fixed
constraint system.  If every realizable partial assignment can be extended in
polynomial time, then clean proper PAC learning follows by an Occam argument.
On a fixed uniform marginal, agnostic learning becomes signed optimization of
the coordinate weights induced by $r$.

This captures natural candidates such as linear codes with erasure extension,
2-SAT-like feasible assignments, and independent-set style assignments in a
fixed graph family.  It is also exactly where the weak additive threshold
causes trouble.

Ordinary signed-optimization hardness is too strong a target.  The learner
does not need to approximate $M(r)$ well; it only needs score
$M(r)-1+1/\operatorname{poly}$.  In an independent-set encoding with uniform
coordinate marginal and nonnegative weights, for example, the all-negative
empty set is a legal default.  If the optimum independent set selects an
$a$-fraction of the mass, the target only forces selection of roughly
$a-1/2$ of the mass.  Many exact or constant-factor optimization lower bounds
do not rule out such a half-range output, and standard defaults, random
feasible assignments, or approximation algorithms often fall inside the
allowed window.  Codes have the analogous leak: efficient linear or erasure
structure usually gives either the zero codeword, complements, or random
codeword samplers with near-neutral score.

This explains why the known hardness sources still miss.  Tiegel gives
distribution-independent weak hardness and fixed-Gaussian strong
`OPT + epsilon` hardness for halfspaces, but not a fixed-marginal theorem
ruling out every legal weak neutral output.  Feldman--Guruswami--Raghavendra--
Wu give weak agnostic hardness for monomials even when halfspace outputs are
allowed, but the reduction's hard distribution/sample is not one fixed
marginal ensemble with all hard information in the conditional labels.  CSP,
PCP, Max-kLIN, nearest-codeword, and weighted-feasible-set templates can make
exact agnostic optimization hard, but they have not supplied the stronger
no-neutral statement needed at the atlas threshold while preserving efficient
clean proper extension under every marginal.

### Final Directions And Obstacles

I would leave the atlas fields unchanged:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
```

The depth-8 body update is still accurate.  If the main atlas note is expanded
again later, the only depth-9 addition I would make is the following sentence:

> Distribution-freeness supplies a uniform clean-transcript oracle and hence
> the low-noise branch, but attempts to turn it into a middle-noise proper
> selector reduce either to exponential clean-trace enumeration or to an
> agnostic residual oracle that is stronger than the source node.

Concrete final directions:

1. **Fixed feasible-set `NNSS`.**  Search for a fixed sequence of feasible
   assignment systems with polynomial-time clean extension but hardness of
   finding any feasible assignment above the half-range threshold
   $M(r)-1+1/\operatorname{poly}$.  This is stronger than standard exact or
   constant-factor optimization hardness; it must block defaults, random
   feasible samplers, complements, and approximation algorithms.

2. **Effective cover-or-neutralizer dichotomy.**  Prove that if clean trace
   families are too large to enumerate, then their largeness yields an
   efficiently samplable proper neutralizer under the fixed marginal.  Parities
   show why this must be a dichotomy: polynomial clean covers need not exist,
   but neutral wrong hypotheses may still make the agnostic target easy.

3. **Residual selector under extra structure.**  Record positive sublemmas for
   classes with legal constants, complements, proper ERM under $P$, logarithmic
   proper compression, or an efficiently samplable balanced proper family.
   These would not resolve the abstract edge, but they would identify the
   exact structures that close the middle-noise branch.

4. **Do not use current halfspace/CSP/code hardness as an atlas separation.**
   They remain valuable near misses, but none currently proves hardness
   against all polynomial-size legal proper neutralizers under one fixed
   marginal while retaining distribution-free clean weak proper learning.

Final verdict: the implication remains genuinely open after this final
distribution-free selector search.
