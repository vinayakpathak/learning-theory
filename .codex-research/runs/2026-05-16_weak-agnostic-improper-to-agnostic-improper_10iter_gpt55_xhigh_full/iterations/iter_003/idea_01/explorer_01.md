## Summary

The finite-bag idea is a useful conditional cleanup, but not by itself a proof of the atlas edge.

It can genuinely remove global assumptions on `Range(A)` for the final noisy validation step: once a polynomial-size finite list of evaluable final classifiers is available, held-out validation depends only on `log |L|`, not on `VC(H)` or dual `VC(H)`. But it does not remove the main hidden-clean bottleneck. In the da Cunha-Høgsgaard-Paudice proof, finite generated bags still arise from enumerating hidden clean `m0`-tuples, and the proof still needs a way to certify that a data-dependent vote which fits the hidden clean sample has low true clean error.

So the right theorem is conditional:

> If one can generate, without exhaustive hidden-clean enumeration, a polynomial finite list of final classifiers containing one classifier accurate on `D_c^+` for a near-optimal comparator `c`, then validation gives efficient strong agnostic improper learning.

That theorem is true and should be recorded. The unresolved content is the finite-list generator.

## Concrete Progress

I isolated three separate roles currently mixed together in the da Cunha route.

First, realized weak calls need no global range control. If a wrapper makes only `q = poly(s,1/epsilon,log(1/delta))` calls to the fixed weak learner on adaptively chosen distributions, then a conditional union bound over the realized calls suffices. No VC bound on `Range(A)` is needed for this part.

Second, final validation can be finite-bag only. If the generated bag is `B` with `|B|=K`, then the class of `T`-wise votes has size at most `K^T`, so held-out validation has statistical cost

$$
O\left(\frac{T\log K+\log(1/\delta)}{\epsilon^2}\right).
$$

This removes the need for global `VC(sign(H^{(T)}))` in the final validation analysis. It does not remove the computational cost of searching `K^T` votes.

Third, the clean-slice population guarantee is still the hard part. In the 2026 proof, the event proving that some vote in `sign(B^{(T)})` has low population risk uses uniform convergence over the global vote class on the hidden clean sample. A finite bag depending on that same hidden clean sample cannot simply be treated as fixed.

## Claims Or Lemmas

**Lemma 1: finite-list clean-transfer.**  
Let `c in C` satisfy

$$
\operatorname{err}_D(c) \le \operatorname{OPT}_C(D)+\tau.
$$

Suppose an algorithm outputs a finite evaluable list `L`, independent of a fresh validation sample, and with high probability some `h in L` satisfies

$$
\operatorname{err}_{D_c^+}(h,c)\le \alpha.
$$

Then fresh validation over `L` returns, with high probability,

$$
\operatorname{err}_D(h,Y)
\le
\operatorname{OPT}_C(D)+\tau+\alpha+O(\epsilon).
$$

This is just L004 plus finite-list validation.

**Lemma 2: realized-call union bound.**  
For polynomially many adaptive calls to the source learner, set each call’s failure probability to `delta/q`. Conditional on the past, each call satisfies the source guarantee on its realized query distribution. A union bound gives correctness of all realized calls. No global capacity assumption on the output range is needed.

**Lemma 3: finite-bag validation replacement.**  
Condition on a generated finite bag `B` independent of the held-out validation sample. ERM over any explicitly listed `L subseteq sign(B^{(T)})` generalizes with dependence on `log |L|`. If using all `T`-wise votes, the statistical term is `T log |B|`, but exhaustive search may be super-polynomial.

**Obstruction lemma.**  
A finite data-dependent bag does not imply clean generalization. A singleton bag can contain a classifier chosen to memorize the hidden clean sample and behave randomly elsewhere. It has zero empirical clean error and finite size one, but clean population error about `1/2`. Thus finite-bag size alone cannot replace VC, compression, stability, independence, or direct population guarantees.

## Proof Attempts

The cleanest conditional proof is:

1. Pick `c*` with `err_D(c*) <= OPT_C(D)+epsilon/3`.
2. Generate a polynomial finite list `L` containing some `h` with  
   `err_{D_{c*}^+}(h,c*) <= epsilon/3`.
3. Validate over `L` on fresh noisy examples from `D`.
4. By L004, the good `h` has noisy risk at most `OPT + 2epsilon/3`.
5. Validation loses another `epsilon/3`.

This proves the target, but the theorem’s real assumption is exactly the missing hidden-clean finite-list generator.

A stronger assumption, literal sample access to `D_c^+`, makes da Cunha unnecessary: on clean distributions, `OPT=0`, so the fixed source is a standard weak learner with error at most `beta = 1/2 - gamma`; classical realizable boosting then learns on `D_c^+`, and L004 lifts to agnostic excess.

For the actual da Cunha finite-bag route, replacing the final global VC bound by a finite-bag union bound works. Replacing the hidden-clean empirical-to-population step does not work unless the bag is independent of a clean certification sample, has a compression/stability certificate, or comes with a direct population guarantee.

## Gaps And Risks

The main gap is still hidden-clean generation. If the procedure can really sample the hidden-clean weak-call distributions, the problem is essentially solved by clean boosting. If it only produces a finite bag from noisy samples, one still needs to prove that the bag contains a true clean-good final classifier.

The final selector is also unresolved. Searching all `T`-wise votes over a polynomial bag costs `K^T`; when `T` grows with `log n`, this is generally quasi-polynomial. A polynomial-time selector or a polynomial explicit list of final classifiers is needed.

Finite-dimensional reformulation may help statistically: all weighted votes over `K` base hypotheses are halfspaces in `R^K`, so global `Range(A)` disappears. But efficient agnostic 0-1 ERM for halfspaces is not available in general, so this only moves the computational burden.

## Counterexamples Or Obstructions

Finite bag size is not enough: a data-dependent classifier can memorize the clean sample and generalize badly. This blocks the naive argument “the bag is finite, therefore validation/generalization handles it” for clean-slice guarantees.

Noisy validation of individual weak hypotheses is also insufficient, as already recorded in O014: a base hypothesis useful on the clean slice can have poor original noisy risk. Validation must be over complete final classifiers.

The dual-VC pruning in da Cunha can be avoided if one can explicitly generate the correct full AdaBoost trajectory, but that again requires hidden-clean adaptive access or an equivalent selector.

## Sources Consulted

Local run files: `problem.md`, all requested `working_notes/*.md`, and `iterations/iter_003/idea_01/idea.md`.

External sources:
- Arthur da Cunha, Mikael Møller Høgsgaard, Andrea Paudice, [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265), arXiv 2026.
- Arthur da Cunha, Mikael Møller Høgsgaard, Andrea Paudice, Yuxin Sun, [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384), arXiv 2025.
- Arthur da Cunha, Kasper Green Larsen, Martin Ritzert, [Boosting, Voting Classifiers and Randomized Sample Compression Schemes](https://proceedings.mlr.press/v272/cunha25a.html), ALT/PMLR 2025.

## Recommended Next Steps

1. Record the finite-list clean-transfer theorem as a conditional positive lemma.

2. Rewrite the da Cunha proof skeleton with `sign(B^{(T)})` replacing global `sign(H^{(T)})` only in the final validation step. This will sharply identify which uses of `VC(H)` are artifacts and which are still doing real clean-generalization work.

3. Formalize the missing generator as one of three alternatives: direct hidden-clean sampling, compression/stability certificate, or polynomial hitting set for adaptive hidden-clean weak-call distributions.

4. Treat polynomial final selection as a separate assumption. Without it, finite-bag validation is statistically fine but computationally too expensive.