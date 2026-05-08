# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-realizable-improper-pac

- date: 2026-05-07
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-realizable-improper-pac`
- worker constraint: only this scratchpad was created/edited; no atlas files, legacy LaTeX files, or `references.bib` were edited
- verdict: unresolved
- confidence: 0.88

## Files And Sources Read

Required atlas files:

- `atlas/README.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- linked argument note `atlas/arguments/marginal-boosting-open.md`

Additional linked/context notes checked:

- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/unrestricted-labelings.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- neighboring edge notes to `efficient-weak-realizable-improper-pac`, `sample-efficient-realizable-improper-pac`, and the improper-source analogue

Prior exact scratchpads:

- Read `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`.
- No exact 2026-05-04 scratchpad for this edge was present.

Primary-source pages checked:

- Schapire 1990, *The Strength of Weak Learnability*: https://doi.org/10.1023/A:1022648800760
- Freund 1995, *Boosting a Weak Learning Algorithm by Majority*: https://doi.org/10.1006/inco.1995.1136
- Benedek and Itai 1991, *Learnability with respect to fixed distributions*: https://doi.org/10.1016/0304-3975(91)90026-X
- Ben-David, Benedek, and Mansour 1995, *A Parameterization Scheme for Classifying Models of PAC Learnability*: https://doi.org/10.1006/inco.1995.1094
- Hanneke, Moran, and Thiessen 2025, *Marginal-Nonuniform PAC Learnability*: https://openreview.net/forum?id=aoVCFtox89
- Feldman 2010, *Distribution-Specific Agnostic Boosting*: https://arxiv.org/abs/0909.2927
- Ghai and Singh 2025, *Sample-Optimal Agnostic Boosting with Unlabeled Data*: https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice 2026, *Sample-Near-Optimal Agnostic Boosting with Improved Running Time*: https://arxiv.org/abs/2601.11265

## Current Atlas State

The edge is currently marked:

```yaml
status: "open"
evidence: unknown
family: marginal-boosting-open
summary: "Open: full-support uniformization controls the resources for one weak call, but the source gives only marginal-dependent weak advantages; no known theorem boosts those hidden gaps to a distribution-free strong realizable improper learner."
```

This is the right diagnosis under the current atlas semantics. The older 2026-05-05 exact scratchpad already moved the obstruction away from one-call resource uniformization and toward weak-gap uniformization. I did not find a proof or counterexample that improves the verdict.

## Formal Reduction Target

Let $A$ be the source learner. For every instance marginal $P$, there are a marginal-dependent polynomial resource bound and a weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

where $1/\gamma_P(s)$ is bounded by some $P$-dependent polynomial. For every joint distribution $\mathcal D$ with marginal $P$, with high probability,

$$
\operatorname{err}_{\mathcal D}(A)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s),
$$

and $A$ outputs a proper hypothesis in $\mathcal C$.

On realizable labels from $c\in\mathcal C$, this specializes to

$$
\operatorname{err}_{P}(A,c)\le 1/2-\gamma_P(s).
$$

The target asks for one distribution-free polynomial-time improper learner that, for every $P$, every $c\in\mathcal C$, and every $\varepsilon,\delta$, returns $h$ with

$$
\operatorname{err}_{P}(h,c)\le \varepsilon
$$

in time polynomial in the representation size, $1/\varepsilon$, and $\log(1/\delta)$, with the polynomial independent of $P$.

## Positive Route: What Would Prove True

**Step 1: one weak call can be resource-uniformized.** Under the atlas convention that computational resources are worst-case/pathwise bounds on finite encoded sample transcripts, the `full-support-marginal-uniformization` argument applies to the single learner $A$. Choose a full-support reference marginal $P^\star$. Since every finite transcript that could arise under any marginal has positive probability under $P^\star$ with a suitable labeling rule, the polynomial bound for $P^\star$ bounds the sample use and runtime of $A$ on every transcript. Thus the cost of one call to $A$ can be made distribution-free.

**Step 2: realizable boosting would finish given a uniform weak gap.** Schapire/Freund boosting turns a weak realizable learner into a strong improper learner, and the final vote need not be a concept in $\mathcal C$. Therefore a proof would follow from an envelope such as

$$
\exists r\ \forall Q\quad \gamma_Q(s)\ge 1/r(s)
$$

for all marginals $Q$ that the booster may induce. The source gives only

$$
\forall Q\ \exists r_Q\quad \gamma_Q(s)\ge 1/r_Q(s).
$$

The quantifier swap is the missing theorem. Validation cannot hide it: estimating a weak edge of size $\gamma$ costs on the order of $1/\gamma^2$ samples, and the number of boosting rounds also depends polynomially on $1/\gamma$.

**Conditional true statement.** If the source definition were strengthened to include one distribution-free inverse-polynomial lower bound on $\gamma_P$, or if the schema adopted a size-indexed marginal semantics strong enough to diagonalize bad gaps into one bad marginal family, then full-support resource uniformization plus standard realizable boosting would prove the edge true. That is not the current atlas semantics.

## Same-Marginal Agnostic Boosting Near Miss

The source is agnostic, so one can try to avoid reweighted instance marginals by keeping $P$ fixed and randomizing labels. This is the most tempting positive route because Feldman-style distribution-specific agnostic boosting changes labels rather than the instance marginal.

Use $\{\pm1\}$ labels. For a realizable target $c$, define a relabeled distribution with

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1.
$$

The target concept $c$ has error $(1-\mathbb E_P a)/2$ on this relabeled distribution. The source guarantee gives

$$
\frac{1-\mathbb E_P[a(X)c(X)h(X)]}{2}
\le
\frac{1-\mathbb E_P a}{2}+\frac12-\gamma_P(s),
$$

so

$$
\mathbb E_P[a(X)c(X)h(X)]\ge \mathbb E_P a-1+2\gamma_P(s).
$$

If $a=\lambda\,dQ/dP$ for a target reweighted marginal $Q$, then $\lambda=\mathbb E_P a$ and $\lambda\le 1/\|dQ/dP\|_\infty$. The resulting $Q$-correlation is positive only when

$$
\lambda>1-2\gamma_P(s).
$$

When $\gamma_P(s)$ is tiny, this permits only density ratios extremely close to $1$. It cannot simulate the residual focusing needed to drive realizable error to arbitrary $\varepsilon$. Modern agnostic boosting results remain relevant, but their guarantees are parameterized by a nontriviality margin or weak-oracle slack; the atlas source supplies that margin only as $\gamma_P(s)$, which is marginal-dependent.

## Why The Sample-Only True Edge Does Not Settle This

The current atlas already has

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
  -> sample-efficient-realizable-improper-pac
