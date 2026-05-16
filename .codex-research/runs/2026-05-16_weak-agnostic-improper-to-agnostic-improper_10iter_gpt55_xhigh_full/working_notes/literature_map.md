# Literature Map

## Agnostic Boosting Families Checked In Iteration 1

### Ben-David, Long, Mansour 2001; Gavinsky 2003

Relevance: early fixed-`beta` agnostic boosting notions. Iteration reports treat these as evidence that older fixed-`beta` guarantees do not give full additive `OPT + epsilon` learning.

Status: useful background, but primary theorem-level details still need direct audit before making a strong claim.

### Kalai, Mansour, Verbin 2008; Feldman 2010

Relevance: threshold-style weak agnostic learners. A fixed `OPT + beta` learner instantiates their weak condition only above threshold `alpha > beta`, yielding guarantees with an `alpha` floor rather than arbitrary `epsilon`.

Status: supports failed route F001. Exact theorem statements should be cited before atlas-level prose is updated.

### Kalai-Kanade 2009; Ghai-Singh 2024/2025

Relevance: efficient potential/correlation-style agnostic boosting. These routes require a multiplicative best-correlation condition with additive slack. When their final bounds retain an `epsilon_0/gamma_0` term, fixed additive slack leaves constant excess.

Status: supports failed route F002 for that theorem family. Do not state this as a general impossibility for all agnostic boosters.

### da Cunha et al. 2025, "Revisiting Agnostic Boosting"

Relevance: residual-free/statistical boosting can accept constant slack satisfying `gamma_0 > epsilon_0`, so fixed `beta < 1/2` is semantically compatible.

Status: important correction to the narrative that all strong agnostic boosting needs vanishing weak slack. Computational efficiency remains the issue because the method relies on exhaustive clean-label style enumeration.

### da Cunha, Hogsgaard, Paudice 2026

Relevance: strongest near miss. The fixed source matches the weak condition with `gamma_0=1`, `epsilon_0=2 beta`, and `theta=(1-2 beta)/2 = 1/2 - beta`. The reported sample bounds are near-optimal, but runtime includes exponents involving weak sample size `m0`, dual VC/capacity, and `theta`.

Status after iteration 2 audit: still the best positive near miss, but not an atlas proof. The 2026 algorithm enumerates ordered weak samples `I in [n/2]^{m0}` and returns an ERM over `sign(B^(T))`, with runtime of the form
$$
O(n^{m0+3})
\quad\text{and}\quad
\operatorname{Eval}_H(1)n^{O(m0\min\{d^*,\log n\}/\theta^2)}.
$$
This is polynomial in sample size only when the exponent parameters are fixed or representation-uniformly bounded. The theorem also needs controlled `H=Range(A)`, `VC(H)`, and `VC*(H)`. If the theorem statement excludes the endpoint `gamma_0=1`, use the interior repair from L009.

Iteration 3 refinement: finite-bag reasoning can replace global `Range(A)` capacity only for the final held-out validation over an already generated polynomial list of complete classifiers. It does not replace the hidden-clean empirical-to-population step, where a data-dependent bag may overfit, and it does not make ERM over all `sign(B^T)` votes computationally polynomial.

### da Cunha, Green Larsen, Ritzert 2025

Relevance: cited by an iteration-3 explorer as background on boosting, voting classifiers, and randomized sample compression.

Status: background only in this run. No ledger claim currently relies on this paper. It may be useful if a future route tries to turn finite vote bags or compression certificates into a de-enumerated clean-witness theorem.

### Classical Realizable Boosting And Compression

Sources discussed: Schapire 1990, Freund-Schapire 1997, Floyd-Warmuth 1995.

Relevance: clean realizable boosting and compression-style generalization are relevant once hidden clean examples or a clean witness are available.

Status: background only. These works do not solve hidden clean-witness generation through noisy agnostic data.

## Literature Gaps To Check

