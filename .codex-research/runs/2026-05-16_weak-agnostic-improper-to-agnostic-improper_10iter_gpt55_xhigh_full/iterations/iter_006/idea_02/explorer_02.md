## Summary

The general residual low-`OPT` lemma is false in the natural population/public-sigma-field model. Positive excess of a current predictor over a comparator does not force any public randomized filtering/relabeling query to have `OPT_C < gamma`, unless the public transcript already contains a low-posterior tail for the comparator or the query is low-`OPT` for public/irrelevant reasons.

The cleanest obstruction is a flat-posterior construction: every public cell has comparator-noise `eta` with `gamma < eta < 1/2`, while the current predictor has larger error `m > eta`. Then every randomized public residual query still has comparator error at least `eta`, despite positive excess.

## Concrete Progress

I generalized the existing public-filter obstruction from sign relabelings to arbitrary public randomized relabeling kernels.

Let `Z` be the public observation available to the residual scheme, including the current predictor value, observed label, transcript, and internal randomness, but not the hidden comparator. A general public relabel/filter query can be written by nonnegative weights `w_+(Z), w_-(Z)`, producing query label `+1` or `-1`.

For a fixed comparator `c`, write

$$
p(Z)=\Pr[c(X)=+1\mid Z],\qquad u(Z)=\min\{p(Z),1-p(Z)\}.
$$

Then the comparator error on the induced query is

$$
\frac{
E[w_+(Z)(1-p(Z))+w_-(Z)p(Z)]
}{
E[w_+(Z)+w_-(Z)]
}
\ge
\frac{E[(w_+(Z)+w_-(Z))u(Z)]}{E[w_+(Z)+w_-(Z)]}.
$$

Thus public randomized relabeling can only exploit public cells where the comparator label is already predictable with error below `gamma`. If `u(Z) >= gamma` everywhere, no such query makes `c` a below-`gamma` witness.

## Claims Or Lemmas

**Lemma 1: Public Kernel Lower Bound.**  
In the sigma-field model above, every public randomized filter/relabeling has comparator error at least the weighted average of `u(Z)=min{Pr[c=+1|Z],Pr[c=-1|Z]}` over its accepted mass.

Status: proved in this model.

**Lemma 2: Flat Posterior Excess Counterexample.**  
For any

$$
\gamma<\eta<m\le 1/2,
$$

there is a finite public-cell distribution with a comparator `c` and binary predictor `g` such that

$$
\operatorname{err}(c,Y)=\eta,\qquad
\operatorname{err}(g,Y)=m,
$$

but every public randomized filtering/relabeling based on `(Y,g)` has comparator error at least `eta > gamma`.

Status: proved as a population obstruction.

**Important limitation.**  
This proves a comparator-error obstruction. To turn it into an `OPT_C` obstruction, one needs either `C={c}` as a toy model or a no-other-witness/random-code condition ensuring no other concept fits the public query below `gamma`.

## Proof Attempts

Use public cells indexed by `(Y,g(X))`. Give total mass `1-m` to cells where `g=Y` and mass `m` to cells where `g=-Y`. Inside every cell, set

$$
\Pr[c(X)\ne Y\mid Y,g]=\eta.
$$

Then `c` has error `eta`, while `g` has error `m`, so the excess is `m-eta`.

But conditional on every public cell, the best public label for predicting `c(X)` is the observed label `Y`, and it still errs with probability `eta`. Filtering can concentrate on any public cell or randomized mixture of cells, but all cells have the same posterior uncertainty. Relabeling away from `Y` only increases comparator error to `1-eta`.

Therefore no public residual query based only on `(Y,g)` crosses the weak threshold `gamma`.

## Gaps And Risks

This does not rule out schemes that first create public posterior variation about `c`, for example through repeated-coordinate denoising, class structure, or genuine information in oracle outputs.

It also does not rule out public low-`OPT` queries. A scheme can relabel by a public hypothesis or concentrate on empirical/spike supports; those may have low `OPT_C` for reasons unrelated to the hidden comparator and need separate routing.

The unrestricted sample-dependent version is too broad as stated. Point-mass queries on observed samples can have realized low `OPT`, and repeated samples on finite domains can estimate hidden labels. A serious negative theorem needs smoothness, target-mass, or information-budget assumptions.

## Counterexamples Or Obstructions

The flat-posterior construction refutes any lemma of the form:

> If current `F` has excess over `c`, then some public residual filter/relabeling has `OPT_C < gamma`.

It remains false even with arbitrary randomized relabeling kernels, not just mistake filters or sign flips.

A second obstruction is public-witness low `OPT`: if the scheme defines query labels using a public anchor or current predictor and that witness is in `C`, the weak oracle may return the public witness and yield no descent.

A third obstruction is empirical/spike querying: unrestricted sample-dependent schemes can manufacture tiny low-`OPT` queries that carry negligible target mass, so “low `OPT` somewhere” is too weak a target.

## Sources Consulted

Only the project-local files requested by the prompt:

- `problem.md`
- `working_notes/canonical_summary.md`
- `working_notes/claim_ledger.md`
- `working_notes/lemma_bank.md`
- `working_notes/failed_attempts.md`
- `working_notes/counterexamples.md`
- `working_notes/literature_map.md`
- `working_notes/promising_directions.md`
- `working_notes/iteration_summaries.md`
- `iterations/iter_006/idea_02/idea.md`

No web search was used.

## Recommended Next Steps

Formalize the public-kernel lemma as the randomized version of the existing public-posterior residual lemma.

Then decide whether the intended residual lemma includes sample-dependent/spike queries. If yes, add a routing taxonomy: hidden-target useful, public-witness, empirical/spike, and other-concept witness.

For a stronger counterexample, try a smooth random-code/no-other-witness upgrade: over a huge domain, show that for any polynomial family of smooth public kernels, neither the planted comparator nor random distractor concepts have error below `gamma` on the public residual queries, while positive excess still holds.