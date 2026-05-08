# Edge: efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-realizable-improper-pac

- date: 2026-05-07
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- target: `efficient-realizable-improper-pac`
- write constraint: this scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

## Depth 1 Branch A: Hidden Weak-Gap Audit

### Setup

The edge is currently marked `open`. The source gives one uniform learner $A$
which, for every marginal $P$, has a marginal-dependent polynomial resource
bound and a marginal-dependent inverse-polynomial weak advantage:

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)^{-1}\le s^{k(P)}
$$

up to the usual confidence bookkeeping. The learner is proper, but the target is
improper, so properness is not an obstacle. If $A$ had one distribution-free
inverse-polynomial weak gap, then Schapire/Freund realizable boosting would
produce the target strong improper learner by taking a vote over weak
hypotheses.

Thus the exact missing step is

$$
\forall P\ \exists k(P)
\quad\Longrightarrow?\quad
\exists k_0\ \forall P .
$$

I do not see a proof of this quantifier swap under the current atlas semantics,
and I do not have an atlas-ready counterexample.

### Full-Support Resource Uniformization

The full-support transcript argument removes the naive resource obstruction.
Choose a full-support reference marginal $P^\star$ on every finitely encoded
instance in each relevant size slice. Since $A$ is one algorithm, and the atlas
treats sample use and runtime as worst-case/pathwise bounds on finite encoded
transcripts, the source guarantee for $P^\star$ bounds the runtime and sample
use of $A$ on every transcript that could occur under any marginal. Otherwise
that transcript would occur with positive probability under $P^\star$ and
violate the $P^\star$ polynomial.

This gives one distribution-free polynomial bound for one call to $A$. It does
not transfer weak accuracy. A hypothesis can have a weak edge under a
full-support mixture by being good on easy or high-mass components while being
uninformative on a component that another marginal isolates. Weak advantage has
no component-transfer rule analogous to the strong statement
"error at most $w\varepsilon$ under a mixture implies error at most
$\varepsilon$ under a component of mass $w$."

So full support uniformizes transcripts, not hidden gaps.

### Weak-Gap Uniformization

A direct boosting proof needs a polynomial envelope for all marginals generated
by the booster. Standard realizable boosting filters or reweights examples, so
it calls the weak learner on induced marginals $Q_t$. The source supplies

$$
\forall Q_t\ \exists k(Q_t)\quad \gamma_{Q_t}(s)\ge s^{-k(Q_t)},
$$

but a distribution-free boosted learner needs a usable bound of the opposite
form:

$$
\exists K\ \forall Q_t\quad \gamma_{Q_t}(s)\ge s^{-K}.
$$

Guess-and-validate does not repair this. To distinguish error $1/2$ from
$1/2-\gamma$ requires $\Omega(\gamma^{-2})$ labeled examples. If
$\gamma_P(s)=s^{-k(P)}$ with $k(P)$ unbounded across marginals, then validation
and the number of boosting rounds both inherit a marginal-dependent polynomial
degree. That gives at most a marginal-nonuniform strong learner, not the
distribution-free target.

The tempting diagonal proof also fails in the current global-marginal reading.
If bad marginals $Q_j$ with gaps near $s_j^{-j}$ are mixed into

$$
P=\sum_j w_j Q_j,
$$

then the $j$th bad component has only weight $w_j$. A weak learner for $P$ may
ignore low-mass bad components and still beat random guessing globally by an
inverse-polynomial amount. This is exactly where a size-indexed, full-mass
marginal semantics would differ: there, bad size slices could plausibly be
stitched into one marginal family and force a uniform exponent. That is a
conditional theorem for a nearby schema, not a proof for this edge.

### Hidden-Gap And Rare-Block Counterexamples

Plain cryptographic classes, such as PRF classes, are not witnesses. They can
make the target false under standard evaluable-output conventions, but they also
make the source false: on the hard marginal, even weak prediction advantage
would distinguish pseudorandom labels from random labels.

Rare-block templates have the right target-side shape. Put a hard block of size
$N=s^j$ behind level $j$. For any alleged distribution-free strong learner with
global polynomial degree $D$, choose $j>D$ and test it on the marginal uniform
on that block. With too few samples it cannot predict many unseen PRF or
random-oracle labels, so the strong improper target should fail, assuming
efficient improper outputs are polynomial-time evaluable.

The source side is the blocker. A cheap proper weak learner can memorize
sampled positive atoms or sampled coordinate pairs, giving a local advantage of
order $1/N$ on friendly balanced block marginals. But the source must work for
every marginal on the same block. Consider paired examples with target
$c_f(u,b)=1$ iff $b=f(u)$, and two nearly balanced marginals

