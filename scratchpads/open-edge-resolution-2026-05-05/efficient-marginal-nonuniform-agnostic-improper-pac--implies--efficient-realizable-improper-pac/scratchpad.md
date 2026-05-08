# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-realizable-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-realizable-improper-pac.md
- verdict: resolved-true
- confidence: high

## Context

The edge note is currently `open` because it was grouped with marginal-uniformization questions: the source permits a polynomial resource bound $p_P$ depending on the instance marginal $P$, whereas the target requires a single distribution-free polynomial resource bound.

The neighboring atlas material now resolves the exact resource issue for this setting:

- `atlas/arguments/full-support-marginal-uniformization.md` records a true argument under the atlas convention that efficient PAC sample use and running time are worst-case/pathwise bounds on finite encoded sample transcripts.
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md` is already marked `true` by that full-support marginal uniformization argument.
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md` is already marked `true` by monotone relaxation from agnostic to realizable.

Thus the assigned edge is true by composition, and it also admits a direct proof using the same full-support resource argument.

## Attempted Resolution

**Goal.** Starting with an efficient marginal-nonuniform agnostic improper learner $A$, build an efficient distribution-free realizable improper PAC learner for the same class.

**Accuracy.** Use $A$ unchanged. On any realizable distribution, the agnostic benchmark $\inf_{c\in\mathcal C}\operatorname{err}(c)$ is $0$. Therefore the source guarantee for the actual marginal $P$ gives

$$
\operatorname{err}(h)\le \varepsilon
$$

with probability at least $1-\delta$. This already gives the target realizable accuracy requirement, except for the need to replace the marginal-dependent resource polynomial by a single distribution-free one.

**Uniform resource bound.** Apply the full-support marginal uniformization argument. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Since the source is marginal-nonuniform, there is a polynomial $p_{P^\star}$ bounding the sample use and running time of the single learner $A$ under all joint distributions with marginal $P^\star$.

Under the atlas worst-case/pathwise efficiency convention, this bound must hold on every finite labeled transcript that can occur with positive probability under $P^\star$. Full support means every finite transcript that can occur under any target marginal also has positive probability under $P^\star$ for a suitable conditional label rule. If $A$ exceeded $p_{P^\star}$ on such a transcript, it would violate the source resource guarantee for $P^\star$. Hence $p_{P^\star}$ is a single transcript-wise polynomial resource bound for $A$ over all marginals.

**Conclusion.** The same learner $A$ has distribution-free polynomial sample complexity and runtime, and its agnostic guarantee gives realizable error at most $\varepsilon$. Therefore the implication is true.

This is also the composition

$$
\text{efficient marginal-nonuniform agnostic improper}
\Rightarrow
\text{efficient marginal-nonuniform realizable improper}
\Rightarrow
\text{efficient realizable improper}.
$$

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
summary: "True under the atlas worst-case efficiency convention: agnostic learning gives realizable accuracy, and a full-support reference marginal gives one transcript-wise polynomial resource bound."
family: full-support-marginal-uniformization
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

Replacement body sketch:

```markdown
# Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`true`, by agnostic-to-realizable relaxation plus full-support marginal uniformization.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform agnostic source. On a realizable distribution, the agnostic benchmark error is zero, so the source accuracy guarantee for the actual marginal $P$ gives error at most $\varepsilon$ with probability at least $1-\delta$.

It remains only to make the resource bound distribution-free. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time for this marginal. Since $P^\star$ has full support, every finite labeled transcript that can occur under any marginal has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ therefore cannot exceed $p_{P^\star}$ on any such transcript.

Thus $p_{P^\star}$ is one distribution-free polynomial sample/time bound for the same learner $A$, while the source agnostic guarantee gives the target realizable accuracy guarantee. Hence the implication is true.
```

## Obstacles

No remaining obstacle under the atlas convention used by `full-support-marginal-uniformization`. Without that pathwise/worst-case resource convention, one would need to restate the runtime model more carefully, because an average or high-probability resource guarantee under $P^\star$ would not automatically bound every transcript. The existing atlas argument explicitly adopts the pathwise convention.

## Next Directions

- Update the assigned edge note from `marginal-uniformization-open` to `full-support-marginal-uniformization`.
- Add `bendavid1995parameterization` to this edge's `ref_keys`, matching the full-support argument note.
- Audit remaining `marginal-uniformization-open` computational edges; any with a single uniform learner and only a marginal-dependent worst-case polynomial may now resolve by the same full-support argument if the remaining target requirements are monotone relaxations of the source.

## References Checked

- [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]
- [[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[marginal-uniformization-open|Marginal Uniformization Open]]
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- Benedek and Itai 1991 (`benedek1991fixed`)
- Ben-David, Benedek, and Mansour 1995 (`bendavid1995parameterization`)
- Hanneke, Moran, and Thiessen 2025 (`hanneke2025marginalnonuniform`)
