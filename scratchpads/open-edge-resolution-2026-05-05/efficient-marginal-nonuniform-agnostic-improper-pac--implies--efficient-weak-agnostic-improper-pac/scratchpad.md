# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md
- verdict: resolved-true
- confidence: high

## Context

The edge note is currently `open` because it was grouped with marginal-uniformization questions: the source permits a polynomial sample/time bound $p_P$ depending on the instance marginal $P$, while the target asks for one distribution-free polynomial bound.

Two existing atlas facts resolve the two requirements of the target:

- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md` is already `true` by monotone relaxation: strong agnostic learning implies weak agnostic learning by fixing a constant excess tolerance.
- `atlas/arguments/full-support-marginal-uniformization.md` records a true resource-uniformization argument under the atlas convention that efficient PAC sample use and running time are worst-case/pathwise bounds on finite encoded sample transcripts.

Thus the assigned edge is true by direct application of full-support marginal uniformization, with weak accuracy obtained from the source's strong agnostic guarantee.

## Attempted Resolution

**Goal.** Starting from an efficient marginal-nonuniform agnostic improper learner $A$, show that the same class has an efficient distribution-free weak agnostic improper learner.

**Accuracy.** Fix the target weak tolerance, for example $\beta=1/4$; any constant $\beta<1/2$ would work. On an arbitrary joint distribution $\mathcal D$ with marginal $P$, run $A$ with $\varepsilon=\beta$. The source guarantee for the actual marginal $P$ gives, with probability at least $1-\delta$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta .
$$

The output is improper, exactly as allowed by the target. So the only remaining issue is whether the marginal-dependent resource polynomial can be replaced by a single distribution-free polynomial.

**Uniform resource bound.** Apply `full-support-marginal-uniformization`. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Since $A$ is a single marginal-nonuniform learner, the source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time for every joint distribution with marginal $P^\star$.

Under the atlas worst-case/pathwise efficiency convention, this resource bound must hold on every finite labeled transcript that can occur with positive probability under some joint distribution with marginal $P^\star$. Full support makes this set of transcripts universal: every finite labeled transcript that can occur under any marginal also occurs with positive probability under $P^\star$ for a suitable conditional label rule. If $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate the source resource guarantee for $P^\star$.

Therefore $p_{P^\star}$ is one distribution-free polynomial sample/time bound for $A$. Accuracy still comes from applying the source guarantee to the actual marginal $P$, not from the reference marginal.

**Conclusion.** Run the source learner $A$ unchanged with a fixed constant $\varepsilon=\beta<1/2$. Full-support marginal uniformization supplies the distribution-free polynomial resource bound, and the source agnostic guarantee supplies the weak agnostic error bound. Hence the implication is true.

Equivalently, this edge factors as

$$
\text{efficient marginal-nonuniform agnostic improper}
\Rightarrow
\text{efficient marginal-nonuniform weak agnostic improper}
\Rightarrow
\text{efficient weak agnostic improper},
$$

where the first implication is monotone relaxation and the second is the same full-support resource-uniformization argument.

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
  - bendavid2001
  - kalai2008agnosticboosting
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
summary: "True under the atlas worst-case efficiency convention: a fixed strong-agnostic accuracy parameter gives weak agnostic accuracy, and a full-support reference marginal gives one transcript-wise polynomial resource bound."
family: full-support-marginal-uniformization
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

Replacement body sketch:

```markdown
# Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Improper PAC Learning

## Verdict

`true`, by strong-to-weak relaxation plus full-support marginal uniformization.

## Proof

Let $A$ be the single learner promised by the marginal-nonuniform agnostic source. Fix any weak tolerance $\beta<1/2$, say $\beta=1/4$, and run $A$ with $\varepsilon=\beta$. For the actual marginal $P=\mathcal D_X$, the source accuracy guarantee gives

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta
$$

with probability at least $1-\delta$.

It remains only to make the resource bound distribution-free. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time for this marginal. Since $P^\star$ has full support, every finite labeled transcript that can occur under any marginal has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ therefore cannot exceed $p_{P^\star}$ on any such transcript.

Thus $p_{P^\star}$ is one distribution-free polynomial sample/time bound for the same learner $A$, while the source agnostic guarantee gives the target weak agnostic accuracy guarantee. Hence the implication is true.
```

## Obstacles

No remaining obstacle under the atlas convention used by `full-support-marginal-uniformization`.

The caveat is model-theoretic rather than mathematical: if efficient PAC runtime were interpreted as an average-case or high-probability runtime bound under each marginal, the full-support transcript argument would not automatically transfer a bound from $P^\star$ to all transcripts. The atlas argument explicitly adopts the worst-case/pathwise convention, so this caveat does not block the current edge.

## Next Directions

- Update the assigned edge note from `marginal-uniformization-open` to `full-support-marginal-uniformization`.
- Add `bendavid1995parameterization` to this edge's `ref_keys`, matching the full-support argument note.
- Consider also resolving `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac`, which is the same resource-uniformization step without the strong-to-weak relaxation.

## References Checked

- [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]
- [[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[marginal-uniformization-open|Marginal Uniformization Open]]
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
- Benedek and Itai 1991 (`benedek1991fixed`)
- Ben-David, Benedek, and Mansour 1995 (`bendavid1995parameterization`)
- Hanneke, Moran, and Thiessen 2025 (`hanneke2025marginalnonuniform`)
- Ben-David et al. 2001 (`bendavid2001`)
- Kalai et al. 2008 (`kalai2008agnosticboosting`)
