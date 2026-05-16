## Summary

The oracle-lower-bound idea looks viable as a **restricted black-box barrier**, not as a full separation. The cleanest version shows that a fixed-slack weak oracle can answer with dummy hypotheses on every “honest smooth” query unless the booster has already found a way to concentrate mass on the hidden clean component. This formalizes the bottleneck: fixed additive weak agnostic learning gives no useful signal whenever queried `OPT_C >= gamma`.

The literal idea needs qualification: arbitrary black-box algorithms can make low-`OPT` point-mass or artificially relabeled queries without identifying the global clean component. A rigorous lower bound must either restrict query smoothness/coverage or define an adversarial oracle that treats such local/artificial queries as non-informative.

## Concrete Progress

Set labels in `{+-1}` and let `beta = 1/2 - gamma`. Consider a finite domain `X = [N]`, a hidden clean set `S` of density

$$
p = 1 - 2\eta,
$$

and a hidden random labeling `sigma` on `S`. The target distribution `D_{S,sigma}` draws `x` uniformly. If `x in S`, then `Y = sigma(x)` deterministically; if `x notin S`, then `Y` is uniform random.

For a rich class such as all Boolean functions on `[N]`,

$$
\operatorname{OPT}_C(D_{S,\sigma}) = \eta.
$$

A strong agnostic learner must achieve error at most `eta + epsilon`, which is nontrivial exactly when

$$
\eta < 1/2 - \epsilon.
$$

A random or transcript-independent final hypothesis has error about `1/2`, so it fails by margin

$$
1/2 - (\eta+\epsilon).
$$

Now consider a query distribution `Q` that preserves the target conditional label function but changes the marginal on `X` to some `nu`. Then

$$
\operatorname{OPT}_C(Q) = \frac{1-\nu(S)}{2}.
$$

So the fixed-slack weak oracle is forced to give non-dummy information only if

$$
\operatorname{OPT}_C(Q) < \gamma
\quad\Longleftrightarrow\quad
\nu(S) > 1 - 2\gamma.
$$

But for a query marginal chosen without knowledge of `S`, the baseline is

$$
\mathbb{E}[\nu(S)] = p = 1 - 2\eta.
$$

Thus the query must over-concentrate on the hidden clean set by

$$
2(\eta-\gamma).
$$

This is the clean oracle-barrier inequality.

## Claims Or Lemmas

**Lemma 1: Dummy-Answer Lemma.**  
If `OPT_C(Q) >= gamma`, then an adversarial fixed-slack oracle may return a hypothesis carrying essentially no useful information. Indeed, since `beta = 1/2 - gamma`,

$$
OPT_C(Q)+\beta \ge 1/2.
$$

For any fixed dummy classifier `h_0`, one of `h_0` or `-h_0` has error at most `1/2`, hence satisfies the weak guarantee.

This is a valid oracle response, though it may leak at most a small statistic such as the sign of the label bias against `h_0`.

**Lemma 2: Smooth Hidden-Set Isolation Lemma.**  
Let `S subset [N]` be random with density `p = 1-2eta`. For any fixed query marginal `nu` satisfying `||nu||_infty <= L/N`,

$$
\Pr[\nu(S) \ge p + 2(\eta-\gamma)]
\le
\exp\left(-\Omega((\eta-\gamma)^2 N/L)\right).
$$

So for `q` adaptive queries whose transcripts remain dummy/non-informative, a union bound gives no informative query with high probability as long as

$$
q \ll \exp(\Omega((\eta-\gamma)^2 N/L)).
$$

**Lemma 3: Final Unpredictability Lemma.**  
If the oracle transcript plus samples reveal only `o(N)` bits about the random labeling `sigma` on a constant-density clean set, then any final hypothesis has expected correlation `o(1)` with `sigma` on unseen clean points. Hence its target error is close to `1/2`, failing the strong agnostic target whenever `eta + epsilon < 1/2`.

## Proof Attempts

The intended proof is a Yao-style lower bound.

Choose random `(S, sigma)`. Fix a deterministic black-box booster. The oracle answers all queries with `OPT >= gamma` using dummy hypotheses. Until the first query satisfying `nu(S) > 1-2gamma`, the transcript is independent of the hidden clean component except for ordinary labeled samples and a small number of dummy sign bits.

For smooth query marginals, concentration says no polynomial number of such queries can over-concentrate on `S` by the required amount `2(eta-gamma)`. Therefore all oracle answers can remain dummy. The final hypothesis then has no way to predict the random labels on most of `S`, so its error remains near `1/2`, while the benchmark concept has error `eta`.

This gives a plausible oracle lower bound for smooth, honest, target-preserving black-box boosters.

## Gaps And Risks

The barrier is not yet a full black-box lower bound.

The biggest issue is arbitrary queries. A booster can query a point mass on a labeled sample; if `C` contains a concept agreeing there, the query has `OPT = 0` without identifying the hidden clean component. It can also ask artificially relabeled queries with low `OPT` for public reasons. Thus the statement “all polynomially many queries have `OPT >= gamma` unless they identify the hidden component” is false as written.

The fix is to charge only **high-coverage informative queries**, or to restrict to smooth marginals and target-preserving relabelings. Without such a restriction, the adversarial oracle must be defined to answer low-coverage or public-witness low-`OPT` queries with hypotheses that are valid on the query but useless on the target distribution.

Also, this cannot refute the atlas implication. It only attacks generic black-box boosting from the fixed-slack guarantee. A real efficient learner may expose representation-specific structure not captured by this oracle.

## Counterexamples Or Obstructions

Point-mass obstruction: after seeing one labeled example `(x,y)`, the booster can query the distribution concentrated on `(x,y)`. Often `OPT_C = 0`, but this reveals no global clean component and covers negligible target mass.

Artificial-label obstruction: the booster can define labels using a public dummy hypothesis, creating a query with low `OPT` for a public witness. The oracle can validly return that public witness, so low `OPT` alone is not equivalent to hidden information.

Endpoint obstruction: if `eta = 1/2 - epsilon`, then a random classifier already has error `1/2 = eta + epsilon`. The lower-bound construction needs the strict margin `eta + epsilon < 1/2`.

## Sources Consulted

Local files: `problem.md`, `working_notes/*`, and `iterations/iter_001/idea_02/idea.md`.

External sources:
- Shai Ben-David, Philip M. Long, Yishay Mansour, “Agnostic Boosting,” COLT/EuroCOLT 2001. https://doi.org/10.1007/3-540-44581-1_33
- Adam Kalai, Yishay Mansour, Elad Verbin, “On Agnostic Boosting and Parity Learning,” STOC 2008. https://www.microsoft.com/en-us/research/publication/agnostic-boosting-parity-learning/
- Varun Kanade, Adam Kalai, “Potential-Based Agnostic Boosting,” NeurIPS 2009. https://papers.neurips.cc/paper/3676-potential-based-agnostic-boosting
- Vitaly Feldman, “Distribution-Specific Agnostic Boosting,” arXiv:0909.2927. https://arxiv.org/abs/0909.2927

## Recommended Next Steps

Formalize the restricted oracle model first: target-preserving queries with smooth marginals and bounded coverage. Prove the hidden-set isolation lemma cleanly there.

Then extend the model to arbitrary low-`OPT` queries by separating “public-witness” low `OPT` from “hidden-witness” low `OPT`. The right invariant is not `OPT_C(Q) < gamma`; it is whether every valid weak answer must carry target-mass correlation with the hidden clean labels.