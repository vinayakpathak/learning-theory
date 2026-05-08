## Depth 1 Branch A: Middle-Noise Selector Obstruction

The edge still looks unresolved. The distribution-free source strengthens the
low-noise branch, but I do not see a way to turn clean proper learning into the
fixed-marginal proper selector needed for arbitrary agnostic labels.

Let $A$ be an efficient distribution-free strong realizable proper learner for
$\mathcal C$. Fix a marginal $P$ and an agnostic distribution $\mathcal D$ with
that marginal. Write

$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
$$

and choose $c^\star\in\mathcal C$ with error near $\eta$.

### Low-Noise Branch

Run $A$ at a constant clean accuracy, say $\varepsilon_0=1/16$, and let
$m(s)$ be the resulting uniform polynomial transcript/sample bound. If
$\eta$ is below a scale

$$
\alpha(s)\ll 1/m(s),
$$

then couple a noisy run on $(X,Y)\sim\mathcal D$ to a clean realizable run on
$(X,c^\star(X))$ using the same original $P$-distributed instance sequence and
the same internal randomness. With inverse-polynomial probability no inspected
label differs from $c^\star(X)$. On that event the noisy transcript equals a
successful clean transcript, so the output is a proper $h\in\mathcal C$ with

$$
\Pr_P[h(X)\ne c^\star(X)]\le \varepsilon_0.
$$

Therefore

$$
\operatorname{err}_{\mathcal D}(h)
\le \eta+\varepsilon_0,
$$

which is within

$$
\eta+\frac12-\gamma(s)
$$

for any inverse-polynomial $\gamma(s)$ chosen below the constant slack. Repeating
independent runs and validating on a fresh labeled sample finds such a candidate
with high probability. This part is stronger than the marginal-nonuniform target:
the source polynomial is distribution-free.

### Why The Branch Does Not Extend

The remaining regime is $\eta\ge \alpha(s)$. In $\{\pm1\}$ notation, the weak
agnostic target asks for a proper $h$ whose correlation satisfies

$$
\mathbf E[h(X)Y]\ge
\sup_{c\in\mathcal C}\mathbf E[c(X)Y]+2\gamma_P(s)-1.
$$

If $\gamma_P(s)\le \alpha(s)$ and $\eta\ge\alpha(s)$, then the right side can be
nonpositive. Thus the target only needs a legal hypothesis that is not too
anti-correlated with the labels. For improper output, the two constants solve
this: one constant has error at most $1/2$. For a proper target, constants,
complements, or any comparable neutralizer need not be in $\mathcal C$.

The realizable proper learner supplies clean decoding, not a middle-noise
neutralizer. Feeding $A$ the agnostic labels is off-promise. When
$\eta=\Theta(1)$, an all-clean transcript for a polynomial-size run can have
exponentially small probability, so low-noise repetition no longer gives an
inverse-polynomial candidate source. Validation can choose among candidates, but
it cannot manufacture a legal candidate if the generator only returns concepts
that are anti-correlated on the current residual label rule.

This also blocks the obvious cover route. Information-theoretically, finite VC
dimension and fixed-marginal covers are enough for agnostic proper learning once
computation is ignored. Computationally, generating a cover by running the clean
learner over many labelings of an unlabeled sample is generally exponential, and
the target still requires a polynomial bound for each fixed marginal.

### Near-Miss False Witnesses

The standard hard classes do not settle the edge.

- Parities under the uniform marginal are cleanly and properly learnable, and
  noisy parity recovery may be hard. But wrong parities are neutral. In the
  middle-noise regime, a neutral wrong parity already satisfies the additive
  weak target; in the very-low-noise regime, the clean-transcript coupling
  applies.
- Monomial/conjunction weak agnostic hardness has the right flavor, but the
  known reductions either use distributional freedom or constant-noise gaps. The
  atlas target may choose an inverse-polynomial weak gap smaller than that
  constant noise, making the required additive guarantee much weaker than
  classical weak agnostic recovery.
- PCP active-slice and one-way/code templates make exact proper recovery hard,
  but they either put the instance identity into the marginal, dilute the hard
  slice when packed into one marginal, or leak legal weak handles and neutral
  wrong hypotheses.

Thus a false witness would need more than noisy recovery hardness. It must make
every proper hypothesis meeting even the very weak middle-noise threshold decode
hard information, while preserving efficient distribution-free clean proper
learning.

### Conditional Positive Criterion

The edge would become true under an additional fixed-marginal proper selector.
For example, suppose that for every $P$ there is one uniform candidate generator
with $P$-dependent polynomial runtime that, from samples with marginal $P$,
produces a polynomial list $L$ such that for every conditional label rule with
$\operatorname{OPT}_{\mathcal C}\ge\alpha_P(s)$,

$$
\max_{h\in L}\mathbf E[h(X)Y]\ge
\sup_{c\in\mathcal C}\mathbf E[c(X)Y]+2\gamma_P(s)-1.
$$

Then the low-noise coupling handles $\operatorname{OPT}<\alpha_P(s)$, the list
handles the remaining cases, and validation selects the best legal candidate.
Proper constants, an efficiently findable complement-pair anchor, an approximate
balanced sampler over $\mathcal C$, or a searchable weak shadow cover are all
special cases. None follows from the source node as stated.

### Depth 2 Directions

1. Formalize the selector criterion above as a reusable conditional lemma, with
   the exact relation among $\alpha_P$, $\gamma_P$, validation sample size, and
   list size.

2. Try to prove or refute the lemma "efficient distribution-free realizable
   proper learning yields an efficient fixed-marginal weak shadow cover." The
   known HKLM-style cover construction is the right sample-level analogy, but
   its cover-generation step appears computationally too expensive.

3. Search for an all-weak-handles-decode construction: one fixed marginal, clean
   proper decoding in polynomial time, no constants or complement anchors, and a
   middle-noise label family where every legal hypothesis above the additive weak
   threshold reveals a hard witness.

For now, the atlas edge should remain `open`: low-noise coupling is solid, but
middle-noise proper selection is neither supplied by the source nor refuted by a
known witness.

VERDICT: unresolved

## Depth 2 Branch A: Strong Clean Learning Still Does Not Select

Depth 1 survives the stronger-source check. The word "strong" is useful, but
it seems useful only on the clean or very-low-noise side. It does not by itself
create the legal proper neutralizer needed when the best concept has
middle-sized agnostic error.

Let $A$ be the distribution-free strong realizable proper learner. Besides the
low-noise coupling from Depth 1, strongness gives the following extra tool.

### What Strongness Really Adds

For every polynomial-size labeled sample $S$ that is realizable by some
$c\in\mathcal C$, we can simulate draws from the uniform distribution on $S$ and
run $A$ with accuracy $\varepsilon<1/(3|S|)$. With constant probability the
proper output is consistent with all of $S$. Thus the source supplies a
randomized polynomial-time proper consistency oracle for polynomial-size clean
samples.

This is stronger than weak realizable learning, but it is still a clean-sample
oracle. If the labels are not realizable, the oracle has no promised behavior.
Using it for agnostic data therefore requires either finding a sufficiently
large clean subset or enumerating enough label corrections.

### Failed Positive Route: Clean Subsamples

Fix a marginal $P$ and a joint distribution $\mathcal D$ with optimal concept
$c^\star$ and

$$
\eta=\operatorname{err}_{\mathcal D}(c^\star)
=\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

To satisfy the weak agnostic target by comparison with $c^\star$, it is enough
to produce a proper $h$ with

$$
\Pr_P[h(X)\ne c^\star(X)]\le \frac12-\gamma_P(s),
$$

because then

$$
\operatorname{err}_{\mathcal D}(h)
\le \eta+\Pr_P[h(X)\ne c^\star(X)]
\le \eta+\frac12-\gamma_P(s).
$$

A generic distribution-free way to obtain such an $h$ from clean labels needs a
VC-scale or source-learner-scale clean sample, say

$$
k \simeq m(s,1/\gamma_P)
$$

examples. In the middle-noise regime $\eta\ge \alpha(s)$, the probability that
a random $k$-sample from $\mathcal D$ has no corruptions relative to $c^\star$
is

$$
(1-\eta)^k\le \exp(-\eta k).
$$

For $k=\operatorname{poly}(s)$ and $\eta$ inverse-polynomial or constant, this
is not generally inverse-polynomial. It can be exponentially small. Repeating
the clean-subsample trick therefore only proves the Depth 1 low-noise branch,
where $\eta k\ll 1$.

Enumerating corrections is the same problem in another form. On a
polynomial-size agnostic sample, a near-optimal concept disagrees with about
$\eta k$ labels. Trying all plausible corrected labelings costs roughly
$2^{H(\eta)k}$ in the middle-noise regime. The consistency oracle can certify a
chosen corrected labeling, but it does not make the search polynomial.

So strong proper realizability gives an efficient clean consistency oracle, not
an efficient agnostic proper ERM or weak selector.

### Failed Positive Route: Anchors And Self-Labeling

One can obtain at least one legal concept by running the proper learner on
synthetic data on which it returns some $h_0\in\mathcal C$, or by taking any
proper output that the implementation emits. If $h_0$ validates against the
agnostic labels, the learner is done.

The hard case is exactly when $h_0$ is too anti-correlated with the labels. Then
the informal neutralizer would be $-h_0$, a complement, a mixture, or a pasted
classifier that follows $h_0$ on some region and another concept elsewhere.
None of these need be in $\mathcal C$.

Filtering on the disagreement event $\{Y\ne h_0(X)\}$ also does not solve the
problem under arbitrary agnostic noise. In favorable random-noise examples, that
event can enrich clean labels from $c^\star$. In the atlas target, the
conditional label rule is arbitrary. The conditional corruption rate on the
filtered marginal can remain constant, and the proper learner is still being
called off-promise. Distribution-free strong realizability lets $A$ handle the
new marginal if the labels are clean; it does not make the filtered labels
clean.

Thus a known anchor helps only when the class has extra closure or neutralizer
structure, such as constants, complements, symmetric differences with the
anchor, or an efficient projection/pasting operation back into $\mathcal C$.

### Failed Positive Route: Fixed-Marginal Covers

Ignoring computation, finite VC dimension plus a fixed marginal gives the usual
proper agnostic route: build a finite $L_1(P)$ cover of the traces of
$\mathcal C$, validate the cover, and output a near-best proper element. The
source node implies the relevant sample-complexity finiteness.

Computationally this does not follow. A cover at weak scale may require
examining labelings of a sample of size $\Theta(d/\gamma_P^2)$, and the clean
consistency oracle only tells us how to realize one labeling once it is chosen.
It does not enumerate the realizable traces in polynomial time. A
marginal-dependent polynomial may have an arbitrary fixed degree depending on
$P$, but it still cannot hide a generic $2^{s^a}$ trace search.

This is the sharp distinction between sample-only marginal nonuniformity and
the computational atlas node.

### Conditional Positive Lemma

The edge would be true with one additional fixed-marginal proper selector.
One clean statement is:

> For every marginal $P$ there is one uniform candidate generator $G$, with
> $P$-dependent polynomial sample and time bounds, and inverse-polynomial
> functions $\alpha_P,\gamma_P$, such that for every joint distribution
> $\mathcal D$ with marginal $P$ and
> $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, the generator
> outputs a polynomial-size list $L\subseteq\mathcal C$ satisfying
> $$
> \min_{h\in L}\operatorname{err}_{\mathcal D}(h)
> \le
> \operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s).
> $$

Then the target learner is straightforward. In the low-noise branch
$\operatorname{OPT}<\alpha_P$, use the coupling/clean-transcript argument from
Depth 1, choosing $\alpha_P$ below the reciprocal of the relevant source sample
bound. In the remaining branch, run $G$. In both branches, validate the
polynomial candidate list on fresh labeled data and output the empirically best
proper candidate.

Concrete extra structures that imply such a selector include:

1. an efficiently findable proper neutralizer list under $P$, for example
   constants, complement pairs, or a polynomial list $N_P\subseteq\mathcal C$
   such that every label rule has some $n\in N_P$ with correlation at least
   $-\alpha_P$;
2. efficient fixed-marginal approximate proper ERM, or a computable
   $L_1(P)$ trace cover by valid concepts at weak scale;
3. algebraic closure that turns a known anchor and a weak external predictor
   into a legal concept, such as efficient complement, symmetric-difference,
   restriction, or projection operations.

None of these structures is forced by the source definition.

### What A False Witness Must Block

A counterexample must be stronger than ordinary noisy-learning hardness. Since
the target may choose an arbitrarily small inverse-polynomial weak gap for the
fixed marginal, a false witness must block every polynomial-time findable
proper handle with inverse-polynomial usefulness.

More concretely, it would need a fixed marginal $P^\star$ and middle-noise label
rules $Y_z$ such that:

1. clean labels from every $c_z\in\mathcal C$ remain efficiently and properly
   learnable distribution-free;
2. for agnostic labels $Y_z$ over $P^\star$, every proper hypothesis satisfying
   $$
   \operatorname{err}(h)\le
   \operatorname{OPT}_{\mathcal C}(Y_z)+\frac12-\frac1{\operatorname{poly}(s)}
   $$
   either decodes the hard witness $z$ or is itself computationally hard to
   find;
3. there are no cheap legal escape routes: constants, complements, wrong-length
   hypotheses, sparse overlaps, random code correlations, or polynomial-size
   residual handles must all fail or be hard to locate;
4. the hard instance must live in the labels, not in an input-dependent
   marginal, because marginal nonuniformity would otherwise absorb the
   instance-specific search cost into $p_P$.

Pure geometry is unlikely to be enough in the finite-encoded atlas setting.
Large families with all wrong concepts negatively correlated below every hidden
inverse-polynomial threshold run into Gram/heavy-atom style barriers, and
approximate codes tend to leave residual inverse-polynomial correlations that
are already legal weak handles. The remaining negative route is therefore a
computational weak-handle lower bound: weak handles may exist
information-theoretically, but finding any one should solve the hard problem.

I do not know an atlas-ready witness with these properties.

### Depth 3 Directions

1. Formalize the conditional selector lemma above as an argument note. Track
   the exact relation between the low-noise scale $\alpha_P$, the weak gap
   $\gamma_P$, source sample bound $m(s,1/\varepsilon)$, list size, and
   validation sample size.

2. Search specifically for computational weak-handle hardness under one fixed
   marginal. Average-case CSP, code-correlation, or LPN-style constructions
   would need to show that even finding a tiny legal proper correlation solves
   the hard task, not merely that exact recovery is hard.

3. Map positive structure classes. The edge should be marked true for subclasses
   with constants/complements, fixed-marginal proper ERM, computable trace
   covers, SQ-style noise tolerance, or efficient projection back into
   $\mathcal C$. This may isolate the minimal neutralizer assumption missing
   from the general source node.

Atlas status should remain `open`. Strong distribution-free proper
realizability gives low-noise robustification and clean consistency search, but
I do not see a derivation of the middle-noise proper agnostic selector. I also
do not see a finite-encoded false witness that blocks all inverse-polynomial
proper handles while preserving efficient clean proper learning.

VERDICT: unresolved

## Depth 3 Branch A: Consistency Is Not A Selector

I still do not see an atlas-ready resolution. The clean consistency oracle from
strong proper realizability is genuinely useful, but every attempt to turn it
into a middle-noise proper selector runs into the same missing operation:
finding a legal concept that is not too anti-correlated with arbitrary labels.

I will use $\{\pm1\}$ notation. For a fixed marginal $P$, write

$$
\rho(h)=\mathbf E[h(X)Y],
\qquad
\rho^\star=\sup_{c\in\mathcal C}\mathbf E[c(X)Y]
=1-2\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

The target with weak gap $\gamma_P(s)$ asks for a proper $h$ with

$$
\rho(h)\ge \rho^\star-1+2\gamma_P(s).
$$

If $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$ and
$\gamma_P\le \alpha_P/2$, it is enough to find a proper $h$ with
$\rho(h)\ge -\alpha_P(s)$. This is the neutralizer form of the middle-noise
problem. The source learner gives a way to decode almost-clean labels from a
near-best $c^\star$, but it does not obviously give such a neutralizer.

