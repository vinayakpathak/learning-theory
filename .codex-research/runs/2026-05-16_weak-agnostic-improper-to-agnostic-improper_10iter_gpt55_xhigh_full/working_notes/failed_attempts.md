# Failed Attempts

## F001. Direct KMV/Feldman Threshold Boosting

The fixed source gives an `(alpha, alpha-beta)` weak agnostic learner only when `alpha > beta`. KMV/Feldman-style boosting then leaves error roughly `OPT + alpha + epsilon`, so the final excess cannot be pushed below the fixed `beta` floor by this direct instantiation.

## F002. Direct Kalai-Kanade / Ghai-Singh Efficient Correlation Boosting

Efficient correlation-style boosters whose final guarantee contains an `epsilon_0/gamma_0` residual cannot use the fixed source to reach arbitrary excess. The source can only provide a constant additive correlation slack, and this leaves constant final excess.

This failure should not be generalized to all agnostic boosters: residual-free statistical boosters can accept constant slack but are not currently representation-uniform efficient in this model.

## F003. Unqualified da Cunha Plug-In As An Atlas Proof

The fixed source semantically matches da Cunha-Hogsgaard-Paudice-style weak conditions with constant parameters, especially `gamma_0=1`, `epsilon_0=2 beta`. The proof attempt fails as an atlas-efficient reduction because known generic algorithms enumerate weak samples, clean labelings, or candidate transcripts with exponents depending on weak sample size `m0`, dual VC/capacity terms, and `1/theta^2`.

The route remains useful as a conditional theorem if these enumerations can be replaced by a polynomial clean-witness menu or a polynomial final selector.

## F004. "epsilon_0 >= 2 beta Works For All gamma_0"

This parameter claim is false without additional assumptions. If best class correlation `rho` can be negative, then `epsilon_0 >= 2 beta` does not uniformly imply
$$
\operatorname{corr}(h)\ge \gamma_0\rho-\epsilon_0
$$
for arbitrary `gamma_0 < 1`. The corrected sufficient condition is
$$
\epsilon_0\ge 1-\gamma_0(1-2\beta),
$$
or the special case `gamma_0=1`, `epsilon_0=2 beta`.

## F005. Naive Clean-Batch Sampling

If a weak learner needs `m_A` examples and a near-optimal comparator has clean mass `1-eta`, the probability that a raw training batch is entirely clean is approximately `(1-eta)^{m_A}`. In the clean-mixture view, the useful excess clean mass may be `1-2 eta`. Either way, for `m_A` growing with representation size this is exponentially small.

This is an obstruction to blind sampling, not a lower bound against structured clean-witness generation.

## F006. Small Weak-Call Sample Size Implies Strong Clean Witness

A weak call on a clean distribution gives only fixed advantage, not clean error `epsilon`. Strong clean learning usually needs `T=Theta(log(1/epsilon))` weak calls. If each weak call requires a `k`-example clean witness, the total hidden transcript size is roughly `K=kT`, plus advice/randomness. Thus `k=O(log(1/epsilon))` gives quasi-polynomial exhaustive search, not polynomial time.

## F007. Ordinary Sample Compression Implies Random Clean Discovery

Existential compression does not imply that a random noisy tuple finds the right compression subset with inverse-polynomial probability. Exhaustive enumeration of `K`-subsets costs `n^K`, polynomial only for constant `K` unless there is an additional hitting-set, stability, or random-witness lemma.

## F008. Literal Hidden-Set Oracle Lower Bound

The statement "all polynomially many queried distributions have `OPT >= gamma` unless they identify the hidden clean component" is false for unrestricted queries. Point-mass, empirical-support, and artificial-relabeling queries can have `OPT=0` without carrying target-mass information about the hidden comparator.

The surviving goal is a restricted oracle theorem based on forced target-mass information, smoothness, and low coverage, not a broad black-box impossibility claim.

## F009. All-Functions / Random-Code Toy Model As Atlas Separation

Taking `C` to be all Boolean functions on `[N]` or a random-code oracle can illustrate black-box barriers, but it does not by itself give an efficient represented concept class with the required source learner. If `N` is the representation size, memorization may be polynomial; if representation size is `log N`, all functions are not succinctly represented.

## F010. Residual Forcing From Excess Alone

