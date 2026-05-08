# Edge: efficient-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- date: 2026-05-05
- assigned edge: `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- source: `efficient-realizable-improper-pac`
- target: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- family: `properization-open`
- worker constraint: did not edit atlas files; this scratchpad is the only file written

## Bottom Line

I do not have an atlas-ready proof or counterexample. The edge should remain
`status: "open"` with `evidence: unknown`.

The source is strong: one distribution-free polynomial-time realizable learner
outputs an arbitrary external hypothesis to any requested accuracy. Therefore,
for any fixed marginal $P$ and realizable target $c\in\mathcal C$, it can
produce an improper predictor $g$ with, say,

$$
\operatorname{err}_P(g,c)\le 1/10.
$$

The target is much weaker statistically but stronger representationally: for
each fixed marginal $P$, output some $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial. The unresolved
step is exactly a fixed-marginal weak proper selector:

$$
\text{external prediction near }c
\quad\Longrightarrow\quad
\text{efficiently find a weakly correlated represented concept }h\in\mathcal C.
$$

The target concept itself proves statistical existence. It does not give a
polynomial-time proper representation search procedure. The known
counterexample templates also miss this exact weak marginal-nonuniform target:
PCP and DNF witnesses put the hard instance in the marginal or distribution;
one-way image-coordinate witnesses force only strong proper recovery; dense
Hadamard/code repairs either leave the finite-encoded atlas model or reintroduce
weak handles and code-correlation barriers.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/README.md`
- `atlas/registry/axes.yml`
- `atlas/registry/edge_families.yml`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `references.bib`

