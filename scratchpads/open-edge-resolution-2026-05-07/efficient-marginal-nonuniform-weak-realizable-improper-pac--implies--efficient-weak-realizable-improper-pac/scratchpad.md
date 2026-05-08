# Edge: efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac

- date: 2026-05-07
- depth: 1
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-improper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write constraint: scratchpad only; no atlas files, `references.bib`, or legacy LaTeX edited

## Depth 1 Branch A: Hidden Weak-Gap Audit

### Verdict

I do not have an atlas-ready true proof or false witness under the current
deterministic binary improper-output and pathwise finite-transcript semantics.
The edge should remain open for now.

The clean conclusion is negative for the most tempting positive proof:
full-support/pathwise transcript uniformization can make the source learner's
sample use and running time distribution-free, but it does not produce one
distribution-free inverse-polynomial weak gap.

### Setup

Let `A` be the single learner promised by the source. For every marginal `P`,
there are a polynomial `p_P` and an inverse-polynomial weak advantage
`\gamma_P(s)` such that for every realizable target `c`,

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
\qquad
1/\gamma_P(s)\le \operatorname{poly}_P(s).
$$

The target needs one efficient weak learner with a marginal-independent
inverse-polynomial advantage:

$$
\exists K\ \forall P,c,s:
\operatorname{err}_P(h,c)\le \frac12-s^{-K}
$$

up to the usual confidence bookkeeping. Since both endpoints are weak,
realizable, and improper, this edge is exactly the quantifier swap

$$
\forall P\ \exists K(P)
\quad\text{versus}\quad
\exists K\ \forall P.
$$

### What Full Support Does And Does Not Give

The full-support argument works for resources. Choose a full-support reference
marginal `P^star` on finitely encoded instances. Because the source learner is
one uniform algorithm and atlas computational bounds are worst-case/pathwise on
finite sample transcripts, the `P^star` resource polynomial bounds every finite
transcript that can occur under any other marginal. Otherwise the same
transcript would occur with positive probability under `P^star` and violate
the source guarantee there.

This rules out hidden level-dependent runtime tricks. A candidate source
learner cannot spend `n^j` or `n^{2j}` time after seeing a level-`j` block if
`j` is unbounded; a full-support marginal would expose those transcripts. So
any separation must be a pure weak-gap hierarchy, not a marginal-dependent
runtime hierarchy.

Accuracy is different. The source guarantee at `P^star` says nothing about
accuracy under the actual marginal `P`. For that we only get

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
$$

where the inverse-polynomial exponent may depend on `P`. Full support controls
pathwise computation, not the averaged risk gap.

### Why Compactness And Diagonalization Do Not Prove True

A fixed-size finite-game or compactness argument could at best show that the
worst marginal at size `s` has some positive edge. It gives no reason for that
edge to be at least `s^{-O(1)}`. A positive margin could decay like
`s^{-log s}` or `2^{-s}` without contradicting the pointwise source statement.

The usual diagonal stitch also fails under the current global-marginal
semantics. If bad marginals `P_j` have gaps around `s^{-j}`, stitching them
into one global marginal

$$
P=\sum_j w_jP_j
$$

dilutes each bad component by `w_j`. Weak error is additive under the mixture:
a learner can ignore a sufficiently low-mass bad component and still beat
random guessing globally by using the complement. This is why a
size-conditioned marginal semantics would be much stronger, but it is not the
current atlas convention.

Validation cannot close the gap either. Certifying or orienting a weak edge
`\eta` costs `\Omega(\eta^{-2})` labeled examples. A distribution-free wrapper
with budget `s^B` can only reliably detect edges down to about `s^{-B/2}`.
If the source edge for a marginal is `s^{-K(P)}` with `K(P)` larger than this,
validation, model selection, and boosting all inherit the hidden exponent.

### Counterexample Template And The Deterministic Blocker

The natural false template is a paired rare-block PRF or random-label
hierarchy. For each level `j`, use a block

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

and an active concept

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

with zero labels off the active block. On the uniform paired block, constants
have exactly error `1/2`, while memorizing sampled labels gives advantage on
the order of the sampled mass, about `m/n^j`. Thus every fixed level has an
inverse-polynomial weak handle, but no fixed distribution-free exponent can
dominate all levels.

The target-hard side is plausible under secure PRFs and efficiently evaluable
improper outputs. If a distribution-free weak learner with sample/runtime
degree `D` and advantage `n^{-a}` existed, choose a constant level
`j>D+a+3` and the uniform marginal on `B_{n,j}`. The learner sees too few of
the `n^j` pair indices. A hypothesis with error `1/2-n^{-a}` would predict
`F_k(u)` on a fresh pair by evaluating its two values on `(n,j,u,0)` and
`(n,j,u,1)`, contradicting the standard PRF-vs-random hybrid. This lower bound
uses deterministic binary improper hypotheses, but it still needs their
printed representations to be polynomial-time evaluable.

The source side is the unresolved part under the pathwise deterministic model.
Constants handle strongly imbalanced marginals. Sparse memorization handles
the exactly balanced uniform block. The hard band is a near-balanced marginal
with

