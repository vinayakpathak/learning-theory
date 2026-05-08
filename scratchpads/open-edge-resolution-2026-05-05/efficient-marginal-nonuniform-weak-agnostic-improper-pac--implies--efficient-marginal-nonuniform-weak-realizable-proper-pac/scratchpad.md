# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- depth: 1
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: medium-high

Worker constraint followed: I only wrote this scratchpad and did not edit atlas files.

## Context

The source is `efficient-marginal-nonuniform-weak-agnostic-improper-pac`.
It gives one uniform learner $A$ such that, for every instance marginal $P$,
there are marginal-dependent polynomial resource bounds and a weak agnostic
tolerance

$$
\beta_P(s)=\frac12-\alpha_P(s)<\frac12,
$$

with $1/\alpha_P(s)$ bounded by a $P$-dependent polynomial. For every joint
distribution $\mathcal D$ with marginal $P$, $A$ may output a hypothesis outside
$\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(A)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

The target is `efficient-marginal-nonuniform-weak-realizable-proper-pac`.
On realizable labels $Y=c(X)$ with $c\in\mathcal C$, it asks for a uniform
algorithm which, for every fixed marginal $P$, has $P$-dependent polynomial
sample/time bounds and outputs $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial.

Restricting the source to realizable data gives a weak improper predictor under
the same marginal. The only real axis change is therefore properization:
can one efficiently convert an external weak predictor, or the source's
agnostic access, into even a weakly correlated member of $\mathcal C$?

## Attempted Resolution

### Positive Route

The most direct positive plan is:

1. run the source learner on realizable data to obtain an improper predictor
   $g$ with positive $P$-correlation with the target $c$;
2. use $g$ and fresh labeled samples to output some $h\in\mathcal C$ with
   positive inverse-polynomial $P$-correlation with $c$.

I do not see a generic way to justify step 2. Information-theoretically the
target concept $c$ itself is perfect, and in the sample-only layer unbounded
ERM can remove the obstacle. Computationally, however, the source learner may
have avoided the hard part by outputting a lookup table, sparse set, parity
vector, vote, regression object, or other representation outside $\mathcal C$.
The target asks for an actual valid concept representation.

Marginal nonuniformity helps with rates only after a uniform algorithm exists.
It does not give $P$-specific advice, a support enumeration, a trace
representative list, or a proper ERM oracle. Standard boosting is also not the
missing ingredient: it improves prediction but generally returns an improper
aggregate, while the present target needs one member of $\mathcal C$.

A true theorem would follow from an extra fixed-marginal weak proper selector:
for each $P$, a uniform polynomial-time procedure, with $P$-dependent analysis,
that turns labeled samples and/or a weak external predictor into a polynomial
list of proper hypotheses containing one with nontrivial $P$-advantage. No
checked note shows that such a selector follows from the source.

### PCP Active-Slice Witness

The PCP active-slice lookup class is the cleanest weak proper hardness witness.
It even satisfies a stronger source than needed: the one-slice lookup-table ERM
from `pcp-active-slice-weak-proper-hardness` gives efficient agnostic improper
learning, hence certainly weak marginal-nonuniform agnostic improper learning.

The lower bound, however, uses the marginal uniform on the active slice of the
input formula $\varphi$. For a distribution-free weak proper target this yields
an RP algorithm for the NP-complete language: satisfiable formulas have an
all-accepting proof, while unsatisfiable formulas have verifier acceptance below
$1/2$.

For the assigned marginal-nonuniform target, that marginal varies with
$\varphi$. The target's runtime polynomial and weak advantage may depend on
that exact marginal, so the reduction no longer obtains one polynomial-time
algorithm for all formulas.

Packing all active slices into one fixed marginal also loses the weak gap. If
$P=\sum_\psi w_\psi U_\psi$, then the local PCP advantage on the $\varphi$
slice is multiplied by $w_\varphi$. A fixed distribution cannot assign
inverse-polynomial or constant mass to exponentially many length-$n$ formulas.
When $w_\varphi$ is small, a wrong-slice or mostly-zero proper concept can
already have global error far below $1/2$ without revealing a useful proof.

### Clause-Satisfaction Lookup Witness

The clause-satisfaction lookup class gives fixed-marginal strong proper
hardness: under the uniform clause marginal, an input formula can be encoded in
conditional labels, and sufficiently accurate proper learning would recover a
satisfying assignment.

This does not refute the present realizable weak target. The fixed-marginal
construction for strong agnostic proper hardness uses noisy/non-formula labels,
so it is not a realizable target distribution. If instead the learner is run on
a realizable assignment-labeling, the input formula is no longer encoded in a
way that forces the returned weakly correlated assignment to satisfy it. If the
marginal is concentrated on the formula clauses, it again varies with the input
formula and is absorbed by marginal nonuniformity.

### One-Way Image Coordinates

The one-way image-coordinate class is also source-positive: sparse improper ERM
agnostically competes with the proper class. It refutes strong marginal
realizable proper learning under a fixed all-length coordinate marginal.

It does not refute the weak target. Under the fixed marginal with length-block
mass $\mu_n=6/(\pi^2 n^2)$, a length-$n$ target differs from a same-length
wrong image only on the length-$n$ block, with total error at most $\mu_n$.
A wrong-length concept can also have error roughly $\mu_n/2+\mu_m/2$ by choosing
a low-mass length $m$. These errors are far below $1/2$ for large $n$, so they
are legal weak proper handles and do not invert the one-way function.

The `one-way-image-coordinate-weak-handle-hardness` note makes this diagnosis
explicit: after adding constants and singleton concepts, weak proper learning is
easy while strong proper learning still forces inversion. Thus the existing
one-way family separates strong properization, not weak fixed-marginal
properization.

### Dense-Code Repair

The natural repair is to encode a one-way image by a balanced codeword over a
shared coordinate space, so that every wrong proper seed has error essentially
$1/2$ under one fixed marginal. A Hadamard-style code has exactly the desired
orthogonality at a single length: any proper hypothesis with positive
correlation would identify the image and hence a preimage.

This is still not atlas-ready. With finite encoded examples, one fixed marginal
spread over all lengths creates the same mass/tail dilution as the coordinate
witness. If the construction pads the exponentially large Hadamard coordinate
domain into the representation size, then a learner running in polynomial time
in the atlas size gives only a subexponential or exponential-time inverter in
the original seed length, not a contradiction to ordinary one-wayness.

