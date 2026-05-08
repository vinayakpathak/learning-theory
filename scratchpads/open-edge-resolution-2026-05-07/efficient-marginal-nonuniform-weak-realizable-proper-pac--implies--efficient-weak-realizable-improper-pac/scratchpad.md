# Edge: efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-weak-realizable-improper-pac

- date: 2026-05-07
- depth: 1
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write constraint: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

## Depth 1 Branch A: Weak-Gap Uniformization Audit

### Setup

The edge note is already focused on the right obstruction. The source gives one
proper learner `A` such that for every marginal `P` there is a
`P`-dependent polynomial resource bound and a `P`-dependent inverse-polynomial
weak advantage:

$$
\operatorname{err}_P(A,c) \le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)^{-1}\le s^{k(P)}
$$

up to ordinary polynomial factors and confidence parameters. The target only
relaxes properness, so an output in `C` is legal as an improper output. The
real question is whether

$$
\forall P\ \exists k(P)
$$

can be converted into

$$
\exists k_0\ \forall P
$$

for the weak advantage, while preserving efficient computation.

### Full-Support Transcript Uniformization

The full-support pathwise argument removes the naive runtime obstruction. Pick
a full-support reference marginal `P^star` on every finitely encoded instance
in each size slice. Since `A` is one uniform algorithm and atlas efficiency is a
worst-case/pathwise finite-transcript bound, the source guarantee at `P^star`
bounds `A` on every finite labeled transcript that could occur under any other
marginal. Otherwise that transcript would occur with positive probability under
`P^star` and violate the `P^star` resource polynomial.

This proves a distribution-free one-call sample/time polynomial for `A`. It
does not transfer accuracy. Accuracy must still be evaluated under the actual
marginal `P`, where the source only gives `gamma_P`. A reference-marginal weak
advantage can be concentrated on easy dust or on components irrelevant to the
target marginal. Thus full support uniformizes transcripts, not weak gaps.

### Compactness And Diagonalization

A fixed-size compactness argument is too weak. Even if, for each representation
size `s`, the best possible worst-marginal advantage of this finite-transcript
learner had a positive minimum `alpha_s`, nothing forces

$$
\alpha_s \ge s^{-O(1)}.
$$

The sequence could decay as `s^{-log s}`, `s^{-s}`, or worse without
contradicting the marginal-by-marginal source statement.

The natural diagonal proof also breaks under the atlas global-marginal
semantics. If no uniform exponent exists, choose bad marginals `P_j` and sizes
`s_j`, then try to stitch them into

$$
P=\sum_j w_j P_j .
$$

For any fixed hypothesis, weak advantage under `P` is a weighted average of the
component advantages. Bad behavior on component `j` only matters at scale
`w_j`; if `w_j` is small, a weak learner can ignore that component and still
beat random guessing globally. To make component `j` force global failure at
gap `s_j^{-K}`, it must carry mass `1-O(s_j^{-K})`, not merely polynomial mass.
Infinitely many disjoint bad components cannot all have almost all the mass.

This explains why a size-indexed or slice-conditioned marginal semantics would
be different. If error at size `s_j` were evaluated after conditioning on the
`j`th slice, a diagonal construction could prove a positive uniformization
theorem. That is not the current atlas semantics.

### Hidden-Gap Counterexamples

Plain PRF classes have the right target-negative flavor but fail the source:
on the hard marginal, a marginal-nonuniform weak learner with any
inverse-polynomial advantage would already distinguish pseudorandom labels from
random labels.

Rare-block sparse-handle templates capture the desired hidden-gap geometry. Put
large blocks of size `N=s^j`; a learner that memorizes or handles only sampled
atoms gets advantage about `m/N`, which is inverse-polynomial for each fixed
level `j` but has unbounded degree. A distribution-free weak learner with fixed
sample/time degree and fixed target exponent can be defeated by taking `j`
larger.

The source side remains the problem. Under arbitrary marginals, deterministic
proper sparse handles face a near-balanced orientation barrier. Take two
marginals on the same hard block with positive label mass

$$
\frac12+\eta
\qquad\text{and}\qquad
\frac12-\eta .
$$

If `eta` is large compared with the sampled correction mass but small compared
with the sampling noise of the fixed pathwise-polynomial sample budget, the
learner cannot reliably choose opposite default orientations. With the wrong
default, the sparse corrections do not even get below error `1/2`.

Paired-block variants improve the uniform-block story but do not remove this
arbitrary-marginal issue. A sampled pair reveals its local orientation, so the
learner can correct sampled pairs without knowing the PRF on unseen pairs. But
outside the sampled pairs the hypothesis still needs a deterministic default or
public rule. An adversarial marginal can bias mass toward points where that
default is slightly better or slightly worse, recreating the same
`1/2 +/- eta` choice. A prediction-time randomized or abstaining default would
neutralize this, but that is not the ordinary deterministic proper PAC model.

Public handles strong enough to avoid orientation tests are also dangerous for
the false direction. If the source can find a deterministic proper handle with
a level-independent correlation under every marginal, then the improper target
can reuse the same handle. If the handle is only local to sampled atoms, the
target lower bound remains plausible, but the arbitrary-marginal source proof
has not been closed.

### Conditional Fragments

The edge would be true under a bounded hidden-exponent assumption: if there is
some `K` such that every marginal's source weak gap is at least `s^{-K}`, then
the source learner itself, with the full-support resource bound, is a
distribution-free weak improper learner.

The edge would also be true under size-conditioned marginal semantics by the
diagonal argument above, or under an added weak-gap envelope principle saying
that all marginals in a specified family have advantages bounded below by one
polynomial. These are extra assumptions, not consequences of the current source
node.

A false result still seems possible through a hidden-gap hierarchy, but it
needs a deterministic proper weak handle that works for every marginal without
gap-scale validation and without becoming a distribution-free improper weak
handle. I do not currently have such a construction.

