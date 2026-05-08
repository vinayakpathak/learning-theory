# Edge: efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- worker depth: 1 of 7
- date: 2026-05-07
- edge file: `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- source: `efficient-marginal-nonuniform-realizable-proper-pac`
- target: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- current atlas status: `open`
- verdict from this pass: unresolved
- confidence: medium-high that the edge should remain open for now

## Question

Does
[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]
imply
[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]?

The source gives one uniform proper learner $A$. For every instance marginal
$P$, there is a $P$-dependent polynomial sample/time bound such that, on labels
realizable by some $c\in\mathcal C$, $A$ outputs $h\in\mathcal C$ with
arbitrary requested accuracy.

The target asks for one uniform agnostic learner. For every joint distribution
$\mathcal D$ with marginal $P$, it must output $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s),
$$

where $\gamma_P(s)$ is inverse-polynomial under a marginal-dependent
polynomial. The algorithm is still uniform; the marginal dependence is only in
the analysis of the resource bound and weak gap.

## Files And Sources Checked

Local atlas files:

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/conjunction-agnostic-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/conjunctions.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `references.bib`

Previous exact-edge scratchpads:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- I found no exact scratchpad for this edge under `scratchpads/open-edge-resolution-2026-05-04`.

Primary sources checked:

- Benedek and Itai, "Learnability with respect to fixed distributions":
  https://doi.org/10.1016/0304-3975(91)90026-X. The abstract gives the
  fixed-distribution finite-cover characterization and explicitly separates
  sample complexity from computational feasibility.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability":
  https://openreview.net/forum?id=aoVCFtox89. The OpenReview page, last
  modified 2026-04-21, frames marginal-nonuniform learning as allowing rates
  to depend on the marginal while remaining uniform over concepts.
- Hopkins, Kane, Lovett, and Mahajan, "Realizable Learning Is All You Need":
  https://doi.org/10.46298/theoretics.24.2 and
  https://arxiv.org/abs/2111.04746. Their reduction covers distribution-family
  classification at the sample level, but the paper explicitly says the
  generic algorithm is computationally inefficient and that this is necessary
  unless `P = NP`.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case
  Lattice Problems": https://proceedings.mlr.press/v195/tiegel23a.html. The
  PMLR abstract separates the distribution-independent weak no-advantage
  theorem from the fixed-Gaussian strong excess-error theorem.
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by
  Halfspaces Is Hard": https://arxiv.org/abs/1012.0729 and
  https://doi.org/10.1137/120865094. The abstract gives NP-hard weak agnostic
  learning for constant-error monomial instances, but not the fixed-marginal,
  inverse-polynomial-low-OPT form needed here.
- Kothari and Livni, "Agnostic Learning by Refuting":
  https://arxiv.org/abs/1709.03871. Their refutation-complexity equivalence
  reinforces that efficient agnostic learning requires an additional
  computational refutation/weak-optimization object, not merely a clean
  realizable learner.
- Asilis, Devic, Dughmi, Sharan, and Teng, "Proper Learnability and the Role
  of Unlabeled Data": https://arxiv.org/abs/2502.10359. This is nearby
  information-theoretic distribution-fixed proper-learning work, but it gives
  the learner stronger access to the marginal and does not provide a uniform
  computational proper selector.

## Current Verdict

`unresolved`; keep this edge `open` with `evidence: unknown`.

The 2026-05-05 scratchpad's diagnosis remains right, and the primary-source
check sharpened it rather than resolving it. The low-noise part of the
improper robustification is valid and produces proper hypotheses because the
source learner is proper. The missing piece is the moderate/high-OPT regime:
the improper proof falls back to constants, while this target requires a legal
concept from $\mathcal C$ and constants need not belong to $\mathcal C$.

Under the current atlas convention, the source is also equivalent to ordinary
efficient realizable proper PAC learning: `full-support-marginal-uniformization`
turns the marginal-dependent worst-case transcript bound into one
distribution-free resource polynomial, and the reverse direction is a trivial
relaxation. Thus the extra marginal-nonuniformity in the source is not the
main obstruction. The edge is really asking whether efficient clean proper
learning gives an efficient fixed-marginal proper weak agnostic selector.

I do not see such a theorem. I also do not see an atlas-ready false witness:
known halfspace, monomial, PCP, clause, parity/code, and one-way-function
routes each miss one of the required quantifiers.

## Partial Positive Result: Low-Noise Proper Robustification

Fix a marginal $P$. Run the source learner $A$ at constant clean accuracy
$\varepsilon_0$, say $\varepsilon_0=1/16$, and constant confidence. Let
$m_P(s)$ be the resulting $P$-dependent polynomial upper bound on the number
of inspected examples and runtime. Choose

$$
\alpha_P(s)\le \min\{1/128,1/(128m_P(s))\}.
$$

Consider an agnostic distribution $\mathcal D$ with marginal $P$ and
$\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$. Choose
$c^\star\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(c^\star)\le \eta+o(\alpha_P(s)).
$$

Couple one noisy run of $A$ on $(X,Y)\sim\mathcal D$ to a clean realizable run
on $(X,c^\star(X))$ using the same $P$-distributed instance sequence and the
same internal randomness. The probability that any inspected label differs
from $c^\star(X)$ is at most

$$
m_P(s)(\eta+o(\alpha_P(s)))<1/128+o(1).
$$

On the no-corruption event, the noisy transcript is exactly a successful clean
transcript under the original marginal $P$. Therefore, with constant
probability, the run outputs a proper $h\in\mathcal C$ with

$$
\Pr_P[h(X)\ne c^\star(X)]\le \varepsilon_0.
$$

Then

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+
\Pr_P[h(X)\ne c^\star(X)]
\le
\eta+o(\alpha_P(s))+\varepsilon_0.
$$

For $\varepsilon_0<1/2-\alpha_P(s)$ this is stronger than the weak agnostic
target in the very-low-OPT regime. Polynomially many independent runs plus a
fresh validation sample find such a candidate with high probability.

The important point is that this coupling is marginal-preserving. It does not
condition on the event of a clean sample and then invoke the learner under a
new conditional marginal. All resource bounds remain attached to the original
$P$.

## Where The Positive Proof Stops

The complementary regime is

$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s).
$$

For the improper sibling edge, this is easy. Add the two constant classifiers.
One has error at most $1/2$, and therefore

$$
1/2\le \eta+1/2-\alpha_P(s).
$$

For this proper edge, constants may not be valid concepts. A clean proper
realizable learner gives a way to decode labels that are consistent with a
member of $\mathcal C$; it gives no generic way to do any of the following:

- output a proper concept with error at most $1/2$ for every conditional label
  rule under a fixed marginal;
- solve weak ERM or weak agnostic optimization over $\mathcal C$;
- enumerate a polynomial-size $P$-specific proper cover;
- project an external weak predictor back into $\mathcal C$;
- force useful behavior of $A$ on inconsistent transcripts.

Running $A$ on noisy samples is useful only while an entirely clean transcript
has inverse-polynomial probability. For moderate noise, for example
$\eta=0.1$, the clean-transcript event for a polynomial-size run can be
exponentially unlikely, while the target may still require a proper hypothesis
of error at most about $0.6$.

## Conditional Positive Lemmas

The edge would be true under any of the following extra assumptions.

1. If $\mathcal C$ contains both constant classifiers and they are efficiently
   usable, the high-OPT fallback in the improper proof is already proper.

2. More generally, if for every fixed marginal $P$ there is a
   $P$-polynomial-time proper neutralizer that outputs $h\in\mathcal C$ with
   $\operatorname{err}_{\mathcal D}(h)\le 1/2$ for every conditional label
   rule, then the low-noise branch plus this neutralizer proves the edge.

3. If there is an efficiently findable anchor $h_0\in\mathcal C$ and
   $\mathcal C$ is efficiently closed under complement, validation between
   $h_0$ and $\bar h_0$ gives such a neutralizer.

4. If for every fixed marginal $P$ there is a polynomial-time searchable
   proper trace cover or selector that finds some $h\in\mathcal C$ within
   $1/2-\rho_P(s)$ of a near-optimal $c^\star$ in $L_1(P)$, then the same
   split proof works after choosing the weak gap below $\rho_P(s)$.

None of these assumptions is implied by the source node as stated.

## Why The HKLM Reduction Does Not Settle This Efficient Edge

Hopkins, Kane, Lovett, and Mahajan give a very relevant sample-level theorem.
Their Algorithm 1 builds a nonuniform cover from a realizable learner and then
does finite-class agnostic learning over that cover. It applies to
distribution-family classification, which is close in spirit to fixed-marginal
or marginal-nonuniform learning.

This proves the right information-theoretic moral: once computation is ignored,
realizable learnability gives agnostic learnability, including proper output
when the finite-class learner ranges over proper candidates. This matches the
atlas `sample-complexity-equivalence` notes.

It does not prove the assigned edge. The paper explicitly flags Algorithm 1 as
computationally inefficient, and the cover-generation step is the obstruction:
the cover is generated by running the realizable learner across all hypotheses
or all labelings on an unlabeled sample. When the source learner uses
polynomially many unlabeled points, this is generally exponential in the
representation size. That exponential proper selector is exactly what the
target does not allow.

## Counterexample Search

### Halfspaces

Halfspaces satisfy the source by linear feasibility and VC generalization, and
Tiegel gives strong hardness evidence for agnostic halfspace learning under
worst-case lattice assumptions.

The available halfspace lower bounds do not refute this edge. Tiegel's
distribution-independent weak theorem varies the hard marginal and has a
best-halfspace error $\delta$ that is only subpolynomially small. A
marginal-nonuniform weak learner may choose a hidden gap
$\alpha_P(s)=s^{-K_P}$, and if $\delta>\alpha_P(s)$ the target does not force
any advantage over error $1/2$. Tiegel's fixed-standard-Gaussian theorem fixes
the marginal but proves strong $\operatorname{OPT}+\varepsilon$ hardness, not
a low-OPT weak no-advantage theorem. Also, standard halfspace classes contain
proper constants, so the conditional positive lemma applies to them.

### Monomials And Conjunctions

Conjunctions and monomials are efficiently realizably properly learnable.
Feldman, Guruswami, Raghavendra, and Wu prove NP-hardness of weak agnostic
learning of monomials even with halfspace outputs: for arbitrary constant
$\varepsilon>0$, a monomial can be correct on a $1-\varepsilon$ fraction while
finding a halfspace correct on $1/2+\varepsilon$ is hard.

This is still not an atlas-ready separation. The atlas target may choose an
inverse-polynomial weak gap much smaller than any fixed constant. To refute it
one needs hardness with $\operatorname{OPT}$ below the learner's hidden
inverse-polynomial gap under a fixed or marginal-nonuniform-compatible
marginal. The cited theorem, as recorded in the abstract and atlas notes, is a
distribution-free constant-gap hardness theorem, not that stronger
fixed-marginal low-OPT statement.

### PCP Active Slices

The PCP active-slice construction has the right weak proper flavor. A proper
hypothesis encodes a proof for an NP instance, and an active slice with
logarithmically many verifier random strings has polynomial size.

It misses this edge because the hard marginal is input-dependent. In a
marginal-nonuniform target, the polynomial and weak gap may depend on the
chosen marginal. A reduction that changes the marginal with the NP instance
does not automatically yield one polynomial-time algorithm for the language.
Packing all slices into one fixed marginal dilutes each slice's global mass,
and the weak additive tolerance can ignore low-mass gadgets.

### Clause-Satisfaction Fixed Marginals

The clause-satisfaction lookup witness is closer: it can use a fixed uniform
marginal over all clauses and encode the input formula in the conditional
labels. This supports strong proper lower bounds, because a highly accurate
proper learner would recover a satisfying assignment.

For the weak target, the formula-clause gap is too small relative to an
unknown inverse-polynomial weak tolerance. Fair-noise padding and non-formula
clauses keep the global correlation small. A weak learner is not forced to
recover the formula unless the hard part has enough global mass and every
wrong proper output is made useless.

### Parities, Codes, And One-Way Images

Parities under the uniform marginal show why generic cover or neutralizer
proofs are hard. Clean proper learning is easy by Gaussian elimination, but an
exponential family of parities has no polynomial-size proper cover at radius
$1/2-\rho$: distinct parities are exactly distance $1/2$ apart. Parities are
not a false witness because wrong parities have error $1/2$ on a noisy parity,
which already satisfies the weak target whenever the noise exceeds the hidden
gap.

One-way image-coordinate and dense-code variants try to repair this by forcing
any weakly correlated proper output to decode a hard witness. At one fixed
length, a Hadamard-style code has the right geometry: an improper learner can
recover the image, while a proper positively correlated output must recover a
preimage. Across all lengths under one finite-string marginal, the construction
faces a mass-dimension tradeoff. Separate length blocks dilute the hard mass;
shared high-mass coordinates create trace collisions or residual weak handles.
The 2026-05-07 scratchpad for the neighboring improper-source edge records a
finite-core version of this obstruction. It blocks the clean dense-code route
but does not prove a general separation.

## Correlation Form Of The Missing Selector

With labels and hypotheses in $\{\pm1\}$, the target inequality is equivalent
to

$$
\mathbf E[h(X)Y]
\ge
\sup_{c\in\mathcal C}\mathbf E[c(X)Y]+2\gamma_P(s)-1.
$$

When the best concept has correlation close to $1$, the low-noise coupling can
find a proper weakly correlated output. When the best correlation is moderate,
the right side may be near zero or negative. A legal neutralizer would be a
way to find some proper concept whose correlation is not too negative for
every label rule. Clean realizable learning does not imply such a barycentric
or validation-searchable neutralizer.

For a false witness, exact recovery hardness is therefore insufficient. One
must show that every efficiently findable proper hypothesis satisfying this
weak correlation threshold decodes a hard witness, or else that no such weak
proper handle is efficiently findable. Current PCP, monomial, halfspace,
clause, parity, and one-way templates do not establish that under one
fixed-marginal weak gap.

## Recommended Atlas Treatment

No atlas status change is justified.

Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
```

