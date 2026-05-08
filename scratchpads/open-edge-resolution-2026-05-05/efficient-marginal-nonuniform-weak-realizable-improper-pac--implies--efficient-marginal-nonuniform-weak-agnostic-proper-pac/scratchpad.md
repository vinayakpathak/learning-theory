# Edge: efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- verdict: unresolved
- confidence: medium-high

## Context

The assigned edge asks whether
[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]
implies
[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]].

The source gives one uniform learner $A$ that, for each fixed marginal $P$, has
a $P$-dependent polynomial sample/time bound and a $P$-dependent inverse
polynomial weak advantage on realizable labels, but may output hypotheses
outside $\mathcal C$.

The target asks for one uniform learner that, for every joint distribution
$\mathcal D$ with marginal $P$, outputs $h\in\mathcal C$ and satisfies
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
\qquad
\beta_P(s)=1/2-\gamma_P(s),
$$
where $\gamma_P(s)$ is inverse-polynomial under a $P$-dependent polynomial.

There are two useful reductions of the question:

1. The target restricted to realizable distributions implies
   `efficient-marginal-nonuniform-weak-realizable-proper-pac`. Thus any proof of
   this edge would also solve the weak marginal-nonuniform properization edge
   from the same improper source.
2. The already-resolved sibling edge
   `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`
   is true by marginal-preserving low-noise robustification. Thus the agnostic
   part can be handled improperly; the remaining issue is producing a legal
   concept in $\mathcal C$.

In correlation form, using $\{\pm1\}$ labels, the weak agnostic target is
equivalent to
$$
\mathbf E[h(X)Y]
\ge
\sup_{c\in\mathcal C}\mathbf E[c(X)Y]+2\gamma_P(s)-1.
$$
So the guarantee is only forcing when the best concept is close to perfectly
correlated with the labels. This is why low-noise arguments help, and why
ordinary strong-accuracy hardness examples often become too weak after the
target is relaxed to a fixed additive tolerance near $1/2$.

## Attempted Positive Route: Low-Noise Robustification With A Proper Selector

The improper low-noise route is solid. Fix $P$, let $m_P(s)$ bound a
constant-confidence invocation of the weak realizable improper learner, and set
an agnostic weak gap $\alpha_P(s)$ below both the realizable weak advantage and
$1/m_P(s)$. On agnostic data, if
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is tiny, couple a noisy run of
$A$ to a clean run on $(X,c^\star(X))$ for a near-optimal concept $c^\star$,
using the same $P$-distributed instance sequence and the same internal
randomness. With inverse-polynomial probability the inspected labels are
uncorrupted, so the noisy transcript is a valid realizable transcript under the
original marginal $P$. Repetition and validation give an improper weak
agnostic predictor.

To make this proof proper, two extra operations seem necessary.

First, the high-noise branch needs legal neutralizers. The improper proof uses
the two constant classifiers: if $\operatorname{OPT}\ge\alpha_P(s)$, a constant
of error at most $1/2$ is already within
$\operatorname{OPT}+1/2-\alpha_P(s)$. Constants need not lie in $\mathcal C$.
Without some proper neutralizer, complement closure, balanced sampler, or
validation-searchable candidate list, the high-noise branch has no guaranteed
proper output.

Second, the low-noise branch needs a proper selector or projection. The coupled
run returns an external predictor $g$ weakly correlated with $c^\star$. The
source does not give an efficient routine that, from samples and perhaps oracle
access to $g$, finds any $h\in\mathcal C$ with inverse-polynomial advantage
under $P$. Running the improper source on pseudo-labels $g(X)$ is not enough:
$g$ need not be realizable by $\mathcal C$, and finding a closest legal concept
is exactly a proper weak ERM or projection problem.

A conditional positive theorem would be plausible:

> If every fixed marginal $P$ admits a $P$-dependent polynomial-time proper
> neutralizer/selector, or an efficiently searchable weak cover of the relevant
> traces of $\mathcal C$, then the marginal-preserving low-noise proof can be
> followed by validation over legal candidates to obtain the target.

But the source node itself does not imply such a selector. Marginal
nonuniformity permits $P$-dependent polynomial bounds, not $P$-specific advice
or a nonuniform proper ERM oracle.

## Counterexample Route: PCP Active-Slice Hardness

