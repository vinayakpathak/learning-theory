# Promising Directions

## D001. Polynomial Clean-Witness Menu Theorem

Formalize the following as the central conditional positive route:

If, for every distribution and near-optimal comparator `c`, a polynomial-time procedure can generate a polynomial-size list `L` containing some `h` with small `D_c^+` error, then validation over `L` yields strong agnostic improper learning.

Next work:
- State exact constants using L004 and L005.
- Keep the theorem independent of any particular boosting paper.
- Then prove sufficient conditions, such as compressed witnesses or random witnesses, that generate such a list.

Iteration 3 update: require the list to contain complete final classifiers and to be independent of the held-out validation sample. A polynomial base bag is not enough unless an efficient final selector or an explicitly polynomial final-vote list is supplied. Finite-list validation removes global capacity assumptions only for the final selection step.

## D002. Random Clean Witness

Try to prove or refute a reconstruction hypothesis:

For every clean realizable distribution `(X,c(X))`, a randomized reconstruction procedure using `K` clean examples plus `a` bits of enumerable advice/randomness outputs an `epsilon`-accurate hypothesis with probability `q`, where
$$
2^K2^a/q = \operatorname{poly}(s,1/\epsilon,\log(1/\delta)).
$$

If true, noisy tuple sampling plus validation gives a polynomial learner. The sharp bottleneck is total witness size `K`, not per-weak-call sample size.

Iteration 3 update: formulate this as the global clean-transcript menu lemma. Use `p=Pr[Y=c(X)]` and account for `p^{-K}q^{-1}` times advice/search cost. Separate enumerable advice from sampleable randomness. Per-call logarithmic witnesses are usually insufficient because total `K=m0T` can be `Theta(log^2(s/epsilon))`.

## D003. Enumerable Compression Witness

Develop a clean theorem saying when compression replaces da Cunha-style weak-sample enumeration.

Needed assumptions:
- every successful clean weak-output transcript decodes from at most `k` clean examples plus polynomially enumerable side information;
- decompressed hypotheses are efficiently evaluable;
- the final vote/search class has controlled generalization;
- either `kT=O(1)` for the number `T` of weak hypotheses, or there is a genuine polynomial-time final selector.

Logarithmic `k` only gives quasi-polynomial exhaustive enumeration unless a separate hitting-set or sampler is found.

Iteration 3 update: any compression route must show inverse-polynomial random discovery or provide a direct final classifier/selector. Existential compression, finite bag size, or bounded randomness alone does not imply that a raw noisy tuple hits a useful hidden-clean transcript.

## D004. da Cunha Runtime Audit

Read the relevant 2025 and 2026 da Cunha papers at theorem and algorithm level.

Questions:
- Which weak condition is used, with exact `gamma_0`, `epsilon_0`, and `theta`?
- Where exactly do `m0`, dual VC, and clean-label enumeration enter the runtime?
- Can the output range `H=Range(A)` be bounded from the atlas model, or must this be an explicit hypothesis?
- Does any part of the proof already imply a clean-witness menu lemma?

Iteration 2 update: the main audit is complete enough for working purposes. The 2026 proof enumerates hidden-clean weak samples and then searches over short votes, with runtime exponent depending on `m0`, `d*`, and `theta`. The next step is not more high-level audit but a formal conditional theorem with explicit assumptions on `H=Range(A)`, `m0`, `VC(H)`, `VC*(H)`, endpoint repair, and final selection.

## D005. Restricted Black-Box Oracle Barrier

Formalize a lower-bound model that is explicitly weaker than an atlas separation.

Candidate parameters:
- finite domain size `N`, sample budget `M`, query budget `q`, smoothness `L`, and gap `eta-gamma`;
- target-preserving smooth query marginals versus spike/empirical/artificial queries;
- oracle answers as black-box evaluable hypotheses with bounded information leakage;
- success measured by target-mass correlation with a random hidden comparator.

The theorem should use "forced target-mass information" as the invariant, not merely `OPT_C(Q)<gamma`.

