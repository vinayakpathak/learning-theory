## Summary

I tested the approximation-gap template on the most natural succinct signed-CSP candidate: log-arity signed Max-LIN / sparse parities.

Verdict: this does **not** instantiate a conditional separation. It gives a useful no-go pattern instead:

- For constant arity, the query domain is polynomial, so improper table learning gives strong agnostic learning.
- For growing arity, e.g. `k = Θ(log n)`, the domain becomes succinct/superpolynomial and strong hardness becomes plausible via sparse-LPN/noisy-k-XOR assumptions, but the weak-side signed approximation is exactly what becomes hard or unavailable.

So the approximation-gap route remains viable only if we find a class with an independently supplied low-noise/signed approximation algorithm that does not already solve the hard-band prediction problem.

## Concrete Progress

Candidate tested:

Let

\[
X_{n,k}=\{S\subseteq[n]: |S|=k\}
\]

and

\[
C_{n,k}=\{c_a(S)=\prod_{i\in S} a_i : a\in\{\pm1\}^n\}.
\]

A labeled example `(S,Y)` is a signed Max-k-LIN equation with RHS kept as the label.

For `k = Θ(log n)`, `|X| = n^{Θ(log n)}`, so the finite-domain table learner obstruction no longer applies.

Strong-side hardness can be cleanly formulated:

Assume hard-band sparse-LPN prediction hardness: for some fixed `eta >= gamma`, no polynomial algorithm given samples

\[
S\sim \mu,\qquad Y=c_a(S)N_\eta
\]

outputs an evaluable `h` with nontrivial correlation with `c_a`.

Then an `OPT+epsilon` agnostic learner breaks this assumption, since `OPT=eta` and

\[
\operatorname{err}(h,Y)
=\eta+(1-2\eta)\operatorname{err}(h,c_a).
\]

Thus strong agnostic learning implies target prediction.

The weak side is where the candidate fails.

A fixed-slack weak learner with `beta=1/2-gamma`, queried at noise `eta < gamma`, would return

\[
\operatorname{err}(h,Y)\le \eta+\frac12-\gamma
=\frac12-(\gamma-\eta),
\]

so it already gives nontrivial noisy sparse-parity prediction. Thus the desired weak algorithm conflicts with the usual low-noise sparse-LPN intuition.

## Claims Or Lemmas

**Lemma 1: constant-arity signed CSPs cannot separate this improper edge.**

If `k=O(1)`, then `|X_{n,k}|=n^{O(k)}`. By the finite-domain table learner already in the run notes, every class over this domain is strongly agnostically improperly learnable in polynomial time. So Max-2-LIN, Max-Cut, and fixed-arity signed CSP approximations cannot yield a separation.

**Lemma 2: log-arity Max-LIN has the right strong-side shape but the wrong weak side.**

For `k=Θ(log n)`, table learning is avoided and hard-band noisy-k-XOR prediction is a plausible strong-side assumption. But any fixed-slack weak learner must beat random on all distributions with `OPT < gamma`, including low-noise sparse parity instances. That is already a low-noise sparse-LPN predictor.

**Lemma 3: random-assignment approximation is exactly too weak.**

For signed Max-k-LIN, a random assignment gives agreement `1/2`. In learning terms this corresponds to slack `beta=1/2`, not `beta<1/2`. To get the atlas source one needs agreement at least `1/2+Ω(1)` on near-satisfiable signed instances, i.e. a genuine weak learner/refuter.

## Proof Attempts

Attempted proper approximation route:

Use a signed/weighted Max-k-LIN approximation algorithm as the weak learner. This fails. Håstad-style approximation resistance for Max-E3-LIN says random assignment is essentially optimal for proper assignment algorithms on almost satisfiable instances, so no proper additive gap `<1/2` is available in the natural worst-case model.

Attempted improper route:

Allow the weak learner to output arbitrary predictors over equation descriptors. This avoids proper Max-LIN hardness formally, but then the required object is exactly an improper weak learner/refuter for low-noise sparse parities. That is not an independently known approximation algorithm; it is the hard part.

Attempted hard-band-only assumption:

One can state a threshold assumption: low-noise sparse parity is easy below `gamma`, but hard at `eta >= gamma`. This would give a conditional separation, but for sparse parity it is not supported by known algorithms. It would be a custom assumption, not an instantiated natural candidate.

## Gaps And Risks

The strong-side sparse-LPN assumption should be stated as **prediction hardness**, not merely recovery or refutation hardness. The strong learner outputs an arbitrary evaluable predictor, not necessarily the hidden assignment.

Håstad’s Max-LIN hardness is proper optimization hardness. It does not by itself rule out arbitrary improper prediction. For improper lower bounds, one needs Daniely-style or Kothari-Livni-style average-case/refutation machinery.

The candidate does not provide the requested “prove or cite a distribution-free signed approximation algorithm.” That is the decisive missing piece.

## Counterexamples Or Obstructions

The main obstruction is a trilemma for signed-CSP approximation-gap candidates:

1. Constant arity/fixed alphabet: weak approximation algorithms may exist, but the descriptor domain is polynomial and table learning gives strong improper learning.
2. Growing arity/succinct domain: strong hardness becomes plausible, but signed weak approximation becomes noisy sparse-parity/refutation-hard.
3. Public RHS/sign in `x`: improper predictors can read the answer or constants become trivial, so the encoding is invalid.

## Sources Consulted

Local run notes: `problem.md`, `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_009/idea_01/idea.md`.

External sources:

- Johan Håstad, “Some Optimal Inapproximability Results” PDF: https://convexoptimization.com/TOOLS/Hastad.pdf
- Amit Daniely, “Complexity Theoretic Limitations on Learning Halfspaces”: https://arxiv.org/abs/1505.05800
- Kothari and Livni, “Agnostic Learning by Refuting”: https://arxiv.org/abs/1709.03871
- Blum, Kalai, Wasserman, “Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model”: https://arxiv.org/abs/cs/0010022

## Recommended Next Steps

Do not continue with log-arity XOR as a separation candidate for the fixed-constant edge unless a genuinely new low-noise sparse-parity weak algorithm is proposed.

For the approximation-gap route, search instead for a succinct class with:

- low-noise distribution-free signed approximation from a real algorithm, not from the assumed weak learner;
- hard-band prediction hardness against arbitrary evaluable predictors;
- no polynomial descriptor-domain table learner;
- no public-label or constant-predictor shortcut.