# Edge: efficient-weak-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- source: `efficient-weak-realizable-proper-pac`
- target: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- family: `marginal-agnostic-hardness-open`

## Bottom Line

I do not have an atlas-ready proof or separation. The edge should remain
`open`.

The distribution-free weak realizable proper source is enough to prove the
low-noise part of the desired agnostic guarantee with proper outputs. Let the
source weak learner have sample bound $m(s)$ and clean advantage $\gamma(s)$.
If the agnostic optimum is below about
$\min\{\gamma(s),1/m(s)\}$, repeated noisy runs contain clean transcripts with
inverse-polynomial probability, and each successful transcript returns a legal
proper hypothesis.

The proof still stops in the middle/high-noise regime. The improper sibling
edge uses the better constant classifier once OPT is above the chosen weak gap.
Here constants, complements, or any other balanced fallback need not be legal
proper hypotheses. I found no theorem deriving a proper neutralizer, balanced
sampler, weak selector, or fixed-marginal proper ERM routine from weak
realizable proper learning alone.

Known false-witness routes remain near misses. Halfspace/Tiegel and
FGRW/monomial hardness are distribution-free or strong-accuracy obstructions,
not fixed-marginal low-OPT weak no-advantage obstructions. Bounded-handle
examples show how weak proper learning can be made easy while strong proper
recovery remains hard; they are positive handles, not this separation.

## Sources Checked

Local atlas and sibling scratchpads:

- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- sibling scratchpads for the nearby marginal-realizable/proper, weak-realizable/proper, and realizable/proper to weak-agnostic/proper edges

Primary or near-primary source pages checked:

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability",
  OpenReview: https://openreview.net/forum?id=aoVCFtox89. Used for the
  quantifier pattern: rates may depend on the marginal, but the learner and
  concept-side guarantee remain uniform for that marginal.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case
  Lattice Problems", PMLR/COLT 2023:
  https://proceedings.mlr.press/v195/tiegel23a.html. Used for the split
  between distribution-independent weak hardness and fixed-Gaussian strong
  $\operatorname{OPT}+\varepsilon$ hardness.
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by
  Halfspaces Is Hard", SIAM Journal on Computing 2012:
  https://doi.org/10.1137/120865094. Used for the FGRW weak agnostic hardness
  near miss.
- Hopkins, Kane, Lovett, and Mahajan, "Realizable Learning Is All You Need",
  TheoretiCS 2024: https://theoretics.episciences.org/13009. Useful as a
  sanity check that realizable-to-agnostic equivalences do not by themselves
  supply efficient proper search for this computational edge.

## Quantifier Setup

The source gives one distribution-free weak realizable proper learner $A$.
For every marginal $P$, every target $c\in\mathcal C_s$, and realizable labels
$Y=c(X)$, it outputs $h\in\mathcal C$ with

$$
\Pr_P[h(X)\ne c(X)]\le \frac12-\gamma(s)
$$

using at most $m(s,\log(1/\delta))$ samples and polynomial time. Here
$\gamma(s)$ is inverse-polynomial.

The target asks for one uniform agnostic learner. For every fixed marginal $P$
there may be a $P$-dependent polynomial and a $P$-dependent inverse-polynomial
gap $\alpha_P(s)$ such that, for every joint distribution $\mathcal D$ with
marginal $P$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\alpha_P(s),
$$

with $h\in\mathcal C$.

For the partial positive result below, the distribution-free source even lets
one choose a $P$-independent gap

$$
\alpha(s)\le \min\{\gamma(s)/4,1/(100m(s))\}.
$$

The unresolved issue is not the marginal dependence of the low-noise analysis;
it is finding a legal proper fallback when OPT is not tiny.

## Partial Positive: Proper Low-Noise Robustification

Fix a marginal $P$ and an agnostic distribution $\mathcal D$ with that
marginal. Let

$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

Assume first that $\eta<2\alpha(s)$. Choose
$c^\star\in\mathcal C_s$ with error $\eta$ up to negligible slack. Run the
source learner $A$ on fresh batches of noisy examples, pretending the labels
are realizable, and collect its proper outputs. Validate all collected
candidates on an independent holdout sample.

Couple one noisy run on $(X,Y)\sim\mathcal D$ with a clean realizable run on
$(X,c^\star(X))$, using the same $P$-distributed instance sequence and the
same internal randomness. A run inspecting at most $m(s)$ labels has a
corruption in its transcript with probability at most

$$
m(s)\eta < 2m(s)\alpha(s)\le 1/50.
$$

On the no-corruption event, the noisy transcript is identical to a successful
clean realizable transcript under the original marginal $P$. Because the
source learner is proper, it returns $h\in\mathcal C$ satisfying

$$
\Pr_P[h(X)\ne c^\star(X)]\le \frac12-\gamma(s).
$$

Therefore

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\Pr_P[h(X)\ne c^\star(X)]
\le
\eta+\frac12-\gamma(s)
\le
\eta+\frac12-\alpha(s).
$$

Polynomially many repetitions and validation find such a candidate with high
probability. This is the same low-noise robustification as in the improper
edge, except that the successful candidate is already proper.

## Where The Proof Stops

The complementary regime is $\eta\ge 2\alpha(s)$. For the improper target, the
two constant classifiers solve this case: one has error at most $1/2$, so

$$
\frac12 \le \eta+\frac12-\alpha(s).
$$

For the proper target, constants may not belong to $\mathcal C$. More
generally, weak realizable proper learning does not imply any of the following:

- a legal concept with error at most $1/2$ under every conditional label rule;
- complement closure or an efficiently available anchor/complement pair;
- a validation-searchable balanced proper sampler;
- fixed-marginal weak ERM or approximate proper ERM;
- a polynomial-size proper cover at radius below $1/2$;
- useful behavior of the source learner on inconsistent samples.

Running the source learner on noisy samples is only justified by the clean
transcript event. When $\eta$ is moderate, for example $\eta=0.1$, that event
can be exponentially unlikely for a polynomial-size transcript. The weak
target may still ask for a legal concept of error roughly $0.6$, but the source
only says how to find legal concepts from clean labels.

In $\{\pm1\}$ notation, with
$r(x)=\mathbf E[Y\mid X=x]$ and
$M=\max_{c\in\mathcal C}\langle r,c\rangle_P$, the target asks for

$$
\langle r,h\rangle_P\ge M-1+2\alpha(s).
$$

If OPT is not tiny, this threshold can be zero or even slightly negative. Thus
a counterexample cannot merely make recovery of $c^\star$ hard; it must make
even a weakly acceptable proper handle or neutral output hard to find.

## Conditional Positive Lemmas

The edge would be true under several extra proper-output assumptions.

1. If both constants are legal concepts, the low-noise branch plus the
   constant fallback gives the target.

2. More generally, if each fixed marginal $P$ admits a $P$-polynomial
   validation-searchable proper neutralizer list containing some
   $b\in\mathcal C$ with
   $\operatorname{err}_{\mathcal D}(b)\le 1/2+o(\alpha_P(s))$ for every label
   conditional, then the same proof works.

