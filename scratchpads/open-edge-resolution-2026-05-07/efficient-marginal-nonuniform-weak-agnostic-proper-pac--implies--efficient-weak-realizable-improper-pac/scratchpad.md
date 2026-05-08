# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-weak-realizable-improper-pac

- date: 2026-05-07
- depth: 1 of 7
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-weak-realizable-improper-pac`
- constraint: scratchpad only; no atlas files, legacy LaTeX, or `references.bib` edited
- status investigated: currently `open`

## Verdict

Unresolved.

I do not see an atlas-ready proof or counterexample under the current global-marginal semantics. The edge reduces cleanly to the same weak-gap uniformization problem recorded in the current edge note and in the 2026-05-05 exact scratchpad:

$$
\forall P\ \exists k(P):\quad \gamma_P(s)\ge s^{-k(P)}
\qquad\text{does not currently yield}\qquad
\exists k\ \forall P:\quad \gamma_P(s)\ge s^{-k}.
$$

Full-support transcript uniformization handles the one-call sample/time resource bound for the single source learner. It does not provide a marginal-independent lower envelope for the weak advantage. Properness is harmless for the positive direction, since a proper output is legal for the improper target, but it makes false witnesses harder because any public proper handle available to the source is also available to the target.

## Files And Sources Read

- `atlas/README.md`
- `atlas/registry/axes.yml`
- `atlas/registry/edge_families.yml`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/unrestricted-labelings.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- prior exact scratchpad: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- no prior exact 2026-05-04 scratchpad was found
- primary source pages checked:
  - Benedek and Itai, "Learnability with respect to fixed distributions," Theoretical Computer Science 1991, DOI page: https://doi.org/10.1016/0304-3975(91)90026-X
  - Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability," OpenReview: https://openreview.net/forum?id=aoVCFtox89

The OpenReview page states the relevant marginal-nonuniform quantifier: rates may depend on the marginal distribution but must hold uniformly over target concepts once the marginal is fixed. The ScienceDirect abstract for Benedek-Itai confirms the fixed-distribution learning lineage and its sample-complexity, rather than general efficient-computation, focus.

## Reduction

Let `A` be the source learner. For every instance marginal `P`, the source supplies a marginal-dependent polynomial resource bound and a weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s),
$$

where `1/gamma_P(s)` is bounded by a polynomial whose degree may depend on `P`. For every joint distribution with marginal `P`,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+1/2-\gamma_P(s),
\qquad h\in\mathcal C.
$$

On realizable labels `Y=c(X)`, the optimum proper error is zero. Therefore the same learner gives

$$
\operatorname{err}_{P}(h,c)\le 1/2-\gamma_P(s).
$$

The target is improper, so this proper `h` is admissible. Thus the edge is not blocked by agnosticism or properness. It is blocked only by the missing uniform weak gap required by the distribution-free weak target.

## What Is Already Uniformized

Under the atlas pathwise transcript convention, the full-support argument gives one distribution-free sample/time polynomial for this same learner. Choose a full-support reference marginal `P^star`. The source guarantee at `P^star` bounds `A` on every finite labeled transcript that can occur under any marginal, because each such transcript has positive probability under a suitable labeling of `P^star`.

This is enough for resources. It is not enough for accuracy. The accuracy statement must be applied at the actual target marginal `P`, and it only gives `gamma_P`.

## Positive Attempts

### Composition Through A Neighboring Edge

The edge

```text
efficient-marginal-nonuniform-weak-agnostic-proper-pac
-> efficient-marginal-nonuniform-weak-realizable-proper-pac
```

is true by monotone relaxation. Composing with

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
-> efficient-weak-realizable-improper-pac
```

would prove the assigned edge, but that second edge is itself open for the same weak-gap reason.

### Strong-Source Argument

Nearby strong marginal-nonuniform sources can imply weak distribution-free targets by running the strong learner at a fixed accuracy such as `1/4`, then using full-support transcript uniformization for resources. This does not apply here because the source is already weak and has no accuracy parameter that lets us choose a fixed gap.

### Validation Or Guessing The Gap

One can search over guessed exponents up to a fixed cutoff `D` and validate candidate hypotheses at scale about `s^{-D}` using `s^{O(D)}` samples. This proves only a bounded-exponent fragment:

> If every marginal's hidden weak exponent is at most `D`, then a distribution-free weak learner with exponent depending on `D` follows.

The atlas source has no such bounded-exponent premise.

### Diagonal Mixtures

A tempting positive proof is to assume no uniform exponent, pick bad marginals `P_k`, and stitch them into one global marginal. This still fails under the current atlas semantics for two reasons.

First, weak error is averaged under the global marginal. Bad behavior on a low-mass component may be hidden below the weak gap promised for the stitched marginal.

Second, an abstract concept class need not let us stitch the corresponding bad target concepts into one compatible concept. Without a disjoint-union closure condition or size-conditional risk semantics, this diagonal route is not a theorem.

### Sample-Only Collapse

The Hanneke-Moran-Thiessen marginal-nonuniform trichotomy supports the atlas's sample-only collapses: polynomial marginal-nonuniform sample rates imply ordinary sample-efficient learnability in the relevant binary PAC layer. This does not resolve the current edge, because the target is computationally efficient. The `sample-to-computational-hardness` note records PRF-style separations showing that unbounded ERM/sample learnability cannot be promoted to efficient weak learnability in general.

## Counterexample Search

### PRF Classes

Pseudorandom-function classes are target-negative under standard cryptographic assumptions, but they are not source-positive. On the hard marginal, a marginal-nonuniform weak agnostic proper learner with even a tiny inverse-polynomial advantage would already give a weak predictor and hence a distinguisher.

### Halfspaces

