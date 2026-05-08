# Edge Resolution Scratchpad

Edge:
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-improper-pac`

Depth: 1

## Files Read

- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/monotone-relaxation.md`
- nearby implication notes:
  - `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-realizable-proper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`

## Current Atlas State

The edge file currently records:

- `status: "open"`
- `evidence: unknown`
- `family: marginal-uniformization-open`
- `argument_note: [[marginal-uniformization-open|Marginal Uniformization Open]]`
- summary: the source has marginal-dependent polynomial resource bounds, while the target asks for one distribution-free polynomial bound.

The nearby edge
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-realizable-proper-pac`
is already marked `true` by `full-support-marginal-uniformization`. The only additional relaxation needed for the requested edge is proper-to-improper output, which is monotone/trivial.

## Resolution

This edge should be resolved as true under the atlas worst-case/pathwise efficiency convention.

The key convention is in `atlas/README.md`: computationally efficient nodes require polynomial sample complexity and polynomial running time as worst-case/pathwise bounds on finite encoded sample transcripts, not merely expected or high-probability running times under the marginal. Under that convention, the full-support reference marginal argument applies directly.

## Proof

**Goal.** Show that a single efficient marginal-nonuniform realizable proper learner is already an efficient distribution-free realizable improper learner.

Let $A$ be the single learner promised by
[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]. Thus, for every marginal $P$, there is a polynomial

$$
p_P(s,1/\varepsilon,\log(1/\delta))
$$

such that for every target concept $c\in\mathcal C$, the learner $A$ outputs $h\in\mathcal C$ with $\operatorname{err}_P(h,c)\le \varepsilon$ with probability at least $1-\delta$, and its sample use and running time obey the $P$-dependent polynomial bound.

**Uniform resource bound.** Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the marginal-nonuniform source guarantee to this one marginal gives a polynomial $p_{P^\star}$.

Under the atlas worst-case/pathwise convention, this $p_{P^\star}$ bounds $A$ on every finite labeled transcript that can occur with positive probability under $P^\star$. Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal $P$ and any realizable target concept $c\in\mathcal C$ also has positive probability under $P^\star$ for the same target concept, restricted to the finitely many sample points appearing in the transcript. Hence an overrun on any transcript possible under any marginal would also be an overrun on a positive-probability transcript under $P^\star$, contradicting the source guarantee for $P^\star$.

Therefore the single polynomial $p_{P^\star}$ is a distribution-free worst-case bound on the sample use and running time of $A$.

**Accuracy.** Accuracy is not transferred from $P^\star$. Fix the actual marginal $P$ and target concept $c\in\mathcal C$. The source guarantee applied directly to this actual $P$ gives

$$
\operatorname{err}_P(A,c)\le \varepsilon
$$

with probability at least $1-\delta$.

**Improper target.** The source learner outputs $h\in\mathcal C$. The target node permits improper hypotheses, so every proper output is also a valid improper output.

Combining the distribution-free resource polynomial $p_{P^\star}$, the source accuracy guarantee for the actual marginal $P$, and the monotone proper-to-improper relaxation proves
[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]].

## Why The Old Open Obstacle No Longer Applies

The old obstacle was correct for resource bounds interpreted only distributionally, for example in expectation or with high probability under each marginal. In that setting a full-support mixture does not necessarily control all rare transcripts uniformly.

Here the atlas explicitly uses worst-case/pathwise finite-transcript resource bounds. That turns a full-support reference marginal into a transcript-wise certificate: every finite transcript possible anywhere is possible under $P^\star$, so the $P^\star$ polynomial cannot be exceeded anywhere.

## Proposed Atlas Metadata

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
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, source realizable proper accuracy already holds for every marginal, and proper output is valid for the improper target."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: proper-to-improper
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

## Proposed Atlas Body

```markdown
# Efficient Marginal-Nonuniform Realizable Proper PAC Learning $\Rightarrow$ Efficient Realizable Improper PAC Learning

## Verdict

`true`, by full-support marginal uniformization plus monotone relaxation from proper to improper output.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under this marginal.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal and realizable target concept has positive probability under $P^\star$ for the same target concept on the finitely many sampled instances. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Therefore $p_{P^\star}$ is one distribution-free resource bound for $A$.

Accuracy is not transferred from $P^\star$. For any actual marginal $P$ and target concept $c\in\mathcal C$, apply the source guarantee directly to $P$. The source already gives strong realizable accuracy and outputs $h\in\mathcal C$. Since the improper target allows outputs at least as broad as $\mathcal C$, the same learner $A$ is an efficient distribution-free realizable improper learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
```

verdict: resolved-true
confidence: 0.90
