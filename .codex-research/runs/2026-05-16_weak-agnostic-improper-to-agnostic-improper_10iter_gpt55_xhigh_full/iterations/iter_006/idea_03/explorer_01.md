## Summary

The exact da Cunha-Hogsgaard-Paudice final vote class is

\[
\operatorname{sign}(\mathcal B^{(T)})
=
\left\{\operatorname{sign}\left(\frac1T\sum_{i=1}^T h_i\right): h_i\in \mathcal B\right\},
\]

with repetitions allowed and `sign(0)=1`. So it is a uniform, nonnegative, \(T\)-wise majority over the generated bag, equivalently a zero-threshold vote with nonnegative integer weights summing to \(T\). It is not an unrestricted real threshold class, and not a signed vote class unless complements are already present in the bag.

The paper does not supply a polynomial-time implicit selector. Algorithm 1 explicitly returns an ERM over \(\operatorname{sign}(\mathcal B^{(T)})\), and the runtime analysis pays the \(|\mathcal B|^T\) search cost. The proof’s margin is a hidden-clean empirical margin used for existence/pruning, not an observable validation-set or surrogate-risk certificate.

## Concrete Progress

The audited 2026 paper sets

\[
R=\lceil \ln(n)/\theta^2\rceil,\quad
M=\left\lceil \frac{\ln(5R/\delta)}{\ln(1/\delta_0)}\right\rceil,\quad
T=\left\lceil \min\left\{R,260^2(4d^*+2)/\theta^2\right\}\right\rceil.
\]

It builds \(\mathcal B\) by running the weak learner on all ordered \(m_0\)-subsamples of the first half \(S_1\), repeated \(M\) times per round for \(R\) rounds. Then it validates over the second half \(S_2\) by exhaustive ERM over \(\operatorname{sign}(\mathcal B^{(T)})\).

The proof shows existence of a good final vote by conditioning on the hidden clean set

\[
S_{f^*}=\{(x,y)\in S_1: y=f^*(x)\}.
\]

On this hidden clean sample, the bag can simulate an equal-weight AdaBoost run. AdaBoost gives a large empirical clean margin; a dual-VC pruning lemma converts the resulting convex vote into a uniform \(T\)-wise vote from \(\mathcal B\) that has zero clean empirical error. Uniform convergence over \(\operatorname{sign}(\mathcal H^{(T)})\) then transfers this to clean-population accuracy, and fresh validation selects a good noisy-risk classifier.

## Claims Or Lemmas

**Exact Vote Class Lemma.** For fixed bag \(\mathcal B=\{h_1,\dots,h_M\}\), the final class is

\[
\left\{\operatorname{sign}\left(\sum_{j=1}^M k_jh_j(x)\right): k_j\in\mathbb N,\ \sum_j k_j=T\right\}.
\]

This is a nonnegative integer-weight threshold over the bag features, with total weight \(T\) and threshold \(0\).

**Selector Bottleneck Lemma.** The paper’s theorem uses that the returned classifier is an empirical minimizer over \(\operatorname{sign}(\mathcal B^{(T)})\). Replacing exhaustive search by an efficient selector would require an additional primitive: given \(\mathcal B\), return a vote whose noisy risk is within \(\xi\) of the best vote in the exact class or in a specified relaxation.

**Margin Non-Transfer Lemma.** The proof’s margin certificate is on the hidden clean sample \(S_{f^*}\), not on \(S_2\) and not on the original noisy distribution. Therefore it does not by itself justify hinge/logistic/convex surrogate minimization on the validation data.

## Proof Attempts

Tried to extract a convex selector from the margin argument. This fails because the margin is produced in the simulated clean AdaBoost trajectory, whose training set depends on the unknown comparator \(f^*\). The validation learner only sees noisy labels.

Relaxing to arbitrary nonnegative convex weights gives a halfspace-like ERM problem over features \(x\mapsto(h_1(x),\dots,h_M(x))\). The 0-1 objective is still nonconvex, and surrogate optimization would need a separate calibration or margin theorem on the noisy validation distribution.

Enumeration is polynomial only when \(T\) is treated as fixed. In the theorem, \(T=O(\min\{\log n,d^*\}/\theta^2)\), so the paper’s selector is not representation-uniform polynomial unless these parameters are controlled.

## Gaps And Risks

Even a polynomial final selector would not solve the upstream hidden-clean tuple generation issue: the paper still enumerates all \(m_0\)-subsamples of \(S_1\).

The theorem assumes a base class \(\mathcal H\) with controlled VC dimension, dual VC dimension \(d^*\), and evaluation time. The atlas source only gives an arbitrary efficient improper weak learner, so \(\mathcal H\)-control remains an extra hypothesis.

A hardness claim for the exact \(T\)-wise nonnegative integer vote class still needs its own reduction. The easier coordinate-bag reduction applies most directly to relaxed or unrestricted real-weight selectors.

## Counterexamples Or Obstructions

Coordinate-bag stress test: if \(\mathcal B\) contains coordinate projections, their negations, and constants, then nonnegative threshold votes over \(\mathcal B\) can represent ordinary signed halfspaces after normalization. Thus a generic efficient selector for relaxed real-weight votes would include agnostic halfspace selection over generated features as a special case.

This is only a warning for the exact da Cunha class: bounded \(T\)-wise integer votes are more restricted than arbitrary real halfspaces, so a separate exact-class hardness or algorithm is needed.

## Sources Consulted

- Arthur da Cunha, Mikael Moller Hogsgaard, Andrea Paudice, [“Sample-Near-Optimal Agnostic Boosting with Improved Running Time”](https://arxiv.org/abs/2601.11265), arXiv:2601.11265, v3, 2026. Audited Algorithm 1, Theorem 1/full theorem, and proof/source.
- Arthur da Cunha, Mikael Moller Hogsgaard, Andrea Paudice, Yuxin Sun, [“Revisiting Agnostic Boosting”](https://arxiv.org/abs/2503.09384), arXiv:2503.09384, 2025, for context.
- Venkatesan Guruswami and Prasad Raghavendra, [“Hardness of Learning Halfspaces with Noise”](https://www.cs.cmu.edu/~venkatg/pubs/papers/halfspace_Full.pdf), SIAM J. Comput. 2009, as background warning for halfspace-style selectors.

## Recommended Next Steps

State the conditional positive theorem with an explicit `ExactTWiseVoteSelector(B,T,xi)` primitive, separate from hidden-clean generation.

Then audit three selector variants separately: exact \(T\)-wise integer votes, nonnegative convex votes, and unrestricted real threshold votes. The coordinate-bag obstruction should be formalized only for the variant it actually covers.

The most useful follow-up paper task is to search for a rounding theorem: if a convex nonnegative vote has a validation-observable margin, can it be rounded to \(T=O(\log n/\mu^2)\) hypotheses without losing risk? The da Cunha proof currently supplies only a hidden-clean margin, so this would need a new bridge.