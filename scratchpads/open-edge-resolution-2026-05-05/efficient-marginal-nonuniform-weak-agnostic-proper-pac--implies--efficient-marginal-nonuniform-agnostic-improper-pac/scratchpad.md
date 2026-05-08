# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac

Date: 2026-05-05

Worker constraint: wrote only this scratchpad; no atlas files edited.

## Verdict

verdict: resolved-false

confidence: 0.86

Conditional on the worst-case lattice hardness assumption used in the atlas halfspace notes, weak proper marginal-nonuniform agnostic learning does not imply strong improper marginal-nonuniform agnostic learning.

The counterexample is Boolean halfspaces. The important extra point for this edge is that halfspaces satisfy the *proper* weak marginal-nonuniform agnostic source by a low-noise robustification of their efficient realizable proper learner. Tiegel's standard-Gaussian distribution-specific hardness then rules out the strong marginal-nonuniform agnostic improper target.

## Files And Sources Read

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/witnesses/halfspaces.md`
- Nearby halfspace implication notes into `efficient-marginal-nonuniform-agnostic-improper-pac`
- Nearby scratchpad `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md`
- `references.bib`
- Primary source checked online: Tiegel 2023 PMLR page, `https://proceedings.mlr.press/v195/tiegel23a.html`

## Existing Edge State

The current edge is marked:

```yaml
status: "open"
evidence: unknown
family: agnostic-boosting-open
summary: "Open: boosting from a marginal-nonuniform weak learner does not automatically give one marginal-dependent polynomial bound for the strong target."
```

That boosting obstacle is real for a black-box positive theorem, but it is not the right final status for this edge. A known hard class satisfies the source and fails the target.

## Definitions In This Edge

The source asks for one uniform learner such that, for every instance marginal $P$, there are a marginal-dependent polynomial $p_P$ and a weak tolerance
$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$
where $1/\gamma_P(s)$ is bounded by a marginal-dependent polynomial. For every joint distribution $\mathcal D$ with marginal $P$, the learner outputs $h\in\mathcal C$ with
$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

The target asks for arbitrary excess accuracy with possibly improper output:
$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$
in time polynomial in $s,1/\varepsilon,\log(1/\delta)$, with the polynomial allowed to depend on the original marginal $P$.

## Counterexample

**Goal.** Refute the implication by finding a class satisfying the weak proper marginal-nonuniform agnostic source but not the strong improper marginal-nonuniform agnostic target.

**Witness class.** Let $\mathcal C$ be Boolean halfspaces. Constants are representable as halfspaces, and the usual realizable learner is proper.

### Source Holds

Halfspaces are efficiently realizably properly PAC learnable distribution-free: on a realizable sample, linear feasibility finds a separating halfspace, and VC generalization gives a polynomial sample bound.

I spell out the weak agnostic source because the existing atlas edge from realizable proper learning to this exact source is still marked open.

Fix any joint distribution $\mathcal D$ over $(X,Y)$ and let $P=\mathcal D_X$. Let
$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
$$
and choose $c^\star\in\mathcal C$ with error at most $\eta$ up to an arbitrarily small slack. Let $m(s)$ be the sample size needed by the proper realizable halfspace learner to get a constant clean error, say $1/16$, with constant confidence. Set
$$
\alpha(s)\le \frac{1}{100m(s)}
$$
and take the source weak tolerance to be $\beta(s)=1/2-\alpha(s)$.

If $\eta\ge 2\alpha(s)$, then one of the two constant halfspaces has error at most $1/2$, hence
$$
1/2 \le \eta + 1/2-\alpha(s),
$$
so the source guarantee is already met by a proper hypothesis.

If $\eta<2\alpha(s)$, draw many fresh batches of size $m(s)$ and run the realizable halfspace learner on each batch as though the labels were clean. A batch is entirely consistent with $c^\star$ with probability at least
$$
1-m(s)\eta \ge 1-2m(s)\alpha(s),
$$
which is bounded below by a positive constant. Conditioned on this clean-batch event, the batch is realizable by $c^\star$ under a conditional marginal $Q$. Since the halfspace realizable learner is distribution-free and proper, with constant probability it outputs a halfspace $h$ with small error against $c^\star$ under $Q$.

