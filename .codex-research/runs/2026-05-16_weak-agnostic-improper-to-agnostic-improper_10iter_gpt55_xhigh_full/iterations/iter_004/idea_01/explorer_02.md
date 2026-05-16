## Summary

I explored the clean-transcript idea through a necessity lens. The strongest honest result is a restricted dichotomy, not a full atlas necessity theorem:

A black-box wrapper can only be forced into the `p^{-K}` bottleneck if its successful outputs are complete final classifiers certified by explicit hidden-clean transcripts, and if all information about the hidden clean mask is either absent or explicitly charged. Under that model, success requires inverse-polynomial clean-discovery mass. Outside that model, there are real escape mechanisms.

## Concrete Progress

A useful sharpening is an information-charged version of the hidden-mask anti-hitting lemma.

Let `c` be fixed, `p = Pr[Y=c(X)]`, and let `S_i` mark whether raw sample `i` is clean relative to `c`. Let `T` be the pre-validation transcript: public samples `U`, wrapper randomness, weak-oracle replies, and any selected candidate/certificate menu. Suppose that, conditional on `T=t`, each successful complete final classifier must be certified by some certificate `sigma` requiring `K_sigma` distinct clean positions, with additional successful branch weight `w_sigma`.

Under the independent coupling where `S` is independent of `T`,

$$
Q(E \mid T=t) \le \sum_{\sigma \in \Sigma(t)} w_\sigma p^{K_\sigma}.
$$

If

$$
\mu := \mathbb{E}_T \sum_{\sigma \in \Sigma(T)} w_\sigma p^{K_\sigma} < 1
$$

and `B = I(S;T)`, then binary-event KL transfer gives

$$
\Pr(E) \le \frac{B+\ln 2}{\ln(1/\mu)}.
$$

So for constant success probability, either:

1. the independent clean-transcript mass `mu` is inverse-polynomial, or
2. the transcript carries enough information about the clean mask, or
3. the algorithm is not actually an explicit clean-transcript wrapper.

In the uniform case with at most `A` successful branches of total weight `q` and all `K_sigma >= K`,

$$
\mu \le A q p^K.
$$

Thus low-leakage success forces roughly `A q p^K >= 1/poly`, equivalently the usual `p^{-K}` barrier unless `A`, `q^{-1}`, or leakage are doing real work.

## Claims Or Lemmas

**Claim 1: Explicit-transcript necessity.**  
For validation-independent wrappers whose only route to a good final classifier is an explicit all-clean certificate, high success implies inverse-polynomial independent clean-discovery mass.

**Claim 2: Information is the right escape parameter.**  
Posterior-biased sampling does not refute the barrier; it must be charged through `I(S;T)`. If `I(S;T)` is large, the `p^{-K}` lower bound should become vacuous.

**Claim 3: `K` must be global.**  
`K` is the total number of distinct hidden-clean positions needed to construct a complete final classifier, not a per-call weak sample size. In a boosting-style transcript with `T_boost` calls and `m0` fresh hidden-clean samples per call, the default accounting is `K ≈ m0 T_boost`.

## Proof Attempts

The clean proof route is:

1. Condition on the pre-validation transcript `T`.
2. Under an independent clean mask, union-bound over all certificates:
   $$
   Q(E \mid T=t) \le \sum_\sigma w_\sigma p^{K_\sigma}.
   $$
3. Average over `T` to get `Q(E) <= mu`.
4. Transfer from independent coupling `Q` to the true joint law `P` using
   $$
   D_{KL}(P\|Q)=I(S;T)
   $$
   and
   $$
   kl(P(E)\|Q(E)) \ge P(E)\ln(1/Q(E))-\ln 2.
   $$

This gives the dichotomy above.

The attempted lift to arbitrary fixed-slack weak learners fails: low `OPT_C` queries may be public-witness, empirical/spike, artificial-relabeling, or other-concept queries rather than hidden-clean target queries.

## Gaps And Risks

The lemma is only a restricted-model statement. It needs a hidden-mask or random-target model where clean statuses have the right independence structure.

The hardest assumption is certificate completeness: proving that every good final classifier must have such a clean transcript is often exactly the missing lower-bound content.

Weak-oracle outputs and hypothesis handles must be charged carefully. If a handle’s evaluation leaks many target bits, the information budget is large and the lower bound should be vacuous.

Advice/search accounting needs separate treatment for enumerable advice versus sampled randomness.

## Counterexamples Or Obstructions

Repeated-coordinate denoising can learn from many noisy labels without ever finding a large all-clean transcript.

Posterior-biased filters escape the raw `p^K` calculation by making selected positions more likely clean; this is legitimate only if charged as information.

Implicit optimization over exponentially many transcript candidates can evade an explicit polynomial-menu union bound.

Validation over individual weak hypotheses is not enough; the menu must contain complete final classifiers.

Near-endpoint cases where `OPT_C` is close to `1/2` can be solved by constants and should be routed separately.

## Sources Consulted

No web search used. Consulted the required local run files:

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

Formalize an `ExplicitCleanTranscriptWrapper` model with transcript `T`, certificate family `Sigma(T)`, global witness length `K`, branch weights, and validation independence.

Then instantiate the model on the da Cunha-style proof skeleton to estimate the real global `K = m0 T` and identify which outputs/leakage must be charged.

Separately, list escape mechanisms as first-class alternatives: posterior-biased sampling, repeated-sample denoising, implicit optimization, and oracle-output information leakage.