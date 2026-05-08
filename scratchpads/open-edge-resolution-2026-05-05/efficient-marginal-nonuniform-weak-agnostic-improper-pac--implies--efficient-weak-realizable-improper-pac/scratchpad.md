# Edge Scratchpad: Efficient Marginal-Nonuniform Weak Agnostic Improper PAC => Efficient Weak Realizable Improper PAC

Date: 2026-05-05

Worker constraint: atlas files are read-only for this pass. This note records only scratch work and proposed follow-up.

## Files Read

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- Related implication notes for:
  - `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac`
  - `efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-weak-realizable-improper-pac`
  - `efficient-marginal-nonuniform-realizable-improper-pac -> efficient-weak-realizable-improper-pac`
  - `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac`

## Current Edge State

The edge is currently marked `open`, with the summary:

> Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound.

That is directionally right, but after reading the newer `full-support-marginal-uniformization` note, the best formulation is sharper:

- The pathwise sample/time resource bound can be uniformized for a single marginal-nonuniform learner by choosing a full-support reference marginal.
- The unresolved part is not mainly runtime; it is the weak advantage/gap. The source definition allows a marginal-dependent weak gap
  $$
  \gamma_P(s) = 1/2-\beta_P(s),
  $$
  with only a $P$-dependent inverse-polynomial lower bound.
- The distribution-free weak realizable target needs one inverse-polynomial advantage $\gamma(s)$ independent of the actual marginal.

## Reduction of the Edge

Let $A$ be the learner promised by the source. On a realizable distribution labeled by $c \in \mathcal C$, the agnostic optimum is zero, so the source gives

$$
\operatorname{err}_P(A,c) \le 1/2-\gamma_P(s)
$$

with high probability, for some marginal-dependent inverse-polynomial $\gamma_P$.

Thus the source trivially implies the marginal-nonuniform weak realizable improper node. The remaining question is exactly:

> Does a single efficient learner whose weak realizable advantage is inverse-polynomial for each marginal separately necessarily have a distribution-free inverse-polynomial advantage?

Equivalently, can one prove a weak-gap uniformization theorem?

## Conditional Positive Observation

If the source's weak-agnostic tolerance were fixed independently of the marginal, the edge would be resolved true.

Proof sketch under that alternate reading:

1. Restrict to realizable labeled distributions. Then $\operatorname{OPT}_{\mathcal C}=0$, so the source returns error at most $\beta<1/2$, giving a uniform weak advantage $\gamma=1/2-\beta$.
2. Use `full-support-marginal-uniformization` to get one distribution-free pathwise sample/time polynomial for the same single learner $A$.
3. The output is improper, which is allowed by the target.

This is exactly the argument used by the atlas for strong marginal-nonuniform agnostic/improper sources into weak realizable improper targets, except that those strong sources produce a constant gap by running at fixed $\varepsilon=1/4$.

But this conditional proof does not apply to the current efficient source definition, which explicitly allows $\beta_P$ and hence $\gamma_P$ to depend on $P$.

## Why Full-Support Uniformization Does Not Settle This Edge

The full-support reference marginal $P^\star$ gives a uniform worst-case transcript bound for $A$ under the atlas pathwise efficiency convention. It does not transfer accuracy from $P^\star$ to an arbitrary target marginal $P$.

For accuracy, the argument must apply the source guarantee directly to the actual marginal $P$. That yields only $\gamma_P(s)$.

Trying to transfer error from $P^\star$ to $P$ would require a polynomial density-ratio bound $dP/dP^\star$. A full-support marginal alone gives no such bound. On finite encoded slices, a uniform or full-support $P^\star$ may assign exponentially or smaller mass to points where $P$ concentrates, so a weak advantage under $P^\star$ can say essentially nothing under $P$.

## Why Boosting Does Not Settle This Edge

For this target, boosting is not needed if one already has a uniform weak gap. The source already gives weak realizable learning under the actual marginal.

If the only available gap is $\gamma_P$, realizable boosting would require time/sample bounds polynomial in $1/\gamma_P$. Since the exponent hidden in $\gamma_P(s) \ge s^{-k(P)}$ may depend on $P$, boosting cannot produce a distribution-free polynomial bound.

Agnostic boosting is also a near miss rather than a proof. The relevant atlas notes say the known Feldman/Ghai-style theorems use threshold/correlation or tunable-slack weak oracles. The source here supplies only a fixed marginal-dependent additive tolerance. Same-marginal agnostic boosting would not by itself turn an unknown $P$-dependent weak gap into one uniform inverse polynomial.

## Attempted Positive Route: Compactness of Marginals

One tempting thought is:

1. Full-support uniformization bounds the learner's finite transcript length uniformly.
2. For a fixed representation size, distributions over a finite encoded slice form a compact simplex.
3. If every marginal has some positive weak gap, maybe the minimum gap is positive.

The obstruction is discontinuity at rare slices. A learner may have a good gap on a limiting marginal that omits a hard slice, while the gap on marginals assigning tiny mass to that slice is proportional to the tiny mass. Thus the pointwise best weak gap need not be lower semicontinuous. Positive pointwise gaps over all marginals need not have a positive uniform lower bound.

This matches the "global-mixture" obstruction already recorded in `marginal-boosting-open`: low-mass bad slices can be ignored by the marginal-nonuniform guarantee, so stitching them into one global marginal does not force a uniform polynomial envelope.

## Attempted False Route: Block/Hierarchy Witness

A plausible counterexample template would be a countable hierarchy of blocks:

- On block $k$, there is a weak learner, but the best available running time or weak advantage has polynomial degree roughly $k$.
- A marginal concentrated on block $k$ is learnable with a $P$-dependent polynomial.
- An arbitrary fixed marginal over blocks has some finite heavy prefix; a universal learner can spend enough time on that prefix and ignore sufficiently light tail mass, with the required polynomial depending on the marginal.
- No distribution-free learner has one polynomial exponent and one inverse-polynomial weak gap covering all blocks.

This template is not yet an atlas-ready counterexample.

The hard part is satisfying the source for every marginal, including marginals that isolate a high block, while still preventing a distribution-free improper weak learner from exploiting the same weak handles. PRF-style blocks give target hardness, but ordinary PRFs are not weakly learnable on the isolated hard marginal, so they fail the source. Public handles make the source easy, but usually leak the same advantage to the target. A successful witness would need "computationally nonuniform weak handles": each fixed block/marginal is weakly learnable by the one universal algorithm with block-dependent polynomial overhead, but no uniform polynomial-time algorithm finds a weak handle across all blocks.

This is close to the PRF coordinate-block hierarchy mentioned in the weak-gap uniformization note, but that note already records the current failure mode: arbitrary marginals can concentrate on near-balanced high-scale blocks where selecting a useful default orientation from samples is not source-certified, while public or compact random defaults tend to give the target learner the same edge.

## Proposed Atlas Update If This Edge Is Refreshed Later

Do not change the status based on this pass. I would keep:

- `status: "open"`
- `evidence: unknown`
- `family: marginal-uniformization-open`

But I would sharpen the summary/body to distinguish resource uniformization from weak-gap uniformization. Suggested summary:

> Open: full-support marginal uniformization gives one pathwise sample/time polynomial for the single source learner, but the source's weak realizable advantage after restricting to realizable labels may still have marginal-dependent polynomial degree.

Suggested proof-status conclusion:

> The edge would be true if the weak-agnostic tolerance were fixed independently of the marginal. Under the current definition, where the gap $\gamma_P$ may depend on $P$, no theorem is known that lower-bounds all $\gamma_P$ by one inverse polynomial, and no concrete hierarchy witness has yet been verified.

## Depth-2 Directions

1. Clarify the weak-gap convention for efficient marginal-nonuniform weak agnostic nodes. If $\beta$ is intended to be fixed as in the sample-efficient weak agnostic notes, this edge should become `resolved-true` by realizable restriction plus full-support marginal uniformization.

