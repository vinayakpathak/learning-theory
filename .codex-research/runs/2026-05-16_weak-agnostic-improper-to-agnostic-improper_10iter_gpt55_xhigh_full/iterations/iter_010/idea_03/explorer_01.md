## Summary

The stable-weak-learner route gives a clean **conditional theorem schema**, but only if the regularity assumption reaches the **complete final classifier** or the **complete final vote class**. Per-call stability of the supplied weak learner is not enough by itself.

Best takeaway: stability, compression, and distribution-dependent quotients are viable as **CleanPopulationTransfer** certificates. They do not automatically solve the **PolynomialFinalSelectorOrList** layer.

## Concrete Progress

I decomposed the idea into three possible sufficient assumptions for the DCHP middle layer.

1. **Final-output stability** can imply CleanPopulationTransfer if the whole clean routine mapping a clean sample `S ~ (D_c^+)^n` to a final classifier `h_S` has a high-probability generalization guarantee:
   $$
   \operatorname{err}_{D_c^+}(h_S,c)
   \le
   \widehat{\operatorname{err}}_S(h_S,c)+\alpha.
   $$
   Leave-one-out stability of only the base weak learner does not imply this unless the final selector is also stable or fixed.

2. **Transcript compression** gives a concrete transfer condition. If every relevant complete final classifier decodes from `k` clean sample indices plus `b` advice bits, then uniform convergence over
   $$
   N_{\rm desc}\le \sum_{i\le k}\binom{n}{i}2^b
   $$
   gives transfer with gap roughly
   $$
   O\left(\sqrt{\frac{k\log n+b+\log(1/\delta)}{n}}\right).
   $$
   This can be statistically polynomial even when enumeration is not.

3. **Distribution-dependent final quotient** can replace global `Range(A)` control. If, under `P=D_c^+`, the final classifier family has a small `P`-metric cover, then empirical clean success transfers to population clean success. But this only yields a polynomial final list if the quotient representatives are effectively computable and polynomially many.

## Claims Or Lemmas

**Lemma A: Conditional Stable-Final-Algorithm Theorem.**  
Assume a noisy wrapper can produce a validation-independent polynomial list `L` of complete classifiers, and for some near-optimal comparator `c`, with high probability `L` contains `h` satisfying
$$
\operatorname{err}_{D_c^+}(h,c)\le \epsilon/3.
$$
Then fresh noisy validation over `L`, plus the clean-conditional lemma, gives
$$
\operatorname{err}_D(\hat h,Y)\le \operatorname{OPT}_C(D)+O(\epsilon).
$$

**Lemma B: Compression Suffices For CleanPopulationTransfer.**  
If all final classifiers considered by the clean procedure are decodable from `k` clean examples plus `b` bits, then CleanPopulationTransfer follows whenever
$$
k\log n+b+\log(1/\delta)=O(\epsilon^2 n).
$$
For a polynomial final list by exhaustive decoding, one needs the stronger condition
$$
\sum_{i\le k}\binom{n}{i}2^b=\operatorname{poly}(s,1/\epsilon,\log(1/\delta)).
$$
Thus index-compression with `k=O(log s)` is enough statistically but usually gives quasi-polynomial enumeration.

**Lemma C: Base Stability Does Not Compose Through An Unstable Selector.**  
Even if every weak output is leave-one-out stable, ERM over `sign(B^(T))` may switch between very different votes after one sample change. Therefore per-call stability must be paired with a stable selector, a fixed aggregation rule, a margin/rounding certificate, or an explicit final list.

## Proof Attempts

The main proof skeleton is:

1. Choose `c` with `err_D(c) <= OPT_C(D)+tau`.
2. Work on the hidden clean conditional `P=D_c^+`.
3. Use stability/compression/quotient structure to show that a clean empirical success certificate transfers to `P`.
4. Use L004/C007:
   $$
   \operatorname{err}_D(h,Y)\le \operatorname{OPT}_C(D)+\tau+\operatorname{err}_{D_c^+}(h,c).
   $$
5. Use fresh validation only after a validation-independent polynomial list or efficient selector is fixed.

This proof is sound as a conditional theorem. The unresolved part is deriving the hypotheses from the atlas weak learner.

## Gaps And Risks

Per-call stability must be measured in the right metric. Stability under a weak-call distribution `Q_t` does not necessarily control error under `D_c^+` unless there is a domination or coverage condition.

Small base-output quotients do not imply a small final vote quotient. If `|B|=poly` and `T=Theta(log s)`, exhaustive `sign(B^(T))` search can still be quasi-polynomial or Set-Cover hard.

The assumptions can become nearly circular if they require a stable procedure that already outputs an `epsilon`-accurate clean classifier from hidden clean data.

## Counterexamples Or Obstructions

Rare-slice junk blocks any claim that semantic `OPT+beta` weak correctness implies global range, dual VC, stability, or quotient control.

Finite bag size alone does not imply clean-population transfer: a singleton classifier can memorize the clean sample and behave randomly off-sample.

Worst-case exact ERM over the DCHP class `sign(B^(T))` is Set-Cover hard for arbitrary bags, so any final-selector assumption must exploit extra structure or output an explicit polynomial list.

## Sources Consulted

No web search used. Consulted the assigned run files, especially `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_010/idea_03/idea.md`.

Relevant bibliography already recorded in the run: da Cunha-Hogsgaard-Paudice 2026, “Sample-Near-Optimal Agnostic Boosting with Improved Running Time,” https://arxiv.org/abs/2601.11265.

## Recommended Next Steps

Formalize one theorem with three named assumptions: `RealizedCleanSimulation`, `StableOrCompressedCleanPopulationTransfer`, and `PolynomialFinalSelectorOrList`.

Then separately test three sufficient conditions:
`FinalAlgorithmStability`, `FinalTranscriptCompression`, and `EffectiveFinalQuotient`.

Do not state “stable weak learner implies the edge” unless selector stability or polynomial final-list generation is included explicitly.