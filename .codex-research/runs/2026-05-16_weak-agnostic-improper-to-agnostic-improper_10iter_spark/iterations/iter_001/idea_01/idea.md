# Residual-forcing wrapper with controlled rejection sampling

ID: idea_01

## Summary
Develop a polynomial-time **distribution-free residual-forcing wrapper**: repeatedly call the fixed-slack learner on weighted restrictions of the sample where points with high disagreement under current consensus are re-weighted/dropped, creating a sequence of filters so that each stage either certifies low OPT or forces a noticeable gain in one-step correlation, with total variation of weights controlled to keep sample complexity polynomial in 1/epsilon.

## Why Promising
Could avoid the typical combinatorial clean-subset enumeration by maintaining weights explicitly; similar to multiplicative-weights style distillation may preserve weak-edge guarantees while converting constant residual to arbitrary epsilon when combined with martingale-style stopping.

## Risks
Could fail if fixed-slack oracle only gives additive guarantee with respect to target class and cannot be made robust under adversarial relabeling; proof may require assumptions like realizability on trimmed distributions that are not distribution-free.

## Suggested Lenses
- proof strategy
- algorithm design
- complexity accounting