2. Try to prove a weak-gap uniformization theorem under stronger semantics, such as size-conditional marginal guarantees or polynomial density-ratio access to a reference marginal. The current global-mixture semantics appears too weak because rare hard slices can be ignored.

3. Build a block hierarchy witness under an explicit complexity assumption. The needed assumption is not just PRF hardness; it should say that block $k$ is weakly learnable in time $n^{O(k)}$ but not with any fixed lower exponent uniformly over $k$, even for improper hypotheses.

4. Check whether any known resource-bounded measure, time-hierarchy, or nonuniform-vs-uniform learning construction gives the required "one universal learner, marginal-dependent polynomial rate" source without handing the target a public weak handle.

5. If pursuing an agnostic-boosting route, look for a theorem that boosts from a fixed additive weak agnostic oracle with unknown marginal-dependent gap while preserving a uniform polynomial in the final weak target parameters. The current Feldman/Ghai/da Cunha near misses do not provide this.

## Bottom Line

The source definitely gives marginal-nonuniform weak realizable improper learning by restriction to realizable labels. The full-support argument likely uniformizes runtime for the same learner. What remains is a genuine weak-gap uniformization problem:

$$
\forall P\ \exists k(P):\ \gamma_P(s) \ge s^{-k(P)}
\quad\not\Rightarrow_{\text{known}}\quad
\exists k\ \forall P:\ \gamma_P(s) \ge s^{-k}.
$$

I do not see a valid proof of the implication under the current source definition, and I do not see a verified counterexample that satisfies the source for all marginals.

verdict: unresolved-open
confidence: 0.74

## Depth-2 Followup 2026-05-05: Weak Tolerance Quantifier Audit

Focus: Direction 1 above, namely whether the atlas intends the weak agnostic tolerance/gap in efficient marginal-nonuniform weak agnostic nodes to be uniform across marginals or allowed to depend on the marginal $P$.

### Files Inspected

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/sample-efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/sample-efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/sample-efficient-weak-agnostic-improper-pac.md`
- `atlas/README.md`
- `atlas/registry/axes.yml`
- `atlas/dashboards/all-edges.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- Nearby implication notes from `efficient-marginal-nonuniform-weak-agnostic-improper-pac` and `efficient-marginal-nonuniform-weak-realizable-improper-pac` to the corresponding distribution-free weak targets.

### Finding

The current atlas definitions for the computational marginal-nonuniform weak agnostic nodes are not merely ambiguous: they explicitly allow the weak agnostic tolerance to depend on the marginal.

The improper source definition says:

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s),
$$

where for every marginal $P$ there are a polynomial $p_P$ and a tolerance $\beta_P(s)<1/2$ whose gap from $1/2$ is inverse-polynomial only under a marginal-dependent polynomial. The proper computational marginal weak agnostic definition has the same convention.

This aligns with the computational marginal weak realizable definitions, which explicitly allow an advantage $\gamma_P(s)$ depending on $P$ and state that $1/\gamma_P(s)$ is bounded by a marginal-dependent polynomial.

By contrast, the distribution-free weak agnostic target definitions use a fixed additive tolerance $\beta<1/2$, and the distribution-free weak realizable target uses one inverse-polynomial advantage $\gamma$ independent of the marginal. Thus, after restricting the source to realizable labels, the source gives only

$$
\gamma_P(s)=1/2-\beta_P(s),
$$

not a single $\gamma(s)$ valid for all marginals.

### Schema And Dashboard Check

The schema-level notes do not override this reading. `atlas/README.md` says marginal-nonuniform nodes allow the polynomial PAC bounds to depend on the instance marginal, and `atlas/registry/axes.yml` records only the five coarse axes. Neither file specifies the weak tolerance quantifier. The dashboard code is only a query interface over those axes and statuses; it contains no independent weak-gap semantics.

There is one local inconsistency worth tracking: the sample-efficient marginal-nonuniform weak agnostic notes use a fixed $\beta<1/2$ and allow only the sample polynomial to depend on $P$. I read this as a sample-only convention rather than evidence for the computational nodes, because the computational notes explicitly write $\beta_P(s)$ and several computational implication notes rely on that notation. The sample-only edges are also resolved through VC/marginal-nonuniform trichotomy arguments with unrestricted ERM, so they do not supply a polynomial-time weak-gap uniformization theorem.

### Implication Pattern Check

Nearby computational notes support the marginal-dependent-gap interpretation.

- `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-improper-pac` is true by same-marginal monotone relaxation: on realizable labels, the source tolerance becomes a same-marginal weak advantage.
- `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac` is open, with the current summary explicitly saying that full-support uniformization gives one pathwise resource polynomial but does not turn the marginal-specific weak gaps into one distribution-free inverse-polynomial gap.
- `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-realizable-improper-pac` is open for the same quantitative reason, plus the stronger boosting requirement.
- `low-noise-weak-agnostic-robustification` and related edges construct or use $\beta_P(s)=1/2-\alpha_P(s)$ from a $P$-specific sample/time bound, which would be unnecessary if the computational marginal weak agnostic convention required a uniform fixed tolerance.

So the best reading is:

$$
\forall P\ \exists p_P,\beta_P
\quad\text{rather than}\quad
\exists \beta\ \forall P\ \exists p_P.
$$

### Consequence For The Assigned Edge

Direction 1 resolves the definitional ambiguity but does not resolve the edge. Under the current atlas definitions, the edge remains open because the source only yields a marginal-dependent weak realizable advantage after restricting to realizable labels.

The full-support argument can uniformize worst-case/pathwise sample and time bounds for the single learner. It cannot uniformize the accuracy parameter, because accuracy is applied to the actual marginal $P$, and the definition supplies only $\gamma_P(s)$ there. A distribution-free weak realizable learner needs one inverse-polynomial $\gamma(s)$ that works for all $P$.

No existing nearby note gives:

$$
\forall P\ \exists k(P):\gamma_P(s)\ge s^{-k(P)}
\quad\Longrightarrow\quad
\exists k\ \forall P:\gamma_P(s)\ge s^{-k}.
$$

The sample-efficient trichotomy route also does not settle this computational edge, because it uses unrestricted computation and does not produce a polynomial-time learner with a uniform weak gap.

### Concrete Obstacles

1. The computational source definition explicitly has $\beta_P(s)$, so changing the assigned edge to true would require either a definition/schema change or a new weak-gap uniformization theorem.
2. Full-support marginal uniformization is resource-only for this edge. It bounds transcripts but does not transfer a weak advantage from the reference marginal to an arbitrary target marginal.
3. The fixed-beta sample-efficient convention is not enough evidence to reinterpret the computational node, because nearby computational notes already use $\gamma_P(s)$ and $\beta_P(s)$ in their proofs and obstruction summaries.
4. A false witness still needs to satisfy the source for every marginal, including marginals concentrated on any hard slice. The existing block/hierarchy idea remains plausible but not atlas-ready.

### Next Directions

1. Update the assigned edge note, if atlas edits are later allowed, to mirror the sharper summary already present on the sibling edge to `efficient-weak-agnostic-improper-pac`: resource uniformization works, weak-gap uniformization is the remaining obstruction.
2. Add an explicit schema note, if desired, distinguishing the computational marginal weak convention (`\beta_P` or `\gamma_P` may depend on $P$) from the sample-efficient marginal weak convention (currently fixed `\beta` in the weak agnostic notes).
3. Continue the proof search as a weak-gap uniformization problem, not as a runtime uniformization problem.
4. For a separation route, look for a concrete hierarchy where one uniform learner achieves $P$-dependent inverse-polynomial weak gaps for every marginal, while no uniform polynomial-time learner achieves one distribution-free inverse-polynomial gap.

### Verdict

verdict: unresolved-open
confidence: 0.86

The quantifier audit strongly supports the current marginal-dependent weak-gap reading for computational marginal-nonuniform weak agnostic nodes. That clarification blocks the simple true proof and leaves the assigned implication open.

