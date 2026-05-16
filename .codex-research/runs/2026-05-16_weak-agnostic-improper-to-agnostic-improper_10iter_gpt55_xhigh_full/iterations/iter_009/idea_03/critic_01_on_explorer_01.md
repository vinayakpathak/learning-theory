## Summary

The explorer’s core legality lemma is sound in a restricted black-box model: if every weak-call distribution puts mass at most `beta` on a common hidden block `S`, then an improper weak output can be arbitrary on `S` and still satisfy `OPT + beta` for `C={+1}`.

But the report does not establish compatibility with the literal DCHP generator. The main obstruction is severe: DCHP-style tuple enumeration with repetitions can create weak calls supported entirely on a hard-slice sample point. Then `Q(S)=1`, so rare-slice legality collapses exactly when the hard block is population-relevant enough to realize a Set-Cover gadget.

## Issue List

- **Fatal gap:** final relevance and weak-call lightness are in tension. If the hard block has mass `alpha` large enough for polynomially many final samples to realize a selector-hard gadget, then a comparable weak-sample pool hits `S` with high probability. With repeated tuple enumeration, one hit gives a spike call with `Q(S)=1`.

- **Fatal gap:** the argument does not show literal DCHP-generated Set-Cover hardness. It proves hardness only under an assumed query-light block; actual DCHP calls may deliberately enumerate empirical tuples that destroy query-lightness.

- **Missing assumption:** the programmed weak learner must be valid for all possible input distributions, not only the wrapper’s realized calls. A universal construction would need a fallback rule when `Q(S)>beta`, plus PAC-confidence accounting showing it detects or avoids heavy-block calls.

- **Missing assumption:** many columns must share one block `S`. Independent rare slices per weak call do not produce one coherent Set-Cover matrix. A shared block requires state, a hardwired seed, or a stateless scheduling mechanism; none is formalized.

- **Missing assumption:** column scheduling is unspecified. To embed an arbitrary Set-Cover instance, the weak learner must output the intended column `j` at the intended generated-bag position. This is not automatic for a stateless PAC learner.

- **Missing assumption:** representation leakage is dangerous. If outputs expose the key `R`, later adaptive calls can focus on `S`; if outputs hide `R`, the final selector/gadget realization may not be able to address the common hard block as intended.

- **Plausible but incomplete:** iid final-row realization with scaled gap can work in a standalone model, but the sample-size/gap accounting must be coupled to the weak-sample hit probability. The explorer only states this informally.

- **Plausible but incomplete:** extra generated columns are uncontrolled. In Set-Cover no-instances, even one additional favorable column can destroy soundness unless all extras are duplicates, constants, or proved harmless.

- **Missing assumption:** the Set-Cover gadgets require constants or offset columns and exact alignment with DCHP’s computed `T`. The explorer notes this but does not resolve it.

- **False if overread:** because the toy class is `C={+1}`, the construction cannot be an atlas separation. Strong agnostic learning is trivial by returning `+1`; this is only a selector obstruction.

- **Unsupported citation/literature issue:** no external citation is misused, but actual DCHP-specific claims still need a primary proof audit. The current report relies on local ledger-level understanding of tuple enumeration.

## Counterexamples Or Stress Tests

- **Spike tuple test:** put mass `alpha` on `S`. If one weak-sample point lies in `S`, and DCHP permits the repeated tuple on that point, the induced query can have `Q(S)=1`. A programmed column that disagrees with `+1` on that row can have error increase `1`, violating `OPT+beta`.

- **Mass tradeoff test:** to avoid weak-sample hits, need roughly `n_w alpha << 1`. To realize a polynomial-size gadget in final samples, need roughly `n_f alpha` at least polynomial or logarithmic in the gadget size. If `n_w` and `n_f` are comparable, both cannot hold.

- **Shared-key coupon test:** if `|K| >= 1/(tau delta_0)` is needed for per-call validity and keys are freshly randomized, collecting many columns on the same key is exponentially unlikely. If the key is shared, adaptivity/key leakage must be controlled.

- **Extra-column soundness test:** add one uncontrolled column that behaves like the missing offset or covers all uncovered elements. The no-cover side of the Set-Cover reduction may become zero-error.

## Literature Or Known-Result Conflicts

The explorer’s restricted lemma is consistent with the ledger’s rare-slice programming lemma `L041/C043` and with arbitrary-bag Set-Cover hardness `L034/C038`.

The conflict is with the DCHP audit in the working notes: known DCHP-style implementation enumerates ordered weak samples and uses `sign(B^(T))` ERM. That enumeration is exactly what can produce spike calls, so arbitrary-bag hardness still does not transfer to DCHP-generated bags.

No external known result is contradicted; the issue is scope.

## What Survives The Critique

The query-light block pollution lemma survives as a clean black-box warning.

The random hidden block version survives for nonadaptive or sufficiently min-entropy-preserving call schedules.

The selector-hard embedding survives as a conditional theorem if one explicitly assumes: common block, query-light calls, scheduled columns, constants/offsets, harmless extra columns, iid final realization, and `T` alignment.

The strongest useful takeaway is negative: literal all-ordered-tuple enumeration with repetitions likely kills rare-slice DCHP compatibility whenever the hard block is final-relevant.

## Recommended Next Checks

1. Prove the spike-call obstruction formally for the exact DCHP weak-call distribution.
2. Quantify the `alpha, n_w, n_f, N_gadget` tradeoff showing weak-sample miss and final-gadget realization are incompatible.
3. Formalize a universal PAC-valid rare-slice learner with fallback on heavy `S`, including confidence accounting.
4. Specify whether the oracle model permits stateful shared keys; if not, give a stateless column-scheduling mechanism.
5. Audit constants/offsets, extra columns, and DCHP’s computed `T` against the two Set-Cover gadgets.
6. Keep the result labeled as black-box selector pollution unless the literal DCHP compatibility items are proved.