Halfspaces do not separate this edge. They are target-positive in the realizable weak improper sense, since realizable halfspaces are efficiently learnable by linear feasibility. Their hardness is agnostic, not weak realizable.

### Clause-Satisfaction Lookup And PCP Active-Slice Classes

These witnesses separate proper from improper learning or strong proper recovery from weak/improper lookup. The assigned target is weak and improper, so the lookup-style improper learner is allowed. They do not refute the target.

### One-Way Image-Coordinate Weak Handles

The weak-handle witness is useful for marginal proper strong-learning hardness, but it does not refute this weak improper target. The handles that make a proper weak source plausible are themselves legal improper outputs. If they are public and efficiently findable enough for the source, the target can reuse them.

### Rare-Block Hidden-Gap Hierarchies

The most plausible false-witness shape is a hierarchy of blocks with level-dependent advantages `s^{-k}`. For every fixed distribution-free exponent, a high enough block could defeat that target advantage, while each fixed marginal might still admit some inverse-polynomial advantage with a marginal-dependent exponent.

The source-positive side remains unverified. If the source learner must sample or validate a handle at the hidden scale `s^{-k}`, then full-support transcript uniformization rules it out: one global pathwise polynomial cannot cover unbounded `k`. If the handle is orientation-free and public enough to avoid validation, it tends to be reusable by the improper target. If a cryptographic residual is added, marginals concentrating on the residual usually make the agnostic proper source fail.

So I do not have a concrete represented class satisfying the source while refuting the target.

## Current Obstacles

1. A proof needs a weak-gap uniformization theorem for one bounded-transcript learner:

   > Every single learner satisfying marginal-nonuniform weak agnostic proper learning has realizable weak advantages with one inverse-polynomial lower envelope independent of the marginal.

   I do not see a proof under global marginals, and prior finite-output/transcript compactness attempts only give fixed-size positivity, not a polynomial envelope over representation sizes.

2. A counterexample needs a calibrated hidden-gap hierarchy:

   > There is one pathwise-polynomial proper weak agnostic learner whose per-marginal advantages are inverse-polynomial with unbounded marginal-dependent exponents, while every polynomial-time improper learner fails every fixed distribution-free inverse-polynomial advantage on some realizable marginal.

   Existing PRF, one-way, lookup, and rare-block templates fail at least one side of this requirement.

3. The model boundary matters. Under a stronger size-conditional marginal semantics or with a closure assumption allowing bad concepts/marginals to be stitched without dilution, a diagonal positive theorem might become plausible. The current atlas notes use global marginals and explicitly separate resource transfer from accuracy transfer.

## Promising Follow-Ups

- Formalize a bounded-exponent theorem: if `sup_P k(P) <= K`, the edge is true with target advantage `s^{-O(K)}`.
- Decide whether the atlas wants a separate family such as `weak-gap-uniformization-open` for weak-to-weak marginal-to-distribution-free edges whose resources are already handled by full-support transcript uniformization.
- Search specifically for orientation-free proper weak handles that are source-usable with one pathwise polynomial but not reusable by improper learners.
- Investigate whether additional representation closure, disjoint-union, or size-conditional-risk assumptions allow the diagonal mixture argument to become a theorem.

## Final

VERDICT: unresolved

The edge should remain open under current atlas semantics. The cleanest current description is: full-support transcript uniformization handles resources, but no known theorem or witness resolves the marginal-dependent weak-gap exponent.

## Depth 2 Branch A: Rare-Block Hidden-Gap Hierarchy

- date: 2026-05-07
- branch: rare-block hidden-gap hierarchy for weak-gap uniformization
- constraint: scratchpad-only follow-up; no atlas files or `references.bib` edited

### Branch Goal

Try to build or rule out a represented class with the following shape:

1. One pathwise-polynomial learner is an efficient marginal-nonuniform weak agnostic proper learner.
2. For fixed marginals, its weak advantage may be only `s^{-k(P)}`, with unbounded exponents `k(P)`.
3. Every distribution-free polynomial-time improper weak realizable learner fails some realizable marginal at every fixed inverse-polynomial target advantage.

The useful false-witness geometry is a rare or huge block: a learner can get a tiny inverse-polynomial edge by memorizing sampled atoms, but no learner can get one fixed distribution-free exponent because a high enough block makes the sample-covered mass too small.

### Sharper Candidate: Paired Hidden Blocks

The most promising version is not a singleton-positive block, but a paired block. For size parameter `n` and level `j`, let

$$
B_{n,j} = [N]\times\{0,1\},\qquad N=n^j .
$$

A hard concept keyed by a pseudorandom function has exactly one positive point in each pair:

$$
c_k(u,b)=1 \quad\text{iff}\quad b=F_k(u),
$$

on the active block, and is a fixed default off the active block. Add proper handle concepts that store finitely many oriented pairs and use a default value elsewhere. A labeled example from a pair reveals the orientation of that pair for a realizable hard concept. The handle can then label both points in that pair correctly.

This removes the earlier default-orientation problem. The source learner does not need to determine whether the whole block has positive mass `1/2 + eta` or `1/2 - eta`; every pair is locally balanced. A sample from a pair gives an orientation-free proper correction.

On the uniform marginal over `B_{n,j}`, a learner taking `m=n^a` samples and outputting the finite-pair handle gets realizable advantage roughly

$$
\gamma_{n,j}(n) \asymp \frac{m}{N} = n^{a-j}
$$

up to constants and collisions. For each fixed block level `j`, this is still inverse-polynomial in `n`, but the exponent is unbounded as `j` increases.

### Target-Negative Side

The target lower bound would use the usual PRF logic. Fix any distribution-free improper learner whose running time and sample use are at most `n^a`, and fix any claimed weak exponent `K`. Choose `j` much larger than `a+K`. Under the uniform marginal on `B_{n,j}`, the learner sees only an `n^a/N` fraction of the pairs. On fresh unseen pairs, any additional prediction advantage would distinguish the pseudorandom orientations from random orientations.

