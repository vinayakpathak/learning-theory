# Failed Attempts

## F001: Naive Generic Agnostic Boosting From Fixed Additive Slack

- Iteration: 1
- Status: failed as a proof route
- Attempt: Treat the weak learner as an additive approximate linear optimizer
  over `C` and run a standard boosting/convex-optimization scheme.
- Failure: The oracle guarantee has additive loss `2 beta` in correlation.
  Once residual correlations are below this fixed scale, the oracle may return
  uninformative hypotheses. Strong agnostic learning needs to exploit
  advantages of order `epsilon`, with `epsilon` arbitrarily smaller than `beta`.
- Salvage: This gives a precise black-box obstruction and motivates searching
  for a residual-amplification or clean-witness lemma.

## F002: Hidden Block / Needle Lower Bound

- Iteration: 1
- Status: failed in simple form
- Attempt: Hide the useful signal in a block of mass about `epsilon`, so the
  weak oracle never sees constant advantage but strong learning must exploit the
  block.
- Failure: A block of mass `Theta(epsilon)` is visible with
  `poly(1/epsilon)` labeled samples, which the strong learner is allowed. If
  the block mass is `o(epsilon)`, missing it does not force more than
  `epsilon` excess error.
- Salvage: Any hidden-signal lower bound must be computational/SQ-like or
  stable under sample access, not merely statistically hidden by small mass.

## F003: Public-Handle Planted Signal Templates

- Iteration: 1
- Status: risky / not a valid separation template yet
- Attempt: Give the weak learner a way to succeed on high-advantage cases via
  public handles while making small-advantage strong learning hard.
- Failure: Public handles often also let an improper strong learner search,
  aggregate, or validate candidate hypotheses from samples.
- Salvage: A successful construction must explain why handles suffice for all
  fixed-`beta` weak requirements but still do not enable `OPT + epsilon`
  validation.

## F004: Finite Explicit Class Barrier

- Iteration: 1
- Status: failed as a negative setting
- Attempt: Use a finite concept class to exhibit weak-oracle flatness.
- Failure: If the class is small or explicitly enumerable, standard
  ERM/validation agnostically learns over it from labeled samples; the weak
  oracle can be ignored.
- Salvage: Finite games may still be useful for convex-analytic intuition, but
  not as PAC separations without representation-size hardness.
