## Verdict

SOLVED: no

I do not have a full proof of the implication or a separating class. The best progress is a sharper obstruction to the most natural direct route: agreement/residual filtering cannot create a low-noise weak-learner query unless the algorithm already has substantial correlation with the hidden comparator.

## Candidate Solution Or Main Attempt

Let `beta = 1/2 - gamma`. The clean positive route is:

1. Pick a near-optimal comparator `c`.
2. Learn well on the hidden clean conditional distribution `D_c^+ = D | [Y=c(X)]`.
3. Use validation on noisy samples to select the resulting hypothesis.

This would solve the edge if we could generate a polynomial-size observable menu containing one hypothesis accurate on `D_c^+`. The main attempt was to get such a menu by filtering noisy examples using a current predictor `g`, for example conditioning on `Y=g(X)`.

That attempt fails quantitatively in the random classification noise model. If `Y=f(X)N`, with noise rate `eta in (gamma, 1/2)`, and `r = E[g(X)f(X)]`, then conditioning on agreement gives noise relative to `f`

$$
\Pr[Y\ne f(X)\mid Y=g(X)]
=
\frac{\eta(1-r)}{1+r(1-2\eta)}.
$$

This drops below `gamma` only if

$$
r >
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

So in the hard band, agreement filtering only creates a useful weak query after the learner already has significant comparator correlation.

## Concrete Lemmas Or Reductions

**Clean-conditional reduction.** If `err_D(c) <= OPT + tau` and `err_{D_c^+}(h,c) <= alpha`, then

$$
err_D(h,Y) \le OPT + tau + alpha.
$$

This is solid and remains the main positive reduction.

**Clean boosting from the source.** Given sample access to a clean distribution labeled by some `c in C`, the source learner is a standard weak learner with edge `gamma`, because every reweighted clean query has `OPT=0`. Standard realizable boosting then gives error `alpha` in polynomial time, assuming clean sample access.

**Polynomial clean-menu theorem.** If an algorithm can produce a polynomial-size evaluable list `L` such that, with high probability, some `h in L` satisfies `err_{D_c^+}(h,c) <= epsilon/3` for a comparator `c` with `err_D(c) <= OPT + epsilon/3`, then fresh validation over `L` gives an `OPT + O(epsilon)` agnostic learner.

**Agreement-filter obstruction.** In the RCN model above, the observable query `D | [Y=g(X)]` is low-noise only past the correlation threshold displayed above. At `r=0`, the conditional noise is still exactly `eta`.

## Gaps And Failure Points

The clean-menu theorem is conditional. I do not know how to generate the menu from the fixed-slack weak learner alone.

The agreement-filter lemma only blocks a natural family of residual-forcing strategies. It is not a general lower bound against all adaptive query constructions.

The source learner may be arbitrary and unstable. Without extra range, compression, or transcript structure, enumerating clean weak-call witnesses still appears quasi-polynomial or worse.

## Counterexamples Or Obstructions

In RCN with `eta > gamma`, the original distribution and naive filtered distributions can remain outside the weak learner’s forced-useful regime, while strong agnostic learning still requires nontrivial recovery of `f`.

Point-mass, empirical-support, and artificial-relabeling queries prevent a broad black-box claim that “low OPT queries reveal the hidden comparator.” They can have low OPT for public reasons.

Blind clean-tuple sampling fails when the required weak-call sample size grows with representation size: the probability of drawing an all-clean or low-corruption transcript is exponentially small.

## Promising Ideas To Explore

Prove a real polynomial clean-witness menu theorem, perhaps from stability or compression of successful clean boosting transcripts.

Search for a represented class that is weakly learnable under adversarial noise below `gamma` but hard under random classification noise at some `eta > gamma`.

Audit the da Cunha-style residual-free booster at algorithm level to isolate whether the exponential clean-label enumeration can be replaced by a polynomial selector under a natural additional assumption.

Formalize a restricted oracle barrier using smooth queries and target-mass information, while explicitly excluding point-mass and artificial-label loopholes.

## Notes For Critics

The agreement-filter calculation is a local obstruction, not a separation.

The clean boosting step assumes genuine sample access to `D_c^+`; producing that access is exactly the missing part.

The conditional clean-menu theorem should be checked for independence of the validation sample and polynomial evaluability of every candidate in `L`.

No theorem claim here resolves the atlas edge.