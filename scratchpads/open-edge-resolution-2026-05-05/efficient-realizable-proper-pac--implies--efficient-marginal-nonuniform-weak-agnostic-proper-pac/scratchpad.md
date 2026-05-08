# Edge: efficient-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- source: `efficient-realizable-proper-pac`
- target: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- family: `marginal-agnostic-hardness-open`

## Current Status

I do not see an atlas-ready resolution. The edge should remain open.

The stronger distribution-free source improves the low-noise part of the story:
we get one uniform clean transcript bound, not merely a $P$-dependent one. But
the proof still stops at the same proper-output obstruction as the neighboring
marginal-source edge. The improper sibling uses constants as a high-OPT
neutralizer; this target requires a member of $\mathcal C$, and efficient
realizable proper learning alone does not supply a proper neutralizer, weak
selector, or noisy ERM routine.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/conjunction-agnostic-hardness.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/conjunctions.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `references.bib`
- neighboring scratchpad:
  `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- earlier improper-target scratchpad:
  `scratchpads/open-edge-resolution-2026-05-04/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`

Primary/source pages checked:

- Benedek and Itai, "Learnability with respect to fixed distributions",
  DOI/ScienceDirect page: https://doi.org/10.1016/0304-3975(91)90026-X.
  The abstract gives the finite-cover characterization and explicitly says the
  main concern is sample complexity, not computational feasibility.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability",
  OpenReview: https://openreview.net/forum?id=aoVCFtox89. The abstract frames
  marginal-nonuniform learning as rates whose constants may depend on the
  marginal and gives a sample/rate trichotomy, not a computational proper
  selector.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice
  Problems", arXiv/PMLR:
  https://arxiv.org/abs/2207.14030 and
  https://proceedings.mlr.press/v195/tiegel23a.html. The abstract separates the
  distribution-independent weak no-advantage theorem from the fixed-Gaussian
  strong $\operatorname{OPT}+\epsilon$ theorem.
- Kearns, Schapire, and Sellie, "Toward Efficient Agnostic Learning",
  https://www.cis.upenn.edu/~mkearns/papers/agnostic-journal.pdf. Relevant
  checked points: empirical minimization is the generic agnostic route when
  optimization is available; conjunction agnostic learning is tied to hard
  optimization and weak approximation of DNF.
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by
  Halfspaces Is Hard", DOI/abstract:
  https://doi.org/10.1137/120865094. The theorem is a distribution-free weak
  agnostic hardness result, not a fixed-marginal low-OPT theorem.
- Daniely, "Complexity Theoretic Limitations on Learning Halfspaces",
  https://arxiv.org/abs/1505.05800. The theorem has the right weak
  no-advantage flavor but only gives arbitrarily small constant $\eta$, or
  subpolynomial $\eta$ under stronger assumptions.
- Diakonikolas, Kane, Manurangsi, and Ren, "Cryptographic Hardness of Learning
  Halfspaces with Massart Noise", https://arxiv.org/abs/2207.14266. This is a
  near-optimal-error Massart hardness theorem, not a no weak advantage theorem
  at the atlas tolerance.
- Nasser and Tiegel, "Optimal SQ Lower Bounds for Learning Halfspaces with
  Massart Noise", https://arxiv.org/abs/2201.09818. Useful as a restricted SQ
  near miss; it still has subpolynomial OPT and is not an arbitrary
  polynomial-time lower bound.

## Quantifiers

The source promises one efficient distribution-free realizable proper learner
$A$. For every realizable distribution $(X,c(X))$ with arbitrary marginal, and
every requested $\varepsilon,\delta$, $A$ outputs $h\in\mathcal C$ with
$\operatorname{err}(h,c)\le\varepsilon$ in time/sample polynomial in the
representation size, $1/\varepsilon$, and $\log(1/\delta)$.

The target asks for one uniform agnostic learner which, for each marginal $P$,
may have a $P$-dependent polynomial bound and a weak gap
$\alpha_P(s)=1/2-\beta_P(s)$ bounded below by an inverse polynomial depending
on $P$. For every joint distribution $\mathcal D$ with marginal $P$, it must
output $h\in\mathcal C$ satisfying
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\alpha_P(s).
$$

Because the source is distribution-free, any positive proof may choose a gap
$\alpha(s)$ independent of $P$. The open issue is not the marginal-dependent
runtime in the low-noise branch; it is finding a proper high-OPT fallback.

## Partial Positive: Low-Noise Proper Robustification

This part works, and it is worth isolating because it explains exactly where
the edge differs from the improper sibling.

Fix a constant clean accuracy, say $\varepsilon_0=1/8$, and confidence
$3/4$. Let $m(s)$ be a polynomial upper bound on the number of examples used by
the source learner $A$ at these parameters. Choose
$$
\alpha(s)\le \min\{1/32,1/(8m(s))\}.
$$

Given agnostic examples from $\mathcal D$, repeat the following on fresh
batches: run $A$ as if the labels were realizable, collect the proper outputs,
and validate all collected candidates on an independent sample.

Suppose
$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha(s).
$$
Choose $c^\star\in\mathcal C$ with
$\operatorname{err}_{\mathcal D}(c^\star)\le\eta+o(\alpha)$.
Couple one noisy run of $A$ on $(X,Y)\sim\mathcal D$ with a clean realizable
run on $(X,c^\star(X))$ using the same $P$-distributed instance sequence and
the same internal randomness. The clean run succeeds with probability at least
$3/4$. By a union bound, the probability that any one of the at most $m(s)$
inspected labels differs from $c^\star(X)$ is at most
$m(s)(\eta+o(\alpha))<1/8+o(1)$. Thus with constant probability the noisy
transcript is identical to a successful clean transcript under the original
marginal $P$.

On that event $A$ outputs a proper $h\in\mathcal C$ with
$$
\Pr_P[h(X)\ne c^\star(X)]\le \varepsilon_0.
$$
Therefore
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)
+\Pr_P[h(X)\ne c^\star(X)]
\le
\eta+o(\alpha)+\varepsilon_0.
$$
Since $\varepsilon_0\le 1/2-\alpha$, this is within the target weak tolerance.
Polynomially many repetitions and a validation sample of size
$\operatorname{poly}(1/\alpha,\log(1/\delta))$ find such a candidate with high
probability.

The proof is marginal-preserving: it does not condition on the event that a
batch is clean and then ask the source learner to work under a conditional
marginal. It compares the noisy transcript directly with a clean run on the
same original $P$-distributed instances. For this assigned edge, the source is
even stronger than needed because $m(s)$ is distribution-free.

## Where The Positive Proof Stops

The complementary regime is
$$
\eta\ge \alpha(s).
$$
For the improper target, the sibling proof includes the two constant
classifiers. The better constant has error at most $1/2$, and hence
$$
1/2\le \eta+1/2-\alpha(s).
$$
This proves the target immediately when $\eta\ge\alpha(s)$.

For the present edge, the constants need not be legal concepts. Efficient
realizable proper learning supplies a decoder for clean labels, but it does
not imply any of the following:

- a proper classifier of error at most $1/2$ for every label conditional under
  a fixed marginal;
- an efficient agnostic ERM or weak ERM routine over $\mathcal C$;
- an efficiently enumerable $P$-specific proper cover;
- a complement operation or projection from an external predictor back into
  $\mathcal C$;
- useful behavior of the source learner on inconsistent samples.

Running $A$ on noisy samples is enough only when a clean transcript occurs with
inverse-polynomial probability. For moderate noise such as $\eta=0.1$, a
polynomial-size transcript is clean with exponentially small probability, while
the target may still require a proper hypothesis with error around $0.6$.

Equivalently, if $c^\star$ is near-optimal, any $h\in\mathcal C$ satisfies
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+
\Pr_P[h(X)\ne c^\star(X)].
$$
Thus a sufficient high-OPT fallback is a proper concept that is not too far
from $c^\star$ in $L_1(P)$, for example within $1/2-\rho$ when the validation
slack is $\rho$. The source learner can find such a concept from clean labels;
it does not provide a way to find one from moderately noisy labels.

## Conditional Positive Lemmas

The edge would become true under any one of several extra representation-level
assumptions.

1. If $\mathcal C$ contains both constant classifiers and they are efficiently
   usable, the improper robustification proof is already proper.

2. More generally, if for each fixed marginal $P$ there is a $P$-polynomial
   proper baseline procedure that outputs $h\in\mathcal C$ with
   $\operatorname{err}_{\mathcal D}(h)\le 1/2$ for every conditional label
   rule, then the low-noise branch plus this baseline proves the edge.

3. If $\mathcal C$ has an efficiently findable anchor $h_0$ and is closed under
   complement, validation between $h_0$ and $\bar h_0$ gives such a baseline.

4. If for every fixed marginal $P$ there is a polynomial-time searchable
   proper cover/selector that can find some $h$ within
   $1/2-\rho_P(s)$ of any near-optimal $c^\star$ in $L_1(P)$, then the same
   split proof works.

None of these assumptions follows from the source node as stated.

## Naive Cover Attempt And Parity Warning

The sample-only analogue is true because unbounded proper ERM can search the
class. A tempting computational proof tries to simulate this by using the
realizable learner to build a fixed-marginal cover.

Fix $P$ and draw an unlabeled sample $U=(X_1,\dots,X_m)$ of the size used by
$A$ for constant clean accuracy. If one enumerates all $2^m$ labelings of
$U$ and all relevant random seeds, then for each $c\in\mathcal C$ the clean
labeling $(c(X_1),\dots,c(X_m))$ is present, and $A$ will produce a proper
candidate near $c$ with the usual probability. Validation over this list gives
the desired selector.

The enumeration is generally exponential because $m$ is polynomial in the
representation size. Marginal nonuniformity allows the polynomial to depend on
$P$, but it does not allow $2^{\operatorname{poly}(s)}$ time for one fixed
marginal.

The obstruction is not merely an artifact of analysis. Linear parities under
the uniform marginal have an exponential proper $<1/2$ cover: distinct parities
are exactly distance $1/2$ apart, so any proper cover at radius
$1/2-\rho$ contains every parity. Parities themselves are not a counterexample,
because Fourier/Gaussian-elimination structure gives algorithms in regimes
where the target asks for one. They show only that a generic small-cover proof
cannot follow from realizable proper learnability.

## False-Witness Search

### Halfspaces

Halfspaces fit the source: realizable proper learning is by linear feasibility
plus VC generalization.

Tiegel's distribution-independent theorem has the right no-advantage shape:
under worst-case lattice hardness, no efficient learner outputs even an
improper binary hypothesis with error below $1/2-\gamma$, while the best
halfspace has error $\delta$. The issue is quantitative for this edge. The
paper allows $\gamma$ to be smaller than any inverse polynomial, but the best
recorded $\delta$ is only
$$
\exp(-\Omega(\log^{1-c} d)),
$$
which is larger than $d^{-K}$ for every fixed $K$ eventually. A
marginal-nonuniform weak learner may choose
$\alpha_P(d)=d^{-K_P}$. Then the target bound
$$
\operatorname{err}(h)\le \delta+1/2-\alpha_P(d)
$$
need not be below $1/2$, so it does not contradict a theorem that only rules
out advantage over random guessing.

The fixed-Gaussian halfspace theorem has the opposite problem. It fixes the
marginal and gives strong $\operatorname{OPT}+\epsilon$ hardness, but it is
not a weak no-advantage theorem with sufficiently small OPT. It settles
neighboring strong agnostic marginal edges, not this weak additive one.

Daniely's random-CSP halfspace hardness and the Massart-noise hardness papers
are similar near misses. They either use distribution-free hard marginals, only
give arbitrarily small constant or subpolynomial OPT, prove near-optimal-error
hardness rather than no weak advantage, or are restricted to SQ algorithms.

### Conjunctions And Monomials

Conjunctions also fit the source. Kearns, Schapire, and Sellie show why
agnostic learning conjunctions is hard through optimization and weak
approximation routes. Feldman, Guruswami, Raghavendra, and Wu give a very
strong weak-agnostic hardness theorem for monomials, even allowing halfspace
outputs.

These are distribution-free hardness statements. They do not provide one fixed
or marginal-nonuniform-compatible marginal family with a single
marginal-dependent polynomial bound. They also do not give the low-OPT
quantitative form needed to beat an unknown inverse-polynomial weak gap
$\alpha_P(s)$ after the target's additive tolerance is added to OPT.

### PCP Active Slices

The PCP active-slice lookup witness gives weak proper hardness on an
input-dependent active slice. It does not fit this edge directly. The source
there is improper/lookup-friendly rather than distribution-free realizable
proper, and the hard marginal is the active slice. Packing all slices into one
shared marginal dilutes the active slice; weak marginal-nonuniform tolerances
can ignore sufficiently small slice mass.

### One-Way Image Coordinates

The one-way image-coordinate class explains the proper-representation
obstruction but fails the present source. Strong proper clean learning under
the fixed coordinate marginal would invert the one-way function.

Adding weak handles makes weak proper learning possible, but not strong proper
clean learning. Adding enough sparse lookup hypotheses to make strong clean
proper learning easy also makes agnostic proper sparse ERM easy. This route
therefore does not currently produce a false witness for the assigned edge.

### Codes And Parities

Linear codes are a useful model for the desired separation: clean proper
learning can be easy by solving linear constraints, while noisy nearest-codeword
problems can be hard. For the atlas weak additive target, however, ordinary
codes and parities have the same issue: wrong codewords are typically at
distance about $1/2$ from the target, so when the noise/OPT is at least the
chosen weak gap, a wrong codeword of error about $1/2$ may already satisfy
$$
\operatorname{err}(h)\le \eta+1/2-\alpha_P(s).
$$
To force recovery at moderate noise, wrong proper concepts would need to be
noticeably more than $1/2$ away from the target, or every weakly valid wrong
concept would need to decode the hidden witness. Plotkin-style and
list-decoding bounds make a purely geometric "all wrong concepts are
anti-correlated" construction impossible for exponentially many binary
concepts under one fixed marginal. A computational wrong-output-usefulness
gadget remains conceivable, but I did not find one.

## Proposed Atlas Metadata If Refreshed

No status change is justified. A sharper note could keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
```