$$
P_+(c^{-1}(1))=\frac12+\eta
\qquad\text{or}\qquad
P_-(c^{-1}(1))=\frac12-\eta,
$$

where `\eta` is larger than the sampled-mass handle but smaller than the
statistical resolution of any fixed pathwise polynomial sample budget. A
deterministic hypothesis must choose an unseen-point orientation. The wrong
orientation has error at least `1/2`, and distinguishing `P_+` from `P_-` at
that scale costs `\Omega(\eta^{-2})` samples.

This is exactly where prediction-time stochastic classifiers would help: they
could memorize seen labels and toss a fair coin on unseen mass, gaining on the
covered mass without choosing an orientation. But the current task keeps
ordinary deterministic binary improper outputs, so that repair is outside the
edge.

Random deterministic defaults do not obviously fix the problem. A random hash
default has quenched correlation fluctuations of order roughly the square root
of the leftover collision mass; on a uniform block this is about `1/\sqrt N`,
which can swamp the sampled-mass advantage `m/N` when `m\ll\sqrt N`. Public
code defaults or handles have the opposite problem: if they are robust and
efficiently findable under arbitrary marginals, the distribution-free improper
target can usually reuse them.

### Current State

I would not update the atlas edge to `true`: no argument turns the
marginal-dependent weak advantages into one inverse-polynomial envelope.

I also would not update it to `false` from this branch. The paired rare-block
construction captures the desired hidden-gap geometry, and under extra model
forks it points toward a conditional counterexample, but I do not have a
source learner that is simultaneously:

- pathwise polynomial under the full-support uniformization convention;
- deterministic binary improper at prediction time;
- weak for every arbitrary marginal; and
- able to avoid level-scale validation or orientation tests.

### Depth-2 Directions

1. Formalize the near-balanced orientation barrier for deterministic improper
   sparse-handle learners. The target lemma should quantify: with pathwise
   sample budget `m=s^B`, block size `N`, and bias
   `m/N \ll \eta \ll 1/\sqrt m`, no deterministic orientation rule succeeds
   with PAC probability on both `P_+` and `P_-`.

2. Search for a genuinely orientation-free deterministic handle. It must gain
   sampled-mass advantage under every marginal without stochastic prediction,
   while not giving the distribution-free improper target the same fixed
   inverse-polynomial handle.

3. Prove a conditional positive theorem under an added weak-gap envelope, for
   example: if one polynomial controls `\gamma_Q` over all marginals reachable
   from a target marginal by a specified validation or boosting wrapper, then
   the edge becomes true. This would identify the exact missing uniformity
   axiom.

VERDICT: unresolved

## Depth 2 Branch A: Tilted Finite Games

- date: 2026-05-07
- branch: weak-gap uniformization through finite games and tilted marginals
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-improper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Goal

This pass tried to decide whether the deterministic improper source itself
forces a distribution-free inverse-polynomial weak gap. I deliberately did not
use properness: the source and target both allow arbitrary efficient binary
hypotheses. The only output restriction used below is that the final predictor
is an ordinary deterministic Boolean function, not a prediction-time randomized
classifier.

After the depth-1 full-support reduction, a source learner `A` has one
pathwise polynomial resource bound. Fix confidence, say `\delta=1/4`, and
write the resulting sample/time budget as

$$
m(s) \le s^B .
$$

Thus the remaining question is whether the high-probability weak advantage of
this one bounded learner can still satisfy only

$$
\forall P\ \exists K(P)\quad \gamma_P(s)\ge s^{-K(P)}
$$

with no finite `K` working for all marginals.

### What A Finite Game Can Prove

For a fixed size slice with finite support and finitely many possible bounded
transcripts, the learner induces a finite statistical game. If the source
guarantee says every marginal in that finite simplex has a strict weak gap,
then compactness can give a positive minimum gap for that fixed finite game.

This is not enough for the atlas target. The minimum can move to harder and
harder finite games as `s` grows, and finite positivity has no reason to be
inverse-polynomial in `s`. The toy envelope

$$
g_j(s)=s^{-j}
$$

already has the relevant quantifier pattern: for every fixed `j` it is
inverse-polynomial, but `\inf_j g_j(s)` is not bounded below by `s^{-O(1)}`.
Finite-game compactness rules out a zero gap inside one already bounded game;
it does not bound the exponent uniformly across the family of games.

The pathwise/full-support argument also cannot change this conclusion. It
controls transcripts and hence resources. Accuracy is evaluated under the
actual marginal. If bad finite games are placed in low-mass components of a
global mixture, a learner can get its required weak edge from the complement
and ignore the bad component. That is why the usual diagonal mixture still
does not force the desired quantifier swap.

### Why Single-Size Hard Marginals Still Matter

A useful false-witness bookkeeping point survived this pass. A target learner
can be refuted by choosing, for each proposed exponent `a`, a marginal
concentrated on one hard size or level. Such a marginal is harmless for the
source's marginal-nonuniform inverse-polynomial syntax: any finite collection
of exceptional sizes can be absorbed into the `P`-dependent polynomial
constant.

