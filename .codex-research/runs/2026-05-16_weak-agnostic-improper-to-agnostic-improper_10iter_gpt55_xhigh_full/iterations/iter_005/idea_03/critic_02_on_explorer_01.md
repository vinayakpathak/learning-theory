## Summary

The explorer’s main negative conclusion is sound under the stated **public-posterior / no-target-information** interpretation: convex duality can optimize over public filters, but it cannot manufacture a low-`OPT` or low-comparator-error chunk unless the public transcript already contains a low-error posterior cell.

The report should not be promoted as an unconditional refutation of all hard-core/dense-model routes. It refutes the route only when “public filter” means measurable with respect to a transcript that has not already learned where the comparator is reliable.

## Issue List

1. **Missing assumption:** The sigma-field model must be explicit.  
   The statement  
   \[
   \Pr[c(X)\ne Y\mid G]=\eta
   \]
   is meaningful as a “public posterior” only if `c` or the target is treated as hidden/random relative to `G`. In an ordinary fixed-distribution measure space, if `G` includes enough of `X` and `c` is a fixed function, then `c(X)` is mathematically determined by `X`. So the obstruction needs a hidden-target/transcript model, not just standard conditioning.

2. **Plausible but incomplete:** The CVaR duality covers a fixed relabeling.  
   The formula
   \[
   \min_{0\le W\le L,\ \mathbb EW=\alpha}\mathbb E[Wm]
   =
   \sup_\tau\{\tau\alpha-L\mathbb E[(\tau-m)_+]\}
   \]
   looks correct, but the report should state feasibility conditions such as `0 < alpha <= L` and clarify how the argument extends over a family of public relabelings. For finitely or measurably many relabelings, one minimizes the corresponding lower-tail value over the family.

3. **Missing assumption:** “Current classifier has error near `1/2`” is not enough.  
   The RCN counterexample works when the public transcript has constant posterior noise `eta`. But a classifier with global error near `1/2` can still create sign-specific cells with low target posterior error, as already recorded in O011/C018. The obstruction is posterior-cell uniformity, not poor global performance.

4. **Plausible but incomplete:** Low comparator-error chunk is stronger than low `OPT_C` chunk.  
   The explorer defines a useful chunk by requiring the near-optimal comparator `c` to have error below `gamma`. This is sufficient for `OPT_C < gamma`, but not equivalent. Public constants, artificial relabelings, or other concepts can make `OPT_C` low for useless reasons. The report should explicitly say it is targeting **hidden-comparator-useful** low-`OPT` chunks.

5. **Worth pursuing:** The duality lemma is a good diagnostic.  
   It cleanly says that public filtering can only exploit the lower tail of
   \[
   m=\mathbb E[1[c\ne Y']\mid G].
   \]
   Future positive attempts must prove that this lower tail drops below `gamma`; excess error alone will not do that.

6. **Unsupported citation:** External hard-core/boosting citations are background only.  
   The report does not rely on exact theorem statements from Impagliazzo, Barak-Hardt-Kale, Feldman, or KMV. If this becomes a working-note lemma, cite the LP duality as self-contained and keep the literature references as motivation unless theorem numbers and hypotheses are audited.

## Counterexamples Or Stress Tests

The clean stress test is:

\[
Y=c(X)N_\eta,\qquad \gamma<\eta<1/2,
\]

with a public transcript `G` satisfying

\[
\Pr[c(X)\ne Y\mid G]=\eta
\]

almost surely. For any `G`-measurable filter `W` and sign relabeling `Y'=SY`,

\[
\Pr_W[c\ne Y']
=
\frac{\mathbb E[W(\eta 1_{S=1}+(1-\eta)1_{S=-1})]}{\mathbb E W}
\ge \eta>\gamma.
\]

Meanwhile, if `c(X)` is balanced and `g` is a constant or independent predictor, then

\[
\operatorname{err}(g)=1/2,\qquad \operatorname{err}(c)=\eta,
\]

so `g` has excess `1/2-eta`. Thus positive excess does not force any public low-noise chunk.

Stress test against overclaiming: allow `G` to contain sign-specific cells from a target-correlated `g`. Then global error or global correlation may look bad while some cell has low comparator error. The no-go must be stated in terms of the full lower tail of the public posterior `m`, not a global statistic.

## Literature Or Known-Result Conflicts

No direct conflict with the local literature map. The explorer’s conclusion is consistent with the existing run notes: C023, F010/F011, O011, and D011 already warn that residual forcing fails unless public posterior structure is available.

The only caution is rhetorical: classical hard-core/boosting duality is not contradicted. Those results start from a weak advantage condition over relevant distributions. Here the missing step is precisely showing that the fixed-slack learner is activated, i.e. that some query has `OPT_C < gamma`.

## What Survives The Critique

The CVaR/public-filter dual lemma survives as a useful formal tool.

The RCN hard-band example survives as a restricted obstruction once the public-posterior assumption is made explicit.

The main conclusion survives in restricted form:

> Excess over a near-optimal comparator does not, by itself, imply the existence of a public filter/relabeling whose comparator error is below the weak threshold.

What does not survive is any unconditional claim that all hard-core or dense-model routes are impossible.

## Recommended Next Checks

1. Formalize the model: hidden target/random comparator, transcript `T`, public sigma-field `G`, allowed filters, allowed relabelings, and whether weak-oracle outputs are included.

2. Record the CVaR lemma with exact feasibility assumptions and an extension to multiple relabelings.

3. Convert the RCN stress test into a precise toy theorem: constant public posterior noise implies no public filter crosses below `gamma`.

4. Add a caution that global error/correlation of `g` is insufficient; the right object is the lower tail of the public posterior error.

5. Keep public-witness low-`OPT` queries separate from hidden-comparator-useful queries, since the former can trigger the weak learner without helping the booster.