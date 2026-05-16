## Summary

The explorer’s aggregate RCN calculations are correct and useful, especially for agreement/mistake filtering. But the strongest stated obstruction is too broad. The claim that no one-sample observable transformation depending on `(Y,Z)` can force `f` below noise `gamma` is false without additional symmetry or “target-usefulness” assumptions.

The main repair is to downgrade the result to: aggregate agreement/mistake residual filters fail below the RCN threshold. A full observable-transformation obstruction must analyze the four cells `(Y,Z)`, not only the two coarse events `Y=Z` and `Y!=Z`.

## Issue List

- **False claim as stated:** The “restricted obstruction lemma” does not follow from the agreement/mistake formulas. A weighted average posterior error above `gamma` on the agreement event does not imply every observable subcell `(Y=y,Z=z)` has posterior error above `gamma`.

- **Missing assumption:** The formulas require the current predictor `Z` to be evaluated independently of the fresh label noise `N`, conditional on `X` and training history. This is natural for a classifier, but should be stated.

- **Missing assumption:** The “uncorrelated special case” needs balanced/symmetric RCN assumptions. `r=E[Zf]=0` alone does not generally imply that observable filters preserve the noise rate.

- **Plausible but incomplete:** The agreement-filter threshold
  $$
  r > \frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
  $$
  is a valid obstruction for the specific filter `Y=Z`, but not for all observable rejection or relabeling rules.

- **Plausible but incomplete:** “Low-OPT but target-mass-useless” is the right warning, but it needs a formal criterion. Otherwise public-label queries and empirical queries are mixed together with genuinely useful hidden-comparator queries.

- **Worth pursuing:** The RCN testbed remains a strong stress test for residual-forcing lemmas. It just needs a corrected scope.

## Counterexamples Or Stress Tests

Take `eta=1/4`, `gamma=0.1`, and define a balanced joint distribution of `(f,Z)` by

$$
P(Z=+,f=+)=0.2,\quad
P(Z=+,f=-)=0,\quad
P(Z=-,f=+)=0.3,\quad
P(Z=-,f=-)=0.5.
$$

Then `E[Zf]=r=0.4`. The explorer’s agreement threshold is

$$
\frac{0.25-0.1}{0.25+0.1-2(0.25)(0.1)}=0.5,
$$

so `r` is below threshold. The aggregate agreement filter still has noise `0.125 > gamma`, as claimed.

But the observable cell `Y=Z=+` has constant probability `0.2 * 0.75 = 0.15`, and on this cell `f=+` always. Querying this accepted distribution with label `+` gives

$$
\operatorname{err}_Q(f)=0<\gamma.
$$

So the broad “no observable one-sample transformation” claim is false. This query is probably public-witness/target-useless, since the public predictor `Z` or the constant `+` also explains it. But that is a different obstruction and must be stated explicitly.

## Literature Or Known-Result Conflicts

No direct literature conflict is forced by the explorer report. The corrected version is consistent with the local notes: L007 already warns that agreement filtering only works after enough correlation, and O003/O004 warn that point-mass, empirical, and public-label low-OPT queries are not necessarily useful.

The overbroad version would risk conflicting with residual-free boosting routes, because those may use richer transcript or witness mechanisms rather than coarse observable residual filters.

## What Survives The Critique

The algebra for excess under RCN survives.

The agreement-filter and mistake-filter calculations survive.

The concrete example `gamma=0.1`, `eta=0.25`, `r=0.4` correctly shows that large excess can remain while coarse residual filters fail to produce a low-noise query.

The idea is still valuable as an obstruction to naive residual forcing, especially “focus on mistakes” and “condition on agreement” strategies.

## Recommended Next Checks

1. Formalize the exact one-sample observable model: acceptance probabilities and pseudo-labels as functions of the four cells `(Y,Z)`.

2. Replace the aggregate proof with a four-cell posterior calculation. The obstruction is valid only if every accepted cell has best posterior error at least `gamma`.

3. Add either a symmetry assumption, such as `Zf` independent of the sign of `Z`, or weaken the theorem to agreement/mistake filters only.

4. Define “target-mass-useful” low-OPT queries so public-label cells like `Y=Z=+` are excluded for the right reason.

5. Keep the RCN threshold as a required sanity check for any positive residual-forcing lemma.