So a hidden-gap counterexample is not ruled out just because each hard marginal
is concentrated on one finite block. Full-support resource uniformization only
forbids spending `N` or `N^2` samples on that block when
`N=s^j` and `j` is unbounded. It still permits a fixed-budget learner whose
advantage is the tiny sampled-mass quantity

$$
C \approx \frac{m(s)}{N}.
$$

This is exactly the scale a distribution-free weak learner cannot use when the
level `j` is chosen larger than its fixed polynomial exponent.

### Tilt Test For Deterministic Unseen Behavior

The obstruction is that a fixed-budget sampled-mass handle is not automatically
a valid deterministic weak learner for every marginal. Consider the paired
block again:

$$
B=\{(u,0),(u,1):u\in[N]\},
\qquad
c_f(u,b)=1 \Longleftrightarrow b=f(u).
$$

Let `M=P(c_f^{-1}(1))`. A default-zero memorization hypothesis has advantage

$$
\operatorname{adv}_0
= \frac12-M+S_+,
$$

where `S_+` is the `P`-mass of sampled positive atoms on which the hypothesis
corrects the default. A default-one memorization hypothesis has advantage

$$
\operatorname{adv}_1
= M-\frac12+S_-,
$$

with the analogous sampled negative mass `S_-`.

On the balanced uniform block, `M=1/2` and both defaults gain about
`C=m/N`. But for a tilted marginal with

$$
M=\frac12+\eta,
\qquad
C \ll \eta \ll \frac1{\sqrt m},
$$

the default-zero orientation is worse than random by about `\eta-C`, while
the default-one orientation is weakly good. The opposite tilt
`M=1/2-\eta` reverses the two roles.

The two `m`-sample transcript distributions are statistically close when
`\eta\sqrt m=o(1)`. Hence any deterministic rule that chooses an unseen
orientation from the sample has almost the same choice distribution under the
two tilts. It cannot choose the right orientation with PAC probability on both
tilts. This makes the depth-1 orientation barrier sharper: the problem is not
properness, and it is not failure to validate a candidate after the fact. It is
the need to commit to one deterministic Boolean behavior on unseen mass before
the sample contains enough information to determine the sign of the tilt.

For PRF or random-label paired blocks, arbitrary improper outputs do not
obviously evade this. Conditioned on a polynomial transcript, the labels of
most unseen pairs still look random. Any efficiently evaluable deterministic
hypothesis induces some fixed unseen labeling, and an opposite small tilt can
put slightly more mass on the side where that labeling has the wrong
orientation. Prediction-time stochastic hypotheses would average the two
orientations and keep the sampled-mass gain, but that is outside the current
deterministic PAC node.

### Why This Does Not Prove The Edge True

The tilt argument explains why the best false template keeps failing, but I
do not see a way to turn it into a general weak-gap uniformization theorem.
Three gaps remain.

First, the argument needs a rich paired or self-opposite hard block. A general
class satisfying the source might avoid the exact opposite-tilt structure while
still having marginal-dependent weak gaps for more representation-specific
reasons.

Second, the bad hypotheses under one marginal need not share one common error
region. A positive proof would need to show that if `A` has only a tiny gap
under `P`, then there is one nearby marginal `Q` under which the whole
high-probability output distribution of `A` remains transcript-indistinguishable
but becomes non-weak. The simple tilt against a single returned hypothesis is
not enough, because `A` under `Q` may output another deterministic hypothesis
that works for that tilt.

Third, finite-game positivity is too weak quantitatively. Even if one proves
that every fixed finite tilted game has a positive value, the value may be
`s^{-j}` on the level-`j` game. Without a local bounded-exponent theorem over
marginals, this still does not produce one target exponent.

### Why This Does Not Prove The Edge False

The hidden-gap rare-block route still has a plausible target lower bound. For
each fixed distribution-free learner with sample/time degree `D` and desired
advantage `s^{-a}`, choose a paired block with `N=s^j` for
`j>D+a+O(1)`. Memorization and explicit queries see too little of the block,
and a PRF/random-oracle hybrid should rule out unseen correlation for efficient
improper hypotheses.

The source side is still missing. Constants handle strongly imbalanced
marginals. Memorization gives the right tiny advantage on exactly balanced
blocks. But arbitrary near-balanced tilts with
`m/N \ll \eta \ll 1/\sqrt m` force deterministic orientation at a scale the
source cannot statistically resolve with its pathwise polynomial budget. I do
not have an orientation-free deterministic handle that both fixes this source
problem and remains unavailable to the distribution-free improper target.

### Conditional Statements That Are Clear

If the source is strengthened by one distribution-free weak-gap envelope, the
edge becomes true: full-support uniformization gives one polynomial resource
bound for calls to `A`, and the supplied envelope is already the target weak
gap.

If the semantics were changed to size-indexed marginals that keep full mass on
the selected hard size at every `s`, the diagonal pressure would be much
stronger. That would be a nearby conditional theorem, not the current global
marginal atlas edge.

If prediction-time randomized classifiers were allowed and evaluated by
expected zero-one loss, the paired rare-block construction would look much
closer to a conditional false witness: memorize sampled labels and flip an
independent fair coin on unseen mass. But the present source and target use
deterministic binary hypotheses, so that fork should not be imported here.

