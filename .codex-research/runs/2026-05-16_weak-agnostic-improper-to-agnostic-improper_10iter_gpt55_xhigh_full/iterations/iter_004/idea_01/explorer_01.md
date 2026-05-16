## Summary

For `idea_01`, the clean-transcript dichotomy is viable only as a **restricted proof-skeleton theorem**, not as a general necessity theorem for the atlas edge.

The right proof strategy is:

1. Formalize a class of wrappers whose only target-useful information comes from explicit hidden-clean examples.
2. Prove an anti-hitting theorem: if every successful final classifier requires total hidden-clean witness length `K`, then success requires inverse-polynomial discovery mass, roughly `p^K q / A_search`.
3. Treat every algorithm that violates this accounting as an escape mechanism, not as a contradiction.

This would sharpen the current ledger: it explains why da Cunha-style transcript enumeration stalls, but it does not rule out posterior filtering, repeated-coordinate denoising, implicit optimization, class structure, or oracle-output leakage.

## Concrete Progress

A useful restricted model is:

- Fix a comparator `c` with `err_D(c) <= OPT_C(D)+tau`.
- Let `p = Pr_D[Y=c(X)]`.
- Split the wrapper into a **generation phase** and a fresh **validation phase**.
- During generation, condition on public data `U` that is not allowed to reveal hidden clean indicators beyond an explicit transcript model.
- The wrapper produces a menu of complete final classifiers.
- Each target-useful candidate `h_j` is associated with a hidden-clean witness event `E_j`, requiring at least `K_j` latent clean examples.
- Conditional on `U`, assume the anti-hitting condition
  $$
  Pr(E_j \mid U) \le p^{K_j}.
  $$
- Given `E_j`, the reconstruction succeeds with probability `q_j`.

Then any proof in this model satisfies
$$
Pr[\text{some successful candidate}]
\le
\mathbb{E}_U \sum_j p^{K_j} q_j.
$$

Therefore, if the wrapper succeeds with probability at least `sigma`, then its generated menu must have total discovery mass at least `sigma`:
$$
\mathbb{E}_U \sum_j p^{K_j} q_j \ge sigma.
$$

In particular, if there are at most `L` explicit candidates and all have `K_j >= K` and `q_j <= q`, then
$$
sigma \le L p^K q.
$$

So a polynomial-time explicit-menu proof needs
$$
L p^K q \ge 1/\operatorname{poly}(s,1/\epsilon,\log(1/\delta)).
$$

Equivalently, if `p` is bounded away from `1`, total hidden-clean witness length must be only logarithmic unless there is nontrivial success mass or a non-enumerative mechanism.

## Claims Or Lemmas

**Lemma 1: Explicit Clean-Transcript Anti-Hitting.**

In the mask-neutral explicit-menu model above,
$$
Pr[\exists j \text{ with a successful hidden-clean transcript}]
\le
\mathbb{E}_U \sum_j p^{K_j} q_j.
$$

Proof is just conditioning on `U` plus union bound. The important content is not the inequality; it is the model assumption that `Pr(E_j|U) <= p^{K_j}`.

**Lemma 2: Polynomial Success Forces Inverse-Polynomial Discovery Mass.**

If a transcript-style wrapper succeeds with constant probability and has at most polynomial advice/search menu size, then at least one successful path or a non-negligible collection of paths must satisfy inverse-polynomial discovery accounting:
$$
p^K q / A_{\mathrm{search}} \ge 1/\operatorname{poly}.
$$

This is a genuine dichotomy inside the restricted model.

**Lemma 3: General Necessity Fails Without Mask-Neutrality.**

A distribution-free wrapper may select examples or regions with posterior clean probability much larger than `p`, use repeated samples on heavy atoms, exploit class structure, or optimize implicitly over exponentially many transcripts. Such algorithms are outside the clean-transcript model, so the anti-hitting theorem cannot be claimed as a black-box lower bound for the atlas edge.

## Proof Attempts

A promising proof organization is:

1. First handle the near-endpoint case.
   If `OPT_C(D) >= 1/2 - O(epsilon)`, validation over constants already gives `OPT + O(epsilon)`. The clean-transcript theorem should explicitly exclude this case.

2. Fix a near-optimal `c`.
   Use the clean-conditional lemma: it suffices that the generated list contain some `h` with small error on `D_c^+`.

3. Define transcript-generated candidates.
   A candidate is target-useful only if its construction uses a set of latent clean examples. Count the total number of distinct required clean examples as `K`.

4. Prove anti-hitting.
   Conditional on public data `U`, if candidate clean-witness events have probability at most `p^K`, a polynomial explicit menu cannot hit a superlogarithmic clean transcript with polynomial probability.

5. State the dichotomy.
   Either the wrapper has inverse-polynomial transcript discovery mass, or it uses a mechanism not captured by literal hidden-clean transcript enumeration.

## Gaps And Risks

The largest gap is defining `U` honestly. In a real distribution-free setting, the wrapper sees `(X,Y)`, and clean status `Y=c(X)` can be correlated with observable features. Conditioning on public data may destroy the naive `p^K` bound.

A second gap is that successful classifiers need not have literal positive clean certificates. They may aggregate many weak noisy signals, solve an implicit optimization problem, or exploit structure of `C`.

A third risk is validation dependence. The clean-transcript theorem needs the final list to be independent of the held-out validation sample. If the wrapper uses all samples adaptively, the proof must first justify a split-sample reduction or pay capacity/stability costs.

## Counterexamples Or Obstructions

Mechanisms escaping the transcript bottleneck:

- Posterior-biased filtering: observable features identify cleaner regions, so selected tuples have clean probability much larger than `p^K`.
- Repeated-coordinate denoising: on finite or heavy-atom domains, repeated samples recover clean labels without all-clean transcripts.
- Class-structured noisy recovery: global constraints may recover `c` from noisy data directly.
- Implicit optimization: an algorithm may optimize over exponentially many transcript-like objects without enumerating them.
- Public low-`OPT` witnesses: weak queries may be easy because of public constants or relabelings, not hidden clean information.
- Oracle handle leakage: improper weak outputs may carry target information not charged by clean-witness length.

## Sources Consulted

No web sources consulted. I used the required run-local files:

- `problem.md`
- `working_notes/canonical_summary.md`
- `working_notes/claim_ledger.md`
- `working_notes/lemma_bank.md`
- `working_notes/failed_attempts.md`
- `working_notes/counterexamples.md`
- `working_notes/literature_map.md`
- `working_notes/promising_directions.md`
- `working_notes/iteration_summaries.md`
- `iterations/iter_004/idea_01/idea.md`

## Recommended Next Steps

1. Write the restricted theorem formally as an “Explicit Clean-Transcript Anti-Hitting Theorem.”
2. Make the mask-neutral assumption explicit instead of hiding it in prose.
3. Add a separate “escape taxonomy” theorem: any successful wrapper outside the theorem must use posterior bias, repeated-coordinate denoising, class structure, implicit optimization, public certificates, or oracle leakage.
4. Apply the theorem to the da Cunha proof skeleton and estimate the true total `K = m0 T`.