Thus, under standard PRF assumptions and the convention that improper outputs are polynomial-time evaluable, the learner's advantage should be bounded by

$$
O(n^a/N) + \operatorname{negl}(n),
$$

which is below `n^{-K}` for high enough `j`.

The fact that an improper learner can reuse the public finite-pair handles is not by itself fatal to the counterexample. Reusing the same sampled-pair handles gives only the hidden advantage `n^{a-j}`. That is enough for the marginal-nonuniform source at fixed `j`, but not enough for the distribution-free target with one fixed exponent.

What would be fatal is any public orientation-free handle with mass or correlation bounded below by `n^{-K0}` independent of `j`. Such a handle would immediately give the improper target a uniform weak learner. The candidate therefore has to keep all public handles local: they correct sampled pairs but do not reveal unseen PRF orientations.

### Source-Positive Side

For realizable labels on a fixed paired block, the source idea is clean:

- sample `m=n^a` examples using one fixed pathwise polynomial;
- store the orientations of sampled pairs;
- output the corresponding proper finite-pair handle;
- obtain advantage on the order of sampled pair mass.

For a marginal concentrated on one high level `j`, the source guarantee may use a polynomial whose exponent depends on that marginal, so the tiny gap `n^{a-j}` is allowed.

Global mixture marginals are not an immediate refutation of the source if each size-`n` hard concept is nontrivial only on its own active block and default elsewhere. A diagonal marginal that puts small masses `mu_n` on increasingly high blocks makes the all-default concept very good for size `n` unless the active block has substantial mass. Thus the usual "choose `j(n)` increasing" diagonal does not automatically force a superpolynomially small source gap under the current global-marginal semantics.

### Remaining Obstruction: Agnostic Proper Learning

The unresolved part is the full agnostic source guarantee. The source must work for every joint label distribution over the same marginal, not just for realizable PRF labels.

The desired lemma would say something like:

> For the paired-block class with finite oriented-pair handles, the sample-handle learner satisfies
> $$
> \operatorname{err}_{\mathcal D}(h)
> \le
> \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)
> + \frac12-\gamma_P(s)
> $$
> for every marginal `P`, with `gamma_P` inverse-polynomial but allowed to have a `P`-dependent exponent.

I do not currently have this lemma. The realizable proof uses sampled labels as reliable pair orientations. In the agnostic setting, noisy positive examples can cause the handle to store a wrong orientation and thereby increase true error on that pair. If we add validation or majority tests to suppress such corruptions, the validation scale appears to depend on the hidden mass `N^{-1}` or on the hidden advantage `m/N`, which would reintroduce the forbidden level-dependent pathwise resource cost.

There is a possible way out: if `OPT` is larger than the hidden gap, the additive tolerance is slack; if `OPT` is smaller than the hidden gap, noisy orientations should be rare enough that the clean sampled-pair mass still wins. But making this uniform over arbitrary marginals with heavy atoms, repeated samples, handle targets, and mixtures is a real proof obligation, not a cosmetic detail.

The properness bookkeeping also needs care. The handle family must be rich enough that the source can output its sampled-pair corrections as proper hypotheses, but not so rich that the agnostic benchmark creates a new hard sparse-lookup problem. This likely can be handled by a sample-compression style argument for finite handles, but I did not close it here.

### Orientation-Free Handle Audit

This branch changes the earlier diagnosis in one useful way. Orientation-free public handles are not automatically disqualifying. They are disqualifying only if they give a uniform inverse-polynomial advantage independent of the hidden block level.

For paired blocks, the handle is orientation-free in the local sense: a single labeled example tells the learner how to orient that pair. An improper learner can reuse exactly this mechanism, but it only learns the pairs it samples. Therefore reuse gives the same hidden gap and does not by itself satisfy the target.

The real obstruction is stronger:

1. Prove that no improper polynomial-time learner can exploit the representation to predict unseen PRF pair orientations.
2. Prove that the proper source learner remains weak agnostic under arbitrary same-marginal label noise without hidden-scale validation.

The first item is a standard cryptographic reduction shape. The second item is the new bottleneck for this exact edge.

### Conditional Outcome If The Missing Lemma Holds

If the agnostic proper source lemma above can be proved, the paired rare-block hierarchy would give a conditional false edge under standard PRF assumptions:

- source-positive: one fixed pathwise-polynomial proper learner gets marginal-dependent weak agnostic gaps by sampled-pair handles;
- target-negative: for every uniform weak exponent and every polynomial-time improper learner, choose a high enough paired PRF block so that sample coverage plus PRF prediction is below the claimed gap.

That would be a genuine weak-gap separation rather than a resource-uniformization separation.

At present, this is not atlas-ready. The missing source lemma is exactly where previous rare-block sketches usually collapse: either one validates at the hidden scale, which violates the pathwise-polynomial source requirement, or one makes the handle so public and strong that the improper target obtains a uniform weak advantage.

### Branch Conclusion

I cannot rule out the rare-block hidden-gap hierarchy. The paired-block version is a sharper near-counterexample because it supplies local orientation-free proper handles and explains why improper reuse need not give a uniform exponent. But I also cannot certify the source node: the agnostic proper guarantee for arbitrary same-marginal labels remains unproved without hidden-scale validation.

The edge therefore remains unresolved from this branch. The precise obstruction is the missing noise-robust agnostic analysis of sampled orientation-free handles, not the realizable target lower-bound geometry.

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Validation-Free Orientation-Free Handles

- date: 2026-05-07
- branch: validation-free orientation-free proper handles
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Branch Question

Can the rare-block route be repaired by making the proper handles genuinely local and orientation-free, so that the marginal-nonuniform weak agnostic proper learner never has to validate a hidden advantage scale?

