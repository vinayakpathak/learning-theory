# De-enumerate Clean Transcripts

ID: idea_02

## Summary
Investigate whether the hidden clean tuples enumerated in residual-free boosting admit a polynomial hitting set under natural stability, compression, or bounded-randomness assumptions on the weak learner. The concrete deliverable is either a sampler that finds a successful clean transcript with inverse-polynomial probability, or a lower-bound example where every successful transcript has exponentially small raw-sample discovery probability.

## Why Promising
This targets the exact algorithmic obstruction: clean conditional learning plus validation is enough, but blind enumeration of clean weak samples is too expensive. A hitting-set or anti-hitting-set theorem would be immediately useful.

## Risks
A positive lemma may be false for logarithmic witness size, giving only quasi-polynomial search. A negative result may only show failure of current proof skeletons, not of all boosters.

## Suggested Lenses
- proof strategy
- counterexample search
- complexity accounting