Polynomial-length codes keep lookup-style improper learning plausible, but only
bound wrong-code correlations at a chosen inverse-polynomial scale. The target
advantage $\gamma_P(s)$ is hidden and may be smaller than that residual
correlation, so a wrong seed can remain a valid weak output. Exact
orthogonality for exponentially many certificates appears to require either a
large shared domain or non-finite/continuous structure outside the checked
finite-transcript atlas convention.

## Proposed Atlas Update

No status change is justified. Keep the edge open:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested summary if the note is refreshed:

```yaml
summary: "Open: the source gives weak improper prediction on realizable data, but no generic efficient fixed-marginal selector for even a weakly correlated proper hypothesis is known; PCP, clause, and one-way witnesses lose force at the marginal-nonuniform weak threshold."
```

Suggested body sketch:

> **Verdict.** `open`.
>
> The source specializes on realizable data to an improper weak learner under
> the same fixed marginal. The target asks for a member of $\mathcal C$. A
> positive proof would need an efficient fixed-marginal weak proper selector or
> projection procedure; sample-only existence, finite traces, and boosting-style
> prediction do not provide one.
>
> Known false witnesses remain near misses. PCP active-slice hardness gives a
> weak proper lower bound only when the hard instance is placed in the marginal;
> marginal nonuniformity lets the target polynomial and weak advantage depend on
> that input-specific marginal, and packing slices into one fixed marginal
> dilutes the gap. Clause-satisfaction lookup gives strong fixed-marginal
> proper hardness, but not a realizable weak proper lower bound. One-way
> image-coordinate classes give strong fixed-marginal recovery hardness, but
> wrong-image, wrong-length, constant, singleton, or other weak handles can beat
> random guessing without inverting. Dense code repairs are the right shape but
> currently either lose polynomial-scale improper learnability or leave
> inverse-polynomial residual correlations below the target's hidden weak gap.

## Obstacles

1. **Proper trace selection.** The target concept exists, but the source output
   need not contain any efficiently recoverable proper representation.

2. **Input-dependent hard marginals.** PCP-style weak lower bounds choose a
   marginal depending on the hard instance. The marginal-nonuniform target may
   have a different polynomial and weak gap for each such marginal.

3. **Packed-slice dilution.** A single fixed marginal cannot keep exponentially
   many active slices visible at the weak scale. Low-mass slices can be ignored.

4. **Strong recovery is not weak hardness.** One-way and clause witnesses can
   force exact or high-accuracy recovery, but weak proper learning may succeed
   through wrong-length, wrong-slice, low-support, or otherwise accidental
   proper handles.

5. **Dense balance versus easy source.** Balanced codes can remove weak handles,
   but exact orthogonality strains the finite-encoded polynomial scale, while
   polynomial codes leave residual correlations at an unknown inverse-polynomial
   scale.

## Next Directions

1. Formalize a reusable **fixed-marginal weak proper selector** condition and
   prove the conditional theorem: source plus selector implies the target.

2. Look for a genuine fixed-marginal weak selector hardness witness: every
   proper hypothesis with inverse-polynomial positive correlation must decode a
   proof, satisfying assignment, preimage, or other hard certificate.

3. Revisit dense one-way or PCP code constructions, but test the source first:
   the class must remain weak agnostically learnable by an efficient improper
   algorithm under arbitrary marginals.

4. Prove a packing/barrier lemma for active-slice witnesses under a fixed
   mixture marginal, showing exactly when wrong-slice proper hypotheses become
   legal weak handles.

