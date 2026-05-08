# Edge: efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-realizable-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-improper-pac`
- target: `efficient-realizable-improper-pac`
- verdict: unresolved-open
- confidence: 0.88
- worker constraint: scratchpad only; no atlas files edited

## Executive Verdict

I do not see an atlas-ready theorem or counterexample. The edge should remain
`open`.

The important update is diagnostic. Under the atlas worst-case finite-transcript
efficiency convention, the marginal-dependent sample and time bound for one call
to the source learner can be made distribution-free by the full-support
reference-marginal argument. The remaining obstruction is the weak advantage,
not the pathwise cost of invoking the weak learner once.

The source gives one learner $A$ such that for every marginal $P$ there is an
inverse-polynomial advantage

$$
\gamma_P(s) \ge s^{-k(P)}
$$

and $A$ returns an improper hypothesis with error at most
$1/2-\gamma_P(s)$ on realizable labels from $P$. The target needs arbitrary
error $\varepsilon$ with one polynomial runtime/sample bound independent of
$P$. Standard realizable boosting would prove the edge if the weak advantages
on all booster-generated marginals had one distribution-free inverse-polynomial
lower bound. The source only gives a separate inverse-polynomial bound for each
marginal.

## Sources Checked

Local atlas files:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- neighboring scratchpads for marginal weak-to-strong, weak-agnostic-to-realizable, and strong marginal-to-distribution-free edges

Primary-source anchors checked:

- Schapire, "The Strength of Weak Learnability" (1990), DOI
  https://doi.org/10.1023/A:1022648800760 and author PDF
  https://www.schapire.net/papers/strengthofweak.pdf. Used for the
  distribution-free weak-to-strong boosting theorem and for the fact that the
  construction filters/reweights examples.
- Freund, "Boosting a Weak Learning Algorithm by Majority" (1995), DOI
  https://doi.org/10.1006/inco.1995.1136. Used for boost-by-majority and its
  distribution-dependent accuracy extension, which is a near miss because it
  assumes quantitative control of accuracy as distributions change.
- Feldman, "Distribution-Specific Agnostic Boosting" (2010), arXiv
  https://arxiv.org/abs/0909.2927. Used as a same-marginal boosting comparison;
  it modifies labels rather than the instance marginal, but needs an agnostic
  weak oracle.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS
  2025), OpenReview https://openreview.net/forum?id=aoVCFtox89. Used for the
  marginal-nonuniform quantifier pattern: rates may depend on the marginal but
  must hold uniformly over concepts.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae
  and Finite Automata" (1994), DOI https://doi.org/10.1145/174644.174647, for
  comparison with cryptographic hard-marginal witnesses.

## Current Edge State

The edge note currently records the implication as open:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

This is still a reasonable status, but the summary is now too coarse. The
strong-source sibling

```text
efficient-marginal-nonuniform-realizable-improper-pac -> efficient-realizable-improper-pac
```

is true under the full-support finite-transcript convention: resource
uniformization works when the source already has arbitrary accuracy. For the
present weak source, resource uniformization still works for a single weak call,
but the weak gap remains marginal-dependent.

## Positive Route 1: Full-Support Marginal Uniformization

Let $A$ be the single source learner. Choose a full-support reference marginal
$P^\star$ over every finitely encoded instance in each representation-size
slice. Applying the source to $P^\star$ gives a polynomial
$p_{P^\star}(s,\log(1/\delta))$ bounding sample use and running time of $A$.

Because $P^\star$ assigns positive mass to every finite encoded instance, any
finite labeled transcript that can occur under any marginal also has positive
probability under $P^\star$ for the same target labels. Under the atlas
pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on such a
transcript. Thus one call to $A$ has a distribution-free polynomial sample and
time bound.

This proves only the resource half of a distribution-free weak learner. The
accuracy statement available for the actual marginal $P$ is still

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s),
$$

with $\gamma_P$ allowed to have a $P$-dependent exponent. The distribution-free
weak node, and hence the standard boosting route to the strong target, would
need one inverse-polynomial lower bound independent of $P$.

So full-support uniformization is necessary bookkeeping, not a resolution.

## Positive Route 2: Ordinary Realizable Boosting

Schapire/Freund boosting would convert the source into the target if we had a
uniform weak edge. A typical target proof would need a statement like

$$
\exists r\ \forall Q \in \mathcal Q(P,c,\varepsilon,\delta)\quad
\gamma_Q(s) \ge 1/r(s,1/\varepsilon),
$$

where $\mathcal Q(P,c,\varepsilon,\delta)$ is the family of filtered or
reweighted marginals generated during boosting from original marginal $P$ and
target $c$.

The source only gives

$$
\forall Q\ \exists r_Q\quad \gamma_Q(s)\ge 1/r_Q(s).
$$

This quantifier order is not enough. The induced marginals $Q_t$ can depend on
the target concept, previous weak hypotheses, empirical validation outcomes,
and the requested accuracy. The target learner needs a single polynomial bound
independent of all of that.

Freund's distribution-dependent extension is a close structural match but still
requires a quantitative envelope on the weak accuracy as filtered distributions
move away from the original distribution. The atlas source has no continuity,
KL-stability, bounded-density stability, or local compactness condition on
$Q \mapsto \gamma_Q$.

## Positive Route 3: Smooth Boosting

A smoother booster might ensure each induced marginal satisfies

$$
Q_t \ll P,
\qquad
\left\|dQ_t/dP\right\|_\infty \le B(s,1/\varepsilon).
$$

This would settle the edge if the source implied a bounded-density weak-gap
envelope:

$$
\inf_{\substack{Q\ll P\\ \|dQ/dP\|_\infty\le B}}
\gamma_Q(s)
\ge
1/r(s,B)
$$

for one distribution-free polynomial $r$. I do not see a way to derive this.
At the level of the source quantifiers, bounded-density marginals can still
have weak gaps such as $s^{-j}$ on thinner and thinner residual slices, with
$j$ growing with the accuracy scale. Each $Q$ separately remains
inverse-polynomial, but no uniform polynomial envelope follows.

This is not a counterexample by itself; it is the main barrier to a black-box
positive theorem.

## Positive Route 4: Same-Marginal Boosting

