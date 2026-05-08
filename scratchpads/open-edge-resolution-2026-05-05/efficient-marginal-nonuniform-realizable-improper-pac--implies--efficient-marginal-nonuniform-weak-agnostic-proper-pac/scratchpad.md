# Edge: efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Context

The assigned edge asks whether
[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]
implies
[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]].

The source gives one uniform learner $A$ that, for each fixed instance marginal
$P$, has a $P$-dependent polynomial sample/time bound in the realizable case
and may output hypotheses outside $\mathcal C$. The target asks for one uniform
learner that, for each fixed $P$, outputs $h\in\mathcal C$ and satisfies
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
\qquad
\beta_P(s)=1/2-\gamma_P(s),
$$
where $\gamma_P(s)$ is inverse-polynomial under a $P$-dependent polynomial.

The already-checked sibling edge

`efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`

is resolvable as true by the
[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]
coupling argument: on low-noise agnostic data, compare the noisy run of the
realizable learner to a realizable run using the same $P$-distributed instance
sequence. That proof preserves the original marginal and therefore preserves the
$P$-dependent resource polynomial. However, it keeps the learner improper. The
assigned edge adds exactly the properization demand.

The current edge note places the edge under
[[properization-open|Properization Open]], and that diagnosis still looks right
after this pass.

## Attempted Resolution

### Positive Route: Low-Noise Robustification Plus Projection

The low-noise coupling gives an efficient marginal-nonuniform weak agnostic
improper learner. More explicitly, for a fixed marginal $P$, run the realizable
improper learner at constant accuracy and let $m_P(s)$ bound this invocation.
Set $\gamma_P(s)$ below $1/m_P(s)$. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is not tiny, a constant classifier
is already within the weak additive tolerance. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is tiny, coupling the noisy run to
the clean run under the same marginal $P$ yields, with inverse-polynomial
probability, a hypothesis with constant error against a near-optimal concept.
Repetition and validation give the weak agnostic improper target.

The missing step is projection back into $\mathcal C$. The source output may be
an arbitrary external hypothesis. Sample-only properization does not solve the
computational problem: finite VC theory and unbounded ERM can show that good
proper hypotheses exist, but the target requires a polynomial-time procedure
for finding one, and marginal-nonuniformity does not supply $P$-specific advice
or an efficient proper ERM oracle.

I do not see a generic way to turn the improper candidate into even an
inverse-polynomially weak proper concept under the fixed marginal.

### Counterexample Route: PCP Active-Slice Weak Proper Hardness

