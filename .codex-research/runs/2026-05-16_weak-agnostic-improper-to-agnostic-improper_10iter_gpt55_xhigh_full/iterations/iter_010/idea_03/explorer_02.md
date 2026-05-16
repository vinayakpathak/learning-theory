## Summary

The stable weak learner route can support a conditional positive theorem, but only if the regularity assumption is placed on the **whole clean-to-final-classifier mechanism**, not merely on individual low-`OPT` weak calls.

Audit verdict:

- Leave-one-out stability of the weak learner helps only after hidden-clean calls are already available. It does not by itself find clean witnesses, prevent overfitting of a generated bag, or solve the final sparse-majority selector.
- Small **total transcript compression** is the cleanest sufficient assumption. It must compress complete final classifiers, not just per-call weak hypotheses.
- Distribution-dependent range quotients can replace global `Range(A)`/dual-VC assumptions only if they control the final-relevant distribution `D_c^+` and come with an efficient selector or polynomial final list.

## Concrete Progress

A useful conditional theorem should be stated around the known clean-conditional reduction:

Let `c` satisfy `err_D(c) <= OPT_C(D)+tau`, and let `P = D_c^+ = D | [Y=c(X)]`. If a validation-independent polynomial procedure outputs a polynomial list `L` containing some `h` with

$$
err_P(h,c) \le \alpha,
$$

then fresh noisy validation gives

$$
err_D(\hat h,Y) \le OPT_C(D)+tau+\alpha+O(\epsilon).
$$

So the real assumption audit is: which stability/compression/quotient hypotheses actually produce such a list or an efficiently selectable final class?

The answer appears to be:

1. **Sufficient for CleanPopulationTransfer only:** stability or quotient control for the complete clean generator on `P`.
2. **Sufficient for a full conditional implication:** the above plus either a polynomial final list or an efficient selector for the exact final vote class.
3. **Insufficient:** per-call stability of `A` on low-`OPT` distributions alone.

## Claims Or Lemmas

**Lemma 1: Total Compression Conditional Positive Route.**  
Suppose that for every clean distribution `(X,c(X))`, a reconstruction procedure maps `K` iid clean examples plus `b` enumerable advice bits or sampleable randomness to a complete classifier with `P`-error at most `alpha` with success probability at least `q`. If, in the non-endpoint case,

$$
p^{-K}2^b q^{-1} \le poly(s,1/\epsilon,\log(1/\delta)),
\qquad p=Pr_D[Y=c(X)],
$$

then raw tuple sampling plus fresh validation gives strong agnostic improper learning up to `tau+alpha+O(epsilon)`.

This is the most robust form of the “stable/compressed transcript” route. The compression must be for complete final classifiers.

**Lemma 2: Whole-Generator Stability Can Give CleanPopulationTransfer.**  
Let `G` be the entire clean-sample-to-final-classifier map. If `G` has high-probability uniform stability on iid samples from `P=D_c^+`, and its empirical clean error is small, then standard stability generalization can transfer empirical clean success to population clean success.

This does not follow from stability of the base weak learner unless the adaptive weighting, bag generation, and final selector preserve stability quantitatively.

**Lemma 3: Distribution-Dependent Quotients Suffice Only With Final-Relevant Control.**  
A quotient of `Range(A)` is useful if, for each relevant `P=D_c^+`, all complete final classifiers considered by the algorithm lie in a class with polynomial effective cardinality/VC dimension under `P`, and the selector/list is computationally available.

A quotient only under weak-call distributions is not enough, because final risk is measured on `D_c^+` and then on the original noisy `D`.

## Proof Attempts

For compression: sample many raw `K`-tuples. A tuple is clean relative to `c` with probability `p^K`. Away from the endpoint `OPT_C(D) ~= 1/2`, we have `p >= 1/2 + Omega(epsilon)`, so `p^{-K}` is polynomial when `K=O(log poly)`. Decode all candidates, then validate on fresh noisy samples.

For stability: try to run the DCHP-style clean proof on an empirical hidden-clean sample and use stability to replace VC/dual-VC population transfer. This works only if the **final output map** is stable. Per-call stability leaves open data-dependent overfitting by the bag or final vote.

For quotients: replace global `Range(A)` by a distribution-dependent quotient modulo disagreement under `P`. Uniform convergence over the quotient can transfer empirical clean success. But the quotient must be fixed independently of the certification sample or controlled by a separate stability/compression argument, and it must be algorithmically usable.

## Gaps And Risks

- Low-`OPT` call stability does not explain how the wrapper obtains low-`OPT` clean calls from noisy agnostic data.
- Ordinary leave-one-out stability is fragile under constant-fraction contamination: replacing `Theta(m)` noisy points can change behavior by `Theta(m sigma_m)`.
- Per-call logarithmic compression can still give total transcript length `Theta(log^2 s)`, leading to quasi-polynomial search.
- A small base bag is not a polynomial final list when the final class is all `T`-wise votes.
- Distribution-dependent quotients may be circular if they depend on unknown `D_c^+` and lack computable representatives.
- An efficient selector over `sign(B^(T))` is a genuine extra primitive, not supplied by the weak learner.

## Counterexamples Or Obstructions

- Hard-band silence: when `OPT_C >= gamma`, the weak learner may legally be uninformative.
- Rare-slice junk: semantic weak correctness does not imply controlled global range, VC, dual VC, stability, or benign generated bags.
- Singleton memorization: a finite bag can perfectly fit a hidden clean sample and still have population clean error near `1/2`.
- Hidden-mask anti-hitting: explicit clean transcript discovery costs roughly `p^{-K}` unless total clean witness length is logarithmic or another sampler exists.
- Sparse-majority Set-Cover hardness: generic exact ERM over arbitrary `sign(B^(T))` bags is not a free polynomial selector.

## Sources Consulted

No web search was used.

Local sources consulted: `problem.md`, `iterations/iter_010/idea_03/idea.md`, and the requested files under `working_notes/`, especially `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, and `iteration_summaries.md`.

## Recommended Next Steps

1. Formalize a conditional theorem with three explicit modules: `CleanDiscovery`, `CleanPopulationTransfer`, and `PolynomialFinalSelectorOrList`.
2. Treat total transcript compression of complete final classifiers as the primary sufficient assumption.
3. If pursuing stability, define stability for the full adaptive clean generator, not only for `A`.
4. If pursuing quotients, require final-relevant control under `D_c^+` plus computable representatives or an efficient selector.
5. Explicitly record that these are additional regularity assumptions; they are not consequences of the atlas fixed-slack source.