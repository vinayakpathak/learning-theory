# General Residual Low-OPT Lemma

ID: idea_02

## Summary
Analyze the most general public randomized relabeling/filtering scheme based on a current soft predictor F and the observed samples, not on the hidden comparator c. The goal is either to prove a lemma of the form 'if F has excess > epsilon, then some sampleable residual query has OPT_C < gamma and yields descent', or to construct a flat-posterior counterexample for the whole scheme class.

## Why Promising
A positive result would bypass hidden clean tuple enumeration and give a real boosting route. A negative result would subsume several failed residual attempts and clarify exactly why fixed slack cannot be refined by public transformations.

## Risks
Known correlation/potential boosters with additive slack leave a constant floor, and public-posterior obstructions may refute the needed low-OPT lemma. Anchor absorption is a serious threat for any small perturbation scheme.

## Suggested Lenses
- proof strategy
- counterexample search
- minimax residual analysis