### Obstacles And Depth-2 Directions

Current obstacles:

- Full-support transcript uniformization gives one pathwise resource
  polynomial, but accuracy remains marginal-specific.
- Compactness can at best give fixed-size positive gaps, not a polynomial
  lower envelope over sizes.
- Diagonal mixtures dilute low-mass bad components in the global weak error.
- Sparse PRF/handle counterexamples still fail the arbitrary-marginal proper
  source because of deterministic orientation.

Promising next branches:

1. Formalize the near-balanced orientation barrier as a reusable lemma for
   deterministic proper sparse-handle witnesses: with sample budget `m`, choose
   block size `N` and bias `eta` so transcript total variation is small while a
   wrong default destroys the weak edge.
2. Search for an orientation-free deterministic proper handle, or prove that
   any such handle reusable under all marginals gives the improper target a
   distribution-free weak learner.
3. Isolate a conditional positive theorem under bounded-density or
   size-conditioned weak-gap envelopes, making explicit exactly which extra
   uniformity axiom would turn the open edge into a theorem.

VERDICT: unresolved

## Depth 2 Branch A: Finite-Game Gap Audit

### Reduced Question

After Depth 1, the resource issue is no longer the interesting one. Let `A`
be the single proper source learner. Applying the source guarantee to a
full-support reference marginal gives one pathwise polynomial bound on all
finite transcripts of `A`. Since the target is improper, every proper output
of `A` is already an admissible target output.

So the edge is reduced to the following hidden-gap question:

$$
\forall P\ \exists k(P)\quad
\operatorname{err}_P(A,c)\le \frac12-s^{-k(P)}
$$

versus

$$
\exists K\ \forall P\quad
\operatorname{err}_P(B,c)\le \frac12-s^{-K}.
$$

The branch asks whether either side can now be forced: a positive theorem by
extracting a uniform finite-transcript margin, or a false witness by building
hidden gaps that survive the arbitrary-marginal proper-source requirement.

### Best Positive Route: Finite Transcript Game

Fix a representation size `s`, confidence `2/3`, and target concept `c`.
Because the resource-uniformized learner has a pathwise polynomial bound, it
has only finitely many possible output strings on bounded finite transcripts
and bounded random strings. Call this finite set `H_s(c)`, allowing dependence
on the labels supplied by `c` in those transcripts.

For a hypothesis `h`, write its signed correlation with `c` under a marginal
`P` as

$$
\rho_P(h,c)=\frac12-\operatorname{err}_P(h,c).
$$

The source guarantee implies that for each `P`, with high probability `A`
outputs some `h` with `\rho_P(h,c)>0`, indeed at least `s^{-k(P)}`. Ignoring
the probability bookkeeping, this suggests the finite game value

$$
\alpha_{s,c}=\inf_P\max_{h\in H_s(c)}\rho_P(h,c).
$$

On a finite instance slice, if every marginal has a strictly positive best
output, compactness gives `\alpha_{s,c}>0`. Equivalently, minimax gives a
target-dependent randomized vote over `H_s(c)` with positive pointwise margin.
This is the cleanest possible positive normal form: the source prevents every
marginal from being completely uncorrelated with all finite-transcript
outputs.

But this still falls short of the atlas target in three ways.

First, `\alpha_{s,c}` can be positive but far below inverse-polynomial. It is
a separation margin of a finite linear game. The source definition gives no
bit-complexity, finite-precision, conditioning, or margin-separation
assumption that would imply

$$
\alpha_{s,c}\ge s^{-O(1)}.
$$

The value could decay like `s^{-log s}`, `2^{-s}`, or worse. On countable
slices, the situation is even less compact: probability mass can escape to
regions where the currently reachable outputs have smaller and smaller edge.

Second, the finite game is target-specific and not algorithmically available
to a PAC learner. The set `H_s(c)` is defined using all possible transcripts
labeled by the unknown target `c`. Solving the game would amount to knowing
or enumerating target-labeled behavior far beyond the random sample.

Third, even a positive value for each fixed size does not diagonalize into a
global marginal contradiction. If `\alpha_{s,c}` is super-polynomially small
along a size sequence, stitching the near-minimizing marginals into one
distribution dilutes the bad components. Weak error is averaged under the
global marginal, so a component that does not carry almost all the mass can be
ignored while still achieving a global weak edge from the complement.

Thus the finite-game route identifies exactly what a positive proof would
need: an inverse-polynomial lower bound on these target-specific margins, or
an efficient way to construct a weak vote without solving the hidden game.
Neither follows from the current source node.

### Validation And Adaptation Do Not Close The Gap

A wrapper around `A` can handle any fixed hidden-exponent budget. If we choose
a search depth `D`, run `A` several times, and validate candidate hypotheses
at thresholds down to `s^{-D}`, standard concentration gives a certified
output with edge `\Omega(s^{-D})` for every marginal whose hidden source
exponent satisfies `k(P)\le D`. The validation cost is polynomial of degree
`O(D)`.

This is a real conditional lemma, but it is not the target implication.
Reliable validation at edge `\eta` requires `\Omega(\eta^{-2})` fresh labeled
examples. The same lower bound applies to orientation tests distinguishing
error `1/2-\eta` from `1/2+\eta`. Any distribution-free wrapper with total
budget `s^B` therefore has an effective resolution floor around `s^{-B/2}`.
If a marginal only promises edge `s^{-k(P)}` with `k(P)>B/2`, the wrapper
cannot safely certify, orient, or amplify that edge.

Repeated runs do not by themselves create a larger edge. The source may
return the same weak handle, or handles with perfectly correlated error sets,
on every successful run. Boosting or majority voting only avoids this with
extra diversity assumptions not present in the definition. Choosing `B` after
seeing `P` is exactly marginal-nonuniformity; the target needs one `B` and one
weak exponent for all marginals.

### Best False Route: Hidden Deterministic Handles

