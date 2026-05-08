# Edge: efficient-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- source: `efficient-realizable-improper-pac`
- target: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- family: `properization-open`

## Bottom Line

I do not have an atlas-ready proof or counterexample. The edge should remain
`open`.

The source is strong in two useful ways: it is distribution-free and strong
realizable. The atlas already records that this is enough to obtain
`efficient-marginal-nonuniform-weak-agnostic-improper-pac`, by low-noise weak
agnostic robustification. The remaining step is exactly properization:
converting an external predictor into a represented concept from
$\mathcal C$ under a fixed marginal, with only a hidden inverse-polynomial
weak advantage requirement.

I found no generic efficient properization theorem. I also could not turn the
standard properness-hardness witnesses into a fixed-marginal weak agnostic
proper separation. The best one-length Hadamard/one-way-function construction
has the right geometry, but making it work for all representation sizes under
one finite-encoded marginal reintroduces tail-mass dilution or countable-atom
orthogonality barriers.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--sample-efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `references.bib`
- sibling scratchpads for the nearby weak and agnostic marginal properization edges dated 2026-05-05

Primary or near-primary external checks:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview: https://openreview.net/forum?id=aoVCFtox89. Used for the quantifier pattern: the rate may depend on the marginal but must hold uniformly over concepts for that marginal.
- Hopkins, Kane, Lovett, and Mahajan, *Realizable Learning Is All You Need*, TheoretiCS 2024: https://theoretics.episciences.org/13009. Useful sanity check for realizable-to-agnostic reductions; it does not supply properization from an improper learner.
- Schapire, *The Strength of Weak Learnability*, Machine Learning 1990, DOI/PDF links through https://doi.org/10.1023/A:1022648800760. Used to check that boosting produces an aggregate predictor, not a generic member of the original class.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, PDF: https://cs.nyu.edu/~khot/papers/minDNF.pdf. Used for the constant-advantage DNF near miss.
- Hastad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing 2005: https://theoryofcomputing.org/articles/v001a007/. Used for the active-slice PCP template.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, DOI: https://doi.org/10.1145/174644.174647, and Hastad-Impagliazzo-Levin-Luby, *A Pseudorandom Generator from any One-way Function*, DOI: https://doi.org/10.1137/S0097539793244708. Used for one-way-function hardness background.
- Plotkin 1960, McEliece-Rodemich-Rumsey-Welch 1977, and Guruswami-Vadhan 2010 as listed in `references.bib`, for the coding/list-decoding obstruction recorded in `properization-open.md`.

## Factorization Through The Known True Edge

The source already gives a weak agnostic improper learner. The atlas true edge

```text
efficient-realizable-improper-pac
->
efficient-marginal-nonuniform-weak-agnostic-improper-pac
```

uses the low-noise argument:

1. If $\operatorname{OPT}_{\mathcal C}$ is not small, an improper neutralizer
   such as a constant classifier can be validated.
2. If $\operatorname{OPT}_{\mathcal C}$ is very small, repeatedly run the
   realizable learner on fresh batches while pretending the labels are clean.
   With inverse-polynomial probability a batch is consistent with a near-best
   concept.
3. Validate the resulting external hypotheses.

The output remains improper. Thus the assigned edge factors as

```text
realizable improper source
  -> weak agnostic improper prediction
  -> ? weak agnostic proper prediction
```

and the second arrow is exactly the open marginal weak agnostic properization
edge.

The sample-only analogue is true: once running time is ignored, VC/sample
theory and unbounded ERM over $\mathcal C$ give proper agnostic learning. This
does not resolve the computational edge because proper ERM/search over
$\mathcal C$ can be the hard part.

## Positive Route: Why The Source Does Not Properize Itself

The desired target learner must output $h\in\mathcal C$ such that, for each
fixed marginal $P$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
\qquad
\beta_P(s)=1/2-\gamma_P(s),
$$

where $\gamma_P$ is inverse-polynomial in the representation size, with the
polynomial allowed to depend on $P$.

The source learner supplies prediction, not representation search. Running the
source, or its low-noise robustification, gives an external hypothesis $g$ with
nontrivial performance. It gives no generic way to find a concept
$h\in\mathcal C$ having even weak advantage under the same marginal.

The marginal-nonuniform quantifier also does not give advice. It says that one
uniform learner has a $P$-dependent polynomial analysis. It does not give the
algorithm the marginal $P$, a finite high-mass support, a proper cover, an
enumeration cutoff, a proper ERM oracle, or a projection map.

Boosting is not the missing operation. Schapire/Freund-style boosting can turn
weak realizable prediction into strong prediction, but the boosted majority or
aggregate is generally outside $\mathcal C$. Agnostic boosting variants have
similar properness issues, and the atlas fixed-additive weak agnostic notion
does not provide a requested gap parameter.

Hopkins-Kane-Lovett-Mahajan's realizable-to-agnostic framework is also not a
properization theorem for this edge. It explains broad realizable/agnostic
equivalences, but the property needed here is "output a represented element of
the original class." Starting from an improper learner, the reduction still
does not create an efficient proper search procedure.

Conditional positive statement that would suffice but is not implied by the
source:

> For every fixed marginal $P$, if the represented class admits an efficient
> weak proper selector, approximate proper ERM, computable $L_1(P)$ cover by
> valid concepts, or constant-slack projection oracle from external predictors
> to $\mathcal C$, then the source learner followed by that selector gives the
> target.

No checked note or source shows that arbitrary efficiently realizable
improper PAC classes have such fixed-marginal selectors.

## Counterexample Route 1: PCP Active Slices

The PCP active-slice lookup class is the sharpest weak proper hardness template.
For an input NP instance $\varphi$, put all mass on its verifier-randomness
slice. Proper hypotheses encode proofs. Perfect completeness gives a zero-error
proper proof when $\varphi$ is satisfiable, while soundness below $1/2$ says no
proof has weak advantage when $\varphi$ is unsatisfiable. A weak proper learner
on this slice would decide the language.

The source side is fine. The active slice has polynomial size because the PCP
uses logarithmic randomness, so an improper learner can memorize the positive
sampled points and predict zero elsewhere. This gives efficient distribution-
free realizable improper learning, and even nearby agnostic improper lookup
learning.

Why this does not refute the assigned target:

- The hard marginal depends on $\varphi$. In a marginal-nonuniform target, the
  runtime polynomial and the weak gap may depend on this marginal. A SAT
  reduction would no longer get a uniform polynomial bound in $|\varphi|$.
- Packing all active slices into one fixed marginal dilutes the gap. If the
  slice for $\varphi$ has mass $w_\varphi$, the local PCP gap is multiplied by
  $w_\varphi$. Because the target only promises a hidden inverse-polynomial
  advantage over an additive tolerance close to $1/2$, a low-mass hard slice
  can be ignored.
- Removing the active-slice identity creates wrong-instance handles. On a
  shared verifier-randomness space, unrelated satisfiable instances with
  perfect proofs can look like high-acceptance proper hypotheses for the wrong
  target.

Thus the PCP witness separates distribution-free weak proper targets, but not
this marginal-nonuniform weak target.

## Counterexample Route 2: Clause And DNF Hardness

The clause-satisfaction lookup class resolves strong proper agnostic targets.
Under the fixed uniform clause marginal, formula clauses are labeled $1$ and
non-formula clauses receive fair noise. Satisfiable and unsatisfiable formulas
differ by an inverse-polynomial strong-accuracy gap, so a strong proper learner
run to sufficiently small excess error finds a satisfying assignment.

The weak target cannot be forced this way. A weak learner is not run with an
accuracy parameter. Its additive tolerance may be almost $1/2$, so a gap of
order $1/|X_n|$ does not force a satisfying assignment. Fair-noise padding
also raises the baseline, making the weak additive guarantee still more
permissive.

Khot-Saket DNF hardness is another near miss. It rules out certain constant-
advantage proper DNF learners under complexity assumptions, but the atlas weak
target only asks for some inverse-polynomial advantage whose exponent may be
hidden and marginal-dependent. Fixed-$k$ DNF itself is already a positive weak
proper example in the atlas, so it cannot witness this edge.

## Counterexample Route 3: One-Way Image Coordinates

The one-way image-coordinate class proves the neighboring strong proper edge
false. A seed $s\in\{0,1\}^n$ exposes the bits of $f(s)$ on a length-$n$
coordinate block. An improper learner can memorize the positive atoms. Under
the fixed all-length marginal with block mass $\mu_n=6/(\pi^2n^2)$, a proper
learner run to accuracy $\varepsilon_n=\mu_n/(3n)$ must output a seed $t$ with
$f(t)=f(s)$, inverting the one-way function.