Suggested summary:

```yaml
summary: "Open: distribution-free realizable proper learning gives a proper low-noise robustification, but the moderate-OPT branch of the improper proof uses constant classifiers; efficient clean proper learning alone does not provide a proper neutralizer or fixed-marginal weak selector, and known hardness witnesses do not meet the weak marginal-nonuniform quantifiers."
```

Suggested body replacement:

```markdown
## Verdict

`open`.

The low-noise part of the improper robustification remains valid with proper
outputs. Fix the source learner's constant-accuracy sample bound and choose the
weak gap below its inverse. If OPT is below this gap, a noisy run can be
coupled to a clean realizable run for a near-optimal concept on the same
original marginal. With inverse-polynomial probability the transcript is
identical to a successful clean transcript, so the source learner returns a
proper weak candidate and validation finds it.

The proof does not handle the remaining OPT regime. The improper sibling uses
the better constant classifier once OPT exceeds the weak gap, but constants
need not belong to the concept class. A positive proof would need an efficient
proper neutralizer, fixed-marginal weak selector, searchable proper cover, or
projection oracle; none follows from realizable proper learning alone.

Known hardness routes remain near misses. Halfspace and random-CSP lower
bounds either vary the marginal or have OPT too large for an unknown
inverse-polynomial weak gap, while fixed-Gaussian halfspace hardness is a
strong excess-error theorem. PCP, conjunction, one-way, and code-based
templates either fail the source, dilute under one marginal, or leave weak
proper handles.
```

