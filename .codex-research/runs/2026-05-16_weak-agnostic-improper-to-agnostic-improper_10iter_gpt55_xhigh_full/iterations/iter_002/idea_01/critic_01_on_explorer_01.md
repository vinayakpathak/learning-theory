## Summary

The explorer’s main negative message is directionally sound: naive residual forcing from excess alone is not enough to produce a query with `err_Q(c) < gamma`. The high-loss and mistake-set filters really do fail by a four-cell obstruction, and the RCN agreement-filter calculation is a useful cold-start warning.

However, several claims are stronger than what is proved. The report gives convincing stress tests for natural residual queries, not a general no-go theorem for all observable query constructions. The “observable relabeling requires posterior concentration” lemma is currently more a tautological template than a formal result, and the RCN obstruction needs symmetry / homogeneity assumptions if it is meant to rule out all `(Y,Z)`-based buckets.

## Issue List

1. **Plausible but incomplete: broad residual-forcing lemma “looks false.”**  
   The explorer breaks loss-weighting, mistake-set filtering, and agreement filtering. That does not refute every observable construction using `X`, nonblack-box structure of `A`, class structure, empirical subroutines, or candidate-list generation. This should be recorded as an obstruction to natural black-box residual queries, not a theorem against residual forcing.

2. **Worth pursuing: high-loss residual formula is correct, but has a partial positive regime.**  
   For `Q proportional to ell D`,
   $$
   err_Q(c)=\frac{\mathbb E[1_{Y\ne c}\ell]}{\eta+\Delta}.
   $$
   Since the numerator is at most `eta`, this gives `err_Q(c) <= eta/(eta+Delta)`. Thus high-loss weighting can force low noise when the current excess is very large relative to `eta`. It fails in the hard band, but the report should state this nuance.

3. **Missing assumption: “observable relabeling requires posterior concentration.”**  
   This needs a precise probability space and sigma-field. Is `O` allowed to contain `X`? labels? previous weak hypotheses as functions? class-specific features? A relabeling kernel can make `c` low-error either by selecting low-noise original-label regions or by outputting a public label correlated with `c`. The latter is not captured by “posterior Bayes error of `c` below `gamma`” unless that phrase is formalized carefully.

4. **Missing assumption / possible false reading: RCN `r=0` does not rule out all `(Y,Z)` buckets.**  
   The agreement event calculation is correct:
   $$
   \Pr[Y\ne f\mid Y=Z]
   =
   \frac{\eta(1-r)}{1+r(1-2\eta)}.
   $$
   But if the report means every finer cell determined by `(Y,Z)` has noise at least `gamma`, `r=0` alone is insufficient. One can have zero global correlation by mixing perfectly correlated and anti-correlated regions; some label-value cells may then be low-noise. A clean obstruction needs label symmetry / balanced target / homogeneous independence assumptions.

5. **Plausible but incomplete: descent lemma warning.**  
   The explorer correctly separates “make `err_Q(c)<gamma`” from “use weak output to improve original risk.” But the critique should sharpen this: even if `err_Q(c)<gamma`, the weak output is only guaranteed better than random against query labels. It need not be close to `c`, and it may encode a public label or current predictor unless the query/potential is designed to convert query correlation into original-risk descent.

6. **Unsupported citation: none directly.**  
   The report uses no external citations. Its claims rest on local algebra and toy examples, so the issue is not citation support but theorem scope.

## Counterexamples Or Stress Tests

Four-cell deterministic stress test for mistake/high-loss filtering:

Let masses be split by whether `c` is correct and whether current `g` is correct.

- `a = Pr[c correct, g wrong]`
- `b = Pr[c wrong, g correct]`
- `d = Pr[c wrong, g wrong]`

Then
$$
err(g)-err(c)=a-b.
$$
So `g` has positive excess whenever `a>b`. But on the mistake set `M={g\ne Y}`,
$$
err_{D|M}(c)=\frac{d}{a+d},
$$
which can be arbitrarily close to `1` by taking `d` large while keeping `a>b`. Thus excess alone cannot force `err_{D|M}(c)<gamma`.

Stress test for the RCN bucket claim:

Take a mixture where on half the domain `Z=f` and on half `Z=-f`, so `E[Zf]=0`. Depending on label/value imbalance, a finer observable cell such as `(Y=Z=1)` can be much cleaner than the aggregate agreement event. The explorer’s aggregate formula survives, but any stronger “no `(Y,Z)` cell is low-noise” claim needs symmetry assumptions.

## Literature Or Known-Result Conflicts

No direct conflict with the working notes. The report is consistent with L007 and the already-recorded warning that filtering only helps after correlation is present.

The main risk is overclaiming relative to the atlas edge. Known residual-free boosting near misses show that constant-slack weak access can sometimes be semantically enough, with the obstruction being computational enumeration. So this critique should not be phrased as “residual forcing is impossible,” only as “simple observable residual filters do not solve the fixed-slack bottleneck.”

## What Survives The Critique

The loss-weight and mistake-set failures are valid and useful.

The RCN agreement-filter threshold is algebraically correct and should remain a central cold-start sanity check.

The separation between forcing and descent is important: future positive arguments must prove both low-noise query construction and original-risk improvement.

A restricted no-go theorem based on transcript-measurable filters and posterior lower bounds is worth formalizing.

## Recommended Next Checks

1. Formalize the “observable sigma-field” lemma with exact allowed inputs: `X`, `Y`, current hypotheses, confidence values, weak-oracle transcripts, and public randomness.

2. Prove the four-cell obstruction as a clean lemma for deterministic and randomized predictors.

3. Strengthen the RCN obstruction under explicit symmetry assumptions, e.g. balanced `f`, `Z` independent of `f` conditional only through global correlation, or exchangeable hidden target.

4. Separately test whether any residual query with negative/centered weights can yield descent without requiring `err_Q(c)<gamma`; the current critique only covers positive distribution queries.