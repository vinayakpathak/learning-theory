# Claim Ledger

## C001. Fixed-Additive Learning Equals Additive Correlation Approximation

**Status:** accepted.

**Claim:** For binary labels in `{-1,+1}`, the source guarantee
$$
\operatorname{err}_D(h)\le \operatorname{OPT}_C(D)+\beta
$$
is equivalent to
$$
\operatorname{corr}_D(h,Y)\ge \rho_C(D)-2\beta,\qquad
\rho_C(D)=\sup_{c\in C}\operatorname{corr}_D(c,Y).
$$

**Reason:** `err(g,Y)=(1-\operatorname{corr}(g,Y))/2` and `OPT_C=(1-\rho_C)/2`.

## C002. Hard-Band Silence For Fixed Slack

**Status:** accepted.

**Claim:** Let `beta=1/2-gamma`. If a query distribution `Q` has `OPT_C(Q) >= gamma`, then a hypothesis with error at most `1/2` is a legal weak-oracle answer.

**Reason:** `OPT_C(Q)+beta >= 1/2`. Equivalently, the correlation lower bound is nonpositive. The better of the two constants has error at most `1/2`, so an adversarial fixed-slack oracle can be non-informative on such queries.

**Caution:** A fixed dummy hypothesis need not be valid on every query; use a majority constant or an otherwise query-valid dummy response.

## C003. KMV/Feldman Direct Instantiation Leaves A Fixed Floor

**Status:** accepted as a theorem-family obstruction, pending exact theorem-number audit.

**Claim:** The source implies KMV-style `(alpha, alpha-beta)` weak agnostic learning only for `alpha > beta`:
$$
\operatorname{OPT}_C(D)\le 1/2-\alpha
\Rightarrow
\operatorname{err}(A(D))\le 1/2-(\alpha-\beta).
$$
Therefore KMV/Feldman-style conclusions of the form `OPT + alpha + epsilon` cannot yield `OPT + epsilon` for target accuracies below the fixed `beta` floor.

## C004. Efficient Multiplicative-Correlation Boosters Retain Constant Slack

**Status:** accepted for the Kalai-Kanade and Ghai-Singh theorem family, pending exact theorem-number audit.

**Claim:** A fixed-additive source cannot instantiate weak conditions of the form
$$
\operatorname{corr}(W)\ge \gamma_0 \sup_{c\in C}\operatorname{corr}(c,Y)-\epsilon_0
$$
with vanishing `epsilon_0` uniformly. If an efficient booster has final excess containing an unavoidable `epsilon_0/gamma_0` term, then the fixed source leaves constant excess.

**Caution:** This is not a blanket statement about all agnostic boosters. Residual-free statistical boosters can accept constant slack but currently pay non-polynomial enumeration/runtime costs.

## C005. Corrected da Cunha Weak-Condition Translation

**Status:** accepted algebraically; positive theorem remains conditional.

**Claim:** From `corr(h) >= rho - 2 beta` and `corr(h) >= -1`, the condition
$$
\operatorname{corr}(h)\ge \gamma_0\rho-\epsilon_0
$$
is guaranteed for all `rho in [-1,1]` whenever
$$
\epsilon_0 \ge 1-\gamma_0(1-2\beta).
$$
In the important special case `gamma_0=1`, it suffices to take `epsilon_0=2 beta`, and nontriviality `gamma_0 > epsilon_0` holds because `beta < 1/2`.

**Rejected earlier version:** "`epsilon_0 >= 2 beta` works for every `gamma_0 <= 1`" is false unless one assumes nonnegative best correlation or uses `gamma_0=1`.

## C006. da Cunha Route Is A Near Miss, Not An Atlas Proof

**Status:** accepted.

**Claim:** Residual-free da Cunha-Hogsgaard-Paudice-style boosting is the strongest positive near miss. The fixed source matches the weak condition with constant slack, but the known generic runtime includes terms like
$$
n^{O(m_0 \min\{d^*,\log n\}/\theta^2)}
$$
and roughly `n^{m0+3}` weak calls or analogous clean-label enumeration. If `m0` or the relevant capacity parameters grow with representation size, this is not polynomial in `(s,1/epsilon)` with representation-uniform exponent.

## C007. Clean-Conditional Learning Suffices For Agnostic Excess

**Status:** accepted.

**Claim:** If `D_c^+ = D | [Y=c(X)]` is defined, `err_D(c) <= OPT_C(D)+tau`, and `err_{D_c^+}(h,c) <= alpha`, then
$$
\operatorname{err}_D(h,Y)\le \operatorname{OPT}_C(D)+\tau+\alpha.
$$

**Use:** This turns the main positive route into hidden clean-witness generation plus noisy validation.

## C008. Polynomial Clean-Witness Menu Implies Strong Agnostic Learning

**Status:** conditional accepted.

**Claim:** Suppose an algorithm can, with high probability from noisy samples, generate a polynomial-size evaluable list `L` containing some `h` with small error on `D_{c^*}^+` for a near-optimal comparator `c^*`. Then fresh held-out validation over `L` gives an efficient agnostic improper learner.

**Needed assumptions:** `L` must be independent of the validation sample, polynomial-size, and evaluable; the validation sample must be fresh.

## C009. Random Clean Witness Route

**Status:** promising conditional, not implied by weak learning alone.

**Claim:** If an efficient reconstruction procedure succeeds from `K` iid clean examples plus enumerable advice/randomness of length `a` with probability `q`, and
$$
2^K 2^a/q \le \operatorname{poly}(s,1/\epsilon,\log(1/\delta)),
$$
then sampling noisy tuples, reconstructing candidates, and validating yields strong agnostic learning, up to constants for the near-`1/2` OPT case.

**Caution:** Ordinary sample compression or small weak-call sample size does not imply this random-witness property.

## C010. Logarithmic Compression Is Not Enough For Exhaustive Enumeration

**Status:** accepted accounting obstruction.

**Claim:** If `n = poly(s,1/epsilon)` and a clean witness has size `k = Theta(log(s/epsilon))`, exhaustive enumeration costs
$$
n^k = \exp(\Theta(\log^2(s/\epsilon))),
$$
which is quasi-polynomial, not atlas-efficient polynomial.

## C011. Black-Box Oracle Barrier

**Status:** promising but unproved; restricted-model only.

**Claim:** In hidden-clean-set or random-classification-noise toy models, a fixed-slack oracle can answer dummy hypotheses on all target-preserving smooth queries until the wrapper over-concentrates on the hidden clean component.

**Current gaps:** unrestricted point-mass, empirical, and artificial-relabeling queries can have low `OPT` without revealing the hidden comparator; adaptivity and information leakage are unhandled; random-code or all-functions constructions are not efficient represented-class separations.

## C012. Excess Alone Does Not Force A Low-Noise Residual Query

**Status:** accepted for high-loss and mistake-set residual filters.

**Claim:** Let `c` be a comparator and `g` a current predictor. Positive excess
$$
\operatorname{err}_D(g,Y)-\operatorname{err}_D(c,Y)>0
$$
does not imply that the high-loss or mistake residual distribution has `c`-error below `gamma`.