```

as true. Hanneke, Moran, and Thiessen's marginal-nonuniform trichotomy plus VC theory collapse the sample-complexity question to finite VC dimension. Therefore any false witness for the present edge must be a purely computational separation: finite-sample learning is possible, but no uniform polynomial-time improper realizable learner exists.

That is a much narrower target than ordinary sample lower bounds.

## Counterexample Search

I did not find a valid false witness.

**Pseudorandom function classes.** These are target-negative under standard cryptographic assumptions, but they are source-negative. On the hard marginal, even weak learning would distinguish pseudorandom functions from random labels.

**Unrestricted labelings.** These fail the target information-theoretically, but they also fail the source. They are only an absolute impossibility baseline.

**Halfspaces.** Halfspaces are not a counterexample. Their agnostic hardness is relevant to agnostic targets, but realizable halfspaces are efficiently learnable by linear feasibility/VC generalization, so the improper realizable target holds.

**Fixed-$k$-term DNF.** This is a proper weak-to-strong separation witness in the atlas. It does not refute the present target, which allows improper hypotheses and only asks for realizable learning.

**Clause-satisfaction and PCP active-slice lookup classes.** These exploit proper-output hardness. The active slices have polynomial size, so an improper learner can memorize or use lookup-table ERM. They are target-positive here.

**One-way image-coordinate weak-handle class.** This is source-positive for proper weak variants and strong-proper hard, but the assigned target is improper. The atlas witness itself notes that improper memorization learns the sparse positive coordinate atoms, so it does not separate this edge.

**Rare-slice/hard-slice template.** The tempting construction is to make slice $k$ have weak handles of advantage roughly $s^{-k}$, with strong learning requiring many handles or solving a hard residual problem. This remains only a template. If a marginal can isolate the hard residual, the weak agnostic source usually fails. If cheap proper handles are available on every residual marginal, an improper learner can often aggregate them. And under the full-support pathwise convention, the source learner cannot hide slice-dependent superpolynomial runtime in low-probability transcripts; only the weak advantage may deteriorate.

## Obstacles That Remain

1. **Weak-gap uniformization.** The unresolved positive lemma is:

   > A single pathwise-polynomial learner satisfying marginal-nonuniform weak agnostic proper learning must have a distribution-free inverse-polynomial weak advantage on realizable labels.

   I do not see a proof under the current global-marginal reading.

2. **Boosting over induced marginals.** Standard realizable boosting changes the instance marginal. The source gives a weak gap for each induced marginal, but no envelope over the family generated during boosting.

3. **Fixed-marginal relabeling floor.** Same-marginal agnostic relabeling avoids induced marginals, but the fixed-additive `OPT + 1/2 - gamma_P` guarantee only gives useful correlation when the relabeling weight has mean above `1 - 2 gamma_P`. This is too weak for arbitrary residual focusing.

4. **Counterexample tension.** A target-negative computational witness must be hard for strong improper realizable learning, yet weakly agnostically properly learnable under every marginal. Existing cryptographic witnesses lose the source; existing proper-hardness witnesses satisfy the improper target.

## Promising Follow-Ups

- Formalize a `weak-gap-uniformization-open` lemma separate from one-call resource uniformization. The present edge is blocked by the weak gap, not by runtime of a single source call.
- Decide whether the atlas wants global marginals or size-indexed marginal families. Under a stronger size-indexed semantics, a diagonal argument over bad weak gaps may prove this edge true.
- Search specifically for computationally nonboostable weak-handle classes: one cheap proper weak handle for every marginal, finite VC dimension, but no polynomial-time way to assemble enough handles into an improper strong learner.
- Check whether modern agnostic boosting frameworks can handle the atlas fixed-additive oracle with runtime polynomial in `1/epsilon` without an explicit polynomial dependence on `1/gamma_P`. The primary-source results I checked still appear to need a quantitative weak-oracle margin.

## Conclusion

The current open status should remain. The clean theorem route needs a distribution-free weak-gap envelope not present in the source definition. The clean separation route needs a source-positive, target-negative improper-realizable computational witness, and the standard atlas witnesses do not supply one.

VERDICT: unresolved

## Depth 2 Branch A: Weak-Gap Uniformization Diagonal

- date: 2026-05-07
- branch: weak-gap uniformization / diagonal theorem under current global marginals
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- write constraint: appended only to this scratchpad; no atlas files or bibliography edited

### Question

Test the possible theorem:

> If one pathwise-polynomial learner $A$ satisfies efficient marginal-nonuniform weak agnostic proper PAC learning, then on realizable labels $A$ has a distribution-free inverse-polynomial weak gap.

If true, the edge would become true: restrict the agnostic source to realizable labels, use the uniform gap to get a distribution-free weak proper learner, and apply Schapire/Freund boosting to obtain the distribution-free strong improper target.

I do not see a proof under the current atlas semantics. I also do not have an atlas-ready false witness. The branch verdict is therefore `unresolved`, with one conditional theorem and one concrete obstruction to the diagonal proof.

### Setup

Fix the source learner $A$ and confidence, say $\delta=1/3$. By the full-support finite-transcript argument, one call to $A$ has a distribution-free pathwise polynomial sample/time bound. Thus the remaining issue is purely quantitative accuracy.

For every marginal $P$, the source supplies some polynomial $r_P$ such that on realizable labels

$$
\operatorname{err}_P(A,c)\le \frac12-\frac{1}{r_P(s)}.
$$

The desired uniformization theorem would replace this with

$$
\exists r\text{ polynomial}\quad
\forall P,c,s,\qquad
\operatorname{err}_P(A,c)\le \frac12-\frac{1}{r(s)}.
$$

This is stronger than one-call resource uniformization. Boosting needs this kind of lower envelope because both the number of rounds and validation cost scale polynomially in the inverse weak advantage.

### Size-Indexed Marginals Give A Conditional True Theorem

There is a clean diagonal proof if the schema is strengthened so that a marginal is a size-indexed family $P=(P_s)_{s\ge 1}$ and the guarantee at size $s$ is evaluated under $P_s$ with full mass.

Assume no distribution-free inverse-polynomial weak gap exists. For every exponent $d$, choose a size $s_d$, a marginal $Q_d$ on that size slice, and a realizable target $c_d$ such that $A$'s advantage is below $s_d^{-d}$. Choose the sizes increasing fast enough to absorb constants.

Define one diagonal marginal family by setting $P_{s_d}=Q_d$ and filling all other sizes arbitrarily. Since the source must hold for this single family $P$, there is a polynomial $r_P(s)\le C s^D$ such that $A$ has advantage at least $1/r_P(s)$ for every selected size. Taking $d>D$ and $s_d$ large contradicts the construction of $Q_d$.

Under that stronger semantics, full-support resource uniformization plus this weak-gap diagonal would make the present edge `true` by ordinary realizable boosting. This is a conditional theorem about a nearby schema, not a proof for the current atlas.

### Why Weighted Global Mixtures Do Not Diagonalize

The current atlas treats a marginal as one global distribution over instances, not as a per-size family with full mass at each selected size. The natural attempt is to mix the bad marginals:

$$
P=\sum_{j\ge 1} w_j Q_j.
$$

This does not force $A$ to be weak on any particular low-mass component $Q_j$. If a target is nontrivial only on component $j$ and zero elsewhere, then the all-zero hypothesis has global error at most $w_j/2$, even if it has error $1/2$ inside $Q_j$. For small $w_j$, that is already a large global weak advantage. Thus the source guarantee for $P$ can be satisfied while completely ignoring the component where the diagonal wanted to expose a tiny gap.

If a target is active on many components at once, a weak learner still only needs a global edge. With summable weights, a handle on a finite high-mass prefix can give inverse-polynomial global advantage while the low-mass tail, where the local gaps deteriorate, remains invisible to the additive weak guarantee. Strong learning to accuracy below the tail mass would have to care, but that is exactly the target conclusion and cannot be imported into the weak source.

This is the concrete obstruction beyond the bare quantifier swap: global mixture mass dilutes bad slices before the weak inequality sees them. The size-indexed proof needs "evaluate $Q_j$ with full mass at size $s_j$"; the current mixture only gives "$Q_j$ has weight $w_j$ inside one global distribution."

### Finite Transcript Compactness Is Too Weak

A compactness route also stalls. Once one-call resources are pathwise bounded, for a fixed finite support and fixed size one can often take an infimum of $A$'s advantage over the relevant marginals and targets. If the source gives strict weak learning everywhere, this may produce a positive number $g_s$.

But this does not give the atlas target. First, $g_s$ can be much smaller than any inverse polynomial as $s$ varies. Second, on countable or expanding supports, mass can escape to farther slices, so finite-support compactness does not control the global marginal class without an additional tightness or size-indexed assumption. Third, even a nonconstructive positive $g_s$ is useless for efficient boosting if $1/g_s$ is super-polynomial.

So finite transcript compactness explains why a weak edge may exist pointwise at each fixed scale; it does not produce the polynomial lower envelope needed by a distribution-free PAC learner.

### Validation Limits

Validation cannot safely discover the hidden gap. To certify that a candidate has advantage $\gamma$, empirical comparison needs on the order of $\gamma^{-2}$ samples. If the only available guarantee under a marginal is $\gamma_P(s)=s^{-k(P)}$ with unbounded $k(P)$, any strategy that searches for or validates the gap can run for $s^{2k(P)}$ samples. That is allowed for a marginal-nonuniform source but not for the distribution-free target.

This also blocks the leading rare-block false template. Dense PRF or random-oracle blocks can make strong improper learning hard on a block of size $N=s^j$, and sparse proper handles can offer only a tiny local advantage about $1/N$. However, an arbitrary-marginal weak agnostic proper source must handle near-balanced reweightings of the same block. Choosing the correct deterministic default orientation at bias scale $1/N$ requires validation or bias testing at that same scale, about $N^2$ samples. If $j$ is unbounded, that violates the uniform pathwise weak-call bound. Stochastic final hypotheses would avoid the orientation choice, but those are not the current atlas semantics.

### Current State Of The Theorem

The proposed weak-gap uniformization theorem is conditionally true under size-indexed marginal semantics, but I cannot prove it for current global marginals. The weighted-mixture calculation shows why the diagonal proof fails, and the validation calculation explains why the obvious rare-block obstruction is not yet a valid counterexample.

Thus the edge remains open. A proof still needs a genuine global-marginal weak-gap envelope; a disproof still needs a deterministic, orientation-free weak-handle construction that satisfies the full agnostic proper source while leaving strong improper learning hard.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Finite-Transcript Compactness Barrier

- date: 2026-05-07
- branch: finite-transcript compactness and validation-scale barrier
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Question

Can the pathwise finite-transcript convention do more than uniformize the cost of one weak call? In particular, can compactness over finite transcripts turn pointwise marginal weak gaps

$$
\forall P\ \exists k(P)\quad \gamma_P(s)\ge s^{-k(P)}
$$

into one distribution-free polynomial gap

$$
\exists k\ \forall P\quad \gamma_P(s)\ge s^{-k}?
$$

The answer I can justify is negative for this proof route. Finite-transcript compactness can give fixed-size positivity under extra finiteness assumptions, but it has no mechanism for producing a polynomial lower envelope in $s$. Validation at an unknown gap scale gives a formal black-box barrier to trying to discover the missing exponent adaptively.

### Lemma 1: Fixed-Size Compactness Has No Polynomial Content

**Statement.** Suppose that, for each representation size $s$, the relevant transcript space is finite after the pathwise sample/time bound is fixed, the size-$s$ instance slice is finite, and the expected realizable advantage of the source learner is a lower-semicontinuous function of the size-$s$ marginal and target. If every size-$s$ marginal/target pair has a strict weak advantage, then compactness gives a positive number

$$
g_s=\inf_{P,c}\gamma_{P,c}(s)>0.
$$

However, this argument alone cannot imply $g_s\ge 1/\operatorname{poly}(s)$.

**Proof.** The compactness part is the usual extreme-value argument: on a compact parameter set, a positive lower-semicontinuous advantage function has positive infimum.

The quantitative failure is just as formal. Compactness is applied separately for each fixed $s$, so it permits an arbitrary positive sequence of minima. For example, a proof schema that only knows "the minimum at size $s$ is positive" cannot distinguish $g_s=s^{-10}$ from $g_s=s^{-s}$ or $g_s=2^{-s}$. A polynomial conclusion would need additional structure relating the compact spaces and advantage functions across different sizes.

This matters here because the source guarantee is marginal-wise, not size-wise uniform:

$$
\forall P\ \exists k(P)\ \forall s\quad \gamma_P(s)\ge s^{-k(P)}.
$$

The missing target statement swaps the quantifiers over $P$ and $k$. Fixed-size compactness never sees that swap. It only supplies a sequence $(g_s)_s$, and that sequence may decay faster than every inverse polynomial even when every individual marginal has some polynomial rate.

### Why The Global-Marginal Diagonal Still Fails

The natural response is to diagonalize over bad sizes: for each exponent $j$, choose a marginal $Q_j$ and size $s_j$ whose gap is below $s_j^{-j}$, then combine the $Q_j$ into one marginal. Under size-indexed semantics this was the depth-2 conditional theorem. Under the current global-marginal semantics the combination step loses the contradiction.

If

$$
P=\sum_{j\ge 1}w_jQ_j,
$$

then the $j$th bad component has only mass $w_j$. A proper weak learner can obtain a global edge by handling the high-mass prefix or by using a default hypothesis on the tail; it is not forced to exhibit the tiny local edge inside $Q_j$ with full mass. Making $w_j$ large enough to preserve all local gaps prevents the weights from being summable. Making the weights summable dilutes the bad components before the additive weak inequality can detect them.

So the compactness-plus-diagonal route proves only a nearby conditional statement:

> If the schema treated a marginal as a size-indexed family evaluated with full mass at each selected size, then bad weak gaps could be stitched into one bad marginal family, forcing a uniform inverse-polynomial gap. For the current atlas global marginals, this stitching is invalid.

### Lemma 2: Validation Has A Gap-Scale Lower Bound

**Statement.** Any validation procedure that distinguishes a hypothesis with error $1/2$ from one with error $1/2-\gamma$, or certifies advantage at least $\gamma/2$ with constant success probability, needs $\Omega(\gamma^{-2})$ fresh labeled examples in the worst case.

**Proof.** Validation errors are Bernoulli observations. Distinguishing $\operatorname{Bernoulli}(1/2)$ from $\operatorname{Bernoulli}(1/2-\gamma)$ from $n$ samples has total variation bounded through the KL divergence by a constant times $\sqrt{n\gamma^2}$ for small $\gamma$. If $n=o(\gamma^{-2})$, the two experiments remain statistically indistinguishable, so no test can succeed with probability bounded away from $1/2$ in both cases.

The same lower bound applies when comparing candidate hypotheses: the empirical excess accuracy of one candidate over another is still a bounded random variable whose mean differs by only $\Theta(\gamma)$.

### Consequence For Hidden-Gap Boosting

A distribution-free strong learner must have one polynomial sample/time bound, say $q(s,1/\varepsilon,\log(1/\delta))$. If the only source guarantee under marginal $P$ is

$$
\gamma_P(s)=s^{-k(P)}
$$

with $k(P)$ unbounded over marginals, then any validation-based search for the weak scale can be forced beyond the target budget. Choose $P$ with $k(P)$ larger than the degree implicit in $q$. At size $s$, validation at the true weak edge costs about

$$
s^{2k(P)}
$$

samples, and standard realizable boosting also has quantitative dependence on $1/\gamma_P$. This is still allowed for the marginal-nonuniform source, because $k(P)$ may depend on $P$, but it is not allowed for the distribution-free target.

This gives a formal barrier for black-box reductions that try to use the source learner by calling it, validating its edge, and then boosting. They must either know a distribution-free lower bound on $\gamma_P$ in advance or spend nonuniform validation effort to find it.

### What This Does And Does Not Resolve

This branch gives a genuine no-go lemma for the compactness proof strategy and a formal lower bound for validation-based hidden-gap discovery. It does not construct an atlas counterexample to the implication. A non-black-box learner might exploit additional representation structure of $\mathcal C$, and the sample-only edge is already true by the marginal-nonuniform trichotomy plus VC theory.

Thus the strongest model-level statement I can defend under the current global marginals is:

> Pathwise finite-transcript compactness can uniformize the resource bound of one source call and can sometimes give nonquantitative fixed-size weak positivity. It cannot, without an additional size-indexed/local-uniformity assumption, promote pointwise marginal weak gaps to a distribution-free inverse-polynomial gap. Moreover, any black-box attempt to discover the missing gap by validation has worst-case cost $\Omega(\gamma_P(s)^{-2})$, which is nonuniform when the marginal exponent $k(P)$ is unbounded.

The edge therefore remains unresolved rather than resolved false. The branch rules out a tempting proof method, not the implication itself.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 4 Branch A: Non-Black-Box Weak-Gap Extraction

- date: 2026-05-07
- branch: non-black-box weak-gap extraction from proper agnostic source
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Question

The previous branches rule out two tempting black-box routes. Full-support finite-transcript compactness gives a pathwise polynomial bound for one call to the source learner, but not a polynomial lower envelope on the weak gap. Empirical validation can discover an advantage $\gamma$ only with $\Omega(\gamma^{-2})$ labeled samples.

This branch asks whether the extra structure of the source notion can do better. The source learner is **proper** and **agnostic**. On realizable labels it outputs a concept $h\in\mathcal C$, and its guarantee holds not only for true labels $c(x)$ but also for arbitrary conditional label distributions with the same marginal. Could a reduction use the code of the learner, the proper representation of $h$, self-reductions, confidence amplification, or disagreement tests to extract a distribution-free inverse-polynomial weak gap?

I do not see such an extraction under the current atlas semantics. The obstruction is not merely that a black-box oracle hides $\gamma_P$. Even with non-black-box access to the learner and its proper outputs, the source promise gives no efficiently checkable certificate that the realized correlation is at least $1/\operatorname{poly}(s)$ rather than $s^{-k(P)}$ for an unbounded marginal-dependent exponent.

### Setup

Fix a marginal $P$ and a realizable target $c\in\mathcal C$. A successful source call returns a proper hypothesis $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
$$

where $\gamma_P(s)$ is inverse-polynomial for this fixed $P$, but no uniform lower bound on $\gamma_P(s)$ is supplied. A distribution-free reduction needs to produce, in time polynomial in $s,1/\varepsilon,\log(1/\delta)$ with a polynomial independent of $P$, a strong improper hypothesis.

Thus any non-black-box extraction must somehow replace

$$
\forall P\ \exists k(P)\quad \gamma_P(s)\ge s^{-k(P)}
$$

by usable behavior at a uniform scale, without spending $s^{\Theta(k(P))}$ samples or rounds.

### Proper Output As A Certificate

Properness gives a syntactic object: the weak learner returns a represented concept $h\in\mathcal C$. This is useful for evaluating $h(x)$ on fresh examples and for forming derived labels such as $y\oplus h(x)$. It is not, by itself, a certificate of distributional accuracy.

The relevant statement is semantic:

$$
\mathbb E_{x\sim P}[1[h(x)\ne c(x)]] < \frac12.
$$

Under an arbitrary unknown marginal $P$, this quantity is not computable from the two concept representations alone. It must be estimated from labeled examples, and distinguishing error $1/2$ from $1/2-\gamma$ costs $\Theta(\gamma^{-2})$ samples. Training error is not a substitute, since the output is chosen from the training sample and the source guarantee is distributional rather than an empirical certificate.

Nor does properness create a locally checkable proof of the edge. If the class has extra structure, for example exact integration under known $P$, a canonical margin certificate, or a polynomial-time distance oracle for every relevant marginal, that is additional representation-specific information. It is not part of the source node. The atlas implication would need to hold for arbitrary represented classes satisfying the source definition.

### Confidence Amplification Does Not Magnify The Gap

One can reduce the failure probability of the source learner by independent repetition, but this only makes it more likely to obtain hypotheses with advantage about $\gamma_P(s)$. It does not make the advantage itself distribution-free.

Taking a majority vote over repeated outputs is also insufficient as a generic operation. If every run returns essentially the same weak hypothesis, majority voting preserves the same error. If the outputs are diverse, a majority may help, but the source guarantee does not provide conditional independence of pointwise errors, diversity, or a lower bound on the variance structure needed for bagging-style amplification. Standard boosting obtains diversity by changing the distribution or loss focus; once it does so, the relevant weak gaps are again marginal-dependent.

Selecting the best member of a repeated list brings back validation. To know that some candidate beats random guessing by $1/\operatorname{poly}(s)$, or even to set the number of repetitions needed to amplify a gap $\gamma_P$, the reduction needs quantitative access to $\gamma_P$.

### Same-Marginal Agnostic Self-Reductions Hit A Floor

Agnosticism is the most promising extra property because it lets a reduction manufacture noisy labels while keeping the same instance marginal $P$. In $\{\pm1\}$ notation, suppose the reduction creates labels $Y$ satisfying

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1.
$$

The target concept $c$ has error $(1-\mathbb E_P a)/2$ on this relabeled distribution. The agnostic source guarantee gives

$$
\mathbb E_P[a(X)c(X)h(X)]\ge \mathbb E_P a-1+2\gamma_P(s).
$$

Thus relabeling enforces positive correlation only when the average retained signal satisfies

$$
\mathbb E_P a>1-2\gamma_P(s).
$$

This is the same floor seen in the earlier same-marginal boosting near miss. It prevents the reduction from focusing on a small residual region while keeping the marginal fixed. For example, if $a=1_S$, then the guarantee gives useful correlation on $S$ only when $P(S)$ is within $2\gamma_P$ of full mass. Strong learning eventually needs to concentrate on low-error residual sets of mass about $\varepsilon$, and the same-marginal agnostic promise is too weak to force a helpful hypothesis there.

The alternative is to condition or rejection-sample on the residual set, changing the marginal to $Q=P\mid S$. But then the source gap becomes $\gamma_Q$, again with no distribution-free lower envelope. This is exactly the hidden-gap problem in boosting form.

### Residual Learning Lacks Closure

Because $h$ is proper, a natural self-reduction is to learn the residual between $h$ and the true target. Given labeled examples, the reduction can compute whether $h(x)\ne y$ and can sample from the current error region by rejection.

There are two problems.

First, conditioning on the error region changes the instance marginal, so the next source call is governed by a new hidden gap. A uniform strong learner cannot budget rounds or validation from the promise $\forall Q\ \exists k(Q)$.

Second, derived labels such as $c(x)\oplus h(x)$ need not be realizable by any concept in $\mathcal C$. The source is agnostic, but its guarantee is only relative to $\inf_{g\in\mathcal C}\operatorname{err}(g)$. If the residual labeling has no good proper concept in $\mathcal C$, the agnostic call may legitimately return a hypothesis with no useful information about the residual. Closure under xor, symmetric difference, restrictions, or residual concepts would be an extra algebraic assumption, not a consequence of proper weak agnostic learnability.

### Empirical Disagreement Tests Are Orientation-Blind

Proper outputs allow unlabeled estimates of pairwise distances

$$
P[h_i(X)\ne h_j(X)].
$$

These tests can reveal whether candidate concepts cluster under $P$, but they do not reveal which side of the cluster agrees with the unknown target $c$. Orientation relative to $c$ requires labels, and then the same $\Omega(\gamma^{-2})$ validation lower bound applies.

Even labeled pairwise comparisons only solve a selection problem once a polynomial threshold is known. If all certified advantages may be as small as $s^{-k(P)}$, then any fixed polynomial sample budget can see the useful hypotheses as statistically indistinguishable from coin-flip predictors for a marginal with large enough $k(P)$.

### Non-Black-Box Access To The Learner Code

One might hope to inspect the source learner rather than treating it as an oracle. The full-support transcript argument already extracts the strongest generic code-level fact available from the source promise: one call has a distribution-free pathwise polynomial resource bound. Beyond that, the code does not necessarily expose the semantic advantage.

Enumerating possible transcripts or random coins only produces a set of candidate proper hypotheses. The missing step is still to identify, under the unknown marginal and target, which candidates have nontrivial correlation at a polynomial scale. That is a distributional fact, not a syntactic one. Without extra structure on $\mathcal C$ or $P$, it is accessible only through samples.

This gives a barrier for generic non-black-box reductions: the source promise constrains the learner's performance for each fixed marginal, but it does not provide the witness polynomial, the exponent $k(P)$, a certificate of advantage, or a closure operation that turns a tiny proper weak edge into a strong improper hypothesis at a uniform cost.

### Barrier Statement

The following is the strongest statement this branch supports.

> A generic proof of the implication cannot be obtained merely from properness, agnosticism, confidence amplification, empirical disagreement testing, residual self-reductions, or inspection of the source learner's finite transcripts. Each route either needs validation at scale $\gamma_P(s)$, changes to a new marginal with its own hidden gap, or assumes closure/certification structure not present in the atlas definition.

This is not a counterexample to the implication. A representation-specific theorem might still exploit special structure of all classes satisfying the source node, and no source-positive target-negative witness is constructed here. The branch therefore leaves the edge open, while sharpening the obstruction: the missing ingredient is a genuine weak-gap uniformization or a new structural theorem, not simply a more clever use of the proper agnostic output.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Source-Positive Counterexample Search

- date: 2026-05-07
- branch: source-positive counterexample without uniform weak-gap extraction
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Search Target

The desired false witness would be a represented binary class $\mathcal C$ with all three properties below.

1. A single uniform algorithm weakly agnostically learns $\mathcal C$ properly under every marginal $P$, with sample and time bounded by a $P$-dependent polynomial.
2. The available weak gaps have no distribution-free inverse-polynomial envelope: for a family of marginals $P_j$, the best justified edge may be only $\gamma_{P_j}(s)\approx s^{-j}$.
3. No distribution-free polynomial-time improper realizable learner exists.

This search deliberately avoided relying on the already-failed templates: plain pseudorandom-function blocks, PCP/properization gadgets, halfspaces, and lookup-handle constructions.

### Focused Literature Check

The closest external results I found are all model mismatches rather than candidates.

- Hanneke--Moran--Thiessen's marginal-nonuniform PAC paper confirms that the relevant sample-only landscape is a rates/trichotomy story: finite classes get exponential rates, finite VC-eluder dimension gives linear rates, and infinite dimension may force arbitrarily slow rates. This supports the existing scratchpad diagnosis that a target-negative witness for the present edge must be computational, not information-theoretic. Source: OpenReview page, `Marginal-Nonuniform PAC Learnability`, lines 15--19.
- Schapire/Freund boosting remains the baseline positive theorem only when a quantitative weak edge is supplied. Freund's abstract explicitly notes resource bounds and also mentions variants where weak accuracy depends on the instance distribution, but this still does not produce a distribution-free envelope over hidden marginal exponents. Source: ScienceDirect page for Freund 1995, abstract.
- Kharitonov-style distribution-specific cryptographic hardness gives target-negative-looking classes, including Boolean formulas and shallow circuits under specific distributions, but the lower bound is for weak prediction as well. Thus these are source-negative on the hard marginal rather than source-positive hidden-gap examples. Source: Kharitonov 1993 PDF; also summarized in the searchable abstract as weak learning of Boolean formulas / threshold circuits under fixed distributions being cryptographically hard.
- Blum--Furst--Jackson--Kearns--Mansour--Rudich give a useful near miss: DNF is weakly learnable with membership queries under the uniform distribution, while DNF and decision trees are not weakly learnable in polynomial time in the SQ model. This is not the atlas source, which uses random examples, arbitrary marginals, agnostic labels, and proper hypotheses. It also does not give target failure for ordinary improper PAC. Source: `Weakly Learning DNF and Characterizing Statistical Query Learning Using Fourier Analysis`, abstract lines 17--32.
- Szorenyi's SQ characterization contains the closest structural analogue to "weak but not strong under a fixed distribution": distribution-dependent SQ weak and strong learning have different dimensions, and the paper even discusses proper/improper behavior. But the model counts SQ information complexity and explicitly does not consider running time; moreover SQ lower bounds do not imply ordinary PAC lower bounds. Source: Szorenyi 2009 PDF, lines 18--30, 113--115, 197--200, and 545--554.

### No-Candidate Table

| Candidate family | Why it was tempting | Blocking failure |
|---|---|---|
| Distribution-specific cryptographic circuit classes, e.g. Boolean formulas, AC0/TC0-style hardness | Fixed hard marginals give computational target failure under standard assumptions. | Known statements rule out even weak prediction on the hard marginal, so the marginal-nonuniform weak agnostic proper source fails. This is the same source-negative shape as PRF hardness, only in circuit clothing. |
| DNF via Kushilevitz--Mansour / Fourier methods | It has a genuine weak-learning positive result under the uniform distribution with membership queries. | The positive result is uniform-distribution and membership-query, not arbitrary-marginal random-example weak agnostic proper PAC. The SQ lower bounds are lower bounds for SQ algorithms, not for the target's unrestricted improper PAC learner. |
| SQ weak/strong separation examples | They look exactly like "weak handles exist but strong amplification is impossible" in a fixed-distribution query model. | The separation lives in the SQ model and in query information complexity. Parity-like examples can be strongly PAC-learned outside SQ, so they cannot refute the atlas target. |
| Parameterized unions such as $k$-juntas, sparse parity variants, or bounded-width formula hierarchies | Each fixed parameter has a polynomial-time learner with an exponent depending on the parameter, suggesting unbounded hidden exponents. | For common marginals such as uniform, the source polynomial may depend on the marginal but not on the target parameter except through the usual representation-size variables. Exhaustive $n^k$ searches are not polynomial in the represented target size when $k$ varies. For sparse parities, the improper target is also positive by ordinary parity learning. |
| Time-hierarchy slice classes | A slice $j$ could be learnable in time $s^j$, giving a uniform learner with marginal-dependent exponent on marginals concentrated on that slice, while no single target learner has one exponent for all slices. | I did not find a literature-ready class satisfying the full agnostic proper source. Diffuse marginals over infinitely many slices require a finite-prefix weak agnostic ERM argument, and target failure depends on representation and prediction-time accounting. This remains a model fork, not a concrete witness. |
| SQ-hard monotone/shallow formula lower-bound families | They provide unconditional or cryptographic hardness against a broad algorithmic class under natural distributions. | The target learner is not restricted to SQ, and the source would have to be a random-example agnostic proper learner for every marginal. Existing lower bounds are either too weak for PAC target failure or too strong in the wrong direction, making the source fail. |

### Remaining Model Forks

**Size-indexed marginal semantics.** If marginals were treated as size-indexed families evaluated with full mass at each size, the depth-2 diagonal argument would likely force a uniform weak-gap envelope and resolve the edge `true`. That is not the current global-marginal reading.

**Stochastic prediction hypotheses.** Rare-slice constructions become easier if the weak source may output a randomized nearly-fair predictor whose tiny bias has the right orientation without being statistically validated. The atlas target and source are deterministic hypothesis notions, so this would be a schema change.

**Marginal advice or separate learners.** If the source allowed a different algorithm, advice string, or exponent certificate for each marginal, a time-hierarchy slice construction would be much easier to formalize. The current source requires one uniform learner; only the polynomial bound may depend on $P$.

**Prediction-time accounting.** A staged hierarchy could be made sharper if hypothesis evaluation time is explicitly charged and if a concept representation can name a hard slice without letting the learner output a cheap interpreter for it. The current notes do not pin down enough representation-level machinery to turn this into an atlas witness.

**SQ/noise-tolerant variants.** Fixed-distribution SQ theory has real weak/strong separations and proper/improper subtleties. These are good diagnostics for the obstruction, but they resolve a different edge: an SQ-restricted target, not ordinary efficient realizable improper PAC learning.

### Conclusion

No concrete source-positive, target-negative class survived the focused search. The near misses either fail the source on a hard marginal, prove only SQ or membership-query statements, or require a schema fork such as size-indexed marginals, stochastic hypotheses, marginal advice, or explicit prediction-time lower bounds.

The edge therefore remains unresolved. The strongest update from this branch is negative evidence about the false-witness route: known computational hardness families do not merely hide the weak gap; they usually destroy the weak source itself. A valid counterexample would need a new kind of computationally nonboostable proper weak handle, not just a hard residual class.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 6 Branch A: Consolidated Model-Fork Summary

- date: 2026-05-07
- branch: depth-6 consolidation before atlas incorporation
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Consolidated Claim

The cleanest atlas-ready synthesis is a three-way fork.

1. The implication is conditionally true if the source is strengthened by a distribution-free inverse-polynomial weak-gap envelope.
2. The implication is also conditionally true under size-indexed marginal semantics, because the bad-gap diagonal can be evaluated with full mass at each selected size.
3. The implication remains open under the current atlas semantics, where marginals are global distributions and the source outputs deterministic proper hypotheses with only marginal-dependent weak gaps.

There is a false-looking stochastic/output-mixture fork, but it should not be recorded as a resolved false atlas edge. It requires weakening the source semantics enough that expected mixture loss counts without producing a high-probability deterministic weak hypothesis or an efficiently certifiable orientation. Under ordinary high-probability PAC semantics for randomized algorithms, the same validation and hidden-gap obstructions reappear.

### Theorem A: Bounded Weak-Gap Exponents Imply The Target

**Statement.** Suppose the source learner $A$ has the usual marginal-nonuniform weak agnostic proper guarantee, and suppose in addition that there is one polynomial $r$ such that for every marginal $Q$, every realizable target $c\in\mathcal C$, and every relevant size $s$,

$$
\operatorname{err}_Q(A,c)\le \frac12-\frac1{r(s)}.
$$

Then $\mathcal C$ satisfies efficient realizable improper PAC learning.

**Proof sketch.** Full-support finite-transcript uniformization gives a distribution-free polynomial bound for one call to $A$. The extra assumption gives the missing quantitative weak edge for every marginal the booster may induce. On realizable labels, $A$ is therefore a distribution-free weak proper learner with inverse-polynomial advantage. Schapire/Freund boosting converts it into a strong learner with sample and time polynomial in $s$, $1/\varepsilon$, and $\log(1/\delta)$. The final majority vote is allowed because the target is improper.

**Atlas use.** This is the safest conditional-positive note to add later: the present edge is blocked exactly by the absence of this uniform weak-gap envelope.

### Theorem B: Size-Indexed Marginal Semantics Also Make The Edge True

**Statement.** Change the marginal-nonuniform schema so that a marginal is a size-indexed family $P=(P_s)_{s\ge 1}$, and the learning guarantee at size $s$ is evaluated under $P_s$ with full mass. Under this semantics, the source guarantee forces a distribution-free inverse-polynomial weak-gap envelope, hence Theorem A applies.

**Proof sketch.** Assume no uniform weak-gap envelope exists. For each exponent $d$, choose a size $s_d$, a marginal $Q_d$ on that size, and a realizable target $c_d$ on which $A$'s advantage is below $s_d^{-d}$. Choose the $s_d$ increasing fast enough to absorb constants. Define one size-indexed marginal family by setting $P_{s_d}=Q_d$ and filling other sizes arbitrarily.

The source guarantee for this single family $P$ supplies one marginal-dependent polynomial, say bounded by $C s^D$, and hence a weak gap at least $1/(C s^D)$ on all selected sizes. Taking $d>D$ and $s_d$ sufficiently large contradicts the choice of $Q_d$. Thus the bad exponents cannot be unbounded. The resulting uniform weak-gap envelope feeds into Theorem A.

**Why this does not prove the current edge.** The current atlas uses one global marginal distribution over instances. Replacing the size-indexed family by a global mixture

$$
P=\sum_j w_j Q_j
$$

dilutes the bad component $Q_j$ to mass $w_j$. A weak learner can obtain a global edge by handling a high-mass prefix or a default tail, without learning the bad component with full local advantage. This is the exact place where the size-indexed proof stops applying.

### Current Semantics: Open, Not False

Under the current source node, the learner is one uniform algorithm, but only the polynomial resource bound and weak gap may depend on the marginal. The full-support transcript argument controls the cost of one weak call, but it does not control the advantage:

$$
\forall P\ \exists k(P)\quad \gamma_P(s)\ge s^{-k(P)}
$$

does not become

$$
\exists k\ \forall P\quad \gamma_P(s)\ge s^{-k}.
$$

The previous branches give three no-go diagnostics for proving more:

- Fixed-size compactness can give a positive minimum gap only at one fixed scale, with no polynomial relation across sizes.
- Validation or candidate selection at advantage $\gamma$ costs $\Omega(\gamma^{-2})$ labeled samples, so hidden exponents cannot be discovered uniformly.
- Properness, agnosticism, repeated calls, disagreement tests, residual learning, and non-black-box transcript inspection still need either a gap certificate, closure structure, or a new marginal whose weak gap is again hidden.

The false-witness search also failed for a principled reason. Standard cryptographic and distribution-specific hardness candidates tend to be hard even for weak prediction on the bad marginal, so they violate the source. Proper-hardness gadgets tend to become target-positive once improper strong learning is allowed. A valid counterexample would need a new computationally nonboostable proper weak-handle class: every marginal admits an easy proper weak handle, but no uniform polynomial-time improper learner can assemble enough handles for strong realizable prediction.

### Stochastic/Output-Mixture Fork

The stochastic/output-mixture idea should be treated as a separate semantics, not as evidence that the current edge is false.

The false-looking version weakens the source as follows: instead of requiring a high-probability deterministic proper hypothesis $h\in\mathcal C$, the learner may output a randomized mixture over proper hypotheses, and the weak guarantee is measured as expected mixture loss. If the mixture is allowed to carry a tiny marginal-dependent bias without producing a certifiably oriented deterministic component, rare-slice or time-hierarchy constructions become much easier to imagine. Under an additional hardness assumption, one would try to make each slice weakly source-positive through a stochastic handle with advantage about $s^{-j}$, while making strong deterministic improper learning solve the hard residual on infinitely many slices.

This is only a conditional false schema, not an atlas theorem. It depends on a changed success criterion. If the randomized output must itself satisfy the usual high-probability PAC guarantee, then estimating the orientation of a bias $\gamma$ again costs $\Omega(\gamma^{-2})$. If the target also permits comparable stochastic mixtures, then the apparent separation may disappear because the target can inherit the same randomized handles. Thus the stochastic fork is best recorded, if at all, as a warning about schema design: expected-mixture weak learning can be strictly weaker than deterministic proper weak learning and may admit artificial nonboostability.

### Suggested Atlas Incorporation

For the current implication note, keep:

```yaml
status: "open"
evidence: unknown
family: marginal-boosting-open
```

A sharper summary would be:

> Open under the current global-marginal deterministic-output semantics. The edge would become true with a distribution-free inverse-polynomial weak-gap envelope, and it would also become true under size-indexed marginal semantics by diagonalizing bad gap exponents. Global mixtures block that diagonal because low-mass bad slices can be ignored by a weak learner. False-witness searches remain inconclusive: known hard classes usually fail the weak source, while proper-hardness gadgets usually satisfy the improper target. Stochastic expected-mixture variants are a separate model fork, not a counterexample to this edge.

For a linked argument note, consider adding a separate lemma named `weak-gap-uniformization-open` with two subclaims:

- `bounded-gap-conditional-true`: uniform inverse-polynomial weak gaps plus standard boosting prove the target.
- `size-indexed-conditional-true`: full-mass size-indexed marginals diagonalize unbounded weak-gap exponents.

The stochastic/output-mixture observation should be phrased only as a model caveat unless a concrete source-positive, target-negative class is later constructed.

### Final Depth-6 Verdict

The final synthesis supports conditional theorem statements around the current edge, but it does not resolve the edge itself. The atlas should not mark the implication true without adding a weak-gap envelope or size-indexed semantics, and it should not mark the implication false without a deterministic source-positive, target-negative witness.

VERDICT: conditional-only

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`