The false direction still wants a hierarchy of hard marginals `P_j` where the
best efficiently findable edge is about `s^{-j}`. A distribution-free weak
learner with fixed exponent can then be attacked at a level `j` beyond its
budget. The source learner would remain valid because, for each fixed
`P_j`, the edge is still inverse-polynomial with a `P_j`-dependent degree.

Rare PRF blocks, paired blocks, and public-code variants all realize this
geometry under a friendly designed marginal. A learner can patch sampled
labels or use a public handle and get edge about sampled mass, while an
improper learner cannot predict the pseudorandom residual well enough to get
a fixed inverse-polynomial edge.

The source side remains the blocker. It must work under every marginal, not
only the designed hard marginal. Constants solve strongly imbalanced
marginals, and sparse patches solve marginals with heavy atoms. The hard band
is the near-balanced, atomless regime where the correct deterministic default
or handle orientation changes across two close marginals:

$$
P_+(c^{-1}(1))=\frac12+\eta,
\qquad
P_-(c^{-1}(1))=\frac12-\eta.
$$

When `\eta` is the hidden handle scale, short transcript laws under `P_+` and
`P_-` are statistically close. A proper learner that chooses the wrong
orientation has error at least `1/2`, not merely a smaller weak edge. Choosing
the orientation reliably costs `\Omega(\eta^{-2})` samples, which is
incompatible with unbounded hidden exponents after full-support pathwise
resource uniformization.

Hadamard or parity-style defaults are the most tempting orientation-free
repair: under the uniform marginal, a wrong codeword can be exactly
orthogonal to the target, so sampled patches create a deterministic analogue
of guessing on unseen points. But the protection is marginal-specific. An
arbitrary marginal can concentrate on coordinates where the default is
negatively correlated with the target. If the code structure is learnable,
the improper target can exploit it; if it is hidden by PRF-style hardness, the
proper source has no evident way to choose the right handle for all marginals.

This gives a useful negative audit of current counterexample templates:
either the handle is public and robust enough that the improper target can use
it, or the handle is local/hidden enough that the proper source must validate
or orient it at the hidden gap scale.

### What Would Resolve The Edge

I do not see an atlas-ready proof or counterexample.

A true resolution would need a new weak-gap uniformization theorem, probably
one of the following stronger statements:

1. a finite-output margin theorem proving `\alpha_{s,c}\ge s^{-O(1)}` from
   the source assumptions;
2. a bounded-density or finite-precision principle preventing arbitrary
   marginals from creating super-polynomially small cancellations;
3. a changed size-conditioned semantics where diagonalizing bad slices is
   legitimate because error is evaluated inside the relevant size slice.

A false resolution needs a source-positive hidden-gap class with a genuinely
deterministic proper handle:

1. for every marginal and target, the source can find a proper hypothesis with
   positive inverse-polynomial edge, possibly with a marginal-dependent
   exponent;
2. finding any fixed inverse-polynomial improper edge under the designed hard
   marginals remains computationally or information-theoretically impossible;
3. the proper source does not choose between opposite near-balanced
   orientations by validation at the hidden scale.

The third item is the sharpest obstacle. It rules out the obvious sparse
patch/default constructions and is not solved by full support, because full
support uniformizes only pathwise resource use, not averaged weak
correlation.

### Depth 3 Directions

1. Formalize the finite-transcript game `\alpha_{s,c}` for the
   resource-uniformized learner. Either prove an inverse-polynomial lower
   envelope under some explicit extra assumption, or construct a toy finite
   game where all marginal-specific gaps are positive but the value is
   super-polynomially small.

2. Prove the near-balanced orientation barrier as a reusable lemma: any
   deterministic proper sparse-handle learner whose correct default flips
   between `P_+` and `P_-` needs `\Omega(\eta^{-2})` samples when the two
   transcript laws differ only at bias scale `\eta`.

3. Search for an orientation-free deterministic handle in an oracle model
   first. The handle must be source-findable under every marginal but not
   reusable by an improper target at any fixed inverse-polynomial scale; if
   even the oracle version leaks, the false route is likely dead.

VERDICT: unresolved | scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md

## Depth 3 Branch A: Finite-Cover Margins

### Goal

This branch gives the finite-game route its sharpest form. Depth 2 already
identified the right reduced question: after full-support transcript
uniformization, the source learner has one pathwise polynomial sample/time
bound, and the target is improper, so proper outputs are admissible. The only
missing datum is one inverse-polynomial weak edge independent of the marginal.

The question here is whether the finite family of hypotheses reachable by the
source learner at a fixed size forces such a polynomial edge, perhaps through
minimax or a finite-cover argument. I do not think it does. The finite game
does force a positive margin at each fixed size under strong compactness
hypotheses, but that margin can be exponentially or otherwise
super-polynomially small. This blocks the positive proof. It also sketches the
right shape of a hidden-gap witness, but not yet an atlas-ready false edge.

### The Finite Game Normal Form

Fix a representation size $s$, a target concept $c$, and a confidence level.
Let $H_s(c)$ be the finite set of proper hypotheses that the resource-
uniformized source learner can output on all bounded transcripts labeled by
$c$ and all bounded random strings. For $h\in H_s(c)$ write

$$
a_h(x)=
\begin{cases}
1 & h(x)=c(x),\\
-1 & h(x)\ne c(x).
\end{cases}
$$

If the relevant size slice $X_s$ is finite, define

$$
\alpha_{s,c}=\inf_{P\in\Delta(X_s)}
    \max_{h\in H_s(c)} \mathbf E_{x\sim P} a_h(x).
$$

The optimistic finite-cover argument is:

1. The source says every marginal has some reachable output with positive
   correlation.
2. Since $\Delta(X_s)$ is compact and $H_s(c)$ is finite, the continuous
   function $P\mapsto\max_h \mathbf E_P a_h$ has positive minimum
   $\alpha_{s,c}>0$.
