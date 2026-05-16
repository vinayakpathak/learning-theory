# Anchor Doping For Support-Function Refinement

ID: idea_02

## Summary
Study label-doping queries where the conditional label mean is a mixture of a known public anchor signal and the original target labels. Vary the mixing weight and reweighting to see whether a constant-additive correlation oracle can be converted into an epsilon-accurate optimizer for the original correlation objective, or prove this is impossible without strong anchor structure.

## Why Promising
It attacks the hard-band silence without hidden clean transcripts. A success would give a new positive route; a failure could become a clean black-box obstruction to upgrading fixed additive optimization.

## Risks
The oracle may satisfy the guarantee by returning an anchor hypothesis and ignoring the small target perturbation. Suitable public anchors may not exist for arbitrary C, and fixed additive slack may swamp any epsilon-scale information.

## Suggested Lenses
- oracle self-reduction
- convex geometry
- black-box lower bound