Nearby scratchpads checked:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`

Primary or near-primary external sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview 2025, https://openreview.net/forum?id=aoVCFtox89. Used for the quantifier pattern: the learner is uniform, while the rate may depend on the marginal and must hold uniformly over concepts.
- Benedek and Itai, *Learnability with respect to fixed distributions*, TCS 1991, https://www.sciencedirect.com/science/article/pii/030439759190026X. Used as fixed-distribution background.
- Ben-David, Benedek, and Mansour, *A parameterization scheme for classifying models of PAC learnability*, Information and Computation 1995, https://doi.org/10.1006/inco.1995.1094. Used for the uniformity-parameter viewpoint; the abstract explicitly frames the discussion as information-theoretic rather than computational.
- Schapire, *The Strength of Weak Learnability*, Machine Learning 1990, https://www.schapire.net/papers/strengthofweak.pdf and DOI https://doi.org/10.1023/A:1022648800760. Used to check that classical boosting improves prediction but does not generically output a member of the original class.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*, JACM 1988, https://doi.org/10.1145/48014.63140 and a PDF mirror indexed by search. Used for representation-dependent proper hardness and fixed-$k$ DNF background.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, FOCS 2008, https://cs.nyu.edu/~khot/papers/minDNF.pdf and DOI https://doi.org/10.1109/FOCS.2008.37. Used for the constant-advantage small-DNF proper weak-learning near miss.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing 2005, https://theoryofcomputing.org/articles/v001a007/. Used for logarithmic randomness, perfect completeness, and soundness below $1/2$.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, JACM 1994, https://doi.org/10.1145/174644.174647 and PDF mirror https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Used as the learning-theoretic cryptographic-hardness anchor.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-Way Function*, SICOMP 1999, https://doi.org/10.1137/S0097539793244708. Used as the standard one-way-function-to-pseudorandomness background.
- Plotkin, *Binary Codes with Specified Minimum Distance*, IRE Transactions on Information Theory 1960, https://doi.org/10.1109/TIT.1960.1057584. Used as a coding-bound warning near distance $1/2$.
- McEliece, Rodemich, Rumsey, and Welch, *New Upper Bounds on the Rate of a Code via the Delsarte-MacWilliams Inequalities*, IEEE TIT 1977, https://doi.org/10.1109/TIT.1977.1055688.
- Guruswami and Vadhan, *A Lower Bound on List Size for List Decoding*, IEEE TIT 2010, https://doi.org/10.1109/TIT.2010.2070170.

## Definition Check

The source note says a learner receives examples $(x,c(x))$ for arbitrary
distribution $D$ and $c\in\mathcal C$, and must output a hypothesis, possibly
outside $\mathcal C$, with error at most any requested $\varepsilon$. The
resource bound is one polynomial in representation size, $1/\varepsilon$, and
$\log(1/\delta)$, independent of the marginal.

The target note says a single learner must work for every marginal $P$, but
for each fixed $P$ there may be a polynomial $p_P$ and an inverse-polynomial
advantage $\gamma_P$. It must output $h\in\mathcal C$ and satisfy

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s)
$$

for every target $c\in\mathcal C$ and confidence $\delta$. The polynomial may
depend on $P$, not on the target concept. The learner is not given a separate
algorithm or advice for each $P$.

The atlas README also matters: computational resource bounds are
worst-case/pathwise bounds on finite encoded sample transcripts. This blocks
using atomless infinite-bit examples as an atlas witness without a schema
change.

## Positive Route

The tempting theorem is:

> Any efficiently distribution-free realizable improper learner can be turned
> into an efficiently marginal-nonuniform weak realizable proper learner.

Run the source learner at $\varepsilon=1/10$ to obtain an external predictor
$g$. Since the data are realizable, there exists a proper concept $c$ with zero
error and hence a proper concept close to $g$. The target asks only for a
proper concept with positive inverse-polynomial correlation.

The missing operation is computational, not statistical. We would need a
uniform procedure which, for each fixed $P$, has a $P$-dependent polynomial
runtime and converts samples plus $g$ into some $h\in\mathcal C$ with weak
advantage. The source learner may have avoided the proper search problem by
outputting a table, sparse memorizer, parity vector, vote, or other external
representation.

Unbounded ERM would solve the sample-only analogue. The atlas
`sample-complexity-equivalence` note records exactly this: once runtime is
ignored, VC/uniform-convergence arguments and ERM over $\mathcal C$ can recover
proper hypotheses. Here runtime is the point.

Boosting is also not the missing operation. Schapire/Freund-style boosting
turns weak prediction into strong prediction by combining hypotheses. That
final combination is generally improper. In this edge, the source is already
strong; the problem is not accuracy but finding one represented concept in
$\mathcal C$.

### Conditional Positive Lemma

A useful restricted theorem would be:

**Fixed-marginal weak proper selector condition.** Suppose that for every fixed
marginal $P$ there is a $P$-dependent polynomial $q_P$ and one uniform
procedure `Select` such that, on realizable labeled samples from $P$ and
optionally oracle/evaluation access to an external predictor $g$ with
$\operatorname{err}_P(g,c)\le 1/10$, `Select` runs in time $q_P(s)$ and returns
a polynomial-size list $L\subseteq\mathcal C$ containing some
$h$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\frac{2}{q_P(s)}.
$$

Then the assigned edge is true for that class. Run the source learner to get
$g$, run `Select`, and use a fresh validation sample to choose the best member
of $L$. A finite-list Chernoff bound preserves an inverse-polynomial advantage
after adjusting $q_P$.

This lemma isolates the gap. The selector is not implied by the source. Finite
support, finite VC dimension, or Sauer-style trace bounds are only
information-theoretic unless there is an efficient map from traces or external
predictors to valid proper representations.

## Counterexample Route 1: PCP Active Slices

The PCP active-slice lookup class separates the distribution-free weak
improper and weak proper nodes under $\mathrm{NP}\nsubseteq\mathrm{RP}$. A
proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on
the active slice for $\varphi$ it outputs the PCP verifier's decision. Perfect
completeness gives an all-positive realizable target for satisfiable
$\varphi$, while soundness below $1/2$ makes every proof weakly bad for
unsatisfiable $\varphi$.

The source side is fine for this assigned edge. The active slice has
polynomial size because the verifier uses logarithmic randomness, so an
improper learner can memorize positives or run one-slice lookup ERM.

The lower bound does not survive marginal nonuniformity. The reduction chooses
the marginal $P_\varphi$ uniform over the active slice of the input formula.
For this target node, the runtime polynomial and weak advantage may depend on
$P_\varphi$; since $P_\varphi$ depends on $\varphi$, the proof no longer yields
one randomized polynomial-time algorithm for the NP language.

Packing all active slices into one fixed marginal $P^\star$ also fails at the
weak threshold. If

$$
P^\star=\sum_\psi w_\psi U_\psi,
$$

then the local PCP correlation gap on the $\varphi$ slice is multiplied by
$w_\varphi$. A fixed probability distribution cannot assign inverse-polynomial
mass to exponentially many length-$n$ formulas. Worse, a wrong-slice proper
hypothesis may have error at most about $w_\varphi+w_\psi$, which is already
far below $1/2$ for low-mass slices and reveals no proof for $\varphi$.

Thus PCP active slices refute a stronger distribution-free weak proper target,
but not this marginal-nonuniform weak target.

## Counterexample Route 2: Clause And DNF Hardness

Clause-satisfaction lookup and fixed-$k$ DNF explain why efficient improper
learning need not give efficient proper learning in the distribution-free or
strong-accuracy settings.

For clause satisfaction, the standard realizable proper-hardness marginal is
formula-dependent, usually uniform on the clauses of the input formula. That
is blocked by marginal nonuniformity just as in the PCP route. The fixed
uniform-clause marginal trick in the atlas is an agnostic strong-accuracy
witness: encode the input formula in conditional labels and use fair-noise
padding. It is not a realizable weak proper lower bound.

For fixed-$k$ DNF, Pitt-Valiant gives the representation-sensitive shape:
fixed-$k$ DNF is learnable by an improper $k$-CNF-style representation, while
proper distribution-free learning is hard. Khot-Saket strengthen the weak
proper side to constant advantage for small DNF by restricted DNF hypotheses.
But the hard distributions are reduction-instance dependent, and the
Khot-Saket statement is constant-advantage rather than "no
inverse-polynomial advantage under one fixed marginal." The atlas weak target
allows a hidden marginal-dependent inverse-polynomial gap.

So these witnesses are good motivation for `properization-open`, but they do
not resolve this edge.

## Counterexample Route 3: One-Way Image Coordinates

The one-way image-coordinate class is the closest fixed-marginal strong
properization witness. Let $f:\{0,1\}^n\to\{0,1\}^n$ be length-preserving and
one-way. A seed $s$ defines a concept exposing the bits of $f(s)$ on a
length-$n$ coordinate block. Improper learning is easy: memorize the positive
atoms seen in the sample and predict zero elsewhere. In fact the atlas records
a sparse improper ERM route for agnostic sources.

The strong proper lower bound fixes an all-length marginal with block masses
$\mu_k=6/(\pi^2k^2)$. At requested accuracy $\varepsilon_n=\mu_n/(3n)$, a
proper learner must output a seed $t$ of the same length with
$f(t)=f(s)$; otherwise the wrong length or one wrong image bit costs too much.

The assigned target has no requested $\varepsilon$. It only asks for global
error below $1/2$ by some hidden inverse polynomial. Under the all-length
marginal, the hard block has mass $\mu_n\to0$. A wrong same-length image has
error at most $\mu_n$, and a wrong low-mass length can have error roughly
$\mu_n/2+\mu_m/2$. These are already excellent weak proper predictions for
large $n$ and do not invert $f$.

Concentrating the marginal on the length-$n$ block would make weak correlation
meaningful, but then the hard marginal varies with $n$. A marginal-nonuniform
target may have a different polynomial for each such length-specific marginal,
which is not enough to contradict ordinary polynomial-time one-wayness across
all input lengths.

The atlas `one-way-image-coordinate-weak-handle-hardness` note makes the
diagnosis explicit: adding constants and singleton concepts gives easy weak
proper handles while strong proper learning still inverts.

## Counterexample Route 4: Hadamard Image Codes

At one fixed length, there is a clean separation.

Let the instance space be $r\in\{0,1\}^n$, let $y=f(s)$, and define

$$
c_s(r)=\langle y,r\rangle \pmod 2.
$$

An improper realizable learner can recover a parity vector consistent with the
labeled examples by Gaussian elimination and output the external vector $y$ or
some equivalent parity predictor. This is distribution-free for parities: a
consistent linear predictor generalizes by the usual VC/sample bound for
dimension $n$.

Under the uniform length-$n$ marginal, any proper seed $t$ with
$f(t)\ne f(s)$ computes a distinct parity and has exactly error $1/2$. Hence
any proper hypothesis with any positive weak advantage must satisfy
$f(t)=f(s)$ and invert the one-way challenge.

This is the right geometry but not an atlas-ready all-length fixed-marginal
witness.

1. If the hard marginal is the uniform length-$n$ marginal, the marginal varies
   with $n$ and the target's $P$-dependent polynomial may vary with it.
2. If lengths are mixed into one fixed finite-string marginal
   $P^\star=\sum_n\mu_n U_n$, the hard length has mass $\mu_n\to0$ and
   wrong-length/default concepts regain weak global advantage.
3. If one tries to share a high-mass coordinate space across all lengths, exact
   Hadamard orthogonality wants fresh unbiased bits at every scale. Under the
   atlas finite-encoded convention, a fixed countably supported marginal has
   atoms and cannot behave like the fair product measure at all finite levels.

### Model Fork: Atomless Product Examples

If the atlas allowed examples to be infinite random bit strings or bit-oracle
instances, the Hadamard route would become a conditional counterexample under
one-way functions.

Take $P^\star$ to be the fair product measure on $\{0,1\}^{\mathbb N}$. Encode
$f(s)$, together with its length, as a finite vector $a_s$ padded by zeros, and
set

$$
c_s(x)=\langle a_s,x\rangle \pmod 2.
$$

Finite parity characters are orthogonal under the product measure, so any
proper hypothesis with error $<1/2$ must have the same encoded image and hence
invert. The improper learner recovers the finite parity vector by linear
algebra.

But `atlas/README.md` says efficient computational bounds are pathwise bounds
on finite encoded sample transcripts. Under that convention, replacing an
infinite product point by a finite prefix gives tail-mass dilution
$\Pr[L\ge |a_s|]\to0$. Therefore this construction is a diagnostic for a
model-boundary issue, not a valid resolution under the current atlas schema.

### Top-Atom Obstruction For Pure Code Geometry

There is also a useful finite-encoded obstruction to exact all-length coding.

Let $P$ be a countably supported marginal and let $p>0$ be the mass of a
largest atom $x_0$. For any family $V$ of $M$ sign functions
$v:\mathcal X\to\{-1,1\}$, if $M$ is larger than a constant multiple of $1/p$,
then some distinct $u,v\in V$ have positive $P$-correlation bounded below by a
constant multiple of $p$.

Proof sketch. At least $M/2$ functions agree on $x_0$; call this subfamily
$W$. Write each such function as the common top-atom coordinate plus the
normalized remaining vector:

$$
v=\sigma\sqrt p\,e_0+\sqrt{1-p}\,w_v.
$$

Since $\|\sum_{v\in W}w_v\|_2^2\ge0$, some pair has
$\langle w_u,w_v\rangle\ge -1/(|W|-1)$. Thus

$$
\mathbb E_P[uv]
\ge p-\frac{1-p}{|W|-1}.
$$

For large enough $M$, this is at least $p/2$.

This does not prove the target edge true, and it does not by itself give an
easy weak learner. The correlated wrong hypotheses could be computationally
hidden. But it blocks the pure geometric plan "make every wrong proper concept
non-correlated under one fixed countable marginal" for exponentially many
proper seeds at every length. A false witness would need computational
weak-handle hardness, not merely code distance.

## Why Stronger Source Power Did Not Resolve It

This assigned source is stronger than several neighboring open sources:
distribution-free instead of marginal-nonuniform, strong instead of weak, and
realizable with arbitrary requested $\varepsilon$. The extra power helps only
to produce a better external predictor. It still does not create a proper
selector.

Known false edges do not transfer by monotonicity:

- `efficient-realizable-improper-pac -> efficient-weak-realizable-proper-pac`
  is false by PCP active slices, but the target there is distribution-free
  weak proper learning. The assigned target relaxes to marginal-nonuniform
  rates and advantages.
- `efficient-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`
  is false by one-way image coordinates, but that target is strong proper
  learning with an accuracy parameter. The assigned target is weak.
- Sample-to-computational pseudorandom-function witnesses fail efficient weak
  learning itself, so they do not satisfy the assigned computational improper
  source.

The source does imply the corresponding sample-efficient proper target once
runtime is ignored, but the computational proper search is exactly the open
piece.

## Proposed Atlas State

No atlas edit is justified by this pass. Keep the current metadata shape:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested summary if the atlas note is later refreshed:

```yaml
summary: "Open: distribution-free strong improper prediction gives accurate external hypotheses, but no generic efficient fixed-marginal selector for even weak proper hypotheses is known; PCP, DNF, one-way-coordinate, and Hadamard-code witnesses remain near misses at the marginal-nonuniform weak threshold."
```

Suggested body sketch:

```markdown
`open`.

