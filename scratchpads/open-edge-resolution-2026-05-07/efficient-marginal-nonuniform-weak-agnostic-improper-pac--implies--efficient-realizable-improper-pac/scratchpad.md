# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-realizable-improper-pac

- depth: 1
- date: 2026-05-07
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-realizable-improper-pac`
- verdict: unresolved
- confidence: 0.91
- worker constraint: scratchpad only; no atlas files, legacy LaTeX, or `references.bib` edited

## Files And Sources Checked

Atlas files:

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`

Prior exact scratchpad:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

Sibling scratchpad used for the rare-block obstruction:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

Primary-source anchors checked:

- Schapire, "The Strength of Weak Learnability", DOI: https://doi.org/10.1023/A:1022648800760.
- Freund, "Boosting a Weak Learning Algorithm by Majority", DOI: https://doi.org/10.1006/inco.1995.1136.
- Feldman, "Distribution-Specific Agnostic Boosting", arXiv: https://arxiv.org/abs/0909.2927.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview: https://openreview.net/forum?id=aoVCFtox89.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", PMLR: https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved Running Time", arXiv: https://arxiv.org/abs/2601.11265.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata", DOI: https://doi.org/10.1145/174644.174647.
- Goldreich, Goldwasser, and Micali, "How to Construct Random Functions", recorded locally as `goldreich1986`.
- Hastad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-way Function", DOI: https://doi.org/10.1137/S0097539793244708.

## Current Atlas State

The edge is currently `open`. The source gives one uniform learner $A$ such that
for each instance marginal $P$ there are marginal-dependent polynomial resource
bounds and a fixed-additive weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s),
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial. On realizable
labels this gives

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s).
$$

The target asks for one distribution-free strong improper learner with sample
and time polynomial in $(s,1/\varepsilon,\log(1/\delta))$, with the polynomial
independent of $P$.

The May 5 exact scratchpad already isolates the main issue correctly:
full-support marginal uniformization controls the pathwise resource bound of
one call to $A$, but it does not uniformize the weak gap. The source has

$$
\forall P\ \exists r_P \quad \gamma_P(s)\ge 1/r_P(s),
$$

while the standard route to the target would need a distribution-free envelope

$$
\exists r\ \forall P \quad \gamma_P(s)\ge 1/r(s),
$$

or at least such an envelope over the marginals used by a booster.

## Positive Route Rechecked

Full-support resource uniformization plus Schapire/Freund boosting would prove
the edge if the source weak gaps were distribution-free. This remains the
cleanest hypothetical proof:

1. Use `full-support-marginal-uniformization` to make one invocation of the
   single source learner pathwise polynomial under the atlas finite-transcript
   convention.
2. Restrict the weak agnostic source to realizable labels, obtaining a weak
   improper learner with gap $\gamma_P(s)$.
3. Boost the weak learner to arbitrary $\varepsilon$.

The failure is quantitative. Boosting overhead depends polynomially on
$1/\gamma_P(s)$, and no current theorem replaces the $P$-dependent exponent by
one global exponent.

Same-marginal agnostic boosting is still only a near miss. Feldman-style
distribution-specific boosting and the newer Ghai/da Cunha lines show that
correlation-style weak agnostic oracles can often be boosted while preserving
the instance marginal. The atlas fixed-additive source can be read, for a
fixed marginal, as a nontrivial correlation oracle with margin
$2\gamma_P(s)$. That would at best give a marginal-nonuniform strong learner
with runtime depending on $1/\gamma_P(s)$. It does not supply the
distribution-free polynomial required here.

I do not see a valid diagonal argument under the current weighted-global
marginal semantics. A size-indexed interpretation of marginals might allow
bad gaps at sizes $s_d$ to be stitched into one diagonal marginal family, but
under the current global-mixture reading low-mass bad components can be ignored
by an additive weak guarantee.

## False Route Rechecked: Rare-Block PRF Handles

The most tempting false route is a rare-block PRF construction with unbounded
polynomial block degrees.

For a seed length $n$ and level $j$, let the active block have

$$
N_{n,j}=n^j
$$

coordinate fibers. A PRF key $k$ defines labels on the block, and the concept
is zero off its active block. A distribution-free strong learner with global
polynomial degree $D$ could be attacked by choosing a fixed level $j>D+10$ and
the uniform marginal on that block. With only $n^D=o(n^j)$ samples and time, a
low-error improper hypothesis would predict unseen PRF labels with constant
advantage, contradicting PRF security by the usual Kearns-Valiant style
argument. The random-oracle version makes the same target-side lower bound
information-theoretic.

So the target side is clean: if the source lemma existed, the assigned
distribution-free target would fail. The problem is the source side.

### Why The Source Lemma Fails Deterministically

The source must hold in particular on realizable labels. A collision or
singleton-handle learner tries to memorize sampled coordinate fibers and use a
default on unseen fibers. The hidden weak advantage would be roughly
$m(s)/N_{n,j}$ for a pathwise polynomial sample bound $m(s)$.

Under deterministic final hypotheses, this breaks on a nearly balanced block.
Let $r=N_{n,j}$ and choose $r\gg m(s)^2$. For a target $c_f$ on coordinate
pairs $(u,b)$, define two marginals on the same block:

$$
P_+(u,f(u))=\frac{1+2\eta}{2r},\qquad
P_+(u,1-f(u))=\frac{1-2\eta}{2r},
$$

and let $P_-$ swap the two weights. Take $\eta=10m(s)/r$. Under $P_+$ the
right unseen-coordinate default is `1`; under $P_-$ it is `0`. A learner using
the wrong default has error at least

$$
\frac12+\eta-O(m(s)/r) > \frac12.
$$

The sampled handles cannot rescue the wrong default because they affect only
$O(m(s)/r)$ block mass.

But the transcript distributions are too close:

$$
\operatorname{TV}(P_+^{m(s)},P_-^{m(s)})
\le O(m(s)\eta)
=O(m(s)^2/r)
=o(1).
$$

Thus no fixed-polynomial deterministic learner can choose the `1` orientation
with high probability under $P_+$ and the `0` orientation with high probability
under $P_-$. This obstruction appears already in the weak realizable subcase,
so the low-noise robustification theorem cannot turn the rare-block learner
into the required weak agnostic source.

Richer deterministic improper outputs do not obviously repair this. On unseen
coordinate pairs a deterministic hypothesis either behaves like a default
orientation, which faces the $P_+$/$P_-$ indistinguishability test, or it
predicts hidden PRF/random-oracle labels on unseen coordinates, which is the
target-side hard task. Since the source already permits arbitrary improper
outputs, adding proper handles to the concept class does not enlarge the
source output space.

### Convention-Changing Variant

If the atlas introduced stochastic final hypotheses, the rare-block source
would become much more plausible: memorize sampled fibers and flip a fresh
fair coin on unseen fibers. Conditional on covered mass $W$, the prediction
error is

$$
\frac12(1-W)=\frac12-\frac W2,
$$

with no default-orientation choice. A strong stochastic learner with error
$\varepsilon\ll 1/2$ would still predict unseen PRF labels with constant
advantage, so the target lower bound should survive after an evaluator
convention is written.

That is not the current atlas semantics. The current notes treat the learner
as outputting an ordinary binary hypothesis whose zero-one error is measured
after training randomness is fixed.

## Verdict

I cannot resolve the edge under the current atlas semantics.

The positive route still needs a weak-gap uniformization theorem. The leading
negative route has a clean isolated-block target lower bound, but its
deterministic source lemma fails on the tiny-bias orientation obstruction. This
keeps the edge open rather than conditionally false.

## Promising Follow-Ups

1. Prove or refute a weak-gap uniformization lemma for a single pathwise
   polynomial weak learner under weighted-global marginals. This would address
   both this edge and the weaker distribution-free weak-realizable sibling.

2. Formalize the deterministic tiny-bias no-go lemma for rare-block
   constructions, covering arbitrary deterministic improper outputs. That
   would prevent future scratchpads from circling back to the same PRF
   singleton-handle candidate.

3. If stochastic final hypotheses are desired, add separate stochastic nodes
   or a global convention before changing edge statuses. Under that convention,
   rare-block PRF/oracle handles are a plausible conditional false route.

4. If the atlas keeps deterministic outputs, search for a genuinely
   orientation-free deterministic weak handle: one that works on both
   $1/2+\eta$ and $1/2-\eta$ reweightings without predicting hidden unseen
   labels.

5. Keep the current edge note's `marginal-boosting-open` family, but consider
   adding language that the rare-block PRF route is blocked by deterministic
   orientation, not merely by an unfinished target lower bound.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 7 Final Consolidation

- date: 2026-05-07
- depth: 7
- note: canonical end-of-scratchpad consolidation; this supersedes the earlier misplaced copy of the same depth-7 section above
- write scope: scratchpad only; no atlas files, legacy LaTeX files, or `references.bib` edited
- final verdict: unresolved under the current atlas semantics

### Final Verdict

Keep the edge `open`.

The source specializes to realizable labels as a marginal-dependent weak
improper learner:

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)\ge \frac1{r_P(s)}
$$

for a polynomial $r_P$ whose exponent may depend on the marginal $P$. The
target would follow from a distribution-free weak learner plus standard
realizable boosting, but that needs one polynomial $r$ satisfying

$$
\gamma_P(s)\ge \frac1{r(s)}
\quad\text{for every marginal }P.
$$

Full-support transcript uniformization gives one distribution-free pathwise
sample/time bound for a call to the single source learner. It does not
uniformize the weak advantage. The exact unresolved quantifier swap is

