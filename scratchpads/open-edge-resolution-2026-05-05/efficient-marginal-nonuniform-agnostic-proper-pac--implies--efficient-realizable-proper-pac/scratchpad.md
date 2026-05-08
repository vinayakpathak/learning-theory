# Edge: efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-realizable-proper-pac.md
- verdict: resolved-true
- confidence: high, under the atlas worst-case transcript convention for efficient PAC resources

## Context

The edge asks whether [[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]] implies [[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]].

The source is stronger than the target on realizability: an agnostic excess-error guarantee specializes to a realizable guarantee when $\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)=0$. The source and target both require strong accuracy, efficient resources, and proper output. The only nontrivial axis change is distribution:

- source: one uniform learner, but the sample/time polynomial may depend on the instance marginal $P$;
- target: one uniform learner with one distribution-free sample/time polynomial.

The current edge note marks this as open via [[marginal-uniformization-open|Marginal Uniformization Open]]. However, the atlas now contains [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]], and the sibling edges
`efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac` and
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac`
have already been resolved true using that argument. The remaining agnostic-to-realizable step is the trivial monotone relaxation recorded by [[monotone-relaxation|Monotone Relaxation]] and by
`efficient-agnostic-proper-pac -> efficient-realizable-proper-pac`.

## Attempted Resolution

**Goal.** Given the single learner $A$ promised by the marginal-nonuniform agnostic proper source, exhibit an efficient distribution-free realizable proper learner.

There are two equivalent routes.

**Route 1: compose known atlas implications.** The source implies [[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]] by [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]. An agnostic proper distribution-free learner is also a realizable proper distribution-free learner, since on realizable distributions the optimum proper benchmark error is zero. Therefore the assigned edge is true by transitivity.

**Route 2: direct proof.** Let $A$ be the single learner promised by the source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the source definition to $P^\star$ gives a polynomial $p_{P^\star}$ bounding the sample use and runtime of $A$.

Under the atlas efficient-PAC convention, resource bounds are worst-case/pathwise over finite sample transcripts, not merely in expectation over draws from the marginal. Since $P^\star$ has full support, every finite labeled transcript that can arise under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. If $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate the source resource guarantee for the full-support marginal. Hence $p_{P^\star}$ is one distribution-free polynomial resource bound for $A$.

Accuracy comes from the actual marginal, not from the reference marginal. Fix any realizable joint distribution $\mathcal D$ with marginal $P$ and labels $y=c(x)$ for some $c\in\mathcal C$. The source guarantee applies directly to this $P$ and this joint distribution: with probability at least $1-\delta$, $A$ outputs $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{P}(h,c)
=
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c'\in\mathcal C}\operatorname{err}_{\mathcal D}(c')+\varepsilon
=
\varepsilon .
$$

Thus the same learner $A$ satisfies the target's strong realizable proper guarantee with a distribution-free polynomial sample/time bound.

**Conclusion.** The implication is true under the current atlas convention. The best family assignment is `full-support-marginal-uniformization`, with a note in the body that agnostic-to-realizable is a monotone relaxation.

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
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, while source agnostic proper accuracy specializes to realizable proper accuracy for every marginal."
family: full-support-marginal-uniformization
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

The `axis_delta` should keep `distribution: marginal-nonuniform-to-distribution-free`, `realizability: agnostic-to-realizable`, and `properness: same`.

Suggested replacement body:

```markdown
## Verdict

`true`, by full-support marginal uniformization plus the monotone relaxation from agnostic to realizable learning.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under this marginal.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Therefore $p_{P^\star}$ is one distribution-free resource bound for $A$.

Accuracy is not transferred from $P^\star$. For any actual realizable distribution $\mathcal D$ with marginal $P$ and target $c\in\mathcal C$, apply the source guarantee directly to $P$. Since $\inf_{c'\in\mathcal C}\operatorname{err}_{\mathcal D}(c')=0$, the agnostic excess-error guarantee gives a proper hypothesis $h\in\mathcal C$ with $\operatorname{err}_{P}(h,c)\le\varepsilon$. Thus the same learner $A$ is an efficient distribution-free realizable proper learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

## Obstacles

No obstacle remains under the current atlas convention.

The caveat is definitional: if a future schema allowed runtime or sample-use bounds only in expectation, or only with high probability over the marginal, then the full-support transcript argument would no longer immediately apply. Under that alternate convention the edge could revert to the older `marginal-uniformization-open` family.

## Next Directions

1. Update the assigned edge note from `marginal-uniformization-open` to `full-support-marginal-uniformization`.
2. Keep the proof close to the already-resolved `efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac` and `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac` notes.
3. If the atlas intends any runtime convention other than worst-case/pathwise over finite encoded transcripts, document that convention explicitly in the marginal-nonuniform definition notes and revisit this verdict.

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/monotone-relaxation.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-proper-pac--implies--efficient-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-proper-pac.md`