$$
P_+(u,f(u))=\frac{1+2\eta}{2N},\qquad
P_+(u,1-f(u))=\frac{1-2\eta}{2N},
$$

with $P_-$ obtained by swapping the two weights. If a pathwise-polynomial weak
call uses $m$ samples and $N\gg m^2$, choose $\eta=\Theta(m/N)$. Then

$$
\operatorname{TV}(P_+^m,P_-^m)=O(m\eta)=O(m^2/N)=o(1).
$$

A deterministic proper hypothesis must still choose some behavior on unseen
pairs. The better unseen orientation is opposite under $P_+$ and $P_-$. The
sampled handles recover only $O(m/N)$ mass, so a wrong unseen orientation can
erase the intended weak edge. Estimating the sign of the tiny bias would cost
about $\eta^{-2}$ samples, which is not uniformly polynomial when $j$ is
unbounded.

Fresh prediction-time randomized hypotheses would make this particular block
easy: memorize sampled pairs and flip a fair coin on unseen pairs. But the
current atlas nodes use ordinary deterministic hypotheses with zero-one error,
and the source here is proper. Public deterministic orientation certificates
also seem dangerous: if they are visible enough for every marginal source
learner, a distribution-free improper learner can often exploit them too.

### Obstacles

1. Full-support uniformization gives one pathwise resource polynomial for the
   source learner, but not a distribution-free lower bound on $\gamma_P(s)$.
2. Ordinary boosting requires a uniform weak-gap envelope over reweighted or
   filtered marginals; the source gives only one hidden exponent per marginal.
3. Global mixture diagonalization dilutes bad components before weak error sees
   them, unlike a size-indexed full-mass semantics.
4. Rare-block false witnesses have plausible target hardness, but deterministic
   proper source learning runs into the near-balanced orientation and
   validation-scale barrier.

### Depth 2 Directions

1. Prove a formal no-go lemma for deterministic rare-block handles: any
   pathwise-polynomial proper learner based on sampled local handles fails on
   one of the paired opposite-bias marginals unless it predicts hidden labels on
   many unseen coordinates.
2. Isolate a conditional true theorem under a precise weak-gap envelope,
   such as a bounded-density or booster-local stability axiom
   $\gamma_Q(s)\ge 1/\operatorname{poly}(s,B)$ for all induced marginals
   $Q\ll P$ with density bound $B$.
3. Compare the current global-marginal semantics with a size-indexed
   marginal-family semantics. Under the latter, the diagonal weak-gap
   uniformization proof may become valid and would resolve the nearby schema
   true.

### Sources Checked

Local notes checked include the assigned edge note, the source and target
definition notes, `full-support-marginal-uniformization`,
`marginal-uniformization-open`, `marginal-boosting-open`, `realizable-boosting`,
and the adjacent weak-realizable improper scratchpads. Primary-source anchors:
Schapire's weak-to-strong theorem, Freund's boost-by-majority distribution-
dependent near miss, and Hanneke-Moran-Thiessen's marginal-nonuniform
sample-rate trichotomy.

### Conclusion

I would not update the atlas edge to true or false from this branch. The best
atlas update, if edits are later allowed, is a sharper open explanation:
resource uniformization is available for one weak call, but weak-gap
uniformization is missing; rare-block counterexamples expose the desired hidden
gap but currently fail the arbitrary-marginal deterministic proper source.

VERDICT: unresolved

## Depth 2 Branch A: Weak-Gap Equivalence Audit

### Goal

This branch tests whether the strong distribution-free improper target adds an
obstruction beyond the weak-gap problem identified in Depth 1.

Let

$$
S=\text{efficient marginal-nonuniform weak realizable proper PAC},
$$

$$
W=\text{efficient distribution-free weak realizable improper PAC},
$$

and

$$
T=\text{efficient distribution-free strong realizable improper PAC}.
$$

For this source, the present edge $S\Rightarrow T$ is equivalent to the weak
sibling $S\Rightarrow W$.

The implication $S\Rightarrow T$ trivially implies $S\Rightarrow W$: run the
strong learner at, say, $\varepsilon=1/3$, giving constant weak advantage
$1/6$.

Conversely, $S\Rightarrow W$ implies $S\Rightarrow T$ by classical realizable
boosting. Once $W$ is available, the booster has a distribution-free weak
improper learner with one inverse-polynomial advantage. The booster may call it
on its reweighted or filtered marginals because those marginals are still
realizable by the same target concept $c\in\mathcal C$. The final majority vote
need not be proper, which is allowed by $T$.

