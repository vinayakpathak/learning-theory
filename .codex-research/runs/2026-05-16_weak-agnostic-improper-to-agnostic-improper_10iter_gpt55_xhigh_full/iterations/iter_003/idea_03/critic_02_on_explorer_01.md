## Summary

The explorer’s core algebra survives as a restricted toy-model lemma: for smooth target-preserving filters in RCN, lowering hidden-target noise below `gamma` requires correlation with the random target, and an adaptive KL-transfer argument can bound this unless the transcript carries enough information about the target.

It does **not** yet support an atlas separation or a broad black-box lower bound. The dangerous step is moving from “hidden-target noise is low” to “the weak oracle must reveal hidden-target information whenever `OPT_C` is low.” That step is still blocked by public witnesses, spike/empirical queries, other concepts, and oracle-output leakage.

## Issue List

1. **Plausible but incomplete:** The public-filter identity is correct under the stated target-preserving model:
   $$
   W(x,y)=a(x)+b(x)y,\quad a\ge |b|,\quad Y=F(X)N.
   $$
   The formula
   $$
   \eta_W=\frac{\eta(1-r)}{1+(1-2\eta)r},
   \qquad r=\frac{\mathbb E[b(X)F(X)]}{\mathbb E[a(X)]}
   $$
   and the threshold
   $$
   r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
   $$
   check out.

2. **Missing assumption:** The concentration lemma needs explicit normalization. Something like `0 <= a_i <= L`, `A >= alpha`, `|b_i| <= a_i` is enough, but the theorem must say whether filters are acceptance probabilities, importance weights, or normalized smooth measures. Otherwise scaling and spike filters make the statement ambiguous or vacuous.

3. **Plausible but incomplete:** The adaptive KL transfer is locally valid, but the event should be formulated with a stopping-time/pre-query transcript. If the full transcript includes oracle replies after the bad query, the information budget may charge consequences of the event rather than information available before selecting the filter.

4. **Fatal gap for oracle lower bound:** Low hidden-target noise is not equivalent to low `OPT_C`, and low `OPT_C` is not equivalent to hidden-target usefulness. Public constants, artificial relabelings, empirical memorization, and other concepts can certify low `OPT_C` without forcing correlation with `F`.

5. **Fatal gap for atlas relevance:** The allowed query family is far narrower than reductions may use. A real wrapper can reweight, relabel, condition on previous hypotheses, query empirical distributions, or construct artificial labels. The theorem only covers target-preserving filters with labels left as `Y`.

6. **Missing assumption:** Oracle-output leakage is not controlled. An arbitrary legal weak oracle can encode hidden bits in off-query behavior or in an over-rich improper hypothesis representation. A lower bound must either define an adversarial canonical non-leaking oracle or bound output descriptions/information per reply.

7. **Plausible but incomplete:** The raw-sample information budget
   $$
   B\le M(\ln 2-h(\eta))+\text{oracle leakage}
   $$
   is reasonable for uniform `X=[N]`, but the final theorem needs a parameter regime such as `M,q << N` or the bound is vacuous.

8. **Unsupported as stated:** “Any adaptive algorithm” is too broad. The proved ingredients support only “any adaptive algorithm whose pre-bad-query transcript has information at most `B` and whose selected queries are smooth target-preserving public filters of mass at least `alpha`.”

## Counterexamples Or Stress Tests

- **Public constant filter:** `W(x,y)=1[y=+1]` makes accepted labels constant. If constants or public witnesses are in `C`, then `OPT_C=0` for public reasons, while hidden-target noise need not be below `gamma`.

- **Spike query:** after seeing `(x,y)`, query the point mass on `(x,y)`. For many rich classes this has `OPT_C=0`, but it has no useful global target mass. It violates smoothness/mass assumptions, so the theorem must explicitly exclude or route it.

- **Artificial relabeling:** define query labels by a public hypothesis `g`. If some concept fits `g`, the weak oracle can return public information only.

- **Other-witness query:** even if hidden `F` has high noise on a query, another concept in `C` may fit it. The random-target argument needs a no-other-witness assumption or a union bound over a precisely represented class.

## Literature Or Known-Result Conflicts

No direct conflict with the run ledger. The report is consistent with C014/L012 and L014.

The main conflict is with earlier recorded obstructions if the result is oversold: O003/O004/O012 already show that low-`OPT` queries can be public, empirical, or artificial rather than hidden-target revealing. The explorer acknowledges this, but the proposed “restricted oracle routing” is still only a taxonomy, not a lemma.

## What Survives The Critique

The following is worth preserving:

- fixed smooth-filter concentration for random `F`;
- adaptive KL transfer using independent coupling;
- the threshold identity for target-preserving filters;
- the view that crossing the weak threshold via smooth public filters requires target information;
- the need to classify low-`OPT` queries by source: hidden-target, public-witness, empirical/spike, other-witness.

## Recommended Next Checks

1. State a precise stopped-process theorem: bound the probability that the **next selected pre-query filter** crosses the hidden-noise threshold.

2. Define the oracle model explicitly: canonical dummy replies, output description limits, and what information is charged per reply.

3. Prove the routing lemma only in a restricted class model first, perhaps `C={F}` or a random-code class with a union bound.

4. Separate the final theorem into two claims: hidden-target filter barrier, then recovery/Fano lower bound. Do not merge them until both are proved.