## Depth-2 Followup 2026-05-05: Hierarchy And Measure Stress Test

Focus: Directions 2 and 4 above. Can full-support/pathwise uniformization, plus classical time hierarchy, resource-bounded measure, or nonuniform-vs-uniform lower bounds, yield either a weak-gap uniformization theorem or a rigorous counterexample?

### Additional Sources Checked

- Hartmanis and Stearns, "On the Computational Complexity of Algorithms" (1965), time-hierarchy source: https://doi.org/10.1090/S0002-9947-1965-0170805-7
- Kannan, "Circuit-size lower bounds and non-reducibility to sparse sets" (1982), fixed-polynomial circuit lower bounds: https://doi.org/10.1016/S0019-9958(82)90382-5
- Lutz, "Category and Measure in Complexity Classes" (1990), resource-bounded measure/category and uniform-vs-nonuniform applications: https://doi.org/10.1137/0219076
- Lutz, "Almost Everywhere High Nonuniform Complexity" (1992), high nonuniform complexity via resource-bounded measure: https://doi.org/10.1016/0022-0000(92)90020-J
- Goldreich, Goldwasser, and Micali, "How to Construct Random Functions" (1986), PRF baseline: https://doi.org/10.1145/6490.6503
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" (1994), representation-independent weak learning hardness: https://doi.org/10.1145/174644.174647
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (2025), marginal-nonuniform rates and arbitrarily slow-rate phenomena: https://openreview.net/forum?id=aoVCFtox89

### Short Verdict

No settlement. I do not see a valid weak-gap uniformization theorem from these tools, and I do not see a rigorous time-hierarchy/resource-bounded-measure counterexample satisfying the source for every marginal.

The most important correction is this: after `full-support-marginal-uniformization`, runtime hierarchy is the wrong knob. If a single source learner $A$ satisfies the atlas's worst-case/pathwise transcript convention, applying the source guarantee to a full-support reference marginal $P^\star$ gives one global polynomial transcript bound for $A$. Thus a proposed witness cannot say "on marginal $P_k$, the learner spends time $s^k$" for unbounded $k$. Such a learner would already violate the pathwise bound obtained from $P^\star$.

The only remaining possible hierarchy is a weak-gap or correlation hierarchy:

$$
\forall P\ \exists k(P):\gamma_P(s)\ge s^{-k(P)}
\quad\text{but maybe not}\quad
\exists k\ \forall P:\gamma_P(s)\ge s^{-k}.
$$

Classical hierarchy and measure tools do not directly speak to this quantified learning statement.

### Direction 2: Positive Uniformization Route

The strongest positive route is still the slice-conditional diagonal argument from nearby notes. If a marginal were a size-indexed family $(P_s)_s$ and risk were evaluated conditionally on each size slice, then failure of a uniform gap would let us choose bad pairs $(s_r,P^{(r)})$ with $\gamma(P^{(r)},s_r)<s_r^{-r}$ and stitch them into one marginal family $P^\dagger$. The source polynomial for $P^\dagger$ would then contradict the bad slices for large $r$.

That argument does not follow from the current atlas global-marginal wording. A single global marginal over encoded instances must assign weights $w_r$ to the bad size/block components. Weak agnostic accuracy is a global additive guarantee, so a component of mass $w_r$ can hide poor conditional behavior unless the loss on that component is large compared with the demanded global gap. Choosing $w_r$ to decay slowly helps, but it does not give a black-box proof: the source guarantee for $P^\dagger$ is tested on one finite target concept at a time, and the learner sees a different sample distribution from the original bad marginal $P^{(r)}$. Without additional closure assumptions on the concept class and marginals, bad performance under $P^{(r)}$ need not transfer to bad performance under the mixture.

Resource-bounded measure does not repair this gap. Lutz-style measure says that certain complexity classes or nonuniformly easy languages form small subsets of classes like E, ESPACE, or related exponential classes. It does not supply the missing learning-theoretic compactness statement:

$$
\text{pointwise inverse-polynomial weak gaps for all global marginals}
\Rightarrow
\text{one inverse-polynomial weak gap uniformly over marginals}.
$$

Nor does it impose a polynomial modulus of lower semicontinuity on the map $P\mapsto \gamma_P(s)$. Finite-slice compactness can at best suggest a positive minimum at each fixed $s$ for a fixed bounded-transcript learner. It gives no reason that these minima cannot shrink faster than every inverse polynomial as $s$ grows.

So the only positive theorem I can currently defend is conditional:

> If the marginal semantics are strengthened to size-indexed, slice-conditional marginal families, or if one adds a nondegeneracy condition forcing every active size/block component to have inverse-polynomial mass in the representation size, then a diagonal uniformization proof may go through. Under the current global-marginal semantics, this is not proved.

### Direction 4: Counterexample Route From Hierarchy Or Measure

The naive time-hierarchy witness would use blocks $B_k$ such that block $k$ is learnable in time $s^{O(k)}$ but not in time $s^d$ for $d<k$. This fails under the pathwise full-support argument: the source learner is one algorithm with one global polynomial transcript bound after reference-marginal uniformization. Marginal-dependent runtime exponents are not actually available.

A more relevant witness would need calibrated weak gaps instead of calibrated runtimes:

1. For every fixed marginal $P$, one uniform polynomial-time learner has advantage at least $s^{-k(P)}$.
2. For every proposed distribution-free exponent $d$, some realizable marginal and target defeat all polynomial-time learners trying for advantage $s^{-d}$.
3. The lower bound is improper and average-case/correlation based, not merely exact-decision or worst-case.

Classical time hierarchy does not give item 3. It separates time classes by worst-case diagonalization. A PAC weak learner may be wrong on many worst-case points and still have advantage under a distribution; conversely, a hierarchy-hard language can be easy to weakly predict under many marginals. Turning time hierarchy into weak-learning hardness requires an average-case or correlation lower bound under the selected marginal.

Kannan-style fixed-polynomial circuit lower bounds and nonuniform-vs-uniform results are also near misses. They can say, for each fixed $d$, that some language avoids circuits of size $n^d$, or that small-circuit languages are meager/measure-zero in a larger class. The target lower bound here needs a represented concept family and, for every polynomial-time learner/hypothesis class, a realizable distribution on which no hypothesis achieves correlation $s^{-d}$. That is an average-case approximation lower bound against all polynomial-size circuits/hypotheses, calibrated by $d$, and it must coexist with the source learner's marginal-specific weak edge.

Resource-bounded measure gives plausible hard residuals: almost-everywhere high nonuniform complexity or p-random languages can rule out small circuits on many lengths. But by themselves these residuals do not satisfy the source. A marginal can concentrate on the hard residual region. If no public weak handle exists there, the marginal-nonuniform weak source fails. If a public handle is made strong enough to give the source learner a weak edge for every adversarial marginal, the distribution-free target learner tends to inherit the same handle, destroying the lower bound.

This is the same failure mode as the PRF coordinate-block attempt in the sibling scratchpad. PRFs give the right target hardness on unseen coordinates, but the source side has to choose a default orientation on arbitrary near-balanced marginals. With only a fixed pathwise-polynomial number of samples, distinguishing two marginals whose label bias differs by less than the validation noise is impossible. Time-hierarchy or measure-hard residuals do not remove this orientation/default-selection obstruction.

### What Would Settle The Edge

A positive settlement would need one of the following.

1. A genuine weak-gap uniformization theorem for single bounded-transcript learners:

$$
\left[\forall P\ \gamma_P(s)\ge 1/\operatorname{poly}_P(s)\right]
\Rightarrow
\left[\exists q\ \forall P\ \gamma_P(s)\ge 1/q(s)\right],
$$

with hypotheses matching global marginals, not slice-conditional families.

2. A semantic strengthening of marginal-nonuniform PAC in the atlas so that marginals are size-indexed and risk is size-conditional. Then the diagonal stitching argument becomes much more credible.

