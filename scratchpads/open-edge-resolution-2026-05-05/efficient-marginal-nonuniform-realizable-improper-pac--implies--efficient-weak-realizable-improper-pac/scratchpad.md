# Edge: efficient-marginal-nonuniform-realizable-improper-pac -> efficient-weak-realizable-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md
- verdict: resolved-true
- confidence: high

## Context

The assigned edge asks whether [[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]] implies [[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]].

The current edge note marks this as `open` via [[marginal-uniformization-open|Marginal Uniformization Open]]: the source gives one learner $A$ whose sample and runtime polynomial may depend on the instance marginal $P$, while the target wants a distribution-free efficient weak learner with one polynomial bound and one inverse-polynomial advantage.

This is now stale under the current atlas convention. `atlas/README.md` states that efficient PAC sample use and running time are worst-case/pathwise bounds on finite encoded sample transcripts. Under that convention, [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]] converts the marginal-dependent resource polynomial for a single source learner into a distribution-free resource polynomial. The stronger sibling edge

`efficient-marginal-nonuniform-realizable-improper-pac -> efficient-realizable-improper-pac`

is already marked `true` by that argument. Since

`efficient-realizable-improper-pac -> efficient-weak-realizable-improper-pac`

is also `true` by monotone relaxation, the assigned edge follows immediately by transitivity.

## Attempted Resolution

**Goal.** Given the single learner $A$ promised by the marginal-nonuniform realizable improper source, produce an efficient distribution-free weak realizable improper learner.

**Route 1: compose existing atlas implications.** The source implies [[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]] by the full-support marginal uniformization edge. Strong distribution-free realizable improper learning then trivially implies weak distribution-free realizable improper learning: run the strong learner with any fixed accuracy $\varepsilon<1/2$, for instance $\varepsilon=1/4$, yielding weak advantage $\gamma=1/4$. This proves the assigned edge.

**Route 2: direct proof.** Let $A$ be the source learner. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source guarantee for $P^\star$ supplies a polynomial $p_{P^\star}(s,1/\varepsilon,\log(1/\delta))$ bounding $A$'s sample use and running time.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any realizable marginal $P$ and target concept $c\in\mathcal C$ has positive probability under $P^\star$ with the same target concept $c$. Under the atlas worst-case/pathwise resource convention, if $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate its resource guarantee for the reference marginal. Therefore $p_{P^\star}$ is one distribution-free polynomial resource bound for $A$.

For accuracy, fix the actual realizable distribution $(X,c(X))$ with $X\sim P$. Apply the source guarantee directly to this actual marginal $P$, not to $P^\star$. Run $A$ with $\varepsilon=1/4$. With probability at least $1-\delta$ it outputs an improper hypothesis $h$ satisfying

$$
\operatorname{err}_P(h,c)\le 1/4.
$$

This is a weak realizable guarantee with constant advantage $\gamma=1/4$, hence with inverse-polynomial advantage. The resource bound is the distribution-free polynomial $p_{P^\star}(s,4,\log(1/\delta))$.

**Conclusion.** The same learner $A$, run at fixed constant accuracy, witnesses efficient weak realizable improper PAC learning. The implication is true under the atlas's stated worst-case/pathwise efficiency convention.

## Proposed Atlas Update

Frontmatter:

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
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, and running the strong source learner at constant accuracy gives weak realizable advantage."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: same
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

Replacement body sketch:

```markdown
# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`, by full-support marginal uniformization plus strong-to-weak relaxation.

## Proof

Let $A$ be the single learner promised by the marginal-nonuniform realizable improper source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source guarantee for $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time.

Every finite realizable labeled transcript that can occur under any marginal $P$ and target $c\in\mathcal C$ has positive probability under $P^\star$ with the same target $c$. Since the atlas uses worst-case/pathwise resource bounds on finite encoded sample transcripts, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Thus $p_{P^\star}$ is one distribution-free resource bound for $A$.

For accuracy, fix the actual marginal $P$ and target $c$. Apply the source guarantee directly to $P$ and run $A$ with a fixed constant accuracy, say $\varepsilon=1/4$. With probability at least $1-\delta$, the output satisfies $\operatorname{err}_P(h,c)\le 1/4$, which is weak realizable learning with constant advantage $\gamma=1/4$. The output is improper, as the target allows.

Therefore $A$ witnesses efficient distribution-free weak realizable improper PAC learning.
```

## Obstacles

No remaining obstacle under the current atlas convention.

The only caveat is definitional. If a future version of the schema interpreted efficient sample use or runtime only in expectation, or only with high probability under each marginal, then the full-support transcript argument would no longer automatically give a distribution-free worst-case resource polynomial. The current `atlas/README.md` explicitly rules this out by using worst-case/pathwise finite-transcript bounds.

## Next Directions

- Update the assigned edge note from `open` to `true`.
- Replace the `marginal-uniformization-open` family with `full-support-marginal-uniformization`.
- Add `bendavid1995parameterization` to the edge's `ref_keys`, matching the full-support argument note and the already-resolved stronger sibling edge.
- Consider separately updating the sibling edge `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac`, which has the same resource-uniformization proof without the strong-to-weak relaxation.

## References Checked

- `atlas/README.md`
- [[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]
- [[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[marginal-uniformization-open|Marginal Uniformization Open]]
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- Benedek and Itai 1991 (`benedek1991fixed`)
- Ben-David, Benedek, and Mansour 1995 (`bendavid1995parameterization`)
- Hanneke, Moran, and Thiessen 2025 (`hanneke2025marginalnonuniform`)
