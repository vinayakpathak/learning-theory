# Exact oracle-compatibility theorem matrix for fixed-slack boosting papers

ID: idea_01

## Summary
Complete a theorem-by-theorem compatibility matrix for fixed-slack-agnostic-to-weak-boosting in KMV08, Feldman, and potential-based boosters, using exact atlas conventions (binary labels, target risk form, runtime in n,1/\u03b5,\u03b4). Produce for each candidate theorem the precise weak condition required, what the wrapper can certify from $\mathrm{err}\le\mathrm{OPT}+\beta$, and whether the final guarantee is $\mathrm{OPT}+\epsilon$, $\mathrm{OPT}+\alpha+\epsilon$, or has hidden floor terms.

## Why Promising
The main blocker is currently a semantic mismatch. A precise matrix can decisively close positive or negative transfer claims and may reveal a single overlooked theorem that already settles the edge.

## Risks
Could be non-matching because many papers use examples of confidence/advantage weak learners or require tunable weak edge; if no theorem exactly matches fixed-$\beta$ risk, this route stalls.

## Suggested Lenses
- proof strategy
- source audit
- oracle-translation
