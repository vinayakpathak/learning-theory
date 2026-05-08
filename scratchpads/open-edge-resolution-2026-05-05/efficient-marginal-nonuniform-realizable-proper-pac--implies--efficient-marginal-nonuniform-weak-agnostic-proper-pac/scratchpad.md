# Edge: efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved-open
- confidence: medium-high

## Context

The source gives one uniform learner $A$ which, for every instance marginal $P$,
has a marginal-dependent polynomial sample/time bound in the realizable case and
outputs $h \in \mathcal C$. The target asks for one uniform learner which, for
every joint distribution $\mathcal D$ with marginal $P$, outputs
$h \in \mathcal C$ with
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
\qquad
\beta_P(s)=1/2-\gamma_P(s),
$$
where $\gamma_P(s)$ is inverse-polynomial under a $P$-dependent polynomial.

The current edge note is open under
`marginal-agnostic-hardness-open`. That diagnosis is still basically right, but
there is a sharper split:

- The low-noise part of the neighboring improper-target proof *does* become
  proper here, because the source learner itself returns concepts in
  $\mathcal C$.
- The medium/high-OPT fallback in that proof uses constant classifiers. Those
  constants need not belong to $\mathcal C$, so the proof does not yield the
  proper target.

The sibling edge
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`
is now marked true by `low-noise-weak-agnostic-robustification`. This assigned
edge is exactly the proper-output version of that story.

Two other atlas notes are useful guardrails. `sample-complexity-equivalence`
explains why the sample-only analogue is true: unbounded ERM can search for a
proper agnostic hypothesis. That does not give the computational target here.
Also, `full-support-marginal-uniformization` can turn this source into ordinary
efficient realizable proper PAC learning under the atlas worst-case transcript
convention, but the edge from ordinary efficient realizable proper learning to
this marginal-nonuniform weak agnostic proper target is itself still open. So
there is no monotone or already-recorded shortcut to the assigned target.

## Attempted Resolution

### Positive route: marginal-preserving low-noise coupling

Fix a marginal $P$ and run the source learner at a constant clean accuracy, say
$1/16$, and constant confidence. Let $m_P(s)$ denote the resulting
$P$-dependent polynomial upper bound on its sample use and runtime. Set
$$
\alpha_P(s) \le \min\{1/100, 1/(100m_P(s))\}.
$$

Suppose $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, and
choose $c^\star \in \mathcal C$ with error close to $\eta$. Couple one noisy run
of $A$ on $(X,Y)\sim \mathcal D$ with one clean realizable run on
$(X,c^\star(X))$, using the same $P$-distributed instance sequence and the same
internal randomness. With probability at least $1-m_P(s)\eta$, no inspected
label is corrupted. On that event, the noisy transcript is identical to a
realizable transcript under the original marginal $P$, not under a conditional
marginal. Therefore the source guarantee applies with the same $m_P(s)$.

Since the source learner is proper, the successful clean transcript returns
$h\in \mathcal C$ with small $\operatorname{err}_P(h,c^\star)$. Then
$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\operatorname{err}_P(h,c^\star),
$$
so repeated runs plus validation find a proper hypothesis with error bounded by
an absolute constant below $1/2$. This is stronger than the target requirement
in the very-low-OPT regime.

This avoids the old conditional-marginal obstruction. The proof never invokes
the learner on a clean marginal $Q$ obtained by conditioning on no corruptions;
it only compares transcripts under the original $P$.

### Where the positive route stops

If $\eta\ge \alpha_P(s)$, the improper sibling proof simply outputs the better
constant classifier, whose error is at most $1/2$, and uses
$$
1/2\le \eta+1/2-\alpha_P(s).
$$

For this proper edge, the constants may not be in $\mathcal C$. There is no
generic replacement. A realizable proper learner gives an efficient way to find
a concept when the labels are consistent with some $c\in\mathcal C$; it does
not give:

- a proper concept with error at most $1/2$ on arbitrary noisy labels,
- an efficient weak ERM routine over $\mathcal C$,
- an enumerable $P$-specific cover of $\mathcal C$,
- or a way to make $A$ behave usefully on inconsistent samples.

Running $A$ on noisy samples and validating its proper outputs is enough only if
some run is likely to produce a useful proper candidate. The clean-batch
argument gives that when $\eta<1/m_P(s)$. For medium noise such as
$\eta=0.1$, the probability that a polynomial-size learning transcript is
entirely clean can be exponentially small, while the weak target may still
require a proper hypothesis of error at most about $0.6$.

Thus I do not see a proof of `true` from the source alone. A conditional
positive lemma is available:

> If $\mathcal C$ contains both constant classifiers, or more generally has an
> efficiently findable proper baseline with error at most $1/2$ for every
> conditional label distribution under each fixed marginal $P$, then the
> low-noise coupling plus that baseline proves this edge.

The atlas source node does not imply such a baseline.

### Counterexample route: halfspaces and fixed-marginal hardness

Halfspaces remain the best-known source-side witness: they are efficiently
realizably properly learnable by linear feasibility and VC generalization.
Tiegel's 2023 result gives distribution-independent weak agnostic hardness and
standard-Gaussian strong agnostic hardness under worst-case lattice assumptions.

The two available forms still miss this edge:

- The distribution-independent weak theorem has the right "no advantage over
  $1/2$" flavor, but its hard marginal varies with the construction. More
  importantly, the best-halfspace error in the known parameter regime is
  subpolynomially small, not below an arbitrary inverse-polynomial weak gap
  $\gamma_P(s)$ chosen by a marginal-nonuniform learner.
- The standard-Gaussian theorem fixes the marginal, but it is an
  $\operatorname{OPT}+\varepsilon$ strong agnostic lower bound. The hard
  distributions need not have $\operatorname{OPT}$ low enough to force the weak
  guarantee below $1/2$.

So halfspaces still refute distribution-free weak agnostic targets and
marginal-nonuniform strong agnostic targets, but they do not currently refute
this marginal-nonuniform weak proper target.

### Counterexample route: proper weak selector hardness

A false witness for this edge should have:

1. efficient marginal-nonuniform realizable proper learning;
2. one fixed marginal, or one atlas-compatible dimension-indexed marginal
   family, so the marginal-dependent polynomial cannot hide the hard instance;
3. conditionals with low $\operatorname{OPT}_{\mathcal C}$;
4. the property that every proper hypothesis with even inverse-polynomial weak
   advantage decodes a hard witness.

Existing atlas hardness templates do not supply all four.

- PCP active-slice weak proper hardness has the right local weak-proper
  decision gap, but the hard marginal is the active slice of the input
  instance, and the class is designed as an improper-source witness rather than
  a realizable-proper-source witness. Packing slices into one fixed marginal
  dilutes each slice, and the weak additive tolerance can ignore low-mass
  gadgets.
- Clause-satisfaction fixed-marginal hardness encodes the formula in labels
  under a uniform clause marginal, which is good for strong proper targets.
  But the gap from one violated clause is only inverse-polynomial in the clause
  universe, and the weak additive tolerance near $1/2$ can absorb it. Also, the
  clause-satisfaction class is a proper-hardness witness, not a source-positive
  realizable proper witness.
- One-way image-coordinate hardness gives fixed-marginal strong proper
  recovery hardness, but the class fails the relevant proper source under the
  one-way assumption. Its weak-handle variant explicitly shows how weak proper
  outputs can avoid recovery.

The right negative object would be a fixed-marginal weak-agnostic selector:
wrong proper outputs are not just inaccurate for strong accuracy; they fail to
achieve any inverse-polynomial weak correlation unless they solve the hard
instance. I did not find such a witness in the atlas notes or the checked
primary-source summaries.

## Proposed Atlas Update

No resolved atlas update is justified.

If the edge note is refreshed, I would keep:

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
summary: "Open: the marginal-preserving low-noise coupling gives proper weak agnostic hypotheses when OPT is below the marginal-dependent gap, but the improper proof's constant-classifier fallback need not be proper; known fixed-marginal hardness results do not refute the weak target."
```

