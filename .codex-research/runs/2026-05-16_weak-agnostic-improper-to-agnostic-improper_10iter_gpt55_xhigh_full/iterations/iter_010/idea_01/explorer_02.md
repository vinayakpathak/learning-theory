## Summary

Under the anti-hitting lens, the ghost-sample idea gives a clean conditional transfer lemma, but it does not remove the exponential hidden-mask step. Independence helps only after one has an observable clean ghost sample, a clean-mask oracle, or a population-valid bag/list. From raw agnostic samples, the ghost clean sample is itself hidden; discovering enough clean ghost points for uniform convergence appears to cost \(p^{-K}\), where \(p=\Pr[Y=c(X)]\) and \(K\) is the clean certification sample size.

The useful takeaway is a sharper obstruction: ghost certification needs \(K=\Omega(\epsilon^{-2}\log |V_B|)\) clean examples for a finite vote class \(V_B\). Blindly hitting such a clean holdout is generally super-polynomial, even when \(V_B\) is only polynomially describable.

## Concrete Progress

Let \(c\) be a near-optimal comparator, \(p=\Pr[Y=c(X)]\), and \(D_c^+=D\mid [Y=c(X)]\). Suppose a generation transcript produces a bag \(B\), and define a final class \(V_B\), for example the DCHP class
\[
V_{B,T}=\operatorname{sign}(B^{(T)}).
\]

If \(B\) is fixed independently of an ideal ghost clean sample
\[
G^+=((X_i,c(X_i)))_{i=1}^K\sim (D_c^+)^K,
\]
then ordinary finite-class uniform convergence gives clean population transfer:
\[
K=O\left(\frac{\log |V_B|+\log(1/\delta)}{\alpha^2}\right)
\]
suffices to make empirical clean error on \(G^+\) approximate error on \(D_c^+\) uniformly over \(V_B\).

But this theorem assumes access to \(G^+\). In the actual agnostic sample model, a raw point is usable as a clean ghost point only when the hidden event \(Y=c(X)\) holds. Without discovering that mask, the ghost sample cannot be used for clean empirical certification.

## Claims Or Lemmas

**Lemma 1: Ideal Ghost Clean Transfer.**  
Condition on a generated bag \(B\), independent of \(G^+\sim(D_c^+)^K\). If \(V_B\) is finite, then with probability at least \(1-\delta\),
\[
\forall v\in V_B,\quad
\left|\operatorname{err}_{G^+}(v,c)-\operatorname{err}_{D_c^+}(v,c)\right|\le \alpha
\]
provided
\[
K\ge O\left(\frac{\log |V_B|+\log(1/\delta)}{\alpha^2}\right).
\]
So a clean selector finding \(v\in V_B\) with empirical clean error \(\le r\) yields population clean error \(\le r+\alpha\).

**Status:** proved, but idealized. It requires observable clean labels or a clean-mask oracle.

**Lemma 2: Ghost Anti-Hitting Bound.**  
In the hidden-mask toy model where candidate ghost certificates are chosen without useful information about clean indicators, if a menu has \(L\) candidate certificates and each requires at least \(K\) distinct clean positions, then
\[
\Pr[\text{some certificate is fully clean}]\le Lp^K.
\]
With transcript-mask information \(I(S;T)\), the existing information-charged form gives the corresponding KL-transfer bound from L020.

**Consequence:** If \(K=\Omega(\epsilon^{-2}\log |V_B|)\), then raw all-clean ghost discovery has cost roughly \(p^{-K}\), which is generally not polynomial in \((s,1/\epsilon)\).

## Proof Attempts

The positive proof attempt works only in the ideal clean-ghost model: generate \(B\) from one clean role, hold out an independent clean ghost sample, and use uniform convergence over \(V_B\). This successfully separates generation overfitting from population certification if clean ghost labels are available.

The attempt fails in the actual model at mask discovery. A raw ghost sample contains clean and noisy examples mixed together, and the event \(Y=c(X)\) is hidden because \(c\) is unknown. Enumerating clean subsets or all-clean tuples reintroduces the same anti-hitting cost as earlier clean-witness routes.

A second attempt is to use the ghost sample only for analysis, not for selection. That also fails without a capacity, stability, compression, or independence theorem for the generated bag. A bag can fit the generation clean sample perfectly and behave randomly on an independent ghost sample; the singleton memorization obstruction O016 is exactly this failure mode.

## Gaps And Risks

The anti-hitting bound is restricted. It does not rule out posterior-biased filters, repeated-coordinate denoising, public clean-status information, class-specific recovery, or weak-oracle outputs that leak useful structure.

The ideal transfer lemma also does not solve final sparse-majority optimization. Even after a population-valid bag exists, selecting over \(\operatorname{sign}(B^{(T)})\) remains the separate selector bottleneck.

## Counterexamples Or Obstructions

The main obstruction is that clean ghost certification needs many clean examples:
\[
K=\Omega(\epsilon^{-2}\log |V_B|).
\]
For \(p<1\) bounded away from one, the probability of blindly hitting such an all-clean certificate is \(p^K\), giving super-polynomial discovery cost.

The memorizing-bag example blocks any claim that independence alone transfers generation-sample success to population success. A classifier can have zero empirical clean error on the generation sample and clean population error near \(1/2\).

## Sources Consulted

No web search or external sources consulted.

Local run files read: `problem.md`, `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_010/idea_01/idea.md`.

## Recommended Next Steps

Formalize the conditional `IdealGhostCleanTransfer` lemma as useful but explicitly oracle-clean.

Then record the anti-hitting corollary: ghost-sample certification of size \(K=\Theta(\epsilon^{-2}\log |V_B|)\) is not discoverable from raw agnostic samples by polynomial menus unless there is extra mask information, compression to \(O(\log \mathrm{poly})\) total clean positions, or a class-specific denoising mechanism.

For the DCHP route, the next concrete calculation is to plug in
\[
\log |\operatorname{sign}(B^{(T)})|=O(T\log(|B|+T))
\]
and compare the resulting ghost-clean \(K\) against \(p^{-K}\).