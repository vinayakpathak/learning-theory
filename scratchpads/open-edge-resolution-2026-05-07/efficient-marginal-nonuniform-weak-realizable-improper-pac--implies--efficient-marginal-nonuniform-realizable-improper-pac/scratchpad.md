# Edge Investigation Scratchpad

- date: 2026-05-07
- worker depth: 1
- edge: `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-improper-pac`
- target: `efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: scratchpad only; no atlas files, `references.bib`, or legacy LaTeX edited

## Executive Verdict

`conditional-only`.

Under the atlas semantics as currently written, I would not change the edge from
`open`. The positive direction is still blocked by the lack of an
original-marginal envelope over booster-induced marginals. However, the prior
May 5 rare-block construction is strong enough to record a conditional
counterexample route: assuming secure pseudorandom functions and the standard
computational PAC convention that an efficient improper learner's printed
hypothesis is polynomial-time evaluable, the edge should be false.

The reason I do not mark this `resolved-false` under current atlas semantics is
not the cryptographic assumption. The atlas already allows conditional
counterexamples. The blocker is that the current definition notes and
`atlas/README.md` explicitly bound training/sample pathwise resources, but do
not explicitly state that final improper hypotheses have a polynomial-time
evaluation procedure. The PRF lower bound needs to evaluate the learner's output
on fresh points.

## Local Files Read

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- linked/boundary notes: `atlas/witnesses/halfspaces.md`, `atlas/witnesses/clause-satisfaction-lookup-class.md`, `atlas/witnesses/unrestricted-labelings.md`
- related cryptographic notes: `atlas/witnesses/pseudorandom-function-classes.md`, `atlas/arguments/sample-to-computational-hardness.md`, `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`, `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- prior exact scratchpads:
  - `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`
  - `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Primary Sources Checked

- Schapire, "The Strength of Weak Learnability" (1990): https://www.schapire.net/papers/strengthofweak.pdf
- Freund, "Boosting a Weak Learning Algorithm by Majority" (1995): https://doi.org/10.1006/inco.1995.1136
- Feldman, "Distribution-Specific Agnostic Boosting" (2010): https://arxiv.org/abs/0909.2927
- Servedio, "Smooth Boosting and Learning with Malicious Noise" (2003): https://jmlr.csail.mit.edu/papers/volume4/servedio03a/servedio03a.pdf
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025): https://openreview.net/forum?id=aoVCFtox89
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data" (ICML 2025): https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved Running Time" (ALT 2026): https://arxiv.org/abs/2601.11265
- Goldreich, Goldwasser, and Micali, "How to Construct Random Functions" (1986): https://www.wisdom.weizmann.ac.il/~oded/ggm.html
- Hastad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function" (1999): https://www.cs.bu.edu/fac/lnd/pdf/hill.pdf

## Current Atlas Semantics

The source says there is one uniform learner `A` such that for every marginal
`P` there are a polynomial `p_P` and an inverse-polynomial weak advantage
`gamma_P(s)>0` with

$$
\operatorname{err}_P(A,c) \le 1/2-\gamma_P(s)
$$

for every target `c`, with sample and running time bounded by
`p_P(s, log(1/delta))`.

The target asks for one uniform learner `B` such that for every marginal `P`
there is a polynomial `q_P` with

$$
\operatorname{err}_P(B,c) \le \varepsilon
$$

for every target `c` and every `epsilon,delta`, using time and samples bounded
by `q_P(s, 1/epsilon, log(1/delta))`.

The README adds that efficient resource bounds are worst-case/pathwise bounds
on finite encoded sample transcripts. I found no global text saying that an
improper output hypothesis must be polynomial-time evaluable from its printed
representation.

## Positive Route: Still Blocked

Classical Schapire/Freund boosting proves weak-to-strong equivalence in the
distribution-free realizable setting. The proof calls the weak learner on
filtered or reweighted marginals

$$
Q_t = Q_t(P_0,c,h_1,\ldots,h_{t-1},\text{randomness})
$$

generated from the original marginal `P_0`.

For this edge, the source gives only pointwise promises

$$
\forall Q\ \exists p_Q,\gamma_Q\ \forall c.
$$

The target would need one original-marginal polynomial envelope, independent of
the target concept, controlling all weak calls that the booster may make:

$$
\sup_{Q\in\mathsf{Filt}(P_0,c,\varepsilon)}
\left(p_Q,\frac1{\gamma_Q},\text{sampling overhead}(P_0\to Q)\right)
\le \operatorname{poly}_{P_0}(s,1/\varepsilon,\log(1/\delta)).
$$

The current source definition does not imply this filter-stable, KL-stable, or
bounded-density-stable envelope. Freund's distribution-specific analysis is a
near miss because it assumes quantitative control of weak accuracy as the
filtered distribution moves away from the target distribution. Smooth boosting
limits `dQ/dP`, but still requires a lower envelope over all bounded-density
perturbations. Feldman/Ghai-style distribution-specific agnostic boosting keeps
the instance marginal fixed by changing labels, but the source here is only
realizable weak learning, so it has no guarantee on those relabeled/noisy
oracle calls.

Full-support marginal uniformization helps only with pathwise sample and
training-time bounds for a fixed learner. It does not transfer weak advantage
from one marginal to another.

Therefore I found no `resolved-true` proof under the current node semantics.

## Conditional False Route

The rare-block PRF/singleton-handle construction from the May 5 scratchpad
appears to give a real conditional counterexample once output evaluation is
made explicit.

### Construction

Assume a secure PRF family `F_k:{0,1}^n -> {0,1}` with key length `n`. For each
block level

$$
1\le j\le J(n)=\left\lfloor\frac{n}{4\log n}\right\rfloor,
$$

let `U_{n,j}` be the first `N_{n,j}=n^j` strings of length `n`, and set

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\}.
$$

The concept `c_{n,j,k}` is active on one block:

$$
c_{n,j,k}(n',j',u,b)=1
\quad\Longleftrightarrow\quad
(n',j')=(n,j)\text{ and }b=F_k(u),
$$

and is zero outside that block. The pair bit `b` makes each active block
balanced under the uniform block marginal.

### Why The Source Holds

Use an improper weak learner that tries constants and sample-found positive
singletons, with staged sample sizes and fresh validation.

For a fixed marginal `R` and target `c`, let `M=R(c^{-1}(1))`. If `M` is not
near `1/2`, one of the two constants has a weak edge. If `M` is near `1/2`,
then the active block has constant `R`-mass. For a fixed `R`, only finitely many
blocks can have that much mass. On each such finite block, a heaviest positive
atom gives a singleton with advantage at least inverse-polynomial in the block
size. The maximum relevant block exponent over the finitely many `R`-heavy
blocks is absorbed into the `R`-dependent polynomial.

Thus the source learner is uniform, and for every marginal `R` it has some
`R`-dependent inverse-polynomial weak edge and resource bound. This uses the
atlas's global-mixture reading of a marginal; a size-conditioned marginal
semantics would need separate auditing.

### Why The Target Fails Conditionally

Fix one marginal `P` with mass

$$
P(B_{n,j})=w_{n,j}=Z^{-1}2^{-j}n^{-2},
$$

uniformly inside each block. For target `c_{n,j,k}`, request

$$
\varepsilon_{n,j}=w_{n,j}/64.
$$

Any hypothesis with `P`-error at most `epsilon_{n,j}` has small conditional
error on `B_{n,j}` and therefore predicts `F_k(u)` on a fresh
`u in U_{n,j}` with constant advantage by evaluating the hypothesis on
`(n,j,u,0)` and `(n,j,u,1)`.

Suppose a target learner existed for this fixed `P`, with polynomial `q_P`.
Let `D` bound the total degree of `q_P`, and choose a fixed block level
`j > 4D+10`. Since `1/epsilon_{n,j}=Theta(2^j n^2)` for fixed `j`, the learner
uses only `n^{O(D)}` samples/time on size `s=Theta(n+j)`. The expected number
of active-block samples is then `n^{O(D)-2}`, while the block contains
`N_{n,j}=n^j` independent PRF input indices. For large `n`, the learner sees
`o(N_{n,j})` active indices.

In the random-function hybrid, unseen active labels remain independent of the
learner's transcript, so no output can predict fresh active labels with
constant advantage. In the PRF world, the alleged low-error learner would give
such a predictor. With an efficient output evaluator, this is a polynomial-time
distinguisher between the PRF and a random function, contradicting PRF
security. Via GGM and HILL, this can be phrased under one-way-function-style
cryptographic assumptions if desired.

This defeats improper learners: the learner may output any polynomial-size
table, circuit, or vote, but it still has to predict many unseen pseudorandom
labels in the active block.

## Why This Is Not A Current `resolved-false`

The lower bound needs to run the learned hypothesis on fresh inputs. The
definition notes I read say the learner "outputs a hypothesis" and bound
training/sample time, but do not explicitly require polynomial-time prediction
from the output representation. Existing cryptographic atlas notes implicitly
use the standard PAC convention that efficient hypotheses are usable/evaluable,
but the convention is not stated globally.

If the atlas adds this convention, or if an edge/argument note records it as an
explicit assumption, the rare-block PRF construction should be promoted to a
conditional counterexample:

- status: `false`
- evidence: `conditional-counterexample`
- assumptions: secure PRFs exist; efficient improper outputs are
  polynomial-time evaluable from their printed representations
- witness: rare-block PRF singleton-handle class

Without that convention, the current atlas-safe result is conditional only.

## Concrete Depth-2 Directions

1. Write a dedicated rare-block PRF witness note. Include the block domain,
   `j <= floor(n/(4 log n))`, representation size `s=Theta(n+j)`, and the
   active-block PRF concept evaluator.

2. Decide where to record the output-evaluation convention. The cleanest place
   is `atlas/README.md`, near the pathwise resource paragraph. A narrower
   alternative is an explicit assumption on a new argument note.

3. Formalize the source lemma in three steps: constants handle biased
   positive mass; a positive singleton handles near-balanced heavy active
   blocks; fixed marginals have only finitely many such heavy blocks, allowing
   an `R`-dependent polynomial.

4. Formalize the target lower bound as a PRF/random-function hybrid. Show that
   low `P`-error at `epsilon=w_{n,j}/64` implies constant prediction advantage
   for `F_k(u)` from evaluating the output on the two paired points.

5. Audit neighboring marginal weak-to-strong improper edges before reusing the
   witness. The construction is tailored to this exact weak-realizable
   improper-to-strong-realizable improper edge, not to proper-output or
   agnostic-source edges without further work.

## Final

The edge is not `resolved-true`. It is not quite `resolved-false` under the
current written atlas semantics. The best current result is a conditional
counterexample route under secure PRFs plus the standard, but currently
unstated, efficient output-evaluation convention.

VERDICT: conditional-only

## Depth 2 Branch A: Polynomial-Time Evaluable Improper Outputs

### Question

Does the atlas, as currently written, already force an efficient improper
learner's final hypothesis to be polynomial-time evaluable on fresh examples?
If yes, the rare-block PRF/singleton-handle construction can be promoted to an
atlas-safe conditional counterexample. If no, the construction remains a
conditional route and the edge should stay `open` with an explicit convention
gap.

### Local Semantics Check

I rechecked the current convention text in `atlas/README.md` and the two endpoint
definition notes.

The README says that computationally efficient nodes require polynomial sample
complexity and polynomial running time, and that these resource bounds are
worst-case/pathwise bounds on finite encoded sample transcripts. This is enough
to control the learner's sampling process and training/output-generation run on
every finite transcript.

The source and target notes say that the learner "outputs a hypothesis `h`,
possibly outside `C`," and then bound samples and time. They do not separately
specify:

- an output representation language for improper hypotheses;
- an evaluator `Eval(h,x)`;
- a polynomial bound on `Eval` for fresh examples after training;
- whether randomized prediction-time hypotheses are allowed or how their
  prediction-time coins are charged.

Thus the written atlas semantics imply a polynomial bound on producing the
finite output string, and therefore on the output length, but not on evaluating
the semantic hypothesis denoted by that string. Existing cryptographic witness
notes implicitly use the standard computational PAC convention that learned
hypotheses are usable/evaluable, but I do not see that convention stated
globally.

### Why The Gap Matters Here

The PRF lower bound needs to convert a strong learner into a polynomial-time
distinguisher. After the learner returns `h`, the distinguisher samples a fresh
active-block point and evaluates `h(n,j,u,0)` and `h(n,j,u,1)` to predict the
PRF value. If evaluation is not polynomial-time, the distinguisher is not a
valid cryptographic adversary.

This is not a cosmetic issue. With only polynomial output generation charged, a
learner could print a short transcript or certificate whose semantic
interpretation is computationally expensive, for example "the lexicographically
first PRF key consistent with the active-block labels seen so far." Whether that
particular semantic rule learns the class is a separate question, but it shows
that training-time efficiency alone does not rule out hypotheses whose
prediction map hides superpolynomial computation. The rare-block separation is
specifically a computational prediction lower bound, so it needs the evaluator
convention.

### Conditional Counterexample Under The Evaluable-Output Convention

Assume secure PRFs exist and add the convention:

> An efficient improper PAC learner outputs a finite representation of a
> Boolean hypothesis together with, or in a fixed representation admitting, an
> evaluator that runs in time polynomial in the learning parameters and the
> example length.

Under this convention, the edge is false by the rare-block PRF/singleton-handle
class.

**Construction.** For each key length `n` and level
`1 <= j <= floor(n/(4 log n))`, let `U_{n,j}` have size `N_{n,j}=n^j` and let

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\}.
$$

A key `k in {0,1}^n` defines the concept

$$
c_{n,j,k}(n',j',u,b)=1
\quad\Longleftrightarrow\quad
(n',j')=(n,j)\text{ and }b=F_k(u).
$$

All points outside the active block are labeled `0`.

**Source.** A uniform weak improper learner tries constants and positive
sample-singletons, using held-out validation to choose among candidates. Fix a
marginal `R`.

If the target positive mass `M=R(c^{-1}(1))` is bounded away from `1/2`, a
constant has the required weak edge. If `M` is close to `1/2`, then the active
block has `R`-mass close to `1/2`; only finitely many blocks can have such large
mass under this fixed `R`. On each such finite block, some positive atom has
mass at least an inverse polynomial in the corresponding block size, and the
largest relevant block size is absorbed into the `R`-dependent polynomial.
Sampling until a positive atom is found and validating the singleton therefore
gives an inverse-polynomial `R`-dependent advantage. This proves the source node
for every marginal `R`.

**Target lower bound.** Fix one marginal `P` with block masses

$$
P(B_{n,j})=w_{n,j}=Z^{-1}2^{-j}n^{-2},
$$

uniform inside each block. Suppose a strong marginal-nonuniform learner exists
for this `P`, with polynomial `q_P`. Let `D` dominate the degree of `q_P`, and
choose a fixed level `j > 4D+10`. For target `c_{n,j,k}`, request

$$
\varepsilon_{n,j}=w_{n,j}/64.
$$

Since `j` is fixed,
`1/epsilon_{n,j}=Theta(2^j n^2)` and the learner uses only `n^{O(D)}` time and
samples. The expected number of active-block examples is
`n^{O(D)} w_{n,j}=n^{O(D)-2}`, while the active block has `N_{n,j}=n^j` input
indices. By the choice of `j`, a fresh active `u` is unseen except with
`o(1)` probability.

If the learner has `P`-error at most `epsilon_{n,j}`, then its conditional error
on `B_{n,j}` is at most `1/64`. Evaluating `h` on the paired points
`(n,j,u,0)` and `(n,j,u,1)` predicts `F_k(u)` with constant advantage over
`1/2` for fresh uniform `u in U_{n,j}`: on all but at most a `1/32` fraction of
pairs, both labels in the pair are correct, and the unique point predicted
positive reveals the bit.

A polynomial-time distinguisher now simulates the learner using oracle labels:
outside the active block it returns `0`, and inside the active block it queries
either a PRF oracle or a random-function oracle. In the PRF case, the learner's
guarantee gives a hypothesis whose evaluator predicts fresh active labels with
constant advantage. In the random-function case, conditioned on the fresh `u`
not having appeared in the training transcript, the label is independent of the
learner's output, so no polynomial-time evaluator produced from the transcript
can predict it with non-negligible advantage. This distinguishes the PRF from a
random function, contradicting PRF security.

The argument is fully improper: the output may be any polynomial-time evaluable
Boolean predictor, not necessarily a concept in `C`.

### Atlas-Safe Conclusion

Under the current written semantics, I would not mark the edge `false` yet. The
right atlas action is to keep the edge `open` and record the conditional
counterexample route:

- assumptions: secure PRFs exist; efficient improper outputs are
  polynomial-time evaluable from their printed representations;
- evidence if promoted: `conditional-counterexample`;
- witness: rare-block PRF singleton-handle class.

If the atlas adds the evaluator convention globally, this same branch should
become `resolved-false` for the edge. Without that convention, the result is
only conditional.

VERDICT: conditional-only

scratchpad:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Convention-Free Route Check

- date: 2026-05-07
- branch: search for a counterexample not using polynomial-time evaluable
  improper outputs, or a theorem/semantic diagnosis showing why omitting
  evaluability changes the edge
- write scope: appended only to this scratchpad; no atlas files,
  `references.bib`, or legacy LaTeX edited

### Question

Can the edge be resolved without assuming that an efficient improper learner's
output hypothesis is polynomial-time evaluable on fresh examples?

The answer from this pass is no. I found no convention-free counterexample and
no full positive theorem for the edge. What I did find is a sharper semantic
diagnosis: under the written atlas conventions, PAC risk is a mathematical
expectation over the function denoted by the output hypothesis, while the
computational resource bound only explicitly charges the finite training/output
transcript. If prediction-time evaluation is not part of the model, the leading
PRF counterexample route loses its target-side hardness by a lazy-ERM
loophole. Thus the edge remains unresolved unless the atlas adds an evaluator
convention or intentionally defines a separate training-only notion.

### Primary-Source Calibration

The standard computational-PAC convention is evaluator-aware.

- Schapire's representation-independent boosting setup permits arbitrary
  hypotheses, but only hypotheses usable to classify instances in polynomial
  time: https://www.schapire.net/papers/strengthofweak.pdf.
- Kearns and Vazirani make this explicit by requiring a polynomially
  evaluatable hypothesis representation in the final PAC definition:
  https://www.jeffreyheinz.net/classes/18S/materials/Kearns-Vairani-1994-Introduction-to-Computational-Learning-Thoery-Ch01.pdf.
- Kearns and Valiant's representation-independent cryptographic lower bounds
  are lower bounds against efficient prediction, not just against printing a
  short string: https://doi.org/10.1145/174644.174647.

The fixed-distribution/marginal-nonuniform sources are mostly sample-rate
sources, not computational-output-semantics sources.

- Benedek and Itai explicitly separate their sample-complexity focus from
  computation, noting that the sample-to-hypothesis map may be undecidable or
  infeasible in some cases: https://doi.org/10.1016/0304-3975(91)90026-X.
- Hanneke, Moran, and Thiessen define marginal-nonuniform learning as rates
  depending on the marginal while staying uniform over concepts:
  https://openreview.net/forum?id=aoVCFtox89.

This matches the atlas gap: the atlas adds training/sample efficiency, but its
written convention does not yet say that improper outputs must be drawn from a
polynomially evaluable representation class.

### How Risk Is Evaluated Under The Current Atlas Text

The endpoint notes use

$$
\operatorname{err}_P(h,c)=\Pr_{X\sim P}[h(X)\ne c(X)].
$$

This is a semantic quantity. Once the learner's training randomness and sample
transcript are fixed, the output `h` is treated as a Boolean classifier, and
the PAC guarantee is a probability statement about the measure of its
disagreement set. Computing this probability is not required of the learner.

For proper outputs, the concept representation usually supplies a natural
evaluator. For improper outputs, the current notes say only "outputs a
hypothesis, possibly outside `C`." They do not specify:

- the representation language for arbitrary improper hypotheses;
- a fixed denotation map from finite strings to Boolean functions;
- a prediction algorithm `Eval(h,x)`;
- whether `Eval` time is charged to the efficient PAC bound.

So if "improper hypothesis" means "any finite string denoting a Boolean
function by an unstated semantics," the computational target is not fully
defined. The training algorithm can be polynomial-time while the denoted
prediction rule hides superpolynomial or even noncomputable work.

### Lazy-ERM Loophole For The PRF Route

This is not merely pedantic. It changes the rare-block PRF candidate.

Recall the tempting hard block:

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

with target

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u).
$$

Under the evaluator convention, a low-error strong learner for a fixed
rare-block mixture gives a polynomial-time algorithm that evaluates the learned
hypothesis on fresh paired points and predicts unseen PRF bits. That is the
conditional target lower bound.

Without charging evaluation, the same class has a lazy strong learner shape.
For accuracy `epsilon` below the active block mass `w`, draw enough samples to
obtain

$$
O\!\left(\frac{n+\log(1/\delta)+\log(1/\epsilon)}{\epsilon/w}\right)
$$

active-block examples, which costs

$$
O\!\left(\frac{n+\log(1/\delta)+\log(1/\epsilon)}{\epsilon}\right)
$$

total examples up to constants. This is polynomial in the target node's
parameters. The learner then prints the sample transcript plus the rule:

> on input `x`, enumerate keys consistent with the stored active-block labeled
> examples, choose the first one, and predict using that key.

Printing this rule and the transcript is polynomial-time. The prediction-time
enumeration may be exponential, but under the no-evaluator reading it is not
charged. By the finite-class/Occam argument over at most `2^n` keys, once the
stored active sample is large enough, every key consistent with it has small
conditional error on the active block with high probability. Therefore this
lazy predictor defeats the intended PRF target hardness.

The same loophole applies broadly to cryptographic improper lower bounds:
if a learner may defer the hard search to the semantic interpretation of its
printed hypothesis, then PRF security no longer rules out efficient training.

### Search For A Convention-Free Counterexample

A convention-free false edge would need to be statistical rather than
cryptographic: for some fixed marginal `P`, every polynomial-training learner
would fail to output even a semantically arbitrary low-error classifier. In
fixed-distribution language, this would amount to a weak-learnable but not
strongly learnable metric/cover phenomenon, not a prediction-time hardness
phenomenon.

I do not see an atlas-ready example satisfying the source's `for every
marginal` quantifier. Fixed-marginal weak-not-strong intuitions, such as large
antichains or monotone-function uniform-distribution examples, break once the
source is tested under marginals concentrated on the hard slice: on that
concentrated marginal, arbitrary labels or hidden orientations are not weakly
learnable unless there is a cheap handle. But cheap deterministic handles are
exactly what the improper target can often aggregate, and the previous
rare-block orientation audits show how arbitrary near-balanced marginals break
sampled-singleton handles.

Nor did I find a theorem proving the edge true under the current text. The
old positive obstruction remains: Schapire/Freund boosting needs quantitative
control of weak gaps on booster-induced marginals, while the source gives only

$$
\forall Q\ \exists r_Q
\qquad
\gamma_Q(s)\ge 1/r_Q(s).
$$

Removing evaluator cost does not supply the missing original-marginal envelope

$$
\exists r_P\ \forall Q\in\mathsf{BoostReach}(P,c,\varepsilon)
\qquad
\gamma_Q(s)\ge 1/r_P(s,1/\varepsilon).
$$

### Branch Conclusion

The convention-free route does not resolve the edge.

What is now clearer:

1. The standard computational-PAC reading includes polynomial-time evaluation
   of improper hypotheses.
2. The atlas text currently charges finite training/output transcripts but
   does not explicitly charge prediction-time evaluation.
3. Under the no-evaluator reading, PAC risk is only a semantic expectation
   over the denoted classifier, and arbitrary improper-output semantics are
   under-specified.
4. The rare-block PRF counterexample is not convention-free: lazy ERM can
   print a short deferred-search predictor, and the hard work moves to
   uncharged evaluation.
5. A genuine convention-free counterexample would need an information-theoretic
   weak-but-not-strong marginal-nonuniform separation. I did not find one, and
   the known rare-block/antichain templates fail the every-marginal weak source
   or become target-learnable.

The clean atlas choices are therefore:

- add a global convention that efficient improper PAC outputs are
  polynomial-time evaluable, after which the rare-block PRF route remains a
  conditional false candidate; or
- leave the current text as a training-only semantic model, in which case PRF
  lower bounds should not be used for improper-output target hardness and this
  edge stays open/partly ill-posed.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Weak-Realizable Improper Boosting Consolidation

### EOF Consolidation

This addendum records the final depth-5 branch verdict after reviewing the May
4, May 5, and May 7 branches. The detailed consolidation above should be read
as the main branch analysis; this final append keeps the scratchpad ending on
the requested branch and verdict.

No unconditional theorem survived. The true branch requires a stronger source:
for every original marginal $P$, one $P$-dependent polynomial must control the
weak learner's runtime, sample use, weak gap, and filtering/sampling overhead
on every booster-generated marginal. Under that envelope, standard realizable
boosting gives the strong improper target. The current source only gives
pointwise promises $\forall Q\,\exists p_Q,\gamma_Q$, so it does not imply the
needed original-marginal envelope.

No unconditional counterexample survived under the current written atlas
semantics. The rare-block PRF singleton-handle construction is the best false
route: constants and sample-found positive singletons give weak learning for
every fixed marginal, while one fixed block-mixture marginal would force a
strong learner to predict unseen pseudorandom labels. This becomes a clean
conditional false edge under secure PRFs once efficient improper outputs are
required to be polynomial-time evaluable.

The present semantic blockers are exactly the evaluator and output-model
forks. Without charged output evaluation, PRF hardness does not refute the
target, because a learner may print deferred-search or lazy-ERM hypotheses and
move the hard computation into uncharged prediction. Prediction-time
stochastic or mixture-valued hypotheses should also be split into separate
nodes or explicit assumptions; they are not the current deterministic
zero-one-output PAC semantics.

Proposed current atlas text remains: keep the edge `open`, with `evidence:
unknown`, and summarize that marginal boosting lacks an original-marginal
weak-gap envelope while the rare-block PRF candidate requires an explicit
efficient-output evaluator convention. Post-clarification, the likely update
is `status: "false"`, `evidence: conditional-counterexample`, assumptions
`secure pseudorandom functions exist` plus the evaluator convention if it is
not made global, and witness `rare-block-prf-singleton-handle-class`.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Weak-Realizable Improper Boosting Consolidation

- date: 2026-05-07
- branch: depth-5 consolidation for weak-realizable improper boosting
- write scope: appended only to this scratchpad; no atlas files,
  `references.bib`, or legacy LaTeX edited

### Branches Reviewed

This pass reviewed the live edge note, the May 7 depth-1 through depth-4
scratchpad entries, and the earlier May 4/May 5 scratchpads for the same edge.
The branches now separate cleanly:

1. Classical Schapire/Freund boosting gives only a conditional positive result:
   it needs an original-marginal envelope over all booster-generated marginals.
2. Oracle/diagonal attacks against a particular booster explain the missing
   envelope, but they do not refute arbitrary direct strong learners.
3. The rare-block PRF/singleton-handle construction gives the best target
   lower-bound route, but it needs an explicit efficient-output evaluator.
4. Under no-evaluator semantics, PRF hardness is defeated by deferred-search
   hypotheses and the computational node becomes under-specified.
5. Prediction-time stochastic or mixture-valued hypotheses are a separate
   model fork, not part of the current deterministic binary-output atlas
   semantics unless the schema is changed.

### Final Theorem Attempt

The strongest true theorem I can state is still an envelope theorem, not the
bare edge.

Fix a concrete realizable booster. For example, use a smooth or filtering
booster whose weak calls are on marginals $Q_t$ generated from the original
marginal $P$, the target $c$, the previous weak hypotheses, and the booster's
randomness. Suppose the source learner $A$ satisfies the following stronger
condition:

For every original marginal $P$ there is a polynomial $E_P$ such that,
uniformly over all target concepts $c$, requested accuracies $\varepsilon$,
booster histories before termination, and induced weak-call marginals $Q_t$,

$$
\gamma_{Q_t}(s)\ge \frac{1}{E_P(s,1/\varepsilon)}
$$

and the weak learner's sample use, running time, and the overhead of simulating
examples from $Q_t$ using the original $P$ stream are all bounded by

$$
E_P(s,1/\varepsilon,\log(1/\delta)).
$$

Then the target follows. Run the booster with a conservative guessed edge
$\gamma_\star$, split the failure probability over weak calls, and validate
the final vote on fresh $P$ examples. If $\gamma_\star$ is not known, use the
standard doubling/halving search over edge guesses and keep the first
validated vote. Once the guessed edge is below the hidden envelope value, the
usual realizable boosting analysis reaches $P$-error at most $\varepsilon$ in
polynomially many calls, with total resource bound polynomial in
$(s,1/\varepsilon,\log(1/\delta))$ and with polynomial depending only on $P$.
The final vote is an improper hypothesis, so it is legal for the target.

This theorem does not prove the edge. The current source gives only

$$
\forall Q\ \exists p_Q,\gamma_Q,
$$

with no filter-stability, KL-stability, bounded-density continuity, or
target-uniform lower envelope relating $p_Q$ and $\gamma_Q$ back to the
original $P$. Freund's distribution-dependent theorem is exactly a near miss:
it assumes quantitative control of weak accuracy on the filtered
distributions; it does not derive that control from pointwise
marginal-nonuniform weak learnability.

The rare-block geometry shows why this is not just bookkeeping. One may have a
fixed mixture $P$ with blocks of mass $w_{n,j}\asymp 2^{-j}n^{-2}$ and
conditioned block marginals whose weak singleton gap is about $n^{-j}$. Each
conditioned marginal individually has an inverse-polynomial gap, but no single
$P$-dependent polynomial in $(n,1/\varepsilon)$ controls all exponents $j$ when
$\varepsilon\asymp w_{n,j}$.

### Final Counterexample Attempt

The best false route remains the rare-block PRF/singleton-handle class.

Use blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

for $1\le j\le \lfloor n/(4\log n)\rfloor$. A key $k$ defines the active-block
concept

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\text{ and }b=F_k(u),
$$

with zero labels off the active block.

The source is satisfied by one staged weak learner that tries constants and
sample-found positive singletons. For a fixed marginal $R$, constants handle
targets whose positive mass is noticeably away from $1/2$. If the positive
mass is near $1/2$, the active block must have constant $R$-mass. Only
finitely many blocks can be that heavy for this fixed $R$, and on each such
finite block a heaviest positive atom has inverse-polynomial mass with an
exponent depending on the block. The maximum exponent over those finitely many
$R$-heavy blocks is absorbed into the marginal-dependent polynomial. Validation
or staged candidate selection makes the learner uniform; $R$ is not supplied
as advice.

For the target lower bound, fix

$$
P(B_{n,j})=w_{n,j}=Z^{-1}2^{-j}n^{-2}
$$

uniformly inside blocks. If a strong learner for this fixed $P$ has hidden
polynomial $q_P$ of degree $D$, choose a constant level $j>4D+10$ and request
$\varepsilon=w_{n,j}/64$ for target $c_{n,j,k}$. The learner sees only
$n^{O(D)}w_{n,j}=n^{O(D)-2}$ active examples, while the active block has
$n^j$ independent PRF indices. Thus a fresh active index is unseen with
probability $1-o(1)$.

Low $P$-error implies small conditional error on $B_{n,j}$. Evaluating the
output hypothesis on the paired points $(n,j,u,0)$ and $(n,j,u,1)$ then
predicts $F_k(u)$ with constant advantage on fresh $u$. In the random-function
hybrid, the unseen label is independent of the learner's transcript, so no
polynomial-time predictor can get more than $1/2+o(1)$ success. In the PRF
world, the assumed learner would give such a predictor, contradicting PRF
security.

This would be an atlas-level conditional counterexample under the standard
computational PAC convention that efficient improper outputs are
polynomial-time evaluable from their printed representations. Under that
convention, the appropriate post-clarification status is:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - secure pseudorandom functions exist
witnesses:
  - rare-block-prf-singleton-handle-class
summary: "False under PRF security: rare active blocks have marginal-nonuniform weak singleton handles, but strong learning under one fixed mixture marginal would predict unseen pseudorandom labels."
```