Suggested body sketch:

```markdown
## Verdict

`open`.

The low-noise robustification resolves the very-low-OPT regime. Fix a marginal
$P$, run the realizable proper learner at constant accuracy, and choose the weak
gap below the inverse of the resulting $P$-dependent sample bound. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below this gap, couple the
noisy run to a clean realizable run for a near-optimal concept using the same
original $P$-distributed instance sequence. On the no-corruption event, the
source learner returns a proper concept, and validation finds a proper weak
hypothesis.

The proof does not handle the remaining OPT regime. The improper sibling edge
uses the better constant classifier when OPT is larger than the weak gap, but
the target here requires output in $\mathcal C$ and constants need not be in the
class. No generic proper baseline or fixed-marginal weak ERM procedure follows
from realizable proper learning.

Known false-witness routes remain near misses. Halfspace hardness either varies
the marginal in the weak theorem or fixes the Gaussian marginal only for strong
excess-error learning. PCP, clause-satisfaction, and one-way-function proper
hardness templates either fail the source or lose their hard signal under the
weak marginal-nonuniform tolerance.
```

If the atlas wants more precise family labels, this edge could eventually be
split out of `marginal-agnostic-hardness-open` into a "proper weak baseline
open" family, but I would not make that schema change from this scratchpad.

## Obstacles

- The low-noise coupling only covers
  $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$.
- The improper proof's high-OPT fallback uses constants, which are not a proper
  output for arbitrary $\mathcal C$.
- A positive proof would need an efficient proper baseline, weak ERM, or
  searchable trace cover under each fixed marginal. The source learner supplies
  none of these.
- A negative proof would need fixed-marginal weak proper hardness with
  sufficiently low OPT and no wrong proper weak handles. Current halfspace,
  PCP, clause, and one-way templates miss at least one of these requirements.

## Next Directions

1. Prove and record the conditional positive lemma for classes containing both
   constants, or more generally an efficiently searchable proper baseline of
   error at most $1/2$ under every fixed marginal.
2. Search for fixed-marginal weak no-advantage lower bounds where
   $\operatorname{OPT}_{\mathcal C}$ is below arbitrary inverse-polynomial
   gaps, not merely constant or subpolynomial. Halfspaces, monomials, and
   parities are the natural first places to check.
3. Try to design a realizable-proper-positive selector class in which every
   proper hypothesis with inverse-polynomial advantage decodes a hard witness.
   Existing PCP and one-way coordinate classes are close in spirit but fail the
   source or admit weak handles.
4. Clarify whether the atlas should distinguish "improper low-noise
   robustification" from "proper high-OPT baseline" as separate argument
   families. This edge sits exactly at that boundary.

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/conjunctions.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- Tiegel 2023, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", PMLR: https://proceedings.mlr.press/v195/tiegel23a.html
- Hanneke, Moran, and Thiessen 2025, "Marginal-Nonuniform PAC Learnability", OpenReview: https://openreview.net/forum?id=aoVCFtox89
- Kearns, Schapire, and Sellie 1994, "Toward Efficient Agnostic Learning", DOI/source page: https://doi.org/10.1023/A:1022615600103
- Benedek and Itai 1991, "Learnability with respect to fixed distributions", DOI: https://doi.org/10.1016/0304-3975(91)90026-X

verdict: unresolved-open
confidence: medium-high

---

## Depth-2 Follow-Up: Proper High-OPT Selector Attempts

- depth: 2
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved-open
- confidence: medium-high

### Focus

This pass pushed on the specific gap left by depth 1: can the
medium/high-OPT branch be made proper by using a concept produced by the
realizable learner, by complements or majorities, or by a fixed-marginal
selector?

I do not see an atlas-ready proof or counterexample. The cleanest conclusion is
that the missing operation is a fixed-marginal weak proper selector. The source
learner supplies good proper concepts on almost-realizable transcripts, but it
does not supply a polynomial-time way to choose a merely non-terrible proper
concept when the labels have moderate noise.

### Error Geometry Of The High-OPT Branch

Let $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$ and let
$c^\star\in\mathcal C$ be nearly optimal. For any $h\in\mathcal C$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\Pr_P[h(X)\ne c^\star(X)].
$$

Therefore a sufficient high-OPT fallback is a proper concept within
$1/2-\gamma_P(s)$ of some near-optimal concept in the fixed-marginal
$L_1(P)$ metric. This is much weaker than agnostic ERM, but it is still a
proper selection problem:

$$
\text{given noisy labels with an unknown near-optimal }c^\star,
\quad
\text{find }h\in\mathcal C\text{ not almost opposite to }c^\star.
$$

The low-noise coupling finds $c^\star$ itself when
$\eta\ll 1/m_P(s)$, because an inspected transcript is clean with inverse
polynomial probability. Once $\eta$ is moderately larger than $1/m_P(s)$, the
all-clean-transcript probability becomes exponentially small, while the target
still may rule out proper hypotheses that are strongly anti-correlated with
$c^\star$.

### Realizable-Learner Transcript Attempt

A tempting route is to use the source learner $A$ to manufacture a
$1/2$-cover of $\mathcal C$ under the fixed marginal $P$.

