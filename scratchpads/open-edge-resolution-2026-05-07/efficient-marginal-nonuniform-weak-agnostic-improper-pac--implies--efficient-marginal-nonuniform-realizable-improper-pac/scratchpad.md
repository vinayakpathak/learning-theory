# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac

- date: 2026-05-07
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-marginal-nonuniform-realizable-improper-pac`
- scratchpad_only: true

## Sources Read

Local atlas material:

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/full-support-marginal-uniformization.md`

Prior exact scratchpad:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

Related prior scratchpads checked for comparison:

- 2026-05-04 and 2026-05-05 scratchpads for `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`

Primary sources checked:

- [Feldman 2010, Distribution-Specific Agnostic Boosting](https://arxiv.org/abs/0909.2927)
- [Ghai and Singh 2025, Sample-Optimal Agnostic Boosting with Unlabeled Data](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha, Hogsgaard, Paudice, Sun 2025, Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384)
- [da Cunha, Hogsgaard, Paudice 2026, Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265)

## Current Atlas State

The edge is currently open in the `marginal-boosting-open` family. That still looks justified.

The source gives one uniform learner `A` such that, for every marginal `P`, there are a marginal-dependent polynomial resource bound and a weak-agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2
$$

with inverse-polynomial gap. For every joint distribution `D` with marginal `P`,

$$
\operatorname{err}_D(A) \le \inf_{c\in C}\operatorname{err}_D(c)+\beta_P(s).
$$

On realizable labels, this immediately gives weak realizable improper learning under `P`. The target asks for arbitrary error `epsilon` under the same original marginal `P`, with one polynomial depending on `P` but not on the target concept or on a boosting transcript.

## Positive Route 1: Standard Realizable Boosting

The trivial subedge to `efficient-marginal-nonuniform-weak-realizable-improper-pac` is true, so the remaining question is the marginal-nonuniform weak-to-strong step.

Classical Schapire/Freund boosting would call the source learner on reweighted or filtered marginals `Q_t`. For every such `Q_t`, the source gives some weak gap `gamma_{Q_t}(s)`, but the target needs a single original-marginal polynomial controlling all gaps encountered before error `epsilon`:

$$
\gamma_{Q_t}(s) \ge 1/r_P(s,1/\epsilon)
$$

for every target, transcript, and round. The source has only the pointwise quantifier pattern

$$
\forall Q\ \exists r_Q.
$$

Full-support marginal uniformization controls pathwise runtime/sample bounds of the fixed learner, but it does not transfer accuracy or weak advantage from one marginal to another. Thus the old obstruction remains a weak-gap envelope, not just a time-bound issue.

## Positive Route 2: Same-Marginal Agnostic Boosting

The source is agnostic, so I rechecked whether recent agnostic boosting avoids reweighted instance marginals.

Use `{\pm 1}` notation and let

$$
\rho^*(D)=\sup_{c\in C}\mathbb E_D[c(X)Y].
$$

The atlas fixed-additive guarantee is equivalent to

$$
\mathbb E_D[h(X)Y]\ge \rho^*(D) - (1-2\gamma_P(s)).
$$

Feldman/Kalai/Ghai-style distribution-specific boosters preserve the instance marginal by relabeling examples, but their oracle condition is a correlation/threshold condition with slack usable at the final accuracy scale. For example, Ghai and Singh's guarantee has excess term proportional to `epsilon_0/gamma`; Feldman's threshold form only gives a positive weak edge when the threshold is above the fixed additive floor. Translating the atlas guarantee gives `epsilon_0` about `1-2 gamma_P(s)`, so the final excess term is constant rather than `epsilon`.

Equivalently, in threshold language, if a relabeled distribution has

$$
\operatorname{OPT}\le 1/2-\alpha,
$$

then the atlas source only implies error at most

$$
1/2-(\alpha-\beta_P(s)).
$$

This is a useful weak oracle only for `alpha > beta_P(s)`. Since `beta_P(s)` may be close to `1/2`, it cannot drive realizable error to arbitrary `epsilon`.

The 2025/2026 da Cunha et al. line is closer. Their weak learner definition asks for

$$
\operatorname{corr}(W)\ge \gamma_0 \sup_{f\in F}\operatorname{corr}(f)-\epsilon_0
$$

with `gamma_0 > epsilon_0`, and their agnostic theorem can use any nontrivial gap. For a fixed marginal `Q`, the atlas source can be written in this form with `(gamma_0, epsilon_0)=(1,1-2 gamma_Q(s))`, so the nontrivial parameter is essentially `theta=gamma_Q(s)`.

This still does not resolve the edge. Their algorithms need one weak parameter and one weak sample parameter for all distributions used by the procedure. In the marginal-nonuniform atlas setting those parameters become `Q`-dependent on the relabeled/reweighted empirical distributions. Without the same original-marginal envelope, the conversion has no `P`-dependent polynomial bound.

There is also a separate computational mismatch for the 2026 improved-runtime theorem: the stated running time has the shape

$$
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$

In the atlas, `m_0` and `1/theta` may themselves be polynomials in the representation size. Putting those quantities in the exponent is not polynomial time in `(s,1/epsilon,log(1/delta))`. So this is a near miss, not a theorem for the current edge.

## Counterexample Route

The sibling weak-realizable edge has a rare-block PRF/singleton-handle candidate. It is not enough for this edge.

A false witness here must satisfy weak agnostic learning for every marginal, not just weak realizable learning. That means it must work on arbitrary noisy labels whenever some concept in `C` has small error. PRF, LPN, random-code, or noisy-parity hard blocks tend to make even weak prediction hard on marginals concentrated on the block, so they violate the source. Singleton or cheap-handle repairs can make weak realizable learning plausible, but for agnostic labels the handle must correlate with the best concept on arbitrary low-noise conditionals. If the handle finder is robust enough to do that under every marginal, an improper strong learner can usually call the same primitive on residual distributions and aggregate it.

Thus the needed false witness is still a "nonboostable weak-handle" class:

1. for every marginal and every low-noise labeling, one weak improper handle is efficiently findable with inverse-polynomial advantage;
2. under one fixed marginal, achieving low realizable error requires many independent handles;
3. finding or aggregating enough handles is computationally hard even for improper output.

I do not know a standard PAC/cryptographic/PCP construction with those three properties. The known proper-output weak-handle witnesses do not refute an improper target, and the rare-block PRF idea does not satisfy the weak-agnostic source.

## Conditional Statements

A positive theorem would follow from either of the following extra hypotheses.

**Transcript envelope.** For every original marginal `P`, every booster-generated marginal `Q_t` before accuracy `epsilon` has

$$
\gamma_{Q_t}(s)\ge 1/r_P(s,1/\epsilon)
$$

for one polynomial `r_P`.

**Size-conditional marginal semantics.** If marginal-nonuniform accuracy were interpreted size-conditionally, the countable diagonal argument from the 2026-05-05 scratchpad could plausibly force such an envelope: super-polynomial deterioration over transcript marginals could be stitched into one bad marginal family. Under the current global-mixture reading, low-mass bad slices can be ignored by a weak learner, so this remains only a conditional route.

## Obstacles

1. Standard boosting changes the instance marginal and needs a weak-gap envelope over the induced marginals.
2. Same-marginal agnostic relabeling has a fixed-additive floor for the atlas source.
3. Recent nontrivial-gap agnostic boosting still needs uniform weak parameters over the distributions it uses, and the currently improved-runtime theorem is not fully polynomial in weak sample/gap parameters.
4. Rare-slice false witnesses must be locally weak-agnostic under isolated marginals; the natural hard-core witnesses fail this.
5. Improper output makes cheap handles hard to use as a separation, because the final learner can aggregate them.

## Promising Follow-Ups

1. Prove or refute the transcript-envelope lemma for one concrete smooth booster.
2. Clarify whether atlas marginal semantics can be made size-conditional; if yes, revisit the diagonal proof as a likely true resolution.
3. Search specifically for nonboostable weak handles under agnostic labels, not merely realizable handles.
4. Watch for a fully polynomial fixed-additive agnostic booster whose runtime is polynomial in `m_0`, `1/theta`, capacity parameters, and `1/epsilon`, and whose calls can be justified with a single original marginal.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 2 Branch A: Transcript-Envelope Boosting Lemma

- date: 2026-05-07
- branch: transcript-envelope lemma for marginal boosting
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Booster Chosen

I used Servedio's SmoothBoost as the concrete smooth realizable booster model.
The finite-sample algorithm maintains measures $M_t$ on the sample, calls the
weak learner on $D_t=M_t/|M_t|$, stops when $|M_t|/m<\kappa$, and returns a
thresholded average of the weak hypotheses. The two properties relevant here
are:

1. every call distribution is smooth, with point masses at most
   $1/(\kappa m)$, so the population analogue has density bounded by roughly
   $1/\kappa$ relative to the original marginal $P$;
2. if every call receives advantage at least $\gamma$, then the number of weak
   calls is polynomial in $1/\kappa$ and $1/\gamma$, and the final error is at
   most $\kappa$.

This is deliberately the most favorable reweighting setup for the envelope
lemma. If smoothness plus the atlas source forced a $P$-dependent weak-gap
envelope, SmoothBoost should expose it.

Reference checked for this branch:

- Rocco A. Servedio, "Smooth Boosting and Learning with Malicious Noise,"
  JMLR 4:633--648, 2003, https://www.jmlr.org/papers/v4/servedio03a.html.

### Conditional SmoothBoost Theorem

The following conditional theorem is valid and would be enough to resolve the
edge true if its hypothesis followed from the source node.

**Theorem.** Fix the SmoothBoost population analogue with accuracy parameter
$\kappa=\Theta(\varepsilon)$, and let $A$ be the marginal-nonuniform weak
agnostic improper learner, used only on realizable labels. Suppose that for
every original marginal $P$ there is a polynomial $r_P$ such that, for every
target concept $c$, every accuracy $\varepsilon$, every finite transcript of
SmoothBoost before stopping, and every induced call marginal $Q_t$ in that
transcript,

$$
\gamma_{Q_t}(s)\ge \frac{1}{r_P(s,1/\varepsilon)}.
$$

Then the source implies efficient marginal-nonuniform realizable improper PAC
learning.

**Proof sketch.** On realizable labels, the weak agnostic guarantee specializes
to

$$
\operatorname{err}_{Q_t}(h_t,c)\le \frac12-\gamma_{Q_t}(s).
$$

The assumed envelope gives one lower bound

$$
\gamma_*=\frac{1}{r_P(s,1/\varepsilon)}
$$

for every SmoothBoost call along every relevant transcript. Run SmoothBoost
with a conservative edge parameter at most $\gamma_*$. The standard
SmoothBoost analysis gives at most polynomially many calls in
$(r_P(s,1/\varepsilon),1/\varepsilon)$ and final error at most $\varepsilon$.
The final hypothesis is a vote/thresholded average of improper weak
hypotheses, hence is allowed by the target. The atlas pathwise finite-transcript
resource convention handles runtime/sample use of the fixed learner once a
finite set of calls and confidence splits is specified. This produces a single
polynomial depending on $P$, not on $c$.

So the branch reduces exactly to whether the displayed envelope is forced by
current marginal-nonuniform semantics.

### Attempted Envelope Proof And Failure Point

For SmoothBoost, every call marginal satisfies a bounded-density condition of
the form

$$
\frac{dQ_t}{dP}\le O(1/\varepsilon).
$$

Thus the desired lemma would follow from a stability principle:

$$
Q\ll P,\quad \left\|dQ/dP\right\|_\infty\le \operatorname{poly}(1/\varepsilon)
\quad\Longrightarrow\quad
\gamma_Q(s)\ge 1/r_P(s,1/\varepsilon).
$$

The source definition does not contain such a stability principle. It gives

$$
\forall Q\ \exists r_Q
$$

for the weak gap, not local bounded-density continuity of $Q\mapsto r_Q$.
Pathwise finite-transcript bounds help with runtime because a full-support
reference marginal sees every finite sample transcript. They do not transfer
accuracy: a global weak-agnostic risk guarantee under $P$ may ignore a
low-mass component on which the induced conditional marginal has an arbitrarily
small weak gap.

This is the exact place where the size-conditional diagonal proof would work
but the current global-marginal semantics do not. If accuracy were evaluated
slice-by-slice at each representation size, stitching bad SmoothBoost
marginals into one diagonal marginal would contradict that diagonal marginal's
single polynomial weak gap. Under a weighted global mixture, the bad slices can
be assigned small enough mass that the weak guarantee on the mixture remains
true even when the conditional gaps on the slices decay with unbounded
exponents.

### Concrete Obstruction Template

Here is a template showing why SmoothBoost smoothness does not force the
envelope.

Let the instance space be a disjoint union of finite blocks

$$
B_{n,j},\qquad n\ge 2,\ j\ge 1,
$$

where $n$ is the representation-size scale and $j$ is a hidden difficulty
level. Put an original marginal $P$ on the blocks with masses

$$
w_{n,j}=Z^{-1}2^{-j}n^{-2}.
$$

Inside $B_{n,j}$, arrange the concept class so that:

1. there is a cheap weak handle giving advantage
   $\gamma_{n,j}(n)\asymp n^{-j}$ under the conditional marginal
   $P(\cdot\mid B_{n,j})$;
2. for each fixed conditional marginal, this is still a legal
   marginal-nonuniform weak guarantee, because $n^j$ is a polynomial in $n$
   once $j$ is fixed as part of the marginal;
3. no stronger uniform-in-$j$ handle is available on the conditioned block.

Now choose an accuracy

$$
\varepsilon_{n,j}\asymp w_{n,j}.
$$

A SmoothBoost call distribution is allowed to have density cap
$O(1/\varepsilon_{n,j})$, which is large enough to put essentially all of its
mass on $B_{n,j}$, since

$$
\frac{dP(\cdot\mid B_{n,j})}{dP}=1/w_{n,j}
=\Theta(2^j n^2)=\Theta(1/\varepsilon_{n,j}).
$$

This conditioned block is therefore within the smooth family that a
population SmoothBoost transcript may need once the current ensemble has
already made the off-block region easy and must reduce the remaining error
below the block mass.

Suppose a $P$-dependent envelope polynomial existed:

$$
\frac{1}{\gamma_{n,j}(n)}
\le r_P(n,1/\varepsilon_{n,j}).
$$

Let $D$ be the total degree of $r_P$. Since

$$
1/\varepsilon_{n,j}=\Theta(2^j n^2),
$$

the right-hand side is at most, up to a constant depending on $j$ and $P$,

$$
C_P\,2^{jD}n^{2D+D'}
$$

for some fixed exponent $D'$. The left-hand side is

$$
\Theta(n^j).
$$

Choosing $j>2D+D'$ and then taking $n$ large contradicts the envelope. Thus
bounded density by $\operatorname{poly}(1/\varepsilon)$ is compatible with
conditioned weak gaps that have no single polynomial lower envelope controlled
by the original $P$.

This obstruction is not yet a full atlas counterexample. To make it an actual
`resolved-false` witness, one would need a concrete uniformly represented
concept class satisfying the weak agnostic improper source on every marginal,
not merely an abstract block-gap assignment. The hard part is the familiar
nonboostable-handle requirement: weak handles must be cheaply findable on every
conditioned marginal, but aggregating enough handles for small error under the
original $P$ must remain hard even for improper hypotheses. Random-code blocks
give the latter but not the former; singleton or lookup handles give the
former but tend to make improper aggregation easy.

### Same-Marginal Agnostic Route Does Not Rescue This Branch

The agnostic source suggests relabeling examples while keeping $X\sim P$ fixed,
but the fixed-additive guarantee still has the old floor. If the relabeling has

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1,
$$

then the source yields only

$$
\mathbb E_P[a(X)\mathbf 1\{h(X)\ne c(X)\}]\le \beta_P(s),
\qquad
\beta_P(s)=1/2-\gamma_P(s).
$$

To simulate a reweighted marginal $Q$ by taking
$a=\lambda\,dQ/dP$, one needs $\lambda\le 1/\|dQ/dP\|_\infty$ and obtains

$$
\operatorname{err}_Q(h,c)\le \beta_P(s)/\lambda.
$$

This is weak only if $\lambda>2\beta_P(s)$. When $\gamma_P(s)$ is small, the
allowable density ratio is essentially $1$, while the SmoothBoost obstruction
uses density ratios of order $1/\varepsilon$. So same-marginal relabeling does
not prove the SmoothBoost envelope.

### Branch Conclusion

For this concrete smooth booster, the transcript-envelope lemma is true as an
extra hypothesis and is sufficient to prove the edge true. I do not see a
proof that the current source node implies the hypothesis. Smoothness gives
only a density cap. Under current global-marginal semantics, low-mass
high-difficulty blocks can satisfy the source pointwise while defeating every
single original-$P$ polynomial weak-gap envelope.

This branch therefore produces a concrete obstruction template to the
envelope lemma, but not a complete source-positive/target-negative concept
class. The edge should remain open.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Rare-Block Nonboostable Handles

- date: 2026-05-07
- branch: turn rare-block obstruction into a counterexample, or locate the collapse
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Setup And Target-Side Temptation

The most tempting false witness is still a rare-block PRF or random-code direct
sum. Let the domain contain paired blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=N_{n,j}=n^j,
$$

and let a concept indexed by a short key $k$ label exactly one point in each
pair:

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

with zero labels off the active block. For a random-code version, replace
$F_k(u)$ by independent random bits. Put a fixed original marginal on the
blocks, for example

$$
w_{n,j}\asymp 2^{-j}n^{-2}
$$

times a roughly uniform distribution inside $B_{n,j}$.

The target-side lower bound has the right shape for the assigned
marginal-nonuniform strong target. Let a proposed strong learner for this fixed
mixture have $P$-dependent polynomial degree $D$. Ask it to learn the target
active on $B_{n,j}$ to accuracy

$$
\varepsilon\ll w_{n,j}.
$$

Then its total sample/time budget is at most polynomial in

$$
s\asymp n,\qquad 1/\varepsilon\asymp 2^j n^2.
$$

For fixed $j$, this is $O(2^{O(j)}n^{O(D)})$. Choosing $j$ larger than the
$n$-degree available from the learner and then taking $n$ large leaves
$o(N_{n,j})$ active coordinates observed. In the random-code version, labels
on fresh unseen coordinates are independent of the transcript. In the PRF
version, a low-error efficiently evaluable improper hypothesis would predict
$F_k(u)$ on fresh $u$ with noticeable advantage, giving the usual
Kearns-Valiant/PRF distinguishing contradiction.

So the rare-block template can make strong improper learning under one fixed
original marginal computationally impossible, at least conditionally on:

1. PRF security, or a random-oracle/relativized random-code model;
2. the standard computational-PAC convention that an efficient improper output
   is polynomial-time evaluable on fresh instances; and
3. a source-side weak learner whose one-call pathwise resources are genuinely
   polynomial and whose marginal-dependent deterioration appears only in the
   weak gap.

The third item is where the construction collapses.

### Why PRF And Random-Code Blocks Are Source-Negative Without Handles

Plain PRF, LPN, random-code, or random-label blocks immediately fail the
source. The source quantifies over every marginal, including marginals
concentrated on the hard block. Under the block-uniform marginal and realizable
labels from a random/PRF target, a weak agnostic learner restricted to
realizable labels would already have to get nontrivial correlation with the
target. That is exactly what the PRF or random-code lower bound denies.

Thus every viable rare-block counterexample must add cheap weak handles. The
handles cannot be merely rare-mixture artifacts; they must work under isolated
block marginals and under arbitrary marginals that make a hard block
near-balanced.

### Singleton And Lookup Handles

The obvious repair is to add constants and local lookup handles. Under
realizable labels, if the positive mass

$$
M=P(c=1)
$$

is far from $1/2$, one of the two constants is weakly good. If $M$ is close to
$1/2$, a singleton or small lookup table containing a sampled positive atom
can improve the all-zero default by the atom mass, giving an edge of order
$1/N_{n,j}$ on an isolated uniform block.

This is enough as an intuition, but not as an atlas source proof.

The source learner is one uniform algorithm. By the full-support
finite-transcript convention, applying the source to a full-support reference
marginal gives one pathwise polynomial bound on the sample use and runtime of a
single call. Therefore the learner cannot validate or search over a block at
cost $N_{n,j}$ or $N_{n,j}^2$ when $j$ is unbounded in the encoded instance
space. Marginal nonuniformity may hide the weak **gap**, but not the one-call
runtime exponent.

Without validation at the $1/N_{n,j}$ scale, deterministic singleton handles
run into an orientation problem. Consider a hard block and two realizable
marginals whose positive masses are

$$
M_+=1/2+\eta,\qquad M_-=1/2-\eta,
$$

where $\eta$ is much larger than the mass corrected by the few observed
singletons but much smaller than what the learner can estimate with its fixed
pathwise sample budget. The all-zero default plus positive singletons is weak
on $M_-$, but can remain above error $1/2$ on $M_+$. The all-one default plus
negative singletons has the symmetric failure. A finite transcript cannot
reliably distinguish $M_+$ from $M_-$ at that scale, and a wrong deterministic
orientation loses the weak guarantee.

This is sharper than merely saying "validation is expensive." The block can be
near-balanced by an amount lying between:

$$
\text{sampled-handle correction mass} \quad\text{and}\quad
\text{detectable label-bias scale}.
$$

In that window, cheap singleton/lookup handles are not a source witness.

### Staged Parities

A staged parity version tries to replace sparse lookup handles with algebraic
handles. For instance, slice $j$ could contain parities whose first few
coordinates are easy to recover, with later coordinates hidden by a PRF,
noisy-parity, or hard-core predicate. The hope is that one stage gives weak
correlation, while strong prediction requires many stages.

This also collapses in one of two ways.

If each residual stage has an efficiently findable parity with inverse
polynomial correlation under every marginal, then an improper learner can
aggregate the recovered parities by standard voting or by directly expanding
the staged representation. The construction is slow only because the weak gap
on stage $j$ is $n^{-j}$; it is not computationally nonboostable for the
marginal-nonuniform target unless one proves a lower bound against all
$P$-dependent polynomial aggregators.

If the later stages are cryptographically hidden, then the source fails on a
marginal concentrated on the hidden residual. In agnostic form this failure is
even clearer: arbitrary low-noise labels on the residual require a handle that
correlates with the best concept there. PRF/LPN hardness is precisely a
barrier to finding such a handle.

The parity-image constructions used in nearby properization searches also do
not help here. Their hardness forces proper recovery of a seed or coefficient;
the present target is improper, so an external parity vector, lookup table, or
vote is an allowed output.

### Nonboostable Weak-Handle Requirement

The needed object is more specific than a rare hard block:

1. **Fixed-polynomial one-call learner.** A single source learner must run in
   transcript-wise polynomial time independent of the block level.

2. **Every-marginal weak agnostic handle.** For every marginal, including
   isolated residual marginals and near-balanced hard-block marginals, the
   learner must find a deterministic improper hypothesis with

   $$
   \operatorname{err}\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s)
   $$

   for some $P$-dependent inverse-polynomial gap.

3. **Hard aggregation under one fixed original marginal.** For some fixed
   mixture marginal $P^\star$, achieving error below a rare block mass must
   require either about $N_{n,j}$ independent handles or prediction of unseen
   PRF/random-code coordinates.

4. **No residual self-defeat.** The same primitive that certifies item 2 must
   not be reusable by an improper booster to satisfy item 3.

I do not know a standard construction with all four properties. In the known
templates, item 2 and item 4 fight each other. If a handle finder works on
every residual marginal, a strong improper learner can generally call it on
residuals and aggregate. If residual handle-finding is made hard, the weak
agnostic source fails on the marginal that isolates that residual.

### Conditional Pieces That Do Work

The following partial statements are sound but insufficient.

**Target hardness conditional on a source lemma.** If one had a valid
pathwise-polynomial weak agnostic source learner for the rare-block
PRF/singleton class, then the fixed-mixture lower bound above would give a
conditional `false` edge under PRF security plus the efficient-output evaluator
convention. The proof would choose a block level $j$ larger than the degree of
the alleged $P^\star$-dependent strong learner and set
$\varepsilon\ll w_{n,j}$.

**Random-code oracle core.** Replacing the PRF by truly random block labels
removes the cryptographic reduction and shows the information-theoretic core:
few active samples cannot predict unseen active coordinates. This is useful as
a relativized diagnostic, but it still lacks the source lemma.

**Randomized prediction would repair orientation, but changes the model.** A
prediction-time randomized default, corrected on sampled handles, could give an
orientation-free expected weak edge on near-balanced blocks. The atlas notes do
not currently use such randomized binary hypotheses for these implication
edges, and the target/lower-bound statements would need to be restated if they
were allowed.

### Branch Conclusion

The rare-block obstruction template has not been turned into an actual
counterexample. The target-hardness half is credible and probably conditional
on standard PRF-style assumptions plus efficient evaluability of improper
outputs. The source half collapses for deterministic hypotheses: PRF/random
blocks need handles to be source-positive, but singleton/lookup handles require
either forbidden block-scale validation or an unavailable orientation-free
choice under near-balanced marginals. Staged parity repairs either become
boostable by an improper learner or make the residual weak source false.

The edge should remain open. A future false witness needs a genuinely
nonboostable weak-handle family, not just rare hard blocks.

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 4 Branch A: Source-Side Weak Agnostic Handle Lemma

- date: 2026-05-07
- branch: source-side weak agnostic handle primitive
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Exact Oracle Inequality

Use $\{\pm 1\}$ labels for this branch. For a joint distribution $D$ with
instance marginal $P$, write

$$
\rho_{\mathcal C}(D)=\sup_{c\in\mathcal C}\mathbb E_D[c(X)Y].
$$

The weak agnostic source guarantee with gap $\gamma_P(s)$ is exactly the
correlation inequality

$$
\mathbb E_D[h(X)Y]\ge \rho_{\mathcal C}(D)-1+2\gamma_P(s).
$$

Indeed, $\operatorname{err}(h)=(1-\mathbb E[hY])/2$ and
$\operatorname{OPT}_{\mathcal C}(D)=(1-\rho_{\mathcal C}(D))/2$.

Thus the meaningful source-side demand appears only on low-noise conditionals.
If some $c\in\mathcal C$ has label noise

$$
\eta=\Pr[c(X)\ne Y],
$$

then $\rho_{\mathcal C}(D)\ge 1-2\eta$, so the source learner must output

$$
\mathbb E[hY]\ge 2(\gamma_P(s)-\eta).
$$

In particular, when $\eta\le \gamma_P(s)/4$, triangle inequality gives

$$
\Pr[h(X)\ne c(X)]\le \frac12-\gamma_P(s)+2\eta
\le \frac12-\frac{\gamma_P(s)}2.
$$

So any handle-based proof of the source must do more than exhibit a weakly
useful concept somewhere in the class. For every marginal, including marginals
concentrated on one residual block, and for every sufficiently low-noise
conditional, it must efficiently output a deterministic improper hypothesis
that is weakly correlated with the near-best concept.

### Necessary And Sufficient Handle Primitive

For a proposed handle family $\mathcal H_s$ the right primitive is the
following.

**Marginal weak agnostic handle primitive.** A uniform algorithm `FindHandle`
is a $\Gamma$-handle primitive for $\mathcal C$ if, for every marginal $P$,
there are a polynomial $p_P$ and an inverse-polynomial gap

$$
\Gamma_P(s)\ge 1/p_P(s)
$$

such that, for every joint distribution $D$ with marginal $P$, `FindHandle`
uses at most $p_P(s,\log(1/\delta))$ samples and time and, with probability at
least $1-\delta$, returns some $h\in\mathcal H_s$ satisfying

$$
\mathbb E_D[h(X)Y]\ge \rho_{\mathcal C}(D)-1+2\Gamma_P(s).
$$

This primitive is sufficient for the source by the preceding equivalence. It
is also necessary for a handle-only source proof: if the source learner is
supposed to work by outputting constants, singleton lookups, staged parities,
or their votes, then its output distribution itself must satisfy this
inequality for that handle family.

For the low-noise subproblem, the primitive can be stated more visibly:
whenever $\operatorname{OPT}_{\mathcal C}(D)\le \Gamma_P(s)/4$, it must output
a handle with error at most $1/2-\Gamma_P(s)/2$ against the near-realizing
concept. The rest of the agnostic range is mostly a safety condition: the
algorithm must not output a hypothesis strongly anti-correlated with the best
available concept when the best correlation is only moderate.

This characterization clarifies what a source-side handle must contain.
Existence of a heavy atom, a lookup entry, or a recoverable parity stage is not
enough. The primitive must also include either:

1. an orientation certificate, so the learner knows which side of the handle
   should be labeled positive;
2. validation at the weak-gap scale, so empirical risk can choose among the
   two orientations; or
3. an algebraic or structural weak learner whose correctness does not rely on
   validating exponentially or block-scale many candidate handles.

### Sparse-Handle Orientation Barrier

Here is the reusable barrier behind the singleton and lookup failures.

Consider a block $B$ of size $N$ with the uniform marginal. A sparse handle
output has the form "one default label, corrected on a set $R$" with

$$
P_B(R)\le a.
$$

For singleton or explicit lookup handles produced from $T$ inspected atoms,
one has $a\le T/N$. Suppose the learner uses $m$ samples and has no public
orientation signal.

Choose two realizable low-noise targets on $B$ whose positive masses are

$$
\frac12+\theta
\quad\text{and}\quad
\frac12-\theta,
$$

with the fine structure otherwise pseudorandom or random subject to those
masses. Distinguishing the two orientations from labels requires

$$
m=\Omega(1/\theta^2)
$$

samples; this is just the Bernoulli bias testing lower bound, and a Yao-style
averaging argument fixes hard deterministic target sets.

If the learner chooses the wrong default orientation, then even after applying
all sparse corrections its error is at least

$$
\frac12+\theta-a.
$$

Therefore, for a desired weak gap $\Gamma$, every bias level $\theta$ with
$\theta>a+\Gamma$ creates an orientation test. A deterministic weak handle
requires at least one of the following:

$$
a\ge \theta-\Gamma
\quad\text{or}\quad
m=\Omega(1/\theta^2).
$$

Equivalently, without a public orientation certificate, sparse handles must
close the whole window

$$
\Gamma+a \ll \theta \ll 1/\sqrt m.
$$

For singleton handles on an $N$-point block, $a\le T/N$. If the learner sees
or outputs only $T$ atoms and uses only $m$ samples, then any bias

$$
T/N+\Gamma\ll \theta\ll 1/\sqrt m
$$

is fatal: the sparse corrections are too small to overcome the wrong default,
but the samples do not reveal which default is right. To remove this window,
the learner must either output correction mass comparable to the bias
($T=\Omega(\theta N)$) or estimate the bias directly
($m=\Omega(1/\theta^2)$). For the natural singleton gap
$\Gamma\asymp 1/N$, a constant number of sampled singletons only handles the
very tiny $\theta\asymp 1/N$ regime; the harder near-balanced marginals have
much larger but still statistically hidden bias. In rare-block templates with
$N=n^j$ and unbounded $j$, closing this window is exactly the forbidden
block-scale validation/orientation cost if the source learner is supposed to
remain pathwise polynomial under a full-support reference marginal.

So singleton handles can satisfy the source only in the "honest validation"
regime: the relevant block has polynomial effective size with a fixed exponent,
or the marginal-dependent polynomial is allowed to pay the full
$\Gamma^{-2}$ validation cost. They cannot provide a hidden weak agnostic
source primitive while avoiding block-scale validation.

The same argument applies to bounded lookup handles. A lookup table helps if
ERM can search and validate the candidate table class at scale $\Gamma$; this
is why polynomial-size active-slice lookup classes are source-positive in
nearby atlas witnesses. But if the table lives in a block of size $n^j$ with
unbounded $j$, and the construction forbids search/validation at that scale,
then arbitrary near-balanced low-noise marginals defeat the source.

### Staged-Parity Handles

Staged parities avoid explicit lookup size, but they face the same dichotomy.

If there is a robust parity-stage finder that, under every marginal and every
low-noise residual conditional, returns a parity with inverse-polynomial
correlation without estimating a tiny empirical advantage by brute force, then
it is a valid source-side handle primitive. But then it is also reusable: an
improper learner can call the same finder on residual distributions and
aggregate the recovered stages, at least conditionally on the same kind of
weak-gap envelope needed by boosting.

If the later parity stages are hidden by a PRF, LPN-type noise, or a hard-core
predicate, then the source fails on the marginal concentrated on that hidden
residual. The low-noise version of the oracle inequality would still demand a
deterministic hypothesis weakly correlated with the hidden stage. The assumed
hardness is precisely that no efficient algorithm can find one.

Thus staged parities are not a third path. They either instantiate the handle
primitive and become aggregation-friendly, or they preserve hardness by making
the source false on residual marginals.

### What Exists And What Does Not

A handle primitive does exist in broad but unthreatening cases:

- finite or polynomial-effective lookup domains, where ERM over all sampled
  handles and orientations is polynomial and uniform convergence validates the
  weak gap;
- algebraic classes with a genuine distribution-robust weak learner for every
  residual marginal; and
- handle families with a public orientation certificate of mass at least the
  desired weak gap.

These cases are source-positive, but they do not look like false witnesses for
the present edge. They either give a stronger agnostic improper learner
directly, or they give a primitive that an improper boosting/aggregation
procedure can plausibly reuse.

What appears impossible, in the broad sparse-handle templates considered here,
is the combination needed for a rare-block separation:

1. arbitrary-marginal low-noise weak agnostic handles;
2. no block-scale validation or orientation test;
3. deterministic binary improper outputs; and
4. residual hardness strong enough to block aggregation.

The obstruction is source-side, not target-side: near-balanced marginals force
the weak learner either to validate the orientation at the weak-gap scale or to
possess a public structural certificate. Singleton, lookup, and staged-parity
handles do not supply such a certificate in the hard regimes.

### Branch Conclusion

The source-side weak agnostic handle lemma is now fairly crisp. The necessary
and sufficient primitive is the correlation oracle inequality

$$
\mathbb E[hY]\ge \rho_{\mathcal C}(D)-1+2\Gamma_P(s)
$$

under every marginal. On low-noise conditionals this is exactly an
orientation-certified weak handle finder. Sparse singleton and lookup handles
can satisfy it only by paying validation at the weak-gap/block scale or by
restricting to polynomial-effective blocks. Staged parities satisfy it only
when the parity finder is robust on arbitrary residual marginals, in which case
the primitive no longer looks nonboostable for an improper target.

This gives a barrier to the current handle templates but not a full resolution
of the atlas edge: a more exotic orientation-certified, nonaggregatable weak
agnostic primitive is not ruled out.

VERDICT: conditional-only

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Correlation-Oracle Primitive And Boostability

- date: 2026-05-07
- branch: decide whether the correlation-oracle primitive itself boosts, or only under extra hypotheses
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Sources Checked For This Branch

Primary sources rechecked:

- Kalai, Mansour, and Verbin 2008, "On Agnostic Boosting and Parity Learning."
- Feldman 2010, "Distribution-Specific Agnostic Boosting."
- Ghai and Singh 2025, "Sample-Optimal Agnostic Boosting with Unlabeled Data."
- da Cunha, Hogsgaard, Paudice, and Sun 2025, "Revisiting Agnostic Boosting."
- da Cunha, Hogsgaard, and Paudice 2026, "Sample-Near-Optimal Agnostic Boosting with Improved Running Time."

The relevant comparison point is that modern correlation formulations use a
weak learner satisfying

$$
\operatorname{corr}_D(w)\ge \gamma\sup_{f\in F}\operatorname{corr}_D(f)-\epsilon_0,
$$

and the strongest positive results need one nontrivial parameter pair
$(\gamma,\epsilon_0)$, usually with $\gamma>\epsilon_0$, for all distributions
that the booster calls. Distribution-specific relabeling results keep the
instance marginal fixed, but their final excess term still depends on the
additive slack at the target accuracy scale.

### Translating The Atlas Primitive

The Depth 4 primitive says that for every marginal $R$ there is a
marginal-dependent inverse-polynomial gap $\Gamma_R(s)$ such that, for every
joint distribution $D$ with instance marginal $R$, the source learner returns
$h$ with

$$
\mathbb E_D[h(X)Y]\ge
\rho_{\mathcal C}(D)-1+2\Gamma_R(s),
\qquad
\rho_{\mathcal C}(D)=\sup_{c\in\mathcal C}\mathbb E_D[c(X)Y].
$$

In the da Cunha et al. notation, this is a correlation weak learner with

$$
\gamma=1,\qquad \epsilon_0(R,s)=1-2\Gamma_R(s),
$$

so the nontriviality gap is

$$
\gamma-\epsilon_0(R,s)=2\Gamma_R(s).
$$

On a realizable distribution over any fixed marginal $R$, this gives the usual
weak realizable correlation

$$
\mathbb E[h(X)c(X)]\ge 2\Gamma_R(s).
$$

Thus, statistically and pointwise in $R$, the primitive is exactly a weak
correlation oracle. The unresolved issue is not the algebraic form of the
oracle. It is whether the original marginal $P$ controls the gap on the
auxiliary marginals that any computational booster needs.

### Conditional Positive Theorem

The following statement is sound and is the cleanest theorem extracted from
the correlation-oracle framing.

**Theorem.** Assume the source learner satisfies the correlation primitive.
Fix an original marginal $P$. Suppose that for every accuracy
$\varepsilon$ there is a polynomial $r_P$ such that every distribution $R$
queried by the chosen booster before reaching error $\varepsilon$ satisfies

$$
\Gamma_R(s)\ge \frac{1}{r_P(s,1/\varepsilon)}
$$

and the source learner's sample/time use on those calls is also bounded by
$r_P(s,1/\varepsilon,\log(1/\delta))$. Then the edge is true for $P$:
there is an efficient marginal-nonuniform realizable improper learner with
error at most $\varepsilon$.

**Proof sketch.** Use the primitive only on realizable labels. For each call
marginal $R$, the best concept has correlation $1$, so the weak hypothesis has
correlation at least $2/r_P(s,1/\varepsilon)$. A standard realizable booster
can therefore run with a conservative edge parameter
$\theta=1/r_P(s,1/\varepsilon)$ and make polynomially many calls in
$(s,1/\varepsilon,\log(1/\delta))$, with polynomial confidence splitting.
The final vote is an improper hypothesis, which is allowed by the target.

This theorem is just the transcript-envelope theorem in correlation language.
It does not follow from the source node unless one adds the displayed envelope.

There is also a same-marginal positive theorem, but it requires a stronger
oracle than the atlas source. If for the original marginal $P$ the learner
handled every relabeling $g\in[-1,1]^{\mathcal X}$ with

$$
\mathbb E_P[g(X)h(X)]
\ge \gamma_P(s)\sup_{c\in\mathcal C}\mathbb E_P[g(X)c(X)]
-\epsilon_{0,P}(s,\varepsilon),
$$

where $\gamma_P$ is inverse-polynomial and
$\epsilon_{0,P}/\gamma_P\le O(\varepsilon)$, then
distribution-specific agnostic boosting would keep the instance marginal $P$
and produce the target. But the atlas primitive has
$\epsilon_0=1-2\Gamma_P(s)$, not tunable $O(\varepsilon)$ slack. This is too
large for the Feldman/Kalai-Kanade/Ghai-Singh route when the target accuracy is
small.

### Black-Box No-Go For The Bare Primitive

The bare primitive plus marginal nonuniformity does not by itself provide a
black-box polynomial booster.

Here is the precise obstruction. Let a proposed booster have an original-$P$
polynomial resource bound $r_P(s,1/\varepsilon)$. The source primitive permits
the following legal pattern of gaps on conditioned rare blocks:

$$
B_{n,j},\qquad
P(B_{n,j})=w_{n,j}\asymp 2^{-j}n^{-2},\qquad
\Gamma_{P(\cdot\mid B_{n,j})}(n)\asymp n^{-j}.
$$

For each fixed conditioned marginal $P(\cdot\mid B_{n,j})$, the gap
$n^{-j}$ is inverse-polynomial in $n$, so it is legal marginal-nonuniformly.
But under the original mixture $P$, asking for accuracy

$$
\varepsilon_{n,j}\asymp w_{n,j}
$$

allows a smooth or filtered booster to query a distribution essentially
conditioned on $B_{n,j}$: its density relative to $P$ is only
$O(1/\varepsilon_{n,j})$. If $r_P$ has fixed total degree $D$, then

$$
r_P(n,1/\varepsilon_{n,j})
\le C_{P,j} n^{O(D)}
$$

while

$$
1/\Gamma_{P(\cdot\mid B_{n,j})}(n)=n^j.
$$

Choosing $j$ larger than the $n$-degree of $r_P$ makes the call gap smaller
than any inverse of the claimed original-$P$ polynomial. A booster that treats
the primitive only as a correlation oracle has no certificate that this cannot
happen. It must either run for time depending on the conditioned marginal's
hidden exponent $j$, or assume an envelope not present in the source.

This is a no-go for a black-box theorem from the primitive alone. It is not a
complete atlas counterexample, because the displayed gap assignment still has
to be realized by one uniform concept class and one uniform source learner.

### Same-Marginal Relabeling Does Not Remove The No-Go

One might hope that the agnostic correlation form avoids reweighted marginals
by querying only relabelings over the original $P$. With the atlas slack, this
still stalls.

For a relabeling with conditional expectation $g(x)c(x)$, the primitive gives

$$
\mathbb E_P[g(X)c(X)h(X)]
\ge
\sup_{f\in\mathcal C}\mathbb E_P[g(X)c(X)f(X)]-1+2\Gamma_P(s).
$$

If the residual task has best correlation at most $1-2\Gamma_P(s)$, the lower
bound is nonpositive. But reaching error $\varepsilon$ requires useful
prediction on residual regions whose $P$-mass can be far below this fixed
additive floor. Thus the same-marginal oracle only guarantees the first weak
step; it does not guarantee residual progress down to arbitrary
$\varepsilon$.

The 2025 da Cunha-Hogsgaard-Paudice-Sun theorem shows that a single
nontrivial correlation parameter can be statistically boosted under very
general assumptions. In the present edge, however, the nontriviality parameter
is $\Gamma_R(s)$ and changes with the booster-called marginal $R$. Their
algorithmic result is also not a polynomial-time atlas learner. The 2026
improved-runtime result is closer, but its polynomial-in-sample-size statement
treats other weak-learning parameters as fixed; when $m_0$ and
$1/(\gamma-\epsilon_0)$ are themselves polynomial in the representation size,
the recorded runtime dependence is not polynomial in the atlas sense.

### Plausible But Still Conditional False Witness

The plausible false-witness shape is now narrower:

1. a disjoint rare-block class with blocks $B_{n,j}$ of effective size
   $N_{n,j}=n^j$ and original mass $w_{n,j}\asymp 2^{-j}n^{-2}$;
2. an orientation-certified local correlation primitive that, under every
   marginal concentrated on a block or residual subproblem, returns a
   deterministic improper handle with correlation about $n^{-j}$;
3. a hard residual component, such as a PRF or random-code core, so that under
   the fixed mixture $P^\star$, error below $w_{n,j}/10$ requires aggregating
   about $n^j$ independent handles or predicting unseen hard coordinates; and
4. no reusable residual finder strong enough for an improper booster to call
   repeatedly inside a $P^\star$-dependent polynomial.

If such a class exists, then the edge would be conditionally false: a
strong learner for $P^\star$ with polynomial degree $D$ could be defeated by
choosing $j>D$ and then $n$ large. The correlation primitive would hold
pointwise on each marginal, but the strong learner's fixed original-$P^\star$
polynomial could not absorb all rare-block exponents.

The missing item is exactly item 2 without item 4. Known candidates fail in
opposite ways. Plain PRF/random-code blocks are source-negative on isolated
marginals. Singleton and lookup handles need validation or orientation at the
block scale. Staged algebraic handles either give a residual finder that an
improper booster can reuse, or they hide the residual and thereby violate the
source.

### Branch Conclusion

The correlation-oracle primitive does not, by itself, resolve the edge true.
It gives a pointwise weak correlation oracle for each marginal, but known
boosting theorems need either:

1. a single original-$P$ lower envelope on the nontriviality gap over all
   reweighted call marginals; or
2. a same-marginal correlation oracle with additive slack tunable to the final
   accuracy scale.

The current source supplies neither. The right statement is therefore
conditional: envelope or tunable-slack correlation oracles imply the target,
while the bare primitive admits a black-box rare-block no-go and still lacks a
concrete source-positive, target-negative class.

VERDICT: conditional-only

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 6 Branch A: Same-Marginal Residual Slack Trap

- date: 2026-05-07
- branch: residual-responsive same-marginal boosting versus deterministic rare-block handles
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Sources Rechecked

I rechecked the same-marginal distribution-specific route in Feldman's
[Distribution-Specific Agnostic Boosting](https://arxiv.org/abs/0909.2927),
especially the distinction between:

1. same-marginal boosting from an $(\alpha,\gamma)$ weak agnostic learner to
   an $\alpha$-optimal agnostic learner; and
2. distribution-changing boosting from a fixed $\beta$-optimal agnostic learner,
   which can get the Gavinsky-style
   $\Delta/(1-2\beta)+\varepsilon$ guarantee and hence arbitrary error in the
   realizable case.

This distinction is exactly the issue for the atlas source. The source is
fixed-additive:

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s),
\qquad
\beta_P(s)=\frac12-\Gamma_P(s),
$$

or, in correlation form for a same-marginal relabeling with conditional mean
$\phi:X\to[-1,1]$,

$$
\langle h,\phi\rangle_P
\ge
\sup_{c\in\mathcal C}\langle c,\phi\rangle_P-1+2\Gamma_P(s).
$$

It is not Feldman's stronger "for every advantage scale $\tau$ recover an
inverse-polynomial fraction of $\tau$" oracle over the fixed marginal.

### Residual-Only Queries Have Too Little Mass

Suppose the target is $f\in\mathcal C$ and a same-marginal booster has already
formed a deterministic current predictor $H$ with error set

$$
E=\{x:H(x)\ne f(x)\},\qquad P(E)=e.
$$

A residual-responsive same-marginal query tries to ask the source learner about
labels whose conditional mean is supported mainly on $E$, for example
$\phi(x)=f(x)1_E(x)$ or a clipped gradient proportional to $f-H$.
For every such residual-only query,

$$
\sup_{c\in\mathcal C}\langle c,\phi\rangle_P\le \mathbb E_P|\phi|
\le e.
$$

If $e\le 1-2\Gamma_P(s)$, the source inequality gives only

$$
\langle h,\phi\rangle_P\ge e-1+2\Gamma_P(s)\le 0,
$$

so it does not even force positive correlation with the residual. Rescaling
does not help, because the conditional label mean is bounded by $[-1,1]$; a
same-marginal relabeling cannot turn a small residual set into unit mass.

This is the same obstruction seen in Feldman's projected-gradient proof. The
query $P_1(f-H)$ is useful for an $(\alpha,\gamma)$ oracle only while its
$L_1$ mass is above the chosen threshold $\alpha$. To drive the final error to
$\varepsilon$, the oracle must be meaningful at scale $\alpha=O(\varepsilon)$.
The atlas source has one fixed scale $\beta_P=1/2-\Gamma_P$, so the same
argument stalls once the residual norm drops below a constant depending on
$\Gamma_P$, long before arbitrary $\varepsilon$.

### Residual Plus Filler Lets The Oracle Ignore The Residual

The natural repair is to keep the best concept's correlation high by adding a
large "filler" part away from $E$. But then the fixed additive slack can be
spent entirely on the filler.

The simplest example is the original realizable labels $\phi=f$. The current
predictor $H$ has correlation

$$
\langle H,f\rangle_P=1-2e.
$$

Since the best concept has correlation $1$, $H$ itself is a legal output of
the source whenever

$$
1-2e\ge 2\Gamma_P(s)
\quad\Longleftrightarrow\quad
e\le \frac12-\Gamma_P(s)=\beta_P(s).
$$

Thus after the first weak step, any later same-marginal call that merely
presents the original labels can legally return a hypothesis that makes no
new residual progress.

The same dichotomy applies to more elaborate filler constructions. If the
filler is random or neutral, the best concept's correlation is only the
residual mass and the previous residual-only obstruction applies. If the
filler is predictable, then a deterministic hypothesis can be good enough on
the filler to satisfy

$$
\langle h,\phi\rangle_P
\ge
\sup_{c\in\mathcal C}\langle c,\phi\rangle_P-1+2\Gamma_P(s)
$$

without improving on $E$. The source guarantee is global zero-one/correlation
accuracy; it has no clause saying the excess loss must be spent uniformly or
responsively on the currently wrong region.

This rules out the hoped-for same-marginal residual-responsive proof from the
bare source inequality. It does not rule out a special source learner that
happens to reveal residual information, but it shows the atlas node does not
force such behavior. To force residual progress under the same original
marginal one needs either:

1. a tunable same-marginal oracle whose additive slack is $O(\varepsilon)$, as
   in genuine distribution-specific weak agnostic learning; or
2. a distribution-changing booster that renormalizes the residual mass, which
   brings back the missing envelope over booster-induced marginals.

### Why This Does Not Resolve True

The positive theorem one would like is:

**False target theorem attempt.** Fixed-additive weak agnostic learning over
the original marginal $P$ implies strong realizable improper learning over
$P$ by repeated relabeling.

The residual slack trap gives a direct failure point. Every relabeling has one
of two bad forms:

1. the relabeling concentrates on the residual, in which case the best
   concept's total correlation becomes at most the residual mass and eventually
   falls below the additive floor; or
2. the relabeling pads the residual with easy mass, in which case a legal weak
   output may explain only the padding.

Feldman's same-marginal theorem avoids this only because its weak learner is
not fixed-additive at one scale: it is invoked at the target scale $\alpha$ and
must respond whenever the best concept has advantage $\alpha$. The atlas
source cannot be reparameterized this way. The source's $\Gamma_P(s)$ is fixed
for the marginal and representation size, and the algorithm receives no
accuracy parameter in the weak node.

So the same-marginal branch does not prove the edge true. The remaining
positive route is still the old one: call the source on reweighted residual
marginals and prove a single original-$P$ lower envelope on the weak gaps and
call resources. Depths 2 and 5 explain why current marginal-nonuniform
semantics do not force that envelope.

### Why This Does Not Resolve False

The slack trap is a black-box obstruction, not yet a concept-class
separation. A false edge still needs a class satisfying the source for every
marginal while defeating every strong learner under one fixed original
marginal.

The rare-block idea remains the best shape. Put blocks $B_{n,j}$ of effective
size $N_{n,j}=n^j$ at original masses

$$
w_{n,j}\asymp 2^{-j}n^{-2}.
$$

For a strong learner with fixed $P^\star$-polynomial degree $D$, ask for
$\varepsilon\ll w_{n,j}$ and choose $j>D$. The budget

$$
\operatorname{poly}_{P^\star}(n,1/\varepsilon)
\le 2^{O(j)}n^{O(D)}
$$

cannot inspect or aggregate $n^j$ independent block coordinates. A PRF or
random-code core would then give target hardness for improper deterministic
outputs, assuming the usual efficient-evaluation convention.

The source side still fails in the same place as before. Because the source
quantifies over marginals that isolate $B_{n,j}$ and over low-noise agnostic
labels on that block, the weak learner must produce a deterministic handle
with correlation about $1/n^j$ using only the globally pathwise-polynomial
work allowed by full-support marginals. Plain PRF/random-code blocks do not
have such a handle. Sparse singleton handles have no reliable orientation on
near-balanced marginals unless the learner pays block-scale validation.
Randomized prediction would make the orientation problem much easier, but the
current atlas semantics use deterministic binary hypotheses. Public
orientation certificates make the source plausible only by also giving an
improper learner information it can repeatedly aggregate.

Thus the deterministic-output rare-block construction is still missing the
same object:

$$
\text{cheap under every marginal}
\quad+\quad
\text{orientation-certified}
\quad+\quad
\text{not reusable for improper aggregation}.
$$

I do not see a concrete standard PRF, random-code, parity, or lookup variant
that satisfies all three.

### Depth 7 Directions

1. **Formal same-marginal oracle lower bound.** Prove a black-box theorem:
   any booster that only queries a fixed-additive same-marginal oracle can be
   answered legally while making no guaranteed progress below
   $\beta_P(s)$, unless its queries induce an $O(\varepsilon)$ additive slack
   requirement. This would not resolve the atlas edge, but it would close the
   residual-responsive same-marginal route cleanly.

2. **Minimal deterministic handle testbed.** Build the smallest rare-block
   class with public local orientation certificates, then check whether the
   certificates necessarily let an improper learner aggregate to strong
   accuracy within the original-$P$ polynomial. This should decide whether
   the certificate-vs-aggregation tension is a theorem for sparse handles or
   merely a failure of the current examples.

3. **Envelope from stronger semantics.** Revisit the size-conditional
   marginal semantics separately. If bad conditioned gaps $n^{-j}$ can be
   diagonally stitched into one marginal without being hidden by low mixture
   mass, the same reweighted boosting proof would likely become a
   resolved-true atlas update under that modified semantics.

### Branch Conclusion

Depth 6 rules out the most tempting new positive path: residual-responsive
same-marginal relabeling cannot extract strong realizable learning from the
fixed-additive atlas source. Residual-only labels have too little total
correlation once the error is small, and padded labels allow legal weak
outputs that spend their guarantee off the residual. Distribution-changing
boosting still needs the missing original-marginal envelope.

The false direction is also not complete. Rare blocks still give the right
target-side diagonal pressure, but deterministic weak agnostic source
positivity requires an orientation-certified handle that is not reusable by an
improper aggregator. I do not know such a construction.

VERDICT: unresolved
Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 7 Branch A: Final Consolidation

- date: 2026-05-07
- branch: final allowed depth; consolidate proof state for atlas use
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited
- source output model: deterministic improper weak agnostic hypotheses
- target output model: deterministic improper realizable hypotheses

### Last Resolution Attempt

I tried one last time to make the agnostic strength of the source avoid
distribution-changing boosting. The only plausible route is a same-marginal
residual booster: keep $X\sim P$, relabel examples as a function of the
current residual, and use the weak agnostic learner as a correlation oracle.

For a fixed original marginal $P$, the source gives a number

$$
\beta_P(s)=\frac12-\Gamma_P(s)
$$

and, for every joint distribution with marginal $P$,

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s).
$$