### Mistake-Region Conditioning Does Not Escape Low Noise

The most tempting new positive route is to start from any legal anchor
$h_0\in\mathcal C$, validate it, and if it fails, use its mistake region

$$
M_0=\{x:h_0(x)\ne Y\}
$$

as a filter. If $h_0$ fails the weak target, then

$$
e_0:=\Pr[h_0(X)\ne Y]>\eta+\frac12-\gamma_P.
$$

In particular $M_0$ has mass above $1/2-\gamma_P$ unless $\eta$ is tiny. If one
could learn $c^\star$ on the conditional marginal $P\mid M_0$, then a proper
concept close to $c^\star$ on $M_0$ would be globally useful: if $h$ has
conditional disagreement $\zeta$ from $c^\star$ on $M_0$, then

$$
\Pr_P[h(X)\ne c^\star(X)]
\le (1-e_0)+\zeta e_0.
$$

Thus constant conditional accuracy would suffice whenever $e_0$ is noticeably
larger than $1/2$. This looks like a selector/neutralizer mechanism.

The catch is the conditional label noise. On $M_0$,

$$
\Pr[Y\ne c^\star(X)\mid M_0]\le \eta/e_0.
$$

The clean-transcript argument for the source learner needs this conditional
noise to be below the reciprocal of the relevant source transcript/sample
bound. Since $e_0\le 1$, this again requires $\eta$ itself to be in the
Depth 1 low-noise regime. For genuine middle noise, the learner is still being
called off-promise. The filtering idea would work for classes with an additional
proper noise-tolerant learner on conditional marginals, but that is extra
structure, not a consequence of clean proper PAC learnability.

### Consistency Search Is Still Minimum Disagreement

Strong proper realizability also gives a randomized one-sided consistency
oracle for polynomial clean samples: if a sample is realizable, repeated runs of
the source learner at accuracy below $1/|S|$ find a proper hypothesis consistent
with it; if a returned hypothesis is checked directly, false positives can be
rejected.

This still does not solve the agnostic selector problem. On an agnostic sample
of size $n$, a near-optimal concept disagrees with about $\eta n$ labels.
Using the oracle requires first guessing which labels to ignore or correct.
The number of plausible correction patterns is roughly

$$
\sum_{j\le \eta n}\binom nj,
$$

which is exponential for middle-noise $\eta$ and polynomial $n$. Validation can
choose among a polynomial list of oracle outputs, but the consistency oracle
does not generate that list. This is exactly the computational gap behind the
sample-only realizable-to-agnostic reduction: one can enumerate all labelings of
an unlabeled sample and then validate, but the enumeration is
$2^{m_A(s,O(1))}$.

Marginal nonuniformity does not hide this cost. The polynomial $p_P$ may have
$P$-dependent constants and degree, but it still cannot absorb a generic
$2^{s^a}$ trace or correction search as $s$ grows.

### Compression And Covers Need Extra Effectivity

A polynomial, efficiently decodable compression scheme would change the picture:
enumerate compressed messages, run the proper decoder, and validate the
resulting concepts. But the source definition does not imply such a compression
scheme. It implies only polynomial clean sample and time bounds, hence finite
VC dimension at the relevant representation scale. General VC cover or
compression constructions are sample-theoretic; their decoding/enumeration can
be exponential in that dimension, and the dimension itself may be polynomial in
$s$.

Even a weak cover at radius just below $1/2$ is not automatically small or
computable. Under the uniform marginal, parities illustrate that positive
correlation balls can require exponentially many centers. Parities are not a
false witness because wrong parities are neutral and therefore satisfy the
middle-noise weak target. The example is still useful: it shows that "weak
cover" and "weak neutralizer" are different objects. The target can survive
without covering the best concept, but only if the algorithm can find a legal
nearly neutral concept.

### Current Hardness Results Still Miss This Edge

Distribution-free weak agnostic hardness for monomials/conjunctions has the
right consistency-versus-min-disagreement flavor: consistency is easy, while
finding a weakly agreeing hypothesis is hard. But the known reductions vary the
example distribution with the hard instance. The marginal-nonuniform target
allows the polynomial bound to depend on that marginal, so such reductions do
not refute this fixed-marginal edge.

Fixed-marginal halfspace hardness under Gaussian marginals is also not enough
in its current form. Those lower bounds are for achieving $\operatorname{OPT}
+\varepsilon$ with small $\varepsilon$, or for distribution-free weak learning
where the marginal can vary. The atlas target here permits the much weaker
additive error $\operatorname{OPT}+1/2-\gamma_P(s)$. A lower bound with
$\varepsilon\ll1$ does not rule out a marginal-dependent polynomial-time
algorithm at additive tolerance nearly $1/2$.

### Sharper False-Witness Requirements

A false witness must force every polynomial-time legal output to decode hard
information, not merely make exact or near-OPT recovery hard. More explicitly,
for one fixed marginal $P^\star$ it should provide label rules $Y_z$ and
near-best concepts $c_z$ such that:

1. $\mathcal C$ remains efficiently distribution-free strongly properly
   learnable in the clean realizable model.

2. The hard labels live in the conditional rule $Y_z\mid X$, not in the
   marginal. Otherwise marginal nonuniformity can bake the instance-specific
   search cost into $p_{P}$.

3. Every proper $h$ satisfying

   $$
   \operatorname{err}(h)
   \le
   \operatorname{OPT}_{\mathcal C}(Y_z)+\frac12-\frac1{\operatorname{poly}(s)}
   $$

   either reveals useful information about $z$ or is itself hard to find.

4. Neutral wrong hypotheses must be absent or computationally hidden. If
   $\eta_z=\operatorname{OPT}(Y_z)\ge\alpha$ and a wrong $h$ has
   $\mathbf E[hY_z]\ge 0$, then it already satisfies the weak target whenever
   $\gamma\le\eta_z$. Ordinary code orthogonality is therefore too weak for a
   separation.

5. Small active-slice hardness is insufficient. If the hard part has marginal
   mass $\mu$ and a wrong concept loses only that slice relative to $c_z$, then
   its correlation is at worst $\rho^\star-2\mu$. It is excluded by the weak
   target only when

   $$
   2\mu>1-2\gamma,
   $$

   so the hard component must occupy essentially more than half the mass, or
   the construction must make cheap wrong concepts bad outside the hard slice
   too.

6. Pure pairwise geometry seems blocked. An exponentially large family cannot
   have all wrong codewords inverse-polynomially negatively correlated with
   every target under a symmetric fixed marginal without running into
   positive-semidefinite Gram constraints. The likely negative route is
   computational: weak handles may exist information-theoretically, but finding
   any legal one should solve the hard problem.

This is a narrower target than "agnostic learning is hard." It is a
fixed-marginal, all-weak-handles-decode lower bound for a class whose clean
proper consistency problem is polynomial-time solvable.

### Depth 4 Directions

1. Formalize the fixed-marginal weak-selector game. Prove that low-noise
   coupling plus a polynomial-time selector/list generator for the game is
   equivalent to the desired target, up to validation error. This would isolate
   the exact missing lemma.

2. Stress-test mistake-region conditioning under additional assumptions:
   random classification noise, Massart noise, SQ-tolerant classes, or proper
   conditional noise-tolerant learners. A positive theorem for those subclasses
   would clarify why arbitrary agnostic labels are the blocker.

3. Try to build one fixed-marginal anti-neutral witness. Start with a cleanly
   decodable class such as parities/codes, then modify it so that every
   polynomial-time findable nondecoded proper concept is negatively correlated
   with the hard labels on more than half the mass, while avoiding constants,
   complements, and other legal escape handles.

For now the edge should stay open. The source gives low-noise robustification,
clean consistency, and sample-only covers, but I do not see a polynomial
middle-noise proper selector. Conversely, the false direction needs a stronger
fixed-marginal weak-handle lower bound than the standard agnostic hardness
templates currently provide.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 4: Selector Game And Anti-Neutral Stress Test

I do not have a resolution. The cleanest progress from this depth is a more
formal reduction of the edge to a fixed-marginal weak-selector game, plus a
sharper reason why the most tempting anti-neutral code witnesses cannot work by
geometry alone.

### Fixed-Marginal Weak-Selector Game

Use $\{\pm1\}$ notation. For a fixed marginal $P$ and a joint distribution
$\mathcal D$ with marginal $P$, write

$$
\rho(h)=\mathbf E[h(X)Y],
\qquad
\rho^\star=\sup_{c\in\mathcal C}\mathbf E[c(X)Y]
=1-2\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

The target asks for a proper $h$ with

$$
\rho(h)\ge \rho^\star-1+2\gamma_P(s).
$$

Let $A$ be the distribution-free strong realizable proper learner. Fix a
constant clean accuracy, say $1/32$, and let $m_A(s)$ be a polynomial upper
bound on the number of labels inspected by a successful run at constant
confidence. Choose

$$
\alpha(s)\le \frac{1}{100m_A(s)}.
$$

The already-established coupling handles $\operatorname{OPT}<\alpha$: with
constant probability the agnostic transcript has no corrupted inspected label
relative to a near-optimal $c^\star$, so $A$ returns a proper hypothesis close
to $c^\star$ under the original marginal $P$. Repetition plus validation gives
a legal weak candidate.

Thus the remaining object is exactly:

> **Middle-noise selector.** For every fixed marginal $P$, produce in
> $P$-dependent polynomial time a polynomial-size list $L\subseteq\mathcal C$
> such that for every joint distribution with marginal $P$ and
> $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge\alpha(s)$,
> $$
> \max_{h\in L}\rho(h)\ge \rho^\star-1+4\gamma_P(s)
> $$
> for some inverse-polynomial $\gamma_P$.

Given such a selector, the edge is true: run the low-noise generator and the
selector, validate all candidates on a fresh labeled sample to accuracy
$\gamma_P$, and output the empirically best proper hypothesis. Conversely, any
learner satisfying the target is a singleton-list middle-noise selector when
restricted to $\operatorname{OPT}\ge\alpha$. So the selector game is equivalent
to the missing part of the target, modulo the low-noise branch and validation
slack.

This equivalence is useful mostly because it shows why the source learner has
not been used enough. On a finite unlabeled sample $U=(x_1,\ldots,x_n)$, the
selector is an approximate linear-optimization problem over the trace set

$$
V_U=\{(c(x_1),\ldots,c(x_n)):c\in\mathcal C\}.
$$

Given labels $y\in\{\pm1\}^n$, the empirical version wants a trace
$v\in V_U$ with

$$
\langle v,y\rangle/n
\ge
\sup_{u\in V_U}\langle u,y\rangle/n - 1 + O(\gamma_P).
$$

Strong realizable proper learning gives a way to realize a trace after a
promising trace or corrected labeling has already been specified: run $A$ at
accuracy below $1/n$ and reject outputs not consistent with the proposed clean
sample. It does not give a linear-optimization oracle over $V_U$. The gap
between "realize this clean trace" and "find any trace that is not too
anti-correlated with arbitrary labels" is precisely the computational content
of the open edge.

### Mistake-Region Conditioning Still Needs A Selector

I pushed the anchor/mistake-region route one step further. Let $h_0\in\mathcal
C$ be any legal anchor. If validation shows that $h_0$ fails the weak target,
then

$$
e_0:=\Pr[h_0(X)\ne Y]>\eta+\frac12-\gamma_P,
\qquad
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

For an optimal $c^\star$, the triangle inequality gives

$$
\Pr_P[h_0(X)\ne c^\star(X)]\ge e_0-\eta>\frac12-\gamma_P.
$$

So a failing anchor certifies that some good concept lives mostly on the other
side of $h_0$. This is tempting: sample from the observed mistake event
$M_0=\{Y\ne h_0(X)\}$ and try to learn there.

The obstruction is sharper than before. Conditional on $M_0$, the observed
label is deterministically $-h_0(X)$, while the desired clean label
$c^\star(X)$ is corrupted at rate at most

$$
\Pr[Y\ne c^\star(X)\mid M_0]\le \eta/e_0.
$$

For genuine middle noise this can be a constant. To force useful global
behavior from a clean learner on $P\mid M_0$, one needs enough clean
constraints to generalize on that conditional marginal. A VC/source-scale
number of constraints has all-clean probability roughly

$$
(1-\eta/e_0)^k,
$$

which is exponentially small when $k$ is polynomial and $\eta/e_0$ is bounded
away from zero. Taking only $O(\log s)$ constraints keeps the all-clean event
polynomially visible, but then a high-dimensional trace class can satisfy those
few constraints while remaining badly anti-correlated elsewhere. Validation can
discard bad outputs; it cannot ensure that the consistency oracle ever
generates the good regional complement.

The patching version has the same missing operation. The classifier that
flips $h_0$ on the bad region, or follows a learned concept on $M_0$ and $h_0$
elsewhere, is not necessarily in $\mathcal C$. Thus the route becomes valid
only under extra closure assumptions: complements, restrictions, symmetric
differences with an anchor, or a proper projection/pasting oracle.

### Anti-Neutral Code Witnesses Hit A Bessel Barrier

I also tried to make the false direction more concrete by starting from a
cleanly decodable code family, such as parities or Hadamard codewords under a
fixed marginal, and then modifying the agnostic label rule so that every
nondecoded proper concept becomes negatively correlated.

For orthonormal code families this is impossible at the inverse-polynomial
scale by a simple calculation. Let

$$
\phi_z(x)=\mathbf E[Y_z\mid X=x]\in[-1,1]
$$

be the conditional label mean for the hard label rule, and let
$c_1,\ldots,c_M$ be orthonormal legal concepts in $L_2(P)$. The correlations

$$
a_i=\mathbf E[c_i(X)\phi_z(X)]
$$

satisfy Bessel's inequality:

$$
\sum_{i=1}^M a_i^2\le \|\phi_z\|_2^2\le 1.
$$

If a witness tried to make one target concept have noticeable positive
correlation while every wrong codeword had correlation at most
$-\gamma(s)$, then

$$
(M-1)\gamma(s)^2\le 1.
$$

For exponentially many codewords and inverse-polynomial $\gamma$, this is
false. So the pure anti-neutral plan cannot work for parity/Hadamard-like
geometry. It can make wrong codewords neutral, but neutral wrong codewords are
already legal weak outputs in the middle-noise regime.

For nonorthogonal dense codes the same issue appears through the Gram matrix:
one can hide correlations below a chosen polynomial scale on a polynomial
coordinate block, but the target's marginal-dependent weak exponent is hidden.
Driving all wrong correlations below every possible inverse-polynomial scale
requires Hadamard/Plotkin-like geometry or superpolynomial coordinate length,
which breaks the finite-encoded polynomial-time source side.

This does not rule out a counterexample. It says the counterexample cannot be
"all wrong proper hypotheses are bad" by pairwise geometry. It must be
computational: weak handles may exist, perhaps many of them, but finding any
legal one with enough correlation should solve the hard problem. The standard
templates still miss that target. Parities have easy random neutral handles;
shared PCPs have wrong-instance or all-one handles; active-slice PCPs lose mass
under one fixed marginal; one-way coordinate classes leak wrong-length or
bounded-support handles; Gaussian halfspace lower bounds currently give strong
fixed-marginal agnostic hardness, not the nearly-$1/2$ additive weak selector
lower bound needed here.

### Current Obstacles

1. The fixed-marginal selector is equivalent to the unresolved middle-noise
   target, and strong clean proper learning only gives consistency after a
   trace has been guessed.

2. Mistake-region conditioning finds a meaningful region only when an anchor
   fails, but learning on that region still faces middle agnostic noise unless
   the class has extra noise tolerance or closure.

3. Pure anti-neutral coding cannot eliminate all inverse-polynomial weak
   handles for large cleanly decodable families; Bessel/Gram constraints force
   neutral or mildly correlated wrong hypotheses to exist.

4. Known hardness sources either vary the marginal, prove only strong
   fixed-marginal agnostic hardness, or leave easy legal weak handles.

### Next Directions