5. Check whether any primary fixed-distribution proper-only lower bound
   explicitly coexists with efficient improper weak agnostic prediction. Lower
   bounds against all predictors are not useful for this edge because they would
   destroy the source.

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- sibling scratchpads for `efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`, `efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`, `efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`, and `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- Schapire 1990 (`schapire1990`)
- Pitt and Valiant 1988 (`pitt1988`)
- Khot and Saket 2008 (`khot2008dnf`)
- Hastad and Khot 2005 (`hastad2005query`)
- Kearns and Valiant 1994 (`kearns1994cryptographic`)
- Hastad, Impagliazzo, Levin, and Luby 1999 (`hastad1999prg`)
- Benedek and Itai 1991 (`benedek1991fixed`)
- Ben-David, Benedek, and Mansour 1995 (`bendavid1995parameterization`)
- Hanneke, Moran, and Thiessen 2025 (`hanneke2025marginalnonuniform`)

verdict: unresolved-open
confidence: medium-high

---

## Depth-2 Follow-Up - 2026-05-05

- depth: 2
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: high that no atlas status change is justified; medium-high that the standard counterexample templates are blocked for structural reasons rather than by a missing citation

### Focus

This pass focused on the realizable target specifically. The source learner,
run on labels $Y=c(X)$, gives an improper predictor $g$ with

$$
\operatorname{err}_P(g,c)\le 1/2-\alpha_P(s)
$$

for some inverse-polynomial fixed-marginal advantage $\alpha_P(s)$. The target
only asks for a proper concept with some inverse-polynomial advantage. I tried
to see whether the realizable labels and validation samples can bridge that
gap, or whether the fixed-marginal weak-handle barriers can be turned into a
clean counterexample.

### Realizable Validation Does Not Properize

The positive plan would be:

1. learn an external weak predictor $g$ from realizable data;
2. use fresh labeled samples to find or validate a proper $h\in\mathcal C$;
3. output $h$ once its empirical error is below $1/2$ by a visible margin.

The failure is in step 2, not in validation. Validation can certify a proposed
proper hypothesis, but it does not generate one. The true target $c$ is a
perfect proper hypothesis, and finite-sample/VC reasoning can justify existence
of good proper traces when computation is ignored. None of that gives a
polynomial-time map from the labeled trace, or from the external predictor
$g$, back to a representation in $\mathcal C$.

Several natural attempts keep hitting the same wall.

- Enumerating proper concepts consistent with a sample is generally
  exponential in the representation size. Marginal nonuniformity allows the
  running-time bound to depend on $P$, but not on the hidden target concept and
  not on a target-specific search tree.
- Re-labeling fresh examples by $g$ and rerunning the source learner preserves
  the marginal $P$, but it still returns an improper hypothesis. Worse, the
  proper benchmark for the $g$-labels may have error
  $\operatorname{err}_P(c,g)\le 1/2-\alpha_P(s)$; the weak agnostic additive
  tolerance can then permit error as large as roughly $1-2\alpha_P(s)$, so this
  does not even force a useful weak predictor for $g$.
- Running the source learner on an empirical marginal supported on the sample
  would move to a new marginal $Q$. The source gives a $Q$-dependent runtime
  polynomial, with no reason for those polynomials to be bounded by a
  $P$-dependent polynomial uniformly over all random samples from $P$.
- Boosting, validation, and majority votes improve or certify prediction, but
  their natural outputs are external aggregates unless an additional projection
  into $\mathcal C$ is supplied.

Thus the realizable target gives a stronger benchmark, but it does not by
itself give a proper selector. A conditional positive theorem remains easy:
source plus an efficient fixed-$P$ weak proper trace selector implies the
target. The selector is exactly the missing computational content.

### Fixed-Marginal Weak Handles Still Block The Counterexamples

The false route needs a class satisfying the source and a fixed marginal
$P^\star$ such that every polynomial-time proper learner fails to output even
one inverse-polynomially correlated concept on some realizable target. Since
the target's advantage $\gamma_{P^\star}(s)$ is hidden, a witness has to defeat
every inverse-polynomial advantage scale, not merely a chosen constant or
$1/s^k$ gap.

The checked witnesses still miss that requirement.

**Clause-satisfaction lookup.** The class has an easy improper agnostic learner
because the clause universe at size $n$ is polynomial. But under broad fixed
clause marginals, weak proper handles are abundant: different assignments have
large agreement because most clauses are satisfied by most assignments. The
known hardness uses formula-specific or high-accuracy clause distributions to
force a satisfying assignment; that is strong proper hardness, not weak
realizable fixed-marginal hardness.

**PCP active slices.** Uniform mass on the active verifier slice of one formula
would give the desired weak gap, but that marginal depends on the formula. A
shared-randomness PCP encoding with proper concepts $(\psi,\pi)$ also has a
wrong-instance handle problem: with perfect completeness, a satisfiable
unrelated instance can produce the all-accepting function on the shared
randomness. Adding identity coordinates recreates slices, and packing those
slices into one fixed marginal multiplies the local gap by the slice weight.

**One-way image coordinates.** Sparse image-coordinate classes keep the source
easy, but wrong images, wrong lengths, constants, or singleton-style concepts
can be weakly good globally without inverting. Dense code repairs remove these
cheap handles only if wrong proper codewords have nonpositive or negligible
correlation under one fixed marginal. Polynomial coordinate domains leave
inverse-polynomial residual correlations; exact Hadamard-style orthogonality
uses exponential domains or padded sizes and breaks the ordinary polynomial
source/inversion scale.

This suggests the same diagnosis as the broader `properization-open` note:
pure geometric removal of weak handles is too expensive, while sparse lookup
geometry gives the source but leaks weak proper handles.

### What A Real Counterexample Would Need

The remaining possible false route is not just "no weak handles exist." For a
finite explicit coordinate domain that seems to conflict with coding bounds and
with easy lookup learning. A more plausible witness would need
**computational weak-handle hardness**:

- weakly correlated proper hypotheses may exist under the fixed marginal;
- however, finding any such hypothesis from realizable samples is as hard as
  finding the intended proof, assignment, preimage, or certificate;
- the improper learner stays easy because it can learn the prediction table or
  another external representation without solving that selector problem.

No checked PCP, clause, one-way, or dense-code construction currently provides
this. Existing reductions either make the hard instance part of the marginal,
ask for strong accuracy, or rely on fixed-distribution prediction hardness that
would also destroy the improper source.

### Depth-3 Directions

1. Formalize the conditional positive lemma with the weakest useful selector:
   from realizable samples plus optional evaluation access to a weak external
   predictor $g$, output an $h\in\mathcal C$ with fixed-$P$
   inverse-polynomial advantage.

2. Prove a negative trace lemma: finite support, finite VC traces, or empirical
   validation alone do not imply efficient proper selection. The lemma should
   isolate the missing map from trace labels to a valid concept representation.

3. Search for computational weak-handle hardness under one fixed marginal.
   Unlike the current dense-code route, this may allow weak handles to exist
   information-theoretically, as long as finding one is hard.

4. Revisit shared-coordinate PCPs with identity-free encodings. The key test is
   whether wrong-instance satisfying proofs can be prevented from becoming
   all-one or high-agreement handles without reintroducing exponentially many
   low-mass slices.

5. Investigate stronger assumptions or variant nodes separately. Subexponential
   one-way hardness, fixed requested-gap weak learning, or advice-per-marginal
   conventions might make dense-code separations work, but they would not
   resolve the present atlas edge as stated.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: medium-high

---

## Depth-3 Follow-Up - 2026-05-05

- depth: 3
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: medium-high

### Focus

This pass tried to push the two suggested routes:

1. use realizable validation samples to turn the source learner's external weak
   predictor into a proper weak handle;
2. build a fixed-marginal counterexample where improper weak agnostic learning
   is easy but every validation-findable proper weak handle is hidden.

The short outcome is still negative on both routes. Validation is powerful
once a polynomially generated candidate family of legal concepts is available,
but the source learner does not provide such a family. Conversely, the most
natural fixed-marginal counterexamples either expose validation-findable wrong
proper handles or lose the efficient weak agnostic improper source.

### Validation Reduces To Candidate Generation

Work in $\{\pm1\}$ notation. On realizable labels the source gives an external
predictor $g$ with

$$
\mathbf E_{X\sim P} g(X)c(X) \ge 2\alpha_P(s)
$$

for an inverse-polynomial $\alpha_P(s)$. A validation set can certify any
proposed $h\in\mathcal C$ whose empirical correlation with $c$ is positive by
a visible margin. More generally, if a polynomial-time routine produced a
polynomial list $L$ of legal concepts such that, with noticeable probability,

$$
\max_{h\in L}\mathbf E_{P} h(X)c(X) \ge 2\eta_P(s)
$$

for inverse-polynomial $\eta_P(s)$, then ordinary validation over $L$ would
give the target.

Thus the desired positive proof would follow from a fixed-marginal weak proper
candidate generator. The candidate generator may use the original labeled
sample and even evaluation access to $g$; validation can then remove false
positives. But I do not see how to derive the generator from the source.

Several variants collapse to the same missing operation.

- Validating all concepts consistent with the sample is computationally
  useless without a way to enumerate valid representations or solve proper
  consistency.
- Using $g$ as a surrogate labeler asks for a proper optimizer against the
  $g$-labels. Even a weakly $g$-correlated proper hypothesis need not be
  weakly correlated with $c$: if both $h$ and $c$ only beat random guessing
  against $g$ by small margins, their mutual correlation can be negative.
- Rerunning the source learner on samples relabeled by $g$, or on disagreement
  labels, still returns an improper hypothesis. It may be useful for prediction
  but it does not generate a legal member of $\mathcal C$.
- Switching to an empirical marginal $Q$ supported on the sample is not a
  uniform algorithmic move: the source guarantee supplies a $Q$-dependent
  polynomial, with no reason for those polynomials to be controlled by the
  original fixed-$P$ polynomial over random samples from $P$.

So validation isolates the exact missing content: a searchable proper trace,
cover, sampler, projection, or approximate proper ERM under the fixed marginal.
This is extra representation structure, not a consequence of the abstract
improper weak agnostic learner.

### Why The Fixed-Marginal Counterexample Is Still Elusive

A false witness needs one fixed marginal $P^\star$ and infinitely many
realizable targets for which every polynomial-time proper learner fails to
find any inverse-polynomially correlated legal concept. It must also satisfy
the source for every marginal, not just for $P^\star$.

The natural blueprint is a hidden-code or hidden-image class:

- a proper concept is indexed by a hard certificate $z$;
- its labels under $P^\star$ are an easily learnable external object, such as
  an image, table, or linear/parity coefficient;
- an improper learner can recover and output that external object without
  recovering $z$;
- any proper weak output should reveal $z$ or another hard certificate.

The blueprint keeps failing at the weak fixed-marginal threshold.

First, sparse or sliced constructions leak cheap handles. If only a length
block, active slice, or image-coordinate set carries the target-specific
signal, then a fixed all-instance marginal assigns that region mass
$\mu_s$. Wrong-length concepts, off-slice defaults, constants, or singleton
handles can have global error well below $1/2$ without solving the hidden
problem. The PCP active-slice witness avoids this only by letting the marginal
depend on the input instance, which marginal-nonuniformity absorbs.

Second, dense shared-coordinate repairs tend to make validation work for the
proper learner. If many legal codewords live on one polynomially visible
coordinate block, wrong codewords cannot all have correlation below every
inverse polynomial. In a random-string or code-bound calculation, excluding
all wrong handles at threshold $\tau$ requires roughly
$N\tau^2 \gg \log M$, where $M$ is the number of proper certificates and $N$ is
the coordinate block size. With $N=\operatorname{poly}(s)$ and
$M$ exponential in the hidden seed length, some inverse-polynomial residual
correlations remain. Since the target's advantage $\gamma_{P^\star}(s)$ is
hidden and may be smaller than that residual scale, a wrong legal concept can
be a valid weak output and validation can find it.

Third, making the dense code safe by taking $N$ superpolynomial breaks the
usual easy-source argument. Lookup-table ERM is no longer polynomial in the
atlas size parameter, and if the representation size is inflated to include
$N$, then the resulting proper learner no longer contradicts ordinary
polynomial-time hardness of inverting the original seed map.

The most tempting hybrid is an image-parity construction: concepts are seeds
$z$, labels are parities with coefficient $f(z)$, and an improper learner
outputs the image coefficient rather than a preimage. Under a single uniform
length block this has the right flavor. Under the atlas edge it is not a
counterexample: the source would require weak agnostic improper learning under
arbitrary marginals, while agnostic parity-style learning is not supplied by
the construction; packing all lengths into one fixed marginal reintroduces
wrong-block or random-code handles unless additional global balancing is added;
and global balancing pushes back into the dense-code residual-correlation
problem above.

### Current Diagnosis

The edge remains a genuine properization open case.

The positive route needs a fixed-$P$ generator of candidate legal concepts.
Validation would finish the proof, but the source learner only gives an
external predictor. The negative route needs computational weak-handle
hardness under one fixed marginal. Known witnesses give either strong recovery
hardness, input-dependent hard marginals, or weak handles that validation can
detect.

This also explains why the realizable assumption helps less than it first
appears. It gives a perfect proper benchmark $c$, and it lets validation test
candidate concepts against noiseless labels. It does not reveal a
representation of $c$ or a polynomial neighborhood of $c$ inside
$\mathcal C$.

### Depth-4 Directions And Obstacles

1. **Formal validation-selector lemma.** State the exact conditional theorem:
   source plus a fixed-marginal polynomial candidate generator for proper
   hypotheses implies the target. Allow the generator to use samples and the
   source learner's predictor $g$. This would separate the easy validation
   part from the hard representation-selection part.

2. **No-free-selector examples.** Build toy oracle or finite-family models
   where an external weak predictor is exposed but mapping it to any valid
   proper representation is hidden. The goal is not an atlas witness yet, but
   a clean lower-level explanation of why validation alone cannot generate
   proper handles.

3. **Computational weak-handle hardness.** Search for a fixed marginal where
   weakly correlated proper handles may exist, but finding any one of them is
   hard. A useful construction must make every validation-findable handle
   decode a certificate, while still leaving an efficient improper weak
   agnostic learner.

4. **Image-parity source test.** Revisit the one-way image/parity idea and
   first prove or refute the source: can the image output be weak agnostically
   learned improperly under every fixed marginal with a marginal-dependent
   polynomial? If not, the construction cannot resolve this edge.

5. **Dense-code barrier lemma.** Formalize the residual-correlation obstruction
   for polynomial-coordinate fixed-marginal codes. The desired lemma would say
   that a code family large enough to hide a hard certificate but small enough
   for explicit improper lookup cannot suppress all wrong proper correlations
   below every inverse-polynomial scale.

6. **Model-boundary check.** Non-atomic or real-valued instance models might
   allow exact orthogonality for hidden parity/image concepts under one fixed
   marginal. Under the atlas's finite-transcript computational convention this
   appears out of scope, but it is worth making that boundary explicit before
   ruling out the construction family.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- sibling scratchpad `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: medium-high