3. By minimax,

   $$
   \alpha_{s,c}=
   \max_{q\in\Delta(H_s(c))}
   \min_{x\in X_s} \mathbf E_{h\sim q} a_h(x).
   $$

Thus there is a randomized vote over reachable proper hypotheses with
pointwise margin at least $\alpha_{s,c}$ against $c$. Since the target is
improper, a known efficiently evaluable vote with
$\alpha_{s,c}\ge s^{-O(1)}$ would be more than enough for the target.

This is the strongest positive consequence I can extract from the finite
game. The problem is quantitative and algorithmic: the source gives no reason
for $\alpha_{s,c}$ to be inverse-polynomial, and the vote is defined using
the unknown target-labeled transcript set $H_s(c)$.

### A Toy Game With Positive But Thin Margin

The lack of a polynomial lower bound is not just a proof artifact. There are
elementary finite games in which every marginal has a positive best response,
but the minimax value is exactly super-polynomially small.

Let $X_s$ have $N_s$ points, with $N_s$ odd, and take the target labels to be
all $+1$. For every subset $S\subseteq X_s$ of size $(N_s+1)/2$, include a
hypothesis $h_S$ that predicts $+1$ on $S$ and $-1$ on $X_s\setminus S$.
For a marginal $P$, choose $S$ to be the $(N_s+1)/2$ heaviest points. Then

$$
P(S)\ge \frac{N_s+1}{2N_s}
$$

by averaging, so

$$
\mathbf E_P a_{h_S}=P(S)-P(X_s\setminus S)
    =2P(S)-1\ge \frac1{N_s}.
$$

Conversely, under the uniform marginal every such $S$ has correlation exactly
$1/N_s$. Hence

$$
\alpha_s=\frac1{N_s}.
$$

Choosing $N_s=2^s$ gives a positive finite-game gap at every fixed size but
only an exponentially small envelope. Choosing
$N_s=s^{\log s}$ gives the gentler decay $s^{-\log s}$. Either way, minimax
and finite covers do not by themselves produce the inverse-polynomial edge
required by `efficient-weak-realizable-improper-pac`.

This toy game is also useful because the minimax vote is completely explicit:
a uniformly random slight-majority subset has pointwise expected margin
$1/N_s$. The example therefore rules out a purely convex-geometric proof of
polynomial weak-gap uniformization.

### Why This Is Not Yet A False PAC Witness

The toy game abstracts away the hard part of the assigned edge: the source
learner must efficiently find a proper weak output for every marginal and
target, using one pathwise polynomial resource bound after full-support
uniformization.

If the proper hypotheses $h_S$ are public and target-independent, an improper
target learner can use the same cover. If they are target-relative, meaning
"agree with the unknown $c$ on $S$ and disagree off $S$," then the proper
source must know enough about $c$ to output the representation of $h_S$.
Samples only reveal labels on sampled points. On the uniform marginal, the
available edge is $1/N_s$, so validating, orienting, or selecting the best
slight-majority handle at that scale costs $\Omega(N_s^2)$ samples in the
usual Bernoulli testing lower bound. For $N_s$ super-polynomial in $s$, that
contradicts the pathwise polynomial resource bound.

The same trilemma appears in PRF or hidden-code versions of the toy game:

1. If the handle family is public enough for the source to select without
   hidden-scale validation, the improper target can usually reuse it.
2. If selecting the handle requires learning target-specific hidden
   structure, the source is not positive on arbitrary marginals.
3. If selection is done from labels, the near-balanced cases require
   gap-scale tests, and the hidden exponent returns as a resource exponent.

Thus the slight-majority finite game builds the desired "positive gap but no
polynomial envelope" geometry, but it does not supply the missing
deterministic proper source learner. It is evidence against the positive
minimax proof, not a complete separation.

### Finite Precision Does Not Save The Positive Route

One might hope that the efficient finite-transcript origin of $H_s(c)$ gives
quantitative separation: transcript probabilities and random strings have
only polynomially many bits, so perhaps a strict finite game cannot have a
too-small value.

At best this kind of argument gives exponential-scale lower bounds. A
polynomial-time learner can induce coefficients with denominators
$2^{\operatorname{poly}(s)}$, and finite linear programs with polynomial
bit-complexity can have optima of order $2^{-\operatorname{poly}(s)}$. That is
still far below $s^{-O(1)}$. The slight-majority game realizes the same
phenomenon combinatorially through an exponentially large size slice.

Arbitrary real-valued marginals make the situation no better. They can tune
weighted cancellations with no finite-precision promise. The source statement
only says that after a marginal is fixed, the resulting positive edge is some
inverse polynomial with a degree allowed to depend on that marginal. It does
not impose a uniform conditioning bound on the finite game.

### What Would Be Needed For Resolution

I do not see a valid atlas update to `true` or `false`.

A true proof would need an additional theorem of one of these forms:

1. a finite-output margin theorem proving
   $\alpha_{s,c}\ge s^{-O(1)}$ from the source assumptions;
2. an efficient way to construct a weak vote without enumerating
   $H_s(c)$ or knowing target labels off sample;
3. a stability principle saying that marginal-specific weak gaps cannot
   collapse under polynomially describable reweightings or finite covers.

The slight-majority game shows why item 1 is false as a bare finite-game
claim. Items 2 and 3 would be genuinely new structure, not a consequence of
the current source node.

A false proof would need to implement the slight-majority geometry inside a
concept class. The missing ingredient is now very specific: a deterministic
proper handle family such that, for every marginal, the source can select a
positive hidden-scale handle in fixed pathwise polynomial time, while no
distribution-free improper learner can obtain any fixed inverse-polynomial
edge from the same public structure. Current rare-block, PRF, parity, and
Hadamard templates fail exactly at this handle-selection point.

### Depth 4 Directions

1. Try to formalize the slight-majority game as a local obstruction lemma:
   finite-cover or minimax positivity alone gives no inverse-polynomial
   weak-gap envelope, even with an explicit positive best response for every
   marginal.

