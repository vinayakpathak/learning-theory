## Summary

The explorer’s core obstruction survives: for log-arity signed XOR, a fixed-slack weak learner would already produce a nontrivial predictor for low-noise sparse parity on the uniform $k$-slice. I see no fatal algebraic gap in that reduction.

The main weaknesses are scope and wording. The result is one-way, not an equivalence; the sparse-LPN hardness premise is not cited or formalized; and “robust decoder” should be replaced by “evaluable predictor” unless a recovery/list-decoding lemma for the fixed-$k$ subset code is proved.

## Issue List

- **Worth pursuing:** The central calculation is sound. If $\eta<\gamma$ and $\beta=1/2-\gamma$, then
  $$
  \operatorname{err}(h,Y)\le \eta+\beta
  $$
  implies
  $$
  \mathbb E[h(S)Y]\ge 2(\gamma-\eta),
  \qquad
  \mathbb E[h(S)c_s(S)]\ge \frac{2(\gamma-\eta)}{1-2\eta}.
  $$
  This correctly turns weak learning into low-noise sparse-parity prediction.

- **False claim / overstatement:** “Equivalent to low-noise sparse-parity prediction” is too strong. A distribution-free signed/weighted weak learner implies a predictor on uniform low-noise sparse XOR instances. The converse is not true: an average-case uniform sparse-XOR predictor would not give distribution-free weak learning for arbitrary signed/weighted distributions.

- **Missing assumption:** The reduction needs the weak learner’s output to be efficiently evaluable on fresh uniform $k$-subsets, and the displayed correlation identity uses independence of the fresh test noise from the trained hypothesis. This is standard in PAC, but should be stated.

- **Plausible but incomplete:** The strong-side hardness assumption is not standard LPN as stated. It is fixed-weight, log-arity, sparse linear equations, and the needed hardness is improper prediction/correlation hardness, not merely assignment recovery or refutation hardness.

- **Plausible but incomplete:** “Constant-factor error approximator is already a low-noise robust decoder” should say “predictor.” Recovering the hidden assignment $s$ from a correlated arbitrary hypothesis on $k$-subsets requires an additional decoding/list-decoding argument. This is nontrivial because nearby assignments can agree on all but about $k/n$ of the $k$-subsets.

- **Unsupported citation:** No literature is supplied for hardness of low-noise fixed-weight $k=\Theta(\log n)$ sparse parity prediction against arbitrary evaluable improper hypotheses. Treat this as an explicit assumption, not a known theorem.

## Counterexamples Or Stress Tests

- At the boundary $\eta=\gamma$, the weak guarantee only gives random-level error, so the predictor reduction disappears. This matches the hard-band requirement but should be kept explicit.

- For $k=O(1)$, the domain has size $n^{O(k)}$, so the finite-domain table learner obstruction applies. Log arity is necessary just to avoid that trivial improper learner.

- If the RHS/sign is included in $x$, the problem becomes improperly trivial. The explorer correctly avoids this.

- If there are efficient low-noise decoders for the relevant random sparse linear-code ensemble, the “weak side is hard” diagnosis weakens. That still would not give a distribution-free weak learner, but it would complicate the sparse-LPN intuition.

## Literature Or Known-Result Conflicts

No direct conflict found in the local notes. The explorer is consistent with the iteration-8 parity-slice obstruction and the iteration-7 hard-band correction.

The main literature gap is that fixed-weight log-arity sparse LPN is not automatically covered by ordinary LPN, Max-XOR approximation, or random-CSP refutation statements. Each has a different output goal: prediction, recovery, value approximation, or refutation.

## What Survives The Critique

The sparse-XOR candidate should not be treated as an instantiated approximation-gap separation.

The useful surviving statement is a clean no-go lemma:

> Any fixed-constant weak learner for log-arity signed XOR gives a polynomial-time nontrivial predictor for low-noise uniform sparse parity whenever $\eta<\gamma$.

That is enough to rule out this candidate under the intended low-noise sparse-parity prediction hardness assumption.

## Recommended Next Checks

1. Rewrite the explorer claim as a one-way reduction, not an equivalence.
2. Formalize a `SparseKXOR-Prediction` hardness assumption with parameters $k=c\log n$, $\eta\ge\gamma$, sample access, evaluator outputs, and advantage threshold.
3. Audit whether known sparse-LPN or LDPC decoding algorithms affect the low-noise $\eta<\gamma$ regime.
4. If recovery of $s$ is ever claimed, prove a decoding/list-decoding lemma for the fixed-$k$ subset parity code.
5. Move to a non-parity approximation-gap candidate with an actual distribution-free signed low-noise approximation algorithm and no efficiently sampleable parity slice.