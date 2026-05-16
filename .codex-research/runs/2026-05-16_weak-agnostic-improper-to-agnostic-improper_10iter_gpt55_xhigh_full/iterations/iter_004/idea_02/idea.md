# Implicit Vote Selector

ID: idea_02

## Summary
Revisit the da Cunha-style residual-free proof through implicit optimization rather than tuple and vote enumeration. Try to formulate the final vote selection as ERM or convex risk minimization over mixtures of realized weak outputs, using only polynomially many fresh population weak calls and finite-list validation at the end. Identify exactly whether the remaining exponential step is hidden-clean sample generation, final vote ERM, or clean-population generalization.

## Why Promising
The semantic weak condition is already compatible with fixed beta; the gap is algorithmic. If the vote search can be replaced by an oracle-based or online-learning selector, the strongest positive near miss may become an atlas-polynomial theorem.

## Risks
Constant additive oracle error may be too coarse for any convex-optimization implementation. The weak oracle optimizes over C, while the desired final class may be an exponentially large vote class without an efficient separation oracle.

## Suggested Lenses
- algorithm design
- runtime audit
- duality