**Reason:** In the four-cell decomposition by whether `c` and `g` are correct, excess only controls the difference between the mass where `c` is correct and `g` is wrong and the mass where `c` is wrong and `g` is correct. It does not control the mass where both are wrong, which can dominate the residual query.

**Scope:** This refutes a natural residual-forcing proof step, not every possible residual-free or class-structured boosting strategy.

## C013. Aggregate RCN Agreement And Mistake Filtering Thresholds

**Status:** accepted with stated assumptions.

**Claim:** In random classification noise `Y=f(X)N`, with `Pr[N=-1]=eta`, `eta>gamma`, and a fresh predictor `Z` independent of the fresh noise bit conditional on `X`, let `r=E[Zf]`. Then
$$
\Pr[Y\ne f\mid Y=Z]
=
\frac{\eta(1-r)}{1+r(1-2\eta)}
$$
and
$$
\Pr[Y\ne f\mid Y\ne Z]
=
\frac{\eta(1+r)}{1-r(1-2\eta)}.
$$
Agreement filtering has noise below `gamma` iff
$$
r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
For `r>=0`, mistake filtering is at least as noisy as the original RCN distribution.

**Caution:** These are aggregate agreement/mistake formulas. They do not rule out sign-specific cells or richer observable buckets unless additional symmetry or atomwise posterior assumptions are imposed.

## C014. Soft Public-Filter Identity

**Status:** accepted as a restricted RCN algebraic identity.

**Claim:** In the same RCN model, for any nonzero target-preserving filter
$$
W(x,y)=a(x)+b(x)y,\qquad a(x)\ge |b(x)|,
$$
with labels left equal to `Y`, define
$$
A=E[a(X)],\qquad B=E[b(X)f(X)],\qquad r=B/A.
$$
Then the filtered noise relative to `f` is
$$
\eta_W=\frac{\eta(A-B)}{A+(1-2\eta)B}
=\frac{\eta(1-r)}{1+(1-2\eta)r}.
$$
Thus `eta_W < gamma` iff
$$
r>\tau_{\eta,\gamma}:=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

**Interpretation:** A target-preserving public filter crosses the weak threshold only when its label-asymmetric part already carries weighted correlation with the hidden target.

**Caution:** Low noise relative to the planted `f` is not equivalent to `OPT_C < gamma`; another public or hidden concept may fit the query.

## C015. Smooth Random-Target Public-Filter Barrier

**Status:** accepted as a restricted random-target toy theorem; not an atlas result.

**Claim:** For `X=[N]` uniform and random iid target `f`, a fixed bounded target-preserving filter with symmetric mass at least `alpha` has probability at most about
$$
\exp(-\Omega(\tau_{\eta,\gamma}^2\alpha N/L))
$$
of satisfying the threshold in C014, where `L` controls smoothness or maximum weight. Iteration 3 proves the corresponding adaptive toy statement under an explicit mutual-information budget.

**Iteration 3 accepted form:** If the selected filter is included in the transcript `T`, `A_T >= alpha`, `0 <= a_T(x) <= L`, `|b_T(x)| <= a_T(x)`, and
$$
R_T(f)=\frac{\sum_x b_T(x)f(x)}{\sum_x a_T(x)},
$$
then
$$
\Pr[A_T\ge \alpha,\ R_T(f)\ge \tau]
\le
\min\left\{1,\frac{I(f;T)+\ln 2}{\tau^2\alpha N/(2L)}\right\}.
$$
The proof is fixed-filter Hoeffding under the independent coupling plus binary-event KL transfer. Raw iid RCN samples contribute at most `M(\ln 2-h_2(eta))` nats of information in the uniform-domain model.

**Gaps:** Need a full transcript information budget for raw samples, majority-constant leakage, public-certificate responses, and any weak-oracle outputs. The model also needs smoothness, mass, no-other-witness or public-certificate assumptions, and a represented-class replacement for the random all-functions target.

## C016. da Cunha 2026 Conditional Positive Route

**Status:** conditional accepted; theorem-instantiation assumptions required.

**Claim:** The 2026 da Cunha-Hogsgaard-Paudice algorithm would give a strong agnostic improper learner from the fixed source under additional uniform assumptions: controlled weak sample size `m0`, efficiently evaluable output range `H=Range(A)`, polynomial/effective `VC(H)`, atlas-polynomial-safe dual VC `VC*(H)`, and an efficient or explicitly polynomial final selector over the vote class.

**Endpoint repair:** If the theorem cannot be invoked at `gamma0=1`, then for every fixed `beta<1/2` one can choose
$$
\gamma_0\in\left(\frac{1}{2(1-\beta)},1\right)
$$
and
$$
\epsilon_0=1-\gamma_0(1-2\beta)<\gamma_0
$$
so the atlas weak guarantee implies the required weak condition uniformly over `rho in [-1,1]`.

**Why conditional:** The atlas source supplies an efficient improper learner but gives no control of `m0`, `VC(H)`, `VC*(H)`, stability, compression, or efficient ERM over final votes.

## C017. Known da Cunha Implementation Is Not Atlas-Polynomial In General

**Status:** accepted audit of the known proof skeleton.

**Claim:** The 2026 implementation enumerates ordered weak samples `I in [n/2]^{m0}` and then searches over `T`-wise votes from the generated bag. The reported runtime has terms of the form
$$
O(n^{m0+3})
\quad\text{and}\quad
\operatorname{Eval}_H(1)\, n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$
This is polynomial in the sample size only when the parameters in the exponent are treated as fixed or otherwise representation-uniformly bounded.

**Caution:** A polynomial hitting set for all adaptive hidden-clean weak-call distributions is necessary for de-enumerating this proof skeleton, but not proved necessary for every possible fixed-slack booster.

## C018. Global-Correlation One-Sample Observable No-Go Is Refuted

**Status:** refuted as a broad claim.

**Refuted claim:** In RCN, if global `r=E[Zf]` is below the agreement threshold, then no one-sample observable transformation depending on `(Y,Z)` can create a query where `f` has error below `gamma`.

**Counterpoint:** Global correlation does not control all four signed cells `(Y,Z)`. A predictor can have below-threshold global correlation while a sign-specific observable cell has posterior error zero relative to `f`.

**Surviving version:** The obstruction is valid for aggregate agreement/mistake filters, or for atomwise/posterior conditions saying every allowed observable cell has `f`-error at least `gamma`. Sign-symmetry or sign-equivariance assumptions can also repair the statement.

## C019. Finite Final-List Validation Removes Only The Final Capacity Step

**Status:** accepted conditional refinement.

**Claim:** If a wrapper outputs, before looking at a fresh validation sample, a polynomial-size evaluable list `L` of complete final classifiers and some `h in L` has
$$
\operatorname{err}_D(h,Y)\le \operatorname{OPT}_C(D)+\epsilon/2,
$$
then finite-list validation returns an `OPT_C+\epsilon` classifier with polynomial samples.

Equivalently, by C007, it is enough that some `h in L` is accurate on `D_c^+` for a near-optimal comparator `c`.

