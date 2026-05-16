## Summary

The explorer’s core algebra is sound: for a one-example, public, absolutely-continuous filter/relabel kernel, the error of a fixed comparator is lower-bounded by the public posterior uncertainty of that comparator. The flat-posterior example is a valid obstruction to any proof step saying “positive excess alone creates a useful low-noise residual.”

But the result is not yet a general `OPT_C` obstruction, and not a general barrier for residual algorithms. The two main gaps are: the “public sigma-field” must be formalized carefully, and comparator-error lower bounds do not imply `OPT_C` lower bounds without no-other-witness assumptions.

## Issue List

- **Missing assumption / potentially fatal formalization:** The public variable `Z` cannot simply include the full instance `X` if `c` is a fixed deterministic concept, because then `c(X)` is mathematically measurable from `X` and `p(Z)` becomes `0` or `1`. To make the posterior uncertainty meaningful, the model needs either a random hidden target/comparator prior, or an explicit restriction to a coarsened public statistic that excludes the hidden comparator information.

- **Plausible but incomplete:** The kernel lemma covers public reweighting/relabeling of single examples dominated by the original distribution. It does not cover tuple queries, synthetic examples, repeated-coordinate denoising, implicit optimization over transcripts, or schemes whose query distribution is not expressible by weights `w_+(Z), w_-(Z)`.

- **Fatal gap for `OPT_C` if overclaimed:** The proof lower-bounds the error of one comparator `c`, not `OPT_C`. Another concept, a public constant, an anchor hypothesis, or an empirical/spike witness may fit the query below `gamma`. The explorer notes this limitation, so the local claim survives, but the “low-OPT lemma is false” conclusion requires a no-other-witness/random-code/singleton-class assumption.

- **Missing assumption:** Sample-dependent schemes need routing. Point-mass and empirical-support queries can produce low `OPT_C` for target-useless reasons. A serious negative theorem needs mass/smoothness or an explicit taxonomy of public-witness, empirical, hidden-target, and other-concept low-OPT queries.

- **Plausible but incomplete:** The flat-posterior example uses a binary current predictor `g`. It refutes universal excess-only residual lemmas, but does not refute stronger hypotheses involving calibrated soft predictors, class structure, transcript-created posterior variation, or denoising.

- **Missing assumption:** The obstruction is adversarial-oracle flavored. It shows the weak guarantee alone need not force useful output on hard-band queries. It does not rule out a particular fixed weak learner `A` whose outputs leak useful structure.

- **Minor technical assumptions:** Require `E[w_+ + w_-] > 0`, measurability of the kernel, and clarity on whether internal randomness is included in `Z` or averaged conditionally.

## Counterexamples Or Stress Tests

- **Full-instance stress test:** If `Z` includes full `X` and `c` is fixed, then `p(Z)=1_{c(X)=+1}`. The lower bound becomes vacuous. This stresses the need for a hidden-target probability model.

- **Public witness stress test:** If constants or public anchors lie in `C`, then relabeling to a public constant can make `OPT_C=0` although the planted comparator has error at least `eta`.

- **Spike query stress test:** A query concentrated on observed samples can have low realized `OPT_C` without carrying useful target mass.

- **Posterior-variation stress test:** If previous oracle outputs or repeated samples create a public region where `Pr[c(X)\ne Y | Z] < gamma`, the lemma allows useful residual queries. The obstruction only applies before such information exists.

## Literature Or Known-Result Conflicts

No direct literature conflict. The claim is consistent with the existing ledger entries L024/L025 and F022.

It also does not contradict da Cunha-style residual-free boosting, because that route tries to generate hidden-clean witnesses or controlled final votes rather than deriving a low-OPT residual from excess alone.

No unsupported external citation issue: the explorer used only project-local material.

## What Survives The Critique

The public-kernel inequality is worth keeping as a lemma, with restricted scope.

The flat-posterior construction cleanly refutes the proof principle:

> positive excess over `c` alone forces a public one-step residual query where `c` has error below `gamma`.

This is useful progress for the stopped-process barrier direction: any successful residual method must first create public posterior variation, exploit public/empirical witnesses, or use structure beyond excess.

## Recommended Next Checks

1. Formalize the public information model using a random hidden comparator `C*`, or explicitly restrict `Z` to a coarsening that excludes `c(X)`.

2. State the kernel lemma with absolute continuity, positive accepted mass, and randomized relabeling assumptions.

3. Upgrade the flat-posterior example to a no-other-witness/random-code model so comparator-error lower bounds become `OPT_C` lower bounds for polynomially many smooth public kernels.

4. Add a routing lemma for low-`OPT_C` causes: hidden-target, public witness, empirical/spike, and other-concept witness.

5. Test which extra assumptions on soft `F` could defeat the flat-posterior obstruction, especially calibration, margin, transcript information, or repeated-coordinate denoising.