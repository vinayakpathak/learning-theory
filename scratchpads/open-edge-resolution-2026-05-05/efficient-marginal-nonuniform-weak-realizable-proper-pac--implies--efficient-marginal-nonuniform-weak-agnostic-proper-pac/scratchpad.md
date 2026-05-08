# Edge: efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Context

The source gives one uniform learner $A$ such that, for every instance
marginal $P$, there are a $P$-dependent polynomial sample/time bound
$m_P(s,\log(1/\delta))$ and a $P$-dependent inverse-polynomial weak advantage
$\gamma_P(s)$ satisfying

$$
\operatorname{err}_P(A,c) \le 1/2-\gamma_P(s)
$$

on realizable labels $Y=c(X)$, with $A$ returning a proper hypothesis
$h\in\mathcal C$.

The target asks for one uniform learner which, for every joint distribution
$\mathcal D$ with marginal $P$, returns $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s)
$$

for some inverse-polynomial $P$-dependent gap $\alpha_P(s)$.

The current atlas edge is marked `open` under
`marginal-agnostic-hardness-open`. The nearby improper-target edges are now
resolved by low-noise robustification because the two constant classifiers can
serve as improper neutralizers. This assigned edge asks whether the same
argument can be made proper.

## Attempted Resolution

### Low-Noise Coupling Does Stay Proper

Fix a marginal $P$ and run the source weak realizable proper learner with
constant confidence. Let $m_P(s)$ be the corresponding $P$-dependent
sample/time bound and let $\gamma_P(s)$ be the weak realizable advantage. Set

$$
\alpha_P(s)
\le
\min\{\gamma_P(s)/8, 1/(100m_P(s)), 1/100\}.
$$

Let $\mathcal D$ have marginal $P$ and let
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$. If
$\eta < 2\alpha_P(s)$, choose $c^\star\in\mathcal C$ with
$\operatorname{err}_{\mathcal D}(c^\star)\le \eta$ up to negligible slack.
Couple one noisy run of $A$ on $(X,Y)\sim\mathcal D$ with a clean realizable
run on $(X,c^\star(X))$, using the same $P$-distributed instance sequence and
the same internal randomness.

Since the run inspects at most $m_P(s)$ labels, the probability that any
inspected label differs from $c^\star(X)$ is at most

$$
m_P(s)\eta < 2m_P(s)\alpha_P(s) \le 1/50.
$$

On the no-corruption event, the noisy transcript is exactly a realizable
transcript under the original marginal $P$, not under a conditional clean
marginal. The source guarantee therefore applies with the same $P$-dependent
polynomial and returns a proper $h\in\mathcal C$ satisfying

$$
\operatorname{err}_P(h,c^\star)\le 1/2-\gamma_P(s).
$$

Then

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\operatorname{err}_P(h,c^\star)
\le
\eta+1/2-\gamma_P(s)
\le
\eta+1/2-\alpha_P(s).
$$

Repetition and validation preserve a $P$-dependent polynomial bound. Thus the
low-noise branch of the robustification remains fully proper: the source
learner itself outputs concepts in $\mathcal C$.

### Constants Or Legal Neutralizers Give A Conditional Positive Theorem

The improper proof handles the complementary regime by outputting the better
constant classifier. If $\eta \ge 2\alpha_P(s)$, a classifier with error at most
$1/2$ has

$$
1/2 \le \eta+1/2-\alpha_P(s).
$$

Therefore, if both constant classifiers are legal members of $\mathcal C$, the
same low-noise wrapper is a proper weak agnostic learner: include the constants
among the validation candidates, run $A$ repeatedly on fresh agnostic batches,
and validate all candidates.

More generally, the edge is true for any class with a validation-searchable
proper neutralizer: for each fixed $P$, a $P$-polynomial procedure that produces
a finite proper candidate list containing some $b\in\mathcal C$ with
$\operatorname{err}_{\mathcal D}(b)\le 1/2$ for every conditional label rule.
Constants are the simplest such neutralizer. Complement closure plus an
efficiently available anchor can also work, because one of $b,\bar b$ has error
at most $1/2$.

This is the clean answer to the prompt's neutralizer check: yes, the
low-noise robustification remains proper when the neutralizers used in the
middle/high-noise branch are themselves legal proper hypotheses.

### Why This Does Not Prove The Full Edge

The source node does not require constants, complement closure, a balanced
proper sampler, a fixed-$P$ weak cover, or proper ERM. It only promises useful
behavior on realizable samples.

For middle noise, for example $\eta$ much larger than $1/m_P(s)$ but still well
below $1/2$, the all-clean transcript event can be exponentially unlikely.
Running $A$ directly on noisy labels gives proper candidates, but the source
definition says nothing about $A$ on inconsistent transcripts. The target still
asks for a proper hypothesis with error below
$\eta+1/2-\alpha_P(s)$, and an arbitrary default concept can be almost opposite
to a near-optimal $c^\star$.

Thus a positive proof would need an additional fixed-marginal proper selector:
some efficient way, using noisy samples under the same marginal $P$, to find a
proper hypothesis that is at least inverse-polynomially better than a
neutral baseline relative to the hidden near-optimal concept. I do not see such
a selector in the source assumption.

## Counterexample Search

I did not find an atlas-ready false witness.

### Halfspaces

Halfspaces are efficiently realizably properly learnable, and Tiegel's 2023
result gives strong agnostic hardness for halfspaces from worst-case lattice
assumptions in both distribution-independent and distribution-specific forms.
This still misses the assigned edge.

The distribution-independent weak hardness varies the hard marginal with the
reduction, so it does not pin down one fixed marginal $P$ together with all
$P$-dependent polynomial bounds. The distribution-specific standard-Gaussian
result is a strong excess-error lower bound, not a low-OPT weak no-advantage
theorem against a $P$-dependent gap. In addition, standard halfspace classes
usually contain constant halfspaces, so the conditional neutralizer theorem
above makes them positive examples for this marginal-nonuniform weak target
rather than counterexamples.

### FGRW-Style Weak Agnostic Hardness