So strong learning itself does not create an additional obstruction. Directly
boosting the marginal-nonuniform source only restates the same missing step:
the booster needs one polynomial lower envelope on the weak gaps of all induced
marginals, while the source gives only

$$
\forall Q\ \exists k(Q).
$$

### Full-Support Envelope Attempt

The full-support transcript argument remains useful but stops at resources.
For the single source learner $A$, applying the source to a full-support
reference marginal $P^\star$ gives one pathwise polynomial bound on sample use
and runtime for every finite transcript that could arise under any marginal.

The tempting upgrade would be to use the same $P^\star$ to lower-bound weak
accuracy. This fails for a simple reason: weak accuracy is not componentwise.
A hypothesis can have edge under a full-support mixture by doing well on easy
or high-mass components while being exactly random, or worse, on a component
that another marginal isolates. The strong-error calculation

$$
\operatorname{err}_{\sum_i w_iP_i}(h,c)\le w_j\varepsilon
\Rightarrow
\operatorname{err}_{P_j}(h,c)\le\varepsilon
$$

has no weak-edge analogue at the scale needed here.

A second attempt is to thicken the target marginal:

$$
Q_\lambda=(1-\lambda)P+\lambda R
$$

with $R$ full support. If $A$ returns $h$ with
$\operatorname{err}_{Q_\lambda}(h,c)\le 1/2-\gamma_{Q_\lambda}(s)$, then the
best direct bound on $P$ loses about $\lambda/2$. To infer even a weak edge on
$P$, one needs $\gamma_{Q_\lambda}(s)>\lambda/2$. But
$\gamma_{Q_\lambda}$ is exactly the hidden marginal-dependent quantity; it may
be below every fixed inverse-polynomial $\lambda$ chosen by a distribution-free
wrapper. Taking $\lambda$ super-polynomially small also cannot be used in a
polynomial learner, and in any case PAC samples from $P$ do not provide labeled
samples from $R$.

Thus full support gives no weak-gap envelope. It proves one-call efficient
computation, not distribution-free weak learnability.

### Hidden-Gap Counterexample Attempt

The rare-block PRF construction still has the right target-side geometry.
Create a block of size $N=s^j$ with pseudorandom labels, and choose $j$ larger
than the degree of any proposed distribution-free strong improper learner. On
the uniform block marginal, the learner sees too few coordinates to predict
fresh PRF labels. Under the usual convention that efficient improper
hypotheses are polynomial-time evaluable, a low-error learner would give a PRF
distinguisher.

The unresolved part is again the source. A proper weak learner can get a
friendly-marginal edge of order $1/N$ by outputting a sampled singleton, a
sampled pair correction, or a sparse handle. For each fixed block level this
is an inverse polynomial with a level-dependent exponent. But the source must
work for every marginal on that same block.

The near-balanced orientation test blocks the obvious deterministic handles.
Suppose a resource-uniformized weak call uses at most $m=s^T$ examples. On a
paired block with one positive atom $p_u$ and one negative atom $q_u$ per
coordinate, take $N\gg m^2$ and define

$$
P_+(p_u)=\frac{1+2\eta}{2N},\qquad
P_+(q_u)=\frac{1-2\eta}{2N},
$$

with $P_-$ obtained by swapping the weights and with
$\eta=\Theta(m/N)$. The all-one default is better under $P_+$ and the all-zero
default is better under $P_-$. A sparse sampled correction covers only
$O(m/N)$ mass, so the wrong default still has error at least $1/2$.

But

$$
\operatorname{TV}(P_+^{\otimes m},P_-^{\otimes m})
=O(m\eta)=O(m^2/N)=o(1).
$$

No $m$-sample deterministic proper learner can choose opposite orientations
with high probability on both marginals unless it has some third hypothesis
that predicts many unseen PRF labels. That third hypothesis would threaten the
target hardness. Prediction-time randomized or abstaining handles would be
neutral on unseen points and would make this template much more plausible, but
they are outside the present deterministic binary proper PAC node.

So the rare-block construction gives a credible hidden-gap counterexample
shape, but not an atlas-ready false witness satisfying $S$.

### Conclusion

The reduction structure is now clean: the edge is exactly weak-gap
uniformization plus classical boosting. If one proves the distribution-free
weak improper sibling, this strong edge follows immediately; if this strong
edge is false, the weak sibling is false as well. I do not see an additional
strong-learning obstruction after a uniform weak gap is available.