Equivalently, for any same-marginal relabeling with conditional mean
$\phi:X\to[-1,1]$,

$$
\langle h,\phi\rangle_P
\ge
\sup_{c\in\mathcal C}\langle c,\phi\rangle_P-1+2\Gamma_P(s).
$$

This is a fixed-additive oracle, not a scale-responsive weak agnostic oracle.
That distinction is the final obstruction.

### Exact Fixed-Additive Slack Obstruction

There are two equivalent ways to state the obstruction.

First, suppose a same-marginal query tries to simulate a reweighted marginal
$Q$ with density $r=dQ/dP$ by using labels of conditional mean

$$
\phi(x)=\lambda r(x)c(x),
\qquad
0\le \lambda\le \|r\|_\infty^{-1}.
$$

In the realizable case the source guarantee implies only

$$
\lambda\,\Pr_Q[h(X)\ne c(X)]\le \beta_P(s),
$$

or

$$
\Pr_Q[h(X)\ne c(X)]\le \frac{\beta_P(s)}{\lambda}.
$$

This is a weak guarantee under $Q$ only if $\lambda>2\beta_P(s)$. Since
$\lambda\le 1/\|dQ/dP\|_\infty$, same-marginal relabeling can simulate only
density ratios

$$
\left\|dQ/dP\right\|_\infty < \frac{1}{2\beta_P(s)}.
$$

