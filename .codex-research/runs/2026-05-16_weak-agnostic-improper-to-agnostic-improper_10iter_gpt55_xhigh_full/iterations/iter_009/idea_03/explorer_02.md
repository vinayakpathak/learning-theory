## Summary

Under the selector-hardness lens, the idea gives a real black-box obstruction but still does not produce literal DCHP-generated Set-Cover hardness.

The supported core is: a semantically valid fixed-slack weak learner can hide arbitrary sparse-majority selector columns on rare key slices. If a generated-bag procedure is forced to include many such columns on one common slice, then the final DCHP selector class `sign(B^(T))` can contain a Set-Cover-hard empirical ERM instance. The obstruction is strongest against claims like “generated bags are automatically benign because every base hypothesis came from a valid weak learner.”

The main gap is that the simple rare-slice construction makes the hard rows off-query or low-mass junk. Turning that into actual DCHP hardness requires controlling common-key hits, adaptivity, validation-sample population relevance, extra generated columns, constants/offset columns, and DCHP’s internally chosen `T`.

## Concrete Progress

A useful decomposition is:

1. **Standalone generated-bag selector obstruction:** plausible and essentially works under artificial scheduling.
2. **Actual DCHP-generated-bag hardness:** still blocked by several compatibility conditions.

For the standalone obstruction, take the singleton class `C={+1}` over a keyed domain. A weak output `h_{R,j}` equals `+1` off key slice `R` and encodes arbitrary column `j` on slice `R`. For any weak-call query `Q`,
\[
\operatorname{err}_Q(h_{R,j})
\le OPT_C(Q)+Q[key=R].
\]
If `R` is random and the slice is low-mass, this is `OPT+beta` valid while the on-slice behavior is arbitrary.

Thus, if a bag generator can be made to output the columns of a Set-Cover gadget on the same slice, the final proper ERM over
\[
V_{B,T}=\operatorname{sign}(B^{(T)})
\]
inherits the known Set-Cover hardness for arbitrary bags.

The new selector-hardness audit is that **stateful common-key scheduling** and **stateless independent-key scheduling** have different failure modes:

- Stateful common-key scheduling can put all columns on one hard slice, but is only safe if later weak-call query distributions cannot adaptively concentrate on the revealed key.
- Stateless independent-key scheduling is safer against adaptive queries, but coupon/key accounting makes it unlikely to get all needed columns on one common slice at the confidence levels needed for semantic validity.

## Claims Or Lemmas

**Lemma 1: Common-Key Pollution For Oblivious Calls.**

Suppose a generated-bag wrapper makes `q` weak calls whose query distributions `Q_1,...,Q_q` are fixed independently of a hidden key `R`. Let `R` be uniform in `K`, and output scheduled columns `h_{R,j_t}` that equal `+1` off `{key=R}`. Then
\[
\Pr_R[\exists t: Q_t[key=R]>\tau]
\le \frac{q}{|K|\tau}.
\]
So with `|K| >= q/(tau delta)`, all scheduled outputs are `OPT+tau` perturbations of the baseline constant with probability at least `1-delta`.

This supports generated-bag pollution for nonadaptive or output-oblivious DCHP-like bag generation.

**Lemma 2: Stateless Keys Do Not Naturally Build One Hard Bag.**

If each weak output chooses an independent fresh key, then each call is valid conditional on the past by the rare-slice Markov argument. But to make all Set-Cover columns appear on the same key, one needs coupon collection over keys. With per-call confidence `delta_0` and `|K| roughly 1/(tau delta_0)`, the expected same-key load is too small for a growing Set-Cover instance unless the call budget is inflated substantially.

This explains the confidence-versus-key-hit obstruction.

**Lemma 3: Constants And Offset Columns Are Artificially Available.**

In the rare-slice model, the Set-Cover offset column and `+1` constant can be scheduled as weak outputs: off the hard slice they are `+1`, and on the slice they have the required gadget values. Thus constants/offsets are not the main obstruction in the artificial model.

They remain a DCHP-compatibility issue because the actual proof may not append these columns in the right form.

## Proof Attempts

The strongest attempted construction is:

- Use a keyed domain `X=K x U`.
- Fix a Set-Cover instance with empirical rows indexed by `U`.
- A stateful weak learner samples one hidden key `R`.
- On scheduled weak call `j`, it outputs a hypothesis equal to the `j`-th Set-Cover gadget column on `{R} x U` and equal to `+1` elsewhere.
- Include the offset/constant columns as scheduled outputs.
- Run the final selector on empirical rows supported on `{R} x U`.

For a selector primitive that accepts an arbitrary empirical sample after seeing the generated bag, this realizes the arbitrary-bag Set-Cover hardness.

For actual DCHP, the proof attempt stalls because the selector sample is not chosen after seeing `R`; it is drawn from the learning distribution. If the hard slice has tiny mass, the empirical selector may not contain enough hard rows. If it has large mass, the weak-call distributions may also see it, invalidating the rare-slice modification.

## Gaps And Risks

The main risks are:

- **Adaptivity:** if the wrapper can infer `R` from previous hypotheses, it can query the slice and break future stateful outputs.
- **Population relevance:** hard rows on a rare slice may only create empirical selector hardness, not learning hardness.
- **Extra columns:** actual DCHP generation may add columns not in the Set-Cover gadget; these could destroy no-cover instances.
- **`T` alignment:** Set-Cover gadgets need `T=2k` or `2k-1`; DCHP computes `T` from boosting parameters, so reduction control is unclear.
- **Confidence/key accounting:** making rare-slice validity high probability pushes `|K|` up, while seeing enough hard rows on the selected key pushes `|K|` down.
- **Improper escape:** even if proper ERM over `sign(B^(T))` is hard, an unconstrained improper final learner may ignore the bag or memorize empirical rows.

## Counterexamples Or Obstructions

The strongest obstruction is that rare-slice hard rows can be pure off-query junk. They can make proper empirical selection over the generated bag hard without affecting the population risk that a class-aware learner needs to optimize.

A second obstruction is the stateless-key coupon failure: independent rare keys preserve weak validity against adaptive calls, but they do not naturally assemble a full Set-Cover matrix on one common slice.

A third obstruction is that the singleton class `C={+1}` is trivially strongly learnable. Therefore this construction cannot be an atlas separation by itself; it only attacks black-box reductions that insist on using the polluted generated bag and exact sparse-majority selector.

## Sources Consulted

Local run files only; no web search.

Key local sources: `problem.md`, `working_notes/canonical_summary.md`, `working_notes/claim_ledger.md`, `working_notes/lemma_bank.md`, `working_notes/failed_attempts.md`, `working_notes/counterexamples.md`, `working_notes/literature_map.md`, `working_notes/promising_directions.md`, `working_notes/iteration_summaries.md`, and `iterations/iter_009/idea_03/idea.md`.

External background named in the local notes: Downey-Fellows 1995 on W-hierarchy Set Cover hardness, Feige 1998 on Set Cover approximation, and the da Cunha-Hogsgaard-Paudice DCHP boosting audit as recorded in the run memory.

## Recommended Next Steps

Formalize the common-key lemma for **oblivious generated-bag procedures** as a scoped black-box selector obstruction.

Then write a separate impossibility note for the **stateless independent-key version**, showing why confidence and coupon collection fight each other.

For actual DCHP compatibility, audit only these concrete points next: whether weak-call distributions are output-oblivious, whether final ERM rows can have non-negligible mass on the programmed slice without invalidating weak calls, whether extra generated columns are harmless, and whether `T` can be matched to the Set-Cover budget.