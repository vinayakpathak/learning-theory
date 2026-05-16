## Summary

The explorer’s main conclusion survives: finite-list validation can remove global `Range(A)` capacity assumptions only for the final noisy selection step, provided we already have a polynomial-size list of complete final classifiers containing a true near-optimal one.

It does not prove the atlas edge. The conditional theorem is close to tautological unless the “hidden-clean transcript generator” and “final selector/list generator” are specified in a way that does not already assume the target conclusion. The largest remaining gap is still candidate existence with true population risk, not validation.

## Issue List

- **Worth pursuing:** Finite final-list validation is correct. If `L` is validation-independent, polynomial size, evaluable, and contains some `F` with `err_D(F,Y) <= OPT + epsilon/2`, then fresh validation gives `OPT + epsilon`.

- **Plausible but incomplete:** The conditional theorem assumes a polynomial generator for final classifiers with true `D`-risk near `OPT`. That is essentially the clean-witness menu theorem. It should be recorded as a conditional lemma, but not as progress on generating the menu.

- **Missing assumption:** The adaptive weak-call union bound only works cleanly when each adaptive query distribution `Q_t` can be sampled by fresh iid examples from the intended population distribution, conditional on the past. If `Q_t` is an empirical hidden-clean distribution, the weak guarantee is only empirical unless another generalization argument is supplied.

- **Missing assumption:** “A certified final vote” needs a precise meaning. Certification by empirical hidden-clean performance is not enough; certification must imply true noisy risk, true clean-slice risk plus L004 transfer, or be followed by validation over a polynomial list.

- **Plausible but incomplete:** Saying global `VC(Range(A))` is bypassed is true only for realized weak calls and final noisy validation. It may still be needed, or replaced by compression/stability/independence, to prove that the generated data-dependent bag contains a true clean-good vote.

- **Missing assumption / unsupported instantiation:** The proof sketch uses `gamma0 = 1`, `epsilon0 = 2 beta`. Prior notes flag that the da Cunha theorem may state parameters in `(0,1)`. Use the interior repair from L009 unless the endpoint is explicitly audited:
  `epsilon0 = 1 - gamma0(1 - 2 beta)` with `gamma0 > 1/(2(1-beta))`.

- **False claim / overbroad stress statement:** “For growing `m0`, `p^{m0}` is not polynomial” is not always true. If `p` is constant and `m0 = O(log(s/epsilon))`, then `p^{m0}` is inverse-polynomial. The right obstruction is the total hidden-clean transcript length, e.g. `K = m0 T`; if `K = Theta(log^2 s)`, blind discovery becomes quasi-polynomial.

- **Plausible but incomplete:** A polynomial base bag plus all `T`-wise votes is statistically manageable via `T log |B|`, but computationally unmanaged. The report correctly flags `|B|^T`; the next theorem should separate statistical validation from efficient optimization.

## Counterexamples Or Stress Tests

- **Memorizing clean sample:** A singleton “bag” can contain a classifier chosen to fit the hidden clean sample perfectly and behave randomly elsewhere. Finite size alone gives no clean population guarantee.

- **Vote search blowup:** If `|B| = s^a` and `T = Theta(log s)`, exhaustive search costs `exp(Theta(log^2 s))`, not atlas-polynomial.

- **Endpoint/negative-correlation stress:** If `rho < 0`, then for `gamma0 < 1`, the condition with `epsilon0 = 2 beta` can fail because `gamma0 rho > rho`. This is why the endpoint or L009 repair matters.

- **Validation misuse:** A base hypothesis can be useful on `D_c^+` but have noisy risk above `1/2`; validating individual weak hypotheses can discard pieces needed in the final hidden-clean trajectory.

## Literature Or Known-Result Conflicts

No direct conflict with the local da Cunha audit. The report is consistent with the accepted state: da Cunha-Hogsgaard-Paudice 2026 is a near miss whose known runtime depends on `m0`, dual VC, and vote-search parameters in the exponent.

The only literature-level caution is theorem instantiation: do not cite the 2026 theorem at `gamma0 = 1` unless the endpoint is confirmed. Otherwise use the interior parameter repair already in the ledger.

Older fixed-`beta` limitations are not contradicted because this finite-list theorem assumes the missing generator/selector rather than deriving it.

## What Survives The Critique

- Finite validation over complete final classifiers is sound.
- Global output-range capacity is unnecessary for selecting from an already generated polynomial final list.
- Realized adaptive weak calls can be union-bounded without global range capacity, provided fresh iid sampling from each realized query is available.
- A finite base bag is not enough; final selection or explicit final-list generation remains a real computational bottleneck.
- The result should be kept as a sharpened conditional theorem, not an atlas proof.

## Recommended Next Checks

1. State the conditional theorem with exact constants using L004 and L005.

2. Split the assumptions into two black boxes: polynomial hidden-clean transcript generation and polynomial final-vote selector/list generation.

3. Replace the endpoint da Cunha parameters by the L009 interior repair unless the theorem’s endpoint is verified.

4. Audit which da Cunha uses of `VC(H)` or `VC*(H)` are only for final validation and which are needed for clean-slice population guarantees or short-vote existence.

5. Recompute random-witness probabilities using total transcript size `K = m0 T`, not just one weak-call sample size `m0`.