This does not reach the weak target. The weak learner has no accuracy
parameter. Under the all-length marginal, the length-$n$ hard block has mass
$\mu_n\to 0$, so a wrong-length seed, a default hypothesis, or a low-support
handle can already have total error far below $1/2$ for large $n$. The
weak-handle variant in the atlas makes this leak explicit by adding constants
and singleton concepts: weak proper learning becomes easy while strong proper
learning remains hard.

Using a marginal concentrated only on the length-$n$ block would not contradict
marginal-nonuniform learning. The polynomial $p_{P_n}$ may depend on that whole
marginal, hence may depend arbitrarily on $n$. A one-way-function reduction
needs one fixed marginal $P^\star$ whose polynomial bound applies uniformly
across infinitely many hard lengths.

## Best New Attempt: Hadamard Image Codes

At one fixed length, there is a very tempting separation.

Let $f:\{0,1\}^n\to\{0,1\}^n$ be length-preserving and one-way. Define proper
concepts by seeds

$$
c_s(r)=\langle f(s),r\rangle \pmod 2,
\qquad r\in\{0,1\}^n.
$$

Under an arbitrary realizable distribution on $r$, an improper learner can
learn a consistent parity vector by Gaussian elimination. It may output the
vector $y=f(s)$ as an external parity predictor, without finding a seed.
Uniform convergence for the $n$-dimensional parity class gives distribution-
free realizable improper PAC learning at this fixed length.

Under the uniform marginal on $\{0,1\}^n$, distinct parity vectors are exactly
orthogonal. Therefore any proper hypothesis with error below $1/2$ must have
$f(t)=f(s)$. A weak proper learner with any positive advantage would invert the
one-way image.

This is the right geometry, but it is not an atlas-ready counterexample for
the marginal-nonuniform node:

1. If the hard marginal is the length-$n$ uniform marginal $P_n$, then the
   marginal varies with $n$, and the $P_n$-dependent runtime polynomial may
   hide arbitrary nonuniform dependence on $n$.
2. If we make one fixed all-length marginal
   $P^\star=\sum_n\mu_nP_n$, then $\mu_n\to 0$. A weak learner can ignore the
   length-$n$ block once its mass is below the allowed weak additive tolerance.
3. If we try to share one high-mass coordinate space across all lengths, exact
   Hadamard orthogonality wants samples containing arbitrarily many fresh
   unbiased bits. Under the atlas finite-encoded transcript convention, a fixed
   countable marginal has atoms and finite high-mass prefixes. Such a space
   cannot support exact independent fair coordinates at all lengths.
4. Polynomial-length dense codes only give approximate orthogonality. Their
   residual wrong-code correlations are inverse-polynomial at some fixed scale.
   The target's hidden weak advantage may be a smaller inverse polynomial, so
   those wrong codewords may be legal weak outputs.

This attempt is still worth flagging for depth-2 work. It isolates the missing
object: a finite-encoded, all-length, fixed-marginal code family with efficient
improper realizable learning and the property that every proper hypothesis with
any inverse-polynomial positive correlation decodes the hard witness.

## Finite-Trace Positive Semantics Check

There is a possible model-semantics fork.

For a fixed countably supported marginal $P$, choose a finite set $F$ with
$P(F)>1-\tau$. If legal concepts are recursively enumerable and efficiently
evaluable, and if one can effectively find representatives for all traces
$\{c|_F:c\in\mathcal C\}$, then empirical minimization over those representatives
gives weak proper agnostic learning:

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+\tau+\text{estimation error}.
$$

Taking $\tau<1/2$ gives a weak proper guarantee. This conditional theorem would
not even need the improper source.

I do not think it resolves the current atlas edge. The atlas requires
worst-case/pathwise polynomial time on finite encoded transcripts. It does not
explicitly provide:

- a recursive enumeration of legal proper descriptions for every represented
  class;
- a total evaluator for every enumerated description;
- a uniform stopping certificate that enough representatives of the hidden
  high-mass trace have been searched;
- polynomial-in-size bounds on the trace-representative search time for each
  fixed marginal.

Treating all of these as implicit would be a model-level clarification that
would trivialize many weak marginal-nonuniform proper targets. Until that
semantics choice is explicit, it is not an implication proof from the source
node.

## Proposed Atlas Update

No atlas files should be edited from this scratchpad. I would keep the current
metadata:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested sharper summary:

```text
Open: the source robustifies to weak agnostic improper prediction, but no
generic efficient fixed-marginal projection to a proper concept is known; PCP,
clause, one-way-coordinate, and Hadamard-code witnesses either vary the hard
marginal, lose mass at the weak scale, or require non-atomic/all-length
orthogonality outside the atlas finite-transcript convention.
```

Suggested body replacement:

```markdown
`open`.

The source gives distribution-free strong realizable improper learning, and by
low-noise robustification it gives the corresponding marginal-nonuniform weak
agnostic improper learner. The remaining issue is properization: the target
requires a represented member of $\mathcal C$.

A positive proof would need an efficient fixed-marginal weak proper selector,
approximate proper ERM, computable $L_1(P)$ cover by valid concepts, or
projection oracle from external predictors to concepts. These are
representation-level assumptions not implied by an arbitrary improper
realizable learner.

Known false-witness templates remain near misses. PCP active slices and
Khot-Saket/DNF hardness give weak proper hardness only with instance-dependent
or distribution-free marginals; packing the slices into one marginal dilutes
the weak gap. Clause-satisfaction fixed-marginal hardness gives only
strong-accuracy gaps. One-way image-coordinate concepts force proper recovery
only at strong accuracy and leak weak handles. Hadamard-coded one-way images
separate proper from improper at one fixed length, but one fixed finite-encoded
all-length marginal either gives the hard block vanishing mass or cannot
support the exact orthogonality needed to defeat every hidden inverse-
polynomial weak gap.

Thus the edge remains open pending either a generic efficient weak
properization theorem or a fixed-marginal weak proper hardness construction
where every inverse-polynomially correlated proper output recovers a hard
witness while improper realizable learning stays efficient.
```

## Concrete Obstacles

- **Prediction is not search.** The source learner may output an arbitrary
  external hypothesis. It need not reveal a concept representation, a proper
  trace, or a search path through $\mathcal C$.
- **Weak additivity hides small hard sets.** A hard slice of mass $w\ll 1$ can
  often be ignored. Strong learners can request $\varepsilon\ll w$; weak
  learners cannot.
- **Marginal nonuniformity blocks per-instance marginals.** If the marginal
  depends on the hard input, the target's polynomial may depend on that input
  through the marginal.
- **Shared-coordinate codes face the hidden gap.** Polynomial coordinate
  domains leave inverse-polynomial wrong correlations; exact Hadamard safety
  needs exponential or non-atomic coordinate structure.
- **Finite-trace enumeration is a semantics question.** Under strong recursive
  finite-trace assumptions many weak fixed-marginal proper targets become
  easy, but those assumptions are not currently part of the atlas edge.

## Depth-2 Branch Directions

1. **All-length Hadamard obstruction.** Formalize the claim that no fixed
   countable finite-encoded marginal can support exact Hadamard-style
   orthogonality for exponentially many length-$n$ messages at every $n$ with
   constant visible mass. This would make the best one-way repair cleanly
   nonviable under current conventions.
2. **Computational weak-handle hardness.** Search for a cryptographic
   construction where weakly correlated wrong proper hypotheses may exist, but
   finding any one of them from samples is hard and any found one decodes a
   witness. This is the main escape from pure coding barriers.
3. **Agreement-PCP route.** Look for a shared-marginal PCP or agreement-test
   theorem where every weakly correlated proper object identifies the target
   instance or a satisfying witness. Ordinary active slices and ordinary PCP
   soundness are not enough.
4. **Restricted positive theorem.** Prove the edge for classes with efficient
   fixed-marginal trace covers, approximate proper ERM, or projection oracles.
   This would not settle the atlas edge, but it would precisely state the
   missing structure.
5. **Representation semantics fork.** Decide whether atlas computational
   classes always include recursive enumeration/evaluation of proper
   hypotheses and whether marginal-dependent finite-trace search time may be
   absorbed into a polynomial. If yes, several weak marginal-nonuniform
   properization edges may become true for semantic reasons.