The attempted lemma "if the current predictor has excess over a comparator, then an observable residual query has comparator error below `gamma`" fails for high-loss and mistake-set filters. The four-cell accounting shows that the mass where both the comparator and current predictor are wrong can dominate the residual query while preserving positive excess.

In RCN, focusing on mistakes selects `Y != Z`, whose noise relative to `f` is at least the original noise for nonnegative `E[Zf]`. Agreement filtering helps only after the current predictor already exceeds the threshold
$$
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

## F011. Broad One-Sample Observable RCN No-Go From Global Correlation

The stronger claim that below-threshold global `r=E[Zf]` rules out every one-sample observable transformation depending on `(Y,Z)` is false. Sign-specific cells can have low posterior error even when the aggregate agreement cell remains above `gamma`.

The repair is to impose sign symmetry/sign equivariance, restrict to aggregate agreement/mistake filters, or require an atomwise hypothesis that every allowed observable cell has `f`-error at least `gamma`.

## F012. Public-Filter Identity As A Full Oracle Lower Bound

The soft public-filter identity is correct for target-preserving filters, but by itself it is not an oracle lower bound. A weak oracle is triggered by `OPT_C`, not by noise relative to a planted `f`. Public constants, public hypotheses, or other concepts can certify low `OPT_C` even when the hidden-target noise remains high.

To become a barrier, this route needs a restricted oracle model with smoothness/mass assumptions, a public-certificate rule for public low-OPT queries, a no-other-hidden-witness assumption, and an explicit information budget for oracle outputs.

## F013. Direct da Cunha 2026 Plug-In From The Atlas Source

The fixed source semantically matches the da Cunha 2026 weak condition, up to the `gamma0=1` endpoint or an interior parameter repair. The direct proof still fails as an atlas reduction because the theorem requires controlled output range `H=Range(A)`, sample size `m0`, primal and dual VC parameters, efficient evaluation, and a final vote search/ERM.

Even `m0=Theta(log s)` yields `n^{Theta(log s)}` tuple enumeration for `n=poly(s,1/epsilon)`, which is quasi-polynomial rather than atlas-polynomial.

## F014. Validating Individual Weak Hypotheses

Noisy validation can select among complete final classifiers in a polynomial list, but it cannot replace hidden-clean weak-call generation by validating individual base hypotheses. A hypothesis with advantage on the hidden clean slice may have original noisy error worse than `1/2`, so validation would discard it even though it is useful inside a hidden-clean boosting trajectory.

The surviving requirement is a polynomial list of complete final classifiers, or an efficient optimizer/selector whose generalization is justified.

## F015. Finite Bag Alone As A da Cunha Proof

Iteration 3 confirms that finite-bag reasoning only cleans up the final validation step. If a polynomial-size final list exists before held-out validation, global `Range(A)` capacity is unnecessary for selecting among that list.

The attempted stronger conclusion fails. A finite base bag generated from hidden clean data does not by itself imply clean-slice population accuracy; it can overfit the hidden clean sample. Also, using all `T`-wise votes over a polynomial bag is statistically finite but computationally expensive: `|B|^T` is quasi-polynomial when `|B|=poly(s)` and `T=Theta(log s)`.

## F016. Per-Call Logarithmic Clean Witnesses De-Enumerate The Transcript

The right parameter is total clean witness length, not per-call witness length. If a clean boosting trajectory uses `T` adaptive weak calls and each call depends on `k` fresh hidden-clean examples, then raw all-clean discovery pays roughly `p^{-kT}`. Thus `k=Theta(log(s/epsilon))` and `T=Theta(log(s/epsilon))` gives quasi-polynomial discovery, unless there is global compression, path selection, robustness to wrong branches, or an efficient final selector.

## F017. Broad `p^K` Lower Bound For All De-Enumeration

The hidden-mask anti-hitting bound is valid only for explicit candidate transcripts chosen without useful information about the hidden clean indicators, and only when success literally requires all `K` distinct positions to be clean.

It does not rule out repeated-coordinate denoising, posterior-biased filtering, public clean certificates, class-structured noisy recovery, implicit optimization over transcripts, or generation of complete final classifiers that never materialize an all-clean transcript.

## F018. Public-Filter Information Lemma As A Full Weak-Oracle Lower Bound

The adaptive public-filter information lemma is a real toy theorem, but promoting it to a weak-oracle lower bound still fails. It controls hidden-target noise for smooth target-preserving filters, not arbitrary `OPT_C` queries. Public constants, artificial relabelings, empirical/spike queries, and other concepts can make `OPT_C` low for reasons unrelated to the hidden target.

