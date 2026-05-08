## Depth 1 Branch A: Proper Selector Obstruction

### Setup

I read the edge note
`atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
first. Its current `open` diagnosis is accurate: same-marginal low-noise
coupling gives proper candidates near realizability, but the middle-noise
branch needs a legal proper neutralizer or selector not supplied by weak
realizable proper learning alone.

The source gives one uniform proper learner $A$. For every instance marginal
$P$, there are a $P$-dependent polynomial resource bound $m_P(s)$ and an
inverse-polynomial weak advantage $\gamma_P(s)$ such that, on clean labels
$Y=c(X)$, $A$ outputs $h\in\mathcal C$ with
$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s).
$$

The target asks, for the same marginal $P$, for a proper learner returning
$h\in\mathcal C$ such that for every joint distribution $\mathcal D$ with
$P=\mathcal D_X$,
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\alpha_P(s)
$$
for some inverse-polynomial $P$-dependent gap $\alpha_P(s)>0$.

Local sources checked include the endpoint notes, the edge note, and the
argument/witness notes `marginal-agnostic-hardness-open`,
`low-noise-weak-agnostic-robustification`, `properization-open`,
`marginal-boosting-open`, `agnostic-boosting-open`,
`halfspace-agnostic-hardness`, `pcp-active-slice-weak-proper-hardness`, and
`one-way-image-coordinate-weak-handle-hardness`. Relevant local bibliography
keys already present include `benedek1991fixed`,
`bendavid1995parameterization`, `hanneke2025marginalnonuniform`,
`tiegel2023`, `feldman2012monomials`, `kearns1994cryptographic`,
`hastad1999prg`, `hastad2005query`, `karp1972`, `valiant1984`, and
`blumer1989`.

### Low-Noise Branch: True And Proper

Fix $P$ and choose
$$
\alpha_P(s)\le
\min\left\{\frac{\gamma_P(s)}8,\frac1{100m_P(s)},\frac1{100}\right\}.
$$
Let $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$ and suppose
$\eta<2\alpha_P(s)$. Choose
$c^\star\in\mathcal C$ with
$\operatorname{err}_{\mathcal D}(c^\star)\le \eta$ up to negligible slack.
Run $A$ on noisy examples from $\mathcal D$, but couple this run to a clean
realizable run on $(X,c^\star(X))$ using the same original
$P$-distributed instance sequence and the same internal randomness.

The probability that one invocation sees any label differing from
$c^\star(X)$ is at most
$$
m_P(s)\eta < 2m_P(s)\alpha_P(s)\le \frac1{50}.
$$
On the no-corruption event, the transcript is exactly a realizable transcript
under the original marginal $P$, not under a conditioned marginal. Therefore
the source guarantee returns a proper $h\in\mathcal C$ with
$$
\operatorname{err}_P(h,c^\star)\le \frac12-\gamma_P(s).
$$
Hence
$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\operatorname{err}_P(h,c^\star)
\le
\eta+\frac12-\gamma_P(s)
\le
\eta+\frac12-\alpha_P(s).
$$
Repetition and validation stay within a $P$-dependent polynomial. Thus
agnostic noise does not obstruct the near-realizable branch; the properness is
preserved because $A$ itself outputs concepts in $\mathcal C$.

### Middle-Noise Branch: The Missing Legal Fallback

For the analogous improper robustification, the complementary regime
$\eta\ge 2\alpha_P(s)$ is handled by the two constant classifiers: one has
error at most $1/2$, and
$$
\frac12\le \eta+\frac12-\alpha_P(s).
$$
This does not prove the assigned proper edge, because constants need not lie
in $\mathcal C$.

The same proof would become a theorem under any legal proper neutralizer. It
is enough that, for every fixed $P$ and size $s$, a $P$-polynomial procedure
produce a validation-searchable list $N_{P,s}\subseteq\mathcal C$ such that
for every label regression $r(x)=\mathbf E[Y\mid X=x]$ in the middle-noise
regime, some $b\in N_{P,s}$ has nonnegative correlation with $r$:
$$
\langle r,b\rangle_P\ge 0.
$$
Legal constants, a known anchor together with its legal complement, or an
efficiently samplable $P$-balanced proper ensemble all satisfy this condition.
The source node, however, does not include any of these structures.

In $\{\pm1\}$ notation, the exact target is the relative selector condition
$$
\langle r,h\rangle_P
\ge
M(r)-1+2\alpha_P(s),
\qquad
M(r)=\sup_{c\in\mathcal C}\langle r,c\rangle_P.
$$
The low-noise coupling handles the case $M(r)$ is extremely close to $1$.
Neutralizers handle cases where this threshold is nonpositive. The open zone
is a proper weak selector problem: find any legal concept above the weak
relative threshold without assuming constants, complements, proper ERM, a
balanced sampler, or useful behavior of $A$ on inconsistent transcripts.

### Why The Source Does Not Seem To Extract A Neutralizer

Running $A$ on illegal constant labels, random labels, flipped labels, or
agnostic labels gives no certificate, because the source guarantee applies
only to realizable samples. Running $A$ on labels produced by legal concepts
only says that the output kernel $K(c,\cdot)$ has positive correlation with
the clean input concept:
$$
\mathbf E_{h\sim K(c,\cdot)}\langle c,h\rangle_P\ge 2\gamma_P(s).
$$
This one-sided condition does not force a balanced barycenter of outputs.
A class may have a universal weak handle that is weakly correlated with every
clean target under a given $P$, and a valid source learner may always return
that handle. Such behavior is consistent with weak realizable proper learning
but useless as a neutralizer against arbitrary middle-noise labels.

This observation is not itself a counterexample. If all legal concepts share a
common bias and the labels oppose that bias, the best proper concept also pays
the same loss, so the weak agnostic threshold relaxes with
$\operatorname{OPT}_{\mathcal C}$. The missing object is therefore relative,
not absolute: one must either derive an efficient selector above
$M(r)-1+2\alpha_P(s)$ or build a witness where finding any such selector is
hard.

### Witness Search

I do not see an atlas-ready false witness.

**Halfspaces.** Halfspaces satisfy the source by linear feasibility and VC
generalization, and local notes cite Tiegel's lattice-based agnostic hardness
under `tiegel2023`. But the recorded hardness is useful for stronger
distribution-free or strong marginal agnostic targets. It does not refute this
fixed-additive weak target with a hidden $P$-dependent inverse-polynomial gap.
Moreover, standard halfspace classes contain legal constant halfspaces, so the
legal-neutralizer wrapper makes them positive examples for this exact weak
marginal target.

**Parities and LPN-like ideas.** Clean parities are properly learnable, and
noisy parity suggests fixed-marginal selector hardness. The obstruction is
that wrong parities are neutral under the uniform marginal. If the noise rate
is below $\alpha_P(s)$, low-noise coupling applies; if it is above
$\alpha_P(s)$, a neutral wrong parity often already satisfies the weak
agnostic inequality. LPN hardness is recovery hardness, while this edge often
requires only avoiding an anti-correlated output.

**FGRW, monomials, and PCP active slices.** Local notes around
`feldman2012monomials` and `pcp-active-slice-weak-proper-hardness` have the
right weak-agnostic flavor, but the known reductions either vary the hard
marginal, operate at constant/subpolynomial gaps, or make clean weak proper
learning hard on the active slice. Packing all hard slices into one fixed
marginal dilutes the weak gap unless one also proves that every weakly
acceptable proper output decodes the hard witness.

**One-way image-coordinate handles.** The local
`one-way-image-coordinate-weak-handle-hardness` witness separates nearby strong
proper targets under one-way function assumptions, but the handles added to
make clean weak proper learning easy also become legal weak agnostic fallbacks
after validation. Removing those handles threatens the source; keeping them
breaks the separation.

**Pure anti-code geometry.** A false witness would like every wrong proper
hypothesis to be more than $1/2+\tau$ away from the hard labels under one
fixed marginal. For inverse-polynomial $\tau$, Plotkin/Gram-matrix geometry
prevents exponentially many binary concepts from being pairwise that
anti-correlated under one fixed marginal. Thus a separation must be
computational selector hardness, not merely pairwise distance geometry.

### Obstacles

1. The low-noise coupling only covers
   $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ below the inverse of the
   source transcript scale.
2. The improper middle-noise proof uses constants, and constants need not be
   legal proper hypotheses.
3. Weak realizable proper learning gives no guarantees on noisy transcripts
   and does not provide proper ERM, complement closure, a balanced proper
   sampler, or a fixed-marginal relative selector.
4. Known witnesses either vary the marginal, prove strong rather than weak
   fixed-marginal hardness, contain legal neutralizers/handles, or leave
   neutral wrong hypotheses that are enough for the weak agnostic bound.

### Next Directions

1. Formalize the conditional positive lemma: same-marginal low-noise coupling
   plus legal constants, complement-pair anchors, a balanced proper ensemble,
   or a validation-searchable fixed-$P$ proper neutralizer implies the target.
2. Attack the relative selector lemma directly: determine whether the source
   implies an efficient procedure finding
   $\langle r,h\rangle_P\ge M(r)-1+2\alpha_P(s)$, perhaps using only
   validation and self-labeled realizable calls.
3. Build a fixed-marginal residual-block witness where clean weak proper
   learning remains easy under every marginal, but every proper output meeting
   the weak agnostic threshold decodes a hard instance and all legal handles
   are below threshold.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 2 Branch A: Shadow Selector Barrier

### Sharpened Target

Keep the notation from Depth 1. Fix the marginal $P$, size parameter $s$,
and a source weak advantage $\gamma_P(s)$ with transcript scale
$m_P(s)$. Write labels in $\{\pm1\}$ form, let
$r(x)=\mathbf E[Y\mid X=x]$, and set
$$
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P .
$$
The weak agnostic target with gap $\alpha_P(s)$ asks for a proper
$h\in\mathcal C_s$ with
$$
\langle r,h\rangle_P\ge M(r)-1+2\alpha_P(s).
$$

The important refinement is that middle noise is not itself the problem once
one has a clean weak shadow of an optimal concept. If
$c^\star\in\mathcal C_s$ has agnostic error $\eta$ and
$h\in\mathcal C_s$ satisfies
$$
\operatorname{err}_P(h,c^\star)\le \frac12-\gamma_P(s),
$$
then for arbitrary labels, not only random classification noise,
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+\operatorname{err}_P(h,c^\star)
\le
\eta+\frac12-\gamma_P(s).
$$
Thus any such shadow is already a valid weak agnostic output for
$\alpha_P(s)\le \gamma_P(s)/2$. This recasts the obstruction: the proper
selector need not recover $c^\star$, but it must generate some legal concept
from the clean weak neighborhood
$$
S(c^\star)=\{h\in\mathcal C_s:\operatorname{err}_P(h,c^\star)
\le 1/2-\gamma_P(s)/2\}.
$$
The source learner samples from $S(c^\star)$ only when it is fed clean labels
$c^\star(X)$. The agnostic learner has samples from $r$, and the current
source promise says nothing about how $A$ behaves on inconsistent
transcripts.

### Why The Standard Middle-Noise Tricks Still Do Not Create The Shadow

**Validation.** Validation is only a selector over a candidate list. If a
candidate generator supplies some member of $S(c^\star)$, validation chooses
it up to the usual slack. If the list contains only legal concepts outside
all useful shadows and no neutralizer, validation has no way to certify a
missing concept. This is exactly why fixed-$k$ DNF works: Schapire's
polynomial list of constants and short clauses hits a weak shadow of every
clean target. The abstract marginal-nonuniform weak source gives the
existence of successful clean transcripts, not a searchable list of their
outputs.

**Random relabeling.** Suppose the best concept has error $\eta$ under
$\mathcal D$. Any relabeling rule that treats examples independently can make
an individual label agree with $c^\star(X)$ with probability at most
$1-\eta'$ for some $\eta'>0$ in the middle-noise regime. A source invocation
using $m_P(s)$ labels is then exactly clean with probability at most
$(1-\eta')^{m_P(s)}$, exponentially small once $\eta' m_P(s)$ is not
$O(\log s)$. The low-noise branch is precisely the regime where this
probability remains inverse-polynomial; random relabeling does not extend it
to middle noise without an additional noise-tolerance guarantee for $A$.

**Tournaments and pairwise comparisons.** Pairwise tests can compare two
proper hypotheses by empirical error on the agnostic sample, but they do not
manufacture a hypothesis close to $c^\star$. They are useful after a shadow
list exists. Without such a list, a tournament can consistently pick the best
available bad candidate.

**Off-promise calls to the realizable learner.** Running $A$ on random labels,
constant labels, flipped labels, or the agnostic labels can output legal
concepts, but the source imposes no accuracy or symmetry condition on those
transcripts. A valid source learner may be deliberately unhelpful off promise:
on every inconsistent transcript it can output a fixed legal concept that is
bad for the present $r$, while still satisfying the clean realizable
guarantee. This blocks black-box wrappers that rely on off-promise behavior.

**Neutralizers.** If one can find a legal $b\in\mathcal C_s$ with
$\langle r,b\rangle_P\ge0$, then every case with
$M(r)\le 1-2\alpha_P(s)$ is solved. The source does not force such a
validation-searchable neutralizer. In particular, the kernel condition
obtained from clean calls,
$$
\mathbf E_{h\sim K(c)}\langle c,h\rangle_P\ge 2\gamma_P(s),
$$
is one-sided around each clean target $c$ and need not make the barycenter of
obtainable outputs balanced against an arbitrary regression $r$.

### Counterexample Search At Depth 2

I tried to turn the obstruction into a concrete same-marginal false witness,
but the natural constructions still leak weak proper outputs.

**Noisy codeword or parity selector.** Let labels be a noisy version of a
hidden concept $c_y$, and make proper hypotheses be codewords. If wrong
codewords are orthogonal to $c_y$ under $P$, then they have correlation
approximately $0$ with the noisy labels. In the middle-noise regime
$M(r)\le 1-2\alpha_P(s)$, this already satisfies the weak target. Therefore
ordinary LPN/parity recovery hardness is too strong a task: the weak
agnostic learner may output a neutral wrong codeword.

To force wrong codewords to fail at noise level $\eta>\alpha_P(s)$, one
needs wrong outputs to have correlation below roughly $-2\eta+2\alpha_P(s)$
with the labels. Under classification noise this means inverse-polynomial
negative pairwise correlations with the hidden clean concept. A Gram-matrix
or Plotkin bound then allows only $O(1/\tau)$ codewords with pairwise
correlation at most $-\tau$. For inverse-polynomial $\tau$, this gives at
most polynomially many purely geometric hard targets, so it cannot by itself
support a cryptographic or NP-hard selector family. A false witness must make
finding even a neutral or mildly positive legal concept computationally hard,
not merely make exact recovery hard.

**One-way image-coordinate handles.** The existing one-way image-coordinate
weak-handle class is source-positive because constants and singleton or
bounded positive-atom handles give clean weak proper learning under every
marginal. Those same handles are also weak agnostic fallbacks after
validation. Removing constants or handles can make the middle-noise labels
harder, but then marginals concentrated on the positive or negative residual
blocks break the realizable weak source. This is the same tension as in Depth
1, now phrased as shadow-list leakage: the handles that hit clean shadows also
hit enough agnostic shadows.

**Anti-handle residual block.** A tempting new template is to put a hard
hidden family on a residual block and add public handles that weakly correlate
with every clean target. Then choose agnostic labels that oppose the public
handles while preserving a moderately good hidden concept. Quantitatively,
this does not yet work. If a public handle is within $1/2-\gamma_P(s)$ of the
hidden concept, the triangle inequality above makes it a valid agnostic
output for any label rule once $\alpha_P(s)<\gamma_P(s)$. If the handle is
not that close on some marginal, it no longer certifies the source for clean
labels under that marginal.

### Current State

This depth-2 pass did not produce an atlas-ready true proof or false witness.
It did isolate the exact missing object more sharply: a positive proof needs a
way, from agnostic samples and the clean realizable source, to generate a
validation-searchable list intersecting the clean weak shadow
$S(c^\star)$ of some near-optimal concept, or else a legal neutralizer for
the current regression. Existing validation, random relabeling, tournaments,
and off-promise calls do not provide that object.

For depth 3, the most concrete next directions are:

1. Prove a conditional shadow-list lemma: if for each fixed $P,s$ there is a
   $P$-polynomial procedure producing a list $L_{P,s}$ such that every
   $c\in\mathcal C_s$ has some $h\in L_{P,s}\cap S(c)$, then the edge is
   true by validation; then classify which known classes satisfy this
   condition.
2. Try to build a computational neutralizer-hard witness rather than a
   recovery-hard witness: one fixed marginal and one hard regression $r_y$
   such that every efficiently findable proper hypothesis with
   $\langle r_y,h\rangle_P\ge0$ decodes $y$, while the class still has clean
   weak shadows for every target and every marginal.
3. Formalize a black-box lower bound for wrappers around the source learner:
   allow validation, random relabeling, pairwise comparisons, and
   self-labeled clean calls, but make off-promise behavior adversarial; show
   that such wrappers cannot guarantee a shadow or neutralizer without an
   additional searchable-list assumption.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 3 Branch A: Hidden Shadows And Neutral Leakage

### Branch Goal

I tried to decide whether the shadow-selector barrier is only a proof
artifact. The precise question was:

Can a same-marginal weak realizable proper learner force, without off-promise
calls, a proper hypothesis in the weak $P$-neighborhood of a near-optimal
agnostic comparator? Or can one build a class where such shadows exist on
clean labels but are unavailable from noisy labels, while clean weak proper
learning remains easy for every marginal?

I do not have an atlas-ready resolution. The branch did rule out one tempting
false route and sharpened what a real witness would have to do.

### Promise-Respecting Shadow Extraction

Fix $P,s$ and write labels in $\{\pm1\}$ notation. For a regression
$r(x)=\mathbf E[Y\mid X=x]$, set
$$
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P .
$$
The target with gap $\alpha$ asks for
$$
\langle r,h\rangle_P\ge M(r)-1+2\alpha .
$$

If $c^\star$ is a near-maximizer and some proper $h$ satisfies
$$
\Pr_P[h(X)\ne c^\star(X)]\le \frac12-\rho ,
$$
then, for every regression $r$ with $\|r\|_\infty\le1$,
$$
\langle r,h\rangle_P
\ge
\langle r,c^\star\rangle_P-2\Pr_P[h\ne c^\star]
\ge
M(r)-1+2\rho
$$
up to the near-optimality slack. Thus any clean weak shadow of the
near-optimal comparator is automatically a weak agnostic solution. This is
stronger than the low-noise coupling: the shadow works for arbitrary agnostic
labels once it has been found.

The problem is generation. The source learner samples such a shadow only when
fed clean labels from $c^\star$. If an agnostic learner refuses off-promise
calls, then its legal clean calls are only self-labeled calls for concepts it
already knows how to output. This explores the closure of the currently known
proper hypotheses under the clean-output kernel of the source learner. The
source assumption does not say that this closure reaches the shadow
neighborhood of every possible comparator. A class could decompose, at least
from the black-box point of view, into many clean components: on clean labels
from a concept in component $i$, the source returns another concept in
component $i$, while a promise-respecting wrapper initialized in public
components never reaches the hidden component containing $c^\star$.

This gives a genuine black-box barrier, not a separation of the atlas edge.
A non-black-box agnostic learner might sample components directly, enumerate a
cover, solve weak ERM, or exploit representation structure ignored by the
source learner. Still, it explains why no proof can rely only on clean calls to
the given learner unless it also proves a component sampler, trace cover, or
proper selector.

### Why Public Handles Cannot Be A False Witness

The natural way to make clean weak learning easy is to add public handles:
for every target $c$, some easily findable $h_c\in\mathcal C$ is within
$1/2-\rho$ of $c$ under the current marginal. But such handles immediately
solve the agnostic problem by the inequality above. In particular, an
anti-handle agnostic label rule cannot push a true clean shadow below the weak
agnostic threshold without making $\alpha>\rho$.

This kills the most direct residual-block construction. Suppose a hidden hard
block carries concepts $c_y$, and public handles are added so that clean weak
proper learning is easy on every marginal. If a handle is good enough to prove
the source for clean $c_y$ under that marginal, then the same handle is a
valid weak agnostic output for every regression for which $c_y$ is
near-optimal. Validation on the agnostic sample can select it once the
candidate generator exposes it. If the handle is hidden from the agnostic
learner, it is no longer a public proof of the source; one must explain how
the clean learner finds it from realizable labels and why noisy labels do not.

So a false witness cannot use target-independent public weak handles. It must
make the successful clean shadows label-dependent and computationally
extractable only from perfectly consistent labels.

### Why Noisy-Code Recovery Is Still Too Strong

The next false route is a noisy-code selector: clean labels identify a codeword
$c_y$, but agnostic labels are a noisy version of $c_y$, and finding any
acceptable proper output should decode $y$.

For ordinary classification noise at rate $\eta$, the regression is
$r=(1-2\eta)c_y$, so the threshold for a wrong concept $h$ is
$$
(1-2\eta)\langle c_y,h\rangle_P
\ge
(1-2\eta)-1+2\alpha .
$$
Equivalently, $h$ fails only if
$$
\langle c_y,h\rangle_P
<
\frac{-2\eta+2\alpha}{1-2\eta}.
$$

If $\eta$ is larger than the hidden weak gap $\alpha$, this bound is negative.
Neutral wrong hypotheses, with correlation near $0$, already satisfy the weak
agnostic requirement. Thus LPN-style or noisy-parity recovery hardness is too
strong a task for this edge: the learner need not recover $y$ if it can find a
neutral proper concept.

Trying to make all nondecoding concepts negatively correlated runs into the
same weighted Plotkin/Gram obstruction noted earlier. A large family cannot
have every wrong concept inverse-polynomially anti-correlated with every
target under one fixed marginal. More generally, if there is an efficient
sampler over a large proper subfamily whose average correlation with each
hidden target is not too negative, then validation over sampled candidates
finds a weakly acceptable neutral output. Therefore a computational witness
must also hide any neutral sampler, not merely make exact recovery hard.

### Conditional Positive Statement Reconfirmed

The branch does give a clean conditional theorem.

Assume that for every fixed $P,s$ there is a $P$-polynomial candidate
generator producing, with high probability, a list
$L_{P,s}\subseteq\mathcal C_s$ such that for every $c\in\mathcal C_s$ some
$h\in L_{P,s}$ satisfies
$$
\Pr_P[h(X)\ne c(X)]\le \frac12-\rho_P(s)
$$
for inverse-polynomial $\rho_P(s)$. Then the edge is true: on agnostic data,
draw the list, validate all candidates, and output the empirical minimizer.
For a near-optimal $c^\star$, the displayed shadow inequality gives
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\rho_P(s)
$$
up to validation slack. The earlier low-noise coupling is only needed when the
list generator is replaced by the source learner on noisy labels.

This conditional theorem also explains the obstruction exactly. The source
guarantee says that such a shadow is sampled from the clean transcript
distribution for each $c$, not that all shadows can be generated from $P$
alone in polynomial time.

### Current Obstacles

1. Promise-respecting clean calls only generate shadows of concepts already
available to the wrapper; they do not force a shadow of the unknown agnostic
comparator.
2. Public handles or public weak covers make the edge true, because any
proper shadow of a near-optimal comparator works for arbitrary agnostic
labels by the triangle inequality.
3. Noisy-code and LPN-style witnesses leave neutral wrong hypotheses that meet
the fixed-additive weak target once the noise is above the hidden weak gap.
4. A real false witness must simultaneously provide every-marginal clean weak
proper learning, hide all useful clean shadows from noisy labels, and prevent
efficient neutral proper sampling under one fixed marginal.

### Depth 4 Directions

1. Formalize the black-box component barrier: define an oracle source learner
whose clean-output kernel preserves hidden components, and prove that any
promise-respecting wrapper with validation cannot reach a comparator shadow
without a component sampler or off-promise assumptions.
2. Search for inverse-polynomial low-OPT weak no-advantage hardness, not
recovery hardness: a fixed marginal and regression family where every proper
hypothesis above $M(r)-1+2s^{-K}$ decodes the hard witness, while clean labels
remain weakly learnable under every marginal.
3. Try the opposite structural theorem: from every-marginal weak realizable
proper learnability plus standard efficient representation assumptions, prove
an efficient fixed-$P$ sampler for approximate clean shadows or for neutral
proper concepts. The component barrier indicates exactly where such a theorem
would need non-black-box representation input.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 4 Branch A: Public Shadows Or No Neutral Sampler

### Branch Question

I focused on the obstruction left by Depth 3: can the clean weak shadow of an
agnostic comparator be made public enough for validation, or can a false
witness keep those shadows visible only under perfectly clean labels while
also preventing neutral proper outputs?

I still do not see an atlas-ready resolution. The pass did sharpen the fork:
any public clean shadow, public weak cover, or public neutral sampler seems to
make the edge true immediately. Therefore a counterexample cannot merely hide
the optimal concept from noisy labels. It must also make every efficiently
findable deterministic proper hypothesis fall below the weak threshold unless
that hypothesis decodes the hidden clean shadow.

### Validation Makes Public Shadows Fatal To A Counterexample

Fix $P,s$ and use $\{\pm1\}$ labels. Let
$r(x)=\mathbf E[Y\mid X=x]$ and
$M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P$. If
$c^\star$ is a near-maximizer and a deterministic proper candidate $h$ obeys
$$
\operatorname{err}_P(h,c^\star)\le \frac12-\rho ,
$$
then for every agnostic label rule,
$$
\langle r,h\rangle_P
\ge
\langle r,c^\star\rangle_P-1+2\rho
\ge
M(r)-1+2\rho-o(1).
$$
Equivalently,
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+\frac12-\rho+o(1).
$$
So once a candidate generator exposes even one such shadow, ordinary holdout
validation is enough; the validation sample does not need to know that the
candidate came from a clean shadow.

This rules out a broad family of false witnesses. Public handles, public
weak covers, and clean-shadow lists generated from the marginal alone all
leak the target. The labels may be adversarially noisy, but the triangle
inequality above is label-rule independent. An "anti-handle" construction can
only work if the handle is not actually within the clean weak neighborhood of
the near-optimal comparator, in which case it also cannot be the object that
proves the source under that marginal.

### Neutral Proper Outputs Are The Other Leak

The middle-noise branch only needs a weaker object when
$M(r)\le 1-2\alpha$: a legal $h$ with nonnegative, or slightly negative,
correlation against $r$. More generally, if an efficient sampler over
deterministic proper concepts has barycenter $b_Q(x)=\mathbf E_{h\sim Q}h(x)$
with
$$
\langle r,b_Q\rangle_P\ge -\varepsilon ,
$$
then drawing polynomially many candidates from $Q$ and validating finds a
deterministic proper $h$ with
$$
\langle r,h\rangle_P\ge -O(\varepsilon)
$$
up to sampling and validation slack. Thus balanced samplers, complement pairs,
legal constants, and many random-code families also make the edge true in the
middle regime.

The clean source kernel does not itself give such a sampler. On clean target
$c$, it only supplies an output distribution $K(c)$ with
$$
\mathbf E_{h\sim K(c)}\langle c,h\rangle_P\ge 2\gamma_P(s).
$$
This is a family of target-indexed one-sided kernels. It need not expose any
target-independent barycenter, and off-promise calls can be adversarially
uninformative. Self-labeled clean calls only explore shadows of concepts
already in hand. The missing step is not validation; it is producing a list
that intersects either a clean shadow of $c^\star$ or a neutral region for
the current regression.

### Point-Mass Handles Do Not Seem To Globalize

I also checked a possible positive route from the every-marginal source
promise. For a point mass $\delta_x$, clean weak learning implies that, given
repeated examples labeled by a bit $b$ realized at $x$, the source learner can
eventually output some legal concept taking value $b$ at $x$ with advantage
over guessing. This looks like a supply of local proper handles.

The problem is that a local handle need not be neutral under the original
marginal $P$. Its behavior away from $x$ can be completely hostile to the
current regression $r$. Validation can discard bad local handles, but it does
not prove that among polynomially many sampled points there is a good one.
Moreover, the marginal-nonuniform weak advantage for $\delta_x$ need not
assemble into one $P$-polynomial global cover of useful handles. The source
therefore gives local legality certificates, not a balanced proper ensemble.

This blocks a clean positive proof via point marginals. To make it work one
would need an additional envelope statement: for $P$-most useful atoms or
cells, the local handles generated from clean point-mass labels have
collectively nonnegative validated correlation against every middle-noise
regression. I do not see that statement following from the source definition.

### Hidden-Shadow False Witness Attempt

The most plausible false template is an exact-decodable but noisy-hard code.
Clean labels identify a hidden key $y$ well enough that a proper clean learner
can output a shadow $h_y$ of the target. Noisy labels at rate $\eta$ should
hide $y$, and every weakly acceptable proper output should decode enough of
$y$ to contradict the assumed hardness.

The same quantitative obstruction reappears. If wrong proper hypotheses are
neutral under the hard marginal, then for classification noise around
$c_y$ the threshold is
$$
(1-2\eta)\langle c_y,h\rangle_P
\ge
(1-2\eta)-1+2\alpha
=2(\alpha-\eta).
$$
When $\eta\ge\alpha$, a neutral wrong hypothesis already satisfies the weak
target. When $\eta<\alpha$, the generic low-noise coupling can choose
$\alpha$ below the inverse clean transcript scale and recover a clean shadow
with inverse-polynomial probability. Thus ordinary noisy-code recovery
hardness is aimed at the wrong task.

To make the noisy-code route work in the middle regime, all efficiently
findable nondecoding proper hypotheses must be noticeably anti-correlated
with the hidden labels. Pure geometry cannot enforce this for a large public
family under one fixed marginal: inverse-polynomial pairwise
anti-correlation runs into the same PSD/Plotkin barrier from the earlier
branches, and near-orthogonal random proper concepts are neutral leaks.
Therefore the witness would need computational no-neutral-sampler hardness:
neutral or mildly positive concepts may exist, but any polynomial-time
method for finding one must decode the hidden shadow.

That is stronger than standard LPN or nearest-codeword hardness. Those
assumptions make recovery hard; this edge requires hardness of finding even a
deterministic proper non-anti-correlated output after validation.

### Current Obstacles

1. A public clean shadow of a near-optimal comparator immediately gives the
   weak agnostic output, independently of the agnostic noise rule.
2. A public neutral proper sampler also solves the middle regime by
   validation, even if it never recovers the hidden comparator.
3. Point-mass clean learnability supplies local legal concepts but does not
   force their off-point behavior to be balanced under the original marginal.
4. A false witness must hide both clean shadows and neutral samplers while
   preserving every-marginal clean weak proper learning. Existing code,
   parity, one-way-handle, and residual-block templates fail one of these
   requirements.

### Depth 5 Directions

1. Prove or refute a same-$P$ shadow-cover extraction lemma: from the source
   learner and samples from $P$, can one generate a $P$-polynomial list
   intersecting the weak shadow of every $c\in\mathcal C_s$? The failed
   point-mass route suggests the exact missing hypothesis is a global
   balance/envelope condition on local handles.
2. Try a hard-to-sample proper class rather than an ordinary code family:
   clean labels should reveal a valid deterministic proper representation,
   while agnostic labels should make finding any valid neutral representation
   as hard as finding the hidden witness. The construction must still provide
   clean weak proper learning under marginals concentrated on arbitrary
   coordinates.
3. Formalize the black-box component lower bound as an oracle theorem. Let
   clean components have source kernels that stay inside the component, make
   off-promise transcripts return adversarial proper concepts, and show that
   validation plus self-labeled clean calls cannot reach a hidden component
   shadow or neutralizer without an explicit component sampler.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 5 Branch A: Local Handles Do Not Globalize

### Branch Goal

I tried to close the fork from Depth 4. The positive route would show that
the every-marginal clean weak proper source forces either:

1. a public same-$P$ weak shadow list, meaning a polynomial candidate
   generator whose output intersects the weak neighborhood of every
   $c\in\mathcal C_s$ under $P$; or
2. a public neutral sampler over deterministic proper hypotheses, meaning a
   polynomial sampler whose validated draws are not noticeably
   anti-correlated with any middle-noise regression.

The negative route would build a class that hides both objects while still
being clean weak properly learnable under every marginal. I did not resolve
the edge. The main new conclusion is more diagnostic: the every-marginal
quantifier really does force many local proper completions, but those local
completions need not have any controlled behavior under the original marginal
$P$. Thus the hoped-for positive dichotomy fails at exactly the globalization
step.

### Quantitative Fork

Keep the $\{\pm1\}$ notation. For a fixed marginal $P$ and size $s$, let
$$
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P .
$$
The target asks for a proper $h$ with
$$
\langle r,h\rangle_P\ge M(r)-1+2\alpha .
$$

Choose $\alpha$ below the usual low-noise scale, for example smaller than a
constant times both the source advantage and the inverse source transcript
bound. If $M(r)>1-3\alpha$, then
$\operatorname{OPT}_{\mathcal C}(\mathcal D)<3\alpha/2$, and the same-marginal
low-noise coupling from the earlier branches can be tuned to expose a clean
shadow of a near-optimal comparator. The unresolved regime is therefore
$$
M(r)\le 1-3\alpha,
$$
where it is enough to find a deterministic proper $h$ with correlation at
least about $-\alpha$. A sampler $Q$ over deterministic concepts with
$$
\langle r,\mathbf E_{h\sim Q}h\rangle_P\ge -\alpha/3
$$
would solve this regime: draw polynomially many $h\sim Q$, validate, and keep
the best. This is weaker than recovering the near-optimal concept and is
exactly why ordinary noisy-code hardness keeps leaking neutral outputs.

### What Every-Marginal Clean Learning Does Force

The source has real bite on tiny marginals. For a point mass $\delta_x$, if
some target concept takes value $b$ at $x$, then running the source on repeated
examples $(x,b)$ must output a proper concept $h_{x,b}$ with $h_{x,b}(x)=b$.
For a uniform distribution on an odd finite set
$T=\{x_1,\ldots,x_k\}$, as long as the source advantage is positive, the
discrete error grid forces the output to agree with the clean target on a
strict majority of $T$ once $k$ is fixed and the marginal-specific polynomial
for that finite marginal is allowed. Thus the source supplies local proper
completions for every realizable finite trace.

This is the strongest positive pressure I found from the every-marginal
quantifier. Unfortunately it does not give a neutral sampler under $P$.
A handle produced from $\delta_x$ or from a small finite support can be
arbitrarily hostile away from that support. Validation can reject hostile
handles, but validation cannot prove that among polynomially many such local
handles there is one with global correlation $\ge -\alpha$ against the
current regression. The source guarantee for the tiny marginal never mentions
the off-support behavior that dominates the original $P$-inner product.

The same obstruction appears for finite traces. Take a large fresh sample
$S=(X_1,\ldots,X_N)$ from $P$ with $N$ big enough for uniform convergence over
$\mathcal C_s$. If we knew the clean trace
$(c^\star(X_1),\ldots,c^\star(X_N))$ of a near-optimal comparator, a clean
source run on the empirical marginal over $S$, followed by validation under
$P$, could expose a useful shadow. But producing such candidates efficiently
requires finding one of the useful trace labelings. Enumerating all trace
labelings costs $2^N$, and $N$ must be polynomial in the inverse weak gap if
the resulting empirical shadow is to certify a $P$-shadow. This recovers the
sample-complexity theorem by unbounded ERM, but it does not give a
polynomial-time atlas update.

Using a tiny trace $|S|=O(\log s)$ keeps enumeration polynomial, but then the
source output is only certified on the tiny empirical marginal. It can again
be adversarial off $S$. So the positive route needs an additional global
envelope statement: local clean completions must be balanced, stable, or
otherwise representative under $P$. I do not see such an envelope following
from the source definition.

### What A False Witness Must Now Do

A false witness has to be stronger than recovery hardness. Suppose the hard
regressions are noisy versions of hidden concepts,
$$
r_y=(1-2\eta)c_y .
$$
For a nondecoding proper hypothesis $h$ to fail the weak agnostic target, it
must satisfy
$$
(1-2\eta)\langle c_y,h\rangle_P
<
(1-2\eta)-1+2\alpha,
$$
or equivalently
$$
\langle c_y,h\rangle_P
<
\frac{-2\eta+2\alpha}{1-2\eta}.
$$
In the actual middle regime $\eta>\alpha$, this is a negative-correlation
requirement. A neutral wrong hypothesis with
$\langle c_y,h\rangle_P\approx0$ is already legal. Therefore LPN, noisy
parity, nearest-codeword, and one-way recovery assumptions are not enough
unless they are upgraded to no-neutral-sampler hardness: every polynomial-time
method that finds even a mildly non-anti-correlated deterministic proper
hypothesis must decode the hidden witness.

Pure geometry is still not enough. If many public concepts are efficiently
sampleable and roughly orthogonal to each hidden $c_y$, then random draws plus
validation give the neutral sampler. If instead all nondecoding concepts are
inverse-polynomially anti-correlated with every hidden target under one fixed
marginal, the weighted Gram/Plotkin obstruction prevents an exponentially
large hard family. Thus the only plausible false witness is computational:
neutral concepts may exist, but every efficient way of finding one is as hard
as finding the hidden clean shadow.

That computational witness must also survive every-marginal clean learning.
The point-mass and finite-support observations above imply that the class
must provide efficient proper completions for arbitrary clean local traces.
Those completions must not form a public neutral sampler under the hard
marginal $P$, and they must not give a polynomial public weak cover of all
hidden concepts. Existing handle constructions fail because the completions
are too useful under agnostic validation. Existing code constructions fail
because random valid concepts are neutral. A hard-to-sample proper class is
the right shape, but I do not yet have a standard cryptographic or
complexity-theoretic assumption that gives clean trace completion while
blocking all neutral deterministic samplers.

### Failed Positive Dichotomy

The most tempting theorem statement was:

For every fixed $P,s$, efficient every-marginal clean weak proper learning
implies either a $P$-polynomial public weak shadow cover or a $P$-polynomial
neutral proper sampler.

The finite-trace analysis shows why this is not currently provable from the
atlas source alone. The source gives an efficient map from clean labeled
traces to proper hypotheses. It does not give an efficient map from unlabeled
$P$-samples, or from agnostic labels, to the clean trace of a near-optimal
comparator. Nor does it constrain the outputs on small-support clean traces
away from those supports. A source learner may be component-preserving on
clean transcripts, with each component reachable only from its own clean
labels; a promise-respecting wrapper initialized from public traces then
never reaches the hidden component. This remains only a black-box barrier,
because a non-black-box algorithm might exploit representation structure, but
it blocks the abstract dichotomy.

### Current Obstacles

1. Local proper handles forced by point and finite-support marginals can be
   globally anti-correlated under the original marginal $P$.
2. A polynomial public trace enumeration is too small to certify a global
   $P$-shadow; a certifying trace has polynomial size and therefore
   exponentially many clean labelings.
3. A false witness must prove no-neutral-sampler hardness, not merely noisy
   recovery hardness.
4. Hard-to-sample proper classes look necessary for a false witness, but the
   every-marginal source simultaneously requires efficient clean proper
   completion for all local traces.

### Depth 6 Directions

1. Finite-trace hardness target. Build a finite-domain representation class
   with efficient clean weak proper learning under every distribution on the
   domain, but for one explicit marginal $P$ make additive-$1/2$ weak
   agnostic proper selection hard and prove that every acceptable output
   either decodes the hidden witness or comes from a forbidden neutral
   sampler.
2. No-neutral-sampler assumption. Formulate a cryptographic primitive
   tailored to this edge: given noisy examples from a hidden valid concept,
   it is hard to output any valid deterministic concept with correlation
   $\ge -1/\operatorname{poly}(s)$, even though exact clean examples allow
   efficient weak proper completion under every marginal.
3. Global-envelope positive lemma. Identify a natural representation
   condition under which the point-mass and finite-support completions have
   controlled off-support behavior under $P$. Such an envelope would convert
   the local handles into a neutral sampler and would settle the edge for a
   broad, non-black-box subclass.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 6 Branch A: No-Neutral Sampler Barrier

### Branch Question

I pushed on the specific no-neutral-sampler fork. The question was whether
the every-marginal clean weak proper source secretly forces one of the two
objects that would settle the edge positively:

1. a same-$P$ public shadow generator whose polynomial list intersects the
   weak $P$-neighborhood of every $c\in\mathcal C_s$; or
2. a same-$P$ public sampler over deterministic binary proper hypotheses
   whose validated draws are never noticeably anti-correlated with the
   current middle-noise regression.

I still do not see such a forcing argument. The clean source forces local
proper extendability, but the off-support behavior of those extensions can be
arbitrary under the hard marginal $P$. Conversely, I also do not yet have a
standard-assumption class proving the implication false. The new conclusion
is that a false witness needs a hard valid-code style primitive, not just
LPN-style noisy recovery hardness.

Throughout this branch, a "sampler" is only a way to generate deterministic
proper candidates. The learner must finally output a single binary concept
$h\in\mathcal C_s$. A randomized barycenter helps only because polynomially
many sampled deterministic hypotheses can be validated and the best one
returned.

### Why Local Clean Handles Still Do Not Force A Neutral Sampler

The every-marginal source gives a useful local test. Fix a point $x$ and a
bit $b$. If some concept in $\mathcal C_s$ takes value $b$ at $x$, then
feeding the source learner repeated examples $(x,b)$ is a realizable run for
the point-mass marginal $\delta_x$, and with enough repetitions it must
output a proper deterministic $h$ with $h(x)=b$. The same holds for any fixed
finite support $T$ and any realizable labeling on $T$: under the empirical
marginal on $T$, positive weak advantage on the discrete error grid forces
strictly better-than-half agreement on the trace once the trace size is fixed
and the marginal-specific runtime is allowed.

This is real structure, but it is not a same-$P$ sampler. A concept produced
to satisfy a one-point or small-trace constraint can be adversarial on the
rest of the space, where essentially all of the $P$-mass may lie. If we draw
$x\sim P$, choose a helpful bit, and call the clean learner for $\delta_x$,
the resulting hypothesis has one controlled value and an uncontrolled
$P$-inner product. Averaging such hypotheses does not give a balanced
barycenter unless one proves an additional envelope condition on their
off-support behavior.

There is also a rate issue. Calls made on empirical trace marginals $Q_T$ use
the source guarantee for $Q_T$, not for the original hard marginal $P$. Since
the model is marginal-nonuniform, the polynomial for $Q_T$ need not be
bounded by the polynomial for $P$ uniformly over traces whose support changes
with $s$. Thus even a trace-enumeration strategy has two gaps: tiny traces do
not certify $P$-correlation, while certifying traces have polynomial size and
exponentially many labelings, with no same-$P$ runtime control for all the
auxiliary marginals.

So I cannot derive a deterministic neutral sampler from local handles alone.
The clean source can be component-preserving: clean labels from a hidden
component produce a shadow in that component, while synthetic local calls and
self-labeled calls remain in public components whose global $P$-correlation
can be negative for the current regression.

### A Concrete False Template And Where It Breaks

The most concrete negative template I can articulate is a finite-domain hard
valid-code class.

For each size $s$, let $P_s$ be a hard marginal on a finite domain
$X_s$. There is a hidden family of deterministic binary concepts
$\{c_y:y\in S_s\}$ and a collection of local completion concepts. A proper
representation must be a valid hidden codeword or a valid local completion.
The desired properties are:

1. **Clean completion.** For every marginal $Q$ and every clean target in
   the class, there is a uniform polynomial-time proper learner with
   $Q$-dependent weak advantage. On $P_s$, exact clean examples reveal enough
   information to decode a hidden $c_y$. On small or singular marginals,
   local completions give the needed weak proper handle.
2. **No public same-$P$ shadow.** Any $P_s$-polynomial candidate generator
   independent of the clean labels misses the weak neighborhoods of most
   hidden $c_y$. Producing a same-$P$ shadow should decode the hidden witness
   $y$.
3. **No neutral deterministic sampler.** For the hard middle-noise regression
   $r_y$, every efficiently generated proper deterministic hypothesis with
   $\langle r_y,h\rangle_{P_s}\ge -1/\operatorname{poly}(s)$ should also
   decode $y$. Local completions that do not decode $y$ must validate as
   noticeably anti-correlated under $P_s$.

This template would separate the nodes: the realizable source uses exact
clean consistency to decode or locally complete, while an agnostic learner on
noisy labels cannot output either a shadow or a neutral deterministic proper
hypothesis.

The breaks are exactly the old leaks, now in a sharper form. If the hidden
valid codewords are easy to sample, as with parities or ordinary linear
codes, a random wrong hidden codeword is nearly neutral under $P_s$ and
validation accepts it in the middle-noise regime. If local completions are
public and close enough to prove the clean source under $P_s$, then the
triangle inequality makes them agnostic shadows of the near-optimal hidden
concept. If local completions are only certified on tiny supports, they can
be globally anti-correlated, but then the clean learner on $P_s$ must really
decode $y$ from exact labels.

Thus the missing ingredient is not ordinary noisy recovery hardness. It is a
hard-to-sample valid-code primitive with exact-clean decoding and noisy
no-neutral hardness: noisy examples should make it hard to find even a valid
deterministic concept of correlation $\ge -1/\operatorname{poly}(s)$, while
clean examples and arbitrary marginal restrictions still allow weak proper
completion. I do not know a standard LPN, one-way-function, lattice, or PCP
assumption that gives this package without reintroducing a neutral sampler or
breaking the every-marginal clean source.

### Why This Is Not Yet A Conditional Atlas Solution

One could state a conditional separation by assuming precisely the
hard-valid-code primitive above. But that assumption is almost the target
hardness restated in representation-language form. It would not be a useful
atlas update unless instantiated from a recognized primitive or reduced to a
cleaner search problem.

Likewise, the positive direction is still missing a theorem. A minimax-style
neutrality statement would need to show that the convex hull of efficiently
reachable deterministic proper hypotheses contains an approximately
$P$-balanced point, or that a polynomial reachable list shadows every hidden
concept under $P$. The source guarantee only constrains output distributions
conditioned on clean labels from each target. It does not constrain the
reachable convex hull from public seeds, agnostic labels, or local synthetic
traces.

This leaves the edge unresolved. The no-neutral-sampler barrier appears
genuine for black-box uses of the source learner, but I cannot yet turn it
into a non-black-box class separation.

### Depth 7 Directions

1. **Hard valid-code instantiation.** Search for a finite-domain family
   $S_s\subseteq\{\pm1\}^{X_s}$ that is hard to sample from, exactly-clean
   decodable from $P_s$-examples, and noisy no-neutral hard. Candidate
   starting points are planted constraint systems with exact-clean hints,
   syndrome/codeword hybrids, or signature-like validity predicates; the key
   test is whether random valid concepts are unavailable and local
   completions validate as anti-correlated under $P_s$.
2. **Reachable-hull theorem or counterexample.** For a fixed source learner
   and hard marginal $P$, define the convex hull of deterministic proper
   outputs reachable by public seeds, self-labeled clean calls, and bounded
   finite-trace calls. Prove either that this hull must contain an
   approximately $P$-neutral point, or build an oracle/component example
   where it stays separated from every hidden component shadow.
3. **Trace-rate obstruction.** Formalize whether using the source on random
   empirical marginals $Q_T$ can be charged to the original $P$-nonuniform
   polynomial. If not, this gives a precise reason that finite-trace local
   handles cannot be globalized inside the atlas definition; if yes, it may
   reopen a positive shadow-cover extraction proof.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md

## Depth 7 Branch A: Final Consolidation

### Final Resolution Attempt

I made one last pass over both directions. I still cannot turn the edge into
an atlas-ready theorem or an atlas-ready separation.

The cleanest normalization remains the deterministic binary proper one. Fix
the marginal $P$ and size $s$, write hypotheses as $\{\pm1\}$-valued
concepts, and let
$$
r(x)=\mathbf E[Y\mid X=x],
\qquad
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P .
$$
The target asks the learner to output one deterministic proper
$h\in\mathcal C_s$ such that
$$
\langle r,h\rangle_P\ge M(r)-1+2\alpha_P(s)
$$
for some inverse-polynomial, marginal-dependent $\alpha_P(s)>0$. Any sampler
mentioned below is only a way to generate deterministic proper candidates;
the final output is still a single binary concept from $\mathcal C_s$.

The positive proof still closes only in two situations. First, the
same-marginal low-noise branch is valid. If $c^\star$ is near-optimal and
$$
\eta=\Pr[Y\ne c^\star(X)]
$$
is below the inverse transcript scale of the source learner, then running the
source learner on the agnostic labels can be coupled to a clean run on
$(X,c^\star(X))$ with inverse-polynomial probability of seeing no corrupted
labels. Crucially, this coupling keeps the original marginal $P$; it does not
condition on an event and therefore does not switch to a different marginal.
Repetition plus validation yields a proper shadow $h$ with
$$
\operatorname{err}_P(h,c^\star)\le \frac12-\gamma_P(s),
$$
and then
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+\operatorname{err}_P(h,c^\star)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\Omega(\gamma_P(s)).
$$
Taking $\alpha_P(s)$ below both the source advantage and the inverse source
transcript bound proves the low-noise part.

Second, the middle-noise branch is also positive if one has a public
same-$P$ shadow cover or a public same-$P$ neutral proper sampler. A shadow
cover means a $P$-polynomial generator whose candidate list intersects the
weak $P$-neighborhood of every $c\in\mathcal C_s$. If the list contains
$h$ with
$$
\Pr_P[h(X)\ne c^\star(X)]\le \frac12-\rho_P(s),
$$
then the same triangle inequality proves the agnostic guarantee for arbitrary
labels. A neutral sampler means a $P$-polynomial sampler over deterministic
proper concepts whose barycenter is not substantially anti-correlated with
the current middle-noise regression. If $M(r)\le 1-3\alpha$ and the sampler
has
$$
\left\langle r,\mathbf E_{h\sim Q}h\right\rangle_P\ge -\alpha/3,
$$
then polynomially many deterministic draws and validation produce a proper
$h$ with correlation at least about $-\alpha$, enough for the target. Legal
constants, legal complement pairs, balanced proper ensembles, and known
proper weak covers all fall into this positive pattern.

The final true-proof attempt was to derive one of these objects from the
every-marginal clean source alone. The source does force local proper
completions. On point masses and fixed finite supports, clean weak advantage
on the discrete error grid implies that realizable traces can be completed by
proper hypotheses agreeing on more than half the local mass. But these local
handles still do not globalize. Their behavior away from the tiny support can
be adversarial under the original marginal $P$, and calls to the source on
auxiliary empirical marginals use those auxiliary marginals' nonuniform
runtime bounds, not the original $P$-polynomial bound. Tiny traces can be
enumerated but do not certify $P$-correlation; polynomial-size traces certify
$P$-correlation but have exponentially many labelings. I do not see a
minimax, reachable-hull, or trace-enumeration argument that converts the
local handles into a same-$P$ neutral sampler without adding a new envelope or
representation condition.

The final false-proof attempt also remains incomplete. Ordinary recovery
hardness is not enough. For noisy hidden concepts
$r_y=(1-2\eta)c_y$, a nondecoding hypothesis $h$ fails only if
$$
\langle c_y,h\rangle_P
<
\frac{-2\eta+2\alpha}{1-2\eta}.
$$
In the middle-noise regime $\eta>\alpha$, this requires noticeable negative
correlation. Neutral wrong hypotheses already pass. Thus LPN, noisy parity,
nearest-codeword, and standard code-recovery templates do not separate this
edge: random wrong parities or random valid codewords are usually neutral
deterministic proper outputs. Pure anti-code geometry is also insufficient,
because inverse-polynomial pairwise anti-correlation under one fixed marginal
runs into the weighted Gram/Plotkin obstruction and cannot support a large
hard family by itself.

A real false witness would need no-neutral-sampler hardness. For one hard
marginal $P_s$ and hard regressions $r_y$, every polynomial-time method that
outputs a deterministic proper $h$ with
$$
\langle r_y,h\rangle_{P_s}\ge -1/\operatorname{poly}(s)
$$
would have to decode the hidden witness $y$. At the same time, exact clean
labels must allow efficient weak proper learning under every marginal, and
finite-support local completions must not become public neutral samplers or
public shadows under $P_s$. This is stronger and more tailored than standard
LPN, one-way-function, lattice, PCP, or nearest-codeword assumptions as used
in the earlier branches. Stating it as an assumption would be nearly a
restatement of the desired separation, so it is not an atlas-ready
conditional result.

### Consolidated State Of Knowledge

The robust positive branch is:

1. If $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the inverse
   transcript scale of the same-$P$ source learner, the edge is true by the
   low-noise coupling and validation.
2. If the class has legal constants, a legal complement pair, a balanced
   proper sampler, or any $P$-polynomial public shadow cover, the middle-noise
   regime is also true.
3. These arguments preserve properness because every candidate is a
   deterministic member of $\mathcal C_s$.

The unresolved obstruction is:

1. The source learner supplies clean-label shadows only when it is fed labels
   from the relevant comparator.
2. Off-promise calls on agnostic, random, flipped, or constant labels have no
   guaranteed behavior.
3. Point-mass and finite-support marginals force local completions, but their
   uncontrolled off-support behavior prevents a same-$P$ neutral sampler.
4. Validation selects among candidates; it does not create a missing shadow
   or neutral deterministic proper hypothesis.

The failed false routes are:

1. Public handles and public weak covers make the edge true by the shadow
   inequality, so they cannot witness falsehood.
2. LPN, noisy parity, and ordinary code-recovery hardness leave neutral wrong
   proper hypotheses that satisfy the weak agnostic inequality.
3. Residual-block and one-way-handle constructions either keep legal handles,
   which validation can use, or remove them and break the every-marginal clean
   source.
4. Pure negative-correlation code geometry cannot provide a large hard family
   under one fixed marginal; any separation must be computational
   no-neutral-sampler hardness, not just pairwise distance.

### Proposed Atlas Summary

Open. The implication is true in the low-noise same-marginal regime and true
for classes with a validation-searchable proper shadow cover or proper
neutralizer, but the source node alone does not appear to provide such an
object. The unresolved middle-noise case is a proper selector problem: from
agnostic samples and a clean weak realizable proper learner, find either a
deterministic proper shadow of a near-optimal comparator or a deterministic
proper hypothesis that is not substantially anti-correlated with the current
regression. Existing parity/code/LPN-style hardness does not refute the edge
because neutral wrong hypotheses already meet the weak additive target.

### Proposed Atlas Proof-Status Body

Use $\{\pm1\}$ labels and fix the marginal $P$. Let
$M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P$. The target is equivalent
to finding $h\in\mathcal C_s$ with
$\langle r,h\rangle_P\ge M(r)-1+2\alpha_P(s)$.

The known positive part is same-marginal low-noise robustification. If a
near-optimal proper comparator $c^\star$ has agnostic error below the inverse
sample scale of the source learner, then an invocation of the realizable
learner on the noisy sample agrees with a clean realizable invocation with
inverse-polynomial probability. Since this coupling uses the same
$P$-distributed instances, the source guarantee applies directly. Repetition
and holdout validation give a deterministic proper $h$ satisfying the weak
agnostic bound.

For larger noise, the standard improper fallback would use constants, but
constants need not be legal proper hypotheses. The same regime is solved
under any additional legal proper neutralizer or shadow-cover hypothesis:
legal constants, complement-pair anchors, balanced samplers over deterministic
proper hypotheses, or a $P$-polynomial list intersecting the weak
$P$-shadow of every concept. The atlas source definition does not include any
of these structures.

The main obstruction is that every-marginal clean weak proper learning gives
only local proper completions on point masses and finite supports. Those
completions may behave adversarially off support under the original marginal
$P$, and marginal-nonuniform runtimes for auxiliary trace marginals do not
automatically give a $P$-polynomial global candidate generator. Conversely,
no atlas-ready false witness is known. A separation would need a hard class
where exact clean labels enable weak proper learning under every marginal,
but noisy labels make it hard to output even a neutral deterministic proper
hypothesis. Standard LPN, noisy parity, nearest-codeword, one-way-handle, and
pure code-distance constructions fail because they leak either clean shadows,
legal handles, or neutral wrong hypotheses.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md