The source can be run to small constant error under any fixed marginal, giving
an external predictor close to the realizable target. The target, however,
requires a represented member of the original class. A positive proof would
need an efficient fixed-marginal weak proper selector, approximate proper ERM,
computable proper cover, or projection oracle; sample-only existence and
boosting-style prediction do not provide this representation search.

Known false witnesses remain near misses. PCP active-slice and DNF hardness
use instance-dependent hard marginals or distributions; marginal nonuniformity
allows the runtime polynomial and weak advantage to depend on those marginals,
and packing slices into one fixed marginal dilutes the weak gap. One-way
image-coordinate concepts give fixed-marginal strong proper recovery hardness,
but weak learners can use wrong-length, wrong-image, low-support, constant, or
singleton handles without inverting. Hadamard-coded one-way images separate
proper from improper at one fixed length, or under atomless product examples,
but a single finite-encoded all-length marginal reintroduces tail-mass
dilution or finite-atom/code-correlation barriers.

Thus the edge remains open pending either a generic computational weak
properization theorem or a fixed-marginal weak proper hardness construction
where every inverse-polynomially correlated proper output recovers a hard
witness while improper realizable learning stays efficient.
```

## Concrete Obstacles

1. **Prediction is not representation search.** The source can learn an
   external predictor, but the target asks for a valid concept description.

2. **Marginal-dependent hard instances are shielded.** PCP and DNF reductions
   that choose a marginal/distribution from the NP instance do not contradict a
   target whose polynomial and weak gap may depend on that marginal.

3. **Packed slices lose weak visibility.** A single probability distribution
   cannot give polynomial or near-half mass to exponentially many hard
   instance slices. Low-mass slices can be ignored while still beating
   $1/2$ globally.

4. **Strong recovery is not weak hardness.** One-way image coordinates force
   inversion only when accuracy is set below the active coordinate mass. The
   weak target has no accuracy knob.

5. **Exact balanced codes hit the model boundary.** One-length Hadamard images
   work, and atomless product examples would work, but finite encoded
   all-length marginals reintroduce tail mass or atom/correlation barriers.

6. **Approximate codes miss the hidden gap.** Polynomial-size codes can leave
   inverse-polynomial residual correlations. Since the target's
   $\gamma_P(s)$ is hidden and may have a larger exponent, such residual
   correlations can be legal weak handles.

## Promising Branch Directions

1. **Fixed-marginal weak selector hardness.** Build one fixed marginal
   $P^\star$ and a hard relation $R(y,t)$ such that every proper hypothesis
   with inverse-polynomial positive correlation against target labels $c_y$
   yields a witness $t$, while an improper learner strongly learns the class
   under every marginal.

2. **Computational weak-handle hardness.** The top-atom and coding barriers
   suggest wrong weak handles may have to exist. A false witness could still
   work if finding any such handle is computationally hard and any found handle
   decodes a certificate.

3. **Proper trace selector theorem.** Formalize classes where the implication
   is true: finite support plus efficient trace realization, computable
   $L_1(P)$ covers by valid concepts, approximate proper ERM, or a projection
   oracle from improper predictors to $\mathcal C$.

4. **All-length Hadamard obstruction.** Turn the finite-encoded/top-atom
   argument into a clean lemma explaining why the one-length Hadamard
   one-way-function witness cannot be packed into one fixed countable marginal
   by geometry alone.

5. **Shared-coordinate PCP/instance codes.** Search for a PCP-style encoding
   where the hard instance lives in target labels over a shared fixed marginal,
   and wrong-instance proper hypotheses stay at error
   $1/2-o(1/\operatorname{poly})$ without destroying the improper source.

6. **Model fork audit.** If future atlas conventions allow atomless product
   examples or bit-oracle samples as computational instances, revisit the
   Hadamard image construction; it appears to give a clean conditional
   separation under one-way functions in that enlarged model.

verdict: unresolved
confidence: medium-high

## Depth 2 Branch: weak proper selector hardness

This branch asks whether the near-miss counterexamples can be upgraded from
"proper recovery is hard" to "even a weak fixed-marginal proper selector is
hard." The useful way to state the target counterexample contract is:

1. There is one fixed marginal $P^\star$, independent of the hard instance.
2. The class is still efficiently distribution-free realizably learnable by
   improper hypotheses.
3. Given a hard instance $y$, the reduction can simulate labeled examples
   from $(P^\star,c_y)$ without knowing the hidden witness.
4. Every proper hypothesis $h\in\mathcal C$ with

   $$
   \operatorname{err}_{P^\star}(h,c_y)
   \le \frac12-\frac{1}{\operatorname{poly}(|y|)}
   $$

   decodes a witness for $y$.

The fourth item is the hard one. Because the target learner's advantage
$\gamma_{P^\star}$ is hidden and only promised to be inverse-polynomial, a
lower bound cannot merely exclude constant advantage or near-perfect proper
accuracy. It must make all inverse-polynomially correlated proper outputs
useful for the reduction.

### One-Way/Hadamard Attempt

At one fixed length the construction is very clean. Let a seed $s$ define the
Hadamard character

$$
c_s(r)=\langle f(s),r\rangle \pmod 2
$$

under the uniform distribution on $r\in\{0,1\}^n$. Improper learning is easy:
recover a consistent parity vector by linear algebra and output it externally.
Proper weak learning is hard: any seed $t$ with $f(t)\ne f(s)$ gives a
different parity and has exactly error $1/2$, so any positive advantage
inverts the one-way image.

This only gives a length-indexed family of hard marginals $U_n$. That does not
contradict marginal-nonuniform learnability. For each fixed $U_n$, the
allowed polynomial and its constants may depend on that entire marginal, and
therefore may hide arbitrary preprocessing tied to that single length. A
one-way-function contradiction needs one learner running in one polynomial
across infinitely many lengths under one fixed marginal.

The standard repair is to mix lengths:

$$
P^\star=\sum_n \mu_n U_n.
$$

But then the active hard length has global mass $\mu_n\to0$. A wrong-length
proper hypothesis, or any hypothesis behaving like a default off its own
block, can have global error roughly $\mu_n/2+\mu_m/2$, which is already far
below $1/2$ for large $n$ if $m$ is a fixed or lower-mass block. The strong
improper source can still learn, but weak proper learning no longer forces
image recovery.

The atomless product-measure version would fix this geometrically. Under fair
product measure on infinite bit strings, all finite parity characters are
orthogonal, so a proper hypothesis with any positive advantage must carry the
same encoded image. That looks like a genuine conditional separation under
one-way functions. The problem is model fit: the atlas computational
convention uses finite encoded sample transcripts. Replacing product examples
by finite prefixes reintroduces a length/tail event, and the weak advantage is
diluted by the probability that the sample exposes enough coordinates.

The countable finite-encoded case has a more structural obstruction. If
$P^\star$ is countably supported, let $p>0$ be the largest atom. For any large
family of sign functions, many agree on that atom; among those, averaging in
the remaining coordinates gives a pair with correlation at least

$$
p-\frac{1-p}{M-1}
$$

inside the subfamily size $M$. Thus an exponentially large all-length code
cannot make every wrong codeword have correlation at most
$1/\operatorname{poly}(n)$ once $n$ is large enough. Pure Hadamard geometry
cannot supply the selector-hardness soundness condition over one fixed
countable marginal.

This does not prove a weak proper learner exists. It says that a false witness
cannot rely only on pairwise orthogonality or code distance. It would need a
new computational weak-handle statement: correlated wrong proper hypotheses may
exist, but finding any inverse-polynomially correlated one should itself
decode the one-way preimage. The current one-way/Hadamard templates do not
provide that extra hardness.

### PCP Active-Slice Attempt

The active-slice PCP witness is perfect for distribution-free weak proper
hardness. The reduction receives a formula $\varphi$, puts the marginal
uniformly on the active slice $\{(\varphi,r)\}$, labels every example by $1$,
and uses perfect completeness versus soundness below $1/2$ to force a proper
learner to output a good proof for $\varphi$.

For the present target, the hard marginal $P_\varphi$ depends on $\varphi$.
Marginal nonuniformity allows the runtime polynomial and weak advantage to
depend on $P_\varphi$. That dependence is exactly enough to block the
black-box NP-to-learning contradiction: the assumed learner gives no single
polynomial bound uniform over all formulas when the marginal changes with the
input formula.

Packing all formula slices into one distribution also loses the weak signal.
If

$$
P^\star=\sum_\psi w_\psi U_\psi,
$$

then the PCP acceptance gap on the $\varphi$ slice is multiplied by
$w_\varphi$. Since there are exponentially many formulas at each length, most
slice weights cannot be inverse-polynomial. On those slices, ignoring the
formula, outputting a wrong-slice concept, or behaving like a low-support
default can already beat $1/2$ globally. The proper learner's output no longer
has to identify a proof for the queried formula.

The remaining possibility is a shared-coordinate PCP code: put the random
string/query space under one fixed marginal and encode the formula in the
target labels, so that any proper hypothesis weakly correlated with those
labels yields a proof for that same formula. This is exactly the selector
hardness requirement in PCP clothing. It needs strong cross-instance
decorrelation: proofs for other formulas must not become weak handles. But
under a finite-encoded fixed marginal, this runs into the same code-packing
problem as the Hadamard route. If the shared coordinates are truly common and
have nonvanishing mass, exponentially many instances cannot all be made
pairwise invisible by geometry alone; if the instances get separate slices,
the weak gap is diluted.

### Why The Weak Marginal Target Keeps Escaping

The escape hatch is not statistical. The realizable target concept itself is a
perfect proper hypothesis, and the improper source can produce an external
predictor with small constant error under any marginal. The gap is purely
algorithmic: convert prediction into a represented concept with any
inverse-polynomial positive correlation.

The escape hatch is also not just "weakness." One-length Hadamard examples
show that weak proper selection can force exact cryptographic recovery when
the marginal is fixed and balanced at that length. The problem is the
combination of weak learning with marginal nonuniformity:

- length-specific or instance-specific marginals are absorbed by the
  $P$-dependent polynomial;
- all-length mixtures make the hard slice low mass, so weak global advantage
  does not localize to the hard instance;
- countable fixed marginals have atoms, and atoms create correlated wrong
  hypotheses unless a separate computational argument rules them out;
- atomless product marginals would restore orthogonality, but they sit outside
  the current finite-transcript atlas convention.

So the current branch does not resolve the edge. It narrows the shape of a
possible counterexample: the witness must make weak handles computationally
hard, not merely absent by distance.

verdict: unresolved; no atlas-ready counterexample or theorem found
confidence: medium-high
next branches:
- Formalize a "fixed-marginal weak selector hardness" lemma with a decoder
  from every inverse-polynomially correlated proper hypothesis.
- Prove a clean countable-marginal code-packing obstruction for all-length
  Hadamard/PCP shared-coordinate attempts.
- Search for a computational weak-handle construction where correlated wrong
  hypotheses exist but any efficient method for finding one yields the hidden
  witness.
- Separately investigate positive selector conditions: efficient proper trace
  realization, approximate proper ERM, or a projection oracle from improper
  predictors into $\mathcal C$.

## Depth 3 Branch: finite-trace proper selector route

This branch tests the positive route left open above. The goal is to prove,
or find the exact failure of, the following selector statement:

> A distribution-free strong improper realizable learner should give, for each
> fixed marginal $P$, an efficient weak proper selector.

The source learner gives prediction. For any realizable target
$c\in\mathcal C$, run it at constant accuracy to obtain an external
hypothesis $g$ with

$$
\operatorname{err}_P(g,c)\le 1/10.
$$

The desired proper output is any represented concept $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\frac1{\operatorname{poly}_P(s)}.
$$

Thus the only missing step is not statistical existence. The target concept
$c$ itself is perfect. The missing step is computational selection of some
valid representation.

### Finite Traces: What They Give

For a finite unlabeled sample

$$
S=(x_1,\ldots,x_m),
$$

the trace set

$$
\mathcal C|_S=\{(h(x_1),\ldots,h(x_m)):h\in\mathcal C\}
$$

is finite. This makes the information-theoretic story look easy: the observed
labels are one trace in this finite set, and a proper concept realizing that
trace exists.

But the computational task is the promise search problem

$$
\operatorname{TraceRealize}(S,\sigma):
\quad
\text{given a realized trace }\sigma\in\mathcal C|_S,
\text{ output a representation }h\in\mathcal C\text{ realizing it.}
$$

The improper source learner does not solve this problem. It may output a
table, circuit, vote, parity vector, or other external predictor whose
accuracy certifies that some proper concept is nearby, without giving a route
back into the original representation system.

A finite trace cover is therefore useful only with an effective selector:
given samples, labels, and perhaps evaluation access to $g$, find a valid
concept whose trace or empirical correlation is good enough. Without that
selector, Sauer-style trace bounds, sample-only covers, and finite lists are
only nonconstructive witnesses.

### Finite-Support Marginals: A Genuine Positive Island

There is one clean positive special case. Fix a marginal $P$ with finite
support

$$
F=\{x_1,\ldots,x_N\}.
$$

For every labeling of $F$ realized by some concept in $\mathcal C$, choose one
realizing representative. There are only finitely many such traces, so the
maximum chosen representation length

$$
R_P=\max_{\tau\in\mathcal C|_F} |\operatorname{rep}(\tau)|
$$

is a finite $P$-dependent constant.

A single uniform learner can dovetail over representation length $L$, test
candidate concepts on fresh labeled samples, and stop once a candidate has
small validation error. With high probability, no candidate of true error
above, say, $1/3$ passes its validation test before the good trace
representative appears. When $L\ge R_P$, the representative matching the full
support trace has zero $P$-error and passes on every validation sample.

Thus every finite-support marginal admits even constant-accuracy proper
learning by brute-force trace realization, with a runtime bounded by a
$P$-dependent constant times a polynomial in $\log(1/\delta)$. This argument
does not use the strong improper source at all.

This finite-support observation is useful because it shows what the positive
route would need: a finite high-mass trace plus a way to turn the trace into a
proper representation before the time bound loses polynomial dependence on the
target size.

### Why Finite High-Mass Sets Do Not Settle The Edge

For countably supported marginals, one can choose a finite set
$F_\eta$ with $P(F_\eta)\ge 1-\eta$. Matching the target on $F_\eta$ gives
true error at most $\eta$, so statistically this looks even stronger than weak
learning.

The atlas computational convention blocks turning this into a generic theorem
by itself. A representative that matches $F_\eta$ may still err on the tail.
It passes a validation test only with high probability, not on every sample
transcript. If validation happens to sample too much of the tail, a universal
dovetailing learner must either continue searching or output a candidate
without knowing that it has reached the right finite cover.

Continuing until the exact target concept appears can require brute-force
enumeration through representations of size $s$, which is exponential in
$s$ for an arbitrary representation system. The marginal-dependent polynomial
may hide constants depending on $P$, but it cannot turn generic enumeration of
$2^s$ descriptions into a polynomial in $s$.

So finite high-mass sets provide sample-only existence of proper covers. They
do not provide a pathwise polynomial-time selector unless there is an
additional effective trace-realization, cover-enumeration, or stopping
criterion.

### Sample-Only Covers From The Improper Learner

Another tempting idea is to use the source learner itself to generate a cover.
For fixed $P$, target size $s$, and sample size $m=\operatorname{poly}(s)$,
the possible sample transcripts induce a family of improper hypotheses output
by the source learner. With high probability, one of these hypotheses is close
to $c$.

This is still an improper cover. To use it for the target node, one must map
an external predictor $g$ to a represented concept $h\in\mathcal C$. A
sufficient projection condition would be:

$$
\operatorname{err}_P(g,c)\le 1/10
\quad\Longrightarrow\quad
\text{find }h\in\mathcal C\text{ with }\operatorname{err}_P(h,g)\le .39.
$$

Then the triangle inequality gives

$$
\operatorname{err}_P(h,c)\le .49,
$$

which is a constant weak advantage. More generally, any inverse-polynomial
slack below $.4$ would suffice.

But this projection is an approximate proper agnostic search problem against
the pseudo-labels supplied by $g$. The source learner gives no reason that
this search is easy. In the known proper-hardness templates, exactly this kind
of representation search is where the hard witness is hidden.

### Sharpened Block

The finite-trace route proves the edge under any of the following extra
conditions:

- finite support for the fixed marginal;
- an efficient proper trace-realization algorithm on high-probability samples;
- an efficiently enumerable proper $L_1(P)$ cover of polynomial size;
- an approximate proper ERM/projection oracle from external predictors into
  $\mathcal C$.

None of these conditions follows from distribution-free strong improper
realizable learning. That learner may certify that a good proper concept
exists near the labels, but it can do so while bypassing the search problem
that produces a valid member of $\mathcal C$.

The computation block is therefore sharper than "finite traces may be large."
Even when the relevant trace set is finite, and even when a finite proper
cover exists for each fixed marginal, the missing ingredient is an efficient
uniform method to identify a represented cover element. Brute-force
description enumeration is exponential in the target representation size, and
sample-only compactness does not supply a polynomial-time stopping rule under
the finite-transcript/pathwise runtime convention.

verdict: unresolved; finite-support marginals are positive, but the general
finite-trace/sample-cover/projection route needs an extra proper selector
oracle not implied by the source
confidence: medium-high
next branches:
- Formalize the finite-support positive lemma, including the validation and
  dovetailing schedule, as a sanity check on the marginal-nonuniform
  quantifiers.
- Audit whether the target definition requires pathwise runtime or only
  high-probability runtime; under the latter, countable high-mass finite
  covers may trivialize much more of the marginal-nonuniform proper target.
- Search for a natural class where `TraceRealize` is hard even though strong
  improper realizable learning is easy, and where the hardness survives weak
  fixed-marginal selection.
- Relate projection from $g$ to approximate proper agnostic learning: prove
  that any generic projection theorem would imply a proper ERM-like oracle,
  explaining why known proper-hardness examples are relevant.

## Depth 4 Branch: fixed-marginal cover versus legal weak-hard witness

- depth: 4
- edge_file: `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: medium-high