- Audit Gavinsky and BDLM directly to reconcile older fixed-`beta` limitations with residual-free da Cunha-style boosting.
- Inspect da Cunha proof details for the `gamma_0=1` endpoint and whether the finite generated bag can replace global `Range(A)` capacity assumptions without circular data dependence.
- Look for SQ/oracle lower bounds for weak-to-strong boosting that can formalize majority-constant leakage and adaptive smooth-query barriers.
- Search for random/stable compression or hitting-set results that convert existential clean compression into inverse-polynomial random discovery.

## Iteration 2 Public-Filter And Oracle-Barrier Background

### Kearns 1998 Statistical Query Learning

Relevance: background for restricted access and classification-noise robustness. The public-filter barrier has SQ flavor because smooth filters and low-leakage oracle replies resemble statistical access rather than arbitrary point queries.

Status: background only. The iteration-2 public-filter identities and mutual-information sketches are in-run arguments, not direct consequences of Kearns' theorems.

### Blum, Furst, Jackson, Kearns, Mansour, Rudich 1994

Relevance: background for SQ lower-bound thinking and weak learning under restricted statistical access.

Status: background only. Do not cite this as proving the public-filter barrier unless a precise SQ reduction or statistical-dimension statement is supplied.

### Hopkins, Kane, Lovett, Mahajan 2024

Relevance: cited in iteration-2 da Cunha-route exploration as related realizable-learning background.

Status: not yet used for a concrete claim in the ledger. Check only if a future route tries to replace agnostic boosting by a realizable-learning reduction with explicit computation.

## Iteration 2 Technical Takeaways

- Public-filter algebra is now a reusable local lemma: target-preserving filtering lowers RCN noise below the weak threshold only when the filter's label-asymmetric part already correlates with the hidden target.
- The adaptive information-theoretic version needs exact mass/smoothness parameters, a transcript information budget, and a public-certificate/no-other-witness rule.
- The da Cunha 2026 route should be cited as "polynomial in sample size with other parameters fixed," not as a representation-uniform efficient agnostic booster from arbitrary fixed-slack improper learners.

## Iteration 3 Technical Takeaways

- The da Cunha weak-condition translation is algebraically solid using the L009 interior repair; the remaining gap is not semantic weak learnability but hidden-clean transcript generation, clean-slice population transfer, and final vote selection.
- Finite validation can be cited only for validation-independent complete final classifier lists. It should not be cited as solving global output-range or dual-VC assumptions inside the hidden-clean proof.
- The global clean-transcript reconstruction lemma and hidden-mask anti-hitting lemma are in-run arguments, not results from the cited boosting/compression literature.
- The adaptive public-filter information theorem is an in-run random-target toy theorem using Hoeffding plus KL transfer. It should not be cited as an SQ or oracle lower bound without an explicit oracle-output leakage model and low-`OPT` query taxonomy.

## Iteration 4 Technical Takeaways

### Clean-Certificate Anti-Hitting

Relevance: iteration 4 upgrades the simple `Lp^K` union bound to an information-charged hidden-mask statement using the same binary-event KL transfer as the public-filter theorem.

Status: in-run restricted theorem only. It is useful for proof skeletons with explicit all-clean certificates and low transcript-mask information. It is not a black-box necessity theorem for fixed-slack weak-to-strong boosting.

### Implicit Vote Selection And Halfspace Hardness

Relevance: final vote optimization over a fixed polynomial bag can be phrased as threshold selection over generated features. For unrestricted real weights this is agnostic halfspace selection; for `sign(conv(B))` or bounded `T`-wise votes the weight restrictions must be kept explicit.

Status: conditional decomposition, not a positive theorem. Guruswami-Raghavendra halfspace-noise hardness and Tiegel improper halfspace hardness were cited by critics as warnings that a generic selector is a serious extra primitive. These citations should be directly audited and mapped to the exact vote class before being used as theorem-level support.

### Coding-Theory Separation Route

Relevance: iteration 4 clarifies that classical decoding hardness is mismatched to improper PAC learning. Proper code learning tracks weighted nearest-codeword distance, while improper learning may output arbitrary predictors.