When $\Gamma_P(s)$ is small, $\beta_P(s)$ is close to $1/2$, so the permitted
density ratio is essentially $1$. Real boosting needs ratios on the order of
$1/\varepsilon$ on residual or smooth hard regions. The fixed additive slack
therefore cannot be converted into a reweighted weak oracle at accuracy
$\varepsilon$.

Second, let a current deterministic predictor $H$ have residual error set

$$
E=\{x:H(x)\ne c(x)\},
\qquad
P(E)=e.
$$

A residual-only same-marginal query has

$$
\sup_{f\in\mathcal C}\langle f,\phi\rangle_P\le \mathbb E_P|\phi|\le e.
$$

The source then gives a positive residual correlation only when

$$
e>1-2\Gamma_P(s).
$$

This is useless for driving error to arbitrary $\varepsilon$. Adding filler
outside $E$ does not fix the problem. If the filler is neutral, the best
concept still has only residual-scale correlation. If the filler is easy,
then a legal weak output can satisfy the fixed-additive guarantee by doing
well on the filler and making no progress on $E$. In particular, on the
original labels $c$, the current $H$ itself is already a legal output whenever

$$
1-2e\ge 2\Gamma_P(s)
\quad\Longleftrightarrow\quad
e\le \beta_P(s).
$$