1. Turn the selector game above into an atlas argument note or lemma with exact
   slack constants: low-noise threshold $\alpha$, selector gap $\gamma_P$, list
   size, and validation sample size.

2. Look for a genuine fixed-marginal computational weak-handle lower bound:
   not a construction where every wrong concept is anti-correlated, but one
   where finding any neutral-or-positive proper handle is itself hard.

3. Prove positive subclasses from explicit extra structure: cost-sensitive
   optimization over traces, computable $L_1(P)$ proper covers, complements,
   restriction/pasting closure, SQ or Massart noise tolerance, or a sampler
   whose barycenter is a proper neutralizer under $P$.

4. Formalize the Bessel/Gram obstruction for shared-code witnesses, so future
   false attempts can focus on computational hidden-handle hardness rather than
   impossible all-wrong-negative geometry.

I would keep the atlas edge open. Depth 4 isolates the missing lemma more
cleanly, but it neither derives the selector from the strong proper realizable
learner nor supplies a fixed-marginal counterexample.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 5C: Positive Structure Routes

I tried to make the positive side as explicit as possible. The result is a
small menu of conditional theorems: each listed structure would prove the
edge, but I do not see any route by which efficient strong realizable proper
PAC learning alone forces that structure.

Throughout this section I use $\{\pm1\}$ labels. For a fixed marginal $P$ and
joint distribution $\mathcal D$, write

$$
\rho(h)=\mathbf E[h(X)Y],
\qquad
\rho^\star=\sup_{c\in\mathcal C}\mathbf E[c(X)Y],
\qquad
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
=\frac{1-\rho^\star}{2}.
$$

The target with weak gap $\gamma_P(s)$ is equivalent to

$$
\rho(h)\ge \rho^\star-1+2\gamma_P(s)=2(\gamma_P(s)-\eta).
$$

Let $A$ be the strong distribution-free realizable proper learner. Fix a
constant clean accuracy and let $m_A(s)$ be the corresponding polynomial
transcript/sample bound. As in the previous depths, choose

$$
\alpha(s)\le \frac{1}{100m_A(s)}
\quad\text{and}\quad
\gamma_P(s)\le \alpha(s)/4.
$$

The low-noise branch $\eta<\alpha$ is handled by coupling the noisy run to a
clean realizable run for a near-optimal $c^\star$. Thus all positive routes
below only need to solve the middle-noise branch $\eta\ge\alpha$. In that
branch the target inequality is implied by the neutralizer condition

$$
\rho(h)\ge -\alpha/2,
$$

after allowing a small validation slack. This is the useful simplification:
the extra structure does not need to agnostically optimize well; it only needs
to find a legal concept that is not too anti-correlated with the labels.

### Route 1: Weak Cost-Sensitive Trace Optimization

Assume that for every fixed marginal $P$ there is one uniform algorithm with
$P$-dependent polynomial bounds that, on a labeled sample
$(x_i,y_i)_{i=1}^n$, outputs $h\in\mathcal C$ satisfying

$$
\frac1n\sum_i h(x_i)y_i
\ge
\max_{c\in\mathcal C}\frac1n\sum_i c(x_i)y_i - 1 + 6\gamma_P(s).
$$

This is a very weak cost-sensitive optimizer over the trace set: it may lose
almost the whole $[-1,1]$ objective range. Still, standard VC uniform
convergence for the source class lets us take $n$ polynomial in the source
sample dimension and $1/\gamma_P$. With empirical-population error at most
$\gamma_P$, the returned $h$ has

$$
\rho(h)\ge \rho^\star-1+4\gamma_P(s),
$$

and holdout validation absorbs the remaining slack. Combined with the
low-noise branch, this proves the target.

This assumption does not follow from the source. The source learner gives
proper consistency or high agreement when the trace with score $1$ is promised
to exist. It does not optimize, even weakly, over arbitrary signed traces.
Equivalently, it can realize a guessed clean trace; it does not find a useful
trace for arbitrary labels.

### Route 2: Computable $L_1(P)$ Proper Covers

Assume that for every fixed marginal $P$ and every inverse-polynomial
$\gamma_P$ there is a $P$-polynomial-time generator for a polynomial list
$L_P\subseteq\mathcal C$ such that every $c\in\mathcal C$ has some
$h\in L_P$ with

$$
\Pr_P[h(X)\ne c(X)]\le \frac12-3\gamma_P(s).
$$

Then validation over $L_P$ gives a proper hypothesis with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)
+\frac12-2\gamma_P(s),
$$

and a fresh holdout sample leaves the requested
$\operatorname{OPT}+1/2-\gamma_P$ guarantee. This route is stronger than
needed in the middle-noise branch because it shadows the best concept rather
than merely finding a neutral legal concept.

This also does not follow from efficient realizable proper PAC learning. The
source implies the usual sample-level finiteness behind $L_1(P)$ covers, but a
generic cover construction may require enumerating exponentially many traces,
and the cover elements must be output as valid proper concepts. Marginal
nonuniformity lets the polynomial depend on $P$, not on the hidden label rule
or on an exponential search in the representation length.

### Route 3: Effective Complements Or Pointwise Balanced Pairs

Assume we can efficiently produce some anchor $a\in\mathcal C$ and an
efficient complement operation $c\mapsto -c$ staying inside $\mathcal C$.
Then $\rho(a)+\rho(-a)=0$, so one of the two legal hypotheses has
nonnegative correlation with any labels. In the middle-noise branch this is
more than enough, since $0\ge 2(\gamma_P-\eta)$ whenever
$\eta\ge\gamma_P$. Validation between $a$ and $-a$, together with the
low-noise candidates, proves the edge.

The source node does not force either ingredient. A proper learner is promised
to output legal concepts on realizable examples, but it need not provide an
efficient way to find a first anchor without already having realizable labels,
and it certainly does not imply complement closure. Many cleanly learnable
proper classes omit constants and complements.

### Route 4: Balanced Proper Samplers

A useful generalization of complements is a fixed-marginal balanced sampler.
Assume that for each $P$ there is a $P$-polynomial-time sampler over legal
proper concepts $H\in\mathcal C$ whose barycenter

$$
b_P(x)=\mathbf E[H(x)]
$$

satisfies $\|b_P\|_{L_1(P)}\le\kappa_P(s)$ for an inverse-polynomial
$\kappa_P\le \alpha/8$. For any label rule,

$$
\mathbf E_H[\rho(H)]
=
\mathbf E[b_P(X)Y]
\ge -\kappa_P.
$$

If $t=\alpha/8$, then a draw from the sampler has
$\rho(H)\ge-(\kappa_P+t)$ with probability at least
$t/(1+\kappa_P+t)$: otherwise the average correlation would be below
$-\kappa_P$. Polynomially many independent draws plus validation therefore
find a legal $h$ with $\rho(h)\ge-\alpha/4$, solving the middle-noise branch.

This sampler is not implied by the source. It is a genuine distributional
symmetry or averaging assumption about $\mathcal C$ under $P$. Complement
pairs give such a sampler pointwise, but efficient realizable proper learning
does not create a balanced distribution over concepts.

### Route 5: Restriction, Pasting, Or Projection Closure

Restriction/pasting helps only when it produces one of the previous objects.
A sufficient form is: for each fixed $P$, there is a $P$-polynomial-time
proper projection operation that takes an efficiently described randomized or
pasted predictor $q:\mathcal X\to[-1,1]$ and returns $h\in\mathcal C$ with
$\|h-q\|_{L_1(P)}\le\alpha/8$. Applying this to the zero predictor, or to a
pointwise balanced pasted predictor, gives a proper neutralizer and hence the
middle-noise branch.

Similarly, if the class can efficiently paste an anchor with its complement
over a family of regions rich enough to make the resulting average predictor
nearly zero under $P$, then the balanced-sampler argument applies.

Bare restriction or pasting closure does not follow from the source and is not
by itself enough. The mistake-region strategy still faces arbitrary agnostic
noise on the restricted marginal; without a projection, complement, sampler,
or noise-tolerant learner, it merely moves the selector problem to a
conditional distribution.

### Route 6: SQ, Massart, Or Other Noise-Tolerant Proper Learners

If the class has an additional proper learner tolerant to the relevant noise
model, the positive proof is straightforward for that model. For example,
under Massart noise relative to some $c^\star\in\mathcal C$ with

$$
\Pr[Y\ne c^\star(X)\mid X]\le \frac12-\lambda_P(s),
$$

a proper Massart-tolerant learner that returns $h$ with
$\Pr_P[h\ne c^\star]\le 1/2-\gamma_P$ gives

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+\frac12-\gamma_P,
$$

which is exactly the weak agnostic target relative to that comparator. SQ
learners with the appropriate noise-tolerant simulation, random-classification
noise learners, or tolerant proper learners on all conditional marginals would
therefore give positive subclass results.

But this does not resolve the atlas edge, because the target label rule is
arbitrary agnostic, not Massart or random classification noise. Efficient
strong realizable proper PAC learning also does not imply that the learner is
SQ, tolerant, or well behaved off the realizable promise.

### Route 7: Neutralizer Extraction From The Realizable Learner

I also tried the most black-box route: use the realizable learner itself to
extract a neutralizer by feeding it random labels, contradictory pairs,
self-labeled samples, or samples filtered by a failing anchor. None is sound
from the source definition.

The reason is simple. Strong realizable proper PAC constrains the learner only
on realizable labeled distributions. Its behavior on random or inconsistent
labels can be changed arbitrarily without affecting the source property. An
off-promise call may always return the same legal concept, and that concept
can be badly anti-correlated with the current agnostic labels. Self-labeling
only recovers concepts already generated; it does not make them balanced.
Filtering by mistakes creates a conditional distribution whose labels can
still have middle-sized adversarial noise.

Thus neutralizer extraction would itself be an extra assumption: a
$P$-polynomial procedure which, from unlabeled samples or arbitrary labeled
samples with marginal $P$, outputs a polynomial list containing some
$h\in\mathcal C$ with $\rho(h)\ge-\alpha/2$ for every middle-noise label rule.
That is essentially the fixed-marginal selector game, not a consequence of the
realizable learner.

### Bottom Line

The positive theorem schema is now clear:

1. use the strong realizable proper learner only for the same-marginal
   low-noise branch;
2. use one extra structure to generate a polynomial legal middle-noise list;
3. validate the union of all candidates on fresh labeled examples.

Cost-sensitive trace optimization, computable $L_1(P)$ proper covers,
effective complements, balanced proper samplers, projection/pasting closure,
and genuine proper noise tolerance each instantiate step 2. None is forced by
the source node as stated. The edge therefore remains unresolved rather than
resolved true.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 5B: Computational Weak-Handle Lower Bound

I tried to build the requested false witness: one fixed marginal
$P^\star$, middle-noise label rules $Y_z$, and a cleanly learnable proper
class $\mathcal C$ such that every legal weak handle for $Y_z$ reveals hard
information about $z$. I do not have such a witness. The stress tests below
sharpen why the usual cryptographic, coding, PCP, and finite-support templates
still fall short.

I use $\{\pm1\}$ notation. For a joint distribution with marginal $P^\star$,
write

$$
\rho_z(h)=\mathbf E[h(X)Y_z],
\qquad
\rho_z^\star=\sup_{c\in\mathcal C}\rho_z(c),
\qquad
\eta_z=\operatorname{OPT}_{\mathcal C}(Y_z)=\frac{1-\rho_z^\star}{2}.
$$

After the low-noise coupling, the hard regime is
$\eta_z\ge\alpha(s)$ and the target learner may choose
$\gamma(s)\ll\alpha(s)$. Thus a counterexample must rule out the much weaker
condition

$$
\rho_z(h)\ge -O(\alpha(s)).
$$

So the lower bound cannot merely say "recover the best concept" or "beat
random labels by a noticeable advantage." It must say:

> Given samples from $Y_z$ under one fixed marginal, finding any proper
> $h\in\mathcal C$ with correlation at least $-\alpha(s)$ is computationally
> hard, and any such $h$ can be converted into useful information about $z$.

This is the all-weak-handles-decode property. It has three extra requirements
that ordinary agnostic hardness does not have:

1. The hard instance must live in the conditional labels, not in the marginal.
   Otherwise the marginal-nonuniform polynomial $p_{P}$ can depend on the hard
   instance's marginal.

2. The class must still be efficiently distribution-free strongly properly
   learnable from exact clean labels. In particular, any hard information
   needed for proper output must either be recoverable from clean labels under
   every relevant marginal, or not be needed for clean accuracy.

3. There must be no efficiently findable legal fallback with correlation
   $-\alpha(s)$ or better. A singleton local move, a wrong codeword with
   near-zero correlation, a wrong PCP instance, a bounded support handle, or an
   arbitrary balanced legal concept is already enough for the weak target once
   $\gamma$ is chosen small.

### One-Way Functions

The natural one-way attempt is to make acceptable proper hypotheses invert a
challenge $y=f(z)$. The image-coordinate class already has the right proper
recovery hardness under a fixed coordinate marginal: high-accuracy proper
learning forces an output seed $t$ with $f(t)=y$. But this conflicts with the
source node. If the proper representation requires a preimage seed, then exact
clean labels on the coordinate block do not reveal a preimage, only the image
bits, so distribution-free strong proper realizable learning would itself
invert $f$ on the fixed marginal. If the representation is relaxed so that an
image string $y$ is a legal proper hypothesis, then the weak lower bound loses
the inversion requirement: a learner can output the image-level concept.

I tried adding a seed-reveal or certificate block so clean labels expose the
preimage while agnostic labels hide it. The distribution-free source breaks
the construction. An adversarial clean marginal can put essentially all mass
on the image-coordinate block and none on the reveal block. If accurate proper
output on that marginal still requires a seed, clean learning inverts. If it
does not require a seed, then the nonseed image-level behavior is a legal
handle that the weak learner can use.

The same tradeoff appears in "hidden valid concept" variants. If there is no
efficiently constructible legal concept except after seeing a clean witness,
then the source learner must still output some proper concept on degenerate or
uninformative clean marginals. That forces either a built-in default concept
or an easy way to construct legal concepts. A default can be made
anti-correlated with the hard labels, but then the remaining hidden concepts
must all be hard to find and all easy local handles must be absent. I do not
see how to enforce that without also making clean proper learning fail on
marginals that hide the witness-bearing part.

So the one-way route still has a source-target tension:

$$
\text{proper output needs preimage}
\quad\Longrightarrow\quad
\text{clean source inverts under some marginal},
$$

while

$$
\text{clean source avoids inversion}
\quad\Longrightarrow\quad
\text{some nonpreimage proper handle is legal}.
$$

### LPN, Parities, And Planted Codes

LPN has the right fixed-marginal flavor: exact parity labels are cleanly and
properly learnable under the uniform marginal, while noisy parity recovery is
believed hard. The weak additive target is too forgiving. For parity labels
with noise rate $\eta$, the best parity has correlation $1-2\eta$, but every
wrong parity has correlation $0$. A wrong parity satisfies the weak target
whenever

$$
0\ge (1-2\eta)-1+2\gamma,
$$

equivalently $\gamma\le\eta$. Since the target learner is free to choose a
very small inverse-polynomial gap, middle-noise LPN instances leak neutral
wrong parities.

Trying to force wrong parities negative by adding a planted code block runs
into the same barrier as Depth 4, but in a more computational form. Suppose
concepts are pairs

$$
h_s=(\chi_s \text{ on an LPN block})\ \oplus\ (C(s) \text{ on a code block}),
$$

and the hard labels are noisy versions of $h_z$. The code block must have
enough mass to make wrong $s$ fail the $-\alpha$ threshold. If $C$ is linear
or otherwise efficiently samplable, the learner can sample legal codewords,
validate them, and find a neutral-or-positive one with nonnegligible
probability unless the code geometry makes almost all wrong codewords
negative. But the Bessel/Gram obstruction rules out doing that at
inverse-polynomial scale for exponentially many cleanly decodable codewords.

