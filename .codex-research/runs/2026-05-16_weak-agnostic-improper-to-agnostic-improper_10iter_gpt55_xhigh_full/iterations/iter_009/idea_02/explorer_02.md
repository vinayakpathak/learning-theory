## Summary

The idea gives a useful capacity refinement, but not a positive proof.

`Range(A)` / dual-VC assumptions can be removed from two layers:

1. correctness of polynomially many actually realized weak calls, if each call gets fresh iid samples from its realized population query;
2. final noisy validation, if the pre-validation output is a polynomial list, or an explicit finite vote class, of complete classifiers.

They cannot be removed from the hidden-clean population-transfer layer by realized-call union bounds alone. DCHP still needs some way to prove that a hidden-clean transcript or generated bag has population accuracy on `D_c^+`; finite realized calls and finite bags do not imply that.

## Concrete Progress

A sharper conditional DCHP statement should separate three capacities:

| Layer | Global `Range(A)` needed? | Replacement |
|---|---:|---|
| Realized PAC weak calls | No | Union bound over `q=poly(...)` fresh population queries |
| Hidden-clean transfer | Still unresolved | Needs VC/dual-VC, stability, compression, clean-witness generator, or another population certificate |
| Final selection | No, statistically | Fresh validation over finite list/class; computation remains separate |

For a fixed generated bag `B` of size `M`, the DCHP final class has size at most  
`binom(M+T-1,T)`, so validation needs roughly

$$
O((T\log(M+T)+\log(1/\delta))/\epsilon^2)
$$

samples. This avoids global `Range(A)` for final statistical selection. It does not solve exact sparse-majority ERM.

## Claims Or Lemmas

**Realized-Call Capacity Lemma.**  
For `q` adaptive weak calls, if each call samples freshly from its intended population query distribution, confidence `delta/q` per call gives all weak guarantees with probability `1-delta`. No global VC or dual VC of `Range(A)` is needed.

**Fixed-Bag Final Validation Lemma.**  
If before seeing validation data we have a finite complete-classifier class `L`, fresh validation selects within `O(epsilon)` of the best classifier in `L` with logarithmic dependence on `|L|`.

**Middle-Layer Non-Reduction.**  
The hidden-clean population step is not covered by either lemma. If the proof only knows that some hidden-clean empirical transcript works, then one still needs a reason it works on `D_c^+`. Realized-call correctness says the weak learner answered its sampled queries legally; it does not certify clean-slice population accuracy of the existential transcript.

## Proof Attempts

The first replacement works cleanly: replace any “all possible weak calls are good” argument by “all realized calls are good,” provided the wrapper actually samples from each query distribution.

The final replacement also works cleanly: once a polynomial validation-independent list of complete classifiers exists, noisy validation handles selection.

The attempted middle replacement fails. DCHP-style hidden-clean tuple enumeration ranges over tuples selected relative to an unknown comparator. If all tuples are enumerated, the count can be `n^{m0}` and is not atlas-polynomial when `m0` grows. If only polynomially many tuples are sampled, hitting a useful all-clean transcript has the usual `p^K` obstruction. And noisy validation cannot rescue intermediate weak hypotheses that are useful only on `D_c^+`.

## Gaps And Risks

A direct theorem-level audit of the DCHP proof is still needed to mark exactly where `VC(H)` versus `VC*(H)` enters.

The final validation refinement is statistical only; the exact DCHP selector over `sign(B^(T))` remains computationally hard in worst case.

If `m0` were representation-uniformly bounded and a polynomial selector existed, realized-call accounting would meaningfully simplify the conditional theorem. Without that, it mostly clarifies where the bottleneck is.

## Counterexamples Or Obstructions

Finite bags can overfit hidden clean samples; empirical clean performance does not imply clean-population performance.

Rare-slice weak learners show semantic `OPT+beta` correctness does not control global range or dual VC.

Worst-case exact sparse-majority ERM over arbitrary bags is Set-Cover hard.

Validation of individual weak hypotheses fails because a clean-slice-useful base learner may have poor noisy risk.

## Sources Consulted

No web search was used.

Local sources: `problem.md`, `iterations/iter_009/idea_02/idea.md`, `working_notes/canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`.

External source referenced through local bibliography: da Cunha, Hogsgaard, Paudice, “Sample-Near-Optimal Agnostic Boosting with Improved Running Time,” https://arxiv.org/abs/2601.11265.

## Recommended Next Steps

1. Rewrite the conditional DCHP theorem with three explicit primitives: realized-call sampling, hidden-clean population transfer, and final selector/list generation.
2. Audit the DCHP proof line-by-line to classify each `VC(H)`/`VC*(H)` use into one of those three layers.
3. Stop trying to use realized-call union bounds for hidden-clean transfer unless paired with compression, stability, or an explicit clean-witness menu.