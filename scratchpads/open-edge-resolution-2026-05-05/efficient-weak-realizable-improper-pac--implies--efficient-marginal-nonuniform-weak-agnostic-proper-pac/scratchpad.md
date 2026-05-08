# Edge: efficient-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- source: `efficient-weak-realizable-improper-pac`
- target: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- family: `properization-open`
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

## Bottom Line

I do not have an atlas-ready proof or counterexample. Keep the edge
`status: "open"` with `evidence: unknown`.

The source gives a distribution-free weak realizable learner, but its output
may be outside $\mathcal C$. By ordinary realizable boosting and the atlas
low-noise robustification argument, this is enough to get a weak agnostic
improper predictor with an inverse-polynomial gap. The assigned target asks
for more representational structure: under each fixed marginal $P$, output a
proper $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s)
$$

for some $P$-dependent inverse-polynomial advantage $\gamma_P$.

The unresolved step is fixed-marginal weak properization:

$$
\text{external weak prediction}
\quad\Longrightarrow ?\quad
\text{efficiently find a weakly good represented concept.}
$$

I checked the PCP active-slice, one-way image-coordinate, bounded-handle, and
proper-neutralizer/finite-trace routes. The known witnesses remain near misses.
They either put the hard instance into the marginal, require a strong accuracy
parameter, or leak proper weak handles such as constants, wrong slices,
wrong lengths, singleton/bounded positive handles, finite-prefix trace
representatives, or residual code correlations.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

Sibling scratchpads checked:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`

Primary-source anchors as recorded in the atlas notes:

- Valiant 1984 and Schapire 1990 for realizable PAC learning and weak-to-strong
  boosting by improper aggregation.
- Håstad and Khot 2005, with Karp 1972, for the logarithmic-randomness,
  perfect-completeness PCP active-slice template.
- Kearns and Valiant 1994 and Håstad-Impagliazzo-Levin-Luby 1999 for the
  one-way-function learning-hardness background.
- Benedek-Itai 1991, Ben-David-Benedek-Mansour 1995, and Hanneke-Moran-
  Thiessen 2025 for the marginal-nonuniform quantifier pattern.
- Plotkin 1960, McEliece-Rodemich-Rumsey-Welch 1977, and Guruswami-Vadhan
  2010 for the code/list-decoding obstruction summarized in
  `properization-open.md`.

## Definition Check

The source says that, for realizable labels $(X,c(X))$ under an arbitrary
marginal $D$, one uniform polynomial-time learner outputs an arbitrary
hypothesis $g$ with

$$
\operatorname{err}_D(g,c)\le \frac12-\gamma(s),
$$

where $\gamma$ is inverse-polynomial in the representation-size parameter.
The output need not be a member of $\mathcal C$.

The target says that one uniform learner must work for every joint
distribution $\mathcal D$ and output $h\in\mathcal C$. For each fixed marginal
$P=\mathcal D_X$, the runtime polynomial and weak additive gap may depend on
$P$, but not on the target concept or conditional label rule.

In particular, on realizable labels the target implies
`efficient-marginal-nonuniform-weak-realizable-proper-pac`. Therefore any
counterexample to the realizable weak proper target would refute this edge.
That realizable weak properization edge is itself still open in the checked
notes.

## Positive Route

The source gives good external prediction. By Schapire-style boosting, weak
realizable improper learning gives strong realizable improper prediction, but
the boosted vote is generally still outside $\mathcal C$. The low-noise
robustification note then gives weak agnostic improper prediction:

1. If $\operatorname{OPT}_{\mathcal C}$ is very small, run the realizable
   learner on fresh batches. With inverse-polynomial probability, the sampled
   transcript is clean relative to a near-best $c^\star\in\mathcal C$.
2. If $\operatorname{OPT}_{\mathcal C}$ is not small, a constant external
   classifier has error at most $1/2$ and is within
   $\operatorname{OPT}_{\mathcal C}+1/2-\alpha$.
3. Validate the improper candidates and constants.

This proves the corresponding improper target, not the assigned proper one.
The clean-batch branch outputs whatever the source learner outputs, which may
be external. The high-OPT branch uses constants, which need not be legal
concepts. Thus even the robustification proof exposes the same missing object:
a proper weak selector or proper neutralizer.

A conditional positive lemma would suffice:

> For each fixed marginal $P$, suppose there is one uniform procedure with
> $P$-dependent polynomial runtime which, from samples and optional evaluation
> access to a good external predictor, returns a finite list of concepts in
> $\mathcal C$ containing some $h$ with inverse-polynomial advantage over the
> labels or over a near-best $c^\star$. Then the source plus validation gives
> the target.

This is not implied by the source. The source may learn by memorizing a sparse
support, solving a relaxed linear problem, outputting a parity vector, or
building an aggregate vote, none of which provides a valid concept
representation.

## Counterexample Route 1: PCP Active Slices

The PCP active-slice class is the right witness for the distribution-free weak
properization sibling. A proper concept is indexed by an NP instance $\varphi$
and a proof $\pi$; on the active slice for $\varphi$, it outputs the verifier
decision. The active slice has polynomial size, so an improper learner can
memorize positive sampled points and predict $0$ elsewhere.

For a distribution-free weak proper target, the lower bound samples uniformly
from the active slice of the input formula and labels every example by $1$.
Perfect completeness makes satisfiable instances realizable by a proof
concept, while soundness below $1/2$ means no proof concept has weak advantage
for unsatisfiable instances.

This does not refute the assigned target.

- The hard marginal $P_\varphi$ depends on the input formula. In a
  marginal-nonuniform target, the polynomial $p_{P_\varphi}$ and the weak gap
  may depend on that very marginal, so the reduction no longer yields a
  uniform polynomial-time SAT algorithm.
- Packing all formula slices into one fixed marginal multiplies the local PCP
  gap by the slice mass $w_\varphi$. One fixed distribution cannot give
  inverse-polynomial mass to exponentially many formulas of a given length.
- Low-mass slices leak weak handles: a wrong-slice proof concept or an
  almost-zero proper concept can have global error far below $1/2$ while
  saying nothing about $\varphi$.
- Removing the identity coordinate creates wrong-instance handles: unrelated
  satisfiable instances can supply high-acceptance proper concepts on a shared
  verifier-randomness domain.

Thus PCP active slices show the properization obstruction is real, but their
standard form is absorbed by marginal nonuniformity and weak additivity.

## Counterexample Route 2: One-Way Image Coordinates

The ordinary one-way image-coordinate class satisfies a stronger improper
source. A length-$n$ seed $s$ exposes the bits of $f(s)$ on $n$ positive atoms.
Improper memorization learns realizably, and sparse lookup ERM even supports
nearby agnostic improper sources.

The fixed-marginal strong proper lower bound is clean. Under the all-length
coordinate marginal with block mass

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

accuracy $\varepsilon_n=\mu_n/(3n)$ forces a proper output to have the same
length and same one-way image as the target. A strong proper learner would
therefore invert the one-way function.

This does not refute the weak agnostic proper target.

- The weak target has no accuracy parameter. It only promises some hidden
  inverse-polynomial advantage over $1/2$.
- The length-$n$ hard block has mass $\mu_n\to0$. A wrong-length seed, a
  low-mass block, or an almost-default concept can already have excellent weak
  global error without recovering $f^{-1}(f(s))$.
- Concentrating the marginal on the length-$n$ block makes weak correlation
  meaningful, but then the marginal varies with $n$, and the target's
  $P$-dependent polynomial can vary with it.

The weak-handle variant records the boundary exactly. Adding constants and
singleton or bounded positive-atom handles makes weak proper learning easy,
including fixed-additive weak agnostic variants, while strong fixed-marginal
proper learning still forces one-way inversion. Those handles are therefore
positive evidence for the target, not a separation for this edge.

## Counterexample Route 3: Bounded Handles And Proper Neutralizers

The low-noise robustification needs two kinds of fallback:

- in the low-OPT regime, a proper concept near the nearly clean target;
- in the moderate/high-OPT regime, a proper neutralizer with error at most
  roughly $1/2$ against arbitrary labels.

Constants, complements of an anchor, singleton handles, bounded positive-atom
handles, and finite-trace representatives can all serve this role in special
classes. The one-way weak-handle class uses exactly this phenomenon.

But these objects are not forced by `efficient-weak-realizable-improper-pac`.
The source learner may never output a valid concept, and the class may not
contain constants or a complement operation. Conversely, adding cheap proper
neutralizers tends to make the assigned target true for the witness, destroying
the separation.

The finite-trace observation from the neighboring scratchpads is a useful
semantics boundary. If the fixed marginal is countably supported, proper
descriptions are recursively enumerable, and the fixed marginal's finite search
constants can be absorbed into $p_P$, then one can choose a finite
high-mass set $F$ and enumerate representatives of all realized traces
$c|_F$. This would give weak marginal-nonuniform proper learning, often without
using the improper source. The atlas definitions do not currently state enough
enumerability/evaluation/stopping semantics to turn this into a theorem, but
it blocks many would-be counterexamples whose hardness lives on a constant-mass
finite prefix.

## Counterexample Route 4: Dense Or Hadamard Image Codes

At one fixed length, a Hadamard image construction has exactly the desired
geometry. Define

$$
c_s(r)=\langle f(s),r\rangle \pmod 2,\qquad r\in\{0,1\}^n.
$$

An improper learner can recover the external parity vector $f(s)$ by Gaussian
elimination. Under the uniform length-$n$ marginal, distinct parity codewords
are orthogonal, so any proper hypothesis with any positive advantage must have
the same one-way image and hence invert.

This still does not yield an atlas-ready fixed-marginal counterexample.

- If the marginal is the uniform length-$n$ marginal, the marginal depends on
  $n$.
- If lengths are mixed into one fixed finite-string marginal, the length-$n$
  block has tail mass $\mu_n\to0$ and weak global handles return.
- If an infinite product marginal is used to get exact orthogonality at all
  lengths, the construction leaves the atlas finite-encoded transcript
  convention.
- If polynomial-length dense codes replace exact Hadamard codes, wrong-code
  correlations remain at some inverse-polynomial scale. The target's hidden
  advantage may be smaller than that scale, making the wrong codeword a legal
  weak proper output.

A false witness along this route would need a stronger primitive than ordinary
one-wayness: hardness of finding any proper seed whose public codeword has
inverse-polynomial positive correlation with the hidden image under one fixed
finite-encoded marginal, while improper weak agnostic prediction remains
efficient under arbitrary marginals.

## Why No Existing False Edge Transfers

Known false edges do not imply this one by monotonicity.

- `efficient-weak-realizable-improper-pac -> efficient-weak-realizable-proper-pac`
  is false by PCP active slices, but the target there is distribution-free.
  The assigned target allows marginal-dependent rates and gaps.
- `efficient-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`
  is false by one-way image coordinates, but that target is strong and has an
  accuracy parameter. The assigned target is weak.
- Edges from weak agnostic improper sources to this same weak agnostic proper
  target are also unresolved in the checked scratchpads, so strengthening the
  source to agnostic improper has not yet solved the properization issue.
- Sample-efficient analogues are true only because unbounded ERM can search
  $\mathcal C$. This computational edge is precisely about whether that search
  can be done in polynomial time.

## Proposed Atlas State

No atlas edit is justified by this pass. Keep the current shape:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested summary if edits are later allowed:

```yaml
summary: "Open: weak realizable improper learning robustifies to weak agnostic improper prediction, but no generic efficient fixed-marginal projection to even a weak proper concept is known; PCP, one-way, bounded-handle, and code-based witnesses either vary the hard marginal, require strong accuracy, or leak weak proper handles."
```

Suggested body sketch:

```markdown
`open`.

