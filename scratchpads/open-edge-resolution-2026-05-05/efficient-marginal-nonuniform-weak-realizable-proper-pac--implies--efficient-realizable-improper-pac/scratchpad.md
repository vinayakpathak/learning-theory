# Edge: efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-realizable-improper-pac

- depth: 1
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- target: `efficient-realizable-improper-pac`
- verdict: unresolved-open
- confidence: 0.84
- worker constraint: created this scratchpad only; no atlas files edited

## Context

The current atlas edge is marked `open` with the summary:

```yaml
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
```

That is still a reasonable high-level warning, but it is not the sharp obstruction after the full-support transcript argument. Under the atlas convention that sample use and runtime are worst-case/pathwise bounds on finite encoded transcripts, a single marginal-nonuniform source learner has a distribution-free polynomial bound for one call: apply the source guarantee to a full-support reference marginal.

The remaining issue is the weak gap. The source gives one proper weak learner $A$ such that for every marginal $P$ there is an inverse-polynomial advantage

$$
\gamma_P(s) \ge s^{-k(P)}
$$

and, on realizable labels from $c\in\mathcal C$,

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s).
$$

The target asks for a distribution-free strong improper learner with one polynomial runtime/sample bound independent of $P$ and with arbitrary final error $\varepsilon$.

The source trivially implies the marginal-nonuniform weak improper node, because a proper output is also an improper output. Thus this edge inherits the unresolved weak-gap problem from the sibling

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
  -> efficient-realizable-improper-pac.