Thus a black-box same-marginal residual booster can stall after the first weak
step. This is not a quirk of one algorithm; it is exactly the difference
between the atlas source and Feldman/Kalai-style distribution-specific
agnostic boosting, where the oracle must respond at a target scale
$\alpha=O(\varepsilon)$.

### Same-Marginal Near Miss

The same-marginal approach is close because the source is agnostic and the
target is only realizable. It also preserves the original marginal, so it
would avoid the main marginal-nonuniform envelope problem. But the source's
additive slack is fixed at $1/2-\Gamma_P(s)$ for the marginal and size. It is
not a tunable $O(\varepsilon)$ slack, nor a multiplicative correlation oracle
with small additive error.

Consequently, same-marginal relabeling proves at most a conditional theorem:
if the source were strengthened so that, for every relabeling over $P$,

$$
\langle h,\phi\rangle_P
\ge
\gamma_P(s)\sup_{c\in\mathcal C}\langle c,\phi\rangle_P
-\epsilon_{0,P}(s,\varepsilon)
$$

with $\gamma_P$ inverse-polynomial and
$\epsilon_{0,P}/\gamma_P=O(\varepsilon)$, then known
distribution-specific agnostic boosting would yield the deterministic
improper realizable target. The actual atlas source has additive slack
$1-2\Gamma_P(s)$ in correlation units, which is a constant-scale floor and
cannot force residual progress below that floor.