$$
\forall P\,\exists r_P
\quad\text{versus}\quad
\exists r\,\forall P.
$$

### Conditional True Forks

The edge becomes `true` under any one of these additional statements:

1. **Uniform weak-gap envelope.** If the source learner has one
   distribution-free inverse-polynomial realizable gap, full-support resource
   uniformization plus Schapire/Freund boosting gives efficient realizable
   improper PAC learning.

2. **Size-indexed full-mass marginal semantics.** If a marginal is a family
   $(P_s)_{s\ge 1}$ and the size-$s$ guarantee is evaluated under full mass
   $P_s$, bad gaps at increasing sizes can be diagonalized into one marginal
   family. The source polynomial for that family then forces a uniform weak
   gap, and boosting proves the target.

3. **Local envelope for booster marginals.** If every filtered, reweighted,
   or label-modified marginal generated by a boosting reduction has weak
   gaps dominated by one polynomial independent of the original marginal,
   the usual boosting analysis can be made distribution-free. This is a new
   bounded-density/KL-stability or local-uniformity assumption, not part of
   the present source node.

### Failed Counterexample Routes

The strongest target-negative route is still a rare-block PRF or
random-oracle construction: choose a hard paired block much larger than any
alleged distribution-free polynomial strong learner can sample or evaluate,
so low error on the isolated block would predict unseen hard labels. This
target-side lower bound is plausible under the standard efficient-output
evaluator convention and PRF security.

The source side is the blocker. The source must work for all marginals,
including concentrated, nearly balanced, coordinate-wise biased marginals on
the hard block. Under the current deterministic-output atlas reading, any
final hypothesis on a paired block with

$$
c_f(i,b)=1 \Longleftrightarrow b=f(i)
$$

decomposes into constant behavior exposed by hidden marginal signs, one-hot
behavior exposed by hidden target labels, and sampled-coordinate corrections
of total scale $O(m/r)$ when one weak call has pathwise sample bound $m$ and
the block has $r$ fibers. For $r\gg m^2$, coordinate-wise biased marginals
make the unseen deterministic contribution larger than the memorized sample
gain. Thus a memorization-only weak handle cannot satisfy the source unless
it samples many more fibers or predicts unseen hard labels/signs. The first
option contradicts the full-support pathwise resource bound on high blocks;
the second defeats the intended target hardness.

This blocks the known deterministic rare-block false route, including
constants, singleton handles, public hashes, fixed pseudorandom tie-breakers,
and richer deterministic improper circuits. Fresh prediction-time randomness
would change the model: memorize sampled fibers and flip fresh fair coins on
unseen fibers could be source-positive in expected loss, but that requires
separate stochastic-final-hypothesis nodes rather than a status change here.

### Exact Obstacle

The remaining obstacle is weak-gap uniformization under weighted-global,
deterministic-output semantics:

> Given one pathwise-polynomial learner whose realizable weak gap is
> inverse-polynomial for each fixed marginal with a marginal-dependent
> exponent, prove or refute that there is one distribution-free
> inverse-polynomial lower bound on those gaps.

The current weighted-global semantics blocks the clean diagonal proof. In a
mixture $P^\star=\sum_j w_jQ_j$, a bad high-size slice has only mass $w_j$.
A global additive weak guarantee may ignore sufficiently low-mass bad slices,
and easy labels on the remaining mass can hide local failure. Making the
other components noisy raises $\operatorname{OPT}$ and leaves the
fixed-additive $1/2-\gamma_{P^\star}(s)$ tolerance too slack to force local
learning. Fixed-size compactness is also insufficient: it may give a
positive $g_s$, but not $1/g_s\le s^O(1)$.

### Proposed Atlas Summary

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
summary: "Open under current weighted-global deterministic-output semantics: full-support transcript uniformization gives one pathwise resource bound, and the source gives a fixed-marginal weak agnostic/correlation oracle on realizable labels, but no known theorem uniformizes the marginal-dependent weak gaps needed for distribution-free boosting. Rare-block PRF/oracle false routes are blocked on the source side by deterministic coordinate-wise orientation tests."
```

### Proposed Atlas Body Text

```markdown
The source specializes on realizable labels to a weak improper learner with
marginal-dependent advantage
$\gamma_P(s)=1/2-\beta_P(s)$. Full-support marginal uniformization controls
the pathwise sample and running time of one call to the single source learner,
but it does not lower-bound $\gamma_P(s)$ uniformly over marginals.

The missing theorem is weak-gap uniformization: from
$\forall P\,\exists r_P$ with $\gamma_P(s)\ge 1/r_P(s)$, derive one
polynomial $r$ such that $\gamma_P(s)\ge 1/r(s)$ for every marginal $P$ on
realizable labels. With such a theorem, standard realizable boosting would
prove the edge true. A size-indexed full-mass marginal semantics would give
this by diagonalization, but the current weighted-global semantics does not:
low-mass bad slices can be hidden from a global additive weak guarantee.

The fixed-additive agnostic promise is a useful fixed-marginal near miss. In
correlation form it gives a nontrivial weak oracle with margin proportional
to $2\gamma_P(s)$ on realizable labels. Distribution-specific agnostic
boosting can amplify such an oracle when the margin is supplied, but the
overhead still depends on the hidden marginal-dependent gap.

No atlas-ready counterexample is known. Rare-block PRF or random-oracle
witnesses give plausible target-side hardness, but deterministic final
hypotheses face coordinate-wise tiny-bias orientation tests on the source
side. A source-positive hard block would need either a genuine deterministic
orientation-free weak handle or nontrivial prediction of unseen hard labels,
the latter defeating the intended target lower bound. Stochastic final
hypotheses could revive the false route only after an explicit schema change.
```

### Primary-Source Anchors

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability":
  https://openreview.net/forum?id=aoVCFtox89
- Schapire, "The Strength of Weak Learnability":
  https://www.schapire.net/papers/strengthofweak.pdf
- Freund, "Boosting a Weak Learning Algorithm by Majority":
  https://doi.org/10.1006/inco.1995.1136
- Feldman, "Distribution-Specific Agnostic Boosting":
  https://arxiv.org/abs/0909.2927

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 7 Final Consolidation

- date: 2026-05-07
- depth: 7
- role: final allowed follow-up for this unresolved edge
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-realizable-improper-pac`
- write scope: appended to this scratchpad only; no atlas files, legacy LaTeX files, or `references.bib` edited
- final verdict: unresolved under the current atlas semantics

### Final Verdict

Keep the edge `open`.

The source specializes to realizable labels as a marginal-dependent weak
improper learner:

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)\ge \frac1{r_P(s)}
$$

for a polynomial $r_P$ whose exponent may depend on the marginal $P$. The
target would follow from a distribution-free weak learner plus standard
realizable boosting, but that needs one polynomial $r$ satisfying

$$
\gamma_P(s)\ge \frac1{r(s)}
\quad\text{for every marginal }P.
$$

Full-support transcript uniformization gives one distribution-free pathwise
sample/time bound for a call to the single source learner. It does not
uniformize the weak advantage. This is the exact unresolved quantifier swap:

$$
\forall P\,\exists r_P
\quad\text{versus}\quad
\exists r\,\forall P.
$$

The primary-source picture remains consistent with this diagnosis. Schapire
and Freund prove weak-to-strong boosting when a quantitative weak edge is
available. Feldman's distribution-specific agnostic boosting keeps the
instance marginal fixed, but its quantitative guarantees still depend on the
available weak/correlation margin. Hanneke-Moran-Thiessen's
marginal-nonuniform model explicitly permits rates depending on the marginal
while remaining uniform over concepts once the marginal is fixed; it does not
by itself provide a computational distribution-free weak-gap envelope.

### Conditional True Forks

The edge becomes `true` under any one of the following additional statements.

1. **Uniform weak-gap envelope.** If the source learner is known to have one
   distribution-free inverse-polynomial realizable gap

   $$
   \exists r\ \forall P,c,s:
   \Pr\!\left[
   \operatorname{err}_P(A(S),c)\le \frac12-\frac1{r(s)}
   \right]\ge \frac23,
   $$

   then full-support resource uniformization plus Schapire/Freund boosting
   gives efficient realizable improper PAC learning.

2. **Size-indexed full-mass marginal semantics.** If a marginal is a family
   $(P_s)_{s\ge 1}$ and the size-$s$ guarantee is evaluated under full mass
   $P_s$, bad gaps at increasing sizes can be diagonalized into one marginal
   family. The source polynomial for that family then forces a uniform
   inverse-polynomial weak gap, and boosting proves the target.

3. **A local envelope for all booster marginals.** If every filtered,
   reweighted, or label-modified distribution generated by a boosting
   reduction has weak gaps dominated by one polynomial independent of the
   original marginal, then the usual boosting analysis can be made
   distribution-free. This is a new bounded-density/KL-stability or
   local-uniformity assumption, not part of the current source node.

The first two are atlas-clean conditional theorems. The third is useful as a
proof design target, but it is not currently a graph-level theorem.

### Failed Counterexample Routes

The strongest target-negative idea remains a rare-block PRF or random-oracle
construction: for every alleged distribution-free polynomial strong learner,
choose a block with many more paired coordinates than the learner can sample
or evaluate, so low error on the isolated block would predict unseen hard
labels. This target-side lower bound is plausible under the standard
efficient-output evaluator convention and PRF security.