Suggested sharper summary if the edge is later refreshed:

```yaml
summary: "Open: marginal-preserving low-noise coupling gives proper weak agnostic candidates when OPT is below the source transcript scale, but the improper proof's high-OPT constant fallback need not be proper; known halfspace, monomial, PCP, clause, parity, and one-way-code hardness routes do not give a fixed-marginal inverse-polynomial weak proper separation."
```

## Obstacles

1. The low-noise coupling covers only
   $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$.

2. The high-OPT part of the improper proof uses constants; constants need not
   be legal concepts.

3. The sample-efficient realizable-to-agnostic reductions generate
   nonuniform covers by exponential search and are explicitly not
   computationally efficient in general.

4. Distribution-free weak agnostic hardness results usually vary the marginal
   or work at constant/subpolynomial OPT, while the atlas learner can choose a
   hidden inverse-polynomial fixed-marginal gap.

5. Fixed-marginal code and one-way attempts must eliminate every weak proper
   handle, not merely every near-exact proper recovery. Pure distance geometry
   runs into coding/mass-dimension barriers.

## Follow-Up Directions

1. Prove a reusable conditional theorem: realizable proper learning plus an
   efficient fixed-marginal proper neutralizer implies this edge.

2. Search specifically for fixed-marginal weak no-advantage hardness with
   $\operatorname{OPT}\le s^{-K}$ for arbitrary $K$, not merely constant or
   subpolynomial OPT.

3. Try to adapt monomial/FGRW-style hardness to an inverse-polynomial
   low-noise regime and check whether the reduction remains polynomial with
   the right marginal quantifiers.

4. Develop a wrong-output-usefulness gadget: every proper concept with
   inverse-polynomial positive correlation under one fixed marginal should
   decode the hard witness.

5. Formalize the black-box barrier suggested by HKLM: any generic conversion
   that only calls the clean learner on all possible traces becomes
   exponential unless a separate proper selector is available.

VERDICT: unresolved

## Depth 2 Branch A: Proper Neutralizer High-OPT Fallback

### Branch Question

Can the source alone supply the missing high-OPT proper fallback? More
precisely, does efficient marginal-nonuniform realizable proper learning imply
that, for each fixed marginal $P$, one can efficiently find a proper
$h\in\mathcal C$ with error at most $1/2$ against every conditional label
rule? If that exact statement is too strong, is there a weaker neutralizer
that still finishes the low-noise split?

### Strong Proper Neutralizer Is False

The exact neutralizer claim is false for a trivial information-theoretic
reason, independent of computation.

**Counterexample to the strong neutralizer claim.** Let
$\mathcal X=\{x_0\}$ and let $\mathcal C=\{h_0\}$, where
$h_0(x_0)=+1$. This class is efficiently realizably properly learnable under
every marginal: the learner always outputs $h_0$.

Take the fixed marginal $P(x_0)=1$ and the conditional label rule
$Y=-1$ surely. The only proper output is $h_0$, and it has error $1$.
Therefore no proper algorithm can guarantee error at most $1/2$ against every
conditional label rule.

This does **not** refute the atlas edge. For this same distribution,
$\operatorname{OPT}_{\mathcal C}=1$, so the weak agnostic target inequality

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+\frac12-\gamma_P(s)
$$

is vacuous. The failed neutralizer label rule is one where even the best
proper concept is anti-correlated with the labels. Weak agnostic learning does
not ask the learner to repair that.

Thus lack of constants is enough to kill the constants-style neutralizer, but
not enough by itself to give a false witness for the edge.

### Minimax Characterization Of Exact Neutralizers

Switch to $\{\pm1\}$ labels. For a conditional label rule, write

$$
\mu(x)=\mathbf E[Y\mid X=x]\in[-1,1].
$$

A proper hypothesis has error at most $1/2$ exactly when

$$
\mathbf E_P[h(X)\mu(X)]\ge 0.
$$

Therefore the existence of a proper neutralizer for every conditional rule is
the condition

$$
\forall \mu:\|\mu\|_\infty\le 1,\qquad
\sup_{h\in\mathcal C}\mathbf E_P[h\mu]\ge 0.
$$

By the separating-hyperplane theorem, this is equivalent to

$$
0\in \overline{\operatorname{conv}}_{L_1(P)}(\mathcal C).
$$

Indeed, if $0$ is in the closed convex hull, average a finite mixture of
proper concepts whose barycenter is arbitrarily close to $0$ in $L_1(P)$; for
every $\mu$, at least one member of the mixture has nonnegative correlation
up to the approximation error. Conversely, if $0$ is separated from the closed
convex hull, the separating functional can be represented by some bounded
$\mu$, and every proper concept has strictly negative correlation with that
label rule.

The approximate version is the useful one for this edge. If one can
efficiently produce a finite distribution over proper concepts with barycenter

$$
b(x)=\mathbf E_{h}[h(x)]
$$

satisfying $\mathbf E_P|b(X)|\le \rho$, then for every label rule $\mu$,
some proper concept in the support has correlation at least $-\rho$, hence
error at most $1/2+\rho/2$. Complements and the two constants are special
cases with $\rho=0$.

This characterization makes the obstruction precise: realizable proper
learning says that consistent labels can be decoded. It does not imply that
$0$ lies in the fixed-marginal convex hull of the class, and even when it
does, it does not imply an efficient way to find a polynomial-size nearly
balanced mixture.

### Conditional Fallback Theorem

The high-OPT split does go through under an approximate proper neutralizer.

Assume the source learner $A$ has, for the fixed marginal $P$, clean
constant-accuracy transcript bound $m_P(s)$. Also assume there is a uniform
candidate generator $N$ such that, for every marginal $P$, it runs in
$P$-dependent polynomial time and, with constant probability, outputs a
polynomial list $L\subseteq\mathcal C$ with the following property: for every
joint distribution with marginal $P$, some $h\in L$ has error at most
$1/2+\tau_P(s)$.

