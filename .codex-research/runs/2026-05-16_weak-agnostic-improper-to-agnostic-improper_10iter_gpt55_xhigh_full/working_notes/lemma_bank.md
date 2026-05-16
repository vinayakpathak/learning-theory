# Lemma Bank

## L001. Correlation Translation

For labels and hypotheses in `{-1,+1}`,
$$
\operatorname{err}(h,Y)=\frac{1-\mathbb{E}[hY]}{2}.
$$
Thus `err(h) <= OPT_C + beta` iff
$$
\mathbb{E}[hY]\ge \sup_{c\in C}\mathbb{E}[cY]-2\beta.
$$

## L002. Hard-Band Dummy Answer

Let `beta=1/2-gamma`. If `OPT_C(Q) >= gamma`, then any hypothesis with `err_Q(h) <= 1/2` satisfies the fixed-slack weak guarantee on `Q`.

Proof: `OPT_C(Q)+beta >= gamma + (1/2-gamma)=1/2`.

## L003. Clean-Mixture Decomposition

If a comparator `c` has error `eta <= 1/2` under `D`, then `D` can be decomposed as
$$
D=(1-2\eta)D_{\mathrm{clean}}+2\eta D_{\mathrm{bal}},
$$
where labels equal `c(X)` on `D_clean`, and `c` has error exactly `1/2` on `D_bal`.

This is an existential decomposition of measures, not an algorithmic way to identify clean membership.

## L004. Clean-Conditional Excess Bound

For a comparator `c` with `p=\Pr[Y=c(X)]>0`, let `D_c^+=D | [Y=c(X)]`. Then for every binary `h`,
$$
\operatorname{err}_D(h,Y)-\operatorname{err}_D(c,Y)
=
\Pr[h\ne c,Y=c]-\Pr[h\ne c,Y\ne c]
\le p\,\operatorname{err}_{D_c^+}(h,c)
\le \operatorname{err}_{D_c^+}(h,c).
$$

Hence if `err_D(c) <= OPT_C(D)+tau` and `err_{D_c^+}(h,c) <= alpha`, then `err_D(h,Y) <= OPT_C(D)+tau+alpha`.

## L005. Validation Over A Polynomial Candidate List

Let `L` be a candidate list independent of a fresh validation sample. With
$$
m=O((\log |L|+\log(1/\delta))/\epsilon^2)
$$
fresh labeled examples, empirical risk minimization over `L` returns, with probability at least `1-delta`, a hypothesis whose true error is within `O(epsilon)` of the best hypothesis in `L`.

Together with L004, a polynomial list containing a clean-conditional learner for a near-optimal comparator implies agnostic learning.

## L006. Random Classification Noise Recovery

If `Y=f(X)N`, where `N=-1` with probability `eta<1/2` independently of `X`, then
$$
\operatorname{err}_D(h,Y)=\eta+(1-2\eta)\operatorname{err}_{D_X}(h,f).
$$
Thus achieving error `eta + epsilon` forces recovery of `f` to error at most `epsilon/(1-2 eta)`.

## L007. Posterior Agreement Filter Threshold

In the same random-classification-noise model, suppose a current predictor `Z` has correlation
$$
r=\mathbb{E}[Zf].
$$
Conditioning on the event `Y=Z` gives conditional noise relative to `f`
$$
\frac{\eta(1-r)}{1+r(1-2\eta)}.
$$
This is below `gamma` only if
$$
r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
So agreement filtering creates a low-noise query only after the algorithm already has nontrivial comparator information.

## L008. Hidden-Set Smooth Isolation Candidate

Toy model: `X=[N]`, a random hidden clean set `S` has density `p=1-2 eta`, and labels are target-preserving. For a fixed marginal `nu` with `||nu||_infty <= L/N`,
$$
\Pr[\nu(S)\ge p+t]\le \exp(-\Omega(t^2N/L)).
$$
Taking `t=2(eta-gamma)`, a target-preserving query has `OPT_C < gamma` only if it over-concentrates on `S`.

Status: nonadaptive concentration is plausible; adaptive transcript-dependent versions remain unproved.

## L009. Corrected da Cunha Parameter Translation

Given the atlas lower bound `corr(h) >= rho - 2 beta` and the trivial bound `corr(h) >= -1`, the implication
$$
\operatorname{corr}(h)\ge \gamma_0\rho-\epsilon_0
$$
holds uniformly for `rho in [-1,1]` if
$$
\epsilon_0 \ge 1-\gamma_0(1-2\beta).
$$
For `gamma_0=1`, this reduces to `epsilon_0 >= 2 beta`. If `rho>=0` is guaranteed, `epsilon_0 >= 2 beta` also suffices for every `gamma_0 <= 1`.

Moreover, for every fixed `beta<1/2` there is an interior nontrivial choice. Taking
$$
\gamma_0>\frac{1}{2(1-\beta)}
\quad\text{and}\quad
\epsilon_0=1-\gamma_0(1-2\beta)
$$
gives `epsilon_0 < gamma_0`, hence positive `theta=(gamma_0-epsilon_0)/2`, while staying within the sufficient condition above.

## L010. Loss And Mistake Residual Accounting