The source side is still the obstruction. The source quantifies over all
marginals, including concentrated, nearly balanced, coordinate-wise biased
marginals on the hard block. Under the current atlas reading, a randomized
training algorithm outputs an ordinary deterministic binary hypothesis before
zero-one error is measured. On a paired block with target

$$
c_f(i,b)=1 \Longleftrightarrow b=f(i),
$$

any deterministic output decomposes coordinate by coordinate into:

- constant behavior, exposed by hidden marginal signs $\theta_i$;
- one-hot behavior, exposed by hidden target labels $f(i)$;
- sampled-coordinate corrections, contributing only $O(m/r)$ when one weak
  call has pathwise sample bound $m$ and the block has $r$ coordinate fibers.

For $r\gg m^2$, coordinate-wise biased marginals can make the unseen
deterministic contribution fluctuate on a larger scale than the memorized
sample contribution. Thus a memorization-only weak handle cannot satisfy the
source on all such marginals unless it samples many more fibers or predicts
unseen hard labels/signs. Sampling many more fibers contradicts the
full-support pathwise resource bound for sufficiently high blocks. Predicting
unseen labels undercuts the intended PRF/oracle target hardness.

This kills the known deterministic rare-block false route, including variants
using constants, singleton handles, public hashes, fixed pseudorandom
tie-breakers, or richer deterministic improper circuits. The issue is not
properness; the source is already improper, and arbitrary deterministic
outputs still face the same orientation test.

Fresh prediction-time randomness is a real model fork. A learner that
memorizes sampled fibers and flips a fresh fair coin on unseen fibers would
avoid deterministic orientation failures in expected loss. But that is not
the present atlas convention, where the final object is an ordinary binary
hypothesis and training randomness is fixed before risk is measured. A
stochastic-final-hypothesis node could plausibly have a conditional false
rare-block separation, but it would be a different graph node.

### Exact Obstacle

The remaining obstacle is:

> **Weak-gap uniformization under weighted-global deterministic-output
> semantics.** Given one pathwise-polynomial learner whose realizable weak
> gap is inverse-polynomial for each fixed marginal with a marginal-dependent
> exponent, prove or refute that there is one distribution-free
> inverse-polynomial lower bound on those gaps.

The current weighted-global marginal semantics blocks the clean diagonal
proof. If we try to mix bad size slices into one global marginal

$$
P^\star=\sum_j w_j Q_j,
$$

then the bad slice $Q_j$ appears only with mass $w_j$. A global additive weak
guarantee may ignore sufficiently low-mass bad components, and labels on the
other components can supply enough global weak advantage to hide local
failure. Making other components noisy does not fix this, because the agnostic
comparison raises $\operatorname{OPT}$ and leaves the fixed-additive
$1/2-\gamma_{P^\star}(s)$ tolerance too slack to force local learning.

Compactness at a fixed representation size is also insufficient. Even if it
gives a positive minimum gap $g_s$ over a finite slice, it does not imply
$1/g_s\le s^O(1)$. Boosting, validation, and agnostic relabeling all have
quantitative overhead depending on the hidden gap.

### Proposed Atlas Summary

Suggested frontmatter replacement, if the atlas note is refreshed but kept
open:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
summary: "Open under current weighted-global deterministic-output semantics: full-support transcript uniformization gives one pathwise resource bound, and the source gives a fixed-marginal weak agnostic/correlation oracle on realizable labels, but no known theorem uniformizes the marginal-dependent weak gaps needed for distribution-free boosting. Rare-block PRF/oracle false routes are blocked on the source side by deterministic coordinate-wise orientation tests."
```

### Proposed Atlas Body Text

Suggested body text:

```markdown
The source specializes on realizable labels to a weak improper learner with
marginal-dependent advantage
$\gamma_P(s)=1/2-\beta_P(s)$. Full-support marginal uniformization controls
the pathwise sample and running time of one call to the single source learner,
but it does not lower-bound $\gamma_P(s)$ uniformly over marginals.

The missing theorem is weak-gap uniformization: from
$\forall P\,\exists r_P$ with $\gamma_P(s)\ge 1/r_P(s)$, derive one
polynomial $r$ such that $\gamma_P(s)\ge 1/r(s)$ for every marginal $P$ on
realizable labels. With such a theorem, standard realizable boosting would
prove the edge true. A size-indexed full-mass marginal semantics would give
this by diagonalization, but the current weighted-global semantics does not:
low-mass bad slices can be hidden from a global additive weak guarantee.

The fixed-additive agnostic promise is a useful fixed-marginal near miss. In
correlation form it gives a nontrivial weak oracle with margin proportional
to $2\gamma_P(s)$ on realizable labels. Distribution-specific agnostic
boosting can amplify such an oracle when the margin is supplied, but the
overhead still depends on the hidden marginal-dependent gap.