### Depth-3 Directions

1. Prove or refute the tilted-output lemma. A useful formal target is: for a
   fixed `m`-sample deterministic learner on a random paired block, if its
   balanced-marginal advantage is only `C`, then one of the two tilts
   `M=1/2\pm\eta` with `C\ll\eta\ll1/\sqrt m` makes it fail with constant
   probability. The lemma should allow arbitrary efficient improper outputs,
   not just constant-default memorization.

2. Try to lift the tilted-output lemma into a positive theorem. The missing
   step is a minimax or stability argument showing that a source learner
   successful on every nearby tilt must already have a polynomially robust
   gap under the original marginal.

3. Continue the false-witness search only if a deterministic neutralizer is
   found. It must gain sampled-mass advantage under all arbitrary tilts without
   stochastic prediction, and it must not amount to a public weak handle that
   the distribution-free target can reuse.

### Current Conclusion

I cannot resolve the edge. The branch strengthens the case that hidden-gap
counterexamples are blocked by deterministic orientation, not by properness or
runtime. It also clarifies why finite games and full-support marginals do not
by themselves force an inverse-polynomial weak-gap envelope. The remaining
open problem is exactly the bridge between these two facts: either a general
tilt-stability theorem proving uniformization, or a deterministic
orientation-free hidden-gap construction proving separation.

VERDICT: unresolved
scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md

## Depth 3 Branch A: Weighted Tilt Neutralizers

### Goal

This branch pushed on the most plausible false route: realize the tilted
finite-game obstruction by an actual represented PAC class, with one
pathwise-polynomial deterministic improper learner whose weak edge may have a
marginal-dependent exponent, but with no distribution-free inverse-polynomial
weak learner.

I still cannot resolve the atlas edge. The branch does make the tilted-game
obstruction more precise: a uniform paired block is too forgiving, because a
deterministic public orientation can be exactly balanced on the uniform block.
The real source-side test is the same paired block under arbitrary weights on
the pairs. Under those weighted tilts, a deterministic learner needs either
true hidden-label prediction on unseen pairs or a pointwise neutral prediction
rule. The latter is exactly what prediction-time randomness would provide, but
ordinary deterministic improper hypotheses do not provide it.

### Paired-Block Decomposition

Fix a paired block

$$
B_N=\{(u,0),(u,1):u\in[N]\},
\qquad
c_f(u,b)=1 \Longleftrightarrow b=f(u).
$$

For a deterministic hypothesis $h$, write $r_+(u)=1$ if $h$ is correct on the
positive atom $(u,f(u))$ and $r_+(u)=-1$ otherwise. Define $r_-(u)$ similarly
on the negative atom $(u,1-f(u))$. For a pair-weight distribution $W$ on
$[N]$, let

$$
E_0(h)=\sum_u W(u)\frac{r_+(u)+r_-(u)}2
$$

be the signed correctness under the balanced-within-pair marginal, and let

$$
\Delta(h)=\sum_u W(u)\frac{r_+(u)-r_-(u)}2
$$

be the orientation-sensitive part. Under the two opposite tilts

$$
P_\eta^\pm(u,f(u))=W(u)(1/2\pm\eta),
\qquad
P_\eta^\pm(u,1-f(u))=W(u)(1/2\mp\eta),
$$

the signed correctness is

$$
E_\pm(h)=E_0(h)\pm 2\eta\Delta(h).
$$

The zero-one weak advantage is $E_\pm(h)/2$. Thus a single deterministic
hypothesis that is weakly good on both opposite tilts must have

$$
E_0(h) > 2\eta |\Delta(h)|.
$$

This is the clean algebraic form of the orientation barrier. A constant
unseen default has $|\Delta|$ close to $1$ on many weighted marginals, so it
must know the sign of the tilt. A hypothesis with $\Delta\approx 0$ avoids the
sign test, but then its balanced advantage comes only from actual pairwise
prediction, sampled atoms, or a carefully balanced public orientation.

### Why Uniform Tilts Are Not Enough

On the uniform pair weights $W(u)=1/N$, a public deterministic default can make
$\Delta=0$ without learning $f$: for example, choose the constant-one
orientation on exactly half the pair indices and the constant-zero orientation
on the other half. Then the opposite label tilts cancel on the uniform block,
and memorizing sampled atoms supplies the tiny balanced edge $m/N$.

So the earlier "tilt" obstruction cannot be stated only for uniform weights on
the pair index. Such a gadget would not refute the source. A source learner
could use an explicit balanced orientation table plus memorization and obtain
the desired $s^{-j}$ edge on the isolated uniform level, while still using only
one pathwise polynomial sample budget $m(s)\le s^B$.

But this does not realize the PAC source, because the source must work for
every marginal on the same represented class. If $W$ concentrates on the half
of pairs where the public table takes the wrong orientation, the same default
has $|\Delta|=1$ again. The two tilted transcript distributions remain close
whenever $\eta\sqrt m=o(1)$, so a deterministic learner cannot reliably choose
between the two signs from samples. If the sampled mass on $W$ is much smaller
than $\eta$, memorization cannot compensate for a wrong orientation.

