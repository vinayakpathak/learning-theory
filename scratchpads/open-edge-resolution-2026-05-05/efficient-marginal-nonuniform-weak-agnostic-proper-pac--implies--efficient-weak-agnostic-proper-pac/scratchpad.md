# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-weak-agnostic-proper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- verdict: resolved-false
- confidence: high
- assumption: worst-case lattice hardness
- witness: `halfspaces`
- worker constraint: no atlas files edited

## Files And Sources Read

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- neighboring scratchpad `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md`
- Tiegel 2023 PMLR page: `https://proceedings.mlr.press/v195/tiegel23a.html`
- Hanneke, Moran, and Thiessen OpenReview page: `https://openreview.net/forum?id=aoVCFtox89`

## Existing Edge State

The atlas edge is currently marked:

```yaml
status: "open"
evidence: unknown
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
family: marginal-uniformization-open
```

That diagnosis is no longer sharp for this edge. Full-support marginal
uniformization can handle the one-learner pathwise resource bound under the
current atlas convention, but this edge is actually refuted by a stronger
counterexample: Boolean halfspaces satisfy the source while failing the
distribution-free weak agnostic target.

## Verdict

`false`, assuming the worst-case lattice hardness used by Tiegel.

## Counterexample

**Goal.** Exhibit a concept class satisfying

$$
\text{efficient-marginal-nonuniform-weak-agnostic-proper-pac}
$$

but not

$$
\text{efficient-weak-agnostic-proper-pac}.
$$

Use Boolean affine halfspaces over $\mathbb R^d$. Constants are proper
halfspaces, e.g. by using zero weights with an appropriate threshold/sign
convention.

### Why The Source Holds

Halfspaces are efficiently realizably properly PAC learnable: on a realizable
sample, solve the linear feasibility problem for a separating halfspace, and
use the VC dimension of halfspaces for generalization.

For this edge, the source is agnostic but only asks for a marginal-nonuniform
weak tolerance whose gap may be inverse-polynomial. In fact, halfspaces satisfy
a slightly stronger distribution-free inverse-polynomial weak agnostic proper
guarantee.

Let $m(d)$ be a polynomial realizable sample bound for learning halfspaces to
a fixed clean disagreement target, say $1/16$, with constant confidence. Set

$$
\alpha(d) \le \frac{1}{100m(d)}.
$$

On agnostic data, the learner builds a candidate list:

1. include the two constant halfspaces;
2. draw $O(\log(1/\delta))$ fresh batches of size $m(d)$;
3. on each batch, if the labels are linearly separable, add a separating
   halfspace found by linear programming; otherwise add an arbitrary constant
   halfspace;
4. use a holdout sample to select the empirically best candidate to accuracy
   much smaller than $\alpha(d)$.

Every output is a proper halfspace.

Fix any joint distribution $\mathcal D$, and let

$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
=\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c).
$$

If $\eta$ is at least a constant multiple of $\alpha(d)$, one of the two
constant halfspaces has error at most $1/2$, hence is within

$$
\eta+1/2-\Omega(\alpha(d)).
$$

If $\eta$ is smaller than that threshold, choose a nearly optimal halfspace
$c^\star$. A fresh batch of $m(d)$ examples is entirely clean relative to
$c^\star$ with probability at least $1-m(d)\eta$, which is bounded below by a
positive constant by the choice of $\alpha(d)$. Conditioned on this clean
event, the batch is realizable by $c^\star$ under a marginal whose total
variation distance from the original marginal is $O(\eta)$. The realizable
halfspace learner therefore supplies, with constant probability, a proper
halfspace whose error is far below $1/2$ after translating back to the original
agnostic distribution. Repetition plus holdout validation finds such a
candidate with probability at least $1-\delta$.

Thus there is a polynomial-time proper learner with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma(d),
$$

where $\gamma(d)$ is inverse-polynomial. This is stronger than the assigned
source: the runtime, sample bound, and weak gap do not need to depend on the
marginal at all. In particular, it satisfies the marginal-nonuniform weak
agnostic proper source by taking the same polynomial for every marginal.

The properness check is essential. The low-noise robustification usually uses
constant classifiers, which need not be proper for an arbitrary class. For
halfspaces, the constants are themselves legal proper hypotheses, so the
robustified learner remains proper.

