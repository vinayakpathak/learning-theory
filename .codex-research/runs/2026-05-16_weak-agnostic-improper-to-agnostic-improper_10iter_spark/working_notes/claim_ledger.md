# Claim Ledger

- [Accepted] `iter_010` preserves the unresolved status of the target edge and records no theorem-level conversion for iteration 10.
- [Accepted] Iteration 10 confirms the exact error/correlation equivalence in the atlas oracle: 
  
  `err_D(h)≤OPT_C(D)+β ⇔ corr(h,Y)≥sup_c corr(c,Y)-2β`.
- [Refuted-as-Theorem] The claim that `err≤OPT+β` plus adaptive filtering immediately yields poly-time `ε`-agnostic improvement is refuted as unsupported in-file (it requires missing invariants and interface checks).
- [Refined] Iteration 10 sharpens required quantifiers for any Route-A argument: `γ_t` lower bounds and mass guarantees must be explicit in `(β, ε, δ, n)` and certified with high confidence under adaptive dependence.
- [Refined] The blocker class `OPT+α(+ε)` is still tracked as a likely outcome under current literature families unless an exact theorem with `α=0` is extracted.
- [Conjecture] If any theorem in KMV08 / Feldman / potential-based lines accepts the atlas oracle under `{0,1}` outputs and compatibility, then fixed-slack rounds with explicit `γ_t` and polynomial mass can still imply final `ε`-excess via known weak-boosting recursion.
- [Open] `iter_010` leaves two explicit open claims:
  1. theorem-indexed Route-D compatibility matrix (theorem IDs, assumptions, final excess form);
  2. a Route-B explicit `(C,D,F)` obstruction with quantified guarantees.
- [Conjecture] `iter_010` records a conditional negative priority: if no Route-D row clears and no Route-A certificates can be made adaptive-valid, a structured `(C,D,F)` instability proof (OPT inflation or mass collapse) remains the strongest fallback.
