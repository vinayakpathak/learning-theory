# Edge Resolution Scratchpad

Edge:

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
->
efficient-weak-realizable-proper-pac
```

- date: 2026-05-07
- worker depth: 1
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-weak-realizable-proper-pac`
- required write scope: this scratchpad only
- atlas files edited: no
- verdict: unresolved

## Executive Verdict

I do not see an atlas-ready proof or counterexample under the current
global-marginal semantics. The edge should remain `open`.

The source already gives the target's proper output condition on realizable
labels. If the source learner is run on data labeled by some
$c \in \mathcal C$, then $\operatorname{OPT}_{\mathcal C}=0$, so it returns
$h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c) \le 1/2-\gamma_P(s),
$$

where the weak edge $\gamma_P(s)$ is inverse-polynomial only with an exponent
allowed to depend on the marginal $P$.

The full-support finite-transcript argument handles the pathwise runtime and
sample-use issue for one call to this single source learner. It does not
change the accuracy quantifier:

$$
\forall P\ \exists k(P):\gamma_P(s)\ge s^{-k(P)}
\quad\not\Rightarrow_{\text{known}}\quad
\exists k_0\ \forall P:\gamma_P(s)\ge s^{-k_0}.
$$

Thus the remaining problem is weak-gap uniformization, not properization and
not one-call resource uniformization.

## Files And Sources Read

Local atlas/schema files:

- `atlas/README.md`
- `atlas/registry/axes.yml`
- `atlas/registry/edge_families.yml`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`

Linked and nearby atlas notes:

- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/unrestricted-labelings.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/witnesses/halfspaces.md`

Prior exact scratchpad read:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`

Related sibling scratchpad/edge read for comparison:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`

Primary sources checked:

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview/PDF, https://openreview.net/forum?id=aoVCFtox89. Used for the marginal-nonuniform quantifier pattern: rates may depend on the marginal but must hold uniformly over concepts once the marginal is fixed, and for the sample-rate trichotomy.
- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 1991, https://doi.org/10.1016/0304-3975(91)90026-X. Used for fixed-distribution background and the separation between statistical fixed-distribution learnability and computational efficiency.
- Schapire, "The Strength of Weak Learnability", Machine Learning 1990, https://www.schapire.net/papers/strengthofweak.pdf. Used for the distribution-free weak definition with one polynomial edge and for the fact that standard boosting relies on quantitative weak advantage and need not preserve hypothesis form.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata", JACM 1994, https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Used only as background for why cryptographic hard-block ideas can prove target hardness but do not automatically prove the source.

## Exact Question

Under the atlas definitions, does

```text
efficient marginal-nonuniform weak agnostic proper
```

imply

```text
efficient distribution-free weak realizable proper?
```

Equivalently, after restricting the agnostic source to realizable labels, can
the marginal-dependent weak edge be replaced by one distribution-free
inverse-polynomial edge?

The source and target have the same resource, strength, and properness axes,
and the target is weaker on realizability. The only hard axis movement is
`marginal-nonuniform -> distribution-free`.

## Positive Route Checked

Let $A$ be the source learner. For every marginal $P$ there are a polynomial
$p_P$ and a weak-agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2
$$

such that $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial. For every
joint distribution $\mathcal D$ with marginal $P$,

$$
\operatorname{err}_{\mathcal D}(A)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

On realizable labels $Y=c(X)$, the infimum is zero, so $A$ is a proper weak
realizable learner under $P$ with edge $\gamma_P(s)$.

By `full-support-marginal-uniformization`, the one-call resource bound can be
made distribution-free under the atlas convention that sample use and runtime
are worst-case/pathwise bounds on finite encoded transcripts. A full-support
reference marginal $P^\star$ sees every finite transcript that can occur under
any target marginal, so the polynomial bound attached to $P^\star$ bounds the
source learner's pathwise resources on all such transcripts.

This proves all but one target requirement. The remaining missing statement is

$$
\exists k_0\ \forall P,c:
\Pr[\operatorname{err}_P(A(S),c)\le 1/2-s^{-k_0}]\ge 1-\delta.
$$

The source supplies only $\forall P\exists k(P)$.

### Why The Obvious Diagonal Proof Fails

A tempting proof would choose marginals $P_d$ whose best available weak gaps
are below $s_d^{-d}$, then stitch them into one marginal $P^\oplus$ and use
the source guarantee for $P^\oplus$ to get a contradiction.

This would work under a size-indexed, slice-conditional semantics where the
size-$s_d$ component is evaluated with full mass at size $s_d$. It does not
work under the current atlas wording, which treats a marginal as a global
distribution over encoded instances and measures additive PAC error globally.

If

$$
P^\oplus=\sum_d w_dP_d,
$$

then failure on component $P_d$ changes global error by at most $w_d$. Taking
the weights $w_d$ small enough lets a weak learner ignore hard components
while still beating $1/2$ on the mixture. A single concept may also fail to
realize all separately chosen bad labelings unless the class has an additional
disjoint-union closure property. The abstract atlas edge has no such closure
assumption.

### Why Validation Does Not Find The Missing Gap

Holdout validation can test a proposed fixed target edge $s^{-d}$ using a
polynomial budget depending on $d$. It cannot discover that the source's true
edge is $s^{-k(P)}$ for some unknown, potentially larger exponent $k(P)$ while
still producing one distribution-free exponent.

Dovetailing over exponents gives no target learner unless the final exponent
is fixed in advance. If the algorithm spends $s^{2d}$ samples for growing
$d$, the runtime is no longer bounded by one distribution-free polynomial.

### Why Sample-Only Collapse Does Not Settle The Edge

Hanneke, Moran, and Thiessen's marginal-nonuniform trichotomy is relevant but
insufficient. It explains why polynomial marginal-nonuniform sample rates
collapse to distribution-free sample-efficient learnability in the sample-only
layer. The present target is computational and proper. Finite-dimensional
sample control gives an unbounded ERM route, not a polynomial-time proper
search algorithm.

The efficient source learner itself is the only available computational
object, and after resource uniformization it still carries only a
marginal-dependent weak edge.

## False Route Checked: PCP Active Slices

The PCP active-slice lookup class is the cleanest existing proper-target
hardness witness, but it does not satisfy this source.

On the active slice for an NP instance $\varphi$, label every example by $1$.
If $\varphi$ is satisfiable, perfect completeness makes the distribution
realizable by a proper proof concept. A proper weak learner would return a
proof accepted on more than half of verifier random strings. If $\varphi$ is
unsatisfiable, soundness below $1/2$ keeps every proper proof below that
threshold. Thus an efficient proper weak learner on these active-slice
marginals would decide an NP-complete language with one-sided randomized
error.

The assigned source is already proper. Therefore the same argument rules out
the source, assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$. This witness works
for improper-source/proper-target siblings, not for this edge.

Adding cheap proper handles does not repair it cleanly. An all-one handle or
other high-acceptance slice handle would make satisfiable active slices easy,
but it would also destroy the soundness test on unsatisfiable instances unless
the handle encodes an actual accepting proof.

## False Route Checked: One-Way Weak Handles

The one-way image-coordinate weak-handle class goes the other way: it is
source-positive but target-positive.

Constants and singleton or bounded positive-atom handles give proper weak
advantages under every marginal. For a length-$n$ coordinate target, the best
constant or singleton handle yields an inverse-polynomial weak edge, typically
of order $\Omega(1/n)$ in the realizable weak case. Hence the distribution-free
weak realizable proper target already holds.

The one-way lower bound in the atlas is a strong proper recovery lower bound.
It says high-accuracy proper learning under a fixed coordinate marginal
inverts the one-way function. It does not refute weak proper learning, because
the added handles were designed to make weak proper learning easy.

## False Route Checked: Dense Or Wide Hidden-Gap Blocks

The best remaining false template is still a hierarchy of hard blocks of size

$$
N=s^K
$$