Status: no instantiated separation. The viable template is succinct-domain sample-access RCN prediction hardness plus efficient distribution-free weighted/soft low-noise weak learning. Berlekamp-McEliece-van Tilborg, Dumer-Micciancio-Sudan, Guruswami-Vardy, and Guruswami-Sudan are background for coding hardness/list decoding, not direct evidence for improper PAC hardness.

## Iteration 5 Technical Takeaways

### Observable Residual Minimax

Relevance: iteration 5 solves the one-step public residual LP in the negative. Public filters and sign relabelings are controlled by the public posterior `eta_G=Pr[c(X) != Y | G]`; excess over `c` does not force a low-posterior public cell.

Status: in-run lemma, not literature-backed and not an atlas lower bound. It extends the local public-posterior obstruction and should be cited only as a sigma-field/finite-cell diagnostic.

### Anchor Doping And Support-Function Lock-In

Relevance: iteration 5 tests whether label-doping queries can refine a fixed additive oracle into an epsilon-scale optimizer without hidden clean transcripts. The direct route fails: small target mixtures can be answered by the public anchor, and one-call support-function forcing needs constant separation of all legal target-bad outputs.

Status: in-run black-box obstruction. The proper support-function cap criterion is a useful diagnostic but must not be promoted to the atlas-improper source without quantifying over improper outputs and valid sampleable query directions.

### Hard-Core / Dense-Model Analogies

Relevance: iteration 5 used hard-core lemma language to diagnose the desired low-OPT chunk lemma. Convex duality over public filters gives a lower-tail/CVaR problem for the public posterior comparator error, but classical hard-core results do not supply the missing low-OPT chunk.

Status: Impagliazzo 1995, Barak-Hardt-Kale, and Klivans-Servedio are background motivation only. Their theorem hypotheses should not be cited as proving any ledger claim here unless a future audit gives an exact reduction.

### Public Information Cost

Relevance: the per-example KL identity `I(S_c;G) >= mu kl(gamma'||eta)` for a public low-noise event is a clean diagnostic for why useful chunks require information about clean/noisy status.

Status: in-run information calculation. It complements, but does not replace, the stronger smooth random-target public-filter barrier with explicit transcript and oracle-output leakage accounting.

## Iteration 6 Technical Takeaways

### Approximation-Gap Template

Relevance: iteration 6 isolates a new conditional separation template. An efficient improper `a`-approximate agnostic learner with tunable additive error implies fixed-slack weak learning for every `beta>(a-1)/(2a)`, by combining the approximator with constants and validation.

Status: in-run algebraic lemma. It is useful because it reduces the weak side to constant-factor/additive-constant approximation, but no class is known that also has `OPT+epsilon` improper hardness.

### CSP Approximation Gaps

Relevance: CSPs were tested as the first approximation-gap candidate.

Status: failed as an ordinary separation route. Standard fixed-arity CSP domains are polynomial-size and hence table-learnable in the improper model. All-positive and RHS-exposed encodings are publicly trivial. Hastad/Raghavendra/Karloff-Zwick-type results are assignment-optimization background, not improper prediction hardness. Daniely-Linial-Shalev-Shwartz and Kothari-Livni-style refutation/improper-hardness frameworks are closer in spirit, but would still need to be paired with a signed/weighted weak approximator for the same succinct-domain class.

### Public Randomized Residual Kernels

Relevance: iteration 6 extends the one-step public residual obstruction from sign relabelings to arbitrary public randomized binary relabeling kernels.

Status: accepted as an in-run sigma-field lemma with restricted scope. It controls the query error of a fixed comparator relative to a public view; it is not a general `OPT_C` lower bound and must not be stated with full `X` in the sigma-field unless a random-hidden-target or information-budget model is used.

### da Cunha-Hogsgaard-Paudice Final Selector

Relevance: iteration 6 audits the exact final vote class in the 2026 proof.

Status: accepted source audit. The final class is `sign(B^(T))`, i.e. zero-threshold nonnegative integer `T`-wise sparse majorities over the generated bag, and the algorithm uses exhaustive ERM over that class. The hidden-clean margin certificate does not by itself justify noisy-label surrogate optimization. Future selector claims should distinguish exact `T`-wise votes, nonnegative convex votes, and unrestricted real thresholds.