The source supplies external weak prediction and, via boosting plus low-noise
robustification, weak agnostic improper prediction. The target requires a
represented member of $\mathcal C$. A positive proof would need a
fixed-marginal weak proper selector, approximate proper ERM, computable
$L_1(P)$ cover by valid concepts, or proper neutralizer/projection oracle.
Such structure is not implied by the abstract improper source.

Known false witnesses are near misses. PCP active slices refute the
distribution-free weak proper target, but their hard marginal depends on the
input instance and packed slices lose weak visibility. One-way image-coordinate
classes force proper recovery only at strong accuracy under the fixed
coordinate marginal; at the weak threshold, wrong lengths and bounded handles
are legal outputs. Hadamard image codes work at one fixed length or in an
atomless product model, but a single finite-encoded all-length marginal
reintroduces tail mass or residual code-correlation handles.
```

## Obstacles

1. **Prediction is not representation search.** The source can learn an
   external predictor without giving any way to output a concept description.

2. **Low-noise robustification remains improper.** Clean-batch runs output the
   source learner's hypothesis, and high-OPT fallback constants need not be
   concepts.

3. **Marginal-dependent hard instances are shielded.** PCP and DNF-style
   reductions that choose a marginal from the input instance are absorbed by
   the target's $P$-dependent polynomial and gap.

4. **Packed slices lose weak visibility.** Local constant gaps become
   $w_\varphi$-scale global gaps, while wrong-slice concepts become weak
   handles.

5. **Strong recovery is not weak hardness.** One-way coordinate witnesses
   invert only when accuracy is requested below the active block mass.

6. **Proper neutralizers are double-edged.** Constants, bounded handles,
   singleton handles, complements, and finite-trace representatives can make a
   class satisfy the target; their absence is exactly what a positive theorem
   cannot assume.

7. **Hidden weak exponent blocks approximate codes.** Dense-code witnesses
   must beat every inverse-polynomial weak gap, not just a chosen scale.

## Depth-2 Directions

1. **Formalize a fixed-marginal weak proper selector lemma.** State conditions
   under which a good external predictor plus samples can be converted into a
   polynomial-size list of proper candidates, and prove source plus selector
   implies the target.

2. **Audit recursive finite-trace semantics.** Decide whether atlas
   computational classes implicitly have recursive proper-description
   enumerations, effective evaluators, and marginal-dependent finite search
   constants. If yes, many weak marginal-nonuniform proper targets may become
   true for semantic reasons.

3. **Search for computational weak-handle hardness.** A counterexample must
   allow weakly correlated proper handles information-theoretically, while
   making every efficiently findable handle decode a hard witness under one
   fixed marginal.

4. **Build an identity-protected shared PCP.** Look for a shared-marginal PCP
   or agreement-test construction where every weakly correlated proper output
   identifies the target instance or proof, without an active-slice marginal.

5. **Quantify the dense-code barrier.** Prove a reusable lemma that polynomial
   coordinate domains leave inverse-polynomial wrong-code correlations, while
   exact all-length orthogonality requires atomless or tail-mass models outside
   the current finite-transcript convention.

6. **Study fixed-gap variants separately.** If a future node asks for a fixed
   constant weak advantage, PCP and polynomial-code witnesses become much
   closer. Under the current inverse-polynomial hidden-gap convention, they do
   not resolve the edge.

verdict: unresolved-open
confidence: medium-high


## Depth 3 Branch: weak improper source to agnostic proper target

depth: 3
date: 2026-05-05
focus: constants, bounded handles, and source-positive target-negative witnesses

### Branch Question

Can the weak realizable improper source be made into the agnostic proper target
by adding only very cheap proper neutralizers, such as constants or bounded
positive handles? Or can one instead build a class where the source remains
positive by an external algebraic/memorization learner, while every proper
weak agnostic learner under one fixed marginal has to solve a hard search
problem?

The agnostic part is not the first obstacle for a negative result. Since the
target must work on realizable distributions, it is enough to find a fixed
marginal $P$ and realizable labels $c^\star\in\mathcal C$ for which no
polynomial-time learner can output any $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c^\star)\le \frac12-\gamma_P(s)
$$

for an inverse-polynomial $\gamma_P$. Constants and handles should therefore
be judged first on balanced realizable targets: if they already give inverse-
polynomial advantage there, they destroy the separation; if they do not, they
also cannot by themselves complete the low-noise branch of a positive proof.

### Neutralizer Accounting

The low-noise robustification proof has two logically different uses of
fallback hypotheses.

1. **High-OPT fallback.** If constants are legal concepts, validation between
   the two constants gives a proper classifier of error at most $1/2$. This
   handles distributions with $\operatorname{OPT}_{\mathcal C}$ larger than
   the desired weak gap. Without constants, complements, or some comparable
   neutralizer, this step is not representation-free.

2. **Low-OPT recovery.** If the labels are close to some
   $c^\star\in\mathcal C$, a clean batch lets the improper source produce an
   external weak predictor for $c^\star$. Constants do not help when
   $c^\star$ is balanced under $P$, and bounded handles help only if samples
   can identify a bounded region on which $c^\star$ carries inverse-polynomial
   $P$-mass.

Thus constants are mainly a high-noise neutralizer. Bounded handles are a
low-noise properization mechanism only for classes whose positive or negative
mass has polynomially visible atoms or small searchable chunks. That is
exactly the double edge seen in the one-way weak-handle witness: once the
handles have enough mass to be found and validated, they tend to prove the
weak proper target rather than separate it.

### Candidate Witness: One-Length Hadamard Image With Tiny Handles

The cleanest source-positive target-negative geometry is still the
single-length Hadamard image construction. For a length-preserving one-way
function $f$, let proper concepts be indexed by seeds $s\in\{0,1\}^n$ and set

$$
c_s(r)=\langle f(s),r\rangle \pmod 2,
\qquad r\in\{0,1\}^n.
$$

Under the uniform marginal on $\{0,1\}^n$, an improper learner can recover the
external parity vector $f(s)$ by linear algebra and output the parity
hypothesis, without finding a preimage seed. This is stronger than the needed
weak realizable improper source at that one length. Properly, however, every
wrong image parity is orthogonal to the target, so any proper hypothesis with
positive correlation must have the same image and hence gives a preimage of
$f(s)$.

This construction also explains how constants and bounded handles should be
calibrated.

- Adding the two constants does not help on the balanced realizable labels:
  each constant has error exactly $1/2$.
- Adding handles for at most $q(n)=\operatorname{poly}(n)$ positive atoms does
  not help under the uniform Hadamard marginal: such a handle has advantage at
  most $q(n)/2^n$, which is below every inverse-polynomial weak gap.
- Therefore, at one fixed length, constants plus polynomially bounded handles
  preserve the proper hardness while the improper source stays efficient.

This is the closest local model of the desired witness. The obstruction is
not the constants or bounded handles; it is the atlas marginal quantifier.

### Why The Local Witness Still Does Not Refute The Edge

If the hard marginal is the uniform distribution on the length-$n$ cube, then
the marginal varies with $n$. The target is marginal-nonuniform, so the
resource polynomial and weak gap are allowed to depend on that fixed marginal.
Using one marginal per challenge length does not give a uniform contradiction.

Packing all lengths into one fixed finite-string marginal reopens the weak
handle problem. If the length-$n$ block has mass $\mu_n$, then a concept that
is harmless or default outside its own block lets constants, wrong lengths, or
low-mass handles obtain global error near $1/2-\Omega(1)$ or at least
$1/2-\operatorname{poly}^{-1}$ without inverting. Making every concept balanced
on the complement of its active block avoids the constant handle but creates
wrong-length agreement handles unless the seed-specific code also lives on a
common large-mass part of the space.

The natural repair is a shared balanced code under one fixed marginal: every
proper seed should be balanced globally, every wrong seed should have
correlation below every inverse-polynomial threshold, and the external image
should remain efficiently learnable from samples. This is exactly the dense-
code branch from the previous pass. In finite-encoded all-length models,
polynomial coordinate domains leave residual inverse-polynomial correlations,
while exact all-length orthogonality wants an atomless/product-style marginal
or an infinite transcript convention. Under the current atlas conventions,
that repair is not atlas-ready.

### Attempted Handle-Hardness Repair

One could try to make weak handles exist information-theoretically but hard to
find computationally. The desired class would have three simultaneous
properties:

1. improper weak realizable learning is easy because examples reveal an
   external codeword or predictor;
2. under one fixed marginal, constants and every efficiently searchable
   bounded handle have advantage below the hidden inverse-polynomial
   $\gamma_P(s)$ on balanced realizable targets;
3. every proper concept with inverse-polynomial positive correlation decodes a
   hard witness, such as a one-way preimage or PCP proof.

The one-length Hadamard image construction has all three properties locally.
The one-way coordinate and weak-handle constructions have the all-length
fixed-marginal form, but lose property 2 because wrong lengths and handles are
already weakly good. PCP active slices have property 3 locally, but lose
property 1 or 2 when slices are packed into one marginal: the hard slice mass
shrinks and unrelated slices become weak handles.

So the right negative witness, if it exists, is not merely "source improper
plus no constants." It must be a computational weak-handle hardness example:
weakly useful proper hypotheses either do not exist at inverse-polynomial
scale under the fixed marginal, or finding any such hypothesis is as hard as
recovering the hidden witness, while an external predictor remains learnable.

### Provisional Conclusion

Constants and bounded handles do not give a black-box positive theorem from
the source. Constants only repair the high-OPT branch, and bounded handles
repair the low-OPT branch only when inverse-polynomial mass is concentrated in
efficiently searchable pieces. But the same objects also frustrate the
standard counterexamples: if handles are visible enough, the target becomes
true; if handles are too tiny to matter, the best hard geometry is the
Hadamard/one-way construction, which has not been made compatible with one
fixed finite-encoded marginal across all lengths.

verdict: unresolved-open
confidence: medium-high
next branches:
- Formalize the one-length Hadamard image plus constants/bounded-handles lemma
  as a diagnostic, explicitly separating the local proper-hardness geometry
  from the failed marginal-nonuniform global step.
- Search for a shared fixed-marginal balanced code with efficient external
  decoding and no inverse-polynomial wrong-code correlations under finite
  transcripts.
- Try a computational weak-handle hardness construction where any efficiently
  findable bounded handle decodes the hidden witness, rather than giving an
  easy proper weak learner.

## Depth 4 Branch: fixed-marginal weak properization versus correlation-inversion

depth: 4
date: 2026-05-05
focus: sharpen the remaining positive and negative routes under the atlas
pathwise finite-transcript convention

### Branch Question

Can the distribution-free weak realizable improper learner be used as a
``label oracle'' to find a proper weak hypothesis after the marginal is fixed?
If not, can a single fixed marginal force every inverse-polynomially correlated
proper hypothesis to decode a hard witness, while still leaving improper weak
prediction easy?

I still do not see an atlas-ready resolution. The depth-4 update is that the
remaining negative route should be stated as a *correlation-inversion* problem,
not as ordinary proper recovery, and the remaining positive route should be
stated as a *uniform stopping* problem, not merely as finite-trace existence.

### A More Exact Positive Attempt

Fix a marginal $P$. The weakest proper target needed in the realizable subcase
is:

$$
\text{given samples from }(X,c(X)),\quad
\text{output }h\in\mathcal C\text{ with }
P[h(X)=c(X)]\ge \frac12+\gamma_P(s).
$$

Since $c$ itself is proper, the only missing part is efficient selection. A
tempting marginal-nonuniform argument is:

1. choose a finite set $F_P$ of large $P$-mass;
2. search for one representative concept for every trace realized by
   $\mathcal C$ on $F_P$;
3. use labeled samples to identify the trace of $c$ on $F_P$ and validate the
   matching representative.

If $P(F_P)>3/4$, the trace representative has error below $1/4$ in the
realizable case, so it is more than weak enough. If constants or another
proper neutralizer are present, the same list-and-validate idea can also cover
the high-OPT branch of low-noise robustification.

The obstruction is not statistical. It is the atlas computational convention:
runtime and sample use are worst-case/pathwise bounds on finite encoded
transcripts. The learner is one fixed algorithm and is not given $P$, $F_P$, a
trace menu, or a certificate that the menu is complete. A dovetailing search
over legal proper descriptions can eventually find trace representatives if
the representation is recursively enumerable and evaluable, but it does not
know when enough representatives have been found. Stopping by validation can
certify that a displayed candidate is good on the sampled distribution, but it
does not certify that the search budget is sufficient for every target trace
under the same marginal.

This matters because the polynomial $p_P$ in the target is only an analysis
bound on the fixed learner's actual stopping time. It is not advice that lets
the learner multiply its search by a hidden $P$-dependent constant. A
semi-decision procedure that halts quickly after the right representative is
encountered is therefore not automatically a marginal-nonuniform efficient
learner. To turn this route into a theorem, one would need an additional
uniform stopping device, for example:

- an effective proper ERM or weak proper ERM oracle;
- an enumerable trace cover with a computable completion certificate;
- a projection oracle from external predictors to proper hypotheses;
- a class-specific normal form bounding the first representative of every
  high-mass trace by a fixed polynomial in the representation size;
- a model change allowing $P$-dependent advice rather than only
  $P$-dependent bounds.

None of these follows from `efficient-weak-realizable-improper-pac`.

### The Improper Source Does Not Supply The Selector

One might hope to use the source learner itself to orient the finite-trace
search. Run the weak improper learner several times, get external predictors
$g_1,\ldots,g_T$, and search for a proper $h$ agreeing with their majority on
the high-mass part of $P$.

This is circular. In the realizable case, the $g_i$ are correlated with $c$,
but their majority need not be close to any legal concept. Searching for a
proper concept correlated with the $g_i$ is exactly a weak proper agnostic ERM
problem against pseudo-labels. If such a search were polynomial under every
fixed marginal, it would already be the missing selector. Boosting only
improves the external predictor; it does not give a representation in
$\mathcal C$.

The source also does not supply the high-noise neutralizer needed for agnostic
proper learning. The low-noise robustification proof uses constants when
$\operatorname{OPT}_{\mathcal C}$ is not tiny. If constants are absent from
$\mathcal C$, an external constant classifier cannot be validated into a legal
output. If constants are added, many counterexample templates become weakly
proper learnable. Thus constants are not a harmless black-box patch.

### A Sharper Negative Target: Correlation-Inversion

A false witness should no longer aim merely to show that strong proper
learning recovers a hidden seed. The target never asks for small error. It
only asks for some hidden inverse-polynomial advantage. Therefore the needed
hardness statement is:

> For one fixed marginal $P$, given labels generated by a legal target
> $c_z\in\mathcal C$, every polynomial-time algorithm that outputs any legal
> $h\in\mathcal C$ with
> $\mathbf E_P[(-1)^{h(X)}(-1)^{c_z(X)}]\ge 1/q(s)$
> can be converted into an inverter/decoder for the hidden witness $z$.

Call this correlation-inversion. It is strictly stronger than the existing
one-way image-coordinate lower bound. The coordinate lower bound proves that
very small error, of order $\mu_n/n$, recovers the image. It does not prove
that any global inverse-polynomial correlation recovers the image. In fact the
weak-handle class shows the opposite phenomenon can be deliberately introduced:
weak proper handles may exist and be easy while strong recovery remains hard.

### Why Standard One-Way Image Coordinates Fall Short

Under the fixed all-length coordinate marginal
$P=\sum_n \mu_n P_n$, a length-$n$ target has its informative block weighted
by $\mu_n$. A wrong-length or default-like proper hypothesis can obtain global
error

$$
\frac12 - \Theta(\mu_n)
$$

or at least avoid any need to match $f(s)$, depending on how the concept is
defined off its active block. Since $\mu_n$ is typically inverse-polynomial
for the lengths used in the strong lower bound, this is already a legal weak
advantage at some scale. If $\mu_n$ is made exponentially small to suppress
wrong-length handles, the local hard block becomes invisible to every
inverse-polynomial weak target.

Conditioning $P$ on the length-$n$ block restores the one-length Hadamard or
coordinate geometry, but then $P$ varies with $n$. A marginal-nonuniform
learner may have a different hidden polynomial and weak exponent for each such
conditioned marginal, so the usual cryptographic reduction does not get one
uniform polynomial-time inverter.

### Why Shared Codes Need More Than Distance

The best negative geometry remains the one-length Hadamard image construction:

$$
c_s(r)=\langle f(s),r\rangle \pmod 2.
$$

At a fixed length and uniform marginal on $r$, any positive proper correlation
with $c_s$ requires the same image parity, hence a preimage. But making this
all-length and fixed-marginal in finite transcripts requires a shared code
domain with exponentially many certificates and no useful wrong-code
correlations at any inverse-polynomial scale.

Pure coding distance seems insufficient. On a polynomial-size coordinate
domain, exponentially many binary codewords cannot all be exactly
nonpositively correlated in the Hadamard/Plotkin sense. Approximate codes can
make wrong correlations small, but normally only at an inverse-polynomial or
chosen negligible scale tied to the coordinate length. The target's weak gap
$\gamma_P(s)$ is hidden and may be smaller than the residual correlation of a
wrong legal codeword. Such a wrong codeword would be an acceptable proper weak
output even if it reveals nothing about the hidden witness.

Increasing the coordinate domain to force exponentially tiny residual
correlation threatens the source. The source must be distribution-free weak
realizable improper in polynomial time. If the domain is too large to expose
the external codeword from polynomially many arbitrary-distribution samples,
lookup/memorization no longer proves the source. If the learner recovers the
codeword algebraically, as in the Hadamard parity example, then one must show
that this algebraic recovery remains easy for arbitrary marginals, not merely
under the uniform code-coordinate marginal.

### PCP And Clause Selectors Rephrased

PCP active slices and clause-satisfaction lookup witnesses can also be put in
correlation-inversion language. The desired fixed-marginal gadget would say:
every proof, assignment, or certificate that is weakly correlated with the
challenge labels decodes a witness for the same challenge instance.

The known gadgets do not have this property. Active slices get it only by
putting the instance name into the marginal. Once slices are packed into a
single marginal, the challenge slice has low mass and unrelated slices become
weak handles. Clause selectors keep the marginal fixed, but the gap contributed
by an individual clause or local test is a strong-accuracy signal, not a
near-$1/2$ weak additive signal. A weakly useful assignment need not satisfy
the formula.

Thus a PCP-based separation would need a wrong-output-usefulness theorem much
stronger than ordinary soundness: not just "bad proofs are rejected often," but
"any legal object with inverse-polynomial global correlation yields the hard
witness." I did not find such a construction in the local atlas notes.

### Conditional Statements That Would Resolve The Edge

The depth-4 pass leaves two clean conditional resolutions.

**Conditional true theorem.** If every class satisfying the source also has,
for each fixed marginal $P$, a uniform-stopping weak proper selector from
samples and external predictor evaluations, then the edge is true. The proof is
source learner plus selector in the realizable case, and marginal-preserving
low-noise robustification plus proper neutralizers/selectors in the agnostic
case.

This condition is not implied by the source. It is essentially a proper weak
ERM/projection assumption.

**Conditional false theorem.** If there is a finite-encoded class based on a
one-way or NP-hard family with:

1. distribution-free polynomial-time weak realizable improper learning;
2. one fixed marginal $P$ of polynomially visible mass on the hard coordinates;
3. correlation-inversion hardness for every proper output with
   inverse-polynomial positive correlation under $P$;
4. no constants, wrong-length concepts, finite-prefix representatives, or
   bounded handles that give inverse-polynomial proper advantage;

then the edge is false, already on realizable labels.

The one-length Hadamard image construction satisfies the local version of
items 2--4 but not the all-length fixed-marginal requirement. The
one-way-coordinate class satisfies items 1--2 for strong accuracy but fails
item 3 at weak accuracy. PCP active slices satisfy a local version of item 3
but fail fixed-marginal item 2.

### Provisional Verdict

verdict: unresolved-open
confidence: medium-high

I would not change the atlas edge yet. The source does imply a weak agnostic
improper learner by the existing robustification argument, but every route to a
proper output needs extra representation search structure. Conversely, every
candidate separation still needs a fixed-marginal correlation-inversion
principle stronger than the current PCP, one-way-coordinate, or shared-code
templates.

### Next Directions

1. Formalize "correlation-inversion" as a reusable target property and test it
   against the one-way image-coordinate and Hadamard image classes.
2. Look for a finite-transcript all-length code family where wrong-code
   correlations are below every inverse-polynomial scale relevant to the
   representation size, while external weak prediction remains
   distribution-free polynomial-time.
3. Try to prove a no-go lemma for pure geometry: under one fixed countable
   marginal and polynomially visible domains, exponentially many proper
   certificates must leave inverse-polynomial wrong correlations or low-mass
   handles.
4. Separately state a restricted positive theorem for classes with efficient
   fixed-marginal weak proper ERM, projection, or certified trace-cover
   selectors; this would clarify exactly what extra structure the unresolved
   edge is missing.

## Depth 5 Branch: selector stopping and correlation-inversion witnesses

depth: 5
date: 2026-05-05
focus: combine weak-realizable improper prediction with fixed-marginal weak
agnostic proper learning

### Branch Question

Can the source learner be used as the predictive part of a fixed-marginal
weak agnostic proper learner, leaving only a marginal-dependent proper
selection problem? Or can one build a single fixed-marginal witness where any
proper hypothesis with even inverse-polynomial correlation must decode a hard
object, while improper weak realizable learning remains distribution-free
polynomial time?

The depth-5 conclusion is still negative on both attempted resolutions. The
source gives useful external prediction, but not a uniform stopping rule for
finding a represented concept. The natural false witnesses give local
correlation-inversion, but all known ways to make the marginal fixed across
infinitely many challenge sizes introduce weak proper handles.

### Positive Template: Uniform-Stopping Weak Proper Selectors

The clean conditional theorem is now the following selector principle.

Fix a class $\mathcal C$ and a marginal $P$. A weak proper selector would be a
single algorithm $S$ which is not given $P$ as advice, but which has a
$P$-dependent polynomial stopping bound. Given labeled samples from a joint
distribution with marginal $P$, and optionally evaluation access to an
external predictor $g$, it outputs $h\in\mathcal C$ whenever either:

1. the labels are realizable by some $c\in\mathcal C$ and $g$ has
   inverse-polynomial positive correlation with $c$ under $P$; or
2. in the agnostic case, some $c^\star\in\mathcal C$ is better than the
   proper neutralizer floor by an inverse-polynomial amount, and $g$ is a
   low-noise external predictor for $c^\star$.

The output should satisfy

$$
\operatorname{err}_{\mathcal D}(h)
\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s)
$$

for a $P$-dependent inverse-polynomial $\gamma_P$.

If such an $S$ is available, the assigned edge is essentially true. In the
low-noise region, run the weak realizable improper learner on fresh batches as
in the robustification argument, feed the resulting external predictors to
$S$, and validate the resulting proper candidates. In the high-noise region,
use the selector's proper neutralizer branch, or constants/complements if the
class supplies them. The target's marginal-nonuniform quantifier can absorb
the selector's $P$-dependent polynomial.

The problem is that this selector is extra structure, not a consequence of
the source. Three weaker-looking attempts still fail for the same stopping
reason.

- **Finite trace enumeration.** For a fixed $P$, a large finite set $F$ and
  one proper representative for every trace on $F$ would suffice
  statistically. A uniform algorithm can dovetail over descriptions, but it
  does not know when all high-mass traces have representatives. The hidden
  polynomial $p_P$ is only an analysis bound, not advice to the learner.
- **External-predictor projection.** Boosting the weak improper learner can
  make $g$ accurate, but searching for $h\in\mathcal C$ correlated with $g$ is
  already weak proper agnostic ERM against pseudo-labels.
- **Validation-only stopping.** Validation can choose among candidates already
  generated, but it cannot certify that the search has reached the first good
  proper representative for every possible target concept under the fixed
  marginal.

So the positive route has a crisp missing lemma: every source-positive class
would need a uniform-stopping fixed-marginal weak proper selector. I see no
way to derive that lemma from distribution-free weak realizable improper
learning alone.

### Negative Template: Fixed-Marginal Correlation-Inversion

For a false edge, it is enough to separate the realizable subcase. The needed
witness should provide a fixed marginal $P$ and targets
$\{c_z:z\in Z_s\}\subseteq\mathcal C$ such that:

1. $\mathcal C$ has a distribution-free polynomial-time weak realizable
   improper learner;
2. for every polynomial-time proper learner $A$, if $A$ outputs
   $h\in\mathcal C$ with

   $$
   \mathbf E_{X\sim P}[(-1)^{h(X)}(-1)^{c_z(X)}]\ge 1/q(s),
   $$

   for some polynomial $q$, then $A$ can be converted into an inverter or
   decoder for $z$; and
3. no easily findable constants, wrong-length hypotheses, finite-prefix
   representatives, or bounded handles have inverse-polynomial correlation
   with $c_z$ under $P$.

This is stronger than the existing proper-learning lower bounds. Strong
proper recovery can force exact identity on a polynomial-mass block. The weak
target allows any inverse-polynomially correlated proper object, so the
witness must rule out every non-decoding weak handle.

### Why Existing Templates Still Miss

**PCP active slices.** The active-slice proof gives the right local
soundness: on the marginal uniform over the slice for $\varphi$, a weakly good
proper proof distinguishes satisfiable from unsatisfiable instances. But that
marginal depends on $\varphi$. Packing all slices into one fixed marginal
multiplies the acceptance gap by the slice weight. Exponentially many
instances then force most slices to have tiny mass, and unrelated slices or
default hypotheses become legal weak outputs. Ordinary PCP soundness says bad
proofs fail often on their own instance; it does not say every globally
weakly correlated proof under a shared marginal decodes the challenge
instance.

**One-way image coordinates.** The all-length coordinate marginal proves
strong proper hardness because small error on the length-$n$ block identifies
the one-way image. The weak target never asks for that accuracy. Wrong
lengths, default behavior outside the active block, and singleton or bounded
coordinate handles can obtain global inverse-polynomial advantage without
inverting. Conditioning on the hard block restores the lower bound, but then
the marginal varies with $n$ and marginal nonuniformity absorbs the reduction.

**Shared Hadamard/code constructions.** At one fixed length, Hadamard image
parities are the perfect correlation-inversion witness: an improper learner
can recover the image vector by linear algebra, while any positively
correlated proper parity has the same image and hence inverts. To make one
fixed finite-encoded marginal work for all lengths, one must share code
coordinates across exponentially many certificates. Exact nonpositive
correlation for all wrong certificates runs into Plotkin/Hadamard-style
geometry; approximate codes leave residual correlations. Since the target's
weak gap is hidden and may be a very small inverse polynomial, those residual
wrong-code correlations are themselves acceptable proper weak outputs. Making
the coordinate domain enormous can suppress the correlations, but then the
improper source is no longer obviously distribution-free polynomial-time from
arbitrary samples.

### Interaction With Agnostic Proper Learning

The agnostic upgrade does not remove the properization bottleneck. The
low-noise robustification converts the source into weak agnostic improper
prediction, provided we may output external candidates and constants. For the
proper target, both branches need representation-level help:

- In the low-OPT branch, a clean batch gives an external predictor for a
  near-best $c^\star$, but a selector must find a legal concept correlated
  with either $c^\star$ or the external predictor.
- In the moderate/high-OPT branch, a proper neutralizer must keep error near
  $1/2$ for arbitrary labels. Constants solve this only for classes that
  contain them, and adding such handles often makes candidate separations
  target-positive.

Thus combining the source with fixed-marginal weak agnostic proper learning
is possible under a selector/neutralizer assumption, but that assumption is
exactly the unresolved content of the edge.

### Obstacles

1. The source learner's stopping time is uniform and polynomial, but its
   output representation is unconstrained; it gives no bound on when a proper
   search should stop.
2. Marginal-nonuniformity allows $P$-dependent analysis bounds, not
   $P$-dependent advice, trace menus, or challenge-length selectors.
3. Validation compares generated candidates; it cannot prove that the
   generated list contains a weakly good proper representative.
4. Existing PCP witnesses use input-dependent active marginals, and shared
   marginals dilute the weak signal.
5. Existing one-way witnesses prove strong recovery, while weak recovery is
   defeated by wrong lengths and bounded handles.
6. Existing shared-code witnesses either leave inverse-polynomial residual
   correlations or make the coordinate domain too large for the known
   distribution-free improper learner.

### Depth-6 Directions

1. Prove or refute a formal selector lemma: source plus a uniform-stopping
   fixed-marginal weak proper selector plus a proper neutralizer implies the
   target. This should be stated as a reusable conditional implication, not
   as an atlas edge update.
2. Define a "certified trace cover" model precisely: an enumerable set of
   proper representatives with a computable certificate that every high-mass
   trace under $P$ is covered. Check whether any existing atlas classes
   satisfy this condition.
3. Build a correlation-inversion benchmark from the one-length Hadamard image
   class, then list exactly which property fails when lengths are packed into
   one fixed finite-string marginal.
4. Try a computational weak-handle hardness construction: allow
   non-decoding weak handles to exist, but make finding any of them as hard as
   decoding the witness.
5. Search for PCP agreement or direct-product gadgets with a shared challenge
   marginal where every inverse-polynomially correlated proof identifies the
   challenged instance, not merely a satisfiable unrelated slice.
6. Prove a geometric no-go lemma for pure shared-code templates under a fixed
   countable marginal: exponentially many finite descriptions plus polynomial
   visibility force either inverse-polynomial wrong-code correlation or
   low-mass/default handles.

verdict: unresolved-open
confidence: medium-high

## Depth 6 Final Attempt: uniform stopping or fixed-marginal correlation inversion

depth: 6
date: 2026-05-05
focus: final pass on uniform-stopping weak proper selectors,
fixed-marginal correlation-inversion witnesses, and PCP/one-way/shared-code
templates

### Final Question

Can this edge be resolved by either:

1. proving that the distribution-free weak realizable improper learner can be
   turned, under each fixed marginal, into a weak agnostic proper learner by a
   uniform stopping argument; or
2. finding one fixed marginal $P$ and a source-positive class where every
   inverse-polynomially correlated proper output decodes a hard witness?

After one last hard pass, I still do not see an atlas-ready proof or
counterexample. The most precise state is:

$$
\text{source}
\Longrightarrow
\text{weak agnostic improper prediction}
\quad\text{but not known}\quad
\Longrightarrow
\text{weak agnostic proper prediction}.
$$

The gap is not statistical. It is an efficient representation-search and
uniform-stopping gap.

### Positive Attempt: Uniform-Stopping Proper Selector

The cleanest route to `true` would be a selector theorem.

**Selector lemma needed.** For every class $\mathcal C$ satisfying
`efficient-weak-realizable-improper-pac`, and for every fixed marginal $P$,
there is one uniform algorithm $S$ with a $P$-dependent polynomial running-time
bound such that, from samples with marginal $P$ and optional evaluation access
to an external weak predictor $g$, $S$ outputs $h\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s)
$$

for some $P$-dependent inverse-polynomial gap $\gamma_P$.

If this selector exists, the edge follows by known ingredients:

1. Boost the weak realizable improper source to a strong improper realizable
   learner when labels are clean.
2. Use the low-noise robustification idea to get external weak agnostic
   candidates from clean-enough batches.
3. Feed those external candidates to the fixed-marginal proper selector.
4. Validate the generated proper candidates.
5. In the high-OPT region, use the selector's neutralizer branch, or constants
   and complements if the class actually contains them.

The point of this formulation is that all marginal-nonuniformity is in the
analysis of $S$'s stopping time and weak gap. The learner itself is still a
single uniform algorithm and receives no $P$-specific advice.

I do not see a derivation of this selector from the source. The following
three almost-proofs fail for the same reason.

**Finite-trace enumeration.** For a fixed $P$, a finite set $F$ with
$P(F)>3/4$ plus one legal representative for each trace $c|_F$ would give a
proper weak realizable learner. But a uniform learner is not handed $F$, a
trace menu, or a certificate that the menu is complete. Dovetailing over
proper descriptions may eventually find representatives, but it has no
uniform stopping rule certifying that every high-mass trace has appeared.

**External-predictor projection.** The source gives predictors correlated with
the target, and boosting can make them accurate. But searching for
$h\in\mathcal C$ correlated with the external predictor is exactly a weak
proper agnostic ERM/projection problem. This is the desired target in another
form, not a consequence of the improper source.

**Validation stopping.** Validation can select among candidates already
generated, and can reject visibly bad proper hypotheses. It cannot certify
that the search has reached the first good proper representative for every
possible target concept under the same marginal.

So a positive atlas proof needs an additional representation hypothesis:
efficient weak proper ERM, a projection oracle, a certified finite trace
cover, or a normal form bounding the first useful proper representative by a
polynomial in the concept size. None is present in the current node.

### Negative Attempt: Fixed-Marginal Correlation-Inversion Witness

For `false`, it suffices to separate the realizable subcase of the target.
The needed witness is stronger than ordinary proper-learning hardness.

A candidate class would need:

1. **Source-positive:** a distribution-free polynomial-time weak realizable
   improper learner.
2. **One fixed hard marginal:** a single marginal $P$ independent of the
   challenge length or formula.
3. **Correlation inversion:** for targets $c_z\in\mathcal C$, every efficient
   algorithm that outputs any $h\in\mathcal C$ with

   $$
   \mathbf E_{X\sim P}[(-1)^{h(X)}(-1)^{c_z(X)}]\ge \frac1{q(s)}
   $$

   for any polynomial $q$ can be turned into an inverter or decoder for the
   hidden witness $z$.
4. **No weak handles:** constants, wrong lengths, wrong slices, finite-prefix
   representatives, bounded handles, and residual code correlations must not
   give inverse-polynomial advantage without decoding $z$.

This is the exact obstruction. Existing witnesses establish strong recovery
or distribution-free weak proper hardness, but not fixed-marginal weak
correlation inversion.

### PCP And Shared-Instance Templates

The PCP active-slice lookup class remains the best witness for the
distribution-free weak proper sibling. On the active slice of a formula
$\varphi$, a weakly good proper proof distinguishes satisfiable from
unsatisfiable instances, while an improper one-slice lookup learner is easy.

It does not instantiate the needed target-negative edge here.

- The hard marginal is $P_\varphi$, uniform on the slice for the input
  formula. The target allows both the runtime polynomial and weak gap to
  depend on this fixed marginal, so a reduction using a different marginal
  for each $\varphi$ does not give one uniform polynomial-time SAT algorithm.
- Packing all formula slices into one marginal gives slice weights
  $w_\varphi$. The local PCP gap is multiplied by $w_\varphi$, and one cannot
  assign inverse-polynomial mass to exponentially many formulas at each
  length.
- Wrong slices become weak handles. A proper proof for an unrelated
  satisfiable formula, or a default-off-slice concept, can be globally
  acceptable without revealing anything about the challenged $\varphi$.
- Ordinary PCP soundness is instance-local. It says bad proofs fail tests for
  their own instance. It does not say that every globally
  inverse-polynomially correlated proof under a shared marginal identifies the
  challenge instance.

A PCP route would therefore need a genuinely stronger shared-marginal
agreement theorem: any proper object with inverse-polynomial global
correlation against the challenge labels must encode a witness for the same
challenge, not merely for a high-mass or unrelated slice. I found no such
template in the atlas material.

### One-Way Coordinate Templates

The one-way image-coordinate class already resolves the stronger
fixed-marginal strong proper target. Under the all-length coordinate marginal,
accuracy about $\mu_n/n$ on a length-$n$ target forces the learner to output a
seed with the same image, hence invert the one-way function.

This does not refute the weak target.

- The weak target has no requested accuracy parameter. It only promises some
  hidden inverse-polynomial correlation.
- Under the all-length marginal, the length-$n$ block has mass $\mu_n$. If
  $\mu_n$ is inverse-polynomial, wrong-length or default-like concepts can be
  weakly useful without matching the image. If $\mu_n$ is negligible, the hard
  block is invisible to every inverse-polynomial weak guarantee.
- Conditioning on the length-$n$ block restores the local lower bound, but
  then the marginal varies with $n$, which marginal nonuniformity absorbs.
- The weak-handle variant makes the boundary explicit: adding singleton or
  bounded positive handles can leave strong proper recovery hard while making
  weak proper learning easy.

Thus one-way coordinates prove that strong proper recovery is not forced by
improper learnability, but they do not prove that every weakly correlated
proper output must invert.

### Shared-Code And Hadamard Templates

The closest local negative geometry is still the one-length Hadamard image
class. Given a length-preserving one-way function $f$, define

$$
c_s(r)=\langle f(s),r\rangle \pmod 2,\qquad r\in\{0,1\}^n.
$$

At the uniform length-$n$ marginal, an improper learner can recover the
external parity vector $f(s)$ by linear algebra and output the parity
hypothesis. A proper hypothesis with positive correlation must use the same
image parity, hence gives a preimage of $f(s)$.

This is the right local model but still not an atlas counterexample.

- One marginal per length is shielded by marginal nonuniformity.
- A single all-length block marginal reintroduces tail-mass and wrong-length
  handles.
- Trying to put every seed at every length on a shared finite coordinate set
  runs into code geometry: exponentially many proper codewords on a
  polynomially visible coordinate domain leave residual correlations at some
  inverse-polynomial scale.
- The target's weak gap is hidden and may be below those residual
  correlations, so a wrong legal codeword may be an acceptable output.
- Making the coordinate space enormous enough to suppress all wrong-code
  correlations breaks the known distribution-free improper learner: arbitrary
  marginals may hide the relevant coordinates from polynomially many samples,
  unless there is additional algebraic structure, which then has to work over
  finite encoded examples.
- Exact infinite orthogonality wants an atomless or infinite-stream product
  marginal. That drifts away from the atlas's finite encoded transcript
  convention and does not give an immediate computational PAC learner on
  arbitrary distributions.

So the shared-code route identifies the missing witness property very
precisely: finite encoded, one fixed marginal, efficient external decoding
from arbitrary-distribution samples, and no inverse-polynomial wrong-code
proper correlations.

### Atlas-Facing Synthesis

No atlas edit is justified by this scratchpad alone. The best current
classification remains:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested updated summary, if the edge note is later refreshed:

```yaml
summary: "Open: weak realizable improper learning gives weak agnostic improper prediction by boosting and robustification, but the known arguments do not provide a uniform-stopping fixed-marginal selector for a proper hypothesis. PCP, one-way-coordinate, and shared-code witnesses remain near misses: they respectively use input-dependent marginals, require strong accuracy, or leak inverse-polynomial weak proper handles."
```

Suggested atlas body replacement:

```markdown
`open`.

