## Accepted Progress
- Iteration 1 is fully consolidated in working notes as a **no-progress-but-high-signal** state: no theorem proved, no separation established.
- The edge `efficient-weak-agnostic-improper-pac => efficient-agnostic-improper-pac` remains explicitly open.
- Central blocker is now clearly recorded: loss of usable `OPT`-gap guarantees under adaptive filtering/reweighting.

## Candidate Routes
1. Develop a residual-forcing wrapper only if it satisfies an explicit invariant:
   - controlled acceptance mass (polynomial in `1/ε`), and
   - `OPT_C`-gap preservation on each filtered distribution.
2. Prove a conditional positive theorem for subclasses (margin/noise/stability assumptions).
3. Explore SQ-based negative route showing fixed-slack precision is insufficient for arbitrary-ε amplification.
4. Attempt explicit conditional hardness reduction using only fixed-slack oracle behavior (candidate ideas 02/04/06).

## Refuted Or Weakened Claims
- Refuted as a general theorem (for now): “standard residual-forcing + weak boosting directly gives poly-time ε-amplification from fixed-slack alone.”
- Weakened:
  - Oracle model mismatch is now explicit: fixed-slack 0/1-error oracle is stronger than needed for many margin-based boosters; extra structure is required.
  - “Adaptive reweighting preserves learnability gap” is now only a conditional sublemma, not a derived fact.

## Working Notes Updated
- [working_notes/canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/canonical_summary.md)
- [working_notes/claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/claim_ledger.md)
- [working_notes/lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/lemma_bank.md)
- [working_notes/failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/failed_attempts.md)
- [working_notes/counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/counterexamples.md)
- [working_notes/literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/literature_map.md)
- [working_notes/promising_directions.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/promising_directions.md)
- [working_notes/iteration_summaries.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/iteration_summaries.md)
- [working_notes/bibliography.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/bibliography.md)

## Next Iteration Focus
- Prioritize one formal object: prove or refute the filter-gap preservation sublemma with explicit constants and complexity bounds.
- In parallel, instantiate a concrete obstruction pattern into a fully specified `(C, D, filter)` witness (or show it cannot be done for a broad class).