No atlas-ready counterexample is known. Rare-block PRF or random-oracle
witnesses give plausible target-side hardness, but deterministic final
hypotheses face coordinate-wise tiny-bias orientation tests on the source
side. A source-positive hard block would need either a genuine deterministic
orientation-free weak handle or nontrivial prediction of unseen hard labels,
the latter defeating the intended target lower bound. Stochastic final
hypotheses could revive the false route only after an explicit schema change.
```

### Final Recommendation

Keep this edge in `marginal-boosting-open`, with the sharper label
`weak-gap-uniformization` if a new argument family or subfamily is added.
Do not mark it false on the basis of rare-block handles unless the atlas also
changes output semantics or supplies a new deterministic orientation-free
source construction. Do not mark it true without a theorem converting
marginal-dependent weak gaps into one distribution-free inverse-polynomial
gap under weighted-global marginals.

Primary-source anchors used in this final pass:

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability":
  https://openreview.net/forum?id=aoVCFtox89
- Schapire, "The Strength of Weak Learnability":
  https://www.schapire.net/papers/strengthofweak.pdf
- Freund, "Boosting a Weak Learning Algorithm by Majority":
  https://doi.org/10.1006/inco.1995.1136
- Feldman, "Distribution-Specific Agnostic Boosting":
  https://arxiv.org/abs/0909.2927

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 2 Branch A: Deterministic Tiny-Bias Orientation No-Go

- date: 2026-05-07
- branch: deterministic tiny-bias orientation no-go for rare-block PRF/handle constructions
- write scope: appended to this scratchpad only; no atlas files or `references.bib` edited
- short verdict: conditional obstacle formalized; not enough by itself to resolve the edge

### Goal

Formalize the obstruction behind the previous rare-block audit, but allow
arbitrary deterministic improper outputs. The intended reusable statement is:
on a high-cardinality block, two realizable marginals can have opposite
tiny target-label biases while their finite-sample transcript laws are nearly
indistinguishable. A deterministic learner that succeeds on both marginals
must therefore either choose opposite default orientations from statistically
insufficient evidence or output a hypothesis with balanced predictive
advantage on the hidden unseen coordinate labels.

The second alternative is exactly the PRF/random-oracle hard task. The point
of the lemma is not that improper hypotheses are syntactically defaults plus
handles. It is an algebraic dichotomy for every binary hypothesis.

### Block Setup

Fix a block with coordinates $[r]$ and paired atoms $(i,b)$ for
$i\in[r]$ and $b\in\{0,1\}$. For a hidden string
$f\in\{0,1\}^r$, the realizable target is

$$
c_f(i,b)=1 \quad\Longleftrightarrow\quad b=f(i).
$$

For a bias parameter $\eta\in(0,1/4)$ define two instance marginals on this
same block:

$$
P_+(i,f(i))=\frac{1+2\eta}{2r},\qquad
P_+(i,1-f(i))=\frac{1-2\eta}{2r},
$$

and

$$
P_-(i,f(i))=\frac{1-2\eta}{2r},\qquad
P_-(i,1-f(i))=\frac{1+2\eta}{2r}.
$$

Both are realizable by the same concept $c_f$. Under $P_+$, the target-positive
atoms have total mass $1/2+\eta$; under $P_-$ they have total mass
$1/2-\eta$. Thus the all-one default has advantage $\eta$ under $P_+$ and
disadvantage $\eta$ under $P_-$, while the all-zero default has the opposite
behavior.

Let $Q_+$ and $Q_-$ be the corresponding labeled example distributions. A
single labeled draw has

$$
\operatorname{TV}(Q_+,Q_-)=2\eta,
$$

so for any pathwise learner using at most $m$ examples,

$$
\operatorname{TV}(Q_+^m,Q_-^m)\le 2m\eta.
$$

The rare-block regime chooses $\eta=\Theta(m/r)$ and $r\gg m^2$, making the
two transcript distributions close even though the correct default
orientations are opposite.

### Algebraic Decomposition For Arbitrary Hypotheses

Let $h$ be any deterministic binary hypothesis on the block, not necessarily
proper and not necessarily a sparse handle. For each coordinate set

$$
a_i = 1-h(i,f(i)),\qquad b_i=h(i,1-f(i)).
$$

Here $a_i$ is the false-negative indicator on the target-positive atom and
$b_i$ is the false-positive indicator on the target-negative atom.

Define the balanced hidden-label advantage

$$
A_0^f(h)
=\frac12-\frac{1}{2r}\sum_{i=1}^r(a_i+b_i),
$$

and the orientation score

$$
O^f(h)
=\frac1r\sum_{i=1}^r(b_i-a_i).
$$

The score $O^f(h)$ is positive for the all-one orientation and negative for
the all-zero orientation. A one-hot predictor that tries to name $f(i)$ has
$O^f(h)=0$; if it is correct it contributes positively to $A_0^f(h)$, and if
it is reversed it contributes negatively.

For $\sigma\in\{+1,-1\}$, the advantage of $h$ under $P_\sigma$ is exactly

$$
A_\sigma^f(h)
=\frac12-\operatorname{err}_{P_\sigma}(h,c_f)
=A_0^f(h)+\sigma\eta O^f(h).
$$

This identity is the clean form of the orientation obstruction. A hypothesis
can be good for $P_+$ because $O^f(h)>0$, or good for $P_-$ because
$O^f(h)<0$. To be good for both with the same hidden string, it must instead
have positive balanced advantage $A_0^f(h)$.

### Lemma: Opposite-Bias Success Forces Hidden Balanced Advantage

Let $A$ be a deterministic learner whose pathwise sample use on this block is
at most $m$. Fix a target $f$ and suppose that for some $\gamma>0$ and
$\delta<1/2$,

$$
\Pr_{S\sim Q_+^m}\left[A_+^f(A(S))\ge\gamma\right]\ge 1-\delta
$$

and

$$
\Pr_{S\sim Q_-^m}\left[A_-^f(A(S))\ge\gamma\right]\ge 1-\delta.
$$

Let $\tau=\operatorname{TV}(Q_+^m,Q_-^m)\le 2m\eta$. Then

$$
\Pr_{S\sim Q_+^m}\left[A_0^f(A(S))\ge\gamma\right]
\ge 1-2\delta-\tau.
$$

The same conclusion holds with $Q_-$ in place of $Q_+$.

**Proof.** Let $E_+$ be the event $A_+^f(A(S))\ge\gamma$ and $E_-$ the event
$A_-^f(A(S))\ge\gamma$. The first assumption gives
$Q_+^m(E_+)\ge 1-\delta$. The second assumption and total variation give
$Q_+^m(E_-)\ge 1-\delta-\tau$. Hence
$Q_+^m(E_+\cap E_-)\ge 1-2\delta-\tau$.

On this intersection, the decomposition gives

$$
A_0^f(A(S))+\eta O^f(A(S))\ge\gamma
$$

and

$$
A_0^f(A(S))-\eta O^f(A(S))\ge\gamma.
$$

Therefore

$$
A_0^f(A(S))\ge \gamma+\eta |O^f(A(S))|\ge\gamma.
$$

This proves the claim.

### Fresh-Label Form

Let $R(S)\subseteq[r]$ be the set of coordinates whose hidden bit $f(i)$ is
revealed by the sample. Always $|R(S)|\le m$. The balanced advantage splits as

$$
A_0^f(h)
=\frac{1}{2r}\sum_{i\in R(S)}(1-a_i-b_i)
 +\frac{1}{2r}\sum_{i\notin R(S)}(1-a_i-b_i).
$$

The revealed-coordinate contribution is at most $|R(S)|/(2r)\le m/(2r)$.
Consequently, if the previous lemma yields $A_0^f(A(S))\ge\gamma$, then the
unseen coordinates contribute at least

$$
\gamma-\frac{m}{2r}
$$

to balanced advantage on the full block scale.

Thus, for any claimed weak gap $\gamma>m/(2r)+\alpha$, opposite-bias success
forces the final improper hypothesis to predict hidden unseen coordinate
labels with advantage at least $\alpha$. In a random-oracle block this is
information-theoretically impossible for a pathwise-polynomial transcript
except with small probability. In a PRF block it would give the usual
Kearns-Valiant style distinguisher, provided $\alpha$ is inverse-polynomial
and the final hypothesis is polynomial-time evaluable.

This is the rigorous replacement for the informal phrase "the learner either
picks the wrong orientation or predicts unseen labels." If it does not
produce hidden balanced advantage, then success on $P_+$ and success on $P_-$
require opposite signs of $O^f(h)$; the two transcript laws are too close for
one deterministic learner to select those signs with high probability on both
marginals.

### What This Kills

This kills the deterministic source lemma for sparse default-orientation
rare-block handles. Such learners get their visible advantage from
sample-revealed coordinates, of size $O(m/r)$, and from choosing the right
constant/default orientation. Choosing $\eta=\kappa m/r$ with a sufficiently
large constant $\kappa$ makes the wrong orientation worse than random even
after all sampled corrections. Since $2m\eta=O(m^2/r)$ is small in the
high-block regime, the learner cannot reliably choose the all-one orientation
under $P_+$ and the all-zero orientation under $P_-$.

The argument is independent of properness. It applies to every deterministic
binary output by projecting that output onto the two quantities
$A_0^f(h)$ and $O^f(h)$. A complicated improper circuit is safe from the
orientation test only to the extent that it has $A_0^f(h)>0$, which is
precisely balanced prediction of the hidden block labels rather than a
default-orientation handle.

For the present edge, this means the rare-block PRF construction cannot prove
`false` merely by adding richer deterministic improper handles. The source
proof must still explain how the learner avoids the above two-marginal test
under arbitrary concentrated marginals.

### Remaining Loophole

The lemma is not an unconditional impossibility for every deterministic
improper weak learner at every possible marginal-dependent gap. The fresh
prediction conclusion becomes nontrivial only above the revealed-coordinate
scale $m/(2r)$. If a candidate source learner can make $O^f(h)\approx 0$ and
guarantee a weak gap entirely from memorized coordinates plus an
orientation-neutral unseen rule, then the algebraic lemma alone does not
refute it.

Concretely, an evasion route would be a deterministic, efficiently evaluable
unseen-coordinate rule that is never anti-correlated with any target by more
than the sample-correction scale $O(m/r)$, while not being strong enough for
the distribution-free target to exploit. Then the learner could memorize
sampled coordinates and use that neutral rule elsewhere, obtaining a tiny
marginal-dependent gap without estimating the sign of the $P_+/P_-$ bias.

This route looks very constrained. For complement-closed PRF blocks, any fixed
one-hot unseen rule that has fresh correlation $\rho$ with $f$ has correlation
$-\rho$ with the complemented target. For a random or pseudorandom family, a
polynomial-time unseen rule with inverse-polynomial positive fresh correlation
on the hard block would itself be a predictor/distinguisher. But turning that
intuition into a full arbitrary-output no-go requires an additional
discrepancy or PRF prediction lemma. The tiny-bias orientation lemma supplies
the reduction target; it does not by itself prove the required
fresh-prediction lower bound at the exact $m/r$ memorization scale.

### Reusable Obstacle Statement

For future rare-block counterexample attempts, require the source proof to
answer the following test.

Take any claimed pathwise sample bound $m(s)$ for one call of the marginal
weak learner. Choose a block size $r\gg m(s)^2$ and two realizable marginals
$P_+,P_-$ on the same hidden target with opposite biases
$\eta=\Theta(m(s)/r)$. Then either:

1. the learner's final hypotheses have balanced hidden-label advantage at the
   claimed weak-gap scale on unseen coordinates, which must be justified
   against the PRF/random-oracle hardness; or
2. the learner is relying on an orientation score, in which case the
   $P_+^m$ and $P_-^m$ transcript laws are too close for high-probability
   success on both marginals.

Any proposed deterministic handle family based on constants, singleton
corrections, sparse lookups, public hashes, or signed defaults should be
audited against this test before being used as a source-positive witness.

### Branch Verdict

The no-go lemma is rigorous as a conditional obstacle and reusable diagnostic:
opposite tiny biases plus transcript indistinguishability force hidden
balanced prediction for arbitrary deterministic improper outputs. It does not
resolve the atlas edge, because a complete negative witness still needs the
separate hidden-prediction/discrepancy lower bound for the precise
memorization-scale gap, and a positive theorem would still need weak-gap
uniformization.

VERDICT: conditional-only

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Memorization-Scale Loophole

- date: 2026-05-07
- branch: memorization-scale loophole in the deterministic tiny-bias no-go
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-realizable-improper-pac`
- write scope: appended to this scratchpad only; no atlas files or `references.bib` edited
- short verdict: the loophole closes for the rare-block deterministic hard-label route only under a random-oracle/PRF-style discrepancy theorem; it does not resolve the atlas edge

### Question

Depth 2 showed that opposite global tiny biases force unseen hidden-label
prediction only when the claimed weak advantage is above the revealed-coordinate
scale. The remaining loophole is the exact memorization scale:

$$
\gamma \asymp \frac{m}{r},
$$

where $m$ is the pathwise sample bound for one source call and $r$ is the
number of coordinate fibers in the hard block. At this scale, the sampled
coordinates alone can contribute order $m/r$ advantage, so the Depth 2 lemma
does not force a positive unseen-label advantage.

The question is whether a deterministic source learner can exploit this by
memorizing sampled coordinates and using an orientation-neutral deterministic
rule on unseen coordinates, while the target strong learner still has to
predict unseen PRF or random-oracle labels.

### Setup

By the full-support finite-transcript convention, any single source learner
has one distribution-free pathwise sample/time polynomial for one call. Fix
confidence, say $\delta=0.1$, and write the resulting sample bound as
$m(s)$. The rare-block target lower bound may choose a block with

$$
r \gg m(s)^2.
$$

Use the paired block

$$
B_r=\{(i,b): i\in[r],\ b\in\{0,1\}\}
$$

and a hidden target

$$
c_f(i,b)=1 \Longleftrightarrow b=f(i).
$$

For a sign vector $\theta\in\{\pm1\}^r$ and a bias parameter
$\eta\in(0,1/4)$, define the coordinate-wise biased realizable marginal

