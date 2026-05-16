# Counterexamples And Obstructions

Iteration-10 status for obstruction candidates:

1. **Filter-Dirtying Obstruction (conditional):** Adaptive wrapper filters can still plausibly drive `OPT_C(D_t)` toward `1/2` even when `OPT_C(D)` is small, destroying fixed-`β` advantage.
   - Status: stress-test pattern (no formal `∃(C,D,F)` with explicit quantifiers).

2. **Rarity/Acceptance Collapse (conditional):** Wrapper reweighting may force exponentially shrinking support/mass in a small number of rounds.
   - Status: stress-test pattern.

3. **Oracle-Mismatch Obstruction (methodological):** Some fixed-weak theorems require richer weak-learner outputs than a pure `{0,1}` excess-risk guarantee.
   - Status: recurring identified methodological blocker in-file.

4. **Offset-Floor Transfer Obstruction (formal pattern):** Current literature targets appear to preserve an additive floor tied to weak offset unless wrapper compatibility lowers it in each round.
   - Status: partially verified by mapping attempts; not theoremized in-file.

5. **Parameter-Convention Obstruction:** Conversions remain brittle without full normalization and theorem-contract tables (`advantage/correlation/error` and confidence dependence).
   - Status: methodological gap.

6. **Precision-Boundary Obstruction (conditional):** As `β→1/2`, finite-sample noise can erase certifiable `γ_t` certificates; no adaptive confidence theorem was established in this iteration.
   - Status: conditional obstruction candidate.

7. **Quantified-Route-B absence:** No explicit `(C,D,F)` theorem was produced in iter_010.
   - Status: unresolved;
     priority remains to prove either a formal negative construction or to demote this to unresolved if Route D/A fail for other reasons.
