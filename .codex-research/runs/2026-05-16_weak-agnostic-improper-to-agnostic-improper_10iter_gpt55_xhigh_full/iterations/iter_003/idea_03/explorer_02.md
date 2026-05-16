## Summary

Through the information-theory lens, idea_03 yields a clean toy theorem: an adaptive algorithm cannot select a smooth, non-negligible public filter that lowers RCN noise below the weak threshold unless its transcript already contains \(\Omega(\tau_{\eta,\gamma}^2 \alpha N/L)\) nats of information about the hidden target.

This is not an atlas separation. It is a useful restricted barrier: it formalizes exactly where target information must enter public-filter strategies and why spike, empirical, public-witness, and unbounded-oracle-output cases must be routed separately.

## Concrete Progress

The main progress is a sharp adaptive version of the existing fixed-filter concentration lemma.

Let \(F\in\{\pm1\}^N\) be iid uniform, \(T\) be the full transcript, and let the selected filter be a post-processing of \(T\):
\[
W_T(x,y)=a_T(x)+b_T(x)y,\qquad 0\le a_T(x)\le L,\quad |b_T(x)|\le a_T(x).
\]
Assume its mass is
\[
A_T=\frac1N\sum_x a_T(x)\ge \alpha.
\]
Define
\[
R_T(F)=\frac{\sum_x b_T(x)F(x)}{\sum_x a_T(x)}.
\]
For RCN noise \(\eta>\gamma\), the filter beats the weak threshold exactly when
\[
R_T(F)>\tau_{\eta,\gamma}
:=\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
\]

If \(I(F;T)\le B\) nats, then
\[
\Pr\!\left[R_T(F)\ge \tau_{\eta,\gamma}\right]
\le
\frac{B+\ln 2}{\tau_{\eta,\gamma}^2\alpha N/(2L)}.
\]

So constant success requires \(B=\Omega(\tau_{\eta,\gamma}^2\alpha N/L)\).

## Claims Or Lemmas

**Lemma 1: Adaptive Smooth Public-Filter Information Barrier.**  
In the model above, for any \(\tau>0\),
\[
\Pr[R_T(F)\ge \tau]
\le
\min\left\{1,\frac{I(F;T)+\ln 2}{\tau^2\alpha N/(2L)}\right\}.
\]
Status: proved in the random-target toy model.

**Lemma 2: Raw RCN Sample Budget.**  
If \(T\) contains \(M\) iid RCN samples \((X_i,Y_i)\), with \(X_i\) uniform on \([N]\), then
\[
I(F;T_{\mathrm{samples}})
\le M(\ln 2-h_2(\eta)),
\]
where \(h_2\) is binary entropy in nats. Extra accessible oracle-output bits add at most their bit length times \(\ln 2\).

**Claim 3: Public-Filter Barriers Must Be Target-Useful, Not Merely Low-OPT.**  
Low \(\operatorname{OPT}_C\) alone is not the right event. Public constants, artificial relabelings, empirical memorization, and other-concept witnesses can make \(\operatorname{OPT}_C\) low without reducing noise relative to the hidden \(F\). The information lemma controls only the hidden-target route.

## Proof Attempts

For Lemma 1, compare the true joint law \(P_{F,T}\) to the independent coupling
\[
Q=P_F P_T.
\]
Under \(Q\), condition on \(T=t\). The selected coefficients \(a_t,b_t\) are fixed and independent of \(F\). Hoeffding gives
\[
Q(R_t(F)\ge \tau\mid T=t)
\le
\exp\left(
-\frac{\tau^2(\sum_x a_t(x))^2}{2\sum_x b_t(x)^2}
\right).
\]
Since \(|b_t|\le a_t\le L\),
\[
\sum_x b_t(x)^2\le L\sum_x a_t(x),
\]
and \(\sum_x a_t(x)\ge \alpha N\), so
\[
Q(R_T(F)\ge \tau)\le \exp(-\tau^2\alpha N/(2L)).
\]
Then apply the binary-event KL transfer from the notes:
\[
D(P_{F,T}\|Q)=I(F;T)=B
\]
implies
\[
P(E)\le \frac{B+\ln 2}{\ln(1/Q(E))}.
\]

For Lemma 2, each raw example reveals at most the capacity of a binary symmetric channel with crossover \(\eta\):
\[
I(F;X,Y)=I(F_X;Y\mid X)=\ln 2-h_2(\eta),
\]
and the chain rule gives the \(M\)-sample bound.

## Gaps And Risks

This is still a toy-model theorem. It assumes a random iid target over a finite domain, smooth filters, nontrivial filter mass, and an explicit mutual-information budget.

The largest missing piece is an oracle-output leakage model. If the weak oracle can return an arbitrary evaluable hypothesis encoding \(\Theta(N)\) target bits, then \(B\) is already large and the theorem becomes vacuous.

The theorem controls target-preserving filters \(W=a+by\). It does not cover arbitrary relabeling queries unless those are routed into public-witness, empirical/spike, other-witness, or charged-information cases.

It also does not produce a represented-class separation. Random \(F\in\{\pm1\}^N\) is a lower-bound toy object, not an efficient concept class.

## Counterexamples Or Obstructions

Spike and empirical filters evade the theorem if \(\alpha\) is tiny or \(L\) is large. This matches the existing point-mass obstruction: low-OPT queries on negligible target mass need not help global learning.

Public constants and public relabelings evade hidden-noise reasoning. They may have \(\operatorname{OPT}_C=0\) for public reasons while \(R_T(F)\) remains small.

Sign-specific cells are not a counterexample to this information lemma. They can beat aggregate agreement thresholds, but under random \(F\) a smooth selected sign-specific filter still needs transcript information to correlate with \(F\) on large mass.

## Sources Consulted

No web sources consulted.

Local sources: `problem.md`, `working_notes/canonical_summary.md`, `working_notes/claim_ledger.md`, `working_notes/lemma_bank.md`, `working_notes/failed_attempts.md`, `working_notes/counterexamples.md`, `working_notes/literature_map.md`, `working_notes/promising_directions.md`, `working_notes/iteration_summaries.md`, and `iterations/iter_003/idea_03/idea.md`.

## Recommended Next Steps

Record Lemma 1 as the clean version of D009, explicitly marked “toy-model only.”

Then define the restricted oracle model by requiring the transcript \(T\) to include raw samples, weak-oracle descriptions, all hypothesis evaluations, and the selected filter. Every non-public oracle response should be charged to \(I(F;T)\).

Finally, formalize the low-OPT taxonomy: hidden-target filters use Lemma 1; public-witness queries are target-useless unless they later leak information; empirical/spike queries are bounded by target mass; other-witness queries require a no-other-hidden-witness assumption.