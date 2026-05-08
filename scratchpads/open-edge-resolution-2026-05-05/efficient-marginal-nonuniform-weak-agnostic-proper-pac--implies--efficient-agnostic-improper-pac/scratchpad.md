# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac

Date: 2026-05-05

Worker constraint: wrote only this scratchpad; no atlas files edited.

## Files And Sources Read

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- Neighboring scratchpad: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md`
- Primary sources checked online: Tiegel 2023 (`https://arxiv.org/abs/2207.14030` and PMLR), Feldman 2010 (`https://arxiv.org/abs/0909.2927`), Ghai--Singh 2025 (`https://proceedings.mlr.press/v267/ghai25a.html`), da Cunha--Hogsgaard--Paudice 2026 (`https://arxiv.org/abs/2601.11265`).

## Existing Edge State

The assigned edge is currently:

```yaml
status: "open"
evidence: unknown
family: marginal-uniformization-open
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
```

I think this can be sharpened to a conditional false edge. The obstacle is not only marginal uniformization: halfspaces satisfy the proper weak marginal-nonuniform agnostic source, but Tiegel's halfspace hardness rules out the strong distribution-free agnostic improper target.

## Verdict

`false`, under worst-case lattice hardness.

## Counterexample

**Goal.** Refute
$$
\text{efficient-marginal-nonuniform-weak-agnostic-proper-pac}
\Rightarrow
\text{efficient-agnostic-improper-pac}.
$$

It is enough to give a class satisfying the source while failing the target.

**Witness class.** Let $\mathcal C_d$ be Boolean affine halfspaces over $\mathbb R^d$, represented by a weight vector and threshold. The class contains the two constant classifiers by taking zero weights and an appropriate threshold/sign convention.

### Why The Source Holds

Halfspaces have an efficient distribution-free realizable proper learner: on a realizable sample, solve the corresponding linear feasibility problem to find a separating halfspace, and use the VC dimension of halfspaces for generalization.

For this edge we need a weak agnostic, proper, marginal-nonuniform learner. In fact, halfspaces satisfy a slightly stronger distribution-free inverse-polynomial weak version.

Fix dimension/representation size $s \simeq d$. Let $m(s)$ be a standard realizable VC sample size for halfspaces at a fixed clean disagreement target, say $1/16$, and constant confidence. Set
$$
\alpha(s) \le \frac{1}{100m(s)}
\quad\text{and}\quad
\gamma(s)=\alpha(s)/4.
$$
The learner does the following:

1. Put the two constant halfspaces in a candidate list.
2. Draw $O(\log(1/\delta))$ fresh batches of size $m(s)$.
3. On each batch, if the labels are linearly separable, add any separating halfspace found by linear programming to the list; otherwise add an arbitrary constant halfspace.
4. Use a holdout sample to select the empirically best candidate to accuracy $O(\gamma(s))$.

All outputs are halfspaces, so the learner is proper. The sample complexity and running time are polynomial in $s$ and $\log(1/\delta)$, and the weak gap $\gamma(s)$ is inverse-polynomial.

Now fix any joint distribution $\mathcal D$ with marginal $P$, and let
$$
\operatorname{OPT}=\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c).
$$

If $\operatorname{OPT}\ge 2\gamma(s)$, one of the two constant halfspaces has true error at most $1/2$. The holdout selector loses only $O(\gamma(s))$, so it returns a candidate with error at most
$$
\operatorname{OPT}+1/2-\gamma(s).
$$

If $\operatorname{OPT}<2\gamma(s)$, choose a halfspace $c^\star$ with error $\eta$ within a negligible additive slack of $\operatorname{OPT}$. A batch of $m(s)$ examples is completely clean relative to $c^\star$ with probability at least $1-m(s)\eta$, which is bounded below by a positive constant because $\eta< O(\alpha(s))$. Conditioned on this clean event, the instances are i.i.d. from a marginal $Q$ whose total variation distance from the original marginal $P$ is $O(\eta)$. By the realizable VC guarantee, a separating halfspace for that clean batch has small disagreement with $c^\star$ under $Q$, hence also under $P$. Its agnostic error under $\mathcal D$ is then bounded well below $1/2-\gamma(s)$, and repetition plus holdout validation finds such a candidate with probability at least $1-\delta$.

Thus halfspaces satisfy the source with
$$
\beta(s)=1/2-\gamma(s)<1/2.
$$
This is stronger than required: the polynomial and the weak gap do not even need to depend on the marginal $P$.

