## Summary

The explorer’s core negative point is sound as a **restricted one-step public-posterior diagnostic**: positive excess over a comparator does not by itself force a public residual filter/relabeling to expose a below-`gamma` comparator-clean query.

But the report overstates the scope if read as a “general residual low-`OPT`” no-go. The argument controls the error of one fixed comparator `c`, not `OPT_C`; it also needs a precise public sigma-field model. In particular, if `G` includes the full instance `X` and `c` is fixed deterministic, the conditional posterior `Pr[c(X) != Z | G]` degenerates to an indicator, so the flat-posterior argument no longer has the stated form.

## Issue List

1. **Missing assumption / near-fatal for “most general scheme”: public sigma-field is ambiguous.**  
   The explorer says `G` contains “observable example coordinates.” If this means full `X`, then for fixed deterministic `c`, `c(X)` is mathematically `G`-measurable, so
   \[
   \Pr[c(X)\ne Z\mid G]=1_{\{c(X)\ne Z\}}.
   \]
   The posterior-envelope statement becomes tautological and does not imply a flat lower bound. To repair this, either restrict `G` to a coarse public feature partition, or move to a random-target/Bayesian lower-bound model where `c(X)` is not revealed by conditioning on `X`.

2. **Fatal gap for “low-OPT” wording: comparator error is not `OPT_C`.**  
   The envelope proves that `c` is not a below-`gamma` witness. It does not prove `OPT_C(Q) >= gamma`. A query may have low `OPT_C` because of a public constant, public anchor, empirical spike, artificial relabeling, or another concept in `C`. The explorer notices this, but the main summary still says “general residual low-`OPT` lemma” too broadly.

3. **Missing assumption: allowed labels.**  
   The `min{eta_G,1-eta_G}` specialization covers arbitrary binary public labels only when `Y` is included in `G`, since then any `Z` can be written as `S(G)Y`. Otherwise one must use the more general quantity
   \[
   \Pr[c(X)\ne Z\mid G]
   \]
   for each allowed label kernel.

4. **Plausible but incomplete: mass-constrained CVaR claim.**  
   The lower-tail/CVaR statement is likely right, but the report does not state the exact optimization problem: ratio objective versus equality `E W = alpha`, constraint `E W >= alpha`, atom handling, and whether `0 <= W <= 1` or `0 <= W <= L`. This should be formalized using existing L026-style notation.

5. **Missing assumption: population query and sampling access.**  
   The weak PAC source applies to fresh iid samples from a realized query distribution. The report should explicitly require that after the transcript, `W,Z` define a fixed population kernel and that `E W` is inverse-polynomial or otherwise sampleable. Empirical reuse or tiny rejection regions are outside the guarantee.

6. **Plausible but incomplete: descent is not addressed.**  
   Even if a public residual query has `OPT_C < gamma`, a fixed-slack improper oracle may return any legal hypothesis. A positive residual booster needs a condition that every legal answer gives descent, or a validation/list mechanism. Low `OPT` alone is not enough.

## Counterexamples Or Stress Tests

- **Full-`X` stress test:** if the residual scheme may use arbitrary functions of `X`, a coarse flat posterior over `(Y,g(X))` is insufficient. Hidden clean/noisy substructure may be encoded in finer public features. The flat construction only blocks filters measurable with respect to the coarse public cells.

- **Public-witness low-`OPT`:** if constants are in `C`, querying labels `Z=+1` has `OPT_C=0` for public reasons. The weak learner can return the constant, giving no information about the hidden comparator. This separates “low comparator noise” from “low `OPT_C`.”

- **Oracle-output stress:** previous weak hypotheses may encode target information. If they are in the transcript and evaluable on `X`, they can create posterior variation. The obstruction applies only before such variation exists or after charging it.

## Literature Or Known-Result Conflicts

No direct external literature conflict is visible from the local notes. The report is consistent with existing in-run items C023, C028, L024, L025, F022, and F024.

It should not be presented as conflicting with da Cunha-style residual-free boosting, because that route uses hidden clean transcript generation and vote selection, not merely one-step public filtering from excess.

## What Survives The Critique

- The conditional-expectation envelope is correct once the public sigma-field and query kernel are fixed.
- The sign-relabeling formula is correct in the `Y in G` model.
- The flat-posterior construction is a valid counterexample to “positive excess alone forces a public low-noise residual for `c`.”
- The result is worth keeping as a local obstruction, not as an atlas separation or a full low-`OPT` no-go.

## Recommended Next Checks

1. Formalize the model with `T`, fresh `(X,Y)`, public randomness `R`, a public feature sigma-field `G_T`, and `G_T`-measurable `W,Z`.

2. Decide whether the theorem is fixed-comparator/coarse-feature or random-target/Bayesian. Do not mix “fixed `c`” with `G` containing full `X`.

3. State the flat-posterior counterexample parametrically with `C={c}` or an explicit no-other-witness assumption.

4. Add a low-`OPT` routing lemma separating hidden-comparator witnesses from public constants, anchors, spikes, and other concepts.

5. Formalize the mass-constrained lower-tail/CVaR variant with exact constraints and sampling cost.