## Obstacles For Depth-2 Agents

1. The only complete positive proof I can make is conditional on a proper
   high-OPT neutralizer. Without constants, complements, a fixed-$P$ selector,
   or proper ERM, the moderate-noise regime is untouched.

2. A generic transcript-cover proof is exponential. Parities under the uniform
   marginal show that polynomial-size proper $<1/2$ covers need not exist even
   for classes with efficient clean proper learners.

3. Halfspace lower bounds still miss the exact quantitative target:
   distribution-independent weak hardness has subpolynomial OPT, while
   fixed-marginal hardness is strong $\operatorname{OPT}+\epsilon$ hardness.

4. PCP/Label-Cover hardness puts hard instance identity into the marginal or
   loses the signal when packed into a shared marginal. A successful version
   needs the hard instance in labels under one fixed marginal without raising
   OPT above the unknown weak gap.

5. Code and parity routes need wrong-output usefulness rather than pure
   distance. Pairwise anti-correlation for exponentially many proper concepts
   is blocked by coding bounds, while merely uncorrelated wrong concepts are
   legal weak outputs when OPT is above the weak gap.

## Promising Branch Directions

1. Prove a reusable conditional theorem: distribution-free realizable proper
   learning plus an efficient fixed-marginal proper neutralizer implies this
   edge. This would cleanly separate the solved low-noise branch from the
   missing high-OPT selector.

2. Search specifically for fixed-marginal weak no-advantage hardness with
   $\operatorname{OPT}\le s^{-K}$ for arbitrarily large $K$, not just constant
   or subpolynomial OPT. Halfspaces and monomials remain the natural first
   candidates.

3. Try to convert FGRW/PCP weak agnostic hardness into a shared-marginal
   construction where the input instance is encoded only in labels, the
   hard slice has inverse-polynomial global mass, and OPT remains below the
   eventual weak gap of any candidate learner.

4. Build a clean-learnable proper selector class where every weakly legal
   proper output, including wrong-looking outputs, decodes a hard witness. This
   avoids demanding Plotkin-forbidden pairwise distances above $1/2$.

5. Formalize a black-box barrier: a realizable learner's off-realizable
   transcript map can hide useful proper candidates among exponentially many
   label strings. This would not separate the atlas edge, but it would rule out
   a common black-box proof strategy.

verdict: unresolved
confidence: medium-high

## Depth 2 Branch: neutralizer from distribution-free proper learning

### Question For This Branch

Depth 1 left the edge blocked only in the moderate/high-OPT regime. The
specific hope here was:

> Maybe the stronger source, distribution-free strong realizable proper
> learning, already forces some legal proper neutralizer under each fixed
> marginal $P$.

I interpret a useful neutralizer as a validation-searchable legal list or
sampler. In $\{\pm 1\}$ notation, with
$r(x)=\mathbf E[Y\mid X=x]$, a distribution $\mu$ over proper concepts has
average prediction
$$
\bar h(x)=\mathbf E_{h\sim\mu} h(x).
$$
It is a barycentric neutralizer under $P$ up to $\zeta$ if, for every label
regression function $r:X\to[-1,1]$,
$$
\langle r,\bar h\rangle_P\ge -\zeta.
$$
Equivalently, $\|\bar h\|_{L_1(P)}\le \zeta$ if this must hold uniformly over
all $r$. Exact pointwise balance is the special case $\bar h=0$ $P$-a.s. A
finite list version lets validation pick a member whose empirical correlation
is near the list average. The two constants in the improper proof are exactly
this kind of barycentric neutralizer.

### Live Theorem Search

I did not find a theorem saying that distribution-free realizable proper PAC
learning implies such a proper neutralizer.

Closest checked sources and why they miss:

- Asilis, Devic, Dughmi, Sharan, and Teng, "Proper Learnability and the Role
  of Unlabeled Data," PMLR/ALT 2025:
  https://proceedings.mlr.press/v272/asilis25b.html. They prove broad
  distribution-fixed proper-learning statements when the learner is given the
  marginal distribution, including finite-problem distributional
  regularization. This is useful fixed-marginal context, but it is not a
  computational theorem extracting a balanced proper sampler from a clean
  realizable proper learner. It may use an explicit $D$ object and an
  optimization/projection over $H$; the atlas learner is one uniform algorithm
  that only has samples and a $P$-dependent runtime analysis.
- Benedek and Itai fixed-distribution learning and the Hanneke-Moran-Thiessen
  marginal-nonuniform trichotomy are sample/rate results. They clarify which
  quantities may depend on $P$, but do not provide a representation-level
  proper selector or neutralizer.
- Blanc, Lange, Strassle, and Tan, "A Distributional-Lifting Theorem for PAC
  Learning," PMLR/COLT 2025:
  https://proceedings.mlr.press/v291/blanc25a.html. This is about lifting
  distribution-specific learners and preserving an already available noise
  tolerance. It does not turn a clean proper learner into a fixed-$P$ proper
  neutralizer or weak agnostic selector.

So the literature search supports the depth-1 diagnosis: distribution-free
clean learning strengthens the low-noise transcript coupling, but I found no
source that makes balanced legal hypotheses appear in the high-OPT branch.

### Simple Anti-Neutralizer Witness

There is a very small reason a source-only barycentric-neutralizer theorem
cannot be true.

Let $\mathcal X_n=\{0,1\}^n$ and let
$$
\mathcal C_n=\{h_a(x)=(-1)^{a\cdot x}:a\in\{0,1\}^n\}
$$
be homogeneous parities. This class is efficiently distribution-free
realizable properly PAC learnable: on clean examples, solve the consistent
linear equations over $\mathbb F_2$ and output a parity consistent with the
sample; standard finite-VC/ERM generalization gives the PAC guarantee.

But every legal concept satisfies
$$
h_a(0^n)=1.
$$
Take the fixed marginal $P=\delta_{0^n}$. For every distribution $\mu$ over
proper concepts, $\bar h(0^n)=1$. If the label regression is $r(0^n)=-1$,
then
$$
\langle r,\bar h\rangle_P=-1.
$$
Thus there is no barycentric neutralizer with $\zeta<1$ under this fixed
marginal. More generally, if $P$ puts mass $p$ on $0^n$, no such neutralizer
can have $\zeta<p$, because the common anchor contributes $-p$ against the
adversarial label regression.

This is information-theoretic, not merely computational. It also blocks the
stronger deterministic "proper hypothesis of error at most $1/2$ for every
conditional label rule" formulation: on the atom $0^n$ with label always
$-1$, every legal proper hypothesis is wrong.

### Why This Does Not Resolve The Edge

The anchored-parity witness only refutes the overstrong neutralizer theorem.
It is not a weak agnostic counterexample.

Under $P=\delta_{0^n}$ all proper concepts are identical, so outputting any
parity has error exactly $\operatorname{OPT}_{\mathcal C}$. Under a mixed
marginal $P=p\delta_{0^n}+(1-p)U_{\mathcal X_n\setminus\{0^n\}}$, the common
anchor can make every fixed balanced sampler biased, but when the anchor
noise raises OPT above the low-noise scale, wrong parities on the remaining
mass are usually neutral enough for the weak additive target. If the planted
parity must be recovered, then we are back in the low-noise regime handled by
the clean-transcript coupling.

This also explains why "no constants" is not the same as "false edge." The
target is OPT-relative. A class can lack any chance-level legal baseline and
still be weak agnostically trivial under the offending marginal because all
legal concepts incur the same loss.

### Failed Counterexample Strengthening

I tried to upgrade the anchored idea into a real weak agnostic obstruction by
putting hard structure off the common anchor. The same two failures recur.