### Distribution-Changing Conditional True Principle

The old distribution-changing proof remains valid under an explicit envelope.
Fix a standard realizable booster, for example a smooth or filtered booster.
If for every original marginal $P$ and accuracy $\varepsilon$ there is a
polynomial $r_P$ such that every booster-induced call marginal $Q_t$ before
termination satisfies

$$
\Gamma_{Q_t}(s)\ge \frac{1}{r_P(s,1/\varepsilon)}
$$

and the source learner's one-call sample and time use on those $Q_t$ are also
bounded by $r_P$, then the edge is true. On realizable labels each call has
weak error at most $1/2-1/r_P$, the booster needs only polynomially many
calls, and the final vote over deterministic improper weak hypotheses is a
deterministic improper hypothesis.

The source node does not supply this envelope. It has the pointwise quantifier
pattern

$$
\forall Q\ \exists r_Q,
$$

not one $P$-dependent polynomial controlling all $Q$ reachable from $P$ at
accuracy $\varepsilon$.

### Why The Envelope Is Not Forced

The rare-block obstruction remains the clean diagnostic. Let an original
marginal $P^\star$ put mass

$$
w_{n,j}\asymp 2^{-j}n^{-2}
$$

on blocks $B_{n,j}$ of effective size $N_{n,j}=n^j$. A smooth booster aiming
for $\varepsilon_{n,j}\asymp w_{n,j}$ may legally focus a call on
$B_{n,j}$, since the conditional marginal has density about
$1/w_{n,j}=O(1/\varepsilon_{n,j})$ relative to $P^\star$.

