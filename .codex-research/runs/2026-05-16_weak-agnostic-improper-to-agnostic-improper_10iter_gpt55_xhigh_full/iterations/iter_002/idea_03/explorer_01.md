## Summary

The da Cunha-style route is a genuine positive near miss, not a proof of the atlas edge. The fixed `OPT + beta` source fits their semantic weak-learning condition by taking `gamma_0 = 1`, `epsilon_0 = 2 beta`, so nontriviality is exactly `beta < 1/2`.

The obstruction is computational. The 2025 paper proves residual-free agnostic boosting statistically, but enumerates all relabelings. The 2026 follow-up improves this to polynomial time in the sample size only when weak-learner parameters are fixed. Its runtime still has exponent
`m0 * min{d*, log n} / theta^2`,
where `m0` is weak sample size and `d*` is dual VC dimension of the weak output class. This is not representation-uniform polynomial from the atlas source alone.

## Concrete Progress

The relevant papers are:

- Arthur da Cunha, Mikael Moller Hogsgaard, Andrea Paudice, Yuxin Sun, [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384), NeurIPS 2025.
- Arthur da Cunha, Mikael Moller Hogsgaard, Andrea Paudice, [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265), ALT 2026.

Parameter translation:

The atlas weak source gives, for binary hypotheses,
`corr(h,Y) >= rho_C(D) - 2 beta`.

The da Cunha weak learner condition is
`corr(h,Y) >= gamma_0 rho_C(D) - epsilon_0`.

Thus set `gamma_0 = 1`, `epsilon_0 = 2 beta`. In the 2026 convention,
`theta = (gamma_0 - epsilon_0)/2 = (1 - 2 beta)/2`.

Exact non-polynomial steps:

1. 2025 algorithm:
   It runs a realizable booster on every relabeling of one third of the sample, i.e. `2^{m/3}` relabelings. This catches the hidden clean relabeling induced by a near-optimal comparator, then filters to `O(log m)` candidates and validates.

2. 2026 algorithm:
   It avoids full relabeling enumeration, but enumerates all weak samples `I in [n/2]^{m0}` in each boosting round. Weak calls are roughly `R M (n/2)^{m0}`.

3. 2026 final selection:
   It searches over all `T`-term votes from the generated bag `B`, with
   `T = O(min{log n, d*}/theta^2)`.
   Runtime becomes
   `Eval_H(1) * n^{O(m0 min{d*, log n}/theta^2)}`.

## Claims Or Lemmas

**Claim 1: semantic compatibility.**  
A fixed `OPT + beta` improper learner instantiates the da Cunha agnostic weak condition with `gamma_0 = 1`, `epsilon_0 = 2 beta`. This part is clean.

**Claim 2: conditional positive theorem.**  
If the fixed weak learner has constant `m0`, its output range `H` has constant dual VC dimension `d*`, finite/polynomial primal VC dimension `d`, and hypotheses are efficiently evaluable, then the 2026 theorem gives a strong agnostic improper learner in polynomial time for fixed `beta < 1/2`.

**Claim 3: no atlas proof from the known papers.**  
The atlas source does not give constant `m0` or bounded `d*` for `Range(A)`. If `m0` or `d*` grows with representation size, the 2026 runtime exponent grows with the input, so the reduction is not polynomial-time in the atlas sense.

## Proof Attempts

Tried proof route:

1. Let `H = Range(A)`.
2. Instantiate the 2026 theorem using `gamma_0 = 1`, `epsilon_0 = 2 beta`.
3. Use validation to select the final vote.

Failure point: the theorem’s runtime depends on `m0` and `d*` in the exponent. The atlas guarantee only says the weak learner is efficient; it does not imply constant weak sample size or small dual VC dimension of its output range.

Possible de-enumeration replacements:

- Validation helps select among a generated list, but does not generate the hidden clean AdaBoost transcript.
- Direct weak calls on noisy data fail in the hard band; the oracle may be uninformative unless calls are supported on the clean conditional distribution.
- Random weak-sample calls would need an inverse-polynomial chance of hitting the right clean/adaptive witness. The literature proof uses exhaustive tuple enumeration exactly because this is not guaranteed.
- Online selection could replace final enumeration only if one has an efficient optimization/separation oracle over short votes from `B`; the cited theorem does not provide this generically.

## Gaps And Risks

The 2026 theorem is stronger than the iteration-1 notes reflected: it partially de-enumerates the 2025 algorithm and is polynomial in `n` for fixed weak parameters. The working notes should not say only “exponential in samples” for the latest paper.

But it still does not resolve the atlas edge. The main unresolved gap is representation-uniformity: can `m0`, `d*`, and final vote selection be controlled from an arbitrary efficient improper weak learner?

Another risk: `Range(A)` may have small representation length but large dual VC dimension. The 2026 paper itself notes worst-case dual VC can be exponentially related to primal VC.

## Counterexamples Or Obstructions

The 2026 tuple enumeration is a formal version of the clean-witness obstruction. For each adaptive AdaBoost distribution over the hidden clean sample, the proof only extracts existence of some good `m0`-tuple. Without knowing the clean set or comparator, the algorithm enumerates all tuples.

This blocks a black-box polynomial proof unless one proves a random/stable clean-witness lemma or adds a structural assumption on the weak learner’s output class.

## Sources Consulted

- da Cunha, Hogsgaard, Paudice, Sun, [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384), 2025.
- da Cunha, Hogsgaard, Paudice, [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265), 2026.
- Hopkins, Kane, Lovett, Mahajan, [Realizable Learning is All You Need](https://theoretics.episciences.org/13009), TheoretiCS 2024.
- Ghai and Singh, [Sample-Efficient Agnostic Boosting](https://arxiv.org/abs/2410.23632), used only as related-work context through the da Cunha papers.

## Recommended Next Steps

1. Record a conditional theorem based on the 2026 result: fixed-slack weak learner plus constant `m0` and constant dual VC output range implies the atlas edge.
2. Audit whether common efficient improper learners have small dual VC output ranges, especially when outputs are circuits or finite representations.
3. Try to replace all-tuple enumeration with a random clean-witness lemma; this is the main missing ingredient for a representation-uniform proof.