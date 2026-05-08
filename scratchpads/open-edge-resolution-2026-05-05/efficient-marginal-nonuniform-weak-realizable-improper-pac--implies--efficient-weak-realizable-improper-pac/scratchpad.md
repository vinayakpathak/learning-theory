# Edge: efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-improper-pac`
- target: `efficient-weak-realizable-improper-pac`
- verdict: unresolved-open
- confidence: 0.84
- worker constraint: scratchpad only; no atlas files edited

## Executive Verdict

I do not see an atlas-ready proof or counterexample. The edge should remain
`open`, but its explanation should be sharpened.

The current edge note says the source has marginal-dependent polynomial bounds
while the target needs one distribution-free polynomial bound. Under the atlas
worst-case/pathwise transcript convention, that is no longer the main issue:
the full-support reference-marginal argument can uniformize the sample/time
bound of the single source learner.

The live obstruction is the hidden weak gap. The source gives

$$
\forall P\ \exists k(P):\quad
\operatorname{err}_P(A,c)\le 1/2-s^{-k(P)}
$$

up to polynomial factors and harmless small-size changes. The target needs one
exponent independent of the marginal:

$$
\exists k\ \forall P:\quad
\operatorname{err}_P(B,c)\le 1/2-s^{-k}.
$$

No checked argument justifies this quantifier swap, and no checked PRF or
rare-block construction gives a clean separation while still satisfying the
source for every marginal.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/sample-efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/sample-efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--sample-efficient-weak-realizable-improper-pac.md`
- `atlas/implications/sample-efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--sample-efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