1. If the anchor has enough mass to kill all barycentric neutralizers, then
   adversarial labels on the anchor also raise OPT. Above the chosen weak gap,
   the target allows merely neutral or mildly wrong proper outputs.
2. If the hard off-anchor part carries the weak signal, then an exponential
   family such as parities supplies many wrong but near-neutral proper
   hypotheses, while code attempts that make all wrong hypotheses
   anti-correlated by inverse-polynomial margin hit the Plotkin/Gram barrier
   from depth 1.

To get an actual false edge, the construction would need fixed-marginal
computational weak-handle hardness: every efficiently findable proper
hypothesis satisfying the weak additive bound must decode a hard witness, but
clean realizable labels must still be properly learnable distribution-free.
The anchor trick alone does not enforce that.

### Verdict

No theorem found. More strongly, the natural theorem "distribution-free
realizable proper learning implies a $P$-barycentric proper neutralizer under
every fixed marginal" is false: homogeneous parities under an atom at the
origin are an explicit source-satisfying anti-neutralizer witness.

This does not settle the atlas implication. It only shows that the positive
proof cannot demand a source-only neutralizer. The unresolved object is a
weaker OPT-relative proper selector/weak-handle generator, or a counterexample
where finding any such handle is computationally hard under one fixed
marginal.

verdict: unresolved-open
confidence: high that source-only barycentric neutralizer theorem is false;
  medium that the edge itself remains open rather than false
next branch ideas:
- Formalize the "common anchor" anti-neutralizer lemma separately from the
  atlas edge, so future agents do not chase a false neutralizer theorem.
- Search for fixed-$P$ weak-handle hardness where all neutral-looking proper
  hypotheses are certificate-gated, not merely absent.
- Audit distribution-fixed regularization/projection results for finite
  classes to see whether any efficient special case yields a proper selector
  when the marginal is sample-accessible rather than explicitly given.
- Try anchored PCP or anchored code gadgets, but track the OPT inflation from
  the anchor explicitly; if OPT rises above the weak gap, the construction is
  probably vacuous.
- Keep the conditional positive lemma in the form "source plus
  validation-searchable barycentric neutralizer or fixed-$P$ weak cover,"
  while recording that the extra neutralizer hypothesis is genuinely extra.

## Depth 3 Branch: anchored parity agnostic hardness

### Question

Depth 2 showed that homogeneous parities refute a source-only barycentric
neutralizer theorem: every concept has value $+1$ at $0^n$. This branch asks
whether that same anchor can be strengthened into a genuine false witness for
the weak agnostic proper target, perhaps by putting adversarial noise on the
anchor and an LPN/noisy-parity hard problem off the anchor.

My conclusion is negative for ordinary anchored linear classes. The anchor is
real, but the OPT-relative weak guarantee almost exactly pays for it. Standard
homogeneous parities, affine parities, and known efficiently searchable linear
subspace variants all appear to satisfy the target by a simple two-branch
learner: low-noise clean-transcript recovery plus random linear hypotheses in
the moderate/high-OPT regime.

Sources checked for the noisy-parity side:

- Blum, Kalai, and Wasserman, "Noise-Tolerant Learning, the Parity Problem, and
  the Statistical Query Model," JACM 2003:
  https://www.microsoft.com/en-us/research/publication/noise-tolerant-learning-parity-problem-statistical-query-model/
- Kearns, "Efficient Noise-Tolerant Learning from Statistical Queries," JACM
  1998, especially the parity/SQ separation context:
  https://doi.org/10.1145/293347.293351
- Kalai, Mansour, and Verbin, "On Agnostic Boosting and Parity Learning,"
  STOC 2008:
  https://www.microsoft.com/en-us/research/publication/agnostic-boosting-parity-learning/

These sources support treating noisy parity/LPN as the relevant hardness
intuition, but they do not give the needed weak-additive lower bound. The known
algorithms are subexponential for substantial noise, and the usual LPN
assumption is about recovering a correlated hidden parity when such recovery is
actually required. The atlas target can choose its weak gap small enough that
substantial-noise LPN instances are already handled by neutral wrong parities.

### Correlation Form Of The Target

Use $\{\pm 1\}$ labels and write
$$
r(x)=\mathbf E[Y\mid X=x].
$$
For a concept $h$, let
$$
\operatorname{corr}(h)=\mathbf E[h(X)r(X)].
$$
If
$$
M=\max_{c\in\mathcal C}\operatorname{corr}(c),
$$
then
$$
\operatorname{OPT}_{\mathcal C}=\frac{1-M}{2}.
$$
The weak agnostic target with gap $\alpha$ asks for a proper $h$ with
$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\frac12-\alpha,
$$
equivalently
$$
\operatorname{corr}(h)\ge M-1+2\alpha.
$$

This is the key quantitative point. If $M$ is not very close to $1$, a concept
with zero or even mildly negative correlation can be legal. A counterexample
must therefore force every efficiently findable legal proper hypothesis to
carry real information, not merely prevent a chance-level neutralizer.

### Homogeneous Parities Are Not A Counterexample

Let
$$
\mathcal C_n=\{h_a(x)=(-1)^{a\cdot x}:a\in\{0,1\}^n\}
$$
over $\mathcal X_n=\{0,1\}^n$. This class is efficiently distribution-free
realizably properly learnable by Gaussian elimination on clean linear
constraints, followed by the usual finite-VC/ERM generalization argument.

All concepts satisfy $h_a(0^n)=1$, so the class has the anchor obstruction from
Depth 2. But the same linear structure gives an efficient randomized
high-OPT handle. If $a$ is uniform in $\{0,1\}^n$, then
$$
\mathbf E_a h_a(x)=
\begin{cases}
1, & x=0^n,\\
0, & x\ne 0^n.
\end{cases}
$$
For a fixed marginal $P$, let $p=P(0^n)$ and $b=p\,r(0^n)$. Then
$$
\mathbf E_a \operatorname{corr}(h_a)=b.
$$
Also, for every parity, the off-anchor contribution is at most $1-p$, so
$$
M\le b+1-p.
$$

Choose the final weak gap $\alpha$ below the clean-transcript scale, say with
the low-noise branch able to handle $\operatorname{OPT}<8\alpha$. In the
complementary regime,
$$
M\le 1-16\alpha.
$$
I claim that the random-parity mean has slack:
$$
b\ge M-1+4\alpha.
$$
There are two cases.

If $p\le 12\alpha$, then $b\ge -p\ge -12\alpha$, while
$$
M-1+4\alpha\le -16\alpha+4\alpha=-12\alpha.
$$
If $p>12\alpha$, then $M\le b+1-p$, hence
$$
M-1+4\alpha\le b-p+4\alpha<b.
$$

Thus, whenever the low-noise branch is not needed, a uniformly random
homogeneous parity has average correlation at least $M-1+4\alpha$. Since
correlations lie in $[-1,1]$, an inverse-polynomial fraction of parities have
correlation at least $M-1+3\alpha$ unless the target threshold is already
vacuous. Sampling $O(\alpha^{-1}\log(1/\delta))$ random parities and validating
them on fresh examples therefore finds, with high probability, a proper parity
whose true error is within
$$
\operatorname{OPT}_{\mathcal C}+\frac12-\alpha
$$
after spending another polynomial number of validation samples.

Combined with the existing clean-transcript branch for
$\operatorname{OPT}<8\alpha$, this gives a direct weak agnostic proper learner
for homogeneous parities. The proof is actually distribution-free in its
polynomial bounds; it does not merely use marginal nonuniformity.

### What Happens To The Anchor Noise

The adversarial anchor example is useful as a sanity check. Suppose labels on
$0^n$ are always $-1$, while off the anchor they are a clean parity. Then the
best homogeneous parity has error at least $p=P(0^n)$, because every legal
concept is wrong on the anchor.

