## Summary

The explorer’s ideal finite-class ghost-transfer lemma is sound under its stated independence and observability assumptions. The main critique is that the obstruction is only a restricted hidden-mask/explicit-certificate obstruction, essentially L017/L020 again. It does not prove that ghost-sample arguments generally require exponential mask discovery.

The strongest overstatements are: “needs” \(K=\Omega(\epsilon^{-2}\log |V_B|)\), and “raw agnostic samples” imply \(p^{-K}\) clean-holdout discovery cost. Both require extra assumptions.

## Issue List

- **Missing assumption:** The \(Lp^K\) anti-hitting bound needs mask-neutral candidate certificates, or iid/exchangeable clean indicators independent of the transcript. In arbitrary agnostic distributions, candidate selection from \(X\) can bias toward high-clean posterior regions. This is exactly the O021 obstruction.

- **False claim if read literally:** “Ghost certification needs \(K=\Omega(\epsilon^{-2}\log |V_B|)\).” Finite-class uniform convergence gives this as a sufficient union-bound scale, not a necessary one. If many elements of \(V_B\) are duplicate or distributionally identical, or if \(VC(V_B)\ll \log |V_B|\), the required sample size can be much smaller.

- **Plausible but incomplete:** The information-charged extension “with \(I(S;T)\)” is underspecified. L020 needs an independent-coupling certificate mass \(\mu=E_T\sum_\sigma w_\sigma p^{K_\sigma}\), certificate completeness, branch weights, distinct-position accounting, and validation independence. Mutual information alone is not the statement.

- **Missing assumption:** The \(p^{-K}\) cost is a blind all-clean tuple cost. It does not apply to posterior-biased filters, public clean-status features, repeated-coordinate denoising, class-specific recovery, or algorithms whose proof uses a ghost sample only analytically rather than as an observed selector.

- **Plausible but incomplete:** The obstruction depends on the target transfer accuracy \(\alpha\). If \(\alpha=\Theta(\epsilon)\), then \(K\sim \epsilon^{-2}\log |V_B|\) can make \(p^{-K}\) super-polynomial. If \(\alpha\) is constant, \(p\) is very close to one, or the effective class size is small, the conclusion may not bite.

- **Worth pursuing:** The explorer correctly separates clean-population transfer from final sparse-majority selection. Even with a population-valid bag, efficient selection over \(\operatorname{sign}(B^{(T)})\) remains a separate bottleneck.

## Counterexamples Or Stress Tests

- **Duplicate vote class:** Let \(V_B\) contain exponentially many syntactic votes that all compute the same function. Then \(\log |V_B|\) is large but no \(\Omega(\log |V_B|)\) clean sample lower bound is valid.

- **Public high-clean region:** Suppose a public region \(R\) satisfies \(\Pr[Y=c(X)\mid X\in R]=1\) while global \(p=\Pr[Y=c(X)]<1\). A ghost certificate chosen from \(R\) is clean with probability \(1\), not \(p^K\).

- **Repeated-coordinate denoising:** Under RCN on a finite or repeated domain, majority over repeated observations can infer clean labels without finding an all-clean \(K\)-tuple. This bypasses literal clean-transcript anti-hitting.

- **Analysis-only ghost sample:** Standard ghost-sample/symmetrization arguments do not require the algorithm to observe the ghost sample. The real missing ingredient is a proof that the generated bag performs well on the independent ghost sample, not necessarily discovery of the ghost mask.

## Literature Or Known-Result Conflicts

No direct external conflict is apparent. The ideal lemma is standard finite-class uniform convergence.

The main mismatch with standard learning-theory phrasing is that \(\log |V_B|\) should be treated as an upper-bound proxy, not a necessary parameter. VC dimension, growth function, covering numbers, margin structure, compression, or stability could all replace raw cardinality if available.

## What Survives The Critique

- Ideal ghost clean transfer is correct for fixed \(B\) independent of \(G^+\) and finite \(V_B\).

- The anti-hitting obstruction is valid as a restricted hidden-mask theorem for explicit mask-neutral all-clean certificates.

- The report correctly concludes that ghost samples alone do not solve the DCHP middle layer.

- The recommended DCHP calculation
  \[
  \log |\operatorname{sign}(B^{(T)})|=O(T\log(|B|+T))
  \]
  is still a useful next accounting step.

## Recommended Next Checks

1. Restate Lemma 2 with exact hidden-mask assumptions: iid mask, transcript-mask independence or bounded posterior, distinct positions, certificate completeness, and \(\mu\) for L020.

2. Replace “needs \(K=\Omega(\epsilon^{-2}\log |V_B|)\)” with “finite-class union bound suffices with \(K=O(\alpha^{-2}\log |V_B|)\); lower bounds require richness/separation assumptions.”

3. Instantiate the DCHP parameters \(M=|B|\), \(T\), clean-transfer tolerance \(\alpha\), and \(p=1-\operatorname{err}(c)\), then compute when \(p^{-K}\) is actually super-polynomial.

4. Separate two proof modes: ghost sample used for algorithmic clean selection versus ghost sample used only for analysis.

5. Stress-test against public high-clean regions and repeated-coordinate denoising before recording any broad “raw agnostic samples cost \(p^{-K}\)” claim.