If the evaluator convention is not global, add the second assumption:

```yaml
assumptions:
  - secure pseudorandom functions exist
  - efficient improper PAC hypotheses are polynomial-time evaluable from their printed representations
```

### Stochastic Fork

Prediction-time stochastic hypotheses should be split off as a model fork. The
current atlas definitions allow randomized learners, but the successful run
outputs an ordinary Boolean hypothesis $h$ whose zero-one error is measured
after training. They do not say that the final hypothesis may toss fresh coins
on each prediction or that risk is expected over those prediction-time coins.

For this particular rare-block PRF construction, stochastic outputs are not
needed for the weak source: deterministic constants and positive singletons
already provide the marginal-nonuniform weak handles. If a future stochastic
node permits efficient randomized evaluators and measures expected prediction
loss, the target-side PRF lower bound should still go through. A low expected
block error stochastic evaluator can be run on fresh paired points to obtain a
constant-advantage randomized predictor for the unseen PRF bit, while in the
random-function hybrid fresh prediction coins do not create information about
an unseen random label.

But this is not evidence for changing the current edge. If stochastic
hypotheses are permitted without charged efficient evaluation, the same
deferred-search loophole returns. If only the source is weakened to
expected-mixture outputs, the model is no longer the deterministic PAC node in
the atlas. Stochastic or mixture-valued variants should therefore get separate
definition nodes or explicit assumptions, not an implicit reinterpretation of
`improper`.

