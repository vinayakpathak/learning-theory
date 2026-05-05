# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `marginal-uniformization-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

Target edge:
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac`.

Source node: one uniform learner $A$ works for every marginal distribution $P$ and every target $c \in \mathcal C$, outputs $h \in \mathcal C$, and has sample complexity and running time bounded by a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$. The polynomial may depend on $P$, but not on the target concept, requested accuracy, or confidence. The learner is not given distribution-specific advice.

Target node: one learner has proper realizable PAC guarantees with sample complexity and running time bounded by a single polynomial in the representation size, $1/\varepsilon$, and $\log(1/\delta)$, uniformly over all marginals.

The only axis change is `distribution: marginal-nonuniform-to-distribution-free`; realizability, properness, strength, and computational efficiency are otherwise the same. The atlas family note `marginal-uniformization-open` records exactly the missing computational uniformization step.

### Sources Checked

- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`.
- `atlas/definitions/efficient-realizable-proper-pac.md`.
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-proper-pac.md`.
- `atlas/arguments/marginal-uniformization-open.md`.
- `atlas/arguments/sample-complexity-equivalence.md`, for the already-settled sample-only marginal-to-distribution-free step.
- `atlas/registry/edge_families.yml` and `atlas/registry/axes.yml`.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page, last modified 21 Apr 2026, https://openreview.net/forum?id=aoVCFtox89, and the linked PDF. The current abstract/main theorem state the marginal-nonuniform rate trichotomy: finite classes have exponential rates, finite VC-eluder dimension has linear rates, and infinite VC-eluder dimension has arbitrarily slow rates; the PDF also states finite VC-eluder dimension is equivalent to finite VC dimension for the relevant binary classes.
- Benedek and Itai, "Learnability with respect to fixed distributions", ScienceDirect/DOI page, https://www.sciencedirect.com/science/article/pii/030439759190026X. The abstract emphasizes fixed-distribution learnability and explicitly says the main concern is sample count rather than computation; computational complexity is only considered for discrete distributions.
- Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability", TAU record/DOI page, https://cris.tau.ac.il/en/publications/a-parameterization-scheme-for-classifying-models-of-pac-learnabil/. The record says the paper classifies PAC models by uniformity parameters and concentrates on information-theoretic learnability rather than computational complexity.
- `atlas/witnesses/pseudorandom-function-classes.md` and `atlas/arguments/sample-to-computational-hardness.md`, to test whether the standard cryptographic witness separates this edge.
- `atlas/witnesses/clause-satisfaction-lookup-class.md` and `atlas/arguments/clause-satisfaction-proper-hardness.md`, to test whether the standard properness witness separates this edge.

### Theorem Attempt

Goal: turn the marginal-dependent polynomial-time learner $A$ into a distribution-free polynomial-time proper learner.

The sample part works. Ignoring runtime, the source gives a polynomial marginal-nonuniform sample guarantee. Hanneke--Moran--Thiessen's current trichotomy implies that polynomial marginal-nonuniform sample rates force finite VC dimension in the binary setting. Standard VC theory then gives distribution-free polynomial sample complexity, and unbounded ERM gives a proper sample-efficient learner. This is exactly the atlas's sample-complexity-equivalence route.

The computational upgrade is where the proof stops. A natural construction is to run $A$ with a timeout $T$ and validate the output on a holdout sample. For each fixed marginal $P$, some polynomial timeout $p_P$ suffices. But the target requires one polynomial timeout $q$ that works for all $P$. The source supplies no quantitative relation between $P$ and $p_P$, no bound on the degree or constants of $p_P$, and no compactness/continuity statement from which to extract a uniform $q$.

Point masses do not repair this. If $P=\delta_x$, the source only implies that $A$ runs in some polynomial time on samples supported at $x$, with a polynomial allowed to depend on $x$ through $P$. Taking a supremum over $x$ can be superpolynomial or infinite at each size. Thus pointwise polynomial behavior under every degenerate marginal does not imply a uniform polynomial worst-case bound.

Validation also does not identify a good timeout uniformly. If timeouts are dovetailed, then for every fixed $P$ the procedure may eventually find the right timeout scale, but the discovery time can depend on $P$. That gives another marginal-nonuniform or universal-style guarantee, not the target's distribution-free polynomial runtime.

### Counterexample Attempts

1. Pseudorandom function classes.

These do not separate the target edge as stated. Under the Kearns--Valiant/Goldreich-style cryptographic argument recorded in the atlas, there is a hard marginal distribution under which no randomized polynomial-time learner can even weakly learn the class. Since the source itself requires polynomial-time learning for every fixed marginal, with a polynomial bound allowed to depend on that hard marginal but still polynomial in the representation size and accuracy parameters, PRF classes fail the source rather than witness `source true, target false`.

2. Clause-satisfaction lookup class.

This is the right shape for properness hardness but not a resolved witness for this edge. The recorded atlas argument separates improper learning from distribution-free proper learning: proper hypotheses encode assignments, and a high-accuracy proper learner would solve SAT. However, to use it here one would need to prove the positive source statement, namely that one uniform proper learner has a marginal-dependent polynomial-time guarantee for every fixed clause marginal. The usual hardness reduction varies the marginal with the SAT instance; marginal-dependent constants could hide instance-specific cost, so the reduction does not immediately refute the source. Conversely, I did not find a source proving the required marginal-nonuniform proper learner for all marginals.

3. Artificial diagonalization.

One could try to build a representation-dependent class with distributions $P_k$ for which learning requires time about $s^k$, and a single learner that runs in time $s^k$ on $P_k$. This would satisfy a marginal-dependent polynomial bound for each $P_k$ while defeating every fixed polynomial. But making this atlas-grade would require a precise concept representation, a proof that every alternative distribution-free learner violates some $P_k$, and a primary complexity-theoretic source or fully formal time-hierarchy construction. I did not complete that construction at depth 0.

### Precise Obstruction

The source gives:

$$
\forall P\ \exists \text{ polynomial } p_P\ \forall c,\varepsilon,\delta:
\Pr[\operatorname{err}_P(A)\le \varepsilon]\ge 1-\delta
\quad\text{and}\quad
\operatorname{time}(A)\le p_P(s,1/\varepsilon,\log(1/\delta)).
$$

The target needs:

$$
\exists \text{ polynomial } q\ \forall P,c,\varepsilon,\delta:
\Pr[\operatorname{err}_P(B)\le \varepsilon]\ge 1-\delta
\quad\text{and}\quad
\operatorname{time}(B)\le q(s,1/\varepsilon,\log(1/\delta)).
$$

The quantifier swap from $\forall P\exists p_P$ to $\exists q\forall P$ is not supplied by the marginal-nonuniform sample trichotomy, Benedek--Itai fixed-distribution learnability, or Ben-David--Benedek--Mansour's information-theoretic parameterization. The recent Hanneke--Moran--Thiessen revision resolves the analogous polynomial sample-rate issue but does not appear to give a computational uniformization theorem.

### Final Verdict

`unresolved`.

I do not have an atlas-valid resolution to `true` or `false`. The sample-only shadow of the implication is true, but the computational edge remains blocked by the missing uniform polynomial runtime bound. The standard PRF and clause-satisfaction witnesses do not currently give a clean conditional false proof for this exact source/target pair.

### Concrete Follow-Up Directions

- Formalize the computational model for marginal-nonuniform bounds across representation sizes. In particular, decide whether a marginal $P$ is fixed per size $s$ or over a global instance space with $s$ as part of the examples. This matters because allowing $p_P$ to depend on a size-specific marginal can hide very large constants.
- Search specifically for "distribution-dependent polynomial-time PAC", "fixed distribution computational PAC", and "nonuniform computational PAC" results after Benedek--Itai. The primary sources checked here are mostly information-theoretic.
- Try to turn the artificial diagonalization sketch into a clean witness using a time hierarchy theorem: distributions $P_k$ should force runtime exponent $k$, while one universal learner has exponent $k$ on $P_k$.
- Revisit the clause-satisfaction lookup class under fixed marginals. If every fixed clause marginal admits a proper learner whose runtime is polynomial with marginal-dependent constants, then it may become a conditional false witness; if some fixed marginal still encodes NP-hard proper learning with a polynomial-independent lower bound, that would refute the source for the candidate.
- Check whether the Hanneke--Moran--Thiessen full revision or subsequent papers discuss computationally efficient marginal-nonuniform learners. The OpenReview page was last modified on 21 Apr 2026, so this should be rechecked before changing the atlas edge.

## Depth-1 Entry - 2026-05-04

### Question

Can the source guarantee

$$
\exists A\ \forall P\ \exists p_P\ \forall c,\varepsilon,\delta:
A \text{ properly learns } c \text{ under } P
\text{ in time } p_P(s,1/\varepsilon,\log(1/\delta))
$$

be uniformized to a distribution-free polynomial-time proper learner, or can one build a class where the best exponent genuinely depends on the marginal?

### Model Clarification

The atlas definition is best read as a **global-marginal** model, not a separate-marginal-per-size model.

In the global-marginal reading, the instance space $\mathcal X$ is fixed, concepts have a representation-size parameter $s$, and a marginal $P\in\Delta(\mathcal X)$ is fixed once. The same polynomial $p_P$ must then control all representation sizes and all targets $c\in\mathcal C$ under that one marginal. This matches the quantifier style in Hanneke--Moran--Thiessen's marginal-nonuniform definition: one learner, then for every marginal $P$ distribution-dependent constants, then all targets and all sample sizes. Their formal rate definition uses $\exists \hat h_n\, \forall P\, \exists C,c>0\, \forall f^*\in H$ and is purely statistical, with no runtime term.

The alternative **sizewise-marginal** reading is much weaker and probably not the intended atlas notion. If, for each size $s$, the adversary may choose an unrelated marginal $P_s$ and the source allows a separate polynomial $p_{P_s}$ for that single size, the runtime condition can hide arbitrary finite behavior in a size-dependent constant. A more coherent size-indexed variant would quantify over a whole family $(P_s)_{s\ge 1}$ and require one polynomial $p_{(P_s)}$ across all sizes. That is essentially the global-marginal reading with $\mathcal X$ replaced by the disjoint union of the size layers.

Thus the depth-1 convention should be:

$$
P \text{ is fixed across the size parameter, and } p_P \text{ must be one finite-degree polynomial across all } s.
$$

Under this convention, a proposed counterexample cannot merely give isolated distributions $P_k$ with exponents $k$. It must also survive arbitrary mixtures or size-family marginals that put mass on infinitely many hard layers.

### Literature Search Update

I searched for computational fixed-distribution, distribution-dependent, and nonuniform PAC uniformization results after Benedek--Itai. I did not find a theorem of the form needed here:

$$
\forall P\ \exists\text{ polynomial-time fixed-marginal learner}
\quad\Longrightarrow\quad
\exists\text{ distribution-free polynomial-time learner}.
$$

Sources checked:

- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 1991, DOI: https://doi.org/10.1016/0304-3975(91)90026-X. The abstract explicitly frames the main result as a fixed-distribution finite-cover/sample theorem. It also says the main concern is the number of examples, not computation; the learner-to-hypothesis function may even be undecidable or infeasible, and computational complexity is considered only for discrete distributions.
- Benedek and Itai, "Nonuniform learnability", JCSS 1994, DOI: https://doi.org/10.1016/S0022-0000(05)80005-4, and the Technion PDF https://csaws.cs.technion.ac.il/~itai/publications/Learning/nonuniform.pdf. The paper gives concept-nonuniform sample characterizations and examples learnable by polynomially many examples but "not necessarily in polynomial time"; it leaves characterizing fixed-polynomial learning time open.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", NeurIPS 2025/OpenReview, https://openreview.net/forum?id=aoVCFtox89. This is the strongest positive source for the sample-rate layer: finite VC dimension is equivalent to the linear marginal-nonuniform regime, while infinite VC dimension gives arbitrarily slow rates. The paper does not add a computational runtime uniformization theorem.
- Hopkins, Kane, Lovett, and Mahajan, "Do PAC-Learners Learn the Marginal Distribution?", ALT 2025, https://openreview.net/attachment?id=JKVYCLDdgp&name=pdf. This studies distribution-family PAC learning and says characterizing learnability under restricted marginals remains old and difficult; its results are about sample/statistical relationships among PAC learning, density estimation, and uniform estimation, not polynomial-time proper learning.
- Lechner and Ben-David, "Inherent limitations of dimensions for characterizing learnability of distribution classes", COLT 2024, https://proceedings.mlr.press/v247/lechner24a.html. This gives negative information-theoretic characterization results for distribution classes, including classification with restricted marginal distributions, but not a computational marginal-to-distribution-free collapse.
- Li and Vitanyi, "Learning Simple Concepts under Simple Distributions", SIAM Journal on Computing 1991, DOI: https://doi.org/10.1137/0220056. This is relevant because it has a polynomial-time version and a universal simple distribution phenomenon, but it restricts the distribution family to simple/enumerable distributions and therefore does not settle arbitrary-marginal uniformization.
- Blanc, Lange, Strassle, and Tan, "A Distributional-Lifting Theorem for PAC Learning", COLT 2025/arXiv, https://arxiv.org/abs/2506.16651. This is the closest computational positive result I found: it lifts efficient learners for a limited distribution family to distributions expressible as mixtures of that family, with overhead depending on the mixture/decomposition complexity. It is conditional on structural distributional decomposability, so it does not imply a single polynomial for all arbitrary marginals.
- Rajgopal and Santhanam, "On the Structure of Learnability Beyond P/Poly", APPROX/RANDOM 2021, DOI: https://doi.org/10.4230/LIPIcs.APPROX/RANDOM.2021.46. This gives unconditional lower bounds for learning very strong classes over the uniform distribution and robustness connections for classes beyond P/poly. It is useful background for computational learning hardness, but a hard fixed marginal would refute this edge's source rather than witness source-true/target-false.

Net result: post-Benedek--Itai work gives strong statistical distribution-family structure and some structured computational lifting, but I found no primary source resolving the atlas edge.

### Artificial Time-Hierarchy Witness Attempt

Depth 0 suggested distributions $P_k$ forcing runtime exponent $k$, with one universal learner taking time $s^k$ on $P_k$. The natural complexity-theoretic ingredient would be a deterministic time hierarchy theorem in the Hartmanis--Stearns tradition: for larger time bounds there are decision problems not decidable in smaller time bounds.

A plausible construction template is:

1. Partition the instance space into layers $X_k$.
2. Put in layer $k$ a proper-learning subproblem whose hypotheses encode a language or search task requiring time about $s^k$ but solvable in time $s^{k+1}$.
3. Let $P_k$ be a marginal supported on $X_k$.
4. Let the universal source learner first identify the active layer and then run the layer-$k$ solver.

This template still fails to be an atlas-grade counterexample for three reasons.

First, the source is uniform over targets for a fixed marginal. If a fixed marginal $P$ has support on many layers, then $p_P$ must be one finite-degree polynomial that works for targets from all those layers. If learning layer $k$ genuinely requires exponent $k$, then a marginal with nonnegligible mass on infinitely many layers threatens the source itself, not just the target. This is the main new obstruction beyond depth 0.

Second, the source quantifies over all marginals, including mixtures $\sum_k w_k P_k$. The learner may ignore layers of mass below $\varepsilon$, but an adversarially slow tail such as $w_k \asymp 1/k^2$ means that for accuracy $\varepsilon$ it may need to handle layers with $k$ growing as a function of $1/\varepsilon$. A runtime like $s^k$ is then not polynomial in $(s,1/\varepsilon)$ with fixed degree.

Third, lower-bounding **proper learning** is stronger than lower-bounding a decision problem. The construction would need a reduction showing that any proper PAC learner under $P_k$ solves the layer-$k$ hard task, while still ensuring that for every mixed marginal there is a marginal-dependent polynomial-time proper learner. I do not currently see how to make both sides true simultaneously.

This suggests that the naive hierarchy witness is not just incomplete; under the global-marginal reading it is structurally misaligned with the source. A counterexample may still exist, but it needs a more delicate mechanism than independent hard layers with unbounded exponents.

### Conditional Positive Route

There is a possible compactness-style route to `resolved true`, but it is not proved.

Suppose no distribution-free polynomial runtime exists for any learner. One would like to extract, for every candidate learner and every polynomial degree $d$, a bad marginal/target/parameter setting that forces failure beyond degree $d$, then mix those bad marginals into one global marginal $P^\star$. If the class allowed the corresponding bad targets to be combined consistently across mixture components, $P^\star$ would contradict the source's single $p_{P^\star}$.

The obstruction is concept compatibility. The bad target for component $k$ may be a different concept $c_k$, and an arbitrary concept class need not contain a single concept agreeing with all $c_k$ on disjoint components. Without such closure, the mixture argument does not automatically refute the source. This is exactly where an atlas-grade proof would need a new lemma or a representation-sensitive construction.

### Verdict

`unresolved`.

Depth 1 strengthens the unresolved verdict. I found no computational fixed-distribution uniformization theorem after Benedek--Itai that would prove the edge true. I also could not make the artificial time-hierarchy witness prove the edge false; once $P$ is interpreted globally across sizes, arbitrary mixtures of the $P_k$ distributions tend to destroy the source guarantee unless one can control all layers by one marginal-dependent finite-degree polynomial.

### Concrete Next Directions

- Add a model note before changing any atlas edge: "marginal" should mean a global distribution, or a size-indexed family of distributions with one polynomial across all sizes. Avoid the sizewise-per-$s$ reading because it makes the computational source nearly vacuous.
- Try to prove a restricted positive lemma: if $\mathcal C$ is closed under disjoint unions of concepts across size/layer blocks, then source true may force a uniform polynomial runtime by mixing bad marginals. This would not settle the atlas edge, but it would explain why layerwise hierarchy witnesses are hard.
- Search specifically for "distribution-family computational PAC learning", "distributional lifting PAC learning", "smart PAC learning marginal distribution", and "testable learning distribution family time lower bound". The Blanc--Lange--Strassle--Tan lifting theorem and recent smart/relative-smart PAC work look closer to computation than the older fixed-distribution sample-complexity papers.
- If pursuing a false witness, avoid pure exponent-per-layer constructions. Look for a class where every mixed marginal admits a polynomial bound because high-complexity layers become statistically ignorable fast enough under that same marginal, while no single distribution-free learner can know which layers are ignorable. This needs a carefully tuned tail/representation design.
- Re-check the Hanneke--Moran--Thiessen OpenReview revisions before atlas edits. The current page says published 18 Sept 2025 and last modified 21 Apr 2026; it remains a statistical-rate paper from the portions checked here.

## Depth-2 Entry - 2026-05-04

### Question

Focus on the component-to-mixture step.

Suppose the source node holds for an arbitrary mixture marginal

$$
P^\star=\sum_{i\in I} w_i P_i,
\qquad
w_i>0,\quad \sum_i w_i=1.
$$

If the source learner $A$ is accurate under $P^\star$, can this be converted into learners for the components $P_i$ with only polynomial overhead? If so, does this prove a positive uniformization theorem from `efficient-marginal-nonuniform-realizable-proper-pac` to `efficient-realizable-proper-pac`?

### Component-To-Mixture Lemma

There is a clean statistical lemma.

Let $A$ be run on labeled examples from $P^\star$ for a target $c\in\mathcal C$. If, with probability at least $1-\delta$,

$$
\operatorname{err}_{P^\star}(h,c)\le \eta,
$$

then on that same success event, for every component $i$,

$$
\operatorname{err}_{P_i}(h,c)
\le \eta/w_i.
$$

The proof is only the nonnegativity of component errors:

$$
\eta
\ge \operatorname{err}_{P^\star}(h,c)
= \sum_j w_j \operatorname{err}_{P_j}(h,c)
\ge w_i \operatorname{err}_{P_i}(h,c).
$$

Thus a single run that achieves mixture accuracy $\eta\le w_i\varepsilon$ is an $\varepsilon$-accurate learner for component $P_i$. For a finite set $J$ of components, choosing

$$
\eta\le \varepsilon \min_{i\in J} w_i
$$

gives simultaneous $\varepsilon$ accuracy on all components in $J$ with the same confidence parameter.

### Runtime And Weight Dependence

The source promise for $P^\star$ gives some polynomial $p_{P^\star}$ such that running $A$ at accuracy $\eta$ takes time at most

$$
p_{P^\star}(s,1/\eta,\log(1/\delta)).
$$

For one component $P_i$, the lemma therefore gives runtime

$$
p_{P^\star}(s,1/(w_i\varepsilon),\log(1/\delta)).
$$

If $p_{P^\star}$ has degree $d$ in its second argument, this is polynomial overhead in $1/w_i$; informally, one pays a factor on the order of $w_i^{-d}$ in the accuracy parameter. For a finite family of components with minimum weight $\alpha$, the simultaneous version pays polynomial overhead in $1/\alpha$.

This is useful but not uniform. The degree, constants, and even the relevant polynomial $p_{P^\star}$ are allowed by the source definition to depend on the whole mixture marginal $P^\star$, including the full tail of the weights and components. The PAC learner is not given a finite representation of $P^\star$, and the atlas representation-size parameter $s$ is the concept/hypothesis size parameter, not a mixture-description length. Therefore the expression above is not a distribution-free polynomial unless one separately assumes a uniform bound on $p_{P^\star}$ and a polynomial lower bound on the weights.

### Sampling Access Caveat

The lemma converts accuracy of a run under $P^\star$ into component accuracy. It does not, by itself, convert a standard PAC learner with samples only from $P_i$ into a learner that can run $A$ under $P^\star$.

Such a conversion is available only with extra access: for example, if the component learner is also given a sampler for $P^\star$, or if it is given samplers for all $P_j$ plus the weights $w_j$ and can synthesize labeled examples from the same target $c$ on every component. Standard distribution-free PAC access to component $P_i$ alone does not supply samples or labels from the other components.

This matters for the atlas edge. The source guarantee says that when the environment's marginal is $P^\star$, the single learner $A$ succeeds under $P^\star$. It does not hand a future learner for $P_i$ an oracle for $P^\star$. And if we simply run $A$ on $P_i$ samples, we are using the source promise for $P_i$, with its own unknown polynomial $p_{P_i}$, not extracting a uniform bound from the mixture.

### Consequence For Diagonal-Mixture Arguments

The lemma is still valuable for attempted uniformization proofs. It says that if a countable diagonal mixture $P^\star=\sum_i w_iP_i$ has a marginal-dependent polynomial bound, then every component with positive weight inherits a polynomial bound from $p_{P^\star}$ after paying $1/w_i$ in the requested accuracy.

This weakens simple exponent-per-layer counterexamples. If many hard layers have nonnegligible mixture weight, then a polynomial-time source learner under the mixture would also learn those layers, contradicting claims that they require unbounded exponents.

But the same calculation explains why the argument does not reach a distribution-free theorem:

1. In an infinite mixture, $\inf_i w_i=0$. Learning component $P_i$ through the mixture requires asking for mixture accuracy $w_i\varepsilon$, so the overhead can grow faster than any fixed polynomial in the component representation size.
2. The polynomial $p_{P^\star}$ itself may encode arbitrary dependence on the mixture marginal. The source quantifier is $\forall P^\star\exists p_{P^\star}$, not $\exists p\forall P^\star$.
3. A distribution-free learner for $P_i$ cannot assume sampling access to the particular diagonal mixture $P^\star$ used in the proof attempt.
4. Properness and target compatibility remain additional obstacles: a hypothesis that is good on the mixture is a single global concept, but constructing the mixture in a diagonal proof may require targets or hard instances that are not simultaneously realized by one concept unless the class has a special disjoint-union closure property.

Thus the component lemma gives pressure against crude counterexamples, but it does not perform the required quantifier swap.

### Relation To Known Mixture Lifting Results

This calculation is a near miss for recent distributional-lifting work, not a replacement for it. Blanc, Lange, Strassle, and Tan's COLT 2025 distributional-lifting theorem upgrades efficient learners for a limited distribution family to learners for distributions expressible as mixtures of that family, with overhead depending on the mixture/decomposition complexity. That is a structured positive theorem with explicit decomposition assumptions.

The atlas edge asks for something stronger and less structured: arbitrary marginals, no finite mixture representation counted in the input, and one polynomial-time proper learner uniform over all marginals. The component-to-mixture lemma does not provide those missing uniform bounds.

The statistical background remains consistent with Hanneke--Moran--Thiessen's marginal-nonuniform trichotomy: polynomial marginal-nonuniform sample rates collapse to the finite-VC side, but their result is a sample-rate theorem rather than a representation-sensitive runtime uniformization theorem. Benedek--Itai fixed-distribution learnability and Ben-David--Benedek--Mansour's parameterization also support the distinction between distribution-dependent statistical guarantees and computational uniformity.

### Conditional Positive Statement

A restricted positive theorem would be valid under extra assumptions.

Suppose there is a class of mixtures $\mathcal M$ such that:

- every component $P_i$ of interest appears in some accessible mixture $P^\star\in\mathcal M$ with weight $w_i\ge 1/\operatorname{poly}(s)$;
- the mixture sampler, or a decomposition sufficient to sample from $P^\star$, is available to the learner;
- the source learner has one polynomial envelope $p_{\mathcal M}$ over all such mixtures, rather than an arbitrary $p_{P^\star}$ for each mixture;
- target concepts are compatible across the components used in the mixture construction.

Then running the source learner on $P^\star$ with requested accuracy $\eta=w_i\varepsilon$ yields an efficient proper learner for $P_i$, with polynomial overhead in $1/w_i$. For finite mixtures with inverse-polynomial minimum weight, this is a straightforward corollary of the lemma.

These assumptions are real strengthening assumptions. They are not consequences of `efficient-marginal-nonuniform-realizable-proper-pac` as currently defined.

### Verdict

`unresolved`.

The component-to-mixture lemma is true in the statistical sense and gives a precise inverse-weight overhead:

$$
\operatorname{err}_{P^\star}(h,c)\le w_i\varepsilon
\quad\Longrightarrow\quad
\operatorname{err}_{P_i}(h,c)\le \varepsilon.
$$

Runtime becomes

$$
p_{P^\star}(s,1/(w_i\varepsilon),\log(1/\delta)),
$$

so any conversion depends polynomially on $1/w_i$ only after fixing the mixture-specific polynomial $p_{P^\star}$. This does not yield a distribution-free polynomial bound independent of the marginal, and it does not solve the sampling-access problem for a learner that only receives examples from $P_i$.

Therefore depth 2 does not resolve the atlas edge to true or false. It explains why mixture arguments are the right pressure test, but also why uniformization remains open without an additional theorem controlling mixture weights, mixture representations, and the marginal-dependent runtime polynomial.

### Next Directions

- Try to prove a restricted uniformization lemma for classes closed under disjoint unions, where diagonal mixture targets can be made compatible. This would clarify exactly how much closure is needed for the mixture pressure to become a proof.
- Look for computational PAC results where the runtime bound is uniform over a distribution family closed under mixtures or restrictions. Blanc--Lange--Strassle--Tan is the closest source checked so far.
- If searching for a false witness, make the high-complexity components have weights so small in every global mixture that the source polynomial can ignore them at ordinary accuracies, while still arranging that distribution-free learning must handle each component when it is the whole marginal. The $1/w_i$ term above is the key quantity to tune.
- Separate two black-box tasks in future notes: "mixture learner implies heavy-component accuracy" is true; "component-only PAC access can simulate the mixture learner" is false without extra access.

### References

- Gyora M. Benedek and Alon Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 1991, https://doi.org/10.1016/0304-3975(91)90026-X.
- Shai Ben-David, Gyora M. Benedek, and Yishay Mansour, "A parameterization scheme for classifying models of PAC learnability", Information and Computation 1995, https://doi.org/10.1006/inco.1995.1094.
- David Hanneke, Shay Moran, and Maximilian Thiessen, "Marginal-Nonuniform PAC Learnability", NeurIPS 2025/OpenReview, https://openreview.net/forum?id=aoVCFtox89.
- Guy Blanc, Jane Lange, Carmen Strassle, and Li-Yang Tan, "A Distributional-Lifting Theorem for PAC Learning", COLT 2025/PMLR, https://proceedings.mlr.press/v291/blanc25a.html.

## Depth-3 Entry - 2026-05-04

### Question

Can the positive direction be salvaged by fixing a deliberately chosen global mixture marginal

$$
P^\star=\sum_i w_i P_i
$$

and then, for an arbitrary target marginal $P$, simulating the $P^\star$-sample oracle needed by the source learner from ordinary distribution-free PAC samples drawn from $P$?

### Short Answer

No, not as a black-box PAC reduction. The mixture idea gives a valid accuracy-transfer lemma when the learner can actually be run on labeled samples from $P^\star$. It does not give a way to manufacture those labeled $P^\star$ samples from labeled samples drawn only from an arbitrary target marginal $P$.

This blocks the proposed positive theorem route. It does not by itself resolve the atlas edge false, because failure of this particular reduction is not a lower bound against all possible distribution-free learners.

### Sample Access Accounting

The target learner for `efficient-realizable-proper-pac` receives only examples

$$
(X,c(X)) \quad \text{with } X\sim P.
$$

To invoke the source learner under the chosen mixture marginal $P^\star$, the reduction would need examples

$$
(Z,c(Z)) \quad \text{with } Z\sim P^\star.
$$

These are different oracles. From samples under $P$, one can resample, subsample, or compute randomized functions of observed $P$-points. One cannot in general obtain labeled examples at fresh points distributed according to $P^\star$, because the PAC sample oracle labels only the points it draws. There is no membership-query oracle for $c(z)$ at arbitrary $z$, and no sampler for the off-$P$ part of $P^\star$.

The obstruction is especially stark when $P$ and $P^\star$ are mutually singular. If $P=\delta_x$ but $P^\star$ puts positive mass away from $x$, then every labeled example available from the target oracle is labeled at $x$. A simulator cannot output a correctly labeled example from the off-$x$ support of $P^\star$ unless it has extra label access. Conversely, if $P^\star$ is chosen to avoid this by setting $P^\star=P$, the argument collapses back to the source guarantee for $P$, with its unknown marginal-dependent polynomial $p_P$.

### Why Choosing A Universal Mixture Does Not Repair This

A tempting move is to choose a global mixture $P^\star$ with very broad support, perhaps one that gives positive weight to many or all possible target marginals. But the direction of simulation is wrong.

If the reduction had labeled $P^\star$ samples, then depth 2's component lemma would say that accuracy under $P^\star$ transfers to any component $P_i$ with overhead depending on $1/w_i$. But the distribution-free learner is given labeled samples from the component or target marginal $P$, not from the global mixture. Component samples do not contain the other mixture components, so they do not simulate mixture samples.

This is not merely an efficiency loss. It is an information/access mismatch:

$$
\text{samples from }P^\star \Longrightarrow \text{weighted information about components}
$$

but

$$
\text{samples from one arbitrary }P \not\Longrightarrow \text{labeled samples from }P^\star.
$$

The second implication can hold only under extra assumptions, for example:

- a membership-query oracle for the target concept $c$;
- an independent sampler for $P^\star$ together with labels under $c$;
- known domination plus a way to label accepted/reweighted points;
- a realizable setting where the labels on the off-$P$ support are somehow fixed or inferable from the labels on $P$.

None of these are part of the atlas definitions for the two nodes in this edge.

### Importance Weighting And Rejection Sampling Do Not Apply In General

One might try to transform $P$ samples into $P^\star$ samples by rejection sampling or importance weighting. These require assumptions absent here.

Rejection sampling from $P$ can only produce distributions absolutely continuous with respect to $P$. It cannot create mass in regions where $P$ has zero probability. Importance weighting can estimate $P^\star$ risks from $P$ samples only when $P^\star\ll P$ and the density ratio is controlled; the edge quantifies over arbitrary marginals, so no such domination or ratio bound is available. Even when risk estimation is possible, it still does not provide the actual labeled i.i.d. $P^\star$ samples expected by the source learner $A$ unless $A$ is rewritten to use weighted examples, which is not a black-box invocation of the source guarantee.

### Random Empirical Mixtures Also Do Not Give The Needed Uniformization

Another possible salvage is to form a random empirical marginal $\widehat P$ from the observed $P$ samples and run the source learner as though the environment were $\widehat P$. This also misses the target.

First, the source learner's guarantee is for i.i.d. labeled examples from the marginal under which its error is measured. If the final goal is low error under $P$, training under $\widehat P$ gives only empirical control unless an additional uniform convergence argument is supplied. Such an argument would be statistical, not the missing computational uniformization.

Second, the source runtime bound for $\widehat P$ is $p_{\widehat P}$, which may depend arbitrarily on the random empirical marginal. The target still needs one polynomial bound independent of $P$ and independent of the sampled empirical support. Thus replacing $P^\star$ by $\widehat P$ reintroduces the same quantifier problem rather than eliminating it.

### What The Mixture Argument Actually Proves

The valid black-box statement remains the depth-2 one:

If the learner can be run on labeled examples from

$$
P^\star=\sum_i w_iP_i
$$

and returns $h$ with

$$
\operatorname{err}_{P^\star}(h,c)\le w_i\varepsilon,
$$

then

$$
\operatorname{err}_{P_i}(h,c)\le \varepsilon.
$$

This is an accuracy-transfer result from mixture access to component guarantees. It is not a sample-oracle simulation from component access to mixture access.

So the direction useful for a positive theorem would need to be:

1. obtain labeled $P^\star$ samples;
2. run $A$ under $P^\star$;
3. transfer accuracy back to the target marginal.

The standard distribution-free PAC oracle supplies only step 3's target marginal samples, not step 1's mixture samples. The construction therefore cannot be implemented as a distribution-free PAC learner.

### Consequence For The Edge

The deliberately chosen global-mixture strategy does not salvage a proof of

$$
\text{efficient marginal-nonuniform realizable proper PAC}
\Rightarrow
\text{efficient distribution-free realizable proper PAC}.
$$

It fails at the oracle level before the runtime-polynomial issue is even reached. If one grants extra access to sample and label $P^\star$, then the mixture lemma applies but the resulting theorem is a strengthened-access result, not the atlas edge. If one does not grant that access, there is no general reduction from arbitrary $P$-sample access to labeled $P^\star$-sample access.

### Verdict

`unresolved`.

The proposed positive theorem route is definitively blocked by sample access mismatch: ordinary distribution-free PAC samples from an arbitrary target marginal $P$ do not simulate labeled samples from a deliberately chosen global mixture marginal $P^\star$. However, this only refutes the black-box mixture-simulation proof strategy. It does not prove a separating concept class, so the atlas edge remains unresolved rather than resolved false.

## Depth-4 Entry - 2026-05-04

### Final Question

Can the remaining mixture-uniformization obstruction be closed either way for

$$
\text{efficient-marginal-nonuniform-realizable-proper-pac}
\Rightarrow
\text{efficient-realizable-proper-pac}?
$$

Equivalently, does a single proper learner whose runtime is polynomial for each fixed marginal, with the polynomial allowed to depend on that marginal, force the existence of a distribution-free proper learner with one polynomial runtime bound over all marginals?

### Final Verdict

`unresolved`.

The depth-4 conclusion is that the available mixture argument is a genuine statistical transfer lemma, but it does not become a distribution-free computational PAC learner. The positive proof remains blocked by two independent issues:

1. ordinary PAC access to a target marginal $P$ does not provide labeled examples from a chosen mixture marginal $P^\star$;
2. even when one is allowed to run the source learner under $P^\star$, its runtime is bounded only by a mixture-specific polynomial $p_{P^\star}$, not by a uniform polynomial independent of the marginal.

I do not have an atlas-valid proof that the edge is true. I also do not have an atlas-valid separating class proving it false. The right atlas status remains `open` with evidence `unknown`.

### What Is Settled By The Mixture Calculation

For any mixture

$$
P^\star=\sum_i w_i P_i,\qquad w_i>0,\quad \sum_i w_i=1,
$$

accuracy under the mixture transfers to each component. If a hypothesis $h$ satisfies

$$
\operatorname{err}_{P^\star}(h,c)\le w_i\varepsilon,
$$

then

$$
\operatorname{err}_{P_i}(h,c)\le \varepsilon.
$$

This follows immediately from

$$
\operatorname{err}_{P^\star}(h,c)
=\sum_j w_j\operatorname{err}_{P_j}(h,c)
\ge w_i\operatorname{err}_{P_i}(h,c).
$$

Thus, if one can actually run the source learner on labeled examples from $P^\star$ at requested accuracy $w_i\varepsilon$, one obtains a component-accurate hypothesis for $P_i$. Runtime for this invocation is bounded by

$$
p_{P^\star}(s,1/(w_i\varepsilon),\log(1/\delta)).
$$

For a fixed finite mixture with inverse-polynomial lower-bounded weights and a known uniform runtime envelope over the mixture family, this would be enough for an efficient component learner. This is a valid restricted theorem, but its assumptions are stronger than the atlas source node.

### Why This Does Not Prove The Edge True

The attempted positive proof needs to turn a target-marginal PAC oracle into the mixture oracle needed by the source learner. That step is unavailable in standard PAC learning.

The target distribution-free learner receives samples

$$
(X,c(X)),\qquad X\sim P.
$$

To run the source learner under a deliberately chosen mixture $P^\star$, it would need samples

$$
(Z,c(Z)),\qquad Z\sim P^\star.
$$

There is no general transformation from the first oracle to the second. If $P$ and $P^\star$ are mutually singular, the learner never sees labels on the off-$P$ support of $P^\star$. Rejection sampling and importance weighting do not fix this without domination assumptions such as $P^\star\ll P$ and controlled density ratios, and those assumptions are absent from the distribution-free edge.

Choosing $P^\star=P$ avoids the sample-access mismatch, but then the runtime bound is just the source's marginal-specific polynomial $p_P$. That returns to the original quantifier problem:

$$
\forall P\ \exists p_P
\quad\not\Rightarrow\quad
\exists q\ \forall P
$$

by any argument currently available here.

Even granting direct access to labeled $P^\star$ samples would not finish the proof. The runtime expression

$$
p_{P^\star}(s,1/(w_i\varepsilon),\log(1/\delta))
$$

is polynomial only after the mixture marginal $P^\star$ is fixed. The source definition allows the degree and constants of $p_{P^\star}$ to depend on the entire mixture, including an infinite tail of tiny weights and hard components. Since the mixture description is not part of the learner input and no distribution-family envelope is supplied, this is not a distribution-free polynomial runtime bound.

### Why This Does Not Prove The Edge False

The failure of the mixture proof is not a lower bound. It only shows that this particular black-box route cannot establish the implication.

A false resolution would require a concept class $\mathcal C$ such that:

- one uniform proper learner succeeds for every fixed marginal $P$ with some marginal-dependent polynomial runtime $p_P$;
- no proper distribution-free learner has a single polynomial runtime bound over all marginals.

The natural hard-layer or time-hierarchy construction is still not atlas-ready. Under the global-marginal reading, the source must hold not only for isolated hard components $P_k$, but also for arbitrary mixtures over those components. If the layers require unbounded runtime exponents and a mixture gives infinitely many layers enough mass to matter at accuracy $\varepsilon$, then the source learner for that mixture may itself fail to have any finite-degree polynomial runtime. Making the tail weights small can make layers statistically ignorable, but then one must prove both source positivity for every possible marginal and target hardness for distribution-free learning. That construction has not been completed.

Known cryptographic or properness-hardness witnesses checked earlier also do not settle this exact edge. A hard fixed marginal refutes the source rather than separating source true from target false, while improper-versus-proper witnesses need an additional proof that every fixed marginal admits a marginal-dependent efficient proper learner.

### Atlas-Ready Unresolved Summary

Suggested frontmatter posture:

- `status: "open"`
- `evidence: "unknown"`
- `assumptions: []`
- `witnesses: []`
- `summary: "The statistical component-to-mixture transfer is valid, but it does not provide a distribution-free polynomial-time learner because PAC samples from an arbitrary target marginal do not simulate labeled samples from a chosen mixture marginal, and the source runtime bound remains a mixture-specific polynomial."`

Suggested body text:

The edge is unresolved. The sample-only analogue is supported by marginal-nonuniform sample-complexity results, but the computational version requires a uniform polynomial runtime bound over all marginals. The source guarantee has the form $\forall P\,\exists p_P$, whereas the target requires $\exists q\,\forall P$.

A natural mixture-uniformization attempt is only partially successful. If $P^\star=\sum_i w_iP_i$ and a hypothesis has error at most $w_i\varepsilon$ under $P^\star$, then it has error at most $\varepsilon$ under $P_i$. This component-to-mixture transfer is immediate from nonnegativity of errors. However, it assumes the learner can be run on labeled samples from $P^\star$. A distribution-free PAC learner for an arbitrary target marginal $P_i$ receives only labeled samples from $P_i$, and in general cannot synthesize labeled samples from the rest of the mixture.

Moreover, even with labeled access to $P^\star$, the runtime bound supplied by the source is $p_{P^\star}(s,1/(w_i\varepsilon),\log(1/\delta))$. The polynomial $p_{P^\star}$ may depend arbitrarily on the mixture marginal, including its tail weights and components. Without an additional uniform envelope over such polynomials, this does not yield the single polynomial runtime required for efficient distribution-free PAC learning.

Thus the mixture argument explains both sides of the obstruction: it rules out some naive hard-component counterexamples, but it also fails to prove computational uniformization. No primary-source theorem or completed separating construction currently resolves the edge to true or false.

### Final Follow-Up Recommendation

Do not change the atlas edge status based on this investigation. If updating the edge note later, keep it `open` and use the unresolved summary above. The most promising future work is either:

1. prove a restricted positive theorem under explicit extra assumptions, such as accessible finite mixtures with inverse-polynomial component weights and a uniform runtime envelope; or
2. construct a genuine false witness that remains source-learnable under arbitrary global mixtures, not merely under isolated hard component marginals.

## Depth-5 Entry - 2026-05-05

### Verdict

`open`, with a sharper conditional positive route.

I still do not have an atlas-valid resolution to `true` or `false`. The new depth-5 observation is that the edge would become `true` under a standard but currently unstated computational convention:

1. the effective instance domain is countable, for example encoded finite strings;
2. there exists a fixed marginal $P_0$ with full support on all possible encoded examples relevant to the class;
3. "running time at most $p_P$" means a pathwise or worst-case bound over every sample sequence in the support of $P$, not merely an in-probability or almost-sure bound under $P$.

Under those assumptions, the source learner itself has one distribution-free polynomial runtime bound: apply the source guarantee to $P_0$. Since every finite sample sequence has positive $P_0$-probability, the pathwise runtime and sample-use bound for $P_0$ bounds the learner on every possible finite sample sequence. Accuracy is already quantified over every marginal in the source. Thus the same proper learner is distribution-free efficient.

The atlas definitions and cited marginal-nonuniform sources do not explicitly commit to all three assumptions. Hanneke--Moran--Thiessen formulate marginal distributions over an arbitrary domain $\mathcal X$, and the atlas notes say only "running time" and "instance marginal distribution" without distinguishing worst-case, almost-sure, or high-probability runtime. Therefore this is not enough, by itself, to change the atlas edge.

### Definitions Used

Source:

$$
\exists A\ \forall P\ \exists p_P\ \forall c,\varepsilon,\delta:
A \text{ outputs } h\in\mathcal C,\quad
\operatorname{err}_P(h,c)\le\varepsilon
$$

with sample complexity and running time bounded by

$$
p_P(s,1/\varepsilon,\log(1/\delta)).
$$

The polynomial $p_P$ may depend on the marginal $P$, but not on the target concept, $\varepsilon$, or $\delta$, and $A$ is one uniform learner.

Target:

$$
\exists B\ \exists q\ \forall P,c,\varepsilon,\delta:
B \text{ outputs } h\in\mathcal C,\quad
\operatorname{err}_P(h,c)\le\varepsilon
$$

with sample complexity and running time bounded by one polynomial

$$
q(s,1/\varepsilon,\log(1/\delta))
$$

uniformly over all marginals.

The unresolved quantifier swap remains

$$
\forall P\,\exists p_P
\quad \text{versus} \quad
\exists q\,\forall P.
$$

### Sources Checked

- Local atlas definition: `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`.
- Local atlas definition: `atlas/definitions/efficient-realizable-proper-pac.md`.
- Local atlas implication: `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-proper-pac.md`.
- Local atlas argument: `atlas/arguments/marginal-uniformization-open.md`.
- Local atlas argument: `atlas/arguments/sample-complexity-equivalence.md`.
- Local atlas conventions: `atlas/README.md`, especially the statement that computationally efficient nodes require polynomial sample complexity and polynomial running time, while marginal-nonuniform nodes allow polynomial PAC bounds to depend on the instance marginal distribution.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page, https://openreview.net/forum?id=aoVCFtox89. The page says the paper studies a PAC variant where constants in the learning rate may depend on the marginal distribution and records the trichotomy of possible rates.
- Hanneke, Moran, and Thiessen PDF, https://openreview.net/pdf?id=aoVCFtox89. The PDF defines marginal-nonuniform learning over $\Delta(\mathcal X)$, with one learner, then $\forall P\in\Delta(\mathcal X)\,\exists C,c>0$, then all target concepts. This is statistical: it controls rates in sample size, not runtime.
- Benedek and Itai, "Learnability with respect to fixed distributions", https://doi.org/10.1016/0304-3975(91)90026-X and ScienceDirect page https://www.sciencedirect.com/science/article/pii/030439759190026X. The abstract gives the finite-cover characterization for a fixed distribution and explicitly says the main concern is sample count rather than computation.
- Benedek and Itai, "Nonuniform Learnability", JCSS 1994, DOI https://doi.org/10.1016/S0022-0000(05)80005-4 and Technion PDF https://csaws.cs.technion.ac.il/~itai/publications/Learning/nonuniform.pdf. The paper is relevant background for nonuniform sample bounds and leaves fixed-polynomial learning time as an open computational issue.
- Benedek and Itai, "Dominating distributions and learnability", COLT 1992, DOI https://doi.org/10.1145/130385.130413 and Technion record https://cris.technion.ac.il/en/publications/dominating-distributions-and-learnability/. This is the most relevant added source at depth 5: its abstract says transferring learnability from $D_1$ to $D_2$ needs absolute-continuity-style support inclusion without polynomial sample bounds, and a multiplicative domination condition when polynomial sample bounds are required.

### Theorem Route

There is a clean conditional proof under a countable full-support/worst-case-runtime convention.

Assume the example domain is countable. Choose a fixed marginal $P_0$ with full support, e.g. $P_0(x)>0$ for every encoded instance $x$. By the source node, there is a polynomial $p_{P_0}$ bounding the sample use and running time of the single source learner $A$ for all targets and parameters under $P_0$.

If the runtime bound is pathwise on every finite sample sequence in the support of $P_0$, then every possible finite sample sequence is covered, because $P_0$ has full support. Hence $A$ runs in time at most

$$
p_{P_0}(s,1/\varepsilon,\log(1/\delta))
$$

on every PAC sample sequence, regardless of the actual marginal $P$. The accuracy guarantee needs no further work: the source already says the same learner $A$ succeeds for every marginal $P$. Properness is also inherited because $A$ outputs $h\in\mathcal C$.

So, under those additional conventions, one may set $B=A$ and $q=p_{P_0}$, proving the target.

This route also explains why the earlier "point masses do not repair this" paragraph was too weak: individual point masses do not produce a uniform polynomial, but one countable full-support marginal might, provided runtime is genuinely worst-case on its support.

### Counterexample Route

The counterexample route is now more constrained.

Any false witness must avoid the full-support theorem above. It must exploit at least one of these gaps:

1. an uncountable domain with no countable full-support marginal covering all possible examples;
2. a runtime/sample-use promise that holds only almost surely, in probability, or on typical samples under $P$, rather than pathwise on every sample sequence in the support;
3. a computational model where the relevant representation-size parameter does not make all possible examples part of one countable encoded input universe;
4. a learner whose source guarantee is stated statistically in sample size, while its implementation can have marginal-dependent rare-path behavior not controlled by a single full-support distribution.

The known witnesses still do not settle this. A hard fixed marginal for pseudorandom functions or halfspaces refutes the source rather than separating source true from target false. Properness-hardness witnesses such as clause-satisfaction lookup classes still need a proof that every fixed marginal admits a proper marginal-dependent polynomial-time learner. Independent hard-layer diagonalizations remain blocked by arbitrary global mixtures unless the high-complexity layers are made ignorable under every mixed marginal in a way compatible with proper distribution-free lower bounds.

### Concrete Obstruction

The concrete obstruction is no longer just "mixtures do not simulate target samples." There are two possible readings:

On a **pathwise countable computational reading**, the edge should be true by the full-support-marginal argument above. This reading is natural for many encoded PAC models, but it is not explicitly stated in the atlas edge or definition notes.

On a **statistical arbitrary-domain reading**, the edge remains open. Hanneke--Moran--Thiessen use arbitrary $\mathcal X$ and distribution-dependent learning rates; Benedek--Itai fixed-distribution work is primarily sample-theoretic; and Benedek--Itai domination results show that transfer between distributions with polynomial sample guarantees needs strong domination hypotheses. None of these sources supplies a computational theorem converting marginal-dependent runtime polynomials into one uniform polynomial over arbitrary marginals.

The atlas currently mixes computational language with marginal-nonuniform statistical sources. Without a convention saying that efficient learners have worst-case polynomial runtime over encoded sample inputs, the full-support proof cannot be recorded as a theorem. Without a separating class, the edge also cannot be recorded as false.

### Atlas-Ready Text If Still Open

Suggested atlas posture remains:

- `status: "open"`
- `evidence: "unknown"`
- `assumptions: []`
- `witnesses: []`
- `summary: "Open under the atlas's current modeling conventions: the sample-rate part uniformizes, and a countable full-support marginal would uniformize worst-case runtime if such a convention were explicit, but the current notes do not state the countable/pathwise-runtime assumptions needed for that theorem. For arbitrary-domain statistical marginal-nonuniform learning, no source checked gives a uniform polynomial runtime bound."`

Suggested body text:

The edge is unresolved under the atlas's current definitions. The sample-only analogue is true by the marginal-nonuniform rate trichotomy and standard VC theory, but the computational edge depends on how one interprets the running-time promise.

There is a conditional positive proof in the usual countable encoded PAC setting with worst-case runtime. Choose a fixed full-support marginal $P_0$ over all encoded instances. If the source learner's runtime bound for $P_0$ applies to every sample sequence in the support of $P_0$, then that bound applies to every possible sample sequence. The same learner already succeeds for every marginal, so it is an efficient distribution-free proper learner with polynomial $p_{P_0}$.

However, the atlas definitions do not explicitly state countability of the effective instance domain or that the marginal-dependent runtime promise is pathwise rather than almost-sure or high-probability under the marginal. The primary marginal-nonuniform sources checked are statistical rate results over arbitrary domains, and fixed-distribution learnability sources do not provide the missing computational uniformization theorem. Benedek--Itai's domination result further indicates that transferring polynomial guarantees between marginals requires strong domination assumptions, not just arbitrary marginal dependence.

Thus the current atlas edge should remain open unless the atlas first adopts the countable encoded/worst-case-runtime convention. If that convention is adopted, the edge can be changed to `true` with `evidence: "theorem"` using the full-support-marginal argument.

No atlas files were edited in this depth-5 pass.
