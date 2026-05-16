# Counterexamples And Obstructions

## O001. Hard Band

With `beta=1/2-gamma`, the source is forced to be useful only when `OPT_C < gamma`. In the band
$$
\gamma \le \operatorname{OPT}_C(D)\le 1/2-\epsilon,
$$
the weak learner may legally return a hypothesis no better than random on the original distribution, while strong agnostic learning still requires nontrivial error improvement.

## O002. Negative-Correlation Stress Test

For arbitrary classes, `rho = sup_c corr(c,Y)` can be negative. This breaks the unqualified claim that the fixed source implies a da Cunha weak condition with `epsilon_0=2 beta` for every `gamma_0 <= 1`. The corrected condition must either use `gamma_0=1`, assume `rho>=0`, or increase `epsilon_0` as in L009.

## O003. Point-Mass And Empirical Low-OPT Queries

After observing a labeled point `(x,y)`, a wrapper can query a distribution concentrated on that point. For rich classes this has `OPT=0`, but any weak answer covers negligible target mass. Similarly, empirical-support queries can be perfectly memorized while revealing little global information.

Implication: low `OPT` on a query is not the same as useful hidden-comparator information.

## O004. Artificial Relabeling

A wrapper can define query labels using a public hypothesis `g`. If `g in C` or the class is rich enough, the query has low `OPT`; the oracle can return `g`, yielding no information about the target comparator. Restricted oracle barriers must distinguish public-witness low-noise queries from hidden-witness low-noise queries.

## O005. Smooth Dummy Responses Can Leak Bits

Even on queries with `OPT >= gamma`, choosing the better of two constants can reveal a sign bit of label bias. Many adaptive smooth queries can become a weak statistical-query channel. A formal barrier must bound this information leakage rather than assume the transcript is independent of the hidden object.

## O006. Heavy-Atom Or Small-Support Targets

Spike-query uselessness requires a large-domain or high-min-entropy target marginal. If the target distribution has polynomial support or heavy atoms, memorization of observed examples can generalize, and the hidden-set barrier no longer applies.

## O007. Near-Endpoint OPT

If `OPT_C(D) >= 1/2 - O(epsilon)`, a constant hypothesis already achieves `OPT + O(epsilon)`. Negative constructions and random-witness arguments must keep a strict margin `OPT + epsilon < 1/2`.

## O008. Random Classification Noise Recovery

For `Y=f(X)N` with noise `eta`, achieving `eta+epsilon` error recovers `f` to error `epsilon/(1-2eta)`. This is a useful hardness template: if moderate-noise recovery of `f` is hard while low-noise weak learning is easy, then a conditional separation might follow. No actual represented class satisfying both sides is known from iteration 1.

## O009. Parity/LPN, Halfspace, Code, CSP, PRF Template Failures

The run starts with these templates already failing to provide a separation: either fixed-additive weak learning is already hard at low constant noise, or strong improper learning becomes plausible through validation, voting, public handles, or known structure. Iteration 1 did not repair any of these templates.

## O010. Four-Cell Residual Obstruction

Let masses be split by whether `c` and current `g` are correct. Take, for example,
$$
\Pr[c\text{ correct},g\text{ wrong}]=0.05,\quad
\Pr[c\text{ wrong},g\text{ correct}]=0,
$$
$$
\Pr[c\text{ wrong},g\text{ wrong}]=0.20,\quad
\Pr[c\text{ correct},g\text{ correct}]=0.75.
$$
Then `err(c)=0.20`, `err(g)=0.25`, so `g` has excess `0.05`; but on the mistake set `{g != Y}`, the comparator error is `0.20/0.25=0.8`. Excess alone therefore does not produce a low-noise residual.

## O011. Sign-Specific Cells Refute A Global-R RCN No-Go

In RCN, below-threshold global correlation `r=E[Zf]` does not preclude low-noise signed cells. For `eta=1/4`, `gamma=0.1`, and `r=0.4`, the aggregate agreement threshold is `0.5`, so agreement filtering remains too noisy. But one can choose a joint law of `(f,Z)` with a signed observable cell such as `Y=Z=+1` or `Y=Z=-1` on which `f` is determined, giving comparator error `0`.