### No-Evaluator Semantic Blocker

The current written atlas text does not explicitly charge prediction-time
evaluation of arbitrary improper outputs. It bounds the learner's sample use
and running time on finite encoded sample transcripts and then measures
$\operatorname{err}_P(h,c)$ semantically for the printed hypothesis.

This blocks the PRF counterexample. A learner can print a short deferred rule
such as:

> Store the labeled sample. On an active-block input, enumerate keys or
> concepts consistent with the stored sample, choose the first one, and
> predict using it.

Printing the rule and transcript is polynomial-time. The expensive search
happens only during prediction, which is uncharged under a no-evaluator
reading. By the usual finite-class/Occam argument, enough active samples make
the deferred consistent key semantically accurate on the active block, even
though evaluating it may be exponential.

There is an even broader warning. Since the corresponding sample-only edge is
already true by the atlas's sample-complexity equivalence, an extremely
permissive no-evaluator model may push the computational edge toward a lazy
ERM theorem: draw the sample promised by the sample-only marginal-nonuniform
rate, then print the sample together with the rule "return the first benchmark
concept consistent with this sample." Training is cheap; the unbounded ERM
search is moved into the hypothesis denotation. I do not promote this to
`resolved-true`, because the atlas has not defined opaque denotations or
unbounded semantic ERM outputs as legal efficient hypotheses, and the uniform
sample-schedule/pathwise-resource details would need to be formalized. It does
show that the no-evaluator reading is not a stable computational PAC model for
this edge.