Distribution-specific agnostic boosting avoids changing the instance marginal
by changing labels or target functions. That is attractive because the source
advantage $\gamma_P$ would then be tied to the original marginal $P$ rather than
to booster-generated marginals.

For this edge the source is only realizable. Same-marginal relabeling creates
noisy or agnostic labeled distributions that need not be realizable by any
concept in $\mathcal C$, so $A$ has no promised behavior on those calls.

Even for stronger weak-agnostic source nodes, the atlas notes record a
quantitative near miss: known fixed-marginal agnostic boosters need a tunable
correlation or threshold weak oracle. A fixed additive guarantee of the form
`OPT + 1/2 - gamma_P` leaves an additive floor depending on the hidden weak gap.
That can give marginal-nonuniform strong learning at best, not the present
distribution-free target.

## Positive Route 5: Diagonal Weak-Gap Uniformization

There is a tempting diagonal proof. Suppose no uniform weak-gap envelope exists.
For every exponent $k$, choose a marginal $Q_k$ and size $s_k$ for which the
available weak gap is below $s_k^{-k}$. Stitch these bad cases into one
marginal $R$. Since the source must weakly learn under $R$ with some
inverse-polynomial gap $s^{-K(R)}$, perhaps this contradicts the chosen
sequence.

I do not think this is atlas-ready under the current global-marginal reading.
In a global mixture $R=\sum_k w_k Q_k$, the learner can ignore sufficiently
low-mass bad components and still beat $1/2$ by an inverse-polynomial amount on
the mixture. Strong learning to small $\varepsilon$ cannot ignore them, but
that is exactly the target gap we are trying to prove.

The diagonal proof would become more plausible under a size-indexed semantics
where a marginal is a family $(P_s)_{s\ge 1}$ and accuracy is evaluated on the
active size slice without dilution. The current atlas notes do not seem to
commit to that stronger semantics.

## Counterexample Search

A false witness must be subtler than the standard computational-hardness
examples. It needs:

1. one uniform learner that, for every marginal $P$, finds some improper weak
   predictor with a $P$-dependent inverse-polynomial advantage;
2. no distribution-free polynomial-time strong improper learner;
3. the obstruction to survive the fact that source outputs are already
   improper, so proper representation recovery cannot be the hard part;
4. the obstruction to live in the weak-gap envelope rather than in one-call
   runtime, because full-support transcript uniformization controls the latter.

### Pseudorandom Functions

PRF-style finite keyed classes are not valid witnesses. They can fail the
distribution-free strong target under a cryptographic hard marginal, but the
same hard marginal also rules out the marginal-nonuniform weak source. A weak
learner on that marginal would distinguish pseudorandom labels from random
labels.

### One-Way Image-Coordinate Classes

The ordinary one-way image-coordinate class and the weak-handle variant separate
proper targets, not this improper target.

For a length-$n$ image-coordinate target, there are only $n$ positive atoms. An
improper learner can memorize observed positive atoms and predict $0$
elsewhere, achieving distribution-free strong realizable learning with
polynomial samples and time. The one-way lower bound forces recovery of a seed
only for proper hypotheses. Since the current target is improper, these
witnesses are target-positive.

### PCP Active-Slice Lookup Classes

The PCP active-slice lookup class is also not a witness. It is useful for weak
improper versus weak proper separations, because a proper weak learner on the
active slice would find a good proof. But the current source is already
improper and the target is improper. On a polynomial-size active slice, lookup
memorization gives strong improper realizable learning.

### Rare-Slice Hidden-Gap Template

The most plausible false template is a direct sum of slices

$$
\mathcal X = \bigsqcup_{j\ge 1} X_j
$$

where one weak handle on slice $j$ is easy but has advantage about $s^{-j}$,
while strong prediction on enough slices requires aggregating many such handles
or solving a hard residual problem. For each fixed marginal, the mass profile
would determine a finite effective exponent, but no distribution-free exponent
would work across all residual marginals.

I do not have an atlas-valid construction. If the handles are findable on every
residual marginal, an improper booster can usually aggregate them. If finding
enough independent handles is made cryptographically hard, the source tends to
fail on the marginal concentrated on the hard slice. Rare slices alone also do
not work, because the source quantifies over marginals that isolate those
slices.

### Randomized-Prediction Hidden Gap

One tempting toy construction lets a weak learner output a randomized
hypothesis that has a tiny positive correlation on every marginal, while any
deterministic low-error predictor is hard. This does not fit the atlas target
cleanly. The target allows improper hypotheses, and the source/target notes
usually treat randomized hypotheses by their induced error. If the randomized
weak predictor is sampleable and evaluable, boosting can often reduce its error
unless the weak edge is exactly the hidden-gap obstruction again. This remains
a diagnostic toy, not a witness.

## Proposed Atlas Update If Edits Are Later Allowed

I would leave the edge `open`, but move the diagnosis from generic marginal
uniformization toward weak-gap uniformization / marginal boosting.

Suggested metadata:

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
summary: "Open: full-support marginal uniformization controls the runtime of one weak call, but the source gives only marginal-dependent weak advantages; no known boosting or diagonal argument yields one distribution-free polynomial strong learner."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested proof-status body:

```markdown
`open`.

Full-support marginal uniformization controls the sample use and runtime of one
call to the single source learner under the atlas worst-case finite-transcript
efficiency convention. It does not uniformize the weak advantage: the source
only gives a marginal-dependent inverse-polynomial gap `gamma_P(s)`.

Standard realizable boosting would prove the target if all filtered or
reweighted marginals generated during boosting had one distribution-free
inverse-polynomial weak-gap lower bound. The source supplies a gap for each
such marginal separately, and those marginals may depend on the target concept,
the boosting history, and the requested accuracy.

Known witness families do not settle the edge. PRF-style hard marginals fail
the source, one-way image-coordinate witnesses are strong-improper learnable by
memorization, and PCP active-slice witnesses separate properness rather than
improper prediction. A proof would need a weak-gap uniformization theorem; a
counterexample would need source-positive but computationally nonboostable weak
handles.
```

## Follow-Up Directions

