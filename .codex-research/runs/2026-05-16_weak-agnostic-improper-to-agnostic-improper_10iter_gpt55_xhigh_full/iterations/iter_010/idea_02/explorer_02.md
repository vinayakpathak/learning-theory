## Summary

The random-vote-list idea is useful only under an additional “good votes have inverse-polynomial sampling mass” condition. That condition is not implied by finite bag size, by existence of one good `sign(B^(T))` vote, or by natural product samplers over the bag.

The main obstruction is a needle-cover gadget: a clean-accurate vote may require a specific `k = Theta(log s)` subset of columns. Uniform, frequency-weighted, or any product sampler that has not already identified those columns hits the vote with probability `s^{-Omega(log s)}`, so any polynomial random list misses it with high probability.

## Concrete Progress

I reduced the risk in idea_02 to a precise missing lemma:

For a generated bag `B` and sampler `S_B` over `T`-wise votes, one needs
$$
\Pr_{v\sim S_B}\left[\operatorname{err}_{D_c^+}(v,c)\le \alpha\right]\ge 1/\operatorname{poly}(s,1/\epsilon).
$$

If this holds for validation-independent `B`, then sampling a polynomial list and using fresh noisy validation plugs into the existing clean-list sufficiency lemma. The counterexample search shows this probability lower bound fails badly for arbitrary bags and natural samplers.

## Claims Or Lemmas

**Lemma 1: product-sampler needle obstruction.**  
Let `M` be the number of non-offset bag columns and set `T=2k`. There is an empirical clean instance for the exact DCHP class `sign(B^(T))` such that zero clean error exists, but every vote with error below one row mass must use exactly:

- `k` copies of an offset column `a`;
- one copy of each column in a hidden `k`-set `S subset [M]`;
- no other set columns.

For an iid vote sampler with probabilities `pi_a, pi_1,...,pi_M`, the good-vote probability is
$$
p_{\mathrm{good}}(S)
=
\frac{(2k)!}{k!}\pi_a^k\prod_{j\in S}\pi_j.
$$

For every product distribution over columns, some `S` satisfies
$$
p_{\mathrm{good}}(S)\le \left(\frac{k}{2M}\right)^k.
$$

Thus if `M=s^a` and `k=c log s`, the good-vote probability is
$$
\exp(-\Omega((\log s)^2)),
$$
not inverse-polynomial.

**Lemma 2: label-oblivious random lists also fail.**  
For the same needle family, if a sampler outputs `L` correlated `T`-multisets without information identifying the hidden `S`, each multiset is good for at most one `S`. Averaging over random `S` gives success at most
$$
L/\binom{M}{k}.
$$
For polynomial `L`, `M=s^a`, and `k=Theta(log s)`, this is still negligible.

## Proof Attempts

The gadget is the offset Set-Cover gadget specialized to a unique cover. Two positive control rows force exactly `k` offset copies. Each negative element row forces inclusion of one required set column. With exactly `k` remaining slots, all required columns must appear exactly once.

Uniform sampling fails immediately. Frequency-weighted sampling also fails if the required columns are rare in the generated bag. More generally, for any product distribution, choose the required set among low-product columns; the bound above follows from averaging/Maclaurin plus `pi_a(1-pi_a)<=1/4`.

## Gaps And Risks

This is not a separation for the atlas edge. The construction is an arbitrary-bag obstruction, not a proof that DCHP-generated bags realize the hard instances.

A sampler that first solves the hidden selector problem and puts large mass on the required columns could evade the bound. But then the sampler is doing the hard final-selection work, not bypassing it.

The gadget uses offset/control structure and `T=2k`. Existing notes already flag that constants, offsets, exact `T` alignment, and generated-bag realizability must be audited separately.

## Counterexamples Or Obstructions

The strongest obstruction is: “contains a good sparse majority” does not imply “random sparse majorities find one.” In needle-cover bags, the good set has exponentially small measure under natural samplers even though a perfect vote exists.

Noisy validation cannot fix this. Validation can select a good complete classifier from a list, but if the random list misses every clean-accurate vote, validation has nothing to amplify.

## Sources Consulted

No web search used. Local files read: [problem.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/problem.md), [idea.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/iterations/iter_010/idea_02/idea.md), [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md), [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md), [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md), [failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/failed_attempts.md), [counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/counterexamples.md), [literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/literature_map.md), [promising_directions.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/promising_directions.md), [iteration_summaries.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/iteration_summaries.md).

## Recommended Next Steps

Formalize the product-sampler needle lemma as a scoped obstruction to idea_02.

Then test whether any DCHP-generated-bag mechanism can prove the opposite property: inverse-polynomial mass of clean-good votes under a concrete sampler. Without such a mass lemma, random vote lists do not replace sparse-majority ERM.