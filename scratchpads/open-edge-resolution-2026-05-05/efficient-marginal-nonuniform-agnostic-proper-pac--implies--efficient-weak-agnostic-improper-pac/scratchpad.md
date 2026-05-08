# Edge: efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-weak-agnostic-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md
- verdict: resolved-true
- confidence: high

## Context

The assigned edge asks whether [[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]] implies [[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]].

The source gives a single proper agnostic learner $A$ for all joint distributions, with sample and runtime polynomial allowed to depend on the instance marginal $P$. The target asks for a distribution-free efficient improper weak agnostic learner: for a fixed $\beta < 1/2$, output some hypothesis, possibly outside $\mathcal C$, with error at most $\operatorname{opt}_{\mathcal C}+\beta$.

The current edge note marks this open because it views marginal-nonuniform-to-distribution-free uniformization as the obstacle. However, the atlas now contains [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]], and the edge
`efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac`
is already marked `true` using that argument. The edge
`efficient-agnostic-proper-pac -> efficient-weak-agnostic-improper-pac`
is also marked `true` as a monotone relaxation.

## Attempted Resolution

**Goal.** Produce a distribution-free efficient weak agnostic improper learner from the marginal-nonuniform strong agnostic proper learner.

**Step 1: uniformize the resource bound.** Let $A$ be the single learner promised by the source. By the full-support marginal uniformization argument, choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source supplies a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under that marginal.

Under the atlas worst-case/pathwise resource convention, every finite labeled transcript that can occur under any marginal also has positive probability under $P^\star$ for an appropriate conditional label rule. Therefore $A$ cannot exceed $p_{P^\star}$ on any such transcript. This makes $p_{P^\star}$ a single distribution-free sample/time polynomial for $A$.

**Step 2: keep the agnostic accuracy.** Accuracy does not need to be transferred from $P^\star$. For the actual distribution $\mathcal D$ with marginal $P$, the source guarantee applied to $P$ directly gives, with high probability,
$$
\operatorname{err}_{\mathcal D}(A(S))
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$
Thus the same learner is an efficient distribution-free agnostic proper learner, exactly as recorded in the sibling edge to `efficient-agnostic-proper-pac`.

**Step 3: weaken strong proper agnostic to weak improper agnostic.** Run this learner with any fixed $\varepsilon \le \beta$, for the target's fixed weak tolerance $\beta<1/2$. Its proper output is also allowed in the improper target, and the strong agnostic bound implies
$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta.
$$
The sample complexity and runtime remain polynomial because $\beta$ is fixed, or polynomial in $1/(1/2-\beta)$ under the parameterized target convention.

So the assigned edge is true by composing full-support marginal uniformization with monotone relaxation.

## Proposed Atlas Update

```yaml
status: "true"
evidence: theorem
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
summary: "True under the atlas worst-case efficiency convention: full-support marginal uniformization gives a distribution-free strong agnostic proper learner, and strong proper agnostic learning trivially implies weak improper agnostic learning."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: proper-to-improper
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
```

Suggested replacement body:

```markdown
## Verdict

`true`, by full-support marginal uniformization followed by monotone relaxation.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform agnostic proper source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under $P^\star$.

Because $P^\star$ has full support, every finite labeled transcript possible under any marginal has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Hence $p_{P^\star}$ is one distribution-free resource polynomial for $A$.

For accuracy, fix the actual joint distribution $\mathcal D$ with marginal $P$. The source guarantee applied to $P$ directly gives proper agnostic excess error at most $\varepsilon$ under $\mathcal D$. Run $A$ with any fixed $\varepsilon \le \beta$, where $\beta<1/2$ is the weak agnostic tolerance. The output is proper, hence allowed by the improper target, and it satisfies
$$
\operatorname{err}_{\mathcal D}(h)\le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta .
$$

Therefore the same learner witnesses efficient distribution-free weak agnostic improper PAC learning.
```

## Obstacles

No remaining obstacle under the atlas's current worst-case/pathwise efficiency convention. The only caveat is the same one recorded in [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]: if marginal-nonuniform efficiency were instead interpreted as expected or high-probability runtime under the marginal, the transcript-wise uniformization step would need to be revisited.

## Next Directions

1. Update the assigned edge note from `open` to `true` using the proposed full-support-marginal-uniformization proof.
2. Optionally audit sibling edges still assigned to `marginal-uniformization-open`; any edge whose source already implies its distribution-free strong counterpart may now be a direct corollary.
3. If the atlas wants to support non-worst-case runtime conventions, split the definition notes or argument notes so the full-support proof's convention is explicit wherever it is used.

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