2. Search for a PAC implementation of the slight-majority game in an oracle
   model. The oracle should give the source marginal-specific proper handles
   without making a fixed-scale improper handle public; if this leaks even in
   the oracle model, the false route is probably dead.

3. Prove a conditional positive theorem under an explicit finite-game margin
   axiom: if every resource-uniformized game has
   $\alpha_{s,c}\ge s^{-K}$ and the corresponding votes are efficiently
   constructible or sample-implementable, then the edge becomes true. This
   would isolate exactly what the current source definition lacks.

VERDICT: unresolved | scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md

## Depth 4 Branch A: Target-Relative Majority Handles

### Aim

This branch tries to turn the slight-majority finite game from Depth 3 into an
actual represented PAC class. The intended false witness would have blocks
with

$$
N=s^j
$$

points or pairs at representation size $s$. A pathwise-uniform source learner
using $m=s^d$ examples would get only a hidden edge such as $m/N=s^{d-j}$ on
the level-$j$ hard marginal. For each fixed level this is still an
inverse-polynomial edge, with the degree allowed to depend on the marginal.
A distribution-free weak target with claimed edge $s^{-K}$ could then be
attacked by choosing $j\gg K+d$.

The finite-game geometry is exactly right. The missing question is whether the
best-response hypotheses can be represented and found from PAC samples without
making a fixed-scale improper learner available. I still do not see such a
representation. The branch gives a local no-go for the direct lifts of the
slight-majority game, but not a representation-independent impossibility
theorem.

### The Literal Majority Cover Needs Target Labels

In the toy game, for a fixed target $c$ and every subset
$S\subseteq X_s$ of size $(N+1)/2$, the response hypothesis is

$$
h_S^c(x)=
\begin{cases}
c(x) & x\in S,\\
1-c(x) & x\notin S.
\end{cases}
$$

This family has value $1/N$: every marginal has a slight-majority response,
and the uniform marginal makes every response have exactly that edge. But
$h_S^c$ is target-relative. To output its representation, a learner must know
how to compute $c$ on roughly half of the block, including unsampled points.
With $m=s^d\ll N$, PAC samples do not provide those labels.

There are three natural ways to make the representation concrete, and each
breaks the desired separation.

First, make the majority handles public and independent of $c$. Then they no
longer guarantee positive correlation against arbitrary realizable targets.
If a public handle family somehow does guarantee such correlation, the
improper target can use the same public handles; properness gives no
protection because the target allows every proper output.

Second, represent $h_S^c$ by the target seed together with $S$. Then the
source learner must recover enough of the target representation to output the
handle. If this can be done under the hard marginals, the same recovered
representation gives an improper distribution-free learner much more than a
weak edge. If it cannot be done, the source is false on those marginals.

Third, let the source encode only sampled labels and fill the unseen part by a
default rule. This is the sparse-patch construction from the earlier
branches. It gives the hidden $m/N$ edge on carefully balanced marginals, but
it fails under arbitrary near-balanced tilts.

### The Tilt Barrier Kills Sparse Majority Lifts

Write $T=c^{-1}(1)$ and suppose the learner's unsampled behavior is a
deterministic default, with sampled exceptions corrected. Let $S_+$ be the
mass of sampled positive atoms corrected by a default-zero hypothesis, and
let $S_-$ be the analogous sampled negative mass corrected by a default-one
hypothesis. The two default advantages are approximately

$$
A_0=\frac12-P(T)+S_+,
\qquad
A_1=P(T)-\frac12+S_-.
$$

On a diffuse level-$j$ block, $S_+$ and $S_-$ are at most on the order of
$m/N$ with high probability. Since full-support transcript uniformization
fixes $m=s^d$ before the hard level $j$ is chosen, we can take $j$ large and
choose a tilt

$$
\frac{m}{N}\ll \eta\ll \frac1{\sqrt m}.
$$

Now compare two realizable marginals with $P_\pm(T)=1/2\pm\eta$. The sample
transcript laws are too close for $m$ examples to identify the sign of the
tilt with high probability, but the wrong default has advantage at most
$-\eta+O(m/N)<0$. Thus a deterministic proper learner of this sparse-patch
kind fails the source requirement on one of the two marginals. Randomly
choosing an orientation does not meet the high-probability PAC output
requirement, and a deterministic hash default has the same problem after an
adversarial marginal concentrates on its negatively correlated coordinates.

This is a source-side obstruction. It appears before any PRF, PCP, or
one-way-function hardness is used. Adding a hard residual may help refute the
improper target, but it does not repair the need for the source to orient the
proper hypothesis under every marginal.

### Compressed Covers Do Not Yet Escape

A more sophisticated lift would replace all majority subsets by a compressed
set system $\mathcal F_s$ whose members have short descriptions and whose
finite-game value is still super-polynomially small. This avoids the literal
need to name an arbitrary half-block. It does not remove the target-relative
label problem.

For each $F\in\mathcal F_s$, a useful handle must still know whether to agree
or disagree with $c$ on most unsampled points in $F$ and its complement. If
that relation is public and efficiently evaluable, the improper target can
reuse it. If it is hidden in the target representation, the source must learn
that hidden structure from samples. If it is selected or oriented by
validation, the validation cost is $\Omega(\alpha^{-2})$ at edge $\alpha$,
which violates the fixed pathwise polynomial once $\alpha$ is pushed below
every target exponent.

So the finite cover can make the convex margin thin, but it does not by itself
give a PAC learner a legal proper output. The PAC lift needs an additional
deterministic, orientation-free, target-relative handle mechanism. I do not
currently know one that is source-findable under all marginals and not also
usable by the improper target.

### Why This Does Not Prove The Edge True

