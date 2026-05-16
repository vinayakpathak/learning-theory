## Summary

The literature audit does **not** find an off-the-shelf succinct signed-CSP candidate that satisfies the whole checklist. The refutation literature gives plausible **strong-side hardness** against improper learners, but mostly as learning-vs-refutation statements. The CSP approximation literature gives **proper assignment approximation** algorithms, but the known guarantees either apply to fixed/polynomial descriptor domains, fail for arbitrary signed labels, or do not beat the `1/2` threshold needed for fixed-slack weak learning.

The key audit correction is: standard low-noise/noiseless random-CSP refutation assumptions are incompatible with the desired weak learner. A fixed-slack weak learner with threshold `gamma=1/2-beta` would already refute planted instances with `OPT < gamma`. Therefore any separation via this route must put strong-side hardness in the hard band
`gamma < eta < 1/2`, not at satisfiable or very low-noise completeness.

## Concrete Progress

A viable signed-CSP candidate must have:

- domain `X` = succinct constraint/query descriptors, with RHS/sign **not** included in `x`;
- concepts `c_sigma(x)` induced by assignments or witnesses;
- superpolynomial effective descriptor domain, otherwise improper table learning applies;
- distribution-free signed/weighted approximation strong enough to give fixed `OPT+beta` weak learning;
- high-noise RRHS/RCN sample-access hardness against arbitrary improper predictors.

The literature splits as follows.

Kothari-Livni and Vadhan strongly support the **strong-side formulation**: efficient agnostic learning is tightly connected to refuting random labels versus labels correlated with a concept class. This is the right language for improper prediction hardness.

Daniely-Linial-Shalev-Shwartz / Daniely-Shalev-Shwartz give random-CSP-based improper learning hardness, but these results are better viewed as refutation-hardness machinery, not as a complete candidate for this edge. In particular, if their hard distribution has `OPT < gamma`, then the assumed weak learner would already distinguish it from random labels.

Raghavendra-style and Makarychev-style Max-CSP approximation algorithms do not supply the needed weak side. Their guarantees are for explicit CSP optimization, often fixed arity/domain, and generic high-arity ratios such as `Omega(k/2^k)` or `Omega(kd/d^k)` are far below the `alpha>1/2` agreement ratio that would directly imply fixed-slack weak learning.

Unique Games / Max-2CSP near-satisfiable algorithms are a near miss but not a candidate as stated. Fixed alphabet/arity keeps the descriptor domain polynomial or close to table-learnable; growing alphabet introduces approximation guarantees depending on alphabet/log parameters and standard hardness assumptions already oppose weak recovery from nearly satisfiable instances.

Ordering CSPs are a warning sign: Guruswami-Hastad-Manokaran-Raghavendra-Charikar show approximation resistance under UGC even for nearly satisfiable constant-arity ordering CSPs, so “nearly satisfiable CSP” does not generically imply a weak learner.

## Claims Or Lemmas

**Lemma 1: Weak learner implies low-noise RRHS refutation below its threshold.**

Let `beta=1/2-gamma`. Suppose a fixed-slack learner exists for class `C`. If a planted signed-CSP distribution has `OPT_C <= eta < gamma`, then the weak learner returns `h` with

`err(h) <= eta + beta = 1/2 - (gamma - eta)`.

Using fresh validation, this distinguishes the planted case from iid random RHS labels. Thus any refutation hardness assumption used for the strong side must live at noise `eta >= gamma`, or it contradicts the weak side.

**Lemma 2: Signed CSP approximation needed for weak learning is genuinely strong.**

For assignment-induced `C={c_sigma}`, let

`A* = max_sigma Pr[c_sigma(X)=Y]`, so `OPT_C = 1-A*`.

An additive signed-CSP approximator with agreement at least `A* - kappa` gives `OPT+kappa` weak learning. To get fixed `OPT+beta`, need `kappa <= beta < 1/2`.

A multiplicative agreement approximation `A >= alpha A*` gives

`err <= OPT_C + (1-alpha)A* <= OPT_C + (1-alpha)`,

so this route needs `alpha > 1/2`. Generic high-arity Max-CSP ratios do not meet this.

**Lemma 3: Standard fixed-arity CSP gaps remain irrelevant for improper separation.**