A lower-bound model must specify the query grammar and either use canonical adversarial weak-oracle replies or charge every returned hypothesis, handle, and evaluation to the transcript information budget.

## F019. Clean-Transcript Anti-Hitting As General Necessity

Iteration 4 refines the `p^K` obstruction but also confirms it is not a general necessity theorem. The union-bound or KL-transfer anti-hitting proof assumes an explicit clean-certificate model: every successful complete final classifier must be covered by named all-clean positions, and the transcript must be mask-neutral or have its mask information explicitly charged.

This excludes real escape mechanisms: posterior-biased clean regions, repeated-coordinate denoising, noisy statistical recovery, class structure, implicit optimization over exponentially many certificate-like objects, public low-`OPT` witnesses, and oracle-output leakage. The result should be used only to diagnose proof skeletons such as literal hidden-clean tuple enumeration.

## F020. Implicit Vote Selector As A Free Atlas Reduction

Replacing explicit `|B|^T` vote enumeration by an "implicit optimizer" does not close the edge. Once a polynomial population-valid bag `B` is available, final vote selection is a separate problem: for unrestricted real weights it is agnostic halfspace learning over the feature map `x -> (h_i(x))_{i=1}^M`; for nonnegative or bounded `T`-wise votes the exact constrained class must be analyzed.

The fixed weak learner for `C` supplies neither a generic halfspace selector nor a pricing oracle over all hidden tuple outputs. Convex surrogate methods are not justified without a concrete margin, calibration, or surrogate-regret theorem. The hidden-clean bag-generation and clean-population transfer bottlenecks remain upstream.

## F021. Classical Decoding Hardness As An Improper-PAC Separation

The direct coding-theory separation based on nearest-codeword, minimum-distance, or maximum-likelihood decoding hardness fails in the improper PAC model. On polynomial coordinate domains, table learning ignores the code and learns to Bayes risk. On deterministic received words, an improper learner may fit the received word rather than output or identify a nearby codeword.

The surviving route is narrower: a succinct huge-domain code family with efficient distribution-free weighted/soft low-noise weak learning, but hard sample-access improper RCN prediction at a larger noise rate. No concrete family satisfying both sides is known from iteration 4.

## F022. One-Step Public Residual Forcing From Excess

Iteration 5 refutes the attempted proof step:

"If `g` has positive excess over a near-optimal comparator `c`, then some public residual filter/relabeling has comparator error below `gamma`."

For a public sigma-field `G`, every public filter/sign relabeling is governed by the posterior `eta_G=Pr[c(X) != Y | G]`; the best possible comparator error is the lower tail of `min(eta_G,1-eta_G)`. Positive excess only controls an average loss gap and is compatible with flat public posterior `eta_G=eta in (gamma,1/2)` everywhere.

This failure is local. It does not rule out algorithms that first create lower-posterior public cells, nor does it rule out low-`OPT_C` queries witnessed by public constants, artificial relabelings, empirical/spike supports, or other concepts.

## F023. Direct Anchor-Doping Support Refinement

The direct anchor-doping strategy fails as a generic upgrade from fixed additive slack to `epsilon`-accurate optimization.

If doped labels equal a public anchor with probability `1-lambda`, then for `lambda <= beta` the anchor itself is always a legal improper weak answer. For larger `lambda`, a single doped support-function query still has constant additive slack; a target-bad hypothesis can remain legal unless the query direction separates the target-bad legal-output set by more than `2 beta`.

The proper cap-separation criterion is useful as a diagnostic, but it is not an atlas theorem because the source is improper and query directions must be normalized sampleable distributions. Adaptive anchor sweeps would require a separate adversarial-oracle or indistinguishability proof.

## F024. Hard-Core Low-OPT Chunk From Duality Alone

The hard-core/dense-model idea does not prove a low-`OPT` chunk lemma from excess alone. Convex duality over public filters gives a CVaR-style lower-tail problem for the public posterior comparator error, but it does not show that the lower tail is below `gamma`.

The algebra
$$
\operatorname{err}(g,Y)-\operatorname{err}(c,Y)
=E[1_{g\ne c}c(X)Y]
$$
identifies the hidden set `{g != c}` as a clean/noisy distinguisher. That set depends on the comparator and is not publicly sampleable without additional information.