with $K$ allowed to depend on the marginal. A cheap proper handle on such a
block can have advantage about $1/N=s^{-K}$. For each fixed block marginal
this is inverse-polynomial with a marginal-dependent exponent, while no single
distribution-free exponent can dominate all $K$.

The target-negative half is plausible. If a distribution-free target learner
claims advantage $s^{-d}$ and uses $s^r$ samples/time, choose $K\gg d+r$.
Sampled singleton or finite-lookup handles have advantage below $s^{-d}$, and
any better dense proper hypothesis could be arranged to require solving a PRF,
one-way-image, random-oracle, or PCP-style prediction problem.

The source-positive half is still missing.

### Full-Support Runtime Blocker

A source learner is one uniform algorithm. It may have a $P$-dependent
polynomial guarantee, but under the atlas finite-transcript convention its
pathwise runtime cannot have an exponent that grows with an observed hidden
block parameter $K$. A full-support reference marginal gives positive
probability to transcripts from all $K$-blocks. If the algorithm spends
$s^{\Theta(K)}$ samples or time on those transcripts, no single polynomial
bound exists for the reference marginal.

Thus the source cannot be proved merely by saying "for each fixed block
marginal, take $s^K$ samples and memorize the block." That is a fixed-marginal
statistical argument, not an efficient marginal-nonuniform source under the
current pathwise semantics.

### Agnostic Tiny-Handle Blocker

In the realizable uniform balanced block, a sampled labeled atom can define a
tiny correct handle with advantage about $1/N$. The source, however, is weak
agnostic. In the low-noise regime
$\operatorname{OPT}\ll 1/N$, the learner must find a clean and correctly
oriented proper handle with high confidence.

Validating an advantage of scale $1/N$ usually costs polynomially in $N$, for
example $N^2$ samples for direct correlation estimation. With unbounded $K$,
this again violates the full-support pathwise polynomial bound.

### Orientation Blocker

Sparse handles with a default value face a near-balanced orientation problem.
For a hard target with positive mass

$$
P(c=1)=1/2\pm \eta,
$$

a default-zero handle and a default-one handle are good on opposite sides of
the bias. If the handle correction mass is $q\ll |\eta|$ and the sample size
is too small to determine the sign of $\eta$, choosing the wrong orientation
is not weakly better than random guessing.

For wide blocks, one can arrange

$$
q \ll |\eta| \ll 1/\sqrt m
$$

for any fixed polynomial sample budget $m$. This defeats singleton,
co-singleton, finite-lookup, and bounded-list handles unless a new
orientation-free deterministic proper handle is found.

## New 2026-05-07 Check: Countable-Domain Fixed-Trace Lure

The Hanneke-Moran-Thiessen and Benedek-Itai background suggests a tempting
false route: on a fixed countable marginal, a learner can eventually identify
a finite heavy trace, learn labels on that trace, and output a proper table.
This can give weak fixed-marginal learning for extremely broad concept
classes.

This does not resolve the present edge.

First, it is not automatically an efficient marginal-nonuniform source under
the atlas semantics. A learner that searches until it has covered a
distribution-specific heavy trace may need a trace size or stopping time whose
exponent is unbounded across marginals. A full-support reference marginal over
all trace patterns would expose those long finite transcripts, so the source
would fail the pathwise polynomial bound unless the trace-search exponent is
uniformly polynomial.

Second, when the trace size is uniformly polynomial in the target size, the
same proper table handles tend to make the distribution-free weak target true:
polynomially many samples can collect enough positive mass and output a legal
finite table. When the trace size is superpolynomial or has unbounded hidden
exponent, the source proof re-enters the full-support runtime blocker.

Thus countable fixed-distribution learnability is a useful warning against
overusing sample-only intuition, but it is not a false witness for this
efficient proper weak edge.

## Why The Edge Is Not Resolved True

The positive route would need a genuine weak-gap uniformization theorem:

> From one efficient proper learner whose weak edge is inverse-polynomial for
> each marginal separately, derive a possibly different efficient proper
> learner with one inverse-polynomial edge for all marginals.

I found no such theorem in the atlas notes or in the primary sources checked.
Schapire-style boosting assumes a quantitative distribution-free weak edge and
normally produces a composite hypothesis; here the target is only weak, so
boosting is not the main missing step anyway. The missing step is the lower
envelope on the original weak gap.

Compactness at each fixed size also seems insufficient. It may give a positive
minimum advantage over marginals at that size for a fixed bounded learner, but
it gives no inverse-polynomial rate as size grows. The current global-marginal
semantics prevent the usual diagonal proof from upgrading those fixed-size
minima to one polynomial lower envelope.

## Why The Edge Is Not Resolved False

The false witness would need all of the following at once:

1. One uniform polynomial-time proper learner satisfying the weak agnostic
   marginal-nonuniform source for every global marginal.
2. A family of marginals or blocks where every easy proper handle has advantage
   below any fixed distribution-free inverse polynomial.
3. A target-side hardness proof showing that any proper hypothesis with a
   fixed inverse-polynomial advantage solves a hard computational problem.
4. No leakage: the source handles must not themselves give the distribution-free
   weak target.
5. No hidden long runtime: finding or validating source handles cannot cost
   $s^K$ on finite transcripts for unbounded hidden $K$.

PCP active slices satisfy the target hardness but fail the proper source.
One-way weak handles satisfy the source but also satisfy the target. Dense PRF
or Hadamard-style blocks help with target hardness but have no verified weak
agnostic proper source. Countable trace memorization helps fixed-marginal
statistics but conflicts with full-support pathwise efficiency when the trace
exponent is hidden.

## Concrete Obstacles

- **Weak-gap quantifier swap:** the source gives $\forall P\exists k(P)$,
  while the target requires $\exists k_0\forall P$.
- **Global-mixture dilution:** stitching bad marginals into one global
  marginal can make hard components too low-mass to affect additive weak error.
- **No closure assumption:** a diagonal mixture also needs one concept to
  realize all component hard labelings, which an arbitrary class need not
  support.
- **Full-support transcript bound:** marginal-dependent weak gaps may have
  hidden exponents, but the source algorithm's pathwise runtime cannot have
  unbounded hidden exponents on finite transcripts.
- **Proper source blocks PCP witnesses:** the clean weak proper lower bound
  already rules out the assigned source.
- **Weak handles leak to the target:** if a proper handle has any fixed
  inverse-polynomial advantage, it is already a target learner.
- **Tiny handles are hard agnostically:** finding and validating a
  $s^{-K}$-scale handle with high confidence tends to require $s^{\Theta(K)}$
  resources.
- **Orientation barrier:** deterministic proper sparse handles must choose a
  side near label bias $1/2$, and the sign can be statistically hidden at the
  same scale as the desired hidden gap.

## Promising Depth-2 Directions

1. **Formal weak-gap no-transfer lemma.** Prove a reusable lemma that an
   $\operatorname{OPT}+1/2-\gamma$ guarantee on a weighted mixture gives no
   conditional weak guarantee on components whose weights are below the global
   weak-gap scale.

2. **Conditional size-indexed theorem.** State and prove the nearby true
   theorem under size-indexed, slice-conditional marginals. In that schema,
   bad exponents cannot be hidden by mixture weights, and the edge likely
   becomes true by diagonal stitching.

3. **Orientation-free deterministic handles.** Search specifically for a
   proper handle family that gives a tiny positive correlation without knowing
   whether $P(c=1)$ is just above or just below $1/2$. Singleton, co-singleton,
   finite lookup, bounded subset, signed-code, and public-hash handles should
   be treated as already suspect.

4. **Oracle target half-separation.** Build an oracle class with dense random
   block labels plus tiny legal handles and prove only the target-negative
   half first. This would isolate exactly what a source oracle would need to
   certify.

5. **PCP handle soundness lemma.** Formalize the claim that any added proper
   handle making the satisfiable all-one active slice weakly learnable either
   violates unsatisfiable soundness or encodes a genuine accepting proof.

6. **Finite-trace source boundary.** Identify representation-level conditions
   under which fixed-marginal heavy-trace memorization is an efficient
   marginal-nonuniform weak agnostic proper source, and then test whether those
   same conditions automatically give a distribution-free weak target.