6. **Requested-gap variant.** Study a stronger weak target where the advantage
   parameter is supplied or fixed. Polynomial-length PRG/code witnesses look
   much more promising there because the coordinate length can be chosen as a
   polynomial in the requested $1/\gamma$.

verdict: unresolved
confidence: medium-high

## Depth 2 Branch: Hadamard fixed-marginal repair

### Goal

Try to turn the one-length Hadamard/one-way-function witness into a single
fixed-marginal counterexample to

```text
efficient-realizable-improper-pac
->
efficient-marginal-nonuniform-weak-agnostic-proper-pac.
```

The target obstruction should be:

1. improper realizable learning remains efficient by learning an external
   parity/codeword;
2. there is one fixed marginal $P^\star$ for all lengths;
3. for every hard seed $s\in\{0,1\}^n$, every proper hypothesis with
   inverse-polynomial positive correlation under $P^\star$ yields a preimage
   of $f(s)$.

The third condition is the hard one. Since the marginal-nonuniform weak gap
for $P^\star$ is hidden, a reduction cannot pick the code accuracy scale in
advance. To force inversion from an arbitrary valid weak proper learner, wrong
proper hypotheses must have no positive correlation at all, or at least only
super-polynomially small positive correlation for every hard length.

### Atomless Product Repair Works Outside The Atlas Model

There is a clean repair if examples are allowed to be infinite random bit
strings.

Let the instance space be $\{0,1\}^{\mathbb N}$ with the fair product marginal
$P^\star$. For a seed $s\in\{0,1\}^n$, let

$$
a_s = \operatorname{delim}(n,f(s)) \in \{0,1\}^{d(n)}
$$

be a self-delimiting finite binary vector of polynomial length, padded by zeros
to an element of $\{0,1\}^{\mathbb N}$. Define the proper concept

$$
c_s(x)=\langle a_s,x\rangle \pmod 2 .
$$

Under $P^\star$, the finite parity characters are orthonormal:

$$
\mathbb E_{x\sim P^\star} (-1)^{c_s(x)}(-1)^{c_t(x)}
=0
\qquad\text{whenever } a_s\neq a_t.
$$

Thus any proper $c_t$ with error below $1/2$ against $c_s$ must have
$a_t=a_s$, hence $|t|=|s|$ and $f(t)=f(s)$. A marginal-nonuniform weak
agnostic proper learner, restricted to realizable labels from $c_s$, would
therefore invert $f$ under this one fixed marginal.

The source side is also fine in this oracle-style model. A realizable improper
learner reads the first $d(n)$ bits of each sample and learns a parity vector
consistent with the labels by Gaussian elimination. The VC dimension is
$d(n)$, so any consistent external parity generalizes distribution-free. The
learner outputs the recovered coefficient vector $a_s$, not a seed preimage.

So the Hadamard idea is not intrinsically broken. It becomes a conditional
counterexample in a model with atomless product examples or bit-oracle
instances.

It is not atlas-ready because the current atlas conventions are finite
transcript / finite encoded instance conventions. Replacing an infinite
product point by a sampled finite prefix of length $L$ makes the visible mass
for a length-$n$ target equal to $\Pr[L\ge d(n)]$, which tends to zero for any
proper distribution on finite prefixes. Then the same tail-mass dilution
returns: a wrong-length or default-like proper hypothesis can be weakly good
globally while ignoring the hard length.

### Fixed Countable Marginals Have A Top-Atom Obstruction

The strongest finite-encoded obstruction is not just that exact product
measure is unavailable. Any fixed countably supported marginal has a largest
atom, and that atom prevents an unbounded family of binary codewords from
being pairwise weak-safe.

**Claim.** Let $P$ be a countably supported marginal and let $p>0$ be the mass
of its largest atom. For any family $V$ of $M$ functions
$v:\mathcal X\to\{-1,1\}$, if

$$
M > 2 + 4/p,
$$

then there are distinct $u,v\in V$ such that

$$
\mathbb E_P[uv] \ge p/2.
$$

In particular, no all-length code over this fixed marginal can make every
wrong proper hypothesis have nonpositive, or even $o(1)$, correlation once the
proper family has exponential size.

**Proof.** Let $x_0$ be an atom of mass $p$. At least $M/2$ functions in $V$
have the same sign on $x_0$; call this subfamily $W$ and let $m=|W|$.
For each $v\in W$, decompose it as the top-atom coordinate plus the remaining
part:

$$
v = \sigma\sqrt p\, e_0 + \sqrt{1-p}\, w_v,
\qquad \|w_v\|_2=1.
$$

The vectors $w_v$ live in a Hilbert space. Since
$\|\sum_{v\in W} w_v\|_2^2\ge 0$, their average off-diagonal inner product is
at least $-1/(m-1)$. Hence some distinct $u,v\in W$ satisfy

$$
\langle w_u,w_v\rangle \ge -\frac{1}{m-1}.
$$

For that pair,

$$
\mathbb E_P[uv]
= p + (1-p)\langle w_u,w_v\rangle
\ge p-\frac{1-p}{m-1}.
$$

If $m>1+2(1-p)/p$, this is at least $p/2$. Since
$m\ge M/2$, the displayed bound on $M$ suffices.

This is a precise obstruction to the pure Hadamard geometry over finite
encoded samples. For length $n$, the one-way image family has exponentially
many possible proper seeds/images. Once $2^n\gg 1/p$, some distinct proper
hypotheses have constant positive correlation under the fixed marginal.
Therefore the desired implication

```text
positive proper correlation => same one-way image
```

cannot be made true by code geometry alone.

This does not prove that every target seed has an efficiently findable wrong
weak handle. The correlated pairs could be computationally hidden or unevenly
distributed. But it does prove that a fixed countable marginal cannot support
the one-length Hadamard miracle uniformly across all lengths. Any successful
false witness must add computational hardness of finding the wrong weak
handles, not merely coding distance.

### All-Length Block Coding Still Dilutes The Weak Gap

The obvious finite-encoded workaround is to keep exact Hadamard blocks but mix
them:

$$
P^\star=\sum_{n\ge 1}\mu_n U_n,
$$

where $U_n$ is uniform on the length-$n$ Hadamard coordinate block. This keeps
same-length wrong parities orthogonal on their local block, but the hard block
has global mass $\mu_n\to 0$.

For a concept that is active only on length $n$, any hypothesis that behaves
benignly off the hard block already has global error about $\mu_n/2$. Since
the weak target permits error up to $1/2-\gamma_{P^\star}(n)$ for some hidden
inverse polynomial $\gamma_{P^\star}$, sufficiently small $\mu_n$ lets the
learner ignore the hard block entirely. Strong proper learners avoid this by
requesting $\varepsilon\ll\mu_n$; weak learners have no such accuracy knob.

Trying to make every concept active on every block pushes us back to the shared
coordinate problem above. Exact all-length orthogonality wants a product-like
source of fresh fair bits at every scale; a fixed finite-encoded marginal has
atoms, and the top-atom claim prevents the required pairwise correlations.

### Dense Approximate Codes Do Not Beat The Hidden Gap

A finite or efficiently indexable dense code can give exponentially many
codewords with pairwise correlations at most $\varepsilon_n$. This is enough
for a requested-gap weak model: choose the coordinate length so that
$\varepsilon_n\ll\gamma$.

It is not enough here. The target fixes no requested advantage parameter.
For a fixed marginal $P^\star$, the learner's guaranteed gap may be
$\gamma_{P^\star}(n)=n^{-A}$ for an arbitrary, unknown exponent $A$ depending
on $P^\star$. A code with residual correlations $n^{-B}$ only rules out
learners whose hidden advantage is larger than $n^{-B}$. A valid learner with
gap $n^{-(B+1)}$ could legally output a wrong codeword of correlation $n^{-B}$.

To make dense approximate coding work uniformly against all hidden inverse
polynomial gaps, one needs super-polynomially small wrong correlations at
every length under the same fixed marginal. Exact one-length Hadamard gives
this locally. A finite-support small-bias or dense-code construction can give
it at one chosen length. But combining all lengths into one fixed countable
marginal again leaves a largest atom $p$, and the top-atom claim forces
constant positive correlations among a large enough proper family.

### Weak Agnostic Output Does Not Change The Lower-Bound Geometry

For a counterexample, it is enough to run the assumed weak agnostic proper
learner on realizable labels. Then

$$
\operatorname{OPT}_{\mathcal C}=0
$$

