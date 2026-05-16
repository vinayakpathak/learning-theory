# Complete Route-D oracle compatibility matrix with exact theorem IDs

ID: idea_01

## Summary
Build an explicit theorem-by-theorem compatibility matrix for KMV08, Feldman, and potential-based agnostic boosting: source oracle form, required weak hypothesis output (binary/real/confidence), per-round complexity, and final excess form (OPT+ε vs OPT+α+ε). The first deliverable should be a table with theorem IDs and quantified parameter substitutions.

## Why Promising
If existing boosters already imply the target under this exact model, this audit is the shortest path to closure; if not, it gives a precise negative/fence for where extra assumptions are indispensable.

## Risks
The strongest route will fail unless exact theorem assumptions (labels/margins/complexity) are met. Risk of mapping mismatch is high, especially around binary outputs and distribution-free runtime. Also high chance no theorem in current form gives true OPT+ε rather than OPT+α+ε.

## Suggested Lenses
- proof strategy
- literature audit
- oracle-translation