If $C$ is a planted or cryptographic code where finding any neutral codeword
near the noisy received word is hard, then the clean source becomes suspect.
Exact clean labels on a distribution supported mostly on the code block must
allow efficient proper recovery. This asks for efficient exact erasure or
unique decoding but hard "find any codeword of roughly half agreement" under
the same coordinate marginal. Linear and algebraic codes with such exact
decoders have easy message sampling, which again gives random neutral
handles. Nonlinear codes without efficient sampling may avoid that escape, but
then a distribution-free proper learner still needs an efficient way to output
a legal codeword on weakly informative clean samples. I do not know a standard
code family with all three properties:

1. exact clean proper learning under every coordinate marginal;
2. no efficient legal sampler or default neutral concept;
3. hardness of finding any codeword with correlation at least $-\alpha$ to a
   noisy planted word.

This route would be worth revisiting if one had a cryptographic code with an
efficient promise-extension algorithm for clean partial codewords but hard
weak signed optimization over codewords. I do not know such a theorem, and it
would be substantially stronger than ordinary LPN hardness.

### PCP Or Shared-Marginal CSP Gadgets

PCP active-slice classes prove several properness separations, but they do
not give this edge. If the marginal is the active slice of an instance
$\varphi$, then the hard instance is in the marginal and marginal
nonuniformity can absorb it. If all instances are packed into one full-support
marginal, the active slice for a length-$n$ instance has mass $\mu_n$ or
smaller. A wrong hypothesis loses only on that slice, so it is excluded by the
weak threshold only when the slice has essentially half the total mass. One
fixed marginal cannot give half the mass to every hard instance length.

