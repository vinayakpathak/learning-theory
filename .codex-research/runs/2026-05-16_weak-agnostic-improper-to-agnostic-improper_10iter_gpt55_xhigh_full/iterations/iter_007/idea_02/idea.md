# No-Free-Regularization Weak Learners

ID: idea_02

## Summary
Construct weak learners satisfying OPT+beta that encode arbitrary sample-dependent bits in tiny or validation-irrelevant regions, forcing huge Range(A), VC, or dual VC while preserving the weak guarantee. Then test whether any generic wrapper can canonicalize, prune, or ignore the junk without additional assumptions.

## Why Promising
This directly probes whether controlled range, compression, or stability can be derived from the atlas source, which is the main missing assumption in the DCHP route.

## Risks
A pathological weak learner does not rule out a different controlled learner for the same class. The construction must matter for black-box reductions that are given only the source learner A.

## Suggested Lenses
- counterexample search
- oracle model
- complexity accounting
