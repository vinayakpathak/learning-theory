# Observable Residual Forcing

ID: idea_01

## Summary
Try to prove or refute an observable residual-forcing lemma: if a current randomized predictor still has excess at least epsilon over some near-optimal comparator c, construct a samplable query distribution Q from observable samples and the current predictor such that c has error below gamma on Q. Test loss-gradient, rejection-sampling, and label-randomization constructions against the RCN threshold from iteration 2.

## Why Promising
This would bypass hidden clean-set enumeration and give a direct boosting route from fixed-slack weak calls to strong agnostic learning.

## Risks
The needed query may be impossible without already knowing a correlated predictor; the RCN agreement-filter calculation is a serious warning sign.

## Suggested Lenses
- proof strategy
- counterexample search