This is the weighted version of the obstruction. Uniform finite games can hide
the problem by building a neutralizer into the index distribution. Arbitrary
PAC marginals can move their mass onto the neutralizer's bad coordinates.

### What A Source-Positive Tilted Gadget Would Need

A represented false witness based on paired blocks therefore needs one of the
following.

1. **Pointwise deterministic neutrality.** For every pair $u$ and every target
   $f$, the learner's unseen behavior would have to be neutral between the two
   atoms of the pair. Deterministic Boolean hypotheses cannot do this unless
   they actually match both labels on the pair, miss both labels on the pair,
   or use fresh prediction-time randomness. Matching many unseen pairs is
   hidden-label prediction; fresh prediction-time randomness is outside the
   current nodes.

2. **A public family of weighted neutralizers.** Perhaps the class could
   provide many explicit orientation tables so that, for every $W$ and $f$,
   one table has small $|\Delta|$. The source learner would still have to find
   such a table without estimating correlations below the hidden gap scale.
   If the family is polynomially enumerable and evaluable, the distribution-free
   improper target can usually run the same empirical search or validation on
   a polynomial-size subfamily. If the family is too large or hidden, the source
   again lacks a pathwise-polynomial way to identify the right table under
   near-balanced tilts.

3. **True unseen correlation.** The learner may output a hypothesis with
   $E_0(h)$ positive because it predicts $f$ on many unseen weighted pairs.
   This can satisfy the source even under both opposite tilts, but it defeats
   the usual PRF/random-label target lower bound. If this predictor is
   efficiently available under the source, a distribution-free improper learner
   may try to recover it by simulating label-conditioned tilts from its own
   labeled examples.

This trichotomy explains why the tilted rare-block template keeps slipping:
the target lower bound wants $f$ to be computationally unpredictable on unseen
pairs, while the arbitrary-marginal source wants deterministic behavior that
is robust to weighted opposite tilts. Those two requirements are in direct
tension.

### Does Improperness Let The Target Recover The Strategies?

Improperness helps the target in two ways, but neither gives a complete proof
of the edge.

First, if the source's tilted-game success is witnessed by a public or
efficiently searchable set of orientation strategies, the target is allowed to
output their vote, a lookup-augmented rule, or any other efficient Boolean
combination. There is no properness bottleneck. The only remaining cost is
statistical: validating an edge $\alpha$ still costs $\Omega(\alpha^{-2})$
examples. If the only balanced edge left after neutralization is $m/N=s^{-j}$,
this validation cost has the same unbounded exponent as the original hidden
gap.

Second, the target can sometimes manufacture the tilted distributions from
samples of the balanced one. Given labeled examples from a marginal $P$, it can
reject or duplicate examples according to their observed label to simulate a
label-conditioned tilt of size $\eta$. If a source learner must succeed on
both $\eta$ and $-\eta$ tilts while their transcript distributions are close,
there is pressure for its outputs to have positive balanced correlation. This
is the right shape for a positive theorem.

The missing quantitative step is severe. The overlap argument only says that
some outputs are simultaneously good for both tilts, hence have $E_0(h)>0$.
It does not lower-bound $E_0(h)$ by a fixed inverse polynomial. A nearly
perfectly neutral public table plus sampled memorization can make
$E_0(h)\asymp m/N$, which is exactly the nonuniform hidden gap. Thus improper
outputs let the target reuse any robust finite-game strategy that is visible
at polynomial scale, but they do not by themselves turn strict positivity into
a uniform weak-gap exponent.

### Current State

I do not have an atlas-ready `false` witness. The most natural PRF or
random-label paired blocks fail on the source side once arbitrary weighted
tilts are allowed: deterministic unseen behavior must either orient a tiny
bias it cannot statistically see, or predict hidden labels on unseen weighted
pairs.

I also do not have an atlas-ready `true` proof. The weighted-tilt algebra shows
why a large family of hidden-gap finite games is hard to realize, but it does
not prove a global weak-gap uniformization theorem for every represented class
satisfying the source. The remaining logical gap is still quantitative:
finite-game compactness gives positivity, while the distribution-free weak
target needs an inverse-polynomial lower envelope.

### Depth-4 Directions

1. Prove a weighted tilted-pair no-go lemma. A useful statement would be: for
   $m$-sample pathwise-polynomial deterministic learners on paired blocks, if
   $P_\eta^+$ and $P_\eta^-$ are transcript-close and sampled mass under $W$ is
   $o(\eta)$, then success on both tilts forces $\Omega(\eta)$ true pairwise
   correlation on unseen $W$-mass. This would formally rule out PRF/random-label
   tilted blocks as source-positive witnesses.

2. Test the public-neutralizer escape hatch. Construct an explicit family of
   deterministic orientation tables and ask whether, for every weighted
   marginal $W$ and target $f$, a pathwise-polynomial learner can find a table
   with $|\Delta|$ below the sampled-mass scale. Either this gives a genuine
   deterministic orientation-free handle, or it proves that any such handle is
   visible enough for the distribution-free improper target.