```

The additional properness in the source is not itself a barrier for the target: Schapire/Freund-style boosting would output an improper vote, which is allowed here.

## Attempted Resolution

### Boosting Route

Classical realizable boosting would prove the implication if the weak advantages over all booster-generated marginals had one distribution-free inverse-polynomial lower envelope. A sufficient statement would look like

$$
\exists r\ \forall Q\in\mathsf{BoostReach}(P,c,\varepsilon,\delta)
\quad
\gamma_Q(s)\ge 1/r(s,1/\varepsilon,\log(1/\delta)).
$$

The source gives only

$$
\forall Q\ \exists r_Q\quad \gamma_Q(s)\ge 1/r_Q(s).
$$

This is the wrong quantifier order. Standard boosters reweight or filter the original marginal according to previous hypotheses and validation outcomes. The induced marginals may depend on the target concept, the transcript, and the requested accuracy. The source has no bounded-density, KL-stability, compactness, or continuity condition forcing these hidden exponents to have one polynomial envelope.

Full-support marginal uniformization controls the pathwise cost of one weak call, but it does not transfer accuracy or a weak advantage from one marginal to another.

### Same-Marginal Route

Distribution-specific agnostic boosting is attractive because it can keep the instance marginal fixed and alter labels instead. Feldman's result shows this is a real route for agnostic weak oracles, but it does not apply directly here because the source is realizable-only. Relabeling or residual-label calls need not be realizable by any concept in $\mathcal C$.

Even for the stronger weak-agnostic sibling, the atlas source has a fixed additive form `OPT + 1/2 - gamma_P(s)`. Known same-marginal agnostic boosters need a quantitative weak-oracle slack, so the overhead still depends on the hidden $\gamma_P$.

### Diagonal Weak-Gap Uniformization

There is a tempting positive diagonal proof. If no uniform weak-gap exponent existed, choose bad marginals $Q_d$ and sizes $s_d$ where the available gap is below $s_d^{-d}$, then stitch the $Q_d$ into one marginal and contradict the source guarantee for that single marginal.

This would likely work under a stronger size-indexed semantics where a marginal is a family $(P_s)_{s\ge 1}$ and the guarantee at size $s$ is evaluated under $P_s$ without dilution.

I do not think it proves the current atlas edge. Under the current global-marginal reading, a mixture can assign tiny mass to the bad components. A weak learner may ignore sufficiently low-mass components and still beat $1/2$ on the mixture by an inverse-polynomial amount. Strong learning to arbitrary $\varepsilon$ cannot ignore them, but that is exactly the target gap.

## Counterexample Search

### Existing Witnesses Do Not Settle This Edge

The one-way image-coordinate weak-handle class is source-positive but target-positive. Constants and singleton handles give weak proper learning, but the target is improper; an improper learner can memorize observed positive coordinate atoms and predict zero elsewhere.

The PCP active-slice lookup class is not a witness. It is source-negative for weak proper learning: a weak proper learner on the active slice would find a good PCP proof. It is also target-positive improperly because the active slice is polynomial-size and can be learned by lookup/memorization.

Standard PRF classes are target-negative but source-negative. On the hard marginal, no polynomial-time algorithm can even weakly learn with a distribution-free inverse-polynomial advantage. This is why the usual sample-to-computational hardness witness does not apply.

### Rare-Block PRF Candidate

The closest false route I found is a polynomial-domain rare-block PRF construction.

Sketch the intended class under a flexible PRF assumption. For each seed length $n$ and block parameter $k$, let the active block contain $N=n^k$ coordinate pairs $(i,b)$, and let a seed concept mark exactly one atom in each pair positive according to a PRF bit. Add proper weak handles such as constants, singletons, and perhaps finite unions of sampled atoms.

For the marginal $P_{n,k}$ uniform on the active block, a proper handle can get advantage about $1/N=n^{-k}$. Since $P_{n,k}$ is allowed its own marginal-dependent exponent, this is consistent with the source. But a distribution-free strong improper learner with runtime $s^d$ would fail after choosing a fixed $k>d$: with only $s^d\ll n^k$ samples, it sees too few coordinates to predict a PRF on fresh coordinates, and a successful learner would distinguish the PRF from a random labeling.

This candidate captures the desired shape: one weak handle is cheap, but enough handles for low error require a polynomial degree depending on the block.

### Why The Candidate Is Not Atlas-Ready

The source learner must be one uniform algorithm satisfying the atlas pathwise resource convention. By full-support transcript uniformization, one weak call cannot secretly run for $n^k$ steps on block-$k$ transcripts for unbounded $k$.

This creates an orientation/validation problem. Constants solve the target when the positive mass $M$ is noticeably away from $1/2$. Sparse positive handles solve it when $M$ is near or below $1/2$. Sparse negative-complement handles solve the symmetric case when $M$ is near or above $1/2$. But choosing the correct default label when

$$
M = 1/2 \pm \Theta(1/N)
$$

requires estimating a bias at scale $1/N$, which costs about $N^2$ samples by the usual binomial testing barrier. That violates the uniform one-call resource constraint. Randomly sampled finite-union handles help find mass at scale $1/N$, but they do not by themselves give a high-confidence deterministic proper output with the right default for every marginal and every $\delta$.

So the rare-block PRF idea is a serious candidate schema, not a proof. To become a counterexample it needs an orientation-free weak handle, or a way to make the weak source guarantee hold with a uniformly bounded pathwise weak call while still forcing strong improper learning to need block-dependent polynomial degree.

## Proposed Atlas Update

If atlas edits are later allowed, I would keep the edge `open`, but sharpen the explanation away from generic resource nonuniformity and toward weak-gap uniformization.

Suggested frontmatter direction:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
summary: "Open: full-support transcript uniformization controls the resource cost of one weak call, but the source gives only marginal-dependent weak advantages; no known theorem turns those hidden gaps into a distribution-free strong improper learner."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested replacement body sketch:

```markdown
The source specializes to a proper weak realizable learner with marginal-dependent advantage `gamma_P(s)`. A full-support reference marginal gives a distribution-free pathwise polynomial bound for one call to this learner, but it does not uniformize the weak advantage.

Standard Schapire/Freund boosting would prove the target if all booster-generated marginals had one inverse-polynomial weak-gap envelope. The source only gives a separate inverse-polynomial gap for each marginal. Since the boosted vote may be improper, properness of the weak hypotheses is not the obstacle.