Iteration 2 update: use the soft public-filter identity as the core. For target-preserving RCN filters `W=a+by`, crossing the weak threshold is equivalent to
$$
\frac{E[b(X)f(X)]}{E[a(X)]}>
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
The restricted theorem should now track: target-preserving filters, public-certified relabelings, empirical/spike queries, other-witness low-`OPT` queries, and oracle-output information leakage as separate cases.

Iteration 4 update: add the public-posterior obstruction as a local invariant. If every public cell still has comparator-error posterior `eta>gamma`, then public filtering and relabeling cannot force a low-noise query. A stopped-process barrier should track the first time this posterior invariant fails and charge the transcript information or public structure that caused the failure.

Iteration 5 update: the one-step public residual problem is solved in sigma-field form. The exact invariant with sign relabeling is `min(eta_G,1-eta_G)`. A stopped-process theorem should track the first time a public cell or smooth public filter has `min(eta_G,1-eta_G)<gamma`, and charge the clean-status/target information or public witness that made it possible.

Iteration 6 update: arbitrary public randomized binary relabeling kernels obey the same posterior-envelope principle with local uncertainty `u(G)=min{Pr[c=+1|G],Pr[c=-1|G]}`. Be careful about scope: if `G` contains full `X` for a fixed deterministic `c`, posterior uncertainty degenerates, so a serious stopped-process barrier needs either a coarse public view or a random-hidden-target/information-budget model. The theorem must still route public witnesses, empirical/spike queries, and other-concept low-`OPT` events separately.

## D006. Conditional Separation Template

Continue searching for a represented class with:

1. efficient distribution-free fixed-slack weak learning whenever `OPT_C < gamma`, and
2. hardness of learning to `eta+epsilon` under random classification noise for some `eta > gamma`.

The RCN identity would then convert strong agnostic learning into recovery of the hidden comparator. No candidate class from iteration 1 satisfies both sides.

Iteration 4 update: for code-based candidates, replace classical nearest-codeword hardness with succinct-domain improper RCN prediction hardness. Also require the weak side to be distribution-free weighted/soft low-radius learning under arbitrary coordinate marginals. Any candidate with polynomial coordinate domain or polynomial list-decoding/validation handles at noise `eta` is unlikely to separate the edge.

## D007. Posterior/Filtering Obstruction

Use L007 to rule out simple "filter until clean" strategies. Agreement conditioning only drops noise below `gamma` once the current predictor has correlation above
$$
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
This can be a sanity check for any proposed residual-forcing lemma.

Iteration 2 update: strengthen this into a local residual-forcing checklist. Any proposed observable residual lemma must survive the four-cell excess obstruction, the RCN agreement/mistake threshold, and the sign-specific-cell counterexample showing that global correlation alone is not enough for a no-go theorem.

## D008. Conditional da Cunha Theorem With Controlled Range

State a precise conditional theorem:

If the fixed-slack source has a weak implementation whose output range `H_s` has efficient evaluation, polynomial/effective primal VC, atlas-polynomial-safe dual VC, weak sample size `m0` bounded so that the 2026 exponent is representation-independent, and an efficient final selector over `sign(B^(T))`, then da Cunha 2026 plus validation gives the target strong agnostic improper learner.

Key checks:
- repair or audit the `gamma0=1` endpoint using L009;
- define `H_s` for fixed representation size, weak sample size, confidence, and randomness model;
- include the cost of weak calls as well as the final vote search;
- decide whether finite generated bags can replace global range capacity without circular data dependence.

Iteration 3 update: split the conditional theorem into two primitives: `HiddenCleanTranscriptGenerator` and `PolynomialFinalSelector/ListGenerator`. Finite bags can replace global capacity for held-out validation over complete final classifiers, but not for hidden-clean population transfer or exhaustive `sign(B^T)` search.

Iteration 4 update: treat `PolynomialFinalSelector` as a real additional primitive. For unrestricted real-weighted votes it is agnostic halfspace selection over generated features; for nonnegative convex votes or bounded `T`-wise votes, first extract the exact vote class from the da Cunha proof and state the corresponding selector/generalization guarantee. Convex optimization should be used only if a margin or surrogate-risk certificate is proved.

Iteration 9 update: rewrite this route as a three-layer conditional theorem:

