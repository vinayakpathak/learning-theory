# Edge: efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- verdict: resolved-true
- confidence: high

## Context

The current atlas edge is marked `open` under
[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]].
For this exact edge, that open diagnosis looks too pessimistic.

The source gives one uniform proper learner $A$ such that, for every instance
marginal $P$, there are:

- a $P$-dependent polynomial sample/time bound $m_P(s,\log(1/\delta))$;
- a $P$-dependent inverse-polynomial weak advantage $\gamma_P(s)>0$;
- and, for every realizable target $c\in\mathcal C$, an output
  $h\in\mathcal C$ satisfying
  $$
  \operatorname{err}_P(h,c)\le \frac12-\gamma_P(s).
  $$

The target asks for an improper weak agnostic learner. It may output any binary
hypothesis, and its additive weak-agnostic gap may also depend on $P$:
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\alpha_P(s)
$$
for some inverse-polynomial $P$-dependent $\alpha_P(s)>0$.

Thus the target is exactly in the range of the low-noise robustification
argument. The source is proper, but the target is improper, so the wrapper may
use arbitrary candidate hypotheses, including the two constants.

## Resolution

**Goal.** Construct an efficient marginal-nonuniform weak agnostic improper
learner from the source weak realizable proper learner.

Fix a marginal $P$ and representation size $s$. Run the source learner with a
constant internal failure probability, say $1/64$. Let $m_P(s)$ be a
$P$-dependent polynomial upper bound for this invocation's sample use and
runtime, and let $\gamma_P(s)$ be its weak realizable advantage. Set
$$
\alpha_P(s)
=
\min\left\{\frac{\gamma_P(s)}{16},\frac{1}{512m_P(s)},\frac{1}{512}\right\},
\qquad
\beta_P(s)=\frac12-\alpha_P(s).
$$
This is a legal target gap: $1/\alpha_P(s)$ is bounded by a $P$-dependent
polynomial because both $1/\gamma_P(s)$ and $m_P(s)$ are.

The agnostic wrapper on samples from a joint distribution $\mathcal D$ with
marginal $P$ does the following:

1. include the two constant classifiers as candidate improper hypotheses;
2. run $A$ independently on fresh agnostic batches, pretending the labels are
   realizable;
3. validate all returned hypotheses and the constants on a fresh holdout sample
   to accuracy much smaller than $\alpha_P(s)$;
4. output the empirically best candidate.

The wrapper is one uniform algorithm. For the proof of its marginal-nonuniform
resource bound, fix $P$ and use the $P$-dependent polynomial bounds for
$m_P(s)$, $1/\gamma_P(s)$, and the holdout size $O(\alpha_P(s)^{-2})$.

## Proof

Let
$$
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
=
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c).
$$

### High-Noise Branch

If $\eta\ge 2\alpha_P(s)$, one of the two constant classifiers has error at
most $1/2$ under $\mathcal D$. Therefore
$$
\frac12
\le
\eta+\frac12-2\alpha_P(s)
<
\eta+\frac12-\alpha_P(s).
$$
With holdout accuracy chosen below, say, $\alpha_P(s)/4$, validation selects a
candidate satisfying the required weak agnostic bound. This is the "constant
neutralizer" step. It is valid here precisely because the target is improper;
the constants need not belong to $\mathcal C$.

### Low-Noise Branch

If $\eta<2\alpha_P(s)$, choose $c^\star\in\mathcal C$ with
$\operatorname{err}_{\mathcal D}(c^\star)\le\eta+\tau$ for negligible
$\tau>0$.

Couple one noisy run of $A$ on examples $(X,Y)\sim\mathcal D$ with one clean
realizable run on examples $(X,c^\star(X))$, using the same $P$-distributed
instance sequence and the same internal randomness. Since the invocation
inspects at most $m_P(s)$ labels, a union bound gives corruption probability
at most
$$
m_P(s)(\eta+\tau)
<
3m_P(s)\alpha_P(s)
\le
\frac{3}{512},
$$
for small enough $\tau$.

On the no-corruption event, the noisy transcript is exactly a realizable
transcript for target $c^\star$ under the original marginal $P$. No conditional
clean marginal $Q$ appears. Therefore the source guarantee applies with the
same $P$-dependent runtime/sample polynomial and with the same weak advantage.
With constant probability, the run returns a proper concept $h\in\mathcal C$
satisfying
$$
\operatorname{err}_P(h,c^\star)\le\frac12-\gamma_P(s).
$$
Because $h$ and $c^\star$ disagree only on the instance marginal,
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)
+
\operatorname{err}_P(h,c^\star)
\le
\eta+\tau+\frac12-\gamma_P(s).
$$
Since $\alpha_P(s)\le\gamma_P(s)/16$, this is comfortably below
$$
\eta+\frac12-\alpha_P(s)
$$
after absorbing validation and approximation slack.

Repeating the source invocation a logarithmic number of times makes the
probability of generating a good candidate high. Holdout validation then
selects a good candidate with probability at least $1-\delta$ using a
$P$-dependent polynomial number of samples and time.