Known witnesses do not settle the edge. One-way coordinate weak handles are source-positive but target-positive improperly; PCP active-slice classes fail the weak proper source; standard PRF classes fail the source. Rare-block PRF templates expose the right hidden-gap phenomenon but currently run into orientation and gap-scale validation barriers under the atlas pathwise runtime convention.
```

## Obstacles

1. Weak-gap quantifier swap: `forall Q exists r_Q` does not imply one polynomial envelope over booster-induced marginals.
2. Same-marginal boosting needs agnostic/correlation weak calls, not merely realizable weak PAC calls.
3. The size-indexed diagonal proof would resolve a nearby stronger schema, but current global marginals can dilute bad blocks.
4. Rare-block false witnesses need cheap high-confidence proper weak handles without gap-scale orientation or validation.

## Next Directions

1. Formalize a conditional true theorem under size-indexed marginal semantics and compare it with the current global-marginal atlas convention.
2. Search for an orientation-free rare-block construction: one weak handle should be findable in uniform pathwise time, while strong improper prediction still needs block-dependent polynomial degree.
3. Try a relativized/oracle version of the rare-block PRF schema before looking for a concrete finite representation class.
4. Prove a positive theorem under an explicit weak-gap envelope, for example bounded-density or KL-stable smooth boosting marginals with one original-marginal lower bound on $\gamma_Q$.

## References Checked

Local atlas notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- neighboring scratchpads for the weak-improper and weak-agnostic versions of this target

Primary source pages checked online or through atlas references:

- Schapire 1990, "The Strength of Weak Learnability": https://www.schapire.net/papers/strengthofweak.pdf
- Freund 1995, "Boosting a Weak Learning Algorithm by Majority": https://doi.org/10.1006/inco.1995.1136
- Feldman 2010, "Distribution-Specific Agnostic Boosting": https://arxiv.org/abs/0909.2927
- Hanneke, Moran, and Thiessen 2025, "Marginal-Nonuniform PAC Learnability": https://openreview.net/forum?id=aoVCFtox89
- Kearns and Valiant 1994, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata": https://doi.org/10.1145/174644.174647

## Depth 2 Branch: rare-block weak-gap witness

- depth: 2
- date: 2026-05-05
- branch: rare-block PRF / orientation-free weak handle
- worker constraint: appended only to this scratchpad; no atlas files edited

### Goal

Try to turn the rare-block PRF template into a counterexample to

$$
\text{efficient marginal-nonuniform weak realizable proper PAC}
\Rightarrow
\text{efficient realizable improper PAC}.
$$

The target obstruction is plausible: on a sufficiently large PRF-labeled block,
any fixed-polynomial strong improper learner sees too few labels to predict
fresh coordinates. The question is whether the source can still hold with one
uniform pathwise efficient proper weak learner and only a marginal-dependent
weak gap.

The conclusion of this branch is negative for the current template. Pairing
the block removes the orientation problem for the uniform hard marginal, but
the source must also work for biased marginals on the same block. Those
marginals force a default-orientation decision at a scale below any fixed
polynomial sample budget, unless the learner can already predict many unseen
PRF labels.

### Candidate Under Test

Use paired active blocks

$$
B_{n,j}=\{(n,j,u,b): u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=N=n^j,
$$

with $j$ allowed to grow with the representation size. A keyed target labels
exactly one point in each pair:

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

and labels points outside the active block by $0$. Add proper weak handles
such as the two constants, positive singletons, negative co-singletons, and
finite sample-correction concepts.

On the uniform marginal over $B_{n,j}$, the positive mass is exactly $1/2$.
A positive singleton found from a labeled sample has error
$1/2-\Theta(1/N)$. Thus the block has the desired hidden-gap shape: for each
fixed $j$ this is inverse-polynomial, but no one exponent works uniformly over
all levels $j$.

### Target Hardness Is Not The Bottleneck

Assume a distribution-free strong improper learner has sample and running-time
degree $D$ at constant confidence and constant accuracy, say
$\varepsilon=1/3$. Choose a constant level $j>D+3$ and use the uniform
marginal on $B_{n,j}$. The learner sees at most $s^D\ll N$ pair indices.

For a truly random paired labeling, a fresh unseen pair index $u$ has a label
independent of the transcript. Low error on the PRF-labeled block would let a
polynomial-time reduction evaluate the returned improper hypothesis on
$(n,j,u,0)$ and $(n,j,u,1)$ and predict $F_k(u)$ with nonnegligible
advantage. Under the standard computational-PAC convention that efficient
improper outputs are evaluable, this is the usual PRF distinguishing route.

So the rare-block PRF side can plausibly rule out the strong improper target.
The failure below is source-side.

### Pathwise Source Constraint

Let $A$ be any proposed source learner. By the full-support transcript
argument from depth 1, if $A$ satisfies the marginal-nonuniform source under
the atlas worst-case/pathwise convention, then one call to $A$ has a
distribution-free polynomial pathwise sample bound. Fix constant confidence
and write this bound as

$$
m=m(s)\le s^T.
$$

Therefore the weak source cannot spend $N$, $N^2$, or $n^{\Theta(j)}$ samples
on a high-level block. It has to obtain the level-$j$ weak edge using only
$m$ samples, with $N\gg m^2$ available to the adversarial marginal.

### The Two-Marginal Orientation Test

Fix a high paired block and a PRF seed. Let $p_u=(n,j,u,F_k(u))$ be the
positive atom in pair $u$, and let $q_u=(n,j,u,1-F_k(u))$ be the negative
atom. Consider two realizable marginals on the same target:

$$
P_+(p_u)=\frac{1+2\eta}{2N},\qquad
P_+(q_u)=\frac{1-2\eta}{2N},
$$

and $P_-$ with the two weights swapped. Choose, for example,

$$
\eta = 20m/N,
\qquad\text{with } N\gg m^2.
$$

Under $P_+$, the all-one default has error $1/2-\eta$ and the all-zero
default has error $1/2+\eta$. Under $P_-$ the roles reverse.

Now suppose the learner only has the usual rare-block handles: constants plus
corrections on the atoms or pairs it has actually seen. With $m$ samples, the
total mass of corrected sampled atoms is $O(m/N)$ with high probability. A
wrong default orientation therefore still has error at least

$$
\frac12+\eta-O(m/N)>\frac12.
$$

So, on these two marginals, a successful proper weak learner must choose
opposite default orientations with high probability, unless it has some third
hypothesis that predicts a nontrivial amount of unseen PRF structure.

But the $m$-sample transcript distributions under $P_+$ and $P_-$ are very
close:

$$
\operatorname{TV}(P_+^{\otimes m},P_-^{\otimes m})
\le O(m\eta)=O(m^2/N)=o(1).
$$

Thus no uniformly pathwise $m$-sample procedure can distinguish the two cases
well enough to output the correct orientation with probability, say, $0.9$
for both. Empirical validation has the same problem: resolving a bias of
order $\eta$ costs $\Omega(1/\eta^2)$ samples, which is superpolynomial in
the high-level regime.

This is stronger than "the gap is hard to validate." For at least one of
$P_+$ or $P_-$, the sparse-handle learner outputs a hypothesis with error
above $1/2$ with constant probability, so it fails even the realizable weak
proper source.

### Orientation-Free Repairs Checked

**Paired positive handles.** Correcting both atoms in a sampled pair is
orientation-free on the sampled pair, but the unsampled region still needs a
default. The total corrected mass is at most $O(m/N)$, so the two-marginal
test above still applies when $\eta\gg m/N$.

**Positive singletons plus co-singletons.** Including both orientations in the
proper class does not help the learner choose one. The correct choice flips
between $P_+$ and $P_-$, and the transcript distributions are too close at the
allowed sample budget.

**Public balanced defaults or hashes.** A fixed public default may be
approximately balanced on the uniform PRF marginal, but the source quantifies
over arbitrary marginals. A marginal can concentrate on the pairs where that
default is anti-correlated with the target, making the default worse than
random while leaving only sparse sampled corrections.

**Randomized or abstaining defaults.** A prediction-time fair coin on the
unseen region would be the right orientation-free object: it has baseline
error $1/2$ and gains on the corrected sampled mass. The atlas nodes here use
ordinary binary proper hypotheses with zero-one error. Converting the coin to
a high-confidence deterministic output again requires estimating the hidden
orientation.

**Large public weak handles.** If a handle has distribution-free
inverse-polynomial mass, the strong improper target can use or boost the same
handle. If its mass is level-dependent, the two-marginal test can choose a
bias larger than the total mass of all handles the pathwise learner can find
from $m$ samples.

I do not see a deterministic proper handle that is genuinely orientation-free
for arbitrary marginals while preserving PRF hardness on the uniform block.
The desired handle would have to behave like "correct on a small learned
region and neutral elsewhere" for every marginal. In binary zero-one PAC,
"neutral elsewhere" is not available as a deterministic prediction.

### Consequence For This Edge

The rare-block PRF route still captures the right hidden weak-gap geometry,
but it does not currently resolve the edge.

It does not prove `resolved-false`: the target lower bound is plausible, but
the proposed class has not been shown to satisfy the marginal-nonuniform weak
realizable proper source under uniform pathwise resources. The arbitrary
biased marginals $P_+$ and $P_-$ break the cheap proper source learner.

It also does not prove `resolved-true`: the failure of this witness is not a
weak-gap uniformization theorem. It only says that the leading PRF/sparse-handle
template still lacks the required orientation-free proper weak handle.

verdict: unresolved

confidence: 0.84

concrete next branches if unresolved:

1. Formalize the two-marginal orientation obstruction as a reusable lemma for
   deterministic binary sample-correction handles on paired PRF blocks.
2. Analyze a separate stochastic-hypothesis variant. If prediction-time
   randomized or abstaining weak hypotheses are admitted, the rare-block PRF
   witness may become a genuine false edge for that different schema.
3. Try an oracle "weak shadow" construction: each sample reveals a
   deterministic proper weak shadow that is neutral off its learned region,
   while aggregating enough shadows remains PRF-hard. This needs a proof that
   the shadows do not hand the strong improper target an efficient learner.
4. Return to the positive side under extra assumptions, such as size-indexed
   marginals, bounded-density booster marginals, or an explicit uniform
   lower envelope on weak gaps.

## Depth 3 Branch: strong target hidden-gap synthesis

- depth: 3
- date: 2026-05-05
- branch: adapt sibling depth-6 weak-target synthesis to the strong
  realizable improper target
- worker constraint: appended only to this scratchpad; no atlas files edited

### Goal

The sibling weak-target scratchpad

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
  -> efficient-weak-realizable-improper-pac
```

