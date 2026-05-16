## Summary

The explorer’s negative diagnosis is mostly sound as a restricted one-step public-filter obstruction. The key algebraic point survives: excess over a comparator exposes the hidden set `{h != c}`, but that set is not public unless the transcript already contains information about `c`.

However, the report overstates what this proves. It does **not** rule out weak calls triggered by public witnesses, spikes, artificial relabelings, or other concepts. It only says that public filtering/relabeling cannot make the same near-optimal comparator `c` a below-`gamma` witness unless the public posterior already has low-noise or high-noise tails.

## Issue List

- **Fatal gap for the positive hard-core route:** Positive excess does not imply a public posterior tail `eta_G <= gamma - poly(epsilon)`. The flat-posterior RCN example directly blocks the broad lemma.

- **False claim / overstatement:** “No public filtering/relabeling step can trigger the fixed weak learner” is too strong. The weak learner is triggered by `OPT_C < gamma`, not by low noise relative to the chosen comparator. Public constants, public relabelings, point masses, empirical queries, or other concepts can make `OPT_C` low.

- **Missing assumption:** Lemma 1 needs a precise sigma-field `G`. The formula is correct only when the filter `W` and relabeling sign `S` are `G`-measurable, the query is absolutely continuous with respect to the original example law, and labels are transformed as `Y' = S Y`.

- **Plausible but incomplete:** The “exactly when low posterior tail exists” statement ignores mass, smoothness, and sampleability. A low-`eta_G` cell of exponentially small mass is not useful for an efficient booster.

- **Missing assumption:** Lemma 2 needs `A in sigma(G)`, global noise `P(S_c=1)=eta`, and a binary accept event or bounded randomized thinning. For arbitrary unbounded weights, the stated `mu kl(gamma'||eta)` lower bound is not automatically the right formulation.

- **Plausible but incomplete:** The information bound can be too weak for inverse-polynomial or tiny chunks. It diagnoses information cost but is not by itself a lower bound against efficient learning.

- **Unsupported citation:** The hard-core citations are background analogies. No cited hard-core theorem currently supplies the needed learning-theoretic public low-OPT chunk lemma.

## Counterexamples Or Stress Tests

- **Flat-posterior RCN:** Let `Y=f(X)N_eta` with `gamma < eta < 1/2`, comparator `c=f`, and current public `h` independent of `f`. Then `err(h,Y)-err(f,Y)=1/2-eta`, but every target-preserving public filter with no information about `f` still has comparator noise `eta > gamma`.

- **Public-witness low OPT:** A query relabeled by a public hypothesis `g in C` can have `OPT_C=0` while revealing nothing about the hidden near-optimal comparator.

- **Spike/empirical queries:** Point-mass or empirical-support queries can have low `OPT_C` for rich classes but carry negligible target mass. These break any conclusion phrased only as “weak learner is triggered.”

- **Sign-specific cells:** Global aggregate quantities can miss useful public cells. Any formal `G` must be fine enough to include the observable cells the wrapper is allowed to select.

- **Tiny posterior tails:** Even if `eta_G < gamma`, if the tail mass is exponentially small or not sampleable, it does not give a polynomial boosting step.

## Literature Or Known-Result Conflicts

No direct conflict with the current ledger. The explorer’s obstruction aligns with `C023/L019` and the public-filter warnings in `F018`.

The main caution is citation hygiene: Impagliazzo/Klivans-Servedio hard-core results should not be cited as proving this posterior lemma. The da Cunha route also remains a near miss because its hidden-clean enumeration is precisely the kind of non-public clean access this critique is diagnosing.

## What Survives The Critique

- The excess identity
  `err(h,Y)-err(c,Y)=E[1_{h != c} c(X)Y]`
  is correct.

- The conditional noise formula on `{h != c}` is correct.

- Lemma 1 is worth recording as a formal sigma-field lemma, with the verdict restricted to “`c` cannot be made a below-`gamma` witness.”

- Lemma 2 is worth pursuing as a clean information-cost lemma for public accept events.

- The flat-posterior RCN example is a strong stress test against any universal hard-core low-OPT chunk lemma.

## Recommended Next Checks

1. Formalize `G`, allowed filters, relabelings, mass lower bounds, and sampling access.

2. Rewrite Lemma 1 with the precise conclusion:
   public filters can lower comparator noise below `gamma` iff they select mass where `min(eta_G,1-eta_G) < gamma`.

3. Prove Lemma 2 using
   `I(S_c;G)=E_G KL(Bern(eta_G) || Bern(eta))`
   and state a separate weighted version.

4. Test the positive route against the observable relabeling minimax direction `D011`.

5. Keep low-`OPT` query taxonomy separate from comparator-useful low-noise queries.