- `RealizedCleanSimulation`: adaptive weak-call legality for actual fresh population calls, with explicit `m0`, seed, tuple, confidence, and clean-sample-size assumptions;
- `CleanPopulationTransfer`: a VC/dual-VC, compression, stability, independence, or clean-witness theorem proving population accuracy on `D_c^+`;
- `PolynomialFinalSelectorOrList`: an efficient selector for the exact `sign(B^(T))` class, or an explicitly generated validation-independent polynomial list of complete classifiers.

The first layer is the only one improved by realized-call union bounds. The second and third layers remain the real bottlenecks.

## D009. Adaptive Public-Filter Information Lemma

Prove the restricted random-target theorem cleanly.

Target statement: for `X=[N]`, random iid `f`, bounded target-preserving filters with mass at least `alpha`, and transcript information `I(F;T)=B`, the probability that the algorithm outputs a filter crossing the hidden-noise threshold is at most about
$$
\frac{B+\ln 2}{\tau_{\eta,\gamma}^2\alpha N}.
$$

Required safeguards:
- include the selected filter in the transcript or charge its description;
- use the corrected binary-event KL transfer;
- account for raw RCN samples and each oracle reply;
- keep the conclusion explicitly restricted to toy public-filter barriers.

Iteration 3 update: the toy theorem is now clean enough to record. State the event as `A_T >= alpha` and `R_T(F) >= tau`, with all randomness and the selected filter included in `T`, giving probability at most `(I(F;T)+ln 2)/(tau^2 alpha N/(2L))`. The next work is the stopped-process/oracle-output model, not the Hoeffding/KL calculation.

Iteration 5 update: add the per-example public-clean-status information bound as a local tool. If a public event of mass `mu` lowers comparator noise from `eta` to `gamma'`, then it costs at least `mu kl(gamma'||eta)` information about the clean indicator. This is useful for routing target-useful chunks, but does not replace transcript-level leakage accounting.

## D010. Target-Useful Low-OPT Queries

Separate low-`OPT` queries by why they are low-`OPT`:

- hidden-target filters, controlled by the public-filter identity;
- public relabelings or public constants, where the oracle may return the public witness;
- empirical/spike queries, which have too little target mass unless the marginal has heavy atoms;
- other-concept witnesses, which require a no-other-hidden-witness or random-code assumption.

This taxonomy is needed before any oracle barrier can claim that fixed-slack weak calls remain uninformative.

Iteration 3 update: make the taxonomy a formal routing lemma in a restricted model. Low hidden-target noise below `gamma` implies `OPT_C < gamma` only under singleton/no-other-witness assumptions; public witnesses, empirical/spike queries, arbitrary relabelings, and other concepts must be handled separately.

## D011. Observable Relabeling Minimax

Classify the strongest one-step observable residual transformation based on a current predictor `g` and samples `(X,Y)`. Model the finite cells induced by `c`, `g`, and `Y`, allow weights/relabelings depending only on observable quantities such as `(Y,g(X))`, and solve whether positive excess over `c` ever forces a query with `c`-error below `gamma`.

This was proposed in iteration 3 but not explored. It is a focused way to prevent future residual-forcing attempts from repeatedly rediscovering high-loss, mistake-set, or global-correlation failures.

Iteration 5 update: the finite/sigma-field version is now resolved negatively. Public filters and sign relabelings achieve comparator error exactly `ess inf min(eta_G,1-eta_G)`, so positive excess alone is insufficient. Future work on this direction should add extra assumptions one at a time, such as calibration, smoothness/mass, posterior variation created by transcript information, or a concrete update rule after a weak response.

Iteration 6 update: extend the formal statement from sign relabelings to general public randomized kernels. State it as a fixed-comparator/coarse-public-view lemma first, then separately attempt a random-hidden-target version that may condition on full `X`. Do not state the conclusion as `OPT_C>=gamma` without a no-other-witness assumption.

## D012. Regularize The Weak Learner

Investigate whether an arbitrary efficient improper fixed-slack learner can be transformed into one with controlled range, stability, compression, or canonical outputs. Possible tools include sample splitting, canonical empirical tie-breaking, validation-based pruning, or output compression.