I also do not see a proof that the hidden marginal gaps must uniformize. The
full-support argument cannot transfer weak accuracy, compact or finite-game
arguments do not force inverse-polynomial margins across sizes, and global
mixture diagonalization dilutes bad slices before weak error sees them.

Nor is there a concrete false witness yet. The best rare-block/PRF template
has plausible strong improper hardness, but its cheap proper weak handles fail
under arbitrary near-balanced marginals because deterministic hypotheses must
choose an unseen default orientation at the hidden gap scale.

### Depth 3 Directions

1. Prove the formal equivalence with the weak-improper sibling as an atlas
   lemma: $S\Rightarrow T$ iff $S\Rightarrow W$, using
   $T\Rightarrow W$ by fixed $\varepsilon$ and $W\Rightarrow T$ by
   realizable boosting.
2. Make the near-balanced orientation test a reusable no-go lemma for
   deterministic local-handle witnesses: specify a class of sparse/default
   proper hypotheses and prove that $P_+$/$P_-$ defeat any pathwise
   $m$-sample learner when $N\gg m^2$.
3. Test an oracle or stochastic-hypothesis version of the rare-block PRF
   witness. If randomized or abstaining neutral handles make the false witness
   work, the exact missing ingredient in the deterministic atlas model becomes
   visible; if they leak to the improper target, the false route likely needs a
   different idea.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md

## Depth 3 Branch A: Deterministic Hidden-Gap Fork

### Goal

Depth 2 reduced the assigned edge to the following fork.

Either prove a weak-gap uniformization theorem:

$$
\forall P\ \exists k(P)\quad
\gamma_P(s)\ge s^{-k(P)}
\quad\Longrightarrow\quad
\exists K\ \forall P\quad \gamma_P(s)\ge s^{-K},
$$

for the single proper weak learner promised by the source, or construct a
class where the hidden exponents are real: every marginal has some weak proper
edge, but no distribution-free polynomial-time improper strong learner exists.

I tried both directions under the current deterministic binary-output
semantics. Neither gives an atlas-ready resolution.

### Positive Fork: Same-Marginal Semantics Do Not Force A Uniform Gap

The strongest code-level fact is still full-support resource uniformization.
Choose a full-support reference marginal $P^\star$. Since the source learner
$A$ is one algorithm and resources are pathwise bounds on finite transcripts,
the $P^\star$ guarantee supplies one polynomial bound for a call to $A$ on
any transcript generated by any marginal. Thus a positive proof cannot blame
hidden runtime or hidden sample count.

What remains is semantic accuracy. The same-marginal weak source says that for
each marginal $P$, the average risk of $A$ under that same $P$ is below
$1/2$ by an inverse polynomial whose exponent may depend on $P$. This is too
local to imply a distribution-free envelope.

The usual diagonal compactness proof fails for two separate reasons.

First, fixed-size positivity is not enough. For a fixed representation size
$s$, one may define a worst-case one-call edge

$$
\lambda_s=\inf_{P,c}\left(\frac12-\operatorname{err}_P(A,c)\right).
$$

Even if finite-domain compactness or continuity gave $\lambda_s>0$, it would
not imply $\lambda_s\ge s^{-K}$ for one constant $K$. The infimum can decay
like $2^{-s}$ or $s^{-\log s}$ while each fixed marginal still has a legal
marginal-dependent inverse-polynomial edge.

Second, the global-marginal diagonal stitch dilutes bad slices. If bad
marginals $Q_j$ have gaps near $s^{-j}$ and we form

$$
R=\sum_j w_j Q_j,
$$

then a weak learner for $R$ may obtain its entire aggregate advantage on the
complement of the $j$th slice while ignoring that slice. Weak error has no
componentwise transfer rule at this scale. A size-indexed semantics with full
mass on every active size would block this escape, but the current atlas
definition uses ordinary global marginals.

Validation and black-box search also cannot close the gap. To distinguish
error $1/2$ from $1/2-\gamma$ costs $\Omega(\gamma^{-2})$ labeled examples.
If $\gamma_P(s)=s^{-k(P)}$ with unbounded $k(P)$, any wrapper that finds,
validates, and boosts the edge inherits a marginal-dependent polynomial
degree. That proves at most a marginal-nonuniform strong learner, not the
distribution-free target.

So the positive fork remains conditional: a uniform weak-gap envelope, a
booster-local bounded-density envelope, or a size-indexed full-mass marginal
semantics would make the edge true by Schapire/Freund boosting. I do not see
a derivation of any of those principles from the present source node.