3. Try a positive theorem with label-conditioned tilt access: if a source
   learner remains weak on both $\pm s^{-K}$ label tilts for one fixed $K$
   after full-support resource uniformization, can a distribution-free learner
   simulate those tilts and extract a balanced weak hypothesis with
   $s^{-O(K)}$ advantage? The hard part is replacing "positive balanced edge"
   by a polynomial lower bound.

VERDICT: unresolved
scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md

## Depth 4 Branch A: Arbitrary Weights Force True Correlation

### Goal

This branch tried to turn the weighted-tilt obstruction from Depth 3 into an
actual resolution. The test question was:

> Can a deterministic improper learner be weak for every arbitrary PAC marginal
> by hiding its advantage in per-marginal sampled-mass effects, or do arbitrary
> pair weights force a distribution-free inverse-polynomial weak gap?

The conclusion is still not atlas-ready, but the branch narrows the remaining
possibilities. Arbitrary weighted marginals do rule out the most plausible
hidden-gap mechanism: sampled memorization plus any public deterministic
orientation neutralizer. What they do not yet rule out is a class whose
per-marginal weak edge comes from genuine, orientation-neutral correlation with
the target, but with a marginal-dependent exponent.

### Weighted Pairs Give A Local No-Go

Keep the paired block notation from Depth 3. For a deterministic output $h$,

$$
E_\pm(h)=E_0(h)\pm 2\eta\Delta(h),
$$

where $E_0$ is balanced-within-pair signed correctness and $\Delta$ is the
orientation term under pair weights $W$.

Suppose a source learner with pathwise sample budget $m=s^B$ is tested on a
weighted paired marginal whose effective support has size $N_{\mathrm{eff}}$
and whose within-pair tilt is

$$
\frac{m}{N_{\mathrm{eff}}}\ll \eta \ll \frac1{\sqrt m}.
$$

The two opposite tilts are transcript-close, so the learner cannot reliably
infer the sign of $\eta$ from labels. The sampled-pair contribution to $E_0$
is only about $m/N_{\mathrm{eff}}$, too small to pay for a wrong orientation.
Therefore, if the same deterministic output behavior is to be weak on both
tilts with high probability, the output must satisfy one of the following:

1. $\Delta$ is tiny for this specific $W$; or
2. $E_0$ is already $\Omega(\eta|\Delta|)$ from true pairwise prediction on
   unseen $W$-mass.

The first option is not stable under arbitrary weights unless the neutrality is
pointwise. Any fixed public orientation table, or any polynomial-size public
family of such tables selected without seeing enough of $W$, has a large
orientation on some large weighted subset. A PAC marginal may concentrate on
that subset. On that marginal, the learner is back in the hidden-sign band.

Thus arbitrary weights appear to force this local rule:

> A deterministic source-positive paired gadget cannot get its weak edge only
> from sampled mass plus public balancing. On hard weighted tilts it must
> produce actual balanced correlation with the hidden labels on unseen mass.

This is a useful partial no-go for PRF/random-label rare-block separations. The
target lower bound wants hidden labels to be unpredictable on unseen mass, but
the arbitrary-weight source condition demands exactly such prediction whenever
the marginal makes public orientation unsafe.

### Why This Still Does Not Prove The Edge True

The local no-go is not yet a global weak-gap envelope. It rules out one family
of finite-game witnesses, but the atlas edge quantifies over all represented
classes satisfying the source.

The missing step is a common-tilt or minimax statement. To prove the edge true
using the source learner $A$, one would like to argue:

> If, for some marginal $P$ and target $c$, the high-probability edge of $A$ is
> smaller than every fixed inverse polynomial, then there is a nearby marginal
> $Q$ whose sample transcripts are indistinguishable from those under $P$, but
> on which the same high-probability output portfolio has nonpositive edge.

That would contradict the source requirement for $Q$ and yield a uniform lower
bound, plausibly around an inverse polynomial in the pathwise sample budget.

I cannot justify this step. A tilt can easily attack one deterministic
hypothesis, but the learner's output distribution may be a large portfolio of
small-edge deterministic hypotheses with different correct and incorrect
regions. There need not be one low-total-variation reweighting that makes a
constant fraction of that whole portfolio worse than random. If the portfolio
acts like prediction-time randomization after averaging over the learner's
random seed, a per-hypothesis tilt is not enough; one needs a minimax theorem
showing either a common attack or an efficiently reusable aggregate predictor.

Improperness helps with the aggregate-predictor side, but not decisively. The
distribution-free target may output votes, lookup-augmented rules, or other
efficient Boolean combinations of hypotheses returned by $A$. However, turning
many hidden edges of size $s^{-j}$ into one validated weak hypothesis still
costs about $s^{2j}$ samples unless a uniform lower bound is already known.

### Why This Still Does Not Prove The Edge False

The weighted-pair analysis also blocks the cleanest false witness.

A false witness would need a represented class and one deterministic improper
learner such that, for every marginal sequence $P$, the learner has some
$P$-dependent inverse-polynomial edge, while no uniform distribution-free
inverse-polynomial edge exists. The natural way to make the target fail is to
hide labels on level-$j$ blocks of size $s^j$, so any fixed distribution-free
learner has only a sampled-mass edge $s^{-j}$.

