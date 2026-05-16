## Summary

Rare-slice generated-bag pollution gives a real black-box obstruction, but I do not see a completed compatibility proof for the literal DCHP bag generator.

The clean statement is: if a DCHP-style generator makes weak calls whose query distributions put at most `tau < beta` mass on a hidden hard block, then a semantically valid fixed-slack weak learner can output hypotheses that are arbitrary on that block and benign elsewhere. The generated bag can then contain an arbitrary sparse-majority selector instance, including the Set-Cover gadgets from the ledger.

The obstruction is scoped. Actual DCHP-style tuple enumeration may create spike or empirical weak calls putting mass `1` on any hard-slice sample point. If so, the rare-slice legality argument breaks exactly where final selector hardness becomes population-relevant.

## Concrete Progress

A useful abstraction is the following.

Let `C={+1}` on a keyed domain `X=K x U`. Fix a hard block `S={R} x U`, or more generally a small keyed subset. For any programmed column `b_j: S -> {+-1}`, define

$$
h_j(x)=
\begin{cases}
b_j(x), & x\in S,\\
+1, & x\notin S.
\end{cases}
$$

For any weak-call distribution `Q` over `X x {+-1}`,

$$
\operatorname{err}_Q(h_j)-\operatorname{err}_Q(+1)\le Q_X(S).
$$

Since `+1 in C`, `err_Q(+1)=OPT_C(Q)`. Therefore if `Q_X(S)<=beta`, every such arbitrary programmed column is a legal `OPT+beta` weak output.

Thus semantic weak correctness alone imposes no structure on a generated bag over a block that is light under all weak-call distributions.

## Claims Or Lemmas

**Lemma 1: Query-light block pollution.**  
Suppose a bag generator makes weak calls `Q_1,...,Q_q`, and there is a block `S` such that `Q_t(S)<=tau<=beta` for every realized call. For `C={+1}`, an oracle may return any hypotheses that equal `+1` off `S` and are arbitrary on `S`, while satisfying every fixed-slack weak guarantee.

**Lemma 2: Random hidden block version.**  
If `S` is selected uniformly from a large key family and the call schedule is nonadaptive to `S`, then

$$
\Pr[\exists t: Q_t(S)>\tau]\le q/(|K|\tau)
$$

for one-key slices. More generally, for block families with expected query mass `mu`, Markov gives failure at most `q mu/tau`.

This can be extended with a posterior min-entropy condition on `S`: if the transcript before call `t` leaves posterior max-probability at most `2^b/|K|`, then the same bound degrades to `2^b/(|K|\tau)` for that call.

**Lemma 3: Selector-hard bag embedding under query-lightness.**  
On the common block `S`, program the columns to match the accepted Set-Cover sparse-majority gadget for `sign(B^(T))`, including a programmed offset column or a public `+1` constant variant. Off `S`, all columns equal `+1`. If all weak calls are `S`-light, the bag is weak-valid but its exact sparse-majority ERM over rows in `S` is as hard as the arbitrary-bag instance.

## Proof Attempts

The positive pollution construction works in a standalone black-box model:

1. Choose a hidden hard block `S`.
2. Program all generated weak hypotheses to be `+1` outside `S`.
3. On `S`, use the Set-Cover matrix columns from the sparse-majority gadget.
4. Ensure every weak-call distribution has mass at most `tau<beta` on `S`.
5. Then every weak output is legal, but the final selector sees an arbitrary hard sparse-majority instance on `S`.

For iid final-row realization, put mass `alpha` on `S` and distribute it over the gadget rows. With `alpha` constant below the weak-call lightness threshold, polynomially many final examples realize the gadget rows with high probability. The empirical selector gap is scaled by `alpha`, but remains inverse-polynomial for polynomial-size gadgets.

The attempted DCHP compatibility proof fails at the query-lightness condition. If DCHP enumerates ordered weak samples from the same empirical pool and repetitions are allowed, then any hard-slice point in the weak-sample pool can induce a tuple-supported call with `Q(S)=1`. Arbitrary behavior on `S` is then no longer legal.

## Gaps And Risks

The construction needs a block that is final-relevant but weak-call-light. This is plausible for smooth nonadaptive generators, but not automatic for DCHP.

A common hidden block across many columns needs either stateful oracle scheduling, a shared hidden seed, or a nonadaptive call schedule. Independent stateless rare slices do not produce one coherent Set-Cover matrix.

If the returned hypothesis representation exposes the key `R`, an adaptive wrapper can focus later calls on the hard slice. That does not invalidate past outputs, but it prevents collecting many polluted columns unless the generator is nonadaptive or leakage is explicitly budgeted.

Extra generated columns can destroy no-cover soundness unless they are duplicates, constants, or otherwise controlled.

This remains a selector obstruction, not an atlas separation. The toy class `C={+1}` is strongly learnable by ignoring the polluted bag.

## Counterexamples Or Obstructions

The main obstruction to literal DCHP compatibility is tuple concentration:

If a DCHP-style generator enumerates all ordered `m_0`-tuples from a weak-sample half, and even one sampled point lies in `S`, then the repeated tuple on that point gives a weak-call distribution supported inside `S`. The rare-slice programmed hypothesis may have arbitrary error there, so the `OPT+beta` guarantee can fail.

Trying to make `S` so rare that the weak-sample half misses it also makes iid final realization of a large Set-Cover gadget unlikely, unless the final mass/gap is only inverse-polynomial and the sample split is carefully engineered. That may still yield a selector-stress test, but not a clean population-level DCHP obstruction.

## Sources Consulted

No web sources consulted.

Local files read: `problem.md`, all requested `working_notes/*.md` files, and `iterations/iter_009/idea_03/idea.md`.

## Recommended Next Steps

Formalize the query-light block pollution lemma as a standalone black-box theorem.

Then audit literal DCHP calls for the key dichotomy: are weak-call distributions smooth enough that a constant-mass hard block can stay below `beta`, or does tuple enumeration create spike calls with `Q(S)=1`?

A useful next lemma would be the negative one: under all-ordered-tuple enumeration with repetitions, any final-relevant hard block appearing in the weak-call sample pool breaks rare-slice legality. That would cleanly delimit this idea as a black-box selector obstruction rather than a DCHP lower bound.