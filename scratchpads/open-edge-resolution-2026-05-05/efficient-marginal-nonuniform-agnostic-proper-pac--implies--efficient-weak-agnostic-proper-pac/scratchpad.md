# Edge: efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-weak-agnostic-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-agnostic-proper-pac.md
- verdict: resolved-true
- confidence: high, under the atlas worst-case transcript convention for efficient PAC resources

## Context

The edge asks whether [[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]] implies [[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]].

The source is stronger than the target in accuracy strength: it gives strong agnostic excess-error learning, while the target only asks for an additive weak agnostic guarantee

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta
$$

for some fixed $\beta<1/2$. The source and target both require agnostic learning and proper output. The only substantive axis change is distributional uniformity:

- source: one uniform learner, but the polynomial sample/time bound may depend on the instance marginal $P$;
- target: one uniform learner with one distribution-free polynomial sample/time bound.

The current edge note marks this as open via [[marginal-uniformization-open|Marginal Uniformization Open]]. However, the atlas now contains [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]], and the sibling edge
[[efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning -> Efficient Agnostic Proper PAC Learning]]
has already been resolved true using that argument. The remaining strong-to-weak step is the trivial monotone relaxation recorded by
[[efficient-agnostic-proper-pac--implies--efficient-weak-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning -> Efficient Weak Agnostic Proper PAC Learning]].

## Attempted Resolution

**Goal.** Given the single learner $A$ promised by the marginal-nonuniform strong agnostic proper source, exhibit an efficient distribution-free weak agnostic proper learner.

There are two clean routes.

**Route 1: compose existing atlas implications.** The source implies [[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]] by [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]. A strong agnostic proper learner is also a weak agnostic proper learner: run it with fixed accuracy parameter $\varepsilon=\beta$ (or any fixed $\varepsilon\le\beta$). Since $\beta<1/2$ is fixed in the target definition, the resulting sample and time bounds remain polynomial in the representation size and $\log(1/\delta)$. Therefore the assigned edge is true by transitivity.

**Route 2: direct proof.** Let $A$ be the single learner promised by the source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the source definition to $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time.

Under the atlas efficient-PAC convention, resource bounds are worst-case/pathwise over finite sample transcripts, not merely in expectation over draws from the marginal. Since $P^\star$ has full support, every finite labeled transcript that can arise under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. If $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate the source resource guarantee for the full-support marginal. Hence $p_{P^\star}$ is one distribution-free polynomial resource bound for $A$.

Accuracy comes from the actual marginal, not from the reference marginal. Fix any joint distribution $\mathcal D$ with marginal $P$. Apply the source guarantee directly to this actual $P$ and choose the strong learner's accuracy parameter $\varepsilon=\beta$. With probability at least $1-\delta$, $A$ outputs $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta.
$$

This is exactly the target's weak agnostic proper guarantee, and the resource bound is the single distribution-free polynomial $p_{P^\star}(s,1/\beta,\log(1/\delta))$.

**Conclusion.** The implication is true under the current atlas convention. The best family assignment is `full-support-marginal-uniformization`, with the body noting the additional trivial strong-to-weak relaxation.

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
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, while source strong agnostic proper accuracy can be run at the fixed weak tolerance."
family: full-support-marginal-uniformization
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

The `axis_delta` can remain:

```yaml
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: same
```

Suggested replacement body:

```markdown
## Verdict

`true`, by full-support marginal uniformization plus the trivial strong-to-weak relaxation.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform strong agnostic proper source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under this marginal.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Therefore $p_{P^\star}$ is one distribution-free resource bound for $A$.

Accuracy is not transferred from $P^\star$. For any actual joint distribution $\mathcal D$ with marginal $P$, apply the source guarantee directly to $P$ and run $A$ with a fixed accuracy parameter $\varepsilon=\beta<1/2$. The source gives a proper hypothesis $h\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta.
$$

Since $1/\beta$ is constant for the target weak learner, the sample and time bounds remain polynomial in the target parameters. Thus the same learner $A$ is an efficient distribution-free weak agnostic proper learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

## Obstacles

No obstacle remains under the current atlas convention.

The caveat is definitional: if a future schema allowed sample-use or runtime bounds only in expectation, or only with high probability over the marginal, then the full-support transcript argument would no longer immediately apply. Under that alternate convention the edge could revert to the older `marginal-uniformization-open` family.

## Next Directions

1. Update the assigned edge note from `marginal-uniformization-open` to `full-support-marginal-uniformization`.
2. Keep the proof close to the already-resolved `efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac` note, adding only the fixed-parameter strong-to-weak step.
3. Consider sweeping the sibling edge `efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-weak-agnostic-improper-pac`, which appears to have the same proof plus a proper-to-improper relaxation.
4. If the atlas intends any runtime convention other than worst-case/pathwise over finite encoded transcripts, document that convention explicitly in the marginal-nonuniform definition notes and revisit this verdict.

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-proper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `references.bib`
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page, especially the marginal-dependent-rate framing and 2026 revision metadata.
