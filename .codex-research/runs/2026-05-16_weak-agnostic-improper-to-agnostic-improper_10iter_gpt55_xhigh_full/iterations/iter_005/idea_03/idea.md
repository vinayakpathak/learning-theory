# Hard-Core Low-OPT Chunk Lemma

ID: idea_03

## Summary
Try to prove a hard-core or dense-model decomposition: if the current final classifier is more than epsilon above OPT_C, then a minimax-selected public distribution over filters/relabelings contains a query where a near-optimal comparator has error at most gamma minus poly(epsilon). Avoid the known high-loss and mistake-residual failures by optimizing over a richer public filter family.

## Why Promising
Such a lemma would turn the fixed weak learner into a fully polynomial booster and would conceptually replace da Cunha-style hidden clean enumeration with a dual certificate.

## Risks
The public-posterior obstruction suggests the needed filter may require information about the hidden comparator. The dual object may depend on c and be nonconstructive, or may only give comparator error just below gamma with no polynomial margin.

## Suggested Lenses
- convex duality
- hard-core lemma
- proof strategy