### Goal

Try one more time to decide the edge:

$$
\text{efficient distribution-free strong realizable improper}
\Longrightarrow
\text{efficient marginal-nonuniform weak realizable proper}.
$$

The source gives a uniform polynomial-time predictor outside
$\mathcal C$. The target is lenient in two ways: it fixes the marginal before
choosing the polynomial bound, and it asks only for inverse-polynomial
advantage. The depth-4 question is whether those two leniencies secretly
permit brute-force properization, or whether a legal class can still hide all
weakly useful proper representations.

### Positive Route Rechecked: Fixed-Marginal Covers

The strongest positive observation is not finite support but finite
metric covers. Since the source is distribution-free realizable PAC
learnable, the size-$s$ subfamily has polynomial sample complexity and hence
polynomial VC dimension in the usual sample-only sense. For any fixed marginal
$P$ and any fixed size $s$, standard VC compactness gives a finite
$L_1(P)$ cover of the size-$s$ concepts by proper concepts. If a learner could
enumerate a cover element close to the target and validate it, it would get
constant proper accuracy, much stronger than the weak target.

This almost proves the edge, but the quantitative step is wrong. A constant
radius cover of a VC-$d(s)$ class can have size roughly $\exp(O(d(s)))$.
The source only forces $d(s)\le \operatorname{poly}(s)$, not
$O(\log s)$. A marginal-dependent polynomial may hide constants and even an
exponent depending on $P$, but it cannot turn a generic
$2^{\operatorname{poly}(s)}$ cover search into polynomial time in $s$.

