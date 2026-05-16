# Compression-Based Clean Witnesses

ID: idea_03

## Summary
Investigate a conditional positive theorem under a small-sample or sample-compression assumption on A. If A uses k examples or has compression size k = O(log poly(1/epsilon)), enumerate candidate training subsets from a larger sample, run A on each induced empirical distribution, and use held-out validation plus boosting to select useful hypotheses.

## Why Promising
It directly attacks the exponential clean-batch probability in the solver attempt. The condition is concrete, checkable, and may yield a clean theorem even if the unrestricted edge remains open.

## Risks
Validation may not certify that a hypothesis useful on a clean slice helps on the original distribution; the enumeration may still be polynomial only under very strong sample-size or compression assumptions.

## Suggested Lenses
- conditional theorem
- proof strategy