## Depth 7 Final Consolidation

- date: 2026-05-07
- branch: final allowed consolidation for this edge
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Final Verdict

The edge remains unresolved under the current atlas semantics.

The source gives one uniform algorithm and, by the full-support finite-transcript argument, one can control the pathwise cost of a single call to that algorithm. What remains missing is a distribution-free quantitative lower bound on the weak advantage. The source supplies

$$
\forall P\ \exists r_P\quad \gamma_P(s)\ge 1/r_P(s),
$$

while a distribution-free boosted realizable learner needs, directly or indirectly,

$$
\exists r\ \forall Q\quad \gamma_Q(s)\ge 1/r(s)
$$

for the marginals $Q$ on which weak hypotheses are requested. No argument found in this depth-limited search justifies that quantifier swap for global marginals, and no concrete source-positive, target-negative deterministic witness was found.

### Conditional True Statements

**Uniform weak-gap envelope.** If the source were strengthened so that the marginal-dependent weak gaps are dominated below by one inverse polynomial independent of the marginal, then the implication would be true. Full-support resource uniformization gives a distribution-free polynomial bound for one weak call. On realizable labels, the weak agnostic proper learner becomes a weak realizable proper learner with a distribution-free inverse-polynomial advantage. Schapire/Freund boosting then gives an efficient strong realizable learner, and the final vote is permitted by the improper target.

