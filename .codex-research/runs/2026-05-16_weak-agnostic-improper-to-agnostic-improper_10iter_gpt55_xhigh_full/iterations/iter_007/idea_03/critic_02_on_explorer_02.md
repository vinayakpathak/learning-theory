## Summary

Explorer 02 is mostly appropriately conservative. I do not see a claimed separation hiding in it; its main conclusion, “no off-the-shelf succinct signed-CSP candidate currently passes the checklist,” survives.

The strongest surviving contribution is the hard-band correction: any refutation hardness used for the strong side must be at noise `eta >= gamma`, because if `OPT_C <= eta < gamma`, the fixed-slack weak learner plus fresh validation already distinguishes planted labels from random RHS labels. This is a useful obstruction to importing standard noiseless or very-low-noise random-CSP hardness.

## Issue List

- **Missing assumption:** Lemma 1 needs an explicit sample-access/refutation model. The validation distinguisher works only if the learner’s output is fixed before a fresh validation sample, the null labels are iid unbiased conditional on `X`, and the returned hypothesis is evaluable on validation descriptors.

- **Missing assumption:** “Weak learner refutes low-noise RRHS” must be for the same descriptor marginal and same class. Standard CSP refutation is often stated for explicit random instances at a density regime, not arbitrary distribution-free sample access.

- **Plausible but incomplete:** The proposed high-noise RRHS/RCN hardness assumption is exactly the right direction, but no candidate class is supplied. It must rule out arbitrary improper predictors, not just assignment recovery, value approximation, or refutation in an explicit-instance sense.

- **Unsupported citation:** Kothari-Livni and Vadhan support learning/refutation vocabulary, but the explorer has not mapped their theorem parameters to this edge. Kothari-Livni concerns efficient agnostic learning vs refutation complexity; Vadhan is PAC/RRHS for a dual class, not directly the high-noise agnostic improper separation needed here.

- **Plausible but incomplete:** Lemma 2’s multiplicative agreement statement is algebraically fine, but for a prescribed weak slack `beta` one needs `1-alpha <= beta`. Saying `alpha > 1/2` only shows existence of some fixed slack below `1/2`.

- **Missing assumption:** The weak-side approximator must handle arbitrary signed/weighted empirical distributions, not just ordinary positive Max-CSP instances. This is much stronger than most approximation algorithms for explicit CSPs.

- **Worth pursuing:** The “low-noise-only approximator plus constants” formulation should be made explicit. The algorithm need only be useful when `OPT < gamma`; constants and validation handle `OPT >= gamma`.

## Counterexamples Or Stress Tests

- **Public RHS:** If the sign/RHS is included in `x`, an improper learner reads it directly. This kills many signed-CSP encodings.

- **All-positive labels:** If every example label is `+1`, the constant `h=+1` has zero error.

- **Fixed-arity descriptors:** For constant arity over `n` variables, descriptor domain size is `n^{O(k)}`, so the table learner reaches Bayes risk plus `epsilon`; this blocks improper separations.

- **Low-noise hardness contradiction:** If a planted CSP distribution has `OPT <= eta < gamma`, then weak learning gives error `<1/2`; fresh validation distinguishes it from iid random RHS. Thus noiseless or near-satisfiable hardness cannot coexist with the desired weak learner for the same class/model.

- **Improper prediction escape:** Even when assignment recovery is hard, an improper learner may output a predictor that labels sampled/query descriptors well without decoding the planted assignment.

## Literature Or Known-Result Conflicts

- Kothari-Livni’s abstract explicitly says refutation complexity characterizes efficient agnostic learning and distinguishes labels correlated with some concept from iid random labels, so the explorer’s use of it as strong-side vocabulary is supported, but only at that abstraction level. Source: https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITCS.2018.55

- Vadhan’s result is about PAC learning being polynomially equivalent to RRHS-refuting a dual class. This supports the learning-vs-refutation theme, but it is not itself the high-noise agnostic improper hardness statement needed here. Source: https://proceedings.mlr.press/v65/vadhan17a.html

- Daniely-Linial-Shalev-Shwartz explicitly target improper learning hardness from average-case assumptions, including agnostic halfspace approximation hardness, but their results should not be treated as giving this edge’s weak side. Source: https://arxiv.org/abs/1311.2272

- Makarychev-Makarychev’s high-arity Max-k-CSP approximation factor is asymptotically tiny, not an `alpha > 1/2` agreement approximation, matching the explorer’s obstruction. Source: https://theoryofcomputing.org/articles/v010a013/v010a013.pdf

## What Survives The Critique

- No current CSP/refutation candidate passes the atlas checklist.

- The hard-band correction is solid and should be recorded: strong-side hardness must be at `eta in (gamma, 1/2)`, not low-noise completeness.

- The signed-CSP weak-side algebra survives: additive agreement gap `kappa` gives `OPT+kappa`; multiplicative agreement `alpha` gives slack at most `1-alpha`.

- The candidate checklist survives: succinct/superpolynomial descriptor domain, RHS as label, arbitrary signed/weighted weak approximation, and high-noise improper prediction hardness.

## Recommended Next Checks

1. Formalize a `HardBandRRHS(C, gamma, eta)` assumption with `eta in (gamma, 1/2)`, sample access, fresh validation, and arbitrary improper distinguishers.

2. Audit Kothari-Livni’s exact agnostic refutation parameters to see whether an `OPT+epsilon` learner at noise `eta` gives the desired high-noise distinguisher with polynomial samples.

3. Search for a low-noise-only signed approximator, not a generic Max-CSP approximation algorithm.

4. Test algebraic/synchronization-style candidates where exact or low-noise instances are algorithmically weak-learnable, but high-noise improper prediction is conjecturally hard.

5. Keep ordinary fixed-arity CSPs marked as failed background, not candidate separations.