## Iteration 7 Technical Takeaways

### Exact Sparse-Majority Selector Complexity

Relevance: iteration 7 replaces generic halfspace-hardness warnings with direct Set-Cover reductions for the exact DCHP class `sign(B^(T))`.

Status: accepted as in-run worst-case reductions for arbitrary tabulated bags. The reductions show NP-hardness and W[2]-hardness in `T` for zero-error proper empirical ERM, plus inverse-polynomial additive empirical hardness by the zero-vs-nonzero risk gap. They do not establish hardness for DCHP-generated bags, margin-promised instances, odd-`T` or alternate tie variants, relaxed convex votes, or improper empirical learners.

Literature support needed: standard NP-hardness and W[2]-hardness of Set Cover are the only theorem-level external facts required. Max k-Cover gap and parameterized approximation references are background until exact normalized empirical-risk gaps are written.

### No-Free-Regularization Weak Learners

Relevance: iteration 7 constructs rare-slice junk weak learners showing that semantic `OPT+beta` correctness alone does not control full semantic `Range(A)` or `VC^*(Range(A))`.

Status: accepted as an in-run black-box obstruction. It supports treating DCHP assumptions on `H=Range(A)` and dual VC as extra implementation assumptions. It does not imply an atlas separation, and it does not rule out white-box syntax stripping, class-aware replacement learners, realized-bag analyses, or distribution-dependent quotienting.

### Succinct Signed-CSP And Refutation Audit

Relevance: iteration 7 tests the approximation-gap template against succinct signed-CSP/refutation candidates.

Status: no candidate passes the checklist. The most useful refinement is the hard-band correction: if `OPT_C <= eta < gamma`, the fixed weak learner itself gives a validation refuter, so refutation hardness used for a separation must be at `eta >= gamma` and must rule out arbitrary improper prediction/distinguisher hypotheses. Kothari-Livni, Vadhan, Daniely-style average-case learning hardness, Makarychev-style Max-CSP approximation, and random-CSP refutation results are useful vocabulary/background but do not by themselves instantiate both sides of the atlas edge.

### Signed Approximation Thresholds

Relevance: iteration 7 corrected the weak-side algebra for multiplicative agreement approximators.

Status: accepted algebraic refinement. An additive agreement gap `kappa` gives slack `kappa`. A multiplicative agreement ratio `alpha` gives slack at most `1-alpha`; therefore `alpha>1/2` only yields some fixed slack below `1/2`, while a prescribed `beta` requires `alpha >= 1-beta` in the worst case.

## Iteration 8 Technical Takeaways

### Parity/LPN Boundary

Relevance: iteration 8 identifies parities as a credible conditional near-separation for a different size-dependent weak-slack notion with `gamma_n=O(log n/n)`. The weak side uses all-clean `Theta(n)` batches and a span-capture lemma over the clean conditional marginal. The strong side uses the RCN identity plus Goldreich-Levin-style recovery from an evaluable predictor correlated with the hidden parity.

Status: boundary warning only. It does not instantiate the current fixed-constant atlas source. LPN hardness is an assumption; Goldreich-Levin supplies the recovery mechanism from a correlated evaluable predictor, not the hardness assumption itself. The weak-side theorem still needs a clean standalone statement with constants, repetitions, and validation accuracy.

### Parity-Slice Amplification Obstruction

Relevance: direct products, block mixtures, padding, and simple meta-classes were tested as ways to turn the shrinking-gap parity near miss into a fixed-constant separation.

Status: accepted scoped obstruction. If the amplified class preserves an efficiently sampleable/evaluable parity slice, a fixed-constant weak learner for it gives constant-correlation noisy-parity prediction below the weak threshold. This aligns with the hard-band correction from iteration 7. It is not a theorem against genuinely non-sliceable classes.

### Rare-Slice Generated-Bag Pollution

Relevance: iteration 8 attacks the loophole in the sparse-majority selector hardness result: arbitrary-bag hardness does not automatically imply hardness for DCHP-generated bags. Rare-slice programming shows that semantic weak correctness alone can allow generated bags to contain arbitrary off-query columns in black-box settings.

