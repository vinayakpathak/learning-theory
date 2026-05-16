## Summary

The explorer’s core LP/minimax claim survives as a local one-step obstruction. In a finite public partition, if the only allowed residual operations are public reweighting and cellwise sign flips of the observed label, the achievable comparator error is exactly controlled by the cell posteriors. Positive excess of `g` over `c` does not force any low-posterior cell.

This should not be promoted beyond that model. It is not an atlas lower bound, not a weak-oracle barrier, and not a refutation of residual-free boosting.

## Issue List

1. **Missing assumption:** the public partition must contain all observables used by the filter/relabeling rule, especially `Y` and `g(X)`. Otherwise `a_i` need not be an indicator, and arbitrary public label rules may require more posterior data than just `eta_i`.

2. **Plausible but incomplete:** the finite-cell lemma should be stated with positive-mass cells only:
   $$
   \min_{i:p_i>0}\min\{\eta_i,1-\eta_i\}.
   $$
   Zero-mass cells and tiny cells do not affect the mathematical value, but tiny cells matter for polynomial sampling.

3. **Missing assumption:** translating “comparator error below `gamma`” into “weak oracle is forced to be informative” requires a singleton or no-other-witness condition, or at least `OPT_C` being witnessed by the same comparator `c`. In a rich class, `OPT_C` can be low for public-witness reasons unrelated to `c`.

4. **Plausible but incomplete:** the flat-posterior counterexample is feasible, but the report should explicitly realize it with deterministic `c,g` over a finite domain. Otherwise a reader may worry that the table is only a posterior abstraction.

5. **Worth pursuing:** the finite LP has a clean sigma-field version. If
   $$
   \eta_G=\Pr[c(X)\ne Y\mid G],
   $$
   then any `G`-measurable filter `W` and sign flip `S` has comparator error
   $$
   \frac{E[W(\eta_G1_{S=1}+(1-\eta_G)1_{S=-1})]}{E[W]},
   $$
   hence cannot beat `ess inf min(eta_G,1-eta_G)`. This would subsume the finite-cell statement.

6. **Not a fatal gap, but a scope limit:** allowing label flips means a high-error cell `eta_i>1-gamma` can become low-error for the relabeled query. That may reveal `c`, but it is not automatically useful for original noisy-risk improvement unless the later algorithm keeps track of the flip structure.

## Counterexamples Or Stress Tests

The flat-posterior example is a valid stress test. For `gamma=0.1`, take four public cells indexed by `(Y,g)` with masses `0.35,0.35,0.15,0.15`, and set
$$
\Pr[c\ne Y\mid \text{cell}]=0.2
$$
in every cell. Then `err(c)=0.2`, while `err(g)=0.3`.

A concrete realization: split each public cell into two subregions, with 80% having `c=Y` and 20% having `c=-Y`, and make `g` fixed according to the cell label. With `C={c}`, every public filter/sign flip has comparator error at least `0.2`, so no query crosses `gamma=0.1`, despite positive excess.

This also stress-tests sign-specific refinements: even after conditioning on `(Y,g(X))`, all public posterior errors remain flat.

## Literature Or Known-Result Conflicts

No conflict with the current ledger. The result is essentially a sharper version of the public-posterior obstruction `C023` and the residual failures `F010/F011`.

It also does not conflict with da Cunha-style residual-free boosting: those methods do not rely on one-step public residual filters forcing `OPT_C<gamma`.

## What Survives The Critique

The minimax lemma survives under the stated finite public-cell model.

The flat-posterior obstruction survives and is useful: excess
$$
\operatorname{err}(g)-\operatorname{err}(c)>0
$$
only controls an average of `a_i-eta_i`; it does not force any `eta_i<gamma`.

The result is worth recording as a local obstruction to residual-forcing proofs, not as a global lower bound.

## Recommended Next Checks

Formalize the sigma-field version with `eta_G`.

Add the explicit finite-domain realization of the flat-posterior table.

State the no-other-witness/singleton-class condition needed to connect comparator posterior to `OPT_C`.

Test whether any stronger assumption, such as calibration, monotonicity, or transcript-created posterior variation, can force `ess inf eta_G < gamma`.