This refutes broad one-sample observable no-go claims based only on global `r`. It does not rescue residual forcing, because such cells may be public-witness or target-mass-useless.

## O012. Public-Constant Filter

The target-preserving filter `W(x,y)=1[y=+1]` can make accepted labels publicly constant. If constants belong to the concept class, then `OPT_C=0` on the query for public reasons, even though the query need not reduce hidden-comparator noise below `gamma`.

This separates "low noise relative to hidden `f`" from "low `OPT_C`" and must be handled in any public-filter oracle barrier.

## O013. Uncontrolled Output Range And Dual VC

An improper weak learner may encode arbitrary sample-dependent bits into its output while preserving the weak error guarantee. Then `H=Range(A)` can have large primal or dual VC dimension. Even simple evaluable families can have large dual VC; for example coordinate projections on `{+-1}^N` have dual VC dimension `N`.

Thus efficient evaluation or short descriptions do not by themselves justify the da Cunha 2026 capacity assumptions.

## O014. Clean-Slice Useful But Noisy-Risk Bad Weak Hypothesis

Let the hidden clean mass be `p=Pr[Y=f(X)]=0.6`. A base hypothesis with clean-slice error `0.4` has positive clean advantage, but if it predicts `f` on the noisy slice, it is always wrong there. Its original noisy error is
$$
0.6\cdot 0.4+0.4\cdot 1=0.64.
$$
So noisy validation of individual weak hypotheses can reject hypotheses needed for a hidden-clean boosting proof.

## O015. Loose KL-Bound Stress Test

An information lower bound of the form `I(F;T) >= kl(alpha || p)` is invalid if `p` is merely a loose upper bound and the true success probability `alpha` is below `p`. The corrected adaptive transfer should use an independent-coupling event bound `Q(E)<=e^{-lambda}` and conclude `P(E) <= (I(F;T)+ln 2)/lambda`.

## O016. Memorizing Singleton Finite Bag

After seeing a hidden clean sample, a procedure can output a singleton bag containing one improper classifier that labels those clean sample points perfectly and behaves randomly off-sample. The bag has size one and empirical clean error zero, but clean population error about `1/2`.

Thus finite bag size alone cannot replace VC, compression, stability, independence from the clean certification sample, or a direct population guarantee.

## O017. Vote Search Blowup From A Polynomial Base Bag

If a generated base bag has `|B|=s^a` and the final classifier is an unrestricted `T`-wise vote with `T=Theta(log s)`, exhaustive search costs
$$
|B|^T=(s^a)^{\Theta(\log s)}
=\exp(\Theta(\log^2 s)).
$$
Finite-cardinality validation may have only `T log |B|` statistical cost, but optimization over all votes is not atlas-polynomial without an additional selector.

## O018. Hidden-Mask Anti-Hitting Stress Test

In a toy model where candidate clean transcripts are chosen before the hidden clean indicators are known, and each successful transcript needs `K` distinct clean positions, an explicit menu of `L` candidates succeeds with probability at most `Lp^K`.

This blocks raw tuple discovery when the total clean witness length is superlogarithmic. It is only a proof-skeleton obstruction, not a separation.

## O019. Repeated-Coordinate Denoising Bypasses Literal All-Clean Tuples

On a finite domain under random classification noise, repeated samples of the same coordinate allow empirical majority to estimate the clean label. Such an algorithm may recover the target without ever finding a large all-clean transcript.

This is a stress test against overbroad `p^K` lower bounds: they require hidden-mask independence and a literal-clean-transcript proof skeleton.

## O020. Oracle Handle Leakage

An improper weak oracle could return a short syntactic handle whose evaluation rule exposes many hidden target bits. If the handle is charged as only `O(1)` bits, a transcript-information lower bound is meaningless. If semantic evaluation access is included in the transcript, the information budget becomes large and the lower bound is correctly vacuous.

Any public-filter oracle barrier must specify whether returned hypotheses are full descriptions, bounded circuits, black-box handles with evaluation access, or adversarial canonical dummy replies.

## O021. Observable High-Clean Regions Break Global `p^K`