Feldman--Guruswami--Raghavendra--Wu prove hardness of weak agnostic learning of
monomials even by halfspaces for constant $\epsilon$. This is close in flavor,
but the Label-Cover/dictatorship-test distributions are not a fixed marginal
counterexample to a learner whose polynomial and weak gap may depend on that
marginal. Packing all hard instances into one shared marginal dilutes the hard
slice, and handle-rich classes may use constants or other neutralizers.

### Parities, Noisy Codes, And LPN-Like Ideas

Parities under the uniform marginal are a useful stress test: clean proper
learning is efficient, while noisy parity has familiar hardness barriers. They
do not settle this edge.

If the noise rate is below the chosen gap $\alpha_P(s)$, the marginal-preserving
low-noise coupling is already the relevant positive argument. If the noise rate
is above the gap, orthogonal wrong parities are often weakly acceptable in
random-noise models, because their error is near $1/2$ while the allowed bound
is $\eta+1/2-\alpha_P(s)$. For adversarial noise, one would need one fixed
corruption pattern that makes every wrong parity fail by an inverse-polynomial
margin; Fourier averaging and small-bias/code geometry make this a nontrivial
extra requirement rather than a ready lower bound.

More broadly, a code-based false witness would need easy clean proper decoding
but hard noisy weak proper selection under one fixed marginal. Pure geometry is
not enough: demanding that every wrong proper codeword be more than
$1/2+\tau$ away from the target is Plotkin-forbidden for large binary families
when $\tau$ is inverse-polynomial. The remaining possibility is computational
selector hardness, not just pairwise distance.

### PCP And Active-Slice Templates

PCP active-slice constructions can force local weak proper hardness, but the
hard marginal is normally the active instance slice. A marginal-nonuniform
learner may attach a polynomial to that slice. If all slices are packed into
one fixed marginal, each hard slice receives small mass and the weak tolerance
can ignore it unless the construction supplies a new wrong-output-usefulness
gadget.

Clause-satisfaction lookup classes are strong proper hardness witnesses, but
they do not give this source-positive weak-realizable-proper edge. In
positive-only clause distributions, random assignments or small handles often
already have weak advantage; for fixed-marginal strong encodings, the weak
additive target can absorb small slice or clause gaps.

## Proposed Atlas Update

No status change is justified from this pass. I would keep the edge open, but
tighten the summary around the proper neutralizer/selector obstruction.

Suggested frontmatter refresh:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
summary: "Open: marginal-preserving low-noise coupling gives proper weak agnostic hypotheses below the fixed-marginal transcript scale, and legal constants or neutralizers would finish the proof; arbitrary proper classes need not contain such a middle-noise neutralizer or weak selector."
```

Suggested body sketch:

```markdown
## Verdict

`open`.

The low-noise branch is understood. Fix a marginal $P$, let $m_P$ and
$\gamma_P$ be the sample/time bound and weak advantage of the realizable proper
learner, and choose the target weak gap below both $\gamma_P$ and $1/m_P$.
When $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below this gap, couple a
noisy run to a clean realizable run for a near-optimal concept using the same
$P$-distributed instance sequence. On the no-corruption event the source
learner returns a proper concept, so validation gives the target guarantee.

