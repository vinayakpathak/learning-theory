# Edge: efficient-marginal-nonuniform-realizable-proper-pac -> efficient-weak-realizable-improper-pac

- date: 2026-05-05
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source_definition: `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- target_definition: `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- main_argument_notes:
  - `atlas/arguments/full-support-marginal-uniformization.md`
  - `atlas/arguments/monotone-relaxation.md`
- related_edges_checked:
  - `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-proper-pac.md`
  - `atlas/implications/efficient-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`

## Current Atlas State

The assigned edge is currently marked `open`, with family `marginal-uniformization-open`. Its stated obstacle is that the source allows a marginal-dependent polynomial $p_P$, while the target asks for one distribution-free polynomial.

This obstacle has been superseded for this kind of edge by `full-support-marginal-uniformization`, under the atlas convention recorded in `atlas/README.md`: efficient PAC sample use and running time are worst-case/pathwise bounds on finite encoded sample transcripts, not merely expected or high-probability bounds under the marginal.

The sibling edge

`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac`

is already resolved `true` by full-support marginal uniformization. The edge

`efficient-realizable-proper-pac -> efficient-weak-realizable-improper-pac`

is already resolved `true` by monotone relaxation.

## Verdict

This edge is resolved true under the current atlas convention.

There are two equivalent routes:

1. Compose the existing resolved edge to `efficient-realizable-proper-pac` with the monotone edge from strong proper realizable learning to weak improper realizable learning.
2. Give the direct proof below: full-support uniformization gives one distribution-free resource polynomial for the same learner, strong realizable accuracy gives a weak advantage, and a proper output is automatically allowed by the improper target.

## Direct Proof

**Goal.** Given an efficient marginal-nonuniform realizable proper PAC learner for a binary class $\mathcal C$, construct an efficient distribution-free weak realizable improper PAC learner for $\mathcal C$.

**Source learner.** Let $A$ be the single learner promised by the source node. For every marginal $P$ on $\mathcal X$, there is a polynomial $p_P$ such that for every $c\in\mathcal C$ and every $\varepsilon,\delta\in(0,1)$, $A$ uses at most $p_P(s,1/\varepsilon,\log(1/\delta))$ samples and time, and with probability at least $1-\delta$ outputs $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \varepsilon.
$$

The learner is one uniform algorithm; only the polynomial bound is allowed to depend on $P$.

**Uniformizing the resource bound.** Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the source guarantee to $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time.

Now fix any marginal $P$, target concept $c\in\mathcal C$, and any finite labeled transcript that can arise from examples $(X,c(X))$ with $X\sim P$. Since $P^\star$ has full support, the same finite instance sequence has positive probability under $P^\star$, and with the same target concept $c$ it induces exactly the same labeled transcript. If $A$ exceeded the bound $p_{P^\star}$ on that transcript, then under $P^\star$ and target $c$ this violation would occur with positive probability. That contradicts the atlas pathwise/worst-case resource convention for the source guarantee at $P^\star$.

Therefore the same learner $A$ has one distribution-free polynomial sample/time bound, namely $p_{P^\star}$.

**Accuracy for the actual marginal.** Accuracy is not transferred from $P^\star$. For an arbitrary target marginal $P$ and realizable labeling $c\in\mathcal C$, apply the source guarantee directly at that actual $P$.

To meet the weak target, run $A$ with a fixed strong accuracy parameter, say $\varepsilon_0=1/4$, and confidence $\delta$. Then with probability at least $1-\delta$,

$$
\operatorname{err}_P(h,c)\le 1/4 = 1/2 - 1/4.
$$

Thus $A$ is a weak learner with constant advantage $\gamma=1/4$, which is in particular an inverse-polynomial advantage. If the target interface explicitly supplies a smaller requested weak advantage $\gamma\le 1/4$, the same run also satisfies $\operatorname{err}_P(h,c)\le 1/2-\gamma$. Runtime remains polynomial in the target parameters because it is bounded by the fixed-accuracy polynomial $p_{P^\star}(s,4,\log(1/\delta))$, which is certainly polynomial in $s$, $1/\gamma$, and $\log(1/\delta)$ for $\gamma\le 1/4$.

**Proper-to-improper monotonicity.** The source learner returns $h\in\mathcal C$. The improper target permits hypotheses outside $\mathcal C$ but does not require them. Hence the allowed output set for the improper target contains the proper output set. No properization theorem, representation conversion, or postprocessing is needed: the exact same proper hypothesis is a valid improper hypothesis.

**Conclusion.** The same algorithm $A$, run at fixed accuracy, witnesses efficient distribution-free weak realizable improper PAC learning. The nontrivial step is full-support marginal uniformization of the resource polynomial; strong-to-weak and proper-to-improper are monotone relaxations.

## Proposed Atlas Metadata

```yaml
type: implication
id: efficient-marginal-nonuniform-realizable-proper-pac__implies__efficient-weak-realizable-improper-pac
source: efficient-marginal-nonuniform-realizable-proper-pac
target: efficient-weak-realizable-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
target_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "unclear"
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
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial; source realizable proper accuracy then relaxes to weak realizable improper accuracy."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: proper-to-improper
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
tags:
  - atlas/implication
  - learning/binary-classification
```

## Proposed Atlas Body

```markdown
# Efficient Marginal-Nonuniform Realizable Proper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`, by full-support marginal uniformization plus monotone relaxation from strong proper learning to weak improper learning.

## Proof

**Goal.** Construct one distribution-free efficient weak realizable improper learner from the marginal-nonuniform realizable proper learner.

Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source guarantee at $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time.

Because $P^\star$ has full support, every finite realizable labeled transcript that can occur under any marginal $P$ and target $c\in\mathcal C$ has positive probability under $P^\star$ with the same target $c$. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Hence $p_{P^\star}$ is a distribution-free resource bound for $A$.

Accuracy is checked under the actual marginal $P$, not under $P^\star$. For any realizable distribution labeled by $c\in\mathcal C$, run $A$ with fixed accuracy parameter $\varepsilon=1/4$. With probability at least $1-\delta$, it outputs $h\in\mathcal C$ with error at most $1/4$, so it has weak advantage $\gamma=1/4$.

Finally, the target is improper only in the permissive sense: hypotheses outside $\mathcal C$ are allowed, but proper hypotheses are still valid. Thus the proper output of $A$ is already an admissible improper hypothesis. The same learner witnesses the target.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

## Caveat

The verdict depends on the atlas's current pathwise/worst-case convention for efficient PAC resource bounds. If the schema were changed so that marginal-nonuniform runtime or sample use were only bounded in expectation, or only with high probability over the marginal, the full-support transcript argument would no longer be immediate.

verdict: resolved-true
confidence: high