Let the global clean mass relative to comparator `c` be `p`, but suppose a public feature region `R` has
$$
\Pr[Y=c(X)\mid X\in R]\approx 1.
$$
A wrapper that samples from `R` obtains clean witnesses at rate near one, not `p^K`, without learning realized clean-mask bits.

This stress test forces any clean-transcript anti-hitting theorem to assume exchangeable hidden masks, mask-neutral transcripts, or an information/posterior charge for how `R` was identified.

## O022. Coordinate Bag For Vote-Selector Hardness

Let `X={+-1}^M` and let the generated bag contain the coordinate projections, and possibly their negations and a constant if the vote class needs them. Unrestricted real-weighted threshold votes over the bag are ordinary halfspaces in `M` dimensions.

Thus a generic efficient 0-1 selector over arbitrary polynomial bags would solve agnostic halfspace selection over arbitrary generated features. For restricted nonnegative or bounded `T`-wise votes, the exact constrained class needs its own reduction or algorithm.

## O023. Polynomial Coordinate Domains Kill Code Separations

For any concept class over a coordinate domain `X` with `|X|=N=poly(s)`, an improper learner can ignore the class and learn a table/empirical-majority predictor with sample complexity polynomial in `N` and `1/epsilon`. This achieves Bayes risk plus `epsilon`, hence at most `OPT_C+\epsilon`.

Therefore explicit polynomial-length block-code hardness cannot separate weak and strong improper agnostic PAC learning.

## O024. Deterministic Received-Word Fitting

Given deterministic labels from a hard received word, an improper learner is allowed to output any predictor close to that received word. It need not output a codeword, recover a message, or solve nearest-codeword decoding.

The RCN identity avoids this specific obstruction only for fresh independent noise around a planted codeword, where low noisy risk implies prediction of the planted codeword. That is a sample-access prediction hardness target, not classical full-word decoding hardness.

## O025. Flat Public Posterior With Positive Excess

Let `gamma=0.1`. Take four public cells indexed by `(Y,g(X))` with masses `0.35,0.35,0.15,0.15`, with `g` correct on the first two cells and wrong on the last two. Inside every cell, set
$$
\Pr[c(X)\ne Y\mid \text{cell}]=0.2.
$$
Then
$$
\operatorname{err}(c,Y)=0.2,\qquad
\operatorname{err}(g,Y)=0.3,
$$
so `g` has positive excess over `c`. But every public filter and sign relabeling over these cells has comparator error at least `0.2`; flipping labels gives error `0.8`.

This refutes any one-step public residual lemma based only on excess. It remains only a comparator-noise obstruction; low `OPT_C` for public or other-concept reasons is a separate issue.

## O026. Relabeling High-Noise Cells

The invariant for public relabeling is not merely `eta_G >= gamma`. If a public cell has
$$
\eta_G=\Pr[c(X)\ne Y\mid G]=0.95
$$
and `gamma=0.1`, then flipping labels makes the comparator error `0.05 < gamma`.

Any public-posterior no-go with sign relabeling must require
$$
\min\{\eta_G,1-\eta_G\}\ge \gamma
$$
on all allowed public cells.

## O027. Small-Doping Anchor Absorption

For doped labels that equal a public anchor `a(X)` with probability `1-lambda` and the target label with probability `lambda`, the public anchor has doped error at most `lambda`. Thus for `lambda <= beta`, returning `a` is a legal improper weak answer independent of the target.

This blocks infinitesimal anchor homotopy or finite-difference strategies: the target perturbation can be fully absorbed by the fixed additive slack.

## O028. Two-Vertex Anchor Lock-In

Let `C={c_good,c_bad}` and let the original target objective favor `c_good` over `c_bad` by a gap
$$
2\epsilon<\Delta\le 2\beta.
$$
If a public anchor favors `c_bad`, or merely does not penalize it enough, then along every line-segment doped direction the target-bad `c_bad` can remain within the fixed weak slack. An adversarial legal weak oracle may keep returning it even though it is not `epsilon`-good for the original objective.

This is a black-box candidate-generation obstruction, not a class separation: if both vertices are explicitly enumerable, fresh validation solves the finite class directly.

## O029. Hidden Distinguisher In Excess Algebra