Neighboring scratchpads checked:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac/scratchpad.md`

Primary-source anchors through atlas references:

- Benedek and Itai 1991, fixed-distribution learnability.
- Ben-David, Benedek, and Mansour 1995, PAC uniformity parameters.
- Hanneke, Moran, and Thiessen 2025, marginal-nonuniform PAC learnability.
- Valiant 1984 and Blumer et al. 1989, VC/sample-complexity background.
- Goldreich, Goldwasser, and Micali 1986 plus Kearns and Valiant 1994, PRF
  learning hardness background.

## Current Edge State

The atlas edge currently records:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

The status still looks right. The summary is stale: the obstacle is no longer
just the resource polynomial.

## Definition-Level Reduction

Let $A$ be the single learner promised by the source. For every marginal $P$,
there are a $P$-dependent polynomial resource bound and a $P$-dependent weak
advantage $\gamma_P(s)$ such that, for every target $c\in\mathcal C$,

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
\qquad
1/\gamma_P(s)\le \operatorname{poly}_P(s).
$$

The target asks for an efficient distribution-free weak learner. In the atlas
weak-realizable convention, that means one inverse-polynomial advantage lower
bound independent of $P$.

Thus the exact question is:

> Does a single uniform polynomial-time learner with marginal-specific
> inverse-polynomial weak advantages necessarily imply some efficient learner
> with one distribution-free inverse-polynomial weak advantage?

## Full-Support Resource Uniformization

This part works.

Choose a reference marginal $P^\star$ with full support on every finitely
encoded instance in each representation-size slice. Applying the source
guarantee to $P^\star$ gives a polynomial $p_{P^\star}$ bounding the source
learner's sample use and running time.

Every finite labeled transcript that can arise under any marginal $P$ and
target $c$ also has positive probability under $P^\star$ with the same target
labels on the sampled instances. Since the atlas treats efficient PAC
resources as worst-case/pathwise bounds on finite transcripts, $A$ cannot run
longer than $p_{P^\star}$ on that transcript. Otherwise the source guarantee
would fail for $P^\star$.

So the source learner can be viewed as a distribution-free polynomial-time
procedure. Accuracy, however, still comes from the actual marginal $P$, not
from $P^\star$. The argument yields

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s),
$$

not a marginal-independent $\gamma(s)$.

## Hidden Weak-Gap Uniformization Attempt

The missing theorem would be

$$
\forall P\ \exists k(P):\gamma_P(s)\ge s^{-k(P)}
\quad\Longrightarrow\quad
\exists k\ \forall P:\gamma_P(s)\ge s^{-k}.
$$

I do not see a valid proof under the current global-marginal semantics.

### Fixed-Size Compactness

After full-support resource uniformization, the learner has bounded finite
transcripts at each representation size. If each size slice is finite, one can
hope that the worst weak gap over all marginals at a fixed size is positive.
That still gives no polynomial rate in $s$.

A toy envelope captures the problem. For parameters $j\in\mathbb N$ define
$f_s(j)=s^{-j}$, and add a limit point with $f_s(\infty)=s^{-1}$. Every fixed
parameter has an inverse-polynomial lower bound in $s$, but

$$
\inf_j f_s(j)=s^{-s}
$$

when the minimizing parameter is allowed to move with $s$. This is the same
quantifier pattern as a marginal-dependent exponent.

### Diagonal Stitching

If marginal-nonuniform PAC were interpreted as a size-indexed family
$P=(P_s)_s$ with risk evaluated conditionally on the active size slice, then a
diagonal proof might work. One could choose bad marginals $P_s$ whose gaps are
superpolynomially small at size $s$, stitch them into one marginal family, and
contradict the source guarantee for that single family.

The current atlas reading is a single global marginal over encoded instances.
Stitching bad slices into one global distribution assigns weights $w_s$ to
the bad components. A weak additive guarantee can ignore sufficiently low-mass
components, so bad conditional behavior on slice $s$ need not violate the
source guarantee for the mixture.

Full-support uniformization uses rare transcripts to control resources because
resources are pathwise. Accuracy is not pathwise; it is averaged under the
actual marginal.

### Validation Or Boosting

Validation does not create a weak gap. To distinguish error
$1/2-\gamma$ from $1/2$ by holdout testing requires about $1/\gamma^2$
samples. If the hidden $\gamma_P(s)$ has exponent $k(P)$, this may be a
$P$-dependent polynomial degree.

Boosting is not formally needed for this edge, since the target is already
weak. If one tries to amplify a tiny $\gamma_P$ anyway, standard boosting
inherits polynomial dependence on $1/\gamma_P$ and therefore does not produce
one distribution-free polynomial bound.

The sample-only route also stops at the resource boundary. The source implies
the sample-efficient distribution-free weak node by the marginal-nonuniform
trichotomy and VC theory, but that proof uses unrestricted ERM. PRF classes in
the atlas are exactly the warning that sample-efficient weak learning need not
be computationally efficient.

## Rare-Block And PRF Counterexample Audit

A false witness would need all of the following:

1. A single source learner with one pathwise polynomial sample/time bound after
   full-support resource uniformization.
2. For every fixed marginal $P$, a weak advantage at least $s^{-k(P)}$.
3. No efficient distribution-free learner with any fixed inverse-polynomial
   advantage $s^{-k}$.
4. An improper lower bound: proper-representation hardness is irrelevant here.

### Plain PRF Blocks Fail The Source

Standard PRF concept classes give the right target hardness flavor. Under the
uniform hard marginal, a polynomial-time learner with nonnegligible weak
advantage would distinguish a PRF from a truly random function.

But plain PRF classes also fail the source. The marginal concentrated on the
hard PRF domain is one of the marginals quantified over by the
marginal-nonuniform source, and no efficient weak learner is known there under
standard PRF assumptions.

### Rare Hard Blocks Alone Are Not Enough

One can try a hierarchy of blocks $B_k$ where block $k$ is hard to learn with
advantage better than $s^{-k}$. A marginal concentrated on $B_k$ would be
allowed to have exponent $k$, while a distribution-free target with exponent
$d$ would fail on $B_k$ for $k\gg d$.

The resource side forbids the simplest version. The source learner cannot
spend $s^k$ samples or time on block $k$ for unbounded $k$, because a
full-support reference marginal would expose those finite transcripts and
force one global polynomial bound. Any valid hierarchy must be a pure
weak-gap hierarchy, not a hidden runtime hierarchy.

### Memorization Plus PRF Residual: Near Miss

The strongest negative template I found is this.

For a level $k$, use a PRF-labeled active block of size about $n^k$, with
concepts defaulting to $0$ off their active block. A fixed-polynomial
memorization learner can store the labels of $n^a$ sampled active points. On
the uniform active-block marginal this gives advantage about

$$
n^a/n^k=n^{-(k-a)}.
$$

For each fixed $k$, that is inverse-polynomial. For any proposed
distribution-free weak exponent $d$, choosing $k\gg d$ should force a learner
to predict unseen PRF labels, which PRF security should rule out.

This captures the desired hidden-gap geometry. It is not atlas-ready because
of an orientation problem.

If the active-label mass is slightly above $1/2$, defaulting to $0$ can be
worse than random guessing unless the learner switches to default $1$. If it
is slightly below $1/2$, the reverse is true. The necessary orientation can be
separated from $1/2$ by only the same hidden scale $n^{-(k-a)}$. Estimating
that sign by validation costs roughly $n^{2(k-a)}$ samples, which reintroduces
the forbidden level-dependent resource exponent.

A prediction-time randomized hypothesis would fix this near miss: memorize
seen labels and predict an unbiased coin on unseen points, gaining exactly on
the memorized mass without choosing a default orientation. The atlas notes
currently use ordinary binary hypotheses and zero-one error, not
prediction-time randomized classifiers. A deterministic pseudorandom default
does not obviously help, because its accidental correlation with the target on
the unseen region can be larger than the tiny memorization advantage.

### Public Handles Leak To The Target

Another attempted repair is to add public weak handles at level $k$ with
advantage $s^{-k}$. This can make the source easy with uniform resources. But
if the handle is public and efficiently findable from samples, a
distribution-free target learner can use the same handle. If the handle is not
reliable under arbitrary marginals, the source fails on marginals
concentrated where the handle points the wrong way.

This is the same obstacle that appears in the one-way image-coordinate
weak-handle notes: handles can certify weak learning, but if the target is
also improper and weak, the handles tend to be legal or reproducible for the
target as well.

## Proposed Atlas Posture

No atlas status change is justified by this pass. I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-uniformization-open
```

But I would update the edge summary/body to say:

```yaml
summary: "Open: full-support marginal uniformization gives one pathwise sample/time polynomial for the single source learner, but the source weak realizable advantage may still have marginal-dependent polynomial degree; no known theorem turns those marginal-specific weak gaps into one distribution-free inverse-polynomial gap."
```

Suggested body replacement:

```markdown
## Verdict

`open`.

Full-support marginal uniformization handles the resource part under the atlas
worst-case transcript convention. Let `A` be the single marginal-nonuniform
weak learner and choose a full-support reference marginal `P^star`. The source
guarantee at `P^star` gives one polynomial bound on every finite transcript
that can arise under any marginal.

The accuracy guarantee must still be applied to the actual marginal `P`.
There it gives only `err_P(h,c) <= 1/2 - gamma_P(s)`, where the
inverse-polynomial lower bound on `gamma_P` may depend on `P`. The
distribution-free weak target needs one inverse-polynomial gap independent of
`P`.

No current compactness, diagonal stitching, validation, boosting, or
sample-complexity argument yields that weak-gap uniformization under the
global-marginal semantics. Conversely, PRF and rare-block counterexample
templates either fail the marginal-nonuniform source, rely on hidden
level-dependent resources, leak public weak handles to the target, or require
prediction-time randomized hypotheses.
```

## Next Directions

1. Introduce a sharper `weak-gap-uniformization-open` argument family, or
   update `marginal-uniformization-open` so this edge is not described as a
   pure resource-polynomial problem.
2. Decide whether the atlas should keep global-marginal semantics or move
   marginal-nonuniform weak notions to size-indexed, slice-conditional
   marginals. Under the latter, the diagonal weak-gap proof becomes much more
   plausible.
3. Formalize the PRF memorization near miss. It may become a clean
   relativized or randomized-hypothesis separation, and it pinpoints the exact
   deterministic orientation bottleneck.
4. Search for an orientation-free deterministic weak-gap hierarchy: one
   uniform pathwise-polynomial learner should obtain level-dependent
   inverse-polynomial gaps for every marginal, while PRF-style residuals rule
   out every fixed distribution-free weak exponent.

## Bottom Line

The edge is still open. Full-support resource uniformization removes the old
runtime objection, but it leaves the central question:

$$
\forall P\ \exists k(P)
\quad\text{versus}\quad
\exists k\ \forall P.
$$

The checked proof routes do not bridge that gap, and the checked rare-block
and PRF routes do not yet realize it as a valid separation under the current
atlas definitions.

## Depth 2 Followup: Paired Rare-Block PRF Weak-Target Audit

- depth: 2
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

### Question For This Pass

The first pass left two live possibilities:

1. A theorem route: full-support transcript uniformization plus compactness or
   diagonalization might turn marginal-dependent weak gaps into one
   distribution-free weak gap.
2. A false-witness route: a rare-block or PRF construction might satisfy the
   marginal-nonuniform weak source while failing the weaker distribution-free
   weak target.

The sharper depth-2 question is whether the earlier PRF orientation problem is
intrinsic, or only an artifact of using one unpaired active block.

### Depth 2 Verdict

The theorem route still does not work under the current global-marginal atlas
semantics. A conditional false-witness route now looks plausible: use paired
active blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

and label exactly one point in each pair by a PRF bit:

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u).
$$

All other blocks are labeled $0$. Take
$j\le \lfloor n/(4\log n)\rfloor$ so that $U_{n,j}$ can be a subset of
$\{0,1\}^n$ while still allowing arbitrarily large constant levels $j$.
For fixed $j$, the representation size is $s=\Theta(n)$.

This paired version removes the orientation bottleneck from the first pass.
On the hard marginal uniform over $B_{n,j}$, the target labels are exactly
balanced, so constants have error exactly $1/2$. A sample-found positive
singleton has advantage about $1/(2n^j)$, which is enough for a
marginal-dependent weak source but too small for any fixed distribution-free
inverse-polynomial gap once $j$ is chosen above the alleged target exponent
and sample/runtime degree.

### Source Positivity

Goal: show efficient marginal-nonuniform weak realizable improper PAC
learning for the paired-block class.

Use one uniform learner that stages over sample sizes and candidate margins.
At each stage it builds the candidates

$$
0,\quad 1,\quad h_x=\mathbf 1[\cdot=x]
$$

for every observed positive example $x$, and uses fresh validation data to
choose a candidate whose empirical error is below $1/2$ by the current guessed
margin.

Fix a marginal $R$ and a target with active block $B$. Let

$$
M=R(\{x:c(x)=1\}).
$$

If $R(B)\le 1/3$, then $M\le 1/3$ and the all-zero hypothesis has constant
advantage. Thus only $R$-heavy blocks, say those with $R(B)>1/3$, need special
attention. There are at most two such blocks, hence finitely many.

For one such finite block, write $N=n^j$. If
$M\le 1/2-\Theta(1/N)$, the all-zero hypothesis is weak. If
$M\ge 1/2+\Theta(1/N)$, the all-one hypothesis is weak. In the remaining
window, $M$ is near $1/2$, and among the at most $N$ positive atoms in the
active block there is a positive atom of mass at least $M/N=\Omega(1/N)$.
The singleton on such an atom has error

$$
M-R(\{x\})\le 1/2-\Omega(1/N).
$$

Sampling for $O(N)$ rounds, with logarithmic confidence factors, sees a
sufficiently heavy positive atom with high probability; validation then finds
one of the constants or a singleton. Since a fixed marginal $R$ has only
finitely many heavy blocks, the largest required level $j$ is an
$R$-dependent constant. The learner therefore has an $R$-dependent polynomial
sample/time bound and an $R$-dependent inverse-polynomial weak advantage.

This uses the current global-marginal semantics essentially. A marginal can
put substantial mass on only finitely many blocks. Low-mass hard blocks are
handled by constants rather than by learning their PRF residuals.