$$
P_{\theta}(i,f(i))=\frac{1+2\eta\theta_i}{2r},
\qquad
P_{\theta}(i,1-f(i))=\frac{1-2\eta\theta_i}{2r}.
$$

This is the important strengthening of the Depth 2 test. The earlier
$P_+,P_-$ marginals use one global sign. Here the source learner must handle
all coordinate-wise signs, because the atlas source quantifies over every
instance marginal.

### Coordinate Decomposition

For any deterministic final hypothesis $h$, define as before

$$
a_i=1-h(i,f(i)),\qquad b_i=h(i,1-f(i)).
$$

Let

$$
z_i=1-a_i-b_i,\qquad d_i=b_i-a_i.
$$

The contribution of coordinate $i$ to the global advantage under
$P_{\theta}$ is

$$
\frac{z_i}{2r}+\frac{\eta\theta_i d_i}{r}.
$$

The four local deterministic behaviors have the following form:

- constant-zero: $z_i=0$, $d_i=-1$;
- constant-one: $z_i=0$, $d_i=1$;
- one-hot correct: $z_i=1$, $d_i=0$;
- one-hot wrong: $z_i=-1$, $d_i=0$.

Thus a deterministic unseen-coordinate rule has no true neutral behavior. It
is either a constant orientation, which is exposed by the hidden marginal sign
$\theta_i$, or it is a one-hot guess, which is exposed by the hidden label
$f(i)$.

Sampled coordinates can be made correct, but they contribute at most

$$
\frac{|R(S)|}{2r}\le \frac{m(s)}{2r}
$$

to the total advantage, where $R(S)$ is the set of sampled coordinate fibers.

### Why Coordinate-Wise Bias Closes The Loophole

Draw $f$ and $\theta$ independently at random. Condition on any training
transcript and on the learner's training coins. For every unseen coordinate
$i\notin R(S)$, the pair $(f(i),\theta_i)$ is still independent of the
transcript. Once the learner has fixed the two output bits
$h(i,0),h(i,1)$, the unseen contribution

$$
X_i=\frac{z_i}{2r}+\frac{\eta\theta_i d_i}{r}
$$

has mean zero over the unrevealed random bits. Moreover, because every
deterministic local behavior is either constant or one-hot, $X_i$ has
magnitude at least $\min\{\eta,1/2\}/r$ in the relevant random sign. The sum
over unseen coordinates therefore has standard deviation at least
$\Omega(\min\{\eta,1/2\}/\sqrt r)$.

For the cleanest no-go take $\eta$ to be a small constant. Then
$r\gg m(s)^2$ makes this fluctuation scale much larger than the maximum
memorization gain:

$$
\frac{1}{\sqrt r} \gg \frac{m(s)}{r}.
$$

If one insists that the coordinate-wise biases themselves be tiny, it is
enough to take an inverse-polynomial $\eta$ with
$\eta \gg m(s)/\sqrt r$ and then choose the block level higher. The same
comparison becomes

$$
\frac{\eta}{\sqrt r} \gg \frac{m(s)}{r}.
$$

Consequently, with constant probability over the hidden block, the unseen
contribution is negative by more than the entire sampled-coordinate advantage.
Equivalently, averaging over the random choice of $(f,\theta)$, no
$m(s)$-sample deterministic learner can have high-probability positive weak
advantage on all such realizable marginals. By the probabilistic method, there
is a fixed target $f$ and a fixed marginal $P_\theta$ on which the learner
fails.

This closes the precise memorization-scale loophole for the rare-block
random-label construction. A learner that only memorizes sampled coordinates
does not merely fail to get a large unseen advantage; under some
coordinate-wise biased marginal, its deterministic unseen rule contributes a
negative fluctuation larger than the memorized gain.

### Relation To The Depth 2 Global-Bias Lemma

The Depth 2 lemma used two marginals $P_+$ and $P_-$ with one global sign. A
learner could try to evade that test by arranging its unseen constants so that
the global orientation score $O^f(h)$ is close to zero. For example, it could
use constant-one behavior on half the unseen coordinates and constant-zero
behavior on the other half.

That evasion is not stable under arbitrary marginals. A coordinate-wise sign
vector $\theta$ can put tiny positive bias on the coordinates where the
learner's constant behavior is wrong and tiny negative bias where the opposite
constant is wrong. The learner sees only $m(s)$ coordinates, so when
$r\gg m(s)^2$ it cannot infer the signs on the unseen coordinates. If it
switches from constants to one-hot guesses, the hidden labels $f(i)$ play the
same role.

So the correct diagnostic is coordinate-wise, not just global:

1. constants face hidden marginal signs $\theta_i$;
2. one-hot guesses face hidden target labels $f(i)$;
3. sampled corrections are too small to dominate the unseen deterministic
   fluctuation when $r\gg m(s)^2$.

### Why Training-Time Random Seeds Do Not Simulate Fresh Coins

A randomized learner may choose a random deterministic tie-breaker during
training and print it as part of the final hypothesis. This still does not
simulate prediction-time randomization at the memorization scale. Once the
seed is fixed, the unseen rule has a fixed contribution against the fixed
marginal and target. On a hard block with $r\gg m(s)^2$, the fixed-seed
fluctuation is typically order $1/\sqrt r$, while the desired memorized
advantage is only $m(s)/r$.

Fresh prediction-time randomization is different. If the final evaluator could
flip a fresh fair coin on every unseen coordinate, its conditional error on
unseen mass would be exactly $1/2$ in expectation under every
$P_\theta$, and the sampled coordinates would give advantage $W/2$. That is a
real convention change, not something available from ordinary randomized
training under the current deterministic-hypothesis reading.

### Conditional Theorem Extracted From The Branch

The branch supports the following conditional no-go theorem for rare-block
counterexample attempts.

> Under deterministic final-hypothesis semantics and the atlas pathwise
> finite-transcript resource convention, let a hard block have $r\gg m(s)^2$
> coordinate fibers. For a random-oracle block, or for a PRF block assuming the
> usual efficient-evaluator and pseudorandom prediction hardness, no source
> learner can obtain its weak advantage solely from memorized coordinate mass
> while leaving unseen coordinates unpredicted. To satisfy the source on all
> coordinate-wise biased realizable marginals, the learner must either sample
> $\Omega(\sqrt r)$ fibers, use fresh prediction-time randomness, or encode
> nontrivial information about unseen hidden labels/signs.

The first option is unavailable for the high block chosen after
full-support pathwise uniformization. The second is outside the current atlas
semantics. The third undercuts the isolated-block target lower bound, because
nontrivial efficient prediction of unseen PRF/random-oracle labels is exactly
the hard task.

### Consequences For The Edge

This branch does not prove the implication true. It only rules out the
remaining loophole in the leading deterministic rare-block false route. A
positive proof still needs a weak-gap uniformization theorem or a boosting
argument that budgets the marginal-dependent weak gaps uniformly enough for
the distribution-free target.

It also does not give an atlas-ready counterexample. Instead, it says the
memorization-scale idea cannot be exploited under the current deterministic
semantics unless a new deterministic orientation-free gadget is found. The
known way to make the rare-block source work is still to change conventions to
stochastic final hypotheses, or to weaken the pathwise resource convention so
that the learner may spend enough samples to identify the hidden signs.

### Branch Verdict

The memorization-scale loophole can be closed for the rare-block
PRF/random-oracle template by strengthening the test marginals from global
tiny biases to coordinate-wise tiny biases. This gives a conditional no-go
theorem for deterministic memorization-only weak handles, not a graph-level
resolution of the edge.

VERDICT: conditional-only

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 4 Branch A: Positive Diagonal After Rare-Block No-Go

