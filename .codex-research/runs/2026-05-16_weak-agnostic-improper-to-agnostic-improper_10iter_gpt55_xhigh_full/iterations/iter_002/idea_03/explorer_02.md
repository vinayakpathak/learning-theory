## Summary

The da Cunha-style route still looks like the closest positive route, but the algorithm audit identifies two separate non-polynomial steps:

1. The 2026 algorithm enumerates every ordered `m0`-tuple from the training sample to hit an unknown clean weak-call witness.
2. It then searches over all `T`-wise votes from the generated bag to find a final classifier.

The atlas fixed-slack source semantically matches the 2026 weak learner definition with `gamma0 = 1`, `epsilon0 = 2 beta`, and `theta = 1/2 - beta`. The obstruction is computational, not semantic. The known runtime is only polynomial in the sample size when `m0`, `d*`, and `theta` are treated as fixed external parameters. That is not representation-uniform atlas efficiency.

## Concrete Progress

The 2026 algorithm does the following. Split `S` into `S1,S2`; set

$$
R=\lceil \ln(n)/\theta^2\rceil,\qquad
T=\left\lceil \min\{\ln(n)/\theta^2,\; O(d^*/\theta^2)\}\right\rceil .
$$

For every round `r`, every ordered tuple `I in [n/2]^{m0}`, and several random seeds, it runs the weak learner on `S1|I` and stores the output in a bag `B_r`. It returns an empirical-risk minimizer over

$$
\operatorname{sign}(B^{(T)}).
$$

The exact runtime bottlenecks are:

- Weak calls: roughly `R M (n/2)^{m0}`, summarized in the paper as `O(n^{m0+3})`.
- Final search: `|B|^T`, giving runtime
  $$
  \operatorname{Eval}_H(1)\, n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
  $$

The proof needs tuple enumeration because for the hidden near-optimal comparator `f*`, the useful distributions are adaptive distributions over the hidden clean subset

$$
S_{f^*}=\{(x,y)\in S_1:y=f^*(x)\}.
$$

For each such adaptive clean distribution, the weak guarantee only implies that some clean `m0`-tuple and seed works. The algorithm does not know the clean subset or the adaptive distribution, so it covers all tuples.

## Claims Or Lemmas

**Claim 1, audited:** The atlas weak learner fits the da Cunha 2026 weak condition.

In correlation form the atlas source gives

$$
\operatorname{corr}(h,Y)\ge \sup_{c\in C}\operatorname{corr}(c,Y)-2\beta.
$$

This is Definition 1 of the 2026 paper with `gamma0 = 1`, `epsilon0 = 2 beta`, hence `theta = (gamma0-epsilon0)/2 = 1/2-beta`.

**Claim 2, bottleneck lemma:** Any de-enumeration of line 8 must replace exhaustive search over `S_1^{m0}` by a polynomial hitting set for every adaptive hidden-clean distribution arising in the simulated AdaBoost proof.

This is stronger than finding one clean tuple. The tuple needed in round `i` depends on previous hidden successful hypotheses.

**Claim 3, selector lemma:** Validation can select among a polynomial list of final classifiers, but it does not replace the final `|B|^T` search unless there is a polynomial-time optimizer or an explicitly polynomial candidate list.

A base hypothesis can be useful on the hidden clean slice and still have poor original noisy risk. Validation of individual weak hypotheses is therefore not enough.

**Claim 4, runtime corollary:** The brute-force 2026 implementation is atlas-polynomial only under fixed-parameter assumptions such as `m0 = O(1)` and `T = O(1)`, or under a separate polynomial selector. Since `T = O(min{d*, log n}/theta^2)`, small dual VC helps only if it is constant in the representation parameters.

## Proof Attempts

Direct weak calls on observable residual distributions do not replace the hidden-clean calls. In the hard band, observable noisy distributions may have `OPT_C >= gamma`, so the fixed-slack weak learner may legally return a dummy hypothesis. The useful low-OPT distribution is the hidden clean conditional, not an observable residual.

Randomly sampling tuples instead of enumerating all tuples only works under a strong random-witness assumption. If the clean mass is `p`, the all-clean probability is about `p^{m0}` before accounting for adaptive weighting. For `m0 = poly(s)`, this is exponentially small.

Online selection over `B` is not currently justified. The proof supplies no observable per-round losses corresponding to the hidden AdaBoost distributions, and optimizing empirical 0-1 loss over `sign(B^{(T)})` is a separate combinatorial problem.

Capacity assumptions help in a precise but limited way. Bounded `VC(H)` supports generalization, and bounded dual `VC(H)` prunes the vote length. Neither follows from the atlas source, where the improper learner may output an arbitrary evaluable binary hypothesis.

## Gaps And Risks

This is not a lower bound against all possible fixed-slack boosters. It is an audit of the known residual-free construction.

The output range `H = Range(A)` is not controlled by the atlas definition. One could add hypotheses such as polynomial VC, small dual VC, compression, stability, or efficient ERM over vote classes, but these are extra assumptions.

If `beta` is treated as a parameter, the factor `n^{O(1/theta^2)}` is not polynomial in `1/theta`. For fixed `beta < 1/2`, this issue disappears, but `m0` and `d*` can still vary with representation size.

## Counterexamples Or Obstructions

A weak hypothesis with error `1/2-theta` on the clean slice can have original noisy error above `1/2`, so noisy validation cannot identify useful weak-round hypotheses.

Logarithmic compression is still too weak for exhaustive enumeration: if `n = poly(s,1/epsilon)` and `k = Theta(log(s/epsilon))`, then `n^k` is quasi-polynomial.

Constant compression is also insufficient if the final vote length is `T = Theta(log n)`, since the final search becomes `n^{Theta(k log n)}`.

## Sources Consulted

- Local run files: `problem.md`, all requested `working_notes/*.md`, and `iterations/iter_002/idea_03/idea.md`.
- da Cunha, Høgsgaard, Paudice, [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265), 2026.
- da Cunha, Høgsgaard, Paudice, Sun, [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384), 2025.

## Recommended Next Steps

Formalize the bottleneck as a two-part conditional theorem: a polynomial hidden-clean weak-call hitting set plus a polynomial final vote selector implies the atlas edge.

Audit whether ERM over `sign(B^{(T)})` is computationally hard for natural implicit `B`; this would clarify whether the final selector is a real barrier or just an artifact.

Look for structured weak learners where `m0`, side information, and `d*` are constant or where successful transcripts have a genuinely polynomial random clean witness.