### Negative Fork: Hidden Hard Blocks Still Fail The Source

The best false template is still a rare hard block. For a level $j$, take
$N=s^j$ paired fibers

$$
B_j=\{(u,b):u\in[N],\ b\in\{0,1\}\}
$$

and a hard target

$$
c_f(u,b)=1\Longleftrightarrow b=f(u),
$$

where $f$ is a PRF, or a random oracle in a relativized version. A
distribution-free strong improper learner with global degree $D$ can be tested
on a level $j>D$ uniform block. It sees too few fibers to predict fresh
values of $f$; under polynomial-time evaluable improper outputs, low error
would give a PRF predictor.

The source-positive side is where the construction breaks. A sampled-fiber
handle can gain only about $m/N$ mass when one call uses $m=s^T$ examples.
For every fixed level $j$, this is an inverse polynomial, so the hidden-gap
geometry is right. But the source must work for every marginal on that same
block, not just the symmetric uniform marginal.

Consider the opposite tiny-bias marginals

$$
P_+(u,f(u))=\frac{1+2\eta}{2N},\qquad
P_+(u,1-f(u))=\frac{1-2\eta}{2N},
$$

with $P_-$ obtained by swapping the two weights. Let
$\eta=\Theta(m/N)$ and choose $N\gg m^2$. Then

$$
\operatorname{TV}(P_+^{\otimes m},P_-^{\otimes m})=O(m\eta)=O(m^2/N)=o(1).
$$

Thus the sample transcript does not reliably reveal which unseen orientation
is better. A deterministic binary hypothesis has no neutral prediction on an
unseen fiber. On each unseen fiber its behavior is one of
$(0,0),(1,1),(1,0),(0,1)$; the first two are constant defaults whose sign is
opposite under $P_+$ and $P_-$, and the last two require correlation with the
hidden bit $f(u)$. For a PRF or random-oracle block, no polynomial-time
deterministic output has useful unseen correlation with $f$ beyond the sampled
fibers. The sampled fibers contribute only $O(m/N)$ mass, exactly the scale
that the wrong unseen orientation can erase.

This is stronger than saying that a particular constants-plus-singletons
algorithm fails. It explains why deterministic hidden-gap witnesses keep
stalling: source positivity demands an orientation-free weak signal for every
near-balanced marginal, while target hardness demands that the same signal not
allow broad prediction of the hidden labels.

Training-time randomness does not obviously repair this. Once the final
hypothesis is deterministic, a random filler has quenched unseen correlation
of typical size about $N^{-1/2}$ under the uniform block. In the target-hard
regime $m\ll \sqrt N$, that fluctuation is larger than the intended
sampled-mass edge $m/N$, with either sign. Fresh prediction-time randomness
would be different: the learner could memorize sampled fibers and flip fair
coins on unseen fibers, making the unseen contribution exactly neutral in
expectation. But that changes the node; the present edge uses deterministic
binary hypotheses.

Public certificates also leak. If a deterministic orientation certificate is
available with enough mass for every marginal, an improper distribution-free
learner can use the same certificate on the isolated hard block. If the
certificate is too rare, an arbitrary marginal avoids it and recreates the
source failure.

### Obstacles

1. Full-support semantics uniformize one-call resources, but not the weak
   advantage.
2. Same-marginal weak accuracy has no component-to-mixture transfer strong
   enough to diagonalize hidden gaps under global marginals.
3. Every validation or boosting wrapper needs polynomial dependence on
   $1/\gamma$, so a hidden exponent remains hidden operationally.
4. The rare-block PRF/oracle template is target-hard, but deterministic
   source learning fails on opposite near-balanced marginals unless it can
   predict unseen hidden labels or access a certificate that would also help
   the target.

### Depth 4 Directions

1. Formalize the opposite-bias no-go as a reusable lemma for deterministic
   binary outputs: for $N\gg m^2$ and $\eta=\Theta(m/N)$, no pathwise
   $m$-sample learner based on sampled fibers and polynomial-time unseen
   evaluators is weak on both $P_+$ and $P_-$ for a PRF/random-oracle block.
2. Search for a deterministic orientation-free handle whose weak edge is
   pointwise neutral on arbitrary unseen mass, not merely neutral under a
   symmetric block marginal. This is the missing source-positive ingredient
   for a false witness.
