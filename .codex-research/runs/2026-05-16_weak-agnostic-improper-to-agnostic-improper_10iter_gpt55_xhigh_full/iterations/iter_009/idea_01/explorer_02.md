## Summary

I audited the approximation-gap idea on the cleanest concrete succinct candidate: log-arity signed XOR / sparse parity.

It passes the syntax checks: succinct superpolynomial query domain, RHS kept as the label, efficient concept evaluation, and no polynomial-domain table learner. But it fails the key weak-side requirement. A fixed-slack weak learner for this class would already give a polynomial-time predictor for low-noise sparse parity on the uniform `k`-slice. That is essentially the same hardness phenomenon one would want to use on the strong side.

So this candidate does not instantiate a separation. It refines the checklist: a viable approximation-gap separation needs a class with a genuine algorithmic threshold, easy below noise `gamma` in a distribution-free signed sense and hard in the hard band `eta >= gamma` against arbitrary improper predictors.

## Concrete Progress

Candidate audited:

Let `k = ceil(c log n)` and

$$
X_{n,k}=\{S\subseteq[n]: |S|=k\}.
$$

For each hidden assignment `s in {0,1}^n`, define

$$
c_s(S)=(-1)^{\sum_{i\in S}s_i}.
$$

Labels `Y` are separate from `S`; the RHS/sign is not part of the public input. The domain has size

$$
|X_{n,k}|=\binom{n}{k}=n^{Theta(log n)},
$$

so the finite-domain table learner obstruction for constant-arity CSPs does not apply in polynomial time.

The strong-side hard distribution would be uniform sparse-parity RCN:

$$
S\sim \mathrm{Unif}(X_{n,k}),\qquad Y=c_s(S)N_\eta,
$$

with `Pr[N=-1]=eta >= gamma`.

But for the weak side, if `eta < gamma` and `beta=1/2-gamma`, then any `OPT+beta` learner must output `h` with

$$
\operatorname{err}(h,Y)\le \eta+\frac12-\gamma
=\frac12-(\gamma-\eta).
$$

Thus it has nontrivial correlation with the noisy labels, hence with the hidden sparse parity. This is already a low-noise sparse-LPN predictor.

## Claims Or Lemmas

**Lemma 1: Fixed-slack weak learning of log-arity XOR implies low-noise sparse-parity prediction.**

Under uniform RCN labels `Y=c_s(S)N_eta` on `X_{n,k}`, with `eta < gamma`, an `OPT+beta` learner for `beta=1/2-gamma` returns an evaluable `h` satisfying

$$
\mathbb E[h(S)Y]\ge 2(\gamma-\eta).
$$

Since `Y=c_s(S)N_eta` and the noise is independent,

$$
\mathbb E[h(S)c_s(S)]
=
\frac{\mathbb E[h(S)Y]}{1-2\eta}
\ge
\frac{2(\gamma-\eta)}{1-2\eta}.
$$

So for, say, `eta=gamma/2`, the learner gives constant positive correlation with the hidden sparse parity.

**Lemma 2: A constant-factor error approximator for signed log-arity XOR is already a low-noise robust decoder.**

If an algorithm satisfies

$$
\operatorname{err}(P(D))\le a\,\operatorname{OPT}_C(D)+\xi,
$$

then on the same RCN distribution it gives error at most `a eta + xi`. For any fixed `a`, choosing `eta` and `xi` with `a eta + xi < 1/2` gives a nontrivial predictor for sparse parity. Thus the weak approximator needed by the approximation-gap template is not a benign approximation primitive; it is a robust noisy sparse-XOR learner.

## Proof Attempts

The natural weak-side attempt is Gaussian elimination. It works only in the noiseless case `OPT=0`: if the sample equations are consistent, recover some assignment satisfying them. It does not handle constant low noise `0 < eta < gamma`. The weak source must be useful throughout this low-noise band, not only at zero noise.

The natural approximation attempt is to use Max-XOR approximation. Random assignment gives agreement `1/2`, but the weak learner needs agreement above `1/2` whenever `OPT < gamma`. Any distribution-free signed approximator beating this baseline on low-noise sparse parity would already solve the low-noise prediction task.

The strong-side hardness can be formulated cleanly only as an improper prediction assumption: no polynomial-time evaluable predictor gets nontrivial correlation with `c_s(S)` from noisy uniform `k`-sparse equations at `eta >= gamma`. Refutation or proper assignment recovery hardness alone is not enough.

## Gaps And Risks

The sparse-XOR audit does not rule out the approximation-gap route in general. It only says this canonical parity-like candidate collapses the weak side into the same hard prediction problem.

A viable candidate would need an independently known distribution-free signed/weighted approximation algorithm at low noise. Standard CSP approximation ratios are not enough unless they produce actual error below `1/2` in the low-`OPT` regime.

The strong-side assumption must be hard-band prediction hardness against arbitrary improper evaluable hypotheses, not just assignment recovery, value approximation, or refutation.

For fixed constant `gamma`, low-noise sparse parity remains a constant-noise task. The shrinking-gap parity route from iteration 8 works only when `n gamma = O(log n)`, so it does not apply to the atlas edge.

## Counterexamples Or Obstructions

Constant arity `k=O(1)` is blocked by the finite-domain table learner, since `|X|=n^{O(k)}`.

Putting the RHS/sign into `x` makes the problem publicly readable and improperly trivial.

Using low-noise refutation hardness with `eta < gamma` conflicts with the weak source: the weak learner itself returns an evaluable hypothesis with validation error below `1/2`.

For log-arity XOR, the weak-side approximation primitive is equivalent to low-noise sparse-parity prediction, so it is not available under the intended hardness assumptions.

## Sources Consulted

No web search used.

Local files read: `problem.md`, all required `working_notes/*.md`, and `iterations/iter_009/idea_01/idea.md`.

## Recommended Next Steps

Do not spend more iteration budget on signed log-arity XOR as the approximation-gap candidate for the fixed-constant edge.

The next candidate should have:

1. succinct superpolynomial query domain;
2. labels separated from public descriptors;
3. a real distribution-free signed low-noise approximation algorithm;
4. hard-band RCN or prediction hardness at `eta >= gamma`;
5. no public slice reducing weak learning to parity/LPN.