Status: accepted as a black-box no-free-structure warning. It does not prove actual DCHP-generated Set-Cover hardness. The missing audit items are DCHP weak-call distributions, constants/offset availability, stateless versus stateful weak learner scheduling, iid realization, extra-column control, confidence/key-hit accounting, and `T` alignment.

## Iteration 9 Technical Takeaways

### Log-Arity Signed XOR / Sparse-LPN Audit

Relevance: iteration 9 tests the approximation-gap template on log-arity signed XOR, the cleanest succinct signed-CSP candidate. The descriptor domain is superpolynomial, and hard-band RCN prediction assumptions can be stated, but the weak side collapses to low-noise sparse-parity prediction.

Status: failed candidate, useful no-go. A fixed-slack weak learner for this class implies nontrivial prediction on uniform low-noise sparse XOR whenever `eta<gamma`; for `eta=gamma/2` the correlation lower bound is constant. Strong-side assumptions must be improper prediction/correlation hardness for the same high-entropy marginal, not search, recovery, refutation, or proper optimization hardness.

Literature status: Bogdanov-Sabin-Vasudevan 2019 and Mao 2026 are relevant sparse-LPN/noisy-`k`-XOR background, but no current ledger claim uses them as theorem-level hardness assumptions. Their role is to sharpen the distinction between prediction, detection, and recovery regimes.

### Realized-Call DCHP Extraction

Relevance: iteration 9 re-audits the DCHP route and separates capacity uses into realized weak-call validity, hidden-clean population transfer, and final selection/validation.

Status: accepted as a proof-layer refinement. Realized weak calls can be handled by fresh-sample union bounds under explicit sampling assumptions, so global `Range(A)` control is not needed for that layer. The hidden-clean population-transfer layer still needs VC/dual-VC, compression, stability, independence, or a new clean-witness theorem. Final finite-class validation is statistical only and does not solve sparse-majority optimization.

### Rare-Slice DCHP Compatibility Audit

Relevance: iteration 9 tries to upgrade rare-slice generated-bag pollution into literal DCHP-generated Set-Cover hardness.

Status: no upgrade. The query-light block lemma survives as a black-box selector warning, but literal DCHP compatibility remains blocked by final-relevant versus weak-light mass tension, spike tuple calls, common-key/statefulness assumptions, key leakage under adaptivity, extra-column soundness, constants/offset availability, and `T` alignment. Treat this as a scoped obstruction, not a learning lower bound.

## Iteration 10 Technical Takeaways

### Ghost-Sample Clean Transfer

Relevance: iteration 10 isolates an ideal ghost-clean transfer lemma. If a final class is fixed independently of a clean ghost sample from `D_c^+`, finite-class uniform convergence transfers empirical clean performance to population clean performance.

Status: standard in-run analysis lemma, not a new external result. It does not supply ghost-clean empirical success, clean-mask access, or final selection. Anti-hitting statements about ghost certificates must be scoped to explicit mask-neutral or information-charged hidden-mask models.

### Random Vote Lists

Relevance: random polynomial lists of `T`-wise votes would replace exact DCHP sparse-majority ERM if a public sampler put inverse-polynomial mass on clean-good votes. A high-mass pointwise margin distribution over the bag is a sufficient condition.

Status: conditional final-list primitive. Iteration 10 also records a needle-cover arbitrary-bag obstruction showing that nonempty good vote sets can have quasi-polynomially small mass under label-oblivious or insufficiently informed product samplers. This extends the Set-Cover selector warning but remains scoped to arbitrary bags, not literal DCHP-generated bags.

### Stability, Compression, And Quotients

Relevance: stability/compression/quotient assumptions were audited as possible replacements for DCHP's global `Range(A)`/dual-VC middle layer.

Status: conditional framework only. The assumptions must apply to complete final classifiers or the whole clean-to-final mechanism. Per-call weak-learner stability or compression is insufficient unless selector state, adaptive transcript information, randomness, advice, and aggregation are included. No new literature claim is made; standard stability or compression theorems need direct theorem-level auditing before atlas use.
