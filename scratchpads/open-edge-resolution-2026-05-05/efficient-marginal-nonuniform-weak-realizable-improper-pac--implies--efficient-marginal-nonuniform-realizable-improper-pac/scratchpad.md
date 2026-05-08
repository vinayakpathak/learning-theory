# Edge: efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-improper-pac`
- target: `efficient-marginal-nonuniform-realizable-improper-pac`
- verdict: unresolved-open
- confidence: 0.86
- worker constraint: scratchpad only; no atlas files edited

## Executive Verdict

I do not see an atlas-ready proof or an atlas-ready counterexample. The edge
should remain `open`.

The source gives one uniform learner $A$ such that, for every instance marginal
$P$, there is a $P$-dependent polynomial resource bound and a $P$-dependent
inverse-polynomial weak gap $\gamma_P(s)>0$. On realizable labels from $P$,
$A$ returns an improper hypothesis with

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s).
$$

The target asks for arbitrary error $\varepsilon$ under the same original
marginal $P$, with samples and running time bounded by one polynomial
$q_P(s,1/\varepsilon,\log(1/\delta))$ independent of the target concept and
independent of the boosting transcript.

Classical Schapire/Freund boosting proves the analogous distribution-free
weak-to-strong implication, but it does so by asking the weak learner to work
on filtered or reweighted marginals. The marginal-nonuniform source gives a
weak gap for each such induced marginal separately. It does not give one
original-marginal polynomial lower-bounding all those gaps.

The sharp obstruction is therefore a weak-gap envelope, not merely one-call
runtime. Under the atlas worst-case finite-transcript convention,
full-support marginal uniformization can control the pathwise sample/time
bound of a fixed source learner. It cannot transfer the accuracy or weak gap
from one marginal to another.

## Files And Sources Read

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- neighboring scratchpads for weak-agnostic and weak-proper marginal boosting edges
- Schapire 1990, The Strength of Weak Learnability: https://www.schapire.net/papers/strengthofweak.pdf
- Freund 1995, Boosting a Weak Learning Algorithm by Majority: https://doi.org/10.1006/inco.1995.1136
- Feldman 2010, Distribution-Specific Agnostic Boosting: https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf
- Ghai and Singh 2025, Sample-Optimal Agnostic Boosting with Unlabeled Data: https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice 2026, Sample-Near-Optimal Agnostic Boosting with Improved Running Time: https://arxiv.org/abs/2601.11265
- Hanneke, Moran, and Thiessen 2025, Marginal-Nonuniform PAC Learnability: https://openreview.net/forum?id=aoVCFtox89

## Current Edge State

The edge note currently records:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - freund1995boosting
  - benedek1991fixed
summary: "Open: Schapire/Freund boosting calls the weak learner on reweighted marginals, and the atlas source gives no original-marginal polynomial controlling target- and history-dependent reweightings."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

That status still looks right. The summary is basically accurate; the only
sharpening I would make is to say explicitly that the missing control is over
weak advantages on induced marginals. Runtime of one weak call is less central
after the full-support transcript-uniformization argument.

## Positive Proof Attempt

### Goal

Fix an original marginal $P$ and target concept $c$. We want a learner $B$ such
that, for every $\varepsilon,\delta\in(0,1)$,

$$
\operatorname{err}_P(B,c)\le \varepsilon
$$

with sample use and running time bounded by one polynomial
$q_P(s,1/\varepsilon,\log(1/\delta))$.

### Standard Boosting Route

Schapire's construction and later boosting algorithms take a weak learner and
force it to focus on the residual hard parts of the distribution. Equivalently,
the weak learner is called on marginals $Q_t$ obtained from $P$ by filtering or
reweighting according to previous hypotheses.

For a distribution-free weak learner, this is fine: the same inverse-polynomial
gap lower bound works for every $Q_t$. For the source here we only have

$$
\forall Q\ \exists r_Q\quad \gamma_Q(s)\ge 1/r_Q(s).
$$

The target would need something like

$$
\forall P\ \exists r_P\ \forall t\le T(P,c,\varepsilon):
\gamma_{Q_t}(s)\ge 1/r_P(s,1/\varepsilon).
$$

Then ordinary boosting would give a polynomial number of rounds, for example
with the usual dependence $O(\gamma^{-2}\log(1/\varepsilon))$, and the
full-support resource argument would bound each weak call.

The source definition does not imply this quantifier swap. The marginals
$Q_t$ can depend on $P$, the target $c$, prior weak hypotheses, validation
randomness, and $\varepsilon$. For each finite transcript there is some
polynomial, but taking the maximum over all possible targets and transcripts
can make the exponent depend on the target path or on the requested accuracy.
That is not allowed in the target node.

### Smooth Boosting Route

A smoother booster might keep every induced marginal absolutely continuous
with respect to $P$ and satisfy a density cap

$$
\left\|dQ_t/dP\right\|_\infty\le B(s,1/\varepsilon).
$$

This would prove the edge if the following envelope followed from the source:

$$
\Gamma_P(B,s)
=
\inf\{\gamma_Q(s): Q\ll P,\ \|dQ/dP\|_\infty\le B\}
\ge \frac{1}{r_P(s,B)}
$$

for some $P$-dependent polynomial $r_P$.

I do not see a derivation. Bounded density still permits focusing on a slice
$S_j$ with $P(S_j)\simeq 1/B$. The pointwise source is compatible, at the level
of quantifiers, with a sequence of bounded-density marginals $Q_j\ll P$ whose
weak gaps behave like

$$
\gamma_{Q_j}(s)\simeq s^{-j}.
$$

Each $Q_j$ has an inverse-polynomial weak gap, but no single polynomial in
$(s,B)$ lower-bounds all of them if $j$ can grow with the accuracy scale. This
is not a counterexample by itself; it is a barrier to proving the edge by
smoothness alone.

### Same-Marginal Agnostic Boosting Route

The source is only realizable, so Feldman/Ghai-style same-marginal agnostic
boosting is not directly applicable: those algorithms make weak calls on
relabelings or agnostic distributions while keeping the instance marginal fixed
at $P$. The realizable source gives no guarantee on those relabeled examples.

I still checked this route because it is the obvious way to avoid changing the
instance marginal. Even under a stronger weak-agnostic source, the known
fixed-marginal boosters are near misses rather than a proof of this edge:

- Feldman's distribution-specific booster preserves the marginal, but assumes
  a threshold-style $(\alpha,\gamma)$ weak agnostic oracle. When translated
  from a fixed-additive `OPT + beta_P` guarantee, it only works above the
  additive floor and cannot drive realizable error to arbitrary
  $\varepsilon$.