Even if a public query makes `c` a below-`gamma` witness, a full positive proof still needs a boosting/update argument translating the weak response into original-risk progress.

## F025. Ordinary CSP Approximation Gaps As Improper Separations

Iteration 6 confirms that standard Max-CSP gaps do not instantiate the approximation-gap separation template.

All-positive encodings are improperly vacuous: if examples are constraints and `Y=1`, then `h=1` has zero error. Signed/RHS encodings only make sense when the desired sign is a label, not part of the public input; if the RHS is exposed in `x`, an improper predictor can read it.

For fixed-arity CSPs over `n` variables, the full constraint descriptor domain has size `n^{O(k)}`. A table/empirical-majority predictor strongly agnostically learns to Bayes risk plus `epsilon`, so fixed-arity Max-SAT, Max-Cut, and ordinary constant-arity CSP gaps cannot separate weak improper from strong improper learning.

The surviving route is a much stronger assumption: a succinct or superpolynomial query domain, an efficient distribution-free signed/weighted weak approximator, and direct sample-access improper prediction hardness for the same evaluation class.

## F026. Overbroad Public Residual Low-OPT Lemma

The general proof principle

> positive excess over a near-optimal comparator forces some public residual query with `OPT_C < gamma`

remains false or unsupported. Iteration 6 extends the public-posterior obstruction to arbitrary public randomized relabeling kernels, but only for the query error of a fixed comparator and only relative to a chosen public view.

If the public sigma-field literally includes full `X` and `c` is a fixed deterministic concept, then `c(X)` is measurable and the posterior-uncertainty argument degenerates. If the claim is about `OPT_C`, public constants, anchors, empirical spikes, or other concepts can witness low `OPT_C` for target-useless reasons. Even when a query has low `OPT_C`, an improper fixed-slack weak learner may return a legal public witness with no original-risk descent.

The restricted flat-posterior counterexample should be kept as a one-step residual-forcing obstruction, not as an atlas lower bound.

## F027. Convex Or LP Final Selector From The DCHP Hidden Margin

Iteration 6 extracted the exact da Cunha-Hogsgaard-Paudice final class as `sign(B^(T))`, a bounded nonnegative `T`-wise sparse majority over the generated bag. The known algorithm performs empirical `0-1` ERM over this class and pays the `|B|^T` search cost.

The attempted shortcut "use the proof's margin to run convex/LP selection on noisy validation data" fails as a proof extraction. The margin certificate is on the hidden clean sample determined by the unknown near-optimal comparator, not on the noisy validation distribution. LP selection would need observable clean constraints, a polynomial explicit bag, rounding to the exact `T`-wise class, and clean-population transfer. Generic surrogate minimization needs a separate calibration or margin theorem.

This does not rule out a future exact sparse-majority selector, but it records that DCHP does not already supply one and that selector progress would still leave hidden-clean tuple generation and range/dual-VC control unsolved.

## F028. Generic `ApproxSparseMajorityERM(B,T)` As A Free Primitive

Iteration 7 refutes the hope that worst-case proper ERM over the exact DCHP final class is generically efficient. Two Set-Cover gadgets show that, for arbitrary binary bags, deciding whether a zero-error `T`-wise sparse majority exists is NP-hard and W[2]-hard parameterized by `T`. Inverse-polynomial additive empirical ERM would also distinguish zero from nonzero optimum.

This does not refute all selector routes. The hardness is for arbitrary bags and proper 0-1 empirical selection. It does not rule out selectors for DCHP-generated bags, margin-certified instances, structured no-constant/no-complement bags, relaxed convex votes with a rounding theorem, surrogate objectives with a proved calibration theorem, or explicitly generated polynomial final lists.

## F029. Free Regularization Of An Arbitrary Supplied Weak Learner

Iteration 7 gives a rare-slice junk construction showing that semantic `OPT+beta` validity alone does not bound the global range or dual VC of the particular weak learner handed to a black-box reduction. Even the constant class has valid weak learners that modify a good constant on a query-small random key slice while encoding high-dimensional coordinate junk there.

The failed overclaim is broader: this is not a class separation, not a proof that all canonicalization is impossible, and not a compression or stability lower bound without extra definitions. A white-box wrapper may strip transparent junk, and a class-aware proof may ignore the supplied learner or construct a different controlled one.

## F030. Off-The-Shelf Succinct Signed-CSP/Refutation Separation

