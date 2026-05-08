# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-weak-realizable-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md
- verdict: resolved-true
- confidence: high

## Context

The assigned edge is currently marked `open` because it was grouped with marginal-uniformization questions: the source permits a polynomial sample/time bound $p_P$ depending on the instance marginal $P$, while the target asks for one distribution-free polynomial weak learner.

The relevant definitions are:

- [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]: one learner $A$ works for all joint distributions, but for each marginal $P$ the resource bound may be a different polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$.
- [[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]: for every distribution $D$ and every target $c\in\mathcal C$, an improper learner outputs a hypothesis with error at most $1/2-\gamma$ for inverse-polynomial $\gamma$, using distribution-free polynomial resources.

Two existing atlas facts remove the apparent obstacles:

- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-improper-pac.md` is already `true` by monotone relaxation: agnostic-to-realizable and strong-to-weak only weaken the target requirements, and improperness is unchanged.
- `atlas/arguments/full-support-marginal-uniformization.md` records a `true` argument under the atlas convention that efficient PAC sample use and running time are worst-case/pathwise bounds on finite encoded sample transcripts. A full-support reference marginal converts the marginal-dependent polynomial of the single source learner into one distribution-free transcript-wise polynomial.

So this edge is not a genuine open problem under the current atlas convention. It is a direct combination of monotone relaxation with full-support marginal uniformization.

## Attempted Resolution

**Goal.** Starting from an efficient marginal-nonuniform agnostic improper learner $A$, show that the same class has an efficient distribution-free weak realizable improper learner.

**Accuracy.** Fix an arbitrary realizable distribution: examples have the form $(x,c(x))$ with $x\sim D$ and $c\in\mathcal C$. Let $P=D$ be the instance marginal. Since the distribution is realizable,

$$
\inf_{c'\in\mathcal C}\operatorname{err}_D(c',c)=0.
$$

Run the source learner $A$ with a fixed constant accuracy parameter, say $\varepsilon=1/4$. The source's agnostic guarantee, applied to the actual marginal $P$, gives with probability at least $1-\delta$ that

$$
\operatorname{err}_D(h,c)\le 1/4.
$$

This is a weak realizable guarantee with constant advantage $\gamma=1/4$, which is certainly inverse-polynomial. The output is improper, exactly as the target permits.

**Uniform resource bound.** The only remaining issue is that the source resource bound may be $p_P$, depending on $P$, while the target needs one distribution-free polynomial. Apply [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]] to the same learner $A$.

Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source guarantee for $P^\star$ supplies a polynomial $p_{P^\star}$ bounding $A$'s sample use and runtime for every joint distribution whose marginal is $P^\star$.

Under the atlas worst-case/pathwise efficiency convention, this bound holds on every finite labeled sample transcript that can occur with positive probability under $P^\star$. Because $P^\star$ has full support, any finite labeled transcript that can occur under any other marginal also has positive probability under $P^\star$ for a suitable realizable target or, more generally, for a suitable conditional label rule. If $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate the source resource guarantee for the reference marginal.

Therefore $p_{P^\star}$ is a single distribution-free polynomial sample/time bound for $A$. Accuracy is still obtained by applying the source agnostic guarantee to the actual marginal $P$, not by transferring accuracy from $P^\star$.

**Conclusion.** The same source learner $A$, run with fixed $\varepsilon=1/4$, is a distribution-free efficient weak realizable improper learner. Hence the implication is true.

Equivalently, the edge factors as

$$
\text{efficient marginal-nonuniform agnostic improper}
\Rightarrow
\text{efficient marginal-nonuniform weak realizable improper}
\Rightarrow
\text{efficient weak realizable improper},
$$

where the first implication is monotone relaxation and the second is full-support marginal uniformization for the weak-realizable setting.

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
summary: "True under the atlas worst-case efficiency convention: agnostic learning gives constant weak realizable advantage, and a full-support reference marginal gives one transcript-wise polynomial resource bound."
family: full-support-marginal-uniformization
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

Replacement body sketch:

```markdown
# Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Improper PAC Learning

## Verdict

`true`, by agnostic-to-weak-realizable relaxation plus full-support marginal uniformization.

## Proof

Let $A$ be the single learner promised by the marginal-nonuniform agnostic source. On a realizable distribution with marginal $P$, the agnostic benchmark error is zero. Run $A$ with a fixed constant accuracy parameter, say $\varepsilon=1/4$. The source guarantee for the actual marginal $P$ gives, with probability at least $1-\delta$,

$$
\operatorname{err}_D(h,c)\le 1/4,
$$

which is weak realizable learning with constant advantage $\gamma=1/4$.

It remains only to make the resource bound distribution-free. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time for this marginal. Since $P^\star$ has full support, every finite labeled transcript that can occur under any marginal has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ therefore cannot exceed $p_{P^\star}$ on any such transcript.

Thus $p_{P^\star}$ is one distribution-free polynomial sample/time bound for the same learner $A$, while the source agnostic guarantee gives the target weak realizable accuracy guarantee. Hence the implication is true.
```

## Obstacles

No remaining obstacle under the atlas convention used by `full-support-marginal-uniformization`.

The caveat is definitional: if a future schema interpreted efficient PAC runtime/sample use only in expectation or with high probability under each marginal, then a bound under $P^\star$ would not automatically control all transcripts. The current atlas argument explicitly uses worst-case/pathwise resource bounds on finite encoded transcripts, so this caveat does not block this edge.

## Next Directions

- Update the assigned edge note from `marginal-uniformization-open` to `full-support-marginal-uniformization`.
- Add `bendavid1995parameterization` to the edge's `ref_keys`, matching the full-support argument note.
- Consider resolving the sibling edge `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac`, which is the same resource-uniformization step without the agnostic-to-realizable and strong-to-weak relaxation.

## References Checked

- [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]
- [[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[marginal-uniformization-open|Marginal Uniformization Open]]
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac/scratchpad.md`
- Benedek and Itai 1991 (`benedek1991fixed`)
- Ben-David, Benedek, and Mansour 1995 (`bendavid1995parameterization`)
- Hanneke, Moran, and Thiessen 2025 (`hanneke2025marginalnonuniform`)