So the cover theorem gives a clean conditional positive result:

> If for every fixed $P$ the size-$s$ class has a polynomial-size proper
> $L_1(P)$ cover that is effectively enumerable by one uniform procedure, then
> the edge is true for that class.

It does not give the atlas edge. The improper learner may have polynomial
prediction complexity while the smallest proper cover, or the first useful
proper representative in any enumeration, is exponential in $s$.

### Marginal Nonuniformity Does Not Remove The Selector Search

The marginal-nonuniform quantifier is helpful only after a fixed $P$ supplies
some finite object whose size is independent of the target. For example, if
one can choose a finite high-mass set $F_P$ and a bounded list of proper
representatives realizing all relevant traces on $F_P$, a universal
dovetail-and-validate learner can eventually find a good representative with
a $P$-dependent constant overhead.

That argument breaks for general fixed marginals and size-indexed classes in
two distinct ways.

1. The number of high-mass traces can grow like $2^{d(s)}$, so the overhead is
   not a $P$-dependent constant or polynomial in $s$.
2. The source learner's external hypothesis does not identify which proper
   trace representative to use. Projection from the external predictor to
   $\mathcal C$ is an approximate proper ERM problem, exactly the task that
   proper-hardness examples make difficult.

Thus marginal nonuniformity and weakness make properization plausible in
structured classes, but they do not by themselves supply a polynomial
selector.

### False Route Rechecked: What A Legal Witness Must Do

A counterexample must satisfy a very demanding contract. There should be one
class $\mathcal C$ such that:

1. $\mathcal C$ has a distribution-free polynomial-time strong improper
   realizable learner.
2. For some fixed marginal $P^\star$, no uniform polynomial-time algorithm
   can, for every target $c\in\mathcal C_s$, output any
   $h\in\mathcal C$ with

   $$
   \operatorname{err}_{P^\star}(h,c)
   \le \frac12-\frac1{\operatorname{poly}(s)}.
   $$

3. The lower bound cannot rely on choosing $P^\star$ from the hard instance,
   because the target learner's polynomial may depend on that marginal.
4. The lower bound cannot merely force strong recovery, because the target has
   no accuracy parameter and accepts any inverse-polynomial weak handle.

The existing legal templates miss one of these points.

**PCP active slices.** The active-slice construction gives distribution-free
weak proper hardness because the reduction chooses the marginal uniform on the
formula's verifier slice. For this edge that is absorbed by
marginal-nonuniformity. Packing all formulas into one fixed marginal dilutes
the gap by the slice weight, and low-weight slices can be ignored while still
beating $1/2$ globally.

**One-way image coordinates.** The coordinate class gives fixed-marginal
strong proper hardness. But under the all-length marginal, a wrong low-mass
seed or default-like concept already has very small global error against a
length-$n$ target, so weak proper learning need not invert the one-way image.
The weak-handle version in the atlas makes this failure explicit: simple
proper handles can give weak learning while strong proper learning remains
cryptographically hard.

**Hadamard one-way images.** At one fixed length this is the cleanest weak
hardness geometry: proper concepts are parity characters indexed by
one-way images, and every wrong image has exactly error $1/2$ under the
uniform length-$n$ marginal. Any positive proper advantage inverts.
However, the hard marginal varies with $n$. Mixing lengths into one finite
encoded marginal makes the active length low mass and recreates weak handles.
An atomless product marginal would keep all finite parities orthogonal, but
that changes the computational model away from finite encoded sample
transcripts used by the atlas.

### A Sharper Candidate Witness And Its Failure

The best possible false witness would combine Hadamard soundness with a
shared fixed marginal:

- each target $c_y$ is easy to learn improperly because samples reveal linear
  constraints or sparse positive atoms;
- each proper hypothesis is a certificate/witness $t$;
- every proper hypothesis with inverse-polynomial positive correlation against
  $c_y$ decodes a valid witness for $y$.

This is exactly a fixed-marginal weak selector hardness assumption. The
current atlas references do not provide it. Coding bounds and the top-atom
argument from earlier depths show why pure geometry is unlikely to suffice in
the finite-encoded setting: a large family of binary functions over one fixed
countable marginal must contain correlated wrong pairs. Therefore a witness
would have to show not that weak handles are absent, but that finding any weak
handle is computationally equivalent to solving the hidden hard relation.

I do not see a legal construction of that kind from PCPs, DNFs, or one-way
functions without adding an unproved bespoke "all weak handles decode"
property. Adding explicit singleton/subset handles makes the target true, and
removing them does not stop wrong-length or low-mass handles after all hard
lengths are packed into one marginal.

### Proposed Atlas Update

No atlas edit is justified. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

If the edge note is refreshed later, the useful sharpened summary is:

```yaml
summary: "Open: fixed-marginal VC covers give nonconstructive proper hypotheses, but their generic size is exponential in the size-index VC dimension; known PCP, DNF, and one-way witnesses either vary the hard marginal or leave inverse-polynomial weak proper handles under one fixed marginal."
```

### Obstacles

1. **Cover size barrier.** Finite VC and fixed marginal give finite proper
   covers, but not polynomial-size or efficiently enumerable covers.

2. **Projection barrier.** The improper learner outputs an external predictor;
   turning it into a member of $\mathcal C$ is approximate proper ERM against
   pseudo-labels, with no generic polynomial algorithm.

3. **Marginal-dependent reductions fail.** PCP and DNF hardness reductions
   that choose the marginal from the input instance are neutralized by the
   target's $P$-dependent polynomial.

4. **Weak handles survive packing.** All-length fixed marginals dilute hard
   slices; wrong-length, default, or correlated concepts can have
   inverse-polynomial or better global advantage without solving the hard
   instance.

5. **Pure code orthogonality is not enough.** One-length Hadamard witnesses
   work, but finite-encoded all-length versions lose exact orthogonality or
   create low-mass active events.

### Next Directions

1. Prove a formal conditional theorem: source plus a polynomial-size
   fixed-marginal proper $L_1(P)$ cover, approximate proper ERM oracle, or
   projection oracle implies the target.

2. Search for a fixed-marginal weak selector hardness relation where every
   inverse-polynomially correlated proper concept decodes a witness, not just
   every highly accurate concept.

3. Quantify the cover-size obstruction for size-indexed VC classes: identify
   whether any known efficiently improper learnable class has unavoidable
   exponential proper $L_1(P)$ covers under a fixed marginal.

4. Audit the model boundary around atomless product examples. If infinite
   bit-oracle samples become legal computational instances, the Hadamard
   one-way image construction looks like a plausible conditional
   `resolved-false` route.

### References Checked

No new atlas files were edited. This pass used the assigned implication and
endpoint definitions, `atlas/README.md`, `atlas/arguments/properization-open.md`,
`atlas/arguments/sample-complexity-equivalence.md`,
`atlas/arguments/pcp-active-slice-weak-proper-hardness.md`,
`atlas/arguments/one-way-image-coordinate-proper-hardness.md`,
`atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`,
`atlas/witnesses/one-way-image-coordinate-class.md`,
`atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`, and
`atlas/witnesses/unrestricted-labelings.md`.

## Depth 5 Branch: proper representative maps and weak selector witnesses