The conditional marginal $Q$ is within $O(\eta)$ total variation of the original marginal $P$, because the conditioning event has probability $1-\eta$ on average. Therefore that same $h$ has error against $c^\star$ under $P$ bounded by a fixed constant, plus $O(\eta)$. Since $\eta<2\alpha(s)$, its labeled error under $\mathcal D$ is at most $\eta$ plus a fixed constant strictly below $1/2-\alpha(s)$, after choosing the clean constant accuracy small enough. Repetition produces such candidates with high probability, and a polynomial-size holdout sample selects a candidate whose true $\mathcal D$-error is within a small constant validation slack of the best candidate.

All candidates are halfspaces: the realizable learner is proper, and the constants are halfspaces. The sample and runtime bounds are distribution-free polynomials, hence also marginal-nonuniform polynomials. Thus halfspaces satisfy `efficient-marginal-nonuniform-weak-agnostic-proper-pac` with an inverse-polynomial gap $\alpha(s)$.

This source proof is the low-noise weak agnostic robustification argument specialized to halfspaces and keeping the output proper.

### Target Fails

Tiegel 2023 proves hardness of improperly learning halfspaces in the agnostic model under worst-case lattice assumptions. The PMLR abstract states both distribution-independent improper hardness and the distribution-specific Gaussian statement. In the distribution-specific setting, for the standard Gaussian marginal, for any constant $\rho>0$, learning halfspaces to error
$$
\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon
$$
takes time at least
$$
d^{\widetilde{\Omega}(1/\varepsilon^{2-\rho})}
$$
under the same lattice hardness assumption.

This lower bound rules out the target. The target requires, for the standard-Gaussian marginal family used in the atlas halfspace notes, a single marginal-dependent polynomial bound in $(d,1/\varepsilon,\log(1/\delta))$. A time lower bound with exponent growing like a power of $1/\varepsilon$ is not such a polynomial.

So halfspaces satisfy the source but fail `efficient-marginal-nonuniform-agnostic-improper-pac` under worst-case lattice hardness.

## Relation To Agnostic Boosting Notes

The local `agnostic-boosting-open` and `marginal-boosting-open` notes correctly explain why a black-box positive theorem is not currently available. Feldman/Ghai-style distribution-specific boosting preserves the feature marginal but needs a tunable correlation-style weak oracle, while the atlas source gives only a fixed additive tolerance. The da Cunha-Hogsgaard-Paudice route is closer to this fixed-additive source, but the known runtime has weak-learner parameters in the exponent.

For this edge, however, those obstacles are superseded by the halfspace counterexample. There is no need to prove that every weak marginal-nonuniform agnostic proper learner boosts. One class already satisfies the weak source by low-noise robustification and is blocked from the strong improper target by Tiegel's Gaussian agnostic hardness.

## Proposed Atlas Update

Proposed frontmatter:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
ref_keys:
  - tiegel2023
  - valiant1984
  - blumer1989
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: "False under worst-case lattice hardness: halfspaces satisfy the weak marginal-nonuniform agnostic proper source via low-noise robustification from efficient realizable proper learning, but Tiegel's standard-Gaussian distribution-specific hardness rules out the strong marginal-nonuniform agnostic improper target."
family: halfspace-agnostic-hardness
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
```

Suggested body:

```markdown
## Verdict

`false`, under worst-case lattice hardness assumptions.

Use Boolean halfspaces. Halfspaces are efficiently realizably properly PAC learnable by linear feasibility plus VC generalization. A low-noise weak agnostic robustification gives the weak marginal-nonuniform agnostic proper source: if the best halfspace error is at least an inverse-polynomial threshold, a constant halfspace is within `OPT + 1/2 - gamma`; if the best halfspace error is below that threshold, repeated runs of the proper realizable learner on fresh batches find a proper halfspace with nontrivial advantage, and validation selects it.

The target fails by Tiegel's standard-Gaussian distribution-specific hardness. Under worst-case lattice hardness, for every constant rho > 0, agnostically learning halfspaces under the standard Gaussian marginal to error `OPT_LTF + epsilon` requires time `d^{~Omega(1/epsilon^{2-rho})}` even for improper binary hypotheses. This is not polynomial in `d` and `1/epsilon`, so it contradicts the marginal-nonuniform strong agnostic improper target for that fixed marginal family.
```

## Caveat

This uses the same marginal-nonuniform reading already used by neighboring atlas halfspace edges: the standard Gaussian hard instances are treated as one fixed Gaussian marginal family across dimensions, not as unrelated dimension-by-dimension marginals with unrelated polynomial exponents. Under a dimension-by-dimension reading the marginal-nonuniform computational notion would become too permissive, and the existing atlas halfspace updates would need the same qualification.

## Final

verdict: resolved-false

confidence: 0.86
