# Random Vote Lists

ID: idea_02

## Summary
Replace exact ERM over sign(B^(T)) by a randomized polynomial final list. Given a generated bag B, sample T-wise majorities from uniform, frequency-weighted, or boosting-induced distributions and ask whether an accurate clean-conditional vote appears with inverse-polynomial probability.

## Why Promising
It bypasses the known Set-Cover hardness of exact sparse-majority ERM and would plug directly into the clean-list sufficiency lemma.

## Risks
The good vote may have exponentially small measure under any natural sampler. Set-Cover-style examples suggest random sparse majorities usually miss rare covers. Clean validation labels are unavailable.

## Suggested Lenses
- proof strategy
- counterexample search
