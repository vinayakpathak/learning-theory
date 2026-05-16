## Verdict

SOLVED: no

## Candidate Solution Or Main Attempt

The most coherent direct route is still a conditional separation via approximation gaps.

Let `beta = 1/2 - gamma`. Suppose a class `C` has an efficient improper agnostic approximation algorithm `P` with tunable additive accuracy:

$$
\operatorname{err}(P(D)) \le a\,\operatorname{OPT}_C(D)+\xi
$$

for some fixed `a > 1`. Then `C` has a fixed-slack weak agnostic learner for every

$$
\beta > \frac{a-1}{2a}.
$$

The weak learner runs `P`, also considers the two constants, and selects by validation. If `OPT_C(D) >= gamma`, a constant has error at most `1/2 <= OPT_C+\beta`. If `OPT_C(D)<gamma`, then

$$
aOPT+\xi
=OPT+(a-1)OPT+\xi
<OPT+(a-1)\gamma+\xi
\le OPT+\beta
$$

for small enough `xi`.

So a separation would follow from a represented class with:

1. efficient distribution-free constant-factor agnostic improper approximation;
2. hardness of `OPT+epsilon` improper learning.

I do not have such a class. The signed/succinct CSP route remains plausible but not instantiated: fixed-arity CSPs are killed by table learning, and superconstant/succinct CSPs need both a signed weighted weak approximator and genuine improper sample-access hardness.

## Concrete Lemmas Or Reductions

**Approximation-gap weak learner.** The lemma above is sound and gives the cleanest conditional negative template.

**Sparse-majority selector conditional.** For a validation-independent bag `B={h_1,...,h_M}` and DCHP-style final class

$$
V_{B,T}
=
\left\{
x\mapsto \operatorname{sign}\left(\sum_{j=1}^M k_j h_j(x)\right):
k_j\in\mathbb N,\ \sum_j k_j=T
\right\},
$$

the statistical side is fine:

$$
|V_{B,T}|\le {M+T-1\choose T},
$$

so fresh validation needs only

$$
O((T\log(M+T)+\log(1/\delta))/\epsilon^2)
$$

samples.

If some `v in V_{B,T}` has small error on `D_c^+` for a near-optimal comparator `c`, then noisy-risk selection over `V_{B,T}` gives strong agnostic learning by the clean-conditional lemma. The bottleneck is computational selection and, upstream, generating such a population-valid bag.

**Signed CSP formulation.** For assignment-induced classes with labels kept separate from descriptors,

$$
\operatorname{OPT}_C(D)=1-\max_\sigma \Pr[c_\sigma(X)=Y].
$$

Thus signed/weighted CSP approximation can imply weak learning, but only if it is distribution-free, label-agnostic, and over a domain not table-learnable.

## Gaps And Failure Points

No unconditional positive proof: fixed-slack calls still do not produce the hidden clean distribution `D_c^+`.

No unconditional negative proof: the approximation-gap template lacks a concrete represented class satisfying both weak-side approximation and strong-side improper hardness.

The DCHP route remains conditional. The exact final class is now identified, but `ApproxSparseMajorityERM(B,T)` is an extra primitive, not supplied by the weak learner.

For CSPs, ordinary approximation hardness is the wrong object: proper assignment hardness does not rule out arbitrary improper predictors.

## Counterexamples Or Obstructions

The hard band `gamma <= OPT_C < 1/2` remains the central obstruction: the fixed weak learner may legally be nearly silent while strong learning still needs improvement.

Flat public-posterior examples refute one-step residual forcing from excess alone.

Polynomial coordinate domains are always improperly strong-learnable by table prediction.

Anchor doping is absorbed for mixture weight `lambda <= beta`, since the public anchor is then a legal weak answer.

## Promising Ideas To Explore

Test a specific succinct signed-CSP/refutation class against the exact checklist: signed weak approximator, superpolynomial effective domain, and improper sample-access hardness.

Study `ApproxSparseMajorityERM` for the exact DCHP class, not relaxed halfspaces unless a rounding theorem is proved.

Try to regularize the weak learner into controlled range, compression, or stability; this is the only visible way to make DCHP unconditional.

Build the stopped-process public-filter barrier in a random-hidden-target model where conditioning on full `X` does not trivially reveal `c(X)`.

## Notes For Critics

The approximation-gap lemma’s constants should be checked, but the algebra appears clean.

Do not accept fixed-arity CSPs as separations; table learning defeats them.

Any strong-side hardness must be improper prediction hardness, not proper recovery, decoding, or assignment optimization.

Any positive DCHP claim must separately justify hidden-clean bag generation and final sparse-majority selection.