Choose

$$
\alpha_P(s)\le \min\{1/(128m_P(s)),1/64\}
$$

and choose the weak gap $\gamma_P(s)$ so that

$$
0<\gamma_P(s)\le \alpha_P(s)-\tau_P(s)
$$

with, say, $\tau_P(s)\le \alpha_P(s)/2$.

Run the low-noise procedure from the depth-1 scratchpad and also generate the
neutralizer list $L$. Validate all candidates on a fresh labeled sample and
output the empirically best proper candidate.

If $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, the
marginal-preserving coupling for $A$ gives, with constant probability, a
proper candidate of error at most

$$
\eta+\varepsilon_0
$$

for fixed $\varepsilon_0<1/2-\gamma_P(s)$.

If $\eta\ge \alpha_P(s)$, the neutralizer list contains $h$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\frac12+\tau_P(s)
\le
\eta+\frac12-\gamma_P(s).
$$

Standard validation boosts the success probability and selects a candidate
within the required additive slack. Thus realizable proper learning plus this
extra approximate neutralizer proves the edge.

This is only a conditional theorem. The neutralizer hypothesis is not a
consequence of the source node.

### Anchors, Complements, And Unlabeled Samples

An efficiently findable anchor $h_0\in\mathcal C$ plus an efficient complement
operation is enough: validate between $h_0$ and $-h_0$, and one of them has
error at most $1/2$. The two constant concepts are the same argument in its
simplest form. More generally, any efficiently findable balanced finite
mixture of legal concepts gives an approximate neutralizer through the convex
hull criterion above.

Unlabeled samples alone do not supply such an object. They can estimate the
geometry of $P$ on a finite trace, but they do not create legal hypotheses.
Calling the realizable learner on arbitrary or random labels only gives the
learner's behavior off its promised realizable domain; the source guarantee
places no useful correlation condition on those outputs.

The HKLM-style cover route explains the information-theoretic positive
picture but not an efficient fallback. On an unlabeled sample $S$, one can
try to run the realizable learner on all labelings or all realizable traces of
$S$ and then validate the resulting proper candidates. This can generate a
proper agnostic cover, but the enumeration is generally exponential in the
source transcript size or in the VC trace dimension. The missing object is an
efficient selector for the few traces that matter; the source learner itself
does not provide that selector.

### Why Missing Constants Does Not Yet Give A Separation

The singleton example and classes with a shared high-mass sign pattern show
that constants or complements cannot be assumed. But the adversarial label
rules witnessing failure of a $1/2$ neutralizer often make
$\operatorname{OPT}_{\mathcal C}\ge 1/2$, sometimes even
$\operatorname{OPT}_{\mathcal C}=1$. In that regime the weak agnostic bound is
nearly vacuous, so the absence of constants has not forced a learner to solve
a hard weak-optimization problem.

To turn lack of constants into an atlas-ready counterexample, one would need a
fixed marginal and a family of conditional label rules with

$$
\alpha_P(s)\lesssim \operatorname{OPT}_{\mathcal C}<1/2
$$

for the target's hidden inverse-polynomial scale, while every efficiently
findable proper hypothesis below the allowed error threshold decodes a hard
witness. This is the same wrong-output-usefulness requirement identified in
the depth-1 search. Existing singleton, anchor-biased, parity, code, PCP, and
one-way templates do not give it in the current finite-string
marginal-nonuniform model.

### Obstruction Isolated

The branch resolves one subclaim but not the edge:

1. Strong fixed-marginal proper neutralizers with error at most $1/2$ do not
   follow from efficient realizable proper learning.

2. A sufficient high-OPT fallback is exactly an efficiently findable
   approximate zero in the fixed-marginal convex hull of proper concepts, or a
   validation-searchable list with error at most $1/2+\tau_P(s)$ for every
   conditional rule.

3. The source learner gives neither convex-hull balance nor an efficient
   HKLM-style trace selector.

4. The failure of such a neutralizer is not by itself a counterexample to weak
   agnostic learning, because weak agnostic guarantees are relative to
   $\operatorname{OPT}_{\mathcal C}$.

Next directions:

1. Search for a fixed-marginal weak no-advantage construction where
   $\operatorname{OPT}_{\mathcal C}$ is inverse-polynomially small but above
   the low-noise transcript scale, and every weakly legal proper output
   encodes a hard witness.

2. Try to prove efficient approximate convex-hull balance from stronger
   structural assumptions: complement closure, known balanced anchors,
   polynomial-size trace classes under $P$, finite effective support plus a
   proper consistency oracle, or explicit proper ERM over a generated cover.

3. Formalize a black-box barrier: an oracle that only promises correct
   behavior of $A$ on realizable labels appears unable to distinguish a class
   with a balanced proper fallback from a singleton-like class with no
   neutralizer.

VERDICT: unresolved, scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

## Depth 3 Branch A: Low-OPT Weak No-Advantage Hardness

### Branch Target

This branch looked for a conditional counterexample of the following shape.
Find a class $\mathcal C$ that is efficiently realizably properly learnable,
but for one fixed marginal $P$ has agnostic proper weak no-advantage hardness
even when

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)
$$

is inverse-polynomially small, small enough that the hidden
marginal-dependent weak gap $\gamma_P(s)$ cannot hide behind the additive
$\operatorname{OPT}$ term.

The attempted false-witness theorem would need to say more than ordinary
agnostic hardness. It would need, for an alleged target learner with gap
$\gamma_P(s)\ge s^{-k_P}$, a fixed-marginal label distribution with
$\operatorname{OPT}_{\mathcal C}\ll \gamma_P(s)$, while no efficient proper
algorithm can output a concept with error below $1/2-\Omega(\gamma_P(s))$ or
even below the target threshold.

I did not find such a theorem or construction.

### Quantifier Calibration

The low-noise coupling from the depth-1 scratchpad creates a hard barrier
against exactly-too-low OPT no-advantage hardness.

Fix the source realizable proper learner $A$ and a marginal $P$. Let $m_P(s)$
be a $P$-dependent polynomial upper bound on the number of labels inspected by
$A$ when run at constant clean accuracy. If

$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
\ll 1/m_P(s),
$$

then running $A$ directly on the noisy agnostic sample has a constant
probability of seeing an entirely clean transcript relative to a near-optimal
$c^\star\in\mathcal C$. Repetition and validation then produce a proper
hypothesis with constant advantage over random guessing. Therefore a source
positive class cannot also have fixed-marginal no-advantage hardness at every
inverse-polynomial low-noise scale below the clean transcript threshold.

This matters for a separation. The target learner is allowed to choose its
hidden weak gap $\gamma_P(s)$ as a very small inverse polynomial. A no-advantage
hardness result with $\operatorname{OPT}<\gamma_P(s)$ would refute that learner
only if it applies below the learner's chosen gap. But if the putative hard OPT
is below $1/m_P(s)$, the source learner itself defeats the no-advantage claim.
If the hard OPT is above $1/m_P(s)$, a target proof can choose
$\gamma_P(s)\le 1/\operatorname{poly}(m_P(s))$ so that the hard distribution is
not in the advantage-forcing low-OPT regime.

Thus the desired lower bound must thread a very narrow needle: it must be
fixed-marginal and proper, force a weak advantage, avoid the transcript-scale
low-noise algorithm, and still beat an unknown marginal-dependent inverse
polynomial weak gap. The checked routes miss at least one of these requirements.

### Halfspaces And Tiegel

Halfspaces remain the strongest known agnostic-hardness family near this edge,
but they do not give the requested low-OPT fixed-marginal weak separation.

[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html) proves two
different kinds of hardness under worst-case lattice assumptions. The
distribution-independent theorem is a genuine weak no-advantage theorem, even
against arbitrary binary outputs, but the hard marginal varies with the
instance and the optimum error parameter $\delta$ is subpolynomially small,
not inverse-polynomially small enough to beat an arbitrary hidden
$s^{-k_P}$ gap. The fixed-standard-Gaussian theorem fixes the marginal, but it
is a strong excess-error lower bound of the form
$\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$, not a theorem saying that no
efficient learner can beat $1/2$ at inverse-polynomially small OPT.

