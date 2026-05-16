## Summary

The convex-duality version of idea_03 gives a clean diagnostic, but it does not prove the desired low-OPT chunk lemma. The main obstruction is sharp: convex duality can identify the best lower tail of the comparator’s public posterior error, but excess error of the current classifier does not force that lower tail below the weak threshold `gamma`.

So the proposed lemma is false as stated unless “public filter family” already contains target information, or unless an extra hypothesis guarantees low-posterior-error public cells.

## Concrete Progress

Let `c` be a near-optimal comparator and let a public filter/relabeling choice produce a nonnegative weight `W` and query label `Y'`. A low-OPT chunk for `c` means

\[
\frac{\mathbb E[W 1[c(X)\ne Y']]}{\mathbb E[W]} \le \gamma-\alpha.
\]

For a fixed public sigma-field `G` and fixed public relabeling, write

\[
m=\mathbb E[1[c(X)\ne Y']\mid G].
\]

Then public filtering is exactly lower-tail selection of `m`. With smooth mass constraints

\[
0\le W\le L,\qquad \mathbb E W=\alpha,
\]

the best possible public filter value is

\[
v_{\alpha,L}(m)
=
\frac1\alpha\min_{0\le W\le L,\ \mathbb E W=\alpha}\mathbb E[Wm]
=
\sup_{\tau\in\mathbb R}
\left\{
\tau-\frac{L}{\alpha}\mathbb E[(\tau-m)_+]
\right\}.
\]

Thus a convex-duality proof must show that the lower-tail average of the public posterior comparator-error `m` is below `gamma`. Ordinary excess

\[
\operatorname{err}(g)-\operatorname{err}(c)>\epsilon
\]

only constrains an average loss gap. It gives no lower-tail guarantee for `m`.

## Claims Or Lemmas

**Lemma 1: Public Filter Duality.**  
For a fixed relabeling and public sigma-field `G`, minimizing comparator error over bounded public filters is a CVaR-style lower-tail problem for

\[
m=\mathbb E[1[c\ne Y']\mid G].
\]

Proof is standard linear-program duality:

\[
\min_{0\le W\le L,\ \mathbb EW=\alpha}\mathbb E[Wm]
=
\sup_{\tau}
\left\{
\tau\alpha-L\mathbb E[(\tau-m)_+]
\right\}.
\]

After dividing by `alpha`, this gives the displayed formula.

**Lemma 2: Excess Does Not Imply Low Public Posterior.**  
In the restricted public-posterior model from the working notes, if

\[
\mathbb P[c(X)\ne Y\mid G]=\eta
\]

almost surely with `eta > gamma`, then no `G`-measurable filter or sign relabeling can make comparator error below `gamma`. This remains true even if a current public classifier `g` has large excess over `c`.

Example: take random classification noise around `c` with noise `eta in (gamma,1/2)` and a current classifier with error `1/2`. Then the excess is `1/2-eta`, but every public chunk still has comparator noise `eta`.

**Claim 3: Hard-core duality has the wrong quantifier unless low-OPT is assumed separately.**  
Classical hard-core/boosting duality assumes advantage on every smooth distribution and then combines weak hypotheses. Here the fixed source gives advantage only on distributions whose `OPT_C < gamma`. The missing step is exactly the low-OPT chunk lemma, and duality alone does not supply it.

## Proof Attempts

The natural minimax attempt is:

1. Suppose `g` is more than `epsilon` above `OPT_C`.
2. Use separation between `g` and a near-optimal `c` to define a residual objective.
3. Optimize over public filters/relabelings.
4. Hope the minimax witness has `c`-error below `gamma-poly(epsilon)`.

Step 4 fails. The separation gives an `epsilon`-scale average loss gap, while the weak learner needs a constant-threshold condition:

\[
\operatorname{err}_Q(c)<\gamma.
\]

The four-cell obstruction already shows this for high-loss and mistake filters. The convex formulation shows the broader reason: unless the public posterior error has a low lower tail, optimizing over a richer public convex filter family cannot cross the threshold.

## Gaps And Risks

The only viable positive version seems to need an extra assumption such as:

- the transcript creates public cells where a near-optimal comparator has posterior error below `gamma`;
- the filter family is allowed target-dependent certificates, which would be nonconstructive unless converted to a polynomial menu;
- or a stronger learner/oracle condition supplies useful correlation below the low-OPT threshold.

Without one of these, the dual certificate can depend on the hidden comparator or reduce to the nonpublic clean filter `W=1[Y=c(X)]`.

## Counterexamples Or Obstructions

The clean stress test is RCN in the hard band:

\[
Y=c(X)N_\eta,\qquad \gamma<\eta<1/2.
\]

A classifier `g` with error near `1/2` is far above `OPT_C=\eta`, but public filters with no target information cannot reduce the noise below `eta`, hence cannot trigger the fixed weak learner. Smooth random-target versions are exactly the public-filter obstruction already tracked in the notes.

This is not an atlas separation, because it is a restricted/no-information model. But it does refute the proposed hard-core low-OPT chunk lemma as a general proof principle.

## Sources Consulted

Local run notes: `problem.md`, `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_005/idea_03/idea.md`.

External sources:
- Russell Impagliazzo, [Hard-Core Distributions for Somewhat Hard Problems](https://dblp.uni-trier.de/rec/conf/focs/Impagliazzo95.html).
- Boaz Barak, Moritz Hardt, Satyen Kale, [The Uniform Hardcore Lemma via Approximate Bregman Projections](https://www.boazbarak.org/Papers/hardcore.pdf).
- Vitaly Feldman, [Distribution-Specific Agnostic Boosting](https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf).
- Adam Tauman Kalai, Yishay Mansour, Elad Verbin, [On Agnostic Boosting and Parity Learning](https://doi.org/10.1145/1374376.1374466).

## Recommended Next Steps

Formalize the CVaR/public-filter dual lemma in the working notes. It gives a concise target for future positive attempts.

Then record the obstruction as: “excess implies no low-OPT public chunk without a lower-tail posterior assumption.” A useful next idea would be to identify natural transcript conditions under which the lower tail of `m` must drop below `gamma`; absent that, this route should be treated as blocked rather than merely incomplete.