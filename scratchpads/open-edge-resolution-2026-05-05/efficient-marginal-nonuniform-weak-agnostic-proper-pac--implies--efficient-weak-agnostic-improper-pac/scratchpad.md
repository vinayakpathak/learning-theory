# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-weak-agnostic-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- worker constraint: only this scratchpad was created/edited; no atlas files were edited
- verdict: resolved-false-conditional
- confidence: 0.86

## Current Atlas State

The edge is currently marked:

```yaml
status: "open"
evidence: unknown
family: marginal-uniformization-open
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
```

That is not the sharp verdict for this assigned edge. The target is not a
realizable or sample-only target; it is the fixed-gap distribution-free weak
agnostic improper target. Boolean halfspaces appear to separate it under
Tiegel's worst-case lattice hardness assumption.

## Definitions Used

The source gives one proper learner $A$ such that, for every instance marginal
$P$, there are a marginal-dependent polynomial and weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

with $1/\gamma_P(s)$ bounded by a $P$-dependent polynomial, and for every joint
distribution $\mathcal D$ with marginal $P$,

$$
\operatorname{err}_{\mathcal D}(A)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s).
$$

The target asks for one distribution-free efficient improper learner and one
fixed weak tolerance $\beta<1/2$:

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta
$$

for every joint distribution $\mathcal D$, with sample and running time bounded
by a polynomial independent of the marginal.

The key difference is not just the runtime polynomial. Under the atlas
full-support transcript convention, one can often uniformize the resource
bound for a single marginal-nonuniform learner. But the source still permits
the weak gap $\gamma_P(s)$ to shrink with the marginal and with the
representation size. The target requires a fixed distribution-free gap
$1/2-\beta$.

## Sources Checked