## Why This Avoids The Marginal Obstruction

The fragile step in older low-noise sketches is conditioning on the event that
an entire batch is clean. Conditioning changes the instance marginal from $P$
to some $Q$, and a marginal-nonuniform learner need not have the same
polynomial bound under $Q$.

The coupling proof avoids that. It compares two executions on the same original
$P$-distributed instance sequence. On the no-corruption event the transcripts
are identical, so the clean execution is a valid source execution under
marginal $P$ itself.

## Constants As Improper Neutralizers

The high-noise branch needs a fallback candidate of error at most $1/2$ for
arbitrary labels. The two constant classifiers provide this. This is not a
property of the concept class; it is allowed only because the target is
improper.

This also explains the boundary with neighboring open proper-target edges. If
the target required $h\in\mathcal C$, the constants might be illegal, and the
proof would need a proper neutralizer, selector, or weak ERM routine. No such
object follows from the source node alone.

## Halfspace And FGRW Hardness Checks

### Halfspaces / Tiegel

Tiegel 2023 proves lattice-based hardness of agnostically learning halfspaces,
including improper learning. The PMLR abstract records two forms:
distribution-independent hardness of beating $1/2-\gamma$ even when
$\operatorname{OPT}$ is very small, and distribution-specific strong agnostic
hardness under the standard Gaussian marginal.

This does not refute the assigned edge. For any class satisfying the source,
the construction above supplies a marginal-nonuniform weak agnostic improper
learner with a $P$-dependent gap $\alpha_P(s)$. The hard halfspace parameters
can rule out stronger distribution-free or strong-excess targets, but they
cannot refute this black-box theorem without contradicting the coupling
argument. In atlas terms, halfspaces are a useful witness for strong agnostic
or distribution-free agnostic targets, not for this marginal-nonuniform weak
improper target.

### FGRW

Feldman-Guruswami-Raghavendra-Wu prove NP-hardness of weak agnostic learning of
monomials even when the output class is expanded to halfspaces: in their
formulation, examples are almost consistent with a monomial, but finding a
halfspace with advantage over $1/2$ is NP-hard.

This also does not refute the assigned edge. The source class in that theorem
would be monomials while the hard improper output comparator is halfspaces; the
atlas target here competes with the same class $\mathcal C$ and permits
arbitrary improper hypotheses only as outputs. More importantly, the hardness
distribution is part of the reduction. The assigned target may choose its weak
gap as a function of the fixed marginal $P$, and the low-noise coupling uses
only the original $P$.

Packing Label-Cover or dictatorship-test instances into one fixed marginal
would dilute hard slices, allowing constants to handle the high-noise regime or
letting the $P$-dependent weak gap shrink around the packed marginal. That is a
near miss for marginal-nonuniform weak targets, not a counterexample to this
edge.

## Proposed Atlas Update

Set the edge to true:

```yaml
status: "true"
evidence: theorem
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
summary: "True: a marginal-preserving low-noise robustification converts the P-dependent weak realizable advantage into a P-dependent weak agnostic tolerance, and constants neutralize the high-noise regime because the target is improper."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
```

Suggested replacement body:

```markdown
## Verdict

`true`, by marginal-preserving low-noise robustification.

## Proof Status

**Goal.** Build a weak agnostic improper learner while keeping all
marginal-dependent bounds attached to the original marginal $P$.

Fix $P$. Let $A$ be the marginal-nonuniform weak realizable proper learner. For
a constant-confidence invocation, write $m_P(s)$ for its $P$-dependent
sample/time bound and $\gamma_P(s)$ for its weak realizable advantage. Set
$$
\alpha_P(s)=
\min\{\gamma_P(s)/16,1/(512m_P(s)),1/512\},
\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$

The agnostic wrapper includes the two constant classifiers, runs $A$ on fresh
agnostic batches as if they were realizable, validates all candidates on a
fresh holdout sample, and returns the empirically best candidate.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge 2\alpha_P(s)$, a constant
classifier has error at most $1/2$, hence is within
$\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s)$. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)<2\alpha_P(s)$, choose a
near-optimal $c^\star\in\mathcal C$ and couple a noisy run of $A$ to a clean
realizable run on $(X,c^\star(X))$ using the same original $P$-distributed
instance sequence. With inverse-polynomial probability no inspected label is
corrupted; on that event the transcript is a valid source transcript under
marginal $P$, and the returned concept has error at most $1/2-\gamma_P(s)$
against $c^\star$. Repetition and validation preserve a gap of at least
$\alpha_P(s)$.

The proof never invokes the source learner under a conditional clean marginal,
so the marginal-nonuniform resource bound remains attached to the original
marginal $P$.
```

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/witnesses/halfspaces.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- Tiegel 2023, Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems: https://proceedings.mlr.press/v195/tiegel23a.html
- Feldman, Guruswami, Raghavendra, and Wu 2012, Agnostic Learning of Monomials by Halfspaces Is Hard: https://doi.org/10.1137/120865094