and the guarantee reduces to finding a proper hypothesis with error at most
$1/2-\gamma_{P^\star}(s)$. In $\{-1,1\}$ notation this is exactly positive
correlation.

Thus the agnostic quantifier does not rescue the Hadamard reduction. If the
fixed marginal has exact product geometry, the realizable subcase already
forces inversion. If the fixed finite-encoded marginal has wrong proper
hypotheses with positive correlation, the weak agnostic target is allowed to
return them even on realizable data. The distinction between weak realizable
proper and weak agnostic proper is not the active obstruction for this branch;
the active obstruction is fixed-marginal weak-safe geometry.

### Branch Verdict

No atlas-ready repair was found.

The Hadamard/one-way construction is a real counterexample in an enlarged
atomless-product or bit-oracle example model. Under the atlas finite-encoded
fixed-marginal convention, however, any countably supported marginal has a
top atom, and that atom forces constant positive correlations among
exponentially many binary proper hypotheses. Therefore a pure coding repair
cannot guarantee that every inverse-polynomially correlated proper output
decodes the one-way image.

This is a precise obstruction to the all-length Hadamard fixed-marginal repair,
not a proof that the edge is true. A false witness could still exist if the
wrong weak handles guaranteed by the atom/coding obstruction are
computationally hard to find, or if the atlas model is broadened to allow
atomless product samples.

verdict: unresolved; Hadamard fixed-marginal repair fails under current
finite-encoded conventions
confidence: medium-high for the pure-code obstruction, medium for the global
edge remaining open

next branch ideas:

1. Formalize a "computational weak-handle hardness" witness: positive
   correlated wrong proper hypotheses may exist, but finding any such
   hypothesis from samples should be as hard as inversion or another
   cryptographic task.
2. Isolate the model fork: if atomless product / bit-oracle examples are
   admitted, record the Hadamard construction as a conditional counterexample;
   if finite encodings are mandatory, record the top-atom obstruction as the
   reason this route is unavailable.
3. Try a multi-call agnostic/list-decoding reduction. Even if one weak proper
   output need not invert, repeated calls on carefully relabeled distributions
   might force enough structured outputs to recover the one-way image.
4. Prove a restricted positive theorem for classes with efficient
   fixed-marginal trace covers or projection oracles, separating genuine
   properization structure from the failed pure-code false route.

## Depth 3 Branch: computational weak-selector hardness

### Goal

Investigate the remaining false-witness route suggested by the depth-2
Hadamard obstruction: weakly correlated proper hypotheses may exist under the
fixed marginal, but finding any validation-useful one should solve a hard
search problem. This is different from the pure-code goal of making every
wrong proper hypothesis non-correlated.

For a fixed marginal $P^\star$ and realizable target $c_z\in\mathcal C$, the
weak agnostic target, restricted to realizable labels, only asks for a proper
$h$ with

$$
\mathbf E_{P^\star}[h(X)c_z(X)] \ge 2\gamma_{P^\star}(s),
$$

in $\{\pm1\}$ notation, for some hidden inverse-polynomial gap
$\gamma_{P^\star}$. A counterexample therefore needs more than exact-recovery
hardness. It must rule out every efficient way of finding a proper hypothesis
with whatever inverse-polynomial correlation the alleged learner happens to
guarantee.

The desired selector-hardness witness would have four parts:

1. one uniform distribution-free realizable improper learner for $\mathcal C$;
2. one fixed marginal $P^\star$ for the proper lower bound;
3. efficiently simulatable labels for the hard challenge, without knowing the
   hidden witness or preimage;
4. a reduction from any efficiently found inverse-polynomially correlated
   proper output to the hard witness.

The fourth item is the new demand. Existing proper-hardness constructions
usually prove that highly accurate proper outputs recover a witness. Here a
wrong output with a small but positive weak advantage is already legal unless
it is also computationally useful.

### PCP With Wrong-Output Usefulness

The active-slice PCP template almost has the right search flavor. Proper
hypotheses encode proofs, and finding a proof that beats the soundness
threshold solves the source instance. The fixed-marginal weak target breaks
the template in two ways already recorded above: the hard slice either depends
on the instance, or its mass is diluted when all instances are packed into one
marginal.

The natural depth-3 repair is a wrong-output-usefulness gadget. Use one fixed
query marginal, let labels encode the verifier behavior for an instance
$\varphi$, and allow a proper hypothesis to encode some pair $(\psi,\pi)$.
The hoped-for property is:

> If the answer string induced by $(\psi,\pi)$ has any inverse-polynomial
> positive correlation with the label function for $\varphi$, then one can
> extract a satisfying assignment or proof for $\varphi$.

Standard PCP soundness does not give this. It controls proofs for the same
instance against that instance's verifier. It does not say that proofs for
other instances, or malformed instance/proof pairs, have no weak agreement
with the label function for $\varphi$.

Trying to force $\psi=\varphi$ by putting instance-description bits into the
labels creates easier weak handles. If those bits have visible mass, a learner
can recover and copy some of them without finding a satisfying proof. If their
mass is small, the advantage is diluted into the same hidden-gap problem. If a
proper representation may include $\psi$ plus an arbitrary assignment, then
matching the instance-description coordinates can itself become a legal weak
proper output.

So the PCP route would need a stronger object than ordinary soundness: a
cross-instance, list-decodable PCP or agreement theorem in which any weakly
correlated accepting transcript is useful for the original instance. I do not
know a standard theorem of this form, and it would have to work at every
inverse-polynomial correlation scale because the weak advantage is not
requested by the learner.

### One-Way Image And Hadamard Hybrids

The one-length Hadamard image witness has the cleanest selector property:
positive correlation with the target Hadamard codeword implies the same
one-way image. The depth-2 branch explains why this does not survive a single
finite-encoded all-length marginal by geometry alone.

Could the correlated wrong outputs forced by finite atoms be computationally
hard to find? Not for the most direct one-way-image classes. If every seed is
a valid proper hypothesis, then valid hypotheses are easy to sample. Under a
finite polynomial code, random or lightly searched seeds typically expose
positive residual correlations at some inverse-polynomial scale. Under a
countable fixed marginal, matching the top atom or a small heavy prefix gives
the same kind of easy validated handle unless all concepts are neutralized
there. Since the target's $\gamma_{P^\star}$ may be smaller than that residual
scale, such handles can satisfy the weak guarantee without inverting.

One can try to replace ordinary one-wayness by a stronger assumption:

> Given a challenge codeword $G(s)$ through sample access under $P^\star$, it
> is hard to find any valid proper object $u$ with
> $\langle G(u),G(s)\rangle_{P^\star}\ge 1/\operatorname{poly}(n)$, unless
> $u$ yields a preimage or witness.

This is exactly the needed weak-selector hardness assumption. It is not a
consequence of ordinary one-wayness. Ordinary one-wayness forbids finding
$u$ with $G(u)=G(s)$, not finding a legal object with tiny positive agreement.
PRG or pseudorandom-code intuition also does not directly help when valid
objects are easy to sample: validation can search for accidental positive
correlation at the residual code scale.

Thus the one-way/Hadamard hybrid remains a diagnostic. It says what the
selector theorem should prove if examples were atomless or exact orthogonality
were available. Under finite encodings, a standard cryptographic lower bound
would need a new "hard to find any weakly correlated valid range element"
assumption, or it must make valid range elements themselves hard to sample.
The latter move turns the construction back toward NP/PCP-style witness
search rather than ordinary one-way images.

### Finite-Support Lookup With Hard Proper Search

The closest abstract finite-encoded template is a block lookup construction.
For each size $n$, let $F_n$ be a polynomial-size support block and let the
fixed marginal give it inverse-polynomial mass $\mu_n$. The challenge defines
a label string $y_z\in\{\pm1\}^{F_n}$ that is efficiently learnable
improperly as a table or external descriptor. Proper hypotheses are a
restricted family of valid certificates whose induced strings may correlate
with $y_z$. The desired hardness statement is:

> From labeled examples of $y_z$ under the fixed block marginal, finding any
> valid proper certificate with agreement $1/2+1/\operatorname{poly}(n)$ over
> $F_n$ solves the hard search problem for $z$.

This would separate prediction from proper search in exactly the right way.
The source side can be easy because $|F_n|=\operatorname{poly}(n)$: an
improper learner can memorize enough of the finite support, or learn the
external descriptor, in polynomial time. The target side would fail because
proper weak selection over the same finite block is computationally hard.

