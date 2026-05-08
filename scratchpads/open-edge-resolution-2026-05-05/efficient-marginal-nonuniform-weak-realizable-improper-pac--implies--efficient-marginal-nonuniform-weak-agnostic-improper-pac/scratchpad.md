# Edge: efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md
- verdict: resolved-true
- confidence: medium-high

## Context

The current atlas edge is marked `open` under
[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]].
That diagnosis is too pessimistic for this exact edge.

Both source and target are:

- computational rather than sample-only;
- marginal-nonuniform rather than distribution-free;
- weak rather than strong;
- improper rather than proper.

The source gives, for every marginal $P$, one uniform learner $A$ with a
$P$-dependent polynomial sample/time bound $m_P$ and a $P$-dependent weak
realizable advantage $\gamma_P(s)>0$. The target also allows its additive weak
agnostic gap to depend on $P$. Therefore no weak-gap uniformization theorem is
needed.

The relevant existing atlas argument is
[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic
Robustification]]. The only adjustment from the already-resolved strong
realizable sibling is that the clean-run advantage is not a fixed constant; it
is the source advantage $\gamma_P(s)$. Since the target is marginal-nonuniform
weak agnostic, this is still enough.

## Attempted Resolution

**Goal.** Given an efficient marginal-nonuniform weak realizable improper
learner, construct an efficient marginal-nonuniform weak agnostic improper
learner for the same class.

Fix a marginal $P$ and representation size $s$. Let $A$ be the source learner.
Run $A$ at a constant internal failure probability, say $1/32$. Let
$m_P(s)$ be a $P$-dependent polynomial upper bound on this invocation's sample
use and running time, and let $\gamma_P(s)$ be the corresponding weak
realizable advantage:

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s)
$$

with constant success probability for every $c\in\mathcal C$.

Set

$$
\alpha_P(s)
=
\min\left\{\frac{\gamma_P(s)}{8},\frac{1}{256m_P(s)},\frac{1}{256}\right\},
\qquad
\beta_P(s)=\frac12-\alpha_P(s).
$$

This is a legal marginal-nonuniform weak agnostic gap: $1/\alpha_P(s)$ is
bounded by a $P$-dependent polynomial because both $1/\gamma_P(s)$ and
$m_P(s)$ are.

The agnostic wrapper on samples from a joint distribution $\mathcal D$ with
marginal $P$ is the usual low-noise robustification:

1. include the two constant classifiers as candidate improper hypotheses;
2. run $A$ independently on fresh agnostic samples a logarithmic number of
   times, pretending the labels are realizable;
3. validate the returned hypotheses and the constants on a fresh holdout
   sample to accuracy $O(\alpha_P(s))$;
4. output the empirically best candidate.

The resource bound is still a $P$-dependent polynomial in $s$ and
$\log(1/\delta)$: the number of source invocations is logarithmic, and the
holdout size is polynomial in $1/\alpha_P(s)$. This uses the same
marginal-nonuniform theorem-level convention as the current low-noise
argument: the wrapper is one uniform procedure, while the proof of its bound is
allowed to name the polynomial and gap attached to the fixed marginal $P$.

Let

$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
=
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c).
$$

### High-Noise Branch

If $\eta\ge 2\alpha_P(s)$, one of the two constants has error at most $1/2$.
Validation to error $O(\alpha_P)$ selects a candidate with true error at most
$1/2+O(\alpha_P)$, hence at most

$$
\eta+\frac12-\alpha_P(s)
$$

after fixing the validation constant small enough.

This is the neutralizer step: because the target is improper, constants are
legal fallback hypotheses. This is exactly where analogous proper-target edges
need extra selector or neutralizer structure.

### Low-Noise Branch

If $\eta<2\alpha_P(s)$, choose $c^\star\in\mathcal C$ with
$\operatorname{err}_{\mathcal D}(c^\star)\le \eta$ up to negligible slack.
Couple a noisy run of $A$ on $(X,Y)\sim\mathcal D$ with a realizable run on
$(X,c^\star(X))$, using the same $P$-distributed instance sequence and the same
internal randomness.

Since the run inspects at most $m_P(s)$ labels, the probability that any
inspected label differs from $c^\star(X)$ is at most

$$
m_P(s)\eta
<
2m_P(s)\alpha_P(s)
\le
\frac{1}{128}.
$$

On the no-corruption event, the noisy transcript is exactly the clean
realizable transcript under the original marginal $P$. Therefore the source
weak realizable guarantee applies without changing to a conditional clean
marginal. With constant probability the run returns $h$ such that

$$
\operatorname{err}_P(h,c^\star)\le \frac12-\gamma_P(s).
$$

For such an $h$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+\operatorname{err}_P(h,c^\star)
\le
\eta+\frac12-\gamma_P(s)
\le
\eta+\frac12-8\alpha_P(s).
$$

Repetition makes the probability of generating such a candidate at least
$1-\delta/2$, and holdout validation loses only $O(\alpha_P)$, still leaving
the required bound

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\frac12-\alpha_P(s).
$$

### Conclusion

The implication is true under the current atlas definitions. The proof is a
marginal-preserving low-noise robustification using the source's
$P$-dependent weak realizable advantage. It does not need:

- distribution-free weak-gap uniformization;
- agnostic boosting;
- strong agnostic learning;
- a proper selector.

## Hardness Routes Checked

### Halfspaces And Tiegel

Tiegel's 2023 result is decisive for strong agnostic halfspace targets and for
distribution-free weak agnostic formulations with a fixed or externally
specified gap. It does not refute this edge.

The reason is structural. The target here may choose a weak gap
$\alpha_P(s)$ depending on the fixed marginal $P$, and it only asks for
$\operatorname{OPT}_{\mathcal C}+1/2-\alpha_P(s)$. The low-noise
robustification above already supplies such a learner from the realizable
halfspace learner. Tiegel-style hardness still rules out stronger targets,
such as efficient agnostic improper learning or fixed-gap distribution-free
weak agnostic learning, but not this marginal-nonuniform weak target.

### FGRW-Style Weak Agnostic Hardness

Feldman-Guruswami-Raghavendra-Wu prove NP-hardness of weak agnostic learning of
monomials by halfspaces. This has the right flavor but not the right marginal
semantics for the assigned edge.

Their Label-Cover/dictatorship-test distributions are hardness distributions,
not a proof that one fixed marginal defeats every $P$-dependent weak gap.
Packing those reductions into one fixed marginal dilutes the hard slice, and
the weak target can then either ignore a low-mass slice or use constants as
neutralizers. This matches the obstacle recorded in
[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness
Open]].

### Neutralizer And Selector Check

For this improper target, the neutralizer exists: the two constant classifiers
are legal improper hypotheses and one has error at most $1/2$ under every
joint distribution. This handles the high-noise regime.

No proper selector is needed because the target does not require output in
$\mathcal C$. This is why the proof should not be copied blindly to proper
targets; there, constants may be illegal and the selector problem becomes real.

## Proposed Atlas Update

Set the edge to true:

```yaml
status: "true"
evidence: theorem
result_origin: "unclear"
assumptions: []
witnesses: []
ref_keys:
  - valiant1984
  - blumer1989
  - benedek1991fixed
  - hanneke2025marginalnonuniform
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "True: a marginal-preserving low-noise robustification converts the P-dependent weak realizable advantage into a P-dependent weak agnostic tolerance, with constants neutralizing the high-noise regime."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
```

Replacement body sketch:

```markdown
## Verdict

`true`, by a marginal-preserving low-noise robustification.

## Proof Status

**Goal.** Build a weak agnostic improper learner while keeping all
marginal-dependent bounds attached to the original marginal $P$.

Fix $P$. Let $A$ be the marginal-nonuniform weak realizable improper learner.
For a constant-confidence invocation, write $m_P(s)$ for its $P$-dependent
sample/time bound and $\gamma_P(s)$ for its weak realizable advantage. Set
$$
\alpha_P(s)=
\min\{\gamma_P(s)/8,1/(256m_P(s)),1/256\},
\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$

The agnostic learner includes the two constant classifiers, runs $A$ several
times on fresh agnostic samples, validates the returned hypotheses and the
constants, and outputs the empirically best candidate.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge 2\alpha_P(s)$, a constant
classifier of error at most $1/2$ satisfies the target after validation. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<2\alpha_P(s)$, choose a
near-optimal concept $c^\star$. Couple each noisy invocation with a realizable
invocation on $(X,c^\star(X))$ using the same original $P$-distributed
instances and the same learner randomness. Since the invocation reads at most
$m_P(s)$ labels, the chance of any corrupted inspected label is at most
$m_P(s)\eta\le 1/128$. On the no-corruption event, the noisy transcript is a
valid realizable transcript under the original marginal $P$, so the source
guarantee gives a hypothesis with error at most $1/2-\gamma_P(s)$ against
$c^\star$. Its agnostic error is therefore at most
$\eta+1/2-\gamma_P(s)$, which is stronger than
$\eta+1/2-\alpha_P(s)$. Repetition and validation amplify the success
probability to $1-\delta$.

The proof never invokes the learner under a conditional clean marginal; all
resource and weak-gap parameters remain attached to the original $P$.
```

## Obstacles

No mathematical obstacle remains for the assigned improper marginal-nonuniform
weak edge.

There are two bookkeeping caveats for the atlas update:

1. The proof should be tied to the existing
   `low-noise-weak-agnostic-robustification` argument, not to Tiegel or FGRW
   hardness.
2. The analogous proper-target edge should not be marked true from this proof
   alone. The high-noise branch uses constants as improper neutralizers.

## Next Directions

1. Update the assigned atlas edge to the proposed `true` verdict when atlas
   edits are allowed.
2. Audit the sibling
   `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`;
   because the target is also improper, the same argument appears to apply.
3. Keep proper weak agnostic targets separate and continue tracking them under
   selector/neutralizer obstacles.

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- Tiegel 2023, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems": https://proceedings.mlr.press/v195/tiegel23a.html
- Hanneke-Moran-Thiessen 2025, "Marginal-Nonuniform PAC Learnability": https://openreview.net/forum?id=aoVCFtox89
- Feldman-Guruswami-Raghavendra-Wu 2012, "Agnostic Learning of Monomials by Halfspaces Is Hard": https://doi.org/10.1137/120865094