---

## Depth-4 Follow-Up - 2026-05-05

- depth: 4
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: high that the validation part is isolated correctly; medium-high that no current counterexample template resolves the edge

### Focus

This pass followed the depth-3 directions:

1. prove the strongest useful validation-selector lemma for realizable labels;
2. test whether the lemma can be instantiated from the source alone;
3. try again to make a fixed-marginal computational weak-handle counterexample.

The useful progress is a clean conditional theorem. The conditional theorem
does not resolve the edge, because its selector hypothesis is exactly the
missing properization operation. The counterexample route also remains blocked:
polynomial-coordinate dense codes leave inverse-polynomial wrong handles, while
exact weak-safe encodings destroy the easy weak agnostic improper source or move
outside the finite-transcript scale.

### Conditional Validation-Selector Lemma

Use $\{\pm1\}$ labels. For a fixed marginal $P$, suppose the source learner
run on realizable labels $c\in\mathcal C$ returns, with high probability, an
external predictor $g$ satisfying

$$
\mathbb E_P[g(X)c(X)] \ge 2\alpha_P(s),
$$

where $1/\alpha_P(s)$ is bounded by a $P$-dependent polynomial.

Now add the following extra selector assumption. There is one uniform procedure
$S$ such that, for every fixed marginal $P$, there are a $P$-dependent
polynomial $q_P$ and an inverse-polynomial $\eta_P(s)>0$ with this property:
given realizable samples from $(P,c)$ and optional evaluation access to such a
$g$, $S$ runs in time $q_P(s,\log(1/\delta))$ and outputs a list
$L\subseteq\mathcal C$ of legal proper hypotheses, with
$|L|\le q_P(s,\log(1/\delta))$, such that with probability at least
$1-\delta$,

