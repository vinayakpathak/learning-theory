## Summary

The explorer’s main conclusion is right: this can only be a restricted proof-skeleton theorem, not a general necessity theorem for the atlas edge. The anti-hitting union bound is useful, but only after very strong assumptions are made explicit.

The most serious problems are: the mask-neutral assumption is doing nearly all the work; success in agnostic learning does not necessarily imply clean-conditional success relative to a fixed comparator; and the `q` / `A_search` accounting is currently ambiguous and likely misstated in one place.

## Issue List

1. **Fatal gap for any general necessity claim:**  
   The clean-conditional lemma is only sufficient. A strong agnostic hypothesis can beat `c` by correcting points where `c` is wrong, while being mediocre on `D_c^+`. So “successful final classifier” does not imply “accurate on the clean slice of fixed `c`,” unless this is imposed as a proof-skeleton restriction.

2. **Missing assumption:**  
   The bound `Pr(E_j | U) <= p^{K_j}` requires a precise mask-neutrality condition. In arbitrary agnostic distributions, clean status `Y=c(X)` may be highly correlated with observable `X`, so conditioning on public data can raise clean probability far above `p`.

3. **Plausible but incomplete:**  
   The anti-hitting lemma is just a union bound once the model is assumed. The real theorem must define `U`, candidate menus, witness events, distinctness/independence of clean indicators, and validation independence formally.

4. **False or at least algebraically confused claim:**  
   The line
   $$
   p^K q / A_{\mathrm{search}} \ge 1/\operatorname{poly}
   $$
   does not match the preceding bound `sigma <= L p^K q`. If `A_search` is menu size, it should multiply discovery probability in the success upper bound. Runtime accounting may divide elsewhere, but probability mass and computational cost need separate notation.

5. **Missing assumption:**  
   `q_j` must be an upper bound on conditional success after `E_j` for the displayed upper bound. This conflicts with the ledger’s use of `q` as a lower success probability in positive reconstruction lemmas.

6. **Missing assumption:**  
   Witness length `K_j` must count distinct independent latent clean examples. Reused coordinates, repeated noisy samples, or dependent clean indicators invalidate the naive `p^{K_j}` factor.

7. **Plausible but incomplete:**  
   Applying this to da Cunha-style proofs requires auditing the actual total distinct hidden-clean witness length. It is not enough to assert `K=m0 T` without checking sample reuse, adaptive dependence, and whether the proof uses literal clean transcripts or a population/ERM argument.

8. **Worth pursuing:**  
   The escape taxonomy is useful, especially posterior-biased filtering, repeated-coordinate denoising, class structure, implicit optimization, public certificates, and oracle leakage.

## Counterexamples Or Stress Tests

- **Observable clean region:** Let `X` reveal a region where labels agree with `c` with probability `1`, while the global clean mass is only `p`. A wrapper selecting that region has clean witness probability `1`, not `p^K`.

- **No clean-conditional necessity:** Suppose `c` is wrong on mass `0.4`. An improper `h` may correct all that noisy mass while making errors on much of the clean mass. Then `h` has better noisy risk than `c` but poor error on `D_c^+`.

- **Repeated-coordinate denoising:** On finite or heavy-atom domains, repeated samples estimate clean labels by majority without ever finding a large all-clean transcript.

- **Implicit optimization:** A learner may optimize over exponentially many transcript-like objects without outputting or enumerating a polynomial explicit menu.

## Literature Or Known-Result Conflicts

No direct unsupported citation issue: the explorer did not lean on external sources.

The main conflict is internal: the `A_search`/`q` accounting should be reconciled with ledger claims C021/C022 and L016/L017. The current explorer text mixes “menu size helps success probability” with “search size costs runtime.”

## What Survives The Critique

A restricted theorem survives:

If a wrapper outputs a validation-independent explicit menu of complete classifiers, and every successful candidate requires a witness event whose conditional probability is at most `p^K`, then a polynomial menu cannot hit superlogarithmic clean transcripts with polynomial probability.

This is valuable as an obstruction to literal clean-transcript enumeration proofs, especially for da Cunha-style proof skeletons after a careful `K` audit.

## Recommended Next Checks

1. Rewrite the theorem with a formal sigma-field `U` and an explicit mask-neutrality assumption.
2. Separate notation for conditional success upper bounds from reconstruction success lower bounds.
3. Fix the `A_search` accounting: probability mass should look like `L p^K q`; runtime cost should be handled separately.
4. Add a warning that clean-conditional accuracy is sufficient, not necessary, for agnostic success.
5. Audit da Cunha’s proof skeleton to determine the real distinct hidden-clean witness length and whether the theorem actually applies.