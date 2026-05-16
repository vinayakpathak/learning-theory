## Summary

Random vote lists are a clean conditional replacement for the final `sign(B^(T))` ERM step, but not yet a proof of the atlas edge. The right proof target is:

> Given a validation-independent generated bag `B`, find a sampler over `T`-wise votes that assigns inverse-polynomial mass to votes with small error on `D_c^+`.

If such a sampler exists, fresh noisy validation finishes the agnostic learner by the clean-conditional lemma. The main risk is serious: existence of one good sparse majority does not imply that uniform, frequency-weighted, or naive boosting-induced sampling hits it with inverse-polynomial probability.

## Concrete Progress

Let

$$
V_{B,T}=\{\operatorname{sign}(\sum_{t=1}^T h_{i_t}): h_{i_t}\in B\}.
$$

For a near-optimal comparator `c`, define the clean-good set

$$
G_\alpha(B,T,c)=\{v\in V_{B,T}: \operatorname{err}_{D_c^+}(v,c)\le \alpha\}.
$$

If a sampler `Pi_B` over `V_{B,T}` satisfies

$$
\Pi_B(G_\alpha(B,T,c))\ge p
$$

for `p >= 1/poly(s,1/epsilon,log(1/delta))`, then drawing

$$
R=O(p^{-1}\log(1/\delta))
$$

random votes gives, with high probability, a polynomial list containing a clean-good final classifier. By L004/L005, noisy validation over this list returns an `OPT_C+tau+alpha+O(epsilon)` hypothesis.

So the idea reduces final selection to a **sampler-mass lemma**. This is a real decomposition, but the mass lower bound is the entire hard part.

## Claims Or Lemmas

**Lemma 1: Random Final-List Sufficiency.**  
Assume `B` and sampler `Pi_B` are fixed before held-out validation. If `Pi_B(G_alpha) >= p` with inverse-polynomial `p`, then random vote listing plus noisy validation gives a strong agnostic learner, conditional on the upstream generation of such a `B`.

Status: straightforward from existing L004/L005/C008.

**Lemma 2: Public Margin Sampler Lemma.**  
Suppose there is an efficiently sampleable distribution `q` over `B` such that, for clean mass at least `1-alpha`,

$$
\mathbb E_{h\sim q}[c(x)h(x)]\ge \theta.
$$

Then a random `T`-wise majority from `q^T` has expected clean error at most

$$
\alpha+\exp(-\Omega(T\theta^2)).
$$

Thus for `T=O(theta^{-2}log(1/epsilon))`, repeated random votes give a polynomial final list.

Status: plausible and essentially Hoeffding; this is the best positive proof strategy.

**Lemma 3: Existence Is Not Enough.**  
If all we know is that `G_alpha` is nonempty, uniform sampling over ordered `T`-tuples may hit it with probability as low as `|B|^{-T}`. For `|B|=poly(s)` and `T=Theta(log s)`, this is quasi-polynomially small, not inverse-polynomial.

Status: immediate counting obstruction, consistent with the Set-Cover sparse-majority hardness notes.

## Proof Attempts

The promising route is to avoid exact ERM by proving that DCHP or a DCHP-like construction secretly produces a **public margin distribution** `q` over the bag. If the hidden proof only says “some sparse majority exists,” random sampling is too weak. If it says “this known distribution over weak hypotheses has positive clean margin on most of `D_c^+`,” then random sparsification works.

The proof plan would be:

1. Generate `B` independently of the final validation sample.
2. Extract or define a computable distribution `q_B` over `B`.
3. Prove a population clean-margin statement for `q_B` on `D_c^+`.
4. Sample polynomially many `T`-wise majorities from `q_B^T`.
5. Validate the resulting complete classifiers on fresh noisy data.

This would replace the final sparse-majority ERM primitive, but it would still require the upstream clean-population transfer layer.

## Gaps And Risks

The largest gap is that the useful `q_B` may depend on the hidden comparator or hidden clean sample. If so, sampling from it is not an algorithm.

Uniform sampling is too diffuse when `|B|` is polynomial and `T` grows logarithmically. Frequency-weighted sampling can also fail if critical hypotheses are rare in the generated bag.

The DCHP hidden margin certificate, as recorded in the notes, is not automatically an observable noisy-validation surrogate and may live only on the hidden clean empirical sample. Random vote lists do not solve that middle-layer population-transfer issue.

## Counterexamples Or Obstructions

Set-Cover-style sparse-majority instances are the main obstruction. They can have a zero-error `T`-wise majority while the good majorities occupy exponentially or quasi-polynomially small mass under natural samplers.

Brittle votes are also dangerous: a deterministic sparse majority may work only because exact counts or offset columns are balanced. Product sampling from the same support can destroy this balance unless there is a robust margin condition.

Rare-slice generated-bag pollution remains relevant as a warning: semantic weak correctness alone does not make generated bags structurally benign.

## Sources Consulted

No web search used.

Local sources:
- [problem.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/problem.md)
- [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md)
- [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md)
- [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md)
- [failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/failed_attempts.md)
- [counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/counterexamples.md)
- [literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/literature_map.md)
- [idea.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/iterations/iter_010/idea_02/idea.md)

## Recommended Next Steps

1. Try to prove the Public Margin Sampler Lemma cleanly and add exact constants.
2. Audit the DCHP proof for whether its final existence argument comes from a sampleable margin distribution or only from ERM over `sign(B^(T))`.
3. Treat random vote lists as a conditional `PolynomialFinalListGenerator` primitive requiring either inverse-polynomial sampler mass or an observable clean-margin distribution.