$$
\max_{h\in L}\mathbb E_P[h(X)c(X)] \ge 4\eta_P(s).
$$

Then the assigned implication is true for the class.

**Proof.** Run the source learner on realizable data to obtain $g$, then run
$S$ to obtain $L$. It remains only to validate. Because the learner does not
know the hidden exponent in $\eta_P$, use phases $k=1,2,\ldots$. In phase $k$,
draw a fresh validation sample of size

$$
m_k=O\left(s^{2k}\left(\log |L|+k+\log(1/\delta)\right)\right)
$$

and estimate $\widehat{\rho}(h)=m_k^{-1}\sum_i h(X_i)c(X_i)$ for all
$h\in L$. Accept any $h$ with $\widehat{\rho}(h)\ge 2s^{-k}$.

Uniform Hoeffding bounds over $L$ and over phases imply that, except with the
allocated failure probability, every accepted $h$ has true correlation at least
$s^{-k}$. Conversely, if $\eta_P(s)\ge s^{-K}$, then by phase $K+O(1)$ the
good list element has empirical correlation above the acceptance threshold.
The total work through that phase is bounded by a $P$-dependent polynomial.
The accepted proper hypothesis has

$$
\operatorname{err}_P(h,c)
=\frac12-\frac12\mathbb E_P[h(X)c(X)]
\le \frac12-\frac{1}{2s^{K+O(1)}}.
$$

This is exactly the target's marginal-nonuniform weak realizable proper
guarantee.

The proof is deliberately boring: validation only removes false positives and
absorbs the hidden weak-gap exponent by dovetailing over thresholds. All
substantive content is in producing the polynomial proper list $L$.

### Why The Lemma Does Not Instantiate Itself

The source learner gives a predictor $g$, not a list of concepts in
$\mathcal C$. Several apparent ways to manufacture $L$ reintroduce an operation
as hard as proper learning.

- Enumerating all proper concepts consistent with a sample is a proper
  consistency or proper ERM problem. The finite-sample fact that $c$ exists
  does not make the representation searchable in polynomial time.
- Optimizing agreement with $g$ is also a proper optimization problem. Even if
  some $h$ weakly agrees with $g$, that need not imply $h$ weakly agrees with
  $c$ unless the selector uses the realizable labels in an essential way.
- Running the source learner on labels derived from $g$ preserves prediction
  access but still returns an improper object.
- Moving to an empirical marginal gives selector-like finite support, but the
  source promise for that new marginal has its own polynomial, not controlled
  by the original fixed-$P$ bound.

Thus the validation-selector lemma is a useful conditional positive result,
not an unconditional proof of the edge.

### Computational Weak-Handle Attempt

The cleanest false template is still a fixed-marginal code construction. Let
proper concepts be hidden certificates $z$, with labels on an explicit
coordinate block $Q_s$ given by a binary codeword $C_z\in\{\pm1\}^{Q_s}$.
An improper learner would use coordinate lookup or empirical majority over
$Q_s$, so the source is plausible when $|Q_s|=\operatorname{poly}(s)$. Proper
weak learning would be hard if every non-certificate codeword had correlation
below the target's hidden $\gamma_P(s)$.

The quantitative barrier is:

$$
|Q_s|\tau^2 \gtrsim \log M_s
$$

for excluding all wrong handles at correlation threshold $\tau$ among
$M_s$ possible certificates. With $M_s$ exponential in a hard seed length and
$|Q_s|=\operatorname{poly}(s)$, this only suppresses wrong correlations to some
inverse-polynomial scale. The target's advantage may be a smaller
inverse-polynomial. A wrong legal codeword at the residual scale is then a
perfectly valid weak proper output, and validation will happily certify it.

Exact Hadamard or parity-style encodings remove the residual correlation, but
then the source side stops being lookup ERM. The improper learner would have to
solve an agnostic parity/correlation-search problem under dense coordinates, or
the coordinate domain must be made exponential and the polynomial-time
contradiction moves to the wrong size parameter.

This also blocks a PRG distinguisher variant. A weak proper learner on a true
generator output returns a seed whose output has correlation at least
$\gamma_P(s)$ with the challenge string. To distinguish generator outputs from
random strings, random strings must have no seed with correlation at that
threshold. The same union-bound/list-decoding calculation needs
$|Q_s|\gamma_P(s)^2\gg \log M_s$. Since $\gamma_P$ is hidden, polynomial
coordinate length cannot guarantee this for the atlas node.

### Atomic-Marginal Sanity Check