3. State a conditional true atlas lemma with an explicit booster-local
   envelope: if all induced marginals $Q$ generated before accuracy
   $\varepsilon$ satisfy $\gamma_Q(s)\ge 1/\operatorname{poly}(s,1/\varepsilon)$
   after full-support resource uniformization, then the assigned edge is true
   by standard realizable boosting.

### Conclusion

I would leave the atlas edge open. The current semantics do not imply the
weak-gap uniformization needed for a true proof, and the best hidden-gap
counterexample still lacks a deterministic source-positive learner for
arbitrary same-block marginals. The branch does sharpen the exact missing
ingredient: either a genuine global or booster-local weak-gap envelope, or a
new deterministic orientation-free weak handle that does not leak to the
improper strong target.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md

## Depth 4 Branch A: Orientation Correlation Bottleneck

### Goal

Depth 3 left a precise fork. The negative route needs a proper
marginal-nonuniform weak learner that survives arbitrary marginals on a rare
hard block. The positive route would need the opposite-bias obstruction to
force a distribution-free inverse-polynomial weak gap. I tried to turn the
obstruction into either object.

The conclusion is still negative for both routes: the obstruction is real, but
it only says that a deterministic weak learner must obtain genuine orientation
correlation with the hidden labels. It does not lower-bound that correlation by
one uniform inverse polynomial.

### Local Decomposition

Work on a paired block

$$
B=\{(u,b):u\in[N],\ b\in\{0,1\}\},
\qquad
c_f(u,b)=1\Longleftrightarrow b=f(u).
$$

For a deterministic hypothesis $h$, fix an unseen fiber $u$ and write

$$
r=h(u,f(u)),\qquad t=h(u,1-f(u)).
$$

Let the positive and negative target atoms in this fiber have total mass
$w_u$ and signed imbalance $\sigma_u=P(u,f(u))-P(u,1-f(u))$. The fiber's
contribution to weak advantage is

$$
\frac{w_u}{2}(r-t)+\frac{\sigma_u}{2}(r+t-1).
$$

The first term is true orientation correlation with the hidden bit $f(u)$:
it is positive only when $h$ behaves like $c_f$ on the fiber. The second term
is a constant-default term: all-one and all-zero defaults get opposite signs,
and the sign flips when $P_+$ and $P_-$ swap the tiny imbalance.

Thus opposite near-balanced marginals eliminate every deterministic default
strategy. If the transcript distributions under $P_+$ and $P_-$ are
statistically close, the learner cannot reliably choose opposite constants.
To be weak on both marginals, it must either use sampled fibers or have
orientation correlation on many unseen fibers.

### Why This Does Not Give A False Witness

For the rare-block PRF or random-oracle template, sampled fibers carry only
about $m/N$ mass when a pathwise-uniformized weak call uses $m$ examples. Set
the imbalance scale $\eta$ comparable to $m/N$ and take $N\gg m^2$. Then
$P_+^m$ and $P_-^m$ have total variation $o(1)$, while the wrong default term
has exactly the scale needed to erase the sampled-fiber gain.

The only deterministic escape is therefore unseen orientation correlation.
But in a PRF/random-oracle block, a polynomial-time proper output cannot have
non-negligible unseen correlation with $f$ beyond the observed fibers. So this
block is target-hard, but it is also source-negative. The opposite-bias fork
does not merely defeat a particular sparse-handle learner; it defeats any
deterministic binary learner whose only source of advantage is sampled mass
plus public defaults.

This also explains why the tempting deterministic repairs leak. A public
orientation certificate gives the needed unseen correlation, but then an
improper distribution-free learner challenged on the isolated block can use the
same certificate. A fixed hash, tie-breaker, or training-time random table is
just a deterministic unseen orientation after the transcript is fixed; an
arbitrary marginal can concentrate on the side where it is wrong, or use the
opposite tiny imbalance to cancel the default gain.

### Why This Does Not Give A True Proof

The same decomposition is too local to prove weak-gap uniformization. It says:
for this paired gadget, any deterministic source-positive learner must obtain
orientation correlation. It does not say that the correlation is bounded below
by $s^{-K}$ for one global $K$.

A source-positive class could, in principle, have a proper orientation handle
whose correlation on level $j$ is exactly $s^{-j}$. For each fixed marginal on
that level this is a legal inverse-polynomial weak edge, but the exponents are
unbounded across levels. The opposite-bias test would certify that the handle
is a real orientation handle rather than a default trick; it would not promote
$s^{-j}$ to $s^{-K}$.

