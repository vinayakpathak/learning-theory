# Open Edge Resolution Scratchpad

- date: 2026-05-05
- assigned edge: `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- source: `efficient-weak-realizable-improper-pac`
- target: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- family: `properization-open`
- depth: 1
- worker constraint: did not edit atlas files; this scratchpad is the only file written

## Bottom Line

I do not have an atlas-ready proof or counterexample. The edge should remain
`status: "open"` with `evidence: unknown`.

The source is distribution-free and weak, so it gives one uniform polynomial-time
algorithm which, on samples from any marginal $D$ and target $c\in\mathcal C$,
outputs an external hypothesis $g$ with

$$
\operatorname{err}_D(g,c)\le \frac12-\gamma(s)
$$

for an inverse-polynomial advantage independent of the marginal. The target is
weaker in distributional uniformity but stricter in representation: for each
fixed marginal $P$, it asks the same one learner to output some represented
$h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
$$

where the polynomial and weak advantage may depend on $P$ but not on the target
concept.

Thus this edge is pure weak properization. The source already supplies weak
prediction under the target marginal. The unresolved operation is:

$$
\text{external weak correlation with }c
\quad\Longrightarrow\quad
\text{efficiently find any weakly correlated }h\in\mathcal C.
$$

The target concept $c$ itself proves statistical existence. It does not give a
polynomial-time proper selector.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/sample-efficient-weak-realizable-improper-pac--implies--sample-efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/README.md`

