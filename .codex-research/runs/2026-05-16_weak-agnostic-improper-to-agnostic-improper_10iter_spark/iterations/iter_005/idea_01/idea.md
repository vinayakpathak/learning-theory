# Close the oracle-semantics gap with explicit theorem map

ID: idea_01

## Summary
Produce a one-page exact translation from the atlas oracle `err_D(h) ≤ OPT_C(D)+β` to fixed `(α,γ)` assumptions in KMV08 / Feldman / potential-based agnostic boosting results, including theorem numbers, norm convention conversions, and runtime dependence on `1/(1/2-β)` and `1/ε`; identify which theorem, if any, already implies target for this exact interface.

## Why Promising
This is the highest-uncertainty blocker; either a known theorem instantly settles the edge or it sharply proves a missing assumption (instead of heuristic optimism).

## Risks
Could stall if all candidate theorems require weak-learner returns confidence/margin or sample-dependent weights not available from 0/1 excess-risk oracle; constants may still hide inverse-polynomial-in-gap terms that make the round complexity non-polynomial in 1/ε.

## Suggested Lenses
- oracle-model translation
- parameter audit
- boosting theorem mining
