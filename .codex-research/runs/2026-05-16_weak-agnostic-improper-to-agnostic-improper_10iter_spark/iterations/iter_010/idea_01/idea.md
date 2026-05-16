# Oracle-Contract Compatibility Matrix for Fixed-Slack Boosting Theorems

ID: idea_01

## Summary
Complete a theorem-by-theorem compatibility matrix for KMV08, Feldman (distribution-specific), and potential-based agnostic boosting results under the atlas oracle form `err_D(h) ≤ OPT_C(D)+β` with only 0/1 outputs. For each theorem record: input contract, required confidence/margin/output type, dependence on `1/(1/2-β)`, `1/ε`, and whether final guarantee is `OPT+ε` or `OPT+α+ε`. This can either produce an explicit positive reduction or a formal negative-compatibility fence.

## Why Promising
It directly resolves the central open blocker and can convert 8+ months of conditional status into a crisp theorem-level answer (or a formal no-go).


## Risks
High work to recover exact theorem statements and normalization constants from primary sources; if existing boosters require richer weak-learner outputs than binary excess-risk, this route may die quickly after audit.

## Suggested Lenses
- proof strategy
- literature mapping
- oracle-compatibility
