## Executive Summary

Run `2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full` attacked the open edge
`efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac` for the fixed-slack agnostic setting.
The run used `gpt-5.5`, `xhigh` reasoning, `danger-full-access`, approval `never`, web search enabled, 10 iterations, 3 ideas per iteration, 2 explorers per idea, and 2 critics per explorer.

The edge remains open. No solver or synthesis step accepted a complete proof or separation. The run did, however, sharpen the problem into a small number of bottlenecks and conditional routes.

## Best Current Understanding

The source notion is best modeled as a fixed additive best-correlation oracle with `beta = 1/2 - gamma`. It can be essentially uninformative in the hard band
`gamma <= OPT_C(D) <= 1/2 - epsilon`, exactly where strong agnostic learning still needs nontrivial prediction.

The most developed positive near miss remains the da Cunha-Hogsgaard-Paudice style route. The fixed source satisfies the semantic weak condition after the interior repair
`gamma_0 > 1/(2(1-beta))` and `epsilon_0 = 1 - gamma_0(1 - 2 beta) < gamma_0`, but this still leaves three separate primitives:

- `RealizedCleanSimulation`: valid adaptive weak calls on clean or clean-enough query distributions.
- `CleanPopulationTransfer`: generated transcripts or bags generalize to the clean conditional `D_c^+`.
- `PolynomialFinalSelectorOrList`: efficient optimization over the final `sign(B^(T))` class, or an explicit polynomial list of complete classifiers.

The clean-list sufficiency theorem is now the cleanest positive abstraction: if a validation-independent polynomial list contains some classifier accurate on `D_c^+` for a near-optimal comparator `c`, then fresh noisy validation gives strong agnostic learning.

## Most Promising Directions

The best positive route is still:

`CleanDiscovery + CleanPopulationTransfer + PolynomialFinalSelectorOrList`.

Iteration 10 narrowed useful subroutes to total final-classifier compression, whole-generator stability under `D_c^+`, effective final quotients, and public pointwise-margin random vote sampling.

The best conditional negative route is still the approximation-gap template. An efficient improper `a`-approximate agnostic learner with tunable additive error gives fixed-slack weak learning for every `beta > (a-1)/(2a)` after adding constants and validating. A separation still needs an independent hard-band `OPT + epsilon` improper prediction hardness result for the same represented class.

## Candidate Lemmas Or Routes

Clean-list sufficiency: if an algorithm outputs a validation-independent polynomial list `L` containing some `h` with small `err_{D_c^+}(h,c)` for a near-optimal comparator `c`, held-out ERM over `L` gives `OPT_C + epsilon`.

Ideal ghost-clean transfer: an independent ideal clean ghost sample gives ordinary finite-class transfer for a fixed validation-independent final class, but it does not discover the hidden clean mask or prove the generated bag is good.

Random final-list sufficiency: exact sparse-majority ERM could be bypassed if a public sampler over final votes placed inverse-polynomial mass on clean-good votes. Mere existence of a good sparse majority is not enough.

Stability/compression route: per-call weak-learner stability is insufficient unless it controls complete final classifiers and selector state. Total final-transcript compression or whole-generator stability would be meaningful conditional hypotheses.

## Failed Attempts Worth Remembering

Parity/LPN gives only a shrinking-gap near separation. Fixed constant slack would already require constant-noise parity prediction.

Log-arity signed XOR does not instantiate the approximation-gap separation: the weak learner would already solve the low-noise stress distribution.

Generic sparse-majority ERM over arbitrary bags is Set-Cover hard, so the final `sign(B^(T))` selector cannot be assumed for free.

Rare-slice generated-bag pollution remains a black-box warning, not a literal DCHP-generated hardness construction.

## Counterexamples And Obstructions

The hard band `gamma <= OPT_C(D) <= 1/2 - epsilon` remains the core obstruction.

Positive excess over a comparator does not by itself create a public low-noise residual query. Public filters and relabelings can only exploit posterior low tails already present in the public view.

Needle-cover examples show that label-oblivious or weakly informed random sparse-majority samplers can put only quasi-polynomially small mass on the unique good vote.

Semantic weak correctness alone still gives no clean-mask access, stability, total compression, controlled range, bounded dual VC, sampler-mass lemma, or generic final selector.

## Literature Notes

The run kept the DCHP route as the main positive reference point and checked sparse-XOR related candidates against DBLP/arXiv entries including Bogdanov-Sabin-Vasudevan 2019 and Mao 2026. These checks supported failed-candidate notes rather than a separation.

## Recommended Next Run

Run a focused theorem-writing pass on the three-module conditional theorem:

`RealizedCleanSimulation + CleanPopulationTransfer + PolynomialFinalSelectorOrList => efficient agnostic improper PAC`.

Then choose exactly one route to push to theorem level: total final-transcript compression, full-generator stability, or public pointwise-margin random vote sampling.

## Project Memory Update Proposal

Record the edge as still open. Add the three-layer DCHP decomposition, the clean-list sufficiency theorem, the approximation-gap conditional-negative template, the needle-cover random-list obstruction, and the warning that log-arity XOR/sparse parity fails the fixed-constant low-noise stress test.