The desired object is a represented class with three features:

1. Under each fixed marginal, a single pathwise-polynomial proper learner has some inverse-polynomial weak agnostic gap, with the exponent allowed to depend on the marginal.
2. The learner gets this gap from local handles whose orientation is read directly from observed labels, not from a global bias or validation test at scale `1/N`.
3. Any distribution-free polynomial-time improper realizable learner still has no fixed inverse-polynomial advantage, because on a high rare block it can only learn sampled local handles and cannot predict unseen orientations.

I do not have such a construction. The closest candidate is sharper than the depth-2 sketch, but it still needs a nontrivial agnostic self-damping lemma that I cannot prove from the present atlas assumptions.

### Candidate 1: One-Sample Paired Handles

Use paired blocks

$$
B_{n,j}=[N]\times\{0,1\},\qquad N=n^j,
$$

and hard concepts

$$
c_f(u,b)=1 \quad\text{iff}\quad b=f(u),
$$

where `f` is pseudorandom or otherwise computationally hidden. Add proper finite-handle concepts that use a default value, say `0`, and store finitely many oriented pairs. A labeled example from pair `u` determines the local orientation in the realizable case: if the sample is labeled `1`, that atom is the positive atom; if it is labeled `0`, the other atom is the positive atom. No global default-orientation decision is needed.

On the uniform marginal over `B_{n,j}`, a learner using `m=n^a` examples and outputting the union of sampled pair corrections gets clean realizable advantage roughly

$$
\gamma_{n,j}(n)\asymp \frac{m}{N}=n^{a-j},
$$

up to constants and collisions. For every fixed level `j`, this is still inverse-polynomial. The exponent is unbounded as `j` grows, which is exactly the hidden-gap geometry needed to refute the distribution-free target.

The target-negative side remains plausible under standard PRF reasoning. A polynomial-time improper learner using `T=n^b` samples can copy orientations on sampled pairs, but on unsampled pairs any extra advantage would predict `f`. Thus its advantage is bounded by

$$
O(T/N)+\operatorname{negl}(n).
$$

Given any claimed distribution-free gap `n^{-K}`, choose `j>b+K` and the sampled-pair advantage falls below the target gap. The fact that the target learner may reuse the same local handles is not fatal; reuse only gives the hidden local coverage advantage.

### Why This Still Does Not Prove The Source

The source is weak agnostic proper, not merely weak realizable proper. For every joint distribution with marginal `P`, the output must satisfy

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s).
$$

There is a tempting low-noise split. If `OPT >= gamma_P`, then a best constant classifier is already within `OPT + 1/2 - gamma_P`. If `OPT < gamma_P`, labels are close to some concept `c^star`, so local orientations sampled from the data should usually be correct. This suggests that validation might be avoidable: use a default-plus-local-corrections hypothesis, and let the low-noise condition make wrong local corrections rare.

The gap is that this has to be a theorem for arbitrary same-marginal agnostic labels, arbitrary heavy atoms, mixtures of blocks, and arbitrary best proper concepts, including the added handle concepts themselves. A noisy local orientation can create a false correction whose risk cost is on the same order as the clean correction it was meant to buy. Without validation, the proof must show a self-damping inequality of the following kind:

$$
\text{expected harm from wrong local handles}
\le
O(\operatorname{OPT}_{\mathcal C}(\mathcal D))
\quad\text{while}\quad
\text{clean local gain}\ge \Omega(\text{covered signal mass}).
$$

For the paired PRF concepts this may be true in some balanced low-noise regimes, but I do not see a proof for the whole source node. The source learner also has to choose or bake in the neutralizer: constants suffice in high-OPT cases, but a handle-rich proper output must not overfit random or middle-noise labels so badly that it loses the slack supplied by `OPT`.

Using a fresh validation set to select among constants and sampled handles would solve the selector issue only by testing at the hidden advantage scale. On a level-`j` block that costs on the order of

$$
\gamma_{n,j}(n)^{-2}=n^{2(j-a)},
$$

which violates the fixed pathwise polynomial resource bound once `j` is unbounded. So the candidate needs a validation-free structural proof, not an empirical selector.

### Candidate 2: Two-Sided Collision Handles

A stricter local handle only orients a pair after seeing both atoms in that pair with complementary labels. This removes much of the one-sample wrong-orientation anxiety. In the clean uniform block, the advantage drops to the birthday scale

$$
\gamma_{n,j}^{\mathrm{coll}}(n)\asymp \frac{m^2}{N}=n^{2a-j},
$$

again inverse-polynomial for each fixed `j` and with unbounded exponent as `j` grows. The target-negative PRF argument still goes through, since an improper learner can find only polynomially many local collisions on a sufficiently large block and still cannot infer unseen orientations.

This repair also fails to close the source proof. Collision handles are safer but sparser. On unbalanced marginals, informative complementary collisions may be much rarer than the local mass that the weak gap is supposed to exploit. Under agnostic labels, complementary noisy collisions can still create wrong handles. Requiring repeated confirmations per pair would again cost at the hidden pair-mass scale. Most importantly, the source guarantee is relative to the best proper concept in the expanded class, not just to the PRF concepts. A collision-only learner has no evident reason to be within `OPT + 1/2 - gamma_P` for distributions where the best comparator is itself a finite handle supported on a small but important part of the marginal.

Thus collision handles trade orientation risk for coverage risk; they do not remove the need for a general agnostic analysis.

### Trilemma For Local Proper Handles

The branch leaves a useful trilemma.

**Level-independent handles make the target positive.** If the proper handle family contains a public, efficiently findable handle with inverse-polynomial correlation bounded below independently of the hidden block level, then the improper target can output or aggregate that same handle. This destroys the desired separation.