Thus the semantic blocker cuts both ways: it prevents the PRF lower bound from
being a formal false edge, but it also makes the positive no-evaluator route
depend on a nonstandard lazy-output interpretation.

### Proposed Atlas Text Under Current Conventions

The live edge should stay open unless the atlas first adds the evaluator
convention or intentionally creates separate stochastic/lazy-output nodes.
The current edge metadata should remain essentially:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open under current conventions: marginal boosting lacks an original-marginal weak-gap envelope, and a rare-block PRF singleton-handle candidate counterexample requires an explicit convention that efficient improper outputs are polynomial-time evaluable."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested body addendum:

```markdown
**Conditional positive branch.** The edge would be true if the weak learner's
resource bounds and weak gaps had one polynomial envelope depending only on
the original marginal $P$ over all booster-generated filtered marginals. Under
that extra filter-stability or KL-stability condition, standard realizable
boosting gives an improper strong learner.

**Conditional false branch.** Under secure PRFs and the standard convention
that efficient improper outputs are polynomial-time evaluable, a rare-block
PRF singleton-handle class separates the nodes. Constants and observed
positive singletons give weak marginal-nonuniform learning for every fixed
marginal, but strong learning under one fixed block mixture would predict
unseen pseudorandom labels.

**Current blocker.** The atlas currently charges training/output generation
but does not explicitly charge evaluation of an arbitrary improper hypothesis
on fresh examples. Without that convention, PRF target-hardness reductions do
not apply, and deferred-search/lazy-ERM outputs make the computational meaning
of the target ambiguous. Prediction-time stochastic or mixture-valued outputs
are likewise separate model variants, not the current deterministic binary
PAC semantics.

**Conclusion.** Keep the edge `open` under current conventions. Resolve the
schema question first: efficient improper PAC outputs should either be finite
encoded hypotheses with a uniform polynomial-time evaluator, or the atlas
should create explicit lazy-output/stochastic-output variants.
```

