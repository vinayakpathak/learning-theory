## Summary

The explorer’s report is directionally sound as an obstruction memo, but its strongest anti-hitting language needs tighter scope. The ideal ghost-clean transfer lemma is standard finite-class uniform convergence and survives. What does **not** follow is a general lower bound saying raw ghost samples require cost \(p^{-K}\): a raw holdout of size \(O(K/p)\) already contains \(K\) hidden clean points with high probability when \(p\) is bounded below. The exponential cost appears only when the proof or algorithm must explicitly name an all-clean \(K\)-tuple/certificate, or optimize using clean labels without a mask.

## Issue List

1. **Broad \(p^{-K}\) discovery claim**
   **Classification:** false claim if read generally; missing assumption if restricted.
   A raw ghost sample does not need to be all clean. With \(M=O((K+\log(1/\delta))/p)\), it contains \(K\) clean examples w.h.p. The \(p^{-K}\) cost applies to mask-neutral all-clean tuple hitting, not to the existence of a hidden clean holdout.

2. **Anti-hitting lemma needs explicit model assumptions**
   **Classification:** missing assumption.
   The bound \(Lp^K\) requires candidate certificates to be chosen without useful posterior information about clean indicators, or else requires an \(I(S;T)\)-charged statement like L020. In arbitrary agnostic distributions, observable high-clean regions can invalidate the naive \(p^K\) posterior.

3. **“Ghost certification needs \(K=\Omega(\epsilon^{-2}\log |V_B|)\)” is overphrased**
   **Classification:** plausible but incomplete.
   \(O((\log |V_B|+\log(1/\delta))/\epsilon^2)\) is the standard sufficient finite-class uniform convergence rate. A matching lower bound needs worst-case separated finite classes and a stated certification task. Effective entropy, VC dimension, duplicate votes, margins, or distribution-specific structure may reduce the needed sample size.

4. **Ideal transfer does not produce ghost-clean empirical success**
   **Classification:** fatal gap for a positive DCHP proof.
   The lemma says: if \(B\) is independent of \(G^+\), then empirical clean performance on \(G^+\) transfers to \(D_c^+\). It does not show that any \(v\in V_B\) has low error on \(G^+\). DCHP-style arguments still need stability, compression, VC/dual-VC control, or another theorem moving generation-sample success to an independent ghost sample.

5. **Clean selector is an oracle**
   **Classification:** missing assumption.
   “A clean selector finding \(v\)” assumes either a clean-mask oracle, observable clean labels, or exhaustive all-clean certificate search. In the actual model, final noisy validation can select among complete classifiers once a good list exists, but it cannot compute clean empirical error on the ghost subset.

6. **Final sparse-majority optimization remains separate**
   **Classification:** fatal gap for algorithmic use.
   Even if ghost transfer proves that some \(v\in \operatorname{sign}(B^{(T)})\) is good on \(D_c^+\), computing or listing such a \(v\) is not supplied. This is exactly the C037/C038 selector bottleneck.

7. **DCHP parameter accounting is only sketched**
   **Classification:** plausible but incomplete.
   The right finite-class bound should plug in
   \[
   \log |\operatorname{sign}(B^{(T)})|
   \le O(T\log(|B|+T)).
   \]
   Then \(K=O((T\log(|B|+T)+\log(1/\delta))/\epsilon^2)\). The report recommends this but does not perform the actual regime comparison.

8. **Citation status**
   **Classification:** unsupported citation, minor.
   No external sources are cited or audited. The use of the DCHP final class is supported by the local ledger, but if promoted to atlas prose it should cite the primary DCHP audit/source rather than this explorer report alone.

## Counterexamples Or Stress Tests

- **Raw holdout stress test:** draw \(M=\Theta(K/p)\) raw ghost examples. There are \(K\) clean examples w.h.p.; the problem is hidden labels/mask, not sample scarcity.

- **Observable high-clean region:** if a public region \(R\) has \(\Pr[Y=c(X)\mid R]\approx 1\), sampling from \(R\) bypasses \(p^{-K}\). This matches O021.

- **Repeated-coordinate denoising:** under finite-domain RCN, repeated samples can recover clean labels without ever finding an all-clean tuple. This is outside the anti-hitting model.

- **Singleton memorizer:** a bag can fit the generation clean sample perfectly and have clean population error near \(1/2\). This is O016 and blocks “finite bag” transfer.

## Literature Or Known-Result Conflicts

No direct literature conflict found. The report is consistent with the local DCHP three-layer decomposition: realized weak-call validity, clean-population transfer, and final selector/list generation.

The main conflict is internal scope: C022/C024/F017/F019 already warn that anti-hitting is a restricted proof-skeleton obstruction, not a general necessity theorem. The explorer’s wording should be tightened to match that.

## What Survives The Critique

- The **Ideal Ghost Clean Transfer** lemma survives as an oracle-clean, analysis-only finite-class lemma.

- The anti-hitting idea survives as a restricted theorem for explicit all-clean certificates under mask-neutrality or information-charged transcript assumptions.

- The ghost idea usefully isolates the middle DCHP bottleneck: independence solves only the statistical transfer step after a ghost-good class/list is already available.

- The final takeaway is correct: ghost samples do not by themselves remove hidden-mask discovery, clean-population transfer, or sparse-majority selection.

## Recommended Next Checks

1. Restate the anti-hitting corollary with exact assumptions: iid/exchangeable clean indicators, transcript/certificate independence or \(I(S;T)\) charge, distinct positions, and certificate completeness.

2. Separate three events: raw ghost sample contains many clean points; algorithm can identify/use clean positions; generated \(V_B\) contains a ghost-good classifier.

3. Plug in the DCHP count
   \[
   K=O((T\log(|B|+T)+\log(1/\delta))/\epsilon^2)
   \]
   and compare polynomial-menu \(L\) against \(Lp^K\).

4. Search for a stability/compression condition proving generation-clean success implies ghost-clean success without mask discovery. That is the only route here that could become positive rather than just diagnostic.