**Interpretation:** This avoids global `Range(A)`, `VC(H)`, or dual-VC assumptions for the final noisy selection step only.

**Caution:** It does not prove that such an `L` exists. A finite data-dependent base bag does not imply clean-slice population accuracy, and searching all `T`-wise votes over a polynomial bag costs `|B|^T` unless there is an efficient selector or an explicitly polynomial final list.

## C020. Realized Adaptive Weak Calls Need Fresh Query Samples, Not Global Range

**Status:** accepted with sampling-model assumptions.

**Claim:** For `q=poly(s,1/epsilon,\log(1/delta))` adaptive calls to the fixed weak learner, it suffices to run each call with failure probability `delta/q` and union-bound over realized calls, provided that conditional on the past each call receives fresh iid samples from its intended query distribution and fresh learner randomness.

**Use:** This separates a real artifact from a real bottleneck: global output-range capacity is not needed merely to justify polynomially many realized PAC calls.

**Caution:** This does not justify feeding empirical hidden-clean tuples or reused samples to the weak learner. The PAC guarantee applies to the realized population query distribution only when the wrapper can actually sample from it.

## C021. Global Clean-Transcript Reconstruction Menu

**Status:** conditional accepted; not implied by the source.

**Claim:** Let `c` be a comparator with `p=Pr[Y=c(X)]>0`, and suppose a polynomial-time evaluable reconstruction map, possibly using public data `U`, takes `K` iid examples from `D_c^+` plus controlled advice/randomness and outputs a complete final classifier with `D_c^+` error at most `alpha` with probability at least `q`. If the raw discovery and search cost is polynomial, for example
$$
p^{-K} q^{-1}\cdot A_{\mathrm{search}}
\le \operatorname{poly}(s,1/\epsilon,\log(1/\delta)),
$$
where `A_search` is `2^b` for enumerable `b`-bit advice but may be smaller for sampleable randomness, then raw tuple sampling plus fresh validation gives error
$$
\operatorname{OPT}_C(D)+\tau+\alpha+O(\epsilon)
$$
for any `c` with `err_D(c) <= OPT_C(D)+tau`.

**Cautions:** The theorem must split off the near-endpoint case `OPT_C(D) >= 1/2-O(epsilon)`, where constants already suffice. The reconstruction must output complete final classifiers, not intermediate weak hypotheses. The success probability must be for complete transcripts, not per-round fragments.

## C022. Hidden-Mask Anti-Hitting Is A Restricted Proof-Skeleton Obstruction

**Status:** accepted in the stated toy model; not a broad lower bound.

**Claim:** In a hidden-mask model where, conditional on all observable data used to choose an explicit menu of candidate transcripts, each candidate requiring `K_j` distinct clean positions has posterior clean probability at most `p^{K_j}`, the chance that a menu of `L` candidates contains a fully clean transcript is at most
$$
\sum_{j=1}^L p^{K_j}
\le Lp^K
$$
when all `K_j >= K`.

**Use:** This explains why raw tuple discovery is polynomial only when total clean witness length and success mass satisfy an inverse-polynomial condition, such as `Lp^Kq >= 1/poly`.

**Caution:** The lemma does not apply to algorithms using repeated-coordinate denoising, posterior-biased filters, public clean-status certificates, class structure, implicit optimization over transcripts, or complete final classifiers that avoid literal all-clean transcripts.

## C023. Public-Posterior Obstruction To One-Step Residual Forcing

**Status:** accepted with the stated sigma-field assumption.