Pointwise marginal nonuniformity permits the conditioned block marginal to
have weak gap

$$
\Gamma_{P^\star(\cdot\mid B_{n,j})}(n)\asymp n^{-j}
$$

for each fixed $j$. If an original-$P^\star$ envelope polynomial had fixed
degree $D$, then at $\varepsilon_{n,j}$ it could grow like a fixed power of
$2^j n^2$, while the conditioned inverse gap is $n^j$. Choosing $j>D$ and
then $n$ large defeats that envelope.

This is not by itself a false witness. It only shows that current
global-mixture marginal semantics do not force the envelope. Under a stronger
size-conditional marginal semantics, the diagonal bad slices might not be
hideable by low mixture mass; in that modified setting the same reasoning may
turn into a true proof via an envelope lemma. Under the current reading, the
envelope is an additional hypothesis, not a consequence.

### Failed False-Witness Routes

The best target-negative template is still a rare-block direct sum. For a
strong learner under $P^\star$ with polynomial degree $D$, ask for accuracy
$\varepsilon\ll w_{n,j}$ and choose $j>D$. Its budget is at most

$$
\operatorname{poly}_{P^\star}(n,1/\varepsilon)
\le 2^{O(j)} n^{O(D)},
$$

which cannot inspect or aggregate $n^j$ independent coordinates for large
$n$. A PRF or random-code core would then give conditional or relativized
hardness for deterministic efficiently evaluable improper outputs.

