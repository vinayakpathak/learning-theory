## Summary

The explorer report makes real progress on `idea_02`, but only as a restricted public-filter lemma. The soft-filter identity is essentially correct and worth preserving. The mutual-information barrier is plausible, but several quantifiers and model assumptions must be made explicit before it is a theorem. It does not yet yield an oracle lower bound or an atlas separation.

The main danger is overconnecting “low conditional noise relative to hidden `F`” with “low `OPT_C` query.” Those are different. Public-witness filters can create legal low-`OPT` weak-oracle calls without learning `F`.

## Issue List

- **Worth pursuing:** Lemma 1, the soft public-filter identity, looks correct. With
  $$
  S=N^{-1}\sum_x c(x),\quad R=(NS)^{-1}\sum_x F(x)d(x),
  $$
  the acceptance probability is
  $$
  \frac S2(1+(1-2\eta)R),
  $$
  and the conditional noise relative to `F` is
  $$
  \eta_W=\frac{\eta(1-R)}{1+(1-2\eta)R}.
  $$
  The threshold
  $$
  R>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
  $$
  is also correct.

- **Missing assumption:** Lemma 2 needs a precise probability model: `X` uniform on `[N]`, `F` iid Rademacher, `W_T` measurable with respect to the transcript, and the selected filter itself included in the transcript. If “there exists a filter at transcript `T`” means an uncharged post-hoc search over a huge filter class, the KL-transfer argument does not apply as written.

- **Plausible but incomplete:** The Hoeffding step is salvageable, but the mass parameter must be defined carefully. If mass means actual acceptance probability, then one should explicitly derive a lower bound on `S`; if mass means `S`, state that. The boundedness `W in [0,1]` is essential because it gives individual weight control.

- **Fatal gap for an oracle barrier:** Low noise relative to `F` is only sufficient for a target-informative low-`OPT` query. It is not necessary for low `OPT_C`. Example: if constants are in `C`, the target-preserving filter `W(x,y)=1[y=+1]` produces labels that are always `+1` on the accepted distribution, so `OPT_C=0`, while its noise relative to a random balanced `F` remains about `eta`. The oracle can return the public constant and reveal no hidden information.

- **Fatal gap unless modeled:** Oracle-output leakage is not a minor detail. A weak oracle response may be a polynomial-size hypothesis containing many bits about `F`, or a callable handle with even more implicit information unless the representation model forbids this. Lemma 3 only works after imposing an explicit information budget per response or choosing an adversarial low-leakage oracle.

- **Plausible but incomplete:** The sample-information bound
  $$
  M(\ln 2-h(\eta))
  $$
  is a reasonable upper bound for iid RCN samples on a random domain, but it should be stated with natural-log entropy and with repetitions handled by chain rule.

- **False if generalized:** “Polynomial samples and polynomial dummy calls do not suffice” depends on `N` being much larger than the transcript information divided by `tau^2 alpha`. It fails for polynomial-size domains, heavy-atom distributions, or very small `eta-gamma`.

- **Unsupported citation / proof obligation:** The “standard binary event KL inequality” is standard, but if promoted to the ledger it should either be proved in one line or cited. The claimed constant `4` is plausible but should not be treated as audited.

## Counterexamples Or Stress Tests

- **Public constant filter:** `W(x,y)=1[y=+1]`. If `+1 in C`, then `OPT_C=0`; nevertheless `R≈0` for random balanced `F`, so the filter does not reduce hidden-comparator noise below `gamma`.

- **Agreement with public comparator:** `W(x,y)=1[y=Z(x)]` for public `Z in C`. Then the filtered labels equal `Z`, so `OPT_C=0`. The hidden-noise threshold is crossed only if `Z` already correlates with `F`, exactly matching the explorer identity.

- **Empirical support:** filters supported on observed coordinates can have low noise and real information, but only on mass about `M/N`. This is consistent with the bound and shows why inverse-polynomial mass assumptions must be explicit.

- **Adaptive sign leakage:** majority-constant dummy answers to smooth subset queries leak sign bits of label bias. This can be modeled by increasing `I(F;T)`, but cannot be ignored.

## Literature Or Known-Result Conflicts

No direct conflict with the working notes. The report sharpens L007/O005 rather than replacing them.

It also does not conflict with da Cunha-style residual-free boosting, because the lemma only controls target-preserving public filters. Clean-label enumeration, artificial relabeling, and transcript enumeration sit outside this restricted model.

## What Survives The Critique

The algebraic filter identity survives.

A corrected Lemma 2 likely survives in this form: for one transcript-measurable target-preserving filter of sufficiently large mass, under iid random `F`, crossing the hidden-noise threshold with nonnegligible probability requires
$$
I(F;T)=\Omega(\tau^2 \alpha N).
$$

This is useful as a restricted black-box obstruction, not as an atlas separation.

## Recommended Next Checks

1. Write the exact Lemma 2 proof with `P` the true joint law, `Q=P_F P_T`, and event `E={S>=alpha, R>=tau}`.
2. Replace “such a filter exists” by “the algorithm outputs this filter,” or charge the selector/filter description in `T`.
3. Add a separate category for public-witness low-`OPT` calls, such as constants and `Y=Z(X)` filters.
4. State an explicit oracle-output information budget.
5. Keep the conclusion modest: restricted public-filter barrier for random-comparator toy models, not an efficient represented-class separation.