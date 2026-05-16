# Parity Near-Separation Audit

ID: idea_01

## Summary
Formalize the parity/LPN near-separation for gamma = Theta(1/n): prove the span-capture weak learner with exact constants, sample size, validation step, and then prove that a strong improper agnostic learner under uniform RCN would break LPN via Goldreich-Levin-style recovery from an arbitrary evaluable predictor.

## Why Promising
This is the most concrete new object from iteration 8. Even if it only yields a parameterized warning note, it sharply clarifies the fixed-versus-shrinking slack boundary.

## Risks
It will not solve the fixed-constant beta edge unless the definition allows gamma to shrink with representation size. The span-capture lemma or LPN reduction may need tighter quantifiers than the solver sketch gives.

## Suggested Lenses
- proof audit
- definition check
- conditional separation