The newer fixed-Gaussian LWE-based hardness of
[Diakonikolas, Kane, and Ren 2023](https://proceedings.mlr.press/v202/diakonikolas23b.html)
has the same mismatch for this branch. It is a near-optimal lower bound for
learning to $\operatorname{OPT}+\varepsilon$ under the standard Gaussian
marginal. It does not rule out a weak learner whose permitted error is close
to $1/2$, and standard halfspace classes have proper constant halfspaces,
which already give the high-OPT fallback used in the positive split.

Older weak proper halfspace hardness, such as
[Guruswami and Raghavendra 2009](https://doi.org/10.1137/070685798), is also a
near miss: it rules out $1/2+\delta$ agreement when a halfspace explains a
$1-\varepsilon$ fraction of examples, but the stated parameters are arbitrary
constants and the learning distribution is not one fixed marginal shared by
all reduction instances.

Conclusion for halfspaces: strong fixed-marginal hardness exists, and weak
distribution-free no-advantage hardness exists, but the same theorem does not
give fixed-marginal inverse-polynomial-low-OPT weak no-advantage hardness.

### Monomial, FGRW, And Conjunction Routes

Monomials and conjunctions satisfy the realizable proper source by the standard
consistent-conjunction algorithm. They are natural because
[Feldman, Guruswami, Raghavendra, and Wu 2012](https://doi.org/10.1137/120865094)
prove NP-hardness of weak agnostic learning of monomials even with halfspace
outputs: for every fixed constant $\epsilon>0$, the hard instance has a
monomial correct on a $1-\epsilon$ fraction, but no efficient algorithm can
find a halfspace correct on a $1/2+\epsilon$ fraction.

This does not instantiate the branch target.

First, the result is distribution-free: the reduction constructs a hard
distribution from the Label-Cover instance. In a marginal-nonuniform target,
if the marginal changes with the instance, the runtime and weak gap may also
depend on that marginal, so the reduction no longer yields a uniform language
decision algorithm.

Second, the theorem is stated for constant $\epsilon$. To beat a hidden
$s^{-k_P}$ weak gap, one would need a sliding-scale version with
$\epsilon\le s^{-K}$ for arbitrary $K$ while keeping the reduction polynomial
and the hard marginal fixed. The published statement and abstracted atlas
notes do not provide that parameter regime.

Third, if one tries to lower $\epsilon$ by PCP or Label-Cover repetition, the
same two obstructions reappear: the marginal still carries instance identity,
and the soundness/list-decoding parameters must be rechecked at the
inverse-polynomial scale. The FGRW proof is built around dictatorship-test and
Label-Cover structure; it does not provide an identity-protected fixed
marginal under which every weakly correlated proper monomial decodes the
target instance.

Conjunction hardness therefore remains evidence that clean realizable learning
does not automatically give efficient agnostic optimization, but not an
atlas-ready low-OPT fixed-marginal counterexample.

### DNF And Fixed-Term DNF

The DNF route also misses quantitatively.

[Khot and Saket 2008](https://cs.nyu.edu/~khot/papers/minDNF.pdf) prove, under
$\mathrm{NP}\nsubseteq\mathrm{RP}$, that for every fixed $t$ and constant
$\epsilon>0$, two-term DNF cannot be learned by $t$-term DNF to accuracy
$1/2+\epsilon$. This is the right "proper weak hardness" flavor, but it is not
the right marginal or parameter statement.

The previous depth-3 scratchpad for a neighboring properization edge unpacked
the proof parameters: the extracted Label-Cover value in the Khot-Saket
Appendix A analysis shrinks polynomially in the desired advantage
$\epsilon$, roughly like $\epsilon^4/(t^4\log(t/\epsilon))$ up to constants.
Setting $\epsilon=1/\operatorname{poly}(n)$ would require a separate
inverse-polynomial-soundness Label-Cover analysis while preserving the rest of
the reduction. The paper's theorem keeps these quantities constant.

There is also a positive warning sign. Schapire's weak-learning construction
for fixed-$k$ DNF gives inverse-polynomial proper weak advantage using simple
proper hypotheses such as constants or small literal combinations. Thus
fixed-$k$ DNF cannot be a no-inverse-polynomial-advantage witness in the form
this edge needs. At most, Khot-Saket rules out constant advantage for fixed
output size.

For unrestricted or growing DNF, the source side becomes the problem:
efficient realizable proper PAC learning is not available in the distribution-
free model. For fixed-term DNF, the target-side inverse-polynomial weak
hardness is not available.

### Label-Cover And PCP Packing

PCP and Label-Cover constructions can produce hard proper-search structure,
but the fixed-marginal weak quantifier breaks the standard active-slice trick.

[Hastad and Khot 2005](https://theoryofcomputing.org/articles/v001a007/) give
query-efficient PCPs with perfect completeness and very small constant
soundness by choosing the query parameter. Low-error PCP work such as
[Dinur, Harsha, and Kindler 2015](https://arxiv.org/abs/1505.06362) pushes
soundness to $1/\operatorname{poly}(n)$ with polyloglog queries and larger
alphabets. These are strong PCP ingredients, but not by themselves fixed-
marginal weak no-advantage lower bounds.

The active-slice construction protects identity by placing the instance name
in the example domain. A proper hypothesis encodes a proof for the same
instance, and a weakly good proper output can be decoded. But then the marginal
is $P_\varphi$, uniform or nearly uniform on the slice for the input
$\varphi$. Marginal-nonuniform learning allows the polynomial and weak gap to
depend on $P_\varphi$, so this does not refute the atlas target.

Packing all instance slices into one $P^\star$ dilutes the global signal. If a
slice has mass $w_\varphi$, then both the local advantage and the local OPT
contribution are multiplied by $w_\varphi$. For infinitely many input lengths
or instances, most slices must have mass below any fixed inverse-polynomial
scale, and the target's hidden weak gap can ignore them. Giving every possible
hard slice high mass is impossible under a single probability distribution.

Shared-randomness PCP variants fix the marginal by using the same random-string
space for all instances, but then identity protection is lost. A proof for a
different satisfiable instance can become a legal weak handle unless one adds
a new cross-instance agreement theorem: every proper hypothesis with
inverse-polynomial correlation against the labels for $\varphi$ must decode a
witness for $\varphi$ itself. Standard Label-Cover soundness is an
own-instance statement, not this cross-instance identity statement.

### Planted-Noise, Parity, And LPN-Style Routes

Planted-noise ideas give the right fixed-marginal intuition but run into the
low-noise transcript barrier.

Parity under the uniform marginal is the cleanest test case. The class of
parities is efficiently realizably properly learnable by Gaussian elimination.
With noisy parity labels, the best parity has error equal to the noise rate
$\eta$, and wrong parities have error exactly $1/2$ under the uniform marginal.

If $\eta$ is below the clean transcript scale, repeated clean-transcript
Gaussian elimination gives a proper weak learner. If $\eta$ is at the usual
LPN-hard scale, for example constant noise or common low-noise regimes above
about $1/n$, then a marginal-nonuniform weak target may choose a much smaller
gap $\gamma_P(s)$; since $\eta\ge \gamma_P(s)$, an arbitrary wrong parity of
error $1/2$ already satisfies

$$
1/2\le \eta+1/2-\gamma_P(s).
$$

Thus LPN-style planted noise has either too little noise to be hard for a
source-positive class or too much noise to force the weak target to beat
random guessing.

The same scaling problem appears in planted hard-slice mixtures. If the hard
component has mass $\mu$, the global OPT and the global weak signal both scale
with $\mu$. Making OPT tiny enough to beat an unknown $\gamma_P$ also tends to
make the useful signal ignorable; making the signal visible puts OPT above the
gap, where no-advantage hardness no longer refutes the weak target.

### What Would Actually Resolve This Branch

A conditional false result would require a new primitive, stronger than the
standard hardness theorems checked above.

For one fixed marginal $P$ and a source-positive class $\mathcal C$, one would
need a polynomial-time samplable family of label rules
$\mathcal D_{n,K}$ such that:

1. $\mathcal C$ has a uniform efficient realizable proper learner.
2. $\operatorname{OPT}_{\mathcal C}(\mathcal D_{n,K})$ can be placed in the
   hard window needed to defeat an alleged target gap, without falling below
   the clean-learner transcript threshold.
3. Any proper $h\in\mathcal C$ with the inverse-polynomial correlation needed
   by the weak target decodes a hard witness for the instance.
4. The marginal $P$ is the same across instances and amplification levels, so
   the target cannot hide in a marginal-dependent runtime or gap.
5. Wrong-instance, constant, parity-like, random-code, or finite-trace handles
   are all ruled out computationally, not merely geometrically.

No checked monomial/FGRW, halfspace/Tiegel, conjunction, DNF, Label-Cover, or
planted-noise route supplies this primitive. The current literature gives
many pairs of the needed properties, but not all of them at once:

- fixed marginal plus strong excess-error hardness, but not weak no-advantage;
- weak no-advantage plus low OPT, but with instance-dependent marginals or
  subpolynomial/constant OPT scales;
- inverse-polynomial PCP soundness, but not identity-protected fixed-marginal
  weak proper decoding;
- fixed uniform marginal planted-noise hardness, but with either clean-sample
  learnability at very low noise or a wrong-proper-hypothesis error of exactly
  $1/2$ when the noise is above the hidden weak gap.

### Branch Conclusion

No conditional counterexample was found. The strongest conclusion from this
branch is negative diagnostic: current hardness results miss the exact
inverse-polynomial low-OPT fixed-marginal target because the atlas weak gap is
hidden and marginal-dependent, while the source learner itself neutralizes
sufficiently tiny OPT by clean-transcript coupling.

The edge should remain open. A future false proof should probably not aim for
"arbitrarily tiny OPT no advantage" in isolation; that collides with the
source learner. It must instead build a fixed-marginal wrong-output-usefulness
gadget in the middle window where OPT is above the source transcript scale but
the weak guarantee still forces a proper concept whose existence or discovery
decodes the hard witness.

VERDICT: unresolved, scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

## Depth 4 Branch A: Black-Box Clean-To-Agnostic Proper Barrier

### Branch Question

Can a generic conversion from an efficient clean realizable proper learner to
an efficient weak agnostic proper learner be justified using only black-box
access to the clean learner? Or must such a conversion either enumerate an
exponential HKLM-style trace/cover family, or use extra representation
structure such as constants, complements, neutralizers, anchors, proper ERM, or
a searchable fixed-marginal cover?

The answer from this branch is a model-level barrier, not an atlas
counterexample. A restricted black-box separation can be stated for
candidate-generation conversions that obtain proper hypotheses only by calling
the clean learner on selected labeled transcripts. The separation does not
rule out non-black-box learners that use the actual representation of
$\mathcal C$.

### Restricted Black-Box Model

Fix a marginal $P$ and a clean learner $A$. A trace-black-box conversion $B$
has sample access to the agnostic distribution $\mathcal D$ with marginal $P$.
It may draw labeled and unlabeled examples, choose labeled transcripts
$(U,z)$, run $A$ on those transcripts with chosen random seeds, validate the
returned proper hypotheses on fresh labeled examples, and output one of the
proper hypotheses it has obtained from $A$.

This model intentionally excludes representation-level operations. In
particular, $B$ cannot enumerate concept descriptions, complement a returned
concept, sample a random proper concept, solve a proper ERM problem, or use a
known constant/anchor unless such an object is explicitly supplied as an extra
candidate source. Those excluded operations are exactly the additional
structure that the previous branches identified as sufficient high-OPT
fallbacks.

A conversion in this model is "generic" in the sense that the only source of
legal proper candidates is the clean learner's transcript map. The source
guarantee constrains that transcript map only on realizable clean labels. Its
behavior on inconsistent or noisy transcripts is completely off-promise.

### Oracle Separation For Transcript Mining

There is a simple oracle lower bound for this restricted model.

Let a clean call to $A$ in the constant-accuracy mode used by the low-noise
argument request a prescribed batch of $m=m_P(s)$ fresh examples. Consider an
opaque two-concept class

$$
\mathcal C_s=\{c_+,c_-\}
$$

under a fixed marginal $P$ such that $c_-=-c_+$ on the high-probability part
of the domain. The concepts are represented by opaque names; the only way for
the black-box conversion to obtain the name of $c_+$ is for $A$ to return it.
Define $A$ so that its PAC run consumes the whole $m$-example batch. On the
ordinary clean $P^m$ transcripts labeled by $c_+$ it returns $c_+$, and on
the ordinary clean $P^m$ transcripts labeled by $c_-$ it returns $c_-$. On
all inconsistent, noisy, or hand-crafted transcripts outside this promised
clean PAC mode, it returns $c_-$. This is a valid clean realizable proper
learner in the oracle model: PAC correctness is distributional over clean
i.i.d. transcripts, and its promised behavior is perfect on both concepts.

Now take the agnostic distribution $\mathcal D$ whose labels are $c_+(X)$
flipped independently with noise rate

$$
\eta=1/4.
$$

Then $\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta$, attained by $c_+$,
while

$$
\operatorname{err}_{\mathcal D}(c_-)=1-\eta=3/4.
$$

For any inverse-polynomial weak gap $\gamma_P(s)>0$, the target threshold is

$$
\eta+\frac12-\gamma_P(s)=\frac34-\gamma_P(s),
$$

so $c_-$ is just outside the required weak agnostic guarantee. In this oracle
world, the conversion must obtain $c_+$.

But a noisy $m$-batch equals a promised clean $c_+$ batch only when no
inspected label is flipped, an event of probability $(3/4)^m$. Calls on
shorter, repeated, or otherwise artificial transcripts are not useful in this
oracle construction: they are outside the clean PAC success event and return
the bad opaque concept. More generally, if $B$ observes a noisy $m$-batch and
tries to repair it by querying corrected label strings, it must hit the exact
clean string. Without additional structure, this is the usual
corruption-pattern search: a polynomial number of queried strings misses with
high probability, while the HKLM-style remedy is to enumerate exponentially
many strings or traces. For constant noise, covering the typical Hamming ball
costs roughly $2^{H(\eta)m}$ possible corrections; enumerating all labelings
costs $2^m$.

Equivalently, the off-promise behavior of $A$ can hide the only useful proper
candidate behind one clean transcript among exponentially many noisy or
inconsistent transcripts. Any proof that treats $A$ as the sole candidate
oracle and makes only $\operatorname{poly}(s)$ transcript queries can be made
to see only the bad proper hypothesis $c_-$, even though the same $A$ remains
a perfect clean realizable proper learner.

This can be made less degenerate by replacing the two opaque concepts with a
hidden codebook. Clean codewords are realizable traces; all non-codeword
transcripts return a designated bad codeword. A black-box conversion must hit
a valid clean codeword or a fixed-marginal neutralizer. A full HKLM cover
enumerates enough traces to hit one, but a polynomial trace miner has no
reason to find it. The two-concept version is enough to isolate the logical
point: the realizable guarantee says nothing about noisy transcripts.

### Why This Is Not An Atlas Separation

The separation is deliberately black-box. It does not prove that the atlas
edge is false.

First, an actual target learner for $\mathcal C$ is not required to use a
particular clean learner $A$. If the representation exposes the two concept
names, a random proper concept, a complement operation, or any anchor whose
opposite can be validated, the toy oracle breaks. For example, if a learner
can obtain both $h$ and $-h$, validation gives an error-at-most-$1/2$
neutralizer and the previous conditional theorem proves the edge.

Second, many natural classes have non-black-box selectors. Parities under the
uniform marginal have exponentially large proper covers at radius
$1/2-\rho$, so they refute the naive small-cover lemma. Nevertheless Gaussian
elimination and Fourier structure give efficient clean and noisy correlation
procedures in regimes where a purely transcript-based method would look
hopeless.

Third, the weak agnostic target is forgiving in the middle-noise regime. If a
generic method can produce almost any proper concept that is not strongly
anti-correlated with the near-optimal concept, validation may already certify
it. This is why constants, complements, balanced mixtures, random proper
anchors, and approximate convex-hull neutralizers are powerful. A false
witness must remove or computationally hide all such weak handles, not merely
make exact recovery hard.

Thus the black-box oracle statement is best read as a barrier to a proof
strategy:

1. Low-noise coupling uses only the promised clean behavior of $A$ and is
   valid.
2. Middle-noise weak agnostic learning needs either a proper neutralizer or a
   weak selector.
3. The clean learner's transcript map supplies such a selector only after
   exponential HKLM-style enumeration, unless additional representation
   structure is available.
4. Since the source node does not include that structure, a generic
   black-box conversion cannot be inferred from the definition alone.

### Consequence For The Depth-7 Search

This branch supports keeping the atlas edge open after depth 7 unless a later
branch finds one of two stronger objects.

The positive object would be a non-black-box theorem: efficient realizable
proper learning, perhaps together with some implicit property already forced
by marginal-nonuniform learnability, yields an efficient fixed-marginal
proper neutralizer or weak selector. The black-box separation says such a
theorem cannot simply mine the clean learner's off-realizable transcripts.

The negative object would be a real class-level witness: a representation in
which clean proper learning is easy, but every efficient proper weak agnostic
learner under one fixed marginal would decode a hard witness. The oracle
construction above does not give this, because it hides the representation
itself rather than proving hardness for a standard explicit class.

So the precise barrier is:

> Any generic clean-to-agnostic proper conversion whose legal candidates come
> only from black-box calls to the clean realizable learner must either query
> exponentially many clean/noisy trace corrections, as in HKLM-style cover
> generation, or be supplemented by extra structure that produces a
> fixed-marginal proper neutralizer/selector. The source node by itself
> supplies neither.

This is a useful warning and a reason not to mark the edge true by a generic
conversion argument. It is not enough to mark the edge false.

VERDICT: unresolved, scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

## Depth 5 Branch A: Structural Conditions For Proper Weak Agnostic Conversion

### Branch Question

This branch tries to make the missing structure exact. The previous branches
showed two things:

1. Low-noise agnostic distributions are handled by the clean proper learner
   through the marginal-preserving coupling.
2. The remaining middle/high-noise regime needs a legal proper fallback:
   constants, complement anchors, an approximate neutralizer, a proper
   weak selector, or a searchable fixed-marginal cover.

The goal here is to separate exact necessary/sufficient conditions from
merely convenient sufficient ones, and to decide whether the atlas edge can be
closed conditionally.

### Correlation Form Of The Target

Use $\{\pm 1\}$ labels. Fix a size parameter $s$, a marginal $P$, and write

$$
\mu(x)=\mathbf E[Y\mid X=x]\in[-1,1].
$$

For $h\in\mathcal C_s$, set

$$
\langle h,\mu\rangle_P=\mathbf E_P[h(X)\mu(X)]
$$

and

$$
M_{\mathcal C}(\mu)=\sup_{c\in\mathcal C_s}\langle c,\mu\rangle_P.
$$

Then

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)
=\frac12\left(1-M_{\mathcal C}(\mu)\right).
$$

A weak agnostic proper guarantee with gap $\gamma_P(s)$, i.e.

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s),
$$

is exactly

$$
\langle h,\mu\rangle_P
\ge
M_{\mathcal C}(\mu)+2\gamma_P(s)-1.
$$

This is a very weak additive approximation to the best correlation. It only
becomes demanding when the best proper concept has correlation close to $1$.

Let $A$ be the clean source learner. For fixed $P$, let $m_P(s)$ be the
constant-accuracy transcript/time bound used in the low-noise coupling. Choose

$$
\alpha_P(s)\le \min\{1/(128m_P(s)),1/64\}.
$$

The low-noise branch handles

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s),
$$

equivalently

$$
M_{\mathcal C}(\mu)>1-2\alpha_P(s).
$$

So the only missing case is the residual region

$$
M_{\mathcal C}(\mu)\le 1-2\alpha_P(s).
$$

In that region the weak target threshold satisfies

$$
M_{\mathcal C}(\mu)+2\gamma_P(s)-1
\le
-2(\alpha_P(s)-\gamma_P(s)).
$$

Thus, once $\gamma_P(s)<\alpha_P(s)$, the middle-regime fallback does not need
to find a concept correlated with the labels. It only needs to find a proper
concept that is not too anti-correlated.

### Exact Residual Selector Condition

For fixed $P$, call an algorithm $S$ an $(\alpha,\gamma)$ residual proper
selector if, for every conditional label rule $\mu$ with

$$
M_{\mathcal C}(\mu)\le 1-2\alpha(s),
$$

the algorithm runs in $P$-dependent polynomial time using samples from
$\mathcal D$ and, with constant probability, outputs a polynomial list
$L\subseteq\mathcal C_s$ such that

$$
\max_{h\in L}\langle h,\mu\rangle_P
\ge
M_{\mathcal C}(\mu)+2\gamma(s)-1.
$$

This is the exact missing object for the clean-to-weak-agnostic split.

**Sufficiency.** Run the clean low-noise wrapper and the residual selector in
parallel, validate all returned proper candidates on fresh labeled data, and
output the empirical best. If $M_{\mathcal C}(\mu)>1-2\alpha$, the low-noise
wrapper supplies a proper candidate satisfying the weak target. If
$M_{\mathcal C}(\mu)\le 1-2\alpha$, the residual selector supplies one.
Validation costs polynomially many samples because the desired slack
$\gamma(s)$ is inverse-polynomial.

**Necessity for this proof architecture.** Any conversion that uses the
low-noise wrapper for the near-realizable branch and validation over a
polynomial candidate list must have such a residual list in the complementary
region. Otherwise there is no candidate for validation to select. This is not
a lower bound against every conceivable non-black-box target learner; it is a
precise statement of what the split proof needs.

This condition is close to tautological, but useful: it says the missing
structure is not "a constant classifier" specifically. It is a residual weak
proper selector at correlation threshold
$M_{\mathcal C}(\mu)+2\gamma-1$.

### Approximate Neutralizers As A Clean Sufficient Condition

A stronger, label-independent sufficient condition is an approximate proper
neutralizer.

For fixed $P$, suppose a uniform generator $N$ runs in $P$-dependent
polynomial time and outputs a weighted polynomial list

$$
L=\{(w_i,h_i)\}_{i=1}^k,\qquad h_i\in\mathcal C_s,
$$

with $\sum_i w_i=1$, $w_i\ge 0$, and barycenter

$$
b(x)=\sum_i w_i h_i(x)
$$

satisfying

$$
\mathbf E_P|b(X)|\le \rho_P(s).
$$

Then for every label rule $\mu$,

$$
\sum_i w_i\langle h_i,\mu\rangle_P
=
\langle b,\mu\rangle_P
\ge
-\rho_P(s),
$$

so some $h_i$ has correlation at least $-\rho_P(s)$, hence error at most
$1/2+\rho_P(s)/2$.

In the residual region $M_{\mathcal C}(\mu)\le 1-2\alpha_P(s)$, this
neutralizer is enough whenever

$$
\rho_P(s)\le 2(\alpha_P(s)-\gamma_P(s)).
$$

Indeed,

$$
-\rho_P(s)
\ge
-2(\alpha_P(s)-\gamma_P(s))
\ge
M_{\mathcal C}(\mu)+2\gamma_P(s)-1.
$$

Thus:

> Efficient marginal-nonuniform realizable proper learning plus an efficient
> fixed-marginal approximate proper neutralizer with
> $\rho_P(s)\le 2(\alpha_P(s)-\gamma_P(s))$ implies efficient
> marginal-nonuniform weak agnostic proper learning.

This is a genuine conditional positive theorem. It is also the right
formalization of the constants/complements intuition.

### Constants, Complements, Anchors, And Approximate Anchors

The following are all special cases of the neutralizer criterion.

1. **Two proper constants.** If both constant classifiers are in
   $\mathcal C_s$ and are efficiently available, their average is exactly
   zero pointwise. Hence $\rho_P=0$ for every marginal.

2. **Known complement anchor.** If one can efficiently find some
   $h_0\in\mathcal C_s$ and also efficiently output its pointwise complement
   $-h_0\in\mathcal C_s$, then the list $\{h_0,-h_0\}$ has barycenter zero.
   Validation chooses the better of the two.

3. **Approximate complement pair.** If one can efficiently output
   $h,h'\in\mathcal C_s$ with
   $$
   \mathbf E_P|h(X)+h'(X)|\le 2\rho_P(s),
   $$
   then the two-point uniform mixture has
   $\mathbf E_P|b(X)|\le \rho_P(s)$.

4. **Balanced proper ensemble.** More generally, any efficiently generated
   finite ensemble of proper concepts whose average prediction is
   $L_1(P)$-close to zero is a neutralizer. The ensemble need not approximate
   every concept in $\mathcal C_s$; it only has to avoid systematic
   anti-correlation with every possible label rule.

These assumptions are not consequences of clean realizable proper learning.
The singleton class from the depth-2 branch has an efficient clean proper
learner but has no nontrivial neutralizer under the point mass marginal.

The singleton also shows why neutralizers are not necessary for the weak
agnostic target itself: if $\mathcal C_s=\{h_0\}$, the trivial learner always
outputs the best and only proper hypothesis, so the agnostic proper guarantee
is immediate even though no $1/2$ neutralizer exists for the opposite label
rule. Therefore the exact condition cannot be "there exists a neutralizer";
the exact condition is the residual selector above. Neutralizers are a broad,
usable sufficient family.

### Fixed-Marginal Proper Covers

There are two cover notions worth separating.

**Strong proper $L_1(P)$ cover.** Suppose one can generate a polynomial list
$K\subseteq\mathcal C_s$ such that for every $c\in\mathcal C_s$ there is
$k\in K$ with

$$
\Pr_P[k(X)\ne c(X)]\le r_P(s).
$$

Then for every agnostic label rule, choosing a near-optimal
$c^\star\in\mathcal C_s$ and its cover representative $k$ gives

$$
\operatorname{err}_{\mathcal D}(k)
\le
\operatorname{err}_{\mathcal D}(c^\star)+r_P(s).
$$

If $r_P(s)\le 1/2-\gamma_P(s)$, validation over $K$ directly gives the weak
agnostic proper target. This is stronger than needed and may be exponentially
large for natural classes, but it is a clean sufficient condition.

**Weak residual proper cover.** The exact middle-regime cover is the dual
condition

$$
\forall \mu\text{ with }M_{\mathcal C}(\mu)\le 1-2\alpha,\qquad
\max_{h\in K}\langle h,\mu\rangle_P
\ge
M_{\mathcal C}(\mu)+2\gamma-1.
$$

This is precisely a label-independent version of the residual selector. It
can be much weaker than an $L_1(P)$ cover of the whole class. An approximate
neutralizer with radius $\rho\le 2(\alpha-\gamma)$ is one way to build such a
weak residual cover, because it lower-bounds the left side by $-\rho$
uniformly over $\mu$.

The HKLM/Benedek-Itai finite-cover picture explains why such covers exist
information-theoretically after ignoring computation, but the known
construction enumerates traces or labelings and is generally exponential.
The current source node gives an efficient decoder for clean labels; it does
not give an efficient generator for a strong cover, a weak residual cover, or
the neutralizer subcase.

### What Is Necessary, What Is Sufficient

The structural landscape after this branch is:

1. **Exact for the split proof:** low-noise clean coupling plus an efficient
   residual proper selector is necessary and sufficient.

2. **Easy sufficient condition:** an efficient fixed-marginal approximate
   neutralizer with radius below the low-noise cutoff gives the residual
   selector.

3. **Common sufficient subcases:** two constants, a known complement anchor,
   approximate complement pairs, and balanced proper ensembles are all
   neutralizers.

4. **Stronger sufficient condition:** an efficient fixed-marginal proper
   $L_1(P)$ cover of radius at most $1/2-\gamma_P(s)$ gives the whole weak
   agnostic target by validation/ERM over the cover.

5. **Not necessary:** neutralizers and small $L_1(P)$ covers are not required
   for weak agnostic proper learning. A class may have a direct optimizer or
   may be trivial, even with no label-independent neutralizer.

6. **Not implied by the source:** clean realizable proper learning supplies
   none of the residual selector, neutralizer, complement, anchor, or
   efficient cover objects. Depth 4 explains why black-box transcript mining
   cannot manufacture them without exponential enumeration.

### Consequence For The Atlas Edge

This branch supports a conditional resolution, not an unconditional atlas
status change.

The edge is conditionally true for classes satisfying any efficient
fixed-marginal residual selector condition, including the approximate
neutralizer condition above. This would justify an atlas note of the form:

> True for classes with efficient fixed-marginal approximate proper
> neutralizers, complement anchors, proper constants, or searchable
> fixed-marginal weak residual covers.

But the unconditional implication remains out of reach. The source node alone
does not force even information-theoretic neutralization, and it certainly
does not force efficient residual selection. Conversely, an unconditional
counterexample is also still out of reach: one must build an explicit class
that is clean properly learnable, has no efficient residual selector under a
fixed marginal, and keeps the hard agnostic instances in the middle window

$$
\operatorname{OPT}_{\mathcal C}\ge \alpha_P(s)
$$

where the clean-transcript coupling no longer applies but the weak threshold
still forces a computationally meaningful proper output. The previous
halfspace, monomial, PCP, code, parity, singleton, and one-way-handle
templates do not simultaneously satisfy these requirements.

So the best atlas action is to keep the edge open, while recording the
conditional theorem as a reusable lemma if conditional atlas annotations are
introduced.

VERDICT: conditional-only, scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

## Depth 6 Branch A: Last-Pass Separation Search

### Branch Question

This pass looked for an unconditional false witness outside the residual
selector proof architecture. The target was a class $\mathcal C$ satisfying
efficient marginal-nonuniform realizable proper PAC learning, but failing
efficient marginal-nonuniform weak agnostic proper PAC learning under one fixed
marginal.

The search intentionally revisited constructions that do **not** merely say
"there is no proper neutralizer." Depth 5 already showed that neutralizers are
sufficient but not necessary. A false witness must instead make every legal
proper output satisfying the weak agnostic threshold computationally hard to
find, while preserving easy clean proper learning.

I did not find a credible unconditional separation. The edge should remain
open.

### What A False Witness Must Still Do

Use $\{\pm1\}$ notation. For a fixed marginal $P$ and conditional mean
$\mu(x)=\mathbf E[Y\mid X=x]$, write

$$
M(\mu)=\sup_{c\in\mathcal C_s}\mathbf E_P[c(X)\mu(X)].
$$

The target asks for a proper $h$ with

$$
\mathbf E_P[h(X)\mu(X)]\ge M(\mu)+2\gamma_P(s)-1.
$$

Let $\alpha_P(s)$ be the low-noise cutoff from the clean-transcript coupling,
chosen below the inverse of the fixed-$P$ clean learner transcript bound. If

$$
M(\mu)>1-2\alpha_P(s),
$$

then the low-noise branch already produces a proper weak agnostic candidate.
Therefore a false witness must live in the narrow middle window

$$
M(\mu)\le 1-2\alpha_P(s),
$$

but must still make the threshold

$$
M(\mu)+2\gamma_P(s)-1
$$

computationally meaningful. Since the alleged target learner may choose
$\gamma_P(s)\ll\alpha_P(s)$, the hardest residual case is near the boundary
$M(\mu)\approx 1-2\alpha_P(s)$, where the required correlation is only a small
negative number. This is why merely making exact recovery hard is not enough:
any efficiently findable proper concept with correlation at least
$-\operatorname{poly}^{-1}$ may already satisfy the target.

### Asymmetric Classes Without Constants Or Complements

Asymmetry by itself does not produce a separation.

Singleton and small anchored classes are the warning examples. A singleton
class may have no constant opposite, no complement, and no neutralizer under a
point mass marginal. Nevertheless the agnostic target is trivial: always output
the only legal concept, whose error equals $\operatorname{OPT}_{\mathcal C}$.
More generally, if the class has a direct proper optimizer, a small enumerable
core, or a canonical output that is never too anti-correlated in the residual
region, missing constants are irrelevant.

Common-bias classes have the same problem. Suppose all concepts agree with a
positive anchor on a large $P$-mass set. The opposite label rule separates the
convex hull from zero and kills exact neutralization, but then every concept is
bad and $M(\mu)$ is nonpositive. In that case the weak agnostic inequality is
vacuous or nearly vacuous, because

$$
M(\mu)+2\gamma_P(s)-1<-1
$$

for small $\gamma_P(s)$. A target learner is not required to repair a label rule
on which the best proper concept is already anti-correlated.

The only useful asymmetric false-witness shape would be:

1. one hidden concept $c^\star$ has correlation just below
   $1-2\alpha_P(s)$;
2. all easy or canonical asymmetric concepts have correlation below the weak
   threshold;
3. finding any other legal concept above the threshold decodes a hard witness.

This is no longer an "absence of constants" argument. It is exactly a
fixed-marginal hard residual selector.

### Fixed-Marginal Anti-Neutralizers

The convex-hull anti-neutralizer route also stalls.

Failure of the exact neutralizer condition gives a bounded label rule $\nu$
such that

$$
\sup_{h\in\mathcal C_s}\mathbf E_P[h\nu]<0.
$$

But for this $\nu$, $M(\nu)<0$, so the weak target threshold is below $-1$ once
$\gamma_P(s)$ is small enough. Every proper hypothesis satisfies the target.
Thus an anti-neutralizer proves that the constants-style positive proof is
invalid, but it does not give a negative agnostic instance.

One can try to mix an anti-neutralizer with a good hidden concept:

$$
\mu=(1-\eta)c^\star+\eta\nu.
$$

If $\eta$ is below the clean-transcript scale, the low-noise coupling recovers
$c^\star$ often enough. If $\eta$ is above that scale, the residual threshold
usually drops to a small negative number, and any proper hypothesis not too
anti-correlated with $c^\star$ becomes legal. The construction therefore needs
to rule out all such neutral wrong hypotheses. That returns to code geometry
or selector hardness.

### Noisy Anti-Code Attempt And The PSD Barrier

The sharpest remaining unconditional-looking idea is a noisy anti-code:
choose a large family of concepts $\{c_t\}$ under one fixed marginal $P$,
label examples by a hidden $c_t$ with noise rate $\eta$, and arrange that every
wrong proper concept is too anti-correlated to satisfy the weak target. Then a
weak agnostic learner would have to recover $t$.

This runs into a simple Hilbert-space barrier.

For labels $\mu=(1-2\eta)c_t$, the best correlation is

$$
M(\mu)=1-2\eta.
$$

A wrong concept $c_u$ satisfies the target iff

$$
(1-2\eta)\langle c_u,c_t\rangle_P
\ge
(1-2\eta)+2\gamma_P(s)-1
=2(\gamma_P(s)-\eta).
$$

So, when $\eta>\gamma_P(s)$, to make every wrong concept fail one needs roughly

$$
\langle c_u,c_t\rangle_P
<
-\Theta(\eta-\gamma_P(s)).
$$

In the intended middle window, $\eta$ must be at least the transcript cutoff
$\alpha_P(s)$, while the target may choose $\gamma_P(s)\le \alpha_P(s)/2$.
Thus all distinct hard concepts would need pairwise correlations at most
$-\Theta(\alpha_P(s))$.

But if $N$ unit $\{\pm1\}$ functions have pairwise correlations at most
$-\theta$, then

$$
0
\le
\left\|\sum_{i=1}^N c_i\right\|_{L_2(P)}^2
=
N+2\sum_{i<j}\langle c_i,c_j\rangle_P
\le
N-\theta N(N-1),
$$

so

$$
N\le 1+\theta^{-1}.
$$

This is the same geometry behind the Plotkin-style obstruction already noted
for shared-code properization. At inverse-polynomial noise scale, a family in
which **every** wrong concept is weak-unsafe has only polynomially many hidden
targets. If those targets are explicitly enumerable, validation learns them.
If they are not enumerable, the hardness is coming from representation hiding
rather than from an atlas-ready learning-theoretic separation.

Relaxing the pairwise requirement leaves neutral wrong concepts. Hadamard or
parity-like classes have exponentially many targets, but wrong concepts have
correlation $0$ with the hidden target under the uniform marginal. In the
middle-noise regime the required threshold is negative, so those wrong proper
outputs are already acceptable. This is why parity/LPN and dense-code routes
keep failing for the weak proper target even though they are compelling for
strong agnostic or exact recovery problems.

### Computationally Hard Residual Selectors

The remaining possibility is not pure geometry: weakly legal proper hypotheses
may exist in abundance, but finding any one of them could be computationally
hard.

I checked the natural sources for such a primitive and did not find an
unconditional candidate.

- **Noisy parity / linear-code decoding.** Clean realizable proper learning is
  easy by Gaussian elimination. Noisy learning under the uniform marginal is
  related to LPN or decoding, but wrong parities have zero correlation, which
  satisfies the weak target in the middle-noise regime. To make wrong codewords
  fail one needs the anti-code geometry above, which collapses the hidden
  family size.

- **PRF or one-way-function classes.** These can make fixed-marginal noisy
  prediction hard, but seed-function classes usually also make clean
  realizable learning hard under a rich fixed marginal. The existing
  one-way-image-coordinate witnesses repair nearby weak/strong edges by adding
  constants and positive-atom handles; those same handles are exactly legal
  weak agnostic fallbacks here.

- **Error-correcting codes with easy erasure decoding and hard noisy decoding.**
  This is attractive because clean examples are erasures while agnostic noise
  is corruption. However, unless wrong codewords are weak-unsafe, any neutral
  codeword satisfies the target. Making all wrong codewords weak-unsafe again
  invokes the inverse-polynomial Plotkin/PSD bound.

- **Monomials, halfspaces, and FGRW/FGKP-style hardness.** The primary-source
  statements remain distribution-free or parameter-mismatched for this edge.
  Feldman--Gopalan--Khot--Ponnuswami show uniform-distribution reductions for
  parities and constant/subpolynomial hardness for monomials and halfspaces;
  the paper explicitly does not rule out the very-low-disagreement or smaller
  weak-advantage regimes needed to beat a hidden marginal-dependent gap. The
  later FGRW monomial-by-halfspace theorem gives strong weak-agnostic hardness
  for arbitrary constant $\epsilon$, but the hard marginal still comes from the
  reduction instance.

- **Membership-query separations.** Feldman's JMLR result gives a
  distribution-specific separation between agnostic learning with membership
  queries and random examples under one-way functions. This confirms that
  fixed-marginal random-example agnostic hardness can happen, but it is
  conditional and does not by itself give a source-positive random-example
  realizable proper class for the present edge.

An unconditional hard residual selector for unrestricted randomized polynomial
time would be a major lower bound. One could imagine a pathological
time-hierarchy or diagonal class that defeats each polynomial-time agnostic
learner on a chosen fixed marginal while preserving a custom clean learner.
I do not regard that as an atlas-ready route without a precise representation,
evaluation, and source-learner construction. It would also be out of character
with the current witness library, which uses standard classes or standard
conditional complexity assumptions.

### Last-Pass Misses

The last-pass separation search therefore leaves the following map.

1. Missing constants, complements, and exact neutralizers explain why the
   improper proof does not automatically properize, but they do not refute the
   weak agnostic target.

2. Anti-neutralizer label rules make $\operatorname{OPT}_{\mathcal C}$ too
   large, so the weak inequality becomes vacuous.

3. Noisy hidden-concept constructions either fall below the low-noise
   transcript scale, where the source learner already gives a weak proper
   candidate, or sit above that scale, where neutral wrong concepts usually
   satisfy the negative weak threshold.

4. Forcing every wrong concept to fail at inverse-polynomial middle noise
   requires pairwise negative correlations of inverse-polynomial magnitude,
   which bounds the hard family size by a polynomial via the PSD/Plotkin
   argument.

5. Existing computational hardness families either vary the marginal, prove
   strong rather than weak fixed-marginal hardness, rely on assumptions, leak
   weak handles, or make the clean realizable proper source fail.

No credible unconditional source-positive/target-negative class remains from
this pass.

### What Depth 7 Should Consolidate Into Atlas Notes

Depth 7 should consolidate exactly these points, without marking the edge
true or false:

1. Keep the edge status as
   ```yaml
   status: "open"
   evidence: unknown
   assumptions: []
   witnesses: []
   ```

2. State the positive part as a theorem sketch: for each fixed marginal $P$,
   the clean proper learner gives a proper weak agnostic candidate whenever
   $\operatorname{OPT}_{\mathcal C}$ is below the inverse clean-transcript
   scale.

3. State the missing middle-regime object in correlation form: a proper output
   or polynomial candidate list with correlation at least
   $M(\mu)+2\gamma_P(s)-1$ when $M(\mu)\le 1-2\alpha_P(s)$.

4. Record the conditional-positive lemma from depth 5: the edge is true for
   classes with efficient fixed-marginal residual selectors; efficient
   approximate proper neutralizers, proper constants, complement anchors,
   approximate complement pairs, balanced proper ensembles, and searchable
   fixed-marginal weak residual covers are sufficient subcases.

5. Record the negative diagnostics, not as witnesses: lack of constants or
   complements is insufficient; anti-neutralizer failure is vacuous when the
   best proper concept is anti-correlated; black-box transcript mining requires
   exponential trace correction outside the low-noise regime.

6. Add the depth-6 geometry warning if there is room: a noisy-code separation
   that makes every wrong proper concept fail the middle-noise weak threshold
   needs pairwise correlations $\le -\Theta(\alpha_P(s))$, hence only
   $O(1/\alpha_P(s))$ hidden targets by the PSD/Plotkin bound. Large code
   families leave neutral wrong concepts that are legal weak outputs.

7. Keep the known-source paragraph as "near misses": halfspaces/Tiegel give
   fixed-marginal strong hardness or distribution-varying weak hardness;
   monomial/FGRW/FGKP results give distribution-free constant or
   subpolynomial weak hardness but not the fixed-marginal inverse-polynomial
   middle-window statement; PCP active slices vary or dilute the marginal;
   parity/LPN gives fixed marginal but neutral wrong parities; one-way
   coordinate classes either break the source or add handles that satisfy the
   target.

8. The atlas conclusion should be: `open`, with a conditional theorem family
   and a sharpened explanation of why no current false-witness template
   settles the edge.

VERDICT: unresolved, scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

## Depth 7 Final Consolidation

### Final Verdict

Keep the edge `open` with `evidence: unknown`.

The last resolution attempt did not find an unconditional proof or an
atlas-ready counterexample. The best current state is:

- source alone gives a proper weak agnostic learner only in the very-low-OPT
  regime, by marginal-preserving clean-transcript coupling;
- the remaining middle-OPT regime is exactly a fixed-marginal proper residual
  selector problem;
- known false-witness templates still miss the fixed-marginal,
  inverse-polynomial weak-gap quantifiers, or else leak legal weak proper
  handles.

Thus the edge should not be marked `true` or `false`. It is not merely a
properization bookkeeping issue; it is an open computational selector issue.

### Strongest Conditional True Statements

**Unconditional low-noise partial.** Fix a marginal $P$. Let $m_P(s)$ be the
constant-accuracy sample/time bound of the realizable proper learner. For

$$
\alpha_P(s)\le \min\{1/128,1/(128m_P(s))\},
$$

if $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, repeated runs of
the clean learner on noisy samples can be coupled to clean realizable runs for
a near-optimal $c^\star\in\mathcal C$ using the same original marginal $P$.
Validation over the resulting proper candidates gives the weak target for a
gap $\gamma_P(s)<\alpha_P(s)$.

**Exact split condition.** The full edge is true if, in the residual region

$$
M_{\mathcal C}(\mu)
=\sup_{c\in\mathcal C_s}\mathbf E_P[c(X)\mu(X)]
\le 1-2\alpha_P(s),
$$

there is an efficient fixed-marginal residual proper selector that outputs a
polynomial list $L\subseteq\mathcal C_s$ with

$$
\max_{h\in L}\mathbf E_P[h(X)\mu(X)]
\ge M_{\mathcal C}(\mu)+2\gamma_P(s)-1 .
$$

The low-noise wrapper plus this selector and validation proves the target.

**Clean sufficient subcases.** The residual selector follows from any of the
following extra structures, none of which is implied by the source node:

- both constant classifiers are proper and efficiently available;
- an efficiently findable anchor $h_0$ and its proper complement are available;
- an efficiently generated approximate complement pair or balanced proper
  ensemble has barycenter $b$ with
  $\mathbf E_P|b(X)|\le 2(\alpha_P(s)-\gamma_P(s))$;
- an efficiently searchable fixed-marginal weak residual cover exists;
- more strongly, an efficiently generated proper $L_1(P)$ cover of radius
  at most $1/2-\gamma_P(s)$ exists.

### Strongest Failed False Routes

**No constants or complements.** Missing constants explains why the improper
robustification proof fails, but it is not a separation. Singleton and
anchored classes may lack neutralizers while remaining trivially agnostic
proper learnable. Anti-neutralizer label rules often make
$M_{\mathcal C}(\mu)<0$, where the weak inequality is vacuous.

**Halfspaces.** Halfspaces are source-positive and have strong agnostic
hardness evidence, but they contain proper constant halfspaces, so the weak
proper marginal-nonuniform target is handled by the low-noise-plus-constants
split. Tiegel-type results give distribution-varying weak hardness or
fixed-Gaussian strong excess-error hardness, not a false witness for this
weak fixed-marginal proper edge.

**Monomials, conjunctions, DNF, and FGRW/FGKP-style hardness.** These give
important weak agnostic hardness evidence, but the hard marginal is
distribution-free or reduction-instance dependent, and the available
parameters are constant or subpolynomial rather than the fixed-marginal
middle-window statement needed to beat a hidden inverse-polynomial
$\gamma_P(s)$.

**PCP and Label-Cover active slices.** Active slices give local weak proper
hardness, but the slice marginal carries the instance. Packing all slices into
one fixed marginal dilutes the hard mass, while shared-marginal variants need
a new cross-instance statement saying every weakly legal proper output decodes
the intended witness.

**Parity, LPN, and code routes.** Under fixed uniform marginals, wrong parities
or wrong nearly orthogonal codewords have correlation $0$. In the middle-noise
regime, the weak threshold is negative, so these wrong proper hypotheses are
already legal. In the very-low-noise regime, the clean-transcript coupling
learns.

**Noisy anti-code route.** To force every wrong proper concept to fail at
middle noise $\eta\gtrsim\alpha_P(s)$ while
$\gamma_P(s)\le \alpha_P(s)/2$, one needs pairwise correlations
$\langle c_u,c_t\rangle_P\le -\Theta(\alpha_P(s))$. The PSD/Plotkin bound then
limits the hidden family to $O(1/\alpha_P(s))$ targets, making brute-force
validation plausible if the targets are explicit. Large code families leave
neutral wrong concepts, which are legal weak outputs.

**One-way, PRF, and residual-selector hardness.** These can make noisy
prediction hard, but current atlas witnesses either break clean proper
learnability, rely on assumptions without the exact fixed-marginal weak
statement, or add weak handles that satisfy the target.

### Exact Obstacle

The unresolved object is an efficient fixed-marginal proper residual selector
in the middle region where

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)
$$

but the weak target still requires some legal concept whose correlation is not
too negative:

$$
\mathbf E_P[h(X)\mu(X)]
\ge M_{\mathcal C}(\mu)+2\gamma_P(s)-1 .
$$

The realizable proper learner guarantees useful behavior only on clean
realizable transcripts. Below the transcript scale, this is enough. Above it,
clean transcripts are exponentially unlikely, and the learner's behavior on
inconsistent transcripts is off-promise. The improper proof uses constants as
a neutralizer; the proper target has no such generic legal output. A false
witness must also remove all weak handles, not just make exact recovery hard.
No current construction does that under one fixed marginal while preserving
efficient clean proper learning.

### Proposed Atlas Snippets

Suggested frontmatter treatment:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
summary: "Open: marginal-preserving low-noise coupling gives proper weak agnostic candidates when OPT is below the fixed-marginal clean-transcript scale, but the middle-OPT regime needs an efficient proper residual selector or neutralizer; known halfspace, monomial, PCP, parity/code, and one-way routes either vary the marginal, prove only strong hardness, or leave legal weak proper handles."
```

Suggested edge body replacement:

```markdown
## Verdict

`open`.

The low-noise part is understood. Fix a marginal $P$ and run the realizable
proper learner at constant clean accuracy. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the inverse of the
resulting $P$-dependent transcript bound, couple the noisy run to a clean
realizable run for a near-optimal concept using the same original
$P$-distributed instance sequence. On the no-corruption event the source
learner returns a proper concept, and validation finds a proper weak agnostic
candidate.

The open part is the residual middle-OPT regime. In correlation notation, with
$\mu(x)=\mathbf E[Y\mid X=x]$ and
$M_{\mathcal C}(\mu)=\sup_{c\in\mathcal C}\mathbf E_P[c(X)\mu(X)]$, the target
needs a proper $h$ satisfying
$$
\mathbf E_P[h(X)\mu(X)]\ge M_{\mathcal C}(\mu)+2\gamma_P(s)-1.
$$
When $M_{\mathcal C}(\mu)\le 1-2\alpha_P(s)$ this is only a weak residual
selector requirement, but no efficient selector follows from clean realizable
proper learning alone.

The improper sibling edge uses the better constant classifier in this regime;
constants need not be legal concepts here. The edge would be true under extra
structure such as proper constants, complement anchors, efficient approximate
proper neutralizers, or searchable fixed-marginal weak residual covers.

Known false-witness routes remain near misses. Halfspaces have proper constant
fallbacks and their fixed-marginal hardness is strong rather than weak.
Monomial/FGRW and PCP routes vary or encode the hard instance in the marginal.
Parity, LPN, and code routes leave neutral wrong proper hypotheses that satisfy
the weak threshold. One-way and PRF-style routes either break the clean proper
source or leak weak handles. Thus no atlas-ready true or false resolution is
currently justified.
```

Suggested addition to `[[marginal-agnostic-hardness-open]]`:

```markdown
For the proper realizable-source to proper weak-agnostic edges, the exact
missing object is a fixed-marginal residual proper selector. Low-noise coupling
handles distributions whose best proper error is below the clean-transcript
scale. In the complementary region, the weak target only asks for a legal
proper concept that is not too anti-correlated with the labels, but clean
realizable learning supplies no generic way to find such a concept. Proper
constants, complement anchors, approximate neutralizers, or searchable weak
residual covers would settle the edge positively for the corresponding class.

Negative attempts must rule out all weak handles, not only exact recovery.
Noisy-code constructions that make every wrong proper concept fail require
inverse-polynomially negative pairwise correlations, which by the PSD/Plotkin
bound leaves only polynomially many hidden targets. Large orthogonal families,
such as parities or Hadamard-style codes, leave zero-correlation wrong concepts
that are acceptable once the weak threshold is negative.
```

VERDICT: unresolved, scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