For deterministic `g`, split the domain by correctness of `c` and `g`:
$$
a=\Pr[c=Y,\ g\ne Y],\quad
b=\Pr[c\ne Y,\ g=Y],\quad
d=\Pr[c\ne Y,\ g\ne Y].
$$
Then
$$
\operatorname{err}(g)-\operatorname{err}(c)=a-b,
$$
but on the mistake residual `M={g\ne Y}`,
$$
\operatorname{err}_{D|M}(c)=\frac{d}{a+d}.
$$
Thus positive excess `a>b` does not control the residual noise; `d/(a+d)` can be arbitrarily close to `1`.

For a randomized predictor with loss `ell=(1-FY)/2`, the high-loss residual `Q proportional to ell D` satisfies
$$
\operatorname{err}_Q(c)
=
\frac{E[1_{c\ne Y}\ell]}{E[\ell]}.
$$
Excess only fixes the denominator relative to `err(c)`; it does not upper-bound the noisy numerator enough to force `err_Q(c)<gamma`.

## L011. Aggregate RCN Agreement/Mistake Formulas

Let `Y=f(X)N`, where `Pr[N=-1]=eta`, and let `Z` be a fresh predictor independent of the current noise bit conditional on `X`. With `r=E[Zf]`,
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
Therefore agreement filtering beats the weak threshold `gamma` iff
$$
r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
For `r>=0`, mistake filtering has noise at least `eta`.

This is an aggregate-cell statement; sign-specific cells require separate posterior checks.

## L012. Soft Public-Filter Identity

In the RCN model, let a target-preserving filter be
$$
W(x,y)=a(x)+b(x)y,\qquad a(x)\ge |b(x)|,
$$
with labels left as `Y`. If `A=E[a(X)]>0`, `B=E[b(X)f(X)]`, and `r=B/A`, then the accepted distribution has noise relative to `f`
$$
\eta_W
=
\frac{\eta(A-B)}{A+(1-2\eta)B}
=
\frac{\eta(1-r)}{1+(1-2\eta)r}.
$$
Consequently `eta_W<gamma` iff
$$
r>\tau_{\eta,\gamma}
:=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

## L013. Fixed Smooth Public Filters Rarely Beat The Threshold For Random Targets

Let `X=[N]` be uniform and let `f` be iid Rademacher. For a fixed target-preserving filter independent of `f`, suppose the symmetric part satisfies `0<=a(x)<=L` and `A=E[a(X)]>=alpha`. With `r=E[b(X)f(X)]/A`, Hoeffding gives
$$
\Pr_f[r\ge \tau]\le
\exp(-\Omega(\tau^2\alpha N/L)).
$$

The constants are not audited here. The lemma is a random-target toy-model concentration statement, not a represented-class lower bound.

## L014. Binary-Event KL Transfer

Let `P` be the true joint law of `(F,T)` and `Q=P_F P_T` the independent coupling. If `D_{KL}(P||Q)=B` and an event `E` has `Q(E)<=e^{-\lambda}`, then
$$
P(E)\le \frac{B+\ln 2}{\lambda}.
$$

Proof sketch: data processing gives `B >= kl(P(E)||Q(E))`, and
`kl(p||q) >= p\ln(1/q)-\ln 2`.

This is the corrected form needed for adaptive public-filter barriers; statements like `I(F;T) >= kl(P(E)||p)` require `p` to be a valid upper bound in the right direction and are false if used with a loose `p` and `P(E)<p`.

## L015. Realized Adaptive PAC-Call Union Bound

Suppose a wrapper makes `q` adaptive calls to the fixed weak learner. If, conditional on the past before call `t`, the wrapper can provide fresh iid samples from the realized query distribution `Q_t`, then running the weak learner with confidence `delta/q` gives, with probability at least `1-delta`, valid weak guarantees for all realized calls.

This lemma does not require global control of `Range(A)`. It also does not apply to reused empirical tuples or to hidden-clean distributions unless the wrapper has justified fresh sampling from the intended population query.

## L016. Global Clean-Transcript Menu Lemma

Let `c` satisfy `err_D(c) <= OPT_C(D)+tau`, let `p=Pr[Y=c(X)]`, and let `D_c^+=D | [Y=c(X)]`. Suppose an evaluable reconstruction procedure `Rec`, possibly using validation-independent public data `U`, maps `K` iid clean examples from `D_c^+` plus controlled advice/randomness to a complete final classifier. Assume
$$
\Pr[\operatorname{err}_{D_c^+}(\operatorname{Rec},c)\le \alpha]\ge q.
$$
If raw tuple sampling and advice/search have polynomial cost, for example
$$
p^{-K}q^{-1}A_{\mathrm{search}}
\le \operatorname{poly}(s,1/\epsilon,\log(1/\delta)),
$$
then sampling raw `K`-tuples, applying `Rec`, and validating the resulting finite list on fresh noisy examples yields a classifier with error at most
$$
\operatorname{OPT}_C(D)+\tau+\alpha+O(\epsilon).
$$

When `p >= 1/2`, the raw clean-tuple penalty is at most `2^K`. If `OPT_C(D)` is within `O(epsilon)` of `1/2`, a separate constant-hypothesis case is needed instead of relying on the clean-tuple lower bound. Enumerable advice of length `b` contributes `A_search=2^b`; sampleable randomness should be accounted through its success probability rather than automatically enumerated.

## L017. Hidden-Mask Anti-Hitting Lemma