3. A calibrated average-case hierarchy witness with an orientation-free public weak edge: every fixed global marginal must be weakly learnable by the same polynomial-time algorithm with some marginal-dependent inverse-polynomial gap, while every distribution-free polynomial exponent is defeated on a hard realizable marginal. Known time-hierarchy, P/poly, resource-bounded-measure, and PRF tools do not currently give this package.

### Why I Am Not Marking False

The lower-bound side alone is not hard to imagine: PRFs, p-random languages, or average-case circuit lower bounds can make uniform weak prediction difficult on selected marginals. The source side is the blocker. It quantifies over all marginals, including marginals that isolate the hard region and balance labels so constants are useless. Any counterexample must still provide a deterministic polynomial-time weak edge there. Existing hierarchy/measure constructions are designed to make such regions hard, not barely learnable with a calibrated marginal-dependent advantage.

### Why I Am Not Marking True

The source only gives pointwise-in-$P$ inverse-polynomial gaps. Full-support uniformization makes the transcript bound uniform but leaves accuracy attached to the actual marginal. Global mixtures do not force conditional performance on low-mass bad components, and resource-bounded measure does not supply the missing polynomial lower bound on $\inf_P\gamma_P(s)$.

### Conclusion

The edge remains best classified as `open`, but with a sharper reason than the current edge note's resource-polynomial wording. Runtime uniformization is handled by the full-support/pathwise argument. The unresolved question is a weak-gap uniformization problem, and the known hierarchy/nonuniformity tools do not quite match its quantifiers.

verdict: unresolved-open
confidence: 0.88

---

## Depth-2 Direction 3 Follow-Up: Block-Hierarchy Counterexample Attempt

- depth: 2
- date: 2026-05-05
- focus: Direction 3, block/hierarchy counterexample under explicit complexity assumptions
- verdict: unresolved-open
- confidence: 0.78

### Target Separation Shape

The desired false witness would be a class $\mathcal C=\bigcup_k \mathcal C_k$ on disjoint blocks $X_{n,k}$ such that:

1. A single universal learner $A$ satisfies the source for every fixed marginal $P$. The weak agnostic gap may be $\gamma_P(s)\ge s^{-K(P)}$, with $K(P)$ allowed to depend on $P$, but the learner itself is not given $P$ as advice.
2. For every fixed distribution-free polynomial weak target gap $s^{-d}$, some high block $k\gg d$ defeats every randomized polynomial-time improper realizable learner under a hard marginal such as the uniform or balanced active-block marginal.

The most tempting assumption is a scale hierarchy of weakly predictable hard cores:

> For each level $k$, the block family is weakly learnable with advantage about $s^{-k}$ by one uniform procedure, but no $s^{O(1)}$-time improper learner can obtain advantage $s^{-d}$ on block $k$ for any fixed $d<k$, even in the realizable case.

This is stronger and more tailored than ordinary PRF hardness. Standard PRFs give the target lower bound flavor, but by themselves they do not give the source on the isolated hard marginal.

### Candidate Construction Tried

Use an image-coordinate or PRF hard-core family on block $X_{n,k}$, with a planted weak handle of size about

$$
\gamma_k(s)=s^{-k}.
$$

One concrete version is a one-way image-coordinate block where the hidden positive set has size $N_{n,k}\approx n^k$. Add weak handles such as constants and singleton-positive-atom hypotheses. On a marginal concentrated on this block, the usual constants-or-singleton strategy gives a weak realizable handle of order $1/N_{n,k}\approx n^{-k}$:

- if the positive mass is far from $1/2$, a constant has weak advantage;
- if the positive mass is near $1/2$, a heaviest positive atom has mass at least about $1/N_{n,k}$, so the corresponding singleton has weak advantage.

For agnostic learning, finite-class ERM over the handle class would compete with these handles; by the triangle inequality, a handle that is weakly correlated with every target concept gives an $\operatorname{OPT}_{\mathcal C}+1/2-\gamma_k$ predictor.

The target lower bound would use a balanced active-block marginal. To beat advantage $n^{-d}$ when $k\gg d$, a learner must do substantially more than exploit one singleton or the public bias; it must recover many hidden positives or predict the hard-core residual. Under length-preserving one-way functions or PRF-style unpredictability, this is the right hardness shape.

### Exact Obstacle

The construction does not satisfy the source under the atlas's current pathwise efficiency convention.

For the isolated block marginal $P_{n,k}$, the constants-or-singleton learner needs about $N_{n,k}\approx n^k$ samples to see a useful positive atom in the balanced case, and agnostic ERM over handles needs comparable polynomial degree to validate an $n^{-k}$ gap. That is allowed for this one marginal only because the polynomial exponent may depend on $P_{n,k}$.

However, the source quantifies over every marginal, including a full-support reference marginal $P^\star$ that gives positive probability to every finite encoded block and every finite labeled transcript. The transcript consisting of many samples from a high block $X_{n,k}$ has positive probability under $P^\star$. If the same learner runs for $n^k$ samples or time on that transcript in order to satisfy $P_{n,k}$, then no single polynomial $p_{P^\star}(s)$ bounds its pathwise resource use for all $k$.

So this hierarchy relies on marginal-dependent resources, but the full-support argument already uniformizes resources for any valid single source learner. The only remaining degree of freedom is the weak gap, not the running time or sample count.

### Why Public Bias Repairs Also Fail

A second repair is to make the $s^{-k}$ handle public and cheap, so the source learner can run in one uniform polynomial time while its guaranteed advantage still decays with $k$.

This solves the resource problem only under special marginals. If a public predictor $g_k$ disagrees with a target concept $c$ at some point $x$, the marginal concentrated on $x$ makes $g_k$ perfectly wrong. Thus a fixed public handle cannot be weakly correlated with every concept under every marginal unless it agrees pointwise, which would make the block easy for the distribution-free target as well.

Biased PRF masks have the same problem. A public bias can be arranged under the uniform active-block marginal, and PRF hardness can make improvement over that bias computationally hard. But the source must also handle marginals concentrated on the anti-biased region or on any other slice where the public bias disappears. Ordinary PRF or one-way-function assumptions then give hardness for the source, not just for the target.

### What Assumption Would Actually Resolve The Edge

A counterexample would follow from a nonstandard "distribution-free weak-advantage hierarchy" assumption:

> There are block classes $\mathcal C_k$ and one uniform polynomial-time learner $A$ such that, for every marginal on every block and every target in $\mathcal C_k$, $A$ achieves weak agnostic advantage at least $s^{-k}$, while for every fixed $d$ no randomized polynomial-time improper learner achieves realizable advantage $s^{-d}$ on all sufficiently high blocks.

Under that assumption, the union over $k$ would separate the source from the target: each fixed marginal gets some finite weak exponent, while any proposed distribution-free exponent $d$ is defeated on a high block.

But this assumption essentially packages the missing separation into the hypothesis. I do not see how to derive it from the standard local witnesses:

- PRF classes give hard high blocks but fail the source on the isolated hard marginal.
- One-way image-coordinate weak handles give marginal weak handles, but the sample/time needed to find them scales like the hidden positive-set size and violates full-support pathwise resource uniformization.
- PCP active slices give weak hardness, but their hard marginal is instance-dependent and does not provide a one-learner, every-marginal source.

### Current Best Takeaway

The block hierarchy remains the most promising negative template, but the viable version must be a pure weak-gap hierarchy with uniform pathwise resources. Any construction whose high block is learnable only after $s^k$ samples or time is ruled out by the full-support resource argument; any construction with a cheap public $s^{-k}$ bias must explain why arbitrary marginals cannot concentrate where that bias fails.

I therefore do not have an atlas-ready counterexample. The exact missing ingredient is a standard complexity assumption producing blocks that are distribution-free weakly learnable with a guaranteed but level-dependent inverse-polynomial advantage, while provably not learnable with any fixed inverse-polynomial advantage uniformly over levels.