7. **Computational weak-handle hardness.** Look for a class where weakly
   correlated proper hypotheses exist under every marginal, but finding any
   one above a fixed distribution-free scale is computationally hard. This is
   sharper than ordinary PRF hardness, because the source still needs a
   marginal-dependent way to find smaller handles.

## Suggested Atlas Action If Edits Are Later Allowed

No status change is justified. The current edge note is already close to the
right diagnosis. If atlas edits are later requested, I would keep

```yaml
status: "open"
evidence: unknown
family: marginal-uniformization-open
```

or split out a more specific `weak-gap-uniformization-open` family. The body
should continue to emphasize:

- full-support finite-transcript uniformization handles one-call resources;
- the weak advantage remains marginal-dependent;
- the source is already proper, so this is not a properization edge;
- known PCP, one-way, halfspace, dense-code, and countable-trace candidates do
  not settle the exact implication.

## Final

The edge remains unresolved under current atlas semantics.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`

## Depth 2 Branch A: Proper Weak-Gap Uniformization

### Branch Question

This branch isolates the proper target after the weak-gap issue has been
separated from runtime. The question is whether the proper output constraint
creates any additional obstruction or any extra positive route once the source
is restricted to realizable labels.

My conclusion is: for the inherited source learner, the edge reduces exactly to
weak-gap uniformization. Properness does not add a second generic obstruction,
because the source already outputs $h\in\mathcal C$. Properness also does not
give an evident generic positive route: without extra structure on
$\mathcal C$, being proper supplies no operation that converts a
$P$-dependent edge into one distribution-free edge.

More explicitly, let $A$ be the source learner. On a realizable distribution
$Y=c(X)$, the agnostic benchmark has $\operatorname{OPT}_{\mathcal C}=0$, so

$$
\operatorname{err}_P(A(S),c)\le 1/2-\gamma_P(s)
$$

with $A(S)\in\mathcal C$. The full-support transcript argument supplies a
distribution-free pathwise polynomial bound for this same $A$. Thus the only
missing target requirement for this inherited learner is

$$
\exists q\ \forall P,s:\quad \gamma_P(s)\ge 1/q(s),
$$

where $q$ is one polynomial independent of $P$.

This is not a properization problem in the usual sense. A counterexample cannot
use the usual "improper learner exists but proper learner is hard" pattern,
because any source-positive witness must already have an efficient proper
weak-agnostic learner under every marginal, with only the weak-gap exponent
allowed to vary.

### Conditional True Statement: Uniform Gap Envelope

**Claim.** Suppose the source learner has a uniform inverse-polynomial weak
gap envelope after the realizable restriction: there is one polynomial $q$ such
that for every marginal $P$ and every realizable target $c\in\mathcal C$,

$$
\operatorname{err}_P(A(S),c)\le 1/2-1/q(s)
$$

with the source success probability. Then the edge is true.

**Proof.** Choose a full-support reference marginal $P^\star$ over finite
encoded instances. Applying the marginal-nonuniform source to $P^\star$ gives
one pathwise polynomial resource bound for $A$ on all finite transcripts. Now
run $A$ on the target realizable distribution. The source output is already in
$\mathcal C$, the agnostic excess-error term collapses to zero, and the
assumed uniform gap envelope gives the target weak edge $1/q(s)$. Confidence
is inherited from the source learner. Therefore $A$ itself is an efficient
distribution-free weak realizable proper learner.

**Exponent caveat.** A bound only on the degrees of the marginal-dependent
polynomials is not enough unless the constants are also controlled, or unless
the atlas convention normalizes them away. The family

$$
\gamma_P(s)=1/(a_Ps^K)
$$

has bounded exponent $K$ but no uniform polynomial lower envelope if the
constants $a_P$ are unbounded. So the clean conditional theorem should assume
either $\gamma_P(s)\ge c s^{-K}$ with uniform $c>0$, or directly assume one
uniform polynomial $q$.

### Conditional True Statement: Size-Indexed Semantics

There is also a nearby semantics under which the weak-gap problem would
collapse by diagonalization.

Assume marginals are size-indexed families

$$
\mathbf P=(P_s)_{s\ge 1},
$$

and the guarantee at size $s$ is evaluated conditionally under $P_s$, not under
one global mixture over all representation sizes. Suppose the source guarantee
must hold for every such sequence $\mathbf P$, with one exponent
$K(\mathbf P)$ for the whole sequence.

Under this semantics, a source learner forces a uniform weak exponent. If not,
then for every $j$ there are a size $s_j$, a marginal $P_j$ on the $s_j$-slice,
and a realizable target $c_j$ such that $A$ fails to achieve edge $s_j^{-j}$.
Choosing the bad sizes increasing and defining a size-indexed marginal by
$P_{s_j}=P_j$ stitches the failures without assigning them small mixture
weights. The source guarantee for this stitched sequence would provide one
finite exponent $K(\mathbf P)$. For any $j>K(\mathbf P)$, the source guarantee
at size $s_j$ is stronger than edge $s_j^{-j}$, contradicting the chosen
failure.

Thus, in a slice-conditional model, the edge would become true for the same
reason as the bounded-envelope theorem: once a uniform weak exponent is forced,
properness and resources are already aligned.

This argument does not apply to the current atlas semantics. The current model
uses one global marginal over encoded examples. If bad slices are stitched by

$$
P^\oplus=\sum_j w_j P_j,
$$

then additive PAC error on slice $j$ is multiplied by $w_j$. A weak learner can
ignore sufficiently low-weight hard slices and still beat $1/2$ on the global
mixture. That dilution is exactly why the diagonal proof does not resolve the
recorded edge.

### Brief Target-Negative Witness Search

I checked the local witness family and a short live literature scan for a
proper target-negative class satisfying the source.

- **PCP active-slice classes.** These give the cleanest weak proper target
  hardness: a proper weak learner would distinguish satisfiable from
  unsatisfiable PCP instances. But this also refutes the assigned source,
  because the source is already proper. So the witness is target-negative but
  not source-positive.

- **One-way image-coordinate weak handles.** These satisfy the source only by
  adding proper handles. The same handles give an inverse-polynomial weak
  realizable proper learner distribution-free, so the target is positive.

- **Fixed-$k$ DNF / Pitt-Valiant style proper hardness.** These are useful for
  weak-versus-strong proper separations. They do not refute the weak proper
  target; fixed-$k$ DNF is already weakly properly learnable.

- **Halfspaces and agnostic weak-hardness results.** Results such as weak
  agnostic hardness for monomials by halfspaces attack agnostic learning or
  stronger accuracy goals. They do not produce a realizable weak proper
  target-negative witness satisfying the marginal-nonuniform weak agnostic
  proper source.

- **Distribution-fixed proper-learning results.** The 2025 proper-learning
  work on unlabeled data confirms that proper learnability has nonmonotone and
  representation-sensitive behavior. Its distribution-fixed positive result
  assumes the marginal is given and is not an efficient binary proper
  source-positive / target-negative witness for this edge.

The search did not find a target-negative proper witness satisfying the source.
The recurring obstruction is leakage: any proper handle strong enough and easy
enough to certify the source tends to be reusable by the distribution-free weak
target. If the handle edge is hidden below every fixed inverse polynomial, then
agnostic validation, orientation, or pathwise runtime blocks the source proof.

### Branch Conclusion

Under the current global-marginal atlas semantics, this branch does not resolve
the edge. It does sharpen the dependency:

- If the source has one uniform weak-gap polynomial envelope, the edge is true.
- If the model is changed to size-indexed, slice-conditional marginals, the
  diagonal stitching argument forces weak-gap uniformization and the edge is
  true.
- Under the present semantics, properness creates no additional obstruction
  after weak-gap isolation, but it blocks the standard proper-hardness
  counterexamples from satisfying the source.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`

## Depth 3 Branch A: Proper Target Weak-Gap Consolidation

### Scope