I do not see a standard instantiation. CSP and PCP labels are simulatable
without knowing a witness when the domain is the set of constraints of the
given instance, but then the marginal depends on the instance. If the domain is
made universal and the instance is moved into labels, proper hypotheses for
wrong instances can match description bits or other public structure without
solving the original instance. If all hard information is pushed into a small
tail block, the global advantage is diluted and off-block handles reappear.

There is also a representation caveat. If legal proper descriptions are not
effectively enumerable or sampleable, the hardness may be an artifact of the
representation language rather than a learning-theoretic witness. If they are
easy to sample, random-candidate plus validation often finds residual weak
handles unless the code has hidden-gap-safe geometry, which depth 2 blocked
for a fixed finite-encoded marginal. A clean witness must therefore make valid
proper certificates hard to find for a standard reason while keeping
improper prediction easy.

This finite-support template is still the most promising abstraction. It
names the exact missing primitive: fixed-marginal weak proper selector
hardness for a polynomial-size visible block. But adding that primitive as an
assumption would be very close to assuming the desired counterexample.

### Interim Reduction Target

A future branch should try to formalize the following as either an oracle
separation or a standard-assumption theorem.

For infinitely many $n$, there is a polynomial-size block $F_n$, an efficiently
samplable fixed marginal $P^\star$ with $P^\star(F_n)\ge n^{-a}$, and a
challenge family $z\mapsto y_z$ such that:

1. the label function $y_z$ is learnable by an improper polynomial-time
   learner under arbitrary distributions over the instance space;
2. examples from $P^\star$ labeled by $y_z$ can be simulated from the hard
   challenge $z$ without knowing the witness;
3. every polynomial-time algorithm that outputs a valid proper
   $h\in\mathcal C$ with
   $\mathbf E_{x\sim P^\star}[h(x)y_z(x)]\ge n^{-b}$ for any fixed $b$
   can be converted into a solver for $z$;
4. all off-block and wrong-output correlations either have super-polynomially
   small global advantage or are covered by the same search hardness.

Item 3 needs to hold uniformly over the unknown exponent because the target
weak gap is hidden. Item 4 is where the known templates fail: constants,
singletons, wrong-length seeds, random valid seeds, instance-description
matches, and finite-prefix representatives all tend to create legal weak
outputs that do not decode the hard witness.

### Branch Verdict

No atlas-ready selector-hardness witness was found.

The computational weak-selector idea is the right remaining negative shape,
but the checked templates still miss one of the fixed-marginal weak
requirements. PCP and CSP gadgets need a nonstandard cross-instance
wrong-output-usefulness theorem. One-way/Hadamard hybrids need a stronger
than-one-way assumption that finding any weakly correlated valid range element
is hard, not merely finding the exact preimage. Finite-support lookup with hard
proper search is the cleanest abstraction, but in its current form it either
varies the marginal, leaks easy public weak handles, or relies on a bespoke
selector-hardness assumption.

verdict: unresolved; keep the atlas edge `open`

confidence: medium-high that standard PCP/one-way/finite-lookup templates do
not yet give this counterexample; medium that a purpose-built oracle or
average-case selector-hardness assumption could realize the abstraction.

next branch ideas:

1. Build an oracle toy model for fixed-marginal weak proper selector hardness.
   This would test the abstraction without pretending it follows from standard
   PCP or one-way assumptions.
2. Search specifically for cross-instance/list-decodable PCP statements where
   any weakly correlated accepting proof string can be decoded into a witness
   for the original instance.
3. Try a finite-support CSP code in which public instance-description
   coordinates are pairwise neutralized, then check whether any remaining weak
   proper handle still solves the CSP.
4. Prove a positive dichotomy for efficiently sampleable proper families:
   under a fixed finite block, random-candidate validation either finds a weak
   proper handle or the family must have an explicit selector-hardness
   obstruction.
5. Revisit requested-gap variants. If the weak advantage is supplied as an
   input, polynomial-length codes and PCP agreement gadgets become much more
   plausible because residual correlations can be driven below the requested
   scale.

## Depth 4 Branch: multi-call properization and finite-marginal dichotomy

- depth: 4
- date: 2026-05-05
- verdict: unresolved-open

### Goal

Push on the two routes still left after depths 1--3:

1. a positive conversion from an efficient realizable improper learner to a
   same-marginal weak agnostic proper learner; and
2. a negative witness where proper weak selection is hard although improper
   realizable prediction is easy.

The key target promise is still very weak but very specific. For a fixed
marginal $P$, one uniform algorithm must output a represented $h\in\mathcal C$
with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s),
$$

where $\gamma_P(s)$ is only promised to be inverse-polynomial in the
representation size under a polynomial that may depend on $P$. Thus a false
witness must defeat every inverse-polynomial weak proper handle under one
fixed marginal, while a true proof must actually find a proper handle in
polynomial time.

### Positive Route A: Realizable-To-Agnostic Reductions Still Output The Wrong Kind Of Object

I rechecked the modern realizable-to-agnostic reduction line, including
Hopkins--Kane--Lovett--Mahajan and the newer representation-preserving
agnostic-to-realizable work of Hanneke--Meng--Shaeiri. These results are
useful sanity checks: they explain why realizable and agnostic learning often
coincide once one has the right finite-cover or representation-preserving
structure.

They do not resolve this edge. The basic black-box reduction draws an
unlabeled sample, runs the realizable learner over many labelings or traces,
and validates the resulting finite candidate list. If the realizable learner
is improper, that candidate list consists of external hypotheses. Validation
can choose a good external predictor, but it does not turn any candidate into
a representation from $\mathcal C$.

The representation-preserving variants are closer in spirit but assume the
property this edge lacks: the realizable learner or reduction has access to a
representation-preserving hypothesis class. They can preserve properness when
properness is already available; they do not manufacture a proper
representation from an arbitrary improper learner.

So the source plus modern realizable/agnostic technology gives the already
recorded true edge

```text
efficient-realizable-improper-pac
->
efficient-marginal-nonuniform-weak-agnostic-improper-pac,
```

but the final projection step remains unsupported.

### Positive Route B: Fixed-Marginal Trace Enumeration Is Not Efficient Enough

For a fixed countable marginal $P$, one can choose a finite set $F$ of large
mass. If we could efficiently find, for every relevant trace on $F$, some
valid concept realizing that trace, then empirical proper ERM on this finite
trace family would give weak agnostic proper learning. This is the strongest
semantic reason the edge might be true.

The obstacle is the word "efficiently." The atlas computational nodes require
pathwise polynomial running time in the representation size. A naive
enumeration of all proper descriptions of length at most $s$ costs
$2^{\Theta(s)}$, and no marginal-dependent polynomial in $s$ can absorb that.
The polynomial's constants and degree may depend on $P$, but it must still be
a polynomial in $s$.

The improper source learner does not fix this. It can be run on hypothesized
labelings of $F$, but the outputs are again external hypotheses. It supplies
no certificate that a trace is realized by a short concept, no way to recover
such a concept, and no stopping rule saying that enough proper traces have
been searched.

Thus a conditional positive theorem is clear:

> If, for every fixed marginal $P$, the class has a polynomial-time
> marginal-dependent weak proper trace selector, approximate proper ERM, or
> projection oracle from validated external predictors to concepts, then the
> edge is true for that class.

But this extra selector is essentially the missing target requirement. I do
not see a way to derive it from efficient improper realizable learning alone.

### Negative Route A: Multi-Call Agnostic Relabeling Does Not Force Exact Proper Outputs

Depth 3 left open a possible rescue for the one-way/Hadamard witnesses:
perhaps a weak proper learner can be called repeatedly on carefully chosen
agnostic relabelings, so that wrong weak handles are eliminated and eventually
a useful preimage or proof must appear.

This does not seem to work generically. On realizable labels, the target
allows any proper hypothesis with inverse-polynomial positive correlation.
If the fixed marginal admits many wrong weak handles, the learner may always
return one of them. After observing a wrong handle $h_1$, we can change the
conditional label rule to penalize $h_1$, but then the original target
concept is no longer necessarily realizable. It can remain near-optimal under
low noise, yet the weak additive tolerance is so large that another wrong
handle may still be legal.

Iterating this process resembles agnostic boosting or list decoding. It can
build an aggregate predictor from weak proper pieces, but the aggregate is
improper. For one-way image classes, an aggregate that predicts the image
bits or parity labels still does not provide a seed preimage. For PCP/CSP
classes, an aggregate of weakly agreeing proof-like objects need not be a
valid proof for the original instance.