### Final Decision

No unconditional theorem or counterexample survived this depth-5 pass. The
state is now conditional-only:

- `resolved-true`: no, unless an original-marginal weak-gap/resource envelope
  is added.
- `resolved-false`: no under current written conventions; yes as a conditional
  PRF route after an efficient-output evaluator convention is made explicit.
- stochastic/mixture outputs: separate semantics, not a current-edge verdict.
- no-evaluator/lazy outputs: under-specified and incompatible with using PRF
  hardness as a target lower bound.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 4 Branch A: No-Evaluator Semantics Consolidation

- date: 2026-05-07
- branch: consolidate the evaluator fork, deferred-search loophole, and weak-gap
  envelope theorem under the current no-evaluator-explicit atlas text
- write scope: appended only to this scratchpad; no atlas files,
  `references.bib`, or legacy LaTeX edited

### Goal

Decide whether the edge can now be resolved under the atlas notes as written.
The short answer is no. The investigation has produced two clean conditional
statements, but neither is an unconditional atlas result under the current
no-evaluator-explicit semantics:

1. If efficient improper outputs are required to be polynomial-time evaluable,
   the rare-block PRF/singleton-handle class is a credible conditional
   counterexample.
2. If the weak learner has one original-marginal weak-gap/resource envelope
   over all booster-reachable marginals, a standard smooth realizable booster
   gives a conditional positive theorem.