If $p$ is below the low-noise threshold, the clean-transcript/Gaussian
elimination branch can recover a good parity from a batch that misses the
corrupted labels or sees labels agreeing with the best concept. If $p$ is above
the threshold, then OPT has risen by roughly $p$, and the weak additive target
allows the random-parity high-OPT branch to be mildly anti-correlated on the
anchor. The bad anchor mass pays for itself in OPT.

This is the precise way in which OPT-relative neutrality saves the target. The
class lacks a proper baseline of error $\le 1/2$ under every conditional label
rule, but the target never asks for such a baseline when the legal class itself
is already forced to make the anchor mistake.

### Why LPN Does Not Bite This Target

Under the uniform marginal, distinct parities are orthogonal. For a planted
parity with random classification noise rate $\eta$,
$$
M=1-2\eta.
$$
A wrong parity has correlation $0$. The target accepts such a wrong parity
whenever
$$
0\ge M-1+2\alpha=2(\alpha-\eta),
$$
that is, whenever $\eta\ge\alpha$.

So constant-noise LPN, and more generally noisy parity at noise rates above
the learner's inverse-polynomial weak gap, does not refute the weak additive
target. The learner can ignore the hidden parity and still satisfy the
OPT-relative bound.

When $\eta<\alpha$, the weak target does require positive correlation with the
hidden parity. But this is exactly the low-noise regime for which the
clean-transcript argument was designed. For parities, this can be viewed
concretely as repeated Gaussian elimination on small batches: when the expected
number of corrupted labels in a constant-accuracy clean learner's sample is
below a small constant, a clean transcript occurs with inverse-polynomial
probability, and validation detects the resulting good parity. This argument
does not require the noise to be independent; it only uses that the best parity
has small disagreement probability.

Thus LPN-style hardness lives in the middle-noise regime where one wants to
recover the hidden parity despite $\eta$ being noticeable. The atlas weak
agnostic target does not demand recovery there.

### Related Linear Classes

Affine parities are even safer: the uniform distribution over affine parities
has pointwise average $0$, giving a true barycentric neutralizer, and constants
are legal affine parities.

The same anchored-parity analysis extends to known linear subspace classes of
characters. If
$$
\mathcal C=\{x\mapsto (-1)^{a\cdot x}:a\in S\}
$$
for an efficiently searchable linear subspace $S$, the uniform barycenter is
the indicator of the common kernel
$$
K=\{x:a\cdot x=0\text{ for all }a\in S\}.
$$
Let $p=P(K)$ and $b=\mathbf E[r(X)1_K(X)]$. The same inequalities
$\mathbf E_{a\in S}\operatorname{corr}(h_a)=b$ and
$M\le b+1-p$ give the high-OPT random-hypothesis branch. Clean realizable
learning is linear algebra inside $S$.

This points to a sharper requirement for a real counterexample. One must
destroy the random wrong-linear-hypothesis handle while preserving efficient
proper clean learning. If the coefficient set is certificate-gated, for example
one-way-image parities $h_s(r)=(-1)^{f(s)\cdot r}$ with proper output $s$, then
proper clean learning already tends to require finding a preimage. If the
proper representation is instead the recovered coefficient vector, the target
again has random or linear-algebra handles. This is the same tension as in the
properization scratchpads: exact orthogonality removes weak handles, but it
also makes the source look like parity/noisy-codeword search unless the
representation leaks the hard witness.

### Takeaway

Anchored homogeneous parity is a good diagnostic but not a false witness. It
shows that a proper chance-level neutralizer need not exist in the strong
baseline sense, yet the weak agnostic target can still be met because:

1. below the weak gap, clean-transcript robustification recovers a good proper
   parity; and
2. above the weak gap, uniform random proper parities have enough
   OPT-relative slack, even though their barycenter is biased on the anchor.

This suggests that a successful parity-like counterexample must be more
structured than "common anchor plus LPN." It would need a fixed marginal and a
proper class where every hypothesis meeting
$$
\operatorname{corr}(h)\ge M-1+2\alpha_P(s)
$$
decodes a hard object, while clean realizable proper learning remains
polynomial-time for arbitrary marginals.

verdict: unresolved for the atlas edge; anchored homogeneous parities and
standard efficiently searchable linear classes do not give a counterexample
and appear to satisfy the weak agnostic proper target.

confidence: high for the negative result on ordinary homogeneous/affine
parities; medium for the broader claim about all "related linear" classes,
because certificate-gated coefficient sets may still hide a more delicate
proper-output obstruction.

next branch ideas:
- Try to formalize the random-barycenter lemma for character classes whose
  uniform average is an indicator of a common kernel. This would permanently
  remove ordinary anchored linear classes from the false-witness list.
- Search for a coefficient-restricted parity class where clean proper learning
  is easy for a reason other than recovering the coefficient, but every weakly
  legal agnostic proper output still reveals a hidden certificate.
- Revisit one-way-image parities only if the representation includes a clean
  proper learner that avoids inversion. Otherwise they refute the source, not
  the target.
- Look for fixed-marginal weak no-advantage hardness at OPT below every
  candidate inverse-polynomial gap. Standard LPN at noticeable noise is too
  high-OPT for this target.
- Test non-linear code families with exact or near-exact orthogonality, but
  track whether their clean realizable proper learner has become a noisy
  codeword/parity search algorithm in disguise.

## Depth 4 Branch: strong proper learner neutralizer search

Question for this branch: can the strong distribution-free realizable proper
learner itself manufacture the high-OPT proper neutralizer needed for the
marginal-nonuniform weak agnostic target?

The desired object is the following. For a fixed marginal $P$ and conditional
mean
$$
r(x)=\mathbf E[Y\mid X=x],
$$
write
$$
\operatorname{corr}(h)=\mathbf E_P[h(X)r(X)]
$$
and
$$
M=\max_{c\in\mathcal C}\operatorname{corr}(c).
$$
The weak agnostic target with advantage $\alpha$ accepts a proper hypothesis
$h\in\mathcal C$ once
$$
\operatorname{corr}(h)\ge M-1+2\alpha.
$$
The low-noise branch tries to handle $M$ extremely close to $1$. This branch is
about the complementary case, where we would like a legal proper hypothesis
that is not too negatively correlated with $r$.

### What A Strong Proper Learner Can Actually Produce

Let $A$ be a realizable proper learner. Its guarantee is only on samples drawn
from some distribution $Q$ and labeled by some legal concept $c\in\mathcal C$.
With enough clean samples, $A$ returns a legal hypothesis $h\in\mathcal C$ with
small $Q$-disagreement from $c$.

So $A$ is a promise selector into $\mathcal C$. It can select concepts that are
locally consistent with realizable labels. It does not create convex averages,
complements, or label patterns outside the class.

This matters for anchors. Suppose there is a measurable set $S$ such that every
legal concept satisfies
$$
c(x)=+1\quad\text{for all }x\in S.
$$
Then every possible proper output of $A$ also has value $+1$ on $S$. Training
on a distribution $Q$ that avoids $S$ does not help: the examples stop
constraining the output on $S$, but legality still does. Training on flipped
labels over $S$ is outside the realizable promise unless the class already
contains a concept with the flipped behavior on $Q$'s support.

Thus a strong proper learner does not, by itself, produce balanced anchors or
proper complements. If the class has no legal way to flip or randomize the
common anchor, the learner cannot synthesize one. Any anchor rescue has to come
from OPT slack or from off-anchor correlation, as in the homogeneous parity
calculation, not from the proper learner alone.

### The Barycenter View