Fix the sample/time bound $m_P(s)$ for a constant-accuracy run of $A$. If we
draw an unlabeled sample $S=(X_1,\ldots,X_m)$ from $P$ and enumerate all
$2^m$ labelings of $S$, then for every target concept $c$ the labeling
$(c(X_1),\ldots,c(X_m))$ is included. Running $A$ on every such labeled sample
would produce candidates that, after validation, should cover all realizable
targets up to the clean accuracy parameter.

This is exactly the sample-only/proper-ERM route, and it is not efficient in
the atlas sense. Since $m_P(s)$ is polynomial, the transcript-label enumeration
is generally exponential. Marginal nonuniformity permits the polynomial bound
to depend on $P$, but it does not permit an exponential dependence on the
representation size $s$ for one fixed marginal.

I do not see a way to compress this enumeration using only the source learner.
Running $A$ on the noisy labels gives proper candidates, but the source
guarantee says nothing about $A$ on inconsistent samples. Running $A$ on
flipped labels only helps if the class has usable complements. Running $A$ on
short subsamples makes the clean event polynomially likely, but then the clean
realizable guarantee of $A$ need not apply.

### Complement And Majority Tricks

Complementation would solve some anti-correlation cases, but only under an
extra class property. If $\mathcal C$ is closed under complement, then any
proper baseline $h_0$ comes with $\bar h_0$, and one of the pair is within
$1/2$ of any fixed target concept. Together with the low-noise coupling and
validation, this gives a conditional positive theorem for complement-closed
classes, or for classes containing an efficiently findable finite proper
$1/2-\gamma_P(s)$ cover under each fixed $P$.

The atlas source node does not imply complement closure. It also does not imply
that the constant classifiers are present. The improper sibling proof relies
on constants precisely because they guarantee error at most $1/2$ against any
label conditional; without them, an arbitrary proper concept can be nearly
opposite to the near-optimal concept in the moderate-noise regime.

Majority votes have the same problem in another form. Boosting or voting among
proper concepts can create an improper predictor with the desired weak
behavior, but the target requires a single member of $\mathcal C$. Unless the
class has a known closure or projection operation, a majority vote is just
another external predictor to be properized.

### Fixed-Marginal Selector Formulation

The positive theorem would follow from the following additional object.

For every fixed marginal $P$, there is one uniform procedure with a
$P$-dependent polynomial bound that, given samples from any joint distribution
with marginal $P$, outputs $h\in\mathcal C_s$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s)
$$

for some inverse-polynomial $\gamma_P(s)$.

Of course this is essentially the target. A less tautological sufficient
condition is an efficient fixed-$P$ weak cover/selector: from samples and a
validation oracle, find a member of a proper cover that lies within
$1/2-\gamma_P(s)$ of a near-optimal concept in $L_1(P)$. The source learner
does not provide this selector; it only certifies that the right concept can be
found from clean labels.

This also explains why the sample-efficient analogue is true. With unbounded
time, one can enumerate enough proper traces or run ERM over $\mathcal C$.
The computational edge is precisely the missing representation-level selector.

### Counterexample Attempts

I tried to turn the selector failure into a false witness, but the known
templates still miss this exact edge.

**PCP active slices.** The active-slice PCP construction forces weak proper
learning to find a proof when the marginal is concentrated on the input's
slice. That does not refute a marginal-nonuniform target, because the runtime
and weak gap may depend on that input-dependent marginal. Packing all slices
into one fixed marginal dilutes the active slice; if the slice has mass $w$,
ignoring it costs only $w$, and the weak additive tolerance can absorb this
unless $w$ is near constant.

**Clause-satisfaction labels under one marginal.** Encoding a formula in labels
under a uniform clause marginal has the right fixed-marginal quantifiers for
strong agnostic proper hardness. It is too weak for this edge: the contribution
of one violated clause is only inverse-polynomial in the clause universe, while
the weak target permits an additive tolerance close to $1/2$. Fair-noise
padding makes the strong excess-error gap visible, but it also raises the
baseline so the weak guarantee need not find a satisfying assignment.

**Parity/LPN under the uniform marginal.** Parities are a useful stress test
because they are properly realizably learnable from clean samples and noisy
parity is cryptographically hard in stronger models. For this weak additive
target, however, a wrong parity is exactly uncorrelated with the target under
the uniform marginal. As soon as the noise rate $\eta$ exceeds the chosen weak
gap $\gamma_P(s)$, an arbitrary wrong parity has error $1/2$ and already
satisfies $\eta+1/2-\gamma_P(s)$. When $\eta<\gamma_P(s)$, the
marginal-preserving low-noise coupling is the relevant positive argument.

**Dense code repairs.** To make moderate-noise weak learning force recovery,
wrong proper concepts would need to be more than $1/2+\Omega(1/\operatorname{poly})$
away from the target, or any weakly correlated wrong concept would need to
decode the hard witness. Plotkin-style bounds rule out exponentially many
binary codewords all separated by more than $1/2+\tau$ for inverse-polynomial
$\tau$. Hadamard-style orthogonality gives beautiful weak geometry, but for
seed-indexed one-way concepts clean proper learning would already require
inverting the seed, so the source fails. If the proper representation is the
decoded image instead of the seed, the hardness disappears.

These failures are not a counterexample. They just identify the shape a
counterexample would need: clean proper decoding must be easy, but every
moderately noisy weak proper output must solve a hard selector problem, and the
hardness must live under one fixed marginal without weak-tail dilution.

### Proposed Atlas Update