The properness point matters. The general atlas edge from realizable proper learning to marginal-nonuniform weak agnostic proper learning remains open because the usual low-noise robustification falls back on constant classifiers, and constants need not be proper for an arbitrary class. For halfspaces, constants are proper halfspaces, so that obstruction disappears for this witness.

### Why The Target Fails

Tiegel proves hardness of agnostically learning halfspaces from worst-case lattice problems. The result rules out improper agnostic learning: the learner may output any binary hypothesis, not necessarily a halfspace.

The distribution-specific part is already enough here. Under the standard Gaussian marginal, for every constant $\beta>0$, learning halfspaces to error
$$
\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon
$$
requires time
$$
d^{\widetilde{\Omega}(1/\varepsilon^{2-\beta})}
$$
under the same worst-case lattice assumptions. This is not polynomial in $(d,1/\varepsilon)$ for that fixed marginal.

The target node, [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]], is distribution-free and therefore would in particular give a polynomial-time improper agnostic learner under the standard Gaussian marginal. That contradicts Tiegel's lower bound. Hence halfspaces fail the target.

## Checks Requested In Prompt

### Halfspace Hardness

Halfspaces are the right witness. They satisfy efficient realizable proper learning, the constants needed by the weak low-noise robustification are themselves halfspaces, and Tiegel's lower bound applies even to improper strong agnostic learners. The lower bound is stronger than needed because it refutes the target on one fixed marginal, while the assigned target asks for a distribution-free polynomial.

### Agnostic Boosting

Feldman and Ghai--Singh are attractive for marginal bookkeeping because their distribution-specific boosters modify labels or use unlabeled data in a way that preserves the instance marginal. But their weak-oracle assumptions are correlation/threshold style with tunable additive slack. The atlas source only gives a fixed additive guarantee
$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma(s),
$$
where $\gamma(s)$ may be merely inverse-polynomial. In correlation form this says roughly
$$
\operatorname{corr}(h)\ge \sup_{c\in\mathcal C}\operatorname{corr}(c)-1+2\gamma(s),
$$
which is useful only when the best concept has correlation very close to $1$.

The da Cunha--Hogsgaard--Paudice theorem is closer to this fixed-additive shape because it can use a nontrivial weak gap. However, the available running-time bounds put weak-learner/sample/capacity parameters in the exponent. That does not give the atlas-polynomial conversion needed here.

The halfspace counterexample explains why this near miss cannot be repaired by a generic theorem for the current source definition: such a theorem would turn the halfspace source above into a strong agnostic learner, contradicting Tiegel.

### Weak-Gap Uniformization

The hidden weak gap is not the issue for this witness. The halfspace source can be witnessed with a distribution-free inverse-polynomial gap $\gamma(s)$, so there is no marginal-dependent exponent to discover.

The failure is that a fixed inverse-polynomial additive weak gap cannot be uniformly shrunk to arbitrary excess error $\varepsilon$. Tiegel's standard-Gaussian lower bound rules out precisely that strong excess-error target, even when the marginal is fixed. Therefore neither marginal uniformization nor a search over weak-gap guesses can prove this edge true.

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
summary: "False under worst-case lattice hardness: halfspaces satisfy the proper inverse-polynomial weak marginal-nonuniform agnostic source via low-noise robustification, but Tiegel's halfspace hardness rules out distribution-free strong agnostic improper learning."
family: halfspace-agnostic-hardness
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
```

Suggested body:

> Use Boolean affine halfspaces. They are efficiently realizably properly PAC learnable by linear feasibility and VC generalization. Moreover, because constant classifiers are themselves halfspaces, the low-noise robustification gives a proper weak agnostic learner with inverse-polynomial gap: include the two constants, repeatedly run the realizable halfspace learner on small batches, and validate the candidate list. Constants handle $\operatorname{OPT}$ above the inverse-polynomial gap; when $\operatorname{OPT}$ is below that gap, a fresh batch is clean relative to a near-optimal halfspace with constant probability, so a separating halfspace from that batch has error well below $1/2$. Thus halfspaces satisfy the source. But Tiegel's worst-case-lattice hardness result rules out polynomial-time improper agnostic learning of halfspaces, already under the standard Gaussian marginal, to error $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$. A distribution-free strong agnostic improper learner would contradict this fixed-marginal lower bound.

Optional related note update:

> In `efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`, halfspaces can be listed as a positive boundary example for this exact marginal weak proper node, with the caveat that the argument uses constants being proper halfspaces. They remain a negative boundary example for strong agnostic improper/proper targets under Tiegel.

## Final Verdict

verdict: resolved-false

confidence: 0.89