For purely atomic fixed marginals, weak prediction itself is often cheap:
enough samples reveal a finite set carrying just over half the mass, and an
improper majority table on that set gives a weak agnostic predictor with
$P$-dependent constants. This explains why source-positive lookup witnesses are
easy to build.

It does not give a false witness by itself. A target lower bound still needs
one fixed marginal where every validation-findable proper weak handle is hard.
If the hard signal is placed in low-mass tails, the weak target can ignore it.
If it is placed on polynomially visible high-mass coordinates, the dense-code
residual-correlation barrier returns. If it is placed on an atomless or
succinct orthogonal space, the construction no longer matches the atlas
finite-encoded transcript convention or the easy improper agnostic source.

### Current Diagnosis

The edge remains open. The positive proof is reduced to an explicit
representation-level selector:

> source learner + fixed-marginal polynomial proper candidate generator +
> validation = target.

The negative proof needs a different kind of witness from the current PCP,
clause, one-way-coordinate, and dense-code templates. Pure geometry wants to
eliminate all weak handles, but that is too expensive at polynomial coordinate
scale. A plausible counterexample must instead make weak handles exist but be
computationally hard to find, while keeping improper weak agnostic prediction
easy.

### Depth-5 Directions And Obstacles

1. **Prove or refute selector existence for special source mechanisms.** If
   the improper learner is specifically finite-domain lookup ERM, sparse-table
   ERM, or low-noise robustification of a realizable learner, can one extract a
   proper weak candidate list? The obstacle is that the lookup table may encode
   labels without any searchable representation in $\mathcal C$.

2. **Oracle weak-handle separation.** Try an oracle class where an oracle gives
   the improper predictor/table directly, but any proper representation with
   positive correlation requires finding an oracle-hidden certificate. This
   would test whether computational weak-handle hardness is coherent before
   trying to realize it with PCPs or cryptography.

3. **Adaptive validation against wrong handles.** If dense codes only give a
   short list of weakly correlated wrong certificates, can labels be modified
   under the same marginal to eliminate returned wrong handles while preserving
   realizability by the true certificate? The obstacle is that each
   modification can consume the hidden weak slack or make the distribution no
   longer realizable.

4. **Weighted dense-code barrier.** Formalize the route-specific no-go for
   weighted fixed marginals: after truncating to high-mass polynomially visible
   coordinates, exponentially many certificates cannot all have correlation
   below every inverse-polynomial threshold; outside the truncation, the weak
   target can ignore low mass.

5. **Model-boundary audit.** Exact orthogonal systems over atomless domains or
   succinct exponentially large domains may yield clean weak proper hardness,
   but they seem to sacrifice either finite encoded sampling/evaluation or the
   efficient weak agnostic improper source. A depth-5 pass should decide
   whether any such model is actually admissible in the atlas.

