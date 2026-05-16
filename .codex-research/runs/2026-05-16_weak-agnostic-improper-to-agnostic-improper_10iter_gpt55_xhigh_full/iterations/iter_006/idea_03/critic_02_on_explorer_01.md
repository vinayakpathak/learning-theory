## Summary

The explorer’s core claims mostly survive. I do not see a false claim in the extraction of the da Cunha-Høgsgaard-Paudice final class: the paper’s Algorithm 1 really returns ERM over `sign(B^(T))`, i.e. uniform `T`-wise nonnegative majority votes with repetitions and `sign(0)=1`.

The main critique is scope: this audit isolates the final selector bottleneck, but it does not materially close the atlas edge unless the hidden-clean tuple generation and `H = Range(A)` capacity assumptions are also handled.

## Issue List

1. **Missing assumption:** “polynomial-time selector” must be parameter-qualified. The paper is polynomial in `n` only when `m0`, `d*`, and `1/theta` are treated as fixed. Atlas efficiency needs representation-uniform polynomial time, so `|B|^T = n^{Theta(m0 T)}` remains non-polynomial if `m0` or `d*` grows with representation size.

2. **Plausible but incomplete:** The proposed `ExactTWiseVoteSelector(B,T,xi)` should be formulated as a sample-based approximate ERM primitive, not as direct access to true noisy risk. True-risk competition is stronger than necessary and not directly implementable; empirical near-ERM plus generalization is the right learning-theoretic form.

3. **Plausible but incomplete:** The coordinate-bag hardness warning applies cleanly to relaxed real-weight threshold votes, but not automatically to the exact da Cunha class. Exact `T`-wise votes are integer, nonnegative, zero-threshold, and `l1`-bounded by `T`; arbitrary halfspaces require complements, constants, and either exact rational weights or a margin/rounding argument.

4. **Missing assumption:** If this audit is used downstream for the fixed-slack atlas source, the da Cunha theorem’s endpoint issue still matters. The theorem statement uses `gamma0 in (0,1)`, so the `gamma0=1, epsilon0=2 beta` plug-in should be replaced by the interior repair from the ledger unless the endpoint is separately justified.

5. **Unsupported citation if promoted:** Guruswami-Raghavendra halfspace hardness is only a warning for relaxed selector variants. It is not yet evidence that exact bounded `T`-wise nonnegative majority selection is hard.

6. **Worth pursuing, not fatal:** The hidden-clean empirical margin non-transfer claim is sound. The margin exists on `S_f*`, not on `S2` or the noisy distribution, so it does not by itself justify hinge/logistic optimization on validation data.

## Counterexamples Or Stress Tests

- **Exact-class granularity:** Take a coordinate bag with complements and constants. Relaxed nonnegative real votes can simulate ordinary halfspaces, but exact `T`-wise votes only simulate rational bounded-weight halfspaces. Small-margin halfspaces may require very large `T`.

- **No-complement bag:** If `B` lacks `-h` for some feature, the exact class cannot freely choose signed weights. Any hardness reduction must ensure complements are present or explain how the weak learner generates them.

- **Base-hypothesis validation failure:** A hypothesis can be useful on the hidden clean slice but have terrible noisy risk. This blocks validating individual weak hypotheses; only complete final classifiers can be safely validated.

- **Enumeration blowup:** With `|B| approx n^{m0}` and `T = Theta(min{d*, log n}/theta^2)`, exhaustive selection costs roughly `n^{Theta(m0 T)}`. This is quasi-polynomial or worse under atlas-scale parameters.

## Literature Or Known-Result Conflicts

No conflict found with the primary source. The arXiv v3 paper states the algorithm is polynomial in sample size when other parameters are fixed, and its runtime includes `n^{O(m0 min{d*, log n}/theta^2)}`; this supports the explorer’s bottleneck diagnosis. Source checked: https://arxiv.org/abs/2601.11265

Known halfspace-hardness results should remain background warnings until reduced to the exact vote class.

## What Survives The Critique

- Exact vote class: `sign((1/T) sum_i h_i)`, repetitions allowed.
- Exhaustive ERM over `sign(B^(T))` is genuinely used.
- The paper gives no hidden polynomial implicit selector.
- The margin certificate is hidden-clean and empirical.
- A conditional theorem with an explicit exact `T`-wise selector primitive is a useful next artifact, but still only conditional.

## Recommended Next Checks

1. State three selector primitives separately: exact `T`-wise integer votes, nonnegative convex votes, and unrestricted real threshold votes.

2. For the exact class, test reductions from sparse/low-weight halfspace ERM rather than unrestricted halfspace ERM.

3. Look for a rounding theorem only under validation-observable margin; the existing da Cunha margin is hidden-clean and does not suffice.

4. Keep selector work separate from the upstream `m0`-subsample enumeration and `VC/dual-VC(H)` control assumptions.