1. Formalize a `weak-gap-uniformization-open` lemma or argument family. These
   edges are not blocked by one-call resource uniformization after the
   full-support argument; they are blocked by missing quantitative control of
   $\gamma_Q$ over induced marginals.

2. Check whether Freund's distribution-dependent boosting theorem can be
   adapted to a bounded-density or KL-stable marginal-nonuniform axiom. This
   would not prove the current edge, but it would identify the exact additional
   condition that makes the proof work.

3. Decide the atlas semantics for marginals across representation-size slices.
   A size-indexed semantics may permit a diagonal weak-gap proof; the current
   global-mixture reading appears to leave dilution loopholes.

4. Search for a concrete rare-slice or oracle class with cheap first weak
   handles but hard handle aggregation, while preserving the source for every
   isolated slice. This is the most plausible false-witness route I found, but
   it is still only a template.

5. Revisit the neighboring edge
   `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac`.
   If that weaker distribution-free weak edge is resolved true, the present
   edge follows immediately by Schapire/Freund boosting. If it is resolved
   false, the same witness may resolve this edge false.

## Depth 2 Followup: Rare-Block Transfer To The Distribution-Free Strong Target

- depth: 2
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

### Question For This Pass

The neighboring marginal-strong edge

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
  -> efficient-marginal-nonuniform-realizable-improper-pac
```

now has a rare-block PRF/oracle route: rare active blocks have
marginal-nonuniform weak singleton handles, but strong improper learning under
one fixed mixture marginal would require predicting many unseen pseudorandom
or oracle-random labels.

The question here is whether that construction also refutes the present
distribution-free strong target, or whether changing the target makes the
problem easier.

### Transfer Verdict

The distribution-free strong target is harder to satisfy than the
marginal-nonuniform strong target. Formally,

```text
efficient-realizable-improper-pac
  => efficient-marginal-nonuniform-realizable-improper-pac.