The identity
$$
\operatorname{err}(g,Y)-\operatorname{err}(c,Y)
=E[1_{g\ne c}c(X)Y]
$$
shows that positive excess makes the hidden disagreement set `{g != c}` biased toward clean examples. But `{g != c}` is not public unless the transcript already contains information about `c`.

This is the basic obstruction to hard-core low-`OPT` chunk proofs from excess alone: the useful separator exists in hindsight but is not necessarily a sampleable query for the weak learner.

## O030. Public Randomized Kernel Flat-Posterior Obstruction

For any `gamma < eta < m <= 1/2`, take public cells indexed by `(Y,g(X))` or by any finite public partition. Put total mass `1-m` on cells where `g=Y` and total mass `m` on cells where `g=-Y`. Inside every public cell, arrange
$$
\Pr[c(X)\ne Y\mid \text{cell}]=\eta.
$$
Then
$$
\operatorname{err}(c,Y)=\eta,\qquad \operatorname{err}(g,Y)=m,
$$
so `g` has positive excess over `c`. But every public randomized filter/relabeling kernel measurable with respect to those cells has comparator error at least `eta`: the best public label in each cell still predicts `c(X)` with error `eta`.

This extends the flat-posterior obstruction from sign relabelings to arbitrary public binary relabeling kernels. It is a comparator-error obstruction, not an `OPT_C` lower bound unless `C={c}` or a no-other-witness condition is imposed.

## O031. Full-Instance Measurability Stress Test

The public-posterior lemmas must not be stated with an unrestricted sigma-field containing full `X` while treating `c` as a fixed deterministic concept. If `G` includes `X`, then `c(X)` is mathematically `G`-measurable and
$$
\Pr[c(X)=+1\mid G]\in\{0,1\}.
$$
The posterior-uncertainty lower bound becomes vacuous.

To use posterior uncertainty against full-instance algorithms, one needs a random-hidden-target or information-budget model in which conditioning on public `X` does not reveal the hidden target values, or an explicit restriction to a coarse public view. This is a scope obstruction for overbroad residual lower bounds.

## O032. CSP Public-Label And Polynomial-Domain Obstructions

Several CSP encodings fail before reaching any subtle hardness issue:

- If examples are clauses/constraints with label `1`, then the improper classifier `h=1` has zero error.
- If a signed constraint's RHS or desired sign is part of the public input `x`, then an improper classifier can read it.
- For constant arity `k`, the set of all constraint descriptors over `n` variables has size `n^{O(k)}`, so table learning reaches Bayes risk plus `epsilon`.

Thus ordinary fixed-arity CSP approximation or satisfiability gaps are proper/assignment obstructions, not improper prediction obstructions.

## O033. Exact Sparse-Majority Selector Stress Tests

The DCHP final class `sign(B^(T))` is not the same as unrestricted halfspaces over bag features.

If `B` contains coordinate projections, their negations, and constants, then relaxed nonnegative real-weight votes can simulate ordinary signed affine halfspaces, and exact `T`-wise votes can simulate bounded rational sparse halfspaces only when `T` and margins are large enough. Without complements, the class can be monotone and much weaker.

Therefore generic halfspace hardness is only a warning for selector variants. Hardness or algorithms for the exact zero-threshold nonnegative integer `T`-majority class require a separate reduction or rounding theorem.

## O034. Set-Cover Gadgets For Exact Sparse-Majority ERM

Worst-case arbitrary bags for the DCHP class can encode Set Cover directly. One gadget uses an offset column and `T=2k`: two positive control rows force exactly `k` offset copies, and negative element rows are correct exactly when at least one of the remaining `k` set columns covers the element. Another gadget uses a public `+1` constant and `T=2k-1`: a negative dummy row forces enough set columns, while positive element rows encode coverage.

Thus finite statistical size of `sign(B^(T))` does not imply computationally efficient selection. The obstruction is scoped: it is for arbitrary tabulated bags and proper empirical 0-1 ERM, not for DCHP-generated bags, margin-promised selector instances, or alternate final-list mechanisms.

## O035. Rare-Slice Junk Range Inflation