verdict: unresolved-open
confidence: 0.78

## Depth-3 Theorem-Route Audit: Compactness Does Not Uniformize the Hidden Gap

- depth: 3
- date: 2026-05-05
- focus: compactness, transcript continuity, finite size slices, and validation as possible routes to a distribution-free weak gap
- verdict: unresolved-open
- confidence: 0.87

### Goal

The theorem route would need to show that the current source semantics already force a uniform distribution-free inverse-polynomial weak realizable advantage.

Let $A$ be the single learner from the source. By the full-support argument, the sample use and runtime of this same $A$ can be bounded by one pathwise polynomial. Thus the only remaining target requirement is a uniform weak gap.

On realizable labels, define informally

$$
\Gamma_A(P,s)
=
\sup\left\{\gamma:
  \forall c\in\mathcal C_s,\ 
  \Pr[\operatorname{err}_P(A,c)\le 1/2-\gamma]\ge 2/3
\right\}.
$$

The source gives the pointwise statement

$$
\forall P\ \exists q_P\ \forall s:\quad
\Gamma_A(P,s)\ge 1/q_P(s),
$$

where $q_P$ is a marginal-dependent polynomial. The target would need, for some efficient learner, a distribution-free polynomial $q$ such that

$$
\forall P\ \forall s:\quad
\Gamma(P,s)\ge 1/q(s).
$$

The question is whether compactness, continuity of bounded transcripts, finite size slices, or validation can bridge this quantifier gap.

### Fixed-Size Compactness Is Too Weak

Grant the most favorable finite-slice setup: for each representation size $s$, the relevant instance slice, concept encodings, random coins, sample transcripts, and possible outputs of the bounded learner are all finite. Then the risk of any fixed output is continuous in the marginal, and a bounded randomized learner induces a continuous or at least semicontinuous weak-gap envelope on that finite-dimensional marginal simplex.

This can prove at most:

$$
\mu_s := \inf_P \Gamma_A(P,s) > 0
$$

for each fixed $s$, assuming the positivity hypotheses needed for semicontinuity. But the target needs $\mu_s \ge 1/\operatorname{poly}(s)$. Compactness alone supplies no rate in $s$.

A small abstract model shows the exact logical failure. Let the compact parameter space be

$$
K=\{\infty\}\cup\{1,2,3,\ldots\}
$$

with the one-point compactification topology. For each size $s$, define

$$
f_s(j)=
\begin{cases}
s^{-j}, & j\le s,\\
s^{-1}, & j>s,
\end{cases}
\qquad
f_s(\infty)=s^{-1}.
$$

For each fixed $s$, $f_s$ is continuous on $K$: all sufficiently large finite $j$ have the same value as the limit point. For every fixed parameter $j$, the sequence $f_s(j)$ is bounded below by the inverse polynomial $s^{-j}$, and for $\infty$ it is bounded below by $s^{-1}$. Thus every single parameter has a polynomial envelope.

Nevertheless,

$$
\inf_{\theta\in K} f_s(\theta)=s^{-s},
$$

which is not inverse-polynomial. The minimizing parameter moves with $s$. This is exactly the quantifier pattern in the current edge: every fixed marginal may have some polynomial weak-gap exponent, while the exponents can be unbounded over the marginals relevant at growing sizes.

So even a compact marginal parameter space, transcript continuity, and pointwise inverse-polynomial lower bounds do not imply a distribution-free inverse-polynomial lower bound. One would need an additional local-boundedness or open-cover hypothesis saying, in effect, that nearby marginals share a common weak-gap exponent on all large sizes. The atlas source definition does not include such a hypothesis.

### Why The Diagonal Stitching Proof Still Needs Stronger Semantics

The natural response is to choose, for each $s$, a marginal $P_s$ nearly attaining $\mu_s$, then stitch the $P_s$ into one marginal and contradict the source guarantee for that stitched marginal. This would work under a size-indexed, slice-conditional semantics:

$$
P=(P_s)_{s\ge 1},
$$

where the learning guarantee at size $s$ is evaluated after conditioning on the $s$-slice. Under that stronger convention, the bad sequence $P_s$ would be visible at full mass at its own size, so a superpolynomially small $\mu_s$ would violate the source for the single stitched family $P$.

That is not the current atlas reading. The current marginal is a single global distribution over encoded instances, and PAC error is not normalized inside each size slice. If a stitched marginal gives slice $s$ mass $w_s$, then bad conditional behavior on that slice changes the global error by at most $w_s$. By choosing small weights, or by using concepts whose hard behavior is isolated on low-mass slices, the global weak guarantee can ignore the bad components while still having a perfectly valid inverse-polynomial gap for the stitched marginal.

This is the precise barrier to the diagonal proof: the source controls global error under the actual marginal, not conditional error on every low-mass component of that marginal. Full-support uniformization can use rare transcripts to control pathwise resources, but PAC accuracy is allowed to average over rare regions.

### Why Validation Does Not Create The Missing Gap

Validation can select among candidate hypotheses once the required resolution is known. To certify a gap of order $s^{-d}$ from holdout samples, a learner needs on the order of $s^{2d}$ validation examples, up to logarithmic factors and candidate-list terms.

If the hidden source gap is only $s^{-K(P)}$ with $K(P)>d$, then a validation routine running with a fixed polynomial budget for exponent $d$ cannot distinguish the source output from random guessing at the necessary scale. Repetition or majority boosting has the same dependence on $1/\gamma_P$. Letting the tested exponent grow with $s$ gives a sub-inverse-polynomial target gap such as $s^{-\log s}$ or worse, not the fixed-degree inverse polynomial required by the distribution-free weak node.

Thus validation is a selector or amplifier after a uniform lower bound is available. It is not itself a proof of such a lower bound.

### Barrier Statement

The current atlas semantics give a pointwise polynomial weak-gap envelope:

$$
\forall P\ \exists k(P):\quad
\Gamma_A(P,s)\ge s^{-k(P)}
$$

up to constants and harmless small-size exceptions. The target needs a uniform envelope:

$$
\exists k\ \forall P:\quad
\Gamma(P,s)\ge s^{-k}.
$$

Compactness and transcript continuity can plausibly turn pointwise positivity into a positive fixed-size minimum $\mu_s$, but they do not control the asymptotic rate of $\mu_s$. Finite size slices do not repair the issue because the bad marginal may vary with the size. Diagonal stitching repairs it only under a stronger slice-conditional marginal semantics. Validation repairs it only after a uniform inverse-polynomial resolution is already known.

So I do not see a theorem route to `resolved-true` under the current notes. This is not a `resolved-false` proof either; it is a no-go diagnosis for the compactness/transcript/validation proof family.

### Depth-4 Directions

1. Formalize $\Gamma_A(P,s)$ for bounded transcript learners and prove the strongest available continuity or semicontinuity statement on finite encoded size slices. Then record the compact-to-positive-minimum result separately from any polynomial-rate claim.

2. Decide whether the atlas should ever adopt size-indexed, slice-conditional marginal semantics. Under that strengthened reading, the diagonal stitching proof should be revisited as a serious route to `resolved-true`.

3. Look for extra hypotheses that make the exponent locally bounded over marginals: bounded density ratios to a reference marginal, polynomial lower mass on active size slices, a compact finite-dimensional marginal family with open exponent classes, or a source learner that accepts a requested weak gap as a parameter.

4. Isolate validation as a conditional theorem: if the source supplies either a certified gap lower bound or a tunable weak-agnostic tolerance, then full-support resource uniformization plus holdout validation gives the distribution-free weak target.

5. If pursuing a separation later, convert the toy envelope above into a calibrated weak-gap hierarchy with uniform pathwise resources. The hierarchy must avoid the previous failures: no source-side $s^{K(P)}$ runtime, no public handle that gives the target the same weak gap, and no hard marginal on which even the source learner loses all inverse-polynomial advantage.

verdict: unresolved-open
confidence: 0.87