The failed lifts above also do not prove weak-gap uniformization. The finite
game still rules out a bare minimax proof: pathwise efficiency only bounds the
number and bit-complexity of reachable outputs by something like
$2^{\operatorname{poly}(s)}$, and finite games of that size can have values
as small as $2^{-\operatorname{poly}(s)}$. For a marginal concentrated on one
hard level, such a value can still be called inverse-polynomial with a
marginal-dependent exponent. Global mixtures continue to dilute bad levels,
so the usual diagonal argument does not force a single exponent.

Thus the current state is asymmetric: the slight-majority obstruction is real
as a finite convex game, but every direct represented-PAC implementation I can
make either fails the arbitrary-marginal proper source or leaks a legal weak
handle to the improper target. That is not enough for an atlas status change.

### Depth 5 Directions

1. Prove a formal sparse-patch tilt lemma. Fix a block of size $N=s^j$, a
   deterministic learner with $m=s^d$ samples, and a class whose unsampled
   outputs reduce to finitely many target-independent orientations. Show that
   if $m/N\ll\eta\ll m^{-1/2}$, two tilted realizable marginals force failure
   on at least one tilt.

2. Test compressed majority handles in an oracle model. Give the source an
   oracle that returns target-relative handles, then ask exactly which oracle
   queries an improper learner would also be able to simulate from PAC samples.
   If every source-useful oracle leaks a target-useful weak vote, the false
   route becomes much less plausible.

3. Seek a positive theorem with an explicit extra hypothesis: bounded
   finite-game margin, size-conditioned marginals, low-complexity marginals,
   or a constructible minimax vote. Any one of these would identify the
   missing uniformity assumption cleanly and separate it from the current
   atlas semantics.

VERDICT: unresolved | scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md

## Depth 5 Branch A: Direct-Lift Dichotomy

### Question

Depth 4 left the right local question: can the slight-majority finite game be
made into an atlas-valid represented PAC class? More explicitly, can we build
blocks $X_{s,j}$ with $N=s^j$ and target-relative handles

$$
h_S^c(x)=
\begin{cases}
c(x) & x\in S,\\
1-c(x) & x\notin S,
\end{cases}
$$

so that a marginal-nonuniform proper source learner can output a useful
handle for every marginal, while no distribution-free improper weak learner
gets a fixed inverse-polynomial edge?

I still cannot make this into a false witness. The obstruction is no longer
just that $h_S^c$ mentions the unknown target. The stronger issue is that an
atlas-valid hypothesis representation has only three ways to determine its
off-sample behavior, and each one either fails the source or leaks to the
improper target.

### Direct-Lift Model

Fix a pathwise sample bound $m=s^d$ obtained by full-support resource
uniformization. A direct majority-handle lift has the following shape:

1. A polynomial-time learner sees a transcript $T$ of $m$ labeled examples
   from the target $c$.
2. It outputs a finite string describing a proper concept $h\in\mathcal C$.
3. On a level-$j$ block, the desired edge is of order $m/N=s^{d-j}$ or
   $1/N=s^{-j}$, with $j$ allowed to depend on the marginal but not on the
   pathwise resource exponent.

The output string must be an ordinary represented hypothesis. It cannot mean
"the unknown training target restricted to $S$" unless the string contains
enough information to evaluate that restriction. Thus all off-sample
target-dependence must enter through one of:

- labels explicitly seen in $T$;
- a recovered description, seed, or evaluator for the target $c$;
- public structure in the class representation that is independent of the
  unseen target labels.

This is a local modeling assumption about the direct majority-cover lifts,
not a theorem about every possible concept class. Under this assumption the
finite-game obstruction does not lift.

### Case 1: The Handle Uses Only Transcript Labels

If the output can depend on $c$ only through labels seen in $T$, then its
behavior on the unobserved part of a diffuse block is a deterministic default
or public code, possibly with sampled exceptions. This is exactly the
sparse-patch situation from Depth 4.

Let $T_+=c^{-1}(1)$ inside the block and let

$$
M=P(T_+).
$$

A default-zero patch has advantage

$$
A_0=\frac12-M+S_+,
$$

where $S_+$ is the sampled positive mass corrected by the patch. A default-one
patch has advantage

$$
A_1=M-\frac12+S_-.
$$

On a diffuse level, $S_+$ and $S_-$ are at most on the order of $m/N$ with
high probability. Choose

$$
\frac{m}{N}\ll \eta \ll \frac1{\sqrt m}
$$

and compare two realizable marginals with $M=1/2+\eta$ and $M=1/2-\eta$.
Their $m$-sample transcript laws are close, but the correct unseen
orientation is opposite. Any deterministic rule has almost the same
orientation distribution under both tilts, so with constant probability it
chooses the wrong orientation on one of them. The wrong orientation has
advantage at most $-\eta+O(m/N)<0$.

This kills transcript-only direct lifts. They can realize the hidden sampled
mass on friendly balanced marginals, but they are not source-positive for all
arbitrary marginals.

### Case 2: The Handle Encodes The Target

The literal majority handle can be represented by a pair such as
$(\operatorname{desc}(c),S)$, or by any equivalent seed/evaluator for $c$ plus
the set-system data. That is atlas-valid as a hypothesis string, but now the
source learner must recover the target description from PAC samples.

If it can recover such an evaluator with pathwise polynomial resources under
the hard marginals, then the distribution-free improper target can use the
same recovery procedure and simply output that evaluator, or use it to build
the same majority handles. This is stronger than a weak edge. Properness
does not protect the construction, because the target is improper and may
output every proper hypothesis the source could output.

If the evaluator is supplied by a special target-handle oracle available only
to the source learner, the construction separates oracle interfaces rather
than PAC notions. Once the same oracle is part of the represented learning
problem, the improper target can call it too. If the oracle is not part of the
represented problem, the source learner was using information not available in
PAC samples.

Thus target-encoding repairs either make the source false on hard marginals
or leak a strong improper learner.

### Case 3: The Handle Is Public Or Compressed