The source side is where every concrete route fails.

- Plain PRF, LPN, random-code, or random-label blocks are source-negative:
  the source quantifies over marginals concentrated on the hard block, where
  even weak realizable prediction is hard.
- Singleton and bounded lookup handles have a deterministic orientation
  problem. On a near-balanced block, choosing the wrong default label loses
  more mass than a few sampled handles can correct, while detecting the bias
  needs block-scale validation.
- Randomized prediction would largely remove the orientation problem, but the
  source and target here use deterministic binary hypotheses.
- Public orientation certificates make weak agnostic source positivity
  plausible, but the same certificates tend to give an improper strong
  learner reusable information it can aggregate.
- Staged parity variants split the same way: if a robust residual parity
  finder exists under every marginal, an improper learner can reuse it; if the
  residual is hidden cryptographically, the weak agnostic source fails on the
  isolated residual marginal.

So the false direction still lacks the needed object:

$$
\text{every-marginal weak agnostic deterministic handle}
\quad+\quad
\text{orientation certified}
\quad+\quad
\text{not reusable by deterministic improper aggregation}.
$$

I do not know a standard PRF, random-code, parity, PCP, or sparse-lookup
construction with all three properties.

### Proposed Atlas Summary

Proposed edge summary:

> Open. Weak agnostic learning gives weak realizable learning under each
> marginal, but known boosting routes require more uniformity than the current
> marginal-nonuniform source provides. Distribution-changing boosting needs a
> single original-marginal polynomial lower-bounding the weak gaps on all
> booster-induced marginals. Same-marginal agnostic relabeling avoids changing
> the marginal, but the source has fixed additive slack
> $1/2-\Gamma_P(s)$; residual queries of mass $e$ have best correlation at
> most $e$, and padded queries allow legal weak outputs that spend the slack
> away from the residual. Rare-block templates explain why a transcript
> envelope is not forced by global-mixture semantics, but no deterministic
> improper source-positive and target-negative witness is known.