For `C={+1,-1}` on `X=K\times\{\pm1\}^D`, a weak learner may output the empirical best constant except on a randomly chosen key slice `{R}\times\{\pm1\}^D`, where it outputs a coordinate `z_i`. If the slice has query mass at most `tau`, the error increases by at most `tau`, so the learner remains `OPT+beta` valid after allocating slack.

For fixed `R`, the hypotheses indexed by coordinates have dual VC at least `D`, witnessed by all sign-pattern points on that slice. Hence a learner can be semantically valid while having global range and dual-VC parameters that are unusable in DCHP-style exponents.

This obstruction does not imply the constant class is hard. It only refutes free global range control for an arbitrary supplied weak learner.

## O036. Low-Noise Refutation Hardness Conflicts With The Weak Source

Suppose a planted signed-CSP or RRHS distribution has `OPT_C <= eta < gamma`, where `beta=1/2-gamma`. The fixed-slack weak learner returns a hypothesis of error at most
$$
\eta+\beta=\frac12-(\gamma-\eta),
$$
so fresh validation distinguishes planted labels from iid unbiased RHS labels with polynomial samples when `gamma-eta` is inverse-polynomial or constant.

Therefore standard noiseless or very-low-noise random-CSP refutation hardness cannot be imported as the strong-side hardness for the same class and model. A separation needs high-noise hard-band improper prediction/refutation, not merely assignment recovery, value approximation, or low-noise refutation.

## O037. Uniform Parity Blocks Constant-Gap Clean-Span Recovery

For parities over `F_2^n` under the uniform marginal, every proper subspace has mass at most `1/2`. Therefore any clean-batch span method that wants a parity agreeing with the target on mass `>1/2+Omega(gamma)` must collect full rank, i.e. essentially `n` independent clean equations.

If the classification-noise rate or comparator error is constant, the probability that `Theta(n)` raw examples are all clean is `exp(-Omega(n))`. This stress test explains why the iteration-8 parity weak learner only works for shrinking `gamma=O(log n/n)`, not for the fixed-constant atlas edge.

## O038. Public Parity Slice Defeats Padding

Suppose an amplified class has a public slice on which its concepts restrict to ordinary parities. A distribution-free weak learner can be queried on a distribution supported entirely on that slice. Under uniform RCN labels with noise `eta=gamma/2`, an `OPT+(1/2-gamma)` response has constant correlation with the hidden parity.

Thus public mixtures, padding coordinates, direct sums, and many product constructions cannot hide the hard parity component from the weak-source requirement. Any parity-like amplification must either avoid an efficiently sampleable slice or supply an independent reason why low-noise weak prediction is easy.

## O039. Hidden Or Non-Sampleable Slices Evade The Slice Lemma

The parity-slice obstruction is scoped. If the parity region is not publicly sampleable, if the embedding has exponential representation blowup, if the sign flip is unknown, or if returned hypotheses cannot be evaluated on embedded fresh inputs, then the pullback does not directly yield an LPN algorithm.

This does not validate such a construction. It only marks the boundary of the iteration-8 no-go lemma.

## O040. Generated-Bag Hard Rows Can Be Off-Query Junk

Rare-slice programming can put arbitrary sparse-majority selector columns on a key slice that has negligible mass under the weak-call distributions. Then the columns are legal weak outputs, and empirical ERM on a chosen hard block can encode Set Cover.

This is a selector-hardness artifact unless the hard rows also have population relevance for the learning distribution. If they are zero-mass or tiny-mass off-query junk, a class-aware strong learner may ignore them, and population risk can be unaffected even though proper empirical selection over the generated bag is hard.

## O041. Confidence Versus Key-Hit Tension In Rare-Slice Programming

For a rare-slice weak output with call confidence `delta_0`, semantic validity may require
$$
|K|\gtrsim \frac{1}{\tau\delta_0}.
$$
But hitting a chosen validation key then has probability about `1/|K|` per independent weak-call output. If DCHP or another generator makes only `L` calls and sets `delta_0` on the order of `delta/L`, the expected number of hits on one fixed key can be too small without additional key-smoothness, many duplicate opportunities, or a different programming scheme.

