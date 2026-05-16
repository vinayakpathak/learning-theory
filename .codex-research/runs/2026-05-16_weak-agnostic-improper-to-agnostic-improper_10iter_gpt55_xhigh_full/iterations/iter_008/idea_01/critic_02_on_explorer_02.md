## Summary

The explorer’s main verdict is correct: this is not progress on the current fixed-constant `beta < 1/2` atlas edge. It is a plausible conditional separation for a different “shrinking weak gap” source where `gamma_n = 1/2 - beta_n = O(log n / n)`.

I do not see a clear false mathematical claim in the explorer report, but several claims are still only proof sketches. The weak-side parity learner needs a fully parameterized theorem, and the strong-side LPN conclusion needs to be stated explicitly as a conditional result under search-LPN hardness and evaluable improper outputs.

## Issue List

- **Fatal gap for current edge:** The weak gap shrinks with dimension. The atlas source requires one fixed `beta < 1/2`, equivalently constant `gamma > 0`. The proposed parity learner gives at best `gamma_n = Theta(1/n)` or `O(log n/n)`, so it cannot instantiate the current source.

- **Missing assumption:** The variant weak notion must be specified. If the learner is asked to handle arbitrary requested inverse-polynomial `gamma`, the all-clean-batch method fails once `gamma n` is superlogarithmic. It supports a hardwired schedule like `gamma_n <= C log n/n`, not a fully tunable weak learner.

- **Plausible but incomplete:** The span-capture lemma is believable, but the theorem needs exact constants: choose `m=c n`, threshold `tau=1/2+C gamma`, prove `Pr[mu(V)<tau]`, then reserve validation slack.

- **Plausible but incomplete:** The weak learner proof must spell out the actual algorithm. It cannot test “all labels are clean”; it should run many trials, solve each consistent linear system, add both constants, and validate the finite list on fresh samples.

- **Missing assumption:** The high-`OPT` constants branch needs validation slack. Since validation may return error `1/2+O(gamma)`, the split should leave margin, e.g. `eta >= 2gamma` with validation error at most `gamma/4`.

- **Missing assumption:** The LPN reduction assumes the improper hypothesis is efficiently evaluable on arbitrary uniform inputs. This is standard for PAC hypotheses, but it should be explicit.

- **Unsupported citation / assumption:** “Contradicts standard LPN hardness” is not a theorem from the cited papers. It should be phrased as “under polynomial-time search-LPN hardness at constant noise.”

## Counterexamples Or Stress Tests

- **Constant `gamma`:** If `eta = gamma/2` is constant, the all-clean probability for `m=Theta(n)` is `exp(-Theta(n))`. The method becomes exponential, matching the LPN-hard regime.

- **Superlogarithmic `gamma n`:** For `gamma=n^{-1/2}`, the all-clean probability is `exp(-Theta(sqrt n))`, so polynomial repetition fails.

- **Clean-conditional shift:** The explorer correctly fixes this, but it is the key stress test. Span capture applies to `D_X | [Y=c*(X)]`, not `D_X`. Transfer back only works because `eta=O(gamma)`.

- **Non-evaluable output:** If a “strong improper learner” only returned transductive sample labels, Goldreich-Levin recovery would not apply. The atlas model should rule this out, but the reduction must say so.

## Literature Or Known-Result Conflicts

No direct conflict found.

Blum-Kalai-Wasserman give context for parity with random classification noise and subexponential algorithms, not a polynomial-time hardness theorem: https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2003-Noise-Tolerant_Learning.pdf

Goldreich-Levin supports the recovery step from an oracle/predictor with noticeable correlation with a hidden parity: https://www.wisdom.weizmann.ac.il/~oded/gl.html

The conditional separation should cite LPN as an assumption separately from these algorithmic facts.

## What Survives The Critique

- The clean-conditional correction is important and looks right.
- The span-capture route likely gives a valid weak learner for `gamma_n=Theta(1/n)` and probably `O(log n/n)`.
- The strong-side reduction from `OPT+epsilon` agnostic improper parity learning under uniform RCN to LPN recovery is sound under standard evaluability and search-LPN assumptions.
- This is worth recording as a warning: fixed constant slack and shrinking slack have very different behavior.

## Recommended Next Checks

1. State a formal theorem for `gamma_n <= C log n/n` with explicit constants, repetitions, and validation sample size.
2. Prove the span-capture lemma with parameters rather than `O(1/n)`.
3. Write the weak learner algorithm without referencing the unobservable clean event.
4. State the LPN assumption precisely: uniform examples, constant noise `eta`, polynomial-time search recovery.
5. Record the result as a separate size-dependent weak-slack non-implication candidate, not as evidence for the current fixed-constant atlas edge.