# Search for exact fixed-slack-compatible agnostic booster theorem

ID: idea_01

## Summary
Do a focused pass over residual-free agnostic boosting literature to find an algorithm that starts from a fixed correlation/advantage oracle and performs only label-to-label calls, then instantiate its assumptions exactly for improper learners. Translate each requirement into the problem’s parameters (query format, runtime, sample, distribution shift) and identify the smallest additional assumption needed.

## Why Promising
If such a theorem already exists, this could close the implication directly without inventing new machinery.

## Risks
May fail if no known theorem fits the exact oracle model (only returns binary labels with fixed error), or if constants in that theorem still depend exponentially on inverse-margin/accuracy proxies.

## Suggested Lenses
- literature-forensics
- oracle semantics audit
- algorithmic complexity audit