### References Rechecked

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- sibling scratchpad `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: high

---

## Depth-5 Follow-Up - 2026-05-05

- depth: 5
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: high that the source does not by itself generate proper candidates; medium-high that the remaining counterexample route must be computational weak-handle hardness rather than pure code geometry

### Focus

This pass tried one more serious positive and one more serious negative route.

The positive route asked whether the source learner itself can be used as a
proper candidate generator. The negative route accepted the depth-4 diagnosis
that pure dense-code geometry cannot beat the hidden weak-gap scale, and tried
instead to make weak handles exist but be computationally hard to find.

Neither route resolves the edge.

### Last Positive Route: Source-Induced Candidate Generation

Fix a marginal $P$ and use $\{\pm1\}$ labels. On realizable labels
$Y=c(X)$, the source gives an improper predictor $g$ with

$$
\mathbb E_P[g(X)c(X)]\ge 2\alpha_P(s)
$$

for inverse-polynomial $\alpha_P$. Depth 4 shows that validation would finish
if we had a polynomial list $L\subseteq\mathcal C$ containing even one
inverse-polynomially correlated proper hypothesis.

The strongest black-box attempt I see is to use the source learner on
artificial same-marginal label distributions derived from the observed labels,
from $g$, and from residuals such as $c\cdot g$. One then hopes that the set of
source outputs, or the transcript tree of source calls, contains enough
information to reconstruct a nearby legal concept.

The obstruction is structural. The agnostic guarantee constrains prediction
quality, not representation type. In correlation form, for an arbitrary label
rule $Y$ the source only promises

$$
\operatorname{corr}(A,Y)
\ge
\max_{h\in\mathcal C}\operatorname{corr}(h,Y)-(1-2\alpha_P(s)).
$$

Every call may answer with a fresh external predictor. Iterating this produces
a polynomial family of improper functions, or a boosted improper aggregate,
but it never forces any output to be a member of $\mathcal C$. The usual
minimax or boosting interpretation closes the generated class under external
prediction, not under valid concept representations.

Enumerating the source learner's finite transcripts does not fix this. For the
$P$-dependent polynomial many samples and random bits, one can at best
enumerate possible improper outputs at a chosen phase. The missing map remains

$$
\text{external predictor or finite labeled trace}
\longmapsto
\text{valid representation in }\mathcal C.
$$

That map is exactly proper weak selection. Dovetailing over unknown
$P$-dependent exponents helps validation thresholds, but it does not create
the candidate list.

So the source is useful as a predictor oracle, not as a representation oracle.
I do not see a way to derive the fixed-marginal polynomial proper candidate
generator from the source definition alone.

### Last Negative Route: Sparse-Validity Weak Handles

Depth 4 rules out the cleanest false template: put exponentially many proper
codewords on a polynomial visible coordinate set and make every wrong codeword
correlation smaller than the target's hidden inverse-polynomial advantage.
Polynomial dense codes leave residual inverse-polynomial correlations; exact
orthogonality moves to a Hadamard-scale or non-atomic model.

The remaining negative idea is therefore not to eliminate weak handles. Let
weakly correlated non-target proper hypotheses exist, but make finding any
valid one computationally hard.

A candidate abstraction is:

- a fixed countable marginal $P^\star$ with a polynomially visible heavy set
  $H_s$;
- an easy improper learner that memorizes or majority-votes labels on $H_s$,
  giving the weak agnostic source marginal-by-marginal;
- proper concepts indexed by certificates $z$ satisfying a hard relation;
- labels on $H_s$ given by a code or test pattern $C_z$;
- any polynomial-time proper learner that finds
  $\mathbb E_{P^\star}[h(X)c_z(X)]\ge 1/\operatorname{poly}(s)$
  can be converted into a witness for the hard relation.

This is the right shape, but I could not instantiate it without reintroducing
one of the old failures.

If valid representations are easy to sample, as with ordinary seed-indexed
one-way image concepts, then random proper trials plus holdout validation tend
to find residual dense-code handles. On a polynomial block, wrong codewords
have correlations at some inverse-polynomial scale, and the target learner is
allowed to use a smaller hidden advantage.

If valid representations are made sparse so that random proper trials do not
work, then the construction needs a standard average-case assumption saying
that, from labeled samples, finding any valid representation matching even a
few high-mass tests is hard. I do not know an atlas-ready PCP or cryptographic
template with this property while preserving an easy weak agnostic improper
learner. PCP versions again need to encode instance identity under one fixed
marginal, and partial identity matches become weak handles unless the identity
code has the same hidden-gap-safe agreement property. One-way versions again
need every inverse-polynomially correlated valid codeword to decode the
challenge image, which is stronger than ordinary one-wayness.

The heavy-atom issue makes this especially sharp. Under any fixed countable
$P^\star$, some atoms carry fixed positive mass. A large proper family has a
large subfamily agreeing on the heaviest atoms. If finding one member of the
matching cell is easy, weak proper learning is easy. If finding one member is
hard, the counterexample rests on a sparse-validity search assumption that is
not supplied by the source and is not yet represented by a checked witness.

### Current Diagnosis

The depth-4 conditional theorem still captures the positive side:

> source learner + fixed-marginal polynomial proper candidate generator +
> validation = target.

This pass strengthens the negative diagnosis. A finite-encoded counterexample
cannot merely say that wrong proper hypotheses have negligible correlation;
that is blocked by polynomial dense-code bounds and, for exact orthogonality,
by fixed-marginal finite-encoding barriers. It must instead prove
computational weak-handle hardness: weak proper handles may exist, but finding
any valid one is hard.

I do not know how to get that from the standard PCP, clause, DNF, or one-way
templates without either making the hard marginal input-dependent, allowing
low-mass slices to be ignored, or leaving validation-findable residual handles.

### Depth-6 Directions And Obstacles

1. **Relativized no-selector model.** Build a toy oracle class where the
   oracle exposes an improper predictor or table for the target, but valid
   proper representations matching the heavy atoms are hidden. This would not
   be an atlas witness, but it would test whether the missing selector can be
   separated cleanly from prediction.

2. **Sparse-validity average-case witness.** Look for a standard hard relation
   where, under one fixed marginal, finding any valid representation with
   inverse-polynomial label correlation is hard, while an improper table
   learner remains weak agnostically efficient. The obstacle is avoiding
   easy random valid handles and avoiding nonuniform hard target sequences.

3. **Identity-protected shared PCP.** Search for a shared-coordinate PCP or
   agreement theorem where every inverse-polynomially correlated wrong-instance
   proof decodes the target instance. The obstacle is that ordinary perfect
   completeness gives unrelated satisfiable all-one handles, and explicit
   identity gates reintroduce slices or dense-code hidden-gap problems.

4. **Agreement stronger than distance.** Dense codes fail as a pure
   pairwise-distance template. A viable code witness would need the stronger
   property that every weakly correlated valid codeword yields the same hard
   certificate, even at an unknown inverse-polynomial threshold.

5. **Model-boundary decision.** Non-atomic or lazy-product examples make
   parity-image orthogonality plausible, but they appear outside the current
   finite-transcript atlas convention. A final pass should decide whether this
   is only a model warning or whether the atlas schema should explicitly record
   such variants.

6. **Positive structural subclasses.** Prove the implication for classes with
   efficient marginal-dependent weak covers, proper consistency search on
   high-mass finite supports, or approximate proper projection. This will not
   settle the abstract edge, but it identifies exactly what a counterexample
   must violate.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- depth-4 section of this scratchpad
- sibling scratchpad `efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: high that validation is not the issue; high that no generator follows black-box from the source; medium-high that any finite-encoded counterexample must use computational weak-handle hardness rather than pure hidden-gap-safe geometry

---

## Depth-6 Final Pass - 2026-05-05

- depth: 6
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: high that the atlas edge should remain open; medium-high that the best finite-string false route needs computational weak-handle hardness or a new all-length orthogonalization idea

### Focus

This final pass tried to make the most favorable remaining counterexample
honest. The useful refinement is that the one-length Hadamard/one-way-image
idea is stronger for this assigned edge than earlier notes suggested: for the
weak agnostic source, low-noise robustification can supply the agnostic
improper learner once a distribution-free realizable improper parity learner is
available. The obstruction is therefore not the single-length source. The
obstruction is turning the single-length hard marginal into one fixed
finite-string marginal for all representation sizes without leaking weak
proper handles.

I still do not see a valid proof or counterexample.

### Final Counterexample Attempt: One-Way Hadamard Images

At one fixed length $n$, let $f:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving
one-way function, and let the proper concepts be

$$
c_s(a)=(-1)^{\langle f(s),a\rangle},
\qquad a\in\{0,1\}^n.
$$

A proper representation is a seed $s$. An improper representation may be the
image coefficient $y=f(s)$ itself.

**Source side at one length.** On realizable labels under an arbitrary
marginal on $\{0,1\}^n$, Gaussian elimination over the sampled linear
constraints can output some parity coefficient $y'$ consistent with the
sample. Uniform convergence for the finite parity class then gives a
distribution-free realizable improper learner. The atlas
[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic
Robustification]] argument would turn this into a weak agnostic improper
learner: if $\operatorname{OPT}$ is not tiny, an improper constant fallback is
enough; if $\operatorname{OPT}$ is tiny, repeated clean batches and validation
recover a weak predictor.

So, unlike the strong agnostic Hadamard route, the weak source is not the main
problem here.

**Target side at one length.** Under the uniform marginal on
$a\in\{0,1\}^n$, distinct parity coefficients are orthogonal. Any proper
hypothesis with positive correlation against $c_s$ must output a seed $t$ with
$f(t)=f(s)$. A uniform polynomial-time weak proper learner for these
single-length marginals would invert $f$.

