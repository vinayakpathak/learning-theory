## Summary

The explorer’s core point is worth keeping, but only as a restricted proof-skeleton obstruction. The bound

$$
\Pr[\text{hit a fully clean }K\text{-transcript}] \le Lp^K
$$

is valid when candidate transcripts are selected without information about the hidden clean indicators and success requires all `K` distinct positions to be clean. It does not justify a broad no-go theorem for de-enumeration, stability, compression, or agnostic boosting.

The strongest surviving message is: raw tuple sampling cannot replace da Cunha-style clean-transcript enumeration unless the total hidden-clean witness length is logarithmic, or unless some additional structure gives information about clean status or avoids literal all-clean transcripts.

## Issue List

1. **Missing assumption:** conditional hidden-mask independence.  
   The union-bound lemma needs that, after conditioning on observable data, each candidate’s clean indicators remain Bernoulli with parameter `p`. This holds in some random-target/unique-coordinate toy models, but fails with repeated points, structured concept classes, posterior information from labels, or any mechanism that estimates clean status.

2. **Plausible but incomplete:** relevance to da Cunha-style enumeration.  
   The report assumes success requires a literal all-clean transcript of length `K`. That may be true for one proof skeleton, but it needs verification against the actual 2026 algorithm: is `K=m0`, `m0T`, a clean-mixture witness, a clean-conditional witness, or only a sufficient artifact used in the proof?

3. **Missing assumption:** polynomial explicit candidate list.  
   The anti-hitting lemma applies to an explicit menu of at most `L` candidate transcripts. It does not rule out implicit optimization over exponentially many transcripts, dynamic programming, structure-specific reconstruction, or a final selector that never materializes clean tuples.

4. **Overbroad phrasing / false if unqualified:** “any de-enumeration theorem based only on sampling candidate hidden-clean transcripts must pay `p^K`.”  
   This is true for blind or mask-independent sampling. It is false once observable data can correlate with clean status, repeated labels allow denoising, or the algorithm uses class structure to infer the hidden comparator.

5. **Missing parameter accounting:** the regime is really  
   $$
   Lp^K q \gtrsim 1/\operatorname{poly}(s,1/\epsilon),
   $$
   with `q` the clean-transcript success probability. Saying `K=O(log(s/epsilon))` is “the only regime” assumes `p` is bounded away from `1` and `q` is not exponentially small.

6. **Plausible but incomplete:** the all-labelings lower bound.  
   The claim that random labels on `[d]` require `Omega(gamma d)` revealed clean labels for error `1/2-gamma` is basically right for constant `gamma`, up to concentration terms. But it should be stated as something like `k >= 2 gamma d - O(sqrt d)` for constant success probability.

7. **Worth pursuing but not an atlas obstruction:** the finite-table class stress test.  
   It shows large clean witnesses occur naturally, but the class is strongly learnable by direct denoising or empirical majority with enough repeated samples. So it only refutes raw all-clean tuple discovery, not the target implication.

8. **Plausible but incomplete:** noisy raw labels near the endpoint.  
   The Chernoff argument for needing a downward noise fluctuation is valid if one noisy label per coordinate is used as a clean label. It does not apply to algorithms using repeated labels, robust statistics, SQ-style access, or structural denoising.

## Counterexamples Or Stress Tests

- **Repeated-coordinate stress test:** On a finite domain with RCN, if the sample contains many repeats of each `x`, majority vote estimates `f(x)` without ever finding a large all-clean tuple. This breaks literal `p^K` discovery as a barrier to learning.

- **Structured-class stress test:** For parities, halfspaces under nice marginals, or other classes where noisy labels still carry global signal, clean status of individual examples is not the right primitive. A learner may recover the target from many weakly noisy constraints.

- **Implicit-menu stress test:** An algorithm might search over all transcripts satisfying a consistency criterion using optimization rather than listing `L` candidates. The explorer’s bound does not touch this unless the implicit family is charged by capacity, information, or description length.

- **High-clean-mass stress test:** If `p=1-\eta` is very close to `1`, then even `K=Theta(log^2 s)` may not be quasi-polynomially unlikely. The obstruction is strongest in the hard constant-noise band.

## Literature Or Known-Result Conflicts

No direct conflict with the run’s recorded literature map. The explorer’s conclusion is consistent with the existing failed attempts F005-F007 and the accounting obstruction C010.

The main caution is conceptual: known clean PAC sample lower bounds for all labelings support the `Omega(d)` witness example, but known finite-domain denoising also shows that this example cannot be used as a separation or broad boosting lower bound.

## What Survives The Critique

- The hidden-mask anti-hitting lemma survives as a clean restricted lemma.

- The report gives a useful warning: compression or bounded randomness alone does not de-enumerate clean transcripts unless it reduces the total clean witness size enough.

- The correct bottleneck is total transcript length `K`, not per-call sample size.

- The finite-table/random-label example is a good stress test for proposed “sample raw tuples until clean” arguments.

## Recommended Next Checks

1. Audit the da Cunha proof skeleton and identify the actual `K`: one weak call, all `T` weak calls, or something weaker than literal clean samples.

2. Restate the anti-hitting lemma with explicit assumptions: mask independence, distinct positions, explicit list size `L`, clean success probability `q`, and constant-noise bounds on `p`.

3. Test whether any proposed de-enumeration route uses observable clean-status information. If yes, the `p^K` bound is not the right obstruction.

4. Separate “raw tuple sampling” lower bounds from stronger claims about compression, stability, or implicit final selectors.