## Summary

The reduction lens gives a conditional black-box obstruction, not a full generated-bag hardness theorem.

I found a plausible way to realize Set-Cover-style sparse-majority columns as outputs of a semantically valid fixed-slack weak learner, but only under an extra “benign weak-call” condition: the DCHP-style generator must call the weak learner on distributions where each programmed column’s disagreement region has small mass, while the final selector still evaluates those columns on the hard rows.

Rare-slice junk alone does not close the loophole. It inflates `Range(A)` and can encode arbitrary matrices off-query, but turning that into selector hardness for actual DCHP-generated bags requires controlling how weak-call query distributions relate to the final ERM sample.

## Concrete Progress

A useful conditional realization template is:

- Use a trivial class, e.g. `C={-1}`.
- Given set-system columns, define improper weak outputs
  $$
  h_j(x)=
  \begin{cases}
  +1,& x\in S_j,\\
  -1,& x\notin S_j.
  \end{cases}
  $$
- If a query distribution `Q` has `Q(S_j)<=tau`, then
  $$
  \operatorname{err}_Q(h_j)\le \operatorname{err}_Q(-1)+\tau
  = \operatorname{OPT}_C(Q)+\tau.
  $$
  Thus for `tau<beta`, `h_j` is a legal fixed-slack weak answer.
- A holdout-gated learner can return `h_j` only when it empirically certifies `Q(S_j)` is small, and otherwise return the baseline `-1`.

This can generate the set columns in the constant-column Set-Cover gadget from L034, provided the final bag also contains a usable `+1` filler/constant column. That last point is an extra assumption: either DCHP appends constants, or the weak learner is queried on some distribution where `+1` is also a legal response.

## Claims Or Lemmas

**Conditional Lemma: Benign-Call Bag Realization.**  
Fix `tau<beta`. Suppose a DCHP-style bag generator makes, for every desired set column `S_j`, at least one weak call to a distribution `Q_j` with `Q_j(S_j)<=tau`, and includes the returned hypothesis in the final bag. Then there is a semantically valid improper `OPT+beta` weak learner for the singleton class `C={-1}` whose generated bag contains all the programmed set columns.

**Conditional Consequence.**  
If the generated bag also contains the required `+1` filler/constant column, then the Set-Cover sparse-majority ERM gadget from L034 embeds into this generated bag. Any proper exact or inverse-polynomial additive selector that works for all such generated bags would solve the corresponding Set-Cover instances.

**Scope.**  
This is a black-box/generated-bag obstruction. It is not a separation of weak and strong learning, since the singleton/constant class is strongly learnable by ignoring the pathological weak learner.

## Proof Attempts

The main reduction attempt is to combine L034 with rare-support weak outputs.

For the constant-column Set-Cover gadget, element rows are positive, the dummy row is negative, set columns indicate membership, and a `+1` filler supplies the offset. The set columns can be made legal weak outputs for `C={-1}` whenever their positive support has small mass under the weak-call query.

The weak learner can be made distribution-free valid by gating:

1. choose or receive a programmed column index `j`;
2. estimate `Q(S_j)` on a holdout sample;
3. return `h_j` only if the estimate is below a safe threshold;
4. otherwise return the baseline `-1`.

This preserves the PAC guarantee for all query distributions. The generated-bag hardness reduction succeeds only if the DCHP skeleton supplies enough low-mass calls to expose all columns anyway.

## Gaps And Risks

The crucial unproved step is actual DCHP compatibility. The known DCHP procedure may generate weak calls whose distributions are tied to the same empirical rows used for final selection. If a call concentrates on `S_j`, the holdout-gated learner must refuse to output `h_j`.

The `+1` filler column is not automatic. Prior notes already flag “audit whether DCHP can append constants” as a necessary follow-up.

Rare-slice junk with a fresh random key per output gives high range/dual-VC, but the columns may not align on a common selector sample. A common rare key aligns columns, but an adaptive wrapper can potentially discover and concentrate on it.

Even if empirical selector hardness is embedded, the resulting hard rows may be pure off-query junk with no clean-population significance. That blocks a generic selector primitive but does not refute a proof that uses generated-bag structure plus validation/generalization differently.

## Counterexamples Or Obstructions

If the weak-call and final-selector distributions are the same and every hard column has large support under that distribution, the legality argument fails: returning that column may add more than `beta` error.

If the hard matrix is encoded only on zero-mass or tiny-mass off-query points, empirical ERM can be hard while population risk is unaffected. This is an overfitting obstruction, not a learning lower bound.

If the underlying class is trivial, a class-aware or white-box wrapper can ignore the supplied weak learner entirely.

## Sources Consulted

No web search used.

Consulted project-local files:

- `problem.md`
- `working_notes/canonical_summary.md`
- `working_notes/claim_ledger.md`
- `working_notes/lemma_bank.md`
- `working_notes/failed_attempts.md`
- `working_notes/counterexamples.md`
- `working_notes/literature_map.md`
- `working_notes/promising_directions.md`
- `working_notes/iteration_summaries.md`
- `iterations/iter_008/idea_03/idea.md`
- prior iteration-7 sparse-majority and rare-slice reports

## Recommended Next Steps

Audit the actual DCHP bag-generation step for two facts:

1. whether constants are appended or cheaply generated;
2. whether, for every desired programmed column, there are low-mass weak calls that still place the column into the final bag.

If both hold, formalize the benign-call realization lemma as a generated-bag Set-Cover reduction. If either fails, record this idea as a black-box obstruction to generic selectors, not as hardness for actual DCHP-generated bags.