The source supplies distribution-free external weak prediction. Standard
realizable boosting and low-noise robustification can produce weak agnostic
improper candidates, but the target requires outputting a represented concept
from $\mathcal C$. A positive proof would need an additional
uniform-stopping fixed-marginal weak proper selector, an efficient weak proper
ERM/projection oracle, a certified trace cover, or a proper neutralizer plus a
properization mechanism. Such structure is not implied by the abstract
improper source.

Known false witnesses are near misses. PCP active-slice classes refute the
distribution-free weak proper target, but their hard marginal depends on the
input instance; packing all slices into one fixed marginal dilutes the weak
gap and creates wrong-slice handles. One-way image-coordinate classes refute
fixed-marginal strong proper learning, but weak proper hypotheses can exploit
wrong lengths, low-mass blocks, or bounded handles without inverting.
Hadamard/shared-code variants have the right one-length
correlation-inversion geometry, but no finite-encoded all-length fixed
marginal is known that keeps improper learning distribution-free polynomial
while eliminating inverse-polynomial wrong-code correlations.
```

### Missing Lemma

The edge should be considered blocked on exactly one of the following two
lemmas.

**Positive missing lemma.** Every efficiently weak realizably improperly
learnable class admits, for each fixed marginal $P$, a uniform-stopping weak
proper selector with a $P$-dependent polynomial bound and enough proper
neutralization to handle the agnostic high-OPT region.

**Negative missing lemma.** There exists a finite-encoded class with
distribution-free efficient weak realizable improper learning and one fixed
marginal $P$ such that any inverse-polynomially correlated proper hypothesis
under $P$ decodes a hard witness, with no efficiently findable non-decoding
weak handles.

Neither lemma follows from the currently recorded PCP, one-way, weak-handle,
or code-based arguments.

### Recommended Status And Family

Recommended status: keep `open`.

Recommended family: keep `properization-open`, with sub-obstruction
`fixed-marginal-weak-proper-selector` or
`fixed-marginal-correlation-inversion` if the atlas later adds finer
families.

Recommended next work:

1. Add a reusable argument note for uniform-stopping weak proper selectors.
2. Add a reusable definition or argument note for fixed-marginal
   correlation-inversion witnesses.
3. Treat one-length Hadamard image parities as the benchmark local witness,
   explicitly recording that the unresolved step is the all-length
   finite-encoded fixed marginal.
4. Do not move this edge to the one-way-image-coordinate family unless the
   weak correlation-inversion gap is closed.
5. Do not move this edge to the PCP active-slice family unless a shared
   marginal PCP/agreement gadget prevents wrong-slice weak handles.

verdict: unresolved-open
confidence: high