In a hidden-mask toy model, condition on an observable transcript `T`. Suppose an explicit candidate menu contains index sets `I_1,\dots,I_L`, and each `I_j` needs all of at least `K_j` distinct positions to be clean. If
$$
\Pr[I_j\text{ is fully clean}\mid T]\le p^{K_j}
$$
for every `j`, then
$$
\Pr[\exists j\le L:\ I_j\text{ is fully clean}\mid T]
\le \sum_{j=1}^L p^{K_j}.
$$
In particular, if all `K_j>=K`, the bound is `Lp^K`.

This is only a proof-skeleton obstruction for mask-independent or low-information raw tuple sampling. It is not a lower bound against repeated-sample denoising, posterior-biased filtering, class-structured learning, implicit optimization, or final-classifier menus.

## L018. Adaptive Smooth Public-Filter Information Barrier

Let `F in {+-1}^N` be iid uniform and let a transcript `T` include all randomness and the selected target-preserving filter
$$
W_T(x,y)=a_T(x)+b_T(x)y,\qquad 0\le a_T(x)\le L,\quad |b_T(x)|\le a_T(x).
$$
Define
$$
A_T=\frac1N\sum_x a_T(x),
\qquad
R_T(F)=\frac{\sum_x b_T(x)F(x)}{\sum_x a_T(x)}
$$
when `A_T>0`. Then for any `alpha,tau>0`,
$$
\Pr[A_T\ge \alpha,\ R_T(F)\ge \tau]
\le
\min\left\{1,\frac{I(F;T)+\ln 2}{\tau^2\alpha N/(2L)}\right\}.
$$

Proof sketch: under the independent coupling `P_F P_T`, condition on `T=t` and apply Hoeffding:
$$
\Pr[R_t(F)\ge \tau]\le
\exp(-\tau^2\alpha N/(2L)).
$$
Then transfer back to the true joint law using L014.

For iid uniform RCN samples `Y=F(X)N_eta`, `M` raw examples contribute at most
$$
M(\ln 2-h_2(\eta))
$$
nats of mutual information about `F`, before adding oracle-output and evaluation leakage.

## L019. Public-Posterior Filtering Lower Bound