Nor can we diagonalize these bad levels into one current-semantics marginal.
Putting level $j$ into a global mixture with weight $w_j$ lets the weak learner
earn its aggregate edge on other levels and ignore the bad slice. The
orientation decomposition is pointwise within a slice; it has no mechanism for
preventing this mixture dilution. A positive theorem would need an additional
modulus, such as size-indexed full-mass marginals or a booster-local
bounded-density weak-gap envelope.

### Exact Missing Structure For Depth 5

The next branch should not look for another constants-plus-sampled-handles
rare block. That family is blocked. The missing source-positive, target-negative
structure would have to satisfy all of the following at once:

1. **Deterministic orientation handle.** For every marginal, including
   opposite near-balanced marginals, the proper learner must produce genuine
   orientation correlation with the target on unsampled or sampled mass. A
   default, public tie-breaker, or fixed random table is not enough.
2. **Hidden, nonuniform gap.** The correlation should be inverse-polynomial for
   each fixed marginal but with unbounded exponents across levels, so no
   distribution-free weak-gap envelope is available.
3. **Anti-leakage to strong improper learning.** The handle must not be a public
   certificate or efficiently repeatable source of independent weak predictors;
   otherwise an improper learner can aggregate it on the isolated hard block.

Equivalently, a true proof needs one of the missing uniformity principles that
rules out item 2: a global weak-gap envelope, a booster-local bounded-density
envelope, or a size-indexed full-mass marginal semantics where bad levels cannot
be hidden by mixture weights.

### Conclusion

The deterministic hidden-gap fork is sharper now. A proper per-marginal weak
learner cannot avoid the opposite near-balanced obstruction by deterministic
neutrality; binary deterministic neutrality does not exist at the fiber level.
It must use real orientation correlation. But that fact alone does not imply a
positive uniform weak-gap theorem, because the required correlation may still
decay with an unbounded level-dependent exponent and global mixtures can dilute
the bad levels.

I would keep the atlas edge open. The depth-5 target is a deterministic
orientation-handle construction with hidden nonuniform gaps and anti-leakage,
or a proof of an added local-uniformity principle that rules such handles out.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md

## Depth 5 Branch A: Orientation Handle Tradeoff

### Goal

Depth 4 isolated the deterministic bottleneck: on paired hard blocks, sampled
corrections and constants do not suffice under opposite near-balanced
marginals. This branch asks whether that bottleneck can be made decisive in
either direction.

The answer is still no, but the obstruction is sharper. The bottleneck rules
out default-based rare-block witnesses. A deterministic witness must supply a
fiber-balanced orientation predictor. Once written that way, however, the
orientation part is just another weak learner for the hidden hard class. That
either leaks to an improper learner at the same hidden gap scale, or it assumes
the very marginal-nonuniform weak-gap separation we are trying to build.

### Tilted-Pair Test

Use $\{\pm 1\}$ labels and fix a base marginal $\mu$ on a paired block with
balanced mass inside each fiber. For a clean target $c_f$, define opposite
label tilts by

$$
dP_\alpha^\pm(x)\propto (1\pm \alpha c_f(x))\,d\mu(x).
$$

For any deterministic hypothesis $h$, its correlation under these tilts
decomposes as

$$
\mathbb E_{P_\alpha^\pm}[c_fh]
=
\mathbb E_\mu[c_fh]\pm \alpha \mathbb E_\mu h
+O(\alpha^2).
$$

The term $\mathbb E_\mu[c_fh]$ is real orientation correlation. The term
$\mathbb E_\mu h$ is the default-orientation term. It has opposite signs under
$P_\alpha^+$ and $P_\alpha^-$.

If an $m$-sample learner relies on the default term, then it must choose
opposite signs under $P_\alpha^+$ and $P_\alpha^-$. For
$m\alpha\ll 1$, the transcript laws have small total variation, so this sign
choice cannot succeed with high probability on both tilts. Thus a
deterministic source learner that works on all such marginals must, on at
least one coupled transcript family, produce hypotheses with genuine
$\mu$-orientation correlation.

This is the strongest positive information I can extract from the bottleneck.
It is qualitative or hidden-scale quantitative. The lower bound it gives is at
the source's own hidden margins for the tilted distributions; it does not
promote those margins to $s^{-K}$ for one distribution-free $K$.

### Why The Test Still Does Not Uniformize The Gap

To get a uniform weak-gap theorem from the tilted-pair test, one would need to
pick a tilt scale $\alpha$ before knowing the marginal's hidden advantage.
This runs into the same validation barrier in a different form.

If $\alpha$ is a fixed inverse polynomial, then constants already have
advantage about $\alpha$ on the tilted marginals. The source learner can pass
those marginals without revealing any smaller orientation handle that would be
useful on the balanced base marginal.

