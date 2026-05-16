# De-Enumerate Residual-Free Boosting

ID: idea_03

## Summary
Audit the da Cunha-style residual-free booster at the algorithm level and isolate the exact step causing non-polynomial dependence. For each exponential term, ask whether validation, direct weak calls, online selection, or a capacity assumption on Range(A) can replace enumeration.

## Why Promising
This is the closest known positive route: the fixed-slack source matches the semantic weak condition, and only representation-uniform efficiency is missing.

## Risks
The audit may show the exponential transcript or clean-label enumeration is essential for the known proof, not an artifact.

## Suggested Lenses
- literature audit
- algorithm audit