Iteration 7 found no CSP/refutation candidate satisfying both sides of the approximation-gap template. Fixed-arity explicit CSPs are still table-learnable in the improper model. All-positive labels and public RHS/sign encodings are trivial. Log-arity XOR avoids polynomial table learning, but the weak side already becomes noisy sparse-parity prediction with nontrivial advantage.

The new failed import is low-noise or noiseless random-CSP refutation hardness. If `OPT_C <= eta < gamma`, the assumed fixed-slack weak learner itself gives an error below `1/2`, and fresh validation refutes iid random labels. Thus any refutation-style strong-side assumption must live in the hard band `eta >= gamma` and rule out arbitrary improper prediction/distinguisher hypotheses for the same sample-access class.

## F031. Parity/LPN As A Fixed-Constant Separation

Iteration 8 found a credible parity/LPN near-separation only for shrinking weak gap
$$
\gamma_n=1/2-\beta_n=O(\log n/n).
$$
The route does not instantiate the current source, which requires one representation-uniform constant `gamma>0`.

The weak-side all-clean batch proof needs `Theta(n)` clean parity equations. When `eta=OPT_C(D)=O(gamma_n)`, this has probability `exp(-O(n gamma_n))`, which is polynomially discoverable only for `n gamma_n=O(log n)`. For constant `gamma`, the probability is `exp(-Omega(n))`, and weak learning low-noise parities becomes the standard constant-noise LPN-hard task.

The surviving value is a boundary warning: fixed-constant slack and size-dependent slack behave qualitatively differently.

## F032. Public Parity Amplification By Products, Mixtures, Or Padding

Attempts to amplify the shrinking-gap parity near-separation into a fixed-constant separation by direct products, block mixtures, noise padding, or simple meta-classes fail whenever the construction preserves an efficiently sampleable public parity slice.

By L040, a fixed-constant weak learner for such an amplified class would imply a constant-advantage noisy-parity predictor on the slice. Padding does not help in the distribution-free model because the weak learner must also handle distributions supported entirely on the hard component.

This is not a proof against all exotic non-sliceable classes. It is a failed route for public parity-slice amplifications and a checklist item for any future parity-like construction.

## F033. Literal DCHP-Generated Set-Cover Hardness From Rare-Slice Programming

Iteration 8 explored whether the arbitrary-bag Set-Cover hardness for `sign(B^(T))` can be realized inside DCHP-generated bags using rare-slice or low-query-mass programmed weak outputs.

The supported core is L041: semantically valid weak learners can hide arbitrary columns on query-small or random key slices. The failed overclaim is that this already proves generated-bag hardness for the actual DCHP procedure.

Missing pieces include:

- actual DCHP weak-call distributions with low mass on the programmed hard slices;
- a formal stateless/stateful mechanism selecting which column `j` to output;
- confidence versus key-hit/coupon-collection accounting;
- iid generation of both programming tags and hard final rows;
- control of all extra generated columns in no-cover instances;
- availability of constants or offset columns;
- alignment between the Set-Cover gadget's `T` and DCHP's computed `T`.

Until these are supplied, rare-slice programming is a black-box generated-bag pollution obstruction, not a DCHP lower bound, not a learning lower bound, and not an atlas separation.

## F034. Log-Arity Signed XOR As An Approximation-Gap Separation

Iteration 9 audits the natural succinct signed-CSP candidate
$$
X_{n,k}=\{S\subseteq[n]: |S|=k\},\qquad
c_s(S)=(-1)^{\sum_{i\in S}s_i},
$$
with `k=Theta(log n)` and the RHS/sign kept as the label.

This avoids the constant-arity polynomial-domain table learner, and hard-band sparse-XOR prediction can be formulated as a plausible strong-side assumption. The weak side fails: a fixed-slack `OPT+(1/2-gamma)` learner queried on uniform RCN sparse-XOR labels with `eta<gamma` returns an evaluable hypothesis correlated with the hidden sparse parity. For `eta=gamma/2`, the correlation lower bound is `gamma/(1-gamma)`.

Thus log-arity XOR does not provide an independent weak approximator. It is a no-go checklist item for parity-like approximation-gap candidates, not a separation. Any hardness used here must be improper prediction hardness for the same high-entropy marginal, not search, recovery, value approximation, or refutation hardness.

## F035. Realized-Call DCHP Extraction As A Complete Positive Proof

