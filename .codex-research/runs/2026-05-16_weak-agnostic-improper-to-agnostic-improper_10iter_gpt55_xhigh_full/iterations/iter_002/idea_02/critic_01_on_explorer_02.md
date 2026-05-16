## Summary

Explorer 02 has a solid algebraic core: the public-filter identity is correct, and the mutual-information route is a plausible restricted oracle barrier. The main breakage is scope. The argument controls only target-preserving, bounded/smooth filters whose usefulness comes from lowering noise relative to the hidden target `F`. It does not control general weak-learner queries, public relabelings, empirical/spike queries, or low-`OPT` queries certified by some concept other than `F`.

So: worth pursuing as a black-box barrier lemma, not evidence for an atlas separation.

## Issue List

1. **Plausible but incomplete: public-filter identity needs exact mass conventions.**  
   The formula
   $$
   \eta_W=\frac{\eta(1-R)}{1+(1-2\eta)R}
   $$
   is algebraically correct for nonzero bounded target-preserving filters. But the report alternates between `S`, “target acceptance probability,” and `alpha`. The Hoeffding bound needs a precise lower bound such as `S >= alpha`, or an equivalent accepted-mass lower bound with constant-factor conversion.

2. **Missing assumption: boundedness/smoothness is essential.**  
   The concentration proof uses coefficients bounded by `O(1/(alpha N))`. This follows if `W in [0,1]` and `S >= alpha`; it fails for arbitrary reweightings or spiky query distributions. The theorem statement should explicitly include `0 <= W <= 1` or an `L`-smoothness parameter.

3. **Fatal gap for broad oracle barriers: conditional noise of `F` is not `OPT_C`.**  
   The weak oracle is triggered by `OPT_C(Q)<gamma`, not by low noise relative to the hidden `F`. A query can have low `OPT_C` for public reasons even when $\eta_W(F)\ge\gamma$. Example: filter on `Y=+1`; the labels are then public-constant `+1`, so if constants are allowed the query has `OPT=0`, while the hidden-target noise need not be below `gamma`.

4. **Missing assumption: no-other-witness or public-certificate rule.**  
   To convert the lemma into an oracle policy, one must assume that every low-`OPT` query is either publicly certified, so the oracle may return the public witness, or comes from hidden low noise relative to `F`. This is not automatic for rich classes.

5. **Plausible but incomplete: adaptive “exists a filter” statement.**  
   The KL transfer proves a bound for a selected measurable filter `W_T`. If the claim is that “some filter exists” in a transcript-dependent class, the proof also needs to account for the selector, family size, or description complexity. Absorbing the chosen filter into `T` is fine, but then this must be stated.

6. **Missing assumption: oracle-output information budget.**  
   Lemma 3 says dummy oracle responses leak only `O(1)` bits. That is an adversarial-oracle modeling choice, not a consequence of the weak-learning guarantee. A black-box lower bound may impose it; an atlas implication cannot.

7. **Fatal gap for atlas separation: random-comparator/all-functions model is not represented-class evidence.**  
   The information lower bound becomes meaningful when `N` is much larger than the transcript budget. But if representation size is `log N`, random all-functions are not succinctly represented; if representation size is `N`, polynomial samples may already be comparable to the domain. This remains a toy barrier.

8. **Plausible but incomplete: sample information accounting.**  
   The bound `M(ln 2 - h(eta))` nats per RCN sample is standard in spirit, but should be written with entropy base fixed and with repeated-coordinate/adaptive-query conditioning handled by chain rule.

## Counterexamples Or Stress Tests

- **Public label filter:** `W(x,y)=1[y=+1]`. This is target-preserving and bounded. It can create `OPT=0` for the public constant `+1`, but usually has little or no correlation with a balanced random `F`.

- **Empirical public witness:** after seeing samples, query the empirical support with labels fixed to the observed labels. This can have low `OPT` for a memorized public hypothesis while carrying negligible global information about `F`.

- **Spike query:** a point mass on a seen `(x,y)` can be low-noise or perfectly fit, but has target mass about `1/N`. The proposed barrier only survives if `alpha` excludes such queries.

- **Known-subset reconstruction:** if the transcript reveals `F` on `alpha N` coordinates, then a low-noise filter on that subset exists. This matches the mutual-information lower bound and is a good sanity check.

## Literature Or Known-Result Conflicts

No direct literature conflict appears from the local notes. The result is consistent with the existing obstruction list: it refines L007/O005 but does not contradict da Cunha-style residual-free boosting because it excludes clean-label enumeration, artificial relabeling, and other non-public-filter mechanisms.

The report should not be cited as an SQ lower bound or boosting impossibility without a formal oracle model.

## What Survives The Critique

- The soft public-filter identity is valuable and should be added to the lemma bank.
- The threshold
  $$
  R>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
  $$
  cleanly generalizes the agreement-filter obstruction.
- The mutual-information proof strategy is credible for bounded, target-preserving, transcript-selected filters.
- The work gives a useful restricted black-box barrier, not an atlas-level separation.

## Recommended Next Checks

1. State the theorem with exact parameters: `N, eta, gamma, alpha/S, L, M, q`, entropy base, and oracle-output leakage budget.

2. Prove the KL transfer lemma explicitly:
   if independent success probability is at most `e^{-lambda}` and `I(F;T)=B`, then success is at most `(B+ln 2)/lambda`.

3. Add a taxonomy of low-`OPT` queries: hidden-target filters, public-certified relabelings, empirical/spike queries, and other-witness queries.

4. Test the theorem against `W=1[Y=+1]`, empirical-support filters, and known-subset filters before promoting it to the claim ledger.