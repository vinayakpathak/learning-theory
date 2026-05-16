# Canonical Summary

The fixed-constant edge remains open after iteration 10. The source is still best viewed as a fixed additive best-correlation oracle with `beta=1/2-gamma`; it may be uninformative on the hard band `gamma <= OPT_C <= 1/2-epsilon`.

The strongest positive near miss remains the da Cunha-Hogsgaard-Paudice route. The fixed source satisfies the semantic weak condition via the interior repair
$$
\gamma_0>\frac{1}{2(1-\beta)},\qquad \epsilon_0=1-\gamma_0(1-2\beta)<\gamma_0,
$$
but the known proof still needs three extra layers: realized clean simulation, clean-population transfer to `D_c^+`, and a polynomial final selector or explicit final list.

Iteration 10 adds three scoped modules. An independent ideal clean ghost sample gives ordinary finite-class transfer for a validation-independent final class, but it does not prove that the generated bag is good on that ghost sample or reveal the hidden clean mask. Random vote lists would replace exact `sign(B^(T))` ERM if a public sampler placed inverse-polynomial mass on clean-good votes, but existence of one good sparse majority is not enough. Stability, compression, and distribution-dependent quotients are useful only when they control complete final classifiers or the full clean-to-final pipeline.

The exact DCHP final class is `sign(B^(T))`: zero-threshold, nonnegative, integer `T`-wise majorities over the generated bag. Worst-case Set-Cover reductions block a universal exact or inverse-polynomial additive selector over arbitrary bags. Iteration 10 strengthens the random-list warning with needle-cover examples: label-oblivious or insufficiently informed product samplers can put only quasi-polynomially small mass on the unique good vote.

The best positive abstraction remains: generate a validation-independent polynomial list of complete final classifiers, or a polynomially selectable final vote class, containing some classifier accurate on `D_c^+` for a near-optimal comparator `c`; then fresh noisy validation gives strong agnostic learning. Fixed-slack weak learning alone still gives no clean-mask access, stability, total compression, clean-transcript generator, controlled semantic range, bounded dual VC, sampler-mass lemma, or generic exact sparse-majority selector.

The conditional negative template remains approximation-gap based. An efficient improper `a`-approximate agnostic learner with tunable additive error gives fixed-slack weak learning for every `beta>(a-1)/(2a)`, after adding constants and validation. A separation still needs independent hard-band `OPT+epsilon` improper prediction hardness for the same class; log-arity XOR/sparse parity failed this checklist because the weak learner already solves the low-noise stress distribution.

Residual-forcing obstructions remain local. Positive excess over a comparator does not by itself create a public low-noise residual query; public filters/relabelings can only exploit posterior low tails already present in the public view, and using those statements as `OPT_C` lower bounds requires no-other-witness or random-hidden-target assumptions.