This almost gives a clean false witness. It fails for the atlas edge because
the marginal in that argument is $U_n$, which varies with $n$. The
marginal-nonuniform target may attach a different polynomial bound to each
$U_n$, so the reduction does not obtain one uniform polynomial-time inverter.

### Why The Fixed-Marginal Repair Still Fails

The natural repair is to pack the length marginals into one fixed distribution
$P^\star$, for example a mixture over blocks $(n,a)$ with conditional marginal
uniform on $a\in\{0,1\}^n$.

The repair runs into the same weak-handle problem in a sharper form.

1. **Length-local concepts dilute or leak defaults.** If the length-$n$
   Hadamard signal has mass $\mu_n$, then an agnostic hard distribution
   supported only on that block has best proper correlation at most $\mu_n$;
   the additive weak guarantee need not force useful information. If instead
   the labels are made realizable by defining the concept off the active block,
   common defaults, wrong lengths, or easy off-block behavior become proper
   weak handles.

2. **All-length shared codes need too much high-mass orthogonality.** To make
   realizable weak learning force information, the target-specific signal must
   occupy nonnegligible $P^\star$-mass for every $n$. But a fixed finite-string
   marginal is countably atomic. High-mass early atoms cannot carry
   near-orthogonal signatures for exponentially many length-$n$ seeds for all
   $n$, while moving the distinguishing coordinates into fresh large blocks
   pays tail mass and returns to dilution.

3. **Approximate finite codes leave hidden-gap handles.** Polynomially visible
   shared-coordinate codes can push wrong correlations below a chosen
   inverse-polynomial scale, but the target's advantage $\gamma_{P^\star}(s)$
   is hidden and may be smaller. Such wrong codewords remain legal weak proper
   outputs unless every weakly correlated wrong output also decodes the hard
   witness.

4. **Atomless product spaces would change the model.** If examples were
   infinite random bit strings under product measure, Walsh/Hadamard
   orthogonality across all finite coefficients would make the counterexample
   much more plausible. Under the atlas finite-encoded transcript convention,
   this is a model-boundary warning, not an admissible witness.

Thus the Hadamard image attempt improves the diagnosis but does not resolve
the edge. It says: the source can be made easy in the weak setting; the missing
piece is a fixed finite-string marginal on which every inverse-polynomially
correlated proper output is computationally useful.

### Atlas-Ready Open Summary

No atlas status change is justified. The edge should remain:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
summary: "Open: the source gives an external weak agnostic predictor, but no generic efficient projection to a weakly correlated proper concept is known. The closest one-way Hadamard repair works at one length, yet fixed finite-string marginals either dilute the hard signal, leak weak proper handles, or require all-length orthogonality outside the atlas model."
```

Suggested body text:

```markdown
## Verdict

`open`.

On realizable labels, the source gives an improper predictor with positive
inverse-polynomial correlation under the same marginal. Validation would
convert any polynomially generated list of legal concepts into the target, but
the source does not generate such a list. It supplies prediction, not a
representation-level selector for $\mathcal C$.

The closest false route is a one-way Hadamard image construction. At one fixed
length, an improper learner can learn the image parity coefficient, and
low-noise robustification gives the weak agnostic improper source. A proper
weak learner under the uniform length-$n$ marginal would have to output a seed
with the same one-way image. This does not refute the marginal-nonuniform
target because the hard marginal varies with $n$.

Packing all lengths into one fixed finite-string marginal reintroduces the
weak-properization obstacles. Length-local blocks dilute the weak signal or
allow wrong-length/default handles. Polynomial shared-coordinate codes leave
inverse-polynomial residual correlations below the target's hidden weak gap.
Exact all-length Walsh/Hadamard orthogonality appears to require an atomless or
infinite-product instance model rather than finite encoded examples. A genuine
counterexample would need computational weak-handle hardness: weak proper
handles may exist, but finding any one of them must decode the hard witness.
```

### Strongest Obstacles

1. **No black-box selector.** The source learner can be run many times and
   validated, but every route to a legal $h\in\mathcal C$ reintroduces proper
   consistency, proper ERM, projection, or candidate generation.

2. **Input-dependent hard marginals.** PCP active slices and one-length
   Hadamard images give the right local weak gap only by choosing a marginal
   tied to the hard instance size or identity. Marginal nonuniformity absorbs
   that dependence.

3. **Fixed mixtures dilute weak gaps.** If each hard subproblem receives mass
   $\mu_n$, then weak additive guarantees can ignore low-mass information, and
   realizable off-block behavior tends to create easy proper handles.

4. **Pure geometry cannot beat the hidden gap.** Polynomial finite-coordinate
   codes leave some inverse-polynomial wrong correlation scale; the target's
   marginal-dependent advantage may be smaller.

5. **Exact orthogonality crosses a model boundary.** Product-measure
   Walsh/Hadamard systems suggest a false witness in a richer instance model,
   but the atlas finite-transcript setting needs finite encoded examples and a
   polynomial-time learner.

### Future Directions

1. **Computational weak-handle hardness.** Find a fixed finite-string marginal
   where every proper hypothesis with any inverse-polynomial positive
   correlation yields a preimage, proof, assignment, or other hard witness,
   while an improper weak agnostic learner remains efficient.

2. **Identity-protected all-length Hadamard codes.** Try to protect the
   one-length Hadamard construction against wrong-length/default handles
   without moving the useful coordinates into a low-mass tail.

3. **Wrong-output usefulness theorem.** Replace pairwise distance by an
   agreement statement: every weakly correlated wrong proper output should be
   convertible into the same hard witness. This is the missing property in the
   PCP, dense-code, and one-way attempts.

4. **Positive structural subclasses.** Prove the implication for classes with
   efficient fixed-$P$ weak covers, proper consistency search on high-mass
   supports, approximate proper projection, or legal concept samplers. These
   results would not settle the abstract edge, but they would mark exactly what
   a counterexample must avoid.

5. **Model-boundary note.** If the atlas ever admits atomless product examples
   or oracle-valued examples, revisit the all-length Walsh/Hadamard image
   construction. Under current finite-string conventions, record it only as a
   warning.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- sibling scratchpad `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: high for leaving the atlas edge open; medium-high that the
single-length Hadamard route is the closest known false template but fails at
the fixed finite-string marginal step
