# Weighted Decoding Separation

ID: idea_03

## Summary
Develop the code/decoding separation template concretely. Let concepts be codewords over coordinate domain X. Seek a represented code family with efficient distribution-free weighted bounded-distance decoding below radius gamma, but hard approximate nearest-codeword or RCN recovery at radius eta>gamma. The explorer should check whether strong agnostic improper learning under a uniform or weighted distribution would imply solving the hard decoding problem.

## Why Promising
It matches the hard band exactly: weak learning is useful only below gamma, while strong agnostic learning must solve instances at eta>gamma. A successful instantiation would give the serious negative route the run has been missing.

## Risks
Weighted bounded-distance decoding may already be hard in the weak regime, or approximate nearest-codeword hardness may disappear for improper hypotheses. Public handles, list decoding, validation, or code structure could also give a strong learner.

## Suggested Lenses
- separation construction
- coding theory
- hardness reduction
