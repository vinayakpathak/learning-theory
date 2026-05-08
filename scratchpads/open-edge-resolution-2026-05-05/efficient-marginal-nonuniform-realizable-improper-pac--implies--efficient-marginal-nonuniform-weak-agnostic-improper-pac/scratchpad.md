# Edge: efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md
- verdict: resolved-true
- confidence: high

## Context

The current edge note marks the implication as open under
[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]].
That open-family diagnosis is too pessimistic for this exact edge because both
source and target are improper, and the source is a strong realizable learner.

The existing atlas note
[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]
already records the needed theorem pattern. It explicitly notes that for
marginal-nonuniform realizable sources one should use a marginal-preserving
coupling, rather than conditioning on a clean batch and thereby changing the
marginal.

There is also an already-resolved sibling edge

`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`,

which is marked true by the same coupling argument. The assigned edge is at
least as easy: the source learner may be improper, and the target also permits
improper output.

## Attempted Resolution

**Goal.** Given an efficient marginal-nonuniform strong realizable improper
learner $A$, construct an efficient marginal-nonuniform weak agnostic improper
learner.

Fix a marginal $P$. Run $A$ with constant accuracy and confidence, say
$\varepsilon_0=1/8$ and failure probability at most $1/16$. Let $m_P(s)$ be a
polynomial upper bound on the resulting sample use and running time under $P$.
The marginal-nonuniform source gives such a polynomial for this fixed $P$.

Define
$$
\alpha_P(s)=\min\{1/64,1/(64m_P(s))\},
\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$
The target only needs a weak agnostic tolerance whose gap from $1/2$ is inverse
polynomial under a $P$-dependent polynomial, so this is quantitatively enough.

The learner on agnostic data from $\mathcal D$ with marginal $P$ does the
standard robustification:

1. include the two constant classifiers as candidates;
2. run $A$ a polynomial number of times on fresh agnostic batches, pretending
   the labels are realizable;
3. validate all candidates on a fresh sample to constant accuracy and output the
   empirically best one.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, one of the two
constant classifiers has error at most $1/2$, hence
$$
1/2 \le \operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s).
$$
So the weak agnostic guarantee holds.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<\alpha_P(s)$, choose
$c^\star\in\mathcal C$ with error at most $\eta$ up to an arbitrarily small
slack. Couple one noisy run of $A$ on examples $(X,Y)\sim\mathcal D$ with one
realizable run on $(X,c^\star(X))$, using the same $P$-distributed instance
sequence and the same internal randomness. Since the invocation inspects at
most $m_P(s)$ labels, the probability that any inspected label differs from
$c^\star(X)$ is at most
$$
m_P(s)\eta < 1/64.
$$
On the no-corruption event, the noisy transcript is exactly the realizable
transcript under the original marginal $P$. Thus the source guarantee applies
with the same $P$-dependent polynomial $m_P$, and with constant probability the
run returns a hypothesis $h$ satisfying
$$
\operatorname{err}_P(h,c^\star)\le \varepsilon_0.
$$
Then
$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\operatorname{err}_P(h,c^\star)
\le
\eta+\varepsilon_0
\le
\eta+1/2-\alpha_P(s),
$$
after the above choice of constants. Repetition makes the chance of seeing such
a good candidate high, and validation selects a good candidate with probability
at least $1-\delta$ using only a $P$-dependent polynomial number of samples and
time.

The crucial point is that the proof never invokes $A$ on a conditional clean
marginal $Q$. The realizable comparison run uses exactly the original marginal
$P$, so the marginal-nonuniform resource bound is preserved.

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
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: "True: a low-noise coupling robustifies the marginal-nonuniform realizable improper learner without changing the marginal."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
```

Replacement body sketch:

```markdown
## Verdict

`true`, by a marginal-preserving low-noise robustification.

## Proof Status

**Goal.** Build a weak agnostic learner while keeping all marginal-dependent
bounds attached to the original marginal $P$.

Fix $P$ and let $A$ be the marginal-nonuniform realizable improper learner. Run
$A$ with constant accuracy and confidence, and let $m_P(s)$ be the resulting
$P$-dependent polynomial sample/time bound. Set
$$
\alpha_P(s)=\min\{1/64,1/(64m_P(s))\},
\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$

The weak agnostic learner includes the two constant classifiers, runs $A$ a
polynomial number of times on fresh agnostic samples, validates all returned
hypotheses, and outputs the empirically best candidate.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, a constant
classifier of error at most $1/2$ already satisfies the weak agnostic target. If
$\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<\alpha_P(s)$, choose
$c^\star\in\mathcal C$ with error $\eta$ up to negligible slack. Couple a noisy
run of $A$ with a realizable run on $(X,c^\star(X))$, using the same
$P$-distributed instance sequence and the same internal randomness. Since the
run inspects at most $m_P(s)$ labels, a union bound gives corruption probability
at most $m_P(s)\eta<1/64$. On the no-corruption event, the noisy transcript is
the realizable transcript under the original marginal $P$, so the source
guarantee applies. The returned hypothesis has constant error against
$c^\star$, and therefore weak agnostic error at most
$\eta+1/2-\alpha_P(s)$. Repetition and validation amplify to confidence
$1-\delta$.

The proof avoids the conditional-marginal obstruction: it never calls the
realizable learner under a clean conditional marginal $Q$, only under the
original marginal $P$.
```

## Obstacles

No remaining obstacle for the assigned edge. The only delicate point is the
runtime/sample-bound convention: the proof uses the polynomial $m_P(s)$ as a
worst-case upper bound for a constant-accuracy invocation of $A$ under marginal
$P$. This is consistent with the atlas definition, which says the learner uses
at most the marginal-dependent polynomial number of samples and time.

## Next Directions

1. Update the atlas edge file with the proposed `true` verdict.
2. Consider whether the sibling open edge
   `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`
   should remain open because the target is proper; the present argument only
   gives an improper agnostic output.
3. Audit the remaining `marginal-agnostic-hardness-open` edges whose source is
   strong realizable and whose target is improper weak agnostic; these may be
   resolvable by the same low-noise coupling.

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