- date: 2026-05-07
- branch: positive diagonal theorem after deterministic rare-block no-go
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-realizable-improper-pac`
- write scope: appended to this scratchpad only; no atlas files, legacy LaTeX files, or `references.bib` edited
- short verdict: the strongest clean positive theorem is conditional on size-indexed or local-envelope semantics; current global marginals plus pathwise resources do not by themselves give the needed weak-gap uniformization

### Goal

Depth 3 blocked the leading deterministic rare-block counterexample route:
coordinate-wise biased marginals force any deterministic memorization-only
weak handle either to sample too many fibers or to predict hidden unseen
labels. That removes the most tempting false witness. The remaining question
is whether the absence of that witness should be upgraded to a positive
theorem.

The desired theorem would say that a single pathwise-polynomial marginal
weak agnostic improper learner automatically has a distribution-free
inverse-polynomial weak gap on realizable labels. If so, the present edge
would be true by ordinary realizable boosting.

### What Is Already Uniform

Let $A$ be the source learner and fix a constant confidence, say
$\delta=1/3$. By the full-support finite-transcript argument, one call to
$A$ has a distribution-free pathwise sample/time polynomial $m(s)$ under the
atlas resource convention.

On realizable labels, however, the accuracy statement remains
marginal-dependent:

$$
\forall P\ \exists r_P\text{ polynomial}\quad
\operatorname{err}_P(A,c)\le \frac12-\frac{1}{r_P(s)}
$$

for every target $c\in\mathcal C$ of representation size $s$. The missing
target-side statement is the quantifier-swapped envelope

$$
\exists r\text{ polynomial}\quad
\forall P,c,s\quad
\operatorname{err}_P(A,c)\le \frac12-\frac{1}{r(s)}.
$$

If this envelope were available, Schapire/Freund boosting would apply to the
distribution-free weak learner. The final boosted vote is allowed to be
improper, and the runtime would be polynomial in
$(s,1/\varepsilon,\log(1/\delta))$ with quantitative dependence on $r$.

Thus the whole positive problem is weak-gap uniformization, not one-call
resource uniformization.

### Conditional Theorem: Size-Indexed Marginals

Here is the clean theorem that would make the edge true under a nearby
semantics.

**Theorem.** Suppose a marginal is interpreted as a size-indexed family
$P=(P_s)_{s\ge 1}$, where the size-$s$ guarantee is evaluated under the
full-mass marginal $P_s$. Suppose one learner $A$ satisfies the
marginal-nonuniform weak agnostic improper source under this semantics, with
pathwise-polynomial resources. Then, on realizable labels, $A$ has a
distribution-free inverse-polynomial weak gap. Consequently the edge to
efficient realizable improper PAC learning is true.

**Proof plan.** Resource uniformization is already supplied by the
full-support transcript argument. It remains to prove the gap envelope.

Assume no distribution-free inverse-polynomial gap exists. Then for every
exponent $d$ there are a size $s_d$, a full-mass marginal $Q_d$ on the
size-$s_d$ slice, and a realizable target $c_d$ such that $A$ fails to achieve
advantage $s_d^{-d}$ at the fixed confidence level. Choose the sizes
increasing fast enough to absorb constants and lower-order terms.

Build one size-indexed diagonal marginal family by setting

$$
P_{s_d}=Q_d
$$

on the selected sizes, and fill unselected sizes arbitrarily. The source
guarantee for this single marginal family $P$ supplies one polynomial
$r_P(s)\le C s^D$. For all selected sizes, $A$ must therefore achieve
advantage at least

$$
\frac{1}{r_P(s_d)}\ge \frac{1}{C s_d^D}.
$$

Taking $d>D$ and then $s_d$ large enough gives

$$
\frac{1}{C s_d^D} > s_d^{-d},
$$

contradicting the choice of $Q_d,c_d$. This proves the uniform weak gap.
Boosting then gives the strong distribution-free improper realizable target.

This theorem is the strongest clean positive diagonal result I can state.
It also applies to the present improper source, not just the proper sibling,
because the argument only uses the source learner after restricting to
realizable labels.

### Why The Theorem Does Not Apply To Current Global Marginals

The atlas currently treats a marginal as one global probability measure over
instances. The attempted analogue of the size-indexed diagonal is a weighted
mixture

$$
P=\sum_{j\ge 1} w_j Q_j.
$$

This loses the crucial "full mass at size $s_j$" step. The bad component
$Q_j$ is visible only through its weight $w_j$, and the weights must be
summable. A weak additive guarantee under the global marginal need not force
the learner to obtain the local weak edge inside a low-mass component.

In the realizable specialization, a target that is hard only on component
$j$ and easy elsewhere can be learned weakly by ignoring the component when
$w_j$ is small. The global error from that neglected component is at most
$w_j/2$, so the learner may have a large global advantage while having no
local advantage on $Q_j$.

Trying to neutralize the other components by moving to the agnostic source
does not fix the issue. If labels outside $Q_j$ are pure noise, then
$\operatorname{OPT}$ under the global distribution rises by about
$(1-w_j)/2$, and the fixed-additive weak agnostic requirement

$$
\operatorname{err}(h)\le \operatorname{OPT}+\frac12-\gamma_P(s)
$$

becomes too slack to force learning on the small component. If labels outside
$Q_j$ are realizable and easy, they again supply global advantage that can
hide local failure. The source guarantee measures global additive error; it
does not inspect each mixture component at full mass.

Pathwise resources do not repair this. They bound how long $A$ can run on
finite transcripts, but they do not convert a low-mass component of a global
probability measure into a full-mass test distribution. The rare-block no-go
shows that one deterministic counterexample template cannot satisfy the
source on all concentrated marginals. It does not prove that every possible
marginal-dependent weak gap has a global polynomial lower envelope.

### What Current Semantics Might Still Give

With extra finiteness assumptions, pathwise resources can give a much weaker
compactness statement. For a fixed representation size $s$, if the relevant
instance slice and transcript space are finite and every marginal/target pair
has a strict weak advantage, continuity can give a positive fixed-size
minimum

$$
g_s=\inf_{P,c}\left(\frac12-\operatorname{err}_P(A,c)\right)>0.
$$

This is not an efficient PAC theorem. The sequence $(g_s)$ may decay faster
than every inverse polynomial, and the compactness argument has no mechanism
relating size $s$ to size $s+1$. Boosting and validation need quantitative
control polynomial in $1/g_s$; a merely positive but super-polynomially small
gap is useless for the target node.

So the strongest statement I can defend under current global marginals is
negative about the proof method, not positive about the edge:

> Full-support pathwise resources can uniformize the cost of one weak call
> and may give nonquantitative fixed-size positivity under finiteness
> assumptions. They do not, without a size-indexed full-mass interpretation
> or an additional local-uniformity/envelope assumption, promote
> $\forall P\,\exists r_P$ weak gaps to one $\exists r\,\forall P$ weak gap.

### Strongest Conditional True Versions

The edge would be resolved true under any of the following strengthened
conditions.

1. **Uniform weak-gap envelope.** The source learner has
   $\gamma_P(s)\ge 1/r(s)$ for one polynomial $r$ independent of $P$ on
   realizable labels. This is exactly the missing target-side weak learner;
   Schapire/Freund boosting finishes.

2. **Size-indexed marginal semantics.** Marginals are families
   $(P_s)_{s\ge 1}$ evaluated with full mass at each size. The diagonal
   theorem above forces the uniform weak-gap envelope, and boosting finishes.

3. **Local envelope for booster marginals.** For every original marginal
   $P$, all filtered or reweighted marginals generated by a realizable
   booster have source weak gaps dominated by one polynomial depending only
   on $P$, and this polynomial can be made distribution-free by the
   full-support transcript argument. This is a bounded-density/KL-stability
   style assumption, not part of the current source definition.

Only the first two give a clean graph-level positive theorem. The third is
more like a sufficient condition for a particular boosting reduction.

### Branch Conclusion

The deterministic rare-block no-go is evidence against the easiest false
route, but it does not by itself create a positive uniformization theorem.
The clean positive diagonal proof needs size-indexed full-mass marginals (or
an equivalent local-uniformity assumption). Under the current weighted-global
marginal semantics, low-mass bad slices can be hidden from the additive weak
guarantee, and pathwise resource bounds do not change that accuracy
bookkeeping.

Thus the actual atlas edge remains unresolved. The strongest result from
this branch is conditional: change the semantics to size-indexed marginals,
or add a distribution-free weak-gap envelope, and the edge becomes true by
standard realizable boosting.

VERDICT: conditional-only

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Atlas-Note Consolidation Draft

- date: 2026-05-07
- branch: atlas-note consolidation for current weighted-global semantics
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-realizable-improper-pac`
- write scope: appended to this scratchpad only; no atlas files, legacy LaTeX files, or `references.bib` edited
- short verdict: still open; the clean true routes are conditional, and the leading false route is blocked by deterministic-output semantics

### Last Unconditional Check

The source gives one uniform learner $A$. By the full-support
finite-transcript argument, one call to $A$ has a distribution-free pathwise
sample/time polynomial under the current atlas resource convention. On
realizable labels, the source also gives a weak improper learner for each
marginal $P$, with gap

$$
\gamma_P(s)=\frac12-\beta_P(s)>0.
$$

The unresolved quantifier swap is exactly:

$$
\forall P\ \exists r_P\text{ polynomial}\quad
\gamma_P(s)\ge \frac{1}{r_P(s)}
$$

versus the distribution-free weak learner needed for standard boosting:

$$
\exists r\text{ polynomial}\quad
\forall P\quad
\gamma_P(s)\ge \frac{1}{r(s)}.
$$

I do not see a way to derive the second statement under the current
weighted-global marginal semantics. The full-support argument uniformizes
resources, not accuracy. Compactness over a fixed finite size slice could at
best give a positive fixed-size minimum gap $g_s$, with no reason for
$1/g_s$ to be polynomial in $s$. Empirical validation or adaptive searching
for the hidden gap costs order $\gamma_P(s)^{-2}$ samples, which is allowed
for the marginal-nonuniform source but not for the distribution-free target
when the exponent in $r_P$ is unbounded.

The sample-only collapse also does not resolve the computational edge.
Ignoring runtime, the marginal-nonuniform sample guarantee collapses to finite
VC dimension and distribution-free sample learning. That leaves open exactly
the polynomial-time improper learner demanded by the target.

### Conditional True Forks

The edge would become `true` under any of the following strengthened
statements.

1. **Uniform weak-gap envelope.** Strengthen the source, or prove as a
   theorem, that the single source learner has one distribution-free
   inverse-polynomial realizable gap:

   $$
   \exists r\text{ polynomial}\ \forall P,c,s\quad
   \Pr\!\left[
   \operatorname{err}_P(A(S),c)\le \frac12-\frac1{r(s)}
   \right]\ge \frac23.
   $$

   Full-support resource uniformization plus Schapire/Freund realizable
   boosting would then give the target.

2. **Size-indexed full-mass marginal semantics.** If a marginal were a family
   $(P_s)_{s\ge 1}$ and the guarantee at size $s$ were evaluated under
   $P_s$ with full mass, then the usual diagonal proof works. Bad gaps at
   sizes $s_d$ can be stitched into one marginal family, contradicting the
   source polynomial for that family. This would force the uniform weak-gap
   envelope and hence the target.