3. A randomized or barycentric neutralizer also suffices. If a $P$-polynomial
   sampler over proper concepts has average prediction $\bar h$ satisfying
   $\|\bar h\|_{L_1(P)}\le o(\alpha_P(s))$, then sampling and validation find a
   legal high-OPT candidate.

4. A fixed-$P$ weak selector would also suffice: given noisy samples, it only
   needs to find some $h\in\mathcal C$ whose correlation is at least
   $M-1+2\alpha_P(s)$, not necessarily recover the optimum concept.

These are genuine extra assumptions. Sibling scratchpads note an
anti-neutralizer sanity check: homogeneous parities are efficiently
distribution-free realizably properly learnable, but every concept has value
$+1$ at $0^n$, so under $P=\delta_{0^n}$ there is no barycentric proper
neutralizer with small bias. That does not refute this edge, because under
that marginal all legal concepts have the same loss and OPT-relative learning
is trivial. It only shows that the positive theorem cannot derive a literal
proper neutralizer from the source alone.

## Hardness Route Audit

### Halfspaces And Tiegel

Halfspaces satisfy the source: linear feasibility and VC generalization give
efficient realizable proper learning, hence weak realizable proper learning.

Tiegel's distribution-independent theorem has the right "no advantage over
$1/2$" flavor and even rules out improper outputs, but the hard marginal varies
with the reduction. A marginal-nonuniform learner may attach a different
polynomial and weak gap to each such marginal. The theorem therefore refutes
the distribution-free weak agnostic nodes, but it does not automatically refute
this fixed-marginal relaxation.

The fixed-marginal part of Tiegel's result uses the standard Gaussian marginal,
but it is a strong $\operatorname{OPT}+\varepsilon$ lower bound. The weak
target here permits additive error close to $1/2$ when OPT is not below the
hidden inverse-polynomial gap. I did not find a fixed-Gaussian, low-OPT,
no-weak-advantage theorem strong enough to force failure of the marginal
weak node.

There is also a positive warning: usual halfspace classes contain legal
constant halfspaces. The conditional neutralizer lemma above then makes
halfspaces a poor candidate for this specific weak marginal target, even
though they are the right witness for stronger agnostic targets.

### FGRW, Monomials, And PCP/Label-Cover Routes

Feldman--Guruswami--Raghavendra--Wu prove that weak agnostic learning of
monomials is hard even when the learner may output halfspaces. This is very
close in spirit, but it remains a distribution-free Label-Cover/dictatorship
test hardness theorem. The hard example distribution changes with the reduced
instance.

To use this against the marginal-nonuniform target, one would need one fixed
marginal, or one dimension-indexed marginal family whose polynomial cannot
hide the hard instance. Packing all Label-Cover or PCP active slices into one
fixed marginal dilutes each slice. Once the active slice has small global
mass, an OPT-relative weak target can ignore it unless the construction also
forces every weakly acceptable proper output to reveal the hard witness.

Existing PCP active-slice lookup classes also miss the source: they are useful
for improper-source properization hardness, but clean weak proper learning on
the active slice would itself decide the hard instance.

### Bounded-Handle Examples

The one-way image-coordinate weak-handle class is a useful boundary example
but not a counterexample here. Adding constants and bounded positive-atom
handles makes weak proper learning easy. Strong proper recovery under a fixed
coordinate marginal can still invert the one-way function, because high
accuracy excludes the handles.

For this assigned edge, those handles point in the positive direction. They
are exactly the kind of proper high-OPT fallback the generic proof is missing.
If handles are removed, the strong proper hardness can return, but then the
source weak realizable proper property may fail or the class may no longer have
an efficiently findable legal weak output under arbitrary marginals.

The lesson is that weak proper agnostic learning can be much easier than
strong proper recovery. A successful false witness must prevent not only
proper recovery of the planted concept, but also all cheap bounded handles and
neutral proper outputs.

### Codes, Parities, And LPN-Like Ideas

Parities under the uniform marginal are cleanly properly learnable by Gaussian
elimination, and noisy parity suggests hardness. But the atlas weak additive
target does not require recovery at noticeable noise. If the best parity has
noise rate $\eta$ and a wrong parity has error $1/2$, then the wrong parity is
legal whenever $\eta\ge\alpha_P(s)$. If $\eta<\alpha_P(s)$, the low-noise
clean-transcript branch applies.

Code-based attempts face the same issue. To force recovery from a weak proper
output at moderate OPT, wrong codewords would need to be noticeably worse than
random guessing, or every weakly legal wrong codeword would need to decode the
hard witness. Pure pairwise-distance geometry is blocked by Plotkin/Gram
matrix phenomena for exponentially many binary concepts under one fixed
marginal. Computational wrong-output-usefulness remains possible, but I did
not find such a construction in the checked notes.

## Finite-Trace And Exhaustive-Relabeling Near Miss

The sample-only analogue is easy because unbounded proper ERM can search
$\mathcal C$. A tempting computational proof is to draw an unlabeled sample
from a fixed marginal, enumerate all labelings, run the realizable weak learner
on each synthetic realizable labeling, and validate the resulting proper
candidates.

This is not polynomial in general. The source learner's sample size is
polynomial in $s$, so enumerating all labelings is typically
$2^{\operatorname{poly}(s)}$. Marginal nonuniformity lets the polynomial's
constants and degree depend on $P$; it does not allow exponential time in the
representation size for one fixed $P$.

Finite-support or computable-trace assumptions could make special cases true.
They would be representation-level selector assumptions, not consequences of
the abstract source node.

## Proposed Atlas Update

No atlas edit is justified from this pass. If the edge note is refreshed, I
would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
```

Suggested sharper summary:

```yaml
summary: "Open: distribution-free weak realizable proper learning gives a proper low-noise robustification with an inverse-polynomial gap, but the middle/high-OPT branch still needs a legal proper neutralizer or fixed-marginal weak selector; known halfspace, FGRW/PCP, code, and bounded-handle routes do not settle the full proper target."
```

Suggested body sketch:

```markdown
## Verdict

`open`.

The low-noise part is understood. Let the distribution-free weak realizable
proper learner have clean advantage $\gamma(s)$ and sample bound $m(s)$, and
choose the target weak gap below both $\gamma(s)$ and $1/m(s)$. If
$\operatorname{OPT}_{\mathcal C}$ is below this gap, couple a noisy run to a
clean realizable run for a near-optimal concept using the same original
marginal. With inverse-polynomial probability the transcript is clean, and the
source learner returns a proper weak candidate; validation finds it.

The proof does not handle the remaining OPT regime. The improper sibling edge
uses constant classifiers as neutralizers once OPT is above the weak gap, but
constants need not lie in an arbitrary proper class. A positive theorem would
need legal constants, complement-pair anchors, a validation-searchable proper
neutralizer, balanced sampler, weak cover, or selector; weak realizable proper
learning alone does not provide one.