To turn this into a lower bound one would need a polynomial-query
"correlation list-decoding" theorem:

> From any polynomial sequence of proper hypotheses, each weakly correlated
> with adaptive relabelings of the same challenge, one can extract the hard
> witness.

The standard witnesses checked here do not provide such a theorem. The
multi-call idea therefore does not upgrade the near misses into a
`resolved-false` result.

### Negative Route B: Neutralizing Public Handles Recreates The Coding Barrier

Another possible false-witness repair is to keep the fixed marginal but
neutralize all easy handles on its heavy atoms or public coordinates. For
example, in the one-way parity picture, force all concepts to agree on the
largest atoms, and put the hard code only on the remaining tail. Or mask the
heavy-prefix labels by a target-dependent hash so that matching public
coordinates no longer gives useful correlation.

Both variants run into the same tradeoff.

If the hard information is moved to a tail of mass $\mu_n$, then the global
weak advantage from solving the hard part is only $O(\mu_n)$. Since
$\mu_n\to 0$ along infinitely many hard lengths, the learner can be valid with
a smaller hidden inverse-polynomial gap while ignoring that tail.

If instead the hard information stays on a fixed high-mass finite prefix, then
there are only finitely many binary traces on that prefix. Supporting
exponentially many hard proper concepts forces many of them to have positive
agreement on the prefix. The depth-2 top-atom argument is the one-point
version of this; applying it after removing any finite heavy prefix gives the
same conclusion on the remaining normalized mass unless the remaining mass is
itself the diluted tail. Dense approximate codes only move the residual
correlation to a chosen inverse-polynomial scale, and the target's hidden
gap can be smaller.

Target-dependent masks also do not obviously help. If the mask is public or
learnable from samples, it becomes another weak handle. If it is hidden, then
the improper learner may also lose efficient distribution-free realizable
learnability. If it is derived from the one-way image, then the construction
has returned to the Hadamard image case, where exact fixed-marginal
orthogonality is unavailable under finite encodings.

So the known proper-hardness witnesses can be made to keep the source
positive, but I still cannot make them block every weak proper handle under
one fixed finite-encoded marginal.

### What Would Resolve The Edge

A `resolved-true` proof would need one of the following representation-level
theorems.

1. **Generic weak proper selector.** From any efficient distribution-free
   realizable improper learner and any fixed marginal $P$, construct in
   polynomial time a proper concept with inverse-polynomial excess over
   $\operatorname{OPT}_{\mathcal C}$.
2. **Effective marginal trace cover.** Show that the source learner implies
   polynomial-time access, for each fixed $P$, to a high-mass finite trace
   cover by valid concepts.
3. **Projection from improper covers.** Show that every validated external
   predictor produced by the realizable-to-agnostic cover reduction can be
   converted to a proper concept with constant or inverse-polynomial loss
   under the same marginal.

I found no route to any of these without adding an oracle that is already a
weak proper learner in disguise.

A `resolved-false` proof would need a witness stronger than the current PCP,
CSP, DNF, and one-way-coordinate templates.

1. **Fixed-marginal weak selector hardness.** Under one fixed marginal, every
   efficiently findable inverse-polynomially correlated proper output must
   reveal a hard witness.
2. **No easy wrong handles.** Constants, wrong instances, wrong lengths,
   heavy-prefix matches, random valid concepts, bounded handles, and
   finite-trace representatives must all either fail the hidden weak gap or
   be computationally as hard as the witness.
3. **Efficient improper source.** The same class must remain efficiently
   distribution-free realizably learnable by an external predictor.

The finite-support lookup abstraction from depth 3 states exactly this, but
no standard assumption I checked supplies it without essentially assuming
the desired selector hardness.

### Depth-4 Verdict

The edge remains open.

I do not see a valid generic properization theorem: realizable-to-agnostic
reductions preserve the improper nature of the source outputs, and fixed
marginal trace enumeration is not polynomial in the representation size
without an additional proper selector.

I also do not see an atlas-ready counterexample: the known proper-hardness
witnesses can keep improper realizable learning easy, but they either vary
the marginal, dilute the weak gap when packed into one marginal, or leak
wrong weak proper handles under a fixed finite-encoded marginal. Multi-call
agnostic relabeling and heavy-prefix neutralization do not remove those
handles without recreating the same coding or tail-mass barrier.

verdict: unresolved-open

confidence: medium-high that the standard witnesses and black-box
realizable/agnostic reductions do not resolve this edge; medium that a
purpose-built oracle or new cross-instance agreement theorem could still
separate the notions.

next directions:

1. Try to prove an oracle separation for fixed-marginal weak proper selector
   hardness, explicitly tracking the hidden inverse-polynomial gap.
2. Search for cross-instance PCP/list-decoding theorems where any weakly
   agreeing proper object yields a witness for the original instance.
3. Formalize a positive theorem for classes with efficient marginal trace
   selectors, then mark exactly which atlas examples satisfy that extra
   structure.
4. Study a requested-gap variant of the target. That version may admit a
   clean one-way/code counterexample because residual correlations can be set
   below the requested weak advantage.

## Depth 5 Branch: proper trace search, representation preservation, and handle legality

- depth: 5
- date: 2026-05-05
- verdict: unresolved-open

### Goal

The depth-4 state leaves three plausible next moves:

1. turn fixed-marginal finite-trace enumeration into an efficient proper
   candidate generator;
2. use representation-preserving realizable-to-agnostic reductions to keep
   outputs proper; or
3. repair the false witnesses by neutralizing public weak handles while
   keeping the represented concepts legal and the source improperly learnable.

I pushed each one as far as I could without changing the model. None resolves
the edge. The common failure mode is sharper now: every positive route needs
a way to find represented concepts, and every negative route must forbid
easy weak handles without also forbidding the intended proper witnesses.

### Positive Route A: Trace Enumeration Needs A Polynomial Proper Representative Map

For a fixed marginal $P$, pick a finite set $F=F(P,s,\tau)$ with
$P(F)\ge 1-\tau$. If, for every representation-size bound $s$, we had
polynomial-time access to the set

$$
T_{P,s,\tau}
=\{c|_F : c\in\mathcal C,\ |c|\le s\}
$$

together with one legal representative $c_t\in\mathcal C$ for each trace
$t\in T_{P,s,\tau}$, then the target would follow by ordinary empirical
selection over these representatives. With $\tau<1/8$, validation on
examples from the agnostic distribution gives

$$
\operatorname{err}(c_t)
\le
\operatorname{OPT}_{\mathcal C}+\tau+O(\text{estimation}),
$$

which is far stronger than the weak tolerance
$1/2-\gamma_P(s)$.

The missing part is not sample complexity. It is computational generation of
proper representatives. The source learner can certify that a trace is
predictable by some external hypothesis when the trace is realizable, but it
does not return a concept representation. Running the improper learner on all
labelings of $F$ only gives a list of improper predictors, and most of those
predictors carry no witness that the corresponding trace came from a short
concept.

Naive enumeration of legal descriptions also does not fit the target. Even if
the representation language is recursively enumerable and evaluation is
decidable, searching all descriptions of size at most $s$ is exponential in
$s$. Marginal-nonuniformity lets constants and degrees depend on $P$, but it
does not let $2^s$ be called polynomial in $s$. It also does not provide an
effective stopping rule: after seeing many descriptions, the learner still
does not know whether all high-mass traces have appeared.

So the valid conditional theorem is:

> If each fixed marginal $P$ admits a polynomial-time, $P$-dependent proper
> trace representative map, approximate proper ERM oracle, or projection map
> from validated external predictors to represented concepts, then this edge
> is true for that class.

This is useful as a local criterion, but it is not derived from
`efficient-realizable-improper-pac`. It should be treated as an extra
selector assumption, not as an atlas-level implication proof.

### Positive Route B: Representation-Preserving Reductions Preserve, But Do Not Create, Properness

The representation-preserving realizable-to-agnostic line is the closest
black-box positive technology because it tries to keep the final hypothesis in
the same representation system. The catch is exactly in the hypothesis:
representation preservation starts with a learner or candidate generator that
already returns represented objects in the desired class or in a controlled
representation-preserving expansion.

For this edge the source learner is allowed to be completely improper. In the
usual reduction pattern, one draws an unlabeled sample, considers many
possible labelings or low-noise events, calls the realizable learner, and then
validates the resulting finite list. If the realizable learner is improper,
the finite list is an improper list. Validation can pick the best external
predictor, which explains the nearby true improper weak agnostic edge, but it
does not supply a represented $h\in\mathcal C$.