ended at depth 6 with a clean diagnosis: after full-support transcript
uniformization, the remaining obstruction is not pathwise sample/time
resources or proper-to-improper output. It is the hidden weak-gap quantifier

$$
\forall P\ \exists k(P)
\qquad\text{versus}\qquad
\exists K\ \forall P.
$$

This branch asks whether replacing the weak target by the strong realizable
improper target introduces an additional boosting obstruction, or whether the
strong edge simply inherits the same hidden-gap problem.

### Weak And Strong Targets Are Coupled

For this source, the strong target and the weak improper sibling should move
together, modulo the standard realizable boosting theorem.

If the present edge were true, then the sibling weak-target edge would follow
immediately by running the strong learner with any fixed error parameter, for
example $\varepsilon=1/3$. Strong distribution-free realizable improper
learning is a relaxation-stronger conclusion than weak distribution-free
realizable improper learning.

Conversely, if the sibling weak-target edge were true, then the present edge
would follow by Schapire/Freund-style realizable boosting. The weak learner
obtained from the sibling target is already distribution-free, so the booster
may call it on the reweighted or filtered marginals it generates. Labels are
still realizable by the same target concept $c\in\mathcal C$. The boosted
majority vote is generally improper, but the target allows improper output.
Its running time and sample use are polynomial in the weak learner's resource
bound, $1/\gamma$, $1/\varepsilon$, and $\log(1/\delta)$; with a uniform
weak edge $\gamma(s)\ge s^{-K}$ this is one distribution-free polynomial.