- Ghai and Singh's 2025 unlabeled-data result is efficient and valuable in
  distribution-specific settings, but the recorded guarantees still require a
  weak-oracle slack at the final accuracy scale.
- da Cunha, Hogsgaard, and Paudice 2026 can leverage nontrivial fixed-additive
  agnostic weak learners, which is very close in spirit. However, their
  explicit runtime has weak-parameter-dependent exponents such as
  $n^{O(m_0\min\{d^*,\log n\}/\theta^2)}$. In the atlas source, $m_0$ and
  $1/\theta$ may themselves be $P$-dependent polynomials in $s$, so this does
  not give a polynomial in $(s,1/\varepsilon,\log(1/\delta))$.

Thus agnostic boosting does not currently bypass the marginal weak-gap
envelope problem for this realizable edge.

### Dovetailing And Validation

One might try to run boosters for many guessed weak gaps and validate the
final hypotheses on fresh $P$-samples. Validation can identify a successful
candidate once one appears, but it does not create a $P$-dependent polynomial
upper bound on the first successful candidate's runtime. If the relevant
residual marginals have gaps $s^{-j}$ for unbounded $j$ as
$\varepsilon\downarrow 0$, the first successful boosting schedule can require
quasi-polynomial or worse time even though each marginal separately has an
inverse-polynomial gap.

This is another way the missing envelope reappears.

## Diagonal True-Proof Attempt

There is a tempting diagonal argument. Suppose no $P$-envelope exists. Choose
reachable marginals $Q_j$ and sizes $s_j$ with weak gaps below $s_j^{-j}$, then
stitch them into one marginal $R$. Since the source must weakly learn under
$R$ with some inverse-polynomial gap, perhaps this contradicts the construction
for large $j$.

This would likely work under a stronger size-indexed semantics where a
marginal is a family $(P_s)_{s\ge1}$ and risks are evaluated separately on each
active size slice. Then one bad $Q_j$ per size can be folded into a single
diagonal marginal family.

I do not think the current atlas wording justifies this proof. Under a global
mixture marginal, the bad components can be assigned small masses. A weak
learner only needs to beat $1/2$ by some inverse-polynomial amount on the
mixture, so it may ignore sufficiently low-mass bad slices. Strong learning to
arbitrary $\varepsilon$ cannot ignore them, but that is precisely the target
gap. The diagonal proof is therefore a schema-level direction, not an
atlas-ready resolution.

## Counterexample Search

### Requirements For A False Witness

A false witness would need a class satisfying:

1. For every marginal $R$, there is an efficient weak realizable improper
   learner with some $R$-dependent inverse-polynomial gap.
2. For one original marginal $P$, no efficient marginal-nonuniform strong
   realizable improper learner exists.
3. The obstruction cannot be merely proper representation recovery, because
   the target is improper.
4. The weak learner's one-call runtime cannot depend on an unbounded hidden
   slice parameter on transcripts that also occur under a mixture marginal;
   under the atlas pathwise convention, a full-support or all-slice marginal
   would expose those transcripts. Any deterioration should live in the weak
   advantage, not in the time to find one weak handle.

### Rare-Slice Schema

The most plausible false template is a direct sum of slices:

$$
\mathcal X_s=\bigsqcup_{j\ge1}\{j\}\times X_{s,j},
\qquad
P=\sum_{j\ge1}\mu_jP_j.
$$

The intended local behavior is:

- under $P_j$, a cheap weak learner has advantage about $s^{-j}$;
- under $P_j$, strong improper learning to constant error needs about
  $s^j$ work or solves a hard search problem;
- under the mixture $P$, weak learning can ignore sufficiently small tail
  slices and still keep a $P$-dependent inverse-polynomial gap;
- but learning under $P$ to $\varepsilon\ll \mu_j$ forces solving slice $j$,
  and no one polynomial $q_P(s,1/\varepsilon)$ can absorb all such costs.

This matches the envelope obstruction, but I do not have an atlas-valid class
realizing it.

### Why Standard Witnesses Miss

- **Halfspaces.** They satisfy the target by efficient realizable proper
  learning. Lattice-style hardness only attacks agnostic targets.
- **Fixed-$k$-term DNF.** This separates weak proper from strong proper in
  distribution-free settings, but the present target is improper; classical
  boosting aggregates weak proper hypotheses into an improper vote when the
  weak parameters are uniform.
- **One-way image-coordinate and weak-handle classes.** These are nearby
  proper-output witnesses. They do not refute an improper target: the lower
  bound is about recovering a valid proper representation, while an improper
  learner can memorize sparse positive atoms or aggregate the handles.
- **PRF, LPN, noisy-parity, and random-code hard cores.** These can make strong
  prediction hard under a fixed marginal, but usually make even inverse-
  polynomial weak prediction hard on marginals concentrated on the hard core.
  That violates the source.
- **Lookup and active-slice PCP classes.** These tend either to fail the weak
  source under some marginals or to become easy for the improper target by
  table lookup on a polynomial-size active slice.

The missing object is a genuinely nonboostable weak-handle class: one
nontrivial handle is efficiently findable under every marginal, with
slice-dependent inverse-polynomial advantage, but producing enough independent
handles for low-error improper prediction is computationally hard.

## Proposed Atlas Posture

No status change is justified. I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested sharper summary:

```yaml
summary: "Open: standard realizable boosting would need one original-marginal polynomial controlling the weak advantages on booster-induced marginals. The marginal-nonuniform source gives only pointwise weak gaps for each induced marginal, and no source-positive improper counterexample is currently known."
```

Suggested body text:

```markdown
The source gives a weak realizable improper learner under every marginal, with
a marginal-dependent inverse-polynomial advantage. Classical Schapire/Freund
boosting would prove the target if, for each original marginal `P`, all
reweighted marginals generated before accuracy `epsilon` had weak advantages
bounded below by one `P`-dependent inverse polynomial. The source only gives a
separate polynomial for each induced marginal.

Full-support marginal uniformization can control the pathwise sample and
runtime bound of a fixed weak learner under the atlas worst-case transcript
convention, but it does not transfer accuracy or weak advantage between
marginals. Smooth boosting reduces the family of induced marginals to
bounded-density perturbations of `P`, yet the source does not imply a
bounded-density weak-gap envelope.

No known witness settles the edge. Cryptographic hard cores tend to violate the
weak source; proper-output witnesses do not refute the improper target; and
rare-slice constructions need a nonboostable weak-handle mechanism not
currently present in the atlas.
```

Potential reference additions if the note is expanded:

```yaml
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
```

## Promising Directions