### Distribution-Free Weak Target Failure

Assume, toward contradiction, that there is an efficient distribution-free
weak learner $L$ for this class. Let its uniform weak advantage be at least
$s^{-a}$, and let its sample use and running time at constant confidence be
bounded by $s^D$ after substituting that advantage. Choose a constant block
level

$$
j>D+a+3.
$$

For all large $n$, this level is allowed. Let $D_{n,j}$ be the uniform
marginal over $B_{n,j}$ and let the target be $c_{n,j,k}$.

Under $D_{n,j}$, achieving error at most $1/2-s^{-a}$ is equivalent to
predicting the hidden bit $F_k(u)$ on a fresh $u\in U_{n,j}$ with advantage
$\Omega(n^{-a})$. Given an output hypothesis $h$, use the pair

$$
h(n,j,u,0),\qquad h(n,j,u,1)
$$

to predict which of the two paired points is positive; random tie-breaking
preserves the classification advantage up to constants.

In the random-function version of the construction, after $s^D$ samples the
learner has seen at most $s^D$ distinct active indices $u$, while
$|U_{n,j}|=n^j$. On unseen indices the labels are independent of the learner's
output. The best possible expected advantage is therefore at most

$$
O(s^D/n^j)=o(n^{-a}),
$$

contradicting the weak target guarantee.

For the PRF version, the same calculation becomes a standard distinguishing
argument. If $L$ achieved advantage $\Omega(n^{-a})$ against PRF labels on
the paired block, evaluating its output on fresh pairs would predict
$F_k(u)$ with nonnegligible advantage. Against a truly random function the
no-free-label calculation gives only $o(n^{-a})$ advantage. This distinguishes
the PRF from random.

The PRF reduction uses the usual computational-PAC convention that an
efficient improper learner outputs a polynomial-time evaluable hypothesis
representation. Existing atlas cryptographic witnesses appear to rely on this
standard reading, but the current definition notes do not spell it out. So
this is a strong conditional false-witness route, not yet a completely
atlas-ready status change under the written conventions alone.

### Why The Compactness/Diagonal Theorem Route Still Fails

Full-support marginal uniformization still controls only pathwise resources.
It does not lower-bound the weak advantage uniformly over marginals.

Fixed-size compactness is too weak. In the paired-block template, for a fixed
size $s=\Theta(n)$ the allowed levels can range up to
$\Theta(n/\log n)$. The smallest source-side singleton gap at that size is
roughly

$$
n^{-\Theta(n/\log n)},
$$

which is positive but far below every inverse polynomial in $s$. Compactness
can at best give a positive fixed-size minimum; it gives no polynomial rate.

Global diagonal stitching is also blocked for the same reason as in the first
pass. A mixture over increasingly hard blocks can assign each bad block small
mass. Then an additive weak guarantee under the mixture may ignore that block
and still beat random guessing by using a constant. The source proof above
exploits exactly this feature: only finitely many heavy blocks need
singleton search for any fixed global marginal.

Thus a positive theorem would need an extra semantic strengthening, such as
size-indexed slice-conditional marginals, bounded-density access to the bad
slices, or an explicit uniform weak-gap assumption. It does not follow from
full support plus compactness under the current notes.

### Depth 3 Directions

1. Draft a dedicated paired rare-block PRF singleton-handle witness note.
   Specify the domain, the block bound
   $j\le\lfloor n/(4\log n)\rfloor$, the representation size
   $s=\Theta(n+j)$, and the concept evaluator.
2. Make the efficient-output convention explicit, either globally or as an
   assumption on a new argument note: efficient improper PAC outputs must be
   polynomial-time evaluable from their printed representations.
3. Formalize the source lemma. Prove a constants-or-positive-singleton
   advantage of $\Omega(1/N)$ on one finite heavy block, then lift it to every
   marginal by observing that each marginal has only finitely many heavy
   blocks.
4. Formalize the weak target lower bound. For an alleged target learner with
   advantage exponent $a$ and resource degree $D$, choose constant
   $j>D+a+3$, use the uniform paired-block marginal, and convert weak
   classification advantage into PRF prediction advantage by evaluating the
   two paired points.
5. Audit neighboring edges before reusing the witness. This construction is
   tailored to marginal-dependent weak gaps versus a distribution-free weak
   gap; it should not be copied into proper-output or agnostic edges without
   checking their extra requirements.

### Depth 2 Final

verdict: the compactness/diagonal theorem route is blocked; a paired
rare-block PRF construction gives a plausible conditional `false` route for
the weak distribution-free target, modulo the standard efficient-hypothesis
evaluation convention and a clean witness writeup.

confidence: 0.77 that the paired rare-block PRF route can be made into a
conditional false witness under standard computational-PAC output semantics;
0.70 that the current atlas edge should remain `open` until that convention
and witness are written explicitly.

## Depth 3 Followup 2026-05-05: Output Evaluability And Paired Source Lemma Audit

- depth: 3
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

### Question For This Pass

Depth 2 left the paired rare-block PRF construction as the most plausible
conditional `false` route, but with two gaps:

1. The PRF lower bound evaluates the learner's improper output on fresh paired
   points. Does the current atlas already require that an efficient improper
   hypothesis be polynomial-time evaluable?
2. Does the proposed constants-or-positive-singleton source lemma actually
   prove efficient marginal-nonuniform weak realizable improper learning for
   every marginal?