The adversarial direction is equally important: construct weak learners that satisfy `OPT+beta` while encoding arbitrary sample-dependent bits or forcing large dual VC. A positive result would strengthen the da Cunha route; a negative result would justify treating controlled range as an extra assumption.

Iteration 7 update: the adversarial direction now has a concrete rare-slice junk construction. It shows that full semantic `Range(A)` and `VC^*(Range(A))` are not controlled by weak correctness alone, even for constants. Future positive work should avoid full-range assumptions by using realized bags, high-probability ranges, distribution-dependent quotients, or a white-box/class-aware construction of a new controlled learner. Future negative work needs a precise black-box-handle model before claiming canonicalization is impossible.

## D013. Explicit Clean-Certificate Model

Formalize the restricted theorem precisely enough that future attempts do not overclaim it:

- hidden mask distribution and whether clean indicators are iid/exchangeable;
- transcript `T`, including raw samples, weak-oracle replies, hypothesis handles, and selected certificates;
- certificate family `Sigma(T)`, branch weights, and distinct-position requirements;
- independent-coupling mass `mu=E_T sum_sigma w_sigma p^{K_sigma}`;
- information budget `I(S;T)` or a stronger joint budget `I((F,S);T)`.

The goal is not a general lower bound. The goal is a reusable diagnostic for da Cunha-style clean tuple enumeration and for any future proof skeleton that claims to de-enumerate hidden clean transcripts.

## D014. Vote-Selector Stress Tests

Before treating an implicit final selector as available, test it against:

- coordinate bags, where unrestricted votes are ordinary halfspaces;
- bags without complements, where `sign(conv(B))` is a restricted nonnegative threshold class;
- bounded `T`-wise votes, where integer weights and sparsity may change both hardness and algorithms;
- surrogate objectives, by seeking either a concrete margin/calibration theorem or a counterexample where low clean-conditional 0-1 risk does not lead to a useful noisy surrogate optimum.

Iteration 6 update: the exact da Cunha-Hogsgaard-Paudice selector class is
$$
V_{B,T}=\operatorname{sign}(B^{(T)}),
$$
a zero-threshold nonnegative integer `T`-wise majority with repetitions and `sign(0)=1`. Future selector work should split into three primitives: exact sparse-majority ERM, nonnegative convex-vote selection, and unrestricted real-threshold selection. Generic halfspace hardness only applies after complements/constants and rounding or margin assumptions are made explicit.

Iteration 7 update: generic exact sparse-majority ERM over arbitrary bags is now Set-Cover hard. Record `ApproxSparseMajorityERM(B,T)` as unavailable in worst case unless the selector uses extra structure. The next useful checks are: no-constant hardness, odd-`T`/alternate tie gadgets, complement-closed bags, DCHP-generated-bag realizability, and margin- or surrogate-promised selectors with explicit rounding/calibration theorems.

## D015. Anchor-Doping Oracle Game

The direct anchor-doping route is blocked: small mixtures can be answered by the public anchor, and one-call support-function forcing needs constant separation of the target-bad legal-output set.

Only pursue this further if formulating a precise black-box oracle game:

- define the allowed normalized, sampleable query directions;
- quantify target-bad outputs over the full improper legal-output universe, not only `C`;
- prove a consistent adaptive adversarial response strategy, or find a natural anchor family whose legal answer set is always original-`epsilon`-good.

Without such a game or anchor family, this should remain recorded as a failed direct support-refinement route.

## D016. Approximation-Gap Separation Checklist

Unexplored iteration-5 idea: look for represented classes with efficient distribution-free constant-factor or additive-constant agnostic approximation, but hard `OPT+epsilon` improper learning. If an algorithm gives `err <= a OPT + epsilon` and `a gamma <= 1/2`, it may yield a fixed-slack weak learner below the `gamma` threshold while constants handle the hard band.

This route is promising only under the strict atlas checklist: the weak side must be distribution-free and improper-compatible, the hardness must rule out arbitrary improper predictors, and validation/table-learning escapes on finite or structured domains must be excluded.