The [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
witness has the right local shape. Proper concepts encode an NP instance
$\varphi$ and proof $\pi$, and on examples $(\psi,r)$ they run the verifier
only when $\psi=\varphi$. The active slice for a fixed $\varphi$ has polynomial
size. Improper memorization, or a one-slice lookup-table ERM, learns the class
efficiently, while a weak proper learner on the active slice would decide an
NP-complete language.

This refutes distribution-free weak proper targets, but it does not refute the
assigned marginal-nonuniform target. The reduction chooses the marginal
$U_\varphi$ uniform over the active slice of the input instance. In the
marginal-nonuniform model, the resource polynomial and weak advantage may
depend on that entire marginal. Since $U_\varphi$ varies with the NP input, the
dependence on $P$ can hide instance-specific search cost, and the reduction no
longer yields a uniform randomized polynomial-time algorithm for the NP
language.

Packing all active slices into one fixed marginal also loses the weak signal.
If the slice for $\varphi$ has mass $\mu_\varphi$, the proper proof/no-proof
gap is multiplied by $\mu_\varphi$. A weak target only requires error below
roughly $1/2$, so low-mass hard slices can be ignored by wrong-slice or mostly
zero proper hypotheses. A single fixed marginal cannot give constant mass to
all input slices.

## Counterexample Route: Fixed-Marginal PCP Or Clause Selectors

The natural repair is to encode the hard instance in the labels while keeping
the marginal fixed. Clause-satisfaction hardness does this for strong proper
targets: under the uniform clause marginal, formula clauses get label $1$ and
non-formula clauses receive fair noise.

For this weak edge, that is not enough. The satisfiable/unsatisfiable gap per
clause is of order one clause mass, while the target allows an additive error
near $1/2$. A weak learner can output an assignment or other proper hypothesis
that is mildly correlated with the labels without finding a satisfying
assignment. The same issue appears for fixed-marginal Label-Cover or PCP tests:
unless every weakly useful proper hypothesis decodes the intended witness,
unrelated satisfiable instances, random balanced concepts, singleton handles,
or residual code correlations may satisfy the weak additive target.

A fixed-marginal selector witness would need the following stronger geometry.
For each challenge $z$, labels $Y_z$ are almost realizable by a legal witness
concept. Every proper hypothesis with correlation exceeding the hidden
inverse-polynomial weak gap must either be a valid witness for $z$ or be
convertible into one. This is stronger than the usual strong-accuracy
separation.

## Counterexample Route: One-Way Image-Coordinate Classes

The [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
witness separates improper prediction from strong proper recovery. A seed
$s\in\{0,1\}^n$ exposes the bits of $f(s)$ on a length-$n$ coordinate block. An
improper learner memorizes positive atoms, while strong proper learning under a
fixed all-length marginal with block mass $\mu_n=6/(\pi^2n^2)$ and accuracy
$\mu_n/(3n)$ recovers a preimage of the one-way image.

The weak target removes the recovery-forcing accuracy demand. Under the
all-length marginal, a wrong-length concept or default-like hypothesis can have
global error on the order of $\mu_n/2$, which is far below $1/2$ and therefore
is a valid weak output without inverting the one-way function. If instead we
condition the marginal on one length $n$, the lower bound again uses a marginal
that changes with the challenge size; the marginal-nonuniform polynomial may
depend on that length-conditioned marginal.

The weak-handle variant makes this sharper. Adding constants and singleton
concepts gives proper weak handles under every marginal, and because the
constants are legal, the low-noise robustification makes the class weak
agnostically proper. That witness separates weak from strong proper learning,
not weak improper source from weak agnostic proper target.

Dense image-code repairs run into the shared-code obstruction already recorded
in [[properization-open|Properization Open]]. To make every wrong proper output
useless, one wants near-orthogonal codewords for exponentially many
certificates on a polynomial-size coordinate domain. Polynomial-length codes
leave inverse-polynomial residual correlations, and the target's hidden weak
gap may be smaller than those residuals. Exact Hadamard-style orthogonality
requires an exponential coordinate domain or representation padding that
destroys the polynomial-time improper lookup learner or the cryptographic
reduction.

## Known Obstacles And Near Misses

- Halfspaces do not refute this edge. They satisfy efficient realizable proper
  learning, and because constants are halfspaces, the low-noise robustification
  gives a weak agnostic proper learner. Tiegel-style hardness is for strong
  agnostic accuracy, not this fixed-additive weak target.
- Fixed-$k$ DNF separates weak proper learning from strong proper learning, but
  the assigned target is weak. It is evidence against proper boosting, not a
  counterexample to the weak target.
- Sample-only properization does not help computationally. VC/ERM arguments can
  show a good proper hypothesis exists with enough samples, but the target
  requires a polynomial-time procedure for finding one.
- A false witness cannot merely hide hard slices in low marginal mass. The
  source quantifies over all marginals, including marginals that isolate a
  slice, so each slice must remain weakly learnable; but once the slices are
  packed into one fixed marginal, low-mass slices are invisible to a weak
  additive target.
- The likely missing negative object is a computationally nonboostable weak
  handle family: one weak handle is efficiently findable under every marginal
  for the improper source, but every proper weak agnostic output under a fixed
  marginal decodes a hard certificate.

## Proposed Atlas Update

No resolved atlas status change is justified by this pass. I would keep the
edge open, but sharpen the summary/body to identify the exact obstruction:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: marginal-preserving low-noise robustification gives a weak agnostic improper learner, but no generic efficient projection or proper neutralizer is known; current PCP active-slice, one-way coordinate, and fixed-marginal selector templates either vary the marginal, dilute the weak signal, or leak weak proper handles."
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested body sketch:

```markdown
## Verdict

`open`.

The source can be robustified to an efficient marginal-nonuniform weak agnostic
improper learner by coupling noisy runs to clean realizable runs under the same
original marginal. The target, however, requires output in the concept class.
The source gives neither legal constant neutralizers for the high-noise branch
nor a polynomial-time projection from an external weak predictor to a proper
hypothesis.

Known counterexample templates are near misses. PCP active slices separate
distribution-free weak improper from weak proper learning, but their hard
marginal depends on the input instance; packing the slices into one fixed
marginal dilutes the local gap below the weak additive tolerance. One-way
image-coordinate classes force exact proper recovery only for strong accuracy;
weak learners can use wrong-length, low-mass, constant, or singleton handles.
Fixed-marginal clause and PCP selectors would need a gadget in which every
weakly useful proper hypothesis decodes the hard witness, and no current
construction provides that while preserving the improper source.
```

## Next Directions

1. Try to formalize the conditional positive selector theorem: proper
   neutralizers plus a $P$-dependent polynomial searchable weak cover should
   make the low-noise robustification proper.
2. Search for a fixed-marginal PCP or Label-Cover code where wrong proper
   certificates have correlation below every inverse-polynomial scale relevant
   to the target, without making the coordinate domain superpolynomial.
3. Explore cryptographic weak-handle hardness: a construction where finding one
   improper weak handle is easy under every marginal, but finding any legal
   proper weak handle under one fixed marginal is equivalent to decoding or
   inverting.
4. Keep the marginal-nonuniform weak realizable proper sibling edge in sync:
   any counterexample to that edge automatically refutes this one in the
   realizable subcase.

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/halfspaces.md`

verdict: unresolved
confidence: medium-high

---

## Depth-2 Follow-Up: Selector Theorem And Anti-Neutralizer Stress Test

- depth: 2
- date: 2026-05-05
- verdict: unresolved
- confidence: medium-high overall; high that the present notes do not justify a true or false atlas status

### Focus

This pass focused on the two live gaps from the first pass.

1. Can one prove a proper selector theorem from the source alone?
2. If not, can a counterexample force the high-noise constant or neutralizer
   used by low-noise robustification to be genuinely improper?

I still do not see an atlas-ready resolution. The useful refinement is that the
second route is narrower than it first looks. Omitting constants from
$\mathcal C$ is not enough. In the high-noise regime, the weak agnostic target
allows even mildly anti-correlated proper hypotheses, so a false witness would
need to make all efficiently findable legal hypotheses strongly anti-neutral.
That collapses back into a fixed-marginal weak selector or anti-selector
hardness problem.

### Correlation Bookkeeping

Use $\{\pm1\}$ labels and write
$$
M(\mathcal D)=\sup_{c\in\mathcal C}\mathbf E[c(X)Y].
$$
Then
$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)=\frac{1-M(\mathcal D)}2.
$$
The target guarantee
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s)
$$
is equivalent to
$$
\mathbf E[h(X)Y]\ge M(\mathcal D)+2\gamma_P(s)-1.
$$

This is the right diagnostic for the neutralizer issue.

If the data are low-noise, say $M(\mathcal D)\approx 1$, the target requires a
proper hypothesis with positive inverse-polynomial correlation. This is exactly
the proper selector problem: find some legal $h$ that weakly tracks the hidden
near-optimal $c^\star$.

If the data are high-noise, the threshold can be negative. For example, if
$\operatorname{OPT}=1/4$, then $M=1/2$ and it is enough to output any proper
hypothesis with correlation at least $-1/2+2\gamma_P(s)$. A random-like or
orthogonal wrong proper hypothesis with correlation near $0$ already succeeds.
Thus the improper constants in the standard robustification proof are a
sufficient neutralizer, but not a necessary one.

So a high-noise counterexample cannot merely say "constants are not in
$\mathcal C$." It must arrange that every proper hypothesis the learner can
efficiently find has correlation below the negative threshold
$M+2\gamma_P(s)-1$. That is much stronger than the usual requirement that wrong
certificates have no positive correlation.

### Conditional Positive Selector Theorem

There is a clean conditional theorem, but its hypotheses are exactly the missing
properization structure.

Fix a marginal $P$. Suppose the source weak realizable improper learner has a
constant-confidence sample bound $m_P(s)$ and clean advantage $\rho_P(s)$. Assume
two additional uniform procedures whose running times admit $P$-dependent
polynomial bounds.

First, a proper neutralizer generator produces a polynomial-size list
$N=N(P,s)$ of legal concepts, from samples rather than from advice, such that
for every joint distribution $\mathcal D$ with marginal $P$, if
$\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$ then some
$n\in N$ satisfies
$$
\operatorname{err}_{\mathcal D}(n)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-2\alpha_P(s).
$$
A legal pair of constants, a complement-closed class with one known concept, or
an efficiently sampleable symmetric family that validation can derandomize would
be enough. The source does not imply any of these.

Second, a low-noise proper selector takes samples from $\mathcal D$, and
optionally evaluation access to an improper predictor $g$, and has the following
guarantee. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<\alpha_P(s)$ and some run of
the source learner has produced $g$ with
$$
\operatorname{err}_P(g,c^\star)\le \frac12-\rho_P(s)
$$
for a concept $c^\star$ with
$\operatorname{err}_{\mathcal D}(c^\star)=\eta$, then the selector returns
$h\in\mathcal C$ with
$$
\operatorname{err}_P(h,c^\star)\le \frac12-\kappa_P(s)
$$
for inverse-polynomial $\kappa_P(s)$.
Since $c^\star$ has $\mathcal D$-error $\eta$, this gives
$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\frac12-\kappa_P(s).
$$

Given these two procedures, the robustification proof becomes proper: repeat
the source learner on noisy batches, convert its low-noise successful outputs
with the selector, add the neutralizer list, validate all legal candidates, and
output the empirical best. Choosing
$$
\gamma_P(s)\ll \min\{\alpha_P(s),\kappa_P(s),\rho_P(s),1/m_P(s)\}
$$
absorbs the coupling and validation losses.

This conditional statement is useful bookkeeping, but it is not a proof of the
assigned edge. The source learner gives prediction, not a legal representation.
Marginal nonuniformity allows the analysis polynomial to depend on $P$; it does
not give the learner $P$-specific advice, a support enumeration, a trace
representative list, or a proper ERM oracle.

### Why The Source Does Not Seem To Force A Selector

The sample-level implication is true in the atlas, but the computational content
does not follow. For a fixed $P$, finite VC or marginal-nonuniform sample theory
can say that a small proper cover exists at the needed scale. It does not give a
polynomial-time map from a labeled trace, or from an external predictor $g$, to a
valid representation in $\mathcal C$.

The distinction matters even with $P$ fixed. A $P$-dependent constant in the
runtime bound can hide a large finite setup cost, but it cannot hide an
exponential search in the target size $s$ for all $s$. Enumerating concepts of
size $\operatorname{poly}(s)$ until one fits the trace is generally exponential
in $s$, even if only polynomially many traces are statistically relevant under
$P$.

The targeted external recheck did not change this picture. Pitt and Valiant's
proper-hardness framework is representation-based: richer hypothesis languages
can make prediction easier, while finding a representation in the original class
can encode hard search. That supports the obstruction but does not by itself
settle this marginal-nonuniform weak edge.

### Can High-Noise Force The Neutralizer To Be Improper?

The most tempting negative plan is:

1. build a class $\mathcal C$ with no constants and no easy complement pair;
2. keep realizable weak improper learning easy, perhaps by memorization or
   lookup;
3. choose a fixed marginal $P^\star$ and an agnostic distribution
   $\mathcal D_z$ for which an improper constant has valid weak error, but any
   valid proper output reveals a hard certificate $z$.

The correlation calculation above shows why this is hard. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D_z)$ is bounded away from zero, the
target does not require positive correlation with the labels. A wrong proper
concept with near-zero correlation is already a legal neutralizer. Therefore the
construction must make every nonrevealing proper concept substantially
anti-correlated with $Y_z$, not merely uncorrelated.

That requirement is stronger than the dense-code repair considered in the first
pass. Orthogonal or small-bias codewords are bad for such a counterexample in
the high-noise regime, because orthogonality gives legal neutralizers. Sparse
one-way image coordinates are also bad: wrong-length or low-mass concepts are
often weakly harmless globally. PCP active slices avoid wrong-instance
neutralizers only by putting the instance identity into the marginal, which the
marginal-nonuniform target can absorb.

One can try to make a "pointing" distribution where the unique good proper
concept is $c_z$ and all other concepts are anti-correlated. But over one fixed
polynomial-size coordinate domain, a large family with this property runs into
the same Gram/Plotkin/Hadamard pressure recorded in
[[properization-open|Properization Open]]. Packing many target-specific
anti-neutralizer slices into one marginal again dilutes the weak signal.

So the high-noise route does not currently give a separate counterexample. It
reduces to a more demanding fixed-marginal selector-hardness problem:

> Find one fixed marginal and a hard family of label rules such that every
> efficiently findable proper hypothesis is below the weak correlation threshold,
> while an improper learner can still satisfy the realizable source for every
> marginal.

No checked PCP, clause-selector, or one-way-code construction achieves this.

### Updated Verdict

Still `unresolved`; keep the edge `open` with `evidence: unknown`.

The strongest positive statement I can prove is conditional on explicit proper
neutralizer and low-noise selector procedures. The strongest negative statement
I can formulate is an anti-neutralizer selector-hardness template, but current
witnesses either vary the marginal, lose the weak signal when packed into one
marginal, or leave near-zero-correlation proper hypotheses that are already
valid high-noise outputs.

No atlas file should be changed on the basis of this pass.

### Depth-3 Directions

1. Formalize the conditional selector theorem as a reusable lemma with two
   named hypotheses: `proper-neutralizer-list` for the high-noise branch and
   `low-noise-proper-trace-selector` for the coupled branch.

2. Prove a finite-trace barrier lemma: existence of a polynomial-size
   $L_1(P)$ cover or finite VC trace bound does not imply polynomial-time proper
   selection unless trace realization over $\mathcal C$ is efficient.

3. Search for fixed-marginal approximation-resistant CSP or Label-Cover gadgets
   where every assignment with correlation above the weak threshold decodes a
   witness. The hard part is preventing unrelated assignments from becoming
   near-zero-correlation neutralizers.

4. Try to prove a high-noise neutralizer meta-lemma for broad symmetric classes:
   if there is an efficient sampler over proper hypotheses with expected
   correlation $0$ against every label rule, validation gives a legal
   high-noise neutralizer. This would isolate the low-noise selector as the only
   obstruction for many natural classes.

5. Revisit dense cryptographic code families only if the wrong-code correlation
   can be made below every inverse-polynomial scale relevant to the hidden
   $\gamma_P(s)$ without making the coordinate domain superpolynomial or turning
   the improper source into a hard parity-style learner.

### References Rechecked

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- [Pitt and Valiant 1988, Computational Limitations on Learning from Examples](https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p965-pitt.pdf)
- [Board and Pitt 1992, On the Necessity of Occam Algorithms](https://experts.illinois.edu/en/publications/on-the-necessity-of-occam-algorithms/)

verdict: unresolved
confidence: medium-high

---

## Depth-3 Follow-Up: Proper Candidate Generation Stress Tests

- depth: 3
- date: 2026-05-05
- verdict: unresolved
- confidence: medium-high that no source-only neutralizer/selector theorem is available; medium that this can be turned into a false atlas edge

### Focus

This pass tried to make the depth-2 obstruction more concrete. The question was
whether the source guarantee itself can manufacture either:

1. a high-noise proper neutralizer, or
2. a low-noise proper selector that converts an external weak predictor into a
   legal weak predictor.

The short answer is negative for black-box/source-only constructions. The
source learner can create predictors and validation can select among candidates,
but neither operation creates a legal representation in $\mathcal C$. I did find
useful conditional neutralizer constructions for symmetric classes, and toy
hard-trace constructions showing why finite traces do not imply efficient
selection. These sharpen the obstruction but still do not settle the atlas edge.

### Source Calls Do Not Generate Legal Candidates

Suppose a generic transformation is only allowed to use samples, validation, and
the source weak realizable improper learner $A$.

Running $A$ on the agnostic labels is not justified: the source promise applies
only to labels realizable by a concept in $\mathcal C$.

Running $A$ on pseudo-labels from an external predictor $g$ is also not
justified. Even in the low-noise case, the coupled predictor $g$ may only be
weakly correlated with a near-optimal $c^\star$. The pseudo-label rule $g(x)$
need not lie in $\mathcal C$, so this is again an agnostic or noisy learning
problem, not an invocation covered by the source.

Running $A$ on labels from a known legal concept $c_0$ would require already
having such a legal concept. Even then, $A$ may output an improper hypothesis
approximating $c_0$, not a representation in $\mathcal C$. If $c_0$ itself is
available, it is external structure, not a consequence of the source node.

Validation has the same limitation. It can choose the best member of an already
generated legal list, but it cannot turn a lookup table, vote, circuit, or other
external predictor into a proper concept. Thus any positive proof must add a
proper candidate generator: a known concept pair, a sampler over legal concepts,
an efficient proper ERM, a projection oracle, or a searchable proper trace
cover.

This refutes a purely black-box selector theorem from the source guarantee. It
does not refute the atlas implication, because a target learner for a specific
class may exploit representation structure that is absent from the abstract
source promise.

### Concrete Positive Neutralizer: Symmetric Proper Samplers

There is a clean high-noise neutralizer lemma under an extra symmetry
assumption.

Fix $P$ and suppose there is an efficient sampler over legal hypotheses
$H\in\mathcal C_s$ such that
$$
\mathbf E_H[H(x)] = 0
$$
for $P$-almost every $x$. For any joint distribution $\mathcal D$ with marginal
$P$, write
$$
Z(H)=\mathbf E[H(X)Y].
$$
Then $\mathbf E_H Z(H)=0$. Since $Z(H)\in[-1,1]$, for every
$\alpha\in(0,1)$,
$$
\Pr_H[Z(H)\ge -\alpha]\ge \frac{\alpha}{1+\alpha}.
$$
Otherwise even setting all successful draws to correlation $1$ and all failed
draws to correlation $-\alpha$ would make the expectation negative.

Therefore $O(\alpha^{-1}\log(1/\delta))$ sampled proper hypotheses contain,
with high probability, one candidate with correlation at least $-\alpha$.
Validation can find it. If the high-noise branch is defined by
$$
M(\mathcal D)=\sup_{c\in\mathcal C}\mathbf E[c(X)Y]\le 1-4\alpha
$$
and the final weak gap satisfies $\gamma_P(s)\le \alpha$, then the target
threshold is
$$
M(\mathcal D)+2\gamma_P(s)-1\le -2\alpha,
$$
so a candidate with correlation at least $-\alpha$ is a valid proper
neutralizer.

Known legal complements are the smallest example: if $c_0,-c_0\in\mathcal C$
are efficiently constructible, one of them has nonnegative correlation with
the labels. More generally, any efficiently sampleable sign-symmetric proper
subfamily gives high-noise neutralizers.

This explains why high-noise counterexamples are so constrained. A class need
not contain constants. Near-zero-correlation proper hypotheses already work.
To refute the target through high-noise labels, one must make such legal
neutralizers either absent or computationally hard to find. The source promise
does not rule out either possibility.

### Concrete Selector Attempt: Trace Projection From An Improper Predictor

The low-noise branch remains harder. In the successful coupling event, the
source learner produces an external predictor $g$ with
$$
\mathbf E[g(X)c^\star(X)]\ge 2\rho_P(s)
$$
for a near-optimal $c^\star\in\mathcal C$. The desired selector would output
$h\in\mathcal C$ with
$$
\mathbf E[h(X)c^\star(X)]\ge 2\kappa_P(s).
$$

A natural construction is to draw a finite trace $T=(x_1,\ldots,x_m)$ from
$P$, label it by $g(x_i)$, and search for a concept $h$ agreeing with these
pseudo-labels noticeably better than chance. But this is just weak agnostic
proper optimization over $\mathcal C$ on the pseudo-labeled trace. The labels
from $g$ can have nearly $1/2-\rho_P(s)$ error relative to $c^\star$, so
ordinary realizable consistency search does not apply.

Labeling the trace by the original agnostic examples does not help. When
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is tiny, there exists a mostly
clean trace, but the algorithm does not know which labels are clean. The
low-noise robustification proof avoids this by using a lucky clean transcript
inside $A$ and then validating the resulting improper hypotheses. It never
identifies a clean trace that can be handed to a proper consistency algorithm.

Thus the selector attempt collapses to one of the following extra assumptions:
efficient approximate proper ERM, an efficient weak correlation maximizer over
$\mathcal C$, or a trace projection oracle that tolerates the weak noise level.
Those assumptions are essentially target-side structure.

### Concrete Hard-Trace Toy

The finite-domain PCP template is a useful stress test for any proposed
selector theorem.

Fix an instance slice with polynomial-size domain $X_z$. Proper concepts encode
certificates or proofs $w$ and label each challenge $x\in X_z$ by the verifier
predicate. An improper learner can strongly learn realizable labels on this
slice by sampling enough to build a lookup table on the polynomial domain. This
uses no proper search.

A proper selector for the uniform marginal on $X_z$ would have to turn the
labeled trace into a proof whose verifier acceptance beats the weak threshold.
With a PCP gap below $1/2$, such a selector solves the underlying proof search
problem.

This is not an atlas-ready false witness for the assigned edge, for the reason
already found at depth 1 and depth 2: the marginal $P_z$ varies with the hard
instance $z$, and a marginal-nonuniform runtime polynomial may depend on that
whole marginal. Packing all slices into one fixed marginal dilutes the weak
signal. But the toy does refute the local positive idea that polynomial support
or polynomial trace size automatically yields an efficient selector. The
missing step is the trace-to-proof map.

### Concrete Hard-Neutralizer Toy

There is also a representation-level toy showing why a source-only
neutralizer theorem is too strong.

Imagine a finite-domain class where every legal proper representation must
carry a certificate for a hard relation, while improper prediction is just
lookup-table learning on the finite domain. On high-noise data, almost any legal
concept with nonnegative or mildly negative correlation would be an adequate
neutralizer. Nevertheless, producing such a legal concept would already solve
the certificate search problem.

This toy is only diagnostic. If all legal representations compute the same easy
function, the semantic class may collapse and an easy representation of that
function might count as proper. If the concepts are made semantically distinct,
one must recheck the source guarantee under arbitrary marginals and prevent
easy weak handles. So this does not give a clean atlas counterexample. It does,
however, isolate the right negative phenomenon: a future false witness should
make neutralizers exist statistically but be computationally hard to find.

### Updated Verdict

Still `unresolved`; keep the edge `open` with `evidence: unknown`.

What improved at depth 3 is the diagnosis:

- A source-only or black-box conversion cannot prove generic proper
  neutralizers/selectors. The source promise gives no legal candidate generator.
- High-noise neutralizers are easy under extra symmetry, via a proper sampler
  with mean-zero labels. This makes "missing constants" an inadequate
  counterexample strategy.
- Low-noise selectors require an efficient weak proper optimizer or projection
  from traces/predictors to $\mathcal C$. The source does not imply this.
- Concrete PCP/finite-trace constructions show the selector map can encode hard
  search, but the known versions still vary the marginal or lose the weak signal
  when packed into one fixed marginal.

No atlas file should be changed on the basis of this pass.

### Depth-4 Directions

1. Formalize the black-box no-go: in a representation-sensitive oracle model,
   two classes can expose identical sample transcripts and identical improper
   source behavior while hiding different legal proper encodings. Any successful
   selector must use more than the source guarantee.

2. Promote the symmetric-sampler calculation to a reusable high-noise
   neutralizer lemma. Then classify which existing witness classes fail because
   they accidentally contain such samplers, complements, constants, or singleton
   handles.

3. Search for computational weak-handle hardness under one fixed marginal:
   weakly adequate proper neutralizers may exist, but finding any of them should
   be as hard as proof search or inversion. This is sharper than trying to make
   all wrong concepts geometrically anti-correlated.

4. Revisit fixed-marginal PCP or Label-Cover gadgets with input encoded in the
   labels on a shared constant-mass challenge space. The needed property is that
   every weakly valid proper hypothesis decodes a witness, while unrelated
   hypotheses are not available as easy near-zero neutralizers.

5. Test finite-domain hard-trace classes against the marginal-nonuniform
   quantifiers. The construction must use one fixed marginal across infinitely
   many challenge sizes without giving each challenge vanishing mass and without
   letting the $P$-dependent polynomial hide the hard instance.

### References Rechecked

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved
confidence: medium-high

---

## Depth-4 Follow-Up: Hadamard-Image Selector Stress Test

- depth: 4
- date: 2026-05-05
- verdict: unresolved
- confidence: medium-high that the best concrete false-witness template still
  fails the atlas fixed-marginal requirements; high that the one-length
  Hadamard-image gadget isolates the missing selector
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

### Focus

This pass tried to build the requested concrete false witness:

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
-/>
efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

The target can already be refuted on realizable distributions, since the
agnostic proper learner must handle the special case
$\operatorname{OPT}_{\mathcal C}=0$. Thus the cleanest route is to make the
source learner recover an external predictor, while every proper weak output
must solve a hard search problem. The depth-3 conclusion says no generic
neutralizer or selector follows from the source. The new question is whether
one can make that failure into a single fixed-marginal counterexample.

### One-Length Hadamard-Image Gadget

Assume a length-preserving one-way function
$f:\{0,1\}^n\to\{0,1\}^n$. At one fixed length, let the instance space be
$X_n=\{0,1\}^n$ with uniform marginal $U_n$. A proper concept is indexed by a
seed $s\in\{0,1\}^n$ and labels

$$
c_s(r)=(-1)^{\langle f(s),r\rangle}
\qquad r\in\{0,1\}^n .
$$

An improper hypothesis may output an arbitrary parity vector
$y\in\{0,1\}^n$, not necessarily a one-way image with known preimage.

This gadget has exactly the desired selector obstruction. In the realizable
case, an improper learner can learn the parity vector by Gaussian elimination
or by realizable ERM over the parity superclass. For arbitrary marginals on
$X_n$, a parity consistent with the sample has small true error by the usual
finite-class or VC argument, and the computation is polynomial in $n$. Thus the
realizable source is easy improperly.

By contrast, under $U_n$ the parity characters are exactly orthogonal:

$$
\mathbf E_{r\sim U_n}[c_s(r)c_t(r)] =
\begin{cases}
1, & f(t)=f(s),\\
0, & f(t)\ne f(s).
\end{cases}
$$

On realizable labels from $c_s$, a weak proper agnostic learner must output a
proper $c_t$ with error at most $1/2-\gamma$, equivalently positive correlation
at least $2\gamma$. Orthogonality then forces $f(t)=f(s)$. Given an inversion
challenge $y=f(s)$, the reduction can sample $r\sim U_n$, label by
$(-1)^{\langle y,r\rangle}$, and any successful proper weak learner returns a
preimage of $y$.

So at one fixed length, the missing proper selector is literally the inversion
map

$$
y \longmapsto t \text{ such that } f(t)=y .
$$

This is a much cleaner obstruction than the sparse image-coordinate class:
there are no wrong-seed weak handles under the length-$n$ uniform marginal.

### Why This Still Does Not Resolve The Atlas Edge

The one-length proof uses a marginal $U_n$ that changes with the hard input
length. In the marginal-nonuniform target, the runtime polynomial and weak gap
may depend on the entire marginal. For the sequence of marginals
$U_1,U_2,\ldots$, this dependence can hide an arbitrary amount of
length-specific work. It therefore does not yield a single randomized
polynomial-time inverter for the one-way function.

The obvious repair is to pack all lengths into one fixed marginal

$$
P=\sum_n \mu_n U_n .
$$

This destroys the weak lower bound. If a size-$n$ concept is active only on the
length-$n$ block and all proper concepts agree on the other blocks, then a
wrong length-$n$ seed has global error only $\mu_n/2$ against the target. Since
$\mu_n\to 0$, this is far below the allowed realizable weak error
$1/2-\gamma_P(n)$ for all large $n$. The learner can output an arbitrary legal
seed of the right length and satisfy the target without inverting.

Letting the size-$n$ concept act on a tail of lengths does not fix the issue:
every fixed probability distribution has tail mass tending to zero. Eventually
a wrong proper concept that agrees off the tail is still a valid weak handle.
To force inversion in a realizable weak target, the region on which wrong
proper hypotheses lose must have mass nearly $1$, not merely inverse
polynomial mass.

The other repair is to use one shared high-mass domain for all lengths, such as
an infinite fair-bit product space with Walsh/Hadamard characters. That would
restore exact orthogonality for all $n$ at once. But under the atlas convention
that samples are finite encoded transcripts with worst-case running-time
bounds, this becomes a model-boundary construction. On a fixed countably
encoded atomic marginal, most mass lies on a finite set $F$. Among a large
enough family of binary concepts, many candidates agree on $F$, giving strong
positive correlation under $P$ rather than hidden-gap-safe orthogonality. This
is the finite-atom version of the shared-code obstruction in
[[properization-open|Properization Open]].

Thus the Hadamard-image gadget proves the right local phenomenon:

> improper weak realizable prediction can be easy because the learner recovers
> an external parity vector, while proper weak prediction is hard because
> projecting that vector back into $\mathcal C$ is one-way inversion.

It does not yet produce the required single finite-encoded fixed marginal.

### Hard-Neutralizer Variant

I also tested whether the high-noise branch can be made to fail more directly
by removing constants and making every legal neutralizer certificate-gated.
The intended construction would have:

1. an improper lookup or parity learner for realizable labels;
2. a fixed agnostic distribution $\mathcal D_z$ under one marginal $P^\star$;
3. one good proper certificate concept for $z$; and
4. every efficiently findable non-certificate proper concept below the weak
   agnostic correlation threshold.

The correlation threshold makes this harder than it sounds. In the high-noise
regime the target only requires

$$
\mathbf E[h(X)Y]\ge M(\mathcal D_z)+2\gamma_{P^\star}(s)-1,
$$

and the right-hand side may be negative. A wrong proper hypothesis with
near-zero correlation is then already a legal neutralizer. Therefore removing
constants is insufficient. A false witness must either make near-zero legal
hypotheses computationally hard to find, or make every non-certificate legal
hypothesis substantially anti-correlated with the labels.

The anti-correlation route runs into the same fixed-marginal geometry as the
Hadamard route, but in a stricter form. A large family in which every wrong
proper concept is negatively correlated with each hidden target cannot be
packed into one finite-encoded fixed marginal without either low-mass slices or
high-agreement atoms. If the construction instead says that every legal
representation must carry a hard certificate, it risks becoming a representation
pathology: either the semantic functions collapse to an easy concept with some
fixed legal representation, or evaluation/membership in the class is itself
hiding the hard search problem rather than proving a learning separation.

So the hard-neutralizer idea remains diagnostic, not atlas-ready. It clarifies
what a real false witness must show: even statistically adequate legal
neutralizers or weak handles may exist, but finding any of them must be hard
under one fixed marginal.

### Requirements For A Real False Witness

A concrete atlas-ready counterexample now seems to need all of the following.

1. **Uniform improper source.** One algorithm must weakly learn realizable
   labels improperly for every marginal. The cleanest way is containment in an
   efficiently learnable improper superclass, such as parity vectors or sparse
   lookup tables, with a worst-case polynomial transcript bound.

2. **One fixed hard marginal.** The lower bound must use a marginal
   $P^\star$ independent of the challenge instance and challenge length. A
   family of marginals $P_z$ or $P_n$ is absorbed by marginal nonuniformity.

3. **Hidden-gap robustness.** The construction must defeat an alleged target
   learner whose advantage is only known to be some inverse polynomial
   $\gamma_{P^\star}(s)$. Beating one advertised exponent is not enough.

4. **No easy legal weak handles.** For realizable labels, every efficiently
   findable non-witness proper hypothesis must have correlation below
   $2\gamma_{P^\star}(s)$. For high-noise agnostic labels, it must fall below
   the possibly negative threshold $M+2\gamma_{P^\star}(s)-1$.

5. **Finite-encoded support audit.** The hard mass cannot vanish with the
   target size, and the construction cannot rely on an atomless infinite
   product domain unless the atlas model is intentionally broadened.

No checked PCP, sparse image-coordinate, dense code, or certificate-gated
neutralizer construction satisfies all five items.

### Updated Verdict

Still `unresolved`; keep the edge `open` with `evidence: unknown`.

The one-length Hadamard-image gadget is the strongest concrete false-witness
stress test found in this pass. It exactly realizes "improper source holds but
proper selector fails" at a fixed length. The obstruction is making that local
phenomenon live under one finite-encoded fixed marginal without giving the
weak proper learner arbitrary wrong-seed handles.

No atlas file should be changed on the basis of this pass.

### Depth-5 Directions

1. **Model-boundary theorem.** Write the one-length Hadamard-image construction
   as a separate diagnostic lemma: under length-indexed marginals it would
   refute properization, but marginal-nonuniformity blocks the cryptographic
   reduction.

2. **Finite-atom barrier lemma.** Formalize the claim that one fixed countably
   encoded marginal cannot support hidden-gap-safe Hadamard behavior for an
   unbounded hard family. The proof should truncate to a finite high-mass set
   and use pigeonhole or Gram-matrix bounds.

3. **Computational weak-handle hardness.** Look for a fixed marginal where
   wrong weak handles exist but are hard to find. This is the remaining escape
   hatch from the finite-geometry barrier.

4. **Shared-domain PCP/CSP selectors.** Revisit fixed-marginal PCP or
   Label-Cover gadgets with the challenge encoded in labels on a common
   constant-mass domain. The needed property is that every weakly valid proper
   output decodes the witness, including outputs that would otherwise serve as
   near-zero neutralizers.

5. **High-noise anti-neutralizer construction.** Try to build a certificate
   class where producing any legal hypothesis with correlation above a negative
   threshold is hard, while realizable labels remain improperly weakly
   learnable. The main risk to rule out is semantic collapse to an easy proper
   representative.

### References Rechecked

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved
confidence: medium-high

---

## Depth-5 Follow-Up: One-Way Handles, Neutralizer Limits, And Selector Conditions

- depth: 5
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high that the current atlas edge should remain open; medium-low
  on the edge's ultimate mathematical truth
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

### Focus

This pass followed the three remaining routes after the depth-4
Hadamard/image selector failed as an atlas-ready fixed-marginal witness:

1. modify one-way image-coordinate examples with weak handles that are easy
   improperly but hard properly;
2. force the high-noise or middle-noise proper neutralizer itself to be hard;
3. state the strongest conditional positive theorem with explicit selector
   assumptions.

I still do not have a proof or counterexample. The best conclusion is sharper:
the natural one-way handle modifications either leak legal weak handles or
fall back into the all-length fixed-marginal obstruction; the neutralizer route
cannot be purely statistical because the target threshold is too permissive;
and the conditional theorem is clean but uses a genuine extra
representation-level search principle not implied by the source node.

### Route 1: One-Way Weak-Handle Modifications

The tempting repair is to keep the depth-4 one-way image idea but add handles
that make the source weakly learnable under arbitrary marginals while leaving
proper handle discovery as hard as inversion.

The simplest version is an image-level handle. A target seed $s$ exposes an
easy external descriptor $y=f(s)$. An improper learner may output a hypothesis
indexed directly by $y$, while a proper learner must output a seed $t$ with
$f(t)=y$. At one length, the Hadamard character construction realizes exactly
this:

$$
c_s(r)=(-1)^{\langle f(s),r\rangle}.
$$

Realisable improper learning is efficient because the learner solves for the
external parity vector. Proper weak learning under the uniform length-$n$
Hadamard marginal inverts because every wrong image is orthogonal to the
target. This is still only a one-length witness. Using marginals $U_n$ indexed
by length is absorbed by marginal nonuniformity, and packing the lengths into
one finite-encoded marginal assigns length $n$ a mass $w_n\to 0$, so a wrong
same-length or wrong-length legal concept only loses $w_n/2$ globally. That is
far below the weak threshold for large $n$.

A second version tries seed-gated sparse handles. For example, a proper handle
could be a singleton or small positive set determined by $f(s)$, but the legal
representation still requires a preimage seed. Improperly, the learner can
memorize or output the image-level singleton. Properly, producing the same
handle would invert. This also does not give a weak fixed-marginal
counterexample. Sparse concepts make default behavior too useful: wrong seeds,
wrong lengths, or concepts agreeing on the inactive region can have error well
below $1/2$ without identifying $f(s)$. Adding ordinary constants or all
singletons makes this explicit and recovers the known weak-handle class, which
is weakly properly learnable.

A third version balances the handles so that defaults are not useful. But once
the handle is balanced on a high-mass shared domain, the construction is back
to the shared-code problem. Polynomial shared codes leave inverse-polynomial
wrong correlations, and the target learner's hidden gap
$\gamma_P(s)$ may be smaller. Exact Hadamard-style safety works at a fixed
length, but making it work for all lengths under one finite-encoded marginal
requires either tail events with vanishing mass or an all-length orthogonal
system outside the present finite-transcript model.

So the one-way weak-handle idea remains the best diagnostic for why
properization can fail locally, but I do not see an atlas-ready fixed-marginal
variant. The route needs a genuinely new property: every efficiently findable
proper weak handle under one fixed marginal should decode the one-way
preimage, while the improper source still has a uniform polynomial learner for
all marginals.

### Route 2: Proper Neutralizer Impossibility Audit

The high-noise branch is a poor place to force a separation unless the
construction is computational, not merely geometric.

Use $\{\pm1\}$ labels and write

$$
M_{\mathcal D}=\sup_{c\in\mathcal C}\mathbf E[c(X)Y].
$$

The target asks for a proper $h$ with

$$
\mathbf E[h(X)Y]\ge M_{\mathcal D}+2\gamma_P(s)-1.
$$

When $M_{\mathcal D}$ is not close to $1$, this lower bound can be negative.
Thus a near-zero-correlation proper hypothesis is already enough. Constants,
complement pairs, singleton handles, unrelated satisfiable proofs, random
balanced concepts, or any efficiently sampleable legal family with pointwise
mean near zero usually give a neutralizer by validation.

Trying to remove all such neutralizers asks for something very strong. If the
only useful proper output is a certificate concept, then every non-certificate
proper concept must be almost maximally anti-correlated with the labels, or at
least every polynomial-time method for finding a non-certificate near-zero
concept must be hard. The first demand runs into the same Plotkin/Hadamard and
finite-atom geometry as depth 4. The second demand is possible in spirit, but
it is no longer a neutralizer-impossibility theorem from the source node. It is
a proper agnostic search hardness theorem under one fixed marginal.

There is also a representation pitfall. One can define legal representations
that syntactically contain a hard certificate even for semantically simple
functions. But if several representations compute the same easy function, an
easy legal representative may count as proper. If the semantics are made
distinct, the proof must again show that no weakly adequate easy function
remains and that the source learner still works for every marginal.

Conclusion for this route: missing constants are not enough, and even missing
balanced samplers are not enough. A false witness must show fixed-marginal
computational weak-handle hardness: statistically adequate proper neutralizers
or weak handles may exist, but finding any one of them should recover a hard
witness.

### Conditional Positive Theorem With Explicit Selector Assumptions

The clean positive statement is conditional. It should not be read as a proof
of the atlas edge, because the assumptions below are exactly the missing
proper-search objects.

Fix a marginal $P$ and size parameter $s$. Let the source learner have
$P$-dependent sample/time bound $m_P(s)$ and realizable advantage
$\rho_P(s)$. Choose inverse-polynomial scales

$$
0<\kappa_P(s)\ll \alpha_P(s)\ll \min\{\rho_P(s),1/m_P(s)\}.
$$

Assume there are single uniform algorithms, with only their analysis allowed
to have $P$-dependent polynomial bounds, satisfying the following two
properties.

**Proper neutralizer list.** Given labeled samples from any joint distribution
$\mathcal D$ with marginal $P$, the neutralizer algorithm generates a
polynomial-size list $L_N\subseteq\mathcal C$ such that, whenever
$M_{\mathcal D}\le 1-4\alpha_P(s)$, with high probability some
$h\in L_N$ satisfies

$$
\mathbf E[h(X)Y]\ge M_{\mathcal D}+2\kappa_P(s)-1.
$$

A sufficient special case is a validation-searchable list containing a concept
with correlation at least $-\alpha_P(s)$ whenever
$M_{\mathcal D}\le 1-4\alpha_P(s)$.

**Low-noise proper selector.** Given samples from $P$ and oracle/code access to
an external predictor $g$, the selector algorithm generates a polynomial-size
list $L_S\subseteq\mathcal C$ with the following guarantee. For every
$c^\star\in\mathcal C$, if

$$
\mathbf E[g(X)c^\star(X)]\ge \rho_P(s)/2,
$$

then with high probability some $h\in L_S$ satisfies

$$
\mathbf E[h(X)c^\star(X)]\ge 4\kappa_P(s).
$$

This selector can be replaced by any equivalent fixed-$P$ approximate proper
ERM, computable weak proper cover, or projection from external predictors to
legal concepts.

Under these assumptions, the target follows. In the low-noise regime, choose
$c^\star$ with error $\eta\le \alpha_P(s)$ and use the marginal-preserving
clean-transcript coupling from the improper robustification proof. With
inverse-polynomial probability a run of the source learner sees a clean
realizable transcript for $c^\star$ under the original marginal $P$, so it
outputs an external $g$ with noticeable correlation with $c^\star$. Feeding
that $g$ to the selector gives a legal list containing an $h$ with positive
correlation with $c^\star$, and the small label noise reduces correlation with
$Y$ by at most $2\eta$. With constants chosen above, this beats the target
threshold for final gap comparable to $\kappa_P(s)$.

In the complementary regime
$M_{\mathcal D}\le 1-4\alpha_P(s)$, the neutralizer list already contains a
valid legal candidate. Run the source learner enough times to obtain the
low-noise candidates, run the selector on their external predictors, add the
neutralizer list, and validate all legal candidates on fresh samples. Uniform
convergence over this polynomial list selects a hypothesis satisfying the weak
agnostic proper guarantee with gap, say, $\kappa_P(s)/10$.

This theorem is useful because it names the missing assumptions. It also
explains why natural positive examples work: constants, complements,
pointwise-balanced proper samplers, known proper ERM routines, and
searchable fixed-marginal weak covers instantiate the neutralizer or selector.
But none of these follows from efficient marginal-nonuniform weak realizable
improper learning alone. The source supplies external prediction on realizable
labels; it does not supply legal candidate generation.

### Updated Verdict

Still `unresolved-open`; keep the atlas edge `open` with
`evidence: unknown`.

Depth 5 did not find an atlas-ready false witness. The final promising
negative route is no longer "make wrong concepts absent." It is
fixed-marginal computational weak-handle hardness: every efficiently found
proper weak output should decode a hard certificate, while an improper learner
can still obtain an external descriptor for every marginal. The final
promising positive route is the conditional selector theorem above, but that
theorem uses exactly the extra proper neutralizer or projection structure the
source node does not provide.

No atlas file should be changed on the basis of this pass.

### Final Depth-6 Directions

1. **Wrong-output usefulness gadget.** Search for a fixed-marginal construction
   where every proper hypothesis meeting even an inverse-polynomial weak
   threshold can be converted into a witness or preimage. This is weaker than
   demanding that all wrong concepts be anti-correlated.

2. **Computational handle hardness.** Allow weak handles to exist
   statistically, but make finding any validation-useful legal handle under
   the fixed marginal as hard as the target search problem. The proof must
   avoid semantic collapse to an easy legal representative.

3. **Formal selector theorem.** Promote the conditional theorem here to a
   reusable argument note with named hypotheses:
   `proper-neutralizer-list` and `low-noise-proper-selector`. This will keep
   future positive claims honest about the extra search principle they use.

4. **Finite-marginal handle dichotomy.** Try to prove a barrier saying that
   broad syntactically sampleable concept families either provide
   validation-findable neutralizers or must encode the hard instance in a way
   that breaks the improper source or varies the marginal.

5. **Model-boundary audit for Hadamard products.** Recheck whether the atlas
   intentionally excludes atomless or infinite-random-string examples. If that
   model were allowed, the all-length Hadamard image route might become a real
   counterexample; under finite encoded transcripts it remains diagnostic.

6. **Fixed-gap variants.** Shared-code and readable-hint constructions may
   separate variants where the weak advantage is fixed in advance. Do not use
   them for this hidden-gap marginal-nonuniform edge without an all-exponents
   argument that survives the representation-size accounting.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: high for keeping the atlas edge open; medium-low for the ultimate
truth of the implication

## Depth-6 Final Follow-Up: Closure Without Resolution

- depth: 6
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high for keeping the atlas edge open; medium-low for the
  ultimate mathematical truth of the implication
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

### Final Decision

This final pass still does not resolve the edge. The atlas implication should
remain

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
```

The positive proof is blocked by legal candidate generation. The source gives
external prediction on realizable labels, with a marginal-dependent
polynomial analysis for one uniform learner. It does not give marginal-specific
advice, a proper ERM oracle, a computable fixed-marginal cover by valid
concepts, or a projection from external weak predictors back into
`C`.

The negative proof is blocked by the hidden weak-gap and fixed-marginal
requirements. To refute the target, a witness must make every polynomial-time
proper learner fail to obtain any inverse-polynomial weak advantage under one
fixed marginal. Current PCP active-slice, one-way image-coordinate,
Hadamard-image, and weak-handle routes either vary the marginal with the hard
instance, dilute the hard slice below the weak scale, or leak validation-useful
proper handles.

A live primary-source check did not change this. Hanneke, Moran, and
Thiessen's marginal-nonuniform paper still supports the quantifier pattern used
here: the rate may depend on the marginal, but one algorithm must work
uniformly over target concepts for that marginal. Recent computability and
class-specific properization papers are adjacent, but they do not supply a
polynomial-time PAC theorem turning an arbitrary improper marginal-nonuniform
weak learner into a proper one.

### Atlas-Ready Open Note Update

If atlas edits are later allowed, the current edge note can be sharpened to the
following text without changing its status.

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: marginal-preserving low-noise robustification gives the agnostic improper part, but the proper target still requires fixed-marginal legal candidate generation; no source-only neutralizer/selector theorem or fixed-marginal weak-handle counterexample is known."
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested body:

```markdown
## Verdict

`open`.

This is the weak marginal-nonuniform properization edge with an additional
realizable-to-agnostic relaxation. The agnostic improper part is not the main
obstruction: a marginal-preserving low-noise coupling can robustify the weak
realizable improper source to weak agnostic improper prediction. The remaining
problem is proper output. In the low-noise branch the source produces an
external predictor weakly correlated with a near-optimal concept
$c^\star\in\mathcal C$, but the source gives no efficient procedure for
finding any legal $h\in\mathcal C$ with comparable weak correlation. In the
high-noise branch the weak agnostic threshold is so permissive that a legal
near-zero-correlation neutralizer would suffice, but the source also gives no
generic way to generate such a legal concept.

Known false-witness templates remain near misses. PCP active-slice hardness
creates weak proper hardness only by making the hard marginal depend on the
input instance; packing those slices into one fixed marginal dilutes the gap
below the hidden inverse-polynomial weak scale. One-way image-coordinate
classes force proper recovery only for strong accuracy; at weak accuracy,
wrong-length concepts, constants, singletons, sparse handles, or residual code
correlations can be valid proper outputs without inversion. Fixed-marginal
PCP, clause-selector, and shared-code repairs would need the stronger property
that every efficiently findable weak proper output decodes the hard witness,
for every inverse-polynomial weak scale relevant to the marginal-nonuniform
target. No current construction provides this while preserving the improper
source for all marginals.

Thus the edge remains open pending either a generic fixed-marginal proper
selector/neutralizer theorem or a fixed-marginal computational weak-handle
hardness construction.
```

### Exact Conditional Selector Assumptions

The clean conditional positive theorem should be stated with explicit extra
search assumptions. These assumptions are not implied by the source node.

Use labels in $\{\pm 1\}$. For a joint distribution $\mathcal D$ with marginal
$P$, write

$$
M_{\mathcal D}=\sup_{c\in\mathcal C}\mathbf E[c(X)Y].
$$

Fix $P$ and representation size $s$. Let the source weak realizable improper
learner have marginal-dependent sample/time bound $q_P(s)$ and realizable
correlation advantage $\rho_P(s)$, meaning error at most
$1/2-\rho_P(s)$, equivalently correlation at least $2\rho_P(s)$. Choose
inverse-polynomial scales, under $P$-dependent polynomials,

$$
0<\kappa_P(s)\le \alpha_P(s)/10,\qquad
\alpha_P(s)\ll \min\{\rho_P(s),1/q_P(s)\}.
$$

Assume there are single uniform algorithms, with only their analyses allowed
to have $P$-dependent polynomial bounds, satisfying the following.

**Proper neutralizer list.** Given labeled samples from any
$\mathcal D$ with marginal $P$, output a polynomial-size list
$L_N\subseteq\mathcal C$. If

$$
M_{\mathcal D}\le 1-4\alpha_P(s),
$$

then with high probability some $h\in L_N$ satisfies

$$
\mathbf E[h(X)Y]\ge M_{\mathcal D}+2\kappa_P(s)-1.
$$

A sufficient special case is a validation-searchable list containing a legal
$h$ with $\mathbf E[h(X)Y]\ge-\alpha_P(s)$ in this regime, since then
$M_{\mathcal D}+2\kappa_P(s)-1\le -3\alpha_P(s)$.

**Low-noise proper trace selector.** Given labeled samples from
$\mathcal D$ with marginal $P$ and oracle/code access to an external predictor
$g$, output a polynomial-size list $L_S\subseteq\mathcal C$. If
$M_{\mathcal D}>1-4\alpha_P(s)$ and there is a near-optimal
$c^\star\in\mathcal C$ with

$$
\mathbf E[c^\star(X)Y]\ge M_{\mathcal D}-\kappa_P(s)
$$

such that

$$
\mathbf E[g(X)c^\star(X)]\ge \rho_P(s)/2,
$$

then with high probability some $h\in L_S$ satisfies

$$
\mathbf E[h(X)c^\star(X)]\ge 4\kappa_P(s).
$$

The earlier "samples from $P$ plus $g$" selector is a stronger special case.
The labeled low-noise trace selector above is the minimal form needed for the
conditional theorem, because it may use the nearly clean labels to decide which
legal trace of $\mathcal C$ to search for.

**Validation over legal lists.** Given the union of the neutralizer list and
the selector lists from repeated source runs, fresh labeled samples from
$\mathcal D$ allow empirical validation over a polynomial-size set of legal
candidates.

Under these assumptions the target follows with final weak gap comparable to
$\kappa_P(s)$. If $M_{\mathcal D}\le 1-4\alpha_P(s)$, the neutralizer list
already contains a valid candidate. If $M_{\mathcal D}>1-4\alpha_P(s)$, choose
$c^\star$ with $\mathbf E[c^\star Y]\ge M_{\mathcal D}-\kappa_P(s)$. The
label noise relative to $c^\star$ is $O(\alpha_P(s))$, so the
marginal-preserving coupling makes a repeated source run produce, with
inverse-polynomial probability, an external predictor $g$ correlated with
$c^\star$. The selector gives $h$ with
$\mathbf E[h c^\star]\ge4\kappa_P(s)$, and since

$$
\mathbf E[hY]\ge \mathbf E[h c^\star]-1+\mathbf E[c^\star Y],
$$

this yields

$$
\mathbf E[hY]\ge M_{\mathcal D}+3\kappa_P(s)-1
  \ge M_{\mathcal D}+2\kappa_P(s)-1.
$$

Validation selects such an $h$ up to constant-factor slack.

### Exact Future Routes

No further depth on this exact scratchpad should be useful without a new
ingredient. The remaining routes are now precise:

1. **Fixed-marginal computational weak-handle hardness.** Build one fixed
   marginal $P^\star$ and a source-positive class such that any polynomial-time
   method finding a proper hypothesis with inverse-polynomial correlation under
   $P^\star$ can be converted into a hard witness or preimage. This must rule
   out all inverse-polynomial weak handles, not merely handles above one fixed
   exponent.

2. **All-exponents shared-domain selector gadgets.** Find a PCP, direct-product,
   or code construction where wrong proper certificates have correlation below
   every inverse-polynomial scale relevant to the representation size, while
   examples remain finite-encoded and the improper source stays polynomial-time
   under every marginal.

3. **Finite-encoded marginal barrier.** Prove a no-go theorem explaining why
   all-length Hadamard or shared-code witnesses over finite transcripts must
   either put hard information on low-mass tails or leak short-prefix/default
   proper handles.

4. **Reusable conditional argument note.** If pursuing the positive side,
   promote the theorem above to an atlas argument note with named hypotheses
   `proper-neutralizer-list` and `low-noise-proper-trace-selector`, so future
   class-specific positive claims state exactly which extra proper-search
   structure they use.

5. **Model-boundary audit.** Revisit the one-way Hadamard image route only if
   the atlas allows atomless product samples, oracle-valued infinite random
   strings, or another representation model where every hard length can retain
   high marginal visibility without short-prefix handles.

### Final References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*:
  https://openreview.net/forum?id=aoVCFtox89
- Brattka and Chirache, *Uniform Computability of PAC Learning*:
  https://arxiv.org/abs/2601.18663
- Diakonikolas, Kane, Kontonis, Tzamos, and Zarifis,
  *Agnostic Proper Learning of Halfspaces under Gaussian Marginals*:
  https://arxiv.org/abs/2102.05629

verdict: unresolved-open
confidence: high for keeping the atlas edge open; medium-low for the ultimate
truth of the implication
