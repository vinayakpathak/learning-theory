## Summary

The explorer’s agreement and mistake-filter calculations are correct under the intended symmetric RCN setup. They give a real obstruction to naive “condition on residual/loss” boosting: before the current predictor has enough correlation with `f`, agreement filtering still has comparator error above `gamma`, and mistake filtering is worse.

The main problem is that the proposed “restricted obstruction lemma” is too broad as written. A global correlation parameter `r = E[Zf]` does not by itself control every observable cell `(Y,Z)`. Sign-specific conditioning can create low-noise cells even when `r` is below the stated agreement threshold. The obstruction can likely survive, but only after adding symmetry/invariance or replacing the global `r` condition by an atomwise posterior condition.

## Issue List

1. **False claim as stated:** global `r` does not rule out low-error sign-specific observable queries.

   The formulas compute aggregate agreement/mistake errors. But a query rule may condition on one of the four cells `(Y,Z)=(+,+),(+,-),(-,+),(-,-)`. Those cell posteriors are not determined by `r` unless a sign-symmetry assumption is imposed.

2. **Missing assumption:** “balanced RCN” is not enough unless it includes joint sign symmetry of `(f,Z)`.

   One needs something like invariance under simultaneous sign flip, or a restriction that the query transformation is sign-equivariant and only uses agreement/disagreement, not the signs themselves.

3. **Plausible but incomplete:** the “mixtures cannot improve” argument is valid only after checking every atom available to the query rule.

   It should say: if every observable atom with non-negligible acceptance probability has Bayes error at least `gamma`, then no mixture of those atoms can get below `gamma`. Agreement/disagreement cells are too coarse unless sign symmetry is assumed.

4. **Missing assumption:** the predictor `Z` must be evaluated on a fresh example and independent of that example’s noise bit `N`.

   This is probably intended, but it should be explicit. If `Z` can depend on the queried label noise, the displayed RCN identities need not hold.

5. **Plausible but incomplete:** the obstruction only covers binary current predictors.

   Many boosting-style residual constructions use real-valued scores, margins, weights, or confidence. The same idea may extend by conditioning on `(Y,F(X))`, but that is a different lemma.

6. **Missing assumption:** smoothness and samplability need parameters.

   A rejection query with exponentially small acceptance is not algorithmically useful. Conversely, a claimed obstruction should quantify lower-bounded acceptance or density ratio.

7. **Worth pursuing:** the public-label low-OPT warning is important.

   Even if a query has `f` at error below `gamma`, the weak learner may legally return a public or local hypothesis that is useless on the target distribution. A positive residual-forcing lemma needs “target-mass usefulness,” not merely low `OPT`.

8. **Missing assumption:** orientation of `Z`.

   The mistake-filter statement explicitly assumes `r >= 0`, but the broader obstruction should also normalize by allowing validation to replace `Z` with `-Z` when useful.

## Counterexamples Or Stress Tests

**Sign-specific cell stress test.** Take `gamma=0.1`, `eta=0.25`, and `r=0.4`, so the agreement threshold is

$$
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
=
\frac{0.15}{0.30}
=
0.5.
$$

Thus `r` is below the explorer’s threshold.

Let `S=Zf`, with `f` balanced and joint masses

$$
P(f=1,S=1)=0.5,\quad
P(f=1,S=-1)=0,
$$

$$
P(f=-1,S=1)=0.2,\quad
P(f=-1,S=-1)=0.3.
$$

Then `E[S]=0.4`, so `E[Zf]=0.4`. But on the observable event

$$
Y=Z=-1,
$$

the only positive-mass possibility is `f=-1`, `S=1`, `N=1`. Hence conditioning on this cell and labeling by `Y` gives comparator error `0 < gamma`. The cell has mass `0.2(1-eta)=0.15`, so this is not a rare-event artifact.

This does not rescue residual forcing, because the query is local/public-label-like and may be target-mass-useless. But it breaks the literal “no one-sample observable transformation” claim.

Other stress tests:

- If `Z` is strongly anti-correlated with `f`, flipping `Z` may already solve the orientation problem.
- If acceptance can use `X`, RCN alone does not block feature-structural clean sets.
- If the current object is a score `F(X)` rather than a sign `Z`, the posterior cells are different.

## Literature Or Known-Result Conflicts

No direct conflict with the local literature map. The report is consistent with L007 and the recorded posterior-filtering obstruction.

But the obstruction should not be stated as a general barrier to agnostic boosting. The working notes already record da Cunha-style residual-free boosting as a near miss using richer enumeration/transcript mechanisms. The explorer’s argument only targets one-sample observable residual filters, not clean-witness generation, transcript enumeration, or class-specific structure.

## What Survives The Critique

The following pieces look solid:

- The agreement-filter formula.
- The mistake-filter formula for `r >= 0`.
- The concrete numerical example `gamma=0.1`, `eta=0.25`, `r=0.4`.
- The conclusion that naive loss-gradient or mistake-region filtering fails under RCN.
- The warning that low-OPT public-label and empirical queries may be useless.
- A corrected obstruction lemma under sign-symmetric RCN and sign-equivariant one-sample query rules.

## Recommended Next Checks

1. Formalize the observable sigma-field. Decide whether atoms are agreement/disagreement or the four signed cells `(Y,Z)`.

2. Either impose sign-flip symmetry/sign-equivariance, or replace the global `r` threshold by an atomwise posterior condition.

3. Test the lemma against the sign-specific counterexample above.

4. Add explicit acceptance-probability or density-ratio bounds.

5. Extend the calculation from binary `Z` to real-valued margin `F(X)`.

6. Separate two notions: “`f` has low query error” versus “every valid weak-oracle answer gives target-useful information.”