Iteration 6 update: the clean weak-side algebra is now:
$$
\beta>\frac{a-1}{2a}
$$
is enough for an `a`-approximate agnostic learner with tunable additive error to yield fixed-slack `OPT+\beta` weak learning, after adding constants and validation. The first CSP audit shows ordinary fixed-arity Max-CSP gaps fail in the improper model. Continue only with candidates that have succinct/exponential query domains and direct sample-access improper prediction hardness.

Iteration 7 update: add a hard-band sanity check. If the proposed strong-side assumption is a refutation hardness statement at noise `eta<gamma`, it conflicts with the weak learner, because weak learning plus fresh validation already distinguishes planted labels from random RHS. A viable refutation/improper-prediction assumption must live at `eta in [gamma,1/2)` and use the same descriptor marginal and class.

Iteration 9 update: log-arity signed XOR is now a failed benchmark for this checklist. It avoids table learning and supports a hard-band prediction assumption, but the weak side already implies low-noise sparse-parity prediction when `eta<gamma`. Continue only with classes that have an independently supplied low-noise signed weak approximator, not one equivalent to the intended hard prediction problem on a stress distribution.

## D017. Succinct Signed-CSP Or Refutation Candidate

If continuing the CSP route, make the candidate explicit before invoking any hardness theorem:

- define the query descriptor `x` and ensure the desired RHS/sign is a label, not public input;
- prove or cite a distribution-free signed/weighted approximation algorithm giving additive `kappa<1/2` or agreement ratio `alpha>1/2`;
- formulate strong-side hardness as arbitrary improper prediction of `c_\sigma(X)` under a sample-access distribution, preferably RCN or refutation-style;
- rule out table learning by making the effective domain superpolynomial or succinct;
- check the two extremes separately: biased OR/k-SAT may be public/baseline-trivial, while XOR/parity may make the weak side hard.

Record standard fixed-arity Max-CSP gaps as failed background, not as candidate separations.

Iteration 7 update: no off-the-shelf candidate passed. Log-arity XOR avoids the polynomial-domain table learner but makes the weak side a noisy sparse-parity prediction task. Generic high-arity Max-CSP approximation ratios are usually too small for a prescribed `beta`, and explicit approximation algorithms do not automatically become distribution-free signed weak learners after succinctization. Search next in algebraic or synchronization-style classes with an independently supplied low-noise signed approximator and a separate high-noise improper prediction assumption.

Iteration 9 update: record the formal sparse-XOR stress test. For uniform `k=Theta(log n)` sparse parity with RCN noise `eta=gamma/2`, fixed-slack weak learning gives correlation at least `gamma/(1-gamma)` with the hidden sparse parity. Any future signed-CSP candidate should be tested against this same low-noise stress distribution before invoking high-noise hardness.

## D018. Shrinking-Gap Parity Warning Note

Formalize the iteration-8 parity near-separation as a separate warning for a size-dependent weak-slack variant, not for the current atlas edge.

Needed theorem statement:

- `C_n` is the parity class over `F_2^n`;
- weak slack is `gamma_n=1/2-beta_n` with `n gamma_n=O(log n)`;
- the weak learner repeats `exp(O(n gamma_n))` clean-batch trials, solves linear systems, adds constants, and validates with accuracy `o(gamma_n)`;
- the span-capture lemma is applied to `D_X | [Y=c^*(X)]`;
- strong `OPT+epsilon` improper learning under uniform constant-noise RCN implies a correlated evaluable parity predictor and hence breaks LPN under a stated search/prediction assumption.

Use this note to police definitions: if a future source notion lets `gamma` shrink with representation size, parity becomes a serious conditional non-implication candidate. If the source is fixed-constant, this route is only a boundary example.

## D019. Parity-Slice No-Go Checklist

Before pursuing any parity-based amplification, explicitly test whether the class exposes an efficiently sampleable/evaluable parity slice.

Checklist:

- give the embedding `phi`;
- identify the restricted concept `c'_s(phi(x))=chi_s(x)` or a known sign flip;
- check representation blowup is polynomial;
- check the weak learner can be run on distributions supported on `phi(F_2^n)`;
- check returned hypotheses are evaluable on embedded fresh inputs.

If all checks pass, L040 blocks the construction under standard LPN assumptions. Continue only with genuinely non-sliceable constructions that also have an independent constant-slack weak approximation algorithm.

