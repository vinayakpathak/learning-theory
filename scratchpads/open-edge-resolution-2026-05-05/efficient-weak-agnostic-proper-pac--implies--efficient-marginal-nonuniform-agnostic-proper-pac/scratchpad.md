# Edge: efficient-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-agnostic-proper-pac

- date: 2026-05-05
- depth: 1
- edge_file: `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- source: `efficient-weak-agnostic-proper-pac`
- target: `efficient-marginal-nonuniform-agnostic-proper-pac`
- family: `agnostic-boosting-open`
- worker constraint: no atlas files edited

## Resolution Summary

This edge should be marked false, assuming length-preserving one-way functions
exist, under the operative weak-learning convention used by the atlas edge
notes: a weak learner may have an inverse-polynomial gap below `1/2`.

The witness is the same one-way image-coordinate weak-handle class already used
for the marginal-nonuniform weak-to-strong proper separations. The extra point
for this edge is that the weak-handle learner is actually distribution-free
weak agnostic proper, not merely marginal-nonuniform weak agnostic proper.

The class contains:

1. image-coordinate seed concepts for a length-preserving one-way function;
2. the two constant concepts;
3. all singleton-positive-atom concepts.

Constants and singletons give a distribution-free weak proper learner. Because
the constants are legal proper concepts, the usual low-noise robustification
keeps the weak agnostic learner proper. Strong marginal-nonuniform proper
agnostic learning still fails: under one fixed coordinate marginal, sufficiently
accurate proper learning of a realizable image-coordinate target forces the
output to be a seed concept with the same one-way image, hence inverts the
one-way function.

## Convention Note

There is a small wording hazard in the local definition of
`efficient-weak-agnostic-proper-pac`: it says `err <= OPT + beta` for a fixed
`beta < 1/2`. Several atlas notes, including the already-resolved
`efficient-weak-agnostic-proper-pac -> efficient-agnostic-proper-pac` edge,
use the standard weak PAC convention with inverse-polynomial advantage
`1/2 - beta(s) >= 1/poly(s)`. The one-way weak-handle witness satisfies this
operative inverse-polynomial version.

If the atlas later enforces a literal dimension-independent constant gap, this
scratchpad should be downgraded to a near miss: the handle class gives
advantage `Omega(1/s)`, not a fixed constant advantage. Under the conventions
currently used in implication notes, the edge is resolved false.

## Definitions Checked

The source asks for one distribution-free efficient learner which, for every
joint distribution `D` over examples, outputs a proper hypothesis `h in C` with

$$
\operatorname{err}_D(h)
\le
\operatorname{OPT}_C(D)+1/2-\gamma(s),
$$

where `gamma(s)` is inverse-polynomial in the representation size under the
atlas weak convention.

The target asks for one uniform learner such that, for every instance marginal
`P`, there is a `P`-dependent polynomial `p_P` bounding sample complexity and
runtime, and for every joint distribution `D` with marginal `P` the learner
outputs `h in C` with

$$
\operatorname{err}_D(h)
\le
\operatorname{OPT}_C(D)+\varepsilon
$$

in time `p_P(s, 1/epsilon, log(1/delta))`.

The target restricted to realizable distributions would give marginal-nonuniform
strong realizable proper learning.

## Counterexample Construction

Assume a polynomial-time computable length-preserving one-way function

$$
f:\{0,1\}^n\to\{0,1\}^n .
$$

The instance domain is

$$
X=\{(1^k,i,b): k\ge 1,\ i\in[k],\ b\in\{0,1\}\}.
$$

For a seed `s in {0,1}^n`, write `y=f(s)` and define the seed concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i .
$$

Let `C` contain all seed concepts `c_s`, the all-zero and all-one concepts, and
every singleton concept `1_a` for `a in X`. These constants and singletons are
the proper weak handles.

## Why The Source Holds

First prove distribution-free weak realizable proper learning.

Consider an image-coordinate target `c_s` of length `n`. For an arbitrary
instance marginal `P`, let

$$
M=P(c_s^{-1}(1))
$$

be the positive mass. The all-zero concept has error `M`; the all-one concept
has error `1-M`; and a singleton on a heaviest positive atom has error at most
`M(1-1/n)`, since the positive set has exactly `n` atoms. Hence

$$
\min\{M,\ 1-M,\ M(1-1/n)\}
\le
1/2-\Omega(1/n).
$$

Samples and validation find such a handle in polynomial time. If a constant is
good, validation selects it. If the singleton route is needed, the positive mass
is near `1/2`, so a heaviest positive atom has mass at least `Omega(1/n)` and is
seen with polynomially many samples. Constant and singleton targets are weakly
learnable by the same candidate list: constants can be output exactly, and a
singleton target is either already weakly approximated by zero or its atom has
large enough mass to be sampled and output.

Now upgrade to weak agnostic proper learning. Let `L` be the distribution-free
weak realizable proper learner above. Let `m(s)` be its constant-confidence
sample bound and `rho(s)` its weak realizable advantage. Set

$$
\alpha(s) \le \min\{\rho(s)/4,\ 1/(16m(s))\}.
$$

Given agnostic examples from `D`, build a candidate list by including the two
constants and by running `L` several times on fresh noisy samples. Validate all
candidates on a fresh sample and output the empirically best candidate. Every
candidate is in `C`.

Let `eta = OPT_C(D)` and choose `c^* in C` with error close to `eta`.

If `eta >= alpha(s)`, the better constant has error at most `1/2`, hence is
within

$$
\eta+1/2-\alpha(s)
$$

of optimum.

If `eta < alpha(s)`, couple a noisy run on `(X,Y) ~ D` with a clean realizable
run on `(X,c^*(X))`, using the same instance sequence and the same internal
randomness. The probability that any of the `m(s)` inspected labels is corrupted
is at most `m(s) eta < 1/16`. Therefore, with constant probability, the noisy
transcript is exactly a successful clean transcript, and `L` outputs a proper
`h` with

$$
\operatorname{err}_P(h,c^*)
\le
1/2-\rho(s).
$$

Then

$$
\operatorname{err}_D(h)
\le
\eta+\operatorname{err}_P(h,c^*)
\le
\eta+1/2-\rho(s)
\le
\eta+1/2-4\alpha(s).
$$

Repetition and validation preserve an inverse-polynomial weak gap after
constant-factor slack. Thus the class satisfies
`efficient-weak-agnostic-proper-pac` under the atlas weak convention.

## Why The Target Fails

Fix the coordinate marginal `P^*` that first chooses a length block `k` with

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then chooses `i in [k]` and `b in {0,1}` uniformly.

Given a one-way challenge `y=f(s) in {0,1}^n`, simulate examples from `P^*` and
label them by

$$
(1^k,i,b)\mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i .
$$

This distribution is realizable by the seed concept `c_s`, so
`OPT_C(D_y)=0`. Run the alleged target learner with

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Because `P^*` is fixed and `1/epsilon_n = poly(n)`, the marginal-nonuniform
target promise gives randomized polynomial running time in `n`.

Any proper hypothesis with `P^*`-error at most `epsilon_n` must be a seed concept
of length `n` with image `y`.

- The all-zero concept has error `mu_n/2`.
- The all-one concept has error at least `1 - mu_n/2`.
- A singleton has error at least `mu_n/2 - mu_n/(2n)`.
- A seed of the wrong length has error at least `mu_n/2` on the length-`n`
  block.
- A same-length seed whose image differs from `y` in one coordinate has error
  at least `mu_n/n`, because it misses the target-positive atom and falsely
  labels the opposite bit-atom on that coordinate.

All these errors exceed `mu_n/(3n)` for large `n`, except the same-image seed
case. Thus a successful proper learner must output a representation `c_t` with
`f(t)=y`. Reading `t` from the proper output inverts the one-way function with
nonnegligible probability, contradicting one-wayness.

Therefore `efficient-marginal-nonuniform-agnostic-proper-pac` fails for this
class under the one-way-function assumption.

## Comparison With Agnostic Boosting

Agnostic boosting does not rescue this implication. The recent da
Cunha--Moller Hogsgaard--Paudice paper is a close match to the fixed-additive
weak agnostic oracle, but its advertised running time is polynomial in the
sample size only when the other parameters are fixed. That is why the sibling
proper-to-improper edge remains an efficient-PAC open problem.

Here there is an additional, simpler proper-output obstruction. Classical
boosting aggregates weak hypotheses by votes or weighted majorities. Even if
each weak hypothesis is proper, the aggregate need not lie in `C`. In the
weak-handle class, the easy hypotheses are constants and singletons. Aggregating
them may help prediction improperly, but the marginal-nonuniform target demands
one proper concept. At accuracy `epsilon_n << mu_n/n`, the only legal proper
concepts good enough under `P^*` are seed concepts with the hidden image.

So this edge is not just a generic agnostic-boosting runtime question. The
properness requirement creates a fixed-marginal representation-recovery lower
bound.

## Comparison With Proper ERM And Clause-Satisfaction Witnesses

Fixed-`k` term DNF already separates weak proper learning from strong proper
learning in the distribution-free setting, but its recorded hardness is not a
fixed-marginal marginal-nonuniform lower bound. It is therefore not by itself a
witness for this target.

The clause-satisfaction lookup class has the opposite shape. It gives a strong
fixed-marginal proper agnostic hardness template: use the uniform marginal over
clauses and encode the formula in the conditional labels. However, it does not
satisfy the present source. A weak proper learner for the active formula slice
would already distinguish satisfiable from unsatisfiable instances with
one-sided randomized error.

The one-way weak-handle class combines the useful parts:

- like clause-satisfaction, the hard distribution can be placed under one fixed
  marginal;
- unlike clause-satisfaction, constants and singleton handles make weak proper
  learning easy under every distribution;
- unlike ordinary proper ERM hardness, the strong target is forced to recover a
  representation, because all cheap handles are separated by the
  `epsilon_n = mu_n/(3n)` accuracy demand.

## Proposed Atlas Update

If atlas edits are later allowed, update

`atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`

to:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-weak-handle-class
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: constants and singleton handles give distribution-free weak agnostic proper learning, but strong marginal-nonuniform agnostic proper learning under the fixed coordinate marginal would invert the one-way function."
family: one-way-image-coordinate-weak-handle-hardness
argument_note: "[[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]"
witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
```