Thus the strong target does not add an independent properization problem.
Once a distribution-free weak improper learner with one inverse-polynomial
edge exists, boosting supplies the strong improper learner.

### What Transfers From The Depth-6 Weak Synthesis

The following depth-6 conclusions transfer unchanged.

First, full-support transcript uniformization controls one-call resources.
Let $A$ be the marginal-nonuniform weak proper source learner. Under the
atlas pathwise finite-transcript convention, applying the source guarantee to
a full-support reference marginal gives one polynomial bound on the sample
use and running time of $A$ over every finite transcript that can occur under
any marginal. This does not transfer accuracy.

Second, proper-to-improper is harmless. A proper weak hypothesis output by
$A$ is a valid weak hypothesis for an improper learner, and a boosted vote of
proper hypotheses is a valid improper strong hypothesis.

Third, bounded hidden exponents would settle the edge positively. If the
source were strengthened to give

$$
\gamma_P(s)\ge s^{-K_0}
$$

for all marginals $P$ with one exponent $K_0$, then full-support resource
uniformization would make $A$ a distribution-free weak proper learner, and
ordinary boosting would prove the strong improper target.

Fourth, validation and exponent search do not remove marginal dependence.
Searching thresholds down to $s^{-D}$ works only for marginals whose hidden
exponent is at most $D$. If $k(P)\gg D$, distinguishing a real edge
$s^{-k(P)}$ from noise or from the wrong orientation costs more than the
fixed-polynomial budget permits.

