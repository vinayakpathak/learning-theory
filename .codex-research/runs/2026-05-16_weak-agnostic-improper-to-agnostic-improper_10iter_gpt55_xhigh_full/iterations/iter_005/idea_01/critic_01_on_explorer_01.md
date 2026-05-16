## Summary

The explorer’s core finite-cell claim survives: in a one-step public partition model, public filtering and sign relabeling can only exploit cellwise posterior variation in whether `c(X)=Y`. Positive excess of `g` over `c` alone does not force any cell with comparator error below `gamma`.

I found no fatal gap for the stated finite-model obstruction. The main danger is overpromotion: this is not a weak-oracle lower bound, not an atlas separation, and not a statement about `OPT_C` unless extra assumptions exclude public or other-concept witnesses.

## Issue List

- **Missing assumption:** cells with `p_i=0` should be excluded or handled. The formula  
  $$
  \min_i \frac{\min\{u_i,v_i\}}{p_i}
  $$
  is over positive-mass cells only.

- **Plausible but incomplete:** the report tracks comparator error for a fixed `c`, not `OPT_C`. A weak learner is triggered by low `OPT_C`; public constants, artificial relabelings, complements, or other concepts may give low `OPT_C` even when `c` has error at least `gamma`.

- **Missing assumption:** to make the counterexample a learning-theoretic distribution, the report should give an atom-level construction with deterministic `c(X)` and `g(X)`. This is easy in the arbitrary agnostic model, but should be explicit.

- **Fatal gap if overclaimed:** the obstruction does not apply to richer transcripts that already create posterior variation, repeated-coordinate denoising, class-structured recovery, or multi-step algorithms. It only blocks one-step public residual forcing from excess alone.

- **Plausible but incomplete:** if future versions impose minimum mass or smoothness on queries, the exact “minimum over cells” formula changes. The constant-posterior counterexample still survives, but the theorem statement should separate the exact optimum from the obstruction.

- **Unsupported citation:** none. The report is self-contained and cites only local run memory.

## Counterexamples Or Stress Tests

The explorer’s constant-posterior witness is the main stress test and appears valid in arbitrary agnostic distributions:

Take sign-specific public cells induced by `(Y,g(X))`, choose masses so `Pr[g(X) != Y]=m`, and inside every cell set  
$$
Pr[c(X) != Y \mid G=i]=\eta
$$
with `gamma < eta < m <= 1/2`. Then `err(c)=eta`, `err(g)=m`, but every public filter/relabeling has comparator error at least `eta`.

Stress test against overreach: under RCN or other structured-noise models, conditioning on `(Y,g(X))` need not preserve constant posterior noise. If `g` is correlated with `c`, sign-specific cells can have much lower posterior error. So this witness should not be presented as an RCN obstruction.

Stress test against `OPT_C`: if constants or public hypotheses lie in `C`, a relabeled public cell may have `OPT_C=0` for reasons unrelated to `c`. The report notes this, but any ledger entry should keep it prominent.

## Literature Or Known-Result Conflicts

No conflict with the existing run ledger. The result strengthens the public-posterior obstruction `C023/L019` by adding that positive excess is compatible with the no-low-public-cell condition.

It is also consistent with `F010/O010`: excess over a comparator does not force mistake or high-loss residuals to be clean.

No conflict with da Cunha-style residual-free boosting: this critique only rules out a one-step public residual lemma, not clean-transcript generation or residual-free statistical boosting.

## What Survives The Critique

The exact finite-cell optimum survives, after excluding zero-mass cells.

The negative conclusion survives: positive excess alone cannot force a weak-callable low-comparator-error public residual.

The result is worth recording as a focused obstruction to residual-forcing proof attempts, not as progress toward a full separation.

## Recommended Next Checks

1. Write an explicit finite atom construction realizing the numeric witness with deterministic `c` and `g`.

2. Restate the lemma in sigma-field form:
   $$
   \inf_G \min\{\Pr[c\ne Y\mid G],\Pr[c=Y\mid G]\}
   $$
   as the one-step public filtering/relabeling optimum.

3. Add an `OPT_C` caveat: comparator-noise lower bounds imply weak-oracle silence only under no-other-witness assumptions.

4. Test the same LP under extra assumptions: RCN, calibrated `g`, minimum query mass, smoothness, and multi-step transcript updates.