## Depth-4 Followup 2026-05-05: Relativized Hidden-Gap Separation Attempt

- depth: 4
- date: 2026-05-05
- focus: explicit oracle/relativized separation for hidden weak gaps under current global-marginal semantics
- verdict: unresolved-open
- confidence: 0.82

### Target Oracle Shape

The most concrete false route is a relativized "keyed half-block" class.

Partition the instance domain into disjoint finite blocks $B_s$, one block for each representation size $s$, and set

$$
|B_s|=N_s=s^s.
$$

For each key $u\in\{0,1\}^s$, an oracle $O$ defines a balanced random labeling

$$
O(u,\cdot):B_s\to\{0,1\}.
$$

The concept $c_{s,u}$ agrees with $O(u,\cdot)$ on $B_s$ and is $0$ off $B_s$. The learner knows $s$ and has oracle access, but it is not given the hidden key $u$. Hypotheses may be arbitrary oracle machines, so this is aimed at an improper lower bound.

This model has the right hidden-gap geometry. Under the active marginal $P_s=U(B_s)$, constants have error $1/2$. A learner that only memorizes $m$ labeled examples can gain advantage at most about $m/N_s$. Since $N_s=s^s$, this is below $s^{-d}$ for every fixed target exponent $d$ once $s$ is large compared with the learner's sample/time exponent.

The oracle lower bound side is therefore plausible. For a fixed polynomial-time oracle learner $L$, choose $s$ large and then choose a key $u$ not queried by $L$ except with negligible probability. Conditioned on $L$'s transcript, the labels of unseen points in $B_s$ are still random balanced bits. Any output hypothesis can only correlate with the target on the sampled or explicitly oracle-revealed coordinates, giving correlation $O(\operatorname{poly}(s)/N_s)$ plus the negligible key-hit probability. A standard finite-injury oracle construction should diagonalize over all polynomial-time learners and make this target failure hold for infinitely many large $s$.

So the target side of a relativized separation looks attainable:

$$
\forall d\ \exists s,u,P_s:\quad
\operatorname{err}_{P_s}(h,c_{s,u})>1/2-s^{-d}
$$

for every $s^d$-time learner, after choosing the oracle generically enough.

### Why The Source Almost Holds

The same construction also explains why current global-marginal semantics are permissive.

Consider the cheap learner that tries constants and memorized positive atoms. On realizable labels for $c_{s,u}$, let

$$
a_{s,u}(P)=P(c_{s,u}=1).
$$

If $a_{s,u}(P)$ is bounded away from $1/2$, a constant predictor already has constant weak advantage. Constants can fail only when $a_{s,u}(P)$ is close to $1/2$. Since $c_{s,u}$ is zero off $B_s$, this requires $P(B_s)$ to be close to $1/2$. For a fixed global marginal $P$ over disjoint blocks, only finitely many blocks can have that much mass.

On any one such exceptional block, sampled positive atoms give a tiny improper handle. In the uniform balanced case, every positive atom has mass $1/N_s=s^{-s}$. More generally, if the positive set has mass $a$ inside a block of size $N_s$, then the positive atoms of mass below $a/(2N_s)$ carry total mass at most $a/2$. Thus a logarithmic number of positive samples, with their singleton hypotheses unioned together, sees a positive atom of mass $\Omega(a/N_s)$ with high probability in the realizable case. Because the exceptional sizes are finite for fixed $P$, one can choose a finite exponent $K(P)$ dominating their block sizes. All remaining sizes are handled by constants with constant advantage.

This is exactly the hidden-gap pattern the edge is looking for:

$$
\forall P\ \exists K(P):\quad
\gamma_P(s)\gtrsim s^{-K(P)},
$$

while the active marginals $P_s=U(B_s)$ force the best cheap gap down to about $s^{-s}$ as $s$ varies.

### The Agnostic Source Obstruction

The construction is not an atlas-ready counterexample because the source is weak agnostic, not merely realizable weak, and it requires high-confidence PAC guarantees.

In the near-realizable case, if $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is already larger than the proposed gap, a constant hypothesis is enough for the weak agnostic inequality. The difficult case is

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)\ll 1/N_s
$$

on an exceptional balanced block. Then a memorized positive atom should still work if it is truly a positive atom of the best concept. But the learner only sees noisy labels. A rare noisy positive label on a high-mass negative atom can make the singleton output much worse than random guessing.

The usual repair is validation or ERM over constants and singleton hypotheses. However, selecting at resolution $1/N_s$ needs sample size polynomial in $N_s$ (or $N_s^2$ for ordinary holdout estimates), which is $s^{\Theta(s)}$. That violates the full-support/pathwise resource uniformization constraint: a valid source learner cannot spend $s^{\Theta(s)}$ time or samples on high-block transcripts, because the full-support reference marginal would force one distribution-free polynomial resource bound for the same learner.

This is the key failure of the oracle attempt. The target lower bound wants the only visible weak advantage on $B_s$ to be $1/N_s=s^{-s}$. The agnostic source wants confidence amplification and noise robustness at that same scale. Under current atlas efficiency conventions, the source cannot pay the usual validation cost for such a hidden gap.

### Why Simple Repairs Leak Or Fail

Adding a public deterministic handle does not solve the problem. If the handle is merely correlated under the active uniform marginal, an adversarial marginal can concentrate where that handle is wrong or absent, so the source fails. If the handle is forced to be useful under every marginal, it becomes a distribution-free weak handle and the target learner inherits it.

Adding noiseless oracle certificates for good atoms is also dangerous. If a certificate lets the source identify true positive handles without gap-scale validation, then an improper target learner can usually collect polynomially many certified handles. Unless the certificates are deliberately non-aggregable, this raises the target advantage from one hidden atom to a fixed inverse-polynomial advantage.

Making the oracle provide a weak-selector subroutine is close to assuming the desired separation. The source learner is not given the marginal $P$, so such a selector would have to work from samples alone, with confidence amplification independent of the hidden gap. I do not see a natural oracle mechanism that supplies this for the source while denying the same mechanism to the distribution-free improper target.

### Current Conclusion

This pass does not resolve the edge. It does, however, isolate the most explicit relativized near-miss:

1. Random keyed half-blocks should give a clean relativized lower bound against distribution-free improper weak learners at any fixed inverse-polynomial gap.
2. Global-marginal semantics make the marginal-dependent realizable weak source plausible, because only finitely many high-mass blocks can be balanced for any fixed marginal.
3. The weak agnostic source is the blocker: robust high-confidence selection of a $1/N_s$ atom appears to require resources polynomial in $N_s=s^s$, contradicting the full-support resource argument.

So I would not mark the edge false on this construction. It is a useful stress test, not an atlas-ready oracle separation.

### Depth-5 Directions

1. Formalize the target-side oracle lemma for keyed half-blocks: after diagonalizing over polynomial-time oracle learners, no improper learner gets advantage $s^{-d}$ under $U(B_s)$ for all large hidden-key blocks when $N_s=s^s$.

2. Prove a black-box no-go lemma for atom-memorization agnostic sources: any high-confidence weak agnostic learner that selects a $1/N$ atom from noisy random examples, without noiseless certificates, needs $\Omega(N)$ or $\Omega(N^2)$ samples to avoid false-positive high-mass atoms.

3. Test whether prediction-time randomized hypotheses are allowed anywhere in the atlas conventions. A randomized "sample a positive atom and predict its singleton" rule may have cleaner expected behavior, but it would still need derandomization or a PAC-success interpretation compatible with the definition.

4. Search for a certified-handle oracle where one weak handle is cheaply and noiselessly findable under every near-realizable marginal, but many independent handles cannot be aggregated by an improper learner. This is the exact nonboostable-handle requirement.

5. If no such certified-handle oracle exists, try to turn that into a conditional theorem: under any source mechanism whose handles are sample-certifiable and reusable, the target learner can aggregate enough of them to obtain a fixed inverse-polynomial weak advantage.