Let `G` be a sigma-field and let `c` be a comparator such that
$$
\Pr[c(X)\ne Y\mid G]=\eta
$$
almost surely with `eta<1/2`. For any nonnegative `G`-measurable weight `W` with `E[W]>0` and any `G`-measurable sign relabeling `Y'=S Y`, `S in {+-1}`,
$$
\Pr_W[c\ne Y']
=
\frac{E[W(\eta 1_{S=1}+(1-\eta)1_{S=-1})]}{E[W]}
\ge \eta.
$$

Thus public filtering/relabeling cannot lower comparator noise unless the transcript first creates cells with lower posterior comparator error.

## L020. Information-Charged Hidden-Certificate Transfer

Let `S` be a hidden clean mask and `T` a pre-validation transcript. Let `P` be their true joint law and `Q=P_S P_T` the independent coupling. Suppose a success event `E` has, under `Q`, the certificate bound
$$
Q(E\mid T=t)\le \sum_{\sigma\in\Sigma(t)}w_\sigma p^{K_\sigma}
$$
for transcript-selected certificates requiring `K_sigma` distinct clean positions. Define
$$
\mu=E_T\sum_{\sigma\in\Sigma(T)}w_\sigma p^{K_\sigma}.
$$
If `mu<1`, then
$$
P(E)\le \frac{I(S;T)+\ln 2}{\ln(1/\mu)}.
$$

This is L014 applied to the independent-coupling bound `Q(E)<=mu`. It is useful only after the hidden-mask model, certificate completeness, branch weights, distinct-position requirement, and validation independence are all explicitly specified.

## L021. Conditional Vote-Selector Lemma

Let `B={h_1,\ldots,h_M}` be fixed before selector-training and final validation, and let `V_B` be a specified threshold-vote class over the features `h_i(x)`. If `c` satisfies `err_D(c,Y)<=OPT_C(D)+tau`, if some `v in V_B` has
$$
\operatorname{err}_{D_c^+}(v,c)\le \alpha,
$$
and if a selector outputs `\hat h` with
$$
\operatorname{err}_D(\hat h,Y)
\le
\inf_{v\in V_B}\operatorname{err}_D(v,Y)+\xi,
$$
then
$$
\operatorname{err}_D(\hat h,Y)\le OPT_C(D)+\tau+\alpha+\xi.
$$

For unrestricted real-weighted thresholds over `M` binary features, `VC(V_B)<=M+1`, so statistical generalization from fresh samples is polynomial. Computing the selector is a separate algorithmic primitive, essentially agnostic halfspace selection over the generated feature map.

## L022. Finite-Domain Improper Table Learner

If `|X|=N`, the class of all Boolean predictors on `X` has VC dimension `N`. With
$$
m=O((N+\log(1/\delta))/\epsilon^2)
$$
samples, ERM over all labelings, equivalently empirical majority with suitable handling of low-mass unseen points, achieves Bayes risk plus `O(epsilon)` with high probability. Therefore for `N=poly(s)`, every class on `X` is efficiently distribution-free agnostically improperly learnable by a table hypothesis.

This blocks separations based only on explicit polynomial-length block codes.

## L023. Codeword Soft-Loss And RCN Prediction Identities

For a codeword class `C subset {+-1}^X`, marginal `mu`, and soft label function `a(x)=E[Y\mid X=x]`,
$$
\operatorname{err}_D(c,Y)
=
\frac{1-E_\mu[c(X)a(X)]}{2}.
$$
Thus proper code learning corresponds to weighted/soft nearest-codeword optimization.

Under fresh RCN labels `Y=c^\star(X)N_eta`,
$$
\operatorname{err}_D(h,Y)
=
\eta+(1-2\eta)\operatorname{err}_\mu(h,c^\star).
$$
So strong agnostic improper learning to noisy excess `epsilon` implies prediction of the planted codeword to error `epsilon/(1-2eta)` under `mu`, but not necessarily message recovery unless an additional reconstruction theorem is available.

## L024. Public Sigma-Field Residual Optimum

Fix a comparator `c` and a public sigma-field `G`. Let
$$
\eta_G=\Pr[c(X)\ne Y\mid G].
$$
For any nonnegative `G`-measurable filter `W` with `E[W]>0` and any `G`-measurable sign relabeling `Y'=SY`, `S in {+-1}`,
$$
\Pr_W[c(X)\ne Y']
=
\frac{E[W(\eta_G1_{S=1}+(1-\eta_G)1_{S=-1})]}{E[W]}.
$$
Consequently, if arbitrary concentration on positive-mass public cells is allowed, the infimum over public filters and sign flips is
$$
\operatorname*{ess\,inf}\min\{\eta_G,1-\eta_G\}.
$$
In a finite partition, this is `min_{i:p_i>0} min{eta_i,1-eta_i}`.

This lemma is about the fixed comparator `c`; using it as a weak-oracle silence statement requires additional no-other-witness or public-certificate routing assumptions for `OPT_C`.

## L025. Flat-Posterior Excess Counterexample

For any `gamma < eta < m <= 1/2`, there are finite public-cell distributions with
$$
\Pr[c(X)\ne Y\mid G=i]=\eta
$$
for every public cell, while
$$
\operatorname{err}(c,Y)=\eta,\qquad
\operatorname{err}(g,Y)=m.
$$
Then `g` has positive excess over `c`, but by L024 every public filter/sign relabeling has comparator error at least `eta > gamma`.

Concrete four-cell realization for `gamma=0.1`: take cells indexed by `(Y,g)` with masses `0.35,0.35,0.15,0.15`, where `g` is correct on the first two cells and wrong on the last two. Split each cell so that `c=Y` on `80%` of its mass and `c=-Y` on `20%`. Then `err(c)=0.2`, `err(g)=0.3`, and every sign-specific public cell has comparator posterior `0.2`.

## L026. Bounded Public Filter Lower-Tail Duality

For a fixed public sigma-field `G`, fixed public relabeling `Y'`, and
$$
m=E[1[c(X)\ne Y']\mid G],
$$
the best bounded public filter with `0 <= W <= L` and `E[W]=alpha`, where `0<alpha<=L`, solves the lower-tail problem
$$
\min_{0\le W\le L,\ E[W]=\alpha}E[Wm]
=
\sup_{\tau\in\mathbb R}
\left\{\alpha\tau-L\,E[(\tau-m)_+]\right\}.
$$
Dividing by `alpha` gives the minimum comparator error under such smooth mass constraints. Optimizing over relabelings amounts to applying this lower-tail calculation to the corresponding public posterior variables.

Thus convex duality does not itself create a low-noise chunk; it only identifies whether the public posterior already has enough low tail.

## L027. Anchor Doping And Lock-In

For public anchor labels `a(X)` and doped labels
$$
Y_\lambda =
\begin{cases}
a(X), & \text{with probability }1-\lambda,\\
Y, & \text{with probability }\lambda,
\end{cases}
$$
the public hypothesis `a` has doped error
$$
\operatorname{err}_{D_\lambda}(a,Y_\lambda)
=\lambda\operatorname{err}_D(a,Y)\le \lambda.
$$
So for `lambda <= beta`, `a` is a legal improper `OPT+beta` weak answer.

In a proper support-function abstraction with slack `alpha=2 beta`, direction `z_lambda=(1-lambda)u+lambda a`, and `c_0 in C`,
$$
\sigma_C(z_\lambda)-\langle c_0,z_\lambda\rangle
\le
(1-\lambda)(\sigma_C(u)-\langle c_0,u\rangle)
+\lambda(\sigma_C(a)-\langle c_0,a\rangle).
$$
If this upper bound is at most `alpha`, an adversarial proper oracle may return `c_0`.

For atlas-improper use, any positive cap-separation condition must quantify over all legal binary outputs, not just concepts in `C`.

## L028. Information Cost Of Public Clean-Status Bias

Let `S_c=1[c(X)\ne Y]` have marginal `eta`, and let `G` be public information. If `A in sigma(G)` has `Pr[A]=mu` and
$$
\Pr[S_c=1\mid A]=\gamma',
$$
then by data processing,
$$
I(S_c;G)\ge I(S_c;1_A)
=
\mu\,\mathrm{kl}(\gamma'\|\eta)
+(1-\mu)\,\mathrm{kl}(\eta_{\bar A}\|\eta)
\ge
\mu\,\mathrm{kl}(\gamma'\|\eta),
$$
where `eta_{\bar A}=Pr[S_c=1 | A^c]`.

This is a per-example information diagnostic for public low-noise chunks. It becomes a learning lower bound only after specifying how transcripts generate `G` and charging oracle outputs/evaluation access.

## L029. Approximation-Gap Weak Learner

Assume an efficient improper agnostic approximator satisfies
$$
\operatorname{err}(P(D))\le a\,\operatorname{OPT}_C(D)+\xi
$$
for a fixed `a>1` and tunable `xi`. Fix any
$$
\beta>\frac{a-1}{2a},\qquad \gamma=\frac12-\beta.
$$
Choose `xi < beta-(a-1)gamma`. Run `P` and the two constants, then select by fresh validation. If `OPT_C(D)\ge \gamma`, a constant has error at most `1/2 <= OPT_C+\beta`. If `OPT_C(D)<\gamma`, then
$$
aOPT+\xi\le OPT+(a-1)\gamma+\xi<OPT+\beta.
$$
Hence the approximator gives an `OPT_C+\beta` weak agnostic improper learner.

This lemma is only a weak-side conversion. It gives a separation only together with independent hardness of `OPT+epsilon` improper prediction.

## L030. Signed CSP Approximation To Weak Learning

For an assignment-induced class `C={c_\sigma}` over query descriptors `x`, with labels `Y` not included in `x`,
$$
\operatorname{OPT}_C(D)=1-\max_\sigma \Pr[c_\sigma(X)=Y].
$$
If an empirical weighted signed-CSP algorithm returns an assignment with agreement within additive `kappa` of the best assignment, then finite-class uniform convergence over `2^n` assignments gives population error at most
$$
\operatorname{OPT}_C(D)+kappa+O(\xi)
$$
using
$$
m=O((n+\log(1/\delta))/\xi^2)
$$
samples. If instead it returns agreement at least `alpha` times the best agreement, then
$$
\operatorname{err}\le 1-\alpha(1-\operatorname{OPT}_C)
=\operatorname{OPT}_C+(1-\alpha)(1-\operatorname{OPT}_C)
\le \operatorname{OPT}_C+1-\alpha.
$$

Thus additive `kappa<1/2` or multiplicative `alpha>1/2` signed approximation can supply fixed slack. This requires arbitrary signed/weighted agnostic instances, not merely ordinary positive Max-CSP approximation.

## L031. Constant-Arity CSP Table Learner

For a finite predicate family of constant arity `k` over `n` variables, the set of possible constraint/query descriptors has size `n^{O(k)}`. Therefore the finite-domain table learner L022 strongly agnostically improperly learns any assignment-induced CSP class over this domain to Bayes risk plus `epsilon` in time polynomial in `n^k` and `1/epsilon`.

All-positive encodings are trivial for an even simpler reason: the improper constant predictor matching the public label has zero error. If the RHS or desired sign is included in `x`, an improper predictor can read it directly.

## L032. Public Randomized Relabeling Kernel Bound

Let `G` be a public observation and let a public randomized one-example query use nonnegative weights `w_+(G),w_-(G)` with positive total mass, producing query labels `+1` and `-1`. For a fixed comparator `c`, define
$$
p(G)=\Pr[c(X)=+1\mid G],\qquad u(G)=\min\{p(G),1-p(G)\}.
$$
Then the query error of `c` is
$$
\frac{E[w_+(G)(1-p(G))+w_-(G)p(G)]}{E[w_+(G)+w_-(G)]}
\ge
\frac{E[(w_+(G)+w_-(G))u(G)]}{E[w_+(G)+w_-(G)]}.
$$

For sign relabelings of an observed label `Y`, this specializes to the lower tail of `min{Pr[c\ne Y|G],Pr[c=Y|G]}`. The lemma is meaningful only relative to a public view or random-hidden-target model where `c(X)` is not already revealed by conditioning.

## L033. Exact DCHP Sparse-Majority Class

For a fixed generated bag `B={h_1,\ldots,h_M}` and integer `T`, the da Cunha-Hogsgaard-Paudice final class is
$$
V_{B,T}
=\operatorname{sign}(B^{(T)})
=\left\{x\mapsto \operatorname{sign}\left(\sum_{j=1}^M k_jh_j(x)\right):
k_j\in\mathbb N,\ \sum_jk_j=T\right\},
$$
with fixed threshold `0` and `sign(0)=1`.

For a validation-independent finite `B`, finite-list validation over an explicitly enumerated `V_{B,T}` has statistical cost `O((T\log |B|+\log(1/\delta))/epsilon^2)`, but exhaustive optimization costs `|B|^T`. Replacing that search requires an additional approximate empirical `0-1` selector or a different polynomial final-list generator. The hidden-clean margin in the DCHP proof is not an observable noisy-validation surrogate certificate.

## L034. Set-Cover Hardness For Exact Sparse-Majority ERM

For arbitrary binary empirical bags, deciding whether `V_{B,T}` has zero empirical error is Set-Cover hard.

Offset-column gadget: given universe `U`, sets `S_1,\ldots,S_M`, and budget `k`, create set columns `h_j`, one offset column `a`, and set `T=2k`. Add two positive control rows:

- upper row: `a=-1`, all `h_j=+1`;
- lower row: `a=+1`, all `h_j=-1`.

If `r` copies of `a` are selected, these rows are both correct iff `r=k`. For each element `e`, add a negative row with `a=-1` and
$$
h_j(e)=
\begin{cases}
-1,& e\in S_j,\\
+1,& e\notin S_j.
\end{cases}
$$
With `r=k`, if `c_e` selected set-column occurrences cover `e`, the margin is `-2c_e`. Because `sign(0)=+1` and the element label is `-1`, this row is correct iff `c_e>=1`. Hence zero error exists iff a size-at-most-`k` set cover exists, using repetitions to pad smaller covers.

Constant-column gadget: if a public `+1` constant `c_+` is allowed, set `T=2k-1`, label element rows positive with set columns indicating membership, and add a negative dummy row on which all set columns are `-1` and `c_+=+1`. Any zero-error vote yields a size-`k` cover; any size-`k` cover plus `k-1` copies of `c_+` gives zero error.

Thus exact proper ERM is NP-hard and W[2]-hard parameterized by `T`. If empirical risk is normalized over `N` rows, additive tolerance `xi<1/(2N)` distinguishes zero from nonzero optimum. These are worst-case arbitrary-bag statements, not DCHP-generated-bag lower bounds.

## L035. Rare-Slice Junk Lemma

Let `A_0` be a learner whose output `h_0` has error at most `OPT_C+\alpha` on query distribution `Q` with probability at least `1-\delta_0`. If a modified learner changes `h_0` only on a set `S` with `Q(S)\le \tau`, then the modified output has error at most `OPT_C+\alpha+\tau`.

For the constant class over `X=K\times\{\pm1\}^D`, choose a random key `R` independently of samples and output `z_i` on the slice `{R}\times\{\pm1\}^D` and the baseline constant elsewhere. Since
$$
E_R Q[k=R]=|K|^{-1},
$$
Markov gives `Pr_R[Q[k=R]>\tau]\le 1/(|K|\tau)`. Taking `|K| >= 2/(\tau\delta)` and splitting confidence with the baseline learner makes the rare-slice modification valid with failure at most `delta`.

For fixed `R` and baseline constant, the hypotheses indexed by `i in [D]` have dual VC at least `D`, witnessed by points `(R,z^S)` for all sign patterns `S subseteq [D]`.

## L036. Weak Learning Refutes Planted Labels Below The Weak Threshold

Let `beta=1/2-gamma`. Suppose a sample-access planted distribution over `(X,Y)` satisfies `OPT_C(D)<=eta<gamma`, and the null distribution has the same `X` marginal but iid unbiased labels independent of `X`. A fixed-slack learner returns, with high probability,
$$
\operatorname{err}_D(h)\le eta+\beta=\frac12-(\gamma-eta).
$$
On a fresh validation sample from the planted or null distribution, empirical error separates the two cases using
$$
O\left((\gamma-eta)^{-2}\log(1/\delta)\right)
$$
examples, because every fixed evaluable hypothesis has null error `1/2` in expectation and validation is independent of the learner's training sample.

Therefore refutation hardness for the same class and marginal cannot be assumed at noise `eta<gamma` together with the fixed-slack weak learner. Strong-side hardness for a separation must be placed in the hard band `eta>=gamma`, or be prediction/recovery hardness not contradicted by constant-advantage refutation.

## L037. Signed Agreement Approximation Thresholds

For assignment-induced signed classes, let
$$
A^*=\max_\sigma \Pr[c_\sigma(X)=Y]=1-\operatorname{OPT}_C(D).
$$
An additive signed approximator with agreement at least `A^*-\kappa` gives error at most `OPT_C+\kappa`.

A multiplicative agreement approximator with agreement at least `alpha A^*` gives
$$
\operatorname{err}
\le 1-\alpha A^*
=\operatorname{OPT}_C+(1-\alpha)A^*
\le \operatorname{OPT}_C+1-\alpha.
$$
Thus `alpha>1/2` yields some fixed slack below `1/2`, but matching a specified source tolerance `beta` in the worst case requires `1-alpha <= beta`, for example in the realizable case `OPT_C=0`.

## L038. Span Capture For Arbitrary Marginals Over `F_2^n`

Let `mu` be any distribution on `F_2^n`, let `x_1,\ldots,x_m` be iid from `mu`, and let
$$
V_t=\operatorname{span}(x_1,\ldots,x_t).
$$
Fix a threshold `tau<1`. While `mu(V_t)<tau`, the next sample increases the span with conditional probability at least `1-tau`, because
$$
\Pr[x_{t+1}\notin V_t\mid V_t]=1-\mu(V_t)>1-\tau.
$$
If `tau <= 3/4` and `m=8n`, stochastic domination by Bernoulli trials and Chernoff bounds give
$$
\Pr[\mu(V_m)<tau]\le \exp(-\Omega(n)).
$$

For the parity near-separation, take `tau=1/2+O(gamma)` with `gamma<=1/8`. The lemma must be applied to the clean conditional marginal `D_X | [Y=c^*(X)]`, not to the original marginal under arbitrary agnostic noise.

## L039. Shrinking-Gap Weak Parity Learner Sketch

For parities over `F_2^n`, set `beta_n=1/2-gamma` with `n gamma=O(log n)`. A candidate weak learner is:

1. Draw `m=Theta(n)` labeled examples for each trial.
2. Solve the linear parity equations if they are consistent and add one consistent parity to a candidate list.
3. Repeat `R=exp(O(n gamma)) polylog(1/delta)` times.
4. Add both constants and select by fresh validation with accuracy `o(gamma)`.

If `eta=OPT_C(D)>=2 gamma`, constants are legal. If `eta<2 gamma`, a trial is all-clean relative to a fixed optimal parity `c^*` with probability at least `exp(-O(n gamma))`. Conditioned on all-clean, L038 gives span mass at least `1/2+2 gamma` over `D_{c^*}^+` with high probability, and any parity consistent with the batch has clean-conditional error at most `1/2-2 gamma`. L004 then gives noisy error at most
$$
eta+\frac12-2\gamma
=OPT_C(D)+\beta_n-\gamma.
$$

This is a size-dependent weak-slack sketch, not a proof for the fixed-constant atlas edge. For constant `gamma`, the all-clean event is exponentially unlikely.

## L040. Efficient Parity Slice Pullback

Let `C'` be a represented class over `X'`. Suppose there is an efficiently computable embedding `phi:F_2^n -> X'` such that for every parity `chi_s` there is `c'_s in C'` whose restriction to the slice is `chi_s` or a known sign flip. If `A'` is an efficient fixed-slack `OPT+beta` weak learner for `C'`, with `beta=1/2-gamma`, then running `A'` on the pushforward of a parity distribution through `phi` and pulling back the evaluable output gives a fixed-slack weak learner for parities.

Under uniform RCN labels `Y=chi_s(X)N_eta`, `eta<gamma`, the pulled-back output satisfies
$$
\mathbb E[h(\phi(X))Y]\ge 2(\gamma-\eta)
$$
and therefore, by independence of the fresh noise bit,
$$
\mathbb E[h(\phi(X))\chi_s(X)]
\ge \frac{2(\gamma-\eta)}{1-2\eta}.
$$
Taking `eta=gamma/2` gives constant correlation. Under an LPN prediction/search hardness assumption and efficient hypothesis evaluation, this blocks public parity-slice amplifications as fixed-constant weak-source candidates.

## L041. Rare-Slice Programmable Weak Outputs

For the singleton class `C={+1}` on a domain with a public key coordinate `k in K`, let `R` be uniform in `K`, and let `h_{R,j}` equal `+1` off the slice `{k=R}` while behaving arbitrarily on that slice. For every query distribution `Q`,
$$
\operatorname{err}_Q(h_{R,j})
\le \operatorname{err}_Q(+1)+Q[k=R]
=OPT_C(Q)+Q[k=R].
$$
Since `E_R Q[k=R]=1/|K|`,
$$
\Pr_R[Q[k=R]>\tau]\le \frac{1}{|K|\tau}.
$$
Thus `|K| >= 1/(tau delta_0)` and `tau<beta` make the randomized output `OPT+beta` valid for a single weak call with failure probability at most `delta_0`, regardless of the programmed behavior indexed by `j`.

This is stronger than mere range inflation when a bag generator actually includes the programmed outputs. It still gives only a black-box selector obstruction unless one also proves call scheduling, confidence/key-hit accounting, iid sample realization, harmless extra columns, constants/offset availability, and `T` alignment for the final sparse-majority selector.

## L042. Fixed-Slack Weak Learning Implies Low-Noise Sparse-K-XOR Prediction

Let `k=k(n)`, let `X_{n,k}` be the set of `k`-subsets of `[n]`, and let
$$
c_s(S)=(-1)^{\sum_{i\in S}s_i}.
$$
Assume uniform RCN labels
$$
S\sim \mathrm{Unif}(X_{n,k}),\qquad Y=c_s(S)N_\eta,
$$
where the fresh test noise bit is independent and `Pr[N_eta=-1]=eta<1/2`. If a fixed-slack learner with `beta=1/2-gamma` succeeds on this distribution and `eta<gamma`, then
$$
\operatorname{err}(h,Y)\le \eta+\beta
=\frac12-(\gamma-\eta),
$$
so
$$
\mathbb E[h(S)Y]\ge 2(\gamma-\eta)
$$
and
$$
\mathbb E[h(S)c_s(S)]
=\frac{\mathbb E[h(S)Y]}{1-2\eta}
\ge \frac{2(\gamma-\eta)}{1-2\eta}.
$$

For `eta=gamma/2`, the correlation is at least `gamma/(1-gamma)`. The lemma assumes the returned hypothesis is efficiently evaluable on fresh `k`-subsets and is a one-way stress test only; it does not turn sparse-XOR prediction on one marginal into distribution-free weak learning.

## L043. DCHP Three-Layer Capacity Decomposition

Separate DCHP-style proof obligations into three layers.

**Realized weak-call layer:** For `q=poly(...)` adaptive calls to well-defined population query distributions, fresh iid samples and confidence `delta/q` per call suffice to make all realized weak guarantees hold with probability at least `1-delta`. This is L015 and does not require global `Range(A)`/dual-VC control.

**Hidden-clean population layer:** If the proof only establishes that a generated transcript or bag works on a hidden clean empirical sample, finite bag size is not enough to infer performance on `D_c^+`. A replacement certificate is needed: uniform convergence over a controlled class, compression, stability, independence from the certification sample, or a direct clean-witness population theorem.

**Final selection layer:** Once a validation-independent finite class `L` of complete evaluable classifiers is fixed, fresh noisy validation selects within `O(epsilon)` of the best element using `O((\log |L|+\log(1/\delta))/epsilon^2)` samples. For a fixed bag `B` with `|B|=M`,
$$
\log | \operatorname{sign}(B^{(T)})|
\le O(T\log(M+T)).
$$
This is only a statistical guarantee; exact or approximate empirical selection over `sign(B^(T))` remains an algorithmic primitive.

## L044. Rare-Slice Final-Relevance Versus Weak-Lightness Tension

Consider a hard block `S` of population mass `alpha`, a weak-sample pool of size `m_w`, and a final selector sample of size `m_f`. To realize a gadget with `N` hard rows by iid final sampling, one typically needs
$$
m_f\alpha \gtrsim N\log N
$$
up to constants and row-probability imbalance. To keep the weak pool from seeing the hard block at all, one needs roughly
$$
m_w\alpha \ll 1.
$$
When `m_w` and `m_f` are comparable and `N` grows, these requirements conflict.

Moreover, for DCHP-style ordered tuple enumeration with repetitions, a single weak-pool point in `S` may allow a tuple-supported weak call with `Q(S)=1`, invalidating arbitrary rare-slice programming on `S`. This is a compatibility obstruction, not a formal lower bound for every DCHP variant.

## L045. Ideal Ghost Clean Transfer

Fix a comparator `c` and let `P=D_c^+`. Let a transcript `T` be independent of iid clean ghost examples
$$
Z_1,\ldots,Z_m\sim P,
$$
including their covariates. Let `V_T` be a finite class of complete classifiers measurable with respect to `T`, with `|V_T|\le N`. Then with probability at least `1-delta` over the ghost sample,
$$
\forall v\in V_T,\quad
\left|\operatorname{err}_P(v,c)-\widehat{\operatorname{err}}_{\mathrm{gh}}(v,c)\right|
\le
\sqrt{\frac{\log(2N/\delta)}{2m}}.
$$

Thus ghost-clean empirical success transfers to clean-population success for a validation-independent final class. The lemma does not prove that such a ghost-good `v` exists and does not make the clean mask observable from raw data.

## L046. Random Final-List Sufficiency

Let `B` and a sampler `Pi_B` over complete evaluable classifiers be fixed before held-out validation. Suppose for a comparator `c` with `err_D(c,Y)<=OPT_C(D)+tau`,
$$
\Pr_{v\sim\Pi_B}[\operatorname{err}_{D_c^+}(v,c)\le \alpha]\ge p .
$$
Draw
$$
R=O(p^{-1}\log(1/\delta))
$$
independent classifiers from `Pi_B`. With probability at least `1-delta`, the resulting list contains an `h` with clean-conditional error at most `alpha`. Fresh noisy validation over the list then returns, with the usual validation accuracy term,
$$
\operatorname{err}_D(\hat h,Y)
\le
OPT_C(D)+\tau+\alpha+O(\epsilon).
$$

This is useful only when `p` is inverse-polynomial and `Pi_B` is public/effective.

## L047. Pointwise-Margin Random Majority

Let `q` be a distribution over a fixed bag `B`, and let `P=D_c^+`. Suppose
$$
\Pr_{x\sim P}\left[\mathbb E_{h\sim q}c(x)h(x)\ge \theta\right]\ge 1-\alpha .
$$
For a random `T`-wise majority
$$
v(x)=\operatorname{sign}\left(\sum_{t=1}^T h_t(x)\right),
\qquad h_t\stackrel{iid}{\sim}q,
$$
Hoeffding gives
$$
\mathbb E[\operatorname{err}_P(v,c)]
\le
\alpha+\exp(-T\theta^2/2)
$$
up to tie-rule constants.

Consequently, if the right side is `mu`, Markov gives constant probability of drawing a vote with clean error at most, say, `2mu`. This lemma requires pointwise or high-mass margin, not merely aggregate correlation.

## L048. Needle-Cover Product-Sampler Bound

In the offset Set-Cover sparse-majority gadget specialized to a unique required `k`-set `S`, take `T=2k`. A zero-error vote must use exactly `k` copies of an offset column `a` and one copy of each required set column in `S`. For iid with-replacement sampling with probabilities `pi_a,pi_1,\ldots,pi_M`, the exact good-multiset probability is
$$
p_{\mathrm{good}}(S)
=
\frac{(2k)!}{k!}\pi_a^k\prod_{j\in S}\pi_j .
$$
For every product distribution over the `M` set columns, some `S` of size `k` satisfies
$$
p_{\mathrm{good}}(S)\le \left(\frac{Ck}{M}\right)^k
$$
for an absolute constant `C`.

Proof sketch: choose `S` among low elementary-symmetric-product columns using Maclaurin or averaging, and use `pi_a(1-pi_a)<=1/4` plus Stirling. For `M=poly(s)` and `k=Theta(log s)`, the bound is quasi-polynomially small. This is an arbitrary-bag and insufficiently informed product-sampler obstruction, not a DCHP-generated-bag theorem.

## L049. Total Final-Classifier Compression Route

Let `P=D_c^+` and suppose a reconstruction procedure maps `K` iid clean examples from `P`, plus `b` enumerable advice bits or sampleable randomness, to a complete efficiently evaluable classifier with `P`-error at most `alpha` with probability at least `q`. If, away from the endpoint case,
$$
p^{-K}2^bq^{-1}
\le
\operatorname{poly}(s,1/\epsilon,\log(1/\delta)),
\qquad p=Pr_D[Y=c(X)],
$$
then raw tuple sampling, reconstruction, and fresh noisy validation give error at most
$$
OPT_C(D)+\tau+\alpha+O(\epsilon)
$$
for `c` with `err_D(c,Y)<=OPT_C(D)+tau`.

This is a restatement of the clean-transcript menu route with the key iteration-10 emphasis: the compression must be total compression for complete final classifiers, including adaptive calls, selector choices, randomness, advice, and aggregation. Per-call compression alone is not enough unless the uncompressed selector state is also accounted for.
