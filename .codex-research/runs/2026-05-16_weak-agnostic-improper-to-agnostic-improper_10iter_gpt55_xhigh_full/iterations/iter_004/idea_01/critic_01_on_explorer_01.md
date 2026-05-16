## Summary

The explorer’s main conclusion is sound: this can only be a restricted proof-skeleton theorem, not a general necessity theorem for the atlas edge. The anti-hitting inequality is basically a union bound once the model assumes mask-neutrality and literal clean certificates.

The strongest critique is that the theorem is close to tautological unless the model defines, independently and checkably, what counts as a hidden-clean certificate and why every successful explicit-menu proof must pass through one. Several quantitative details also need repair.

## Issue List

- **Fatal gap for general necessity:** The assumption “each target-useful candidate has a hidden-clean witness event” is not implied by being a black-box wrapper. It excludes posterior filtering, noisy aggregation, implicit optimization, class structure, and final classifiers accurate on noisy risk without being clean-slice accurate.

- **False as written / missing assumption:**  
  The bound
  $$
  \Pr[\exists j\text{ successful}] \le \mathbb E_U\sum_j p^{K_j}q_j
  $$
  needs success via candidate `j` to be contained in a clean event times a branch-success event with conditional probability at most `q_j`. If `q_j` is a lower-bound success probability given clean witnesses, as in the positive clean-transcript lemma, multiplying by `q_j` gives the wrong direction.

- **Missing assumption:** “Requires at least `K_j` clean examples” is too weak. The event must require a fixed specified set of `K_j` clean positions, or all alternative witness sets must be charged in the menu/advice factor. Event “there exists a clean subset of size `K` among `m` positions” can have probability far larger than `p^K`.

- **Plausible but incomplete:** The accounting mixes menu size, branch probability, and advice/search cost. For an explicit menu of size `L`, success is bounded by `L p^K q`. For exhaustive advice search, runtime has a factor `A_search p^{-K}q^{-1}`. These are dual but not interchangeable; the theorem should keep them separate.

- **Missing assumption:** The public transcript `U` must be mask-neutral in a strong posterior sense:
  $$
  \Pr(E_j\mid U)\le p^{K_j}.
  $$
  This is not true for arbitrary agnostic distributions, even if `U` only contains observable features.

- **Plausible but incomplete:** The clean-conditional reduction is sufficient, not necessary. A strong agnostic classifier may achieve low noisy risk by trading errors between clean and corrupted slices, so a necessity theorem cannot demand small error on `D_c^+`.

- **Worth pursuing:** The near-endpoint split is correct: if `OPT_C(D) >= 1/2-O(\epsilon)`, validation over constants gives `OPT+O(\epsilon)` for improper learning.

## Counterexamples Or Stress Tests

- Public feature identifies clean region: let global `p=1/2`, but a visible region `A` has `Y=c(X)` always. A wrapper sampling from `A` has clean probability `1`, violating the `p^K` bound.

- Many possible witness subsets: if a candidate succeeds when at least one of `m` samples is clean, the probability is `1-(1-p)^m`, not at most `p`.

- Repeated-coordinate denoising: on finite/heavy-atom domains under RCN, majority vote over repeated labels recovers clean labels without ever finding a large all-clean transcript.

- Noisy-risk classifier not clean-slice classifier: a hypothesis can compensate clean-slice mistakes by matching labels on the corrupted slice, so strong agnostic success need not imply clean-conditional success.

## Literature Or Known-Result Conflicts

No direct external citation conflict: the explorer cites no theorem beyond run-local notes. The claims are consistent with the ledger’s warning that hidden-mask anti-hitting is only a restricted proof-skeleton obstruction.

The main internal conflict is with the positive clean-transcript accounting: `q` is used there as a success lower bound, while the explorer’s upper bound needs `q_j` to be an upper conditional branch mass or exact branch success probability.

## What Survives The Critique

A restricted theorem survives:

If an explicit validation-independent menu is chosen under a mask-neutral transcript, and every successful candidate has a charged fixed clean certificate of size `K_j`, then a union bound gives an anti-hitting limit of roughly `sum_j p^{K_j}`, with branch/advice factors handled explicitly.

This is useful for diagnosing da Cunha-style exhaustive clean-transcript proofs. It does not lower-bound arbitrary fixed-slack weak-to-strong wrappers.

## Recommended Next Checks

1. Define an `ExplicitCleanCertificateMenu` model with success events `S_j`, certificate events `E_j`, and the exact condition `Pr(S_j | U) <= q_j Pr(E_j | U)`.

2. Separate three quantities: explicit candidate count `L`, enumerable advice cost `A_search`, and randomized branch success `q`.

3. Add a clause charging unions of possible certificates: if candidate `j` has certificate family `Sigma_j`, bound by `sum_{sigma in Sigma_j} p^{|sigma|}`.

4. Test the theorem on the da Cunha proof skeleton and compute whether `K=m_0T` or a smaller globally compressed certificate is actually required.