**Claim:** Let `G` be the public sigma-field available to a one-step filter/relabeling procedure, and let `c` be a comparator. If
$$
\Pr[c(X)\ne Y\mid G]=\eta
$$
almost surely, with `eta < 1/2`, then no `G`-measurable nonnegative filter `W` and no `G`-measurable sign relabeling `Y'=S Y`, `S in {+-1}`, can make the comparator error below `eta`. Indeed,
$$
\Pr_W[c\ne Y']
=
\frac{E[W(\eta 1_{S=1}+(1-\eta)1_{S=-1})]}{E[W]}
\ge \eta.
$$

**Use:** This generalizes the high-loss and mistake-residual failures to any residual step that has not created public information correlated with where `c` is correct.

**Caution:** The assumption is strong. It excludes posterior-biased features, repeated-coordinate denoising, class-structured recovery, and any prior transcript information that changes the conditional clean probability.

## C024. Information-Charged Clean-Certificate Anti-Hitting

**Status:** accepted as a restricted hidden-mask theorem; not a general necessity theorem.

**Claim:** In a hidden-mask model with clean indicators `S`, let `T` be the pre-validation transcript. Suppose that under the independent coupling `Q=P_S P_T`, a success event `E` is covered by a transcript-selected weighted certificate family `Sigma(T)` such that each certificate `sigma` requires `K_sigma` distinct clean positions and has weight `w_sigma`. If
$$
Q(E\mid T=t)\le \sum_{\sigma\in\Sigma(t)} w_\sigma p^{K_\sigma}
$$
and
$$
\mu:=E_T\sum_{\sigma\in\Sigma(T)} w_\sigma p^{K_\sigma}<1,
$$
then under the true joint law `P`,
$$
P(E)\le \frac{I(S;T)+\ln 2}{\ln(1/\mu)}.
$$

**Interpretation:** Constant success requires either inverse-polynomial independent clean-certificate mass when `I(S;T)=O(log n)`, or enough transcript information about the hidden mask to make the lower bound vacuous, or a mechanism outside explicit all-clean certificate enumeration.

**Cautions:** Certificate completeness is an assumption, not a consequence of fixed-slack weak learning. The weights `w_sigma` are upper bounds or branch masses in the anti-hitting argument; they should not be confused with the reconstruction success lower bound `q` in C021. The model also requires exchangeable or otherwise controlled clean indicators; arbitrary agnostic distributions can have observable high-clean regions.

## C025. Conditional Final Vote Selector

**Status:** conditional accepted; selector is an extra primitive.

**Claim:** Let a validation-independent polynomial bag `B={h_1,\ldots,h_M}` of evaluable hypotheses be fixed, and let `V_B` be a specified threshold-vote class over the feature map `x -> (h_1(x),...,h_M(x))`. If `V_B` contains a classifier with error at most `alpha` on `D_c^+` for a near-optimal comparator `c`, and if an efficient selector returns a classifier whose true noisy risk is within `xi` of the best in `V_B`, then the clean-conditional lemma gives an `OPT_C+tau+alpha+xi` learner after the usual validation/generalization bookkeeping.

**Use:** This separates final vote optimization from hidden-clean bag generation. For unrestricted real-weighted votes, selection is agnostic halfspace learning over the generated features; for `sign(conv(B))` or bounded `T`-wise votes, the exact weight restrictions must be stated.

**Cautions:** The fixed weak learner for `C` is not an agnostic halfspace learner over `B`. Generic 0-1 vote optimization is a substantial extra assumption, and convex surrogate optimization needs a separate margin/calibration theorem. The bag must have a population clean-conditional guarantee, not merely empirical clean performance.

## C026. Polynomial Coordinate Domains Are Improperly Strong-Learnable

**Status:** accepted with standard table-representation assumptions.

**Claim:** If the instance domain `X` has size `N=poly(s)`, then every concept class over `X` is distribution-free agnostically improperly learnable in time and samples polynomial in `N` and `1/epsilon`, by learning a table/empirical-majority predictor for all coordinates with sufficient mass. This achieves Bayes risk plus `epsilon`, hence at most `OPT_C+\epsilon`.

**Use:** Explicit finite block-code hardness cannot separate this atlas edge in the improper model when the coordinate domain is polynomial in the representation size.

**Caution:** This obstruction assumes table or dictionary hypotheses of polynomial size are allowed and evaluable. It does not apply directly to succinct exponential coordinate domains.

## C027. Coding Route Must Target Succinct-Domain RCN Prediction

**Status:** conditional template; no instantiated separation.

**Claim:** For codeword concept classes over coordinates `X`, strong agnostic improper learning under fresh RCN labels
$$
Y=c^\star(X)N,\qquad \Pr[N=-1]=\eta<1/2
$$
would output a predictor `h` satisfying
$$
\operatorname{err}_{D_X}(h,c^\star)\le \epsilon/(1-2\eta)
$$
when run to noisy excess `epsilon`. Therefore a code-based separation must assume hardness of sample-access improper RCN prediction on a succinct or effectively exponential coordinate domain.

**What is insufficient:** Classical nearest-codeword, minimum-distance, or maximum-likelihood decoding hardness is proper/full-word hardness and does not by itself rule out arbitrary improper predictors. The weak side must also be a distribution-free weighted/soft low-radius learner, not merely a uniform Hamming bounded-distance decoder.

## C028. One-Step Public Residual Minimax

**Status:** accepted in the stated sigma-field model; not an atlas lower bound.

**Claim:** Fix a comparator `c` and a public sigma-field `G`. Let
$$
\eta_G=\Pr[c(X)\ne Y\mid G].
$$
For any nonnegative `G`-measurable filter `W` and `G`-measurable sign relabeling `Y'=SY`, `S in {+-1}`,
$$
\operatorname{err}_{W,S}(c)
=
\frac{E[W(\eta_G1_{S=1}+(1-\eta_G)1_{S=-1})]}{E[W]}.
$$
Thus the best one-step public filter/relabeling can only exploit public cells where `min(eta_G,1-eta_G)` is small. In finite positive-mass cells, the optimum is
$$
\min_i \min\{\eta_i,1-\eta_i\}.
$$

**Consequence:** Positive excess `err(g,Y)>err(c,Y)` alone does not force a public residual query with comparator error below `gamma`. Flat-posterior examples with all `eta_i=eta in (gamma,1/2)` and `err(g)>eta` refute that proof step.

**Cautions:** This tracks one comparator, not `OPT_C`. Public constants, artificial relabelings, empirical/spike queries, or other concepts can make `OPT_C` small for unrelated public reasons. The result is one-step and public-relative; it does not rule out transcripts that first create posterior variation.

## C029. Anchor Doping Absorption

**Status:** accepted as a direct-route obstruction.

**Claim:** For a public anchor `a` and doped labels
$$
Y_\lambda =
\begin{cases}
a(X), & \text{with probability }1-\lambda,\\
Y, & \text{with probability }\lambda,
\end{cases}
$$
the public improper hypothesis `h=a` has doped error
$$
\operatorname{err}_{D_\lambda}(a,Y_\lambda)
=\lambda\operatorname{err}_D(a,Y)\le \lambda.
$$
Hence whenever `lambda <= beta`, `a` is a legal `OPT_C+beta` weak answer, regardless of the target labels and even if `a notin C`.

**Interpretation:** Infinitesimal or small-mixture support-function differentiation near a public anchor cannot force target information in the atlas improper model.

**Cautions:** This is a legality/adversarial-oracle obstruction, not a statement about what a particular fixed PAC learner must output. It does not rule out adaptive procedures unless a consistent legal response strategy is formalized.

## C030. Anchor Lock-In And Cap-Separation Diagnostic

**Status:** accepted as a restricted single-call support-function diagnostic.

**Claim:** For a proper support-function view with slack `alpha=2 beta`, direction
$$
z_\lambda=(1-\lambda)u+\lambda a,
$$
and any `c_0 in C`, define
$$
\kappa=\sigma_C(u)-\langle c_0,u\rangle,\qquad
\Delta=\sigma_C(a)-\langle c_0,a\rangle.
$$
Then
$$
\sigma_C(z_\lambda)-\langle c_0,z_\lambda\rangle
\le (1-\lambda)\kappa+\lambda\Delta.
$$
If the right side is at most `alpha`, an adversarial proper weak oracle may keep returning `c_0`. In particular, an anchor maximizer with target gap `2 epsilon < Delta <= alpha` remains legal along the whole anchor-target line.

**Proper single-call criterion:** A valid query direction `z` forces every proper concept output to be target-`epsilon`-good only if the target-bad cap is separated by more than `alpha`:
$$
\sigma_C(z)-\sigma_{C_{\mathrm{bad}}(\epsilon)}(z)>\alpha.
$$

**Cautions:** The atlas source is improper, so a positive forcing criterion must quantify over the full legal output universe, not only `C`. Query directions must be normalized and sampleable PAC query distributions. This diagnostic does not rule out multi-call aggregation or validation over explicitly known candidates.

## C031. Hard-Core Low-OPT Chunk Requires Public Posterior Tail

**Status:** accepted obstruction to the general proof principle.

**Claim:** A hard-core or dense-model proof that tries to turn excess
$$
\operatorname{err}(g,Y)-\operatorname{err}(c,Y)>\epsilon
$$
into a fixed-slack weak call must produce a public query where some near-optimal comparator has error below `gamma`. Public convex duality only optimizes the lower tail of the public posterior comparator error; excess by itself does not force that lower tail below `gamma`.

Equivalently, writing `Z=c(X)Y`,
$$
\operatorname{err}(g,Y)-\operatorname{err}(c,Y)
=E[1_{g\ne c}Z],
$$
so the natural distinguisher `{g != c}` is hidden because it depends on `c`.

**Cautions:** If a public query does have comparator error `gamma-kappa`, the weak learner is triggered, but a full booster still needs an update/potential argument showing how the returned hypothesis improves original noisy risk. Low comparator error is sufficient but not necessary for low `OPT_C`; public-witness low-`OPT` queries must be routed separately.

## C032. Information Cost Of A Low-Noise Public Chunk

**Status:** accepted as a per-example information diagnostic.

**Claim:** Let `S_c=1[c(X)\ne Y]` have marginal `eta`, and let `G` be public information. If a `G`-measurable event `A` has mass `mu` and
$$
\Pr[S_c=1\mid A]=\gamma'<\eta,
$$
then
$$
I(S_c;G)\ge I(S_c;1_A)
\ge \mu\,\mathrm{kl}(\gamma'\|\eta).
$$

**Use:** A target-useful public low-noise chunk requires public information about clean/noisy status. This complements the smooth random-target public-filter barrier.

**Cautions:** This is not a transcript-level lower bound unless `G`, the per-example sampling model, and the way transcript outputs generate public events are specified. Weighted filters and tiny-mass events require separate mass/smoothness accounting.

## C033. Approximation-Gap To Fixed-Slack Weak Learning

**Status:** accepted conditional lemma; no instantiated separation.

**Claim:** Suppose `C` has an efficient improper agnostic approximation algorithm `P` such that, for every distribution and tunable `xi>0`,
$$
\operatorname{err}(P(D))\le a\,\operatorname{OPT}_C(D)+\xi
$$
for some fixed `a>1`. Then for every fixed
$$
\beta>\frac{a-1}{2a}
$$
the class has an efficient fixed-slack weak agnostic improper learner with guarantee `OPT_C+beta`.

**Reason:** Let `gamma=1/2-beta`. Run `P` with sufficiently small `xi`, include the two constants, and choose by fresh validation. If `OPT_C(D)>=gamma`, a constant has error at most `1/2<=OPT_C+\beta`. If `OPT_C(D)<gamma`, then
$$
a\,OPT+\xi
=OPT+(a-1)OPT+\xi
<OPT+(a-1)\gamma+\xi
\le OPT+\beta
$$
for `xi < beta-(a-1)gamma`.

**Use:** A conditional separation could be obtained from efficient distribution-free constant-factor/additive-constant agnostic approximation plus hardness of `OPT+epsilon` improper prediction.

**Cautions:** The strong-hardness side must rule out arbitrary improper predictors, not merely proper recovery or assignment optimization. The weak approximation must be distribution-free and must support arbitrary agnostic labels.

## C034. Signed CSP Approximation Gives Weak Learning Only Under Strong Conditions

**Status:** conditional accepted; standard CSP literature does not supply the needed assumptions automatically.

**Claim:** For an assignment-induced CSP-evaluation class, with examples `x` being constraint/query descriptors and labels `Y` kept separate, agnostic learning against assignments is the weighted signed-CSP objective
$$
\max_\sigma \Pr[c_\sigma(X)=Y].
$$
An empirical signed/weighted approximation algorithm with additive gap `kappa<1/2`, together with finite-class uniform convergence over assignments and fresh validation, gives fixed-slack weak learning with any `beta>kappa+o(1)`. A multiplicative agreement guarantee
$$
\Pr[h(X)=Y]\ge \alpha\max_\sigma\Pr[c_\sigma(X)=Y]
$$
gives `err(h) <= OPT_C + (1-alpha)`, so `alpha>1/2` also gives fixed slack.

**Cautions:** Standard Max-CSP approximation algorithms usually address proper assignment satisfaction for explicit positive or signed instances. They do not automatically give distribution-free signed agnostic approximation for arbitrary labels over succinct domains.

## C035. Standard Fixed-Arity CSP Gaps Cannot Separate The Improper Edge

**Status:** accepted obstruction.

**Claim:** For a fixed finite predicate family of constant arity `k` over `n` variables, the domain of possible constraint descriptors has size `n^{O(k)}`. Therefore, by the finite-domain table learner, every assignment-induced class over this domain is distribution-free agnostically improperly learnable to Bayes risk plus `epsilon` in polynomial time.

**Consequences:** Ordinary fixed-arity Max-SAT/Max-CSP/Max-Cut-style gaps cannot provide a weak-but-not-strong improper PAC separation. All-positive encodings are even more trivial because the public constant `h=1` has zero error; encodings where the RHS/desired label is part of `x` are also publicly learnable.

**Cautions:** This does not rule out succinct or effectively exponential CSP-evaluation domains. Those still require both a signed weak approximation algorithm and improper sample-access prediction hardness for the same class.

## C036. Public Randomized Kernel Posterior Envelope

**Status:** accepted in a restricted public-view model; not an `OPT_C` lower bound.

**Claim:** Fix a public sigma-field or public observation `G` and a comparator `c`. A one-example public randomized filter/relabel query can be represented by nonnegative `G`-measurable weights `w_+(G),w_-(G)` that output query labels `+1` and `-1`. If
$$
p(G)=\Pr[c(X)=+1\mid G],\qquad u(G)=\min\{p(G),1-p(G)\},
$$
then the comparator error on the induced query is
$$
\frac{E[w_+(G)(1-p(G))+w_-(G)p(G)]}{E[w_+(G)+w_-(G)]}
\ge
\frac{E[(w_+(G)+w_-(G))u(G)]}{E[w_+(G)+w_-(G)]}.
$$
Thus public randomized relabeling can make `c` have error below `gamma` only by placing mass on public cells where `c` already has posterior uncertainty below `gamma`.

**Flat-posterior use:** For any `gamma<eta<m<=1/2`, coarse public cells can be arranged so `err(c,Y)=eta`, `err(g,Y)=m`, and every allowed public cell has comparator posterior uncertainty `eta`; then positive excess over `c` still gives no below-`gamma` public residual for `c`.

**Cautions:** If `G` contains full `X` and `c` is a fixed deterministic concept, then `c(X)` is mathematically `G`-measurable and the posterior uncertainty can degenerate to zero. For full-instance algorithms this lemma needs either a coarse public view or a random-hidden-target/information-budget model. It lower-bounds the error of one comparator, not `OPT_C`; public constants, anchors, spikes, or other concepts may still witness low `OPT_C`.

## C037. Exact DCHP Final Vote Class And Selector Bottleneck

**Status:** accepted audit of the 2026 proof skeleton.

**Claim:** In the da Cunha-Hogsgaard-Paudice 2026 algorithm, the final class for a generated bag `B` is
$$
V_{B,T}=\operatorname{sign}(B^{(T)})
=\left\{\operatorname{sign}\left(\frac1T\sum_{t=1}^T h_t\right):h_t\in B\right\},
$$
with repetitions allowed and `sign(0)=1`. Equivalently, for `B={h_1,\ldots,h_M}`,
$$
V_{B,T}
=\left\{x\mapsto \operatorname{sign}\left(\sum_{j=1}^M k_jh_j(x)\right): k_j\in\mathbb N,\ \sum_jk_j=T\right\}.
$$
This is a zero-threshold, nonnegative, integer-weight sparse majority class, not an unrestricted real-weight halfspace class.

**Selector bottleneck:** The known algorithm performs empirical risk minimization over `V_{B,T}` and pays an exhaustive `|B|^T`-type cost. An atlas-polynomial reduction would need an additional `ApproxSparseMajorityERM(B,T)` primitive, or an explicitly polynomial list of complete final classifiers.

**Hidden-margin non-transfer:** The proof's margin certificate lives on the hidden clean sample for a near-optimal comparator. It does not by itself justify hinge/logistic/exponential surrogate minimization on noisy validation labels, nor LP selection unless clean constraints and population transfer are separately supplied.

**Cautions:** Selector progress alone does not solve upstream hidden-clean tuple generation or controlled `H`, `VC(H)`, `VC*(H)`, and `m0` assumptions. Generic halfspace hardness is only a warning unless reduced to the exact bounded nonnegative integer vote class with complements/constants and sufficient rounding margin.

## C038. Generic Exact Sparse-Majority ERM Is Set-Cover Hard

**Status:** accepted in-run reduction for arbitrary empirical bags; not a DCHP-generated-bag lower bound.

**Claim:** For arbitrary finite binary bags `B`, proper empirical risk minimization over the exact DCHP class
$$
V_{B,T}
=
\left\{x\mapsto \operatorname{sign}\left(\sum_{j=1}^M k_jh_j(x)\right):
k_j\in\mathbb N,\ \sum_j k_j=T\right\},
$$
with repetitions and the DCHP tie rule `sign(0)=1`, is NP-hard. Parameterized by `T`, the zero-error decision problem is W[2]-hard via Set Cover.

**Reduction forms:** One sound gadget uses a special offset column and `T=2k`. Two control rows force exactly `k` copies of the offset column; the remaining `k` selected set columns classify an element row correctly exactly when at least one selected set covers that element. A second sound gadget assumes a public `+1` constant, sets `T=2k-1`, and uses a negative dummy row to force at least `k` set-column occurrences; positive correctness then implies a size-`k` cover after deleting surplus selected occurrences.

**Additive version:** Any deterministic proper selector returning empirical risk within `xi < 1/(2N)` of optimum, where `N` is the number of empirical rows, distinguishes zero-error from nonzero-error instances. Thus an `f(T)poly(M,N,1/xi)` inverse-polynomial additive selector would imply an FPT algorithm for Set Cover.

**Cautions:** The reduction is worst-case over arbitrary tabulated bags. It does not rule out selectors for DCHP-generated bags, margin-certified instances, special no-constant/no-complement bags, odd-`T` variants, relaxed convex votes, surrogate objectives, or constant-additive empirical approximations. The selector must be proper over `V_{B,T}`; an unconstrained improper empirical learner can simply memorize the sample.

## C039. Rare-Slice Junk Blocks Free Range And Dual-VC Control

**Status:** accepted as a black-box/no-free-regularization obstruction; not an atlas separation.

**Claim:** Semantic fixed-slack validity alone does not imply controlled semantic `Range(A)`, `VC(Range(A))`, or `VC^*(Range(A))` for the particular supplied weak learner. Even for the constant class `C={+1,-1}` over points `(k,z)`, a valid weak learner can output
$$
h_{b,R,i}(k,z)=
\begin{cases}
z_i,& k=R,\\
b,& k\ne R,
\end{cases}
$$
where `b` is an empirical best constant and `R` is a random key whose query mass is at most `tau` with high probability. If the constant learner has excess `alpha` and `alpha+tau <= beta`, this preserves `OPT_C+beta` validity.

For fixed `b` and `R`, the range contains `{h_{b,R,i}:i\in[D]}`. Points `(R,z^S)` realizing all sign patterns over coordinates shatter these `D` hypotheses in the dual sense, so
$$
VC^*(Range(A))\ge D
$$
within the learner's output/evaluation budget. A table-payload variant can similarly inflate primal VC with explicit output-length accounting.

**Cautions:** The constants class is strongly learnable by ignoring this learner. White-box wrappers may strip transparent junk, and proofs using only realized adaptive calls or validation-independent finite final lists may avoid global range. The result attacks claims that DCHP-style full `H=Range(A)` or dual-VC assumptions follow from weak correctness alone.

## C040. Succinct Signed-CSP Route Needs Hard-Band Refutation, Not Low-Noise Hardness

**Status:** accepted checklist refinement; no instantiated separation.

**Claim:** A fixed-slack weak learner with `beta=1/2-gamma` refutes any planted signed-CSP/RRHS sample-access distribution with `OPT_C <= eta < gamma`: it returns an evaluable `h` with
$$
\operatorname{err}(h)\le eta+\beta
=\frac12-(\gamma-eta),
$$
and fresh validation distinguishes this from iid unbiased random RHS labels, assuming the planted and null cases share the same `X` marginal and the validation sample is independent.

Therefore low-noise or noiseless random-CSP refutation hardness cannot serve as the strong-side hardness for a class that already has the required fixed-slack weak learner. Any refutation-style separation must place the hard assumption in the hard band `eta in [gamma,1/2)`, and it must rule out arbitrary improper prediction/distinguisher hypotheses for the same evaluable class.

**Signed approximation thresholds:** For assignment-induced classes with agreement optimum `A^*=1-OPT_C`, an additive signed approximator with agreement at least `A^*-\kappa` gives `OPT_C+\kappa` learning. A multiplicative agreement approximator with `A >= alpha A^*` gives slack at most `1-alpha`; for a prescribed source tolerance `beta`, the worst-case sufficient condition is `alpha >= 1-beta`, while merely `alpha>1/2` only gives some fixed slack below `1/2`.

**Cautions:** The iteration-7 audits found no off-the-shelf succinct signed-CSP candidate. Fixed-arity explicit domains are table-learnable, RHS/signs must not be public inputs, all-positive labels are trivial, log-arity XOR shifts the burden to noisy sparse-parity weak learning, and known explicit CSP approximation/refutation theorems do not automatically provide distribution-free signed weak approximation plus high-noise improper prediction hardness.

## C041. Parity Gives A Shrinking-Gap Near-Separation, Not The Fixed-Constant Edge

**Status:** accepted as a scoped boundary diagnosis; formal constants still need a standalone writeup.

**Claim:** For the parity class
$$
C_n=\{\chi_s(x)=(-1)^{s\cdot x}:s\in\mathbb F_2^n\},
$$
iteration 8 gives a plausible conditional non-implication for a different source notion where
$$
\gamma_n=\frac12-\beta_n=O(\log n/n),
$$
not for the current atlas source with representation-uniform constant `gamma`.

Weak-side sketch: if `eta=OPT_{C_n}(D) >= 2 gamma`, constants are legal with slack. If `eta<2 gamma`, an `m=Theta(n)` raw batch is clean relative to a fixed optimal parity with probability `exp(-O(n gamma))`; conditioned on that event, the inputs are iid from the clean conditional marginal `D_{c^*}^+`. A span-capture lemma over `D_{c^*}^+` gives a consistent parity with clean-conditional error at most `1/2-O(gamma)`, and fresh validation selects from polynomially many trials when `n gamma=O(log n)`.

Strong-side sketch: under uniform RCN labels `Y=chi_s(X)N_eta` at constant `eta<1/2`,
$$
\operatorname{err}(h,Y)
=\eta+(1-2\eta)\operatorname{err}(h,\chi_s).
$$
An `OPT+epsilon` improper learner with efficiently evaluable outputs and sufficiently small constant `epsilon` gives a predictor correlated with `chi_s`; Goldreich-Levin-style recovery then breaks search LPN, under the usual LPN hardness assumption.

**Cautions:** This is not evidence for the fixed-constant atlas edge. For constant `gamma`, the all-clean `Theta(n)` batch has probability `exp(-Omega(n))`, and the weak side becomes constant-noise parity learning. The weak learner is not a tunable polynomial-time learner for arbitrary inverse-polynomial `gamma`; the sketch is polynomial only while `n gamma=O(log n)`.

## C042. Parity-Slice Pullback Blocks Public Amplification Attempts

**Status:** accepted conditional obstruction under efficient embedding/evaluation and LPN-style hardness.

**Claim:** Suppose a transformed class `C'` has an efficiently sampleable and evaluable parity restriction: there is an efficiently computable map `phi` such that for every parity `chi_s` there is `c'_s in C'` with
$$
c'_s(\phi(x))=\chi_s(x)
$$
or a known sign flip. Then any fixed-slack weak learner for `C'` with `beta=1/2-gamma` gives a fixed-slack weak learner for parities by running it on distributions supported on `phi(X)` and evaluating the returned hypothesis on `phi(x)`.

In particular, on uniform RCN parity labels with noise `eta<gamma`,
$$
\operatorname{err}(h,Y)\le \eta+\frac12-\gamma
$$
implies
$$
\mathbb E[h(\phi(X))Y]\ge 2(\gamma-\eta),
\qquad
\mathbb E[h(\phi(X))\chi_s(X)]
\ge \frac{2(\gamma-\eta)}{1-2\eta}.
$$
Taking `eta=gamma/2` gives constant correlation with the hidden parity.

**Use:** This rules out direct parity amplification by public products, block mixtures, padding, or meta-classes whenever they preserve an efficiently accessible parity slice.

**Cautions:** The conclusion is conditional on representation-uniform reduction size, efficient sampling of the slice, efficient hypothesis evaluation, and an explicit LPN prediction/decision/search hardness assumption. It does not rule out genuinely non-sliceable classes with independent constant-slack weak approximation and hard-band improper prediction hardness.

## C043. Rare-Slice Programming Pollutes Generated Bags In Black-Box Models

**Status:** accepted core legality lemma; generated-bag Set-Cover hardness remains conditional and not established for actual DCHP.

**Claim:** For the singleton class `C={+1}` over a keyed domain, a learner may output hypotheses that equal `+1` off a random key slice and behave arbitrarily on that slice while preserving semantic `OPT+beta` validity. If
$$
h_{R,j}(x)=+1
$$
off the slice `{key=R}` and `h_{R,j}` encodes an arbitrary programmed column on that slice, then for every query distribution `Q`,
$$
\operatorname{err}_Q(h_{R,j})
\le \operatorname{err}_Q(+1)+Q[key=R]
=OPT_C(Q)+Q[key=R].
$$
Since `E_R Q[key=R]=1/|K|`, Markov gives
$$
\Pr_R[Q[key=R]>\tau]\le \frac{1}{|K|\tau}.
$$
Thus choosing `|K| >= 1/(tau delta_0)` and `tau<beta` yields a valid randomized weak learner for that call confidence, independent of what column `j` encodes.

**Conditional selector obstruction:** If a DCHP-style or standalone generated-bag selector primitive is forced to include enough such programmed columns on a common hard slice, has the necessary constants/offset columns, controls extra generated columns, and uses the exact `T` needed by the Set-Cover gadget, then worst-case generated bags can contain Set-Cover-hard sparse-majority instances.

**Cautions:** These extra hypotheses are not proved for the actual DCHP procedure. The construction is artificial, class-aware wrappers can ignore it, `C={+1}` is strongly learnable, confidence/key-hit accounting may fight coupon collection, iid sample realization is unwritten, extra columns may destroy no-cover instances, and DCHP computes its own `T`. The result is a no-free-structure warning for black-box generated-bag selectors, not an atlas separation.

## C044. Log-Arity Signed XOR Does Not Instantiate The Approximation-Gap Route

**Status:** accepted as a candidate-specific no-go; sparse-LPN hardness remains an assumption, not a proved theorem here.

**Claim:** Let `k=Theta(log n)`,
$$
X_{n,k}=\{S\subseteq[n]: |S|=k\},
\qquad
c_s(S)=(-1)^{\sum_{i\in S}s_i}.
$$
This avoids the polynomial-domain table learner, but it fails the weak-side checklist. Under uniform RCN labels
$$
Y=c_s(S)N_\eta,\qquad S\sim \mathrm{Unif}(X_{n,k}),
$$
with `eta<gamma` and `beta=1/2-gamma`, any fixed-slack weak learner returns an evaluable `h` satisfying
$$
\operatorname{err}(h,Y)\le \eta+\beta
=\frac12-(\gamma-\eta),
$$
hence
$$
\mathbb E[h(S)Y]\ge 2(\gamma-\eta),
\qquad
\mathbb E[h(S)c_s(S)]
\ge \frac{2(\gamma-\eta)}{1-2\eta}.
$$
For example, `eta=gamma/2` gives constant positive correlation with the hidden sparse parity.

**Use:** Log-arity signed XOR has the right high-entropy hard-band prediction shape, but a fixed-constant weak source would already solve its low-noise sparse-parity prediction stress distribution. Thus it is not an instantiated approximation-gap separation unless one assumes an independent low-noise sparse-XOR weak predictor and a separate hard-band prediction barrier.

**Cautions:** This is one-way, not an equivalence. A predictor for uniform sparse XOR does not give distribution-free weak agnostic learning. Strong-side hardness must be improper prediction/correlation hardness for the same marginal, not assignment recovery, value approximation, or refutation. If the RHS/sign is placed in `x`, the problem is improperly trivial; if `k=O(1)` or the marginal has polynomial support, table learning kills the strong side.

## C045. Realized-Call DCHP Extraction Is A Narrow Positive Refinement

**Status:** accepted as a proof-layer refinement; not an atlas proof.

**Claim:** In a DCHP-style boosting proof, adaptive weak-call correctness can be charged only over the realized calls, provided each call receives fresh iid samples from its intended population query distribution and uses fresh learner randomness. Thus global `Range(A)` or dual-VC control is not needed merely to union-bound the legality of polynomially many realized weak calls.

The proof should be decomposed into three separate primitives:

1. `RealizedCleanSimulation`: weak-call validity for the actual adaptive clean empirical trajectory, with explicit assumptions on `m0`, seeds, confidence, tuple enumeration, and clean-sample size.
2. `CleanPopulationTransfer`: a mechanism proving that a generated hidden-clean transcript or bag has population accuracy on `D_c^+`; this still needs VC/dual-VC, compression, stability, independence, or another population certificate.
3. `PolynomialFinalSelectorOrList`: an efficient selector over `sign(B^(T))` or a validation-independent polynomial list of complete classifiers.

**Cautions:** This does not remove `m0` tuple enumeration. It does not replace the hidden-clean empirical-to-population step; finite generated bags can overfit the hidden clean sample. It also does not solve computation of the best sparse majority; finite validation over a fixed vote class is statistical only.

## C046. Rare-Slice Generated-Bag Pollution Is Blocked From Literal DCHP Hardness By Compatibility Gaps

**Status:** accepted as a scoped obstruction to overclaiming; not a formal impossibility theorem.

**Claim:** The query-light block lemma from C043 gives a standalone black-box selector obstruction: if every generated weak-call distribution has `Q_t(S)<=tau<beta` on a common block `S`, a weak learner for `C={+1}` may output arbitrary programmed columns on `S` while staying `OPT+beta` valid. But iteration 9 identifies severe obstacles to making this literal DCHP-generated Set-Cover hardness.

Main obstacles:

- final relevance versus weak-call lightness: if a block has mass `alpha` large enough for final samples to realize a polynomial Set-Cover gadget, a comparable weak-sample pool likely hits it;
- tuple concentration: with ordered tuple enumeration and repetitions, one hard-slice sample can induce a spike call with `Q(S)=1`;
- common-key scheduling is nonstandard for a stateless PAC learner, and outputs may reveal the key to adaptive future queries;
- extra generated columns can destroy Set-Cover no-instance soundness;
- constants/offset columns and the exact `T=2k` or `2k-1` gadget budgets must align with DCHP's internally chosen `T`;
- the singleton class is strongly learnable, so the construction cannot be an atlas separation.

**Use:** Keep rare-slice programming as a no-free-structure warning for black-box generated-bag selectors. Do not cite it as DCHP-generated bag hardness unless the compatibility items above are proved.

## C047. Ideal Ghost Clean Transfer Is Analysis-Only

**Status:** accepted conditional lemma; not a positive atlas proof.

**Claim:** Fix a near-optimal comparator `c` and let `P=D_c^+`. If a transcript `T` and finite final class `V_T` are fixed independently of an iid clean ghost sample from `P`, then standard uniform convergence transfers ghost-clean empirical error to population clean error on `P`. In particular, for finite `|V_T|=N`,
$$
m=O((\log N+\log(1/\delta))/\xi^2)
$$
clean ghost examples suffice for simultaneous `xi`-accuracy over `V_T`.

**What it solves:** It removes only the statistical dependence between a validation-independent final class and an independent clean certification sample.

**Cautions:** It does not prove that `V_T` contains a classifier good on the ghost sample. It also does not reveal the clean ghost mask from raw agnostic samples. Independence must include ghost covariates, labels, clean indicators, and any seed correlated with them.

## C048. Ghost Anti-Hitting Applies Only To Explicit Mask-Neutral Certificates

**Status:** accepted scope refinement.

**Claim:** A raw ghost holdout of size `O((m+\log(1/\delta))/p)` contains `m` points from `D_c^+` with high probability when `p=Pr[Y=c(X)]` is bounded below. The exponential `p^{-m}` obstruction applies only when an algorithm or proof must explicitly name an all-clean `m`-tuple or certificate without useful posterior information about clean indicators.

**Use:** This corrects the overbroad claim that raw ghost samples themselves require `p^{-m}` discovery cost.

**Cautions:** The restricted anti-hitting form still requires iid/exchangeable clean indicators, distinct-position certificates, certificate completeness, and either transcript-mask neutrality or an information-charged statement such as C024. Observable high-clean regions, repeated-coordinate denoising, posterior-biased filters, class-specific recovery, and oracle-output leakage are outside the simple `Lp^m` bound.

## C049. Random Final-List Sampler Suffices Under Inverse-Polynomial Good Mass

**Status:** conditional accepted; sampler-mass primitive required.

**Claim:** Let `B` be validation-independent, and let `Pi_B` be an efficiently sampleable distribution over complete final classifiers, for example over `V_{B,T}=sign(B^(T))`. If for a near-optimal comparator `c`,
$$
\Pr_{v\sim \Pi_B}[\operatorname{err}_{D_c^+}(v,c)\le \alpha]\ge p
$$
with `p >= 1/poly(s,1/epsilon,log(1/delta))`, then drawing `O(p^{-1}\log(1/\delta))` classifiers and using fresh noisy validation gives an `OPT_C+tau+alpha+O(epsilon)` learner, assuming `err_D(c,Y)<=OPT_C(D)+tau`.

**Cautions:** The sampler must be computable from the public transcript/bag, not from `c`, `D_c^+`, a hidden clean sample, or clean labels. This is a final-list primitive, not a consequence of fixed-slack weak learning.

## C050. Public Pointwise-Margin Sampler Gives Good Random Votes

**Status:** conditional accepted with strengthened hypotheses.

**Claim:** Suppose a public distribution `q_B` over a bag `B` satisfies, under `P=D_c^+`,
$$
\Pr_{x\sim P}\left[\mathbb E_{h\sim q_B} c(x)h(x)\ge \theta\right]\ge 1-\alpha .
$$
Then a `T`-wise vote sampled from `q_B^T` has clean error at most
$$
\alpha+\exp(-\Omega(T\theta^2))
$$
in expectation over the sampled vote. Hence Markov gives constant sampler mass on a relaxed clean-error threshold once `T=O(\theta^{-2}\log(1/\epsilon))`.

**Cautions:** Average correlation `E_{x,h}[c(x)h(x)]>=theta` is insufficient; the margin must hold pointwise or on high `P`-mass. The margin parameter must be inverse-polynomial, and the distribution `q_B` must be public/computable. A hidden DCHP empirical margin is not enough without clean-population transfer.

## C051. Needle-Cover Bags Obstruct Label-Oblivious Random Vote Lists

**Status:** accepted as an arbitrary-bag/random-sampler stress test; not a DCHP-generated-bag lower bound.

**Claim:** There are arbitrary empirical bags for the exact DCHP class where a zero-error `T=2k` sparse majority exists but good votes require a specific hidden `k`-set of columns and exact offset balance. For iid product sampling over columns, if the sampler has not identified the required set among `M` columns, some required set has good-vote probability at most about
$$
\left(\frac{Ck}{M}\right)^k .
$$
For `M=poly(s)` and `k=Theta(log s)`, this is `exp(-Theta(log^2 s))`, not inverse-polynomial.

**Use:** Existence of one good sparse majority does not imply that uniform, frequency-weighted, or label-oblivious random vote lists will find it.

**Cautions:** A sampler that already knows the required columns can evade the bound. Many-good-vote or robust-margin bags may also be easy. The statement is scoped to arbitrary bags and insufficiently informed samplers; it does not prove failure for DCHP-generated bags, boosting-induced samplers with a proved mass lemma, or selectors that explicitly solve the column-identification problem.

## C052. Regularity Assumptions Must Reach Complete Final Classifiers

**Status:** accepted conditional-framework refinement.

**Claim:** Stability, compression, or distribution-dependent quotient assumptions can serve as `CleanPopulationTransfer` certificates only when they apply to complete final classifiers or to the whole clean-sample-to-final-classifier mechanism, including adaptive weak calls, bag generation, selector choices, weak-learner randomness, and final aggregation.

**Consequences:** Per-call stability or per-call compression of the supplied weak learner is insufficient by itself. A stable base bag can be followed by an unstable final selector; per-call logarithmic compression across `T=Theta(log s)` rounds can give total witness length `Theta(log^2 s)`; and a quotient defined only after seeing the same clean certification sample can overfit like the singleton memorizer.

**Cautions:** These are additional regularity hypotheses, not consequences of the atlas fixed-slack source. A full conditional implication still needs clean discovery or total random-discoverable compression, clean-population transfer, and a polynomial final selector or explicit final list.