This pass treats the proper target as the final obstruction check. I read the
current edge, both definition notes, the `marginal-uniformization-open` and
`full-support-marginal-uniformization` arguments, the sibling edge

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
->
efficient-weak-realizable-proper-pac
```

and the local witness families that appear in false incoming edges to
`efficient-weak-realizable-proper-pac`: PCP active slices, pseudorandom
function classes, clause-satisfaction lookup classes, one-way image-coordinate
weak handles, fixed-$k$-term DNF, and halfspaces. I also checked the live
primary-source trail around Hanneke-Moran-Thiessen marginal-nonuniform
learning, Schapire weak learning, Kearns-Valiant cryptographic hardness, and
recent distribution-fixed/proper-learning work.

The result is still not an unconditional atlas resolution. The best final
statement is conditional: once a distribution-free weak-gap envelope is added,
the edge is true; without that envelope, the standard false witnesses still do
not fit.

### Consolidated Positive Route

Let $A$ be the source learner. For every marginal $P$, the source gives a
polynomial resource bound and a weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s),
$$

where $\gamma_P(s)$ is inverse-polynomial with a polynomial allowed to depend
on $P$. On realizable labels $Y=c(X)$, the agnostic optimum over
$\mathcal C$ is zero, so the same learner outputs $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s).
$$

The output is already proper. This is the important consolidation point:
properness contributes no additional obstruction after the realizable
restriction.

The full-support transcript argument can uniformize one-call sample use and
runtime. Choose a full-support reference marginal $P^\star$ over finite
encoded examples. Since every finite labeled transcript that can arise under
any target marginal has positive probability under $P^\star$ for a suitable
labeling rule, the source's worst-case/pathwise resource polynomial for
$P^\star$ bounds $A$ on all finite transcripts.

Thus the inherited learner misses exactly one target requirement:

$$
\forall P\ \exists q_P\quad \gamma_P(s)\ge 1/q_P(s)
$$

does not give

$$
\exists q\ \forall P\quad \gamma_P(s)\ge 1/q(s).
$$

If this uniform polynomial $q$ is assumed, the edge is true immediately:
run $A$, use full-support resource uniformization, and use the inherited
proper output. No boosting or properization theorem is needed for this weak
target.

There is also a nearby true theorem under size-indexed, slice-conditional
marginals. If guarantees are evaluated separately on each size slice, bad
weak-gap exponents can be diagonalized into one marginal sequence without
being diluted by small global mixture weights. The source guarantee for that
stitched sequence would force one finite exponent, contradicting arbitrarily
bad slice exponents. This proves the edge in that altered semantics, but not
under the atlas's current global-marginal semantics.

### Last Counterexample Search

I did not find a concrete target-negative proper weak realizable class that
satisfies the source.

**Pseudorandom function classes.** These are target-negative under standard
cryptographic assumptions, but they are source-negative. On the uniform hard
marginal, even a weak realizable proper learner would distinguish a
pseudorandom function from random labels. Marginal-nonuniformity does not help,
because the source must still handle this fixed hard marginal efficiently.

**PCP active-slice lookup classes.** These are the clean target-negative proper
weak witness: a weak proper learner on the all-one active slice would return a
proof accepted on more than half of verifier random strings, separating
satisfiable from unsatisfiable instances when soundness is below $1/2$. But the
same argument refutes the assigned source, because the source learner is also
proper and must work on the realizable satisfiable active-slice marginal.

**Clause-satisfaction lookup classes.** These give proper hardness for stronger
accuracy goals, but not a clean weak target-negative witness. A nonsatisfiable
3-CNF can still have assignments satisfying more than half its clauses, so the
plain clause gadget does not create the $1/2$ threshold needed for weak proper
hardness. Replacing it by a PCP gadget returns to the active-slice source
failure above.

**Fixed-$k$-term DNF.** This remains a proper weak-to-strong separation, not a
weak target separation. The class is already weakly properly learnable, so it
cannot refute `efficient-weak-realizable-proper-pac`.

**One-way image-coordinate weak handles.** These are source-positive only
because constants, singleton handles, or bounded positive-atom handles give a
proper weak advantage. But those same handles give the distribution-free weak
realizable proper target. The strong proper recovery hardness survives, while
the weak target does not fail.

**Halfspaces.** Halfspaces are useful for agnostic hardness, not this target.
In the realizable proper weak setting, they are efficiently learnable by the
usual linear-separation route.

**Distribution-fixed/proper-learning results.** The recent unlabeled-data
proper-learning work confirms that proper learnability is representation
sensitive and nonmonotone, but it does not supply the required binary
computational witness. Its positive distribution-fixed result assumes access
to the marginal/unlabeled distribution in a way that is not the atlas source,
and its impossibility results are not a source-positive marginal weak agnostic
proper construction.

The remaining false template is still a hidden-gap handle hierarchy: for block
parameter $K$, source handles have edge about $s^{-K}$, so every fixed target
exponent can be beaten by choosing $K$ larger. The template still lacks the
source proof. If the learner spends $s^{\Theta(K)}$ time or samples to find or
validate the handle, full-support pathwise resource uniformization kills the
source. If the handle is easy and has any uniform inverse-polynomial mass, it
leaks to the target. If the handle mass is tiny, agnostic validation and the
near-balanced orientation problem reappear.

### Why A False Witness Is So Constrained

A genuine separation would need all of the following simultaneously:

1. A single uniform polynomial-time learner that is proper and weak agnostic
   under every marginal, with only the weak-gap exponent allowed to depend on
   the marginal.
2. A realizable marginal family for which every proper hypothesis with a fixed
   distribution-free inverse-polynomial edge would solve a hard problem.
3. Proper weak handles that are findable and certifiable at the
   marginal-dependent scale without $s^K$ hidden pathwise work.
4. No leakage of those handles to a distribution-free weak proper learner.

The known witnesses each miss one of these requirements. PCP and PRF witnesses
give target hardness but also kill the source. One-way weak handles and
fixed-$k$ DNF satisfy weak proper learnability and therefore make the target
true. Halfspaces and clause gadgets attack the wrong target strength or
realizability/agnostic axis.

### Suggested Atlas Summary Language

If atlas edits are later allowed, I would keep the edge `open` and use language
close to:

```yaml
status: "open"
evidence: unknown
summary: "Open: restricting the source to realizable labels and applying full-support transcript uniformization gives a proper weak learner with distribution-free resources, but only a marginal-dependent weak gap. Properness adds no extra obstruction; the unresolved step is uniformizing the weak advantage from forall P exists q_P to exists q forall P."
family: marginal-uniformization-open
```

Body language:

```text
On realizable labels, the agnostic benchmark is zero, so the source learner
already outputs a proper hypothesis with error at most 1/2 - gamma_P(s).
Full-support transcript uniformization controls the cost of one call to this
learner. The missing target requirement is a distribution-free inverse
polynomial lower bound on gamma_P. A uniform gap envelope, or a size-indexed
slice-conditional marginal semantics, would make the edge true. Current
counterexample templates do not settle the edge: PCP and PRF hardness refute
the proper source as well as the target, while weak-handle constructions leak
to the distribution-free weak proper target.
```

### Branch Conclusion

This branch should not change the edge to true or false. It consolidates the
proper-target story: once the source is proper, the entire obstruction is the
weak-gap quantifier swap. The conditional true routes are clear, and the last
counterexample search did not identify a source-positive, target-negative
proper weak realizable witness.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`

## Depth 4 Branch A: Proper Target Model-Fork Consolidation

### Scope

This pass only revisits the final weak-gap uniformization issue for the proper
target. I did not edit atlas files or `references.bib`. The question is
whether one of four nearby semantics changes the outcome:

- the current global-marginal atlas semantics;
- size-indexed, slice-conditional marginal semantics;
- bounded weak-gap exponent semantics;
- stochastic or mixed proper-output semantics.

I also tried one final concrete proper target-negative template. It did not
produce a valid source-positive / target-negative witness.

### Current Global-Marginal Semantics

