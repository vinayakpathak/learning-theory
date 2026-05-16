# Observable Residual Minimax LP

ID: idea_01

## Summary
Model a public transcript as a finite partition with variables for each cell's mass, comparator posterior error, and current predictor behavior. Optimize over all public nonnegative filters and sign relabelings to decide whether excess risk over a comparator ever forces a query with comparator error below gamma. Include sign-specific cells, not just aggregate agreement or mistake filters.

## Why Promising
This directly tests the weakest missing step in residual-forcing proofs and could produce either a usable low-noise-query lemma or a crisp finite counterexample explaining why no public residual method can work.

## Risks
A positive result may need assumptions not present in the atlas source. A finite-cell abstraction could miss continuous or adaptive queries, and a negative LP certificate may only rule out one-step public filters.

## Suggested Lenses
- finite LP
- counterexample search
- proof strategy
