## Summary

The explorer report gives a useful restricted obstruction, but its strongest language should be narrowed. The union-bound lemma is correct only in a hidden-mask model where candidate transcripts are chosen without information about which examples are clean and where success literally requires `K` clean positions. It does not by itself rule out de-enumeration using repeated samples, posterior-biased filtering, noisy-label denoising, class structure, oracle leakage, or final-classifier menus.

I do not see a fatal flaw in the restricted anti-hitting lemma. I do see fatal gaps for any attempt to promote it to an atlas-level lower bound or to a general impossibility theorem for de-enumerating da Cunha-style boosting.

## Issue List

1. **Missing assumption:** conditional hidden-mask independence.  
   The bound
   $$
   \Pr[\exists\text{ clean candidate among }L]\le Lp^K
   $$
   requires something like: after conditioning on all observable data used to choose the candidate transcripts, each candidate’s clean indicators remain Bernoulli with parameter at most `p`, or at least satisfy
   $$
   \Pr[I_j\text{ all clean}\mid T]\le p^K.
   $$
   This is not automatic in RCN or general agnostic data. Labels, repeated points, public certificates, and oracle replies can change posterior clean probabilities.

2. **Fatal gap for broad conclusions:** “sampling clean transcripts must pay `p^K`” is false without a literal-clean-transcript requirement.  
   A learner may not need an all-clean tuple. It might use noisy labels plus averaging, infer a clean conditional statistically, or generate complete final hypotheses whose noisy validation succeeds. The obstruction applies to proof skeletons that insist on hidden all-clean weak-call samples.

3. **Missing assumption:** candidate transcripts must be pre-mask or low-information.  
   If the menu is chosen adaptively after weak-oracle outputs, validation statistics, or repeated observations, the clean mask is no longer hidden in the same way. A correct statement needs an information budget or posterior bound, not just `L`.

4. **Plausible but incomplete:** the finite-table lower bound needs formal quantifiers.  
   For random labels on a uniform `d`-point domain, seeing fewer than about `2 gamma d` clean labels should indeed prevent correlation `2 gamma` in expectation. But to use this as a lower bound, state whether it is average-case over random targets, high probability, or worst-case via Yao/Fano.

5. **False if unqualified:** noisy raw labels cannot replace clean transcripts.  
   For the all-labelings finite-domain class under RCN, repeated samples per point and empirical majority strongly learn in polynomial time in `d`. The explorer notes this caveat, but Lemma 3 should be phrased as “one noisy label per covered point does not automatically replace clean labels.”

6. **Missing parameter accounting:** `p` is ambiguous and matters.  
   The report alternates between `p=Pr[Y=c(X)]=1-eta` and clean-mixture mass `p=1-2eta`. These lead to different discovery rates. The right condition is closer to
   $$
   L\,q\,p^K \ge 1/\operatorname{poly}(s,1/\epsilon),
   $$
   with `q` the clean-transcript success probability and with explicit dependence on `gamma`.

7. **Plausible but incomplete:** compression/stability obstruction needs multiplicity.  
   A compressed learner may have many successful witnesses. The lower bound should count total posterior mass of successful witnesses, not just one witness of length `K`.

8. **Worth pursuing:** this is a good obstruction to the known enumeration proof skeleton.  
   It supports the existing ledger point that logarithmic total witness size is the threshold for raw discovery, while `m0` or `m0T` growing with representation size makes enumeration non-polynomial.

## Counterexamples Or Stress Tests

- **Repeated-coordinate majority:** On `[d]` with all labelings and RCN noise `eta<1/2`, sample each coordinate enough times and majority vote recovers the target. This bypasses all-clean transcript discovery.

- **Posterior-biased filtering:** If repeated observations or side information identify examples more likely to be clean, then candidate tuples can have clean probability much larger than `p^K`.

- **Public clean certificates:** If a side feature reveals clean status, a learner can select clean examples directly. Trivial, but it isolates the hidden-mask assumption.

- **Sign-specific cells:** Prior notes already show global correlation/noise summaries can miss low-noise observable cells. Any anti-hitting lemma must control posterior clean probability cell-by-cell.

## Literature Or Known-Result Conflicts

No direct conflict with the run’s known results. The report is consistent with C010, F005-F007, F013, and O014.

The main caution is interpretive: this should not be cited as a lower bound against agnostic boosting generally, nor against the atlas edge. The finite-table class is strongly agnostically learnable, and da Cunha-style enumeration may require auditing to determine whether the true hidden witness length is `m0`, `m0T`, or something weaker.

## What Survives The Critique

The restricted hidden-mask anti-hitting lemma survives.

The finite-table example is a good stress test showing that clean weak learners can naturally have `K=Omega(d)` sample dependence, so atlas-efficient weak learning does not imply constant or logarithmic clean witness size.

The clean accounting message survives: raw tuple discovery is polynomial only when the total clean witness length and success mass satisfy an inverse-polynomial condition.

## Recommended Next Checks

1. Formalize Lemma 1 with a sigma-field `T` of observable information and an explicit posterior condition:
   $$
   \Pr[I_j\text{ all clean}\mid T]\le e^{-\kappa K_j}.
   $$

2. Audit the boosting proof to identify the true total hidden witness length: one weak call `m0`, all calls `m0T`, or final classifier witness size.

3. Replace `p^K` by a posterior/information version that allows adaptive menus:
   $$
   \mathbb E\sum_j \Pr[I_j\text{ clean}\mid T].
   $$

4. Formalize the finite-table lower bound via Yao or Fano, while explicitly noting that the class is still strongly learnable.

5. Add the success multiplicity parameter `q` to every positive/negative de-enumeration statement.