### Evaluability Audit

The written atlas definitions do not by themselves state a prediction-time
evaluation requirement for improper hypotheses.

The relevant definition notes say that an efficient learner has polynomial
sample complexity and running time and outputs a hypothesis $h$, possibly
outside $\mathcal C$. The `atlas/README.md` clarifies that efficient PAC sample
use and running time are worst-case/pathwise bounds on finite encoded sample
transcripts. That is enough for full-support resource uniformization of the
training procedure, but it does not explicitly say:

> Given the printed output representation of an improper hypothesis $h$ and a
> new encoded instance $x$, the value $h(x)$ must be computable in polynomial
> time.

Polynomial training time implies only that the printed output has polynomial
length. It does not rule out a short representation whose intended evaluator is
superpolynomial, nonuniform, or otherwise unavailable to a reduction. The
semantic PAC error statement still talks about a mathematical classifier, but a
cryptographic distinguisher cannot use that classifier unless the
representation is efficiently evaluable.

Existing atlas cryptographic witnesses strongly suggest that the intended
computational-PAC convention is the standard one: efficient improper learners
return hypotheses that can be evaluated efficiently. The
`pseudorandom-function-classes` witness and many sample-to-computational
separation edges rely on the claim that an efficient weak learner for PRFs
would distinguish pseudorandom labels from random labels. That argument needs
efficient evaluation of the returned hypothesis on fresh test points.

So the paired rare-block PRF target lower bound is compatible with the atlas's
apparent intent, but it is not forced by the current written definition text
alone. An atlas-ready `false` edge should either first add a global efficient
output convention or record it explicitly as an assumption in the witness or
argument note.

### Source Lemma Verification

The source side of the paired construction does check out after making the
validation cost explicit.

For an active paired block with $N=n^j$ pairs, let $S$ be its positive set and
let

$$
M=R(S)
$$

under an arbitrary marginal $R$. Consider only the candidates:

- $h_0\equiv 0$,
- $h_1\equiv 1$,
- $h_x=\mathbf 1[\cdot=x]$ for a positive atom $x$ observed in the sample.

The deterministic existence lemma is:

> For every marginal $R$ and every active block with $N$ pairs, one of
> $h_0,h_1$, or a positive singleton has error at most
> $1/2-\Omega(1/N)$.

Proof. If $M\le 1/2-1/(8N)$, then $h_0$ has the required gap. If
$M\ge 1/2+1/(8N)$, then $h_1$ has the required gap. Otherwise
$M\in[1/2-1/(8N),1/2+1/(8N)]$. Among the $N$ positive atoms, some positive
atom $x$ has mass at least $M/N$. The singleton $h_x$ has no false positives
and misses only the other positive atoms, so

$$
\operatorname{err}_R(h_x,c)=M-R(\{x\})
\le M-\frac{M}{N}
\le \frac12-\Omega(1/N).
$$

With the constants above the gap is at least $1/(8N)$ for the constant cases
and at least $1/(4N)$ in the singleton case.

Algorithmically, the earlier depth-2 sketch understated the validation cost:
seeing a heavy positive singleton takes $O(N\log(1/\delta))$ samples, but
certifying a gap of order $1/N$ by empirical validation takes
$O(N^2\log(1/\delta))$ validation samples, up to candidate-list logarithms.
This is still fine for the marginal-nonuniform weak source.

To lift from one block to every fixed marginal $R$, call a block heavy if
$R(B)>1/3$. There are at most two heavy blocks. If the target's active block is
not heavy, then $M\le R(B)\le 1/3$, so $h_0$ already has constant advantage. If
the active block is heavy, its block size $N$ belongs to a finite
$R$-dependent set, and the staged learner eventually reaches the
$R$-dependent sample and validation budget needed for that block.

Thus one uniform learner can stage over budgets, form the two constants and
all observed positive singletons, and validate them. For each fixed marginal
$R$, the stage needed for all heavy active blocks is bounded by an
$R$-dependent polynomial, while all non-heavy active blocks are handled by
the all-zero hypothesis with constant gap. The resulting weak advantage is
inverse-polynomial with a marginal-dependent exponent, exactly as the source
allows.

This proof is source-side only. It uses no PRF security and does not require
the learner to evaluate any cryptographic target off-sample.

### Target Lower Bound Conditional On Evaluability

If efficient improper outputs are required to be polynomial-time evaluable,
the paired construction still gives the intended target obstruction.

Assume a distribution-free weak learner has sample/runtime degree $D$ and weak
advantage at least $s^{-a}$. Choose a constant level $j>D+a+3$ and use the
uniform marginal on the paired block $B_{n,j}$. A sample of size at most
$s^D$ reveals the hidden PRF bit for at most $s^D$ of the $N=n^j$ pair
indices $u$.

For a truly random paired labeling, the output hypothesis has no information
about $F(u)$ on a fresh unseen pair index. Even an optimal evaluable output can
gain only on the probability that the fresh pair index was seen, giving
expected prediction advantage $O(s^D/N)=o(s^{-a})$.

If the same learner achieved error $1/2-s^{-a}$ on the PRF-labeled paired
block, then evaluating its output on $(n,j,u,0)$ and $(n,j,u,1)$ and
tie-breaking randomly would predict $F(u)$ with advantage $\Omega(s^{-a})$.
This distinguishes the PRF from the random paired labeling. The reduction is
polynomial time only because it can evaluate the returned improper hypothesis
on fresh paired points.