1. Formalize the smooth-envelope lemma for one named booster: characterize the
   exact bounded-density marginals that can arise before accuracy
   $\varepsilon$, then prove or refute a $P$-dependent lower bound on their
   weak gaps.

2. Decide the atlas size-slice semantics. A size-indexed, per-slice risk
   convention may allow a diagonal proof of the needed envelope; the current
   global-mixture reading leaves the edge open.

3. Try a relativized rare-slice construction. An oracle may be the cleanest
   first place to model source-positive but nonboostable weak handles.

4. Recheck future fixed-additive agnostic boosting results for a theorem whose
   runtime is polynomial in the weak learner's own resource bound,
   $1/\gamma_P$, and $1/\varepsilon$ with no weak-parameter-dependent exponent,
   and whose oracle calls can be justified from a realizable marginal source.

## Final

verdict: unresolved-open

confidence: 0.86

## Depth 2 Followup: Smoothness, Fixed Marginals, And Rare-Block Handles

- depth: 2
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

### Sources Rechecked

- Servedio 2003, *Smooth Boosting and Learning with Malicious Noise*:
  https://jmlr.csail.mit.edu/papers/volume4/servedio03a/servedio03a.pdf
- Feldman 2010, *Distribution-Specific Agnostic Boosting*:
  https://arxiv.org/abs/0909.2927
- Ghai and Singh 2025, *Sample-Optimal Agnostic Boosting with Unlabeled Data*:
  https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice 2026,
  *Sample-Near-Optimal Agnostic Boosting with Improved Running Time*:
  https://arxiv.org/abs/2601.11265

### Smooth Boosting Does Not Remove The Marginal Change

Smooth boosting is the right positive thing to check, because it limits how
hard the booster can focus on a small residual set. Servedio's SmoothBoost
constructs distributions on the sample with an explicit $\ell_\infty$ cap:
for final empirical error parameter $\kappa$, each booster distribution puts
weight at most about $1/(\kappa m)$ on any one of the $m$ sample points. Its
round bound still depends polynomially on the weak advantage, roughly as
$1/(\kappa\gamma^2)$.

Translated back to the population marginal, this says that a smooth booster
only asks for weak learning on marginals $Q$ with bounded density

$$
\frac{dQ}{dP}\lesssim B,\qquad B=\operatorname{poly}(1/\varepsilon).
$$

This gives a clean conditional positive theorem:

$$
\Gamma_P(B,s)
=\inf\{\gamma_Q(s):Q\ll P,\ dQ/dP\le B\}
\ge \frac{1}{r_P(s,B)}
$$

for one polynomial $r_P$ would be enough. Full-support transcript
uniformization would then control the weak learner's running time, and
SmoothBoost or a standard smooth variant would give an improper vote with
error at most $\varepsilon$.

The source definition still does not imply this envelope. A bounded-density
family can contain conditionals on rare blocks of mass about $1/B$, and the
weak gap on those conditionals can have degree depending on the block. Smooth
boosting therefore postpones the bad marginal until the density cap permits
it; it does not convert pointwise guarantees

$$
\forall Q\ \exists r_Q
$$

into the needed local-uniform guarantee

$$
\forall P\ \exists r_P\ \forall Q\in\mathcal Q(P,\varepsilon).
$$

This is also where full-support uniformization stops. It can make one
worst-case transcript-time polynomial visible by applying the source learner
to a full-support reference marginal. It does not say that the hypothesis
returned on a $Q$-distributed weak call has any advantage that is controlled
by the original marginal $P$.

### Same-Marginal Reductions Are Still Near Misses

The same-marginal agnostic line is attractive because Feldman-style
distribution-specific boosting keeps the instance marginal fixed and changes
only the labels. That would avoid the whole $Q\ll P$ envelope if the source
were an oracle for the resulting relabeled distributions.

For this edge, the source is only realizable. A same-marginal relabeling
usually creates labels whose conditional expectation is not a concept in
$\mathcal C$, so the weak realizable learner has no promised behavior on that
call. One can try to encode focusing by keeping $X\sim P$ and drawing

$$
\mathbb E[Y\mid X=x]=a(x)c(x),
\qquad 0\le a(x)\le 1,
$$

but this is an agnostic/noisy oracle call, not a realizable one. The current
source gives no guarantee for it.

Even if the source were strengthened to the atlas fixed-additive weak agnostic
form, the published same-marginal results remain quantitative near misses.
Feldman and the Ghai-Singh line need the weak-oracle slack or threshold tuned
at the final accuracy scale. The 2026 da Cunha-Hogsgaard-Paudice theorem is
closer because it can use a nontrivial fixed-additive agnostic weak learner,
but its explicit runtime has weak-parameter-dependent exponents, for example
terms of the form

$$
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$

In the atlas source, $m_0$ and $1/\theta$ may themselves be
$P$-dependent polynomials in the representation size. Substituting them into
the exponent does not give a polynomial in
$(s,1/\varepsilon,\log(1/\delta))$.

So the fixed-marginal literature sharpens the desideratum but does not prove
this realizable-improper edge. A positive theorem would need either a
realizable same-marginal transformation whose labels remain in $\mathcal C$,
or a parameter-efficient agnostic booster whose runtime is polynomial in
$m_0$, $1/\theta$, and $1/\varepsilon$ rather than polynomial with those
quantities in the exponent.

### Concrete Rare-Block Handle Candidate

The first-pass "rare slice" idea can be made more concrete for this exact
improper edge. The source is improper, so the weak handles do not have to be
members of $\mathcal C$. They can be external singleton hypotheses found from
samples.

Consider a block instance space

$$
B_{n,j}=\{(n,j,i):i\in[N_{n,j}]\},
\qquad N_{n,j}=n^j.
$$

For a cryptographic version, let $F_k$ be a pseudorandom function family and
define the target concepts

$$
c_{n,j,k}(n',j',i)=
\begin{cases}
F_k(i), & (n',j')=(n,j),\\
0, & \text{otherwise.}
\end{cases}
$$

An oracle version can replace $F_k$ by an independently random balanced block
labeling. The oracle version gives the clean information-theoretic picture;
the PRF version is the plausible computational witness.

The weak learner is uniform and simple:

1. draw samples in stages of increasing polynomial size;
2. validate the all-zero hypothesis, the all-one hypothesis, and singleton
   hypotheses for labeled positive sample points;
3. stop when validation certifies error below $1/2$ by the current guessed
   inverse-polynomial margin.

Why this plausibly satisfies the source for every marginal $R$:

- If the target's positive mass under $R$ is not close to $1/2$, one of the
  constants has a constant weak advantage.
- If the positive mass is close to $1/2$, then the active block must carry
  constant $R$-mass. There are only finitely many such heavy blocks for a
  fixed $R$.