No status change is justified. If refreshed, I would keep the edge open and
tighten the summary around the proper selector obstruction:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
summary: "Open: low-noise coupling gives proper candidates when OPT is below the fixed-marginal transcript scale, but the moderate-OPT fallback would require a fixed-marginal weak proper selector; constants, complements, and majority votes are not available in arbitrary proper classes."
```

I would not move the edge to `properization-open` outright. The obstruction is
proper-output selection, but it is not the usual improper-to-proper source
axis: the source learner is already proper on realizable data. The more precise
family would be something like "proper weak baseline/selector open" if the
atlas later splits these cases.

### Depth-3 Directions And Obstacles

1. **Formal selector lemma.** State a reusable lemma: low-noise coupling plus
   an efficient fixed-$P$ proper weak selector implies the edge. The lemma
   should explicitly separate the very-low-OPT case from the moderate-OPT
   fallback.

2. **Transcript-cover lower bound.** Formalize why enumerating source-learner
   transcripts is exponential: for a polynomial-size clean sample, covering all
   target label patterns requires $2^{m_P(s)}$ runs unless the class has extra
   trace compression.

3. **Conditional positive classes.** Record restricted positives for classes
   with both constants, complement closure plus one known anchor, polynomially
   enumerable fixed-$P$ weak covers, or a projection oracle from external
   predictors into $\mathcal C$.

4. **Proper-only noisy decoding witness.** Search for a class with easy clean
   proper decoding and hard noisy weak proper selection under one fixed
   marginal. The candidate must avoid the parity failure where wrong concepts
   are merely uncorrelated and therefore already legal weak outputs.

5. **PCP with shared marginal and anti-handles.** Look for PCP/label-cover
   encodings where the hard instance is in labels under a shared marginal, but
   wrong proper certificates are below the weak threshold rather than merely
   slightly worse in strong excess error.

6. **Wrong-output usefulness.** A counterexample need not make all wrong
   concepts anti-correlated if every weakly useful wrong concept still reveals
   the hard witness. This seems more plausible than demanding
   Plotkin-forbidden pairwise distances above $1/2+\tau$.

### Additional References Checked

- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: medium-high

---

## Depth-3: Compressed Transcript-Cover / Proper-Selector Test

- depth: 3
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved-open
- confidence: medium

### Focus

This pass tried to isolate the exact "transcript cover" statement that would
turn the existing low-noise argument into a full proof, and then tested whether
that statement follows from a realizable proper learner under one fixed
marginal.

The conclusion is negative for the naive cover lemma and negative for a
black-box transcript-search lemma. It is not yet a counterexample to the edge:
a real target learner may ignore the given realizable learner's off-realizable
behavior and use extra structure of the representation. Parities under the
uniform marginal are the useful warning sign: their proper $<1/2$ metric cover
is exponentially large, but their algebraic structure still gives efficient
fixed-marginal weak correlation search.

### Conditional Lemma That Would Suffice

Let $A$ be the source realizable proper learner and fix a marginal $P$. Let
$d_P(h,c)=\Pr_{X\sim P}[h(X)\ne c(X)]$.

A sufficient additional object is the following fixed-$P$ selector. For some
inverse-polynomial $\rho_P(s)$ and some $P$-dependent polynomial runtime, given
samples from any joint distribution $\mathcal D$ with marginal $P$, the selector
returns $h\in\mathcal C_s$ such that, for a near-optimal
$c^\star\in\mathcal C_s$,
$$
d_P(h,c^\star)\le \frac12-2\rho_P(s)
$$
with enough probability to be found by validation.

Then the edge follows. If
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the clean-transcript
scale, the already-recorded low-noise coupling returns a proper hypothesis near
$c^\star$. If $\eta$ is above that scale, the selector gives
$$
\operatorname{err}_{\mathcal D}(h)
\le \eta+d_P(h,c^\star)
\le \eta+\frac12-2\rho_P(s),
$$
and a validation slack of $\rho_P(s)$ gives the target tolerance
$1/2-\rho_P(s)$. Thus the missing operation can be stated cleanly as a
fixed-marginal weak proper selector, or equivalently as a searchable proper
$<1/2$ cover around the unknown near-optimal concept.

### What The Realizable Learner Gives For Free

There is an uncompressed trace cover. Run $A$ at accuracy
$1/2-3\rho$ and let $m_P(s)$ bound its sample use and random bits for that
invocation. Draw an unlabeled sample
$U=(X_1,\ldots,X_{m_P})$ from $P$. If we enumerate every label string
$y\in\{0,1\}^{m_P}$ and every relevant random seed, then for the clean label
string $y_i=c(X_i)$ the source guarantee says that one of these transcripts
produces a proper hypothesis within $1/2-3\rho$ of $c$, with the usual
probability over $U$ and the seed.

This is exactly the sample-only story: with unbounded time, enumerate
transcripts or run proper ERM and then validate. It does not give the
computational target, because $2^{m_P(s)}$ is exponential in the representation
size even though $m_P$ itself is a marginal-dependent polynomial.

### Polynomial-Size Cover Lemma Is False

The strongest simple refutation is linear parities under the uniform marginal.
Let $\mathcal C_n=\{x\mapsto a\cdot x \bmod 2:a\in\{0,1\}^n\}$ and let
$P$ be uniform on $\{0,1\}^n$. This class is efficiently realizably properly
learnable by Gaussian elimination plus the usual finite-dimensional
generalization bound.

For any two distinct parities $c_a,c_b$,
$$
d_P(c_a,c_b)=\frac12.
$$
Therefore any proper cover of $\mathcal C_n$ at radius $1/2-\rho(n)$, for any
$\rho(n)>0$, must contain every parity. Its size is $2^n$. The obstruction is
present under one fixed marginal $P$, so marginal nonuniformity does not rescue
the polynomial-size finite-cover lemma.

This only kills an explicit small-cover proof. It does not prove the edge
false, because parities have additional Fourier structure. A selector can be
implicit and algorithmic rather than an enumerated cover.

### Black-Box Transcript Search Is Also Too Weak

The realizable guarantee constrains $A$ only on clean realizable transcripts.
It says essentially nothing about how $A$ maps inconsistent label strings to
proper hypotheses. Thus a compressed search procedure that treats $A$ as the
sole source of candidates has no reliable structure to exploit.

In an oracle-style version, take a clean learner $A_0$ and modify only its
off-realizable transcript behavior: on one hidden label string among the
$2^{m_P}$ possible strings, return a designated useful proper hypothesis, and
on all other inconsistent strings return decoys. The source property is
unchanged, because clean realizable behavior is unchanged. Any procedure that
probes only polynomially many transcript labels can miss the hidden string.

This is not an atlas counterexample. A target learner for the class is not
forced to use that perverse $A$, and it may exploit the representation directly.
The point is narrower but important: no lemma of the form "a realizable proper
learner's transcript map automatically contains a polynomial-time searchable
proper weak selector" follows from the source definition alone.

### Can The Representation Hide Every Selector?

This remains the unresolved part. To refute the edge, one needs a class where
clean proper learning is easy but every efficient fixed-marginal weak proper
selector is hard. The transcript-cover obstruction suggests how such a class
should look, but the known repairs all leak weak handles.

- If wrong proper concepts are merely uncorrelated with the near-optimal
  concept, then at moderate $\eta$ they often already satisfy the weak additive
  bound. This is the parity/LPN failure mode.
- If wrong concepts are forced to be more than $1/2+\tau$ away from the target
  so that moderate noise forces recovery, Plotkin-style bounds prevent
  exponentially many binary concepts with that separation on one polynomial
  coordinate domain.
- If hard instances are packed into one shared marginal by slices, low-mass
  slices can be ignored by a weak learner. Making each slice visible with
  constant mass is impossible for infinitely many slices.
- If constants, complements, singleton handles, or majority/projection
  operations are added to make positive cases easier, those same objects often
  become the high-OPT proper fallback.

So the representation-hiding story is plausible as a barrier but not yet a
proof of `false`. The missing witness would need "wrong-output usefulness":
every proper hypothesis meeting the weak additive bound either is a genuine
selector for the hidden near-optimal concept or decodes the hard witness. It
need not make all wrong concepts geometrically anti-correlated, but it must
remove all efficiently findable weak handles under the one fixed marginal.

### Proposed Atlas Update

No status change is justified. If the edge note is refreshed, I would keep the
existing `open` status and use a summary that explicitly rules out the naive
transcript-cover proof:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
summary: "Open: low-noise coupling handles the clean-transcript regime, but a polynomial-size fixed-marginal proper transcript cover is false in general, and no non-black-box weak proper selector or fixed-marginal counterexample is known."
```

