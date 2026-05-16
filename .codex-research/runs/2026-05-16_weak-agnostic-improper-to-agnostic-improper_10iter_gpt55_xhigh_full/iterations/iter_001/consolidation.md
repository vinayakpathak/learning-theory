## Accepted Progress

The edge remains open. I consolidated the accepted pieces: fixed `OPT + beta` equals additive best-correlation approximation; the hard band is `gamma <= OPT_C <= 1/2 - epsilon`; and the clean-conditional lemma gives a real reduction from agnostic learning to finding a hypothesis good on `D_c^+`.

The da Cunha-style residual-free boosting route is recorded as the strongest near miss: semantically compatible with fixed slack, but not representation-uniform polynomial with the known generic runtime.

## Candidate Routes

The main positive route is now a polynomial clean-witness menu theorem. Two possible sufficient mechanisms are recorded: random clean witnesses with total witness size `K = O(log poly(s,1/epsilon))`, and enumerable compression witnesses with controlled final selection.

The main negative route is a restricted black-box oracle barrier, explicitly not an atlas separation yet.

## Refuted Or Weakened Claims

I recorded the corrected da Cunha parameter translation. The claim "`epsilon_0 >= 2 beta` works for all `gamma_0 <= 1`" is false unless `rho >= 0` is assumed or `gamma_0=1`.

I also recorded that ordinary sample compression, small weak-call sample size, and unrestricted hidden-set oracle lower bounds do not suffice as stated.

## Working Notes Updated

Updated under `working_notes/`:

- [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md:1)
- [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md:1)
- [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md:1)
- [failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/failed_attempts.md:1)
- [counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/counterexamples.md:1)
- [literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/literature_map.md:1)
- [promising_directions.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/promising_directions.md:1)
- [bibliography.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/bibliography.md:1)
- [iteration_summaries.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/iteration_summaries.md:1)

## Next Iteration Focus

Formalize the clean-witness menu theorem first, then audit da Cunha 2025/2026 at algorithm level to isolate the exact exponential step. In parallel, define the restricted oracle-barrier model precisely enough that point-mass, empirical, artificial-label, and adaptive leakage issues are not swept under the rug.