```

Therefore any class satisfying the weak marginal-nonuniform source while
failing the marginal-nonuniform strong target automatically fails the present
distribution-free target. If the rare-block PRF singleton-handle witness from
the marginal-strong edge is accepted, no new construction is needed for this
edge.

There is also a sharper target-side observation: for the distribution-free
target, the rare mixture is overkill. The lower bound can concentrate the test
marginal on one hard block whose exponent is larger than the alleged global
target polynomial degree. The target is harder to prove and easier to refute.

### Cleaner Isolated-Block Lower Bound

Use the same block family as in the rare-block route. For fixed $n$ and block
level $j$, let

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=N_{n,j}=n^j.
$$

A key $k$ defines an active-block concept

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

with value $0$ off the active block. In the oracle version, replace $F_k(u)$
by an independent random-oracle bit.

Suppose a distribution-free strong improper learner $L$ has sample and time
bound

$$
q(s,1/\varepsilon,\log(1/\delta))
$$

of total degree $D$. Choose a fixed block level $j>D+10$ and put the test
marginal $D_{n,j}$ uniformly on $B_{n,j}$. Ask for a constant accuracy, say
$\varepsilon=1/64$.

For large $n$, the learner sees only $O(n^D)=o(N_{n,j})$ active coordinates.
In the oracle version, conditioned on the observed active coordinates, the
labels on a fresh unseen coordinate are still independent random bits. Thus
no output hypothesis, even an improper one, can predict the active block with
conditional error below a constant. In the PRF version, a low-error hypothesis
that is polynomial-time evaluable would predict $F_k(u)$ on fresh
$u\in U_{n,j}$ with constant advantage, distinguishing the PRF from a random
function.

This is strictly simpler than the fixed-mixture lower bound needed for the
marginal-strong target. There is no hidden $q_P$ and no need to encode the
hard block through $1/\varepsilon=\Theta(1/w_{n,j})$: the single global target
polynomial must handle every marginal, including the marginal concentrated on
this one block.

### Source-Side Reuse And Caveat

The source side should be imported from the rare-block witness, not reproved
by a new target-specific trick. Under a marginal concentrated on
$B_{n,j}$, one observed positive coordinate gives an improper singleton or
paired-coordinate handle with advantage about $1/N_{n,j}=n^{-j}$; the source
allows this exponent to depend on the marginal. Under an arbitrary global
marginal $R$, low-mass active blocks are handled by a constant, while only
finitely many high-mass blocks can force singleton-handle behavior, so their
exponents can be absorbed into the $R$-dependent weak gap.

The important caveat is the same one noted in the marginal-strong scratchpad:
the final source lemma must respect the atlas pathwise resource convention.
The one-call runtime of the weak learner cannot secretly scale like $n^j$ on
high-block transcripts, because full-support marginal uniformization would
expose those transcripts. The rare-block construction is viable only if the
large quantity $n^j$ appears in the weak advantage and in the number of
handles needed for strong learning, not in the runtime of one weak call.

This caveat does not create a new obstruction for the present edge; it is a
shared atlas-readiness condition for the witness itself.

### Relation To The First-Pass Diagnosis

The first pass said that weak-gap uniformization blocks a positive proof. The
rare-block route explains how that obstruction could become a false witness:
on block level $j$, the weak gap is about $n^{-j}$, and an improper strong
learner must aggregate information from a constant fraction of the
$n^j$ independent coordinates. A distribution-free target polynomial has one
fixed degree, so choosing $j$ above that degree defeats it immediately.

Thus the target is not easier than the marginal-strong target. It is stronger.
The only reason the atlas verdict should not immediately flip is that the
rare-block witness still needs a clean source lemma and, for the PRF version,
an explicit efficient-hypothesis-evaluation convention.

### Depth 3 Directions

1. Decide whether to record this edge as a direct corollary of the
   marginal-strong rare-block witness or as a separate, simpler isolated-block
   lower bound. The second presentation is cleaner for this distribution-free
   target.

2. Prove the source lemma in a pathwise-compatible form. The writeup must show
   one uniform weak learner, with fixed polynomial transcript resources, whose
   marginal-dependent weakness comes only from the hidden gap
   $\gamma_R(s)$.

3. Check the default-orientation issue for singleton or paired-coordinate
   handles under arbitrary marginals. The source proof should not rely on
   validating a bias at scale $1/n^j$ unless that validation cost is already
   pathwise polynomial.

4. State the target lower bound against an alleged distribution-free learner:
   fix the learner, let $D$ be its polynomial degree, choose constant
   $j>D+10$, put the marginal uniformly on $B_{n,j}$, and take
   $n\to\infty$.

5. Settle the hypothesis-output convention. The oracle version gives a clean
   no-free-label lower bound; the PRF version additionally needs that an
   efficient improper learner's printed hypothesis can be evaluated in
   polynomial time on fresh instances.

### Depth 2 Verdict

verdict: conditionally-false route transfers from the marginal-strong edge;
for this distribution-free target, an isolated hard block is enough. The
atlas-safe status should remain `open` until the rare-block witness source
lemma and evaluator convention are written cleanly.

confidence: 0.88 that any valid rare-block counterexample to the
marginal-strong edge refutes this edge; 0.82 that the isolated-block
PRF/oracle lower bound is the right target-side proof; 0.74 that the full
counterexample is atlas-ready without further source-lemma work.

## Depth 3 Followup: Current-Conventions Candidate Decision

- depth: 3
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

### Decision

Under the current written atlas conventions, do **not** update this edge to
`false` yet. It should remain `open`, but the open note can now be sharpened
to record the rare-block PRF/oracle construction as the leading candidate
counterexample.

The reason is not target-side uncertainty. For this distribution-free target,
the lower bound is cleaner than for the sibling marginal-strong target: an
isolated hard block is enough. The remaining atlas-readiness issues are:

1. the rare-block source lemma still needs to be written as a
   pathwise-compatible uniform weak learner, with no hidden validation cost
   depending on the block level; and
2. the PRF lower bound needs an explicit efficient-output convention saying
   that an improper hypothesis printed by a polynomial-time learner is
   polynomial-time evaluable on fresh encoded instances.

The current `atlas/README.md` gives pathwise polynomial sample and training
time bounds for computationally efficient nodes, but it does not explicitly
state the second convention for improper outputs. The definition notes say
that the learner outputs a hypothesis $h$, possibly outside $\mathcal C$, but
do not spell out a prediction-time evaluator requirement. That is standard in
computational PAC learning, and existing cryptographic witness notes implicitly
use it, but it is not yet an explicit atlas convention.

### Isolated-Block Target Lower Bound

Assume an efficient distribution-free strong improper learner $L$ exists, with
one polynomial resource bound

$$
q(s,1/\varepsilon,\log(1/\delta))
$$

of total degree $D$. Use the rare-block family

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=N_{n,j}=n^j,
$$

and the active-block target

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

with zero labels off the active block. In the oracle version, replace $F_k(u)$
by an independent random-oracle bit.

Choose a fixed block level $j>D+10$, put the test marginal uniformly on
$B_{n,j}$, and ask for constant accuracy, say $\varepsilon=1/64$ and constant
$\delta$. For large $n$, the learner sees only $O(n^D)$ active examples while
the block contains $n^j$ independent coordinates. In the random-oracle version,
conditioned on the training transcript, the labels on fresh unseen coordinates
remain independent random bits, so no output can have conditional block error
as low as $1/64$.

In the PRF version, the same calculation becomes a distinguisher only if the
reduction can evaluate the learner's printed hypothesis on fresh pairs

$$
h(n,j,u,0),\qquad h(n,j,u,1).
$$

Low block error would then predict $F_k(u)$ with constant advantage, while the
random-function hybrid gives only $1/2+o(1)$ success. This is the standard
Kearns-Valiant style PRF contradiction, but it depends on polynomial-time
evaluation of improper outputs.

### Source-Side Status

The intended source proof is still the same rare-block singleton-handle
argument:

- constants handle active targets whose positive mass under the current
  marginal $R$ is bounded away from $1/2$;
- when the positive mass is near $1/2$, the active block must be $R$-heavy;
- for fixed $R$, only finitely many blocks are $R$-heavy, so singleton or
  paired-coordinate handles on those blocks give an $R$-dependent
  inverse-polynomial weak gap.

This is plausible, and the sibling scratchpad has pushed it close to a
draftable lemma. Still, it should not be treated as an atlas witness until the
uniform learner is specified with the pathwise convention in mind. In
particular, the proof must not select among constants and singleton handles by
running validation at scale $n^{-j}$ on arbitrary high-$j$ transcripts, since
those same finite transcripts occur under a full-support reference marginal.
The hidden block level may appear in the weak advantage, but not as an
unbounded one-call transcript resource.

### Candidate Atlas Note Under Current Conventions

If atlas edits were allowed without changing conventions, I would keep the
edge open and use wording like:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open under current conventions: a rare-block PRF/oracle singleton-handle construction is the leading candidate counterexample. The isolated-block target lower bound is clean, but atlas incorporation still requires a pathwise source lemma and an explicit convention that efficient improper outputs are polynomial-time evaluable."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested body addendum:

```markdown
**Current best candidate.** A rare-block PRF singleton-handle class appears to
separate the source from the target. For the source, constants and
sample-found singleton handles should give marginal-nonuniform weak
realizable improper learning under each fixed marginal. For the target, an
alleged distribution-free strong learner can be defeated on a single uniform
hard block whose level exceeds the degree of its global polynomial; the learner
sees too few active coordinates to predict unseen PRF or oracle-random labels.

**Why this is not yet a false edge.** The source proof must be written so that
one weak call has pathwise polynomial resources under the atlas convention.
The PRF proof also needs the standard computational-PAC convention that
improper hypotheses output by efficient learners are polynomial-time evaluable.
Until these are recorded in an argument/witness note or as global conventions,
the construction should remain a candidate rather than graph-level evidence.
```

If the evaluator convention is later made global and the source lemma is
written cleanly, the edge should be eligible for:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - secure pseudorandom functions exist
witnesses:
  - rare-block-prf-singleton-handle-class
summary: "False under PRF security: rare active blocks have marginal-nonuniform weak singleton handles, but a distribution-free strong learner would predict unseen pseudorandom labels on an isolated hard block."
```

If the evaluator convention is not made global, add it as an explicit local
assumption before using the PRF witness. If the atlas accepts relativized
evidence, the random-oracle version can be recorded as the clean formal core;
otherwise it should remain a diagnostic rather than the graph-level witness.