Could one wrap the reduction so that the labelings of the unlabeled sample
are themselves used as partial representations of concepts? Only if the class
has an efficient extension operation:

$$
\text{finite trace on }F
\quad\mapsto\quad
\text{some }c\in\mathcal C\text{ realizing the trace}.
$$

That is the same proper trace representative map from Route A. Without it,
the reduction has no way to tell whether a good empirical trace is extendable
by a short legal concept, let alone find such a concept.

Thus the representation-preserving approach gives a clean diagnostic:

- If the source node were `efficient-realizable-proper-pac`, this route would
  be plausible and is partly reflected by neighboring proper-source edges.
- From an improper source, the reduction is representation-preserving only in
  the improper representation it constructs internally.
- Any attempted repair must insert a proper candidate generator, which is
  precisely the missing target-side structure.

I do not see a way to make this a `resolved-true` proof without silently
assuming properness.

### Negative Route: Neutralizing Public Weak Handles Must Preserve Legal Proper Witnesses

The strongest false-witness idea remains a fixed-marginal weak-selector
hardness construction. Prior branches identified many easy handles: constants,
wrong lengths, wrong instances, heavy-prefix matches, random valid seeds,
singletons, bounded subset handles, and finite-prefix representatives.
Depth 5 asks whether these can be neutralized by design.

There are three natural neutralization strategies.

**1. Force all concepts to agree on public heavy atoms.**

This removes top-atom and heavy-prefix correlation handles. But the
distinguishing information is then pushed into the remaining tail. If the
tail carrying a length-$n$ hard instance has mass $\mu_n$, the global weak
advantage available from solving it is also $O(\mu_n)$. Since
$\mu_n\to 0$ over infinitely many hard lengths, an alleged target learner
with hidden gap smaller than $\mu_n$ can legally ignore that hard part. If
one keeps a constant-mass tail for all lengths, the tail is no longer split
into finite encoded hard blocks without reintroducing shared-code
correlations.

**2. Add masks or balancing coordinates.**

A public mask is learnable from samples and becomes a handle. A hidden mask
protects against weak handles but also threatens the source: the improper
realizable learner must still learn distribution-free in polynomial time.
If the mask is recoverable by the improper learner from labeled examples,
then a proper learner may also exploit whatever public trace the mask leaves.
If the mask is tied to a one-way image, the construction returns to the
Hadamard image problem: exact positive-correlation safety exists at one
length or in an atomless product model, but not under one fixed finite-encoded
countable marginal.

**3. Restrict legal concepts so every weakly correlated concept is a real
witness.**

This is the right target property, but making it legal is delicate. In PCP or
CSP templates, proper concepts usually include an instance string plus a
proof or assignment. If wrong instance strings are legal, they can correlate
with public instance-description coordinates. If wrong instance strings are
made illegal relative to the target, then legality becomes target-dependent,
which is not a fixed concept class. If all instance-description coordinates
are neutralized, ordinary PCP soundness only controls proofs for the same
instance; it does not rule out cross-instance weak agreement.

This suggests a precise missing theorem for a counterexample:

> A fixed public marginal and a fixed legal concept class such that, for every
> hard instance label function $y_z$, every legal concept with
> inverse-polynomial positive correlation with $y_z$ yields a witness for
> $z$, while $y_z$ remains efficiently distribution-free improperly
> learnable.

I do not know a standard PCP, coding, or cryptographic theorem with this
cross-instance, all-inverse-polynomial selector property. Existing witnesses
either allow legal non-witness concepts with small positive correlation, or
avoid them by making the marginal depend on the instance.

### Obstacles After Depth 5

- **Trace enumeration is a selector oracle in disguise.** Finite high-mass
  traces give weak proper learning only when one can find legal
  representatives in polynomial time.
- **Representation-preserving reductions are not properness-generating
  reductions.** They preserve represented outputs when such outputs already
  exist in the candidate list.
- **Neutralization trades handles for dilution.** Removing public weak
  handles usually moves the hard signal into a smaller tail, where the hidden
  marginal-dependent weak gap can ignore it.
- **Target-dependent legality is forbidden.** A false witness cannot say that
  only concepts matching the current hard instance are legal; legality must
  be fixed before the target is chosen.
- **Cross-instance weak agreement is uncontrolled.** PCP/CSP soundness and
  one-way exact-recovery hardness do not automatically rule out weakly
  agreeing wrong legal objects.

### Depth-5 Verdict

The edge remains unresolved.

There is still no generic proof of