Local atlas files:

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/halfspaces.md`
- neighboring scratchpads for the source-to-realizable-improper edge and the weak-agnostic-improper-to-weak-agnostic-improper edge
- `references.bib`

Primary-source page checked online:

- Tiegel 2023, Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems: https://proceedings.mlr.press/v195/tiegel23a.html

## Counterexample

### Witness

Let $\mathcal C$ be Boolean halfspaces.

### Why The Source Holds

Halfspaces are efficiently realizably properly PAC learnable: on a realizable
sample, find a consistent separating halfspace by linear feasibility, and use
the VC dimension of halfspaces for generalization.

For the assigned source, we need only a marginal-nonuniform weak agnostic
proper learner with an inverse-polynomial weak gap. The atlas
low-noise weak agnostic robustification gives this from the realizable proper
learner, and it remains proper for halfspaces because the two constant
classifiers are themselves halfspaces.

Concretely, run the realizable proper halfspace learner on fresh small batches
while pretending the labels are realizable, validate the candidates, and also
validate the two constant halfspaces. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is not tiny, a constant
classifier is already within

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha(s)
$$

for an inverse-polynomial $\alpha(s)$. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is tiny, then with
inverse-polynomial probability a fresh batch is clean relative to a best
halfspace, and the realizable learner returns a proper halfspace with a
nontrivial advantage that survives validation.

This is stronger than needed in one respect: the resulting gap can be chosen
distribution-free inverse-polynomial for halfspaces. It is still not a fixed
constant gap, so it does not contradict Tiegel's weak agnostic hardness below.

### Why The Target Fails

Tiegel proves, under worst-case lattice hardness, agnostic hardness for
improperly learning halfspaces. The PMLR abstract states that no efficient
algorithm outputs any binary hypothesis with misclassification error better
than $1/2-\gamma$ even when the optimal halfspace error is as small as
$\delta$, with $\gamma$ allowed to be smaller than the inverse of any
polynomial in the dimension and $\delta$ negligible in the stated
quasipolynomial scale.

Suppose, toward contradiction, that halfspaces satisfied the target. Then there
would be a polynomial-time distribution-free learner and a fixed
$\beta<1/2$. Write

$$
a=1/2-\beta>0.
$$

Choose Tiegel hard parameters with $\delta+\gamma<a$. On that hard agnostic
distribution, the target learner would output some binary hypothesis, not
necessarily a halfspace, satisfying

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+\beta
\le
\delta+\beta
<
1/2-\gamma.
$$

That contradicts the lower bound. Because the target already permits improper
outputs, properness cannot rescue it.

Thus Boolean halfspaces satisfy
`efficient-marginal-nonuniform-weak-agnostic-proper-pac` but fail
`efficient-weak-agnostic-improper-pac`, conditionally on Tiegel's worst-case
lattice assumption.

## Marginal-Nonuniform And Weak-Gap Bookkeeping

The generic marginal-nonuniform-to-distribution-free issue is real for nearby
weak edges, but it is not needed to leave this edge open. The halfspace witness
exploits the fixed-gap part of the target.

Full-support marginal uniformization can make the resource usage of a single
source learner distribution-free under the atlas pathwise runtime convention.
It does not turn an inverse-polynomial source gap
$\gamma_P(s)$ into one fixed gap. For halfspaces, that is exactly the
separation: the source has a weak agnostic proper learner with an
inverse-polynomial gap, while Tiegel rules out any efficient distribution-free
learner with a fixed positive advantage over $1/2$ when the halfspace optimum
is tiny.

So the proposed status should be a conditional counterexample, not an open
weak-gap-uniformization entry.

## Other Witnesses Checked

### PCP Active-Slice Lookup Class

This is not the clean witness for the assigned edge.

The PCP active-slice class is useful for separating weak improper learning from
weak proper learning: a weak proper learner on the active slice would decide
the underlying NP language using perfect completeness and soundness below
$1/2$. But the assigned source is proper, so the class is source-negative under
the usual complexity assumption. It also tends to be target-positive
improperly because one-slice lookup or memorization learners can exploit the
polynomial active slice.

### One-Way Image-Coordinate Weak-Handle Class

This witness is also not needed here.

The weak-handle construction can make proper weak learning easy while proper
strong recovery remains hard under length-preserving one-way functions. But
the target here is improper weak agnostic learning. The known one-way argument
mainly forces hard proper recovery of the seed/image; an improper learner can
often use handles or memorization to avoid that recovery. It does not give a
clean failure of the assigned weak improper target.

### Pure Marginal Diagonalization

A pure diagonal witness would try to make every fixed marginal weakly learnable
with some inverse-polynomial advantage, while every distribution-free fixed
gap fails. This is the right shape for nearby open weak-gap-uniformization
edges, but it is unnecessary here because halfspaces already give a standard
conditional counterexample.

## Proposed Atlas Update

Suggested frontmatter:

```yaml
status: "false"
evidence: conditional-counterexample
result_origin: "known"
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
ref_keys:
  - valiant1984
  - blumer1989
  - tiegel2023
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "False under worst-case lattice hardness: halfspaces satisfy the marginal-nonuniform weak agnostic proper source via low-noise robustification, but Tiegel rules out distribution-free weak agnostic improper learning."
family: halfspace-agnostic-hardness
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
```

Suggested body:

```markdown
## Verdict

`false`, under worst-case lattice hardness.

Use Boolean halfspaces. They are efficiently realizably properly PAC learnable
by linear feasibility and VC generalization. Since the constant classifiers are
also halfspaces, the low-noise weak agnostic robustification gives a proper
weak agnostic learner with an inverse-polynomial gap; this is enough for the
marginal-nonuniform weak agnostic proper source.

The distribution-free weak agnostic improper target would require a fixed
additive tolerance `beta < 1/2`. Let `a = 1/2 - beta`. Tiegel's lattice-based
halfspace hardness rules out any efficient algorithm outputting an arbitrary
binary hypothesis with error below `1/2 - gamma` even when the best halfspace
has error at most `delta`, for parameters with `delta` negligible and `gamma`
smaller than inverse-polynomial. Choose the hard parameters so
`delta + gamma < a`. A target learner would have error at most
`delta + beta < 1/2 - gamma`, contradicting Tiegel.

Thus halfspaces satisfy the source but fail the target.
```

## Final

verdict: resolved-false-conditional

confidence: 0.86