### Depth 4 Directions

1. Write the pathwise source lemma first. Specify one uniform weak learner and
   prove that, for every fixed marginal $R$, constants plus observed positive
   singleton or paired-coordinate handles give an $R$-dependent
   inverse-polynomial advantage without hidden high-level validation costs.

2. Decide the evaluator convention. Prefer a global README clarification:
   efficient improper PAC outputs are finite encoded hypotheses with a uniform
   prediction procedure running in time polynomial in the instance length and
   output length. Otherwise add this as an explicit assumption on the new
   rare-block PRF argument note.

3. Draft `rare-block-prf-singleton-handle-class.md` and a matching argument
   note. Keep source positivity, the isolated-block distribution-free lower
   bound, and the PRF/random-oracle hybrid as separate lemmas.

4. After those notes exist, update this edge only, unless a separate audit
   checks propagation to neighboring weak-to-strong improper edges. The
   distribution-free target proof should use the isolated uniform block with
   constant $\varepsilon$, not the fixed-mixture marginal used for the
   marginal-strong sibling.

### Depth 3 Verdict

verdict: remain `open` under current atlas conventions, with the rare-block
PRF/oracle singleton-handle construction recorded as the leading candidate
counterexample rather than as installed graph evidence.

confidence: 0.90 that the edge should not be flipped under the current written
conventions; 0.83 that, after a pathwise source lemma and an efficient-output
evaluator convention are installed, the isolated-block PRF construction should
make the edge conditionally `false`.

## Depth 4 Followup: Tiny-Bias Orientation Blocks The Source Lemma

- depth: 4
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

### Question For This Pass

Can the intended source proof be completed under the current definitions? More
precisely, do constants plus sample-found singleton or paired-coordinate
handles give one uniform learner that, for every fixed marginal $R$, has a
marginal-dependent inverse-polynomial weak realizable advantage?

### Verdict

No, not for deterministic ordinary hypotheses under the current atlas
definitions. The proposed source lemma fails before the target lower bound and
before the efficient-output evaluator issue.

The exact failure is a default-orientation problem on one high-scale balanced
block. Sample-found handles correct only the coordinates seen in the sample.
If the learner predicts a deterministic default on all unseen coordinates, then
it must choose the sign of an arbitrarily tiny bias in the marginal's positive
mass. A fixed-polynomial sample transcript cannot distinguish the two possible
signs, while the wrong default is not rescued by the sampled handles.

### Setup

Use the rare-block active concept on one block

$$
B_{n,j}=\{(n,j,u,b):u\in [r],\ b\in\{0,1\}\},
\qquad r=n^j.
$$

For a Boolean function $f:[r]\to\{0,1\}$, let

$$
c_f(n,j,u,b)=1 \Longleftrightarrow b=f(u),
$$

and let $c_f$ be $0$ off this block. A sample from coordinate $u$ reveals the
correct labels of both $(u,0)$ and $(u,1)$, so paired-coordinate handles are at
least as strong as singleton-positive handles. This means a failure for
paired-coordinate handles is the relevant obstruction.

By the atlas pathwise resource convention, any one uniform marginal-nonuniform
source learner would have a fixed global polynomial transcript bound after the
full-support reference-marginal argument. Write the number of examples used at
confidence $\delta=0.1$ as

$$
m(s)\le s^T
$$

for some fixed exponent $T$. Choose a block level $j$ and large $n$ so that

$$
r=n^j \gg m(s)^2.
$$

Now define two marginals on the same active block, both realizable by the same
target $c_f$:

$$
P_+(u,f(u))=\frac{1+2\eta}{2r},\qquad
P_+(u,1-f(u))=\frac{1-2\eta}{2r},
$$

and let $P_-$ swap these two weights. Thus the positive mass is
$1/2+\eta$ under $P_+$ and $1/2-\eta$ under $P_-$. Take, for example,

$$
\eta = 10m(s)/r.
$$

### Why Handles Do Not Rescue The Wrong Default

Consider any hypothesis that is correct on sampled coordinate pairs and then
uses default $0$ on every unseen coordinate in the active block. Under $P_+$,
its error is at least

$$
\frac12+\eta-\frac{m(s)}{r}
>
\frac12.
$$

The sampled handles can remove at most the total positive mass of the sampled
coordinates, which is bounded by $O(m(s)/r)$ pathwise. Symmetrically, a
default-$1$ unseen-coordinate hypothesis has error above $1/2$ under $P_-$.
Thus a deterministic constants-plus-handles learner must choose opposite
defaults on $P_+$ and $P_-$ with high probability.

But the $m(s)$-sample transcript distributions under $P_+$ and $P_-$ are
statistically close:

$$
\operatorname{TV}(P_+^{m(s)},P_-^{m(s)})
\le O(m(s)\eta)
= O(m(s)^2/r)
= o(1).
$$

So no fixed-polynomial sample procedure can choose the $P_+$ orientation with
probability at least $0.9$ and the opposite $P_-$ orientation with probability
at least $0.9$. This is not a proof-technical validation nuisance; it is the
statistical indistinguishability of the two marginals at the very scale where
the hidden weak gap is supposed to live.

### Consequences For The Candidate Witness

Constants still handle marginals whose positive mass is bounded away from
$1/2$, and sample-found handles really do provide a tiny improvement once the
right default orientation is known. The broken step is the claim that one
gap-oblivious deterministic learner can select that orientation for every
marginal without spending samples polynomial in the hidden block size $r$.

Prediction-time randomization would change the picture. A stochastic predictor
that is correct on sampled coordinates and flips a fair coin on unseen active
coordinates would have error

$$
\frac12-\Omega(m(s)/r)
$$

on the uniform hard block without choosing a default orientation. However, the
current atlas definitions say the learner outputs a hypothesis $h$ with
zero-one error; they do not install a convention allowing randomized
prediction as the final hypothesis. Under the current deterministic reading,
the source lemma is not available.

This leaves the rare-block PRF/oracle route below atlas-ready status. The
target lower bound may still be the right shape, but the source side needs a
different deterministic orientation-free handle gadget, or an explicit
definition/convention change allowing stochastic improper hypotheses. The
efficient-output evaluator convention remains necessary for the PRF target
argument, but it is no longer the first blocker.

