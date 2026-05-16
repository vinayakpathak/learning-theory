## Summary

The explorer’s core legality lemma is correct and worth keeping: if every weak-call distribution is light on a block `S`, then a weak learner for `C={+1}` may be arbitrary on `S` while remaining `OPT+beta` valid.

But the report does **not** establish compatibility with the literal DCHP generator. The main obstruction is stronger than a small gap: a block that is relevant enough for final Set-Cover selector hardness is likely to be seen by DCHP’s empirical or tuple-based weak calls, at which point rare-slice legality fails.

## Issue List

- **Fatal gap:** final-relevant versus weak-call-light tension.  
  To encode a polynomial Set-Cover gadget, the final sample must see many rows from `S`. If the weak-call sample is drawn from the same distribution at comparable size, it will also hit `S` with high probability. Tuple enumeration or repeated selected samples can then create calls with `Q(S)=1`.

- **Missing assumption:** common hidden key `R`.  
  The Set-Cover matrix needs many columns on the same block `S={R} x U`. A standard PAC learner outputs evaluable hypotheses; in the obvious representation, each hypothesis exposes `R`. After that, adaptive calls can focus on `S`.

- **Missing assumption:** stateful column scheduling.  
  “The generated bag can contain an arbitrary sparse-majority instance” requires the weak learner to output prescribed columns `b_j` across many calls. A normal learner is stateless except for fresh randomness. A stateful oracle can do this, but that is a different model.

- **Plausible but incomplete:** random hidden block lemma.  
  The Markov bound works for a fixed or nonadaptive call schedule. It does not handle adaptive schedules once previous returned hypotheses reveal information about `R`.

- **Fatal gap for hardness:** extra columns are uncontrolled.  
  Set-Cover no-instance soundness is not monotone under adding arbitrary columns. A single extra helpful column can make the sparse-majority ERM instance easy. The construction needs exact control of all generated columns, not just inclusion of a hard submatrix.

- **Unsupported source-audit step:** DCHP spike calls.  
  The warning that repeated tuple enumeration gives `Q(S)=1` is plausible and consistent with the ledger, but it depends on the exact DCHP weak-call distribution. It should be stated as an audit target until verified from the proof.

- **Scope limitation:** `C={+1}` makes the learning problem trivial.  
  This is fine for a selector-obstruction toy model, but fatal for any atlas separation claim. A strong learner can ignore the polluted bag and output `+1`.

- **Plausible but incomplete:** iid final-row realization.  
  Need explicit accounting for block mass `alpha`, gadget row count `N`, sample size, and selector tolerance. The empirical gap is about `alpha/N`; if `alpha` is made tiny to avoid weak-call hits, final realization becomes too sparse.

## Counterexamples Or Stress Tests

- **Sample-split tension test:** suppose the hard block has mass `alpha`, weak pool size `m_w`, final pool size `m_f`, and the gadget has `N` rows. Final realization needs roughly  
  `m_f alpha >= N log N`.  
  Weak-call avoidance needs  
  `m_w alpha = O(1)`.  
  If `m_w` and `m_f` are comparable, both cannot hold for polynomial-size gadgets.

- **Key-leakage test:** let the first returned hypothesis be  
  `h_R(k,u)=+1` off `k=R` and nonconstant on `k=R`.  
  If its description contains `R`, the next query can be supported on `S`; then `Q(S)=1` and arbitrary behavior on `S` is no longer legal.

- **Independent-slice test:** if each column uses an independent hidden key `R_j`, legality is easier, but the columns do not form one common Set-Cover matrix. The sparse-majority gadget no longer lives on shared rows.

- **Helpful-extra-column test:** add to the polluted bag one column equal to the target labels on the hard rows and `+1` elsewhere. It is legal under query-lightness, but it destroys Set-Cover no-instance soundness.

## Literature Or Known-Result Conflicts

No direct external literature conflict appears. The explorer is consistent with ledger items C038/L034 on arbitrary-bag Set-Cover hardness and C043/L041 on rare-slice programmable weak outputs.

The only source-level caution is DCHP-specific: the report uses a plausible picture of tuple-supported weak calls, but literal compatibility requires checking the actual DCHP query construction, sample split, repetitions, constants/offsets, and computed `T`.

## What Survives The Critique

- The **query-light block pollution lemma** survives.
- The **nonadaptive random block Markov bound** survives.
- The construction remains a useful **black-box selector-structure warning**: semantic weak validity alone does not imply generated bags are benign.
- The explorer correctly refuses to call this an atlas separation or a literal DCHP lower bound.

## Recommended Next Checks

1. Formalize separate models: stateless PAC learner, stateful oracle, and black-box hypothesis handle.
2. Audit DCHP weak-call distributions to determine whether hard-block sample hits imply `Q(S)=1`.
3. Prove the sample-split tension lemma above for all-ordered tuple enumeration.
4. Specify column scheduling and prove extra generated columns cannot repair Set-Cover no-instances.
5. Work out `alpha`, gadget size `N`, sample size, and additive selector gap explicitly.
6. Record this as a standalone black-box obstruction unless the DCHP audit resolves the query-lightness problem.