```text
efficient-realizable-improper-pac
->
efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

because the source gives prediction but not polynomial-time search for legal
proper representatives. There is also still no atlas-ready counterexample:
the best fixed-marginal false witnesses either leak public weak handles or
neutralize them by pushing the hard signal below the hidden weak scale.

verdict: unresolved-open

confidence: medium-high that trace enumeration, current
representation-preserving reductions, and direct handle-neutralization do not
resolve the edge; medium that a new oracle or cross-instance agreement
construction could still give a separation.

### Concrete Depth-6 Directions

1. **Trace-selector theorem or barrier.** Formalize the exact extra oracle
   needed for fixed-marginal trace enumeration:
   given $(P,s,\tau)$ and samples from $P$, output a polynomial-size list of
   legal concepts whose traces cover all high-mass size-$s$ traces. Then prove
   either that common atlas examples satisfy it, or that deriving it from an
   improper learner would imply a known hard proper-search task.
2. **Representation-preserving reduction audit.** Check the precise
   assumptions in the Hanneke--Meng--Shaeiri style reductions: identify the
   line where a proper candidate generator is assumed, and write a short
   lemma saying that replacing it by an improper learner yields only the
   improper weak agnostic target.
3. **Legal cross-instance PCP search.** Look for or formulate an agreement
   PCP in which any legal proof object for any instance that weakly agrees
   with the verifier-label function of $\varphi$ decodes a witness for
   $\varphi$. Track whether the instance string is public, hidden, or part of
   the concept representation.
4. **Oracle weak-selector separation.** Build a relativized finite-block
   class where all weakly correlated legal concepts are hard to find, but the
   label tables are improperly learnable. This would test whether the desired
   counterexample shape is coherent before tying it to PCP or cryptography.
5. **Handle-neutralization invariant.** For any proposed false witness, list
   every legal concept family that is not an intended witness and compute its
   best possible correlation under the fixed marginal. Require either
   super-polynomially small correlation or a reduction from finding it to the
   hard problem. This should catch constants, heavy-prefix concepts, wrong
   instances, wrong lengths, masks, and bounded subset handles early.

## Depth 6 Final Attempt: selector lemma, last counterexample audit, and atlas synthesis

- depth: 6
- date: 2026-05-05
- verdict: unresolved-open
- recommended_family: properization-open
- recommended_evidence: unknown

### Goal

This final pass tried to resolve the edge by forcing one of the three depth-5
targets to become decisive:

1. derive polynomial proper representative maps for fixed-marginal trace
   enumeration from the improper source;
2. turn representation-preserving realizable-to-agnostic reductions into a
   properness-creating reduction; or
3. build a legal neutral-handle counterexample that keeps the hard signal at
   weak scale without target-dependent legality or dilution.

I still do not get an atlas-ready proof or counterexample. The final
diagnosis is sharper: the edge is exactly the absence, in the current atlas
model, of a polynomial-time fixed-marginal weak proper selector.

### Final Positive Attempt: Trace Representatives Would Prove More Than Needed

Fix a marginal $P$ and a representation-size bound $s$. Suppose there were a
uniform procedure whose analysis may depend on $P$ and which, in time
polynomial in $s$ and $\log(1/\delta)$, outputs a list
$L_{P,s}\subseteq\mathcal C$ with the following property:

For every joint distribution $\mathcal D$ with marginal $P$, some
$h\in L_{P,s}$ satisfies

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C_s}\operatorname{err}_{\mathcal D}(c)
+1/4.
$$

Then validation over $L_{P,s}$ gives the target immediately, with a constant
weak gap. A still stronger sufficient condition is a polynomial proper
representative map for high-mass traces:

$$
(P,s,\tau)
\mapsto
\{c_t\in\mathcal C:\ t=c_t|_F,\ P(F)\ge 1-\tau\},
$$

covering every trace on $F$ realized by a size-$s$ concept. Taking
$\tau<1/16$ and validating over representatives gives weak agnostic proper
learning. This would not use the improper source at all.

The source does not imply this map. An efficient realizable improper learner
can output a table, parity vector, regression surrogate, majority vote, or
other external predictor whose existence certifies learnability but not
membership in $\mathcal C$. Running the source on hypothesized labels for a
finite trace only produces more external hypotheses. Exhaustive enumeration
of proper descriptions is exponential in $s$, and marginal nonuniformity
cannot absorb $2^s$ into a $P$-dependent polynomial in $s$.

So the clean positive lemma is conditional, not a resolution:

> **Missing selector lemma.** If every class satisfying
> `efficient-realizable-improper-pac` also admitted a polynomial-time
> fixed-marginal weak proper selector, approximate proper ERM, proper trace
> representative map, or projection from validated external predictors to
> concepts, then the assigned edge would be true.

No checked atlas note or standard reduction derives this selector from an
arbitrary improper learner.

### Final Representation-Preservation Audit

Representation-preserving realizable-to-agnostic reductions are not false
friends, but they preserve a representation already present in the candidate
generator. In the usual sample-splitting pattern, the reduction:

1. draws an unlabeled sample or finite cover;
2. tries labelings, low-noise events, or related subproblems;
3. calls the realizable learner;
4. validates the candidate list.

If the realizable learner is proper, the candidate list contains legal
concepts. If the realizable learner is improper, the candidate list contains
external hypotheses. Validation can choose the best candidate in that list,
which is precisely why the nearby improper weak agnostic edge is true, but
validation has no operation that turns an external hypothesis into a member
of $\mathcal C$.

One might try to use the finite labeled traces themselves as proto-concepts.
That again requires an extension operation

$$
\text{realizable finite trace}
\mapsto
\text{short legal concept realizing it}.
$$

This is the same proper representative map. Thus representation-preserving
technology gives the right bookkeeping once a proper generator exists; it is
not a properness generator from an arbitrary improper source.

### Final Negative Attempt: Legal Neutral Handles Still Leak Or Dilute

A false witness must satisfy all of the following at once:

1. improper distribution-free realizable learning is efficient;
2. there is one fixed marginal $P^\star$ for the lower bound;
3. for infinitely many hard targets, every legal proper hypothesis with the
   target's hidden inverse-polynomial weak advantage yields the hard witness;
4. constants, wrong lengths, wrong instances, heavy-prefix matches, random
   valid concepts, masks, bounded subset handles, and finite-prefix traces are
   not legal weak outputs unless finding them is also hard.

I tried the natural neutral-handle repairs one more time.

**Agreement on heavy atoms.** Force all concepts to agree on the high-mass
public prefix of $P^\star$. This removes top-atom handles, but it moves all
hard information into the tail. Along infinitely many hard sizes, the visible
tail mass must go to zero. The target's weak gap is hidden and may be smaller
than that tail mass, so a learner can be valid while ignoring the hard part.

**Balancing and masks.** Public balancing coordinates are learnable weak
handles. Hidden masks also hide the labels from the improper source unless
the source can recover the mask efficiently from samples; once recoverable,
the trace left by the mask is again a possible proper handle. If the mask is
derived from a one-way image, the construction returns to the Hadamard image
attempt: exact positive-correlation safety works at one length or in an
atomless bit-oracle model, but not under one fixed finite-encoded marginal.

**Restrict legal concepts to real witnesses.** This would be decisive if
legal, but the concept class cannot depend on the target instance. In PCP and
CSP templates, if proper concepts include wrong instance strings, those wrong
instances can weakly agree on public description or verifier coordinates. If
wrong instances are declared illegal relative to the current target, legality
has become target-dependent. If instance coordinates are neutralized,
ordinary PCP soundness still controls only same-instance proofs, not weak
cross-instance agreement by arbitrary legal proof objects.

The exact missing counterexample theorem is therefore:

> **Fixed-marginal weak-selector hardness.** There is a fixed legal class
> $\mathcal C$ and fixed marginal $P^\star$ such that the labels $y_z$ for a
> hard instance $z$ are efficiently distribution-free improperly learnable,
> but any polynomial-time algorithm that outputs a legal
> $h\in\mathcal C$ with
> $\mathbf E_{P^\star}[h y_z]\ge 1/\operatorname{poly}(|z|)$ can be converted
> into a solver for $z$.

The known witnesses do not instantiate this theorem. PCP active slices get a
weak gap only with an instance-dependent marginal. Clause and DNF witnesses
give strong-accuracy proper hardness but not hidden-gap weak hardness.
One-way coordinate witnesses force exact recovery only when the learner is
run to accuracy below the hard block mass. Hadamard image codes give the
right one-length geometry, but one fixed finite-encoded all-length marginal
either dilutes the active block or admits weakly correlated wrong handles.

### Precise Obstruction

The obstruction is not statistical existence. In realizable data, the target
concept itself has zero error. In agnostic data, finite-sample theory gives
proper near-minimizers once computation is ignored. The obstruction is
representation-level search:

$$
\text{good external prediction}
\not\Rightarrow
\text{polynomial-time represented concept search}.
$$

The marginal-nonuniform target weakens uniformity only in the analysis. It
does not give the learner $P$ as advice, a finite support cutoff, a trace
enumeration certificate, a proper ERM oracle, or a projection map. It also
hides the inverse-polynomial weak gap, so lower bounds must defeat every
positive inverse-polynomial proper correlation under one fixed marginal.

This double requirement is why both sides are stuck. A positive proof needs a
selector that is not implied by improper prediction. A negative proof needs
to rule out or make hard all weak handles, not merely all accurate proper
solutions.

### Near-Miss Results For Atlas Incorporation

- The edge factors through the true improper edge:
  `efficient-realizable-improper-pac` gives
  `efficient-marginal-nonuniform-weak-agnostic-improper-pac` by low-noise
  robustification, but this keeps external outputs.
- Sample-only analogues are true by VC/uniform-convergence and unbounded ERM;
  this confirms the obstruction is computational proper search.
- Fixed-marginal trace enumeration would prove the target with room to spare
  if polynomial proper representatives were available.
- Representation-preserving realizable-to-agnostic reductions preserve
  properness from proper candidate generators; replacing the generator by an
  improper learner yields only improper candidates.
- The one-length Hadamard one-way image construction is a genuine model
  boundary: it separates in an atomless or bit-oracle setting, but not under
  the current finite-encoded fixed-marginal convention.
- PCP, clause/DNF, and one-way-coordinate witnesses should remain recorded as
  near misses for this exact edge, not as evidence of falsehood.

### Recommended Atlas Status

Keep the implication as:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested atlas summary:

```text
Open: the source yields weak agnostic improper prediction, but no generic
polynomial-time fixed-marginal selector is known that converts external
predictors or finite traces into represented concepts. Known proper-hardness
witnesses either vary the marginal, require strong accuracy, dilute the weak
signal, or leak legal weak handles under one fixed finite-encoded marginal.
```

Suggested body paragraph:

```markdown
The source is distribution-free and strong realizable, so low-noise
robustification gives the corresponding marginal-nonuniform weak agnostic
improper learner. The unresolved step is properization. A proof of the target
would need extra representation-level structure, such as polynomial
fixed-marginal proper trace representatives, approximate proper ERM, or a
projection from validated external predictors to concepts. These are not
implied by an arbitrary improper learner. Conversely, standard false-witness
templates remain near misses: PCP active slices use instance-dependent
marginals, clause/DNF and one-way coordinate constructions force only
strong-accuracy proper recovery, and shared-code/Hadamard repairs either
leave the finite-transcript atlas model or leak inverse-polynomial weak
handles. Thus the edge remains a genuine properization-open case.
```

### Final Missing Lemma

The exact lemma that would move the atlas is one of the following.

For a true result:

> Every efficiently distribution-free realizable improperly learnable
> represented binary class admits, for each fixed marginal $P$, a uniform
> polynomial-time fixed-$P$ weak proper selector or trace representative map.

For a false result:

> Under a standard assumption, there is an efficiently realizable improperly
> learnable class and a fixed finite-encoded marginal $P^\star$ for which
> finding any legal proper hypothesis with inverse-polynomial positive
> correlation against the target labels is hard.

Neither lemma is currently available from the checked atlas material or the
standard PCP, DNF, one-way, coding, boosting, and realizable-to-agnostic
toolkits.

final verdict: unresolved-open

final confidence: high that this should remain `open` in the current atlas;
medium-high that the right family is `properization-open`; medium that a
purpose-built oracle or new cross-instance agreement theorem could eventually
settle it as false.