Nearby scratchpads:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`

The depth-6 properization scratchpad for
`efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`
is especially relevant. Its final diagnosis survives the stronger
distribution-free source here: finite-trace dovetailing nearly proves a
positive theorem under stronger recursive/stopping semantics, while all known
fixed-marginal false-witness templates leak weak proper handles.

## Definition Check

The source has a single distribution-free polynomial runtime/sample bound and
a single inverse-polynomial weak advantage. This is stronger than the
corresponding marginal-nonuniform weak improper source.

The target has the same weak realizable guarantee but requires a proper output.
The learner is still one uniform algorithm; it is not given a separate
algorithm or advice for each marginal. The atlas README says computational
runtime bounds are worst-case/pathwise bounds on finite encoded transcripts,
not merely expected or high-probability running times under the marginal.

Therefore the stronger source removes marginal-uniformization and
marginal-boosting distractions. It does not remove the proper representation
search.

## Positive Route Audit

The most tempting proof is:

1. Run the source weak learner on the actual marginal $P$ to get an external
   predictor $g$ weakly correlated with $c$.
2. Use samples, $g$, and the fact that some $c\in\mathcal C$ realizes the
   labels to find a weakly correlated represented concept $h\in\mathcal C$.

Step 2 is exactly the missing theorem. Boosting is irrelevant: boosting could
improve external accuracy, but its final majority/vote is generally improper.
Sample-only ERM is also irrelevant: once runtime is ignored, the sample
equivalence note already makes the sample analogue true.

A useful conditional lemma is:

**Fixed-marginal weak proper selector lemma.** If, for every fixed marginal
$P$, there is a $P$-dependent polynomial-time procedure which, from realizable
samples and optional evaluation access to an external weak predictor $g$,
returns a finite list of proper concepts containing some
$h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\frac{1}{q_P(s)},
$$

then the assigned edge is true. Run the source learner, run the selector, and
choose from the finite list by fresh validation.

No checked atlas source implies this selector. It is extra representation
structure: efficient proper ERM, a projection oracle, a computable
$L_1(P)$-cover by proper concepts, or efficient finite-support trace
realization.

## Finite Support And Proper Selector Obstacles

Finite support is the sharpest near-positive case. Fix a countably supported
marginal $P$ and choose a finite set $F$ with $P(F)>3/4$. For each realizable
trace $\tau:F\to\{0,1\}$, pick one proper concept $h_\tau$ realizing it. The
finite menu $\{h_\tau\}$ has a $P$-dependent maximum description length and
evaluation cost, and the member matching $c|F$ has error below $1/4$.

This nearly proves the target without using the improper source. It becomes a
real theorem if the atlas explicitly supplies:

- recursively enumerable legal proper descriptions;
- total effective evaluation of every enumerated description;
- a pathwise stopping certificate or permission to absorb the hidden
  $P$-dependent finite search into the runtime bound.

Under current atlas semantics this is not enough. A blind enumerate-and-validate
procedure can stop with high probability once it sees a good trace
representative, but the atlas computational nodes require pathwise polynomial
resource bounds on finite transcripts. The learner is not given $P$, the
high-mass set $F$, the finite trace menu, or the cutoff showing enough
representatives have been searched. Treating those as implicit would be a
model-level convention that would make many countable fixed-marginal weak
proper targets trivial.

This finite-trace barrier also weakens false-witness attempts. A fixed-marginal
separation cannot merely hide the exact target concept behind a finite prefix:
for a fixed finite prefix, proper trace representatives are constant-cost once
the marginal is fixed. A separation would need all useful proper correlation to
live in a size-dependent tail while every prefix, wrong-length, and short-sketch
proper handle remains useless or computationally hard to find.

## PCP Active-Slice Check

The PCP active-slice lookup class resolves the neighboring distribution-free
edge

```text
efficient-weak-realizable-improper-pac
->
efficient-weak-realizable-proper-pac
```

as false under $\mathrm{NP}\nsubseteq\mathrm{RP}$. Proper concepts encode a PCP
instance/proof pair. On the active slice for an input formula $\varphi$, perfect
completeness gives an all-positive realizable target when $\varphi$ is
satisfiable, while soundness below $1/2$ rules out weakly good proper
hypotheses when $\varphi$ is unsatisfiable. The active slice has polynomial
size, so improper memorization gives the weak improper source.

This does not refute the assigned target.

First, the hardness reduction uses the marginal $P_\varphi$ uniform on the
active slice of the input formula. In the target node, the runtime polynomial
and weak advantage may depend on that fixed marginal. If $P_\varphi$ depends on
the SAT instance, the reduction no longer obtains one polynomial-time RP
algorithm for the language.

Second, packing all slices into one fixed marginal

$$
P^\star=\sum_\psi w_\psi U_\psi
$$

dilutes the local PCP gap by $w_\varphi$. A fixed distribution cannot give
inverse-polynomial mass to exponentially many formulas of the same length.
Low-mass hard slices can be ignored while still beating $1/2$ globally, and
wrong-slice proper concepts become weak handles rather than proof witnesses.

So PCP active slices explain why properization is dangerous, but they do not
resolve the marginal-nonuniform weak target.

## One-Way Image-Coordinate Check

The one-way image-coordinate class resolves neighboring strong proper
marginal-nonuniform edges under length-preserving one-way functions. A seed
$s\in\{0,1\}^n$ defines a concept that exposes the coordinates of $f(s)$.
Improper memorization learns because a length-$n$ target has only $n$ positive
atoms. Under the fixed all-length marginal with block weights
$\mu_k=6/(\pi^2 k^2)$, sufficiently small accuracy
$\varepsilon_n=\mu_n/(3n)$ forces any proper output to have the same length and
same one-way image, hence inverts.

The weak target has no accuracy knob. Under the all-length marginal, the
length-$n$ block has mass $\mu_n\to0$, so wrong-length, default, or sparse
proper hypotheses can have global error below $1/2$ without recovering
$f(s)$. Concentrating the marginal on the length-$n$ block would make weak
correlation force recovery, but then the hard marginal varies with $n$, and the
marginal-nonuniform target may hide $n$-dependent constants in its polynomial.

The weak-handle variant makes this failure explicit. Adding constants and
singleton or bounded positive-atom handles gives proper weak learning under
each marginal, while the strong proper lower bound still works at accuracy
$\varepsilon_n$. Hence it is a witness for weak-versus-strong proper learning,
not for failure of the assigned weak proper target.

## Hadamard And Code-Tower Check

The cleanest one-length separation would encode a one-way image as a dense
Hadamard/parity concept. For fixed length $n$ and uniform marginal over
$r\in\{0,1\}^n$, define

$$
c_s(r)=\langle f(s),r\rangle \pmod 2.
$$

An improper learner can recover a parity predictor by linear algebra. Any
proper seed with positive correlation under the uniform length-$n$ marginal
must have the same image, hence would invert.

This does not yet fit the atlas target across all sizes:

- a length-specific uniform marginal lets the target's polynomial depend on
  the challenge length;
- an all-length disjoint-block marginal gives the hard block vanishing mass,
  so wrong-length/default hypotheses become weak handles;
- a shared infinite product marginal would support exact orthogonality, but it
  leaves the finite encoded transcript convention used by computational atlas
  nodes;
- finite polynomial-size code towers leave inverse-polynomial residual
  correlations, and the target's hidden $\gamma_P(s)$ may be smaller than that
  residual handle.

The depth-6 notes also record the finite-atom/Gram obstruction: under a fixed
countably supported marginal, a very large family of binary proper codewords
cannot all be pairwise nonpositively correlated by pure geometry. Thus a
future code-based false witness would need computational weak-handle hardness,
not merely distance or orthogonality.

## What Would Resolve The Edge

A positive theorem would likely be one of these:

1. a generic fixed-marginal weak proper selector from samples plus an improper
   weak predictor;
2. a precise recursive finite-trace theorem compatible with the atlas's
   pathwise runtime convention;
3. an effective proper trace/cover assumption added to the target definition.

A counterexample would likely need:

1. one fixed marginal $P^\star$;
2. an efficient distribution-free weak improper learner;
3. a proof that every inverse-polynomially correlated proper output under
   $P^\star$ yields a hard witness;
4. no constants, wrong-length hypotheses, finite-prefix representatives,
   sparse handles, or residual code correlations that give proper weak
   advantage without solving the hard problem.

None of the checked PCP, DNF/Khot-Saket, one-way-coordinate, Hadamard,
finite-support, or depth-6 properization routes currently satisfies these
requirements.

## Depth-2 Directions

1. **Make the finite-trace fork formal.** Decide whether atlas computational
   concept classes have recursively enumerable legal proper descriptions with
   total evaluators, and whether marginal-nonuniform runtime allows the hidden
   finite trace cutoff. If yes, the weak marginal-nonuniform properization
   edges may become true for semantic reasons.

2. **Prove a pathwise stopping lemma or obstruction.** The central technical
   issue in the finite-trace route is not validation accuracy, but a worst-case
   polynomial stopping rule for one uniform learner that does not know the
   fixed marginal's high-mass trace menu.

3. **Search for computational weak-handle hardness.** Since finite prefixes
   and pure code geometry leak weak handles, a separation should make finding
   any useful handle computationally equivalent to a hard relation.

4. **Try a shared-marginal label-code PCP.** Put the hard instance in target
   labels over one fixed marginal rather than in the marginal itself, and force
   every weakly correlated proper hypothesis to decode a proof. The known
   active-slice construction does not do this.

5. **Keep one-way coordinate witnesses in the strong bucket.** They are strong
   proper recovery lower bounds; the weak target remains protected by
   wrong-length, sparse, singleton, constant, or residual-code handles.

verdict: unresolved-open
confidence: medium-high