### Depth 3 Verdict

The source lemma is verified, with the correction that validation needs
quadratic dependence on the inverse singleton gap. The paired rare-block PRF
route is a credible conditional `false` witness under the standard
computational-PAC convention that efficient improper hypotheses are
polynomial-time evaluable.

However, the current written atlas definitions do not state that convention
clearly enough to support changing this edge to `false` on the basis of this
scratch work alone. The edge should remain `open` until either:

1. the atlas globally clarifies efficient output/evaluation semantics; or
2. a witness note explicitly includes efficient evaluability as part of the
   hypothesis representation and checks the paired construction in that
   representation.

confidence: 0.84 that the source lemma is valid; 0.80 that the PRF target
lower bound is valid once efficient output evaluation is made explicit; 0.76
that the current atlas edge should remain `open` until that definitional
clarification or witness note is added.

## Depth 4 Followup 2026-05-05: Convention-Gated False Decision

- depth: 4
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

### Question For This Pass

Depth 3 left a narrow decision:

1. Keep the edge `open`, but update the eventual edge note with the paired
   rare-block PRF candidate and the missing evaluator convention.
2. Or treat the standard computational-PAC evaluator convention as already
   part of the atlas and update the edge to conditional `false`.

### Depth 4 Verdict

Under the current written atlas conventions, the edge should remain `open`.
The paired rare-block PRF construction is strong enough to be recorded as a
candidate counterexample route, but not strong enough to justify an atlas
status change to conditional `false` yet.

The reason is not PRF security. It is the model convention. The false proof
needs to turn a learned improper hypothesis into a PRF distinguisher by
evaluating that hypothesis on fresh paired points. The atlas currently says
that computationally efficient PAC sample use and running time are
worst-case/pathwise bounds on finite encoded sample transcripts. It does not
explicitly say that an improper output is a polynomial-time evaluable
representation, nor that prediction-time evaluation is included in the
resource bound.

That omission matters for a new conditional counterexample. A PAC error
statement can be read semantically as "the output denotes some classifier
$h$." If the learner prints a short object whose intended classifier is not
available to a polynomial-time reduction, then the PRF lower bound cannot use
the output on fresh examples. Standard computational learning usually rules
this out by requiring efficiently evaluable hypotheses, and existing atlas PRF
separations strongly suggest that this is the intended convention. But
"strongly suggested" is weaker than "written model assumption" for changing an
open edge to a new false edge.

### Why Not Record Conditional False With An Evaluability Assumption?

The atlas permits conditional false edges under complexity or cryptographic
assumptions. Here the extra premise is different: "efficient improper outputs
are polynomial-time evaluable" is a semantics convention for the learning
model, not an external hardness assumption inside a fixed model.

Recording

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - standard cryptographic assumptions
  - efficient improper hypotheses are polynomial-time evaluable
```

would mix two kinds of conditions. It would make the graph answer depend on a
definition-level choice that is not currently visible in the definition nodes.
That is especially awkward because the neighboring marginal-boosting edge now
uses the same rare-block PRF candidate but explicitly keeps the edge open
until the evaluator convention is made global or attached to a witness note.
For consistency, this edge should take the same posture.

### Proposed Edge-Note Posture

If the atlas edge is edited later, I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-uniformization-open
```

and replace the stale resource-only summary with candidate/convention text:

```yaml
summary: "Open under current conventions: full-support marginal uniformization gives one pathwise sample/time polynomial, but the weak advantage may still have marginal-dependent polynomial degree. A paired rare-block PRF singleton-handle construction is a candidate conditional counterexample if efficient improper outputs are explicitly required to be polynomial-time evaluable."
```

Suggested body addition:

```markdown
**Current best candidate.** A paired rare-block PRF singleton-handle class
appears to separate the source from the target under the standard
computational-PAC convention that efficient improper hypotheses are
polynomial-time evaluable. Constants and sample-found positive singletons give
each fixed marginal an inverse-polynomial weak edge with a marginal-dependent
exponent. A distribution-free weak learner with one fixed exponent would fail
on a sufficiently high paired PRF block, since it would need to predict unseen
pseudorandom labels from too few samples.

**Why this is not yet a false edge.** The lower bound evaluates the learned
improper hypothesis on fresh paired examples to build a PRF distinguisher. The
current atlas conventions make training sample/time bounds pathwise, but do
not explicitly require polynomial-time evaluation of arbitrary improper
outputs. Until that convention is made global, or a witness note explicitly
fixes the hypothesis representation and evaluator, the construction remains a
candidate rather than an atlas-level conditional counterexample.
```

### If The Evaluator Convention Is Adopted

With an explicit convention that an efficient improper learner outputs a
polynomial-size representation equipped with polynomial-time prediction, I
would be prepared to change this edge to conditional `false` after writing the
witness note. The status would then rest on two ingredients:

1. Source lemma: for every fixed marginal, constants or sample-found positive
   singletons give a weak advantage at least $1/\operatorname{poly}_P(s)$.
2. Target lower bound: on a high paired PRF block, every learner with one
   fixed polynomial sample/time/evaluation bound and one fixed weak exponent
   would distinguish PRF labels from random labels.

The remaining work would be proof hygiene rather than a conceptual obstacle:
state the representation size, block range, candidate learner, validation
budget, reduction, and success-probability amplification cleanly.