verdict: unresolved-open
confidence: 0.82

## Depth-5 Followup 2026-05-05: Gap-Oblivious Memorization And Randomized Handles

- depth: 5
- date: 2026-05-05
- focus: whether the keyed half-block source can satisfy weak agnostic learning without estimating the tiny $1/N_s$ gap
- verdict: unresolved-open
- confidence: 0.77

### Updated Diagnosis

The depth-4 obstruction was correct for validation-based source learners, but it is too strong as a general no-go statement.

The source learner does not have to know, estimate, or certify the marginal-dependent gap. The weak agnostic definition only requires that, for each fixed marginal $P$, there exists some inverse-polynomial gap $\alpha_P(s)$ for which the learner's output satisfies

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s).
$$

Thus a learner may be completely gap-oblivious. The proof can choose $\alpha_P$ after analyzing the learner. Constants handle the regime $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, so the only genuinely nontrivial regime is very low noise relative to the eventual hidden gap. In that regime, coupling or direct memorization may be enough; one need not run a holdout test that resolves error differences of order $1/N_s$.

So the previous sentence

> robust high-confidence selection of a $1/N_s$ atom appears to require resources polynomial in $N_s$

should be narrowed to:

> robust high-confidence validation or ERM selection at resolution $1/N_s$ requires resources polynomial in $N_s$.

That narrower bottleneck blocks the naive "find and validate the best singleton" source, but it does not yet block all source learners.

### Randomized One-Sample Handle

Consider one balanced keyed block $B_s$ of size $N_s=s^s$, and first ignore high-confidence amplification. Under a realizable target $c_{s,u}$ and the uniform active marginal, a learner that samples one positive labeled atom $x$ and outputs the singleton $1_{\{x\}}$ gets error

$$
1/2-1/N_s.
$$

This already has the desired hidden-gap shape. It finds the weak handle without estimating the gap: it only uses the sign of one label.

In a low-noise agnostic distribution close to some $c_{s,u}$, the same idea still has a plausible expected-risk guarantee. For default $0$, the stochastic one-sample correction has improvement over the constant $0$ roughly

$$
\sum_x P(x)^2\,\Pr(Y=1\mid x)\,\bigl(2\Pr(Y=1\mid x)-1\bigr).
$$

On true positive atoms this contributes about $P(x)^2$; on false positive noise over true negative atoms it contributes a negative term of order $P(x)^2\eta_x$. This is the key observation: the damage from a noisy false positive is quadratic in the atom mass for a random one-sample correction, not automatically linear in the atom mass. High-mass negative atoms can be protected by seeing their many negative labels, while low-mass false positives have low cost.

This suggests a possible source learner that never estimates $1/N_s$:

1. choose an empirical default label;
2. memorize sample atoms whose empirical label majority disagrees with the default;
3. on prediction, use the memorized correction if present and otherwise use the default.

For the uniform balanced realizable block, this gives a clean advantage of order $\operatorname{polylog}(1/\delta)/N_s$ from the memorized minority atoms. For a fixed active marginal $P_s=U(B_s)$, $N_s=s^s$ is still a polynomial in the representation size with $P_s$-dependent degree $s$, so this is compatible with a marginal-dependent source gap.

### Why Prediction-Time Randomization Is Not A Clean Atlas Fix

If prediction-time randomized hypotheses were allowed as first-class outputs, the one-sample correction could be packaged as a stochastic classifier: draw a remembered correction at prediction time and otherwise use the default. Its expected risk can be analyzed directly, and the construction is naturally gap-oblivious.

The atlas definitions, however, consistently say the learner outputs a hypothesis $h$ with zero-one error. They allow randomized learners, but they do not explicitly allow stochastic prediction rules as the final hypothesis. A training-time randomized singleton is allowed, but then the PAC success probability must be high over the training sample and internal randomness. Expectation over the learner's final random choice is not enough.

Thus prediction-time randomization is useful as a diagnostic, not yet as a resolution. To use it in the atlas, one would need either:

1. an explicit convention that improper hypotheses may be randomized classifiers with risk interpreted in expectation over prediction randomness; or
2. a derandomization or aggregation argument producing an ordinary binary hypothesis with the same marginal-dependent gap.

Without that convention change, randomized hypotheses do not settle the edge.

### Sample Splitting: Validation Is Overkill, Safety Filtering May Not Be

The naive sample-splitting idea was: construct singleton candidates, validate them on a holdout set, and choose the empirically best. That indeed needs holdout size on the order of $N_s$ or $N_s^2$ to resolve a $1/N_s$ advantage, and is incompatible with the full-support/pathwise resource uniformization.

But a different split might only perform safety filtering, not gap estimation. The point would be:

- high-mass atoms are easy to recognize coarsely because they repeat often;
- if a high-mass atom has mostly default labels, do not let one rare noisy opposite label flip it;
- low-mass atoms may be memorized after one opposite label because their total harm is small;
- constants cover the case where the label bias is not close to $1/2$.

This kind of rule does not need to certify that the final improvement is $1/N_s$. It only needs to prevent a low-noise corruption from creating large excess error. The hidden gap can then be proved after the fact from the collision mass of the corrected region.

I do not have a complete high-confidence proof for this rule over all marginals and all agnostic conditional label distributions. The missing estimate is a uniform lemma of the following form.

> Let $B$ be a finite block and let $\mathcal C$ contain balanced hidden labelings on $B$ plus the off-block zero behavior. For the empirical-default, majority-memorization learner with $r=\operatorname{poly}(\log(1/\delta))$ samples, show that for every marginal $P$ and every distribution $\mathcal D$ with $\operatorname{OPT}_{\mathcal C}(\mathcal D)\le \alpha_P(s)$, the learner improves on the better constant by at least a fixed fraction of the realizable collision handle, except with probability $\delta$.

If such a lemma is true, the keyed half-block route becomes much more credible as a relativized separation. It would give the source weak agnostic guarantee without any gap-scale validation.

### Changed Construction To Try

The better separation attempt is no longer "certify one true positive atom." It is:

1. Keep the keyed random balanced half-blocks $B_s$ with $N_s=s^s$ for the target lower bound.
2. Use a source learner based on empirical default plus majority-memorized exceptions, with constants included implicitly as the no-exception cases.
3. Analyze its source gap via collision mass. On a balanced active block, the clean collision handle is about $1/N_s$ for one correction and about $r/N_s$ for $r$ safe corrections.
4. For a fixed global marginal $P$, only finitely many blocks can have mass close enough to $1/2$ for constants to fail. Choose $K(P)$ larger than the sizes of those exceptional blocks; all other blocks get a constant advantage, and the exceptional blocks get their collision gaps.
5. Keep the oracle lower bound against the distribution-free target: under $U(B_s)$, any polynomial-time improper learner sees or queries only $\operatorname{poly}(s)$ atoms, so even arbitrary aggregation of all seen labels gives advantage at most $\operatorname{poly}(s)/N_s$, which is below $s^{-d}$ for every fixed $d$ at large $s$.

This construction would also answer the "nonboostable handle" concern in a cleaner way. The source handle is aggregable, but only up to the number of observed atoms. The distribution-free target is allowed polynomially many observations, and that still buys only $\operatorname{poly}(s)/s^s$, not a fixed inverse-polynomial advantage.

### Does This Prove The Bottleneck Blocks The Route?

No. The bottleneck blocks the validation route, not the entire keyed half-block route.

A black-box lower bound saying "any agnostic source must estimate the tiny gap" is false in spirit: low-noise weak guarantees can often be proved by choosing a smaller hidden gap and using constants outside the low-noise regime. The learner need not know the hidden gap. What one can plausibly prove instead is a narrower no-go:

> Any source learner whose only protection against noisy false singleton handles is holdout comparison among candidates needs sample size polynomial in $1/\alpha_P(s)$.

That no-go would explain why ERM/validation fails, but it would leave empirical-majority memorization, stochastic correction, and other gap-oblivious safety rules untouched.