Suggested body:

```markdown
## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the one-way image-coordinate weak-handle class: seed concepts for a
length-preserving one-way function, the two constants, and all singleton
positive-atom concepts. Constants and singletons give a distribution-free weak
realizable proper learner with inverse-polynomial advantage. Since the constants
are themselves proper concepts, the low-noise robustification gives weak
agnostic proper learning: if the agnostic optimum is not tiny, a constant is
within the weak additive tolerance; if the optimum is tiny, noisy runs couple to
clean realizable runs and validation finds a proper weak candidate.

For the target lower bound, fix the coordinate marginal with length-`k` mass
`mu_k = 6/(pi^2 k^2)`. On a length-`n` one-way challenge `y=f(s)`, label the
length-`n` coordinate block according to `y`. This distribution is realizable.
A strong marginal-nonuniform agnostic proper learner run with
`epsilon = mu_n/(3n)` must output a seed concept of length `n` with image `y`,
since constants, singletons, wrong lengths, and wrong images all have larger
error. This recovers a preimage of `y` in randomized polynomial time,
contradicting one-wayness.
```

The `axis_delta` should be:

```yaml
resource: same
distribution: distribution-free-to-marginal-nonuniform
strength: weak-to-strong
realizability: same
properness: same
```

## Sources Checked

Local atlas files:

- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `references.bib`

External sources checked:

- da Cunha, Moller Hogsgaard, and Paudice 2026, arXiv:2601.11265:
  https://arxiv.org/abs/2601.11265
- Kearns and Valiant 1994 metadata and abstract:
  https://cir.nii.ac.jp/crid/1360574095867888512
- Hastad, Impagliazzo, Levin, and Luby 1999:
  https://epubs.siam.org/doi/10.1137/S0097539793244708

verdict: resolved-false
confidence: medium-high