Proposed proof-status body:

> The positive direction is conditional on either a transcript-envelope
> hypothesis for distribution-changing boosters or a stronger same-marginal
> weak agnostic oracle whose additive slack is tunable to $O(\varepsilon)$.
> The standard fixed-additive source only guarantees
> $\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+1/2-\Gamma_P(s)$.
> To simulate a reweighted call $Q$ over the original marginal $P$ by
> relabeling, one must scale by
> $\lambda\le\|dQ/dP\|_\infty^{-1}$, giving only
> $\operatorname{err}_Q(h)\le\beta_P(s)/\lambda$. This is weak only for
> density ratios essentially bounded by $1$ when $\Gamma_P(s)$ is small, while
> residual and smooth boosters need ratios of order $1/\varepsilon$.
> Conversely, rare-block/handle attempts give target-side diagonal pressure
> but fail to prove the source: hard blocks are not weak agnostically
> learnable on isolated marginals, and deterministic sparse handles require
> orientation or validation at the weak-gap scale. The edge therefore remains
> open under the present deterministic improper semantics.

### Final Status

No complete proof of the implication and no complete separation emerged at
depth 7. The most accurate atlas status is still `open`, with the explanatory
body centered on the fixed-additive slack obstruction, the missing
transcript-envelope hypothesis, and the unresolved deterministic handle
counterexample problem.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md