If $\alpha$ is taken below the hidden advantage, then the test can force real
orientation correlation, but finding such an $\alpha$ costs exactly the
unknown weak-gap scale. Distinguishing the two tilts, validating a candidate
edge, or deciding when to boost still needs on the order of
$\gamma^{-2}$ samples. With $\gamma_P(s)=s^{-k(P)}$ and unbounded $k(P)$, this
only recovers a marginal-dependent polynomial.

The mixture diagonal still fails as before. Bad balanced blocks with genuine
orientation gaps $s^{-j}$ can be assigned weights $w_j$ in one global marginal,
and a weak learner for the mixture can spend its additive advantage on a
high-mass prefix. The tilted-pair calculation is local to a block; it gives no
mechanism forcing the low-mass block to be learned with full local weight.

### Why A False Witness Now Has To Recurse

The deterministic repair for the rare-block witness would be a handle that is
fiber-balanced on unseen mass. On a paired fiber this means the handle must
choose one of the two orientations:

$$
h_g(u,b)=1\Longleftrightarrow b=g(u).
$$

For target $c_f$, its balanced-block advantage is exactly the correlation of
$g$ with $f$ under the induced marginal on fibers. In other words, an
orientation-free deterministic handle is not a neutralizer; it is a weak
predictor for the hidden orientation class $\mathcal F=\{f\}$.

This creates a recursion. To make the paired class source-positive under every
near-balanced marginal, the source learner must weakly learn $\mathcal F$
under every marginal on fibers, with a possibly hidden inverse-polynomial gap.
To make the paired class target-negative, no distribution-free strong improper
learner may learn $\mathcal F$ on the isolated hard levels. That is essentially
the same weak-gap uniformization problem, stripped of the paired-block
language.

Cryptographic choices for $\mathcal F$ do not solve the recursion. A PRF or
random-oracle orientation class blocks strong improper prediction, but it also
blocks the source from producing the required $g$ on an isolated balanced
marginal. Public or efficiently enumerable orientation families go the other
way: they make source positivity plausible, but an improper learner can run the
same weak-orientation procedure and aggregate the handles whenever a uniform
gap is available. The only remaining anti-leakage is quantitative
nonboostability from unbounded hidden exponents, not secrecy of the handle.

So the orientation-correlation bottleneck kills the simple false witness but
does not itself furnish a new one. Any successful false witness must first
construct a base class with real deterministic marginal-nonuniform weak
orientation learning and no distribution-free strong improper learner. That is
not presently known.

### Obstacles For Resolution

1. The tilted-pair test forces real orientation correlation only at the
   hidden weak-gap scale; it does not yield a distribution-free inverse
   polynomial.
2. A fixed tilt scale is defeated by constants, while an adaptive tilt scale
   requires validation at the unknown $\gamma_P$ scale.
3. Fiber-balanced deterministic handles reduce to weak learning an induced
   orientation class. PRF-like orientation classes fail the source; public
   orientation classes leak to the improper target up to the same quantitative
   weak-gap issue.
4. Global mixtures still dilute bad orientation blocks, so the size-indexed
   diagonal proof remains a conditional schema theorem rather than a current
   atlas proof.

### Depth 6 Directions

1. Formalize the reduction from paired fiber-balanced handles to an induced
   orientation class: any deterministic handle that neutralizes the default
   term defines a weak predictor $g$ for the hidden fiber labels. This would
   prevent future branches from treating such handles as a new primitive.
2. Search for a genuinely quantitative, not cryptographic, base witness:
   a class $\mathcal F$ with one uniform pathwise weak learner whose
   distribution-specific gaps are $s^{-j}$ on level $j$, but for which strong
   improper learning provably needs $s^{\Omega(j)}$ weak information. A
   relativized or oracle construction may be the cleanest first target.
3. On the positive side, state the best possible conditional theorem with
   explicit hypotheses: full-support resource uniformization plus either a
   distribution-free weak-gap envelope, a booster-local bounded-density
   envelope, or size-indexed full-mass marginals gives the target by
   realizable boosting.

### Conclusion

I would not mark the atlas edge true or false from this branch. The
orientation-correlation bottleneck is a real no-go for default/sparse-handle
rare blocks, but it does not become a weak-gap uniformization theorem. The
only deterministic way around the bottleneck is to weakly learn the hidden
orientation itself, and that either fails for hard PRF-style blocks or reduces
the false-witness search to the original hidden-gap problem.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md