The middle/high-noise branch is the obstruction. The improper robustification
uses constant classifiers as neutralizers, but constants need not lie in an
arbitrary proper class. A positive theorem would follow from legal constants,
complement-pair anchors, a validation-searchable fixed-$P$ proper neutralizer,
or an efficient fixed-marginal weak proper selector. None follows from weak
realizable proper learning alone. Known halfspace, FGRW/PCP, parity/code, and
lookup hardness templates do not currently give a fixed-marginal low-OPT weak
proper counterexample.
```

## Obstacles

- Low-noise robustification is proper only for the low-OPT branch; the source
  learner returns legal concepts there.
- The high-OPT fallback in the improper proof uses constants. Constants are not
  guaranteed to be in $\mathcal C$.
- Clean weak realizable proper learning gives no guarantee on noisy
  transcripts, no efficient proper ERM, and no fixed-marginal proper weak
  selector.
- Known hardness routes either vary the hard marginal, prove strong rather
  than weak fixed-marginal hardness, leave legal neutralizers/handles, or run
  into code-geometry barriers.

## Next Directions

1. Prove a reusable restricted positive lemma: low-noise coupling plus legal
   constants, complement-pair anchors, or a validation-searchable fixed-$P$
   proper neutralizer implies the edge.
2. Search specifically for fixed-marginal low-OPT weak proper hardness where
   every proper hypothesis with inverse-polynomial advantage decodes a hard
   witness. This is stronger than existing strong agnostic hardness.
3. Try code-based selector lower bounds with easy clean decoding but hard
   noisy weak selection, while avoiding the parity failure where wrong
   hypotheses are merely orthogonal and often weakly acceptable.
4. Revisit PCP/shared-marginal gadgets looking for "wrong-output usefulness":
   any legal weak proper output, not only a near-perfect output, should reveal
   the hard witness.

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview, https://openreview.net/forum?id=aoVCFtox89
- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 1991, https://doi.org/10.1016/0304-3975(91)90026-X
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", COLT/PMLR 2023, https://proceedings.mlr.press/v195/tiegel23a.html
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by Halfspaces Is Hard", SIAM Journal on Computing 2012, https://doi.org/10.1137/120865094
- Kearns, Schapire, and Sellie, "Toward Efficient Agnostic Learning", Machine Learning 1994, https://doi.org/10.1007/BF00993468
- Plotkin, "Binary codes with specified minimum distance", IRE Transactions on Information Theory 1960, https://doi.org/10.1109/TIT.1960.1057584

## Depth 2 Branch: proper neutralizer/selector

### Sharpening The Obstruction

Use $\{\pm 1\}$ notation in this branch. For a joint distribution
$\mathcal D$ with marginal $P$, write
$$
r(x)=\mathbf E[Y\mid X=x].
$$
Then
$$
\operatorname{err}_{\mathcal D}(h)=\frac12-\frac12\langle r,h\rangle_P.
$$
If $c^\star\in\mathcal C$ has error $\eta$ and correlation
$\langle r,c^\star\rangle_P=1-2\eta$, the weak agnostic target asks for
$$
\langle r,h\rangle_P
\ge
\langle r,c^\star\rangle_P+2\alpha_P(s)-1
=
2\alpha_P(s)-2\eta .
$$
Thus, once $\eta\ge \alpha_P(s)$, the target only asks for a proper hypothesis
with nonnegative, or very slightly negative, correlation with the labels. The
literal statement "every proper hypothesis is worse than $1/2$ while OPT is
small" cannot hold, because the near-optimal $c^\star$ itself is proper and
has error $\eta<1/2$.

The real obstruction is algorithmic, not existential: for a noisy distribution
near $c^\star$, every easy fixed proper fallback might be anti-correlated, and
finding either $c^\star$ or any merely nonnegative-correlated proper hypothesis
might require a proper selector that the realizable learner does not provide.

### Conditional Theorem: Barycentric Proper Neutralizers

The cleanest atlas-ready positive condition is a randomized proper
neutralizer. Fix $P$ and size parameter $s$. Suppose there is a $P$-polynomial
procedure producing a finite list $B_{P,s}\subseteq\mathcal C_s$, or sampling
from a distribution $\mu_{P,s}$ over $\mathcal C_s$, such that for every label
regression function $r:X\to[-1,1]$,
$$
\mathbf E_{b\sim\mu_{P,s}}\langle r,b\rangle_P \ge -\zeta_P(s),
$$
with $\zeta_P(s)\le \alpha_P(s)/10$. Equivalently, up to $\zeta_P(s)$, the
zero function lies in the $P$-closed convex hull of legal proper hypotheses.
This is weaker than having constants or complements. It can hold for balanced
proper ensembles even when no single concept has its complement in the class.

Then the depth-1 proof becomes a theorem. In the low-noise case
$\eta<2\alpha_P(s)$, use the marginal-preserving coupling with the realizable
proper learner. In the middle/high-noise case, draw enough neutralizer
candidates from $\mu_{P,s}$, validate them on a holdout sample, and output the
best candidate. Since the average correlation is at least $-\zeta_P(s)$, some
proper candidate has
$$
\operatorname{err}_{\mathcal D}(b)\le \frac12+\frac{\zeta_P(s)}2.
$$
For $\eta\ge 2\alpha_P(s)$ and $\zeta_P(s)\le \alpha_P(s)/10$, this is below
$$
\eta+\frac12-\alpha_P(s)
$$
after the usual validation slack. Constants are the degenerate case where the
neutralizer list is $\{0,1\}$ in $\{0,1\}$ notation. Complement-pair anchors
and balanced code ensembles are other cases. The source weak realizable proper
assumption alone, however, does not appear to imply any such barycentric
neutralizer.

### Geometry Barrier To A Pure Code Counterexample

A tempting false witness would make every wrong proper hypothesis worse than
$1/2$ by an inverse-polynomial margin against labels close to $c^\star$. In
code language, this asks for a large binary code whose pairwise distances are
all at least $1/2+\tau(s)$ under one fixed marginal $P$.

That route is blocked by the usual Plotkin/Gram-matrix phenomenon. If
$\langle c_i,c_j\rangle_P\le -2\tau$ for all $i\ne j$, positive semidefiniteness
of the Gram matrix bounds the number of codewords by $O(1/\tau)$, up to
inessential constants. For inverse-polynomial $\tau$, the hard core has only
polynomially many concepts. With ordinary explicit representations, that is
not an atlas-ready computational lower bound: a validation-based selector can
search the polynomial-size hard core using the marginal-dependent polynomial
budget.

This explains why the parity/code attempts stall. Homogeneous parities under
the uniform marginal have no useful constants and need not contain complements,
but wrong parities are exactly neutral, not worse than neutral. Standard LPN
hardness is hardness of recovering the planted parity from noisy labels; the
atlas weak agnostic target does not require recovery when $\eta\ge\alpha_P(s)$,
because any neutral wrong parity suffices. Biasing the marginal or adding an
orientation block can make some wrong parities anti-correlated, but making all
wrong hypotheses anti-correlated by an inverse-polynomial gap for an
exponential-size secret family runs into the same Gram/Plotkin bound.

### PCP And Lookup Templates

PCP-style tests are better at creating selector hardness: the label rule can
be nearly satisfiable, while finding an assignment with even a small advantage
over the random baseline is NP-hard. The mismatch is that the assigned edge
needs the source class to be weakly realizable properly learnable under every
fixed marginal. Standard PCP reductions usually put the hard instance into the
marginal or require proper recovery of a witness already in the clean case.

Packing all PCP instances into one fixed marginal also dilutes the active
slice. If the active slice has small mass, the weak additive target can ignore
it or a neutralizer handles it. If the active slice has large mass, then the
marginal is essentially instance-specific again, or clean weak proper learning
starts to look as hard as finding the PCP witness. Clause-satisfaction lookup
classes have a similar problem: they provide strong proper hardness witnesses,
but random assignments, local handles, or improper constants often give the
weak middle-noise baseline, while removing those handles tends to damage the
source realizable proper learner.

### What A False Witness Would Need

An atlas-ready counterexample should therefore be a selector-hard family, not a
pure distance-code family. It would need one fixed marginal $P$ and a family of
joint distributions $\mathcal D_z$ such that:

1. $\operatorname{OPT}_{\mathcal C}(\mathcal D_z)=\eta_z$ is above the
   low-noise coupling scale but below the inverse-polynomial anti-neutral gap;
2. clean realizable labels from every $c_z\in\mathcal C$ are weakly properly
   learnable in $P$-polynomial time;
3. from noisy labels, any $P$-polynomial algorithm that outputs a proper
   hypothesis with nonnegative correlation solves a hard selector problem;
4. the class has no efficiently samplable barycentric proper neutralizer under
   $P$.

This is stronger than ordinary LPN or standard weak agnostic PCP hardness.
Those results can force recovery or positive correlation, but this edge can be
satisfied by a merely neutral proper output whenever $\eta$ is above the chosen
weak gap. A counterexample must rule out all efficiently findable neutral
proper outputs, not only rule out the planted concept.

### Takeaway

This branch yields a useful conditional positive theorem but not a false edge.
The obstruction should be recorded as "proper neutralizer or proper selector"
rather than as a simple absence of constants. The absence of constants and
complements matters only when it also prevents an efficiently searchable
barycentric neutralizer. Current code, parity, PCP, and lookup constructions do
not yet supply that stronger obstruction.

verdict: unresolved
confidence: medium
next branches:
- Formalize the barycentric-neutralizer theorem as an optional positive lemma
  for the atlas edge body, with an approximate convex-hull condition under
  each fixed marginal $P$.
- Try to prove or refute whether marginal-nonuniform weak realizable proper
  learning itself implies a $P$-dependent approximate barycentric neutralizer.
- Search for a fixed-marginal selector-hard construction where clean labels
  are erasure-decodable but noisy labels make even nonnegative proper
  correlation computationally hard.
- Test PCP active-slice gadgets with an explicit no-neutralizer condition:
  the hard slice must have inverse-polynomial mass, source clean learning must
  stay easy, and random/proper baseline assignments must fail the weak bound.

## Depth 3 Branch: neutralizer from weak realizable learner behavior

### Question

Can the fixed-marginal weak realizable proper learner itself be used to build
the barycentric neutralizer needed in the middle/high-OPT branch?

Use $\{\pm1\}$ notation. A randomized proper neutralizer under $P$ is a
distribution $\mu$ over legal hypotheses with barycenter
$$
g_\mu(x)=\mathbf E_{b\sim\mu} b(x)
$$
such that $\|g_\mu\|_{L^1(P)}$ is at most the target slack. Equivalently, for
every regression function $r:X\to[-1,1]$,
$$
\mathbf E_{b\sim\mu}\langle r,b\rangle_P \ge -\zeta .
$$
This is a strong uniform-in-labels property. It is not the same as saying that
the learner has some positive correlation on each realizable target.

### Constants Do Not Give A Black-Box Extraction

The first attempted extraction is to run the weak realizable learner on
constant labelings and average the outputs. This only works in the cases that
were already conditionally positive.

If both constants are legal concepts, then constants themselves are already a
proper neutralizer; the learner is unnecessary. If one or both constants are
not legal concepts, the source guarantee says nothing about the learner's
behavior on those labeled samples. A weak realizable learner may be redefined
arbitrarily on every non-realizable transcript without changing the source
property. Thus its outputs on illegal constant labels, random labels, or noisy
labels cannot be used as certified proper neutralizer material.

Even when the $+1$ constant is legal, the $-1$ constant may not be. Running the
learner on $+1$ labels only certifies an output with positive global bias. It
does not create an opposite-bias output, and it does not control the full
function-valued barycenter $g_\mu$ against nonconstant regressions $r$.

### Realizable Labels Also Do Not Force Balance

A second attempted extraction is to run the learner on many realizable label
rules $c\in\mathcal C$ and average its proper outputs. Abstractly, this gives
a transition kernel $K(c,\cdot)$ on $\mathcal C$ satisfying only
$$
\mathbf E_{h\sim K(c,\cdot)}\langle c,h\rangle_P \ge 2\gamma_P(s).
$$
This is a one-sided local correlation condition. It does not imply that the
image of any efficiently samplable input distribution has small barycenter.
In particular, the learner is allowed to collapse many, or all, targets onto a
single universal weak handle.

A concrete toy obstruction makes this explicit. Let $P(S)=1/2+2\gamma$ and
let every concept in $\mathcal C$ be identically $+1$ on $S$. Put any easy
properly learnable class on $X\setminus S$, and fix one legal concept $h_0$.
The algorithm that always outputs $h_0$ is a weak realizable proper learner:
for every target $c\in\mathcal C$, it makes mistakes only off $S$ in the worst
case, so
$$
\operatorname{err}_P(h_0,c)\le 1-P(S)=1/2-2\gamma .
$$
But no barycentric neutralizer exists under this marginal, because every
proper hypothesis is $+1$ on $S$. For every distribution $\mu$ over
$\mathcal C$,
$$
\|g_\mu\|_{L^1(P)}\ge P(S).
$$
Equivalently, the regression $r=-\mathbf 1_S$ separates the entire convex hull
of proper hypotheses from zero. The learner's behavior on constants,
self-labels, and realizable labels can be completely uninformative: it may
always return $h_0$.

This rules out a generic theorem of the form "any fixed-marginal weak
realizable proper learner yields a barycentric proper neutralizer from its
label behavior." Sometimes the neutralizer is absent altogether.

### Why This Is Not Yet A Counterexample To The Edge

The toy obstruction blocks neutralizer extraction, but it does not by itself
falsify the implication. The separating direction may be a common structural
bias of the whole class. If all concepts are $+1$ on $S$ and the agnostic
labels are mostly $-1$ on $S$, then the best proper concept also pays that
loss, so the loss is already included in
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$.

Thus absence of an absolute zero-barycenter is too crude. The real
middle/high-OPT problem is relative: given
$$
M(r)=\sup_{c\in\mathcal C}\langle r,c\rangle_P,
$$
the weak agnostic target only needs an efficiently found proper $h$ with
$$
\langle r,h\rangle_P \ge M(r)-1+2\alpha_P(s).
$$
A neutralizer with correlation near $0$ is a sufficient fallback when
$M(r)\le 1-4\alpha_P(s)$, but it is not necessary. Common biases, singleton
classes, and small exposed faces of the convex hull may make the target easy
even without a barycentric neutralizer.

So the sharpened obstruction is not merely "zero is outside the convex hull."
It is:

1. the low-noise coupling no longer applies;
2. the class has no efficiently accessible neutral fallback for the relevant
   marginal and size scale;
3. nevertheless $M(r)$ is large enough that arbitrary proper handles can fail
   the weak agnostic inequality;
4. finding any proper hypothesis above the threshold
   $M(r)-1+2\alpha_P(s)$ is computationally hard.

This is a proper selector obstruction, not just a convex-geometry obstruction.

### Failed Symmetrization Routes

Several natural symmetrizations all smuggle in extra assumptions.

Label-flip symmetrization would run the learner on both $Y$ and $-Y$ and
average the outputs. The flipped labels are realizable only when complements
are legal, and if complements are legal then a complement-pair neutralizer is
already available.

Random-label symmetrization asks the learner to behave sensibly on labels with
regression $0$. The source definition has no such requirement; all those
transcripts are outside the realizable promise.

Self-training symmetrization runs the learner on labels generated by previous
proper outputs. This stays inside the realizable promise, but it only explores
the directed graph of concepts reachable through positive-correlation
transitions. A universal weak handle is an absorbing state, so self-training
can preserve or amplify the barycenter rather than cancel it.

Sampling many target concepts would help only if there is already an efficient
balanced sampler over $\mathcal C$ and the learner's transition kernel does
not destroy balance. That is essentially the barycentric-neutralizer
hypothesis in different language, not a consequence of weak realizable
learning.

### Sharpened Takeaway

The fixed-marginal weak realizable learner supplies a way to obtain a proper
hypothesis correlated with a promised clean target. It does not supply:

- behavior guarantees on illegal constants, random labels, or noisy labels;
- a balanced distribution over legal targets;
- complement closure or label-flip symmetry;
- a guarantee that the learner's output distribution has small barycenter;
- an efficient selector among proper hypotheses on middle-noise labels.

Therefore the positive proof cannot be completed by extracting a barycentric
neutralizer from the learner's constants/labels behavior alone. Any full
resolution needs either an additional geometric condition on the proper class
or a selector theorem that is weaker than absolute neutralization but strong
enough for the agnostic threshold.

verdict: no generic neutralizer extraction; edge remains unresolved
confidence: medium-high for the no-extraction claim, medium for the exact
selector obstruction
next branches:
- Depth 4A: formalize the toy obstruction as a black-box separation. Show
  that for any proposed extractor using a weak learner's behavior on constants,
  random labels, self-labels, or realizable labels, there is a source-positive
  learner/class where the extractor sees only a universal weak handle and no
  barycentric neutralizer exists.
- Depth 4B: replace absolute neutralizers by relative selector conditions.
  Work with $M(r)=\sup_{c\in\mathcal C}\langle r,c\rangle_P$ and characterize
  when efficient access to concepts above $M(r)-1+2\alpha$ follows from clean
  weak learning plus validation.
- Depth 4C: search for a fixed-marginal selector-hard residual construction:
  an easy common block gives clean weak realizable proper learning, while a
  medium-mass residual block makes every successful middle-OPT proper output
  decode a hard witness and gives no neutral wrong hypotheses.
- Depth 4D: test whether exposed-face geometry can make the edge positive in
  more cases. If the face of $\operatorname{conv}(\mathcal C)$ relevant to
  each middle-noise $r$ has an efficiently samplable relative barycenter, then
  the lack of an absolute zero-barycenter may be harmless.

## Depth 5 Branch: same-marginal proper weak agnostic conversion

- depth: 5
- verdict: unresolved-open
- confidence: medium-high

### Goal And Correlation Form

The assigned edge asks for a theorem or a counterexample at exactly the
same-marginal, weak, proper interface:

$$
\text{efficient marginal-nonuniform weak realizable proper}
\Rightarrow
\text{efficient marginal-nonuniform weak agnostic proper}.
$$

Use $\{\pm 1\}$ labels in this pass. For a joint distribution with marginal
$P$, write

$$
r(x)=\mathbf E[Y\mid X=x],
\qquad
M(r)=\sup_{c\in\mathcal C}\langle r,c\rangle_P .
$$

The target inequality

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha
$$

is equivalent to

$$
\langle r,h\rangle_P \ge M(r)-1+2\alpha .
$$

This translation is useful because it shows how weak the agnostic target is.
If $M(r)\le 1-2\alpha$, the required correlation threshold is nonpositive.
Only the near-realizable regime $M(r)>1-2\alpha$ asks for positive correlation
with the best concept. However, a proper learner still has to avoid outputting
a legal hypothesis that is substantially anti-correlated with the labels.
That is the whole difficulty left after the improper constant-neutralizer
proof.

### Same-Marginal Low-Noise Robustification Is Maxed Out

Fix a marginal $P$ and a size parameter $s$. Let the source learner's
constant-confidence invocation use at most $m_P(s)$ examples and have clean
weak advantage $\gamma_P(s)$. If

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta
$$

is below a small multiple of $1/m_P(s)$, the previous coupling proof is
already the right proof. Choose a near-optimal $c^\star\in\mathcal C$, run the
source learner on noisy examples, and couple this execution to the clean
execution on $(X,c^\star(X))$ using the same $P$-distributed instance sequence
and the same internal randomness. With constant probability no inspected label
is corrupted. On that event the transcript is a legal realizable transcript
under the original marginal $P$, so the source guarantee returns a proper
$h\in\mathcal C$ satisfying

$$
\langle c^\star,h\rangle_P \ge 2\gamma_P(s).
$$

Validation then gives

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+1/2-\Omega(\gamma_P(s)).
$$

This proof cannot be pushed much further without a new idea. If
$m_P(s)\eta$ is superlogarithmic, the all-clean transcript event has
superpolynomially small probability. Conditioning on a clean transcript is
also not acceptable in the marginal-nonuniform setting unless one uses the
coupling form above, because conditioning changes the instance marginal. Thus
the only robust low-noise theorem available from the source alone is the
transcript-scale theorem: choose the target gap $\alpha_P(s)$ below both
$\gamma_P(s)$ and about $1/m_P(s)$, and handle $\eta\lesssim \alpha_P(s)$ by
coupling.

The important negative point is narrower than "noise breaks the learner." It
is:

1. for $\eta\gg 1/m_P(s)$, clean-transcript repetition is no longer a
   polynomial-time route;
2. the source hypothesis says nothing about the learner's behavior on noisy or
   inconsistent samples;
3. the target may still reject badly anti-correlated proper outputs, even when
   it does not require finding $c^\star$ with positive correlation.

So the low-noise proof settles the near-realizable end of the edge but does
not itself produce a middle-noise proper fallback.

### Conditional Positive Theorem With Legal Neutralizers

The following condition is sufficient and seems to be the right abstraction of
the missing high/middle-noise branch.

For each fixed marginal $P$ and size $s$, suppose there is one uniform
polynomial-time procedure, with $P$-dependent polynomial resource bound, that
produces a validation-searchable finite list

$$
N_{P,s}\subseteq \mathcal C
$$

such that for every label regression $r$ with $M(r)\le 1-2\alpha_P(s)$, some
$b\in N_{P,s}$ satisfies

$$
\langle r,b\rangle_P\ge 0 .
$$

Then the edge is true for that class. Run the low-noise coupled wrapper and
also validate the proper neutralizer list. If $\eta<\alpha_P(s)$, the
low-noise branch supplies a good proper hypothesis. If
$\eta\ge \alpha_P(s)$, then $M(r)\le 1-2\alpha_P(s)$, so the neutralizer list
contains $b$ with nonnegative correlation, hence

$$
\operatorname{err}_{\mathcal D}(b)\le 1/2
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s).
$$

This captures several genuine positive cases:

- both constants are legal proper hypotheses;
- some legal $b$ and its complement $\bar b$ are both in $\mathcal C$;
- there is an efficiently samplable $P$-balanced distribution over proper
  concepts whose barycenter is $0$;
- there is a fixed-$P$ proper ERM or weak selector strong enough to find a
  concept with nonnegative empirical correlation whenever one exists.

Halfspaces fall into this benign zone because standard halfspace classes have
legal constants. Many handle-augmented constructions also fall into it because
the handles added to make weak realizable learning easy tend to become legal
agnostic neutralizers after validation.

### Why The Source Does Not Seem To Extract A Neutralizer

I tried to force such a legal neutralizer from the weak realizable proper
source itself. The attempts still smuggle in extra structure.

**Known-anchor extraction.** If one knows and can label by some
$a\in\mathcal C$, the source learner can be run on realizable samples from
$a$. The resulting proper concept is positively correlated with $a$, but this
does not make it neutral for arbitrary labels. If the agnostic comparator
$c^\star$ is almost the complement of $a$ under $P$, this anchor output can be
almost maximally anti-correlated with the labels.

**Two-anchor extraction.** Running on both $a$ and $\bar a$ would solve the
previous problem by validation, but $\bar a$ need not be legal. This is exactly
complement closure, not a consequence of the source.

**Random-label extraction.** Running the learner on random labels, flipped
agnostic labels, or labels drawn from a balanced coin asks the learner to do
something outside its realizable promise. The source definition permits
arbitrary behavior there.

**Self-labeling extraction.** Running the learner on labels produced by its own
proper outputs keeps all calls realizable, but it only explores a transition
kernel on $\mathcal C$ that preserves positive correlation with the current
state. There is no reason for the orbit or stationary distribution to have
zero barycenter. A class can have a universal weak handle that attracts these
calls without producing any balanced pair.

Thus the source supplies positive-correlation access to promised clean
targets, not a balanced proper sampler, not legal constants, and not a
correlation-zero fallback.

### Stress Test: What A Marginal-Specific Proper Counterexample Must Do

An atlas-ready false witness would need all of the following at once.

1. **Clean weak proper learning under every marginal.** The class must remain
   efficiently weakly realizably properly learnable even when the marginal
   isolates the part of the domain intended to carry the hard instance.
2. **One fixed hard marginal for agnostic labels.** The agnostic lower bound
   must use a single marginal $P$, because the target may attach its own
   polynomial and weak gap to each marginal.
3. **No legal neutralizer.** Constants, complement pairs, balanced handles, or
   validation-searchable nonnegative-correlation lists would make the positive
   wrapper work.
4. **Wrong-output usefulness.** For the hard label regression $r$, every
   efficiently findable wrong proper hypothesis must have
   $\langle r,h\rangle_P < M(r)-1+2\alpha_P(s)$, not merely fail to be close to
   optimal. Ordinary strong agnostic hardness does not imply this weak
   no-neutral-output statement.
5. **Polynomial noise window.** The hard labels must have
   $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$ above the clean
   transcript scale but still in a range where the weak agnostic threshold
   excludes the easy proper outputs.

This combination is much sharper than standard agnostic hardness.

### Counterexample Attempts Rechecked

**Parities and LPN.** Parities under the uniform marginal are cleanly and
properly learnable by Gaussian elimination, and noisy parity gives a natural
fixed-marginal hardness intuition. But the weak additive target is too weak.
If the noise is below the chosen $\alpha_P(s)$, clean-sample coupling applies
by taking $\alpha_P(s)$ below the inverse sample bound. If the noise is well
above $\alpha_P(s)$, a wrong parity has correlation $0$ with the target parity
under the uniform marginal, which usually satisfies the nonpositive agnostic
threshold. LPN hardness is about identifying the best parity, while this edge
often only asks for avoiding an anti-correlated parity.

**Large anti-code families.** A tempting repair is to replace parities by a
code where every wrong proper concept is anti-correlated with the target. Under
a fixed binary marginal this runs into the Plotkin/list-decoding barrier
already noted in the atlas: one cannot have an exponentially large family of
binary concepts with all wrong concepts at distance $>1/2+\tau$ from each
target for inverse-polynomial $\tau$. Approximate variants leave residual
neutral correlations, and those residual correlations are enough for a weak
marginal-nonuniform target whose gap can shrink with $P$.

**Conjunction-style agnostic hardness.** Conjunctions are a classical
realizable-proper-positive and agnostic-proper-hard class. This does not settle
the present edge. The known hardness is distribution-free or strong-excess in
flavor; it does not isolate one fixed marginal and prove that even a weak
proper output above $M(r)-1+2\alpha_P(s)$ is hard. Depending on the exact
conjunction convention, constants or simple biased conjunctions can also act
as high-noise neutralizers.

**Halfspaces and Tiegel.** Tiegel's halfspace results are strong evidence
against stronger agnostic nodes, but they do not refute this weak
marginal-nonuniform proper edge. Standard halfspace classes contain constants,
so the legal-neutralizer theorem gives the weak marginal target once the
low-noise branch is included. The fixed Gaussian lower bound is a strong
agnostic lower bound, not a no-legal-neutralizer lower bound for the atlas's
fixed additive weak target.

**FGRW/PCP active slices.** FGRW-style weak agnostic hardness and PCP
dictatorship tests have the right "weak no advantage" flavor, but the hard
instance normally changes the example marginal. Packing all instances into one
fixed marginal dilutes each active slice, and a marginal-nonuniform learner may
choose a polynomial and weak gap adapted to that packed marginal. A successful
packing would need the wrong-output-usefulness gadget above: every weakly
acceptable proper output under the global marginal must decode the active hard
witness.

**One-way image-coordinate handles.** The one-way image-coordinate family is
the closest structural template because it already separates weak proper from
strong proper behavior under fixed coordinate marginals. But the handles that
make weak realizable proper learning easy also tend to provide legal weak
agnostic fallbacks. Removing the handles threatens the source; adding enough
handles for every marginal tends to restore neutralizers. The missing gadget
would need handles that are useful on clean labels but become unusable under a
medium-noise residual distribution without giving validation a neutral proper
candidate.

### A More Precise Obstruction For Depth 6

The unresolved core is a fixed-marginal **proper weak selector** problem.
Given samples from $r$, can clean weak proper learnability under the same
$P$ force an efficient procedure that finds

$$
h\in\mathcal C
\quad\text{with}\quad
\langle r,h\rangle_P \ge M(r)-1+2\alpha_P(s)?
$$

The low-noise branch answers yes when $M(r)$ is extremely close to $1$.
Legal neutralizers answer yes when the threshold is nonpositive. The gap is
not a geometric existence gap, since the best concept itself exists; it is an
efficient proper selection gap in the presence of weakly admissible but
possibly anti-correlated legal outputs.

I do not see a theorem deriving this selector from the source assumption, and
I also do not have a concrete marginal-specific class proving it impossible.
The edge should therefore remain open.

### Depth 5 Verdict

verdict: unresolved-open

The edge is true under legal constants, complement-pair anchors, balanced
proper samplers, or fixed-marginal proper weak selectors. The same-marginal
low-noise robustification is proper and solid, but it only handles the
transcript-scale near-realizable regime. No generic legal neutralizer can be
extracted from weak realizable proper learning by anchor, label-flip,
random-label, or self-labeling tricks. Current counterexample templates
remain near misses because they either vary the hard marginal, prove strong
rather than weak hardness, contain legal constants/handles, or fail the
fixed-marginal anti-code geometry needed to make every wrong proper output
useless.

### Obstacles

- The source guarantee is realizable-only and says nothing about noisy
  transcripts once the all-clean event is superpolynomially unlikely.
- Proper high-noise neutralizers are not part of the definition; constants are
  an improper crutch unless they lie in $\mathcal C$.
- Weak agnostic success often requires only nonnegative or mildly negative
  correlation, so standard noisy-identification hardness such as LPN is too
  strong a target and too weak a lower bound.
- A fixed-marginal false witness must defeat all legal handles while keeping
  clean weak proper learning under every marginal, including marginals
  concentrated on the hard residual block.
- Large families whose wrong hypotheses are all anti-correlated with the
  target are blocked by Plotkin/list-decoding-type geometry unless the
  hardness is computational rather than purely metric.

### Next Directions For Depth 6

- Formalize the conditional legal-neutralizer theorem as an atlas argument
  candidate, separate from this open edge.
- Try to prove a weaker selector theorem using only empirical validation and
  the source learner on carefully chosen realizable self-labels; the target
  threshold is $M(r)-1+2\alpha$, not $M(r)-\varepsilon$.
- Build a residual-block witness with three parts: easy clean weak handles,
  a noisy residual that requires decoding, and a proof that all handles become
  anti-correlated rather than neutral under the hard residual labels.
- Revisit conjunction agnostic hardness under one fixed marginal and ask for a
  weak no-neutral-output statement, not a strong excess-error statement.
- Search for a computational anti-code construction: neutral proper concepts
  may exist by geometry, but finding any one with nonnegative correlation
  should be as hard as decoding the hidden witness.

## Depth 6 Branch: final neutralizer/selector pass

- depth: 6
- verdict: unresolved-final
- confidence: high that current atlas evidence does not resolve the edge;
  medium-high that the obstruction is exactly a proper weak selector/neutralizer
  obstruction.

### Last Attempted Positive Route: Extract The Legal Neutralizer

The depth-5 conditional theorem says that the edge would be true if the class
had a fixed-marginal legal neutralizer/selector. In correlation notation, the
needed middle-noise object is a $P$-polynomial procedure producing a
validation-searchable proper list $N_{P,s}\subseteq\mathcal C_s$ such that,
whenever

$$
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P\le 1-2\alpha_P(s),
$$

some $b\in N_{P,s}$ has

$$
\langle r,b\rangle_P\ge 0
$$

or at least $\ge -o(\alpha_P(s))$. Low-noise coupling handles
$M(r)>1-2\alpha_P(s)$ at the transcript scale; this neutralizer would handle
the complement.

I tried one final time to derive this list from the weak realizable proper
learner. The derivation still fails for a structural, not merely technical,
reason. The realizable source supplies, for each clean target $c$, a procedure
whose output kernel $K(c,\cdot)$ satisfies only

$$
\mathbf E_{h\sim K(c,\cdot)}\langle c,h\rangle_P\ge 2\gamma_P(s).
$$

This one-sided promise has no force on:

- illegal constant labels;
- random or agnostic labels;
- labels flipped from a legal concept when complements are not legal;
- the barycenter of outputs over many clean targets;
- the behavior of the learner on inconsistent transcripts.

Self-labeling does not repair the issue. If the learner has a universal weak
handle $h_0$, all realizable calls may collapse toward $h_0$ while still
satisfying the source guarantee. That produces a positively correlated
absorbing state, not a balanced sampler. Thus the source learner is an oracle
for promised clean positive correlation, not an oracle for the center of
$\operatorname{conv}(\mathcal C)$ or for nonnegative correlation with an
arbitrary regression $r$.

The strongest black-box statement I can justify is negative:

> Weak realizable proper learning does not by itself certify a legal proper
> neutralizer. Any extraction that relies only on the learner's observable
> behavior on clean/self-labeled targets can be defeated by a source-positive
> class whose learner always returns a universal weak handle.

This does not refute the edge, because the agnostic target is relative to
$M(r)$, not to the absolute zero function. A class can lack an absolute
barycentric neutralizer and still be weak agnostically learnable because the
common bias is already charged to $\operatorname{OPT}_{\mathcal C}$. The
missing theorem would have to be a **relative** selector theorem, not a pure
convex-hull neutralizer theorem.

### Last Attempted Negative Route: Residual-Block Witness

The most plausible counterexample shape is a residual-block class:

1. a common block or easy handle block makes clean weak realizable proper
   learning easy under many marginals;
2. a residual block carries a noisy hard selector problem;
3. under one fixed hard marginal, every proper output satisfying the weak
   agnostic threshold must solve the residual selector;
4. constants, complements, balanced handles, and wrong residual hypotheses are
   either absent or provably below the weak threshold.

This template still collapses in both directions.

If the common/easy block has enough mass to make a universal handle a clean
weak learner, then agnostic labels that oppose this handle also increase
$\operatorname{OPT}_{\mathcal C}$, because every legal comparator pays the
same common-block loss. The weak agnostic threshold

$$
\langle r,h\rangle_P\ge M(r)-1+2\alpha_P(s)
$$

falls together with $M(r)$, and the allegedly bad handle often becomes legal
again. Common bias is not a separator; it is part of the comparator geometry.

If the hard residual block has enough mass that wrong handles should fail,
then the source quantification over all marginals becomes dangerous. The
source learner must also weakly properly learn clean labels under marginals
concentrated on that residual block. For parities, this is true cleanly, but
wrong parities are neutral under the fixed uniform marginal, so noisy parity
hardness asks for more recovery than the weak agnostic target requires. For
PRF/code blocks, wrong hypotheses are again typically neutral up to residual
inverse-polynomial correlations.

Trying to make all wrong residual hypotheses anti-correlated by an
inverse-polynomial margin runs into the Plotkin/Gram barrier: an exponential
hard family cannot be pairwise beyond distance $1/2+\tau$ under one fixed
binary marginal for inverse-polynomial $\tau$. Pure metric anti-codes are too
small, and approximate anti-codes leave neutral or mildly correlated wrong
hypotheses that the weak target may accept.

The only remaining negative route is computational rather than geometric:
neutral or nonnegative proper hypotheses may exist, but finding any such
hypothesis should decode the hard witness. I do not know an atlas-ready class
with this property. The existing one-way image-coordinate weak-handle witness
goes the other way: the handles added to make weak proper learning easy are
also legal weak agnostic fallbacks after validation. Removing them breaks the
source; keeping them breaks the separation.

### Final Synthesis For Atlas Incorporation

The edge should remain `open`.

The proved/near-proved positive part is:

- **Low-noise branch.** For each fixed marginal $P$, couple the noisy run to a
  clean realizable run on the same original $P$-distributed instance sequence.
  If $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the inverse of the
  $P$-specific sample bound, the realizable proper learner's output is already
  a valid proper weak agnostic candidate.
- **Legal-neutralizer branch.** If the class has legal constants,
  complement-pair anchors, an efficiently samplable $P$-balanced proper
  ensemble, or any validation-searchable fixed-$P$ proper neutralizer/selector,
  then the implication is true by adding those candidates to the low-noise
  wrapper.

The precise obstruction is:

> Clean weak realizable proper learning gives positive-correlation access to
> promised clean concepts, but it does not give a legal proper hypothesis that
> is nonnegative-correlated with arbitrary middle-noise labels, nor an
> efficient selector for a concept above the threshold
> $M(r)-1+2\alpha_P(s)$.

The near-miss negative results are:

- LPN/parity gives fixed-marginal noisy-selector hardness, but wrong parities
  are neutral and therefore often weak-agnostically acceptable.
- Halfspace/Tiegel and FGRW/PCP hardness are too strong or too
  distribution-varying for this marginal-nonuniform weak target; standard
  halfspaces also have legal constant neutralizers.
- One-way image-coordinate weak-handle classes separate nearby strong proper
  targets, but their handles supply the legal weak agnostic fallback here.
- Residual-block PRF/code attempts either let common losses lower the target
  threshold, leak neutral wrong hypotheses, or violate the source requirement
  on marginals concentrated on the residual block.
- Pure anti-code geometry cannot make exponentially many wrong proper
  hypotheses all inverse-polynomially anti-correlated under one fixed binary
  marginal.

The concrete missing lemma, in positive form, is:

> **Fixed-marginal proper weak selector lemma.** Let $\mathcal C$ be
> efficiently marginal-nonuniform weak realizably properly learnable. For every
> marginal $P$ and size $s$, there is a $P$-polynomial algorithm which, from
> samples with regression $r$, outputs $h\in\mathcal C_s$ satisfying
> $$
> \langle r,h\rangle_P\ge
> \sup_{c\in\mathcal C_s}\langle r,c\rangle_P-1+2\alpha_P(s)
> $$
> for some inverse-polynomial $\alpha_P(s)$.

This lemma is essentially the open edge. The useful restricted version replaces
the conclusion by the legal-neutralizer condition for the case
$M(r)\le 1-2\alpha_P(s)$; that restricted version is a good atlas lemma when
stated as an additional hypothesis, not as a consequence of the source node.

The concrete missing lemma, in negative form, is:

> **Fixed-marginal no-neutral-output residual witness.** Construct a single
> proper class and fixed marginal $P$ such that clean labels are weakly
> properly learnable under every marginal, but for a family of noisy residual
> regressions $r_z$ with polynomially small
> $\operatorname{OPT}_{\mathcal C}$, every polynomial-time proper output above
> $M(r_z)-1+2/\operatorname{poly}(s)$ decodes $z$; moreover all legal handles
> that make the clean source true are below this weak threshold.

No existing atlas witness proves this.

Recommended atlas treatment:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
summary: "Open: same-marginal low-noise coupling gives a proper weak agnostic learner below the transcript-noise scale, and legal proper neutralizers/selectors would finish the middle-noise branch; weak realizable proper learning alone does not seem to extract such a neutralizer, while current residual-block, parity/LPN, PCP, halfspace, and one-way-handle witnesses all leak neutral proper outputs or miss the fixed-marginal weak threshold."
```

If the atlas gets a finer family taxonomy, this edge belongs in a subfamily
such as `proper-weak-selector-open` or
`proper-neutralizer-selector-open`, under the broader
`marginal-agnostic-hardness-open` umbrella.