### Depth-4 Directions And Obstacles

1. **Formalize the black-box barrier.** Write an oracle model for transcript
   selectors and prove a query lower bound showing that off-realizable behavior
   of a source learner can hide the useful candidate among exponentially many
   label strings. This would be a barrier lemma, not an atlas separation.

2. **Look for non-black-box selector hardness.** The needed witness is a class
   with easy clean proper decoding but hard moderate-noise weak proper
   selection under one fixed marginal. The construction must avoid parity-style
   uncorrelated weak handles.

3. **Revisit conjunction/set-cover hardness at weak slack.** Existing atlas
   notes use conjunctions for strong agnostic proper hardness. Check whether
   any set-cover gap amplification yields an additive $1/2-\gamma$ weak
   proper lower bound under a fixed or marginal-nonuniform-compatible
   marginal. The obstacle is that known reductions usually need small
   inverse-polynomial excess error, not nearly-$1/2$ slack.

4. **Search for label-cover gadgets with wrong-output usefulness.** A promising
   negative witness would make every weakly legal proper output encode a
   satisfying assignment or proof, without requiring pairwise distances above
   the Plotkin threshold.

5. **Record conditional positives separately.** Classes with both constants,
   an efficiently searchable fixed-$P$ weak cover, a complement-plus-anchor
   structure, Fourier/SQ weak correlation search, or a proper projection oracle
   should be treated as positive subfamilies; none is implied by the abstract
   source node.

### Additional References Checked

- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/conjunction-agnostic-hardness.md`
- `atlas/witnesses/conjunctions.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: medium

---

## Depth-4: Non-Black-Box Proper Baseline Check

- depth: 4
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved-open
- confidence: medium

### Focus

This pass tried the requested non-black-box route. The question was whether the
representation structure behind an efficient realizable proper learner gives a
proper high-OPT fallback, even when transcript covers and black-box searches are
unavailable.

I do not see such an implication. The useful refinement is that the missing
object is slightly sharper than a cover: it is an efficient fixed-marginal
proper baseline or sampler that can find a concept with error at most $1/2$ on
arbitrary moderate-noise labels. Clean proper decoding does not appear to imply
that baseline.

### What The High-OPT Branch Really Needs

Fix $P$ and let
$$
\alpha_P(s)=1/2-\beta_P(s)
$$
be the desired inverse-polynomial weak gap. The low-noise coupling already
handles $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$ after
choosing $\alpha_P$ below the clean transcript scale.

For the complementary regime $\eta\geq \alpha_P(s)$, it would be enough to find
a proper hypothesis with
$$
\operatorname{err}_{\mathcal D}(h)\leq 1/2,
$$
because then
$$
1/2\leq \eta+1/2-\alpha_P(s).
$$
This is exactly where the improper sibling uses the better constant classifier.
For a general proper class, the analogous object is a fixed-$P$ proper
neutralizer:

> Given samples from any joint distribution with marginal $P$, output some
> $h\in\mathcal C_s$ with error at most $1/2$ whenever
> $\operatorname{OPT}_{\mathcal C}(\mathcal D)\geq \alpha_P(s)$.

This is weaker than agnostic ERM, but it is still not a consequence of clean
realizable learning.

### Balanced-Sampler Route

One sufficient condition is an efficiently sampleable proper distribution
$\mu_P$ over $\mathcal C_s$ whose average prediction is balanced under $P$:
in $\{\pm1\}$ notation,
$$
\mathbb E_{h\sim\mu_P} h(x)=0
$$
for $P$-almost every $x$, or at least up to error below the target weak gap.
Then a draw from $\mu_P$ has expected error $1/2$ against every label
conditional with marginal $P$; repeated draws plus validation would provide the
high-OPT fallback. Complement-closed classes with an anchor and affine parity
classes under the uniform marginal have this flavor.

But the source node does not imply such a sampler. A realizable proper learner
is an efficient clean decoder: given labels from one unknown concept, it can
recover a good proper concept. It does not give a way to sample a balanced
range of concepts without labels. Running the learner on arbitrary synthetic
labels only returns some proper hypothesis; its off-realizable behavior can be
as representation-dependent and biased as in the depth-3 transcript barrier.

