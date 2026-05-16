# CSP Approximation-Gap Instance

ID: idea_01

## Summary
Try to instantiate the solver's approximation-gap template using assignment-induced concept classes from Max-CSP or related constraint systems. An explorer should write the exact learning reduction: examples are succinct constraint descriptions, concepts are assignments, labels are constraint truth values or noisy planted assignment values. Check whether an SDP/LP or other approximation algorithm gives err <= a OPT + xi, and whether OPT+epsilon improper prediction would imply a known hard task under a succinct-domain distribution.

## Why Promising
This directly targets the new iteration-6 conditional route. CSPs are one of the few places where efficient constant approximations and hardness of near-optimal approximation coexist, so they are a natural source of a weak-but-not-strong separation candidate.

## Risks
Standard Max-CSP hardness is usually proper or optimization hardness, not improper prediction hardness. If the example domain is polynomial, table learning kills the separation. Many approximation guarantees are additive in satisfaction rather than multiplicative in OPT, so the solver algebra may not apply without extra work.

## Suggested Lenses
- conditional separation
- improper hardness audit
- constant-factor approximation
