# Edge: efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-weak-realizable-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md
- verdict: resolved-true
- confidence: high, under the atlas worst-case transcript convention for efficient PAC resources

## Context

The edge asks whether [[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]] implies [[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]].

The current edge note marks this as open because it treats the marginal-nonuniform-to-distribution-free step as a possible uniformization obstacle. The source has one learner $A$ for all joint distributions, but its sample and runtime polynomial may depend on the instance marginal $P$. The target requires one distribution-free polynomial bound, and otherwise only weakens the learning requirement: agnostic to realizable, strong to weak, and proper to improper.

The atlas now contains [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]], and the edge
`efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac`
is already marked `true` using that argument. The edge
`efficient-agnostic-proper-pac -> efficient-weak-realizable-improper-pac`
is also marked `true` as a [[monotone-relaxation|Monotone Relaxation]].

## Attempted Resolution

**Goal.** Produce an efficient distribution-free weak realizable improper learner from the marginal-nonuniform strong agnostic proper learner.

There are two equivalent proofs.

**Route 1: compose existing atlas edges.** The source implies [[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]] by [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]. Distribution-free strong agnostic proper learning trivially implies distribution-free weak realizable improper learning: on realizable distributions the agnostic optimum is zero, a proper output is allowed by an improper target, and a strong learner can be run to any fixed accuracy below $1/2$. Thus the assigned edge is true by transitivity.

**Route 2: direct proof.** Let $A$ be the single learner promised by the source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the source definition to $P^\star$ gives a polynomial $p_{P^\star}$ bounding the sample use and runtime of $A$.

Under the atlas efficient-PAC convention, resource bounds are worst-case/pathwise over finite encoded sample transcripts, not merely in expectation over draws from the marginal. Since $P^\star$ has full support, every finite labeled transcript that can arise under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. If $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate the source resource guarantee for the full-support marginal. Hence $p_{P^\star}$ is one distribution-free polynomial resource bound for $A$.

Accuracy is not transferred from $P^\star$. Fix any realizable distribution $\mathcal D$ with marginal $P$ and labels $y=c(x)$ for some $c\in\mathcal C$. The source guarantee applies directly to this $P$ and this realizable joint distribution. With probability at least $1-\delta$, $A$ outputs $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{P}(h,c)
=
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c'\in\mathcal C}\operatorname{err}_{\mathcal D}(c')+\varepsilon
=
\varepsilon .
$$

To meet the weak target, run $A$ with any fixed $\varepsilon \le 1/2-\gamma$, where $\gamma$ is an inverse-polynomial advantage parameter for the target. For example, taking $\varepsilon=1/4$ gives advantage $\gamma=1/4$ if the target node only requires some inverse-polynomial advantage; under a parameterized convention, choose $\varepsilon=1/2-\gamma$. The output is proper, hence allowed in the improper model. Therefore the same learner witnesses efficient distribution-free weak realizable improper PAC learning.

**Conclusion.** The implication is true under the current atlas convention. The assigned edge should move from `marginal-uniformization-open` to `full-support-marginal-uniformization`, with a note that the remaining strength, realizability, and properness changes are monotone relaxations.

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
summary: "True under the atlas worst-case efficiency convention: full-support marginal uniformization gives a distribution-free strong agnostic proper learner, and monotone relaxation gives the weak realizable improper target."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: agnostic-to-realizable
  properness: proper-to-improper
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

Suggested replacement body:

```markdown
## Verdict

`true`, by full-support marginal uniformization followed by monotone relaxation.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform agnostic proper source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under this marginal.

Because $P^\star$ has full support, every finite labeled transcript possible under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Therefore $p_{P^\star}$ is one distribution-free resource polynomial for $A$.

For accuracy, fix the actual realizable distribution $\mathcal D$ with marginal $P$ and target $c\in\mathcal C$. The source guarantee applied to $P$ directly gives a proper hypothesis $h\in\mathcal C$ with $\operatorname{err}_{P}(h,c)\le\varepsilon$, since the optimal proper error is zero. Run $A$ with a fixed $\varepsilon<1/2$ to obtain an inverse-polynomial weak advantage, or with $\varepsilon\le 1/2-\gamma$ for a requested inverse-polynomial advantage parameter $\gamma$. The proper output is allowed by the improper target.

Thus the same learner is an efficient distribution-free weak realizable improper PAC learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

## Obstacles

No obstacle remains under the current atlas convention.

The caveat is definitional: if a future schema allowed runtime or sample-use bounds only in expectation, or only with high probability over the marginal, then the full-support transcript argument would no longer immediately apply. Under that alternate convention the edge could revert to the older `marginal-uniformization-open` family.

## Next Directions

1. Update the assigned edge note from `open` to `true` using the proposed proof.
2. Audit sibling edges from `efficient-marginal-nonuniform-agnostic-proper-pac` that still cite `marginal-uniformization-open`; the same full-support argument appears to resolve at least the weak realizable proper sibling edge as well.
3. If the atlas intends a non-worst-case runtime convention, document it explicitly in the marginal-nonuniform definition notes and revisit every use of [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]].

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/monotone-relaxation.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac/scratchpad.md`