### Depth 4 Verdict

verdict: source lemma fails as stated under current definitions.

confidence: 0.86 that deterministic constants plus sample-found singleton or
paired-coordinate handles do not prove the marginal-nonuniform weak realizable
improper source for the rare-block candidate; 0.75 that a stochastic-output
convention would repair this particular source-side obstruction, while still
requiring separate target-side convention work.

## Depth 5 Followup: Stochastic Handles And Deterministic Escape Routes

- depth: 5
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

### Question For This Pass

Depth 4 refuted the deterministic singleton/paired-handle source lemma because
the learner must choose an unseen-coordinate default orientation, and two
opposite tiny-bias marginals are statistically indistinguishable at any fixed
pathwise polynomial sample scale. This pass asks whether the false route can
be saved by:

1. allowing stochastic final hypotheses;
2. replacing constants plus handles by richer deterministic improper
   hypotheses; or
3. changing the construction while staying within the current atlas
   conventions.

### Short Verdict

I still do not see an atlas-ready counterexample. Under the current atlas
reading, the edge should remain `open`.

Stochastic prediction would repair the particular orientation obstruction, but
only after a definition or convention change. Richer deterministic hypotheses
do not seem to repair the rare-block route: on unseen coordinates they either
collapse to a hidden default-orientation choice, or they must contain
nontrivial deterministic information about the hidden labels, which would
undercut the isolated-block target lower bound. I also do not see a different
deterministic construction that avoids the same near-balanced-marginal
obstruction without adding an easy weak signal strong enough to threaten the
hardness argument.

### Stochastic Final Hypotheses

If final hypotheses were allowed to randomize at prediction time, the source
side would become much cleaner. A weak learner could memorize the sampled
coordinate pairs and, on every unseen active coordinate, output a fresh fair
coin. Let $W$ be the marginal mass of coordinate fibers whose labels were
learned from the sample. Conditional on the training transcript, the expected
zero-one error over prediction coins is

$$
\operatorname{err}(h,c)
=
\frac12(1-W)
=
\frac12-\frac{W}{2}.
$$

This is orientation-free: on uncovered coordinates, a fair coin has error
$1/2$ regardless of whether the marginal puts mass $1/2+\eta$ or
$1/2-\eta$ on the positive side. On a uniform block with $r$ fibers and
$m$ observed examples, $W\approx m/r$, so the weak advantage is about
$m/(2r)$. For each fixed block-level marginal this is still inverse
polynomial in the representation size, with an exponent depending on the
marginal.

This does not fit the present definition note, which says the learner outputs
a hypothesis $h$ and measures ordinary zero-one error. The atlas has
randomized learners, but it has not installed randomized prediction as the
final hypothesis semantics.

Nor can this be simulated just by drawing a random seed during training and
then outputting the resulting deterministic labeling of unseen coordinates.
On the hard regime used in Depth 4, $r\gg m(s)^2$. A random fixed labeling of
the unseen fibers has error fluctuation of order $1/\sqrt r$, while the
desired improvement from memorized fibers is only $m(s)/r=o(1/\sqrt r)$. Thus
with probability bounded away from one, the fixed deterministic seed lands on
the wrong side of $1/2$. Fresh prediction-time coins are doing real work.

If the atlas later allows stochastic final hypotheses, the target lower bound
should probably survive. A strong stochastic learner with error
$\varepsilon\ll 1/2$ on an isolated uniform PRF or random-oracle block would
still predict the active label on a fresh unseen coordinate with probability
$1-\varepsilon$. A reduction could sample the randomized evaluator repeatedly
to obtain a predictor with constant advantage. So the stochastic convention is
a plausible alternate route to a conditional false edge, but it is not the
current route.

### Richer Deterministic Hypotheses

Allowing the source learner to output richer deterministic improper
hypotheses does not appear to help, because the source is already improper.
The learner may already print any efficient deterministic classifier; adding
more proper handles to the concept class would not enlarge the improper output
space for this edge.

On an unseen coordinate pair, a deterministic binary hypothesis has only four
local behaviors:

$$
(0,0),\quad (1,1),\quad (1,0),\quad (0,1).
$$

The first two are the constant defaults from Depth 4. They need opposite
choices on the two tiny-bias marginals $P_+$ and $P_-$. Since those transcript
distributions have total variation $o(1)$ at the fixed pathwise sample scale,
no learner can choose the right constant orientation with high probability for
both.

The last two behaviors guess which member of the coordinate pair is positive.
On the sampled coordinates this is fine, because the label reveals the target
orientation. On unseen coordinates, however, such guesses require information
about the hidden function $f$. For the random-oracle version, a deterministic
guess is wrong on about half of the unseen mass with high probability. For the
PRF version, any efficient deterministic rule with a reliable unseen
correlation would be exactly the kind of predictor the target-side hardness
argument is meant to rule out.

Hybrids do not seem to evade the dichotomy. If most unseen mass receives
constant behavior, the Depth 4 orientation test returns. If substantial unseen
mass receives pair-orientation guesses, then the source proof needs a
deterministic correlation with the hidden labels on that mass. That correlation
is unavailable in the random-oracle core and would threaten the PRF lower
bound in the computational version.

### Different Construction

A different false witness would need a deterministic, orientation-free weak
signal that is available for every marginal but still too weak or too
nonuniform to yield the distribution-free strong target.

The obvious changes do not achieve this:

1. Making positive examples globally rare does not help, because the marginal
   is arbitrary. For any nontrivial concept, an adversarial marginal can
   rebalance the positive and negative regions to total masses
   $1/2\pm\eta$ while spreading that mass over a high-scale unresolved block.

2. Adding public deterministic weak features helps only if those features are
   correlated with the target on the marginal's unresolved mass. If the
   correlation holds uniformly enough to survive arbitrary reweightings, it
   starts to look like a distribution-free weak learner, and then ordinary
   boosting threatens the desired target failure.

3. Using validation to detect the tiny sign of the label-mass bias costs
   samples on the order of $1/\eta^2$. Under the pathwise finite-transcript
   convention, such hidden block-level validation cannot be charged to the
   marginal $P$ alone, because the same high-level finite transcripts occur
   under a full-support reference marginal.