Known hardness routes remain near misses. Halfspace and FGRW/PCP weak
hardness vary the marginal or put the hard instance in the example
distribution, while fixed-marginal halfspace hardness is a strong
$\operatorname{OPT}+\varepsilon$ theorem. Code and LPN-like routes leave
neutral wrong outputs legal above the weak gap. Bounded-handle examples show
how weak proper handles make the target easy rather than hard.
```

## Obstacles

- The low-noise robustification is proper, but only below the clean-transcript
  scale.
- The improper proof's high-OPT fallback uses constants; arbitrary proper
  classes need not contain constants or complements.
- Weak realizable proper learning gives no guarantee on inconsistent
  transcripts and no generic proper ERM/selector.
- Literal source-only barycentric neutralizers are false in simple anchored
  classes, but lack of such a neutralizer is not enough for a counterexample
  because the target is OPT-relative.
- Halfspace and FGRW hardness results do not pin down one fixed marginal with
  low enough OPT and no weak proper handles.
- Pure code-distance attempts run into neutral wrong codewords or
  Plotkin-style barriers.

## Depth-2 Directions

1. Formalize the restricted positive lemma: source weak realizable proper
   learning plus a validation-searchable proper neutralizer, balanced sampler,
   complement-pair anchor, or fixed-$P$ weak selector implies the target.

2. Search for fixed-marginal weak no-advantage hardness with
   $\operatorname{OPT}$ below the eventual inverse-polynomial gap, not merely
   below a constant or subpolynomial threshold. This is the exact missing form
   in halfspace and monomial routes.

3. Try a wrong-output-usefulness gadget: one fixed marginal, clean weak proper
   learning easy, but every proper hypothesis satisfying
   $\langle r,h\rangle_P\ge M-1+2\alpha_P(s)$ decodes a hard witness.

4. Revisit PCP/FGRW shared-marginal encodings where the hard instance is in
   labels, not in the marginal, while keeping the active mass above the hidden
   weak gap and eliminating cheap proper handles.

5. Clarify the computational model for fixed-marginal finite-trace search. If
   the atlas ever adds effective trace-cover or explicit-marginal selector
   assumptions, several weak marginal-nonuniform proper edges may become true
   for that restricted reason.

verdict: unresolved-open
confidence: medium-high

## Depth 3 Branch: distribution-free source neutralizer

### Question

Can the distribution-free nature of the source do more than the marginal-source
version? In particular, can it force a legal proper neutralizer, balanced
proper sampler, or fixed-marginal proper selector for the middle/high-OPT
branch?

The desired high-OPT object can be phrased in $\{\pm1\}$ notation. For a fixed
marginal $P$, write

$$
r(x)=\mathbf E[Y\mid X=x],
\qquad
M=\max_{c\in\mathcal C}\langle r,c\rangle_P .
$$

The weak agnostic target asks the learner to find $h\in\mathcal C$ with

$$
\langle r,h\rangle_P\ge M-1+2\alpha_P(s).
$$

When $\operatorname{OPT}=(1-M)/2$ is tiny, the clean-transcript argument already
supplies such an $h$ properly. This branch asks whether the stronger
distribution-free source can force an $h$ when $M\le 1-2\alpha_P(s)$, i.e. when
the threshold is at most zero.

### What Distribution-Free Does Give

The distribution-free source is genuinely stronger than a marginal-source
promise. It supplies one clean weak learner, one polynomial resource bound, and
one inverse-polynomial clean advantage that work under every marginal. This
removes several marginal-diagonal escape routes. A counterexample cannot rely
only on saying that each fixed marginal has some tiny private weak gap while no
uniform gap exists; the source already gives a uniform clean gap.

It also gives pointwise and subdistribution tests on clean labels. If
$Q=\delta_x$ and both labels at $x$ are realized by concepts, then running the
source on the realizable point-mass task can return proper concepts realizing
those labels at $x$. More generally, for any subdistribution $Q$ and any
concept $c$, the learner can find some proper $h$ with
$\langle h,c\rangle_Q\ge 2\gamma(s)$.

That is useful structure, but it is structure relative to a clean concept
labeling. The high-OPT branch needs a legal output for an arbitrary conditional
label rule $r$, and $r$ need not be close to any single concept.

### Why It Still Does Not Force A Neutralizer

A literal barycentric neutralizer would say that, for each fixed $P$, there is
a $P$-polynomial searchable list or sampler $B\subseteq\mathcal C$ such that

$$
\max_{b\in B}\langle r,b\rangle_P\ge -o(\alpha_P(s))
\quad
\text{for every } r:\mathcal X\to[-1,1].
$$

Equivalently, the closed convex hull of the accessible proper concepts is
approximately balanced around $0$ in the dual geometry induced by $P$. The
distribution-free weak realizable source does not imply this. Homogeneous
parities are the clean sanity check: they are efficiently distribution-free
properly learnable, but every concept has value $+1$ at $0^n$. Under
$P=\delta_{0^n}$, the proper convex hull is the single point $+1$, so no
literal neutralizer exists.

This is not just an artifact of parities. Any class with a common anchor
coordinate, one-sided range restriction, or non-complement-closed
representation can be distribution-free weakly learnable while failing this
literal convex-balancing property on a marginal concentrated on the anchored
region. Distribution-free clean learnability says the learner can follow a
legal concept under clean labels; it does not say the class contains a legal
opposite, a legal constant, or a legal zero-mean mixture.

The point-mass trick also fails to manufacture missing opposites. If no concept
realizes label $-1$ at an anchored point, then the labeled sample
$(x,-1)$ is outside the source guarantee. Running the learner on such synthetic
labels has no promised behavior. Enumerating all empirical relabelings of a
large unlabeled sample has the same problem plus an exponential search cost.

Boosting the source does not repair this. Standard weak-to-strong boosting can
combine many proper weak hypotheses into an accurate improper vote on clean
realizable labels, but the final vote need not lie in $\mathcal C$. The missing
object here is precisely a proper high-OPT output, not an external majority
predictor.

### Why Anti-Neutralizers Are Still Only Near Misses

Failure of literal neutralization is not a counterexample to the edge. The
target is OPT-relative, and consensus directions cancel out of the comparison.
If all concepts agree on an anchored coordinate, then the contribution of that
coordinate shifts $M$ and every candidate's correlation in the same direction.
Under $P=\delta_{0^n}$ for homogeneous parities, every legal concept has the
same loss for every conditional label rule, so any proper output is optimal.

Thus a false witness needs more than "no balanced proper convex hull." It needs
a fixed marginal $P$ and label rule $r$ such that:

- some proper concept achieves the optimum correlation $M$;
- a weakly acceptable proper concept exists, since the target is existentially
  feasible;
- every polynomial-time learner fails to find any proper $h$ with
  $\langle r,h\rangle_P\ge M-1+2\alpha_P(s)$ for every inverse-polynomial
  candidate gap;
- the same class remains distribution-free weak realizable proper learnable
  under arbitrary clean marginals.

That last bullet is the squeeze. Removing constants, complements, singleton
handles, or bounded handles may make the agnostic high-OPT case hard, but it
also tends to break distribution-free weak realizable proper learning on
marginals concentrated where the hard concepts differ.

### Geometry Of A Selector

For a single fixed fallback $b\in\mathcal C$, the high-OPT requirement is quite
strong. To have

$$
\langle r,b\rangle_P\ge
\max_{c\in\mathcal C}\langle r,c\rangle_P-1+2\alpha
\quad\text{for all }r,
$$

it is enough and essentially necessary that $b$ be a weak $L_1(P)$ center:

$$
\sup_{c\in\mathcal C} 2P[b(X)\ne c(X)]\le 1-2\alpha .
$$

So a known anchor concept would only solve the high-OPT branch if it is within
$1/2-\alpha$ of every concept under $P$. Distribution-free weak learning does
not imply such a center; the source can weakly learn each clean target by
using labels, with the successful output depending on the target.

A list or sampler weakens the center requirement to a convex-hull/selector
condition: for every $r$ in the high-OPT regime, at least one accessible proper
concept must avoid being too anti-correlated with $r$. That is exactly the
neutralizer/selector assumption already isolated in the depth-1 notes, not a
consequence of the source.

### Sharpened Near Misses

Clause-satisfaction fixed-marginal hardness has the right "instance in the
labels, not the marginal" flavor, but it is tuned for strong proper agnostic
learning. For the present weak target, the fair-noise region and the hidden
inverse-polynomial gap leave room for weakly acceptable assignments or cheap
fallbacks. If constants or balanced handles are added to make clean weak
learning easy, they also solve the high-OPT branch. If they are removed, it is
unclear that the assignment class is distribution-free weak realizable proper
learnable under arbitrary clause marginals.

The one-way image-coordinate weak-handle class has the opposite problem. The
proper handles make the source robustly positive, and low-noise
robustification plus constants make the weak agnostic proper target positive.
Deleting the handles restores strong proper hardness, but then a clean
distribution concentrated on the hard coordinate block can require finding the
hidden seed even for weak proper advantage.

PCP/FGRW active-slice constructions still miss for two reasons. If the slice
identity is put into the marginal, marginal-nonuniformity can hide the
polynomial. If all slices are packed into one fixed marginal, the active mass
is diluted unless the construction forces every weakly acceptable proper
output to decode the hard witness. Distribution-free source strength makes
this harder, because every clean active slice must remain weakly learnable by
one uniform proper algorithm.

Code and LPN-like routes also remain near misses. At very low noise, the
clean-transcript branch learns properly. At moderate noise, wrong codewords or
neutral handles tend to be legal weak outputs unless the code geometry makes
every weakly legal output computationally useful. Pure distance geometry is
not enough; the needed property is computational wrong-output usefulness under
one fixed marginal.

### Takeaway For The Edge

The distribution-free source gives a uniform clean weak learner and therefore
rules out some marginal-only diagonal counterexamples. It does not, by itself,
force constants, complements, a balanced proper convex hull, a weak center, or
a fixed-marginal agnostic selector. The positive proof still stops exactly at
the proper high/middle-OPT fallback.

For a false witness, the target should now be sharper: build a class where
clean distribution-free weak proper learning is easy because clean labels
expose a legal weak handle, but under one fixed noisy marginal every weakly
acceptable proper output either decodes a hard witness or is computationally
hard to find. Existing candidates either add handles that also neutralize the
agnostic problem, or remove handles and lose the source.

verdict: still-open; distribution-free source does not force a literal proper
neutralizer, but anti-neutralizer examples do not separate the OPT-relative
target.

confidence: medium-high.

next branches:

1. Formalize a quotient-neutralizer lemma that ignores consensus directions:
   characterize when lack of convex balance actually matters for
   OPT-relative weak agnostic learning.

2. Test clause-satisfaction assignments under arbitrary clean clause
   marginals: either find a distribution-free weak proper learner or show this
   near miss is source-negative.

3. Search for a wrong-output-usefulness construction under one fixed marginal:
   every proper hypothesis meeting
   $\langle r,h\rangle_P\ge M-1+2\alpha_P(s)$ should reveal the hidden
   witness, while clean labels still admit easy weak proper handles.

## Depth 4 Branch: OPT-relative proper neutralizer gap

### Setup

This branch separates two notions that the earlier notes sometimes blur:

1. a literal proper neutralizer, meaning a legal concept, list, or sampler
   whose correlation with every conditional label rule is close to zero; and
2. an OPT-relative proper neutralizer, meaning a legal concept, list, or
   sampler that is only required to beat the weak agnostic threshold
   $M-1+2\alpha_P(s)$.

The second condition is strictly weaker. In $\{\pm 1\}$ notation, for a fixed
marginal $P$,

$$
r(x)=\mathbf E[Y\mid X=x],
\qquad
M=\max_{c\in\mathcal C}\langle r,c\rangle_P,
$$

and the target only asks for a proper $h$ satisfying

$$
\langle r,h\rangle_P\ge M-1+2\alpha_P(s).
$$

If the low-noise branch has already handled
$\operatorname{OPT}=(1-M)/2<2\alpha_P(s)$, then the remaining branch has
$M\le 1-4\alpha_P(s)$ and hence

$$
M-1+2\alpha_P(s)\le -2\alpha_P(s).
$$

So the high-OPT branch does not need a balanced concept. It only needs a legal
proper output that is not too anti-correlated with $r$ relative to the best
proper concept.

### Bounded Handles Do Not Yet Separate

Bounded-handle classes still look positive for this edge. In the one-way
image-coordinate construction, constants and bounded positive-atom handles
make clean weak proper learning easy while preserving strong proper hardness.
But under the present weak agnostic target those same objects are cheap
high-OPT fallbacks. Constants give a literal neutralizer, and searchable
bounded handles give a validation-friendly proper selector whenever a modest
positive region is visible in the noisy labels.

Removing the handles restores the strong recovery hardness, but then the
source becomes suspect. A clean distribution can concentrate on the hard
coordinate block, and a weak proper learner must still produce a legal
hypothesis with inverse-polynomial advantage for every clean target. If the
only legal hypotheses with such an advantage are seed/image concepts, the
source learner already has to solve the one-way inversion problem in the
realizable case.

The tempting middle variant is to keep handles that are useful on clean labels
but useless under noisy labels. This needs a sharper property than the existing
bounded handles have. The source learner must be able to find a legal weak
handle from clean samples under arbitrary marginals, while for one fixed noisy
marginal every proper hypothesis meeting

$$
\langle r,h\rangle_P\ge M-1+2\alpha_P(s)
$$

must either encode the hidden witness or be computationally hard to locate. A
public bounded-handle family fails this: empirical validation can search the
same handles in the noisy problem, and the target only asks for a nearly
random-quality output in the high-OPT regime.

Thus bounded handles are not a separation as currently formulated. They either
are searchable enough to prove the target's high-OPT branch, or are hidden
enough that the clean distribution-free weak proper source becomes doubtful.

### Anti-Neutralizers Also Do Not Yet Separate

Anti-neutralizer examples show that a literal neutralizer is not forced by the
source. Anchored homogeneous parities are the clean sanity check: every proper
concept takes the same value at the anchor, so a marginal concentrated there
has no balanced proper convex hull.

But this obstruction lives in a consensus direction. If all legal concepts
agree on a region $A$, then the contribution

$$
\langle r,c\rangle_{P|A}
$$

is the same for every $c\in\mathcal C$. It shifts both $M$ and the candidate
correlation by the same amount, so it cancels from the OPT-relative comparison.
An adversarial label rule on $A$ may destroy literal neutrality without making
the weak agnostic task hard.

For an anti-neutralizer to separate this edge, it must create a non-consensus
gap: a fixed marginal $P$ and noisy label rule $r$ for which an optimal proper
concept is noticeably better than all efficiently findable fallback concepts,
yet the class remains distribution-free weak realizable properly learnable on
clean labels. Equivalently, the bad direction must survive after quotienting
out coordinates or affine components shared by every proper concept.

This is stronger than "the proper convex hull misses zero." It asks for a
computational OPT-relative gap:

$$
\langle r,c^\star\rangle_P
-
\langle r,h\rangle_P
>
1-2\alpha_P(s)
$$

for every efficiently findable cheap $h$, while some legal $c^\star$ exists.
Known anchored examples do not have this gap; known hard recovery examples get
the gap only after excluding the handles that made the source easy.

### Conditional Positive Under An Added Neutralizer Condition

The edge becomes true under the following added condition.

For every fixed marginal $P$ and size $s$, suppose there is a uniform
polynomial-time candidate generator $N$ whose polynomial bound may depend on
$P$, such that with inverse-polynomial probability it outputs a proper
concept $b\in\mathcal C_s$ satisfying the following high-OPT guarantee for
every conditional label rule $r$:

$$
\text{if } M\le 1-4\alpha_P(s),
\quad
\langle r,b\rangle_P\ge M-1+2\alpha_P(s).
$$

Then combine three candidate sources: repeated runs of the clean weak
realizable proper learner on noisy batches, repeated runs of $N$, and a
validation holdout sample. In the low-OPT branch, the clean-transcript
argument produces a proper candidate with error at most
$\operatorname{OPT}+1/2-\alpha_P(s)$. In the high-OPT branch, the generator
produces a proper candidate satisfying the displayed correlation inequality.
Uniform convergence over the polynomial candidate pool lets validation select
a good candidate.

A more concrete sufficient condition is a proper near-neutral sampler: for
the high-OPT branch it is enough that $N$ output, with inverse-polynomial
probability, some $b$ with

$$
\operatorname{err}_{\mathcal D}(b)\le \frac12+\alpha_P(s)
$$

for every $\mathcal D$ with marginal $P$. Since the high branch has
$\operatorname{OPT}\ge 2\alpha_P(s)$, such a $b$ satisfies

$$
\frac12+\alpha_P(s)
\le
\operatorname{OPT}+\frac12-\alpha_P(s).
$$

This condition can be stated without literal balancing. It is exactly an
OPT-relative proper neutralizer: it may fail to neutralize consensus
directions, and it may depend on $P$ through its polynomial search bound, but
it must be searchable and proper.

### Separation Target After This Branch

A successful separation now seems to need all of the following at once:

- clean distribution-free weak proper learning, with one uniform learner and
  one inverse-polynomial clean advantage;
- no validation-searchable OPT-relative proper neutralizer under some fixed
  marginal;
- a noisy label rule whose weakly acceptable proper outputs are all
  computationally useful, for example they decode a seed, proof, assignment,
  or codeword;
- no public constants, complements, signed bounded handles, or empirical
  handle search that supplies a legal near-neutral high-OPT output.

Bounded-handle constructions fail the second and fourth requirements. Pure
anti-neutralizer constructions fail the second requirement only literally, not
OPT-relatively, because their bad directions can be consensus directions.

verdict: still-open. Bounded handles and anti-neutralizers do not currently
give a separation; the target is positive under an added searchable
OPT-relative proper neutralizer condition.

confidence: medium-high.

next branches:

1. Formalize the quotient version of the neutralizer condition: remove
   consensus components and ask for a searchable proper selector only on the
   remaining disagreement geometry.

2. Try to construct hidden signed handles that are discoverable from clean
   realizable labels but not from one fixed noisy label rule, while preserving
   distribution-free weak proper learnability.

3. Revisit PCP/code wrong-output-usefulness with the explicit requirement
   that every proper hypothesis above
   $M-1+2\alpha_P(s)$ reveals the witness and that all cheap handles are
   absent or provably below threshold.

## Depth 5 Branch: hidden handles, residual blocks, and marginal advice

- depth: 5
- date: 2026-05-05
- focus: whether marginal advice plus weak realizable proper learning can
  agnosticize under fixed marginals, or whether bounded-handle,
  neutralizer-free, or residual-block classes separate the edge.

### Current Target

Depth 4 reduced the question to the high/middle-OPT branch. The low-noise
branch is already proper: if
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the clean-transcript
scale, repeated runs of the weak realizable proper learner produce a proper
candidate. The remaining question is whether, for each fixed marginal $P$, the
learner can find a legal proper fallback when

$$
M=\max_{c\in\mathcal C}\langle r,c\rangle_P
\le 1-4\alpha_P(s),
$$

where $r(x)=\mathbf E[Y\mid X=x]$. The target inequality is

$$
\langle r,h\rangle_P\ge M-1+2\alpha_P(s).
$$

The important quantitative point is that this threshold is often negative.
So a separation cannot merely make optimal proper recovery hard. It must make
every efficiently findable proper fallback more than roughly one correlation
unit worse than the optimum, or else such a fallback remains legal for a small
enough inverse-polynomial weak gap.

### What Marginal Advice Can And Cannot Do

The target's marginal nonuniformity is rate advice, not a separate learner
indexed by $P$. The algorithm is still uniform and is not handed an explicit
proper neutralizer, cover, or search procedure for the marginal. Thus a
positive proof cannot simply say that every fixed $P$ has some finite proper
cover; it needs a uniform way to generate candidates from samples, with the
runtime bounded by a $P$-dependent polynomial.

The Hopkins--Kane--Lovett--Mahajan realizable-to-agnostic cover idea remains a
sample-complexity sanity check rather than an efficient proof here. For a fixed
marginal, enumerate all labelings of an unlabeled sample, run the realizable
learner, and validate the returned hypotheses. This gives a nonuniform cover,
but the enumeration is $2^{m(s)}$ when the weak learner uses $m(s)$ examples.
Since $m(s)$ is polynomial in the representation size, this is generally
exponential, not a $P$-dependent polynomial. Marginal nonuniformity may change
the polynomial bound; it does not turn an exponential-in-$s$ enumeration into
an efficient algorithm.

So the only plausible positive route from the source alone would have to use
the weak learner more cleverly than exhaustive relabeling: for example, a
sample-generated polynomial candidate pool, a searchable proper selector, or a
weak refutation routine. I do not see such a routine in the abstract source
definition.

### Bounded Handles: Positive, Not Separating

The bounded-handle construction remains a near miss in the positive direction.
Public constants, signed handles, singleton handles, or bounded subset handles
are exactly the objects needed in the high-OPT branch. If they can be
enumerated or sampled in polynomial time, validation on noisy examples can
select them whenever they beat the weak threshold.

Trying to hide the handles creates a dichotomy.

If the handles are discoverable from clean realizable samples under arbitrary
marginals, then the same discovery procedure is a candidate generator on noisy
samples. It may fail to identify the exact clean handle when the labels are
noisy, but validation only needs some handle above
$M-1+2\alpha_P(s)$, a much weaker requirement than clean recovery.

If the handles are not discoverable in the noisy problem because their signal
is too weak, then they are also suspect for the source. The source is
distribution-free: it must weakly learn under marginals that concentrate on
the region where the hard concepts differ and under marginals that give little
or no mass to any auxiliary easy region. If the only clean weak outputs on
such a marginal are hidden seed concepts, the source learner already seems to
solve the intended hard problem in the realizable case.

This is the main reason bounded handles do not separate the assigned edge.
They either remain public enough to give the agnostic proper fallback, or they
are hidden enough that the clean distribution-free weak proper source is no
longer credible.

### Residual-Block Variants

A residual-block construction tries to attach an easy block $R$ to a hard core
$B$. Clean labels expose an easy handle on $R$, while a fixed noisy marginal
is supposed to force useful prediction on $B$ and make the residual handles
unhelpful.

This also runs into the distribution-free quantifier. The source must handle
the marginal $P_B$ that puts all its mass on $B$. On $P_B$, residual handles
are invisible. Therefore either:

- the hard core $B$ is itself weakly properly learnable in the realizable
  case, in which case the proposed hardness must come only from noisy labels;
  or
- the source property fails.

If the core is weakly learnable because it has its own public handles, those
core handles are again high-OPT agnostic fallbacks. If the core is weakly
learnable only by recovering a seed, assignment, proof, or codeword, the
source learner appears to break the same computational assumption the
separation hoped to use.

Giving the fixed hard marginal a small but nonzero residual mass does not fix
this. The weak agnostic target can choose $\alpha_P(s)$ below that residual
advantage scale if the residual handle is searchable. Conversely, if the
residual mass is below every admissible inverse-polynomial gap, then the
residual block cannot be what certifies distribution-free weak learnability on
marginals concentrated elsewhere.

Thus residual blocks seem to be bookkeeping devices, not a separation, unless
one can prove a genuinely noisy-only hardness on the hard core while retaining
an independent clean weak learner on that same core.

### Neutralizer-Free Geometry After Quotienting

The anti-neutralizer route also remains too weak. A class can fail literal
balancing because all proper concepts agree on an anchor or on a large
consensus block. But consensus contributions cancel from the OPT-relative
comparison: they shift $\langle r,h\rangle_P$ and
$M=\max_c\langle r,c\rangle_P$ together.

A real separation needs a non-consensus anti-neutralizer. After quotienting out
the affine span shared by all proper concepts, there must be a noisy direction
$r$ and an optimal concept $c^\star$ such that every efficiently findable cheap
proper concept $h$ satisfies

$$
\langle r,c^\star\rangle_P-\langle r,h\rangle_P
> 1-2\alpha_P(s).
$$

This is a very large gap. It explains why code and parity attempts keep
leaking weak outputs. If $r=(1-2\eta)c^\star$ and a wrong codeword $h$ is
orthogonal to $c^\star$ under $P$, then
$\langle r,h\rangle_P=0$. The weak threshold is

$$
M-1+2\alpha_P(s)
=(1-2\eta)-1+2\alpha_P(s)
=2(\alpha_P(s)-\eta).
$$

For the high-OPT regime $\eta\ge \alpha_P(s)$, the orthogonal wrong codeword
is already legal. To force recovery, wrong codewords must be not merely
orthogonal but slightly anti-correlated at the hidden inverse-polynomial
scale, and this must hold for every efficiently findable wrong output under
one fixed marginal. Existing Plotkin/Hadamard/list-decoding barriers explain
why pure distance geometry has not delivered this.

### Best Remaining False-Witness Shape

The best separation template after this pass is a computational
wrong-output-usefulness class:

- one fixed marginal $P$;
- a noisy label rule $r_w$ hiding a witness $w$;
- a legal proper optimum $c_w$;
- clean distribution-free weak proper learning, including on marginals
  concentrated on the hard core;
- for every inverse-polynomial $\alpha(s)$ that a target learner might claim,
  every proper $h$ satisfying
  $\langle r_w,h\rangle_P\ge M_w-1+2\alpha(s)$ lets one recover useful
  information about $w$; and
- no public constants, complements, bounded handles, residual handles, random
  balanced subfamilies, or wrong codewords that pass the threshold without
  revealing $w$.

This is sharper than ordinary proper agnostic hardness. Strong
$\operatorname{OPT}+\varepsilon$ hardness can force recovery of $c_w$ by
setting $\varepsilon$ tiny. The present weak target cannot: it permits errors
nearly $1/2$ above OPT. A witness must make even those nearly random-quality
proper outputs computationally useful.

I do not currently know a construction with this property. The known
one-way-image-coordinate weak-handle class fails because its handles are too
useful. Clause-satisfaction and PCP active-slice routes fail because either
the source is not distribution-free weak proper under arbitrary clean
marginals, or the active slice is diluted/neutralized when placed under one
fixed marginal. Code and LPN-like routes fail because neutral or residual
wrong outputs remain legal once the noise is above the hidden weak gap, while
very-low-noise cases are covered by clean-transcript robustification.

### Conditional Positive Envelope

The positive theorem still looks correct under any one of the following added
conditions, all of which are stronger than the source node:

- legal constants or complements;
- a $P$-polynomial validation-searchable near-neutral proper sampler;
- a quotient-neutralizer that ignores consensus directions and only balances
  the disagreement geometry;
- a polynomial candidate generator whose outputs satisfy the high-OPT
  inequality above whenever $M\le 1-4\alpha_P(s)$; or
- a fixed-marginal weak agnostic selector/refuter over the proper class.

With any such generator, the full learner is the same two-branch algorithm:
clean-transcript weak learner runs for low OPT, generator runs for high OPT,
and holdout validation chooses the best proper candidate.

### Verdict

verdict: unresolved-open.

The depth-5 search did not resolve the edge. Weak realizable proper learning
does not appear to imply a searchable OPT-relative proper neutralizer, but the
bounded-handle, anti-neutralizer, and residual-block constructions examined so
far also do not separate the edge. The live obstruction is now narrower:
constructing a fixed-marginal noisy-only hardness result where every weakly
acceptable proper output is computationally useful, while the same class is
still distribution-free weak realizable properly learnable.

confidence: medium-high.

### Obstacles

- Marginal nonuniformity gives a $P$-dependent polynomial rate, not a
  $P$-specific learner or explicit neutralizer.
- Exhaustive relabeling gives a sample-complexity cover but is exponential in
  the weak learner's polynomial sample size.
- Public bounded handles solve the high-OPT branch; hidden handles threaten
  the distribution-free source.
- Residual blocks disappear under marginals concentrated on the hard core, so
  they cannot by themselves certify the source.
- Literal anti-neutralizers can live entirely in consensus directions and need
  not affect the OPT-relative target.
- Orthogonal wrong codewords are legal whenever the noise exceeds the hidden
  weak gap; forcing recovery needs inverse-polynomial anti-correlation or
  computational wrong-output-usefulness under one fixed marginal.

### Concrete Depth-6 Directions

1. Prove a hidden-handle dichotomy lemma: under distribution-free weak
   realizable proper learning, any handle family that certifies weak learning
   on hard-core marginals is either validation-searchable enough for the
   agnostic high-OPT branch or already solves the hard clean problem.

2. Formalize residual-block no-go conditions. If a construction's clean weak
   advantage comes from a residual block, test the marginal that removes that
   block and check whether the source still holds.

3. Quantify the code threshold exactly: for noisy labels
   $r=(1-2\eta)c^\star$, derive the pairwise correlation bound needed so every
   wrong proper codeword falls below $M-1+2\alpha$, then compare it with
   Plotkin/list-decoding limits for the intended fixed marginal.

4. Revisit clause-satisfaction under arbitrary clean clause marginals. Either
   find a genuine distribution-free weak proper learner for assignment
   concepts, or record that this route is source-negative for the assigned
   edge.

5. Search for a fixed-marginal refutation-style hardness theorem where
   weakly beating the OPT-relative threshold by any proper hypothesis implies
   decoding a witness. This is stronger than standard strong agnostic proper
   hardness and is the exact false-witness shape needed here.

6. Explore positive restricted theorems: source plus sample compression,
   stable weak learner, polynomial trace cover, legal complement pair, or
   quotient-neutralizer generator. Any one of these may turn the open edge into
   a clean conditional true lemma.

## Depth 6 Branch: final hard attempt on fixed-marginal weak proper agnosticization

- depth: 6
- date: 2026-05-05
- focus: hidden-handle dichotomies, residual-block no-go checks,
  code-threshold quantification, clause-marginal tests, and
  fixed-marginal refutation-style hardness.

### Target Reframing

The low-noise branch is no longer the live issue. With source sample bound
$m(s)$ and clean weak advantage $\gamma(s)$, the coupling argument gives a
proper candidate whenever

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)
\lesssim
\min\{\gamma(s),1/m(s)\}.
$$

So a final false witness must live in the middle/high-OPT regime and must
defeat the weak OPT-relative threshold

$$
\langle r,h\rangle_P
\ge
M-1+2\alpha_P(s),
\qquad
M=\max_{c\in\mathcal C_s}\langle r,c\rangle_P.
$$

Equivalently, it is not enough to make finding an optimal proper hypothesis
hard. The hard distribution must make every efficiently findable proper
hypothesis worse than the best proper concept by almost one full correlation
unit. That is the source of all the near misses below.

### Hidden-Handle Dichotomy

The cleanest possible separation would add legal handles that make realizable
weak proper learning easy but make agnostic weak proper learning hard. The
last attempt was to hide those handles so that they are exposed by clean
labels but not by the fixed noisy label rule.

The dichotomy seems unavoidable:

1. If a handle is discoverable from clean realizable samples under arbitrary
   marginals, then the discovery procedure is almost a candidate generator for
   the agnostic high-OPT branch. It need not identify the same handle under
   noise; validation only needs some legal handle with correlation above
   $M-1+2\alpha_P(s)$, and this threshold is often negative.

2. If a handle is not discoverable under the fixed noisy distribution, then
   there is a marginal concentrated on the hard region where the same hidden
   structure is all that certifies clean weak learnability. Under that
   marginal, the source learner itself must find a useful proper concept from
   realizable labels, so the construction has either leaked a clean algorithm
   for the hard object or failed the source node.

This is not a theorem yet because "discoverable" needs to be formalized as a
validation-searchable candidate distribution. But it is strong enough to block
the usual handle recipes. Public constants, complements, singleton handles,
and signed handles solve the target. Cryptographic handles that are hidden
from noisy samples threaten the distribution-free source once the marginal is
allowed to remove every easy auxiliary region.

Missing lemma:

> If a class is distribution-free weak realizable properly learnable using a
> designated handle family on every hard-core marginal, then either a
> polynomial noisy-sample candidate generator finds an OPT-relative proper
> fallback at the same fixed marginal, or the clean learner can be converted
> into the intended decoder/refuter for the hard witness.

The edge would become much clearer if this lemma could be proved or refuted.

### Residual-Block No-Go Check

Residual blocks try to evade the dichotomy by splitting the domain into a hard
core $B$ and an easy block $R$. Clean labels reveal weak signal on $R$; the
fixed agnostic hard marginal puts most of its mass on $B$.

This fails a simple source test. Since the source is distribution-free, it
must work under the marginal $P_B$ supported only on $B$. Therefore $R$ cannot
be essential to clean weak realizable proper learning. One of two things must
happen on $B$:

- $B$ is already weakly properly learnable in the realizable case, in which
  case the separation must be genuinely noisy-only on the same core; or
- $B$ is not weakly properly learnable, in which case the proposed class does
  not satisfy the source.

Making $R$ small but nonzero under the fixed hard marginal also does not help.
If $R$ contributes an efficiently searchable inverse-polynomial advantage,
the target may choose $\alpha_P(s)$ below that scale and use the residual
handle as a legal fallback. If $R$ has sub-inverse-polynomial mass, it cannot
be the reason the distribution-free weak source holds for marginals that put
negligible or zero mass on all other easy regions.

So residual blocks are only harmless padding unless the hard core itself has
a clean weak proper learner and an independent noisy-only weak proper
hardness theorem. I do not know such a hard core.

### Code-Threshold Quantification

The code route asks whether one can make all wrong proper hypotheses fall
below the weak threshold under one fixed marginal. Write labels in
$\{\pm1\}$ and take a noisy planted concept

$$
r=(1-2\eta)c^\star.
$$

Then

$$
M=\langle r,c^\star\rangle_P=1-2\eta.
$$

A wrong codeword $h$ with correlation
$\rho=\langle h,c^\star\rangle_P$ has

$$
\langle r,h\rangle_P=(1-2\eta)\rho.
$$

For $h$ to be rejected by a weak agnostic target with gap $\alpha$, it must
satisfy

$$
(1-2\eta)\rho < M-1+2\alpha
=2(\alpha-\eta).
$$

Thus the required wrong-codeword correlation bound is

$$
\rho < \frac{2(\alpha-\eta)}{1-2\eta}.
$$

This formula is fatal in the intended middle-noise regime. If
$\eta\ge \alpha$, the right-hand side is nonpositive. Orthogonal wrong
codewords, and certainly mildly positive residual wrong codewords, are legal
weak outputs. To force recovery of $c^\star$, every efficiently findable wrong
proper hypothesis must be anti-correlated with $c^\star$ at the hidden
inverse-polynomial scale.

If $\eta<\alpha$, the low-noise coupling branch already applies after
choosing $\alpha$ below the source transcript scale. The code construction is
therefore squeezed between two bad regimes:

- very low noise is handled by clean-transcript robustification;
- middle noise requires anti-correlation, not mere distance $1/2$ or
  orthogonality.

This matches the atlas coding obstruction. Exact nonpositive correlations for
an exponentially large proper family need Hadamard/Plotkin-scale geometry,
which is too large or too structured for the finite encoded fixed-marginal
lookup attempts. Approximate polynomial-size constructions leave
inverse-polynomial residual correlations, and the marginal-nonuniform target
may hide its $\alpha_P(s)$ below those residuals.

### Clause-Marginal Test

The clause-satisfaction class is the sharpest fixed-marginal agnostic proper
hardness pattern in the atlas: use the uniform marginal over all clauses on
$n$ variables and encode the input formula only in the conditional labels.
Formula clauses are labeled $1$; non-formula clauses are fair noise. Proper
hypotheses are assignments.

For the assigned edge, however, this class fails the source-side test. The
source asks for distribution-free weak realizable proper learning. Under a
clean marginal supported on the clauses of a satisfiable formula, a weak
proper learner for assignment concepts would have to output an assignment
that satisfies noticeably more than half of the sampled clause distribution.
For adversarial clause marginals, that is already a weak satisfiability
search problem. The usual clause-satisfaction lookup class was designed to be
easy improperly, not weakly easy properly.

One might try to weaken the clause test: use a fixed uniform marginal over all
clauses for the hard agnostic distribution and add public handles to make
arbitrary clean clause marginals weakly properly learnable. But then those
handles become proper high-OPT fallbacks unless they are hidden. If they are
hidden, the hidden-handle dichotomy repeats.

Thus the clause route gives an atlas-facing warning rather than a witness:
fixed-marginal encoding of formulas is strong enough for marginal-nonuniform
proper agnostic hardness, but not compatible with the distribution-free weak
realizable proper source unless an additional clean weak assignment learner is
supplied. That additional learner is essentially the missing ingredient.

### Fixed-Marginal Refutation-Style Hardness

The exact false-witness shape would be a fixed-marginal refutation theorem.
For each hard witness $w$, choose one marginal $P$ and a conditional label
rule $r_w$ such that:

1. the proper optimum $c_w$ has correlation $M_w$;
2. every proper $h$ with

   $$
   \langle r_w,h\rangle_P\ge M_w-1+2\alpha(s)
   $$

   yields a randomized polynomial-time decoder/refuter for $w$; and
3. the same concept class has a distribution-free weak realizable proper
   learner on clean labels.

Condition 2 is far stronger than standard proper agnostic hardness. Standard
hardness can force recovery by asking for $\operatorname{OPT}+\varepsilon$
accuracy. Here the learner may be almost $1/2$ worse than optimum. Therefore
even a weakly legal proper output must be computationally meaningful.

This suggests a refutation rather than recovery framing: a legal hypothesis
need not identify the planted object, but it should distinguish the hard label
rule from a null/noise rule. Unfortunately, if the class contains any public
near-balanced proper concept, the null distinction is easy in the wrong
direction: validation can output that concept and satisfy the weak threshold
without learning the witness. If the class removes all such concepts, the
realizable weak source loses its easy fallback on hard-core marginals.

So the missing theorem is not just "fixed-marginal agnostic proper learning is
hard." It is:

> fixed-marginal weak OPT-relative proper refutation is hard, even though
> clean realizable labels for the same proper class are distribution-free
> weakly learnable.

No standard PCP, LPN, halfspace, one-way, or clause construction presently in
the atlas seems to instantiate that theorem.

### Last Positive Attempt

The strongest positive statement I can justify remains conditional. Suppose
that for every marginal $P$ there is a uniform polynomial-time, validation
searchable generator $G$ whose polynomial bound may depend on $P$, and for
every label rule $r$ with

$$
M\le 1-4\alpha_P(s)
$$

the generator outputs, with inverse-polynomial probability, a proper concept
$b$ satisfying

$$
\langle r,b\rangle_P\ge M-1+2\alpha_P(s).
$$

Then the edge is true for that class: run the clean weak learner repeatedly
for the low-noise branch, run $G$ repeatedly for the high-OPT branch, and use
holdout validation over the polynomial candidate pool. The source alone,
however, does not appear to imply such a $G$.

This is the tight positive envelope. It covers legal constants, complement
pairs, searchable bounded handles, quotient-neutralizers, and fixed-marginal
proper weak selectors. It does not cover arbitrary weak realizable proper
classes.

### Atlas-Facing Synthesis

Verdict after depth 6: unresolved; keep the edge `open`.

Precise obstruction:

The distribution-free weak realizable proper source gives a proper
low-noise agnostic learner by clean-transcript coupling. The remaining
middle/high-OPT branch requires a legal proper fallback under each fixed
marginal. Weak realizable proper learning alone gives no known
validation-searchable OPT-relative neutralizer, balanced proper sampler,
fixed-marginal weak selector, or proper refutation routine.

Near misses:

- Hidden handles either are searchable enough to solve the agnostic fallback
  branch, or are hidden enough to endanger the clean distribution-free source.
- Residual blocks vanish under marginals concentrated on the hard core, so
  they cannot certify the source unless the hard core is itself clean weak
  properly learnable.
- Code/Hadamard/LPN-style witnesses fail quantitatively: when
  $\eta\ge\alpha$, orthogonal wrong codewords are legal weak outputs; when
  $\eta<\alpha$, low-noise robustification applies.
- Clause-satisfaction fixed-marginal hardness is source-negative for this
  edge because weak proper learning under arbitrary clean clause marginals
  already resembles assignment search.
- Standard fixed-marginal strong agnostic hardness is too strong-accuracy
  oriented; the weak target permits nearly random-quality proper outputs.

Missing lemma:

A resolution likely needs one of two new lemmas.

Positive lemma: distribution-free weak realizable proper learning implies,
for every fixed marginal, a validation-searchable OPT-relative proper
neutralizer or weak selector for the high-OPT branch.

Negative lemma: there exists a fixed-marginal weak refutation-style hardness
gadget in which every proper hypothesis satisfying
$\langle r,h\rangle_P\ge M-1+2\alpha(s)$ decodes or refutes the hard witness,
while the same proper class remains distribution-free weak realizable
learnable on clean labels.

Recommended atlas status/family:

Keep `status: "open"`, `evidence: unknown`, and family
`marginal-agnostic-hardness-open`. If the argument note is later refined,
record this edge as the proper-output, middle-noise subfamily of marginal
agnostic hardness: low-noise is solved by realizable-source coupling, and the
unresolved obstruction is the absence of a searchable OPT-relative proper
neutralizer under fixed marginals.

confidence: high that current known templates do not settle the edge;
medium that the edge is genuinely independent of the current source without
an extra neutralizer/selector assumption.