**Purely local handles keep the target negative but make the source hard.** If handles reveal only sampled local information, the target lower bound is plausible: high blocks hide almost all orientations. But then the agnostic source has to trust noisy local labels without certifying their true advantage. The needed self-damping lemma is not part of the current atlas toolkit.

**Validation repairs the source but violates the branch.** Empirical selection among constants, one-sample handles, collision handles, and other finite handles needs samples polynomial in the inverse of the true weak gap. For hidden gaps `n^{-k(P)}` with unbounded `k(P)`, this is exactly the forbidden hidden-scale validation.

### Barrier Statement

I can rule out the naive hope that "orientation-free" alone solves the rare-block construction. It solves only the realizable default-orientation problem. The full weak agnostic proper source additionally needs a validation-free selector or a structural monotonicity theorem saying that local corrections cannot hurt more than the `OPT` slack while they retain an inverse-polynomial clean gain under every fixed marginal.

No such theorem is currently established here. Conversely, I also do not have a counterexample showing that all validation-free local-handle schemes fail. The one-sample and collision variants remain plausible conditional templates for a false edge under PRF assumptions, but only if the missing agnostic self-damping/selector lemma can be proved.

So this branch does not resolve the implication. It sharpens the barrier: a successful false witness needs more than local orientation-free proper handles; it needs local handles whose agnostic performance is certified by construction, not by hidden-scale validation, while still exposing no level-independent handle reusable by an improper distribution-free learner.

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 4 Branch A: Validation-Free Self-Damping Selector

- date: 2026-05-07
- branch: validation-free self-damping/selector lemma
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Branch Goal

Test the remaining false-witness route from Depths 2 and 3.

The desired counterexample would use high paired blocks with local handles. A fixed-polynomial learner would learn only the sampled coordinates, giving a weak advantage of order `m/N` on a level with `N` pairs. For every fixed marginal this can be inverse-polynomial with a marginal-dependent exponent, while a distribution-free target with one fixed exponent can be defeated by choosing `N` much larger than its sample budget.

The missing source lemma is stronger:

> A validation-free proper learner should select local orientation-free handles under arbitrary marginals and arbitrary agnostic label noise, without spending samples at the hidden scale `N/m` or `1/gamma_P`.

This branch asks whether a self-damping argument proves that lemma, or whether the selector problem is a real barrier.

### Restricted Selector Lower Bound

The following restricted theorem rules out the cleanest validation-free selector. It is not a full impossibility theorem for every possible proper extension, but it captures exactly the two-orientation local-handle schemes used in the rare-block template.

**Theorem.** Fix a paired block

$$
B_N=[N]\times\{0,1\}
$$

and a realizable target

$$
c_f(u,b)=1\{b=f(u)\}.
$$

Let `d` be a balanced default, meaning that `d` labels exactly one atom in each pair positive. Consider an `m`-sample learner whose output is either `d` or its complement `\bar d` on all unsampled pairs, plus arbitrary correct local corrections on sampled pairs. Suppose the marginal is almost uniform over pairs, so the total mass of all sampled pairs is at most `O(m/N)` with high probability. Then for `N >> m^2`, no such learner can, with high constant probability, achieve error below `1/2` on every realizable marginal over this block.

**Proof.** Let

$$
A=\{u:d(u)=f(u)\}.
$$

Choose two coordinate marginals. Under `P_+`, the set `A` has mass `1/2+\eta`; under `P_-`, it has mass `1/2-\eta`. Inside `A` and its complement distribute mass nearly uniformly across coordinates, and within each coordinate place the mass on the two atoms in any fixed way compatible with the realizable labels. Then `d` has error `1/2-\eta` under `P_+` and error `1/2+\eta` under `P_-`; the complement has the opposite errors.

The transcript distributions from `m` samples have total variation at most `O(m eta)`. Taking

$$
\eta=Cm/N
$$

with `C` larger than the local-correction constant and `N >> m^2`, the two transcript laws are still `o(1)` apart. Hence no selector can identify whether it is seeing `P_+` or `P_-` with high constant advantage.

On the other hand, if the selector chooses the wrong default, the sampled local corrections change error by only `O(m/N)`, while the wrong default is worse than random by `eta`. With the above constant `C`, the final error remains strictly above `1/2`. Since the labels are realizable, `OPT=0`; the source would require error at most `1/2-gamma_P(s)` for some positive inverse-polynomial `gamma_P`. Thus even making `gamma_P` arbitrarily small cannot save the wrong orientation. The learner must choose the right orientation, but hidden-scale validation is exactly what is needed to do that. QED.

The same argument applies to all-zero/all-one defaults by taking `A` to be the positive side of the target and tilting its mass to `1/2 +/- eta`. It also applies to one-sample pair handles and collision handles, because they only change the `O(m/N)` corrected mass term. Collision handles reduce orientation mistakes on sampled pairs, but they do not neutralize the deterministic default on unsampled pairs.

### Why Self-Damping Does Not Close The Source Lemma

The natural self-damping proof plan is:

1. If `OPT` is large, constants already satisfy the weak agnostic additive bound.
2. If `OPT` is small, sampled local labels are usually reliable, so wrong local handles should be charged to `OPT`.
3. Therefore no hidden-scale validation should be needed.

The lower bound above blocks this plan before agnostic noise enters. It uses realizable labels, so `OPT=0`. There is no noise budget to charge. The only failure is that an ordinary deterministic proper hypothesis must say something on the unseen pairs. A wrong unseen default has error above `1/2`, and sparse local corrections cannot self-damp that global orientation error.

This is the main distinction between local orientation and global selection. A labeled sample really does orient its own pair without validation. But the final proper hypothesis must also select a behavior on all unsampled pairs. Under arbitrary marginals, that unseen behavior is not neutral. A marginal can tilt mass by `eta` toward the side where the chosen default is wrong, with `eta` larger than the mass of sampled corrections but smaller than the learner's statistical resolution.

