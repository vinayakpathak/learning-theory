## Summary

The oracle-lower-bound version of idea_03 looks viable as a **restricted toy theorem**, not as an atlas separation. The clean statement is:

In RCN on `X=[N]` with random hidden target `F`, any adaptive algorithm that outputs smooth target-preserving public filters must already have large mutual information about `F` before it can produce a query whose hidden-target noise drops below the weak threshold `gamma`.

The core bound should be of the form

$$
\Pr[\exists t \le q:\eta_{W_t}<\gamma]
\le
\frac{B+\ln 2}{c\,\tau_{\eta,\gamma}^2\alpha N/L-\ln q},
$$

where `B = I(F; transcript)`, each filter has mass at least `alpha`, smoothness at most `L`, and

$$
\tau_{\eta,\gamma}
=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

This is a useful oracle barrier: fixed-slack weak calls cannot discover the hidden clean component through smooth public filters unless the wrapper has already learned substantial information about the hidden target.

## Concrete Progress

A plausible formal model is now clear.

Let `F in {+-1}^[N]` be uniform and labels be

$$
Y = F(X)N,\qquad \Pr[N=-1]=\eta>\gamma.
$$

A target-preserving public filter has the form

$$
W(x,y)=a(x)+b(x)y,\qquad a(x)\ge |b(x)|.
$$

For a fixed transcript-selected filter, define

$$
A=\mathbb E[a(X)],\qquad B_F=\mathbb E[b(X)F(X)],\qquad r=B_F/A.
$$

Then the accepted distribution has hidden-target noise

$$
\eta_W
=
\frac{\eta(1-r)}{1+(1-2\eta)r}.
$$

Thus the weak oracle is forced to be useful for the hidden target only if

$$
r>\tau_{\eta,\gamma}.
$$

Adaptivity can be handled by including the selected filter in the transcript and comparing the true joint law of `(F,T)` to the independent coupling `P_F P_T`.

## Claims Or Lemmas

**Lemma 1: Fixed Smooth Filter Concentration.**

Assume `F` is iid Rademacher, `0 <= a_i <= L`, `|b_i| <= a_i`, and

$$
A=N^{-1}\sum_i a_i\ge \alpha.
$$

For a fixed filter independent of `F`,

$$
\Pr_F\left[\frac{N^{-1}\sum_i b_iF_i}{A}\ge \tau\right]
\le
\exp\left(-\Omega(\tau^2\alpha N/L)\right).
$$

A direct Hoeffding calculation gives an exponent like `tau^2 alpha N/(2L)`.

**Lemma 2: Adaptive KL Transfer.**

Let `T` be the full transcript, including the chosen filter/query. If

$$
I(F;T)\le B
$$

and under the independent coupling the bad event has probability at most `e^{-lambda}`, then under the true adaptive process

$$
\Pr[E]\le \frac{B+\ln 2}{\lambda}.
$$

For `q` possible queries, use the union bound under the independent coupling, so `lambda` becomes roughly

$$
\Omega(\tau^2\alpha N/L)-\ln q.
$$

**Lemma 3: Restricted Oracle Routing.**

For each low-`OPT` query, route it into one of four cases:

1. Hidden-target smooth filter: controlled by the information lemma above.
2. Public-witness query: oracle returns the public constant/relabeling witness, leaking no hidden-target information.
3. Empirical/spike query: charge it to raw sample information or exclude it by smoothness/mass assumptions.
4. Other-witness query: requires an explicit no-other-hidden-witness assumption, or a random-code union bound.

Without this routing, “low `OPT`” is too broad for a valid lower bound.

## Proof Attempts

The main proof path is short.

First, prove the public-filter identity algebraically. Conditioning on acceptance gives numerator

$$
\Pr[Y\ne F,\text{ accepted}]
=
\eta(A-B_F)
$$

and denominator

$$
\Pr[\text{ accepted}]
=
A+(1-2\eta)B_F.
$$

Solving `eta_W < gamma` gives `B_F/A > tau`.

Second, for fixed public `a,b`, apply Hoeffding to `sum b_iF_i`. Smoothness gives

$$
\sum_i b_i^2 \le L\sum_i a_i = LAN.
$$

This yields the concentration exponent.

Third, for adaptivity, let `T` contain raw samples, oracle replies, and selected filters. Under `P_F P_T`, the selected filters are independent of `F`, so the fixed-filter concentration applies conditionally on `T`. Then use the corrected binary-event KL transfer.

A transcript budget can be bounded as

$$
B \le M(\ln 2-h(\eta)) + \text{oracle-output leakage},
$$

where `M` is the number of raw RCN samples and `h` is binary entropy in nats. Majority-constant dummy replies may leak up to `ln 2` per query unless the oracle response is made canonical in a way that avoids dependence on hidden label bias.

## Gaps And Risks

This does not prove the atlas implication false. It is only a restricted oracle barrier.

The theorem needs explicit assumptions on smoothness, minimum mass, query grammar, and oracle-output representation. If returned hypotheses are arbitrary evaluable objects, their off-query behavior could encode hidden bits unless the adversarial oracle is defined canonically.

The biggest mathematical gap is the “other witness” case. Low `OPT_C` need not mean low noise relative to the planted `F`; another concept may fit the query.

A final learner lower bound would also need a recovery argument, probably Fano-style: achieving error `eta+epsilon` in RCN recovers `F` to error `epsilon/(1-2eta)`. That endpoint was not completed here.

## Counterexamples Or Obstructions

The public-constant filter `W(x,y)=1[y=+1]` can make labels publicly constant. If constants are allowed as improper outputs, the oracle can answer without revealing `F`.

Spike and empirical-support queries can have low `OPT` after seeing samples, but they cover too little target mass unless the marginal has heavy atoms.

Artificial relabeling by a public hypothesis creates low-`OPT` queries unrelated to the hidden target.

The all-functions/random-target toy model is not an efficient represented-class separation. It is useful for an oracle barrier, not directly for the atlas edge.

## Sources Consulted

No web search used.

Local run files consulted: [problem.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/problem.md), [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md), [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md), [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md), and [idea.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/iterations/iter_003/idea_03/idea.md).

## Recommended Next Steps

Formalize the restricted theorem with exact constants and an explicit oracle strategy.

Then add the missing induction: until a hidden-target query occurs, all oracle replies are public/dummy/spike-routed and contribute only the charged information budget.

Finally, prove or isolate the no-other-witness assumption, perhaps first for a random-code concept class with a union bound over non-target concepts.