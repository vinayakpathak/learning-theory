## Summary

The explorer’s algebraic Lemma 1 is sound and worth keeping: for target-preserving reweightings in the RCN model, lowering noise below `gamma` is exactly equivalent to the label-asymmetric part of the filter having weighted correlation with `f`.

But the report is not yet an oracle lower bound. The biggest problems are: Lemma 3 is stated falsely as a KL bound, `eta_W` for the planted `f` is not the same as `OPT_C`, and the adaptive information budget is only sketched.

## Issue List

1. **False claim:** Lemma 3 is not correct as stated.  
   If `Q = P_f P_T` and event `E = {eta_{W_T}<gamma}`, data processing gives
   $$
   I(f;T) \ge \mathrm{kl}(P(E)\|Q(E)).
   $$
   If only `Q(E) <= p`, then `I(f;T) >= kl(P(E)||p)` is valid when `P(E) > p`, but not unconditionally. Counterexample: take `T` independent of `f`, success probability `alpha < p`; then `I=0` but `kl(alpha||p)>0`.

2. **Fatal gap for atlas relevance:** low conditional noise relative to planted `f` does not imply `OPT_C < gamma`, nor does high noise relative to `f` imply `OPT_C >= gamma`. Another concept may fit the filtered distribution. The explorer notices this, but it remains a blocker unless the model is explicitly singleton-target, random-code/no-other-witness, or has a precise “public certificate” oracle rule.

3. **Missing assumption:** the filter model must specify simulability. A target-preserving `W(x,y)` is implementable by rejection sampling only if the learner can evaluate `W` on fresh labeled examples and the accepted mass is at least inverse-polynomial. The parameters `A >= mu` and `a <= L` should be normalized, e.g. after scaling `sup a <= 1`, because `W` is scale-invariant.

4. **Plausible but incomplete:** Lemma 2 applies to a fixed filter independent of `f`. For adaptive filters, conditioning on transcript values changes the posterior of `f`; the independent-target tail only transfers through a carefully stated mutual-information change-of-measure argument. That argument is not fully written.

5. **Plausible but incomplete:** “already extracted target correlation” is only weighted/local correlation:
   $$
   E[b(X)f(X)]/E[a(X)]>\tau.
   $$
   If the symmetric mass `A` is small, this may be only inverse-polynomial global correlation. That may still be enough for a restricted barrier, but the theorem must track whether the needed information is local or global.

6. **Missing assumption:** the adversarial weak-oracle policy is underspecified. In hard-band queries, a majority constant is valid, but for low-`OPT` public-certificate queries one must prove the returned public witness satisfies the fixed-slack guarantee. Otherwise the oracle policy may not be legal.

7. **Unsupported citation:** the cited SQ papers support the general flavor of restricted/statistical access and noise tolerance, but they do not by themselves justify Lemmas 1-3 or the public-filter lower bound. I checked Kearns’ JACM paper and the BFJKMR STOC record; they are background, not direct support for this theorem.

8. **Worth pursuing:** Lemma 1 cleanly strengthens L007 and should probably enter the lemma bank, with the above assumptions attached.

## Counterexamples Or Stress Tests

- **KL-bound stress test:** `T` independent of `f`, fixed smooth `W`, and a loose upper bound `p` larger than the actual success probability. Then Lemma 3’s displayed inequality can be false.

- **Public-witness low-OPT query:** if the wrapper relabels or filters so that a known public `g in C` fits the query, then `OPT_C` can be low for public reasons. Returning `g` gives no information about `f`.

- **Point mass / empirical support:** already acknowledged by the explorer. These make low-noise or low-`OPT` queries possible with negligible target mass, outside the smooth-filter regime.

- **Rich concept class:** even for target-preserving filters, a concept class with many functions may contain `c != f` that fits the filtered query better than `f`. The formula for `eta_W` does not control this.

## Literature Or Known-Result Conflicts

No direct conflict with SQ literature is apparent. Kearns’ SQ framework explicitly restricts learners away from individual-example access and studies classification-noise robustness, which is philosophically aligned with a smooth-filter barrier. BFJKMR’s SQ characterization/lower-bound line is also compatible.

But neither cited source proves the adaptive public-filter claim. The report should not cite them as theorem support without adding a precise SQ reduction or statistical-dimension statement.

Sources checked: Kearns JACM 1998 PDF: https://homepages.math.uic.edu/~lreyzin/papers/kearns98.pdf ; BFJKMR STOC 1994 record: https://doi.org/10.1145/195058.195147

## What Survives The Critique

- The exact formula for `eta_W` survives.
- The threshold
  $$
  r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
  $$
  survives under RCN with target-preserving filters.
- The fixed-filter Hoeffding tail survives with independence, smoothness, and mass assumptions.
- The route remains a useful restricted black-box barrier, not an atlas separation.

## Recommended Next Checks

1. Rewrite Lemma 3 with `q = Q(E)` and the condition `alpha=P(E)>p>=q`.

2. Formalize the restricted oracle model: class, query type, smoothness, mass, allowed relabeling, and legal adversarial responses.

3. Prove the full transcript information budget, including raw noisy samples and oracle-output leakage.

4. Decide whether the theorem controls local weighted correlation, global correlation, or both.

5. Add Lemma 1 to the lemma bank as a restricted RCN public-filter lemma, not as a general agnostic-boosting obstruction.