**Size-indexed marginal semantics.** If the atlas interpreted a marginal as a size-indexed family $P=(P_s)_{s\ge 1}$ evaluated with full mass at each size, the edge would also become true. If no uniform weak-gap envelope existed, one could choose bad triples $(s_d,Q_d,c_d)$ with advantage below $s_d^{-d}$, stitch them into a single size-indexed marginal by setting $P_{s_d}=Q_d$, and contradict the marginal-dependent polynomial promised for that one $P$. This diagonal fails for the current global-marginal semantics because a mixture $\sum_d w_d Q_d$ dilutes each bad component to mass $w_d$.

**Local-uniformity fork.** A weaker conditional positive route would be enough if, for every original marginal $P$, all booster-induced marginals generated from $P$ had weak-gap polynomials bounded by one polynomial depending only on $P$. That would prove at least the marginal-nonuniform strong target and might help with distribution-free variants if the original-marginal polynomial could then be uniformized. The current source definition contains no such stability or bounded-density assumption.

### Failed Counterexample Routes

**Cryptographic hard marginals.** PRF, Kearns-Valiant, and distribution-specific cryptographic hardness classes are target-negative-looking, but they generally rule out weak prediction on the hard marginal. They therefore fail the source rather than separating the edge.

**Proper-hardness gadgets.** Clause-satisfaction, PCP active-slice, and one-way image-coordinate handle constructions separate proper from improper or weak proper from strong proper variants. They do not refute this edge because the target is improper: polynomial-size active slices can be memorized or handled by lookup-style improper hypotheses, and bounded weak handles that certify the source tend to be aggregable by an improper learner.