There is also a weaker nonconstructive fact that does not seem algorithmically
useful. For a finite class and fixed $P$, the positive semidefinite Gram matrix
implies, by a minimax argument, that there is a mixed proper strategy whose
expected correlation with every concept $c\in\mathcal C_s$ is nonnegative:
for any distribution $\nu$ over concepts,
$$
\mathbb E_{c,c'\sim\nu}\langle c,c'\rangle_P
=\left\|\mathbb E_{c\sim\nu}c\right\|_{L_2(P)}^2\geq 0.
$$
Thus some mixed strategy is not, on average, anti-correlated with any fixed
concept. This still falls short of the target. It need not be efficiently
sampleable, need not put inverse-polynomial mass on useful hypotheses, and
concept-neutrality is not label-neutrality under adversarial agnostic noise.

### Hardness-Witness Route

The cleanest false-witness template would be a code/noisy-decoding class:

1. concepts are codewords or certificates;
2. clean random examples can be decoded efficiently to a proper representation;
3. under one fixed marginal, any proper hypothesis with even inverse-polynomial
   useful error on noisy labels decodes a hard witness.

Parities satisfy the first two items but fail the third. Wrong affine parities
are exactly balanced, so once the noise rate is at least the weak gap, an
arbitrary wrong parity is a valid high-OPT fallback; below the weak gap the
low-noise clean-sample argument applies.

Trying to repair this with denser codes runs back into the depth-3 geometry.
If wrong codewords have no positive correlation with the target, Plotkin-style
bounds prevent exponentially many certificates on a polynomial coordinate
domain. If many wrong codewords have small positive correlation, then they are
weak handles unless every such handle itself decodes the hard witness. If valid
concepts are efficiently sampleable, random sampling plus validation may find a
non-anti-correlated handle. If they are not efficiently sampleable, the
construction must explain why the clean learner can still output valid proper
representations while the agnostic weak learner cannot find any useful one.

The conjunction/set-cover and halfspace/monomial routes remain near misses.
Conjunctions give strong proper agnostic hardness, but the reduction needs
small excess accuracy and does not force a merely weak proper learner to find a
minimum cover. Known monomial and halfspace weak-hardness theorems have the
right no-advantage flavor, but the hard marginal varies or the quantitative
OPT scale is not below an arbitrary marginal-dependent inverse-polynomial weak
gap.

### Proposed Atlas Update

No status change is justified. If the edge note is refreshed, I would keep
`status: "open"` and sharpen the summary to:

```yaml
summary: "Open: low-noise coupling handles the clean-transcript regime, but the moderate-OPT branch would require an efficient fixed-marginal proper neutralizer or weak selector; clean realizable proper learning does not appear to supply such a balanced proper baseline, and current code, parity, conjunction, and halfspace hardness routes remain near misses."
```

I would not add a witness or assumption from this pass.

### Depth-5 Directions And Obstacles

1. **Balanced-sampler conditional theorem.** Prove the restricted positive
   result: low-noise coupling plus an efficiently sampleable fixed-$P$ balanced
   proper distribution, or a validation-searchable proper neutralizer, implies
   the edge. This would subsume constants, complement-pair anchors, and affine
   parity-like cases.

2. **Sampler impossibility target.** Look for a class where clean proper
   decoding is easy but sampling or finding any proper concept with error
   $\leq 1/2$ on moderate-noise labels is hard under one fixed marginal. This is
   weaker and more plausible than forcing all wrong concepts to be
   anti-correlated.

3. **Code-based clean-vs-noisy separation.** Search coding/cryptographic
   examples with efficient erasure or noiseless decoding from random examples
   but hard inverse-polynomial correlation decoding, while preventing random
   valid concepts from becoming weak handles.

4. **Formal weak-handle lemma.** Prove that any efficiently sampleable concept
   family with enough balanced random handles automatically satisfies this
   edge by the low-noise/validation algorithm. Such a lemma would rule out many
   naive random-code counterexamples.

5. **Fixed-marginal low-OPT hardness search.** Continue checking monomial,
   conjunction, halfspace, and label-cover sources specifically for a theorem
   with one fixed marginal and
   $\operatorname{OPT}$ below every inverse-polynomial gap an alleged
   marginal-nonuniform weak learner may choose.

### Additional References Checked

- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/conjunction-agnostic-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: medium

---

## Depth-5: Gap-Shrinking And Fixed-Marginal Hardness Stress Test

- depth: 5
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved-open
- confidence: medium-high

### Focus

This pass tried two ways to close the depth-4 gap.

First, I checked whether the target learner can choose the weak gap so small
that the moderate-OPT branch becomes automatic. This helps quantitatively but
does not remove the need for a fixed-marginal proper selector or neutralizer.

Second, I rechecked the closest negative sources: halfspaces, monomials,
parities/codes, PCP slices, and one-way image-coordinate classes. They still do
not give a fixed-marginal weak proper counterexample with an efficient
realizable proper source.

### Gap Shrinking Does Not Remove The Selector

Let $m_P(s)$ be the fixed-$P$ sample/time bound for a constant-accuracy clean
run of the realizable proper learner. The low-noise coupling can be run with a
threshold
$$
\alpha_P(s) \ll 1/m_P(s).
$$
The weak target is free to use an even smaller gap
$$
\gamma_P(s) = 1/2-\beta_P(s) \ll \alpha_P(s).
$$
This means that in the complementary regime
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)\geq \alpha_P(s)$, the target
only asks for
$$
\operatorname{err}_{\mathcal D}(h)
\leq \eta + 1/2-\gamma_P(s),
$$
which is slightly easier than the depth-4 formulation with
$\gamma_P=\alpha_P$.

However, the middle-noise obstruction survives. In $\{\pm1\}$ notation, writing
$\bar y(x)=\mathbb E[Y\mid X=x]$, the target condition is equivalent to
finding $h\in\mathcal C_s$ with
$$
\langle h,\bar y\rangle_P
\geq
\sup_{c\in\mathcal C_s}\langle c,\bar y\rangle_P - 1 + 2\gamma_P(s).
$$
If the best concept has error $\eta$, the right side can still be close to
$-2\eta+2\gamma_P(s)$. Thus a completely anti-correlated proper anchor can
fail throughout the range between the clean-transcript scale and roughly
constant noise. Making $\gamma_P$ smaller narrows the forbidden margin, but it
does not manufacture a proper concept whose correlation is not too negative.

This is why the constants in the improper proof are so powerful: one of the
two constants has error at most $1/2$ for every label conditional, independent
of the near-optimal concept. A general proper class need not contain any such
label-neutral object.

### What A Neutralizer Would Have To Do

The most useful non-tautological sufficient condition remains:

> For each fixed marginal $P$, there is a $P$-dependent polynomial-time
> procedure which, given samples from any joint distribution with marginal
> $P$, outputs $h\in\mathcal C_s$ with error at most
> $\eta+1/2-\gamma_P(s)$ whenever the low-noise coupling has not already found
> a near-optimal concept.

This can be supplied by either of the following extra structures.

1. An efficiently sampleable distribution $\mu_P$ over proper concepts whose
   average prediction is pointwise balanced up to $o(\gamma_P)$ under $P$.
   Then random draws plus validation give a high-OPT fallback.
2. A validation-searchable weak cover: a polynomially searchable proper family
   such that every near-optimal $c^\star$ has a member within
   $1/2-\Omega(\gamma_P)$ in $L_1(P)$.

The source learner supplies neither object. It promises efficient decoding
from clean labels of the particular unknown concept, not efficient sampling of
balanced concepts and not searchable coverage of all possible clean label
traces. The depth-3 parity example already rules out a polynomial-size explicit
cover in general; depth 4 rules out getting a balanced sampler from black-box
clean behavior.