The shared-marginal variant is more interesting: take the domain to be verifier
random strings $r$ only, and let a proper hypothesis encode an instance-proof
pair $(\varphi,\pi)$ with value $V(\varphi,\pi,r)$. The labels for a challenge
$z$ would be a target predicate on the same random-string marginal. To get an
all-weak-handles-decode lower bound, every proper pair $(\psi,\pi')$ with
correlation at least $-\alpha$ against the challenge labels must reveal useful
information about $z$.

I could not make this happen. Wrong instances provide too many handles. Some
unrelated satisfiable or high-acceptance instance can have neutral correlation
with the challenge labels. Adding an instance code to punish wrong $\psi$
returns to the code-geometry problem: either wrong instances are not all
negative, or the code block/instance code has to be so rigid that clean
learnability or polynomial representation breaks. Randomly signed shared PCP
predicates make exact recovery hard, but they also make random wrong proofs
approximately neutral, and validation over any efficiently samplable family
would find a legal weak handle.

The missing gadget would be a "wrong-output-usefulness" PCP: under one shared
random-string marginal, every proof or instance-proof pair that is not
strongly anti-correlated with the challenge labels can be decoded into a
solution or witness for the challenge. That is stronger than ordinary PCP
soundness, which only says proofs for the same instance cannot be too
accepting.

### Finite-Support Trace Classes

Finite-support classes look promising because they separate clean consistency
from agnostic optimization. A useful toy model is a set system
$\mathcal F_n\subseteq 2^{[N]}$ and the concept class of its incidence
vectors. Clean proper learning asks for a feasible set consistent with sampled
labels from a feasible target. Weak agnostic learning under the uniform
marginal asks for a feasible set with acceptable signed weight.

There are easy examples where promise extension is polynomial but weighted
optimization is hard. Vertex covers are the simplest diagnostic. Let
$\mathcal C_G$ be vertex covers of a graph $G$, represented as
$\{\pm1\}$ assignments over vertices. A clean sample from a target vertex
cover can be extended by setting all unsampled vertices to "in the cover,"
provided no sampled edge has both endpoints forced out; consistency with a
true cover guarantees this. Thus the clean promise-extension operation is
easy. But with all labels saying "out of the cover," agnostic optimization is
minimum vertex cover.

The weak target again escapes. The all-in cover is a legal default. More
importantly, for every vertex $v$, the cover $V\setminus\{v\}$ is legal, so
there are singleton improvements over the default. If the learner chooses
$\gamma<1/N$, one such local move already beats the default by enough for the
weak additive guarantee in the hard middle range. This is the finite-support
version of bounded positive-atom handles.

One can try to remove local moves by requiring all feasible sets to have large
minimum distance from the default, or by requiring the complement to be an
independent set of a prescribed large size. But then clean partial extension
becomes a hard feasibility problem: extending a sampled partial independent
set to size $K$ is essentially the independent-set problem. Matroid-like
families go the other way: clean extension is easy, but weighted optimization
is also easy. The candidate object would be an intermediate set system with:

1. polynomial-time promise extension for every partial trace coming from a
   feasible concept;
2. no small local feasible moves that give $1/\operatorname{poly}$ weak
   handles;
3. hard weak signed optimization, not just hard exact optimization.

I do not know a standard finite-support system satisfying all three. Greedoid
or antimatroid optimization might be a place to look, but one would need a
representation where clean PAC extension is genuinely efficient while finding
even a nonnegative signed feasible set is hard under one fixed uniform
marginal.

### What A Successful Lower Bound Would Need

The failed attempts suggest a more precise target for the next search. We need
a family of trace sets $V_n\subseteq\{\pm1\}^{X_n}$ with a fixed marginal
$P^\star_n$ and hard signed label vectors $y_z$ such that:

1. **Clean promise extension:** Given any polynomial sample labeled by a
   concept $v\in V_n$, there is a polynomial-time algorithm outputting a
   proper concept agreeing with the sample and generalizing in the usual PAC
   way under arbitrary marginals.

2. **Hard weak signed search:** Given random coordinates from $P^\star_n$ and
   labels from $y_z$, no polynomial-time algorithm can output
   $v\in V_n$ with
   $$
   \langle v,y_z\rangle_{P^\star_n}\ge -1/\operatorname{poly}(n),
   $$
   unless it solves the underlying hard problem.

3. **No efficient neutral sampler:** There is no efficiently constructible
   distribution over legal concepts whose barycenter has small
   $L_1(P^\star_n)$ norm, and no known default-plus-local-move family that
   validation can exploit at the learner's chosen inverse-polynomial scale.

4. **Hardness remains label-only:** The same $P^\star$ works for all
   challenges; neither the support nor the slice weights encode $z$.

This is not a standard consequence of one-way functions, LPN, PCP soundness,
or NP-hard ERM. It is closer to hardness of weak signed optimization over an
efficiently promise-extendable trace family with no sampleable neutral
barycenter.

### Current Verdict

I do not see an atlas-ready counterexample. The most plausible negative route
is still computational rather than geometric, but each concrete template leaks
one of the forbidden weak handles or breaks the clean proper source:

1. one-way/image-coordinate constructions either make clean proper learning
   invert or legalize a nonpreimage handle;
2. LPN and parity/code constructions have efficiently samplable neutral wrong
   hypotheses unless one postulates a much stronger planted-code object;
3. PCP/shared-marginal constructions leak wrong-instance handles or suffer
   active-slice dilution;
4. finite-support trace classes with easy clean extension tend to have local
   singleton handles, while removing them makes clean extension hard.

So this depth does not resolve the edge false. It does, however, isolate the
needed witness: a fixed-marginal hard weak signed-search problem over a class
with efficient clean promise extension and no efficiently sampleable neutral
legal concepts.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 5A: Selector Equivalence With Constants

This depth does not resolve the edge. It does, however, make the Depth 4
selector game precise enough to use as an atlas-ready conditional lemma. The
right conclusion is: the clean proper learner plus the low-noise coupling
reduces the edge to a fixed-marginal middle-noise selector, and that selector
is theorem-equivalent to the missing part of the target up to harmless constant
slack. I do not see a derivation of the selector from realizable proper PAC
learning alone, nor a counterexample that refutes it.

### Constants

Work in $\{\pm1\}$ notation. For a joint distribution $\mathcal D$ with
marginal $P$, write

$$
\rho_{\mathcal D}(h)=\mathbf E_{\mathcal D}[h(X)Y],
\qquad
\rho^\star_{\mathcal D}
=\sup_{c\in\mathcal C}\mathbf E_{\mathcal D}[c(X)Y],
$$

so

$$
\rho^\star_{\mathcal D}=1-2\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

A weak agnostic guarantee with final gap $\gamma(s)$ is equivalent to

$$
\rho_{\mathcal D}(h)
\ge
\rho^\star_{\mathcal D}-1+2\gamma(s).
$$

Let $A$ be the assumed distribution-free strong realizable proper learner. Run
$A$ with clean accuracy

$$
\varepsilon_0=1/32
$$

and clean failure probability $1/32$. Let $m_0(s)$ be a polynomial upper bound
on the number of labeled examples inspected by such a run at representation
size $s$. Fix the low-noise threshold

$$
\alpha_A(s)=\min\left\{\frac1{64},\frac1{128m_0(s)}\right\}.
$$

For the final weak gap, it is harmless to insist throughout that

$$
0<\gamma_P(s)\le \min\{1/64,\alpha_A(s)/8\}
$$

and that $\gamma_P$ is inverse-polynomial under the fixed marginal $P$.
Shrinking an inverse-polynomial gap by these fixed and source-polynomial
factors keeps it inverse-polynomial.

### Low-Noise List

The low-noise list generator is just repeated use of $A$ on the observed
agnostic examples. It does not need to know whether the current distribution is
low-noise.

Suppose

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_A(s).
$$

Choose $c^\star\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(c^\star)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\alpha_A(s)
<2\alpha_A(s).
$$

Couple one noisy run of $A$ on samples from $\mathcal D$ with a clean run on
$(X,c^\star(X))$ using the same instance sequence and internal randomness.
The probability that some inspected label is corrupted relative to $c^\star$
is at most

$$
2\alpha_A(s)m_0(s)\le 1/64.
$$

With probability at least

$$
1-\frac1{32}-\frac1{64}>\frac12,
$$

the noisy transcript is a successful clean transcript. The output is a proper
$h\in\mathcal C$ satisfying

$$
\Pr_P[h(X)\ne c^\star(X)]\le 1/32.
$$

Therefore

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\alpha_A(s)+1/32
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+3/64.
$$

Since $\gamma_P\le1/64$, this is much stronger than

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-4\gamma_P(s).
$$

Repeating the run

$$
R=\lceil \log_2(8/\delta)\rceil
$$

times gives, with failure probability at most $\delta/8$, a low-noise list
$L_{\mathrm{low}}$ of size $R$ containing such a hypothesis whenever
$\operatorname{OPT}<\alpha_A$.

This is the only place where the source learner is used. The constants show
that low-noise generation composes cleanly with any later list generator:
the runs can use a disjoint sample block, and if the current distribution is
not low-noise then the low-noise list may be arbitrary because validation will
only select from the union by empirical error.

### Middle-Noise Selector Game

The missing object can now be stated with slack.

For every fixed marginal $P$, a middle-noise proper selector for $A$ is one
uniform randomized algorithm $G$ with $P$-dependent polynomial sample and time
bound $q_P$ and a $P$-dependent inverse-polynomial gap $\gamma_P$ such that,
for every joint distribution $\mathcal D$ with marginal $P$, every confidence
parameter $\delta$, and

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge\alpha_A(s),
$$

$G$ outputs, with probability at least $1-\delta/8$, a list
$L_{\mathrm{sel}}\subseteq\mathcal C$ of size at most $q_P(s,\log(1/\delta))$
containing some $h$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-4\gamma_P(s).
$$

Equivalently,

$$
\rho_{\mathcal D}(h)
\ge
\rho^\star_{\mathcal D}-1+8\gamma_P(s).
$$

The properness requirement belongs in the selector statement: every list
element used by validation must be a legal concept. If the representation has
a syntactic membership check, illegal outputs can simply be discarded; without
such a check, the selector lemma itself must promise legal output.

Because $\gamma_P\le\alpha_A/8$, the middle-noise threshold also has a useful
neutralizer form. If $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge
\alpha_A$, then

$$
\rho^\star_{\mathcal D}-1+8\gamma_P
=-2\eta+8\gamma_P
\le -\alpha_A.
$$

Thus an even stronger-looking but often easier sufficient condition is a
polynomial-time list containing some proper $h$ with

$$
\rho_{\mathcal D}(h)\ge -\alpha_A(s)
$$

for every middle-noise label rule under the same fixed marginal. This is the
same "not too anti-correlated" neutralizer obstruction from the earlier depths.
The source learner does not seem to provide it.

### Validation Requirements

Let

$$
B=|L_{\mathrm{low}}|+|L_{\mathrm{sel}}|.
$$

After generating both lists on sample blocks independent of validation, draw

$$
n_{\mathrm{val}}
\ge
\frac{1}{2\gamma_P(s)^2}\log\frac{8B}{\delta}
$$

fresh labeled examples from $\mathcal D$. Hoeffding plus a union bound gives,
with probability at least $1-\delta/4$, simultaneous estimates of every
candidate's true error within $\gamma_P(s)$. If $\hat h$ is the empirically
best candidate in the union list, then on this validation event

$$
\operatorname{err}_{\mathcal D}(\hat h)
\le
\min_{h\in L_{\mathrm{low}}\cup L_{\mathrm{sel}}}
\operatorname{err}_{\mathcal D}(h)+2\gamma_P(s).
$$

Hence, in the middle-noise case, the selector candidate gives

$$
\operatorname{err}_{\mathcal D}(\hat h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-2\gamma_P(s)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s).
$$

In the low-noise case, the low-noise candidate gives

$$
\operatorname{err}_{\mathcal D}(\hat h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+3/64+2\gamma_P(s)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s),
$$

using $\gamma_P\le1/64$. The total failure probability is at most $\delta$
after the displayed allocations. The total sample and running time are bounded
by a $P$-dependent polynomial because $R$, $q_P$, and
$n_{\mathrm{val}}$ are all polynomial in $s$ and $\log(1/\delta)$ under the
fixed marginal.

This proves the conditional positive lemma:

> If the source node holds and a middle-noise selector exists for every fixed
> marginal $P$ with the constants above, then the edge is true.

No estimate of $\operatorname{OPT}$ is needed. The algorithm always forms the
low-noise list, always forms the selector list, and lets the fresh validation
block choose among the union. This is the cleanest way the low-noise coupling
composes with selector/list generation.

### Equivalence To The Missing Target

The selector is also necessary up to constant slack. Suppose the desired target
learner already exists for the fixed marginal $P$ with weak gap
$\Gamma_P(s)$. Define

$$
\gamma_P(s)
=
\min\{\Gamma_P(s)/4,1/64,\alpha_A(s)/8\}.
$$

On input samples from any middle-noise $\mathcal D$, run the target learner
once with the requested confidence and output its single hypothesis as a
one-element list. Its guarantee

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\Gamma_P(s)
$$

implies the selector guarantee with slack $4\gamma_P(s)$. Thus the
middle-noise selector is not an extra easy lemma sitting below the target; it
is the target's unresolved middle-noise content, isolated after the part that
the realizable proper learner really does prove.

### What This Says About Resolution

This formalization proves neither direction of the atlas edge by itself. It
shows that a positive proof still needs an efficiently sample-accessible
fixed-marginal proper selector, or a concrete structure implying one:
computable proper trace covers, cost-sensitive optimization over traces,
constants/complements, restriction or pasting closure, SQ/Massart tolerance, or
some other legal neutralizer mechanism.

For a false result, the validation constants clarify what must be ruled out.
A counterexample must give one fixed marginal $P^\star$ and middle-noise label
rules for which no polynomial-time algorithm can output even a polynomial list
with one proper hypothesis satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-4\gamma(s).
$$

It is not enough to make exact agnostic recovery hard, and it is not enough to
vary the marginal with the hard instance. The low-noise regime is already
handled by coupling, while the middle-noise regime permits nearly neutral
proper hypotheses. So the negative route must be a fixed-marginal
computational weak-handle lower bound: finding any legal not-too-anti-correlated
handle must be hard, even though clean proper realizable learning remains
efficient.

The section should therefore feed the parent as a theorem-equivalent missing
lemma, not as a completed resolution.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 6B: Neutralizer Extraction Attempt

This depth tries to prove the edge true using only the assumed efficient
distribution-free strong realizable proper learner. I do not get a proof. The
main conclusion is a sharper negative statement about this positive route:
every way I can make the middle-noise branch work smuggles in exactly the
same-marginal selector from Depth 5A, or one of the extra structures listed in
Depth 5C.

I use $\{\pm1\}$ labels. For a fixed marginal $P$ and a joint distribution
$\mathcal D$ with regression $\phi(x)=\mathbf E[Y\mid X=x]$, write

$$
\rho(h)=\mathbf E_P[h(X)\phi(X)]
\quad\text{and}\quad
\rho^\star=\sup_{c\in\mathcal C}\rho(c).
$$

The target asks for

$$
\rho(h)\ge \rho^\star-1+2\gamma_P(s).
$$

As in Depth 5A, the realizable learner handles the low-noise regime by
same-marginal coupling. In the remaining regime
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_A(s)$, after
choosing $\gamma_P\ll \alpha_A$, it would suffice to find a legal proper
$h\in\mathcal C$ with mildly negative correlation, say

$$
\rho(h)\ge -\alpha_A(s).
$$

So the extraction target is deliberately weak: manufacture, from the clean
learner itself, a same-marginal proper neutralizer for every middle-noise
regression $\phi$.

### Black-Box Limitation

The first obstruction is purely logical. The realizable learner is constrained
only on realizable labeled distributions. If an extraction procedure calls it
on arbitrary labels, random labels, contradictory samples, residual labels, or
filtered agnostic labels, then the call is off-promise. Its behavior can be
changed to return a fixed legal concept $a$ on every off-promise input without
affecting the source guarantee. If the current regression has
$\rho(a)<-\alpha_A$, that extraction fails.

Thus a proof cannot rely on benign off-promise behavior of the implementation.
It must either make only realizable calls, or add a checkable consistency
filter that discards bad outputs. Once we impose that discipline, the clean
learner becomes a promise-extension oracle: it can realize a clean trace after
the trace has already been guessed. It is not yet a selector for arbitrary
signed labels.

### Synthetic Self-Labels

One can often get at least one anchor $a\in\mathcal C$. For instance, try a
degenerate distribution on a sampled point with each possible label; any
realizable choice gives a legal output. Then label fresh $P$-samples by
$a(X)$ and run the clean learner again. This is an on-promise call, but it can
only produce hypotheses close to $a$ under $P$ when the requested clean error
is small.

If $\rho(a)\ge-\alpha_A$, we are already done. The hard case is
$\rho(a)<-\alpha_A$. Self-labeling by $a$ reinforces the bad anchor rather
than balancing it. Self-labeling by $-a$ would be useful only if the complement
is realizable by a concept in $\mathcal C$, and random flips of $a$ are
off-promise unless the class contains the resulting randomized trace. The
hidden assumption is therefore complement closure, a balanced pair, or
noise-tolerant behavior on non-realizable labels. None follows from efficient
realizable proper PAC learning.

The same problem appears if we self-label by a small pool of previously found
concepts. The pool's average predictor $b(x)$ gives

$$
\mathbf E_{H}[\rho(H)]=\mathbf E_P[b(X)\phi(X)].
$$

For this average to be at least $-\alpha_A$ for every regression $\phi$, we
need $\|b\|_{L_1(P)}\le\alpha_A$. That is exactly a balanced proper sampler.
The clean learner can resample around existing concepts; it does not force the
barycenter of the generated concepts to be small.

### Random Restrictions And Failing Anchors

Suppose an anchor $a$ fails validation. Then some near-best
$c^\star\in\mathcal C$ must disagree with $a$ on more than about half the
$P$-mass. This suggests restricting to the observed mistake region
$M=\{Y\ne a(X)\}$, where labels point away from $a$.

On $M$, however, the labels are still agnostic. The clean label
$c^\star(X)$ is corrupted at conditional rate at most

$$
\Pr[Y\ne c^\star(X)\mid M]\le
\operatorname{err}(c^\star)/\Pr[M].
$$

In the genuine middle-noise regime this ratio can be a constant below, near,
or even at the tolerance needed for a weak learner, but it is not at the
transcript scale $1/m_A(s)$. Running the clean learner on the conditional
sample therefore again requires a constant-noise tolerance assumption. Taking
only $O(\log s)$ conditional examples keeps the all-clean event visible, but
those few constraints do not force generalization for a class with
polynomial VC dimension. Taking enough constraints to generalize makes the
all-clean event exponentially rare.

Random restrictions independent of the labels have the same issue. If the
restriction is labeled by $a$, the output remains an extension of $a$ on that
region and may stay anti-correlated globally. If the restriction is labeled by
the agnostic labels, the call is off-promise unless we have guessed a clean
subtrace. If we then paste a learned concept on the restriction and use $a$
elsewhere, the pasted classifier need not be a member of $\mathcal C$. The
hidden assumptions are conditional noise tolerance and restriction/pasting
closure with proper projection.

### Validation Over Clean-Consistency Outputs

A more careful version is to use the realizable learner only as a consistency
oracle. Draw many small labeled subsets from the agnostic sample, run the
learner at accuracy below the reciprocal subset size, and keep only outputs
that are actually consistent with the subset. Then validate all kept outputs
on fresh data.

This has the right flavor but not enough force. If a subset has size $k$, the
probability that it is clean relative to $c^\star$ is roughly
$(1-\eta)^k$. For $k=O(\log s)$ this can be inverse-polynomial, so repeated
trials may find clean subsets. But such subsets are too small to identify a
hypothesis with any guaranteed global correlation under a high-dimensional
trace class. A canonical consistency oracle can return a concept that agrees
with those few clean labels and is anti-correlated elsewhere.

For $k$ at the VC or source-sample scale needed to force even weak global
agreement, $(1-\eta)^k$ is exponentially small in the middle-noise regime.
Trying all label corrections on a large sample is the usual exponential
agnostic search. Validation is only a selector over the polynomial list
already generated; it cannot make the consistency oracle generate a good list
without an additional trace-search mechanism.

So this route proves a conditional theorem: if random clean-consistency
queries produce a polynomial list containing a mildly correlated proper
hypothesis, then the edge is true. But that condition is just the middle-noise
selector, not a consequence of the source.

### Sample Compression And VC Covers

The sample-complexity analogy is seductive. Efficient distribution-free
realizable PAC learning gives finite, indeed polynomially bounded, sample
dimension at representation size $s$. For a fixed marginal $P$, finite VC
dimension gives proper agnostic learning information-theoretically by an
$L_1(P)$ cover and holdout validation.

The missing word is "computable." A generic cover construction enumerates the
trace set on an unlabeled sample of size polynomial in the VC dimension and
$1/\gamma_P$. If the dimension is $d=\operatorname{poly}(s)$, the number of
traces may be $n^d$, which is superpolynomial in $s$. A sample-compression
scheme would help only if its message length were small enough that all
messages could be enumerated in polynomial time and decoded to proper
concepts. The source learner does not imply such an efficiently enumerable
proper compression scheme. Its transcripts have polynomial length, and
enumerating all transcripts, random bits, or corrected labels is again
exponential.

Thus VC covers prove the sample-only edge but not this computational one. The
hidden assumption is an efficient fixed-marginal proper cover generator, an
efficient proper ERM, or an efficiently enumerable proper compression scheme.

### Randomized Targets And Mixtures Over Proper Outputs

Another possible escape is to randomize the target used for clean calls. If
we could sample $H\in\mathcal C$ from a distribution with nearly zero
barycenter under $P$, then for every regression $\phi$ some draw would satisfy
$\rho(H)\ge-\alpha_A$, and validation would find it. This is the balanced
sampler route from Depth 5C.

The clean learner itself does not provide the sampler. Sampling random
labelings is off-promise. Sampling descendants of an anchor by self-labeling
has barycenter close to that anchor. Sampling over all proper outputs of the
learner on all realizable finite traces would require enumerating realizable
traces, and even the uniform distribution over those outputs need not be
balanced under $P$.

Mixtures also do not remove properness. A randomized vote or average predictor
may be neutral as a function in $[-1,1]$, but the target requires a legal
proper hypothesis. To pass from a neutral mixture to one legal component we
need either a distribution over legal components with neutral average, or a
proper projection of the mixture back into $\mathcal C$. Both are extra
structure.

### Full-Support Marginal Nonuniformity

Finally, I tried to use the marginal-nonuniform relaxation itself. Perhaps for
each fixed $P$, a full-support or heavy-tailed sampling scheme could wait
until the right clean transcript, restriction, or neutral output appears.

This only recovers the known low-noise branch. If the learner uses
$m_A(s)$ labels, the probability that a middle-noise transcript is completely
clean relative to $c^\star$ is about $\exp(-\eta m_A(s))$, which is not
inverse-polynomial when $\eta$ is constant or merely above the low-noise
threshold. A $P$-dependent polynomial may have constants and exponents
depending on $P$, but it still cannot absorb a generic $2^{s^a}$ trace search
or an exponentially rare clean transcript for unbounded $s$.

Full support over the instance marginal also does not help with label-only
hardness. The marginal is fixed before the conditional regression $\phi$ is
chosen, and the polynomial $p_P$ cannot depend on $\phi$, on $c^\star$, or on
which rare transcript would be useful. Full-support arguments can sometimes
turn pathwise finite-transcript bounds into uniform resource bounds; they do
not create a legal hypothesis with nonnegative correlation against every
middle-noise regression.

### What Would Make The Extraction Work

The attempted proof becomes valid under any one of the following additional
lemmas:

1. Off-promise stability: running the clean learner on arbitrary same-marginal
   labels produces a legal output that is not too anti-correlated whenever
   $\operatorname{OPT}\ge\alpha_A$.

2. Balanced generation: using only realizable calls, one can generate a
   polynomial list or sampler over $\mathcal C$ whose $P$-barycenter has
   $L_1(P)$ norm at most $\alpha_A$.

3. Effective trace search: clean consistency outputs from polynomially many
   subsets form a list containing a hypothesis within
   $\operatorname{OPT}+1/2-O(\gamma_P)$.

4. Efficient proper compression or covers: for each fixed $P$, the class has
   an efficiently enumerable weak-scale proper cover.

5. Closure or projection: complements, restrictions, pasting, mixtures, or
   external weak predictors can be converted back into a proper concept in
   $P$-polynomial time.

Each item is a version of the Depth 5A selector or Depth 5C positive
structure. None is forced by the definition of efficient strong realizable
proper PAC learning. The source learner can be perfectly good on all clean
realizable distributions while being useless on arbitrary labels, and its
clean promise-extension power does not search the trace set.

### Depth 7 Directions

1. Try to prove a non-black-box representation theorem: efficient strong
   realizable proper PAC learning plus the atlas representation conventions
   might imply an efficiently enumerable proper compression or weak cover. The
   obstacle to beat is the $n^{\operatorname{poly}(s)}$ trace count.

2. Look for a class where every black-box extraction above can be made to
   return a bad anchor, while some other hidden algorithm still might or might
   not weakly learn. This would separate "extract from the given learner" from
   the actual implication.

3. Search for positive subclass lemmas with minimal assumptions: complement
   pairs, a single balanced sampler, efficient proper projection of the zero
   predictor, or consistency-oracle output diversity under random clean
   restrictions.

4. Continue the false-witness hunt from Depth 5B, but target the exact
   negation of the extraction lemmas: fixed marginal, efficient clean promise
   extension, no efficiently sampleable balanced legal distribution, and hard
   weak signed search.

I therefore cannot write an atlas-ready proof of the edge as true. The
neutralizer extraction attempt reduces back to the fixed-marginal
middle-noise selector and exposes the hidden assumptions needed by each
candidate construction.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 6C: Cryptographic Weak-Handle Attempt

I revisited the negative route with one-way, LPN, planted-code, and PRF
templates. I still do not see an atlas-ready conditional counterexample. The
main obstruction is now very sharp: every standard cryptographic construction
either makes the clean proper source learner solve the cryptographic recovery
problem on some marginal slice, or it leaves an efficiently findable nonsecret
proper handle that is already good enough for the weak agnostic target.

I use the constants from Depth 5A. Let $\alpha_A(s)$ be the low-noise threshold
coming from the clean realizable learner, and let the target choose
$\gamma_P(s)\le \alpha_A(s)/8$. In the middle-noise regime
$\eta_z=\operatorname{OPT}_{\mathcal C}(Y_z)\ge\alpha_A(s)$, a sufficient weak
output is any proper $h$ with

$$
\rho_z(h)=\mathbf E_{P^\star}[h(X)Y_z]\ge -\alpha_A(s).
$$

So a false witness must prove much more than noisy recovery hardness. It must
make finding even a nearly neutral legal hypothesis hard under one fixed
marginal $P^\star$.

### Desired Cryptographic Object

The object I tried to instantiate is:

1. a fixed marginal $P^\star$ and label rules $Y_z$ whose hard instance is in
   the conditional labels, not in the marginal;
2. an efficient distribution-free proper learner for exact clean labels from
   every concept in $\mathcal C$ and every marginal;
3. a lower bound saying that any polynomial-time algorithm outputting
   $h\in\mathcal C$ with $\rho_z(h)\ge-\alpha_A(s)$ can be converted into
   useful information about $z$;
4. no efficiently sampleable balanced distribution over legal concepts, no
   public image-level concept, no default concept, and no local legal move that
   validation can turn into a nearly neutral handle.

This is stronger than the usual assumptions behind one-way functions, LPN, PRF
security, planted-code decoding, or PCP soundness.

### One-Way And PRF Secret-Required Concepts

The most direct plan is to make every acceptable proper hypothesis encode a
secret. For a one-way function, a legal hypothesis might need a preimage
$s$ of a challenge image $y=f(s)$. For a PRF class, a legal hypothesis might
need the key $k$.

This immediately conflicts with the source. Consider a clean realizable
marginal supported on the hard coordinate block. If accurate proper output on
that block requires the preimage or PRF key, then the clean proper learner is
an inverter or key-recovery algorithm on exact labels. That is acceptable for
parities, where exact labels are linearly learnable, but it is exactly what
one-way and PRF assumptions are meant to rule out.

Adding a reveal or certificate slice does not fix this in the distribution-free
source model. An adversarial clean marginal can put negligible or zero mass on
the reveal slice. If the learner still has to output a seed to be accurate on
the hard block, clean learning inverts. If the representation is relaxed so
that the image, certificate, or partial behavior is itself a legal proper
hypothesis, then the weak agnostic learner can output that nonsecret legal
object as a handle.

This is the source-target tension in its cleanest form:

$$
\text{proper output requires the secret}
\quad\Rightarrow\quad
\text{clean source learning recovers the secret on some marginal,}
$$

whereas

$$
\text{clean source learning avoids secret recovery}
\quad\Rightarrow\quad
\text{some nonsecret behavior is legal and weakly usable.}
$$

### LPN And Planted-Code Guards

LPN fixes the clean-source side: exact parity labels are properly learnable by
linear algebra under arbitrary marginals, because the learner only needs a
parity consistent with the clean sample. Noisy recovery of the planted parity
is believed hard under the uniform marginal.

The weak target is too forgiving. For noisy labels from a planted parity with
noise rate $\eta$, every wrong parity has correlation $0$ with the labels.
When $\eta\ge\alpha_A$ and $\gamma\le\alpha_A/8$, this neutral wrong parity is
far above the required threshold. Random parities are therefore legal weak
handles.

I tried to attach a planted code or guard block:

$$
h_s=(\chi_s\text{ on a parity block})\ \oplus\ (C(s)\text{ on a guard block}),
$$

with enough guard mass that wrong $s$ becomes negatively correlated with the
challenge labels. If $C$ is linear, algebraic, or otherwise efficiently
sampleable, random messages again give a balanced proper sampler. By the
balanced-sampler argument from Depth 5C, polynomially many sampled codewords
plus validation find a handle with correlation at least $-\alpha_A$.

If $C$ is made cryptographic or planted so that finding any nearly neutral
codeword is hard, the clean source becomes the problem. Exact clean labels on
a marginal supported mostly on the guard coordinates must allow efficient
proper recovery or promise extension. Standard efficiently decodable codes also
have efficiently sampleable messages, giving neutral handles. Nonlinear
non-sampleable codes might block random handles, but then I do not see how a
distribution-free clean proper learner outputs a legal codeword on weakly
informative clean samples.

The missing primitive would be an efficiently promise-extendable code whose
weak signed optimization problem is hard at the negative threshold
$-\alpha_A$, and whose legal codewords cannot be sampled in a balanced way.
That is not ordinary LPN or planted-code hardness.

### PRF Families Are Usually Balanced Samplers

A PRF-keyed concept class also has a direct escape route if keys are
efficiently sampleable. Under the fixed marginal, sample a random key $k$ and
validate the proper hypothesis $h_k$ against the labels. If the random-key
barycenter

$$
b(x)=\mathbf E_k h_k(x)
$$

has small $L_1(P^\star)$ norm, then a random draw has
$\rho_z(h_k)\ge-\alpha_A$ with inverse-polynomial probability. Repetition and
validation solve the middle-noise branch without identifying the planted key.

This is not a computational distinguisher for the PRF; it is just legal
candidate generation. The weak learner does not need to tell which key is
planted. It only needs one proper hypothesis that is not too anti-correlated
with the observed labels.

To make the random-key sampler fail, one must either make the keyed family
strongly biased against the challenge labels or make valid keys hard to sample.
The first option cannot hold uniformly for a large symmetric keyed family
without reintroducing the Gram/Bessel obstruction from Depth 4 or legalizing
complements. The second option is hostile to clean proper learning: on
uninformative clean marginals, the learner still needs some efficient way to
output a legal concept.

### Why This Is Not Yet A Conditional Counterexample

One can write a formal assumption that would imply a false edge. Assume there
are trace families $V_n\subseteq\{\pm1\}^{X_n}$ with fixed marginals $P_n$,
hard label rules $Y_z$, and an efficient clean promise-extension learner, but
no polynomial-time algorithm can output any $v\in V_n$ with

$$
\langle v,Y_z\rangle_{P_n}\ge -1/\operatorname{poly}(n).
$$

Then the class $\mathcal C=\bigcup_n V_n$ would satisfy the source by the clean
extension learner, while any target learner for the fixed marginal would break
the weak signed-search assumption. But this assumption is almost exactly the
missing lower bound restated as a primitive. It is not currently justified by
one-way functions, LPN, planted-code decoding, or PRFs.

The standard cryptographic assumptions give one of the following, but not all
of them together:

1. hard recovery of the planted secret from noisy labels;
2. easy exact clean recovery under the hard marginal;
3. absence of efficiently sampleable neutral legal hypotheses;
4. hardness of finding any legal hypothesis with correlation merely
   $-\alpha_A$ or better.

LPN gives 1 and 2 but fails 3. PRF and one-way constructions give 1 but tend
to fail 2 unless nonsecret legal handles are added. Planted-code variants can
be tuned toward 3 and 4 only by making the clean promise-extension side
nonstandard and currently unsupported.

### Depth 7 Directions

1. Formalize the hypothetical primitive as a "weak signed-search trace family":
   efficient clean promise extension under all marginals, one fixed marginal
   for hard labels, and hardness of finding any proper trace with correlation
   at least $-1/\operatorname{poly}$. This would make clear exactly what a
   cryptographic counterexample must assume.

2. Prove a no-go lemma for efficiently sampleable keyed classes: if a
   polynomial-time sampler over legal concepts has inverse-polynomially small
   barycenter under $P^\star$, then the Depth 5C balanced-sampler route gives
   the target. This would formally rule out vanilla parity, LPN, PRF, and
   linear-code attempts.

3. Search for learnable-but-non-sampleable trace representations. The hard
   part is not just non-sampling; the clean learner must still output legal
   proper concepts on empty, reveal-avoiding, and weakly informative marginal
   slices.

4. Try an oracle or diagonal trace-family construction that kills each
   polynomial-time weak-handle generator while preserving an explicit clean
   promise-extension algorithm. If even that fails, it would be evidence toward
   a positive theorem extracting a selector from clean learnability plus mild
   effectivity.

For now I would not mark the atlas edge false. The cryptographic route remains
plausible only under a stronger, custom weak signed-search primitive; the
standard one-way/LPN/planted-code/PRF templates still leak neutral handles or
break the clean proper source.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 6A: Trace-System Counterexample Attempt

I tried to instantiate the false direction using finite-support trace and
set-system classes. The short version is: finite set systems give many clean
promise-extension examples, and some of them have hard exact weighted
optimization, but I still do not get the much stronger object needed here:
hard fixed-marginal weak signed search at additive tolerance almost $1/2$,
with no default, local move, or balanced sampler.

### Finite-Trace Translation

Let $X_N=[N]$ with the uniform marginal and let a feasible set
$F\in\mathcal F_N$ define

$$
h_F(i)=
\begin{cases}
+1,&i\in F,\\
-1,&i\notin F.
\end{cases}
$$

For labels $y\in\{\pm1\}^N$, put

$$
W_y(F)=\sum_{i\in F}y_i,\qquad Y=\sum_i y_i.
$$

Then

$$
\rho_y(F)=\frac1N\sum_i h_F(i)y_i
=\frac{2W_y(F)-Y}{N}.
$$

So the empirical weak agnostic selector condition

$$
\rho_y(F)\ge \rho_y^\star-1+2\gamma
$$

is exactly

$$
W_y(F)\ge W_y^\star-\frac N2+\gamma N.
$$

This is the key finite-support obstruction. A counterexample cannot merely
make maximum-weight feasible set hard. It must make additive-$N/2$ signed
optimization hard. Equivalently, in the middle-noise regime it must be hard
to find any legal trace with correlation at least $-1/\operatorname{poly}$.
If the hard part occupies only a small active slice, the $N/2$ slack swallows
it. If the support size is polynomial, singleton or endpoint moves have
inverse-polynomial mass and can become legal weak handles. If the support size
is exponential, local handles are too small, but the source learner usually
loses polynomial sample complexity unless the effective dimension is small,
and then the hard signed signal is often diluted.

For the source node, the clean finite-support route is clear. Given sampled
positive constraints $A$ and sampled negative constraints $B$, a promise
extension algorithm should output

$$
F\in\mathcal F_N\quad\text{with}\quad A\subseteq F\subseteq X_N\setminus B
$$

whenever such an $F$ exists. With a polynomial VC/sample dimension, consistency
on a realizable sample gives distribution-free strong proper PAC learning. The
missing part is not clean extension; it is the fixed-marginal weak signed
selector above.

### Vertex Covers

Vertex covers are the cleanest upward-closed diagnostic. If
$\mathcal F_G$ is the family of vertex covers of a graph $G$, then clean
promise extension is easy. Given positives $A$ and negatives $B$ from a true
cover, $B$ is an independent set, so $V\setminus B$ is a vertex cover
containing $A$ and avoiding $B$.

The hard signed-search attempt uses all-negative labels. Then weak search is
minimum vertex cover with additive $N/2$ slack:

$$
|C|\le \tau(G)+\frac N2-\gamma N.
$$

This is too weak to give a lower bound. If $\tau(G)\ge N/2+\gamma N$, the
all-in cover already works. If $\tau(G)<N/2$, a standard $2$-approximate
vertex cover $C$ has $|C|\le2\tau(G)\le \tau(G)+N/2$. Thus the canonical hard
case for minimum vertex cover is killed by the weak additive tolerance.

Local handles also leak. Whenever $V\setminus\{v\}$ is a cover, it improves
the all-in cover by $1/N$ under all-negative labels. Since the target may
choose $\gamma<1/N$ when $N=\operatorname{poly}(s)$, validation can exploit
such moves. Forcing every vertex to be essential makes every cover large, at
which point the all-in cover is already weakly acceptable. Exact-size or
large-distance cover variants remove local moves only by making the clean
extension problem nontrivial again: extending a partial cover while avoiding
sampled negatives becomes a hidden feasibility problem, not the easy source
learner.

So vertex covers meet the clean source but fail the weak-target hardness.

### Independent Sets

Independent sets give the downward-closed mirror image. Clean realizable
proper learning is easy by memorization: output the set of sampled positive
vertices. Because the target independent set is downward closed, the output is
proper; with a VC/sample bound this learns distribution-free in the realizable
model.

All-positive labels ask for an independent set of size

$$
|I|\ge \alpha(G)-\frac N2+\gamma N.
$$

For graph independent sets this also looks hard only briefly. If
$\alpha(G)\le N/2$, the empty independent set already satisfies the weak
threshold. If $\alpha(G)>N/2$, let $\tau(G)=N-\alpha(G)$. A $2$-approximate
vertex cover $C$ gives

$$
|V\setminus C|\ge N-2\tau(G)=2\alpha(G)-N
\ge \alpha(G)-N/2.
$$

Thus graph independent sets have a polynomial additive-$N/2$ selector for the
all-positive case. For signed labels, one can ignore negatively labeled
vertices and apply the same argument to the positive-induced subgraph; adding
negative vertices to an independent set never helps the objective.

This explains why graph variants are unlikely witnesses. The source is easy,
but the fixed-marginal weak signed search has a simple selector. If the graph
itself varies with the hard instance, the hard instance has effectively moved
into the marginal or side information, and marginal nonuniformity can absorb
that variation. A real counterexample needs one fixed trace family and one
fixed marginal while the challenge lives in the labels.

### Matroids, Matroid Intersections, And Greedoids

Matroids are positive structure, not counterexamples. For matroid independent
sets, the clean learner can again output sampled positives. For bases, a
clean partial basis can be extended after contraction/deletion. In both cases
linear optimization is polynomial by the matroid greedy theorem, so the
middle-noise selector is far stronger than needed.

Two-matroid intersection is also not a negative route, since weighted matroid
intersection is polynomial. Intersections of three or more matroids and
general independence systems are more tempting: they can have easy
downward-closed clean learning by outputting sampled positives while their
maximum-weight feasible-set problems are hard. But the known hardness is not
yet the right hardness. The weak target only asks for additive half-range
optimization. Empty-set and sign-bias handles cover the low-optimum regimes,
and constant-factor approximation or complement-cover algorithms often suffice
whenever the optimum is large enough to make the empty set fail. I do not know
a fixed-marginal label-only gap for a succinct independence system showing
that finding a feasible set of weight

$$
W^\star-N/2+\gamma N
$$

is hard.

Greedoids point in the opposite direction. There are known hard weighted
greedoid maximization results, which is exactly the kind of promise-extension
versus optimization gap one would like. But a greedoid is not hereditary. A
positive sample from a feasible target need not itself be feasible, and
extending required positives while avoiding sampled negatives can encode the
same reachability, Steiner, or ordering problem that makes optimization hard.
So the clean source node is not automatic. Passing to the downward closure
restores the memorization learner, but it also adds prefixes/subsets and
local handles; then one still needs an additive-$N/2$ hardness theorem for the
closure, not just hard exact greedoid maximization.

Antimatroids and convex geometries do not currently help. In the tractable
representations, such as poset ideals or closure systems with efficient
closure, clean extension is easy and weighted closure/ideal optimization is
also polynomial, or at least supplies accessible endpoint moves. General
antimatroid representations may have hard optimization, but then the clean
extension problem for arbitrary sampled positives and negatives is not
obviously efficient. I found no standard antimatroid that simultaneously has
efficient clean promise extension, no balanced or endpoint sampler, and hard
weak signed search.

### Error-Correcting Trace Families

Codes are another natural finite trace template. Let
$V_N\subseteq\{\pm1\}^{X_N}$ be the legal trace set. Clean proper learning is
promise erasure extension: given a partial trace promised to come from a
codeword, output a legal codeword agreeing with it.

Linear codes satisfy the source side well. A partial clean trace is a linear
system, and any solution is a proper hypothesis. But linear and algebraic
codes also have efficient message samplers. If the code has no heavily fixed
coordinates, a random codeword has nearly zero barycenter under the uniform
marginal, so the balanced-sampler argument from Depth 5C gives a weak handle
without decoding the planted word. This is the same reason LPN and parity
classes fail as counterexamples: wrong codewords are neutral.

Adding distance or a guard block does not solve the finite-support problem.
To make every wrong codeword have correlation below $-\alpha$ with a planted
label rule, the construction runs into the Depth 4 Gram/Bessel barrier for
large balanced code families. To avoid the barrier one can make the code
biased, nonlinear, or hard to sample, but then either a default codeword
becomes a handle, or the clean learner no longer has an evident way to extend
arbitrary promised partial traces. Standard nearest-codeword and syndrome
decoding hardness are not enough: they make near-optimal recovery hard, while
the weak target accepts any codeword with mildly negative correlation.

The code object that would work is much stronger and nonstandard: an
efficiently promise-extendable code with no efficient balanced sampler and
hardness of finding any codeword with signed correlation
$\ge -1/\operatorname{poly}$. I do not know such a code family.

### Monotone Set Systems And Hitting/Set Cover

General monotone systems make the clean source almost too easy. For an
upward-closed family, output $X_N\setminus B$ on a clean sample; for a
downward-closed family, output $A$. This gives proper consistency whenever
the sample is realizable.

The same monotonicity creates weak handles. Upward-closed classes contain the
full set; downward-closed classes contain the empty set. If that extreme has
correlation at least $-\alpha_A$, the middle-noise branch is solved. If it is
too anti-correlated, the labels have a strong sign bias, and any legal local
move in the helpful direction has inverse-polynomial value on polynomial
support. Removing all local moves forces large minimum distance or exact-size
constraints. But exact-size constraints are precisely where clean extension
usually becomes hard unless the family is matroid-like, and matroid-like
families bring back efficient weighted optimization.

Hitting set and set cover are the closest monotone promise-extension gap I
found. The upward-closed clean extension is trivial, while exact minimum
hitting set is hard. With all-negative labels, however, the weak learner only
needs a hitting set of size at most

$$
\tau+\frac N2-\gamma N.
$$

Full set works when $\tau$ is above half the ground set; when $\tau$ is far
below half, ordinary approximation and greedy deletion heuristics may already
enter the weak window. To turn this into a counterexample one would need a
fixed family with a label-only hardness gap for additive-$N/2$ hitting set,
plus a proof that no polynomial-time local deletion, approximation, or
balanced sampling procedure finds a legal weak handle. I do not know such a
gap, and ordinary set-cover hardness is not stated at this additive scale.

### Current Obstacles And Depth 7 Directions

The finite-support route clarifies the desired primitive but does not produce
it. A successful trace-system counterexample should give one fixed marginal
$P^\star$ and trace families $V_s$ such that:

1. clean promise extension from arbitrary realizable partial traces is
   polynomial-time, giving efficient distribution-free strong realizable
   proper PAC;
2. for challenge label rules under the same $P^\star$, finding any legal
   trace with correlation at least $-1/\operatorname{poly}(s)$ is hard;
3. the family has no efficiently sampleable distribution over legal traces
   with small $P^\star$-barycenter;
4. defaults, empty/full extremes, singleton endpoints, approximate covers,
   random codewords, and wrong-instance traces are all absent or provably
   insufficient at the learner's chosen inverse-polynomial gap;
5. the hard instance is in the labels, not in the marginal or in a
   graph/hypergraph parameter that varies with the fixed distribution.

Concrete next searches:

1. Check whether any known set-cover, hitting-set, or bounded-occurrence
   covering hardness gives additive-$N/2$ lower bounds under one fixed support,
   rather than only ratio or exact-optimization hardness.

2. Study downward closures of hard greedoid or multi-matroid-intersection
   systems: clean learning by memorization is immediate, but one needs a
   gap where every feasible set above $W^\star-N/2+\gamma N$ decodes the hard
   witness, despite the extra local subsets.

3. Look for non-sampleable promise-extendable codes. The required property is
   not nearest-codeword hardness; it is hard weak signed search with threshold
   just below zero.

4. Prove positive no-go lemmas for accessible monotone systems: if an
   upward/downward/antimatroid-like family has enough efficiently findable
   endpoints, then extremes plus endpoint validation give a middle-noise
   selector.

I therefore do not have an atlas-ready finite-support counterexample. The best
finite trace candidates either satisfy the clean source and leak weak handles,
or make weighted signed search hard by also making clean promise extension
hard. The edge remains open from this direction.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 7C: Final Atlas Synthesis

This edge should remain `open`. The depth tree did resolve one substantial
piece: efficient distribution-free strong realizable proper learning gives a
same-marginal low-noise weak agnostic candidate by transcript coupling. The
unresolved residue is exactly a fixed-marginal middle-noise proper selector.
Neither the positive attempts nor the counterexample attempts closed that
selector gap.

I use $\{\pm1\}$ notation. For a joint distribution $\mathcal D$ with marginal
$P$, write

$$
\rho_{\mathcal D}(h)=\mathbf E[h(X)Y],
\qquad
\rho^\star_{\mathcal D}=\sup_{c\in\mathcal C}\mathbf E[c(X)Y],
\qquad
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
=\frac{1-\rho^\star_{\mathcal D}}2.
$$

The weak agnostic target with gap $\gamma_P(s)$ is equivalent to

$$
\rho_{\mathcal D}(h)\ge \rho^\star_{\mathcal D}-1+2\gamma_P(s)
=2(\gamma_P(s)-\eta).
$$

### Resolved Low-Noise Branch

Let $A$ be the source learner. Run $A$ with clean accuracy $1/32$ and clean
failure probability $1/32$, and let $m_0(s)$ bound the number of labeled
examples inspected by such a run. Define

$$
\alpha_A(s)=\min\left\{\frac1{64},\frac1{128m_0(s)}\right\},
\qquad
0<\gamma_P(s)\le \min\{1/64,\alpha_A(s)/8\}.
$$

If $\eta<\alpha_A(s)$, choose $c^\star\in\mathcal C$ with
$\operatorname{err}_{\mathcal D}(c^\star)\le \eta+\alpha_A<2\alpha_A$.
Couple a noisy run of $A$ on $\mathcal D$ to a clean realizable run on
$(X,c^\star(X))$ using the same $P$-distributed instances and the same
internal randomness. The probability that an inspected label is corrupted
relative to $c^\star$ is at most

$$
2\alpha_A(s)m_0(s)\le 1/64.
$$

Thus with probability greater than $1/2$ the noisy transcript is a successful
clean transcript, and the proper output $h$ satisfies

$$
\Pr_P[h(X)\ne c^\star(X)]\le 1/32.
$$

Consequently

$$
\operatorname{err}_{\mathcal D}(h)
\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+3/64,
$$

which is stronger than
$\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-4\gamma_P(s)$ for the chosen
constants. Repeating $O(\log(1/\delta))$ times produces a polynomial
low-noise list containing a legal weak candidate with high probability. This
part is atlas-ready as a proved branch.

### Selector-Game Equivalence With Constants

After the low-noise branch, the exact missing object is a middle-noise
selector. For each fixed marginal $P$, such a selector is a uniform randomized
algorithm with $P$-dependent polynomial bounds that, for every joint
distribution with marginal $P$ and $\eta\ge\alpha_A(s)$, outputs a polynomial
list $L_{\mathrm{sel}}\subseteq\mathcal C$ containing some legal $h$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-4\gamma_P(s),
$$

equivalently

$$
\rho_{\mathcal D}(h)\ge \rho^\star_{\mathcal D}-1+8\gamma_P(s).
$$

Given this selector, the target learner is immediate. Generate the low-noise
list and the selector list on independent samples, set
$B=|L_{\mathrm{low}}|+|L_{\mathrm{sel}}|$, and validate on

$$
n_{\mathrm{val}}
\ge
\frac{1}{2\gamma_P(s)^2}\log\frac{8B}{\delta}
$$

fresh labeled examples. Hoeffding and a union bound give simultaneous error
estimates within $\gamma_P(s)$. The empirically best candidate is therefore
within $2\gamma_P(s)$ of the best list candidate, yielding the final
$\operatorname{OPT}+1/2-\gamma_P$ guarantee in both the low-noise and
middle-noise cases.

Conversely, if the target learner already exists for marginal $P$ with gap
$\Gamma_P(s)$, then running it once gives a singleton selector with

$$
\gamma_P(s)=\min\{\Gamma_P(s)/4,1/64,\alpha_A(s)/8\}.
$$

So the selector is not merely a convenient sufficient lemma. Up to constant
slack and the already-proved low-noise branch, it is theorem-equivalent to the
unresolved content of the edge.

The neutralizer form is often the clearest way to state the obstruction. Since
$\eta\ge\alpha_A$ and $\gamma_P\le\alpha_A/8$ imply

$$
\rho^\star_{\mathcal D}-1+8\gamma_P=-2\eta+8\gamma_P\le-\alpha_A,
$$

it would suffice in the middle-noise branch to find any legal proper
hypothesis with

$$
\rho_{\mathcal D}(h)\ge-\alpha_A(s).
$$

The source learner does not supply this same-marginal proper neutralizer.

### Failed Positive Extraction Assumptions

The positive attempts all smuggle in the selector or an extra structure that
implies it.

Off-promise calls do not work black-box. The realizable learner is constrained
only on realizable labeled distributions; on arbitrary, residual, random, or
inconsistent labels its behavior can be changed to return a fixed legal anchor
without affecting the source guarantee. If that anchor is anti-correlated with
the current labels, validation cannot manufacture a better legal concept.

Using the learner as a consistency oracle also falls short. Strong realizable
proper learning can realize a clean trace after the trace or corrected labels
have been guessed. In middle noise, a source-scale clean subsample occurs with
probability about $(1-\eta)^k$, exponentially small for polynomial $k$ when
$\eta$ is bounded away from the transcript scale. Small $O(\log s)$ clean
subsamples occur with polynomial probability but do not force global weak
correlation in a high-dimensional trace class.

Mistake-region conditioning only relocates the same problem. If an anchor
$a$ fails, then a near-best $c^\star$ disagrees with $a$ on a large portion of
the marginal. But labels on the observed mistake region still have conditional
agnostic noise at rate at most $\eta/\Pr[Y\ne a(X)]$, which can remain
constant. A clean learner needs noise tolerance, not just realizable
learnability. Pasting a regional correction back into a legal concept also
requires closure or projection not present in the source node.

VC covers, sample compression, and trace enumeration prove only sample-level
intuition unless they are effective. The source implies finite sample
complexity, but a generic fixed-marginal proper cover can require enumerating
$n^{\operatorname{poly}(s)}$ traces or exponentially many corrected labels.
Marginal nonuniformity permits the polynomial bound to depend on $P$, but not
on the conditional label rule or on a hidden exponential trace search.

The extra assumptions that would make the positive proof valid are exactly:
an efficient weak cost-sensitive optimizer over traces, a computable
$L_1(P)$ proper cover, constants or complement pairs, a balanced proper
sampler with small $P$-barycenter, restriction/pasting/projection closure, or
proper noise tolerance such as SQ/Massart/random-classification-noise
tolerance. None follows from efficient distribution-free realizable proper PAC
learning alone.

### Failed Counterexample Templates

The negative attempts also did not produce an atlas-ready witness.

Parities and LPN have the right fixed-marginal noisy-recovery flavor, but wrong
parities are neutral. In the middle-noise branch, a neutral wrong parity
already satisfies the weak additive target once $\gamma_P\le\eta$.

Code and planted-code guards try to make wrong hypotheses negative, but large
orthogonal or near-orthogonal families hit the Bessel/Gram obstruction: for
orthonormal legal concepts $c_i$ and a regression $\phi_z$, the correlations
$a_i=\mathbf E[c_i(X)\phi_z(X)]$ satisfy

$$
\sum_i a_i^2\le \|\phi_z\|_2^2\le 1.
$$

Thus exponentially many wrong concepts cannot all have inverse-polynomial
negative correlation by geometry alone. If the code is efficiently sampleable,
random codewords give a balanced sampler and hence a legal weak handle. If the
code is made non-sampleable or cryptographic, the clean proper promise
extension side becomes nonstandard and unsupported.

One-way, PRF, and secret-required concepts face a source-target tension. If a
proper output must encode the secret, then the clean distribution-free source
learner recovers the secret on marginals supported on the hard coordinate
block. If clean learning is allowed to avoid secret recovery by legalizing an
image-level, partial, default, or certificate-level concept, that nonsecret
object becomes a candidate weak handle.

PCP and active-slice constructions either put the hard instance into the
marginal, where marginal nonuniformity can absorb instance-specific search, or
dilute the hard slice when many instances are packed into one marginal.
Shared-marginal PCP variants leak wrong-instance or random-proof handles unless
one adds a much stronger wrong-output-usefulness gadget.

Finite-support and set-system templates clarify the additive slack but do not
separate the nodes. For a trace family $F\subseteq[N]$ under the uniform
marginal, the weak selector condition is

$$
W_y(F)\ge W_y^\star-\frac N2+\gamma N,
$$

so ordinary hard maximum-weight optimization is not enough. Vertex covers,
independent sets, monotone systems, matroids, and many covering systems either
have defaults, endpoints, local moves, approximation algorithms, or balanced
samplers that fall inside this half-range window. Removing those handles tends
to make clean promise extension hard as well.

Standard halfspace, conjunction, residual-block, and distribution-free
agnostic hardness results likewise miss this exact edge. They are too strong,
too distribution-varying, target near-OPT agnostic learning rather than
additive almost-$1/2$ weak selection, or leave legal neutral hypotheses.

### Sharpened Negative Primitive Needed

A false resolution would require a custom primitive, stronger than the
standard templates above. One convenient formulation is a fixed-marginal weak
signed-search trace family:

1. There is a class $\mathcal C$ or trace family $V_s$ with efficient
   distribution-free clean proper promise extension, giving the source node.
2. There is one fixed marginal $P^\star$ for the hard family; the challenge
   $z$ appears only in the conditional label rule $Y_z\mid X$, not in the
   marginal or side information that a $P^\star$-dependent polynomial can
   absorb.
3. For middle-noise labels with $\operatorname{OPT}\ge\alpha_A(s)$, every
   polynomial-time algorithm that outputs a proper $h\in\mathcal C$ with
   $$
   \mathbf E_{P^\star}[h(X)Y_z]\ge -1/\operatorname{poly}(s)
   $$
   can be converted into useful information about $z$ or breaks an explicit
   hardness assumption.
4. The family has no efficient legal neutralizer mechanism: no constants or
   complements, no default/local endpoint moves, no efficiently sampleable
   balanced distribution over legal concepts, no wrong-code or wrong-instance
   handles, and no computable weak-scale proper cover.

This is the precise "all weak handles decode" requirement. It is not known to
follow from one-way functions, LPN, PRFs, PCP soundness, nearest-codeword
hardness, NP-hard ERM, or ordinary set-cover/independent-set hardness.

### Recommended Replacement Atlas Summary

I would keep the implication frontmatter as `status: "open"` and
`evidence: unknown`, with this replacement summary:

```yaml
summary: "Open: same-marginal low-noise coupling follows from the realizable proper learner, but the middle-noise branch is equivalent to an unsupplied fixed-marginal proper selector; known hardness templates leak neutral handles or move the hard instance into the marginal."
```

### Recommended Replacement Atlas Body

```markdown
## Verdict

`open`.

The low-noise branch is resolved by coupling a noisy run to a clean realizable
run of the proper learner. The unresolved part is the middle-noise regime,
where the target needs a same-marginal legal proper selector rather than clean
decoding.

## Proof Status

**Low-noise branch.** Let $A$ be the efficient distribution-free strong
realizable proper learner. Run $A$ at clean accuracy $1/32$ and let $m_0(s)$
bound the number of inspected labels. Set
$\alpha_A(s)=\min\{1/64,1/(128m_0(s))\}$ and choose an inverse-polynomial
$\gamma_P(s)\le\min\{1/64,\alpha_A(s)/8\}$. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_A(s)$, couple samples from
$\mathcal D$ to clean samples from a near-optimal $c^\star\in\mathcal C$ under
the same marginal $P$. With constant probability no inspected label is
corrupted, so the noisy transcript is a successful clean transcript and the
proper output has error at most
$\operatorname{OPT}_{\mathcal C}(\mathcal D)+3/64$. Repetition and holdout
validation give a legal weak agnostic candidate.

**Selector equivalence.** In the remaining regime
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge\alpha_A(s)$, the missing
object is a fixed-marginal middle-noise selector: a $P$-polynomial algorithm
that outputs a polynomial list of proper concepts containing some $h$ with
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-4\gamma_P(s).
$$
Combining such a list with the low-noise list and validating
$O(\gamma_P^{-2}\log(B/\delta))$ candidates proves the target. Conversely, any
target learner gives a singleton selector after shrinking constants. Thus this
selector is theorem-equivalent to the unresolved middle-noise content of the
edge. Equivalently, since $\gamma_P\le\alpha_A/8$, it would suffice in the
middle-noise branch to find any proper $h$ with correlation at least
$-\alpha_A(s)$ against the agnostic labels.

**Why the source does not supply the selector.** The realizable proper learner
is only constrained on realizable labeled distributions. Off-promise calls on
arbitrary, residual, random, or filtered labels can behave adversarially
without violating the source node. Used safely, the learner is only a clean
promise-extension oracle: it can realize a clean trace after the trace or
label corrections have been guessed. In middle noise, source-scale clean
subsamples are exponentially rare, while small clean subsamples do not force
global weak correlation. Fixed-marginal VC covers, compression, or trace
enumeration need additional effectivity assumptions.

**Why current witnesses miss.** Parity/LPN examples leak neutral wrong
hypotheses. Code and planted-code guards run into Bessel/Gram barriers or
balanced samplers. One-way and PRF templates either force the clean learner to
recover the secret on some marginal or legalize a nonsecret weak handle. PCP
and active-slice constructions either encode the hard instance in the marginal,
dilute the hard slice, or leave wrong-instance handles. Finite-support
set-system templates make exact optimization hard but generally have defaults,
local moves, approximations, or balanced samplers within the additive
$1/2-\gamma$ window; removing those handles tends to break clean promise
extension.

**Missing negative primitive.** A false result would need a fixed-marginal
weak signed-search construction: efficient clean proper promise extension, one
fixed marginal for all hard labels, and hardness of finding any legal proper
hypothesis with correlation at least $-1/\operatorname{poly}(s)$, with no
constants, complements, neutral samplers, defaults, local moves, wrong-code
handles, or wrong-instance handles. No standard hardness template currently
provides this.

**Conclusion.** The edge remains open. The realizable proper source proves
same-marginal low-noise robustification, but the middle-noise proper selector
is neither implied by the source definition nor refuted by known
fixed-marginal counterexample templates.
```

VERDICT: unresolved depth 7

## Depth 7A: Final Trace Primitive Audit

I re-audited the finite-support and trace-system false route after Depth 5A
and Depth 6A. I cannot instantiate the required primitive. The obstruction is
not merely that a named theorem is missing; the three needed properties pull
against one another in every standard finite trace template I can make
explicit.

### Trace Normal Form

Let the fixed marginal be uniform on a finite support $X_s$ of size $N$, and
let the legal proper traces be

$$
V_s\subseteq\{\pm1\}^{X_s}.
$$

For a signed label vector $y\in\{\pm1\}^{X_s}$ and a trace $v\in V_s$,
write

$$
\rho_y(v)=\frac1N\sum_{x\in X_s} v(x)y(x).
$$

Equivalently, for set-system traces $F\subseteq X_s$ with
$v_F=1_F-1_{X_s\setminus F}$ and
$W_y(F)=\sum_{x\in F}y(x)$,

$$
\rho_y(F)=\frac{2W_y(F)-\sum_x y(x)}N.
$$

Thus the empirical weak selector condition

$$
\rho_y(v)\ge \rho_y^\star-1+2\gamma
$$

is exactly the additive half-range condition

$$
W_y(F)\ge W_y^\star-\frac N2+\gamma N.
$$

This is the decisive normalization. A finite-support counterexample cannot
only make exact weighted optimization hard. It must make additive-$N/2$
signed search hard. In the middle-noise regime isolated in Depth 5A, after
choosing $\gamma_P(s)\le\alpha_A(s)/8$, it is enough for the weak learner to
find any legal trace with

$$
\rho_y(v)\ge -\alpha_A(s).
$$

So a false witness must rule out even mildly non-anti-correlated legal
outputs.

### Required Primitive

The finite trace primitive would need all of the following.

1. **Efficient clean promise extension.** From any polynomial sample labeled
   by a legal trace, the learner can output a legal trace that is consistent
   enough to give distribution-free strong realizable proper PAC learning.
   This must hold on arbitrary clean marginals, including marginals that hide
   any reveal, certificate, or global feasibility witness.

2. **One fixed label-only marginal.** The hard instance must be in the
   conditional label rule $y_z$, not in the support, graph, hypergraph,
   active slice, or coordinate weights defining the marginal. Otherwise the
   marginal-nonuniform polynomial can depend on the hard instance.

3. **Hard additive-$N/2$ weak signed search.** Given labeled samples from
   $y_z$ under the fixed marginal, finding any legal trace with correlation
   at least $-1/\operatorname{poly}(s)$ must be hard. A lower bound for exact
   maximum weight, nearest codeword, minimum cover, or near-OPT agnostic
   learning is not enough.

4. **No efficient weak handles.** There can be no legal default, no useful
   empty/full endpoint, no singleton or local move with inverse-polynomial
   mass, no approximation algorithm already inside the additive-half window,
   no efficiently sampleable distribution over legal traces with small
   barycenter, and no wrong-codeword or wrong-instance family that validation
   can exploit.

5. **No dilution.** If many hard instances are packed into one support, the
   challenge slice must still carry essentially half-range mass. Otherwise
   the additive $N/2$ slack swallows the hard part.

I do not know a standard object satisfying this checklist.

### Candidate Audit

**Monotone systems.** Upward-closed systems have the full set as a legal
default; downward-closed systems have the empty set. Those extremes solve all
low-signal signed instances. When an extreme is too anti-correlated, the
labels have a strong sign bias, and polynomial-support local moves or ordinary
approximations often enter the weak window. Imposing exact size, large
minimum distance, or global balance can remove the easy handles, but then
clean extension of arbitrary positive and negative samples becomes a global
feasibility problem rather than a promise-extension routine.

**Vertex covers, independent sets, and hitting systems.** Graph vertex covers
and graph independent sets have the clean promise-extension behavior described
in Depth 6A, but the additive-$N/2$ requirement is too weak: the all-in or
empty endpoint, singleton deletions/additions, and standard cover
approximations give selectors in the regimes where exact optimization is
hard. Hitting set and set cover have the same shape. Their ordinary ratio
hardness does not imply hardness of finding a set within additive $N/2$ of
the optimum, and any attempt to force all local handles away tends to
introduce exact-size or feasibility constraints that break the clean source.

**General hypergraph or universal CSP encodings.** Downward-closed
hypergraph independent sets initially look more dangerous: clean learning can
memorize sampled positives, while maximum independent set can be hard. But an
atlas-ready witness must not put the particular hypergraph or CSP instance in
the marginal. Packing many instances into one fixed support dilutes the
active slice, and using weights or labels over a universal fixed support
leaves subset, random-assignment, or approximation handles unless one
reimposes global exactness. If proper concepts are full assignments, clean
promise extension becomes SAT-like; if proper concepts are downward closures
or satisfiable subformulas, the local subset handles return.

**Matroids, matroid intersections, greedoids, and antimatroids.** Matroids
and two-matroid intersections have efficient weighted optimization, so they
give positive selector structure. Harder independence systems and greedoids
can separate extension intuition from optimization, but the clean learner is
no longer automatic: sampled positives may not be extendable without solving
the same reachability, ordering, or packing problem. Passing to a downward
closure restores clean memorization and also restores local handles. I do not
see a source-grounded additive-half lower bound for the closure.

**Codes and finite trace codes.** Linear or algebraic codes have efficient
clean erasure extension, but also efficient message samplers. Under the fixed
marginal, sampled wrong codewords are neutral or balanced often enough for
validation to find a weak handle. Guard blocks that make wrong codewords
negative run into the Depth 4 Bessel/Gram obstruction for large balanced
families. Making the code nonlinear, biased, planted, or hard to sample may
hide neutral handles, but then the distribution-free clean proper learner no
longer has an evident way to extend arbitrary promised partial traces. Nearest
codeword hardness is the wrong scale: it rules out near-optimal decoding, not
finding any trace of correlation just above $-1/\operatorname{poly}$.

### Why A Conditional False Statement Is Not Enough

One can state a custom assumption:

> There are trace families with efficient clean promise extension and a fixed
> marginal for which every polynomial-time algorithm that outputs a legal
> trace of correlation at least $-1/\operatorname{poly}(s)$ breaks a hardness
> assumption, and there is no efficient neutral sampler or local handle.

Under that assumption, the edge would be false. But this is not an
atlas-ready counterexample, because the assumption is exactly the missing
primitive restated. Depth 6A and this audit did not identify a standard
source for it among NP-hard ERM, set cover, hitting set, independent set,
greedoid optimization, PCP soundness, LPN, nearest-codeword hardness, or
ordinary coding constructions.

### Atlas-Ready Obstacle Summary

Finite-support trace systems reduce the desired false witness to additive
half-range signed optimization. For a uniform support of size $N$, the weak
proper agnostic selector over traces $V_s$ needs only

$$
W_y(v)\ge W_y^\star-\frac N2+\gamma N,
$$

or, in the middle-noise normal form, any legal trace with correlation at least
$-1/\operatorname{poly}(s)$. Existing finite trace families do not meet the
required primitive. Systems with efficient clean promise extension, such as
monotone families, graph covers or independent sets, matroids, linear codes,
and downward closures, provide extremes, local moves, approximation
algorithms, wrong traces, or balanced samplers that validation can use as
weak handles. Systems that hide all such handles do so by imposing exact-size,
global feasibility, non-sampleable code, or instance-specific constraints
that make clean proper promise extension hard or move the hard instance into
the marginal.

Therefore the finite-support/trace-system false route remains unavailable.
Resolving the edge as false would require a new fixed-marginal weak
signed-search primitive with efficient clean promise extension and no
efficient neutral legal handles. The current trace audit supplies an
atlas-ready obstacle, not an atlas-ready counterexample. It also does not
prove the edge true, because the middle-noise fixed-marginal proper selector
from Depth 5A remains unsupplied.

VERDICT: unresolved depth 7 scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 7B: Final Neutralizer Extraction Audit

This is the final positive-route audit. I tried one last time to extract the
same-marginal proper middle-noise selector directly from the assumed efficient
distribution-free strong realizable proper learner. I still do not see a valid
derivation. The obstruction is not a constants issue: after Depth 5A, the
only missing object is a legal proper candidate generator for arbitrary labels
under the same fixed marginal. Every extraction route below becomes valid only
after adding an assumption that is already a selector, balanced neutralizer, or
computable trace-search principle.

I use $\{\pm1\}$ labels. For a fixed marginal $P$ and joint distribution
$\mathcal D$ with regression $\phi(x)=\mathbf E[Y\mid X=x]$, write

$$
\rho_{\mathcal D}(h)=\mathbf E_P[h(X)\phi(X)],
\qquad
\rho^\star_{\mathcal D}=\sup_{c\in\mathcal C}\rho_{\mathcal D}(c),
\qquad
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
=\frac{1-\rho^\star_{\mathcal D}}2.
$$

Let $A$ be the source learner. Run it at clean accuracy $1/32$ and constant
failure probability, and let $m_A(s)$ be a polynomial bound on the number of
labels inspected. Set

$$
\alpha_A(s)=\min\left\{\frac1{64},\frac1{128m_A(s)}\right\}.
$$

The low-noise branch $\eta<\alpha_A$ is already handled by the same-marginal
coupling from Depth 5A. If $\eta\ge\alpha_A$ and
$\gamma_P(s)\le\alpha_A(s)/8$, then a proper hypothesis with

$$
\rho_{\mathcal D}(h)\ge-\alpha_A(s)
$$

is sufficient for the candidate-list stage, since

$$
\operatorname{err}_{\mathcal D}(h)
\le \frac12+\frac{\alpha_A}{2}
\le \eta+\frac12-4\gamma_P(s).
$$

Thus the final extraction target is a same-marginal proper neutralizer: from
samples with marginal $P$, produce a polynomial list containing one legal
$h\in\mathcal C$ that is not more than inverse-polynomially anti-correlated
with the current arbitrary label rule.

### Last Direct Extraction Attempt

The clean learner can be used safely in only two ways.

First, we may call it on labels known to be realizable by a concept already in
hand. This only regenerates or promise-extends known clean traces. Starting
from an anchor $a$, self-labeling fresh $P$-samples by $a$ returns concepts
close to $a$ under $P$ when the requested clean accuracy is small. If
$a$ is badly anti-correlated with the agnostic labels, this reinforces the bad
anchor. To leave the anchor direction one needs complements, balanced pairs,
restriction/pasting, or some other legal operation not supplied by the source.

Second, we may guess finite clean traces and ask $A$ to extend them. If the
trace has $k=O(\log s)$ constraints, all labelings can be tried in polynomial
time, but such a small trace need not control global correlation. A canonical
extension may satisfy those few constraints and be anti-correlated on the rest
of the marginal. If $k$ is large enough to force global weak behavior by VC or
cover arguments, then enumerating corrected traces or realizable labelings is
exponential in general. The source learner realizes a trace after it has been
found; it does not search the trace set.

All other uses of $A$ feed it arbitrary, random, residual, or filtered agnostic
labels. Those calls are off-promise. A learner can be modified to return one
fixed legal bad anchor on every off-promise transcript without changing the
source guarantee. Therefore no black-box argument may infer neutral behavior
from such calls. A non-black-box argument would need a representation theorem
saying that efficient realizable proper PAC learnability gives an efficiently
enumerable weak cover, balanced sampler, or weak trace optimizer. The previous
depths found no such theorem, and the usual VC/sample-complexity argument is
not computational.

So the positive extraction still collapses to the Depth 5A selector game.

### Hidden Assumptions Needed By The Failed Routes

The following list is atlas-ready: each item names the extra assumption that
would make the corresponding failed extraction route sound.

1. **Off-promise learner calls.** Needed assumption: off-promise stability and
   total properness. On arbitrary same-marginal labeled samples, the learner
   must output legal concepts and, in the middle-noise regime, a polynomial
   list containing some $h$ with
   $\rho_{\mathcal D}(h)\ge-\alpha_A(s)$. This is not a consequence of
   realizable PAC learning; it is the neutralizer selector itself.

2. **Anchor and self-labeling.** Needed assumption: effective complements,
   balanced pairs, or an operation generating legal descendants whose
   $P$-barycenter has $L_1(P)$ norm $O(\alpha_A)$. Self-labeling by known
   concepts alone preserves the existing bias and cannot rescue a bad anchor.

3. **Random finite constraints.** Needed assumption: small-trace diversity, or
   an efficient weak trace-search theorem. Polynomially many realizable
   extensions of $O(\log s)$ constraints must contain a globally weakly useful
   proper concept for every label rule. Without this, the extensions can agree
   on the sampled constraints and be bad elsewhere.

4. **Clean-subsample consistency.** Needed assumption: either the middle-noise
   rate is low enough that VC-scale all-clean samples occur with
   inverse-polynomial probability, or there is an efficient correction-search
   mechanism. For genuine middle noise, finding a large clean subset relative
   to a near-best concept is exactly the agnostic search problem.

5. **Mistake-region conditioning.** Needed assumption: a proper learner
   tolerant to the induced conditional noise, or proper restriction/pasting
   plus projection back into $\mathcal C$. Conditioning on a failing anchor
   can identify a useful region, but the labels on that region remain
   agnostic and the patched classifier need not be legal.

6. **Fixed-marginal VC covers.** Needed assumption: an efficiently computable
   $L_1(P)$ proper cover, efficient proper ERM, or an efficiently enumerable
   proper compression scheme at weak scale. Finite VC dimension gives the
   sample-only cover, but not a polynomial-time generator for valid proper
   representatives.

7. **Mixtures and randomized predictors.** Needed assumption: either a
   polynomial-time sampler over legal concepts with small $P$-barycenter, or a
   proper projection of a neutral randomized predictor into $\mathcal C$.
   A neutral average predictor is not enough unless a legal component or legal
   projection is available.

8. **Full-support marginal waiting.** Needed assumption: polynomially frequent
   useful clean transcripts or useful trace extensions under the fixed
   marginal, with a lower bound independent of the label rule. Marginal
   nonuniformity permits $P$-dependent polynomials, but not a polynomial that
   depends on the hidden regression or absorbs exponential trace search in
   the representation size.

9. **Validation.** Needed assumption: the generated list already contains a
   legal good candidate, or there is a syntactic membership filter for proper
   hypotheses. Holdout validation can select among candidates; it cannot
   manufacture legality, complements, balance, or trace-search power.

### Clean Conditional Theorem

The conditional positive statement should be recorded as follows.

**Conditional same-marginal selector theorem.** Suppose
$\mathcal C$ has an efficient distribution-free strong realizable proper PAC
learner $A$. Let $\alpha_A$ be defined from a constant-accuracy run of $A$ as
above. Assume additionally that there is one uniform randomized algorithm $N$
such that for every fixed marginal $P$ there are a $P$-dependent polynomial
$q_P$ and an inverse-polynomial gap

$$
0<\gamma_P(s)\le \min\left\{\frac1{64},\frac{\alpha_A(s)}8\right\}
$$

with the following property. For every joint distribution $\mathcal D$ with
marginal $P$, every confidence parameter $\delta$, and every size parameter
$s$, if

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge\alpha_A(s),
$$

then $N$, given samples from $\mathcal D$, runs in time
$q_P(s,\log(1/\delta))$ and outputs a list
$L_{\mathrm{mid}}\subseteq\mathcal C$ of size at most
$q_P(s,\log(1/\delta))$ that contains, with probability at least
$1-\delta/8$, some $h$ satisfying the selector bound

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-4\gamma_P(s).
$$

It is enough, and often cleaner, to assume instead the stronger middle-noise
neutralizer condition

$$
\rho_{\mathcal D}(h)\ge-\alpha_A(s).
$$

Then the edge

$$
\text{efficient-realizable-proper-pac}
\Rightarrow
\text{efficient-marginal-nonuniform-weak-agnostic-proper-pac}
$$

is true.

The proof is the Depth 5A union-and-validation proof. On every input, run the
low-noise generator obtained by repeating $A$ on the observed labels, run
$N$, and validate the union of the two polynomial candidate lists on fresh
examples. If $\operatorname{OPT}<\alpha_A$, the coupling to a clean run of
$A$ supplies a proper candidate with error far below
$\operatorname{OPT}+1/2-\gamma_P$. If
$\operatorname{OPT}\ge\alpha_A$, the selector assumption supplies a candidate
with error at most $\operatorname{OPT}+1/2-4\gamma_P$. A holdout sample of
size

$$
O\left(\gamma_P(s)^{-2}
\log\frac{|L_{\mathrm{low}}|+|L_{\mathrm{mid}}|}{\delta}\right)
$$

estimates all candidate errors to within $\gamma_P$, so the empirical winner
has error at most

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s).
$$

All bounds are polynomial in $s$ and $\log(1/\delta)$ with a polynomial
allowed to depend on the fixed marginal $P$.

### Final Audit Verdict

I cannot derive the selector $N$ from efficient strong realizable proper PAC
alone. The source learner gives low-noise robustification and clean
promise-extension power. It does not give off-promise stability, a balanced
proper sampler, computable fixed-marginal covers, efficient weak trace
optimization, complement/projection structure, or conditional noise tolerance.
Each of those additions would prove the edge by the theorem above, but each is
an extra assumption rather than a consequence of the source node.

I also do not have a false witness, so this audit does not justify changing
the atlas edge to false. The correct status after the final positive-route
attempt remains open: the middle-noise same-marginal proper selector is exactly
the unresolved content.

VERDICT: unresolved depth 7 scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md