A label-blind high-OPT strategy would be: use marginal-specific advice to
sample legal concepts from some distribution $\mu$ over $\mathcal C$, then use
fresh labeled data to validate the sampled hypotheses. Let
$$
\phi(x)=\mathbf E_{c\sim\mu}c(x).
$$
The expected correlation of a random proper hypothesis from $\mu$ is
$$
\mathbf E_{c\sim\mu}\operatorname{corr}(c)=\mathbf E_P[\phi(X)r(X)].
$$

A strong all-label neutralizer condition would be
$$
\mathbf E_P[\phi(X)r(X)]\ge M-1+2\alpha
\quad\text{for every }r:\mathcal X\to[-1,1].
$$
Equivalently, it is enough and in this all-label form essentially necessary
that
$$
\max_{c\in\mathcal C}\mathbf E_P|c(X)-\phi(X)|\le 1-2\alpha.
$$
Indeed,
$$
M-\mathbf E_P[\phi r]
=\max_{c\in\mathcal C}\mathbf E_P[(c-\phi)r]
\le \max_{c\in\mathcal C}\mathbf E_P|c-\phi|,
$$
and the reverse worst case is obtained by choosing $r$ to be the sign of
$c-\phi$ for the worst $c$.

This condition is a distribution-specific approximate center condition for
$\mathcal C$ inside its convex hull. The realizable learner $A$ does not give
such a center. It only maps clean legal label samples back to legal concepts.
For homogeneous parities the center exists for algebraic reasons: the uniform
barycenter is the common-kernel indicator. For affine parities it is exactly
zero. Those are class-geometry facts, not consequences of strong proper
learnability.

The weaker high-OPT condition only needs this inequality for label rules with
$M$ bounded away from $1$, so the all-label center condition is stronger than
necessary. But it still isolates the missing ingredient: a neutralizer proof
needs an efficiently samplable marginal-specific barycenter or hitting set of
proper concepts. A clean proper learner is not automatically such a sampler.

### Why Complements Are Not A Free Consequence

One tempting route is to say: if $A$ can learn $c$, maybe we can ask it to learn
$-c$ and get a legal complement. This is not valid unless $-c\in\mathcal C$.
The target is proper, so an output outside $\mathcal C$ is illegal even if it
would have perfect neutralizing behavior.

Another tempting route is to relabel a clean sample by a synthetic rule $g$ and
feed it to $A$. But if $g$ is not realized by a concept of $\mathcal C$ on the
sample distribution, $A$ is off promise. Its output may still be a proper
concept, but the realizable guarantee says nothing about its correlation with
$g$, with $r$, or with the best agnostic concept.

Thus the strong learner can be used robustly in only two ways:

1. low-noise recovery, where a small batch is likely to be consistent with the
   best concept; and
2. legal concept selection, where we already know how to generate clean labels
   from some legal concept.

Neither use manufactures a missing anchor flip, a complement, or a balanced
proper distribution.

### Sharpened Selector Obstruction

If this edge is false, the witness should not merely have a common anchor. The
parity analysis says that a common anchor can be paid for by OPT slack when the
off-anchor concept family has a good barycenter. The obstruction has to make
every legal high-OPT hypothesis act like a selector for hidden information.

A sharper false-witness template would fix a marginal $P$ and give a family of
conditional label rules $\{r_z\}$ such that:

1. The best legal correlation is
   $$
   M_z=1-\tau
   $$
   with $\tau$ above the clean-transcript scale but below the final weak
   threshold scale, so
   $$
   M_z-1+2\alpha=2\alpha-\tau
   $$
   is still a positive inverse-polynomial requirement.
2. The legal set
   $$
   L_z=\{h\in\mathcal C:\operatorname{corr}_{r_z}(h)\ge 2\alpha-\tau\}
   $$
   is contained in a small selector fiber encoding $z$.
3. Any efficiently samplable marginal-advice distribution $\mu$ over
   $\mathcal C$ puts negligible mass on $L_z$ for a random hidden $z$, and its
   barycenter $\phi$ is too anti-correlated with some $r_z$ to satisfy the weak
   target.
4. Clean realizable proper learning remains easy because, when $\tau=0$,
   labeled examples reveal enough constraints to reconstruct a legal selector
   for $z$.

This is more delicate than LPN at noticeable noise. If $\tau\ge 2\alpha$, the
threshold is nonpositive and a chance-level or mildly bad proper hypothesis may
be accepted. If $\tau$ is too small, the clean-transcript branch can find a
good selector by running the realizable learner on a lucky clean batch and
validating. A real obstruction must live in the narrow band where noisy
selector recovery is computationally hard but the weak agnostic guarantee still
requires positive correlation.

The properness issue then becomes exact: the hard part cannot be just that an
improper neutralizer exists outside the class. The counterexample must show
that every legal proper neutralizer is already a selector. Otherwise the
marginal-nonuniform learner can put the nonselective legal concepts in advice,
sample them, and validate.

### Consequence For The Edge Search

This branch weakens the hope for a black-box proof from strong proper
realizable learning alone. A strong proper learner does not imply:

- closure under complement;
- balanced behavior on common anchors;
- an efficiently samplable barycenter of legal hypotheses; or
- a marginal-specific hitting set for all high-OPT label rules.

The positive proof, if true, needs another idea beyond "run the proper learner
on synthetic clean data." It might be a general minimax/boosting argument that
constructs a small legal hitting set using the realizable learner as a
separation oracle, but properness is the hard point: the separation oracle only
answers realizable labeling questions, not arbitrary signed measures. Without
such an argument, the selector template above remains the most plausible place
to search for a false edge.

verdict: no black-box legal neutralizer from a strong realizable proper learner.
The learner cannot manufacture balanced anchors or complements unless those
objects are already present in the proper class. The edge remains unresolved,
but any counterexample now needs a selector-style obstruction rather than the
plain anchored-parity obstruction.

confidence: medium-high for the negative black-box conclusion; medium for the
selector template, because the narrow parameter band between clean-transcript
recovery and vacuous weak correlation still needs formal calibration.

next branches:
- Formalize the approximate-center lemma for a distribution $\mu$ over proper
  concepts, including the high-OPT-only variant where $M\le 1-\tau$.
- Try to build a selector class with easy clean proper learning but hard noisy
  weak selector recovery at $\tau<2\alpha$.
- Check whether a minimax construction can use a realizable proper learner as a
  genuine separation oracle for the convex hull of $\mathcal C$ under fixed
  marginal $P$; the suspected failure point is off-promise synthetic labels.
- Revisit certificate-gated parities under this selector lens: the source must
  stay efficiently properly learnable without requiring inversion.
- Quantify the clean-transcript scale for the source learner's sample
  complexity and compare it to the weak advantage that the target is allowed to
  choose.

## Depth 5 Branch: residual-block and representation-preserving agnosticization

- depth: 5

### Question

Depth 4 left two plausible routes:

1. a positive route, where the strong realizable proper learner is turned into
   a same-marginal weak agnostic proper learner by a legal neutralizer,
   selector, mixture/anchor construction, or representation-preserving
   agnosticization; and
2. a negative route, where a residual-block witness separates the nodes by
   making every legal weak agnostic proper output reveal a hard selector.

This branch calibrates both routes. I do not get an atlas-ready resolution.
The positive constructions still need extra legal geometry not implied by the
source, while the residual-block constructions lose exactly to the
marginal-nonuniform weak-gap quantifier unless they satisfy a much stronger
"no residual handle at any inverse-polynomial scale" condition.

### Representation-Preserving Agnosticization Still Only Handles Low Noise

A natural black-box agnosticization would keep the source representation
unchanged: run the clean proper learner on many small labeled batches, collect
proper candidates, and validate. This is representation-preserving because
every candidate is exactly whatever the source learner outputs, hence lies in
$\mathcal C$.