### Why The Obstruction Is Model-Level

Several apparent repairs change the model or destroy the target lower bound.

**Stochastic neutralization.** If the source could output a stochastic predictor that flips a fair coin on unsampled pairs and uses learned orientations only on sampled pairs, the unseen mass would contribute exactly `1/2` error and sampled pairs would give advantage `Omega(m/N)` in the realizable case. That is a plausible self-damping mechanism, but it is not a proper binary hypothesis in the current atlas node.

**Pair-balanced marginal restrictions.** If every marginal were forced to put equal mass on the two atoms of each pair, balanced defaults could be neutralized. The source and target here quantify over arbitrary marginals, so an adversarial marginal may put all the relevant tilt on one side of each pair.

**A rich public default family.** If the class contains a public, efficiently selectable default with level-independent positive correlation under every marginal, then an improper distribution-free weak learner can reuse the same selector. This removes the target hardness. If the public family has no such selectable correlation, choosing the right default is again a hidden-scale validation problem.

**Adding more proper handles.** Adding finite handles makes local memorization easier, but it also lowers the agnostic benchmark `OPT_C` on distributions where a finite handle is the best comparator. The source proof then has to compete with those handles under arbitrary label noise, not merely with the PRF concepts. This strengthens the selector obligation rather than weakening it.

### Consequence For The Rare-Block Counterexample

The rare-block PRF target lower bound remains plausible under the standard efficient-output evaluator convention: a polynomial-time improper learner sees only `m` of `N` coordinate orientations, and predicting unseen PRF orientations would break pseudorandomness.

What this branch shows is that the matching source-positive proof is still missing. Local orientation-free handles are not enough. They solve the orientation of sampled coordinates, but a deterministic proper output still needs an unseen default, and arbitrary marginals can make default selection as hard as validation at the hidden weak scale.

Thus a real false witness would need one of the following genuinely new ingredients:

1. a deterministic proper neutralizer that has exactly `1/2` error on unseen mass for every marginal, which seems impossible for ordinary binary hypotheses;
2. a selector whose unseen predictions carry real information about the hidden PRF orientation, which threatens the target lower bound;
3. a different construction where the source learner never faces two nearly indistinguishable realizable marginals requiring opposite proper outputs.

I do not currently have any of these.

### Branch Conclusion

This branch gives a precise barrier rather than a full resolution. For the local-handle rare-block strategy, validation-free self-damping fails in the two-orientation setting already on realizable labels. The missing source lemma cannot be proved merely by saying that local handles are orientation-free or that agnostic errors self-damp against `OPT`.

The edge therefore remains open under current atlas semantics. The best current diagnosis is:

$$
\text{local sampled handles can create hidden marginal-dependent weak gaps,}
$$

but

$$
\text{deterministic proper selection of unseen behavior still needs hidden-scale information.}
$$

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Deterministic Versus Stochastic Model Fork

- date: 2026-05-07
- branch: deterministic binary outputs versus stochastic or mixture-valued outputs
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Branch Question

Depth 4 isolated the obstruction for the rare-block handle route: a deterministic proper binary hypothesis must choose labels on unseen pairs. Under arbitrary marginals, that unseen default can be tilted to be worse than random by a hidden amount, while the sampled local corrections have only hidden mass.

This branch asks whether that obstruction is only an artifact of deterministic binary hypotheses. In particular:

1. If the learner may output a stochastic predictor or a mixture-valued hypothesis, does the paired rare-block handle construction become a real counterexample template?
2. Can the current deterministic proper binary semantics simulate that stochastic neutralizer without changing the atlas node?

### Stochastic Or Mixture-Valued Fork

In the paired-block template, let

$$
B_{n,j}=[N]\times\{0,1\},\qquad N=n^j,
$$

and let the hard concepts have one positive atom in each pair:

$$
c_f(u,b)=1\{b=f(u)\}.
$$

After seeing a sample, a local-handle learner knows the orientations of sampled pairs. The stochastic neutralizer is the predictor

$$
q_S(x)=
\begin{cases}
c_f(x), & \text{on sampled pairs whose orientation was observed},\\
1/2, & \text{on unseen pairs}.
\end{cases}
$$

Equivalently, if the proper class contains two complementary finite-handle defaults that agree on the sampled local corrections and are complements off the sampled set, then `q_S` is the half-half mixture of those two proper handles. Evaluated as prediction-time randomized zero-one loss, the unseen mass contributes exactly `1/2` error pointwise, not merely in expectation over a training-time seed.

For realizable labels under the uniform level-`j` block, if `m` samples cover pair-mass `M_S`, then

$$
\operatorname{err}(q_S,c_f)=\frac12(1-M_S),
\qquad
\operatorname{adv}(q_S)=\frac{M_S}{2}.
$$

With `m=n^a` and `N=n^j`, this gives advantage about `n^{a-j}` for fixed `j`, hence an inverse-polynomial gap whose exponent depends on the marginal or level. This is exactly the hidden-gap behavior needed for the marginal-nonuniform source.

The target-negative side survives the same stochastic fork. A distribution-free polynomial-time learner, even if allowed to output a stochastic predictor, can neutralize unseen pairs at `1/2` but cannot get positive correlation there without predicting unseen PRF orientations. With `T=n^b` samples, its advantage on a high uniform block is still bounded by

$$
O(T/N)+\operatorname{negl}(n).
$$

Given any claimed distribution-free weak exponent `K`, choose `j` larger than the learner's sample exponent plus `K`; the sampled coverage falls below `n^{-K}`, and PRF security rules out useful advantage on unsampled pairs.

