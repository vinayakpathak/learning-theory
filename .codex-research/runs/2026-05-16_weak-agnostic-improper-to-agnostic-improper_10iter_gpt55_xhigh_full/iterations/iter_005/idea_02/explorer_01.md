## Summary

Anchor doping does not seem to give a black-box oracle self-reduction from fixed `OPT + beta` learning to `OPT + epsilon` learning. The core obstruction is that a doped query scales the true target signal by at most `1`, while the oracle’s additive slack stays constant. For small target mixing weight, the improper oracle can legally return the public anchor itself. For large mixing weight, the translated original-objective error floor is still constant unless the anchor already separates good original optimizers from bad ones by a constant margin.

## Concrete Progress

Model a doped query by a public binary anchor `a` and mixing weight `lambda`:

$$
Y_\lambda =
\begin{cases}
a(X), & \text{with probability } 1-\lambda,\\
Y, & \text{with probability } \lambda.
\end{cases}
$$

Equivalently the conditional label mean is

$$
m_\lambda=(1-\lambda)a+\lambda m,
\qquad m(x)=E[Y\mid X=x].
$$

The fixed weak learner is a constant-additive support-function oracle:

$$
\langle h,m_\lambda\rangle
\ge \sup_{c\in C}\langle c,m_\lambda\rangle - 2\beta.
$$

The key point: if `lambda <= beta`, then the public improper hypothesis `h=a` is always a legal oracle output, independently of `C` and independently of the true target labels. So infinitesimal or small-perturbation “differentiate the support function near the anchor” strategies are dead in the atlas improper model.

## Claims Or Lemmas

**Lemma 1: Small-doping anchor-answer obstruction.**

For the stochastic mixture above, the public hypothesis `h=a` has doped-query error

$$
\operatorname{err}_{D_\lambda}(a,Y_\lambda)
= \lambda \operatorname{err}_D(a,Y)
\le \lambda.
$$

Since `OPT_C(D_lambda) >= 0`, if `lambda <= beta`, then

$$
\operatorname{err}_{D_\lambda}(a,Y_\lambda)
\le OPT_C(D_\lambda)+\beta.
$$

Thus the weak learner may legally return `a` and reveal no target information.

**Lemma 2: Large-doping keeps a constant floor.**

Let `eta=2 beta`. For any doped objective

$$
u=(1-\lambda)a+\lambda m,
$$

an `eta`-approximate maximizer for `u` only controls the original objective `m` up to scale `eta/lambda`, plus whatever anchor-bias term is introduced. Since `lambda <= 1`, the oracle slack alone leaves at least a `2 beta` correlation-scale floor unless the anchor provides extra separation.

**Necessary anchor condition.**

To force every legal oracle answer to be `epsilon`-good for the original objective, every original-`epsilon`-bad hypothesis must be excluded from the doped approximate maximizer set:

$$
\sup_{d\in C}\langle d-c,(1-\lambda)a+\lambda m\rangle > 2\beta
$$

for every `c` with

$$
\sup_{d\in C}\langle d,m\rangle-\langle c,m\rangle>\epsilon.
$$

For `epsilon << beta`, the `lambda m` term cannot provide this exclusion by itself. The anchor must already separate bad hypotheses from good original optimizers by a constant margin. That is a strong, target-dependent structural assumption, not supplied by weak agnostic learnability.

## Proof Attempts

The most tempting self-reduction is to sweep `lambda` and watch which hypotheses the oracle returns, hoping to recover the derivative of the support function in the target direction. Lemma 1 blocks the small-`lambda` regime: the oracle can always answer with the public anchor.

For `lambda > beta`, the target component is visible, but the oracle still has constant additive slack. In a two-candidate picture, let `c0` be anchor-favored and `c1` be target-favored. The doped score advantage of `c1` over `c0` is

$$
\lambda\Delta_m-(1-\lambda)\Delta_a.
$$

Even after `c1` becomes the exact doped maximizer, `c0` remains a legal weak-oracle answer until this advantage exceeds `2 beta`. If the target improvement `Delta_m` is below `2 beta`, then varying `lambda` cannot force the oracle to output `c1`.

## Gaps And Risks

This is not a full black-box lower bound for every adaptive oracle wrapper. It rules out the direct anchor-doping support-refinement mechanism unless one assumes a strong anchor family.

Reweighting might help if the algorithm can identify high-target-signal regions, but that is exactly hidden comparator information. Public spike or empirical reweighting can create low-`OPT` queries without useful target mass, matching the existing point-mass obstruction.

The argument uses impropriety critically: the oracle may return the public anchor even if `a notin C`.

## Counterexamples Or Obstructions

Small target mixture is completely anchor-absorbed: for `lambda <= beta`, `h=a` is always legal.

Support-function finite differences have constant noise: additive error `2 beta` divided by target scale `lambda` cannot yield `epsilon`-precision.

A successful anchor must be target-aware: it must make original-bad hypotheses lose by constant doped margin, which is essentially already a certificate of the desired optimizer.

## Sources Consulted

No web sources. Consulted the local required run notes: `problem.md`, `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_005/idea_02/idea.md`.

## Recommended Next Steps

Record this as a failed/direct obstruction unless another explorer finds a nontrivial anchor source.

A useful conditional theorem would be: anchor doping succeeds if there is a polynomial anchor family such that, for every target objective, some anchor-query approximate maximizer set is contained in the original `epsilon`-good set. Then test whether any natural class supplies such anchors without already solving strong agnostic learning.