The limitation is quantitative. If the source learner uses $m(s)$ examples at
constant clean accuracy and the best concept has agnostic error $\eta$, then a
batch is consistent with that best concept with probability at least
$1-m(s)\eta$. This gives an inverse-polynomial discovery probability only for
$\eta \lesssim 1/m(s)$ after choosing the final weak gap below that scale. Once
$\eta$ is moderate, validation can select among candidates but cannot create a
candidate whose transcript never appeared.

Trying to repair this by feeding synthetic labels to the realizable learner is
not representation-preserving in the needed sense. The output remains proper,
but the source guarantee is off-promise unless the synthetic labels are
realized by a legal concept on the sampled marginal. In particular, synthetic
labels do not supply a separation oracle for signed measures or an ERM oracle
over $\mathcal C$.

Thus representation-preserving agnosticization gives the already-recorded
low-noise branch and no more.

### Legal Mixtures Need More Than A Clean Learner

For a fixed marginal $P$, a legal mixture $\mu$ over $\mathcal C$ has
barycenter
$$
\phi(x)=\mathbf E_{h\sim\mu}h(x).
$$
Validation can convert such a mixture into an actual proper output whenever
the expected correlation of the mixture beats the weak threshold, because a
polynomial number of sampled legal hypotheses contains a near-average member.

The obstacle is not validation; it is constructing $\mu$. A clean proper
learner can sample concepts in two legal ways:

1. choose a concept $c\in\mathcal C$, label examples by $c$, and ask the
   learner to recover some nearby proper concept; or
2. use the unknown agnostic labels and hope the transcript is clean relative to
   a near-optimal concept.

The first method presupposes an already useful distribution over legal
concepts. The second is exactly the low-noise method. Neither produces
complements, anchor flips, balanced constants, or a proper approximate center.

This is why parity-like classes are benign for a reason external to the source
node: their algebra gives a legal mixture whose barycenter is zero or a small
common-kernel indicator. A generic efficient realizable proper learner does
not expose such a mixture.

### Residual-Block Witness Calibration

The cleanest possible false witness would pack hard subproblems into residual
blocks under one fixed marginal $P$. Let block $B_n$ have mass $\mu_n$, and let
the conditional label rule on $B_n$ encode a hard selector $z_n$. A weak
agnostic proper learner for the whole marginal would be converted into a
solver for the $n$th residual problem only if the global target inequality
forces nontrivial performance on $B_n$.

In correlation notation, the target accepts $h$ when
$$
\operatorname{corr}(h)\ge M-1+2\alpha_P(s).
$$
If the only distinguishing signal is on $B_n$, the maximum gap between a
solver and a nonsolver is scaled by $\mu_n$. Therefore any reduction from weak
learning to solving the residual instance needs roughly
$$
\mu_n \cdot \gamma_n \gtrsim \alpha_P(s),
$$
where $\gamma_n$ is the within-block correlation gap between legal solvers and
legal nonsolvers.

This is the same dilution problem as active-slice PCP witnesses. Since
$\sum_n\mu_n\le 1$, the block masses must decay. But the target is allowed to
choose an inverse-polynomial gap whose exponent depends on the entire fixed
marginal $P$. If $\mu_n=n^{-2}$ and the within-block gap is constant, the
target may still use $\alpha_P(n)=n^{-K}$ for a larger fixed $K$. Then the
global weak requirement is too small to force solving the residual block.

Making $\mu_n$ decay more slowly does not solve this across all lengths:
summability prevents one fixed marginal from giving every block mass larger
than every inverse polynomial. A residual-block separation therefore needs a
stronger property than ordinary block amplification:

> For every inverse-polynomially tiny positive threshold, every legal proper
> hypothesis meeting that threshold on the global distribution must identify
> the hard residual selector.

This is much stronger than standard PCP, one-way-coordinate, or noisy-code
hardness. Those witnesses usually leave constants, singleton handles,
wrong-codeword correlations, or unrelated-slice concepts with enough residual
global correlation once the weak gap is made smaller than the block mass.

### Anchor Blocks Do Not Force The Residual Either

One can try to add a large common anchor $A$ so that all legal concepts agree
on most mass, with the hard selector living only in a residual block $B$. This
does not by itself force weak agnostic recovery.

If the labels agree with the common anchor, then every legal concept gets a
large easy positive correlation from $A$, so the residual selector is not
needed for a weak advantage. If the labels disagree with the common anchor,
then every legal concept pays that anchor loss, so OPT rises with the anchor
mass. Once OPT has risen beyond the weak gap, the target again permits
neutral or mildly wrong residual behavior.

Thus anchor mass is useful for refuting overstrong neutralizer claims, but it
is a poor way to force residual-block selection under an OPT-relative weak
agnostic guarantee.

### Selector Classes: The Remaining Negative Template

The residual-block idea could still work if the class has a legal
wrong-output-usefulness property. For a family of label rules $r_z$ under a
single fixed marginal $P$, define
$$
L_z(\alpha)=
\{h\in\mathcal C:\operatorname{corr}_{r_z}(h)\ge M_z-1+2\alpha\}.
$$
A false witness would need:

1. clean realizable proper learning is polynomial for every legal target, even
   distribution-free;
2. for a hard random $z$, every hypothesis in $L_z(\alpha)$ decodes useful
   information about $z$, for every inverse-polynomial $\alpha$ that a
   marginal-nonuniform learner might choose;
3. no legal constants, handles, anchors, wrong codewords, or mixture
   barycenters land in $L_z(\alpha)$ without decoding $z$; and
4. noisy examples in the weak regime do not give the same information that
   clean examples give to the realizable learner.

This is the narrowest obstruction I now see. It is not enough that exact
optimal proper agnostic learning be hard. It is not enough that recovering the
best selector be hard at noticeable noise. The weak target can choose an
arbitrarily small inverse-polynomial advantage, so every legal hypothesis with
even a tiny safe residual correlation must either be hard to find or must
decode the witness.

### Verdict

verdict: unresolved-open

Strong distribution-free realizable proper learning gives a
representation-preserving low-noise agnosticization, but I do not see a legal
way to extend it to the same-marginal moderate-noise regime without an
additional proper neutralizer, selector, approximate center, or searchable
legal mixture. Conversely, the obvious legal residual-block witnesses do not
separate the edge because block mass is diluted and the marginal-nonuniform
weak gap may be chosen below that diluted signal. Anchor mass blocks
source-only neutralizer theorems but is paid for by OPT.

The edge should remain open. A future false proof needs a residual selector
class where every inverse-polynomially weak legal output is already a hard
selector; a future true proof needs a way to extract a same-marginal legal
mixture or weak selector from the realizable learner without querying it
off-promise.

confidence: medium-high that residual-block/anchor constructions in their
standard form cannot resolve the edge; medium-low on the global status of the
edge, because a nonstandard selector class or minimax extraction theorem is
still plausible.

depth-6 directions:
- Prove a residual-block dilution lemma: for any fixed marginal with block
  masses $\mu_n$, if nonsolver legal hypotheses have global correlation within
  $O(\mu_n\gamma_n)$ of solvers, then a marginal-nonuniform weak learner can
  choose a gap below that scale and the block does not force recovery.
- Search for a selector class with "all weak handles decode" behavior at every
  inverse-polynomial threshold, not merely at a fixed constant threshold.
- Try a minimax theorem over $\operatorname{conv}(\mathcal C)$ under fixed
  $P$ and identify exactly what oracle is needed; then test whether a
  realizable proper learner can implement that oracle without off-promise
  labels.
- Examine whether distribution-fixed proper regularization results give an
  efficient sample-accessible legal mixture for special representation
  classes, separating genuine positives from source-only wishful thinking.
- For one-way/coding templates, quantify all legal nonsolution correlations
  after packing into one marginal; any remaining inverse-polynomial handle is
  enough for the atlas weak target and must be eliminated or made hard to find.

## Depth 6 Final Branch: middle-noise selectors and atlas-facing synthesis

- depth: 6