**Rare-slice/time-hierarchy templates.** These can produce hidden exponents such as $\gamma_{P_j}(s)\approx s^{-j}$ in thought experiments, but they have not supplied a valid deterministic source learner. If the weak handle requires choosing the sign of a bias of size $s^{-j}$, orientation testing costs about $s^{2j}$ samples, contradicting the uniform pathwise bound forced by the full-support marginal. If the construction avoids orientation by using stochastic mixtures or marginal advice, it changes the atlas semantics.

**SQ and membership-query weak/strong separations.** Fixed-distribution SQ theory gives genuine weak/strong separation phenomena, but SQ lower bounds and membership-query upper bounds do not imply ordinary PAC target failure. They remain diagnostic analogies rather than atlas witnesses.

### Exact Obstacle

The exact obstacle is not sample complexity and not the runtime of one source call. The sample-only implication is already true via finite VC/marginal-nonuniform trichotomy, and one source call can be pathwise resource-uniformized.

The obstacle is the absence of an efficiently usable weak-gap certificate or envelope. Boosting, validation, candidate selection, and residual focusing all need quantitative access to the advantage scale. Distinguishing error $1/2$ from $1/2-\gamma$ costs $\Omega(\gamma^{-2})$ labeled samples, so a hidden marginal exponent $k(P)$ cannot be discovered within a distribution-free polynomial budget. Same-marginal agnostic relabeling does not remove the problem: with labels satisfying $\mathbb E[Y\mid X=x]=a(x)c(x)$, the fixed-additive guarantee only forces useful correlation when $\mathbb E_P a>1-2\gamma_P(s)$, which is too close to full mass to simulate arbitrary residual focusing.