- On a heavy active block $B_{n,j}$, some positive atom has mass at least
  $\Omega(1/N_{n,j})$. Sampling and validation find a useful singleton in
  time polynomial in $N_{n,j}$.

Thus, for each fixed marginal $R$, the largest relevant heavy-block exponent
$j$ can be absorbed into the marginal-dependent polynomial. The weak advantage
can be as small as $n^{-j}$ on the block marginal, but that is still inverse
polynomial with a degree depending on $R$.

### Fixed Marginal For Target Failure

Now define one original marginal

$$
P(B_{n,j})=w_{n,j}=Z^{-1}2^{-j}n^{-2},
$$

uniformly inside each block. For target $c_{n,j,k}$, request

$$
\varepsilon_{n,j}=w_{n,j}/16.
$$

Any hypothesis with $P$-error at most $\varepsilon_{n,j}$ must have conditional
error at most $1/16$ on $B_{n,j}$. A singleton handle is far from enough: it
explains one atom, while the target contains a pseudorandom or oracle-random
labeling over $N_{n,j}=n^j$ atoms.

For the oracle-random block version, a standard no-free-label argument gives a
sample lower bound of order

$$
\Omega(N_{n,j}/w_{n,j})=\Omega(2^j n^{j+2})
$$

to learn a constant fraction of the active block labels from $P$-samples.

Let $q_P$ be any proposed target polynomial, and let $D$ be its total degree.
For fixed $j$,

$$
q_P(s,1/\varepsilon_{n,j},O(1))\le C_j n^{O(D)}.
$$

Choosing $j$ larger than this degree makes the oracle lower bound exceed
$q_P$ for all large $n$. The hard marginal $P$ contains every level $j$, so no
single $P$-dependent polynomial degree can cover all requested accuracies.

For the PRF version, the same shape becomes a conditional computational lower
bound. If a $P$-polynomial strong learner existed, choose a level $j$ above
the degree of its polynomial. Running the learner on the target
$c_{n,j,k}$ and then evaluating its output on a fresh point from $B_{n,j}$
would predict the PRF on random inputs with constant advantage in time
polynomial in $n$ for that fixed $j$. This contradicts standard PRF security,
provided the representation/evaluation conventions are made explicit.

This candidate defeats improper output. The final learner may output an
arbitrary table, vote, or circuit, but under the hard marginal it still has to
predict many unseen pseudorandom labels inside the active block. The cheap
weak handle is intentionally nonboostable: it gives one atom of advantage, not
a reusable rule for the residual.

### Why This Is Not Yet An Atlas Status Change

This is the strongest false route I found in this pass, and it is more
concrete than the first-pass rare-slice schema. Still, I would not update the
edge note from `open` without a full writeup, because several details need to
be nailed down:

1. Specify a PRF family with the needed variable input lengths and a
   representation-size convention where evaluating $c_{n,j,k}$ is polynomial
   in the concept size.
2. Prove the staged constants-plus-singletons learner satisfies the source
   for every marginal $R$, including the validation and stopping-time
   bookkeeping.
3. State the target lower bound as a standard reduction from strong learning
   under the fixed $P$ to predicting the PRF on fresh random block inputs.
4. Check compatibility with the atlas hypothesis-output convention: the
   reduction needs to evaluate the learner's final improper hypothesis.

If those details work, the edge should likely become `false` under a
cryptographic assumption. Until they are written cleanly, the atlas-safe
verdict remains open.

### Depth 2 Verdict

verdict: unresolved-open

confidence: 0.78

The confidence is lower than in the first pass because the rare-block PRF
construction now looks like a plausible conditional counterexample, not just a
vague obstruction. Smooth boosting and same-marginal reductions still do not
provide the missing $P$-dependent weak-gap envelope.

## Depth 3 Followup: Rare-Block PRF Route, With Oracle-Clean Version

- depth: 3
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

### Depth 3 Verdict

The rare-block route can be formalized as a conditional false witness, at
least relative to a random oracle. Under standard PRF assumptions, and hence
under one-way functions via the usual PRG-to-PRF chain, the same construction
also gives a computational false witness provided the atlas uses the standard
efficient-hypothesis convention: an efficient improper learner outputs a
hypothesis that can be evaluated in polynomial time from its printed
representation.

I would still not call this atlas-ready in the current pass, because that
hypothesis-output convention is implicit rather than stated in the two
definition notes read above. The oracle version does not need that convention
and is the cleanest formal core. The PRF version is ready once the atlas says
that efficient improper hypotheses are efficiently evaluable, or once the
lower-bound argument is recorded purely as a sample lower bound in an oracle
model.

### Construction

Fix a PRF family $F_k:\{0,1\}^n\to\{0,1\}$ with key length $n$. For the oracle
version, replace $F_k(u)$ by an independent random-oracle bit
$O(n,j,k,u)$.

For each $n$ and block level

$$
1\le j\le J(n)=\left\lfloor\frac{n}{4\log n}\right\rfloor,
$$

let $U_{n,j}$ be the first $N_{n,j}=n^j$ strings of length $n$. The instance
block is

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\}.
$$

The concept $c_{n,j,k}$ is active on exactly one block:

$$
c_{n,j,k}(n',j',u,b)=1
\quad\Longleftrightarrow\quad
(n',j')=(n,j),\ u\in U_{n,j},\ b=F_k(u),
$$

and it is $0$ outside $B_{n,j}$. The paired bit $b$ makes every active block
perfectly balanced under the uniform block marginal: exactly one of
$(u,0),(u,1)$ is positive for each $u$.

For each fixed $j$, the representation size is $s=\Theta(n)$; more generally
$s=\Theta(n+j)$. The restriction $j\le J(n)$ keeps $U_{n,j}$ inside
$\{0,1\}^n$ while still allowing every fixed block level $j$ needed for the
diagonal lower bound.

### Source Proof

Goal: prove efficient marginal-nonuniform weak realizable improper PAC
learning.

The uniform weak learner uses only constants and sample-found singleton
handles:

1. Run staged sample sizes.
2. On each stage, form candidates $0$, $1$, and $h_x=\mathbf 1[x=\cdot]$ for
   every observed positive example $x$.
3. Use fresh validation data to choose a candidate whose empirical error is
   below $1/2$ by the current guessed margin.

Why this works for every fixed marginal $R$:

Let $B$ be the active block of the target and let

$$
M=R(\{x:c(x)=1\}).
$$

The constant hypotheses have errors $M$ and $1-M$. Thus if
$|M-1/2|$ is nontrivial, one constant is already weak.