The current endpoint notes give neither extra convention. They bound samples
and running time for finite training/output transcripts, and they measure PAC
risk semantically as $\operatorname{err}_P(h,c)$ after a hypothesis has been
printed. They do not explicitly charge prediction-time evaluation for an
arbitrary improper output.

### Consolidated Fork 1: Evaluable Outputs Give Conditional False

Under the standard computational-PAC convention that an efficient improper
hypothesis is represented by, or comes with, a polynomial-time evaluator, the
rare-block PRF/singleton-handle route remains the best false witness.

The construction has blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

and active concepts

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\text{ and }b=F_k(u).
$$

For every fixed marginal $R$, constants handle biased positive mass, and
sample-found positive singletons handle the finitely many $R$-heavy
near-balanced active blocks. Thus the source is plausibly satisfied with an
$R$-dependent inverse-polynomial weak edge.

For the fixed mixture marginal

$$
P(B_{n,j})=w_{n,j}\asymp 2^{-j}n^{-2},
$$

a strong learner with one polynomial $q_P$ would, for
$\varepsilon\asymp w_{n,j}$ and $j$ above the degree of $q_P$, see too few
active indices to predict fresh PRF labels on the block. If its output is
polynomial-time evaluable, low error yields a polynomial-time predictor for
fresh values of $F_k$, hence a PRF distinguisher.

