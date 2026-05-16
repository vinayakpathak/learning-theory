# da Cunha Vote Selector

ID: idea_03

## Summary
Extract the exact final vote class in the da Cunha-Hogsgaard-Paudice proof: unrestricted real thresholds, nonnegative convex votes, bounded T-wise majorities, or something more structured. Then test whether the existence proof gives a margin or surrogate-risk certificate that enables polynomial-time selection over a generated bag, instead of enumerating all votes.

## Why Promising
The da Cunha route is the strongest positive near miss, and the final selector is a sharply isolated bottleneck. This direction can produce either a useful conditional positive theorem or a precise coordinate-bag hardness obstruction.

## Risks
Even if final selection is solved, the hidden-clean bag generation and clean-population transfer bottlenecks remain. The extracted vote class may still contain agnostic halfspace selection as a special case, or the proof's margin may be too weak or empirical-only.

## Suggested Lenses
- paper audit
- algorithm extraction
- hardness reduction