Fifth, the finite-output margin normal form remains suggestive but
non-algorithmic. For fixed size $s$, target $c$, and resource-uniformized
learner $A$, let $H_s(c)$ be the finite set of proper hypotheses that can
appear as outputs on realizable transcripts labeled by $c$. On a finite
instance slice, the game value

$$
\alpha_s(c)=
\inf_P \max_{h\in H_s(c)}
\mathbf E_{x\sim P}[(-1)^{c(x)}(-1)^{h(x)}]
$$

captures whether some output hypothesis has positive edge against every
marginal. If $\alpha_s(c)$ had an inverse-polynomial lower bound and the
corresponding vote were efficiently constructible from examples, it would
give the weak target and hence the strong target by boosting. In fact, on a
finite slice a positive minimax margin would even suggest an exact pointwise
vote for $c$. But the source assumptions give no inverse-polynomial lower
bound on $\alpha_s(c)$, no conditioning or finite-precision guarantee, and no
efficient way to construct the target-specific vote.

### Direct Boosting From The Source Still Hits The Same Wall

Trying to bypass the weak-target sibling and boost the source learner
directly makes the hidden-gap issue more visible, but not different in kind.

A direct booster would need a statement like

$$
\exists K\ \forall Q\in\mathsf{BoostReach}(P,c,\varepsilon,\delta)
\qquad
\gamma_Q(s)\ge s^{-K},
$$

where $\mathsf{BoostReach}$ denotes the marginals produced by the booster
from the original marginal $P$, the target $c$, and the previous weak
hypotheses. The source gives only

$$
\forall Q\ \exists k(Q)
\qquad
\gamma_Q(s)\ge s^{-k(Q)}.
$$

There is no density-stability, KL-stability, bounded-exponent, or
finite-precision hypothesis that would control the exponents of the
booster-generated marginals. In fact, boosting deliberately concentrates on
regions where previous hypotheses make mistakes; those regions are exactly
where a rare-block or hidden-gap construction would try to bury an arbitrarily
small weak edge.

Same-marginal detours do not repair this for the realizable source. Agnostic
or correlation-style boosting can sometimes keep the instance marginal fixed
by modifying labels or weights, but the present source is realizable-only.
The residual or weighted-label problems created by such a simulation need not
be realizable by a concept in $\mathcal C$. Even if a same-marginal weak
oracle were available, its overhead would still depend quantitatively on the
hidden edge unless an independent uniform lower envelope were proved.

So the strong target adds an adaptive form of the same obstruction: not only
must the original marginal have a uniform weak edge, every marginal that a
booster might need must have one. But because a distribution-free weak target
already quantifies over all marginals, this is exactly the sibling weak-gap
uniformization problem, not a separate boosting mystery.

### Rare-Block PRF Adaptation

The rare-block PRF synthesis also transfers in a one-sided way.

If there were an atlas-ready paired rare-block PRF class satisfying the
proper marginal-nonuniform weak source while refuting the weak improper
target, it would automatically refute the present strong target. Strong
learning implies weak learning, so any valid no-uniform-weak-edge lower bound
is already enough.

The direct strong lower bound is at least as plausible as the weak one. On a
uniform paired block

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=N=n^j,
$$

a learner with sample/time degree $D$ sees only $n^D\ll N$ pair indices after
choosing $j>D+O(1)$. To achieve constant strong error, say
$\varepsilon=1/3$, it must predict labels on many fresh unseen pairs. Under
the standard computational-PAC evaluator convention, evaluating the returned
improper hypothesis on fresh pairs would then distinguish PRF labels from
random labels. This is the same lower-bound mechanism already noted in depth
2, and it is stronger than merely ruling out a fixed weak edge.

