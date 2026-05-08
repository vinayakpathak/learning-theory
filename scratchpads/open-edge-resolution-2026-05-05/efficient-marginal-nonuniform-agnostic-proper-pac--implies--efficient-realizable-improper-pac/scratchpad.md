# Edge: efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-realizable-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md
- verdict: resolved-true
- confidence: high, under the atlas worst-case transcript convention for efficient PAC resources

## Context

The edge asks whether [[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]] implies [[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]].

The source has one uniform learner $A$, but its sample and runtime polynomial may depend on the instance marginal $P$. It is strong, agnostic, and proper: for every joint distribution $\mathcal D$ with marginal $P$, it returns $h \in \mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

using at most $p_P(s,1/\varepsilon,\log(1/\delta))$ samples/time.

The target asks for a distribution-free efficient realizable improper learner. Relative to the source, the target relaxes realizability from agnostic to realizable and relaxes properness from proper to improper, but strengthens the distribution axis from marginal-dependent polynomial bounds to one distribution-free polynomial bound.

The current edge note marks this as open via [[marginal-uniformization-open|Marginal Uniformization Open]]. However, the atlas now contains [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]], which resolves exactly the remaining distribution-axis obstruction under the atlas convention that efficient PAC resources are worst-case/pathwise bounds over finite encoded sample transcripts.

## Attempted Resolution

**Goal.** Starting from the marginal-nonuniform agnostic proper learner $A$, exhibit one distribution-free polynomial resource bound and the realizable improper accuracy guarantee.

**Uniform resource bound.** Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the source guarantee to $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under that marginal.

Under the atlas efficient-PAC convention, these resource bounds are worst-case/pathwise over finite sample transcripts, not only in expectation or with high probability over draws from the marginal. Because $P^\star$ has full support, every finite labeled transcript that can occur under any target marginal can also occur with positive probability under $P^\star$ for a suitable conditional label rule. If $A$ used more than $p_{P^\star}$ samples/time on such a transcript, it would violate the source resource bound for the full-support marginal. Therefore the same polynomial $p_{P^\star}$ bounds $A$ on all finite transcripts and is a distribution-free efficient resource bound.

**Accuracy.** Accuracy is not transferred from $P^\star$. Fix an arbitrary realizable PAC distribution: $x\sim D$ and labels are $c^\star(x)$ for some $c^\star\in\mathcal C$. Let $P=D$. Applying the source guarantee directly to this actual marginal and joint distribution gives, with probability at least $1-\delta$,

$$
\operatorname{err}_D(h,c^\star)
\le
\inf_{c\in\mathcal C}\operatorname{err}_D(c,c^\star)+\varepsilon
=\varepsilon.
$$

The source output is proper, $h\in\mathcal C$, but the target permits improper hypotheses, so the same output is allowed. Thus $A$ is an efficient distribution-free realizable improper PAC learner.

**Transitive atlas route.** Equivalently, the source implies the distribution-free agnostic improper node by [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]] plus proper-to-improper monotone relaxation. The existing edge `efficient-agnostic-improper-pac -> efficient-realizable-improper-pac` is true by [[monotone-relaxation|Monotone Relaxation]], since the agnostic optimum is zero in the realizable case.

**Conclusion.** The implication is true under the current atlas convention.

## Proposed Atlas Update

Frontmatter changes:

```yaml
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
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, and the source agnostic proper guarantee specializes to the realizable improper target."
family: full-support-marginal-uniformization
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

The existing `axis_delta` can remain:

```yaml
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: agnostic-to-realizable
  properness: proper-to-improper
```

Suggested replacement body:

```markdown
## Verdict

`true`, by full-support marginal uniformization plus monotone relaxation from agnostic proper learning to realizable improper learning.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform agnostic proper source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under this marginal.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Therefore $p_{P^\star}$ is one distribution-free resource bound for $A$.

Accuracy is obtained from the actual marginal. For any realizable distribution labeled by $c^\star\in\mathcal C$, apply the source agnostic guarantee to that distribution. Since the benchmark error is zero, $A$ returns $h\in\mathcal C$ with error at most $\varepsilon$. The target allows improper output, so this proper hypothesis is valid for the target.

Thus the same learner is an efficient distribution-free realizable improper PAC learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

## Obstacles

No obstacle remains under the current atlas convention.

The caveat is definitional. If efficient-PAC resource bounds were later interpreted only in expectation, or only with high probability over samples from the marginal, then the full-support transcript argument would no longer immediately imply one worst-case distribution-free polynomial bound. Under that alternate convention, this edge should be revisited.

## Next Directions

1. Update the assigned edge note to `status: "true"` with `family: full-support-marginal-uniformization`.
2. Add `bendavid1995parameterization` to the edge's `ref_keys`, matching the full-support argument note.
3. Sweep remaining `marginal-uniformization-open` computational edges whose source already satisfies all non-distribution requirements of the target; several may resolve by the same full-support argument.

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md`
