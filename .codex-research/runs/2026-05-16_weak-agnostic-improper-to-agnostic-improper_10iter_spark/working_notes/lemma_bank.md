# Lemma Bank

- **Lemma-Lite (Conditional):** If a wrapper gives per-round distributions `D_t` with:
  - `mass(D_t) ≥ 1/poly(n,1/ε)` and
  - `γ_t = 1/2 - OPT_C(D_t) ≥ γ_min(β,ε,δ,n) > 0`,
  and if `γ_t` is certifiable from samples with high probability under adaptive stopping-time wrappers, then fixed-`β` calls can be combined via compatible weak-boosting machinery to target excess `ε`.
  - Status: `open-critical` (missing compatibility table + certifiability).

- **Lemma (Accepted):** Fixed-slack oracle equivalence in `{0,1}` labels remains valid: 
  
  `err_D(h) ≤ OPT_C(D)+β ⇔ corr(h,Y) ≥ sup_c corr(c,Y)-2β`.

- **Lemma-Critique (Accepted):** Existing fixed-weak frameworks reviewed in-file generally require richer interface than pure `0/1` excess-risk oracle (confidence/margins/residuals/weights) to instantiate directly.
  - Status: `identified gap`.

- **Iteration-10 Route-D Lemma Target (Open):** For each candidate theorem in KMV08 / Feldman / potential-based lines, produce a literal translation from atlas oracle to theorem weak-condition, including final guarantee type (`OPT+ε` vs `OPT+α+ε`) and computational dependence on `(β, ε, δ, n)`.

- **Iteration-10 Candidate Negative Lemma (Open):** If for every admissible wrapper schedule one can force either
  - `OPT_C(D_t) → 1/2` on required rounds, or
  - `mass(D_t)` shrinks super-polynomially in `n,1/ε`,
  then fixed-`β` conversion under this oracle fails for efficiency without extra assumptions.
  - Status: `open` (no quantifier-complete witness yet).

- **Iteration-10 Estimation Sublemma (Open):** Constructing adaptive stopping-time high-confidence lower bounds on `γ_t` remains unresolved; without this, Route A is not computationally operational.