The only possible problem is $M\approx 1/2$. In that case $R(B)\ge M\approx
1/2$, so $B$ must be one of the finitely many blocks with $R(B)\ge 1/3$.
For those finitely many blocks, the block size $|B|=2N_{n,j}$ is a finite
$R$-dependent constant. For any binary labeling on such a finite block, the
best of the two constants and a positive singleton has advantage at least
on the order of $1/|B|$: if $M$ is within $1/(6|B|)$ of $1/2$, a heaviest
positive atom has mass at least about $M/|B|$ and the corresponding singleton
beats random guessing; otherwise a constant does.

Since there are only finitely many $R$-heavy blocks, the smallest of these
advantages is a positive $R$-dependent constant. Sampling and validation find
the needed constant or singleton with sample and time bounded by an
$R$-dependent polynomial in $s$ and $\log(1/\delta)$. Blocks that are not
$R$-heavy are handled by the all-zero constant with constant advantage.

So the source is satisfied. Notice the proof uses the current global-mixture
reading of a marginal. Under a size-indexed per-slice marginal convention, a
family that is uniform on $B_{n,j(n)}$ with unbounded $j(n)$ would break this
argument, because the singleton advantage $n^{-j(n)}$ need not be inverse
polynomial in $s$ with fixed degree.

### Fixed Marginal For Target Failure

Define one fixed marginal $P$ by putting mass

$$
w_{n,j}=Z^{-1}2^{-j}n^{-2}
$$

on $B_{n,j}$, uniformly over the $2N_{n,j}$ atoms in that block. The normalizer
$Z$ is finite because $\sum_n n^{-2}\sum_j2^{-j}<\infty$.

For target $c_{n,j,k}$, request

$$
\varepsilon_{n,j}=w_{n,j}/64.
$$

Then $1/\varepsilon_{n,j}=\Theta(2^j n^2)$ for fixed $j$. Any hypothesis with
$P$-error at most $\varepsilon_{n,j}$ has conditional error at most $1/64$ on
the active block $B_{n,j}$, and therefore predicts $F_k(u)$ on a fresh
$u\sim U_{n,j}$ with probability at least $63/64$ by evaluating the hypothesis
on the pair $(u,0),(u,1)$ and using the better-labeled bit.

Now suppose the target learner existed for this fixed $P$, with marginal
polynomial $q_P$. Let $D$ be a total degree bound for $q_P$. Choose a constant
block level

$$
j>4D+10.
$$

For this fixed $j$ and large $n$,

$$
q_P(s,1/\varepsilon_{n,j},O(1))\le C_j n^{3D}.
$$

The expected number of active-block examples seen by such a run is at most

$$
C_j n^{3D}w_{n,j}
=O_j(n^{3D-2}),
$$

whereas the active block contains $N_{n,j}=n^j$ independent input indices.
Thus the learner sees $o(N_{n,j})$ active indices.

### Oracle Lower Bound

In the random-oracle version, condition on all non-active samples and on the
set $S$ of active indices seen during training. For every unseen
$u\notin S$, the bit $O(n,j,k,u)$ is independent of the learner's output,
even if the learner uses arbitrary computation after seeing the samples. Hence
any output hypothesis has expected prediction success at most

$$
\frac12+\frac{|S|}{2N_{n,j}}
$$

on a fresh active index. Since $\mathbb E|S|=o(N_{n,j})$, the success
probability is $1/2+o(1)$, contradicting the $63/64$ success forced by
$P$-error at most $w_{n,j}/64$.

This gives a clean oracle separation: relative to a random oracle, the source
holds but the target fails for the fixed marginal $P$.

### PRF/One-Way Version

For the PRF version, use the same fixed $P$ and the same diagonal choice of
$j$ above the alleged polynomial degree. A strong learner for $P$ would yield
a predictor for unseen PRF labels on the set $U_{n,j}$:

1. simulate labeled examples from $P$, using oracle access to either
   $F_k(\cdot)$ or a truly random function on active-block examples;
2. run the assumed strong learner at accuracy $w_{n,j}/64$;
3. from its output hypothesis $h$, predict a fresh $F_k(u)$ by comparing
   $h(n,j,u,0)$ and $h(n,j,u,1)$.

In the PRF world, the learner's guarantee gives constant prediction advantage.
In the random-function world, the no-free-label calculation above gives only
$1/2+o(1)$ success because the learner sees $o(N_{n,j})$ active indices. This
distinguishes the PRF from a random function in polynomial time, contradicting
standard PRF security.

The cryptographic assumption can be stated either directly as existence of
secure PRFs, or as existence of one-way functions together with the standard
constructions: Goldreich-Goldwasser-Micali construct PRFs from PRGs, and
Hastad-Impagliazzo-Levin-Luby give PRGs from one-way functions. Kearns-Valiant
is the learning-theoretic cryptographic-hardness anchor already used elsewhere
in the atlas.

The only remaining convention-sensitive point is evaluation of the final
improper hypothesis. The reduction needs to compute $h(n,j,u,0)$ and
$h(n,j,u,1)$ in polynomial time. This is standard for efficient PAC learning,
since the learner's output is normally a polynomial-time evaluable hypothesis,
but the present definition notes only say "outputs a hypothesis" and bound
the learner's sample use and running time. If the atlas deliberately allows
efficient learners to print opaque, non-evaluable hypothesis representations,
the PRF reduction is not formally stated. The oracle sample lower bound still
captures the intended obstruction.

### Refutation Checks

The earlier concern that $1/\varepsilon$ might absorb the rare block is not a
real obstruction. For fixed $j$,

$$
1/\varepsilon_{n,j}=\Theta(2^j n^2),
$$

so any fixed polynomial in $s$ and $1/\varepsilon$ has only a fixed power of
$n$. The unseen-label burden is $N_{n,j}=n^j$. Choosing $j$ above the polynomial
degree leaves an asymptotic gap.

The earlier concern that singleton handles might be boostable is exactly what
the construction blocks. A singleton gives advantage about $1/N_{n,j}$ on the
active block, but after that atom is removed the residual labels are still
pseudorandom or oracle-random. Boosting by repeatedly finding such handles
requires seeing polynomially many active atoms in $N_{n,j}$, and for the fixed
mixture marginal no one $P$-dependent polynomial in $(s,1/\varepsilon)$ can
cover all block levels $j$.

### Depth 4 Directions

1. Make the witness note atlas-ready by specifying the concept representation,
   allowed block levels $j\le J(n)$, and the efficient evaluator for
   $c_{n,j,k}$.
2. Decide and record the hypothesis-output convention for efficient improper
   PAC learning. If hypotheses are required to be efficiently evaluable, the
   PRF/one-way version should be usable as a conditional counterexample.