Under the current atlas definition, the edge is still not resolved.

The inherited source learner $A$ is already proper. On realizable labels
$Y=c(X)$, the agnostic benchmark is zero, so for every marginal $P$,

$$
\operatorname{err}_P(A(S),c)\le 1/2-\gamma_P(s),
$$

with $A(S)\in\mathcal C$ and with $\gamma_P$ inverse-polynomial only after
allowing the polynomial to depend on $P$. The full-support transcript argument
uniformizes the pathwise sample/time bound for this single $A$, but it does not
change

$$
\forall P\ \exists q_P
$$

into

$$
\exists q\ \forall P.
$$

The global-marginal semantics are exactly what blocks the standard
diagonalization. If bad size slices or block parameters are stitched into one
global marginal

$$
P^\oplus=\sum_j w_jP_j,
$$

then failure on slice $j$ contributes only $w_j$ times the conditional error
gap to the global PAC loss. A learner can ignore sufficiently low-weight hard
slices while still beating $1/2$ on the global mixture. This is not a
properness issue; it is the additive-error/marginal-mixture issue.

Thus the current edge should remain open unless one proves a genuine
weak-gap uniformization theorem or supplies a concrete hidden-gap witness that
also satisfies the proper weak agnostic source.

### Size-Indexed Fork

In a size-indexed, slice-conditional model, the same obstruction largely
disappears.

Suppose a marginal is a sequence $\mathbf P=(P_s)_{s\ge 1}$, and the guarantee
at size $s$ is evaluated under $P_s$ itself rather than under a single weighted
global marginal. Suppose further that the source guarantee for a fixed sequence
$\mathbf P$ supplies one marginal-dependent weak exponent for all sizes in that
sequence.

Then the edge becomes true in that fork. If no distribution-free exponent
existed for $A$, then for every integer $j$ one could choose a size $s_j$, a
marginal $P_j$ on that size slice, and a realizable target $c_j$ where $A$
fails edge $s_j^{-j}$. Define a size-indexed marginal by setting
$P_{s_j}=P_j$ on the bad sizes and arbitrary marginals elsewhere. The source
guarantee for this single stitched sequence gives an exponent $K(\mathbf P)$.
For $j>K(\mathbf P)$, the source would force an edge at least on the order of
$s_j^{-K(\mathbf P)}$, contradicting the chosen failure at edge $s_j^{-j}$.

This fork is therefore resolved true, provided the exponent is attached to the
whole size-indexed sequence. It is not the current atlas semantics: the atlas
uses a global marginal over encoded instances, where bad slices can be hidden
behind small mixture weights.

### Bounded Weak-Gap Exponent Fork

A bounded weak-gap envelope also makes the edge true, but the exact bound
matters.

If the source is strengthened so that there is one polynomial $q$ with

$$
\gamma_P(s)\ge 1/q(s)
$$

for every marginal $P$, then the proof is immediate. Run the source learner
on realizable labels, use full-support transcript uniformization for resources,
and use the inherited proper output. No boosting or properization is needed,
because the target is only weak and properness is already satisfied.

A bound on exponents alone is weaker. If all marginals satisfy

$$
\gamma_P(s)\ge 1/(a_Ps^K)
$$

with a common $K$ but unbounded constants $a_P$, then there need not be a
pointwise uniform polynomial lower envelope across all $P$ and all sizes. For
each fixed size $s$, a marginal with $a_P$ much larger than $s$ can still push
the available edge below $s^{-(K+1)}$. If the model ignores finitely many
small-size failures with a marginal-dependent threshold, one can sometimes
hide this constant issue by increasing the exponent, but the atlas target is
best read as requiring one distribution-free weak polynomial, not a
polynomial after a $P$-dependent startup range.

So the clean fork statement is:

- uniform polynomial gap envelope: resolved true;
- uniformly bounded degree plus uniform constants/thresholds: resolved true;
- bounded degree with arbitrary marginal-dependent constants: not enough by
  itself.

### Stochastic Or Mixed Output Fork

Stochasticity does not appear to change the current verdict.

Ordinary PAC learners may already be randomized internally, but the proper
target requires the realized output hypothesis to lie in $\mathcal C$. Under
that interpretation, stochasticity is already included in the source and
target definitions. It does not uniformize the weak gap.

If the target is changed to permit an explicit mixture over proper hypotheses,
then the target is no longer strictly proper in the atlas sense; it is closer
to a convex-hull or randomized-prediction target. Even in that relaxed model,
the weak-gap quantifier problem remains. Zero-one error against a randomized
classifier is linear in the output mixture after conditioning on the sample,
so the mixture's advantage is the average of the advantages of its components.
A mixture cannot manufacture an $\Omega(s^{-d})$ edge from components whose
available correlations are all below that scale.

Mixed outputs also do not solve the orientation barrier from the hidden-handle
templates. Randomizing equally between a default-zero and a default-one handle
cancels the correlation to about zero. Biasing the mixture in the useful
direction requires estimating the sign of the near-balanced bias, which is
exactly the statistically hidden step. Allowing mixed outputs therefore makes
target-negative witnesses harder, not easier, and gives no new proof of the
proper atlas target.

### Final Concrete Witness Attempt: Paired Hidden Handles

The last target-negative template I tried was a paired hidden-handle hierarchy.
For a block parameter $K$, let a size-$s$ block contain

$$
N=s^K
$$

public pairs of atoms. Proper concepts choose an orientation on a hidden subset
or encode a hard core, while legal handle hypotheses mark one sampled pair or
one sampled atom. The intended behavior is:

- for each fixed block marginal, a sampled legal handle has advantage about
  $1/N=s^{-K}$, giving the marginal-nonuniform weak source with an exponent
  depending on the block;
- a distribution-free weak proper learner claiming edge $s^{-d}$ can be
  defeated by choosing $K\gg d$;
- the hard core prevents any better proper hypothesis from being found without
  solving a PCP/PRF/one-way style prediction problem.

This template still fails as an atlas witness.

First, if the learner must find or validate a handle at scale $1/N$, the
agnostic source tends to require $N^{\Omega(1)}=s^{\Omega(K)}$ samples or time.
A full-support reference marginal sees finite transcripts from all $K$, so
such a runtime is not a valid marginal-nonuniform efficient source under the
pathwise convention.

Second, if the handle can be produced from one or a few labeled samples, the
same sampling trick usually leaks to the distribution-free weak target. It may
only give edge $s^{-K}$ on that block, but if the construction includes any
uniformly findable heavy handle, target positivity follows at the same scale.
Hiding the handle below every fixed inverse polynomial reintroduces the
validation/runtime problem.

Third, paired handles do not remove the orientation issue. On two nearly
balanced realizable marginals with

$$
P(c=1)=1/2\pm \eta,
$$

the two orientations require opposite defaults. If the handle correction mass
is $q\ll |\eta|$ while $|\eta|$ is below the sampling resolution of every fixed
polynomial target learner, choosing the wrong orientation is not weakly better
than random guessing. A mixed orientation averages the two sides and gives no
positive edge.

Finally, adding a PCP or PRF hard core makes the target-negative part
plausible, but it also risks refuting the source on the hard marginal. This is
the same source-negative failure as the earlier PCP active-slice and PRF
witnesses. I do not see a way to keep the hard core target-negative while
also giving the proper weak agnostic source a findable, certifiable,
nonleaking hidden handle.

### Consolidation Text

The most accurate atlas-facing consolidation is:

> The edge remains open under the current global-marginal semantics. Restricting
> the source to realizable labels gives a proper weak learner, and full-support
> transcript uniformization controls the resources of one call to that learner.
> The only missing target requirement is a distribution-free inverse-polynomial
> lower bound on the weak advantage. Size-indexed slice-conditional semantics
> or an explicit uniform weak-gap envelope would make the edge true. Allowing
> stochastic or mixed outputs does not remove the quantifier swap, and the
> remaining hidden-handle counterexample templates either fail the proper
> source, leak to the target, or violate pathwise efficiency.

### Branch Conclusion