### Current Conclusion

Depth 5 reopens the keyed half-block oracle route rather than closing it. The prior agnostic obstruction was too tied to validation. A gap-oblivious memorization learner may be able to achieve the marginal-nonuniform weak agnostic source with a hidden gap of order $1/N_s$ on active blocks, while the target lower bound remains essentially unchanged.

I still would not mark the edge false. The source proof is not complete, and the atlas does not clearly allow prediction-time randomized hypotheses. But the right next attempt is now a positive source lemma for empirical-majority memorization, not a no-go theorem about estimating $1/N_s$.

### Depth-6 Directions

1. Prove or refute the empirical-default, majority-memorization lemma above on one finite block. Track the clean collision advantage and the agnostic noise harm separately.

2. Decide the randomized-hypothesis convention. If stochastic prediction rules count as improper hypotheses, formalize the one-sample stochastic correction first; if not, derandomize it by storing many corrections in one binary lookup hypothesis.

3. Build the full relativized keyed half-block statement in two lemmas: a source lemma for every fixed global marginal $P$, and an oracle target lower bound for $U(B_s)$ against each fixed polynomial-time improper learner.

4. Check whether the source lemma survives arbitrary nonuniform marginals inside a block, especially mixtures with a few high-mass noisy atoms and a huge low-mass balanced residual.

5. If the majority-memorization lemma fails, isolate the failing distribution. It may become the desired black-box bottleneck: a low-noise agnostic distribution where every gap-oblivious sample handle either overfits false atoms or loses the $1/N_s$ collision advantage.

verdict: unresolved-open
confidence: 0.77

## Depth-6 Final Followup 2026-05-05: Orientation Barrier For Hidden Handles

- depth: 6
- date: 2026-05-05
- focus: final pass on the depth-5 randomized-handle/gap-oblivious route and possible theorem routes
- verdict: unresolved-open
- confidence: 0.86

### Additional Checks

This pass reread the endpoint definitions, the current edge note, `full-support-marginal-uniformization`, `low-noise-weak-agnostic-robustification`, and the depth-5 scratch work. I also checked the relevant outside theorem route represented by Feldman's distribution-specific agnostic boosting and the representation-independent lower-bound template of Kearns--Valiant.

The theorem route still does not close the edge. Feldman's theorem is useful because it keeps the instance marginal fixed while boosting agnostic weak learners, but it still starts from a supplied distribution-specific weak advantage/oracle and its quantitative cost depends on that advantage. It does not turn

$$
\forall P\ \exists K(P):\gamma_P(s)\ge s^{-K(P)}
$$

into one exponent $K$ uniform over $P$. Kearns--Valiant/PRF-style lower bounds can support the target-hardness side of a separation, but by themselves they make the source fail on marginals concentrated on the hard region. Thus I found no overlooked standard theorem that proves either direction for this edge.

### Stress Test Of The Randomized Handle

The depth-5 one-sample handle correctly identified a gap-oblivious phenomenon, but the phenomenon appears to rely on prediction-time randomization.

On one hidden block $B$ of size $N$, suppose the clean target has positive mass

$$
a=\frac12+\theta
$$

under the active marginal. Let $h_0$ be "default $0$ plus memorized positive samples," and let $h_1$ be the all-one constant. If $m$ samples give a clean memorized-positive correction of size $C\approx m/N$, then, ignoring lower-order collision terms,

$$
\operatorname{err}(h_0)=\frac12+\theta-C,
\qquad
\operatorname{err}(h_1)=\frac12-\theta.
$$

The half-and-half stochastic classifier has expected error

$$
\frac12\operatorname{err}(h_0)+\frac12\operatorname{err}(h_1)
=\frac12-\frac{C}{2},
$$

independent of the tiny bias $\theta$. This explains why the randomized-handle idea looked promising: a stochastic predictor can average the two orientations and keep the collision gain without estimating whether the block is slightly positive-biased or exactly balanced.

The atlas definitions, however, ask the learner to output an ordinary hypothesis $h$ and measure its zero-one error. A randomized training algorithm may choose a random hypothesis, but the PAC success probability must be high over that choice. Sampling $h_0$ or $h_1$ only succeeds with constant probability in the transition regime.

### Deterministic Orientation Bottleneck

For deterministic hypotheses, the learner has to choose an orientation. This recreates a gap-scale testing problem even though the handle itself is gap-oblivious.

Take the same block and compare two clean realizable regimes:

1. $\theta=0$, where $h_0$ has advantage about $C$ and $h_1$ has no advantage;
2. $\theta=2C$, where $h_1$ has advantage about $2C$ and $h_0$ is worse than random by about $C$.

Distinguishing these regimes from labels requires resolving a bias of order $C$. With $m=\operatorname{poly}(s)$ samples and $N=s^s$, the collision gain is $C\approx m/N$, far below the $1/\sqrt m$ sampling fluctuation. A high-confidence orientation test would need on the order of $1/C^2$ samples, i.e. polynomial in $N$ rather than polynomial in $s$.

This does not prove that no clever deterministic source learner exists. It does refute the specific depth-5 empirical-default/majority-memorization lemma in its hoped-for form: the learner cannot both avoid gap-scale validation and choose the right deterministic default across the tiny-bias transition. The stochastic mixture evades this only by using prediction-time randomization, which is not currently part of the atlas convention for improper hypotheses.

### Consequence For The Keyed Half-Block Separation

The target lower bound for keyed half-blocks still looks plausible: under $U(B_s)$, a polynomial-time improper learner sees or queries only $\operatorname{poly}(s)$ atoms, so it cannot obtain inverse-polynomial advantage when $N_s=s^s$.

The source proof is the unresolved part. Realizable weak learning is plausible by constants plus sparse memorized handles. Weak agnostic learning is harder: low-noise labels near the tiny-bias transition force a deterministic source learner either to orient at resolution $m/N_s$ or to use stochastic prediction. The first option violates the full-support/pathwise resource constraint; the second needs a definition change.

So the keyed half-block construction remains a useful relativized near-miss, not an atlas-ready `false` witness.

### Final Atlas-Ready Summary

Recommended summary if the edge note is updated later:

> Open: restricting the source to realizable labels gives a single uniform-resource learner, by full-support resource uniformization, but only with a marginal-dependent weak advantage. Known boosting theorems amplify a supplied weak advantage rather than uniformizing its exponent, and current hidden-gap separation attempts either need prediction-time randomized hypotheses or gap-scale validation.

Recommended proof-status replacement:

> On realizable distributions, the source yields error at most $1/2-\gamma_P(s)$, where $\gamma_P$ may have a marginal-dependent inverse-polynomial exponent. Full-support marginal uniformization can make the source learner's pathwise sample and time bounds distribution-free, but it does not change the accuracy statement, which is still applied to the actual marginal $P$. A proof of the implication would therefore need a weak-gap uniformization theorem. Existing agnostic boosting results, including distribution-specific boosting, preserve or amplify a given weak advantage with quantitative dependence on that advantage; they do not supply one exponent uniform over all marginals. Conversely, PRF/Kearns--Valiant-style lower bounds and keyed half-block oracle templates can make the distribution-free weak target hard, but the source side has not been verified: deterministic gap-oblivious handles run into an orientation bottleneck at the hidden collision scale, while stochastic prediction is outside the current atlas output convention. No atlas-ready counterexample or proof is known.

Recommended metadata:

- `status: "open"`
- `evidence: unknown`
- `family: marginal-uniformization-open`
- `assumptions: []`
- `witnesses: []`

### Final Verdict

The final depth-6 pass does not resolve the edge. The correct obstruction is now more precise than the original note: resource uniformization is available; the missing piece is uniform weak-gap control. The best false route remains a hidden-gap keyed-block separation, but the deterministic weak agnostic source proof fails at the tiny-bias orientation step unless the atlas permits stochastic final hypotheses.

verdict: unresolved-open
confidence: 0.86
