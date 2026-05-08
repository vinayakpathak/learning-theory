# Edge Resolution Scratchpad

Edge:

`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-weak-realizable-proper-pac`

Depth: 1

## Files Read

- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/monotone-relaxation.md`
- `atlas/arguments/properization-open.md`

## Current Atlas State

The edge file is still marked:

```yaml
status: "open"
evidence: unknown
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
```

However, the atlas now also contains `full-support-marginal-uniformization.md`, whose verdict is true under the atlas convention that efficient PAC sample use and running time are worst-case bounds on finite encoded sample transcripts. Nearby source edges using this argument have already been resolved true, including:

- `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac`
- `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-weak-realizable-improper-pac`

The present edge is the proper weak version of the second one and is also implied by the first one followed by the already-true monotone relaxation

`efficient-realizable-proper-pac -> efficient-weak-realizable-proper-pac`.

## Verdict

Resolved true, under the same atlas worst-case/pathwise resource convention used by `full-support-marginal-uniformization`.

The proof does not use boosting, so there is no properness loss. The source learner already outputs a concept in `C`; running it to constant strong accuracy gives a weak learner whose output remains proper.

## Proof

**Goal.** Show that one efficient marginal-nonuniform realizable proper PAC learner yields one distribution-free efficient weak realizable proper PAC learner.

Let `A` be the single learner promised by the source. Thus for every marginal `P` there is a polynomial `p_P` such that for every target concept `c in C` and every `epsilon, delta in (0,1)`, `A`, given examples from `(X,c(X))` with `X ~ P`, runs in time and samples at most

```text
p_P(s, 1/epsilon, log(1/delta))
```

and outputs `h in C` with `err_P(h,c) <= epsilon` with probability at least `1 - delta`.

**Subgoal 1: uniformize the resource bound.** Choose a full-support reference marginal `P^star` on every finitely encoded instance in each representation-size slice. Applying the source guarantee to `P^star` gives a polynomial `p_{P^star}` bounding `A`'s sample use and runtime under that marginal.

Every finite realizable labeled transcript that can occur under any marginal `P` and target `c in C` has positive probability under `P^star` with the same target labels on the sampled instances. Under the atlas worst-case/pathwise convention for efficient sample use and runtime, `A` cannot exceed the `p_{P^star}` bound on any such finite transcript; otherwise it would violate the source guarantee at `P^star`. Hence `p_{P^star}` is one distribution-free polynomial resource bound for `A`.

**Subgoal 2: get weak accuracy under the actual marginal.** The accuracy guarantee is not transferred through `P^star`. Instead, fix the actual target marginal `P` and apply the source guarantee directly to `P`. Run `A` with a constant accuracy parameter, say `epsilon = 1/4`. With probability at least `1 - delta`, `A` outputs `h in C` satisfying

```text
err_P(h,c) <= 1/4 = 1/2 - 1/4.
```

Thus the same run is a weak learner with constant advantage `gamma = 1/4`, which is certainly inverse-polynomial. Since `epsilon` is fixed, the resource bound is polynomial in the representation size and `log(1/delta)`; it also satisfies any target accounting that includes `1/gamma`, because `1/gamma = 4`.

**Subgoal 3: preserve properness.** The source learner is proper, so its output is always in `C`. The weak target also requires a proper hypothesis in `C`. No boosting or improper majority vote is introduced, so properness is preserved verbatim.

Combining the uniform resource bound, actual-marginal accuracy at constant `epsilon`, and proper output constraint proves the implication.

## Proposed Atlas Metadata

```yaml
type: implication
id: efficient-marginal-nonuniform-realizable-proper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-realizable-proper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
target_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "open-edge-resolution-2026-05-05"
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, and running the source proper strong learner at constant accuracy gives a proper weak learner."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: same
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
tags:
  - atlas/implication
  - learning/binary-classification
```

## Proposed Atlas Body

```markdown
# Efficient Marginal-Nonuniform Realizable Proper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`true`, by full-support marginal uniformization plus strong-to-weak relaxation.

## Proof

**Goal.** Construct one distribution-free efficient weak realizable proper learner from the marginal-nonuniform realizable proper learner.

Let $A$ be the single learner promised by the source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source guarantee at $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time.

Because $P^\star$ has full support, every finite realizable labeled transcript that can occur under any marginal $P$ and target $c\in\mathcal C$ has positive probability under $P^\star$ with the same target labels. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Hence $p_{P^\star}$ is a distribution-free resource bound for $A$.

Accuracy is checked under the actual marginal $P$, not under $P^\star$. For any realizable distribution labeled by $c\in\mathcal C$, run $A$ with fixed accuracy parameter $\varepsilon=1/4$. With probability at least $1-\delta$, it outputs $h\in\mathcal C$ with error at most $1/4$, so it has weak advantage $\gamma=1/4$.

The output remains proper throughout: the source learner already returns $h\in\mathcal C$, and the proof does not apply boosting or any improper post-processing. Thus the same learner witnesses efficient weak realizable proper PAC learning.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

## Caveats

The resolution depends on the convention stated in `full-support-marginal-uniformization`: efficient PAC sample use and running time are worst-case/pathwise bounds over finite encoded sample transcripts. If the source allowed only expected-time or high-probability resource bounds under each marginal, the full-support argument would not by itself give a uniform worst-case polynomial.

No additional properization theorem is needed. This is important because generic improper-to-proper conversion remains open elsewhere in the atlas, but this edge never leaves the proper class.

verdict: resolved-true
confidence: 0.88