3. If the atlas wants to avoid that convention, record the random-oracle
   version first: it gives the same source-positive/target-negative behavior
   by a direct no-free-label sample lower bound.
4. Check all outgoing implications that would inherit this witness; the
   construction is tailored to weak-to-strong improper marginal boosting, not
   to properization, and should not be copied blindly into proper-output
   edges.

### Depth 3 Final

verdict: conditionally-false route formalized; atlas status should remain
`open` until the witness and hypothesis-evaluation convention are written
cleanly.

confidence: 0.74 for the PRF/one-way counterexample under standard efficient
hypothesis evaluation; 0.82 for the random-oracle separation.

## Depth 4 Followup: Efficient-Hypothesis Convention Audit

- depth: 4
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

### Question For This Pass

Decide whether the depth-3 PRF route is ready to move into the atlas, given
that the route needs to evaluate the final improper hypothesis output by an
efficient learner.

### Local Convention Audit

Files and patterns checked:

- `atlas/README.md`
- all `atlas/definitions/efficient-*.md` and
  `atlas/definitions/sample-efficient-*.md` definition notes
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- this edge note

The README says computationally efficient nodes require polynomial sample
complexity and polynomial running time, and that those resource bounds are
worst-case/pathwise bounds on finite encoded sample transcripts. This is
important and already supports the transcript side of the rare-block
argument.

The definition notes say an efficient learner "outputs a hypothesis" and then
bound sample complexity and running time. I found no explicit convention using
terms such as `evaluable`, `evaluate`, `prediction time`, or `hypothesis
representation` for final improper hypotheses. The proper notes can often lean
on the benchmark class representation, but the improper notes do not say that
an output outside $\mathcal C$ comes with a polynomial-time prediction
procedure.

Existing cryptographic witness notes also implicitly use efficient prediction:
the PRF witness says no randomized polynomial-time learner can weakly learn
because such a learner would distinguish pseudorandom functions from random
labelings. That is the standard PAC reading, but it is not spelled out as a
global atlas convention.

### Atlas-Readiness Verdict

The PRF route is not quite atlas-ready under the definitions exactly as
written. The depth-3 construction is mathematically ready modulo one standard
convention:

> An efficient improper PAC learner must output a finite hypothesis
> representation whose prediction on encoded instances is computable in
> polynomial time.

Without that convention, the PRF reduction has a formal gap. The distinguisher
must run the alleged strong learner and then compute

$$
h(n,j,u,0),\qquad h(n,j,u,1)
$$

on a fresh active-block input. If "outputs a hypothesis" allowed an opaque
object that cannot be evaluated by the reduction, the learner's training-time
bound alone would not give a polynomial-time PRF predictor.

I do not think this is a substantive mathematical obstacle. It is a schema
clarity issue. In ordinary computational PAC learning, the learner's output is
a usable hypothesis representation; otherwise the risk statement
$\operatorname{err}_P(h,c)$ is computationally detached from the claimed
efficient learner. But because this atlas is explicit about pathwise sample
and training-time bounds, the evaluator convention should be made equally
explicit before changing this edge to `false`.

### Minimal Clarification That Would Unblock The PRF Route

The smallest atlas-level clarification would be a short convention in
`atlas/README.md`, preferably near the existing computational-efficiency
paragraph:

```markdown
For computationally efficient nodes, the learner outputs a finite encoded
hypothesis representation. Unless a definition explicitly says otherwise, the
output representation includes a uniform prediction procedure, and evaluating
the output hypothesis on an encoded instance must run in time polynomial in
the instance length and the output length. Since the output length is bounded
by the learner's pathwise running time, this preserves the stated polynomial
PAC resource bound. Improper learning only removes the requirement that the
output hypothesis lie in the benchmark class; it does not permit opaque or
non-evaluable hypotheses.
```

This is enough for the rare-block PRF lower bound. On a successful run of a
putative target learner, the printed hypothesis has length at most
$q_P(s,1/\varepsilon,\log(1/\delta))$. For fixed block level $j$, this is
polynomial in $n$. A polynomial-time evaluator in the output length and input
length is therefore also polynomial in $n$, so the PRF distinguisher is an
ordinary polynomial-time algorithm.

If the atlas wants the clarification closer to the result instead of global
README text, a minimal argument-note assumption would be:

```yaml
assumptions:
  - secure pseudorandom functions exist
  - efficient improper PAC hypotheses are polynomial-time evaluable from their printed representations
```

That would keep the current definition notes untouched but make the exact
extra convention visible on the edge family.

### Minimal Argument-Note Shape