This is a concrete obstruction to promoting rare-slice generated-bag pollution into a full DCHP-generated Set-Cover hardness theorem.

## O042. Low-Noise Sparse-XOR Stress Test

For log-arity signed XOR with `k=Theta(log n)`, uniform `k`-subsets, and RCN labels
$$
Y=c_s(S)N_\eta,
$$
take `eta=gamma/2` and `beta=1/2-gamma`. A valid fixed-slack weak learner must output `h` with
$$
\operatorname{err}(h,Y)\le \frac12-\frac{\gamma}{2}.
$$
Thus
$$
\mathbb E[h(S)c_s(S)]
\ge \frac{\gamma}{1-\gamma}.
$$

This stress test defeats the signed-XOR approximation-gap candidate: the weak source itself becomes a low-noise sparse-parity predictor. Any proposed sparse-XOR separation must either supply such a low-noise predictor independently and place hardness only in the hard band, or abandon the candidate.

## O043. Rare-Slice Spike Tuple And Population-Mass Tension

Rare-slice programming needs a hard block `S` to be light under weak-call distributions. Literal DCHP compatibility is threatened by two simple tests.

First, if a DCHP weak-sample pool contains even one point in `S` and ordered tuples with repetition are enumerated, the repeated tuple on that point can induce a query supported inside `S`; then `Q(S)=1`, and arbitrary behavior on `S` is not `OPT+beta` valid.

Second, if `S` has mass `alpha`, final realization of a gadget with `N` hard rows needs on the order of `m_f alpha >= N log N` samples, while weak-sample avoidance asks for `m_w alpha << 1`. When `m_w` and `m_f` are comparable, these demands conflict for growing `N`.

This does not refute every generated-bag pollution model, but it blocks the naive route from rare-slice programming to literal DCHP-generated Set-Cover hardness.

## O044. Ghost-X Dependence Breaks Finite-Class Transfer

The ideal ghost transfer lemma requires the final class to be fixed independently of the ghost sample, including the ghost covariates. If a procedure may inspect ghost `X` values before choosing the class, it can output a singleton classifier that labels those sampled points correctly and behaves randomly or adversarially elsewhere. The class has size one and ghost empirical error zero, but population clean error can be close to `1/2`.

This is the ghost-sample version of the memorizing-bag obstruction. It should be used whenever a proposed transfer argument conditions only on label/mask independence but lets the final class depend on ghost covariates.

## O045. Raw Ghost Holdout Contains Clean Points But The Mask Is Hidden

For `p=Pr[Y=c(X)]`, a raw holdout of `M=Theta(K/p)` points contains `K` clean points relative to `c` with high probability. This does not make the holdout algorithmically useful for clean empirical selection, because the event `Y=c(X)` is hidden.

The obstruction is not sample scarcity. It is mask access, clean-label identification, or a replacement mechanism such as stability, compression, public high-clean regions, repeated-coordinate denoising, or class-specific recovery.

## O046. Needle Sparse-Majority Good Vote Has Tiny Random-List Mass

In an arbitrary bag for `sign(B^(T))`, a perfect vote can be unique or nearly unique. In the offset Set-Cover needle gadget with `T=2k`, correctness can require exactly `k` offset copies and one copy of each of a hidden `k`-set of useful columns. Uniform product sampling over `M=poly(s)` columns then hits the exact good vote with probability about `M^{-k}` up to factorial factors, which is `exp(-Theta(log^2 s))` when `k=Theta(log s)`.

If the hidden set is revealed, a product sampler can put mass on those columns and succeed with inverse-polynomial probability. The obstruction is therefore informational and algorithmic: random final lists need a public sampler-mass lemma, not just a nonempty set of good votes.

## O047. Data-Dependent Quotient Trap

A quotient or cover defined after seeing the same hidden clean certification sample can be meaningless. Given clean sample `S`, a procedure may output one classifier that memorizes `S`; the realized quotient has size one and empirical clean error zero, while clean-population error is near `1/2`.

Distribution-dependent quotients are useful only when they cover a fixed or uniformly controlled final family under `D_c^+`, are independent of the certification sample, or are justified by a separate stability/compression theorem. They must also be algorithmically usable if they are meant to produce a final list or selector.