Thus, under the model fork where hypotheses may be prediction-time stochastic, or where mixture-valued hypotheses are evaluated by their expected randomized loss, the paired rare-block handle route does become a genuine conditional counterexample template. It is conditional in the usual sense: one still formalizes the represented block hierarchy and uses a PRF-style lower bound for unseen orientations. But the specific deterministic unseen-default barrier from Depth 4 disappears.

### A Note On Agnostic Source Semantics

The stochastic fork is especially natural for the weak agnostic source. The all-coin predictor has error exactly `1/2`, so it already satisfies the additive weak-agnostic inequality whenever

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \gamma_P(s).
$$

When `OPT` is below the hidden covered-mass scale, sampled labels are close on average to some proper comparator, and the stochastic local corrections have a plausible self-damping analysis: wrong corrections are charged to `OPT`, while unseen mass remains exactly neutral. This is the argument that failed in the deterministic model because an unseen binary default could be tilted above `1/2` even when `OPT=0`.

For atlas purposes, this should be recorded as a model fork, not as a proof of the current edge. The stochastic proof obligation is standard-looking, but it proves a different node whose outputs are randomized predictors or convex mixtures, not ordinary proper binary concepts.

### Why Deterministic Proper Binary Outputs Cannot Simulate It

The current source definition says the learner must output `h in C`, and the atlas definitions use ordinary binary zero-one loss. Learner randomization is training-time randomization that eventually produces one binary hypothesis. That is weaker than prediction-time stochasticity.

The fair-coin neutralizer is pointwise:

$$
\Pr[\hat Y=1\mid x]=1/2
$$

on each unseen point. A deterministic hypothesis cannot implement this. It must choose `0` or `1` on every unseen atom, and the arbitrary-marginal quantifier can put a hidden tilt on the atoms where that choice is wrong.

Several possible simulations fail for the same reason.

**Randomly choose one complementary default at training time.** The half-half mixture has neutral expected loss, but after the choice is made the output is one deterministic default. The two nearly indistinguishable marginals from Depth 4 require opposite defaults. A random choice is wrong with constant probability on one of them, while PAC success must hold with high probability.

**Use an explicit finite mixture but round it to a binary vote.** If the final object is a majority vote or tie-broken classifier, then it again chooses a deterministic unseen default. The hidden tilt argument applies to the rounded classifier.

**Encode pseudorandom labels on unseen points.** A deterministic pseudorandom default may look balanced under a friendly or uniform marginal, but the source quantifies over arbitrary marginals. A marginal can concentrate or slightly tilt toward the points where the fixed default disagrees with the realizable target. Pointwise neutrality is lost.

**Add both complementary handles to the proper class.** This supplies the two components needed for a mixture, but the current proper learner still has to output one component. Selecting the right component is exactly the hidden-scale orientation problem. If a public selector can choose a level-independent correlated component, then the improper target can reuse it and the rare-block lower bound collapses.

Consequently, deterministic proper binary semantics cannot simulate the stochastic neutralizer unless the atlas adds an actual deterministic neutralizer with exactly `1/2` error on unseen mass for every relevant target and marginal. Under arbitrary binary marginals, such a pointwise neutral deterministic hypothesis is not available.

### Model-Fork Conclusion For Future Atlas Notes

The clean fork is:

- **Current atlas semantics:** outputs are deterministic binary hypotheses; the rare-block handle route is not an atlas-ready counterexample because the source-positive proof fails at unseen default selection, already in the realizable case.
- **Prediction-time stochastic semantics:** the rare-block route becomes a conditional false-witness template. The learner predicts learned orientations on sampled pairs and flips a fair coin on unseen pairs, giving hidden marginal-dependent weak gaps while preserving the PRF target lower bound.
- **Mixture-valued semantics:** same as stochastic semantics if risk is evaluated as expected loss of the mixture on each prediction. Not the same if the mixture is sampled once or rounded to one deterministic classifier.

So if this edge is still unresolved at depth 7, the atlas note should not cite stochastic neutralization as a counterexample to the current edge. It should say that stochastic or convexified hypothesis semantics would likely make the rare-block hidden-gap route false under PRF assumptions, but the present deterministic proper binary model deliberately does not include the pointwise fair-coin operation that the construction needs.

VERDICT: conditional-only

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 6 Branch A: Deterministic Semantics Consolidation

- date: 2026-05-07
- branch: deterministic proper binary semantics consolidation
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, legacy LaTeX files, or `references.bib` edited

### Consolidation Goal

Make one more attempt to decide the edge under the current atlas semantics:

- the source learner outputs an ordinary deterministic binary hypothesis `h in C`;
- learner randomization is training-time randomness only, so each successful run still returns one binary concept;
- zero-one loss is evaluated on that final deterministic concept;
- no prediction-time coin flips, fractional predictions, abstentions, or convex-mixture risks are available.

Under these semantics I still do not have an atlas-ready true proof or false witness. The edge remains a weak-gap uniformization problem with an additional deterministic orientation barrier for the best false-witness templates.

### One More Positive Attempt

The optimistic proof route is:

1. Use full-support transcript uniformization to get one pathwise sample/time polynomial for the single source learner.
2. Restrict the weak agnostic guarantee to realizable labels, so properness and agnosticism disappear: the source output is legal for the improper target and satisfies
   $$
   \operatorname{err}_P(h,c)\le 1/2-\gamma_P(s).
   $$
3. Try to prove that the remaining marginal-dependent gaps have one inverse-polynomial lower envelope.

The third step is still missing. The quantifier pattern is exactly

$$
\forall P\ \exists k(P)
\quad\not\Rightarrow\quad
\exists k_0\ \forall P
$$

without an additional compactness, closure, or bounded-exponent hypothesis. The full-support argument only says that the same finite transcripts are resource-bounded; it does not say that the correlations witnessed under different marginals have a polynomial lower envelope.