### Depth 5 Directions

1. Decide the evaluator convention globally. Add or reject the sentence:
   efficient improper PAC learners output polynomial-size hypothesis
   representations whose predictions are computable in polynomial time, and
   prediction time is part of the computational resource model.
2. If adopted, create a paired rare-block PRF singleton-handle witness note.
   Specify the domain $(n,j,u,b)$, the range
   $j\le \lfloor n/(4\log n)\rfloor$, representation size
   $s=\Theta(n+j)$, the keyed paired concept, and the evaluator.
3. Write the source proof top-down. First prove the deterministic
   constants-or-positive-singleton lemma with gap $\Omega(1/N)$; then prove
   that sampling plus validation costs $O(N^2)$ up to logs; finally lift to an
   arbitrary global marginal using the fact that only finitely many blocks can
   have mass above a fixed heavy threshold.
4. Write the target proof top-down. Given a learner with sample/runtime degree
   $D$ and weak exponent $a$, choose a constant level $j>D+a+3$, use the
   uniform marginal on $B_{n,j}$, prove the random-label no-information bound,
   and then replace random labels by PRF labels through a standard
   distinguishing reduction using fresh paired evaluations.
5. Audit graph reuse. The same witness may inform marginal boosting and some
   distribution-uniform weak-gap edges, but it should not be copied to
   proper-output or agnostic targets without checking whether singleton
   handles or constants become legal target learners.
6. If the evaluator convention is not adopted, search for a separation that
   does not need fresh evaluation of the improper output. At present I do not
   see such a route; most improper computational lower bounds seem to need
   exactly that access to the learned predictor.

### Depth 4 Final

verdict: keep the edge `open` under current atlas conventions; add
candidate/convention text rather than a conditional `false` status.

confidence: 0.83 that `open` is the right atlas status under the written
conventions; 0.79 that the paired rare-block PRF route would justify
conditional `false` after an explicit efficient-output-evaluation convention
and witness note are added.

## Depth 5 Followup 2026-05-05: Global Evaluator Convention Or Evaluability-Free Separation

- depth: 5
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

### Question For This Pass

Depth 4 left the edge in a convention-gated state. The paired rare-block PRF
construction looks like a conditional counterexample if efficient improper
outputs are required to be polynomial-time evaluable, but the written atlas
definitions do not yet say this explicitly. The depth-5 decision is therefore:

1. recommend a global computational-output/evaluator convention and a future
   conditional `false` update; or
2. find a separation that avoids evaluating the learned improper hypothesis on
   fresh examples.

### Depth 5 Decision

Recommend the global convention plus future `false` update. I do not see a
standard separation route that avoids evaluability for this improper target.

The paired rare-block PRF construction is doing the right mathematical work.
Constants and sample-found positive singletons give every fixed marginal a
weak advantage whose inverse-polynomial exponent may depend on that marginal.
For an alleged distribution-free weak learner with one fixed exponent and one
fixed polynomial sample/time degree, a high paired PRF block forces prediction
of unseen hidden bits from too few labeled samples. This is exactly the hidden
weak-gap separation shape.

The remaining obstruction is not the source lemma, the choice of block range,
or the PRF/no-free-label calculation. It is the final step of the lower-bound
reduction: after the learner outputs an improper hypothesis $h$, the
distinguisher needs to compute

$$
h(n,j,u,0), \qquad h(n,j,u,1)
$$

on a fresh pair index $u$ in order to predict the PRF bit $F_k(u)$. That step
is polynomial time only if the output representation includes a polynomial-time
prediction procedure, or if prediction time is otherwise part of the efficient
PAC resource model.

### Why An Evaluability-Free Separation Is Not Currently Available

There is an information-theoretic random-label core that does not itself need
efficient evaluation: after only $m\ll n^j$ samples from a paired block, the
learner's transcript contains labels for only $m$ pair indices, so fresh
unseen random labels remain independent of the transcript. Thus, as a
mathematical statement, any fixed output classifier can gain only on the seen
mass in the random-label experiment.

That observation is not enough for an atlas-level cryptographic separation.
To contradict PRF security, one must turn the alleged learner into a
polynomial-time distinguisher. A semantic statement that "the output
classifier has low error on PRF labels but not on random labels" is not
observable by the reduction unless the reduction can evaluate the classifier
or otherwise query its predictions. Without such access, the training
algorithm may be efficient while the classifier denoted by its printed output
is opaque to the distinguisher.

Counting output strings also does not fix the issue under the current written
model. Polynomial training time bounds the output length, but unless the
atlas fixes an effective interpretation/evaluator for improper outputs, a
short string could denote a classifier in a model-dependent way that the
reduction cannot compute. Standard computational PAC learning rules this out
by treating the output as a usable hypothesis representation. The atlas should
say that explicitly before importing this PRF lower bound as a false edge.

Nor does validation avoid the problem. Validation samples can be used by the
learner during training, but the lower-bound reduction needs predictions on
fresh independent pairs after training to convert weak classification
advantage into PRF prediction advantage. Replacing those fresh evaluations by
extra labeled samples collapses back to the learner's existing sample access
and does not expose unseen PRF bits.

### Recommended Global Convention

The cleanest next atlas move is a global convention near the existing
computational-efficiency paragraph in `atlas/README.md`:

```markdown
For computationally efficient nodes, the learner outputs a finite encoded
hypothesis representation. Unless a definition explicitly says otherwise, the
output representation includes a uniform prediction procedure, and evaluating
the output hypothesis on an encoded instance must run in time polynomial in
the instance length and the output length. Since the output length is bounded
by the learner's pathwise running time, this preserves the stated polynomial
PAC resource bound. Improper learning only removes the requirement that the
output hypothesis lie in the benchmark class; it does not permit opaque or
non-evaluable hypotheses.
```

This convention is preferable to recording "efficient improper hypotheses are
polynomial-time evaluable" as a local edge assumption. Evaluability is not a
complexity-theoretic assumption like PRF security; it is part of what the
computational learning model means. A global convention also aligns this edge
with existing atlas PRF witnesses, which already rely on the standard idea
that an efficient learner's output can be used for efficient prediction.

If the maintainers intentionally reject this global convention, the edge
should remain open until a different separation is found. A local
conditional-false update with an evaluator assumption is logically possible,
but it would be a statement about a strengthened local model rather than a
clean resolution of the current graph edge.

### Future False Update After The Convention

After the global evaluator convention is adopted and a dedicated witness note
is written, I would update this edge to conditional `false` under PRF
security. The intended payload is:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - secure pseudorandom functions exist
witnesses:
  - paired-rare-block-prf-singleton-handle-class
summary: "False under PRF security: paired rare blocks admit marginal-dependent weak singleton handles, but any distribution-free weak learner with one fixed inverse-polynomial advantage would predict unseen pseudorandom labels on a sufficiently high block."
```

The witness note should be separate from the edge note. It should define
paired blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

with $j\le \lfloor n/(4\log n)\rfloor$, and concepts

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

with zero labels off the active block. The source proof should use constants
and observed positive singletons; the target proof should choose a constant
level $j$ above the alleged learner's sample/time degree plus weak exponent
and use the fresh-pair evaluator to distinguish PRF labels from random labels.

### Atlas-Ready Open-Note Text Under Current Conventions

Use this if the edge is updated before the evaluator convention is changed:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open under current conventions: full-support marginal uniformization gives one pathwise sample/time polynomial, but the weak advantage may still have marginal-dependent polynomial degree. A paired rare-block PRF singleton-handle construction is the leading candidate counterexample, but its PRF reduction requires an explicit convention that efficient improper outputs are polynomial-time evaluable."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

Suggested body addendum:

```markdown
**Current best candidate.** A paired rare-block PRF singleton-handle class
appears to separate the source from the target under the standard
computational-PAC convention that efficient improper hypotheses are
polynomial-time evaluable. For each fixed marginal, constants and
sample-found positive singletons give a weak advantage with a
marginal-dependent inverse-polynomial exponent. A distribution-free weak
learner with one fixed exponent would fail on a sufficiently high paired PRF
block, since it would have to predict unseen pseudorandom labels from too few
labeled samples.

**Why this is not yet a false edge.** The lower bound evaluates the learned
improper hypothesis on fresh paired examples to build a PRF distinguisher. The
current atlas conventions make training sample/time bounds pathwise, but do
not explicitly require polynomial-time evaluation of arbitrary improper
outputs. Until that convention is made global, or a new witness/argument note
states it as part of its model, the construction remains a candidate rather
than an atlas-level conditional counterexample.

**Conclusion.** Keep the edge `open` under the current written conventions.
The next schema decision is whether computationally efficient improper PAC
outputs are finite encoded hypotheses with a uniform prediction procedure
running in time polynomial in the instance length and output length.
```

### Depth 6 Instructions

If this remains unresolved, the next pass should stop searching for a
different proof route and draft the convention-plus-witness package:

1. Decide whether the evaluator convention is global README text or an
   explicit assumption on a new rare-block PRF argument note. Prefer the
   global README text unless the atlas intentionally permits opaque improper
   outputs.
2. Draft `atlas/witnesses/paired-rare-block-prf-singleton-handle-class.md`
   with frontmatter, construction, representation size, evaluator, and role
   in source/target separations.
3. Draft `atlas/arguments/paired-rare-block-prf-singleton-handle-hardness.md`
   with three top-down lemmas: source weak singleton-handle lemma,
   random-label no-free-label bound, and PRF distinguishing reduction using
   fresh paired evaluations.
4. Only after those notes exist, update
   `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
   to conditional `false` if the global evaluator convention was adopted.
   If the convention was not adopted, keep the edge `open` and include the
   atlas-ready open-note text above.
5. Audit reuse on neighboring edges separately. This witness is tailored to
   weak marginal-dependent gaps for improper distribution-free targets; do not
   copy it to proper-output or agnostic edges without rechecking the output
   and benchmark requirements.
6. Run the atlas frontmatter and citation-key checks after any atlas edits.
   Do not run LaTeX unless the report is explicitly in scope.

### Depth 5 Final

verdict: keep the current atlas edge `open`; recommend a global
efficient-output/evaluator convention and then a future conditional `false`
update using a paired rare-block PRF singleton-handle witness. I did not find
an evaluability-free separation route suitable for the current improper
target.

confidence: 0.87 that the correct current status is `open` under the written
conventions; 0.82 that the edge should become conditional `false` after a
global evaluator convention and a clean paired rare-block PRF witness/argument
note are installed; 0.74 that no standard evaluability-free separation route
is available.