4. Encoding a deterministic pseudo-random tie-breaker in the hypothesis does
   not simulate a fair coin under arbitrary marginals. Once the tie-breaker is
   fixed, the target or marginal can concentrate on the coordinates where it
   is wrong; on random-oracle hard blocks, concentration is not even needed to
   lose high-probability control at the tiny advantage scale.

This does not prove that every possible false construction fails. It does say
that the rare-block PRF/oracle construction needs either stochastic
prediction-time semantics or a genuinely new deterministic gadget, not just a
larger deterministic handle family.

### Depth 6 Directions

1. Prove a local deterministic no-go lemma for isolated random-label blocks:
   for any pathwise $m(s)$-sample deterministic learner with $r\gg m(s)^2$,
   construct two close realizable marginals $P_+$ and $P_-$ on the same block
   such that the learner cannot have inverse-polynomial weak advantage on both.
   The lemma should cover arbitrary deterministic improper outputs, not only
   constants plus explicit handles.

2. If stochastic final hypotheses are acceptable, draft a separate convention
   proposal before editing edge notes. The proposal should define whether
   $\operatorname{err}_P(h,c)$ includes prediction-time randomness, how
   confidence $\delta$ composes with evaluator randomness, and whether
   efficient randomized evaluators may be sampled repeatedly in reductions.

3. Under that stochastic convention, write the source lemma using covered
   coordinate-fiber mass $W$ and then redo the isolated-block target lower
   bound for randomized evaluators. Keep the random-oracle proof and the PRF
   reduction as separate sublemmas.

4. If staying deterministic, search for a construction whose weak learner gets
   an orientation-free deterministic signal from samples without needing to
   predict unseen hard labels. The required signal must be marginal-uniform
   enough to handle $1/2\pm\eta$ reweightings but nonuniform enough not to
   give a distribution-free weak learner.

5. Re-audit the full-support pathwise resource uniformization premise. If that
   premise is weakened, gap-scale validation may become possible for
   marginal-nonuniform sources; if it stands, it should be treated as a fixed
   constraint in any future source-side witness proof.

### Depth 5 Verdict

verdict: unresolved-open under current atlas conventions. The stochastic
version is a plausible convention-changing route to a conditional
counterexample, but stochastic final hypotheses are not currently part of the
node semantics. Richer deterministic hypotheses and obvious construction
changes do not save the rare-block false route.

confidence: 0.88 that the edge should remain `open` under the current atlas
definitions; 0.84 that arbitrary deterministic improper outputs do not repair
the rare-block source lemma; 0.78 that a stochastic-output convention would
repair the source-side orientation obstruction while leaving a PRF/oracle
target lower bound plausible.

## Depth 6 Final Followup: Current-Conventions Closure And Convention Routes

- depth: 6
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

### Final Decision

Do **not** resolve this edge as true or false under the current atlas
conventions. Leave it `open`.

The positive proof still lacks a weak-gap uniformization theorem. Full-support
finite-transcript uniformization controls the runtime and sample use of one
call to the marginal-nonuniform weak learner, but it does not turn

$$
\forall P\ \exists k(P)\quad \gamma_P(s)\ge s^{-k(P)}
$$

into one distribution-free exponent usable by Schapire/Freund boosting. The
known boosting route therefore remains blocked at the quantitative weak-gap
envelope, not at impropriety or at the cost of one weak call.

The negative rare-block PRF/oracle route is also not atlas-ready under current
deterministic-output semantics. Depths 4 and 5 identify the decisive source-side
failure: on a nearly balanced hard block, any deterministic hypothesis must make
some effective default choice on unseen coordinates or predict hidden labels on
them. Opposite tiny-bias marginals $P_+$ and $P_-$ are statistically
indistinguishable at the allowed pathwise polynomial sample scale, so a uniform
deterministic weak learner cannot reliably choose the right default for both.
Richer deterministic improper output does not fix this; the output space was
already improper. If it predicts hidden unseen labels with nontrivial
correlation, it undercuts the target lower bound; if it does not, the default
orientation obstruction returns.

Thus the final current-conventions status is:

```text
verdict: unresolved-open
confidence: 0.90
reason: no positive weak-gap-uniformization theorem, and the leading rare-block
counterexample needs a convention change before its source lemma works.
```

### Atlas-Ready Open-Note Update Text

If atlas edits are later allowed, this is the update I would make to the edge
note while keeping the status open.

Suggested metadata:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - freund1995boosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "Open under deterministic-output atlas conventions: full-support uniformization controls one-call resources, but not the marginal-dependent weak advantage needed for boosting; the leading rare-block PRF/oracle counterexample candidate fails its deterministic source lemma unless stochastic final hypotheses or a weaker resource convention is adopted."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested body replacement for `Proof Status`:

```markdown
**Goal.** Decide whether a marginal-nonuniform weak realizable improper learner
can always be converted into one distribution-free strong realizable improper
learner.

**Current status.** `open`.

Full-support marginal uniformization controls the sample use and runtime of one
call to the source learner under the atlas worst-case finite-transcript
efficiency convention. It does not uniformize the weak advantage. The source
only gives, for each marginal $P$, an inverse-polynomial gap
$\gamma_P(s)\ge s^{-k(P)}$ with an exponent depending on $P$.

Standard realizable boosting would prove the edge from a distribution-free
weak learner, or from a marginal-nonuniform weak learner whose gaps over all
booster-induced filtered or reweighted marginals were dominated by one
polynomial. The current source gives a separate gap for each induced marginal
and provides no bounded-density, KL-stability, continuity, or compactness
condition from which such an envelope follows.

The leading counterexample template is a rare-block PRF/oracle construction:
weak learning would use sample-discovered handles on each fixed marginal, while
the distribution-free strong target would fail on a single hard block whose
level exceeds the degree of the alleged global polynomial learner. This
template is not yet graph-level evidence under the current deterministic
hypothesis semantics. On nearly balanced hard blocks, deterministic outputs
must choose an unseen-coordinate orientation, and opposite tiny-bias marginals
are statistically indistinguishable at any fixed pathwise polynomial sample
scale. Prediction-time randomized hypotheses would remove this orientation
problem, but they are not part of the current node semantics.

**Conclusion.** The edge remains open. A proof would need a weak-gap
uniformization theorem for the marginals generated by boosting. A counterexample
would need either a new deterministic orientation-free weak handle gadget, or an
explicit convention change such as stochastic final hypotheses.
```

