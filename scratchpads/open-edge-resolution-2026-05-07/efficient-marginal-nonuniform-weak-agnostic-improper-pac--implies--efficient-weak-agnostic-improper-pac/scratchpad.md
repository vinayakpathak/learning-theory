# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac

- date: 2026-05-07
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-weak-agnostic-improper-pac`
- verdict: resolved-false under the atlas convention that complexity-conditional separations are recorded as false with assumptions
- assumption: worst-case lattice hardness, as in the existing halfspace witness notes

## Files Read

Required local context:

- `atlas/README.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/arguments/marginal-uniformization-open.md`
- prior exact scratchpad: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac/scratchpad.md`

No exact 2026-05-04 scratchpad exists at the corresponding path.

Additional local context used to resolve the edge:

- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/unrestricted-labelings.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/arguments/sample-complexity-equivalence.md`

Primary source checked online:

- Tiegel 2023, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", PMLR: https://proceedings.mlr.press/v195/tiegel23a.html

## Current Edge State

The assigned edge is currently open. Its summary says that full-support marginal uniformization gives a pathwise sample/time polynomial for the source learner, but does not turn marginal-specific weak gaps into one distribution-free inverse-polynomial gap.

That generic weak-gap obstruction is real for some nearby marginal-uniformization edges. It is not the sharp verdict for this exact edge, because the target is the fixed-additive distribution-free weak agnostic improper node. The existing halfspace hardness witness refutes that target, while low-noise weak agnostic robustification establishes the source for halfspaces.

## Definitions Used

The source allows one learner such that for every marginal $P$ there are a $P$-dependent resource polynomial and weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial. For every joint distribution $\mathcal D$ with marginal $P$, the learner must output an improper hypothesis $h$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

The target asks for one distribution-free efficient learner and one fixed additive tolerance $\beta<1/2$, independent of the marginal and of the representation size:

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta.
$$

Equivalently, the target requires a fixed positive gap $a=1/2-\beta$ from random guessing in the low-noise regime.

## Counterexample

### Witness Class

Let $\mathcal C$ be Boolean affine halfspaces.

### Why The Source Holds

Halfspaces satisfy `efficient-realizable-proper-pac`: on a realizable sample, a consistent halfspace can be found by linear feasibility, and VC generalization gives the distribution-free PAC guarantee.

The atlas already records the implication

$$
\text{efficient-realizable-proper-pac}
\Rightarrow
\text{efficient-marginal-nonuniform-weak-agnostic-improper-pac}
$$

via `low-noise-weak-agnostic-robustification`.

Specialized to halfspaces, the construction is:

1. Run the realizable halfspace learner on small fresh batches while pretending labels are realizable.
2. Validate the resulting hypotheses together with the two constant classifiers.
3. If $\operatorname{OPT}_{\mathcal C}$ is at least the chosen inverse-polynomial threshold $\alpha(s)$, a constant classifier is already within $\operatorname{OPT}_{\mathcal C}+1/2-\alpha(s)$.
4. If $\operatorname{OPT}_{\mathcal C}$ is below that threshold, a small batch is clean relative to a near-best halfspace with inverse-polynomial probability, and the realizable learner returns a candidate whose advantage survives validation.

This yields a weak agnostic learner with an inverse-polynomial gap. The source is improper, so even if the robustification is viewed as producing proper halfspaces, the same outputs are allowed. Thus halfspaces satisfy the assigned source.

### Why The Target Fails

Tiegel proves, under worst-case lattice hardness, distribution-independent agnostic hardness for halfspaces even when the learner may output an arbitrary binary hypothesis. In the PMLR abstract's formulation, no efficient algorithm achieves error better than $1/2-\gamma$ even when the best halfspace error is as small as $\delta$, with $\gamma$ allowed to be smaller than inverse-polynomial and $\delta$ negligible.

Assume for contradiction that halfspaces satisfied the target. Then there would be a polynomial-time distribution-free weak agnostic improper learner with fixed tolerance $\beta<1/2$. Let

$$
a=1/2-\beta>0.
$$

Choose Tiegel hard parameters with $\delta+\gamma<a$. On the hard distribution, the target learner would output an arbitrary binary hypothesis $h$ with

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+\beta
\le
\delta+\beta
<
1/2-\gamma,
$$

contradicting Tiegel's lower bound. The contradiction applies directly to the target because the target already permits improper output.

Therefore Boolean halfspaces satisfy the source but fail the target, conditionally on the same worst-case lattice hardness assumption already used by the atlas.

## Relation To The Prior Exact Scratchpad

The 2026-05-05 exact scratchpad correctly identified that full-support marginal uniformization handles pathwise sample/time bounds but not marginal-dependent weak gaps. Its unresolved conclusion missed the halfspace route:

- Halfspaces do not need a new weak-gap uniformization theorem.
- The source is obtained indirectly from efficient realizable proper learning by low-noise robustification.
- The target is ruled out because it asks for a fixed additive weak agnostic tolerance, which Tiegel's halfspace hardness contradicts.

So the generic obstruction remains useful background, but the edge is no longer merely open under current atlas semantics.

## Proposed Atlas Update

Do not edit atlas files in this worker pass, but the edge should be changed along these lines:

```yaml
status: "false"
evidence: conditional-counterexample
result_origin: "known"
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
witness_note: "[[halfspaces|Halfspaces]]"
ref_keys:
  - valiant1984
  - blumer1989
  - tiegel2023
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "False under worst-case lattice hardness: halfspaces satisfy the marginal-nonuniform weak agnostic improper source via low-noise robustification from efficient realizable proper learning, but Tiegel rules out distribution-free weak agnostic improper learning."
family: halfspace-agnostic-hardness
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
```

Suggested body:

```markdown
## Verdict

`false`, under worst-case lattice hardness.

Use Boolean halfspaces. They are efficiently realizably properly PAC learnable by linear feasibility and VC generalization. By low-noise weak agnostic robustification, this gives efficient marginal-nonuniform weak agnostic improper PAC learning with an inverse-polynomial weak gap.

The distribution-free weak agnostic improper target would require a fixed additive tolerance $\beta<1/2$. Let $a=1/2-\beta$. Tiegel's lattice-based halfspace hardness rules out any efficient algorithm outputting an arbitrary binary hypothesis with error below $1/2-\gamma$ even when the best halfspace has error at most $\delta$. Choose the hard parameters so $\delta+\gamma<a$. A target learner would have error at most $\delta+\beta<1/2-\gamma$, contradicting Tiegel.
```

## VERDICT

VERDICT: resolved-false, scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac/scratchpad.md`