A diagonal mixture proof also still fails in the current atlas model. If bad marginals `P_i` are placed into a full-support mixture with small weights `w_i`, a weak error guarantee for the mixture only controls component `i` at scale roughly divided by `w_i`. Low-weight components can hide arbitrarily small gaps. More importantly, an arbitrary concept class need not contain a single target concept that stitches together all componentwise bad concepts. The agnostic source does permit arbitrary label rules, but then the comparator error `OPT_C` may become too large for the weak additive guarantee to force useful componentwise accuracy.

So I cannot turn the deterministic orientation barrier into a positive theorem. It is evidence that sparse-handle counterexamples are hard, not a proof that every source-positive class has a uniform weak gap.

### One More False Attempt: Deterministic Neutralizers

Depth 5 showed that a prediction-time stochastic neutralizer would make the paired rare-block construction look like a conditional false witness. The natural deterministic repair is to replace the fair coin on unseen pairs by a deterministic binary default chosen randomly at training time, for example a public balanced hash or code:

$$
h_{r,S}(u,b)=
\begin{cases}
\text{sampled orientation}, & u\in S,\\
g_r(u,b), & u\notin S.
\end{cases}
$$

This keeps the output deterministic and proper if the class contains these hash-plus-handle concepts. On sampled pairs the learner gets the local hidden gain. On unseen pairs, the random hash is meant to imitate the stochastic `1/2` predictor for each fixed marginal and target.

The obstruction is the discrepancy floor. On a block with `N` nearly equal pair-mass coordinates, even a balanced independent hash has typical correlation fluctuation about

$$
N^{-1/2}.
$$

The sampled-pair gain of a learner using `m=n^a` examples is only

$$
\frac{m}{N}.
$$

For the high levels needed to defeat every distribution-free weak exponent, `N` can be much larger than `m^2`, and then

$$
N^{-1/2}\gg m/N.
$$

Thus the deterministic hash default's uncontrolled sign can dominate the entire hidden local gain. Selecting a favorable seed would require validation at the hidden advantage scale. A public seed or public default strong enough to avoid this validation would be reusable by the distribution-free improper target.

This is not just a two-default artifact. Training-time randomization over many deterministic defaults gives neutrality only in expectation before the final hypothesis is chosen. The PAC guarantee needs high-probability success for the selected deterministic output. Once the output is fixed, an arbitrary marginal can expose its imbalance unless the learner has either validated the imbalance or learned real target information on the unseen region.

### Deterministic Orientation Barrier

The clean deterministic barrier is now:

- Sparse local handles can produce marginal-dependent hidden gains such as `m/N`.
- Those handles do not decide what the proper binary hypothesis should do on unsampled mass.
- Any deterministic unseen behavior has a sign. Near-balanced realizable marginals can require opposite signs while producing statistically indistinguishable transcripts at `m` samples.
- If the wrong sign is chosen, sparse local corrections of mass `O(m/N)` cannot prevent error from rising above `1/2`, even when `OPT_C=0`.
- Random hashes and balanced codes replace a fixed wrong sign by a discrepancy term, but for high blocks that term is larger than the hidden gain unless one validates at the hidden scale.

This explains why the obvious deterministic false witnesses keep failing on the source-positive side. Local orientation-free handles solve only the sampled-coordinate orientation. They do not provide a deterministic, pointwise neutral behavior on all unseen coordinates.

### Stochastic And Mixture Model Fork

The stochastic fork should be kept separate from this edge.

If prediction-time randomized predictors were allowed, the rare-block learner could predict correctly on sampled pairs and flip a fair coin on unseen pairs. The unseen error would be exactly `1/2` pointwise, and the sampled mass would give a hidden marginal-dependent advantage. A PRF-style argument would then plausibly refute every fixed distribution-free weak exponent, because no efficient learner can predict unseen orientations.

The same is true for convex mixtures only if risk is evaluated as the expected loss of the mixture on each prediction. It is not true if the mixture is sampled once at training time or rounded to one binary vote. Those operations return to the deterministic barrier above.

Therefore the stochastic or mixture-valued construction is a conditional false-witness template for a different node, not a resolution of the current deterministic proper binary edge.

### What Depth 7 Should Incorporate Into Atlas Notes

If depth 7 updates the atlas, the current edge should remain `open` unless it supplies a genuinely new theorem or witness. The useful atlas-facing consolidation would be:

- state explicitly that full-support transcript uniformization handles sample/time resources but not the weak gap;
- name the remaining obstruction as weak-gap uniformization: marginal gaps `s^{-k(P)}` need not have a known uniform exponent;
- add the deterministic orientation barrier to the proof-status prose for rare-block proper-handle templates;
- record that prediction-time stochastic or expected-mixture semantics would likely change the answer under PRF assumptions, but those semantics are not the current proper binary node;
- list positive fragments separately: bounded hidden exponent, extra size-conditional/closure assumptions enabling diagonal mixtures, or a deterministic neutralizer with discrepancy below the hidden local gain;
- list false-witness requirements separately: a pathwise-polynomial weak agnostic proper source for every arbitrary marginal, no hidden-scale validation, no public level-independent handle reusable by the target, and a global evaluator convention if the target lower bound uses PRFs.

The most precise short summary for the edge note would be:

> Open under deterministic proper binary semantics. Resource uniformization is available, but no known argument uniformizes the marginal-dependent weak advantage. Rare-block PRF templates expose the right hidden-gap geometry, yet deterministic proper outputs must choose unseen labels; near-balanced marginals force hidden-scale orientation or validation. Prediction-time stochastic or expected-mixture semantics would remove this barrier, but those are different output models.

### Depth 6 Conclusion

No resolution under the current semantics. The positive direction still lacks a weak-gap uniformization theorem, and the negative direction still lacks a deterministic proper source-positive rare-block construction. The stochastic fork remains conditional-only for a different model.

VERDICT: unresolved

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
