## Summary

Literature audit verdict: no audited theorem directly proves the atlas edge. The closest result is da Cunha--Hogsgaard--Paudice 2026: its weak-learner definition can accept a fixed-additive `OPT + beta` oracle after translating to correlation form, but its running time is only polynomial in the sample size with weak-sample and dual-VC parameters in the exponent. That is not a representation-uniform polynomial PAC reduction.

## Concrete Progress

The atlas source gives, in correlation notation,

$$
\operatorname{corr}(h,Y)\ge \rho_D(C)-2\beta,
\quad \rho_D(C)=\sup_{c\in C}\operatorname{corr}(c,Y).
$$

Threshold-style boosters do not settle the edge. Kalai--Mansour--Verbin and Feldman use an `(alpha,gamma)` condition: if `OPT <= 1/2 - alpha`, output error `<= 1/2 - gamma`. The atlas oracle implies this only with `gamma = alpha - beta`, hence only for `alpha > beta`; their final excess remains at least about `beta`.

Correlation-style efficient boosters also do not settle it. Kanade--Kalai / Ghai--Singh use

$$
\operatorname{corr}(W)\ge \gamma_0 \sup_{h\in H}\operatorname{corr}(h)-\epsilon_0,
$$

and their final guarantee retains a term proportional to `epsilon_0/gamma_0`. The fixed-additive oracle forces `epsilon_0 >= 2 beta` for any uniform implication of this form, so the residual is constant.

The notable near miss is da Cunha et al. 2026. Their theorem only needs `gamma_0 > epsilon_0`, not `epsilon_0 = O(epsilon)`. Since the atlas oracle implies

$$
\rho - 2\beta \ge \gamma_0 \rho - \epsilon_0
$$

whenever `epsilon_0 >= 2 beta` and `gamma_0 <= 1`, one may choose `2 beta < epsilon_0 < gamma_0 < 1`. But their runtime contains terms like `n^{O(m0 min{d*,log n}/theta^2)}`, where `m0` is weak sample complexity and `d*` is dual VC dimension of the base output class. For atlas purposes, `m0` may be polynomial in representation size, so this is generally quasi-/super-polynomial.

## Claims Or Lemmas

**Lemma 1.** A fixed-additive `OPT + beta` weak oracle instantiates `(alpha, alpha-beta)` threshold weak agnostic learning for every `alpha > beta`.

**Lemma 2.** A fixed-additive oracle instantiates da-Cunha-style correlation weak learning with `(gamma_0, epsilon_0)` for any `epsilon_0 >= 2 beta` and `gamma_0 <= 1`; hence nontriviality `gamma_0 > epsilon_0` is possible exactly because `beta < 1/2`.

**Lemma 3.** Any booster whose final excess contains an unavoidable `epsilon_0/gamma_0` term cannot use the atlas source to reach arbitrary `epsilon`, because the fixed-additive source forces `epsilon_0/gamma_0 = Omega(beta)`.

## Proof Attempts

The main translation attempt is positive for da Cunha et al.: take the base class to be the range of the weak learner `A` on all sample transcripts/random seeds. This gives the right correlation weak condition with constant slack. The attempt fails at the complexity audit: enumerating or searching over weak-call transcripts creates exponents depending on `m0` and dual capacity, which are not controlled as constants by the atlas definition.

For KMV/Feldman, the translation is blocked earlier: fixed `beta` only supplies useful threshold weak learning above the fixed noise floor `beta`, while their final error tracks that threshold.

## Gaps And Risks

I did not directly re-derive Ben-David--Long--Mansour 2001 from the Springer paper; the audit of that theorem used Gavinsky and Feldman’s descriptions of its `beta`-optimal weak learner model.

The base-class choice for da Cunha et al. needs a formal encoding audit. If the output range of `A` had uniformly bounded weak sample size and dual VC dimension, the route might become a conditional positive theorem. The atlas source alone does not give those bounds.

## Counterexamples Or Obstructions

No separation found in this literature pass. The obstruction is quantitative/algorithmic: known fixed-slack-compatible boosters seem to require exhaustive weak-sample/candidate generation, while known efficient boosters require tunable correlation slack.

## Sources Consulted

- Ben-David, Long, Mansour 2001, *Agnostic Boosting*: https://doi.org/10.1007/3-540-44581-1_33
- Gavinsky 2003, *Optimally-Smooth Adaptive Boosting and Application to Agnostic Learning*: https://www.jmlr.org/papers/v4/gavinsky03a.html
- Kalai, Mansour, Verbin 2008, *On Agnostic Boosting and Parity Learning*: https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2008-On_Agnostic_Boosting-and_Parity_Learning.pdf
- Feldman 2010, *Distribution-Specific Agnostic Boosting*: https://arxiv.org/abs/0909.2927
- Kalai, Kanade 2009, *Potential-Based Agnostic Boosting*: https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2009-Potential-Based_Agnostic_Boosting.pdf
- Ghai, Singh 2024, *Sample-Efficient Agnostic Boosting*: https://arxiv.org/abs/2410.23632
- Ghai, Singh 2025, *Sample-Optimal Agnostic Boosting with Unlabeled Data*: https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, Paudice 2026, *Sample-Near-Optimal Agnostic Boosting with Improved Running Time*: https://arxiv.org/abs/2601.11265

## Recommended Next Steps

Focus next on the da Cunha route. Try to prove a conditional atlas implication under a “small weak-output class” hypothesis: polynomial `m0`, VC/dual-VC, and transcript search compressed to polynomial time. Failing that, isolate whether `n^{m0}` transcript enumeration is inherent for fixed-additive residual-free boosting.