- depth: 5
- edge_file: `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: medium-high

### Goal

Resolve, if possible, whether a distribution-free strong realizable improper
learner gives a marginal-nonuniform weak realizable proper learner.

At depth 5 I focused on the remaining properization gap in its most concrete
fixed-marginal form. Fix a marginal $P$ and a target concept
$c\in\mathcal C_s$. The source learner can be run at small constant error and
returns an external predictor $g$ with

$$
\operatorname{err}_P(g,c)\le \eta
$$

for, say, $\eta=1/20$. The target asks for some represented concept
$h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\frac1{\operatorname{poly}_P(s)}.
$$

The issue is therefore a fixed-marginal weak selector problem: from samples
and possibly from the external predictor $g$, efficiently find any legal
concept with positive inverse-polynomial correlation.

### Polynomial Proper Representative Maps

A clean positive theorem would follow from a polynomial proper representative
map. One possible formulation is:

For every fixed marginal $P$, there are a $P$-dependent polynomial $q_P$ and
one uniform algorithm `Rep` such that, for every size $s$ and every finite
sample set $S=(x_1,\ldots,x_m)$ with $m\le q_P(s)$, whenever a trace
$\sigma\in\{0,1\}^m$ is realized on $S$ by some concept in
$\mathcal C_s$, `Rep(S, sigma, s)` outputs a representation
$h\in\mathcal C$ of size at most $q_P(s)$ realizing $\sigma$ on $S$, in time
$q_P(s)$.

Under such a condition, the edge is true for that class. Draw a sufficiently
large fixed-marginal sample $S$, use the realizable labels to define the trace
$\sigma=(c(x_1),\ldots,c(x_m))$, map it to a proper representative, and
validate on fresh samples. Standard uniform convergence at the fixed marginal
then turns empirical consistency, or sufficiently good empirical agreement,
into constant error and hence weak advantage. The $P$-dependence is harmless
because the target node allows the polynomial and weak gap to depend on $P$.

This is only a conditional positive result. The source learner does not imply
the existence of `Rep`. An improper learner can output a circuit, table,
linear predictor, vote, or other external object whose predictions are good
without solving the promise search problem "find a legal representation for
this realized trace." Thus polynomial proper representative maps are exactly
an extra representation-level assumption, not a consequence of source
learnability.

### Trace Enumeration

Trace enumeration looks tempting because the labels are realizable. For a
finite unlabeled sample $S$, the trace family

$$
\mathcal C_s|_S
= \{(h(x_1),\ldots,h(x_m)):h\in\mathcal C_s\}
$$

is finite, and the observed trace belongs to it. If the learner could
enumerate a polynomial-size set of proper representatives covering all
relevant traces, validation would select a weak proper hypothesis.

The generic enumeration route fails twice.

First, the number of traces can be exponential in the VC dimension. The source
only forces polynomial sample complexity, so the size-$s$ VC dimension may be
$\operatorname{poly}(s)$. A cover or trace list of size
$2^{\operatorname{poly}(s)}$ is not acceptable for the target, even though the
polynomial bound may depend on $P$.

Second, enumerating descriptions is not the same as enumerating traces. A
realized trace may first appear only after searching exponentially many legal
representations of size $s$. Marginal nonuniformity can hide constants
depending on $P$, but it cannot make a generic $2^s$ representation search
polynomial in the target size.

So trace enumeration proves the edge only under an effective polynomial trace
selector or polynomial proper cover assumption. Finite support is a positive
island because the complete support trace table is a $P$-dependent finite
object. General fixed marginals do not give such a table with polynomial
size and a uniform stopping rule.

### Projection From External Predictors

The strongest use of the source learner is to obtain $g$ and then project
$g$ back to the concept class. A sufficient projection oracle would be:

Given samples from $P$, labels from an external predictor $g$, and the promise
that some $c\in\mathcal C_s$ has $\operatorname{err}_P(c,g)\le \eta$, output
$h\in\mathcal C$ with

$$
\operatorname{err}_P(h,g)\le \frac12-\eta-\frac1{\operatorname{poly}_P(s)}.
$$

Then

$$
\operatorname{err}_P(h,c)
\le \operatorname{err}_P(h,g)+\operatorname{err}_P(g,c)
\le \frac12-\frac1{\operatorname{poly}_P(s)}.
$$

This makes the missing algorithm precise: it is a weak approximate proper ERM
or projection procedure against pseudo-labels supplied by an external
predictor. The source learner gives no such projection. In fact, known
proper-hardness examples are best understood as cases where good external
prediction is easy but legal representation search is hard.

The projection route also explains why ordinary boosting is not enough.
Boosting can combine weak predictors into a stronger external predictor, but
the output is usually an aggregate outside $\mathcal C$. This edge needs one
member of $\mathcal C$, not a better improper vote.

### Source-Positive, Target-Negative Weak Selector Witnesses

A false resolution would need a class satisfying a much sharper contract than
the current PCP, DNF, or one-way coordinate witnesses.

The desired witness should provide:

1. a distribution-free polynomial-time strong realizable improper learner for
   $\mathcal C$;
2. one fixed marginal $P^\star$, independent of the hard instance;
3. a way to simulate realizable labels for a target $c_y\in\mathcal C_s$ from
   a hard challenge $y$;
4. a decoder such that every proper $h\in\mathcal C$ with

   $$
   \operatorname{err}_{P^\star}(h,c_y)
   \le \frac12-\frac1{\operatorname{poly}(s)}
   $$

   yields a witness for $y$.

The fourth item is the hard selector-soundness condition. Strong recovery
soundness is insufficient. The target accepts any inverse-polynomial weak
handle, so every weakly correlated legal concept must decode useful
information, or finding such a concept must itself be computationally hard.

The one-length Hadamard image construction satisfies this contract at a fixed
length: improper linear algebra recovers the external parity predictor, while
any positive-correlation proper seed inverts the one-way image. It still does
not fit the atlas edge, because the hard marginal changes with the length. A
single all-length finite-encoded marginal reintroduces low-mass active events,
wrong-length/default handles, or the countable-marginal correlation
obstruction recorded in earlier depths.

PCP active slices satisfy a related contract only when the marginal is chosen
from the formula. Once packed into one fixed marginal, slice weights dilute
the weak gap and wrong-slice proper concepts become handles. DNF/proper
hardness behaves similarly: the hard distribution carries instance
information, and the marginal-nonuniform target is allowed to depend on that
distribution.

Thus no source-positive/target-negative weak selector witness is currently in
hand. A successful witness must make weak proper handles computationally
unusable, not merely geometrically absent.

### Verdict

`unresolved-open`.

The depth-5 pass gives conditional positive statements but no atlas-ready
generic theorem. If a class has polynomial fixed-marginal proper
representative maps, polynomial enumerable proper covers, or a weak projection
oracle from external predictors to legal concepts, then the edge is true for
that class. None of those objects follows from efficient distribution-free
realizable improper learning.

The pass also sharpens the false route. A counterexample must be a
source-positive, target-negative fixed-marginal weak selector witness: every
inverse-polynomially correlated proper output must decode a hard witness, or
the act of finding any weak handle must be hard. Existing PCP, DNF, sparse
one-way coordinate, and Hadamard repairs do not meet that contract under the
atlas finite-encoded fixed-marginal convention.

### Obstacles

1. **Representative-map gap.** The realized sample trace has a proper
   representative, but the source learner does not provide a polynomial-time
   map from traces to legal concepts.

2. **Trace-count barrier.** VC/sample compactness gives finite traces and
   covers, but generic trace families may have size
   $2^{\operatorname{poly}(s)}$, too large for the computational target.

3. **Projection barrier.** Turning an external predictor $g$ into
   $h\in\mathcal C$ is a weak approximate proper ERM problem against
   pseudo-labels. This is not implied by improper realizable learning.

4. **Marginal-nonuniform shield.** Hardness reductions using an
   instance-dependent marginal do not contradict a target whose polynomial and
   weak advantage may depend on that marginal.

5. **Weak-handle leakage.** Fixed all-length marginals let wrong-length,
   low-mass, default, or residual-code proper hypotheses beat random guessing
   without recovering the hard witness.

6. **No legal selector-hardness witness.** Existing near misses force strong
   proper recovery or distribution-free weak recovery, but not fixed-marginal
   inverse-polynomial weak proper selector hardness.

### Concrete Depth-6 Directions

1. **Formalize the conditional true theorem.** State and prove a reusable
   lemma: source plus a $P$-polynomial proper representative map, polynomial
   proper $L_1(P)$ cover, or weak projection oracle implies the target edge.

2. **Separate trace enumeration from trace realization.** Build or find an
   example where the trace family has small information-theoretic complexity
   but the promise problem `TraceRealize(S, sigma)` is hard, while an improper
   learner remains efficient.

3. **Design a fixed-marginal weak selector witness.** Search for a hard
   relation $R(y,w)$ and class $\mathcal C$ where every weakly correlated
   proper hypothesis under one $P^\star$ decodes $w$, but an improper learner
   can still learn from realizable samples distribution-free.

4. **Revisit dense image codes with efficient improper learning.** The missing
   object is a balanced all-size code where external prediction is easy from
   samples, but every legal inverse-polynomial correlation yields a preimage
   or hard-core witness. Check whether pseudorandom-code assumptions can
   supply this without making the improper source hard.

5. **Quantify the all-length packing barrier.** Turn the top-atom and
   low-mass-slice observations into a formal no-go lemma for pure geometric
   Hadamard/PCP packing over fixed countable finite-encoded marginals.

6. **Audit runtime convention dependence.** If future atlas conventions allow
   high-probability runtime, atomless product examples, or oracle-valued
   samples, re-evaluate whether countable-cover or Hadamard image arguments
   become decisive.

## Depth 6 Branch: last properization attempt and atlas-facing synthesis

- depth: 6
- edge_file: `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- verdict: unresolved-open
- confidence: high that the existing atlas state should remain open

### Goal

Make one final attempt to decide the edge

$$
\text{efficient realizable improper PAC}
\Longrightarrow
\text{efficient marginal-nonuniform weak realizable proper PAC}.
$$

The source gives, under every marginal $P$ and every target
$c\in\mathcal C_s$, a polynomial-time external predictor $g$ with arbitrarily
small error. The target only asks, for each fixed $P$, for one legal concept
$h\in\mathcal C$ with inverse-polynomial positive correlation against $c$.

After depth 6, I still do not see an atlas-ready proof or counterexample. The
final obstruction is precise:

$$
\text{accurate external prediction}
\not\Rightarrow
\text{efficient proper weak selection}
$$

without an additional representation-level selector.

### Conditional Positive Lemma: Polynomial Proper Representative Maps

The clean theorem that would settle this edge positively for a class is the
following.

**Lemma template.** Fix a class $\mathcal C$ satisfying the source. Suppose
that for every marginal $P$ there is a $P$-dependent polynomial $q_P$ and one
uniform algorithm `Rep` with this property. For every target size $s$ and every
sample multiset $S=(x_1,\ldots,x_m)$ of length $m\le q_P(s)$, if a labeling
$\sigma\in\{0,1\}^m$ is realized on $S$ by some concept in $\mathcal C_s$,
then `Rep(S, sigma, s)` outputs, in time $q_P(s)$, a legal concept
$h\in\mathcal C$ of size at most $q_P(s)$ whose trace on $S$ has empirical
error at most

$$
\frac12-\frac{3}{q_P(s)}
$$

against $\sigma$.

Then the assigned implication is true for $\mathcal C$. On realizable samples
from $(P,c)$, apply `Rep` to the observed trace and validate on a fresh sample.
With the usual Chernoff bound, increasing $q_P$ by a constant factor makes the
selected legal concept have true error at most

$$
\frac12-\frac{1}{q_P(s)}
$$

with confidence $1-\delta$. If `Rep` realizes the trace exactly, this even
gives constant-error proper learning.

The same proof works if `Rep` is replaced by any of these equivalent selector
objects:

1. a $P$-polynomial enumerable proper $L_1(P)$ cover containing a weakly good
   representative for every $c\in\mathcal C_s$;
2. a fixed-marginal approximate proper ERM oracle for realizable labels;
3. a projection oracle which, from an external predictor $g$ satisfying
   $\operatorname{err}_P(g,c)\le\eta$, finds a legal $h$ with
   $\operatorname{err}_P(h,g)\le 1/2-\eta-1/q_P(s)$.