Once the evaluator convention is accepted, the depth-3 construction can be
converted into an atlas argument note with roughly this contract:

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions:`
  - `secure pseudorandom functions exist`
  - or `one-way functions exist`, citing the GGM/HILL route already covered by
    `goldreich1986` and `hastad1999prg`
- `witnesses:`
  - a new rare-block PRF singleton-handle witness

The proof should be written as three lemmas.

**Construction.** Use active blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j}, b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

with $j\le \lfloor n/(4\log n)\rfloor$. A key $k$ defines one active block
labeling by

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

and all other blocks are labeled zero.

**Source positivity.** The weak learner tries constants and sample-found
positive singletons. For every fixed marginal $R$, all non-heavy active blocks
are handled by a constant. Only finitely many blocks can be heavy under $R$,
so the worst singleton-search exponent over those blocks is absorbed into the
$R$-dependent polynomial. Validation and staged guesses make the learner
uniform.

**Target failure.** Fix

$$
P(B_{n,j})=Z^{-1}2^{-j}n^{-2}
$$

uniformly inside blocks, request $\varepsilon=w_{n,j}/64$, and let $q_P$ be
the alleged target polynomial. Choose a constant $j$ larger than the degree of
$q_P$. The learner then sees $o(n^j)$ active indices. Low $P$-error would let
the evaluator predict $F_k(u)$ on a fresh $u\in U_{n,j}$ with constant
advantage, while a random-function hybrid gives only $1/2+o(1)$ success. This
distinguishes the PRF from a random function.

### Why The Random-Oracle Version Is Still Useful

The random-oracle version is atlas-useful as a sanity check because it avoids
cryptographic reductions and opaque hypothesis-output worries about PRF
security. It proves the same source-positive/target-negative shape by a pure
no-free-label calculation: after seeing $o(n^j)$ active indices, no output,
even one produced with unbounded postprocessing, predicts unseen random oracle
labels on the active block.

I would not use it alone to flip the atlas edge in the standard graph unless
the atlas explicitly accepts relativized/oracle evidence as a false witness.
It is better as the formal core that the PRF proof derandomizes under standard
cryptographic assumptions once output evaluation is explicit.

### Depth 5 Directions

1. Decide where to record the evaluator convention. Preferred minimal edit:
   one README convention paragraph applying to all computationally efficient
   nodes. Alternative: add the convention as an explicit assumption on the new
   rare-block PRF argument note.

2. Draft a new witness note for the rare-block PRF singleton-handle class.
   Include the block domain, the bound $j\le \lfloor n/(4\log n)\rfloor$, the
   representation-size convention $s=\Theta(n+j)$, and the polynomial-time
   evaluator for $c_{n,j,k}$.

3. Write the source lemma in top-down form. First prove constants-or-singleton
   advantage on one finite active block; then lift it to every marginal $R$ by
   separating non-heavy blocks from the finitely many $R$-heavy blocks; finally
   add staged sample sizes and validation to make one uniform weak learner.

4. Write the PRF lower-bound lemma with the evaluator convention stated before
   the reduction. Show explicitly that low block-conditional error gives a
   predictor from the pair
   $(h(n,j,u,0),h(n,j,u,1))$, with arbitrary tie handling losing only a
   constant factor.

5. Update this edge only after the witness and argument note are complete:
   proposed status would be `false`, evidence `conditional-counterexample`,
   assumptions `secure pseudorandom functions exist` or `one-way functions
   exist`, and witness the new rare-block PRF singleton-handle class. Check
   neighboring weak-to-strong improper marginal edges separately before
   reusing the witness.

### Depth 4 Final

verdict: not atlas-ready yet; PRF route is ready after a minimal
efficient-hypothesis-evaluation clarification and a dedicated witness/argument
note.

confidence: 0.81 that the only atlas-readiness blocker is the missing
evaluator convention; 0.76 that the edge should become conditionally false
after that clarification and a clean witness writeup.

## Depth 5 Followup: Clarification-Plus-Witness Decision

- depth: 5
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

### Depth 5 Decision

Propose an atlas clarification plus a dedicated rare-block PRF witness note.
Do not treat the edge as merely generically open anymore. The depth-3 and
depth-4 passes have reduced the obstacle to a standard computational PAC
convention: an efficient improper learner's printed hypothesis must be
polynomial-time evaluable.

Operationally, because this pass is scratchpad-only and no atlas convention or
witness note has actually been added, the current edge should still remain
`open` in the atlas. The recommended next atlas state is:

- after a global evaluator clarification: change this edge to `false`;
- evidence: `conditional-counterexample`;
- assumptions: `secure pseudorandom functions exist`;
- witnesses: a new rare-block PRF singleton-handle class;
- refs: at least `goldreich1986` and `kearns1994cryptographic`, with
  `hastad1999prg` if the assumption is phrased as one-way functions.

If the atlas maintainers do not want a global convention, the fallback is to
keep the evaluator requirement as an explicit assumption on the new argument
note:

```yaml
assumptions:
  - secure pseudorandom functions exist
  - efficient improper PAC hypotheses are polynomial-time evaluable from their printed representations
```

That fallback is logically adequate for this edge, but it is less clean than a
global convention because existing cryptographic witness notes already rely on
the same standard reading when they say that a polynomial-time learner would
distinguish pseudorandom labels from random labels.

### Why This Should Be A Proposal, Not A Permanent Open Verdict

The original open-edge obstruction was the lack of a $P$-dependent weak-gap
envelope over booster-induced marginals. The rare-block PRF construction turns
that obstruction into a candidate counterexample rather than just a proof
barrier:

1. For every marginal $R$, constants plus sample-found positive singletons
   give a uniform weak learner with an $R$-dependent inverse-polynomial
   advantage. Heavy difficult blocks are only finitely many for fixed $R$,
   so their singleton-search exponents can be absorbed into the
   marginal-dependent polynomial.
2. For one fixed mixture marginal $P$, strong learning an active block
   $B_{n,j}$ to error $w_{n,j}/64$ requires predicting many unseen labels in
   a block of size $n^j$.
3. Given an alleged marginal-nonuniform strong learner with polynomial
   $q_P$, choose a fixed block level $j$ larger than the degree of $q_P$.
   The learner sees only $o(n^j)$ active indices, so low error would yield a
   predictor for unseen PRF values.
4. The only thing the PRF distinguisher needs beyond the printed learner
   output is the ability to evaluate that output on fresh pairs
   $(n,j,u,0)$ and $(n,j,u,1)$ in polynomial time.

Thus the mathematical content points toward a conditional `false` edge. The
remaining issue is a schema convention, not a missing learning-theoretic
ingredient.

### Proposed Atlas Payload

The least invasive atlas payload should be two or three notes plus this edge
update.

First, add a computational-output convention, preferably in `atlas/README.md`
near the existing paragraph saying that computationally efficient nodes have
pathwise polynomial running-time bounds:

```markdown
For computationally efficient nodes, the learner outputs a finite encoded
hypothesis representation. Unless a definition explicitly says otherwise, the
output representation includes a uniform prediction procedure, and evaluating
the output hypothesis on an encoded instance must run in time polynomial in
the instance length and the output length. Improper learning only removes the
requirement that the output hypothesis lie in the benchmark class; it does
not permit opaque or non-evaluable hypotheses.
```

Second, add a witness note, tentatively
`atlas/witnesses/rare-block-prf-singleton-handle-class.md`, with:

- blocks $B_{n,j}=\{(n,j,u,b):u\in U_{n,j}, b\in\{0,1\}\}$;
- $|U_{n,j}|=n^j$ and $1\le j\le\lfloor n/(4\log n)\rfloor$;
- concepts $c_{n,j,k}$ with
  $c_{n,j,k}(n',j',u,b)=1$ iff $(n',j')=(n,j)$ and $b=F_k(u)$;
- zero labels outside the active block;
- representation size $s=\Theta(n+j)$;
- a polynomial-time proper evaluator given $(n,j,k)$ and an encoded instance.

Third, add an argument note, tentatively
`atlas/arguments/rare-block-prf-singleton-handle-hardness.md`, proving:

- source positivity by constants and observed positive singleton handles,
  lifted from one active block to every fixed marginal $R$;
- target failure under
  $P(B_{n,j})=Z^{-1}2^{-j}n^{-2}$, uniformly inside each block;
- the PRF hybrid showing that a strong learner for $P$ would distinguish a PRF
  from a random function after evaluating the learned hypothesis on fresh
  active-block pairs.

Then update only this edge, not the whole marginal-boosting family by default.
The edge summary could be:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - secure pseudorandom functions exist
witnesses:
  - rare-block-prf-singleton-handle-class
summary: "False under PRF security: rare active blocks have marginal-nonuniform weak singleton handles, but strong learning under one fixed mixture marginal would predict unseen pseudorandom labels."
```

