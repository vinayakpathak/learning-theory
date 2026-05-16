## Accepted Progress
- Iteration 3 is consolidated as **unsolved** (open edge remains unresolved): no complete proof of  
  `efficient-weak-agnostic-improper-pac => efficient-agnostic-improper-pac`.
- The blocker was narrowed to a precise conditional package:
  - stable adaptive-filter gap preservation (`OPT_C(D_t) ≤ 1/2 - γ_t` with explicit trackable `γ_t`), and
  - polynomial acceptance-mass lower bounds across rounds.
- The notes now consistently distinguish search status from theorem status (no accidental impossibility claims retained).
- Refined the obstruction status to “stress-test/candidate pattern” unless a quantified `(C,D,F)` proof is supplied.

## Candidate Routes
- Route A (positive): prove one concrete filter family with explicit invariants and instantiate a matching agnostic-boosting theorem via precise oracle-semantics conversion.
- Route B (negative): build an explicit quantifier-checked counterexample showing adaptive filtering can raise `OPT` to near `1/2` or collapse mass polynomially too fast.
- Route C (precision): formalize the oracle as an SQ/precision object and derive conditional lower bounds for fixed-precision amplification barriers.
- Route D (audit): complete theorem-by-theorem parameter-translation table for KMV08, Feldman (distribution-specific), and potential-based boosting in the exact atlas oracle model.

## Refuted Or Weakened Claims
- Reframed as non-theorem: “no direct conversion exists” (now stored as partial instantiation status).
- Reframed as non-theorem: “fixed-offset floor is always unavoidable” (now marked convention-dependent until exact source matching is done).
- Reframed as non-theorem: “adaptive filtering destroys progress” (kept as conditional stress-test until formalized as quantified witness).
- Added that previous `opt + α + ε` transfer claims in prior notes require exact normalization and are not yet theorem-grade here.

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
- Add a strict conversion table from fixed-slack `err ≤ OPT+β` to each candidate theorem’s exact assumptions and complexity claims before any positive transfer statement.
- Prove Route A by giving one filter construction with fully explicit `γ_t`, mass bounds, and sample/runtime accounting.
- In parallel, attempt one explicit `C,D,F` obstruction witness with complete quantifiers and complexity consequences.
