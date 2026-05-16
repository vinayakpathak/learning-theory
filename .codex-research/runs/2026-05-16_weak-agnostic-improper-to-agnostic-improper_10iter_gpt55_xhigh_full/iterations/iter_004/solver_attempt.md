## Verdict

SOLVED: no

## Candidate Solution Or Main Attempt

The best direct route I can make rigorous is still conditional: reduce strong agnostic learning to generating a polynomial-size list of complete final classifiers, one of which is accurate on the hidden clean conditional distribution of a near-optimal comparator.

Let `c` satisfy `err_D(c,Y) <= OPT_C(D)+tau`, and define `D_c^+ = D | [Y=c(X)]`, with `p = Pr[Y=c(X)]`. If a reconstruction procedure can output an `h` with

$$
err_{D_c^+}(h,c) \le \alpha
$$

from `K` iid samples from `D_c^+` with probability at least `q`, then raw noisy `K`-tuples plus fresh validation give a strong learner whenever

$$
p^{-K}q^{-1}
$$

is polynomial, up to advice/search factors.

The fixed weak learner supplies such a reconstruction only in a very expensive way: on `D_c^+`, the problem is realizable, so standard boosting can turn the fixed `beta < 1/2` advantage into clean error `alpha`. But the hidden clean transcript length is roughly the total number of clean examples needed by that boosted clean run. For a generic PAC weak learner this is polynomial, so discovering the transcript inside noisy data costs exponential time. This is the same bottleneck as da Cunha-style clean tuple enumeration, stated without depending on that paper.

So the route proves a useful conditional theorem, not the atlas implication.

## Concrete Lemmas Or Reductions

### Lemma 1: Clean-Transcript Menu Implies Agnostic Learning

Assume a validation-independent generator produces a finite list `L` of evaluable hypotheses. If, with high probability, `L` contains some `h` with

$$
err_{D_c^+}(h,c) \le \alpha
$$

for a comparator `c` with `err_D(c,Y) <= OPT_C(D)+tau`, then fresh validation over `L` returns, with high probability,

$$
err_D(\hat h,Y) \le OPT_C(D)+tau+\alpha+2\nu,
$$

where `nu` is the validation accuracy.

Reason: for every `h`,

$$
err_D(h,Y)-err_D(c,Y)
\le err_{D_c^+}(h,c).
$$

Then uniform convergence over the finite list adds only the validation term.

### Lemma 2: Raw Tuple Discovery Cost

If `Rec` succeeds from `K` iid samples from `D_c^+` with probability `q`, then a raw `K`-tuple from `D` is useful with probability at least `p^K q`, where `p=Pr[Y=c(X)]`.

Conditioned on all `K` sampled examples satisfying `Y=c(X)`, the tuple is exactly iid from `D_c^+`. Thus

$$
M = O\left(p^{-K}q^{-1}\log(1/\delta)\right)
$$

raw trials suffice to put a clean-good candidate into the list with probability `1-delta`.

In the nontrivial case `OPT_C(D) < 1/2 - \Omega(\epsilon)`, we may take `p >= 1/2+\Omega(\epsilon)`, so the crude upper bound is essentially `2^K q^{-1}`. Therefore polynomial time requires total hidden-clean witness length `K = O(log poly(s,1/epsilon,log(1/delta)))`, unless there is a better sampler or selector.

### Lemma 3: Observable Posterior Obstruction

Let `G` be the public sigma-field available to a one-step residual procedure. Suppose

$$
Pr[c(X)\ne Y \mid G] = \eta
$$

almost surely, with `eta > gamma`. Then no `G`-measurable filtering and no `G`-measurable relabeling can make `c` have error below `eta`, hence cannot force a weak call through the hidden comparator.

Indeed, for a nonnegative `G`-measurable weight `W` and relabeling `Y' = S Y` with `S in {+-1}` `G`-measurable,

$$
Pr_W[c\ne Y']
=
\frac{E[W(\eta 1_{S=1}+(1-\eta)1_{S=-1})]}{E[W]}
\ge \eta,
$$

since `eta < 1/2`.

This cleanly generalizes the high-loss and mistake-residual failures: excess of a current predictor over `c` does not by itself create a public cell where the comparator noise drops below the weak threshold.

## Gaps And Failure Points

The missing positive ingredient is a theorem deriving small total clean transcript length, a polynomial final list, or an efficient final selector from the fixed weak source alone. The source guarantee does not control compression, stability, `Range(A)`, dual VC, or hidden-clean witness size.

The obstruction lemma is only one-step and public-information based. It does not rule out algorithms that first acquire posterior information about where `c` is correct, use class structure, exploit repeated samples, or obtain informative weak-oracle outputs.

The da Cunha route remains a near miss: the weak condition can be met with fixed slack, but the known implementation still pays hidden-clean enumeration and vote-search costs with representation-dependent exponents.

## Counterexamples Or Obstructions

The hard band remains central: when

$$
gamma \le OPT_C(D) \le 1/2-\epsilon,
$$

the fixed weak learner may legally return an uninformative hypothesis, while strong agnostic learning still requires improvement over random guessing.

A stronger residual obstruction is now clear: even if a current predictor `g` has larger error than `c`, the event `g(X)\ne Y` may carry exactly the same posterior comparator noise as the full distribution. Any residual proof must identify how it creates public information correlated with `c`’s correctness.

Finite bags also remain insufficient. A data-dependent bag can memorize a hidden clean sample without population accuracy, and exhaustive search over `T = Theta(log(1/epsilon))` votes from a polynomial bag is generally quasi-polynomial.

## Promising Ideas To Explore

Formalize the clean-transcript theorem as the main conditional positive result, with exact `K,q,p`, advice, endpoint, and validation constants.

Audit da Cunha-style algorithms specifically for total hidden-clean witness length and for which VC assumptions are needed for clean-population transfer versus final validation.

Develop the observable-posterior obstruction into a stopped-process barrier: track the information needed before any smooth public query can lower hidden-target noise below `gamma`.

A possible negative template is a code/decoding separation: a class with efficient weighted bounded-distance weak decoding below radius `gamma`, but hard approximate nearest-codeword decoding at radius `eta > gamma`. The missing piece is an actual represented class satisfying the distribution-free weak side.

## Notes For Critics

The clean-transcript lemma is a conditional reduction, not a proof that the fixed weak source gives such transcripts efficiently.

The posterior obstruction assumes the query/filter/relabeling is measurable with respect to the current public information. It does not cover arbitrary new `X`-dependent structure unless that structure is included in the sigma-field and the posterior condition is maintained.

Any claimed full separation must still handle public-witness low-`OPT` queries, empirical or spike queries, other concepts in `C`, and leakage through improper oracle outputs.