Iteration 9 confirms a useful refinement but not a proof. Realized adaptive weak-call correctness can be handled locally with fresh population samples and confidence union bounds; global `Range(A)` or dual-VC control is not needed merely for the legality of polynomially many realized weak calls.

The attempted positive conclusion fails because the DCHP middle layer remains: an empirical hidden-clean transcript or generated bag must generalize to the clean conditional distribution `D_c^+`. Realized-call legality does not give this, and finite generated bag size can overfit the hidden clean sample. The final selector over `sign(B^(T))` also remains computationally hard in worst-case bags.

The right output is a conditional theorem with three explicit primitives: realized clean simulation, clean-population transfer, and polynomial final selector/list generation.

## F036. Literal DCHP Rare-Slice Set-Cover Hardness

Iteration 9 strengthens the warning that rare-slice programming does not yet transfer arbitrary-bag Set-Cover hardness to actual DCHP-generated bags.

The query-light block lemma is valid: if every weak-call distribution has mass at most `tau<beta` on a common block, arbitrary programmed columns on that block are legal weak outputs for the singleton class. The DCHP compatibility proof fails on several fronts:

- a final-relevant block is likely to be hit by a comparable weak-sample pool;
- repeated tuple enumeration can turn one hit into a spike call with `Q(S)=1`;
- many columns need a common key, requiring stateful or otherwise nonstandard scheduling;
- previous outputs may reveal the key to adaptive future calls;
- extra generated columns can destroy no-cover soundness;
- constants/offsets and the gadget budget `T` may not align with DCHP's computed `T`;
- `C={+1}` is strongly learnable, so the construction cannot be a learning separation.

Keep this as a black-box selector pollution obstruction, not as literal DCHP-generated hardness.

## F037. Ghost-Sample Clean Transfer As A Complete DCHP Middle-Layer Proof

Iteration 10 shows that an independent ideal clean ghost sample gives a valid finite-class transfer lemma, but this does not prove the atlas implication or the DCHP middle layer.

The attempted shortcut fails because DCHP-style generation certifies success on the hidden clean sample or transcript used to build the bag, not on an independent ghost clean sample. A bag can memorize the generation clean sample and fail on the ghost sample. If the ghost sample is used algorithmically, the clean mask is hidden; finding explicitly certified all-clean ghost tuples reintroduces the restricted anti-hitting costs.

Important correction: a raw ghost holdout of size `O(K/p)` contains `K` clean points with high probability when `p=Pr[Y=c(X)]` is bounded below. The exponential `p^{-K}` cost applies to explicitly naming all-clean certificates without mask information, not to the mere existence of clean points in a raw holdout.

## F038. Random Vote Lists From Mere Existence Of A Good Sparse Majority

Iteration 10 tests whether sampling polynomially many random `T`-wise votes can replace exact ERM over `sign(B^(T))`.

The conditional positive statement is valid only if a public sampler over final votes has inverse-polynomial mass on clean-good votes. Mere existence of one clean-good sparse majority gives no such mass. Needle-cover variants of the Set-Cover gadget can force a good vote to use a specific hidden `k=Theta(log s)` subset of columns and exact offset balance. Uniform or insufficiently informed product sampling then hits the vote with probability `exp(-Theta(log^2 s))`.

This does not rule out randomized final lists from a proved public pointwise-margin distribution, many-good-vote structure, or a sampler that has already identified the useful columns. It records that random listing is a separate sampler-mass primitive, not a free substitute for final selection.

## F039. Per-Call Stability Or Compression As A Full Positive Route

Iteration 10 weakens the stable-weak-learner route. Regularity of individual low-`OPT` weak calls does not by itself produce clean witnesses, prevent generated-bag overfitting, or solve final sparse-majority selection.

The regularity must apply to complete final classifiers or the whole adaptive clean-to-final mechanism. Total transcript compression must include all clean examples, weak-call choices, learner randomness, advice, selector state, and aggregation. Whole-generator stability must control the final clean loss on `D_c^+`. Distribution-dependent quotients must be final-relevant and non-circular, with computable representatives or an efficient selector.

Thus the route remains a conditional theorem schema:
`CleanDiscovery + CleanPopulationTransfer + PolynomialFinalSelectorOrList`.
It is not a consequence of the atlas fixed-slack source, and it may collapse back to the already-known clean-witness menu abstraction if the assumptions are too strong.