The [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
argument has the right local shape for weak proper hardness. The class is
efficiently learnable by an improper memorization or one-slice lookup-table ERM,
while a weak proper learner on the active slice of an NP instance would decide
an NP-complete language.

The obstacle is marginal nonuniformity. The hardness reduction chooses the
marginal concentrated on the active slice of the input instance $\varphi$. A
marginal-nonuniform learner may have a polynomial $p_{P_\varphi}$ depending on
that whole slice marginal. Thus the reduction would not get a runtime bound
polynomial uniformly in $|\varphi|$; the dependence on $P_\varphi$ can hide
instance-specific search cost.

Packing all active slices into one fixed marginal also fails naively. Once a
slice has small mass, the constant PCP gap is multiplied by that mass. Since the
target's weak tolerance is close to $1/2$, low-mass hard slices can be ignored.
A single fixed marginal cannot assign constant mass to all infinitely many
input-instance slices.

### Counterexample Route: Clause-Satisfaction Fixed Marginal

The [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
argument is important because it can encode the formula in labels under a fixed
uniform clause marginal. This resolves strong proper targets: running to
accuracy on the order of one clause mass forces recovery of a satisfying
assignment.

It does not resolve this weak edge. Under the uniform clause marginal, the
satisfiable/unsatisfiable gap contributed by one violated clause is
$1/|X_n|$. The target permits additive error almost $1/2$, only requiring some
unknown inverse-polynomial advantage. A weak proper learner need not find an
assignment satisfying all clauses or close enough to certify satisfiability.
Low-noise padding does not change the additive-tolerance issue: to force a
specific clause decision, each relevant clause would have to carry near-constant
mass, impossible for polynomially many clauses under one fixed marginal.

### Counterexample Route: One-Way Image Coordinate Hardness

The [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
witness separates strong marginal-nonuniform proper learning from improper
learning under length-preserving one-way functions. Its fixed all-length
marginal makes accuracy
$\varepsilon_n=\mu_n/(3n)$ force recovery of a seed preimage.

The assigned target is weak, so this accuracy demand disappears. Under the
usual coordinate marginal, wrong-length or wrong-image proper concepts can have
small global error simply because the hard length-$n$ block has mass
$\mu_n=O(1/n^2)$. Such hypotheses can satisfy a weak
$1/2-\gamma_P(n)$ guarantee without recovering the one-way challenge.

Dense-code variants would need every wrong proper hypothesis to have correlation
below the unknown inverse-polynomial $\gamma_P(s)$. Polynomial-length codes
leave inverse-polynomial residual correlations, while Hadamard-style orthogonal
codes make the source-side improper agnostic learner look like agnostic parity
or else make the domain explicit and exponentially large. I found no existing
atlas witness that avoids this tradeoff.

## Proposed Atlas Update

No resolved atlas update proposed.

If the atlas edge is refreshed, keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: low-noise robustification gives a marginal-nonuniform weak agnostic improper learner, but no generic efficient projection to a proper hypothesis is known; current PCP, clause-satisfaction, and one-way witnesses do not refute the marginal-nonuniform weak target."
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested replacement body sketch:

```markdown
## Verdict

`open`.

The realizable marginal-nonuniform improper source can be robustified to a weak
agnostic improper learner by the marginal-preserving low-noise coupling, but the
target requires output in $\mathcal C$.

**Positive route.** The low-noise argument runs the realizable learner on noisy
samples and compares it to a clean realizable run using the same original
$P$-distributed instance sequence. This preserves the $P$-dependent polynomial
bound and gives an improper weak agnostic hypothesis. No general polynomial-time
projection from that external hypothesis to a member of $\mathcal C$ is known.

**Counterexample route.** The PCP active-slice witness gives weak proper
hardness only with an input-dependent marginal; marginal-nonuniform resource
bounds may depend on that marginal. Clause-satisfaction fixed-marginal
hardness gives strong-accuracy gaps of order one clause mass, which the weak
additive tolerance can absorb. The one-way image-coordinate witness forces exact
recovery only for strong accuracy; weak learners can use low-mass or
wrong-length handles. Thus the known separation templates do not settle the
edge.
```

## Obstacles

- The source-to-improper weak agnostic step is available, but it produces an
  external hypothesis and gives no efficient properization.
- Computational sample-only properization via ERM is not enough; the target
  needs a polynomial-time proper learner, not just existence of a good proper
  hypothesis.
- PCP active-slice hardness uses input-dependent marginals. Marginal-nonuniform
  polynomial bounds can depend on those marginals, so the reduction loses a
  uniform polynomial runtime.
- Fixed-marginal strong proper hardness examples have gaps too small for the
  weak additive target, or they allow weak handles that avoid solving the hard
  search problem.

## Next Directions

1. Search for a fixed-marginal PCP or label-cover construction where the input
   changes labels on constant mass, satisfiable instances have proper witnesses,
   and unrelated proper hypotheses are near-random rather than weak handles.
2. Look for a dense cryptographic code class with efficient improper agnostic
   learning under arbitrary distributions but with every weakly correlated
   proper hypothesis yielding a preimage. Existing sparse coordinate and
   Hadamard extremes each miss one requirement.
3. Investigate conditional positive results: for fixed marginals whose
   polynomial-sample trace of $\mathcal C$ has an efficiently searchable weak
   cover, the low-noise improper learner might be projectable. This would not
   resolve the atlas edge globally, but it would isolate the missing structure.
4. Audit whether any primary source proves weak properization from improper PAC
   learners under representation restrictions compatible with the atlas model.

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- [[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]
- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- Valiant 1984 and Blumer et al. 1989 as cited by the low-noise and clause-satisfaction notes
- Håstad and Khot 2005 and Karp 1972 as cited by the PCP active-slice note
- Kearns and Valiant 1994 and Håstad et al. 1999 as cited by the one-way-function note

---

# Depth-2 Follow-Up: Projection Gap And Fixed-Marginal Selector Hardness

- depth: 2
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Focus Question

Can the low-noise robustification for the improper sibling edge be made proper
under the marginal-nonuniform quantifiers? If not, can one prove a separation by
building a fixed-marginal weak proper selector problem: the realizable improper
source is easy, but any proper weak agnostic learner must select a hard proper
certificate from noisy labels under one fixed marginal?

My depth-2 answer is still `unresolved`. The positive projection route appears
to need an extra oracle-like operation not supplied by the source. The negative
selector route has the right computational shape, but current fixed-marginal
templates either lose the weak signal or create easy wrong proper handles.

## Attempted Positive Route: Properizing The Low-Noise Robustification

The marginal-preserving low-noise proof for the improper target is solid. Fix
$P$, let $A$ be the realizable improper learner, and choose
$\alpha_P(s)$ below the inverse of the constant-accuracy runtime/sample bound
of $A$. On agnostic distributions with
$\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, a noisy run of $A$
couples to a realizable run against a near-optimal $c^\star\in\mathcal C$ with
constant probability. Validation then finds an external hypothesis $g$ with
weak agnostic error.

The tempting projection subroutine is:

**Input:** samples from the same fixed marginal $P$, labels from
$\mathcal D$, and perhaps oracle access to the improper predictor $g$.

**Goal:** output $h\in\mathcal C$ with
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s).
$$

The source learner gives no such subroutine. It only promises that when labels
are exactly realizable by some concept, an external predictor with small error
can be found. Running the source learner on pseudo-labels $g(X)$ does not help:
$g$ need not be close to any concept in $\mathcal C$ in a realizable sense, and
even if a closest concept exists statistically, finding it is a proper ERM or
proper weak-approximation problem over $\mathcal C$.

Marginal nonuniformity weakens resource bounds but does not give advice. For a
fixed $P$, one may allow a $P$-dependent polynomial, yet the algorithm must
still be the same uniform learner and cannot receive a representation of a
$P$-specific search tree, cover, or ERM procedure. Thus the usual sample-only
argument, "a good proper hypothesis exists on a large enough sample," does not
become a computational projection theorem.

One possible conditional positive statement is visible but too narrow for the
atlas edge:

> If for every fixed marginal $P$ the polynomial-size sample traces of
> $\mathcal C$ admit an efficiently searchable weak cover, then the low-noise
> improper robustification can be followed by validation over that cover to
> return a proper weak hypothesis.

This isolates the missing structure rather than resolving the implication. The
source node does not imply such a searchable trace cover.

## Attempted Negative Route: Fixed-Marginal Weak Proper Selectors

A separation should avoid the active-slice problem by fixing one marginal
$P^\star$ once and for all, and encoding the hard instance only in the label
conditional. The target learner would then be forced to solve a selector
problem under $P^\star$: among many proper certificates, return one weakly
correlated with the current label pattern. The source could still hold if an
improper learner can ignore the representation constraint and learn by lookup,
sparse ERM, or another tractable relaxation.

This route clarifies the needed lower-bound geometry. For each hard challenge
$z$, let $Y_z$ be the label pattern under $P^\star$, and let proper hypotheses
be certificate vectors $C_a$. A weak proper learner may return any $C_a$ whose
error is below roughly $1/2$ by the hidden gap $\gamma_{P^\star}(s)$. Therefore
a wrong certificate is harmless only if either:

1. it can itself be converted into a valid witness for $z$; or
2. it has correlation at most the hidden weak gap with $Y_z$.

The second condition is nearly an orthogonality requirement, because the hidden
gap may be $s^{-k}$ for an arbitrarily large constant $k$ depending on the
fixed marginal and the alleged learner. Polynomial-length small-bias or
ordinary error-correcting codes leave inverse-polynomial residual correlations
at some scale. That scale may still be larger than the learner's weak advantage,
so a wrong codeword can become a legal weak output. Hadamard-style encodings
remove this problem, but they make the coordinate domain exponential or move the
source-side improper learner into agnostic parity/noisy-codeword decoding rather
than lookup-style learning.

The PCP and clause templates fit the same selector diagnosis:

- Active-slice PCP gives constant weak proper hardness only because the input
  slice has essentially all the mass. Once all slices are packed into one fixed
  marginal, every individual hard slice has low mass and can be ignored by a
  weak learner.
- Clause-satisfaction with a fixed uniform clause marginal encodes the formula
  in labels, which is exactly what we want, but a single violated clause changes
  error by only $1/|X_n|$. The weak additive tolerance can absorb this unless an
  amplification makes each decisive violation cost constant mass.
- A fixed-marginal PCP whose input is encoded in labels would still need to
  prevent unrelated satisfiable formulas with good proofs from being weak
  handles. Protecting formula identity against exponentially many formulas
  again looks like the shared-code orthogonality bottleneck.

Thus a fixed-marginal weak selector hardness result remains plausible only with
a new ingredient: either a selector problem where every weakly good wrong output
is also useful for solving the hard instance, or a dense shared-coordinate
encoding whose improper agnostic relaxation remains polynomial-time learnable.

## Depth-2 Verdict

No resolved atlas update proposed.

Keep the edge open:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested refined summary:

> Open: low-noise robustification gives a marginal-preserving weak agnostic
> improper learner, but making it proper would require an efficient
> fixed-marginal projection or weak proper ERM not implied by the source.
> Fixed-marginal selector-hardness templates explain the possible separation,
> but current PCP, clause, and code witnesses either lose the weak signal or
> admit wrong proper weak handles.

## Next Directions

1. **Searchable-trace positive lemma.** Formalize the conditional theorem: if
   every fixed marginal $P$ has a marginal-dependent polynomial-time searchable
   weak cover for traces of $\mathcal C$, then low-noise robustification plus
   validation yields the target. This would identify the exact projection
   property missing from the source.

2. **Selector-hardness template.** Define an abstract fixed-marginal selector
   witness with label patterns $Y_z$, certificate concepts $C_a$, and an
   improper relaxation $\mathcal H$ that is efficiently agnostically learnable.
   Prove which metric conditions on $(Y_z,C_a)$ force weak proper hardness.

3. **Wrong-output usefulness.** Look for cryptographic or PCP selectors where
   any proper concept with inverse-polynomial correlation to $Y_z$, even if not
   the intended certificate, can still be decoded into a witness for $z$. This
   would avoid needing pairwise near-orthogonality against all wrong concepts.

4. **Fixed-marginal label-PCP.** Investigate label-cover/PCP constructions in
   which the instance is carried by labels under a shared coordinate marginal,
   while unrelated satisfiable instances are made near-random rather than
   usable weak handles.

5. **Agnostic-relaxation search.** For dense code routes, search for a tractable
   improper relaxation richer than the proper codewords but easier than
   agnostic parity. Without this, Hadamard-like proper hardness destroys the
   source-side efficient improper learner.

## Additional References Checked

- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

---

## Depth-3 Follow-Up: Fixed-Marginal Projection And Weak-Agnostic Selectors

- depth: 3
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

### Focus

This pass pushed on the two remaining live questions.

First, after the marginal-preserving low-noise robustification gives an
improper weak agnostic predictor, can one recover a proper weak hypothesis by
projection, validation, or weak ERM under the same fixed marginal?

Second, if not, can a fixed-marginal selector hardness construction be made
weak-agnostic, so that any proper weak output under one marginal solves a hard
search problem?

My depth-3 verdict is still `unresolved`. The positive route becomes true after
adding a fixed-marginal proper weak ERM or trace-selector oracle, but that
oracle is not implied by the realizable improper source. The negative route has
a clearer target condition now, but the known selector witnesses do not make
that condition hold for agnostic weak learning under one marginal.

### Projection After Low-Noise Robustification

Fix a marginal $P$ and a joint distribution $\mathcal D$ with
$\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta$. The improper sibling edge
is handled as follows: if $\eta$ is not very small, a constant classifier is
already within the weak agnostic tolerance; if $\eta$ is tiny, run the
realizable improper learner on noisy samples and couple its transcript to a
clean realizable run for a near-optimal $c^\star\in\mathcal C$. This produces
an external predictor $g$ with

$$
\operatorname{err}_{\mathcal D}(g)
\le
\eta + O(1)
<
\eta + 1/2-\gamma_P(s)
$$

for some inverse-polynomial $\gamma_P$ determined by the fixed $P$-dependent
sample bound.

The proper target would need one more operation:

$$
\text{external } g \text{ weakly useful for } c^\star
\quad\Longrightarrow\quad
\text{find } h\in\mathcal C \text{ weakly useful for } \mathcal D .
$$

There are two natural ways to try this, and both assume the missing selector.

1. **Project the external predictor.** Draw a sample from $P$, label it by
   $g$, and search for $h\in\mathcal C$ that agrees with $g$ on the trace. But
   $g$ need not be realizable by $\mathcal C$, and even finding a concept with
   positive correlation to $g$ is an approximate proper ERM problem over
   $\mathcal C$.

2. **Ignore $g$ and weakly ERM on the original noisy labels.** When
   $\eta$ is small, $c^\star$ itself is a very good proper comparator, so any
   proper weak ERM routine under $P$ would suffice. But this routine is exactly
   what the target asks us to construct in the low-OPT regime.

This gives a useful conditional lemma but not a proof of the edge:

> If for every fixed marginal $P$ there is a marginal-dependent polynomial-time
> procedure that, from samples labeled by any joint distribution with marginal
> $P$, outputs $h\in\mathcal C$ whenever some concept has low error and achieves
> error at most $1/2-\gamma_P(s)$ for an inverse-polynomial $\gamma_P$, then
> the assigned edge follows by combining that routine with constants for the
> high-OPT case.

The point is that the realizable improper learner is doing little in this
conditional statement. Once a proper weak ERM or proper trace selector exists,
the low-OPT agnostic case is already solvable by that selector. Conversely, the
source learner can output lookup tables, sparse external hypotheses, votes, or
other representations that give no efficient map back into $\mathcal C$.
Marginal nonuniformity permits $P$-dependent polynomial rates; it does not give
$P$-dependent advice or a target-uniform map from traces to proper
representations.

### Why Validation Does Not Supply The Selector

Validation can choose among candidates already generated. It cannot create a
proper representation. To use validation after low-noise robustification, the
algorithm would need a polynomial list

$$
L(S,g)\subseteq \mathcal C
$$

such that whenever $g$ is close to some $c^\star\in\mathcal C$ under $P$, at
least one $h\in L(S,g)$ has inverse-polynomial positive correlation with the
labels. No representation-independent construction of such a list is supplied
by the source.

Finite trace bounds also stop at existence. On a polynomial sample there may
be a realizable proper trace, but selecting any weakly good representative can
be computationally hard. This is the same distinction recorded in
[[properization-open|Properization Open]]: the sample-efficient layer may use
unbounded ERM, while the efficient layer needs an actual algorithm for proper
search.

### Fixed-Marginal Weak-Agnostic Selector Hardness

A false witness should fix one marginal $P^\star$ and encode the hard instance
only in the conditional labels. For each challenge $z$, let
$\mathcal D_z$ have marginal $P^\star$ and low optimum because some certificate
concept $c_{a(z)}\in\mathcal C$ fits the labels. The desired lower bound is not
ordinary exact proper recovery. It must say:

> Every proper $h\in\mathcal C$ satisfying
> $$
> \operatorname{err}_{\mathcal D_z}(h)
> \le
> \operatorname{OPT}_{\mathcal C}(\mathcal D_z)+1/2-\gamma(s)
> $$
> for any relevant inverse-polynomial $\gamma$ can be decoded into a witness
> for $z$.

This is stronger than strong proper hardness. It rules out all wrong proper
weak handles, not just high-accuracy wrong hypotheses. It also has to survive
the agnostic additive term: if neutral or non-input regions raise
$\operatorname{OPT}$, then the bound can become too permissive to force any
certificate information.

The checked templates still miss this requirement.

- **PCP active slices.** On the active slice of one formula, weak proper
  learning selects a good proof. Under one fixed marginal, however, each
  formula slice gets small mass, so the weak advantage is diluted. If labels
  instead carry the formula under shared coordinates, unrelated satisfiable
  formulas become proper weak handles unless formula identity is protected with
  near-orthogonal encoding.

- **Clause-satisfaction fixed marginal.** This correctly puts the formula in
  labels under a fixed clause marginal, but the satisfiable/unsatisfiable gap is
  an inverse-polynomial strong-accuracy gap. The weak agnostic additive
  tolerance can absorb it, especially once fair-noise regions are used to make
  non-formula clauses harmless.

- **One-way image coordinates.** Sparse coordinates preserve efficient
  improper learning, but weak proper outputs can ignore low-mass hard blocks or
  use wrong-length handles. Dense encodings can make every wrong seed nearly
  uncorrelated, but exact weak-safety pushes toward Hadamard/parity geometry,
  where the source-side learner becomes a noisy-codeword or agnostic-parity
  learner rather than a simple improper memorizer.

So the right negative object is a fixed-marginal **weak-agnostic selector**:
low $\operatorname{OPT}$ for yes/challenge labelings, efficient improper
learning by a tractable relaxation, and a guarantee that every proper concept
with any inverse-polynomial advantage decodes a hard witness. I did not find
such an object in the existing notes.

### Depth-3 Verdict

No atlas status change is justified. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Refined summary:

> Open: marginal-preserving low-noise robustification gives an improper weak
> agnostic predictor, but converting it to a proper hypothesis is exactly a
> fixed-marginal proper weak ERM/trace-selection problem. A counterexample
> would need one fixed marginal where every proper weak-agnostic output decodes
> a hard selector witness; existing PCP, clause, and one-way templates still
> fall short.

### Next Directions

1. **State the selector lemma precisely.** Define a fixed-$P$ weak proper ERM
   oracle with input samples from $\mathcal D$ and output $h\in\mathcal C$ when
   $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the low-noise
   threshold. Prove formally that this oracle plus constants implies the
   target, and note that the source learner is not enough to implement it.

2. **Separate projection from robustification.** Write the low-noise proof as
   producing only a candidate external predictor $g$, then formulate the exact
   projection/list condition needed to turn $g$ into a proper weak hypothesis.
   This may become a reusable obstruction paragraph for other
   `properization-open` marginal edges.

3. **Search for fixed-marginal weak-agnostic selector lower bounds.** Look for
   hardness results where any hypothesis with inverse-polynomial correlation,
   not merely any near-optimal or exact-ERM hypothesis, yields a witness. The
   lower bound must keep $\operatorname{OPT}$ low so that weak agnostic
   additivity does not wash out the signal.

4. **Test dense relaxations, not just dense codes.** The promising false route
   needs a balanced shared-coordinate encoding with no wrong weak handles and
   an improper relaxation that is still efficiently agnostically learnable. The
   key question is whether such a relaxation exists without becoming agnostic
   parity/list-decoding in disguise.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

---

## Depth-4 Follow-Up: Proper High-OPT Fallbacks And Global Selector Geometry

- depth: 4
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

### Focus

This pass pushed the requested fixed-marginal proper weak ERM / trace-selector
obstruction one level further.

There are two separable questions:

1. Can the marginal-preserving low-noise robustification for the improper
   sibling edge be made proper?
2. If not, can selector hardness be made weak-agnostic under one fixed marginal,
   so that every proper weak output must solve a hard representation problem?

I still do not have an atlas-ready resolution. The best update is a sharper
diagnosis: the proper agnostic target needs a proper selector not only in the
low-noise case, but also as the fallback in the medium/high-OPT case. The
improper robustification's fallback uses constants, and constants are not
available to a proper learner unless they are already in $\mathcal C$.

### Properizing Low-Noise Robustification

The improper sibling proof has the following structure. Fix a marginal $P$ and
let $m_P(s)$ be the sample/runtime bound for a constant-accuracy run of the
realizable improper learner. Choose a small inverse-polynomial
$\alpha_P(s)\ll 1/m_P(s)$.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, couple the noisy
run on $\mathcal D$ to a realizable run for a near-optimal
$c^\star\in\mathcal C$ using the same $P$-distributed instance sequence. With
inverse-polynomial probability the learner sees no corrupted labels, so it
returns an external predictor $g$ that is weakly useful for $\mathcal D$.

For the proper target this leaves the projection problem:

$$
\text{external weak predictor }g
\quad\Longrightarrow\quad
\text{find }h\in\mathcal C\text{ with weak agnostic error}.
$$

No step in the source promise implements this projection. Running the source
learner again on pseudo-labels from $g$ only gives another external predictor.
Searching for a concept that correlates with $g$ or with the original noisy
labels is exactly a fixed-marginal proper weak ERM problem over $\mathcal C$.

The additional point from this pass is that the high-OPT side is also not
proper for free. The improper low-noise proof handles
$\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge\alpha_P(s)$ by validating the
two constant classifiers, since one of them has error at most $1/2$. But the
target requires output in $\mathcal C$. Unless constants, complements, or some
other universal proper handles are part of $\mathcal C$, this fallback is not
legal. A proper weak agnostic learner therefore needs a selector that can find
a not-too-bad concept whenever the best concept is merely moderately good, not
only when labels are almost realizable.

A conditional positive statement is possible but tautological:

> If, for every fixed marginal $P$, there is one uniform polynomial-time
> procedure with $P$-dependent bounds that solves proper weak agnostic ERM over
> $\mathcal C$ to tolerance $1/2-\gamma_P(s)$, then the target holds.

This does not use the realizable improper source in a meaningful way. The
missing object is exactly the target-side proper trace selector.

### Trace-Selector Formulation

A useful abstraction is the following fixed-$P$ selector.

Input: a sample from a joint distribution $\mathcal D$ with marginal $P$, and
optionally a list of external candidates produced by the source learner.

Promise: there exists $c^\star\in\mathcal C$ with error
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$.

Goal: output $h\in\mathcal C$ such that

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta + \frac12-\gamma_P(s)
$$

for some inverse-polynomial $\gamma_P(s)$.

The source learner gives no algorithm for this selector. Finite trace or VC
arguments only say that a good proper trace exists on a large enough sample;
they do not say that a representation can be found in polynomial time. This is
the computational distinction between the sample-efficient layer and the
efficient layer.

The selector obstruction is especially sharp because the weak advantage is
hidden inside the existential $P$-dependent polynomial. To refute a proposed
proper learner, a counterexample must prevent all wrong proper hypotheses from
having any inverse-polynomial advantage at the scale the learner might choose.
It is not enough to make wrong concepts have small correlation like
$s^{-100}$: a legal weak learner could have advantage $s^{-200}$.

Thus a robust false witness needs one of two properties:

1. **Wrong-output usefulness.** Any proper concept with positive
   inverse-polynomial correlation can be decoded into a valid witness or
   preimage.
2. **Near-exact weak safety.** Every wrong proper concept has nonpositive, or
   superpolynomially small, correlation under the fixed marginal.

Current atlas witnesses have neither property at the needed fixed-marginal
weak-agnostic level.

### Fixed-Marginal Selector Hardness Attempts

#### PCP Active Slices

The active-slice PCP witness gives the right local weak proper hardness, but
only when the marginal is concentrated on the input-dependent slice. That is
not enough for the marginal-nonuniform target, since the polynomial bound may
depend on that slice marginal.

Packing all slices into one fixed marginal loses the weak signal. If a slice
has mass $w_\varphi$, a hypothesis that ignores the slice pays only
$O(w_\varphi)$ global error. For the agnostic weak target, this is fatal even
when $w_\varphi$ is inverse-polynomial unless the rest of the distribution
forces a meaningful comparison inside the slice. With exponentially many
formula slices at a length, no fixed marginal can give all of them large enough
mass to make the local PCP gap globally unavoidable.

Adding an easy global balancing region also leaks. If the balancing labels are
simple enough for an improper learner to exploit under arbitrary marginals,
then off-slice proper concepts, default-like proper concepts, or any proper
concept sharing the common labels tend to become legal weak handles. If the
balancing labels are proof-dependent enough to block those handles, the source
side stops being easy.

#### Clause-Satisfaction Under One Marginal

The fixed uniform clause marginal correctly puts the hard formula into labels
rather than into the marginal. This is the right quantifier shape. But the
gap from one violated clause is only $1/|X_n|$, and the weak agnostic target
allows additive error nearly $1/2$. Low-noise padding preserves the same
additive issue: unless each decisive clause has near-constant marginal mass,
weak proper output need not certify satisfiability.

Sampler or direct-product amplification would need to make every bad
assignment lose constant mass while keeping the domain and improper learner
polynomial. The known way to get constant soundness with polynomially many
tests is PCP machinery, and the existing active-slice implementation returns
to the slice-packing problem above.

#### One-Way Image Codes

The sparse image-coordinate class proves strong fixed-marginal proper hardness,
but weak learners can ignore the low-mass length block or use wrong-length
handles. A balanced Hadamard-style image code is the natural repair:

$$
c_s(a)=\langle f(s),a\rangle \pmod 2.
$$

At a single fixed length with uniform $a\in\{0,1\}^n$, realizable improper
learning is easy by linear algebra on the image vector $y=f(s)$, while any
proper concept with nonzero advantage must output a seed $t$ with $f(t)=y$.
This cleanly separates improper prediction from proper representation recovery
in a length-specific fixed-distribution model.

It still does not settle the atlas edge. If the hard marginal is $P_n$ for
each length $n$, the marginal-dependent runtime polynomial may depend on
$P_n$ and therefore on $n$, so the inversion reduction does not get one
uniform polynomial bound. If all lengths are packed into one finite-string
marginal, the length-$n$ balanced block has tail mass $\mu_n$, and the weak
advantage can again ignore it.

The only apparent way to get exact orthogonality for all target sizes under
one marginal is to use a common infinite random source, such as Walsh
characters on an infinite product space. That would make distinct proper image
codes disagree on exactly half the marginal for every length. But the atlas
efficiency convention is explicitly worst-case/pathwise over finite encoded
sample transcripts. Infinite-bit examples would step outside that model. Once
examples are finite strings, the probability of seeing enough fresh coordinates
to distinguish length-$n$ messages is a tail event, and tail mass reintroduces
the weak-dilution obstruction.

So the balanced-code route is not dead in spirit, but an atlas-valid version
needs a finitely encoded, all-length, fixed marginal with near-exact
orthogonality and an efficient realizable improper learner. I do not know such
a construction.

### Proposed Atlas Metadata And Body

No status change is justified.

Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Possible refreshed summary:

> Open: marginal-preserving low-noise robustification gives only an improper
> predictor, and its high-OPT fallback uses improper constants. A proper target
> would need a fixed-marginal proper weak agnostic trace selector. Current PCP,
> clause, and one-way selector templates either vary the marginal, lose the
> weak signal under one marginal, or require non-finite/too-dense code geometry.

Possible body addition:

```markdown
The improper low-noise robustification does not properize automatically. In
the low-OPT case it returns an external predictor and supplies no efficient
projection into $\mathcal C$. In the high-OPT case it relies on constant
classifiers, which are not legal outputs for a proper learner unless constants
belong to the class. Thus the missing operation is a fixed-marginal proper weak
agnostic ERM or trace-selector routine.

A false witness would need one fixed marginal under which every proper
hypothesis with inverse-polynomial advantage decodes a hard witness. Active
PCP slices vary the marginal or dilute under packing; fixed clause marginals
give only strong-accuracy gaps; sparse one-way image coordinates leak weak
handles; and balanced Hadamard image codes become length-specific or require
non-finite shared randomness. No existing witness resolves the edge.
```

### Depth-5 Directions

1. **Formal trace-selector lemma.** State the exact fixed-$P$ proper weak
   agnostic selector that would imply the target, explicitly handling both
   low-OPT projection and high-OPT proper fallback. This would make clear that
   the source learner alone does not implement the selector.

2. **Finite-string orthogonality barrier.** Try to prove a small quantitative
   lemma: under a fixed marginal on finite strings, if length-$n$ targets
   require fresh coordinates of length at least $L(n)$, then any global weak
   hardness signal is bounded by the tail mass $\Pr[|X|\ge L(n)]$. This would
   formalize why infinite-product Walsh/Hadamard ideas fall outside the atlas
   model or collapse to dilution.

3. **Wrong-output usefulness.** Search for cryptographic selectors where any
   weakly correlated proper output, not just the intended codeword, yields a
   preimage. This avoids needing exact near-orthogonality against all wrong
   concepts.

4. **Fixed-label PCPs.** Look for PCP or label-cover constructions in which
   the input instance is encoded in labels under a shared marginal and
   unrelated proper proofs are automatically near-random, while an improper
   learner still has a tractable relaxation.

5. **Check proper handles in candidate witnesses.** For every proposed
   counterexample, explicitly test constants, off-slice concepts, wrong-length
   concepts, singleton/lookup handles, and residual code correlations against
   the weak agnostic tolerance.

### Additional References Checked

- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: medium-high

---

## Depth-5 Follow-Up: Trace Selectors, Dense Code Handles, And Atomic Marginals

- depth: 5
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

### Focus

This pass focused on the fixed-marginal proper weak agnostic trace-selector
question from depth 4.

The main new observation is negative for the most tempting counterexample
route. A balanced one-way/parity code looks like it should separate improper
prediction from proper representation recovery, but on ordinary finite-string
instance spaces any fixed marginal is atomic. For dense proper code families,
the largest atom creates residual Fourier energy, and random proper codewords
become weak handles that a validation routine can find. Thus the finite-string
version of the Hadamard/permutation idea does not give the desired false
witness.

This still does not prove the edge true: the source learner does not force such
a dense supply of random proper handles, nor does it force constants or any
generic proper selector.

### What A Proper Trace Selector Would Need To Do

Fix a marginal $P$ and write the target guarantee in correlation form. For
$\{\pm 1\}$ labels, the weak agnostic condition

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s)
$$

asks for a proper $h\in\mathcal C$ whose label correlation is within an
additive $2\gamma_P(s)$ of the best proper correlation. Validation can select
such an $h$ from a polynomial list, but it cannot generate the list.

The source learner only says that, under realizable labels, some external
predictor can be found. It gives no procedure that maps a sample trace, or an
external predictor $g$, to a legal representation in $\mathcal C$. In the
medium-OPT range this is even more explicit. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge\gamma_P(s)$, the improper
robustification proof would be happy with a constant classifier of error
$1/2$, but constants may not belong to $\mathcal C$. A proper learner needs a
legal concept with error below roughly $1/2$, not just an external fallback.

So a positive proof still seems to require an additional selector hypothesis:

> For every fixed marginal $P$, there is a uniform polynomial-time generator of
> polynomially many legal concepts such that, for every joint distribution with
> marginal $P$, validation over that list finds a concept satisfying the weak
> agnostic tolerance.

This selector property is essentially the target side of the edge. I do not
see how the realizable improper source implies it.

### Dense Balanced One-Way Codes Leak Weak Handles

The most attractive counterexample attempt is the balanced one-way image code.
Assume a length-preserving one-way permutation $f$. For a seed $s\in\{0,1\}^n$,
let the proper concept be a parity code

$$
c_s(x)=(-1)^{\langle f(s),A_n(x)\rangle},
$$

where $A_n(x)\in\{0,1\}^n$ is a computable feature map. An improper learner can
recover the image vector $y=f(s)$ from linear equations and output the parity
with coefficient $y$, without inverting $f$. A proper learner must output a
seed.

On a non-atomic product marginal with $A_n(X)$ uniform, every wrong seed is
orthogonal to the target, so any proper weak output would have to invert. That
is the clean intuition. But on finite-string instance spaces, a fixed marginal
$P$ is countably atomic. Let $x_0$ be an atom of maximum mass
$\rho=P(x_0)>0$, and let $q_n$ be the induced distribution of $A_n(X)$ on
$\{0,1\}^n$. For each difference $d\in\{0,1\}^n$, define the Fourier
coefficient

$$
\widehat q_n(d)=\mathbf E_{X\sim P}(-1)^{\langle d,A_n(X)\rangle}.
$$

Parseval gives

$$
2^{-n}\sum_d \widehat q_n(d)^2
=
\sum_a q_n(a)^2
\ge
\rho^2.
$$

Also $2^{-n}\sum_d\widehat q_n(d)=q_n(0^n)\ge 0$, so the average positive part
of $\widehat q_n(d)$ is at least $\rho^2/2$. Consequently a uniformly random
difference $d$ has positive correlation at least a $P$-dependent constant with
nonnegligible $P$-dependent probability. Since $f$ is a permutation, a random
proper seed $t$ makes $d=f(s)\oplus f(t)$ uniform, even though the learner does
not know $f(s)$.

Thus a proper learner can generate random seeds $t$, validate their empirical
correlation with the observed labels, and output a seed whose concept has
constant positive advantage whenever the labels are clean, and still
inverse-polynomial advantage under sufficiently low noise. This is a legal
proper weak handle. It does not recover the original preimage $s$, but the
weak target does not ask it to.

This kills the dense permutation/Hadamard counterexample in the finite-string
model. The very atomicity that prevents exact all-length orthogonality gives
validation-accessible wrong proper handles.

### Why This Does Not Resolve The Edge True

The preceding argument uses strong extra structure:

- proper concepts are dense enough that random seeds induce nearly random
  differences;
- candidates are easy to sample as legal proper representations;
- the fixed marginal's atomic Fourier energy is visible to the concept family.

None of these follows from efficient marginal-nonuniform realizable improper
learning. A sparse image-coordinate class has easy improper prediction but
does not provide uniformly random balanced proper codewords. PCP and clause
classes likewise do not come with a sampler over legal concepts whose random
outputs are guaranteed to correlate with the current labels.

So the current state is a squeezed middle:

- If the proper family is dense and balanced enough to avoid slice dilution,
  fixed atomic marginals tend to create random weak handles.
- If the family is sparse enough to avoid random weak handles, known
  constructions fall back into tail-mass dilution, wrong-length handles, or
  strong-only recovery requirements.

This explains why I still do not see either a generic positive theorem or a
clean counterexample.

### Proposed Atlas Update

No atlas status change is justified.

Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Possible additional summary sentence if the edge note is later refreshed:

> Dense balanced-code counterexamples also appear to fail on finite-string
> fixed marginals: atomic Fourier energy gives random proper weak handles,
> while sparse selector constructions lose the weak signal or admit other
> handles.

### Depth-6 Directions

1. **Make the dense/sparse dichotomy precise.** Prove a lemma for finite-string
   fixed marginals: dense proper code families with an efficiently samplable
   near-uniform image distribution admit validation-findable weak handles from
   atomic Fourier energy. Then identify exactly which hypotheses of that lemma
   sparse one-way and PCP witnesses evade.

2. **Search for non-dense wrong-output usefulness.** The next false route
   should not try to make all wrong proper concepts orthogonal. Instead, look
   for a selector where every weakly correlated legal output, even from a
   sparse family, can be decoded into the original witness. Current one-way
   shifted-image outputs do not give the original preimage.

3. **Formalize high-OPT proper fallback as a separate requirement.** Define a
   fixed-$P$ proper weak fallback generator for distributions with
   $\operatorname{OPT}\ge\gamma_P(s)$. Show that constants are one instance of
   such a generator, random dense codewords are another, and the source learner
   supplies neither in general.

4. **Look for classes with easy proper sampling but hard weak validation.**
   The dense-code handle argument depends on empirical validation being able to
   recognize a random correlated proper candidate. A possible counterexample
   would need random legal candidates to have no detectable inverse-polynomial
   correlation unless they solve the hard selector.

5. **Check whether marginal-nonuniform definitions permit non-atomic efficient
   instance models.** If real-valued or oracle-valued examples were allowed,
   the infinite-product Walsh construction might become a genuine false
   witness. Under the atlas's finite-transcript computational convention, it
   appears outside model.

verdict: unresolved-open
confidence: medium-high

---

## Depth-6 Final Pass: Correlation Bookkeeping And The Mass-Dimension Trap

- depth: 6
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: high for keeping the atlas edge open

### Goal

This was the final allowed attempt to settle the edge

$$
\text{efficient marginal-nonuniform realizable improper}
\Rightarrow
\text{efficient marginal-nonuniform weak agnostic proper}.
$$

I tried one last time in both directions.

The positive route still stops at the same missing operation: after low-noise
robustification produces an external weak predictor, there is no generic
polynomial-time way to output a legal concept in $\mathcal C$.

The negative route still lacks a fixed-marginal weak selector witness. The
single-length Hadamard/one-way idea is genuinely compelling, but every
finite-string all-length packing I could make either dilutes the hard signal or
creates validation-findable weak proper handles.

The final recommendation is therefore to leave the atlas edge open, with a
more precise explanation of what a proof or counterexample would have to
supply.

### Correlation Bookkeeping

Use $\{\pm 1\}$ labels and write

$$
M_{\mathcal D}=\sup_{c\in\mathcal C}\mathbf E_{\mathcal D}[c(X)Y].
$$

The target inequality

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s)
$$

is equivalent to

$$
\mathbf E_{\mathcal D}[h(X)Y]
\ge
M_{\mathcal D}+2\gamma_P(s)-1.
$$

Thus, in the realizable case where $M_{\mathcal D}=1$, a proper weak learner
must output a legal concept with positive inverse-polynomial correlation:

$$
\mathbf E[h(X)c^\star(X)]\ge 2\gamma_P(s).
$$

But if a construction only gives best proper correlation $M_{\mathcal D}=\mu$
because the hard instance lives on a slice of mass $\mu$ and the rest is fair
noise or irrelevant padding, the guarantee only forces

$$
\mathbf E[h(X)Y]\ge \mu+2\gamma_P(s)-1.
$$

For small or even moderate $\mu$, this is essentially vacuous. This is the
cleanest way to state why active-slice packing and fixed-clause/fair-noise
gadgets do not refute the weak agnostic marginal target. A false witness should
therefore either be realizable under the fixed marginal, or at least keep
$M_{\mathcal D}$ very close to $1$ while preventing all non-witness proper
outputs from having positive inverse-polynomial correlation.

This also slightly reframes the high-OPT fallback issue. The improper
low-noise argument can validate constant classifiers because one constant has
error at most $1/2$. A proper learner cannot use that unless constants or
equivalent legal fallback concepts are in $\mathcal C$. In correlation terms,
when $M_{\mathcal D}$ is not close to $1$, the learner still needs to find a
legal concept whose correlation is not too far below the best proper
correlation. The realizable improper source does not provide that selector.

### Last Positive Attempt

The only plausible positive theorem would be:

1. Run the marginal-preserving low-noise robustification to get an external
   candidate $g$ in the low-OPT regime.
2. Generate a polynomial list of legal concepts.
3. Validate the list against the original labels and return the best legal
   concept.

This works under additional structure, for example an efficiently searchable
fixed-$P$ weak cover, a fixed-$P$ proper weak ERM routine, a legal constant or
complement fallback plus a low-noise projection oracle, or a dense concept
sampler whose random outputs are guaranteed to include weak handles.

The source node implies none of these. It only says that when the labels are
exactly realizable, one uniform algorithm can find some external predictor
using a $P$-dependent polynomial number of samples and steps. Running that
algorithm on pseudo-labels from $g$ still gives an external predictor. Asking
for a concept in $\mathcal C$ that correlates with $g$, or with the original
labels, is already the proper weak search problem.

The depth-5 dense-code observation is also not enough for a positive proof. It
uses special extra facts: legal concepts are easy to sample, their images are
near-uniform in a large group, and the fixed marginal's atomic Fourier energy
is exposed to validation. Sparse lookup, PCP, and one-way coordinate classes
need not have any comparable legal sampler or random-handle supply.

So I do not see a non-tautological derivation of the target from the source.

### Last Counterexample Attempt: Shared Codes Across One Fixed Marginal

At one fixed length, the one-way Hadamard construction would separate the
notions cleanly. Let $f:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving one-way
permutation, and define

$$
c_s(a)=(-1)^{\langle f(s),a\rangle},\qquad a\in\{0,1\}^n.
$$

Under the uniform marginal on $a$, an improper learner recovers the image
$y=f(s)$ by linear equations and predicts the parity with coefficient $y$,
without finding $s$. A proper learner must output a seed. Since wrong seeds are
orthogonal to the target, any positive-correlation proper output inverts
$f$.

The obstruction is making this into one fixed finite-string marginal for all
lengths.

**Separate length blocks dilute.** If the length-$n$ Hadamard block has mass
$\mu_n$, then a label distribution supported only on that block has best
correlation at most $\mu_n$, so the weak agnostic guarantee is too permissive.
If the labels are made realizable by giving the concept common default behavior
off the active block, wrong-length or wrong-seed concepts sharing that default
become legal weak handles.

**Shared high-mass coordinates need too much geometry.** To keep
$M_{\mathcal D}$ near $1$, a length-$n$ seed must be encoded on most of the
fixed marginal's mass, not just on a fresh low-mass block. But a fixed
finite-string marginal is countably atomic. High-mass early atoms or
low-dimensional coordinate groups cannot carry almost-orthogonal signatures
for exponentially many length-$n$ seeds at every $n$. If the proper family is
dense and easy to sample, the atomic Fourier-energy phenomenon from depth 5
reappears: random legal codewords have validation-detectable positive
correlation often enough to be weak handles. If the construction moves the
near-orthogonal code to fresh high-dimensional coordinates, the useful signal
is paid for by tail mass and the weak-dilution problem returns.

**Sparse families avoid random handles but lose weak forcing.** One can avoid
the random dense-code handle by making proper concepts sparse or highly
structured. That returns to the known PCP, clause, and image-coordinate
templates. In those templates a weakly good wrong output either ignores a
low-mass hard region, matches only an easy partial hash, uses a default or
wrong-length handle, or gives correlation too weak to decode into the original
witness. I did not find a sparse selector where every inverse-polynomially
correlated proper output is useful for the hard instance.

This is the mass-dimension trap for the false route:

- To make weak agnostic learning force information, the best proper
  correlation must be close to $1$, so the hard encoding must occupy most of
  the fixed marginal.
- To prevent wrong proper weak handles, the encoding must be nearly
  orthogonal, or every correlated wrong output must decode a witness.
- On finite-string fixed marginals, nearly orthogonal all-length dense
  encodings either expose random validation handles through atomic structure
  or move their useful dimension into a tail whose mass weak learning can
  ignore.
- The known sparse encodings avoid the dense random handles but do not provide
  wrong-output usefulness.

This does not prove a theorem that no counterexample exists, but it explains
why the natural final candidate did not resolve the edge.

### Atlas-Ready Recommendation

No atlas status change is justified.

Recommended frontmatter if the edge note is refreshed:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
summary: "Open: low-noise robustification gives only an improper weak agnostic predictor. A proper target would require a fixed-marginal legal trace selector or weak proper ERM routine not implied by the source. Known fixed-marginal counterexample routes either dilute the hard signal, leak proper weak handles, or need shared-code geometry outside the finite-string model."
```

Suggested body text:

```markdown
## Verdict

`open`.

The marginal-preserving low-noise argument converts the source into an
efficient marginal-nonuniform weak agnostic improper learner, but it does not
produce a concept in $\mathcal C$. In the low-OPT regime it returns an external
predictor and supplies no efficient projection into the class. In the
medium/high-OPT regime the usual improper fallback uses constant classifiers,
which need not be legal proper hypotheses.

In correlation form, the target asks for
$$
\mathbf E[h(X)Y]\ge
\sup_{c\in\mathcal C}\mathbf E[c(X)Y]+2\gamma_P(s)-1.
$$
Thus a counterexample based on a hard slice of mass $\mu$ does not force proper
information unless the best proper correlation remains close to $1$; otherwise
the weak agnostic additive term can absorb the slice.

Known false-witness templates still fall short. PCP active slices use
input-dependent marginals or lose their signal when packed into one marginal.
Fixed clause marginals create only strong-accuracy gaps. Sparse one-way
image-coordinate classes leak constants, singleton, wrong-length, or
low-mass handles for weak learning. Dense Hadamard-style repairs work at one
fixed length, but finite-string all-length packings either dilute into tail
mass or expose validation-findable random proper handles through atomic
Fourier energy. No current construction gives one fixed marginal where every
proper inverse-polynomial weak output decodes a hard witness.
```

### Remaining Exact Open Problems

1. Prove a genuine positive selector theorem from the source, not from an
   added proper weak ERM assumption. The missing object is a uniform generator
   of polynomially many legal concepts whose validation covers the weak
   agnostic target for each fixed marginal.

2. Build a fixed-marginal weak selector counterexample with wrong-output
   usefulness: every legal concept with positive inverse-polynomial correlation
   must decode the hard witness. This would avoid the impossible-looking
   demand that all wrong concepts be superpolynomially orthogonal.

3. Formalize the finite-string mass-dimension barrier for shared codes. A
   useful lemma would say that an all-length dense code over a fixed atomic
   marginal either has validation-findable random weak handles or places the
   distinguishing coordinates in a tail whose mass makes the weak agnostic
   guarantee non-forcing.

4. Check whether a non-atomic instance model is intentionally excluded. If
   examples could be infinite random strings with product measure, the
   all-length Walsh/Hadamard counterexample might become real. Under the
   atlas's finite encoded transcript convention, that route appears outside
   the model.

verdict: unresolved-open
confidence: high for the atlas recommendation; medium-low for any claim about
the edge's ultimate mathematical truth