### Why The Target Fails

Tiegel proves hardness of agnostically learning halfspaces from worst-case
lattice problems. The PMLR abstract states the distribution-independent lower
bound in an improper form: under the assumption, there is no efficient
algorithm outputting any binary hypothesis with error better than

$$
1/2-\gamma
$$

even when the best halfspace has error as small as $\delta$, for suitable
hardness parameters. This is stronger than ruling out proper learners.

Now suppose an efficient weak agnostic proper learner for halfspaces existed
in the atlas sense, with fixed tolerance $\beta<1/2$. Let

$$
a=1/2-\beta>0.
$$

Choose Tiegel hard parameters with $\delta+\gamma<a$. On the hard distribution,
the weak learner would output a proper halfspace $h$ with

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+\beta
\le
\delta+\beta
<
1/2-\gamma,
$$

contradicting the lower bound. Since Tiegel rules out even arbitrary binary
outputs, it certainly rules out proper halfspace outputs.

Therefore halfspaces fail `efficient-weak-agnostic-proper-pac` under the
worst-case lattice assumption.

## Checks From The Prompt

### Weak-Gap Uniformization

The old open-edge explanation focused on marginal-dependent resource
polynomials. That is not the blocker here. The halfspace source learner has a
single distribution-free polynomial resource bound and a single
inverse-polynomial weak gap.

The mismatch is between the source's inverse-polynomial weak agnostic gap and
the target note's fixed-additive weak agnostic tolerance. A generic theorem
turning the low-noise inverse-polynomial weak source into the target fixed
weak agnostic learner would give a weak agnostic learner for halfspaces,
contradicting Tiegel's lower bound.

### Properness

The source proof is genuinely proper because all candidates are halfspaces.
The constants used in the high-OPT branch are also halfspaces. No improper
projection or boosted vote is used.

### Other Counterexamples

The PCP active-slice witness is useful for improper-to-proper separations, but
it is not needed here. The target failure is already witnessed by halfspaces,
and the source positivity is cleaner because it follows from realizable
proper halfspace learning plus the proper version of low-noise robustification.

The PRF and coordinate-block ideas are aimed at marginal weak-gap
uniformization. They are unnecessary for this edge because halfspaces refute
the target even without exploiting marginal dependence.

## Proposed Atlas Update

Suggested frontmatter direction:

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
summary: "False under worst-case lattice hardness: halfspaces satisfy the proper inverse-polynomial weak agnostic source, hence also its marginal-nonuniform relaxation, but Tiegel rules out distribution-free weak agnostic learning even with arbitrary binary hypotheses."
family: halfspace-agnostic-hardness
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
```

Suggested replacement body:

```markdown
## Verdict

`false`, under the worst-case lattice hardness assumption used by Tiegel.

Use Boolean affine halfspaces. They are efficiently realizably properly PAC
learnable by linear feasibility and VC generalization. Since constant
classifiers are themselves halfspaces, the low-noise weak agnostic
robustification can be made proper: include the two constants, repeatedly run
the realizable halfspace learner on small batches, and validate all candidate
halfspaces. Constants handle the case where the optimum error is above the
chosen inverse-polynomial weak gap; when the optimum is below that gap, a
fresh batch is clean relative to a near-optimal halfspace with constant
probability, and a separating halfspace from that batch gives a proper weak
candidate. Thus halfspaces satisfy the marginal-nonuniform weak agnostic
proper source, in fact with distribution-free resources and gap.

Tiegel's worst-case-lattice lower bound rules out efficient weak agnostic
learning of halfspaces even when the learner may output an arbitrary binary
hypothesis. If a distribution-free weak agnostic proper learner existed, then
on Tiegel's hard distribution it would output a halfspace with error
`OPT_C + beta < 1/2 - gamma` after choosing the hard parameters so that
`OPT_C <= delta` and `delta + gamma < 1/2 - beta`, contradicting the lower
bound.
```

Optional note-level cleanup:

- In `efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`, halfspaces
  can be listed as a positive boundary example for this exact source node,
  with the caveat that properness uses constants being halfspaces.
- The edge's family should move from `marginal-uniformization-open` to
  `halfspace-agnostic-hardness`.

## Final Verdict

verdict: resolved-false

confidence: high
