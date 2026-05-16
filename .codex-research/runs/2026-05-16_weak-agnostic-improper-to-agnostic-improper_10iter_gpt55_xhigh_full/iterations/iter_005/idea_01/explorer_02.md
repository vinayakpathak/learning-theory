## Summary

The observable-residual LP idea produces a clean obstruction, not a positive residual-forcing lemma. In the finite public-cell model, public filtering plus sign relabeling can only exploit cells whose comparator posterior error is already low. Positive excess of a current predictor over a comparator does **not** force such a cell, even after refining to sign-specific cells like `(Y,g(X))`.

## Concrete Progress

A finite public residual model collapses to a simple minimax calculation.

Let public cells be indexed by `i`, with mass `p_i`, current-predictor mistake indicator `a_i = 1[g(X) != Y]` on the cell, and comparator posterior error

$$
\eta_i = \Pr[c(X) \ne Y \mid i].
$$

Then

$$
\operatorname{err}(g)-\operatorname{err}(c)
= \sum_i p_i(a_i-\eta_i).
$$

A public residual query chooses weights `w_i >= 0` and a sign relabeling `S_i in {+1,-1}`, giving label `Y' = S_iY`. The comparator error on the query is

$$
\frac{\sum_i p_i w_i q_i}{\sum_i p_iw_i},
\qquad
q_i =
\begin{cases}
\eta_i & S_i=+1,\\
1-\eta_i & S_i=-1.
\end{cases}
$$

So the best public filter/relabeling can do is

$$
\min_i \min\{\eta_i,1-\eta_i\}.
$$

Thus a residual-forcing theorem from excess alone would need excess to imply some public cell has `eta_i < gamma` or `eta_i > 1-gamma`. It does not.

## Claims Or Lemmas

**Lemma 1: Public residual minimax value.**  
In the finite public-cell model above, the minimum comparator error achievable by any nonnegative public filter and public sign relabeling is

$$
\min_i \min\{\eta_i,1-\eta_i\}.
$$

Reason: weighted averages cannot beat their smallest selected cell value, and a filter can concentrate all mass on a best cell.

**Lemma 2: Flat-posterior counterexample family.**  
For every `gamma < eta < 1/2`, choose a current predictor with mistake mass `m > eta`, e.g. `m <= 1/2`. Set every public cell’s comparator posterior to `eta`. Then

$$
\operatorname{err}(g)=m>\eta=\operatorname{err}(c),
$$

so `g` has positive excess over `c`, but every public filter/sign-relabel query has comparator error at least `eta > gamma`.

A concrete instance for `gamma=0.1`:

| public cell | mass | relation of `g` to `Y` | `Pr[c != Y | cell]` |
|---|---:|---|---:|
| `Y=+1,g=+1` | `0.35` | correct | `0.2` |
| `Y=-1,g=-1` | `0.35` | correct | `0.2` |
| `Y=+1,g=-1` | `0.15` | wrong | `0.2` |
| `Y=-1,g=+1` | `0.15` | wrong | `0.2` |

Then

$$
\operatorname{err}(c)=0.2,\qquad
\operatorname{err}(g)=0.3.
$$

But every sign-specific public cell has comparator posterior error `0.2`, and flipping labels gives error `0.8`, so no public residual query gets comparator error below `gamma=0.1`.

## Proof Attempts

The natural positive route would be:

1. Assume `err(g) > err(c)`.
2. Refine the public partition by observable signs such as `(Y,g(X))`.
3. Optimize over public filters/relabelings.
4. Hope the LP forces a cell with comparator error `< gamma`.

Step 4 fails. The excess inequality only controls the weighted average of `a_i - eta_i`; it does not force any `eta_i` to be small. The flat-posterior construction keeps all cells at the same comparator error `eta > gamma` while increasing excess solely by placing enough public mass on cells where `g` is wrong.

## Gaps And Risks

This is only a one-step public-residual obstruction. It does not rule out algorithms that first create public cells with genuinely lower comparator posterior.

It also does not handle filters depending on hidden structure inside the cells. If the algorithm can refine the partition using target-correlated information, the flat-posterior invariant may fail.

As a weak-oracle obstruction, this becomes clean only for a singleton or no-other-witness class where `OPT_C` equals comparator error. For richer classes, a query may have low `OPT_C` for public-witness reasons unrelated to the comparator.

## Counterexamples Or Obstructions

The main obstruction is the flat-posterior sign-specific counterexample above. It survives aggregate agreement/mistake filtering and also survives refinement by `(Y,g(X))`.

This strengthens the existing four-cell residual obstruction: even allowing arbitrary public weights and sign flips over the observable cells, excess over `c` alone gives no low-noise weak query.

## Sources Consulted

No web sources used.

Local run files consulted: `problem.md`, all listed `working_notes/*.md`, and `iterations/iter_005/idea_01/idea.md`.

## Recommended Next Steps

Formalize this as an LP lemma in the working notes: public residual forcing is equivalent to finding a public cell with `min(eta_i,1-eta_i)<gamma`.

Then test stronger assumptions that might make the LP positive, such as monotonicity constraints, calibrated posteriors, or a transcript invariant that forces excess mass to concentrate on low-`eta_i` cells.