There is also a small caution: "output error $\leq 1/2$" is only a sufficient
neutralizer condition, not a necessary one. A one-concept class trivially
satisfies the weak agnostic proper target by always outputting its only concept,
even though that concept may have error above $1/2$ on adversarial labels. So a
positive theorem should not be phrased as "every source class has a
$1/2$-baseline." The needed object is weaker and relative to
$\operatorname{OPT}$, but it is still a genuine proper selection problem.

### Counterexample Stress Tests

**Parities and oriented parities.** Linear parities under the uniform marginal
still show that small proper covers are impossible, but they are not a false
witness. Uniform random parities are an efficient nearly pointwise-balanced
sampler, and oriented parity subfamilies are balanced except on negligible
subspaces under the usual uniform marginal. If the noise is below the chosen
gap, the clean-transcript coupling applies; if it is above the gap, random
balanced handles and validation are enough for the weak additive guarantee.

Adversarially placing the noise can make any fixed anchor slightly
anti-correlated, but it does not defeat the efficient balanced sampler. This is
the cleanest example showing why the missing object is not a cover but a
searchable neutralizer or sampler.

**Code and noisy-decoding ideas.** A code-based false witness would need easy
clean decoding from random coordinates but hard inverse-polynomial correlation
decoding from noisy coordinates. The problem is the weak threshold. If wrong
codewords are only uncorrelated with the target, they become legal weak handles
as soon as the target gap is chosen below the noise. If every wrong codeword is
more than $1/2+\tau$ away from the target, Plotkin-type bounds rule out
exponentially many binary codewords for inverse-polynomial $\tau$ on one
shared coordinate space. If some wrong codewords have mild positive
correlation, those codewords are themselves weak handles unless every such
handle decodes the hard witness.

This leaves a possible but very specific negative target: a representation in
which every efficiently findable weak handle carries enough information to
solve the hard problem. I did not find such a construction.

**Monomial and halfspace weak hardness.** The Feldman-Guruswami-Raghavendra-Wu
monomial/halfspace result has exactly the right distribution-free weak flavor:
even when a monomial agrees with almost all examples, finding a halfspace with
nontrivial advantage is NP-hard. But the hard distribution is generated by a
Label-Cover instance; it is not a single fixed marginal with the instance only
in the conditional labels. This is the same obstruction as the PCP active-slice
route: a marginal-nonuniform learner may have a polynomial and a weak gap that
depend on the instance-coded marginal.

Tiegel's halfspace theorem also remains a near miss. The distribution-free
weak lower bound rules out ordinary weak agnostic learning, while the
distribution-specific Gaussian part is a strong excess-error lower bound. I do
not see a step from that fixed Gaussian strong lower bound to failure of the
much weaker additive target
$\operatorname{OPT}+1/2-\gamma_P(s)$.

**One-way image-coordinate classes.** The strong proper fixed-marginal
inversion argument still does not become weak. With the usual all-length
marginal, low-mass blocks can be ignored, and the weak-handle variant shows
explicitly how constants or singleton-like handles make weak proper learning
easy while preserving strong proper hardness. Removing the handles restores
strong hardness but does not explain why every weakly legal proper output must
recover a preimage.

### Why This Still Does Not Resolve The Edge

The positive route lacks a theorem deriving a fixed-$P$ proper neutralizer from
clean realizable proper learning. The negative route lacks a class where clean
proper learning is easy but every efficient fixed-marginal weak proper selector
is hard.

The live literature check did not change that balance. The closest primary
results remain:

- Tiegel 2023, halfspace agnostic hardness:
  https://proceedings.mlr.press/v195/tiegel23a.html
- Hanneke-Moran-Thiessen 2025/2026 marginal-nonuniform PAC trichotomy:
  https://openreview.net/forum?id=aoVCFtox89
- Feldman-Guruswami-Raghavendra-Wu, monomial/halfspace weak agnostic hardness:
  https://arxiv.org/abs/1012.0729
- Feldman, distribution-specific agnostic boosting:
  https://vtaly.net/papers/F_AgnosticBoosting_111609.pdf

These support the existing atlas diagnosis but do not supply the missing
fixed-marginal proper weak selector or a counterexample to it.

### Proposed Atlas Update

No status change is justified. If the edge note is refreshed, I would keep the
status open and sharpen the summary along these lines:

```yaml
summary: "Open: the weak gap can be chosen below the fixed-marginal clean-transcript scale, but the remaining middle-noise regime still requires an efficient proper neutralizer or weak selector; realizable proper learning supplies clean decoding, not balanced proper sampling, and known weak-hardness results either vary the marginal or prove only strong fixed-marginal lower bounds."
```

I would not add a witness or assumption from this pass.

### Depth-6 Directions And Obstacles

1. **Fixed-marginal FGRW audit.** Check whether any monomial/halfspace weak
   hardness theorem can be recast with one universal marginal and all instance
   information placed in the conditional labels. The apparent obstacle is that
   the Label-Cover structure affects the example marginal, not only the labels.

2. **Wrong-output usefulness gadget.** Search for a label-cover or coding
   gadget where every proper hypothesis satisfying the weak additive bound
   decodes a proof/witness. This is weaker than making all wrong concepts
   pairwise farther than $1/2+\tau$, and may avoid the Plotkin barrier.

3. **Handle dichotomy lemma.** Try to prove that broad families with
   efficiently sampleable syntactic representations automatically have a
   fixed-$P$ weak neutralizer. Such a lemma would explain why parity, random
   code, and weak-handle constructions keep failing as counterexamples.

4. **Oracle barrier only as barrier.** Formalize the black-box fact that a
   realizable learner's off-realizable transcripts can hide all useful
   candidates. This would not refute the edge, because the target learner may
   use representation structure directly, but it would prevent accidental
   black-box "proofs" of the neutralizer.

5. **Restricted positive theorem.** Record separately that the edge is true for
   classes with constants, complement-plus-anchor structure, an efficiently
   sampleable balanced proper distribution, or a validation-searchable
   fixed-$P$ weak cover. None of these structures follows from the abstract
   source node.

verdict: unresolved-open
confidence: medium-high

---

## Depth-6 Final Pass: Fixed-Marginal Weak-Selector Audit

- depth: 6
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved-open
- confidence: high that the atlas edge should remain open; medium-high that the standard counterexample templates are genuinely blocked in this formulation

### Focus

This final pass pushed on the three remaining directions from depth 5:
fixed-marginal FGRW-style hardness, wrong-output-usefulness gadgets, and a
handle/neutralizer dichotomy. I did not find an atlas-ready proof or
separation.

