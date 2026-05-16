## Summary

The finite LP lens gives a clean negative result for this idea as a one-step residual-forcing lemma.

In a finite public-cell model, arbitrary public filters and sign relabelings can only exploit variation in the public posterior of the comparator. Positive excess
\[
\operatorname{err}(g,Y)>\operatorname{err}(c,Y)
\]
does **not** force any public cell, even sign-specific cells of \((Y,g(X))\), to have comparator error below the weak threshold \(\gamma\).

## Concrete Progress

Let \(G\in[k]\) be the public finite partition, refined enough to include \(Y\) and \(g(X)\). For each cell \(i\), define
\[
u_i=\Pr[G=i,\ c(X)=Y],\qquad v_i=\Pr[G=i,\ c(X)\ne Y],\qquad p_i=u_i+v_i.
\]

A public filter/relabeling chooses weights \(w_i\ge 0\) and signs \(s_i\in\{\pm1\}\), with query label \(Y'=s_iY\) on cell \(i\). The comparator error on the query is
\[
\frac{\sum_i w_i\big(1_{s_i=1}v_i+1_{s_i=-1}u_i\big)}
{\sum_i w_i p_i}.
\]

Since this is a weighted average, the best possible public query has comparator error
\[
\min_i \frac{\min\{u_i,v_i\}}{p_i}.
\]

Thus “no public residual query has comparator error below \(\gamma\)” is exactly the finite linear condition
\[
u_i\ge \gamma p_i,\qquad v_i\ge \gamma p_i
\]
for every public cell \(i\).

This condition is compatible with positive excess. Pick any
\[
\gamma<\eta<m\le \frac12.
\]
Let \(\Pr[g(X)\ne Y]=m\), and set
\[
\Pr[c(X)\ne Y\mid G=i]=\eta
\]
for every sign-specific public cell \(i\). Then
\[
\operatorname{err}(c,Y)=\eta,\qquad \operatorname{err}(g,Y)=m,
\]
so \(g\) has positive excess \(m-\eta\), but every public filter and sign relabeling has comparator error at least \(\eta>\gamma\).

Concrete numeric witness:
\[
\gamma=0.10,\qquad \eta=0.15,\qquad m=0.20.
\]
Then \(g\) is still better than random, \(c\) is better than \(g\), but no one-step public residual query reaches comparator error below \(0.10\).

## Claims Or Lemmas

**Lemma 1: Exact finite-cell residual optimum.**  
In the finite public partition model above, the minimum comparator error achievable by any public nonnegative filter and sign relabeling is
\[
\min_i \frac{\min\{u_i,v_i\}}{p_i}.
\]

**Status:** proved in this finite model.

**Lemma 2: Positive excess does not force a low-noise public cell.**  
For every \(\gamma<1/2\), there are finite-cell distributions with
\[
\operatorname{err}(g,Y)>\operatorname{err}(c,Y)>\gamma
\]
such that every public filter/relabeling query has comparator error at least \(\operatorname{err}(c,Y)>\gamma\).

**Status:** proved in this finite model.

## Proof Attempts

The natural positive LP proof would try to combine excess
\[
\sum_i p_i\ell_i-\sum_i v_i>0
\]
with the no-low-query constraints
\[
u_i,v_i\ge \gamma p_i.
\]

But these imply only
\[
\operatorname{err}(c,Y)=\sum_i v_i\ge \gamma.
\]
They do not contradict positive excess, because one may take the current predictor’s loss \(m\) slightly larger than the constant comparator posterior \(\eta>\gamma\).

If additionally \(\operatorname{err}(g,Y)\le 1/2\), the no-low-query constraints only bound the possible excess by
\[
\operatorname{err}(g,Y)-\operatorname{err}(c,Y)\le \frac12-\gamma,
\]
which is too weak to drive boosting-style progress.

## Gaps And Risks

This is not an atlas separation. It rules out only a one-step residual-forcing argument in a fixed public finite partition.

The obstruction assumes the public sigma-field has not already created posterior variation in where \(c\) agrees with \(Y\). If the transcript contains richer information, repeated-coordinate denoising, class structure, or posterior-biased regions, the constant-posterior witness no longer applies.

Failure to find a low-error query for comparator \(c\) does not rule out low-\(\operatorname{OPT}_C\) queries for other reasons, such as public constants, artificial relabelings, empirical queries, or other concepts.

## Counterexamples Or Obstructions

The main obstruction is constant public posterior noise:
\[
\Pr[c(X)\ne Y\mid Y,g(X)] = \eta
\]
for all sign-specific cells, with
\[
\gamma<\eta<\Pr[g(X)\ne Y]\le 1/2.
\]

Then every public cell has comparator error \(\eta\) if labeled by \(Y\), and \(1-\eta\) if relabeled by \(-Y\). Hence every public filter/relabeling has comparator error at least \(\eta>\gamma\), despite positive excess over \(c\).

This directly strengthens the existing public-posterior obstruction by showing that positive excess is compatible with the obstruction.

## Sources Consulted

No web sources consulted.

Local run files consulted: `problem.md`, `working_notes/canonical_summary.md`, `working_notes/claim_ledger.md`, `working_notes/lemma_bank.md`, `working_notes/failed_attempts.md`, `working_notes/counterexamples.md`, `working_notes/literature_map.md`, `working_notes/promising_directions.md`, `working_notes/iteration_summaries.md`, and `iterations/iter_005/idea_01/idea.md`.

## Recommended Next Steps

Record this as a finite-LP obstruction to one-step public residual forcing: excess alone does not imply a weak-callable low-noise residual.

If continuing this direction, extend the LP to include additional assumptions one at a time: calibrated current predictors, minimum query mass, smoothness, posterior variation, or multi-step transcript information.

For a positive residual lemma, the needed extra hypothesis must explicitly force some public cell to have
\[
\Pr[c(X)\ne Y\mid G=i]<\gamma.
\]
Excess over \(c\) alone cannot do that.