### Goal Of This Last Pass

The assigned edge is now localized to one question:

> Does efficient distribution-free realizable proper learning force enough
> legal same-marginal structure to handle middle-noise weak agnostic learning,
> or can a fixed-marginal residual/coding/one-way construction make every
> weakly legal proper output decode a hard witness?

I do not get an atlas-ready resolution. The last pass makes the obstruction
more precise. The strong clean proper learner gives legal hypotheses only on
realizable transcripts. It does not give a legal neutralizer, a same-marginal
weak selector, or a separation oracle over signed label rules. Conversely, the
standard false templates all leak inverse-polynomial legal handles once the
weak gap is allowed to depend on the fixed marginal.

### Residual-Block Dilution Lemma

Here is the cleanest form of the negative-template barrier.

Let a fixed marginal decompose as
$$
P=\sum_{n\ge 1}\mu_n P_n + P_{\mathrm{rest}},
\qquad \sum_n \mu_n\le 1.
$$
Suppose the hard information for length $n$ lives only on block $B_n$, and
legal solver hypotheses improve within-block correlation over all legal
nonsolvers by at most $\gamma_n\le 2$. Then the global correlation gap between
solvers and nonsolvers is at most
$$
\Delta_n \le \mu_n\gamma_n.
$$

The target accepts any proper $h$ with
$$
\operatorname{corr}(h)\ge M-1+2\alpha_P(s).
$$
Therefore a reduction from weak learning to solving the length-$n$ residual
problem can force recovery only if every legal nonsolver falls below this
threshold, which requires
$$
\alpha_P(s)\gtrsim \Delta_n.
$$
But in a marginal-nonuniform target, after fixing $P$ the learner may use an
advantage $\alpha_P(s)=s^{-K_P}$ for some marginal-dependent exponent. For any
summable block schedule $\mu_n$, there are infinitely many scales at which
$\mu_n$ is below whatever stronger polynomial the learner is allowed to hide
in $P$. If a legal nonsolver, wrong codeword, default concept, singleton
handle, or random proper hypothesis has correlation within $O(\mu_n\gamma_n)$
of the solver, the weak guarantee can be satisfied without solving the block.

This is why residual active-slice, PCP, one-way-coordinate, and shared-code
constructions keep losing visibility. They can make strong proper recovery
hard on the active block, but once packed into a single fixed marginal, the
global weak target may choose a gap below the block's signal.

### One-Way And Coding Templates Rechecked

The one-way image-coordinate class gives the right proper-representation
intuition: accurate proper output on a chosen block recovers a preimage. It
does not fit this edge. Without handles it fails the clean strong proper
source under the fixed coordinate marginal; with handles it supplies exactly
the legal weak outputs the target needs.

Coding templates have the complementary problem. If codewords are nearly
orthogonal under a fixed marginal, then a wrong codeword has correlation near
$0$ with a planted codeword. For random classification noise rate $\eta$, the
best correlation is $M=1-2\eta$, and a wrong neutral codeword is legal whenever
$$
0\ge M-1+2\alpha
\quad\Longleftrightarrow\quad
\eta\ge\alpha.
$$
Thus ordinary noisy-codeword hardness lives in the regime where the atlas weak
target can ignore the hidden word. If $\eta<\alpha$, clean-transcript
robustification recovers a good proper codeword from the realizable learner,
provided the clean learner has polynomial sample size.

Trying to make every wrong codeword anti-correlated by inverse-polynomial
margin runs into the earlier Plotkin/Gram obstruction for large binary
families under one fixed marginal. Approximate versions leave residual
inverse-polynomial correlations, and those residual correlations are legal
weak handles unless finding them is itself hard.

### Why A Positive Minimax Proof Still Misses

A possible true proof would construct, for each fixed $P$, an efficiently
samplable distribution $\mu_P$ over legal concepts with barycenter
$$
\phi(x)=\mathbf E_{h\sim\mu_P}h(x)
$$
such that for every conditional mean $r$,
$$
\langle \phi,r\rangle_P \ge
\max_{c\in\mathcal C}\langle c,r\rangle_P -1 + 2\alpha_P(s).
$$
Validation would then turn samples from $\mu_P$ into an actual proper output.
This is the exact same-marginal legal neutralizer/selector needed for the
middle-noise branch.

The missing step is constructing $\mu_P$ from the clean proper learner. A
minimax proof would need an oracle that, given a signed measure or loss vector,
finds a legal concept with good correlation. The source learner is weaker: it
only promises good behavior on samples labeled by a legal concept. Feeding it
synthetic labels asks it an off-promise question. Homogeneous parities under an
atom at the origin show that even an information-theoretic all-label
barycentric neutralizer need not exist, so any positive theorem must exploit
the OPT-relative slack, not merely chance-level balancing.

The missing positive lemma is therefore:

> Efficient realizable proper learning implies an efficiently
> sample-accessible fixed-marginal OPT-relative legal selector: for every
> marginal $P$, there is an inverse-polynomial $\alpha_P$ and a uniform
> polynomial-time procedure which, using labeled samples from any conditional
> rule with marginal $P$, finds a proper $h$ satisfying
> $\operatorname{corr}(h)\ge M-1+2\alpha_P$.

This lemma is essentially the target itself in selector form. I found no
route to derive it from the realizable source without adding constants,
complements, a proper weak ERM oracle, an explicit searchable cover, or an
efficient legal mixture.

### What A False Witness Would Have To Prove

A counterexample cannot merely say "strong agnostic proper learning is hard."
It must refute an extremely weak OPT-relative demand. For a fixed marginal
$P$ and hard label rules $r_z$, define
$$
L_z(\alpha)=
\{h\in\mathcal C:\langle h,r_z\rangle_P
\ge M_z-1+2\alpha\}.
$$
A successful separation needs all of the following:

1. $\mathcal C$ is efficiently distribution-free realizably properly
   learnable.
2. For the fixed hard marginal $P$, and for every inverse-polynomial
   $\alpha$ that a marginal-nonuniform learner might choose, every efficiently
   findable member of $L_z(\alpha)$ decodes useful information about $z$.
3. There are no legal nonsolution hypotheses in $L_z(\alpha)$: no constants,
   complements, singleton handles, wrong parities, wrong codewords, unrelated
   slice concepts, common-anchor defaults, or samplable mixture barycenters.
4. The noise level is not below the clean-transcript scale, because below that
   scale the source learner already supplies the needed proper selector.

This is the "all weak handles decode" requirement. Existing residual-block,
one-way, PCP, conjunction, halfspace, parity, and coding templates miss at
least one item. Most fail item 2 or 3 after marginal packing; some fail item 1.

### Recommended Atlas Treatment

No atlas status change is justified.

Recommended metadata remains:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
```

Recommended sharper summary:

```yaml
summary: "Open: low-noise coupling from the realizable proper learner gives legal weak candidates, but the middle-noise branch would need a same-marginal proper neutralizer or OPT-relative selector; residual-block, one-way, and coding templates currently dilute or leak legal weak handles under the marginal-nonuniform gap."
```

If the family taxonomy is refined later, this edge belongs in a subfamily such
as `proper-middle-noise-selector-open` under the broader
`marginal-agnostic-hardness-open` umbrella. I would not move it yet, because
the current argument note already names the exact obstruction.

### Final Verdict

verdict: unresolved-open

confidence: high that the known positive proof only covers low noise; high
that source-only legal neutralizers are false; medium-high that standard
residual-block/one-way/coding templates do not separate the edge; medium-low
on the absolute mathematical status of the edge.

The final obstruction is precise: clean strong proper learning does not
provide a legal middle-noise selector, but a false witness must eliminate every
inverse-polynomial legal weak handle after fixing one marginal. That missing
object, either a positive OPT-relative selector theorem or a negative
"all weak handles decode" class, is the right next lemma.