Thus a proof still needs a real weak-gap uniformization theorem for current global marginals, and a disproof still needs a deterministic source-positive class whose proper weak handles are easy under every marginal but computationally impossible to assemble into a uniform polynomial-time improper strong learner.

### Proposed Atlas Summary Text

Suggested replacement summary if the atlas note is refreshed:

> Open under the current global-marginal deterministic-output semantics. Full-support transcript uniformization controls the sample/time cost of one weak call, but the source gives only marginal-dependent weak advantages. The implication would be true with a distribution-free inverse-polynomial weak-gap envelope, and it would also be true under size-indexed marginal semantics by diagonalizing bad gap exponents. For global mixtures, low-mass bad slices can be ignored by a weak learner, so the diagonal fails. Known hard classes either fail the weak source or become learnable by improper lookup/aggregation.

### Proposed Atlas Body Text

```markdown
## Verdict

`open`.

The source specializes on realizable labels to a proper weak learner with advantage $\gamma_P(s)>0$ for each marginal $P$, where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial. Under the atlas worst-case finite-transcript convention, a full-support reference marginal gives one distribution-free polynomial bound for the runtime and sample use of a single call to the source learner. This does not uniformize the advantage.

If there were one polynomial $r$ with $\gamma_Q(s)\ge 1/r(s)$ for every marginal $Q$ requested during boosting, Schapire/Freund boosting would prove the target: the final majority vote is an allowed improper hypothesis. The source only gives $\forall Q\,\exists r_Q$, and no theorem is known that swaps these quantifiers for current global marginals.

A size-indexed marginal semantics would make the edge true by diagonalization: bad weak-gap exponents at sizes $s_d$ could be stitched into one marginal family evaluated with full mass at those sizes, contradicting the source polynomial for that family. The current global-mixture semantics blocks this proof because each bad component can be assigned small mass and ignored by an additive weak guarantee.

Known counterexample templates do not settle the edge. Cryptographic hard marginals are usually hard even for weak prediction, so they violate the source. Proper-hardness and active-slice gadgets tend to satisfy the improper target by memorization or lookup. Rare-slice hidden-gap constructions still need deterministic, orientation-free weak handles that work for every marginal.

Therefore the edge remains open. A proof would require weak-gap uniformization or a stable original-marginal boosting theorem; a counterexample would require a source-positive, target-negative class with computationally nonboostable proper weak handles.
```

### Final Recommendation

Keep the atlas edge as `status: "open"` and `evidence: unknown`. If this scratchpad is mined into atlas notes, the cleanest reusable abstraction is a separate `weak-gap-uniformization-open` argument recording the bounded-gap and size-indexed conditional true statements, plus the global-mixture obstruction.

VERDICT: unresolved

Scratchpad: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
