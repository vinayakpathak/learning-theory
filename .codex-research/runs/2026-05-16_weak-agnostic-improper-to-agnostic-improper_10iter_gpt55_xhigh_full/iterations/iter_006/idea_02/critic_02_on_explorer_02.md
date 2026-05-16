## Summary

The main algebraic claim survives: for a fixed public sigma-field and public randomized relabeling kernels, the comparator error is lower-bounded by the weighted public posterior uncertainty. This does break the one-step proof principle “positive excess over `c` forces a public residual query where `c` is below the weak threshold.”

The critique is scope. The explorer proves a comparator-error obstruction, not a general `OPT_C` obstruction, and only for kernels measurable with respect to a chosen public view that does not already reveal information about `c(X)`. It should not be promoted to a general sample-dependent or atlas-level lower bound.

## Issue List

- **Plausible but incomplete:** The `w_+, w_-` lower bound is correct under the population kernel model:
  $$
  \frac{E[w_+(1-p)+w_-p]}{E[w_++w_-]}
  \ge
  \frac{E[(w_++w_-)u]}{E[w_++w_-]}.
  $$
  But the model needs to be stated with a sigma-field `G`, positive denominator, finite weights, and fresh sampling from the induced population query.

- **Missing assumption / fatal for broad generality:** If the “public observation” includes full `X` and `c` is a fixed deterministic concept, then `Pr[c(X)=+1 | X]` is `0` or `1`, so `u=0`. The posterior obstruction only works for a coarsened public view, or for a Bayesian/random-target model where `c` remains hidden conditional on `X`.

- **Missing assumption:** The result controls the planted comparator’s query error. It does not imply `OPT_C >= gamma` unless `C={c}` or a no-other-witness condition rules out public constants, public anchors, empirical memorization, or other concepts fitting the relabeled query.

- **Fatal gap for unrestricted sample-dependent schemes:** Point-mass or empirical-support queries can have realized low `OPT_C`, sometimes even for the planted comparator, while carrying negligible target mass. The explorer notes this, but any statement about “all public randomized schemes” must exclude or route these.

- **Plausible but incomplete:** The flat-posterior construction is one-step and relative to `(Y,g)` or another fixed public transcript. It does not rule out algorithms that first create posterior variation by denoising repeated coordinates, exploiting class structure, or receiving informative weak-oracle outputs.

- **Worth pursuing:** The report cleanly generalizes the earlier sign-flip lemma. The right invariant for arbitrary absolute relabeling is `u(Z)=min{Pr[c=+1|Z],Pr[c=-1|Z]}`, not just `Pr[c != Y | Z]`.

## Counterexamples Or Stress Tests

- Full-information stress test: let the kernel depend on raw `X`. In a deterministic-concept PAC model, `c(X)` is mathematically determined by `X`, so the posterior formalism no longer certifies uncertainty. This forces either a restricted query grammar or a random-target/information-budget model.

- Public-witness stress test: if constants or the current public predictor lie in `C`, relabeling by that witness can make `OPT_C=0` while teaching nothing about the hidden comparator.

- Spike-query stress test: on observed samples, empirical labels can produce low-`OPT` queries unrelated to population progress. Smoothness, minimum-mass, or target-mass requirements are needed.

- High-noise sign-flip stress test: any version using only `Pr[c != Y | G] >= gamma` is false when that posterior is near `1`; flipping labels can make `c` low-error. The explorer avoids this by using `u`, and that should be preserved.

## Literature Or Known-Result Conflicts

No direct conflict with the run ledger. The report is consistent with `C023`, `C028`, `L024`, `L025`, and `D011`, and is best viewed as their arbitrary-randomized-relabeling extension.

It also does not contradict the da Cunha-style near miss, because that route is not a one-step public residual forcing argument; it relies on hidden clean tuple generation, capacity assumptions, and final vote selection.

No external literature claim is established here. This should remain an in-run sigma-field lemma unless later tied to a formal SQ/oracle/stopped-process theorem.

## What Survives The Critique

The public-kernel lower bound is sound in its stated population model.

The flat-posterior example is a valid counterexample to “excess alone gives a public below-`gamma` comparator-witness residual query.”

The strongest surviving statement is:

> For a fixed public sigma-field `G`, if `min{Pr[c=+1|G], Pr[c=-1|G]} >= gamma` almost surely, then no `G`-measurable randomized relabel/filter query can make `c` have error below `gamma`.

## Recommended Next Checks

Formalize the lemma with `G`, kernel normalization, essential infimum, and fresh-query sampling.

Add a separate no-other-witness assumption if the conclusion is meant to be about `OPT_C`, not just the planted comparator.

Build a stopped-process version: charge the first time the transcript creates a public cell or smooth filter with posterior uncertainty below `gamma`.

Keep spike, public-witness, and other-concept low-`OPT` queries in a routing taxonomy instead of folding them into the obstruction.