This is an atlas-level false edge only after adding the evaluator convention
globally or recording it as an explicit assumption. The cryptographic
assumption is not the blocker; atlas conventions already allow conditional
counterexamples. The blocker is the missing output-evaluation convention.

### Consolidated Fork 2: No-Evaluator Text Leaves A Deferred-Search Loophole

Under the current written semantics, the PRF lower bound is not
convention-free. A learner can do polynomial training, print a short deferred
search rule, and move the hard computation into uncharged prediction.

For the same rare-block PRF class, a training-only learner can use the target
accuracy to draw enough examples to identify the active block when its mass is
relevant. It then stores the active labeled examples and prints the rule:

> On an active-block input, enumerate PRF keys consistent with the stored
> active examples, choose the first such key, and predict using that key; off
> the active block, predict zero.

The printed rule and transcript are polynomial length and polynomial to
produce. Evaluation may be exponential, but evaluation is exactly what the
current notes do not charge. By the finite-class/Occam argument over the
$2^n$ possible keys, once the stored active sample has size
$O((n+\log(1/\delta))/\alpha)$, every consistent key has conditional error at
most $\alpha$ on the active block with high probability. Taking
$\alpha\asymp\varepsilon/w_{n,j}$ gives the desired semantic low-error
hypothesis at polynomial sample cost in $1/\varepsilon$.

This does not prove the edge true for all classes. It only explains why PRF
hardness cannot, by itself, prove this edge false unless outputs are required
to be efficiently evaluable. More broadly, many computational hardness
templates become unstable in a training-only improper model because the
improper output can denote "the first object consistent with the transcript"
without paying the search cost at training time.

### Conditional Positive Theorem: Weak-Gap Envelope

There is also a clean conditional true theorem.

Fix a concrete realizable booster, for example a smooth booster whose call
marginals $Q_t$ have density bounded by $\operatorname{poly}(1/\varepsilon)$
relative to the original marginal $P$. Suppose that for every original
marginal $P$ there is a polynomial $r_P$ such that, for every target concept
$c$, every requested accuracy $\varepsilon$, and every finite booster
transcript before stopping,

$$
\gamma_{Q_t}(s)\ge \frac{1}{r_P(s,1/\varepsilon)}
$$

and the weak learner's sample/time use on those same $Q_t$ calls is also
bounded by $r_P(s,1/\varepsilon,\log(1/\delta))$.