3. **Local envelope for booster marginals.** A particular boosting proof
   would also go through if all filtered, reweighted, or marginal-preserving
   distributions generated during boosting had weak gaps dominated by one
   polynomial that can be made distribution-free. This is a bounded-density,
   KL-stability, or local-uniformity assumption, not part of the present
   source node.

The fixed-additive agnostic promise is not the main obstacle for a fixed
marginal. In $\{\pm1\}$ notation it is a nontrivial correlation oracle:

$$
\operatorname{corr}(h,Y)
\ge \sup_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta_P(s).
$$

On realizable labels the nontriviality margin is
$\theta_P(s)=1-2\beta_P(s)=2\gamma_P(s)$. Marginal-preserving agnostic
boosting would still have overhead depending on $1/\theta_P(s)$, so it does
not by itself remove the missing distribution-free envelope.

### Blocked Rare-Block False Route

The strongest false template remains the rare-block PRF/random-oracle
construction. The target-side lower bound is plausible: choose a hard block
whose level exceeds the exponent of any alleged distribution-free polynomial
learner, and low error on the isolated block would predict unseen
pseudorandom labels.

The source side is the blocker. Under current semantics the learner outputs
an ordinary deterministic binary hypothesis after training; training
randomness is fixed before measuring zero-one error. On a paired hard block,
coordinate-wise biased realizable marginals expose any deterministic unseen
rule:

- constant behavior is exposed by hidden marginal signs;
- one-hot behavior is exposed by hidden target labels;
- sampled-coordinate corrections contribute only $O(m/r)$ when the one-call
  pathwise sample bound is $m$ and the block has $r\gg m^2$ fibers.

Thus a memorization-only weak handle cannot satisfy the source on all
concentrated, nearly balanced, coordinate-wise biased marginals unless it
samples too many fibers or predicts unseen hidden labels. The first option
violates the pathwise resource bound for the high block. The second undercuts
the target-side PRF/oracle lower bound. This blocks the known deterministic
rare-block false route rather than proving the edge false.

### Deterministic Output Caveat

Do not treat an ordinary randomized training algorithm as a stochastic final
hypothesis. Under the current atlas reading, after the learner's training
coins are fixed, the output is one hypothesis $h$ and its error is
$\Pr_{X\sim P}[h(X)\ne c(X)]$.

Fresh prediction-time randomness would change the situation. If the atlas
added separate stochastic-final-hypothesis nodes, a rare-block learner could
memorize sampled fibers and flip fresh fair coins on unseen fibers, giving
conditional error $(1-W)/2$ where $W$ is covered mass. The corresponding
strong target would still look false under PRF security or in a random-oracle
model after explicit evaluator and lower-bound lemmas are written. That is a
conditional false fork for a different convention, not evidence to flip the
current deterministic-output edge.

### Suggested Atlas Summary If Still Open

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
summary: "Open under the current weighted-global marginal semantics: full-support uniformization gives one transcript-wise resource bound, and the weak agnostic source gives a nontrivial fixed-marginal correlation oracle on realizable labels, but no theorem uniformizes the marginal-dependent weak gaps needed for distribution-free boosting. The leading rare-block false route is blocked by deterministic-output orientation tests."
```

Suggested body language:

```markdown
The source specializes on realizable labels to a weak improper learner with
marginal-dependent advantage
$\gamma_P(s)=1/2-\beta_P(s)$. Full-support marginal uniformization controls
the pathwise sample and running time of one call to the source learner, but it
does not lower-bound $\gamma_P(s)$ uniformly over marginals.

The exact missing theorem is weak-gap uniformization: from one
pathwise-polynomial learner satisfying
$\forall P\,\exists r_P$ with
$\gamma_P(s)\ge 1/r_P(s)$, derive one polynomial $r$ such that
$\gamma_P(s)\ge 1/r(s)$ for every marginal $P$ on realizable labels. With that
theorem, standard realizable boosting would prove the edge true. A
size-indexed full-mass marginal semantics would supply such a theorem by
diagonalization, but the current weighted-global semantics does not:
low-mass bad slices can be hidden from a global additive weak guarantee.

No atlas-ready counterexample is known. Rare-block PRF or oracle witnesses
give the right target-side hardness, but deterministic final hypotheses face
coordinate-wise tiny-bias orientation tests on the source side. Stochastic
final hypotheses or a different resource convention could revive that false
route only after an explicit schema change.
```

### Final Consolidated Recommendation

Keep the current edge `open`. The next atlas-level improvement should be to
name the missing `weak-gap-uniformization` theorem, or to add a convention
fork for stochastic final hypotheses. Under the current deterministic-output,
pathwise-resource, weighted-global marginal semantics, I cannot prove the edge
true and I also do not have a source-positive, target-negative witness.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 6 Branch A: Final Theorem Or Counterexample Check

- date: 2026-05-07
- branch: final theorem/counterexample check under deterministic weighted-global semantics
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-realizable-improper-pac`
- write scope: appended to this scratchpad only; no atlas files, legacy LaTeX files, or `references.bib` edited
- short verdict: still unresolved; improperness removes a syntactic output obstruction but not the weak-gap obstruction, and the stochastic false route does not determinize

### Final Positive-Theorem Check

The source is stronger than the proper-source analogue because the weak
learner may output any efficiently evaluable binary hypothesis. On realizable
labels it gives, for each marginal $P$, an improper weak learner with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)\ge \frac1{r_P(s)}
$$

for some polynomial $r_P$ that may depend on $P$.

Improperness does not seem to make the standard theorem route easier in the
needed way. Once the target is already improper, Schapire/Freund boosting can
use either proper or improper weak hypotheses; the final majority vote is
allowed in both cases. Thus the proper-source analogue was not blocked by the
properness of each weak hypothesis. It was blocked by the missing quantitative
envelope

$$
\exists r\text{ polynomial}\ \forall P\quad
\gamma_P(s)\ge \frac1{r(s)}.
$$

The same envelope is still missing here. Full-support marginal
uniformization gives one distribution-free pathwise sample/time bound for one
call to the source learner, but it does not convert
$\forall P\,\exists r_P$ into $\exists r\,\forall P$ for the advantage.

The agnostic part of the source also remains only a fixed-marginal near miss.
In correlation notation, a fixed-additive weak agnostic learner is a
nontrivial oracle with margin proportional to $2\gamma_P(s)$ on a fixed
marginal. Distribution-specific agnostic boosting can plausibly turn this
into a strong learner for that marginal with overhead polynomial in
$1/\gamma_P(s)$. That still yields at most a marginal-nonuniform strong
learner unless some separate theorem bounds the gaps uniformly over the
marginals used by the booster.

### Why Improper Outputs Do Not Supply A Hidden Certificate

One possible hope was that an improper source hypothesis might carry more
information than a proper weak handle: perhaps validation, disagreement
tests, or non-black-box inspection of the output circuit could reveal the
hidden advantage scale. I do not see a valid argument.

The PAC guarantee says that the output has small true error with high
probability under the current marginal. It does not provide a certified
lower bound on its advantage. Estimating whether a candidate has edge
$\gamma$ rather than zero costs $\Omega(\gamma^{-2})$ samples, and the hidden
exponent in $\gamma_P(s)\ge s^{-k(P)}$ may be arbitrarily large across
marginals. The output being improper changes the hypothesis space, not this
statistical cost.

Nor does repeated use of the agnostic learner solve the issue. Any boosting
or residual-focusing scheme must either call the weak learner on reweighted
marginals whose gaps may have new hidden exponents, or use a
same-marginal agnostic reduction whose quantitative guarantee still depends
on the original hidden gap. Without a uniform gap certificate, the number of
rounds and validation samples cannot be bounded by one distribution-free
polynomial.

### Final Deterministic Counterexample Check

The best false route is still a rare-block PRF or random-oracle construction:
choose a high block of size $r=s^j$ so that any alleged distribution-free
polynomial-time strong learner sees too few fibers to predict unseen hard
labels. The target-side lower bound is plausible.

The source-side lemma remains the failure point, and this is where
improperness matters most. Because the source learner is already improper,
the rare-block audit must rule out arbitrary deterministic binary outputs,
not merely constants, singletons, or proper handles. Depths 2 and 3 gave the
right diagnostic. On a paired block with target

$$
c_f(i,b)=1\Longleftrightarrow b=f(i),
$$

any deterministic hypothesis decomposes coordinate-wise into:

- constant behavior, exposed by hidden marginal signs $\theta_i$;
- one-hot behavior, exposed by hidden target labels $f(i)$;
- sampled-coordinate corrections, contributing only $O(m/r)$ when one weak
  call has pathwise sample bound $m$.

For $r\gg m^2$, coordinate-wise biased realizable marginals make the unseen
deterministic contribution fluctuate on a larger scale than the memorized
sample contribution. Thus a deterministic source learner that succeeds on
all such marginals must either sample many more fibers or predict hidden
unseen labels/signs. The first option violates the high-block pathwise bound;
the second defeats the intended target-side hardness. This blocks the known
rare-block false witness even for improper source outputs.

This is not a theorem that no counterexample exists. It only says that the
obvious way of exploiting impropriety, namely outputting richer deterministic
weak handles on the hard block, does not evade the coordinate-wise
orientation test.

### Stochastic Fork Does Not Determinize

Fresh prediction-time randomness would change the source side. A learner
could memorize sampled fibers and flip a fresh fair coin on unseen fibers;
under an evaluator that measures expected loss over prediction coins, the
unseen mass contributes exactly $1/2$ error and the sampled mass gives a tiny
marginal-dependent weak edge. The same hard block could still look
target-negative for deterministic strong learning.