For constant arity over `n` variables, the descriptor domain has size `n^{O(k)}`. An improper table learner can learn Bayes risk plus `epsilon`, hence `OPT_C+epsilon`. This is already recorded locally as C035/L031 and survives the literature audit.

## Proof Attempts

I tried to instantiate the idea with three literature families.

1. **Random k-SAT / DNF-refutation hardness.**  
   Strong-side hardness is plausible via Daniely-style reductions, Vadhan RRHS, and Kothari-Livni refutation equivalence. But the usual satisfiable or very low-noise planted cases are below any reasonable weak threshold, so a fixed-slack weak learner would already refute them. Moving hardness to high noise is possible as an assumption, but it is not the standard theorem statement.

2. **Generic Max-k-CSP approximation.**  
   Makarychev-Makarychev and related Max-CSP algorithms give explicit-instance approximation ratios, but for high arity the ratios are too small to imply `alpha>1/2`. They do not yield the distribution-free arbitrary signed weak learner needed here.

3. **Unique Games / Max-2CSP.**  
   Near-satisfiable algorithms exist, but their useful regimes depend on alphabet size and/or `log n`; UGC-style hardness also directly targets nearly satisfiable recovery. This does not currently give “easy below gamma, hard above gamma” in the improper sample-access prediction sense.

## Gaps And Risks

The main missing object is a **low-noise-only distribution-free signed approximator**: an algorithm that works whenever `OPT < gamma`, for fixed `gamma`, but says nothing useful in the hard band.

Most CSP approximation algorithms are not distribution-free learning algorithms over arbitrary signed labels; they optimize explicit proper assignments.

Most CSP hardness results are not improper prediction hardness. Proper assignment recovery, value approximation, and refutation hardness need to be translated carefully.

A strong learner at noise `eta > gamma` would give a correlative refuter by validation, so the exact hardness assumption should be stated as high-noise RRHS/RCN refutation hardness for the same evaluation class.

## Counterexamples Or Obstructions

- If RHS/sign is public in `x`, an improper learner reads it.
- If all labels are positive, `h=1` is trivial.
- If arity/domain is fixed and descriptor domain is polynomial, table learning kills the separation.
- If the hardness distribution has `OPT < gamma`, the weak learner itself refutes it.
- For high-arity generic CSPs, known approximation ratios are typically far below the `>1/2` agreement threshold needed for the weak-side conversion.

## Sources Consulted

- Kothari and Livni, **Improper Learning by Refuting**, ITCS 2018: https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITCS.2018.55
- Vadhan, **On Learning vs. Refutation**, COLT 2017: https://proceedings.mlr.press/v65/vadhan17a.html
- Daniely, Linial, Shalev-Shwartz, **From average case complexity to improper learning complexity**: https://arxiv.org/abs/1311.2272
- Daniely and Shalev-Shwartz, **Complexity Theoretic Limitations on Learning DNF’s**, COLT 2016: https://proceedings.mlr.press/v49/daniely16.html
- Allen, O’Donnell, Witmer, **How to refute a random CSP**: https://arxiv.org/abs/1505.04383
- Raghavendra, **Optimal Algorithms and Inapproximability Results for Every CSP?**: https://www.cs.cornell.edu/~abrahao/tdg/papers/p245.pdf
- Makarychev and Makarychev, **Approximation Algorithm for Non-Boolean Max-k-CSP**: https://theoryofcomputing.org/articles/v010a013/v010a013.pdf
- Yury Makarychev thesis page, **Approximation Algorithms for Constraint Satisfaction Problems**: https://www.cs.princeton.edu/research/techreps/508
- Guruswami, Hastad, Manokaran, Raghavendra, Charikar, **Beating the Random Ordering Is Hard**: https://epubs.siam.org/doi/10.1137/090756144

## Recommended Next Steps

1. Recast the candidate as a **hard-band RRHS assumption**: no poly-time algorithm distinguishes iid RHS from labels with correlation `1-2 eta` for some `eta in (gamma,1/2)`.
2. Separately search for classes with **bounded-distance signed approximation** below `gamma`; do not use noiseless random-CSP hardness.
3. If staying with CSPs, focus on algebraic/synchronization-style classes where exact satisfiable instances are easy, small-noise instances may be weakly approximable, but high-noise sample-access prediction is conjecturally hard.
4. Treat current CSP literature as providing obstruction and vocabulary, not yet a separation candidate.