### Exact Convention-Change Routes

Route 1: Add stochastic final-hypothesis nodes.

This is the cleanest route if the rare-block candidate is to become a false
edge without reinterpreting all existing deterministic nodes. Add parallel
stochastic variants of the relevant source and target nodes, with a frontmatter
axis such as:

```yaml
prediction_randomness: stochastic-final-hypothesis
```

Use this semantics:

```markdown
A learner may output a randomized evaluator $h(x;\rho)$. Its error is
$\Pr_{X\sim P,\rho}[h(X;\rho)\ne c(X)]$, conditional on the training sample and
the learner's training randomness. The PAC confidence parameter $\delta$ ranges
over the training sample and training randomness; with probability at least
$1-\delta$, the conditional prediction-time error is at most the requested
bound. The evaluator must be sampleable and executable in polynomial time.
```

Under this convention, the rare-block source lemma should use the covered
coordinate-fiber mass $W$: memorize labels on sampled fibers and use fresh fair
coins on unseen fibers, giving conditional error

$$
\frac12(1-W)=\frac12-\frac W2.
$$

The target lower bound should then be rerun for randomized evaluators. On a
single uniform PRF or random-oracle block, error $\varepsilon\ll 1/2$ still
gives a predictor for unseen active labels by repeated randomized evaluation.
After those lemmas are written, the stochastic analogue of this edge is a
candidate for:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - secure pseudorandom functions exist
witnesses:
  - rare-block-prf-stochastic-handle-class
summary: "False under PRF security for stochastic final hypotheses: rare active blocks have marginal-nonuniform stochastic weak handles, but a distribution-free strong learner would predict unseen pseudorandom labels on an isolated hard block."
```

Route 2: Make stochastic final hypotheses a global reinterpretation.

This uses the same error semantics as Route 1, but edits the global atlas
convention so every existing statement that says "outputs a hypothesis $h$" may
include prediction-time randomness. This is more invasive than Route 1. It
would require auditing existing implication notes, because some deterministic
separations may weaken when the learner can use fresh evaluator coins. If this
route is chosen, the current edge should still not be flipped until the
rare-block stochastic source and target lemmas are written explicitly.

Route 3: Keep deterministic outputs but weaken the pathwise resource
convention.

This is the deterministic way to revive the rare-block source proof. Replace
the current worst-case finite-transcript reading of marginal-nonuniform
efficiency with a distributional or high-probability-over-$P$ resource bound
that may spend samples polynomial in the marginal-specific hidden scale. Then a
weak learner could validate the tiny sign of a nearly balanced block using
about $1/\eta^2$ samples and charge that cost to the marginal-dependent
polynomial $p_P$.

This route is a major convention change. It disables the full-support
transcript uniformization diagnosis used in this scratchpad and in neighboring
open-edge notes. It should be adopted only if the atlas intentionally wants
marginal-nonuniform computational efficiency to be distributional rather than
pathwise. The PRF version of the target lower bound would still also need the
efficient-output evaluator convention in Route 4.

Route 4: Add an explicit efficient-output evaluator convention.

This convention is necessary for PRF lower bounds but not sufficient to resolve
the current edge by itself. Add a global computational-PAC convention such as:

```markdown
For computationally efficient learning nodes, an output hypothesis is a finite
description together with a uniform prediction procedure. The prediction
procedure runs in time polynomial in the representation size, the output
description length, and the instance length. For randomized final-hypothesis
nodes, the evaluator may also use fresh coins and can be sampled repeatedly in
polynomial time.
```

With deterministic outputs, this only enables the target-side PRF reduction; it
does not repair the source-side orientation problem. With Route 1 or Route 3,
it supplies the missing evaluator convention needed to convert low target error
on an isolated hard block into a PRF distinguisher.

Route 5: Record a random-oracle/relativized witness policy.

If the atlas accepts relativized evidence, the random-oracle hard-block version
can serve as the clean formal core of the lower bound, avoiding computational
assumptions about PRFs. This should be recorded as a policy choice rather than
silently mixed with ordinary counterexamples:

```yaml
evidence: relativized-counterexample
assumptions:
  - random-oracle model
```

This route still needs Route 1 or Route 3 for the source lemma. It replaces the
PRF assumption in the target lower bound; it does not fix deterministic
orientation by itself.

### Routes Not To Take

Do not mark this current edge `false` merely from the rare-block target lower
bound. The isolated-block target argument is the easy half; the current source
lemma is what fails.

Do not treat "randomized learner" as already allowing prediction-time
randomized final hypotheses. The current notes naturally allow random training
procedures, but they measure the error of the output hypothesis $h$; a random
seed fixed at training time does not simulate fresh evaluator coins at the
tiny advantage scale $m/r$.

Do not rely on richer deterministic improper outputs as a source repair.
Impropriety is already allowed. On unseen coordinate pairs, a deterministic
output either chooses a constant-like orientation or guesses hidden labels; the
first option faces the $P_+$/$P_-$ indistinguishability obstruction, and the
second conflicts with the hard-block lower bound.

### Final Recommendation

Keep the atlas edge `open` and update its rationale from generic
marginal-uniformization to weak-gap uniformization plus the deterministic
orientation obstruction. The next productive work is not another depth pass on
this exact edge, but a convention decision: either add stochastic
final-hypothesis variants and develop the rare-block witness there, or keep the
deterministic/pathwise conventions and search for a genuinely new
orientation-free deterministic counterexample.

Final confidence:

```text
0.90 that the correct current atlas status is open.
0.87 that the rare-block deterministic source lemma fails under current
     pathwise deterministic-output conventions.
0.82 that stochastic final-hypothesis variants would make the rare-block
     counterexample route viable after separate source/target lemmas are
     written.
0.72 that weakening pathwise marginal-nonuniform resources would also revive a
     deterministic false route, at the cost of changing existing atlas
     bookkeeping.
```