But under arbitrary weights, sampled-mass edge is not enough. A marginal can
put its mass on the coordinates where any proposed public neutralizer has the
wrong orientation and then add a tilt in the statistically invisible range
$m/N_{\mathrm{eff}}\ll\eta\ll1/\sqrt m$. To keep the source true on this
marginal, the learner must either detect that invisible tilt or predict the
hidden labels on unseen mass. The former is information-theoretically
unavailable; the latter destroys the standard PRF/random-label target lower
bound.

So the only plausible false route left is no longer a pure
memorization-orientation construction. It would have to exhibit genuine
per-marginal true correlation whose exponent can depend on $P$, and then show
that this correlation cannot be made distribution-free even by an improper
learner. That is essentially a new hidden-correlation separation, not the
paired rare-block template explored so far.

### Current Assessment

Arbitrary weighted PAC marginals do force a strong local stability condition:
deterministic binary outputs cannot be pointwise neutral on unseen pairs. Any
source learner that survives all weighted opposite tilts must get real
balanced correlation on the weighted unseen mass, or expose a public strategy
that the improper target can plausibly reuse.

However, I still do not see a proof that this local stability condition implies
one global inverse-polynomial weak-gap envelope. The obstacle is quantitative
and portfolio-shaped: individual deterministic hypotheses are tilt-attackable,
but a randomized learner may spread hidden positive edges across many
deterministic outputs, and no common attacking marginal or reusable aggregate
has been forced.

### Depth-5 Directions

1. **Common-tilt lemma.** Prove or refute the following finite-game statement.
   Let $\mathcal H$ be the high-probability output portfolio of an $m$-sample
   learner under $(P,c)$, and suppose at least a constant fraction of
   $h\in\mathcal H$ have $0<E_P[r_h]\le \alpha$. If $\alpha\ll 1/m$, must
   there be a marginal $Q$ with $\mathrm{TV}(P,Q)=O(\alpha)$ such that the
   $m$-sample transcript laws remain close but a constant fraction of
   $\mathcal H$ have $E_Q[r_h]\le0$? A yes answer is the missing positive
   theorem; a no answer should exhibit the portfolio geometry a false witness
   needs.

2. **Hidden true-correlation witness.** Stop trying pure public neutralizers.
   Search instead for a class where, for each fixed marginal $P$, there is an
   efficiently findable deterministic predictor with true balanced correlation
   $s^{-K(P)}$, while every distribution-free improper learner lacks any fixed
   exponent. This must avoid reducing to a reusable weak handle visible to the
   target.

3. **Polynomial neutralizer lower bound.** Formalize the weighted-pair no-go
   against polynomially many public orientation tables. For every such family
   and every $m=s^B$, construct pair weights $W_s$ with large effective support
   so that all selected tables have $|\Delta|$ above the sampled-mass scale.
   This would close the current PRF/random-label rare-block route as a
   source-positive candidate.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md

## Depth 5 Branch A: Spike Tilts Resolve The Portfolio Obstruction

### Goal

This branch revisits the common-tilt/minimax obstruction from Depth 4. The
question was whether a randomized training algorithm could spread tiny
positive edges over a large portfolio of deterministic improper outputs so
that no single nearby marginal makes many of them non-weak.

The answer is no for deterministic binary outputs. Arbitrary weighted
marginals do not need a delicate paired-block tilt. A small spike at one point
where many low-edge outputs are wrong is already a common tilt. This gives a
uniform inverse-polynomial weak-gap envelope after the full-support resource
uniformization step.

### Setup

Let $A$ be the source learner. By the full-support transcript argument from
Depth 1, fix a constant confidence parameter, say $\delta_0=1/100$, and obtain
one pathwise sample bound

$$
m(s) \le s^B
$$

for all marginals, targets, and finite transcripts at representation size
$s$. Write hypotheses and labels as $\{\pm1\}$-valued functions and define the
signed edge

$$
e_P(h)=\mathbb E_{x\sim P}[c(x)h(x)].
$$

The zero-one weak advantage is $e_P(h)/2$. The source guarantee says that for
every marginal $P$ and target $c$, with probability at least $1-\delta_0$,

$$
e_P(h)>0
$$

in fact $e_P(h)\ge 2\gamma_P(s)$ for some marginal-dependent inverse
polynomial $\gamma_P$.

I claim that $A$ itself has a distribution-free constant-confidence edge

$$
e_P(h)\ge \frac{1}{125\,m(s)}
$$

up to inessential constants. Thus the hidden exponent cannot occur.

### The Common Spike Lemma

Fix $P,c,s$ and put

$$
\alpha=\frac{1}{1000\,m(s)}.
$$

Suppose, toward contradiction, that

$$
\Pr_{A,P}\left[e_P(h)\ge 8\alpha\right]<\frac23 .
$$

Since the source guarantee gives $\Pr[e_P(h)>0]\ge 99/100$, the low-positive
portfolio

$$
\mathcal B=\{h:0<e_P(h)<8\alpha\}
$$

is output with probability at least $99/100-2/3>0.32$.

