## Summary
For **iteration 3**, this idea is still unresolved, but the research state is now much cleaner. The best route remains a **conditional positive theorem**: build a residual-forcing wrapper with explicit polynomial guarantees on (i) acceptance mass and (ii) preservation of learnability gap on adaptive filtered distributions. Without those invariants, fixed-slack oracle calls (`err ≤ OPT + β`, constant β) do not force global ε-accuracy in the target model. No completed separation is established.

## Concrete Progress
1. The edge remains `open` with no change in formal status, and the same two-blocker structure was reinforced:  
   - no direct mapping from constant-slack to ε without extra assumptions, and  
   - adaptive filtering can destroy the weak-advantage condition the oracle relies on.  
2. Route split is now explicit and actionable:  
   - Route A: prove stable filter-gap invariant + polynomial acceptance, then reduce to an agnostic boosting schema.  
   - Route B: prove explicit `(C,D,F)` obstruction showing gap inflation or mass collapse.  
3. The project’s notes are now more careful about convention mismatch (`advantage`/`correlation`/excess error) and do not overstate prior claims as theorems.

## Claims Or Lemmas
1. **Conjectural Lemma (core):**  
   If at each boosting round `t`, the wrapper ensures `OPT_C(D_t) ≤ 1/2 - γ_t` with explicit trackable `γ_t` and `mass(D_t) ≥ 1/poly(n,1/ε)`, then fixed-slack calls can be composed to reach `ε`-excess in polynomial time.

2. **Conjectural Sublemma (filter construction):**  
   There exists a computable residual-based filter definition from round statistics that simultaneously preserves a nontrivial lower bound on the residual gap and avoids exponential support collapse.

3. **Observed Obstruction Pattern (not proved):**  
   Adaptive filters can raise effective `OPT_C` on `D_t` near `1/2`, even if original `OPT_C(D)` is small, making the weak oracle unusable on round `t`.

4. **Conventional-Language Risk Claim (methodological):**  
   Published fixed-slack-friendly boosters aligned so far with the literature typically retain an additive floor tied to oracle slack unless additional assumptions make effective slack shrink.

## Proof Attempts
1. **Residual-forcing via adaptive rejection/reweighting:**  
   Attempted to carry an invariant while repeatedly filtering low-confidence/noisy regions; failure point was absence of a proof that `OPT_C` remains bounded away from `1/2` under filtering.

2. **Direct literature-closure attempt (KMV/Feldman/potential styles):**  
   Attempted to instantiate with current oracle (`err ≤ OPT + β` only). This mostly yielded “α-floor” behavior or convention mismatches after normalization; no full polynomial ε-upgrade was derived.

3. **Conditional positive translation attempt:**  
   Reframed as “prove invariant first, then bootstrap with existing weak-against-advantage recursion.” This is the currently most structured positive path, but still incomplete at invariant level.

## Gaps And Risks
1. **Invariant gap-preservation not proved:**  
   There is no theorem yet that adaptive filters used by wrappers preserve `OPT`-gap polynomially.

2. **Acceptance mass may collapse:**  
   Even if gap preservation can be forced occasionally, known wrappers can cause exponentially small effective sample mass, violating poly-time/data constraints.

3. **Oracle-semantics gap:**  
   Most strong booster analyses demand more than 0/1 weak hypotheses with fixed additive excess; they need calibrated advantage/margin style signals.

4. **Risk of false-complete claims from convention errors:**  
   Previous `α + ε` style reductions must be re-normalized carefully (`0/1`-loss vs correlation/advantage formulations).

5. **No explicit obstruction witness yet:**  
   There are stress-test patterns, but no fully formal explicit `(C,D,F)` theorem-level counterexample.

## Counterexamples Or Obstructions
1. **Filter-Dirtying obstruction (conditional):**  
   Adaptive filtering can transform a globally low-`OPT` setting into high-`OPT` restricted distributions, invalidating fixed-slack progress.

2. **Rarity/acceptance collapse obstruction:**  
   Support mass can shrink too fast under adaptive importance-rejection, causing polynomial runtime failure.

3. **Oracle mismatch obstruction:**  
   Fixed-slack guarantees do not directly provide the confidence/margin primitives assumed by several boosters.

4. **Offset-floor obstruction:**  
   Under pure fixed-β weak assumptions, existing matched frameworks often leave an additive floor unless extra regularity is assumed.

## Sources Consulted
- [problem.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/problem.md)
- [working_notes/canonical_summary.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/canonical_summary.md)
- [working_notes/claim_ledger.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/claim_ledger.md)
- [working_notes/lemma_bank.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/lemma_bank.md)
- [working_notes/failed_attempts.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/failed_attempts.md)
- [working_notes/counterexamples.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/counterexamples.md)
- [working_notes/literature_map.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/literature_map.md)
- [working_notes/promising_directions.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/promising_directions.md)
- [working_notes/iteration_summaries.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/working_notes/iteration_summaries.md)
- [iterations/iter_003/idea_01/idea.md](file:///Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_spark/iterations/iter_003/idea_01/idea.md)

## Recommended Next Steps
1. Prove or disprove a concrete filter family with two explicit invariants:
   - `OPT_C(D_t) ≤ 1/2 - γ_t` for polynomially bounded `γ_t`,
   - `mass(D_t) ≥ 1/poly(n,1/ε)` at every round.
2. Build a one-page theorem table translating the exact oracle form `err ≤ OPT + β` into the `(α,γ)` or potential function assumptions required by each candidate booster (KMV/Feldman/potential-based).
3. If invariants fail, switch to Route B and construct an explicit counterexample family `(C,D,F)` for filter-gap inflation or mass-collapse.