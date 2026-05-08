# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-agnostic-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md
- verdict: resolved-true
- confidence: high, under the atlas worst-case transcript convention for efficient PAC resources

## Context

The edge asks whether [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]] implies [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]].

The source and target have the same strength, realizability, properness, and computational resource axis. The only axis change is:

- source: one uniform learner, but the sample/time polynomial may depend on the instance marginal $P$;
- target: one uniform learner with one distribution-free sample/time polynomial.

The current edge note marks this as open via [[marginal-uniformization-open|Marginal Uniformization Open]]. However, the atlas now contains [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]], which resolves same-requirement marginal-to-distribution-free computational edges under the atlas convention that sample use and runtime are worst-case/pathwise bounds on finite encoded sample transcripts.

Three already-resolved sibling edges use this argument:

- `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac`;
- `efficient-marginal-nonuniform-realizable-improper-pac -> efficient-realizable-improper-pac`;
- `efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac`.

The assigned edge is the missing agnostic-improper analogue and is actually a little cleaner than the agnostic-proper sibling, since no output constraint is lost or strengthened.

## Attempted Resolution

**Goal.** Given the single learner $A$ promised by the marginal-nonuniform agnostic improper source, exhibit the same learner as a distribution-free efficient agnostic improper learner with one polynomial resource bound.

**Uniformizing resources.** Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the source definition to $P^\star$ gives a polynomial $p_{P^\star}$ bounding the sample use and runtime of $A$.

Under the atlas efficient-PAC convention, these resource bounds are worst-case/pathwise over finite sample transcripts, not merely in expectation over draws from the marginal. Since $P^\star$ has full support, every finite labeled transcript that can arise under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. If $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate the source resource guarantee for the full-support marginal. Therefore $p_{P^\star}$ is a single distribution-free polynomial resource bound for $A$.

**Accuracy is taken from the actual marginal.** Fix any joint distribution $\mathcal D$ with marginal $P$. The source guarantee applies directly to this actual $P$: with the requested probability, $A$ returns an improper hypothesis $h$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$

This step does not try to transfer agnostic excess error from $P^\star$ to $P$; it only uses $P^\star$ to obtain the uniform resource polynomial. Thus the usual component-mixture obstacle for agnostic error is avoided.

**Conclusion.** The same learner $A$ has the source agnostic-improper accuracy guarantee for every marginal and, by the full-support reference marginal, one distribution-free polynomial bound on sample use and running time. Hence the implication is true under the atlas convention.

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
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, while source agnostic-improper accuracy already holds for every marginal."
family: full-support-marginal-uniformization
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

Suggested replacement body:

```markdown
## Verdict

`true`, by full-support marginal uniformization.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under this marginal.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Therefore $p_{P^\star}$ is one distribution-free resource bound for $A$.

Accuracy is not transferred from $P^\star$. For any actual joint distribution $\mathcal D$ with marginal $P$, apply the source guarantee directly to $P$. The source already gives the agnostic excess-error guarantee and permits improper output, so the same learner $A$ is an efficient distribution-free agnostic improper learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

## Obstacles

No obstacle remains under the current atlas convention.

The only caveat is definitional: if a future schema allowed runtime/sample-use bounds only in expectation or with high probability over the marginal, rather than worst-case/pathwise over encoded transcripts, the full-support argument would no longer immediately apply. In that alternate convention, the edge could revert to the more delicate `marginal-uniformization-open` family.

## Next Directions

1. Update the assigned edge note to use `full-support-marginal-uniformization`, matching the resolved agnostic-proper sibling edge.
2. Consider sweeping the remaining `marginal-uniformization-open` edges whose source and target differ only by marginal-nonuniform-to-distribution-free and whose other target requirements are already met by the source.
3. If the atlas intends a different runtime convention for randomized learners, spell that out in `atlas/README.md` or the marginal-nonuniform definition notes, because the verdict depends on this convention.

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/implications/sample-efficient-marginal-nonuniform-agnostic-improper-pac--implies--sample-efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page and PDF snippets, especially the trichotomy statement relating polynomial marginal-nonuniform sample rates to finite VC dimension.