## D020. Generated-Bag Pollution Audit

Turn rare-slice programming into a precise black-box selector obstruction, or record exactly why it cannot hit actual DCHP-generated bags.

Required audit items:

- exact DCHP weak-call distributions and whether they are low-mass or key-smooth on proposed hard slices;
- whether constants or offset columns are appended or can be legally generated;
- stateless versus stateful weak learner model, and how column index `j` is selected;
- confidence/key-hit/coupon-collector accounting for all generated calls;
- iid realization of programming tags and final hard rows;
- proof that extra generated columns are harmless in no-cover instances;
- alignment between the Set-Cover gadget's `T` and DCHP's computed `T`.

Until these are resolved, rare-slice generated-bag hardness should be used only as a no-free-structure warning against universal black-box selectors.

Iteration 9 update: split this into two tasks. First, prove the clean restricted theorem for query-light, oblivious generated-bag procedures with a common block and scheduled columns. Second, prove or refute literal DCHP compatibility via the spike-tuple and mass-tension tests: if a final-relevant hard block has mass `alpha`, can DCHP weak samples avoid producing calls with `Q(S)=1` while final samples still realize the gadget?

## D021. Ghost Clean Transfer As A Diagnostic

Iteration 10 turns the ghost-sample idea into a precise diagnostic rather than a proof of the edge.

Useful theorem to formalize:

- A final class/list `V_T` is fixed independently of an ideal clean ghost sample from `D_c^+`.
- Finite-class, VC, compression, or stability generalization transfers ghost-clean empirical success to population clean success.
- The theorem explicitly assumes a ghost-good event; it does not prove that event.

Next work:

- State exact sigma-field independence: no dependence on ghost covariates, labels, masks, or correlated seeds.
- Separate raw ghost sample size from mask access: `O(K/p)` raw examples contain `K` hidden clean points, but identifying or using them is a separate problem.
- Use anti-hitting only in explicit mask-neutral certificate models, with distinct-position certificates and information charging.

This direction is most valuable as a way to test proposed DCHP middle-layer proofs. A proof that only fits the generation clean sample still fails the ghost diagnostic.

## D022. Random Vote Sampler-Mass Route

Iteration 10 identifies the exact condition under which random final lists replace sparse-majority ERM:
$$
\Pr_{v\sim \Pi_B}[\operatorname{err}_{D_c^+}(v,c)\le \alpha]\ge 1/\operatorname{poly}.
$$

Promising positive sufficient condition: find a public, computable distribution `q_B` over bag elements with pointwise clean margin on most of `D_c^+`; random `T`-wise majorities from `q_B^T` then work by Hoeffding.

Required checks:

- `q_B` must be computable from the public transcript/bag, not from `c`, clean labels, or `D_c^+`.
- The margin must be population-level and pointwise or high-mass, not merely aggregate correlation.
- The margin must be inverse-polynomial so `T` remains polynomial.
- Upstream clean-population transfer for the bag remains separate.

Negative benchmark: needle-cover arbitrary bags show that nonempty good sparse-majority sets can have quasi-polynomially small mass under label-oblivious product samplers. Future positive random-list claims must prove a genuine mass/spread lemma.

## D023. Final-Level Stability, Compression, And Quotients

Iteration 10 refines the regularization route.

Potential sufficient assumptions:

- `FinalTranscriptCompression`: complete final classifiers reconstruct from total `K` clean examples plus `b` advice/randomness with `p^{-K}2^b/q` polynomial and clean error `O(epsilon)`.
- `WholeGeneratorStability`: the full adaptive clean-sample-to-final-classifier map has a high-probability stability generalization bound under `D_c^+`.
- `EffectiveFinalQuotient`: the complete final classifier family has a polynomial effective cover under `D_c^+`, with computable representatives or an efficient selector.

Do not pursue per-call regularity alone. It does not discover hidden clean calls, does not prevent final overfitting, and does not solve `sign(B^(T))` selection. Any theorem in this direction should keep the three modules explicit:
`CleanDiscovery`, `CleanPopulationTransfer`, and `PolynomialFinalSelectorOrList`.
