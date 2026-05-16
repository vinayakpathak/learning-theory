# Exact Sparse-Majority Selector Dichotomy

ID: idea_01

## Summary
Study empirical risk minimization over the exact DCHP final class V_{B,T}=sign(sum_j k_j h_j), with k_j nonnegative integers summing to T and sign(0)=1. Try for either a polynomial or FPT selector when T=O(log(1/epsilon)), or a hardness reduction for approximate ERM on arbitrary binary feature bags, including cases with complements/constants.

## Why Promising
Iteration 6 isolated this as a concrete bottleneck. It is precise, separable from hidden-clean generation, and a theorem either way would clarify whether the DCHP near miss is only upstream or also computationally blocked.

## Risks
A hardness result for relaxed halfspaces may miss the exact nonnegative integer zero-threshold class. A positive selector would still leave the upstream hidden-clean bag-generation problem unresolved.

## Suggested Lenses
- proof strategy
- computational complexity
- counterexample search