The final obstruction is now quite sharp. The marginal-preserving low-noise
coupling gives proper hypotheses when
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the fixed-$P$
transcript scale. The unresolved middle-noise regime still needs a proper
neutralizer: a way, under the same fixed marginal, to find a concept with
error at most $1/2$ or otherwise within
$\operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s)$. The source gives clean
proper decoding, not such a label-neutral object.

### Final Positive Attempt

Let $m_P(s)$ be the $P$-dependent sample/time bound for a constant-accuracy
realizable run. Choose $\alpha_P(s)\ll 1/m_P(s)$ and then choose the target
weak gap $\gamma_P(s)\ll\alpha_P(s)$. If
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, the existing
coupling compares the noisy run to a clean run for a near-optimal concept
using the original $P$-distributed instance sequence. A no-corruption
transcript occurs with inverse-polynomial probability, the source learner
returns a proper concept, and validation finds it.

If $\eta\ge\alpha_P(s)$, a proper concept of label error at most $1/2$ would
suffice, since
$$
1/2\le \eta+1/2-\gamma_P(s).
$$
This is exactly what the better constant classifier supplies in the improper
sibling proof. But arbitrary proper classes need not contain constants,
complements, a balanced sampler, a projection oracle, or a searchable weak
cover. Running the source learner on inconsistent labels gives no guarantee,
and its off-realizable behavior can hide all useful candidates.

A conditional positive lemma is worth recording separately: low-noise coupling
plus any efficiently validation-searchable fixed-$P$ proper neutralizer proves
the edge. This includes classes with both constants, complement-plus-anchor
structure, pointwise balanced proper samplers, or polynomially searchable
fixed-$P$ weak covers. None of these follows from the source node itself.

### Fixed-Marginal FGRW/PCP Audit

Feldman-Guruswami-Raghavendra-Wu give the right weak-hardness flavor:
distribution-free weak agnostic learning of monomials is hard even with
halfspace outputs. The reduction, however, puts Label-Cover/dictatorship-test
structure into the example distribution. Recasting it with one universal
marginal runs into the same blockers as PCP active slices.

Using only shared verifier randomness makes unrelated satisfiable instances
into proper weak handles: a learner can output a proof for an easy satisfiable
instance rather than solve the target instance. Adding an instance identity to
the domain restores hardness but makes the marginal instance-dependent.
Packing all identities into one fixed marginal dilutes each slice, so the weak
additive tolerance can ignore low-mass hard instances.

Coded identity under one marginal also fails at the hidden-gap scale. To make
all useless wrong instances non-handles, the code needs exact nonpositive
correlation for exponentially many identities or residual correlations below
the unknown inverse-polynomial $\gamma_P(s)$. The first demand is in the
Plotkin/Hadamard regime; the second either makes the coordinate domain too
large for the desired efficient source or leaves merely inverse-polynomial
wrong-output correlations, which may exceed the learner's hidden gap.

### Wrong-Output-Usefulness Audit

The most plausible false witness would not make every wrong concept
anti-correlated. It would instead ensure that every weakly legal wrong output
decodes the hard witness.

The natural address/payload construction still leaks handles. A clean address
region can reveal a seed or witness, making realizable proper learning easy.
If an agnostic distribution corrupts that address with mass $q$, then
$\operatorname{OPT}\approx q$. Once the target gap is chosen below $q$, an
unrelated pseudorandom-looking proper concept with payload error about $1/2$
is already within
$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s).
$$
To force recovery, the payload must make every useless output worse than
random or make every useful output reveal the witness. The former is blocked
for exponentially many binary concepts by Plotkin-style geometry; the latter
is the missing wrong-output-usefulness gadget. I found no PCP, code,
one-way-function, monomial, conjunction, or halfspace construction with this
property under one fixed marginal while retaining efficient realizable proper
learning.

### Handle/Neutralizer Dichotomy

The failed witnesses suggest a useful but still informal dichotomy.

In the handle-rich case, the class has constants, complements, unrelated
satisfiable proofs, singleton handles, random balanced concepts, or an
efficiently sampleable syntactic family with near-zero pointwise mean. Then
validation usually gives a proper middle-noise neutralizer, and the low-noise
branch handles the rest.

In the handle-poor case, the construction removes those outputs by forcing a
proper hypothesis to identify the hard instance or witness. Then clean proper
learning becomes hard unless the identity is exposed on a clean address or
slice. Exposing it either makes the marginal instance-dependent or lets
agnostic corruption of the address reopen the weak-handle problem on the
payload.

This is a barrier, not a theorem. A formal handle dichotomy, or a genuine
wrong-output-usefulness gadget escaping it, would be the most valuable next
step.

### Atlas-Ready Unresolved Summary

No atlas status change is justified. I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
summary: "Open: marginal-preserving low-noise coupling gives proper weak agnostic hypotheses below the fixed-marginal transcript scale, but the remaining middle-noise regime requires an efficient proper neutralizer or weak selector; known FGRW/PCP, code, one-way, conjunction, and halfspace hardness routes either put the hard instance in the marginal, leave weak handles, or prove only strong fixed-marginal lower bounds."
```

Suggested body:

```markdown
The low-noise branch is understood: couple a noisy run to a clean realizable
run for a near-optimal concept using the same original marginal $P$. This
returns a proper concept when $\operatorname{OPT}_{\mathcal C}$ is below the
fixed-$P$ transcript scale.

The middle-noise branch remains open. The improper proof uses constants, but
constants need not be proper. A positive proof would need a fixed-marginal
proper neutralizer, balanced sampler, weak cover, or selector; clean realizable
proper learning does not imply any of these computational objects. Known
counterexamples remain near misses because they vary the marginal, leak weak
handles, or only prove strong excess-error hardness.
```

### Best Future Directions

1. Prove restricted positive neutralizer lemmas for constants, complements,
   balanced proper samplers, and validation-searchable fixed-$P$ weak covers.
2. Formalize the handle-rich/handle-poor dichotomy as a barrier lemma for
   syntactically sampleable concept families.
3. Search specifically for a wrong-output-usefulness gadget under one fixed
   marginal: every weakly legal proper hypothesis should decode a hard witness,
   while clean labels still allow efficient proper learning.
4. Revisit FGRW/Label-Cover only if instance identity can be encoded without
   input-dependent marginal mass and without unrelated satisfiable handles.

### References Checked In This Final Pass

- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by Halfspaces is Hard": https://arxiv.org/abs/1012.0729
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems": https://proceedings.mlr.press/v195/tiegel23a.html
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability": https://openreview.net/forum?id=aoVCFtox89

verdict: unresolved-open
confidence: high