This lemma is useful but conditional. Efficient distribution-free improper
realizable learning does not imply any of these representative maps. The
source learner may output an external circuit, lookup table, parity vector,
majority vote, sparse memorizer, or other predictor that entirely bypasses
the search problem of finding a valid representation in $\mathcal C$.

### Trace Enumeration Limits

The strongest generic positive idea is trace enumeration. For a finite sample
$S$, the trace set

$$
\mathcal C_s|_S
=\{(h(x_1),\ldots,h(x_m)):h\in\mathcal C_s\}
$$

is finite, and the realizable label vector is in it. If one could enumerate a
polynomial-size list of legal representatives covering the relevant traces,
validation would give the target node.

The attempt fails for two separate reasons.

First, finite VC/sample control only bounds the trace count by roughly
$m^{d(s)}$, where $d(s)$ may be polynomial in $s$. Thus even a sample of
polynomial size may have $2^{\operatorname{poly}(s)}$ possible traces. The
target's marginal-dependent polynomial can depend on $P$, but it still must
be polynomial in $s$; it cannot absorb generic exponential trace search.

Second, even a small trace family is not enough unless traces can be realized
effectively. The promise problem

$$
\operatorname{TraceRealize}(S,\sigma):
\text{given a realized trace, output a legal concept realizing it}
$$

can be exactly the hard part. The improper source learner need not solve
`TraceRealize`; it may learn by using a representation language outside
$\mathcal C$. Brute-force enumeration over legal descriptions reaches the
target concept after at most exponentially many size-$s$ descriptions, which
is not a polynomial-time marginal-nonuniform learner.

This separates the three notions that were easy to conflate:

- finite traces give sample-only existence;
- polynomial trace lists give a possible computational route;
- polynomial proper representative maps are the missing algorithmic object.

Only the last object would prove the edge.

### Projection From External Predictors

The source learner can be used most directly by first obtaining

$$
\operatorname{err}_P(g,c)\le 1/20.
$$

If there were a uniform projection algorithm that, for every fixed $P$, found
a legal $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,g)\le \frac12-\frac{1}{10q_P(s)}
$$

whenever some $c\in\mathcal C_s$ is within $1/20$ of $g$, then the edge would
be true by the triangle inequality after adjusting constants. But this
projection task is a weak approximate proper ERM problem against pseudo-labels
from $g$. It is not supplied by improper realizable learning.

This is the most compact formulation of the positive obstruction: the source
solves prediction, while the target asks for a legal representation. The
bridge is an approximate proper projection oracle.

### Last False Attempt: Source-Positive, Target-Negative Weak Selector Witness

A counterexample must be stronger than the known properization witnesses. It
must provide a class $\mathcal C$, one fixed marginal $P^\star$, and a hard
challenge family $y\mapsto c_y\in\mathcal C_s$ such that:

1. $\mathcal C$ has a distribution-free polynomial-time strong realizable
   improper learner;
2. samples from $(P^\star,c_y)$ are efficiently simulatable from the challenge
   $y$;
3. every legal $h\in\mathcal C$ with

   $$
   \operatorname{err}_{P^\star}(h,c_y)
   \le \frac12-\frac1{\operatorname{poly}(s)}
   $$

   decodes a witness for $y$, or at least yields one by a polynomial-time
   postprocessing map.

This is a source-positive, target-negative weak selector witness. It is much
harder than a strong proper recovery witness: every inverse-polynomially
correlated proper output must be useful, because the target accepts any such
weak handle.

The existing templates still miss this contract.

**PCP and DNF hardness.** These reductions choose a hard distribution or
marginal from the formula. Marginal nonuniformity shields the target because
the polynomial and weak advantage may depend on that marginal. Packing all
formula slices into one fixed $P^\star$ multiplies the acceptance gap by the
slice weight; most slices then become too light to force weak global
correlation.

**Sparse one-way image coordinates.** The fixed all-length marginal can force
strong proper recovery at accuracy $\mu_n/(3n)$, but the weak target has no
accuracy knob. Wrong-length, default, singleton, or low-support concepts can
beat $1/2$ globally without inverting the one-way image.

**One-length Hadamard image codes.** At one fixed length this is the closest
false witness: an improper linear-algebra learner recovers the external parity
predictor, while any positive-correlation proper seed gives the same one-way
image. The failure is all-length packing. A length-specific uniform marginal
varies with $n$, and a fixed finite-encoded mixture puts vanishing mass on the
active length. Wrong low-length or default concepts again become weak handles.

**Heavy-tail prefix repair.** One might try to sample finite random prefixes
with $\Pr[L\ge n]$ inverse-polynomial, so length-$n$ parity information remains
visible under one marginal. This still does not give a legal witness. If a
proper concept of a smaller length is allowed, its behavior is tested on a
larger tail mass and can already obtain weak global advantage. If the
construction adds high-mass length checks to exclude wrong lengths, then
arbitrary same-length proper seeds remain weak handles unless the parity
portion has constant mass at every length, which no single finite distribution
can provide over infinitely many lengths. This is another form of the same
mass-allocation obstruction.

**Atomless product repair.** Infinite fair product examples would restore
Hadamard orthogonality for all finite parity characters at once. Under that
model, a one-way-image Hadamard construction looks like a plausible
conditional separation. The atlas, however, currently requires pathwise
polynomial bounds on finite encoded sample transcripts. Finite prefixes
reintroduce tail dilution, so this remains a model-fork note rather than an
atlas resolution.

### Precise Obstruction

The edge is stuck at the following missing lemma:

> **Missing lemma.** Every efficiently distribution-free realizably learnable
> improper binary class admits, for each fixed marginal $P$, a uniform
> $P$-polynomial weak proper selector: given realizable samples, or given an
> accurate external predictor learned from them, output a legal
> $h\in\mathcal C$ with inverse-polynomial positive correlation.

I see no proof of this lemma. It would amount to a generic weak approximate
proper ERM/projection theorem, and known representation-sensitive proper
hardness examples are precisely warnings against such theorems.

I also see no legal counterexample. A false witness would need the selector
soundness property above: all weakly correlated proper outputs under one fixed
marginal must decode the hard witness, or finding any weak handle must itself
be computationally hard. Current PCP, DNF, one-way-coordinate, and Hadamard
constructions either vary the marginal, prove only strong recovery hardness,
or leak weak handles when packed into one finite-encoded marginal.

### Atlas-Facing Synthesis

Recommended atlas status:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Recommended summary:

```yaml
summary: "Open: strong distribution-free improper learning supplies accurate external predictors, but no generic polynomial-time fixed-marginal weak proper selector, trace-to-representation map, or projection oracle is known; existing PCP, DNF, one-way-coordinate, and Hadamard witnesses either vary the marginal, force only strong proper recovery, or leak weak handles under one finite-encoded marginal."
```

Recommended body wording:

```markdown
`open`.

Run the source learner at small constant error under the fixed marginal to get
an external predictor close to the realizable target. The remaining step is
not statistical: the target concept itself is a perfect proper hypothesis.
The missing step is algorithmic selection of a represented member of
$\mathcal C$ with even inverse-polynomial advantage. This would follow from a
polynomial fixed-marginal proper representative map, an efficiently enumerable
proper $L_1(P)$ cover, approximate proper ERM, or a projection oracle from
external predictors to legal concepts. None is implied by the abstract
improper source.

Known false-witness templates remain near misses. PCP and DNF proper-hardness
reductions use instance-dependent hard marginals or distributions, which are
absorbed by marginal-nonuniform rates; packing the instances into one fixed
marginal dilutes the weak gap. One-way image coordinates give fixed-marginal
strong proper recovery hardness, but weak proper hypotheses can exploit
wrong-length, default, low-support, or residual-code handles. Hadamard-coded
one-way images give the right weak-selector geometry at one fixed length, and
under atomless product examples, but finite-encoded all-length marginals
reintroduce tail-mass dilution or finite-atom/code-correlation barriers.

Thus the edge should remain in `properization-open` pending either a generic
computational weak properization theorem or a fixed-marginal weak selector
hardness construction in which every inverse-polynomially correlated proper
output decodes the hard witness.
```

Final verdict: unresolved. No atlas files should be edited from this pass.