That construction does not become a deterministic counterexample under the
current atlas semantics. If the learner fixes a random seed during training
and outputs the resulting deterministic table or circuit, then after the
seed is fixed the unseen predictions face the same coordinate-wise signs and
hidden labels as any other deterministic hypothesis. For $r\gg m^2$, the
fixed-seed unseen fluctuation dominates the $O(m/r)$ memorization gain with
constant probability, so the high-probability weak PAC guarantee fails for
some concentrated marginal. A public hash, pseudorandom tie-breaker, or
balanced deterministic rule is still just one deterministic rule, and an
arbitrary marginal can weight the coordinates where it is oriented the wrong
way.

Thus the stochastic idea is a genuine model fork, not a deterministic
counterexample waiting to be derandomized. It would require separate
stochastic-final-hypothesis nodes and an explicit choice of whether risk is
measured in expectation over prediction-time coins or after fixing a
hypothesis.

### Depth-7 Final Consolidation Bullets

If this edge gets one final consolidation pass, the atlas-facing bullets
should be:

- Keep the edge `open` under current deterministic weighted-global marginal
  semantics.
- Record the exact positive obstruction as weak-gap uniformization:
  full-support transcript uniformization controls resources, not the
  marginal-dependent advantages.
- State the conditional true theorem: a distribution-free inverse-polynomial
  weak-gap envelope, or size-indexed full-mass marginal semantics, plus
  standard realizable boosting proves the target.
- State that impropriety of the source does not remove the obstruction,
  because the target is already improper and boosting can already aggregate
  proper weak hypotheses.
- Record the counterexample obstruction: rare-block PRF/oracle target
  hardness is plausible, but deterministic source positivity fails on
  coordinate-wise biased marginals unless the learner predicts unseen hard
  labels.
- Treat stochastic final hypotheses as a model fork, not as evidence for
  `false` in the current graph.
- Suggested summary: "Open under current weighted-global deterministic-output
  semantics: one weak call can be resource-uniformized, but no known theorem
  uniformizes the marginal-dependent weak gaps; improper source outputs do
  not bypass this, and the leading stochastic rare-block separation requires
  a different output semantics."

### Final Branch Verdict

The final depth-6 check did not produce a theorem or a counterexample.
Improperness strengthens the source but does not address the only known
positive-theorem bottleneck, and the strongest false route still needs a
model change or a new deterministic orientation-free hard-block gadget.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 7 Final Consolidation

- date: 2026-05-07
- depth: 7
- note: canonical end-of-scratchpad consolidation; earlier depth-7 copies above were misplaced because the scratchpad has repeated verdict trailers
- write scope: scratchpad only; no atlas files, legacy LaTeX files, or `references.bib` edited
- final verdict: unresolved under the current atlas semantics

### Final Verdict

Keep the edge `open`.

The source specializes to realizable labels as a marginal-dependent weak
improper learner:

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
\qquad
\gamma_P(s)\ge \frac1{r_P(s)}.
$$

The target would follow from a distribution-free weak learner plus standard
realizable boosting, but that needs one polynomial $r$ such that
$\gamma_P(s)\ge 1/r(s)$ for every marginal $P$. Full-support transcript
uniformization gives one distribution-free pathwise sample/time bound for a
call to the source learner; it does not uniformize the weak advantage. The
unresolved quantifier swap is

$$
\forall P\,\exists r_P
\quad\text{versus}\quad
\exists r\,\forall P.
$$

### Conditional True Forks

The edge becomes `true` under any one of these additional statements:

1. **Uniform weak-gap envelope.** If the source learner has one
   distribution-free inverse-polynomial realizable gap, full-support resource
   uniformization plus Schapire/Freund boosting gives efficient realizable
   improper PAC learning.

2. **Size-indexed full-mass marginal semantics.** If a marginal is a family
   $(P_s)_{s\ge 1}$ and the size-$s$ guarantee is evaluated under full mass
   $P_s$, bad gaps at increasing sizes can be diagonalized into one marginal
   family. The source polynomial for that family then forces a uniform weak
   gap, and boosting proves the target.

3. **Local envelope for booster marginals.** If every filtered, reweighted,
   or label-modified marginal generated by a boosting reduction has weak gaps
   dominated by one distribution-free polynomial, the usual boosting analysis
   can be made distribution-free. This is a new bounded-density/KL-stability
   or local-uniformity assumption, not part of the present source node.

### Failed Counterexample Routes

The strongest target-negative route is still a rare-block PRF or
random-oracle construction: choose a hard paired block much larger than any
alleged distribution-free polynomial strong learner can sample or evaluate,
so low error on the isolated block would predict unseen hard labels. This
target-side lower bound is plausible under the standard efficient-output
evaluator convention and PRF security.

The source side is the blocker. The source must work for all marginals,
including concentrated, nearly balanced, coordinate-wise biased marginals on
the hard block. Under the current deterministic-output atlas reading, any
final hypothesis on a paired block with

$$
c_f(i,b)=1 \Longleftrightarrow b=f(i)
$$

decomposes into constant behavior exposed by hidden marginal signs, one-hot
behavior exposed by hidden target labels, and sampled-coordinate corrections
of total scale $O(m/r)$ when one weak call has pathwise sample bound $m$ and
the block has $r$ fibers. For $r\gg m^2$, coordinate-wise biased marginals
make the unseen deterministic contribution larger than the memorized sample
gain. Thus a memorization-only weak handle cannot satisfy the source unless
it samples many more fibers or predicts unseen hard labels/signs. The first
option contradicts the full-support pathwise resource bound on high blocks;
the second defeats the intended target hardness.

This blocks the known deterministic rare-block false route, including
constants, singleton handles, public hashes, fixed pseudorandom tie-breakers,
and richer deterministic improper circuits. Fresh prediction-time randomness
would change the model: memorizing sampled fibers and flipping fresh fair
coins on unseen fibers could be source-positive in expected loss, but that
requires separate stochastic-final-hypothesis nodes rather than a status
change here.

### Exact Obstacle

The remaining obstacle is weak-gap uniformization under weighted-global,
deterministic-output semantics:

> Given one pathwise-polynomial learner whose realizable weak gap is
> inverse-polynomial for each fixed marginal with a marginal-dependent
> exponent, prove or refute that there is one distribution-free
> inverse-polynomial lower bound on those gaps.

The current weighted-global semantics blocks the clean diagonal proof. In a
mixture $P^\star=\sum_j w_jQ_j$, a bad high-size slice has only mass $w_j$.
A global additive weak guarantee may ignore sufficiently low-mass bad slices,
and easy labels on the remaining mass can hide local failure. Making the
other components noisy raises $\operatorname{OPT}$ and leaves the
fixed-additive $1/2-\gamma_{P^\star}(s)$ tolerance too slack to force local
learning. Fixed-size compactness is also insufficient: it may give a positive
$g_s$, but not $1/g_s\le s^O(1)$.

### Proposed Atlas Summary

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
summary: "Open under current weighted-global deterministic-output semantics: full-support transcript uniformization gives one pathwise resource bound, and the source gives a fixed-marginal weak agnostic/correlation oracle on realizable labels, but no known theorem uniformizes the marginal-dependent weak gaps needed for distribution-free boosting. Rare-block PRF/oracle false routes are blocked on the source side by deterministic coordinate-wise orientation tests."
```

### Proposed Atlas Body Text

```markdown
The source specializes on realizable labels to a weak improper learner with
marginal-dependent advantage
$\gamma_P(s)=1/2-\beta_P(s)$. Full-support marginal uniformization controls
the pathwise sample and running time of one call to the single source learner,
but it does not lower-bound $\gamma_P(s)$ uniformly over marginals.

The missing theorem is weak-gap uniformization: from
$\forall P\,\exists r_P$ with $\gamma_P(s)\ge 1/r_P(s)$, derive one
polynomial $r$ such that $\gamma_P(s)\ge 1/r(s)$ for every marginal $P$ on
realizable labels. With such a theorem, standard realizable boosting would
prove the edge true. A size-indexed full-mass marginal semantics would give
this by diagonalization, but the current weighted-global semantics does not:
low-mass bad slices can be hidden from a global additive weak guarantee.

The fixed-additive agnostic promise is a useful fixed-marginal near miss. In
correlation form it gives a nontrivial weak oracle with margin proportional
to $2\gamma_P(s)$ on realizable labels. Distribution-specific agnostic
boosting can amplify such an oracle when the margin is supplied, but the
overhead still depends on the hidden marginal-dependent gap.

No atlas-ready counterexample is known. Rare-block PRF or random-oracle
witnesses give plausible target-side hardness, but deterministic final
hypotheses face coordinate-wise tiny-bias orientation tests on the source
side. A source-positive hard block would need either a genuine deterministic
orientation-free weak handle or nontrivial prediction of unseen hard labels,
the latter defeating the intended target lower bound. Stochastic final
hypotheses could revive the false route only after an explicit schema change.
```

### Primary-Source Anchors

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability":
  https://openreview.net/forum?id=aoVCFtox89
- Schapire, "The Strength of Weak Learnability":
  https://www.schapire.net/papers/strengthofweak.pdf
- Freund, "Boosting a Weak Learning Algorithm by Majority":
  https://doi.org/10.1006/inco.1995.1136
- Feldman, "Distribution-Specific Agnostic Boosting":
  https://arxiv.org/abs/0909.2927

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