Then the edge is true, provided the weak outputs are usable enough for the
booster to form its reweighted call distributions and update the finite
sample weights. Run the booster with conservative edge
$\gamma_*=1/r_P(s,1/\varepsilon)$, split confidence across calls, and use the
standard realizable boosting analysis. The number of calls and total
sample/time use are polynomial in
$(s,1/\varepsilon,\log(1/\delta))$ with a polynomial depending only on $P$.
The final vote is an improper hypothesis, so it is allowed by the target.

This theorem is not implied by the source node. The source gives only

$$
\forall Q\ \exists r_Q,
$$

not one $r_P$ controlling all booster-reachable $Q_t$. Bounded-density or
smoothness alone does not force such continuity of the hidden weak gap. A
rare-block pattern with

$$
P(B_{n,j})\asymp 2^{-j}n^{-2},
\qquad
\gamma_{P(\cdot\mid B_{n,j})}(n)\asymp n^{-j}
$$

is compatible with pointwise marginal-nonuniform weak learning: each fixed
conditioned block has an inverse-polynomial gap, with exponent depending on
the marginal. But no single polynomial in
$(n,1/\varepsilon)$ controlled by the original mixture $P$ can dominate all
exponents $j$ when $\varepsilon\asymp P(B_{n,j})$.

So the envelope theorem is the right positive statement for a stronger schema,
not a resolution of the present edge.

### Final Non-PRF Counterexample Route

A no-evaluator counterexample must be information-theoretic or
sample-complexity based, not computational-prediction based. I tried the
natural non-PRF rare-block replacement:

- Use dense random-code or arbitrary-label blocks so that strong learning a
  block requires seeing many coordinates.
- Add constants/singletons/lookup handles so every marginal concentrated on a
  block is still weakly learnable with an inverse-polynomial
  marginal-dependent gap.
- Put a fixed mixture $P$ over blocks with masses
  $w_{n,j}\asymp 2^{-j}n^{-2}$, then choose $j$ above the degree of the
  target learner's $P$-polynomial.

The route fails in the current atlas model.

If a block has only $2^{\operatorname{poly}(s)}$ compactly represented
concepts, a no-evaluator improper learner can print a lazy Occam/ERM rule:
"choose the first represented concept consistent with the stored sample." The
training cost is polynomial, and the uncharged semantic evaluation/search does
the hard work later.

If a block has $2^{n^j}$ essentially arbitrary labelings so that
information-theoretic sample complexity is really $\Omega(n^j)$, then either
the representation size is already $\Omega(n^j)$, in which case the target's
polynomial in $s$ can absorb the cost, or the construction relies on an
unstated oracle/nonuniform denotation scheme outside the finite encoded
representation discipline used by the atlas.

If the hard part is NP, one-wayness, PRF prediction, or another computational
barrier, the same deferred-search issue returns: an improper no-evaluator
output can denote the result of the hard search without performing it during
training. If the handles are explicit enough to certify weak learnability
under every isolated marginal, they also tend to be reusable by an improper
strong learner through memorization, lookup, or lazy residual search.

Thus I do not have a non-PRF atlas counterexample. The missing object would
have to be a genuinely statistical nonboostable-handle class: weak handles are
findable under every marginal with a marginal-dependent inverse-polynomial
gap, but no polynomial-training learner can even print a short semantic
low-error hypothesis under one fixed mixture marginal. The finite-class
lazy-ERM observation blocks the obvious compact constructions.

### Depth-5/7 Atlas-Note Summary

If this edge is summarized for a later atlas edit, the clean note is:

- Keep the edge `open` under the current no-evaluator-explicit semantics.
- Record the evaluator fork: with secure PRFs plus polynomial-time evaluable
  improper outputs, the rare-block PRF/singleton-handle class should give a
  conditional counterexample.
- Record the deferred-search caveat: without charged evaluation, PRF and
  other computational target-hardness arguments do not refute improper
  learning, because the output may defer the hard search to prediction time.
- Record the positive fork: an original-marginal envelope over all
  booster-reachable weak gaps and weak-call resources implies the target by
  smooth realizable boosting, but the current source only gives pointwise
  marginal guarantees.
- Do not promote any non-PRF rare-block, singleton, lookup, NP, one-way, or
  arbitrary-code template to a witness without separately defeating lazy
  semantic ERM.

### Branch Conclusion

This depth-4 pass does not resolve the edge under the written atlas
semantics. It narrows the state space: evaluator semantics point toward
conditional false, envelope semantics point toward conditional true, and the
current no-evaluator-explicit text leaves both the PRF route and the standard
boosting route short of an atlas verdict.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Weak-Realizable Improper Boosting Consolidation

### Final EOF Addendum

This is the final appended branch record. The detailed depth-5 consolidation
above reviews the May 4, May 5, and May 7 branches; this addendum keeps the
file ending on the requested heading and verdict.

The final theorem attempt is conditional true only. If, for every original
marginal $P$, one $P$-dependent polynomial controls the weak learner's runtime,
sample use, weak gap, and filtering/sampling overhead on all
booster-generated marginals, then standard realizable boosting gives the
strong improper target. The current source gives only pointwise marginal
promises $\forall Q\,\exists p_Q,\gamma_Q$, so the envelope is extra
structure.

The final counterexample attempt is conditional false only. The rare-block PRF
singleton-handle construction gives weak marginal-nonuniform learning by
constants plus sample-found positive singletons, while a strong learner under
one fixed block-mixture marginal would have to predict unseen pseudorandom
labels. This becomes an atlas-level conditional counterexample under secure
PRFs once efficient improper outputs are explicitly required to be
polynomial-time evaluable.

The current semantic blockers remain decisive. Without charged output
evaluation, deferred-search or lazy-ERM hypotheses move hard computation into
uncharged prediction, so PRF hardness cannot refute the target. Prediction-time
stochastic or mixture-valued hypotheses are likewise separate model forks, not
the current deterministic zero-one-output PAC semantics.

Proposed atlas text under current conventions: keep the edge `open` with
`evidence: unknown`; mention both the missing original-marginal weak-gap
envelope and the evaluator-dependent rare-block PRF route. Post-clarification,
the likely false update is `evidence: conditional-counterexample`,
assumption `secure pseudorandom functions exist`, and witness
`rare-block-prf-singleton-handle-class`, with the evaluator convention either
global or explicitly listed as an extra assumption.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`