But the depth-6 weak-target audit shows why this is still not a counterexample
for the assigned proper-source edge. The hard part is source positivity under
arbitrary marginals. Constants and sample-found singleton handles work on
friendly or highly biased marginals, but near a balanced high-scale block the
learner must choose a deterministic default orientation. For two marginals
$P_+$ and $P_-$ whose positive masses differ by only

$$
\eta \asymp m/N
$$

with $m$ the pathwise sample budget and $N\gg m^2$, the $m$-sample transcript
distributions have total variation $o(1)$, while the correct proper default
orientation flips. A wrong orientation has error above $1/2$ even after
sparse corrections. Thus the proposed source learner fails one of the two
marginals with constant probability.

Adding public handles has the familiar tension. If a handle family is strong
and orientation-free enough to guarantee a source weak edge for every
marginal, then an improper target learner or a booster can often reuse it. If
the handles remain rare enough to preserve PRF hardness, choosing the correct
orientation or validating the edge falls back below the fixed-polynomial
resolution scale. Prediction-time randomized or abstaining defaults would be
a different hypothesis model, not a repair for deterministic binary proper
PAC.

Therefore the strong target does not rescue the rare-block witness. The
target lower bound is easier to believe, but the source-side orientation
barrier is unchanged.

### No Additional Boosting Obstruction

The main conclusion of this branch is that "strong" should not be recorded as
an extra unresolved boosting layer on top of the weak sibling.

If a future branch proves weak-gap uniformization and obtains

$$
\text{efficient-weak-realizable-improper-pac}
$$

from the present source, then the current edge follows by standard boosting.
No further atlas assumption about properness is needed, since the final vote
is allowed to be improper.

If a future branch instead gives a proper-source hidden-gap counterexample to
the weak improper target, then the same class refutes this strong target
a fortiori. A strong learner at fixed accuracy would be a weak learner with a
fixed advantage.

The only caveat is model hygiene for computational lower bounds. PRF-based
strong-target separations need the standard convention that efficient
improper outputs are finite encoded hypotheses with polynomial-time
evaluation on fresh instances. This is not a new boosting obstruction; it is
the same evaluator convention issue that appears in the weak improper
rare-block notes.

### End Verdict

verdict: unresolved-open. The present edge should track the sibling
weak-target edge. Full-support resource uniformization and proper-to-improper
relaxation reduce the source to a hidden weak-gap problem; if that problem is
solved positively, standard realizable boosting gives the strong improper
target. Direct boosting from the marginal-nonuniform source still fails
because the source supplies only marginal-dependent weak exponents over the
booster-generated marginals. The rare-block PRF route remains source-blocked
by deterministic orientation under arbitrary near-balanced marginals.

confidence: 0.90 that there is no additional independent boosting obstruction
once a distribution-free weak improper learner with a uniform inverse-
polynomial edge is available; 0.88 that the atlas status should remain
`open`; 0.82 that any eventual resolution of the sibling weak-target edge
will transfer to this edge by either boosting or monotone strong-to-weak
separation.

next branches:

1. Formalize the coupling lemma: for this source, the edge to
   `efficient-realizable-improper-pac` is equivalent, using standard
   realizable boosting and strong-to-weak relaxation, to the edge to
   `efficient-weak-realizable-improper-pac`.
2. Write a bounded-hidden-exponent positive lemma specialized to the strong
   target: full-support resource uniformization plus
   $\sup_P k(P)<\infty$ plus Schapire/Freund boosting.
3. Continue the false-witness search only on the source side: find
   deterministic orientation-free proper weak handles for arbitrary marginals
   that do not also give a distribution-free improper weak edge.
4. Develop the finite-output margin normal form into a reusable
   non-resolution note: positive finite-slice margins would imply strong
   learning after boosting if they were inverse-polynomial and efficiently
   constructible, but current atlas assumptions give neither.
5. Keep PRF-based strong lower bounds gated on the global efficient-output
   evaluator convention; without that convention, the lower-bound reduction
   cannot reliably query the learned improper hypothesis on fresh pairs.