For every $h\in\mathcal B$,

$$
P[h(x)\ne c(x)] = \frac{1-e_P(h)}2 > \frac12-4\alpha .
$$

Averaging over $h\in\mathcal B$ and $x\sim P$, there is a point $x^\star$
such that a fraction at least $1/2-4\alpha$ of the portfolio $\mathcal B$ is
wrong at $x^\star$.

Now form the spiked marginal

$$
Q=(1-\varepsilon)P+\varepsilon\delta_{x^\star},
\qquad
\varepsilon=16\alpha .
$$

For any $h\in\mathcal B$ wrong at $x^\star$,

$$
e_Q(h)=(1-\varepsilon)e_P(h)-\varepsilon
<8\alpha-16\alpha<0.
$$

So these outputs are not merely below a desired uniform gap under $Q$; they
are worse than random guessing.

The transcript distributions remain close. Since $A$ uses at most $m(s)$
examples pathwise, coupling each draw from $Q$ as a draw from $P$ except when
the spike is selected gives

$$
\operatorname{TV}(\operatorname{Trans}_P,\operatorname{Trans}_Q)
\le m(s)\varepsilon
=\frac{16}{1000}.
$$

Under $P$, the event "the output lies in $\mathcal B$ and is wrong at
$x^\star$" has probability at least

$$
0.32\left(\frac12-4\alpha\right)>0.15 .
$$

Therefore under $Q$ the same output-failure event has probability at least
$0.15-0.016>0.13$, contradicting the source guarantee for the marginal $Q$ at
confidence $\delta_0=1/100$.

Thus the supposition was false: for every $P,c,s$,

$$
\Pr_{A,P}\left[e_P(h)\ge 8\alpha\right]\ge \frac23 .
$$

Equivalently, $A$ has distribution-free weak advantage at least

$$
\frac{8\alpha}{2}=\frac{1}{250\,m(s)}
$$

with constant success probability. The exact constant is irrelevant; the
important point is the inverse-polynomial envelope $1/\operatorname{poly}(s)$.

### Why Portfolios Cannot Evade The Tilt

This proves the common-tilt statement in the form needed here. A portfolio of
deterministic low-edge outputs cannot behave like prediction-time randomization
against all nearby marginals. Even if its errors are spread across many
regions, averaging over the portfolio finds a point at which a constant
fraction of the low-edge deterministic hypotheses are wrong. Putting only
$\Theta(1/m)$ additional marginal mass on that point is invisible to an
$m$-sample transcript with constant probability, but it flips those hypotheses
from weakly positive to nonpositive edge.

This is exactly where deterministic output matters. A genuinely randomized
prediction-time classifier could assign half-correct behavior at the spike
point in expectation. A deterministic hypothesis cannot: at $x^\star$ it is
either correct or wrong, and a constant fraction of the low-edge portfolio is
wrong somewhere.

The previous paired-block hidden-gap witnesses fail for the same reason. Their
near-neutrality can be maintained under a fixed balanced marginal, but an
arbitrary weighted marginal may spike a point or subset where many proposed
deterministic outputs are wrong. If the spike has mass on the order of
$1/m(s)$, the learner cannot reliably notice it from samples, while the edge
of every low-positive wrong-at-the-spike output becomes nonpositive.

### Turning The Constant-Confidence Learner Into The Target

The base learner is just $A$ run at the fixed confidence $\delta_0$. It has
pathwise polynomial sample and time bounds and outputs, with probability at
least $2/3$, a deterministic improper hypothesis with advantage
$\Omega(1/m(s))$ under every realizable marginal.

For an arbitrary requested confidence $\delta$, use the standard confidence
amplification wrapper: run the base learner independently
$O(\log(1/\delta))$ times, draw a fresh validation sample of size
$O(m(s)^2\log(1/\delta))$, and return a candidate whose empirical error is
below $1/2-\Theta(1/m(s))$. Hoeffding validation preserves a
$\Theta(1/m(s))$ true advantage with probability at least $1-\delta$. The
selected output is still a deterministic improper hypothesis. Under the usual
computational-node convention that returned hypotheses are efficiently
evaluable, all sample and runtime costs are polynomial.

### Atlas-Ready Conclusion

The edge should be updated to `true` with theorem evidence.

Proof sketch for the atlas: full-support transcript uniformization gives one
pathwise polynomial sample/runtime bound $m(s)$ for the marginal-nonuniform
source learner. If the learner failed to have a uniform weak edge
$\Omega(1/m(s))$ under some marginal $P$, then with constant probability it
would output deterministic hypotheses whose signed edge under $P$ lies in
$(0,O(1/m(s)))$. A constant fraction of those low-edge outputs are wrong at
some point $x^\star$. The spiked marginal
$Q=(1-\Theta(1/m(s)))P+\Theta(1/m(s))\delta_{x^\star}$ has $m(s)$-sample
transcripts within constant total variation of those under $P$, but the same
outputs have nonpositive edge under $Q$. This contradicts the source guarantee
for $Q$. Hence the source learner already supplies a distribution-free
inverse-polynomial weak advantage, and standard validation boosts confidence.

VERDICT: resolved-true scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md