A compressed cover tries to avoid naming arbitrary half-blocks. The class
contains a polynomially describable set system $\mathcal F_{s,j}$ or a public
code, and the learner chooses a short handle from it.

If the off-sample predictions of those handles are public and independent of
$c$, then an arbitrary marginal can concentrate on the coordinates where a
chosen public orientation is wrong. To be source-positive for every target and
every marginal, the public family must contain target-relative orientation
information in some form. But then we are back in Case 2: either the target
orientation is recoverable, in which case the improper target can reuse it, or
it is not recoverable from samples, in which case the source cannot output it
under the hard marginals.

If the public family is only selected by empirical validation, the validation
cost is $\Omega(\alpha^{-2})$ at margin $\alpha$. For the intended
$\alpha=s^{-j}$, taking $j$ larger than the pathwise exponent brings back the
same hidden-exponent barrier. This does not produce an atlas source learner.

### What This Settles Locally

This branch gives a local no-go for the direct target-relative majority-cover
lift:

- A literal lift needs off-sample labels and is not PAC-outputtable unless the
  target evaluator has effectively been learned.
- A sampled-label lift avoids off-sample labels but fails the near-balanced
  tilt test.
- A public or compressed lift either fails under adversarial marginals or
  exposes the same handle mechanism to the improper target.

So the finite-game convex obstruction remains real but nonconstructive. It
shows that positive finite-game margins can be as thin as $s^{-j}$, but it
does not by itself give a represented class separating the atlas nodes. The
representation layer is doing essential work: a target-relative majority vote
is not a legal PAC hypothesis until its off-sample target dependence is
accounted for.

### Why This Still Does Not Resolve The Edge

I do not have a representation-independent theorem saying every possible
source-positive hidden-gap class must fall into the three direct-lift cases.
A more exotic class might have deterministic "neutralizers" whose off-sample
behavior is neither a public default nor a recovered target evaluator, yet
still has nonnegative correlation under all arbitrary marginals. I do not know
such a mechanism, and arbitrary marginals make it hard to imagine: any
target-independent deterministic residual can be attacked by concentrating
mass where it disagrees with the target.

On the positive side, the failure of direct false witnesses is still not
weak-gap uniformization. Finite games with values $s^{-j}$ are compatible with
the source quantifiers for each fixed level $j$, and global mixtures dilute
bad levels. To prove the edge true one would still need a theorem showing
that success on all tilted marginals forces one uniform inverse-polynomial
edge, not merely that the sparse-patch construction fails.

### Depth 6 Directions

1. Formalize the direct-lift impossibility lemma. Define a class of handle
   representations whose off-sample behavior factors through transcript
   labels, a recovered target evaluator, and public code. Prove the exact
   dichotomy: transcript/public cases fail the tilt test; recovered-evaluator
   cases give an improper target learner.

2. Build the oracle version cleanly. Let an oracle $O_c(F)$ return an
   evaluator for the target-relative handle on $F$. Prove that if both source
   and target have access to $O_c$, the target leaks; if only the source has
   access, the construction is not an atlas PAC class. Then ask whether any
   ordinary representation can simulate source-only access without also
   simulating target access.

3. Search specifically for deterministic neutralizers outside the direct-lift
   model. The object to find or rule out is a short proper hypothesis family
   whose unseen predictions are not target-independent, not target-evaluator
   encodings, and yet cannot be made negatively correlated by an arbitrary
   marginal.

VERDICT: unresolved | scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md

## Depth 6 Branch A: Neutralizer Stress Test

### Goal

Depth 5 isolated the direct-lift dichotomy. This branch tries to sharpen it
into an actual theorem and, in parallel, tries the most plausible escape:
replace the bad deterministic default by an off-sample neutralizer that is
independent of the unseen target labels. The result is a stronger local no-go
for direct lifts, but still not a representation-independent resolution of the
atlas edge.

The useful conclusion is:

> In the direct-lift model, a deterministic proper source mechanism that works
> for all weighted tilts either encodes the target on the unsampled region, in
> which case the improper target can reuse the same evaluator, or else it can
> be defeated by a diffuse tilted marginal. Random or pseudorandom
> neutralizers avoid this only in expectation; their realized discrepancy is
> too large at the hidden-gap scales needed for a false witness.

This is close to a theorem about direct majority-handle constructions. It is
not yet a theorem about arbitrary represented concept classes.

### Direct-Lift Theorem Under A Factorization Hypothesis

Fix a hard block $X_{s,j}$ of size $N=s^j$ and a pathwise sample bound
$m=s^d$ from full-support resource uniformization. A direct-lift output has a
sampled patch plus an off-sample evaluator. On points not explicitly fixed by
the transcript, assume the output evaluator factors through one of the three
channels from Depth 5:

1. transcript labels and public class data;
2. a recovered evaluator or seed for the target $c$;
3. public compressed code independent of the unseen labels of $c$.

Under this factorization, the dichotomy can be made formal.

In cases 1 and 3, condition on a transcript $\tau$ whose sampled points carry
total mass at most $O(m/N)$ on a diffuse block. The off-sample prediction is
then a fixed public function $b_\tau$; all target dependence outside the
patch is absent. Let

$$
R_\tau(x)=
\begin{cases}
1 & b_\tau(x)=c(x),\\
-1 & b_\tau(x)\ne c(x).
\end{cases}
$$

If there is any off-sample region on which $R_\tau=-1$, arbitrary marginals
can tilt mass toward that region. More quantitatively, choose two diffuse
marginals $P_+$ and $P_-$ with opposite biases across the agreement and
disagreement regions:

$$
\mathbf E_{P_+} R_\tau = 2\eta,\qquad
\mathbf E_{P_-} R_\tau = -2\eta,
$$

with

$$
\frac{m}{N}\ll \eta \ll \frac1{\sqrt m}.
$$

