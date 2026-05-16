## Summary

The explorer’s main Set Cover reduction looks essentially sound for **arbitrary finite bags that include a public `+1` constant**. It genuinely targets the exact DCHP final class: zero-threshold, nonnegative integer `T`-wise majorities with repetitions.

The result should be recorded as a worst-case selector hardness theorem, not as a direct obstruction to the atlas edge or to DCHP-generated bags. The main weak points are scope: constants, arbitrary bags, approximate-gap parameters, and whether the selector needed by the positive route is really universal over such bags.

## Issue List

- **Worth pursuing:** Lemma 1 appears correct. With `T=2k-1`, the vote sum is always odd, so `sign(0)=1` causes no tie ambiguity. Dummy correctness gives `q<s`, hence `s>=k`; positive correctness gives `r_u >= s-k+1`; removing any `s-k` selected set occurrences leaves `k` occurrences covering every correctly classified positive point.

- **Missing assumption:** the reduction needs a public constant `c_+`. This blocks a generic arbitrary-bag selector, but it does not rule out selectors for bags produced by the weak learner unless the wrapper is allowed to augment the bag with constants.

- **Plausible but incomplete:** the Max k-Cover gap transfer needs explicit thresholds. If dummy multiplicity is `W`, the positive coverage gap is normalized by `|U|+W`; choosing `W` too large destroys constant additive empirical-risk gaps. Use something like `W=|U|+1` and state the additive tolerance.

- **Plausible but incomplete:** approximate ERM hardness should specify the approximation model. Exact zero-error hardness implies additive-approximation hardness only when the requested tolerance is smaller than the empirical gap, e.g. `o(1/(|U|+W))` for deciding zero error, or a constant gap after a Max k-Cover promise construction.

- **Unsupported citation:** W[2]-hardness should cite parameterized Set Cover directly. The reduction gives `T=2k-1`, so the parameter transfer is fine, but the cited background should match the exact source problem.

- **Plausible but incomplete / possible false as stated:** the “complements/constants embed bounded integer halfspaces” claim needs parity and exact-`T` accounting. Canceling filler pairs only fill even leftover weight, and bias representation needs both constants with integer margins controlled.

- **Missing assumption:** the hardness is for arbitrary evaluation tables. It does not show that the special bags arising from DCHP hidden-clean generation are hard, nor that they contain enough arbitrary columns to encode Set Cover.

## Counterexamples Or Stress Tests

- **No constant stress test:** remove `c_+`. The reduction no longer works: with only set columns, positive correctness requires a majority-style coverage threshold rather than ordinary coverage, and the dummy calibration disappears.

- **Large dummy weight stress test:** if `W=|U|^2`, every optimum still classifies dummies correctly, but Max k-Cover gaps shrink to `O(1/|U|)` additive empirical risk. So the gap lemma must keep `W=O(|U|)`.

- **Special-bag stress test:** a selector that works only for monotone/no-constant bags, or only for bags output by a particular stable weak learner, is not contradicted by this reduction.

- **Even-`T` stress test:** the proof uses `T=2k-1`. For even `T`, ties interact with `sign(0)=1`, and the inequalities need adjustment.

## Literature Or Known-Result Conflicts

No conflict with the run ledger. The result strengthens the existing DCHP selector bottleneck in `C037` / `L033` / `D014`.

The halfspace-hardness citations remain only contextual unless reduced to the exact nonnegative integer sparse-majority class. The Set Cover reduction is the cleaner theorem-level support.

The Max k-Cover citation should be audited before claiming a standard additive empirical-risk approximation lower bound.

## What Survives The Critique

The zero-error selector hardness theorem survives:

> For arbitrary finite bags containing a public `+1` constant, deciding whether `V_{B,T}` has zero empirical error is NP-hard and W[2]-hard parameterized by `T`.

Also surviving: among dummy-correct votes, the number of correctly classified positive examples is exactly bounded by the best `k`-set coverage value, with the converse construction from any `k` selected sets.

## Recommended Next Checks

1. Write Lemma 1 formally with input model, multiset samples, `T=2k-1`, and explicit use of odd parity.
2. Formalize the Max k-Cover gap version with `W=|U|+1`, promise thresholds, and additive empirical-risk gap.
3. Check whether the DCHP wrapper may freely add constants to `B`; if yes, record this hardness against universal augmented-bag selectors.
4. Try a no-constant reduction. That is the most useful robustness check.
5. Separate three statements: exact ERM hardness, additive-approximate ERM hardness, and FPT hardness in parameter `T`.