If the evaluator convention is not made global, add the evaluator assumption
explicitly to `assumptions`.

### Residual Checks Before Atlas Edit

There are still mechanical checks that should happen before changing graph
metadata:

- Verify that the source weak learner is one uniform algorithm, not an
  $R$-specific algorithm. The $R$-dependence should enter only through the
  existence of a successful stage and a hidden polynomial bound.
- Write the finite-heavy-block lemma carefully. For fixed $R$, blocks with
  mass at least a constant threshold are finite; all other active targets are
  weakly handled by a constant because their total positive mass is bounded
  away from $1/2$.
- State the quantifier order in the target lower bound: after fixing the
  alleged target learner and fixed marginal $P$, let $q_P$ be its hidden
  polynomial, choose constant $j$ above its degree, then take $n\to\infty$.
- In the PRF reduction, the learner's samples from the fixed marginal $P$ must
  be simulable in polynomial time for the chosen active target. This is
  immediate because the reduction can sample $(n',j',u,b)$ from the explicit
  mixture and label only the active block using the PRF oracle, with all other
  blocks labeled zero.
- Do not use the random-oracle variant as the atlas witness unless oracle
  evidence is accepted as graph-level evidence. It should remain a diagnostic
  proof core for the PRF hybrid.

### Depth 6 Directions

If this remains unresolved after depth 5, the next pass should move from
decision to drafting:

1. Draft the exact README convention or the exact per-argument evaluator
   assumption, and decide which one the atlas should accept.
2. Draft `rare-block-prf-singleton-handle-class.md` with frontmatter, role,
   construction, source behavior, target obstruction, and references.
3. Draft `rare-block-prf-singleton-handle-hardness.md` with three top-down
   lemmas: weak source lemma, fixed-marginal lower-bound setup, and PRF
   distinguisher.
4. Update only
   `efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
   to conditional `false`, unless a separate audit justifies propagating the
   witness to neighboring weak-to-strong improper marginal edges.
5. Run the repository frontmatter, citation-key, graph-completeness, and
   status-count checks. Do not run LaTeX.

### Depth 5 Final

verdict: propose atlas clarification plus a dedicated rare-block PRF witness
and argument note; keep the live atlas edge `open` until those files are
actually written.

confidence: 0.84 that the correct next action is the clarification-plus-witness
proposal; 0.78 that the edge should become conditionally `false` once the
evaluator convention and witness proof are installed.

## Depth 6 Final Followup: Current-Convention Incorporation Decision

- depth: 6
- date: 2026-05-05
- worker constraint: appended only to this scratchpad; no atlas files edited
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

### Final Decision

Under the current atlas conventions, the rare-block PRF singleton-handle
witness should **not** be incorporated as a `false` edge yet. The live edge
should stay `open`, with a note that the candidate counterexample is blocked
only by an evaluator/output-semantics clarification.

The decisive point is not the weak-source lemma or the rare-block diagonal;
those are now coherent enough to draft. The blocker is semantic. The current
`atlas/README.md` says that computationally efficient nodes require polynomial
sample complexity and polynomial running time, with pathwise bounds on finite
encoded sample transcripts. The definition notes say that the learner outputs
a hypothesis $h$. They do not explicitly say that an improper output comes
with a uniform polynomial-time prediction procedure.

The PRF lower bound needs exactly that missing statement. After an alleged
strong marginal-nonuniform learner outputs $h$, the reduction must evaluate
$h(n,j,u,0)$ and $h(n,j,u,1)$ on fresh active-block points to predict
$F_k(u)$. Without a polynomial-time evaluator for the printed hypothesis, low
semantic error under $P$ does not automatically become a polynomial-time PRF
distinguisher.

Adding the evaluator requirement as a one-off assumption on this edge would be
logically understandable, but it would not be incorporation under the current
atlas conventions. It would change the local meaning of the efficient target.
The cleaner atlas move is to first add a global computational-output
convention, or else explicitly mark a new argument note as depending on that
extra evaluator convention.

### Atlas-Ready Update Text For The Current Edge

Use this if updating the edge without changing atlas conventions:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open under current atlas conventions: a rare-block PRF singleton-handle construction is a plausible conditional counterexample, but the PRF reduction requires an explicit convention that efficient improper outputs are polynomial-time evaluable."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested body replacement or addendum:

```markdown
**Current best candidate.** A rare-block PRF singleton-handle class appears to
give the right separation shape. Constants and sample-found positive
singletons give marginal-nonuniform weak realizable improper learning under
every fixed marginal: non-heavy active blocks are handled by constants, while
only finitely many heavy blocks remain for a fixed marginal, so their
singleton-search costs are absorbed into the marginal-dependent polynomial.
For a fixed mixture marginal over blocks, a strong learner with one
$P$-dependent polynomial would, at a block level above that polynomial's
degree, have to predict many unseen pseudorandom labels.

**Why this is not yet a false edge.** The PRF lower bound turns low error into
a distinguisher by evaluating the learner's output hypothesis on fresh
active-block pairs. The current atlas conventions bound the learner's
training-time/output-time behavior on finite encoded sample transcripts, but
do not explicitly require polynomial-time evaluation of arbitrary improper
hypothesis outputs. Until that evaluator convention is made global, or is
recorded as an explicit extra assumption on a new argument note, the witness
should be treated as a candidate rather than an atlas-level
conditional-counterexample.

**Conclusion.** Keep the edge `open`. The next schema clarification to resolve
before changing status is: efficient improper PAC outputs are finite encoded
hypotheses with a uniform prediction procedure running in time polynomial in
the instance length and output length.
```

### Post-Clarification Payload

If the evaluator convention is added globally, the same construction should be
eligible for an atlas `false` update:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - secure pseudorandom functions exist
witnesses:
  - rare-block-prf-singleton-handle-class
summary: "False under PRF security: rare active blocks have marginal-nonuniform weak singleton handles, but strong learning under one fixed mixture marginal would predict unseen pseudorandom labels."
```

If the convention is not made global, the local false update should add a
second assumption:

```yaml
assumptions:
  - secure pseudorandom functions exist
  - efficient improper PAC hypotheses are polynomial-time evaluable from their printed representations
```

### Final Verdict

verdict: keep the atlas edge `open` under current conventions; do not
incorporate the rare-block PRF singleton-handle witness as a `false` edge until
the evaluator convention is clarified.

confidence: 0.89 that the edge must remain `open` under the current written
conventions; 0.80 that the rare-block PRF singleton-handle witness can become
a conditional `false` edge after a global evaluator clarification and a clean
witness/argument note.