The $m$-sample transcript laws remain close at this tilt scale, so a
deterministic rule has essentially the same off-sample orientation behavior
under both marginals. On one of the two tilts, the public residual contributes
negative correlation of order $\eta$, while the sampled patch contributes only
$O(m/N)$. The output then has nonpositive weak edge with constant probability.

The only way for a public off-sample evaluator to pass every such weighted
tilt is to have

$$
\mathbf E_P R_\tau \ge 0
\quad\text{for every marginal }P
$$

on the unsampled region. Since $P$ is arbitrary, point masses force
$R_\tau(x)=1$ at every off-sample point. In words: a deterministic
all-tilt-safe residual is not neutral; it is the target itself. That moves the
construction into case 2.

In case 2, the output string contains enough information to evaluate $c$ on
the off-sample region, or an equivalent target-relative handle. Then the
improper learner can run the same pathwise-polynomial recovery procedure and
output the recovered evaluator or the same proper handle. Properness does not
hide anything from the target node, because every proper output is also a
legal improper output. Thus case 2 leaks rather than separates.

So the direct-lift theorem is:

**Conditional direct-lift no-go.** For hidden majority-handle constructions
whose off-sample behavior factors through transcript labels, recovered target
evaluators, and public code, no atlas-valid false witness exists. The
transcript/public branches fail the weighted tilt test; the recovered-target
branch gives a distribution-free improper learner at least as strong as the
source mechanism on the hard marginals.

### The Natural Neutralizer Attempt Fails

The best escape from the deterministic default problem is to make the
off-sample behavior target-independent but "neutral" rather than oriented.
For example, output a hypothesis that patches the sampled labels and uses a
fresh balanced hash, codeword, or programmable pseudorandom function on all
unseen points. This avoids off-sample labels and does not obviously leak the
target.

The problem is high-probability correlation. Under the uniform hard marginal,
write the signed correlation of such an output as

$$
\rho = P(\text{sampled distinct points})
      + \sum_{x\notin S} P(x) Z_x,
$$

where the $Z_x$ are the off-sample agreement signs between the fresh
neutralizer and the target. The patch term is about $m/N$. For an actually
random neutralizer on a uniform block,

$$
\operatorname{sd}\left(\sum_{x\notin S} P(x)Z_x\right)\asymp N^{-1/2}.
$$

At the hidden levels needed to refute a fixed target exponent, we take
$N\gg m^2$, so

$$
N^{-1/2}\gg m/N.
$$

The realized off-sample discrepancy swamps the positive sampled-mass edge.
With constant probability the hypothesis has negative correlation, so it is
not a high-confidence PAC weak learner. Pairing the neutralizer with its
complement only helps if the learner can orient the pair. But orientation is
again a Bernoulli test at the hidden scale and costs
$\Omega((m/N)^{-2})$ samples, far beyond the fixed pathwise polynomial.

Weighted marginals make the same obstruction sharper. The fluctuation scale
is controlled by something like $\|P_{\mathrm{unseen}}\|_2$, while the patch
edge is the sampled mass. Heavy atoms are patched, but a diffuse adversarial
tilt can keep $\|P_{\mathrm{unseen}}\|_2$ much larger than the hidden edge.
Thus pseudorandom, balanced, Hadamard, and paired-code neutralizers are not
enough unless their discrepancy is controlled against every marginal. That
level of discrepancy control is equivalent to the pointwise condition above,
which means target evaluation and hence leakage.

### Why This Still Does Not Prove The Edge True

The local theorem depends on the factorization hypothesis. An arbitrary
represented class need not present its off-sample semantics as "public code
plus patches" or "recovered target evaluator" in a syntactically visible way.
A short proper hypothesis might be selected by a global structural relation
inside $\mathcal C$ whose target dependence is neither learned as an evaluator
nor reducible to a public default. I do not know such a deterministic
neutralizer, and arbitrary marginals make it severely constrained, but ruling
it out would require a representation-independent argument.

There is also still no positive weak-gap uniformization theorem. The finite
game from Depth 3 can have value $s^{-j}$ for arbitrarily large fixed $j$,
and the global-mixture diagonal still dilutes bad levels. The weighted-tilt
argument shows that the obvious hidden-gap PAC lifts fail; it does not show
that every source-positive learner has a uniform inverse-polynomial edge.

So Depth 6 narrows the false route substantially: a successful counterexample
cannot be a sparse patch, public compressed majority cover, target-encoding
handle, or randomized neutralizer with ordinary high-probability semantics.
It must use a genuinely representation-level deterministic neutralizer, or
else the edge needs a new positive uniformization idea.

### Obstacles

- The direct-lift no-go is conditional on a factorization of off-sample
  behavior. The atlas node does not impose that factorization on arbitrary
  concept representations.
- The weighted-tilt proof is transcript-local. A global theorem must control
  how the learner's transcript distribution changes when the adversary tilts
  mass toward the current output's disagreement region.
- Randomized neutralizers fail as deterministic proper hypotheses at hidden
  scales, but this is not yet a lower bound against all efficiently samplable
  pseudorandom or algebraic neutralizer families.

### Depth 7 Directions

1. State the factorized direct-lift no-go as a formal lemma with constants:
   define the transcript/public/recovered-evaluator factorization, prove the
   $m/N\ll\eta\ll m^{-1/2}$ two-tilt lower bound, and record it as a
   conditional obstruction rather than an atlas edge resolution.

2. Make one final attempt at a representation-level neutralizer. The target
   object is a short proper hypothesis family with discrepancy
   $o(m/N)$ against every post-sample weighted marginal, while not computing
   the target. If arbitrary point-mass tilts force target computation, write
   that impossibility explicitly.

3. If no neutralizer exists, close the depth-7 investigation with an
   atlas-ready "still open" refinement: the edge is unresolved, but direct
   hidden-gap witnesses fail for the weighted-tilt/leakage reasons above, and
   any future false witness must identify a non-factorized deterministic
   neutralizer.

VERDICT: unresolved | scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md
