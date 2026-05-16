## Summary

Saved the critique to [critic_02_on_explorer_01.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/iterations/iter_008/idea_01/critic_02_on_explorer_01.md).

Verdict: the explorer’s repair is useful, but only for a shrinking-gap parity variant. It does not instantiate the current atlas edge, which needs one representation-uniform fixed constant `beta < 1/2`.

## Issue List

- **Fatal gap:** the construction uses `beta_n = 1/2 - a/n`, so the weak advantage goes to zero. The atlas source requires fixed constant slack.
- **False if overread:** this is not a general parameterized weak learner polynomial in `(n, 1/gamma)`. Runtime is about `exp(O(n gamma))`, so it is polynomial only for `n gamma = O(log n)`.
- **Plausible but incomplete:** the weak learner needs full accounting for repetitions, candidate list size, fresh validation, and confidence splitting.
- **Plausible but incomplete:** the span-capture lemma needs a formal adaptive Chernoff/submartingale argument.
- **Missing assumption:** the clean-conditioning proof must fix one optimal parity `c*` before conditioning on all labels agreeing with `c*`.
- **Unsupported citation / conditional:** LPN hardness is an assumption. Goldreich-Levin only supplies recovery once a correlated evaluable predictor exists.
- **Missing assumption:** the strong learner’s improper hypothesis must be efficiently evaluable on fresh chosen uniform inputs.

## Counterexamples Or Stress Tests

- Uniform `X` blocks the span method for constant `gamma`: any proper subspace has mass at most `1/2`, so full rank needs about `n` clean equations, whose probability is `exp(-Omega(n))` under constant noise.
- If `gamma = 1/sqrt(n)`, the gap still shrinks, but runtime is `exp(O(sqrt(n)))`, not polynomial.
- Under `x`-dependent agnostic noise, the original marginal span claim fails; only the clean-conditional marginal argument is valid.

## Literature Or Known-Result Conflicts

No conflict with noisy-parity folklore: at noise `O(1/n)` or `O(log n/n)`, all-clean recovery can be polynomially likely.

A fixed-constant weak learner for parities under low constant RCN would already threaten standard LPN assumptions, because validation plus Goldreich-Levin would recover the hidden parity.

## What Survives The Critique

- A credible shrinking-gap weak parity learner for `gamma = O(log n/n)`.
- The clean-conditional correction is the right proof repair.
- The strong-side conditional LPN reduction survives under standard PAC evaluability assumptions.
- The idea is valuable as a warning that fixed constant slack and inverse-polynomial slack behave very differently.

## Recommended Next Checks

1. Formalize the shrinking-gap theorem with exact constants.
2. Put it under a separate size-dependent weak-slack variant, not the current atlas edge.
3. State the LPN implication explicitly as conditional on search-LPN hardness.
4. Record the uniform-marginal full-rank example as a method obstruction for extending the span route to constant `gamma`.