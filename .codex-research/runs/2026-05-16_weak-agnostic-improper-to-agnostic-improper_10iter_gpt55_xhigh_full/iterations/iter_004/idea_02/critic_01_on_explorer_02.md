## Summary

The explorer’s main diagnosis survives: an implicit vote selector can at most address the final vote-search bottleneck. It does not produce the hidden-clean weak hypotheses needed by the da Cunha-style proof, and the fixed `OPT + beta` source can still legally return dummy answers on observable hard-band queries.

The main critique is that several claims are too coarse to become theorem statements. The report needs sharper distinctions between arbitrary real-weighted votes, convex/nonnegative votes, sparse `T`-votes, empirical versus population selection, and 0-1 versus surrogate optimization.

## Issue List

- **Missing assumption / fatal gap if promoted to proof:** A polynomial bag `B` must contain a vote with a population clean-conditional guarantee, not merely empirical clean-sample performance. Otherwise O016-style memorization breaks the route.

- **Missing assumption:** A “polynomial selector” must come with either a population-risk guarantee, VC/stability control, or a fresh validation/list mechanism. Empirical optimization over a data-dependent continuous vote class is not automatically enough.

- **Plausible but incomplete:** “Final vote selection is halfspace ERM” is exact for arbitrary real-weighted votes over `B`. It is not literally the same for `sign(conv(B))`, nonnegative weighted majorities, or sparse `T`-wise votes unless closure under negation, thresholds, and weight constraints are specified.

- **Plausible but incomplete:** The hardness warning for 0-1 halfspace ERM is right generically, but it needs a reduction for the actual allowed vote class. For arbitrary polynomial `B`, coordinate-feature bags give a strong stress test; for structured or margin-certified `B`, LP/convex methods may still work.

- **Plausible but incomplete:** The surrogate-loss objection is not yet a proof. A clean comparator under RCN can still have good logistic/hinge behavior after optimizing scale. To rule out surrogates, construct a finite `B,D` where the best 0-1 vote is strong but every surrogate minimizer has bad 0-1 risk, or weaken the claim to “requires a separate calibration/consistency proof.”

- **Unsupported citation / imprecise attribution:** The halfspace-hardness citation should be pinned to the exact result used. Guruswami-Raghavendra supports hardness of proper weak agnostic halfspace learning, but that is background unless converted into the finite-bag selector model.

## Counterexamples Or Stress Tests

- **Coordinate bag selector hardness:** Let `X={+-1}^d` and `B={x -> x_j}` plus negations/constant threshold if needed. Then real-weighted vote selection is ordinary halfspace learning in `d` dimensions. With noisy labels, exact or weak 0-1 optimization inherits known hardness.

- **Hard-band observable calls:** In RCN with noise `eta > gamma`, target-preserving observable filters remain useless until they carry enough hidden-target correlation. The fixed weak source may return majority constants throughout, so column generation from ordinary noisy calls need not populate `B` with hidden-clean hypotheses.

- **Surrogate sanity check:** For a classifier `h=c` under RCN, logistic or hinge loss with optimized scale need not be “large” despite noisy-slice mistakes. Thus “surrogate punishes noisy labels” is only a warning, not an obstruction.

- **Clean empirical overfitting:** A singleton hypothesis can memorize a hidden clean sample and have zero empirical clean error but population clean error near `1/2`. This blocks any selector argument that uses only finite bag size.

## Literature Or Known-Result Conflicts

No direct conflict with the local literature map. The arXiv abstract for da Cunha-Høgsgaard-Paudice 2026 explicitly says the improved algorithm is polynomial in sample size with other parameters fixed, which supports the run’s “near miss, not atlas proof” framing: https://arxiv.org/abs/2601.11265

Guruswami-Raghavendra’s halfspace-noise hardness supports treating generic 0-1 halfspace ERM as unavailable, but only after mapping the finite-bag selector to their setting: https://epubs.siam.org/doi/10.1137/070685798

The 2025 da Cunha et al. paper uses a realizable reduction and margin-based filtering, so the next audit should check whether the final vote has a margin certificate that convex optimization could exploit: https://arxiv.org/abs/2503.09384

## What Survives The Critique

- Hidden-clean generation remains the primary bottleneck.
- Final vote selection is a real second bottleneck once a useful polynomial `B` exists.
- The fixed-slack source alone gives no pricing oracle over all hidden tuple outputs or over `Range(A)`.
- An implicit selector is still worth pursuing as a conditional primitive, especially if da Cunha’s final object has a margin or LP-checkable certificate.

## Recommended Next Checks

1. Extract the exact da Cunha final vote class: real weights, nonnegative weights, sparse majority, threshold, margin guarantee.
2. Formalize two selector primitives separately: generic 0-1 ERM over `B`, and margin-certified convex/LP selection over `B`.
3. Prove the coordinate-bag hardness stress test for the generic selector model.
4. Try to build a finite surrogate-inconsistency example; otherwise downgrade the surrogate objection.
5. Keep the conditional theorem split into: hidden-clean generator, clean-population guarantee, final selector/generalization.