No model fork justifies changing the current atlas edge to true or false.
The size-indexed and uniform-envelope forks are useful conditional true
statements; stochastic/mixed outputs do not help; and the final paired-handle
witness attempt still fails to satisfy the source without leaking to the
target.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`
## Depth 5 Branch A: Full-Support Gap Squeeze

### Aim

This branch tries to push the only remaining issue harder: can the
full-support transcript idea be upgraded from resource uniformization to weak
gap uniformization, or can one build a deterministic proper false witness
whose fixed-marginal weak gaps are genuinely hidden?

I still do not see an atlas-ready true proof or an atlas-ready false witness.
The strongest new conclusion is that the false witness must be more than a
hidden sparse handle. It must be a source-valid proper weak agnostic cover for
every reweighting of every hard marginal. That reweighting requirement is the
main reason the obvious deterministic center-plus-hard-core construction does
not yet work.

### Positive Squeeze Attempt

The tempting positive argument is to mix a bad target marginal into a
full-support marginal with polynomial weight. Suppose a target learner fails
to get edge $s^{-d}$ on a realizable pair $(P,c)$. Form

$$
P^\lambda=(1-\lambda)R+\lambda P
$$

where $R$ is full-support and $\lambda$ is inverse-polynomial. If the source
learner has gap $\gamma_{P^\lambda}(s)$ on this mixture, then a sufficiently
large mixture gap would force some useful conditional behavior on the
$P$-component: roughly, a global improvement of size larger than
$\lambda s^{-d}$ cannot be supplied entirely by the $R$-component.

The missing inequality is exactly the unresolved one. The source gives only

$$
\gamma_{P^\lambda}(s)\ge 1/q_{P^\lambda}(s),
$$

where the polynomial can depend on the whole mixture, including $\lambda$ and
the hard component. There is no lower bound relating $\gamma_{P^\lambda}$ to
$\lambda$. It may be much smaller than $\lambda s^{-d}$. Choosing $\lambda$
smaller does not help, because the mixture-specific weak polynomial may shrink
with it.

There is also an algorithmic access problem. Even if the mixture learner
returned a proper hypothesis good on the $P$-component, a distribution-free
target learner receives labeled samples only from $P$. It cannot generally
simulate labeled examples from $R$ or from $P^\lambda$ without knowing $c$ off
the support sampled from $P$. Full-support uniformization works for runtime
because it is a pathwise statement about finite transcripts. It does not give
the target learner a labeled simulator for the reference marginal.

So the full-support argument still stops at:

$$
\text{uniform resources} + \forall P\exists q_P\text{ gap}.
$$

It does not produce:

$$
\exists q\forall P\text{ gap}.
$$

### Fixed-Size Compactness Does Not Repair The Gap

For a fixed representation size and a bounded transcript budget, one can
imagine compactness giving a positive minimum advantage over all marginals at
that size. Even granting this optimistic finite-size statement, it is not
enough. The minimum can decay faster than every inverse polynomial as the size
varies.

The current global-marginal semantics are what prevent the usual diagonal
response. A sequence of almost-minimizing size slices can be stitched into one
global marginal only with weights $w_s$. The additive PAC loss on slice $s$ is
then multiplied by $w_s$, so a learner may ignore the worst slices and still
meet a weak global guarantee. This is why the size-indexed fork from depth 4 is
true while the atlas edge remains open.

### Reweighting And Boosting Route

A second positive route is to use the source on reweighted versions of the
target marginal. For a fixed realizable pair $(P,c)$, the source promise
applies not only to $P$ but also to every marginal $Q$ obtained by reweighting
$P$. This resembles the hypothesis oracle used in boosting: every reweighting
has some proper hypothesis with positive correlation.

Two barriers remain.

First, the edge on $Q$ is $\gamma_Q$, so the boosting schedule has no
distribution-free polynomial lower bound. Dovetailing over smaller and smaller
edges can become super-polynomial.

Second, even if the reweighting process builds a good majority vote, the vote
is not necessarily in $\mathcal C$. The present target asks for one proper
hypothesis, not a randomized prediction rule or a boosted committee. Without a
proper closure or projection theorem, the reweighting route gives at most an
improper conditional theorem.

Thus the all-reweightings strength of the agnostic source is real, but I do
not see how to extract a single distribution-free weak proper hypothesis from
it.

### Deterministic False Witness Audit

The most plausible false template is a center-plus-hard-core hierarchy. For a
hard marginal $P_K$, every target concept $c$ is slightly closer to an easy
proper center $g_K$ than to random guessing:

$$
\operatorname{dist}_{P_K}(g_K,c)\le 1/2-s^{-K}.
$$

Then the constant algorithm outputting $g_K$ would be weak on realizable
labels with a marginal-dependent gap. More importantly, the same inequality
would make it weak agnostic by the triangle inequality:

$$
\operatorname{err}_{\mathcal D}(g_K)
\le
\operatorname{err}_{\mathcal D}(c)
+
\operatorname{dist}_{P_K}(g_K,c)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-s^{-K}
$$

whenever the closest concept is one of these $c$'s. A cryptographic or PCP
hard core could then try to make every hypothesis with advantage $s^{-d}$,
for fixed $d<K$, computationally hard to find.

The problem is that the source must work for every marginal, not only for
$P_K$. If there is a region where $g_K$ is wrong on a hard concept, an
adversary may reweight onto that region. On a point mass, the source can often
repair the mistake using a local proper concept. But on a large balanced
reweighting of the hard region, the center advantage can disappear while the
cryptographic or PCP prediction problem remains.

So the false witness needs one of two extra mechanisms:

- a deterministic proper repair net that covers every possible reweighting
  with some positive, marginal-dependent gap; or
- a proof that every reweighting which kills the center advantage becomes
  computationally easy for the source.

Neither mechanism is present in the known candidates. PCP and PRF hard cores
give balanced reweightings that refute the source. Sparse local repairs handle
point masses but not broad balanced reweightings. If repairs are made heavy
and easy enough to cover broad reweightings, they tend to leak a
distribution-free weak proper learner. If repairs stay at scale $s^{-K}$, the
agnostic validation and deterministic orientation barriers from earlier
branches return.

This audit makes the deterministic false route sharper but still incomplete:
the witness must be source-positive under arbitrary reweightings, not merely
under the hard marginal where the target lower bound is proved.

### Properness Check

The final-output properness constraint is still doing real work, but not by
blocking the inherited source learner. On realizable labels, the source output
is already in $\mathcal C$. The obstruction is that the most natural positive
uses of the all-marginals source, especially reweighting and boosting, produce
votes or mixtures. Those are not legal target outputs unless the class has an
extra closure or projection property.

Conversely, the false witness cannot rely on an improper fixed-marginal
learner. Every source repair, center, and handle must itself be a concept in
$\mathcal C$. This is why the clean PCP proper-hardness witness remains
source-negative.

### Depth 6 Directions

1. **Reweighting-cover lemma.** Try to prove or refute the following precise
   statement: if a deterministic polynomial-time proper source satisfies the
   weak agnostic marginal-nonuniform guarantee, then for every hard marginal
   $P$ and target $c$, the set of proper hypotheses it can output on
   polynomially many reweightings of $P$ contains one member with
   distribution-free inverse-polynomial advantage under $P$. A proof would
   resolve the edge true under an explicit proper extraction lemma; a refuting
   example would isolate the exact role of improper boosting.

2. **Center-plus-repair oracle witness.** Build an oracle class with centers
   $g_K$, hard cores, and local repair concepts. First prove the triangle
   inequality source guarantee for every reweighting, not just for the planted
   hard marginal. Only then attempt the target lower bound. This should be
   treated as the cleanest false route because it directly addresses the
   agnostic source.

3. **Balanced-reweighting obstruction theorem.** Formalize the failure mode of
   PRF/PCP hard cores: if a proposed center has only $s^{-K}$ advantage under
   $P_K$, then either a broad reweighting makes the center nearly unbiased
   while preserving target hardness, or the class contains enough deterministic
   repair concepts to give a distribution-free weak target. This would not
   resolve the edge by itself, but it would rule out the main false template.

### Branch Conclusion

The edge remains unresolved. Full-support transcript uniformization cannot be
stretched into weak-gap uniformization without a new lower bound relating the
mixture gap to the hard component weight. The deterministic false witness route
now has a sharper target: it must provide a proper weak agnostic cover for all
reweightings while keeping every distribution-free inverse-polynomial proper
advantage computationally hidden. I do not have that construction.

VERDICT: unresolved

## Depth 6 Branch A: Correlation-Oracle Barrier

### Aim

This branch tests the remaining gap after the full-support squeeze in the
strongest black-box form I can see. The question is whether the extra
agnostic quantifier, together with proper output, secretly forces one uniform
weak advantage on clean labels.

I do not see such a force. In correlation form, the agnostic source is an
extremely coarse proper linear-optimization oracle. Clean realizable labels
are already the case that imposes the largest correlation requirement on the
returned proper concept. Noisy or otherwise agnostic labels only weaken that
requirement unless one has an additional quantitative weak-oracle assumption.

### Correlation Reformulation

Use $\{-1,1\}$ labels. For a fixed marginal $P$, write

$$
\eta(x)=\mathbb E[Y\mid X=x]
$$

for an arbitrary agnostic conditional label rule. For $h\in\mathcal C$,

$$
\operatorname{err}(h)=\frac{1-\langle \eta,h\rangle_P}{2}.
$$

Let

$$
M(\eta)=\sup_{c\in\mathcal C}\langle \eta,c\rangle_P.
$$

The weak agnostic guarantee

$$
\operatorname{err}(A)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s)
$$

is equivalent to

$$
\langle \eta,A\rangle_P\ge M(\eta)-1+2\gamma_P(s).
$$

On clean labels $\eta=c_0\in\mathcal C$, $M(\eta)=1$, so the guarantee says

$$
\langle c_0,A\rangle_P\ge 2\gamma_P(s),
$$

which is exactly the inherited proper weak edge. If the labels are a noisy
version $\eta=\alpha c_0$ with $0\le \alpha\le 1$, the same guarantee only
forces

$$
\alpha\langle c_0,A\rangle_P\ge \alpha-1+2\gamma_P(s).
$$

For every $\alpha<1$, this is weaker than the clean-label constraint whenever
the right-hand side is positive, and it is vacuous when
$\alpha\le 1-2\gamma_P(s)$. Thus the agnostic cases do not amplify the
required clean-label advantage. They ask the learner to be a proper
approximate optimizer only to additive error almost $1$, and the clean
realizable case is the extremal one for forcing positive correlation.

This is the main reason I no longer expect a proof whose only new ingredient
is "the source is agnostic." A proof of the edge would need a stronger
structural consequence of the existence of this oracle, not just a direct
calibration or noise-smoothing argument.

### Properness Does Not Supply A Projection

Properness helps in one place and hurts in another. It helps because the
source output on clean labels is already legal for the target. It hurts
positive extraction because all the natural ways to use the all-marginals
strength of the source produce several proper hypotheses.

For example, run the source on reweightings $Q_1,\ldots,Q_T$ of the target
marginal $P$. Each call returns some $h_i\in\mathcal C$ with a
$Q_i$-dependent edge. If these were weak hypotheses with a known lower
envelope, a boosting or minimax argument could combine them into a good
predictor. But the target must output one concept in $\mathcal C$, not a vote.
Without a closure theorem saying that the vote projects back into
$\mathcal C$, the only legal extraction is to select one $h_i$.

Selection is exactly where the hidden exponent reappears. A polynomial
holdout can certify advantage at scale $s^{-d}$, but if all available
proper hypotheses have original-$P$ correlations between $s^{-K}$ and
$2s^{-K}$ for some marginal-specific $K\gg d$, validation sees them as
unbiased. The agnostic guarantee remains satisfied for that $P$ with exponent
$K$, but the distribution-free target has learned nothing at its fixed scale.

So properness plus agnosticism gives:

$$
\forall Q\ \exists h_Q\in\mathcal C:
\langle c,h_Q\rangle_Q\ge 2\gamma_Q(s),
$$

not:

$$
\exists h\in\mathcal C:
\langle c,h\rangle_P\ge s^{-k_0}
$$

with $k_0$ independent of $P$.

### What A False Witness Would Have To Do

The depth-5 center-plus-repair template now has a sharper formal target. A
deterministic proper counterexample would need a uniform polynomial-time
learner $A$ and a hierarchy of hard marginals $P_K$ such that:

1. On clean labels from $c_K$, some easy proper output, say a center or repair
   concept, has only tiny correlation
   $\langle c_K,h\rangle_{P_K}\asymp s^{-K}$.
2. For every reweighting $Q$ of every hard marginal and every agnostic label
   rule with nontrivial optimum, the same algorithm can still find a proper
   concept satisfying the coarse optimizer inequality
   $\langle \eta,h\rangle_Q\ge M(\eta)-1+2\gamma_Q(s)$.
3. Nevertheless, for every fixed target exponent $d$, choosing $K\gg d$ makes
   every polynomial-time proper hypothesis with correlation at least $s^{-d}$
   computationally hard to find.

The hard part is item 2. Sparse repairs cover point masses and tiny traces but
fail on broad balanced reweightings. Broad deterministic repairs cover those
reweightings but tend to leak a distribution-free weak proper learner. A PCP
or PRF hard core can supply item 3, but then the broad balanced reweightings
usually make item 2 false because the source itself would need to solve the
hard prediction problem.

This is also why randomized or improper handles are misleading here. A
prediction-time randomized handle can be orientation-free, and a boosted vote
can aggregate many tiny correlations. Neither is a legal final output for this
proper target.

### No Resolution From The Full-Support Mixture

The full-support squeeze still stops exactly at the gap. If one mixes a hard
marginal $P$ into a full-support marginal

$$
P^\lambda=(1-\lambda)R+\lambda P,
$$

the source's mixture gap may be smaller than $\lambda s^{-d}$, because the
polynomial attached to $P^\lambda$ is allowed to depend on the entire mixture.
The correlation reformulation makes the failure stark: the source only
promises optimization to additive error $1-2\gamma_{P^\lambda}$, and that
additive error can be too coarse to notice the $P$ component at the target
scale. Full support controls which transcripts can occur; it does not lower
bound the mixture's correlation gap.

### Depth 7 Directions

1. **Proper coarse-optimization cover.** Prove or refute a finite-cover lemma
   for the correlation inequality above: does one polynomial-time proper
   coarse optimizer for every marginal imply a uniform proper hypothesis with
   distribution-free clean correlation? The lemma should avoid votes and
   output a single concept.

2. **Oracle center-plus-repair construction.** Build a relativized class where
   items 1-3 in the false-witness checklist can be tested without
   cryptographic overhead. The first goal is source positivity under every
   reweighting, not target hardness.

3. **Balanced-reweighting dichotomy.** Formalize the apparent dichotomy for
   deterministic repairs: either broad reweightings kill the source, or the
   repair family is broad enough to leak a fixed distribution-free weak proper
   edge.

### Branch Conclusion

The edge remains unresolved. The new obstruction is that the weak agnostic
source is only an additive-$\approx 1$ proper correlation optimizer; clean
labels already impose its strongest positive-correlation requirement, and
properness gives no generic way to project reweighting-based votes back to a
single concept. I therefore do not have an atlas-ready proof of truth, and the
false direction still lacks a deterministic proper repair family that covers
all reweightings without leaking a uniform weak target.

VERDICT: unresolved
scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md

## Depth 7 Branch A: Final Consolidation

### Final Resolution Attempt

I do not see an atlas-ready proof of truth or falsity at the final allowed
depth. The strongest positive reduction still reaches only the inherited
learner with uniformized resources and a marginal-dependent weak gap.

Let $A$ be the source learner. On realizable labels $Y=c(X)$, the agnostic
optimum over $\mathcal C$ is zero, so the source guarantee gives

$$
A(S)\in\mathcal C,\qquad
\operatorname{err}_P(A(S),c)\le 1/2-\gamma_P(s)
$$

where $\gamma_P$ is inverse-polynomial only with a polynomial allowed to
depend on the marginal $P$. The full-support transcript argument can still
make the sample and time bound of this one call distribution-free, under the
atlas pathwise finite-transcript convention. It does not lower-bound
$\gamma_P$ by one polynomial independent of $P$.

The final positive pressure test was whether the agnostic all-marginals
promise forces this missing lower envelope. In $\{-1,1\}$ notation, for
$\eta(x)=\mathbb E[Y\mid X=x]$ and

$$
M_P(\eta)=\sup_{c\in\mathcal C}\langle \eta,c\rangle_P,
$$

the weak agnostic guarantee is just

$$
\langle \eta,A\rangle_P\ge M_P(\eta)-1+2\gamma_P(s).
$$

For clean labels $\eta=c_0$, this becomes

$$
\langle c_0,A\rangle_P\ge 2\gamma_P(s).
$$

Noisy labels $\eta=\alpha c_0$ only weaken the required clean correlation,
and for $\alpha\le 1-2\gamma_P(s)$ the inequality can be vacuous. Thus the
source is an additive-nearly-1 proper correlation oracle; agnosticism does not
by itself amplify the clean-label advantage.

The mixture squeeze also fails at exactly this scale. If
$P^\lambda=(1-\lambda)R+\lambda P$, the source gap attached to
$P^\lambda$ may be smaller than $\lambda s^{-d}$. Then the additive
optimization guarantee is too coarse to force useful conditional behavior on
the $P$ component. A PAC learner for the target marginal also cannot generally
simulate labeled examples from the auxiliary full-support marginal $R$,
because it does not know the target concept off the observed $P$ samples.

### Proper-Output Constraint

The target output must be a single deterministic proper classifier
$h\in\mathcal C$; a vote, mixture, randomized prediction rule, or convex-hull
predictor is not a legal final output for this edge.

This matters in the positive direction. The source may be run on many
reweightings $Q$ of the target marginal, producing proper hypotheses
$h_Q\in\mathcal C$. With a known uniform weak edge, a boosting or minimax
argument could combine them into a strong improper predictor. Here the weak
edge is $Q$-dependent, and even a successful combination is not necessarily in
$\mathcal C$. To stay proper one must select one hypothesis. Selecting one at
correlation scale $s^{-d}$ requires a holdout test at that scale, but the
available correlations may all be around $s^{-K(P)}$ for $K(P)\gg d$.

This also matters in the false direction. A source-positive witness cannot
use an improper fixed-marginal learner, randomized handles, or boosted votes
to satisfy the source. Every center, handle, and repair used by the source
must itself be a concept in $\mathcal C$.

### Conditional True Principles

The edge is true under any of the following extra principles.

1. **Uniform weak-gap envelope.** If the source learner has one polynomial
   $q$ such that $\gamma_P(s)\ge 1/q(s)$ for all marginals $P$, then running
   the source learner on realizable labels gives the target. Full-support
   transcript uniformization supplies distribution-free resources, and the
   output is already proper.

2. **Uniform bounded constants and thresholds.** A common exponent is not by
   itself enough if the constants are marginal-dependent and unbounded. But a
   genuine envelope, or a common exponent with uniform constants/startup
   thresholds in the atlas size regime, again gives the target.

3. **Size-indexed slice-conditional semantics.** If marginals are sequences
   $(P_s)$ and the guarantee at size $s$ is evaluated on the size-$s$ slice
   rather than on one weighted global marginal, bad exponents can be
   diagonalized into a single marginal sequence without mixture dilution. The
   source guarantee for that sequence then forces one finite exponent. This
   resolves the fork true, but it is not the current global-marginal atlas
   semantics.

4. **Proper extraction from reweightings.** If one had a theorem saying that
   the collection of proper outputs obtained from polynomially many
   reweightings contains a selectable member with distribution-free
   inverse-polynomial correlation under the original marginal, the edge would
   be true. This is exactly the missing projection/selection lemma; ordinary
   improper boosting does not provide it.

### Failed Deterministic Proper False-Witness Templates

The final false route also remains incomplete. A counterexample must satisfy a
very restrictive checklist: one uniform polynomial-time proper weak agnostic
source for every marginal and reweighting, but no polynomial-time proper
learner with any fixed distribution-free inverse-polynomial clean correlation.

The known templates fail as follows.

- **PCP or PRF hard cores:** these can make the target hard, but broad
  balanced hard marginals also refute the assigned proper source.

- **One-way weak handles and sparse local repairs:** these can make the source
  easy on some marginals, but if the handles have a fixed inverse-polynomial
  mass they leak to the distribution-free weak proper target. If their mass is
  hidden at $s^{-K}$, agnostic validation and orientation require
  $s^{\Theta(K)}$-scale work or fail on balanced reweightings.

- **Center-plus-hard-core hierarchies:** a deterministic center $g_K$ can give
  only $s^{-K}$ correlation under the planted hard marginal, but reweighting
  onto the region where $g_K$ is wrong kills the center advantage while
  preserving the hard prediction problem. Sparse repairs cover point masses
  but not broad reweightings; broad repairs tend to leak a target learner.

- **Paired or orientation-free handles:** random mixtures can avoid choosing a
  sign, but randomized prediction is not deterministic proper output. A
  deterministic proper handle must choose an orientation, and near-balanced
  label bias can hide that sign below every fixed polynomial sample budget.

- **Countable heavy-trace memorization:** if the trace bound has a hidden
  unbounded exponent, it conflicts with pathwise efficiency under a
  full-support marginal. If the trace bound is uniformly polynomial, the same
  proper tables tend to make the distribution-free weak target true.

The most plausible remaining separation would be an oracle
center-plus-repair construction where every reweighting has a findable proper
repair with marginal-dependent correlation, while every fixed target-scale
proper correlation remains computationally hidden. I do not have such a
construction, and the balanced-reweighting dichotomy above suggests why it is
hard.

### Proposed Atlas Summary

```yaml
status: "open"
evidence: unknown
summary: "Open: on realizable labels the marginal-nonuniform weak agnostic proper source already outputs a proper weak hypothesis, and full-support transcript uniformization controls one-call resources. The unresolved step is weak-gap uniformization: the source gives forall P exists q_P, while the distribution-free weak target needs exists q forall P."
family: marginal-uniformization-open
```

### Proposed Proof-Status Body

On realizable labels, $\operatorname{OPT}_{\mathcal C}=0$, so the source
learner returns $h\in\mathcal C$ with error at most
$1/2-\gamma_P(s)$. The properness and realizability axes therefore line up,
and a full-support finite-transcript argument can make the resource bound for
this one learner distribution-free. What remains is the weak-gap quantifier
swap from a marginal-dependent inverse polynomial $\gamma_P$ to one
distribution-free inverse polynomial.

In correlation form, the weak agnostic promise is an additive-nearly-1 proper
optimization oracle,
$\langle \eta,h\rangle_P\ge M_P(\eta)-1+2\gamma_P(s)$. Clean labels already
impose the strongest positive-correlation requirement; noisy labels and
mixture marginals do not amplify the clean advantage. Reweighting and
boosting routes produce collections, votes, or mixtures of proper hypotheses,
but the target requires a single deterministic proper output.

Known false-witness templates do not settle the edge. PCP and PRF hard cores
make the target hard but also refute the proper source. Sparse weak handles
and one-way-coordinate repairs either leak to the distribution-free weak
proper target or fail agnostic validation/orientation at the hidden gap scale.
Center-plus-hard-core constructions still lack a deterministic proper repair
family that covers all reweightings without leaking a uniform weak target.

The atlas edge should remain open unless a genuine weak-gap uniformization
theorem or a source-positive deterministic proper hidden-gap hierarchy is
found.

VERDICT: unresolved
scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md
