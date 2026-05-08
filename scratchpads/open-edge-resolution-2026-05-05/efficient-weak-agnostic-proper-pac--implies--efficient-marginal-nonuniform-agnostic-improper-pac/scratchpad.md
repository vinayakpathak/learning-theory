# Edge: efficient-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac

Date: 2026-05-05

Assigned edge:
`atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`

Worker constraint: atlas files were read only; the only repo file written in
this pass is this scratchpad.

## Verdict First

I do not resolve the edge. My recommendation is to keep it open.

The main update is diagnostic: for this specific edge, the usual
``boosting changes the marginal'' objection is not the main obstruction. The
source learner is distribution-free, so any ordinary reweighted weak-learner
call would still have the same distribution-free polynomial resource bound.
The real obstruction is the fixed-additive agnostic weak guarantee.

Properness helps clean up the oracle interface: the weak hypotheses are in
the comparator class `C`, and the target allows an improper final vote over
them. But properness does not supply the tunable threshold/correlation slack
needed by Feldman/Ghai-style efficient boosters, and it does not remove the
large parameter exponents in the da Cunha-Hogsgaard-Paudice fixed-slack
booster.

## Sources Checked

Local atlas files:

- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/conjunction-agnostic-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- nearby May 4 and May 5 scratchpads for the distribution-free strong target,
  the improper-source sibling edge, and the marginal weak-to-strong sibling edge
- `references.bib`

Primary or bibliographic sources checked online:

- Ben-David, Long, Mansour, "Agnostic Boosting" (2001),
  https://doi.org/10.1007/3-540-44581-1_33. The DOI metadata summarizes the
  beta-weak agnostic learner and the older non-strong final guarantee.
- Feldman, "Distribution-Specific Agnostic Boosting" (2010),
  https://arxiv.org/abs/0909.2927. The abstract states the important
  marginal-preserving feature: the booster modifies labels rather than the
  instance distribution.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data"
  (ICML 2025), https://proceedings.mlr.press/v267/ghai25a.html. This gives a
  computationally efficient modern route in the correlation-oracle setting,
  but the residual weak-oracle slack must be at the final accuracy scale.
- da Cunha, Hogsgaard, Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time" (ALT 2026), https://arxiv.org/abs/2601.11265. I also
  checked the arXiv source for the displayed runtime and conclusion.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic
  Learning" (JMLR 2003), https://www.jmlr.org/papers/v4/gavinsky03a.html.

## Definitions In This Edge

The source is distribution-free fixed-additive weak agnostic proper PAC
learning. There is a fixed `beta < 1/2` such that one uniform polynomial-time
learner, for every joint distribution `D`, outputs `h in C` with

$$
\operatorname{err}_D(h)
\le
\inf_{c\in C}\operatorname{err}_D(c)+\beta .
$$

The target is strong agnostic improper PAC learning with marginal-nonuniform
resource bounds. For every instance marginal `P`, there must be a polynomial
`p_P` such that the same uniform learner, for every joint distribution `D`
with marginal `P`, outputs an arbitrary hypothesis `h` with

$$
\operatorname{err}_D(h)
\le
\inf_{c\in C}\operatorname{err}_D(c)+\epsilon
$$

in time and samples at most `p_P(s,1/epsilon,log(1/delta))`.

In `{+-1}` notation, the source is the fixed-slack correlation guarantee

$$
\operatorname{corr}_D(h)
\ge
\sup_{c\in C}\operatorname{corr}_D(c)-2\beta .
$$

So it is a nontrivial fixed additive approximation to the best correlation in
`C`, not a tunable oracle that can be asked for slack `O(epsilon)`.

## Positive Route 1: Reduce To The Distribution-Free Strong Edge

If the open edge

`efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac`

were resolved true, then this assigned edge would be immediate by monotone
relaxation: a distribution-free strong improper learner supplies the same
polynomial as `p_P` for every marginal `P`.

That route is currently the same agnostic boosting problem, not a solution.
The May 4 scratchpad for that edge already identified the closest known
positive theorem and the same computational gap. This assigned edge is weaker
on distribution uniformity, but it does not weaken the final polynomial-time
requirement in the representation size and `1/epsilon`.

## Positive Route 2: Feldman Or Ghai-Singh Same-Marginal Boosting

Marginal nonuniformity is genuinely helpful for Feldman-style boosting. Those
boosters can keep the instance marginal fixed and alter only the conditional
labels. If the source were a threshold or correlation weak agnostic oracle
available at every desired scale, then all weak calls would stay under the
original marginal `P`, and the target's single polynomial `p_P` could plausibly
control the whole run.

The current source is not that oracle. Suppose a threshold call asks for a
weak hypothesis whenever

$$
\operatorname{OPT}_C(D)\le 1/2-\alpha .
$$

The atlas source then gives

$$
\operatorname{err}_D(h)
\le 1/2-\alpha+\beta,
$$

which is useful only when `alpha > beta`, with advantage `alpha - beta`. A
strong agnostic target needs final excess `epsilon`, so the threshold scale
has to go below any fixed `beta` when `epsilon < beta`.

The Ghai-Singh correlation framework has the same issue in a different
normalization: a residual term proportional to the weak-oracle additive slack
remains unless that slack is chosen at the final accuracy scale. The atlas
node supplies only one fixed additive tolerance.

Conclusion: same-marginal boosting explains why the marginal bookkeeping is
not hopeless, but it proves a strengthened threshold/correlation weak node,
not this fixed-additive node.

## Positive Route 3: da Cunha-Hogsgaard-Paudice Fixed-Slack Boosting

This is the closest positive route because the atlas source fits their
fixed-slack correlation condition. With

$$
\gamma_0=1,\qquad \epsilon_0=2\beta,\qquad
\theta=(\gamma_0-\epsilon_0)/2=1/2-\beta>0,
$$

the weak source is a nontrivial weak oracle. Properness is useful here: the
base weak class can be read as `C`, and the target is allowed to output an
improper vote or sign of a real-valued aggregate.

The theorem still does not give the atlas target. The arXiv source for
`2601.11265` states that the algorithm invokes the weak learner at most

$$
O(n^{m_0+3})
$$

times and has running time

$$
\operatorname{Eval}_{H}(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)} .
$$

Here `m_0` is the weak learner's sample parameter and `d^*` is the dual VC
dimension of the base class. In this atlas edge, `m_0` can be polynomial in
the representation size `s`, and `d^*` may also grow with `s`. Even with
constant `theta`, the bound can be

$$
(\operatorname{poly}(s,1/\epsilon))^{\operatorname{poly}(s)},
$$

which is not polynomial in `(s,1/epsilon,log(1/delta))`.

Marginal-nonuniformity cannot absorb this. A marginal-dependent polynomial
`p_P` may have a degree depending on `P`, but it still must be a polynomial in
`s` and `1/epsilon` with a fixed exponent for that `P`. An exponent such as
`m_0(s)` is not allowed.

Conclusion: da Cunha-Hogsgaard-Paudice gives strong evidence that the
fixed-additive source is statistically boostable, but not an atlas-polynomial
computational implication.

## Positive Route 4: VC Or Exhaustive ERM At A Fixed Marginal

The source restricted to realizable distributions gives weak realizable
proper learning, and sample-complexity theory then points toward finite VC
dimension and strong agnostic sample learnability. That is enough for the
sample-only atlas layer.

It is not enough here. The target is computational. A fixed marginal `P` may
make a finite cover of `C` exist at each accuracy scale, but the target still
requires one uniform algorithm whose runtime is bounded by a `P`-dependent
polynomial. The source proper weak learner does not provide:

- an efficient strong ERM routine for `C`,
- a computable `L_1(P)` cover with polynomial search time,
- or a projection method from an improper aggregate back to an efficiently
  found strong hypothesis.

So properness gives a useful representation for each weak output, but not an
efficient strong optimizer.

## False-Witness Search

I did not find a concrete separation.

### Halfspaces

Halfspaces are the strongest nearby false witness for marginal-nonuniform
strong agnostic improper learning: Tiegel's standard-Gaussian hardness rules
out the target under worst-case lattice hardness.

They do not satisfy this source. The atlas definition for
`efficient-weak-agnostic-proper-pac` lists halfspaces as a negative boundary
example: Tiegel-style hardness rules out even weak agnostic learning in the
distribution-free sense. Halfspaces only separate the weaker marginal-source
sibling edge after low-noise robustification.

### Fixed-k-Term DNF

Fixed-k-term DNF satisfies the weak proper source used in the atlas and
separates weak proper learning from strong proper learning under `RP != NP`.
But the assigned target is improper. I did not find an atlas-ready theorem
showing fixed-k-term DNF is hard for strong improper agnostic learning, let
alone under a fixed marginal in a way that defeats marginal-nonuniform
runtime.

So fixed-k DNF remains a proper-output separation, not a separation for this
improper target.

### PCP And Lookup Classes

The PCP active-slice lookup family separates improper learning from weak
proper learning in other edges. It does not fit this source, because the
assigned source itself is proper weak agnostic learning. If the domain is made
small enough for lookup-table improper learning, strong agnostic improper
learning often becomes easy by empirical majority or finite-class ERM, killing
the desired target failure.

### Monomials, Parities, PRFs, And Noisy Hardness

These are tempting because strong agnostic learning can be hard under natural
assumptions. The difficulty is that their hardness usually appears already at
the weak-correlation level when `OPT` is small. That threatens the source
itself, since a realizable or low-noise distribution still requires the weak
proper learner to output a concept with error below `1/2` by a nontrivial
amount.

A valid counterexample would need a subtler "many weak handles" structure:
one proper weak handle is efficiently findable for every labeled distribution,
but assembling enough handles for arbitrary excess error is hard under some
fixed marginal. I do not know such a class.

## What The Two Relaxations Actually Buy

### Marginal Nonuniformity

It buys less than the current edge summary suggests, because the source is
already distribution-free. Reweighted marginals are not a resource-bound
problem for this source.

It buys something for label-only boosters: if the weak oracle were a tunable
threshold/correlation oracle, Feldman-style calls could all stay under the
same marginal `P`, and a `P`-dependent polynomial would be natural. But the
fixed-additive source is not tunable.

It also might absorb hidden constants or cover exponents in a future fully
polynomial booster. It cannot absorb a runtime exponent that grows with the
representation size.

### Properness

It removes properization as an obstacle on the weak side. The weak hypotheses
are already in `C`, and the target allows an improper aggregate of them.

It does not resolve agnostic boosting. The problem is not that the weak
hypotheses are outside `C`; the problem is extracting arbitrarily small
excess error from a fixed `OPT + beta` oracle in representation-uniform
polynomial time.

## Proposed Atlas Note If Editing Were Allowed

I would not change the status from open. I would revise the summary to avoid
blaming marginal reweighting for this specific source:

> Open: because the source weak learner is distribution-free, reweighted
> weak calls do not by themselves break the resource bound. The remaining
> gap is the fixed-additive agnostic boosting gap: efficient same-marginal
> boosters require tunable threshold/correlation slack, while the known
> fixed-slack residual-free booster has weak-sample/base-class parameters in
> the runtime exponent.

I would also consider adding `feldman2010distributionspecific`,
`ghai2025agnosticboosting`, and `gavinsky2003` to the edge's references if
the body is expanded. The current `bendavid2001` and
`dacunha2026agnosticboosting` references are still relevant.

## Depth-2 Directions

1. Try to prove a fully polynomial fixed-slack agnostic booster. The needed
   theorem should be polynomial in the weak learner runtime, weak sample
   parameter `m_0`, evaluation time, `1/(1/2-beta)`, class capacity, and
   `1/epsilon`, not exponential in `m_0` or `d^*`. This would likely resolve
   the edge true.

2. Add or use a strengthened threshold/correlation weak agnostic source node.
   For that node, Feldman's marginal-preserving booster, or a Ghai-Singh style
   variant, should plausibly give a true edge to the strong marginal-nonuniform
   agnostic improper target.

3. Formalize the budgeted-output-class approach for arbitrary efficient proper
   weak learners. The question is whether the class of all hypotheses printed
   within a polynomial budget can be used by a modern agnostic booster with
   only polynomial dependence on its effective dimension.

4. Search for a fixed-marginal computational separation: a class with
   distribution-free efficient fixed-additive weak agnostic proper learning,
   but no strong agnostic improper learner under one fixed marginal. Existing
   halfspace, monomial, parity, PRF, fixed-DNF, and lookup templates all miss
   at least one side of this requirement.

5. Revisit fixed-k DNF only with an explicit improper hardness source. Proper
   hardness alone is not enough for this assigned target.

verdict: unresolved-open
confidence: 0.84

## Depth 3 Branch: marginal fixed-additive proper agnostic boosting

Branch question: if the target marginal $P$ is fixed and the weak hypotheses
are proper members of $\mathcal C$, does the fixed-additive agnostic boosting
obstacle disappear?

My conclusion is no. Fixed $P$ removes the marginal bookkeeping problem for
label-only boosters, and properness removes the base-class/output-interface
problem. Neither removes the fixed additive slack.

### Setup

Use labels in $\{\pm 1\}$. The source gives one distribution-free polynomial
time learner $A$ and a fixed $\beta<1/2$ such that for every joint
distribution $\mathcal D$,

$$
\operatorname{corr}_{\mathcal D}(A(\mathcal D))
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)-2\beta,
$$

and the output lies in $\mathcal C$.

For this branch, fix a marginal $P$ and allow the final algorithm's polynomial
bound to depend on $P$. Since the source is distribution-free, every relabeled
distribution with feature marginal $P$ is still a legal input to the same weak
learner with the same distribution-free polynomial resource bound. Thus the
only remaining question is whether the fixed additive approximation to best
correlation can be converted into arbitrary excess correlation under the same
feature marginal.

### Same-Marginal Feldman/Ghai Route

Feldman's distribution-specific theorem and the Ghai--Singh unlabeled-data
boosters have exactly the right marginal shape: the weak learner is called on
distributions obtained by relabeling or pseudo-labeling points from the same
feature marginal. In a marginal-nonuniform target this is ideal, because all
weak calls remain under the one fixed $P$.

Properness also fits this route. Ghai--Singh's base class can be read as
$\mathcal B=\mathcal C$, and the final target is improper, so an aggregate such
as $\operatorname{sign}(\sum_t \alpha_t h_t)$ is allowed.

The quantitative mismatch remains. Ghai--Singh use a weak oracle of the form

$$
\operatorname{corr}_{\mathcal D'}(W)
\ge
\gamma\max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D'}(h)-\epsilon_0,
$$

and their theorem leaves residual correlation error $2\epsilon_0/\gamma$ plus
the requested booster accuracy. Translating the atlas source gives
$\gamma=1$ and $\epsilon_0=2\beta$, hence a constant residual, not arbitrary
$\epsilon$.

Feldman's threshold formulation has the same floor. If a relabeled
distribution has $\operatorname{OPT}_{\mathcal C}\le 1/2-\alpha$, the atlas
source only gives a proper $h$ with error at most

$$
1/2-\alpha+\beta.
$$

This is a useful weak hypothesis only when $\alpha>\beta$. A strong agnostic
learner must continue down to thresholds on the order of the final
$\epsilon$, so the route stalls once $\epsilon<\beta$.

Thus fixed marginal plus proper weak hypotheses would prove a strengthened
node with tunable $\epsilon_0=O(\epsilon)$, but not the current fixed-additive
node.

### Fixed-Slack da Cunha--Hogsgaard--Paudice Route

The da Cunha--Hogsgaard--Paudice theorem is still the closest positive result
because it accepts a nontrivial fixed-slack agnostic weak learner. The atlas
proper source maps to their condition with

$$
\gamma_0=1,\qquad \epsilon_0=2\beta,\qquad
\theta=(\gamma_0-\epsilon_0)/2=1/2-\beta>0.
$$

Properness helps here too: the base class can be taken as $\mathcal H=\mathcal
C$, and the final improper vote is permitted by the target.

The barrier is still representation-uniform running time. Their source theorem
invokes the weak learner at most $O(n^{m_0+3})$ times and gives running time

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$

Here $m_0$ is the weak learner's sample parameter and $d^*$ is the dual VC
dimension of the base class. The atlas source only says $m_0$ and runtime are
polynomial in the representation size $s$. It does not make $m_0$ a constant,
and properness does not bound $d^*$ by a constant. Even for fixed $P$ and
constant $\theta$, the bound can be

$$
(\operatorname{poly}(s,1/\epsilon))^{\operatorname{poly}(s)},
$$

or quasi-polynomial through the $\ln n$ fallback. A marginal-dependent
polynomial $p_P$ may choose constants and degree depending on $P$, but it is
still a polynomial in $s,1/\epsilon,\log(1/\delta)$; it cannot absorb an
exponent that grows with $s$.

So this route says the fixed-additive source is conceptually boostable and
that properness is not the obstacle. It does not supply the efficient
marginal-nonuniform atlas target.

### Fixed-P Cover Or Convex-Hull Route

A different hope is to use the fixed marginal $P$ to build or search a
$P$-specific cover of $\mathcal C$, then agnostically optimize over the
improper convex hull of proper weak hypotheses.

I do not see an atlas-ready theorem here. The source learner is only a
constant-additive optimizer for every relabeled distribution. Holdout
validation can select the best candidate among those produced, but it cannot
force the weak learner to produce missing directions whose improvement over
the current aggregate is below the $\beta$ floor. In convex-optimization
language, the source is a coarse linear-optimization oracle over $\mathcal C$;
fine excess agnostic learning would need a separation/optimization oracle at
scale $O(\epsilon)$ or a special theorem showing that coarse directions
suffice in fully polynomial time.

The recent fixed-slack booster is evidence that coarse directions can suffice
statistically, but its enumeration is exactly where the known computational
cost appears.

### False-Witness Check Under This Branch

No new false witness emerged from adding "fixed $P$" and "proper weak
hypotheses."

Halfspaces remain source-negative for this edge: Tiegel-style hardness rules
out distribution-free weak agnostic learning, whereas this edge's source is
distribution-free. The halfspace counterexample works for the marginal-source
sibling edge only because low-noise robustification supplies a
marginal-nonuniform weak source, not the present distribution-free one.

Fixed-$k$ DNF remains only a proper-target separation. Its weak proper source
is useful, but the assigned target is improper, and I did not find a primary
source giving strong improper agnostic hardness under one fixed marginal.

Approximation-hardness templates would need a class where one proper weak
handle is efficiently findable for every labeled distribution, while assembling
enough such handles for arbitrary excess error is hard under a fixed marginal.
That is still the missing counterexample shape.

### Sources Rechecked For This Branch

- Feldman 2010, `Distribution-Specific Agnostic Boosting`,
  https://arxiv.org/abs/0909.2927. The relevant point is that the booster
  modifies labels rather than the feature marginal.
- Ghai--Singh 2025, `Sample-Optimal Agnostic Boosting with Unlabeled Data`,
  https://proceedings.mlr.press/v267/ghai25a.html and arXiv source
  `2503.04706`. The source theorem gives same-marginal relabeling but retains
  a residual $2\epsilon_0/\gamma$.
- da Cunha--Hogsgaard--Paudice 2026, `Sample-Near-Optimal Agnostic Boosting
  with Improved Running Time`, https://arxiv.org/abs/2601.11265 and arXiv
  source. The theorem accepts fixed nontrivial slack but has $m_0$ and $d^*$
  in the runtime exponent; its conclusion explicitly leaves fully polynomial
  dependence on all parameters as an open direction.

verdict: unresolved-open
confidence: 0.86
next branches:
1. Fully polynomial fixed-slack proper-base agnostic booster: look for a
   theorem polynomial in $m_0$, weak runtime, $d$ or a budgeted output-class
   capacity, $1/(1/2-\beta)$, and $1/\epsilon$, with no weak-parameter in the
   exponent.
2. Fixed-marginal coarse-oracle lower bound: test whether black-box access to
   an $\operatorname{OPT}+\beta$ proper oracle is insufficient for
   polynomial-query agnostic excess minimization, even when all calls preserve
   $P$.
3. Source-positive improper hardness witness: search beyond halfspaces and
   fixed-$k$ DNF for a class with distribution-free fixed-additive weak
   agnostic proper learning but fixed-marginal strong agnostic improper
   hardness.

## Depth 4 Branch: fixed-marginal coarse-oracle barrier

This branch tests the second next-branch from Depth 3. The target question is
not whether same-marginal agnostic boosting is possible in general; Feldman and
Ghai--Singh already make that direction plausible when the weak oracle has
tunable slack. The target question is narrower:

> Can a booster that only sees a fixed-additive proper weak learner, abstracted
> as a coarse optimization oracle over $\mathcal C$, force arbitrary
> $\epsilon$-excess agnostic error under one fixed marginal $P$?

The best current answer from this branch is "probably not by a black-box coarse
oracle argument alone." There is a natural barrier model, but it separates
black-box booster access from the actual atlas implication. It is therefore
diagnostic rather than decisive.

### Coarse Oracle Model

Fix a marginal $P$ on $\mathcal X$. Write a joint distribution with this
marginal through its regression function

$$
g(x)=\mathbb E[y\mid x]\in[-1,1].
$$

For $h:\mathcal X\to\{\pm1\}$,

$$
\operatorname{corr}_D(h)=\mathbb E_{x\sim P}[g(x)h(x)].
$$

The source learner gives, for every relabeling or pseudo-labeling with the
same marginal $P$, a proper hypothesis $h\in\mathcal C$ satisfying

$$
\operatorname{corr}(h)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}(c)-2\beta .
$$

So, as an oracle, it is an additive $2\beta$ linear-optimization oracle over
$\mathcal C$ with respect to whatever signed weight function the booster has
induced on $P$. The oracle is very strong at detecting directions whose
correlation is separated from the pack by more than $2\beta$, but it is
allowed to be completely uninformative among directions that differ only below
that fixed scale.

This abstraction captures the exact mismatch from the prior branch. Strong
agnostic learning to excess $\epsilon$ is a fine optimization target. The
source oracle only promises coarse optimization at a constant scale.

### A Candidate Adversarial Picture

The tempting lower-bound picture is a hidden-direction family. Let
$\mathcal C=\{c_1,\ldots,c_N\}$ be a large nearly orthogonal family under the
fixed marginal $P$. For a hidden index $i$, define the labels by

$$
g_i(x)=\alpha c_i(x)
$$

where $\epsilon\ll\alpha<2\beta$. Then

$$
\sup_{c\in\mathcal C}\operatorname{corr}_{D_i}(c)=\alpha,
\qquad
\operatorname{err}_{D_i}(c_i)=\frac{1-\alpha}{2}.
$$

A strong agnostic learner competing with $\mathcal C$ must output a hypothesis
with correlation at least $\alpha-O(\epsilon)$, so it must essentially discover
the hidden direction $c_i$ or an improper surrogate correlated with it.

But a $2\beta$-coarse oracle is not forced to reveal $c_i$ on the original
distribution, because an arbitrary default hypothesis with correlation near
$0$ still satisfies

$$
0\ge \alpha-2\beta .
$$

The same issue persists for many adaptive relabelings. Unless the booster has
already constructed a signed weight function for which $c_i$ beats the
available defaults by more than $2\beta$, the oracle may return something that
does not identify $i$. In this model the booster is asking a constant-resolution
linear optimizer to solve a fine-resolution search problem.

This is the cleanest form of the fixed-marginal coarse-oracle barrier. The
marginal never changes. Properness is no obstruction. The obstruction is that
all useful signal can be placed below the oracle's guaranteed resolution, while
the target accuracy asks the final hypothesis to recover that signal.

### Why This Is Not Yet A False Edge

The adversarial picture is not an atlas-ready non-implication.

First, it is a lower bound against a black-box oracle interface, not against
the existence of a distribution-free fixed-additive proper learner. The actual
source learner is an algorithm, not an adversarial oracle. A transformation
proving the edge true might use the learner's code, its samples, validation,
or a special structure of the class in a way the oracle abstraction hides.

Second, the hidden-direction sketch must satisfy the source assumption for
all labeled distributions, not just for the low-correlation family
$g_i=\alpha c_i$. A trivial default learner works only when the best proper
correlation is below the fixed slack. For arbitrary distributions where some
$c_j$ has correlation much larger than $2\beta$, the source learner must
efficiently find a near-best proper hypothesis. Turning this into a genuine
class separation would require a class where large correlations are easy to
find but correlations below the fixed slack are computationally hidden.

Third, marginal nonuniformity weakens many finite-domain information-theoretic
attacks. For a fixed marginal $P$, the target resource polynomial $p_P$ may
depend on $P$. If the lower bound is only that the domain has a huge finite
support or that a $P$-specific preprocessing table is large, marginal
nonuniformity may absorb it. A usable separation has to force super-polynomial
dependence on the representation size or $1/\epsilon$ even after $P$ is fixed.

So the coarse-oracle lower bound is a barrier to the known boosting-style
proof strategy, not a proof that the implication is false.

### Consequence For A Positive Booster

A fully polynomial distribution-specific booster for this edge would have to
do something stronger than the Feldman/Ghai same-marginal tunable-slack route
and stronger, computationally, than the da Cunha--Hogsgaard--Paudice
fixed-slack route.

The needed theorem would look roughly like this. Given fixed $P$, sample access
to labeled examples with marginal $P$, and oracle access to a proper weak
learner satisfying

$$
\operatorname{corr}(W)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}(c)-2\beta
$$

for one constant $\beta<1/2$, produce an improper hypothesis $H$ with

$$
\operatorname{corr}_D(H)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_D(c)-2\epsilon
$$

in time polynomial in the representation size, the weak learner's own
polynomial bound, $\log(1/\delta)$, and $1/\epsilon$, with any dependence on
$P$ allowed only as fixed constants in that polynomial. The theorem cannot
leave the weak sample parameter, dual VC dimension, or a cover size in the
exponent if those quantities may grow with the representation size.

The coarse-oracle picture suggests such a theorem is unlikely in a purely
black-box oracle model. If it exists, it probably needs an additional
structural assumption, a refined oracle that can be queried with accuracy
parameters, or a non-black-box use of the source learner.

### Source Check For This Branch

The current public results still line up with the Depth 3 diagnosis.

- Feldman's distribution-specific agnostic booster is same-marginal because it
  changes labels rather than the instance marginal, but its weak condition is
  a threshold/tunable-slack condition rather than a fixed-additive constant
  floor: https://arxiv.org/abs/0909.2927.
- Ghai--Singh's unlabeled-data booster is explicitly useful in
  distribution-specific settings and is computationally efficient, but the
  guarantee retains residual dependence on the weak oracle's additive slack:
  https://proceedings.mlr.press/v267/ghai25a.html and
  https://arxiv.org/abs/2503.04706.
- da Cunha--Hogsgaard--Paudice accept fixed nontrivial agnostic weak slack, but
  their running-time statement is polynomial in the sample size only when
  other problem parameters are fixed, which does not give the atlas target's
  fully polynomial marginal-nonuniform learner:
  https://arxiv.org/abs/2601.11265.

verdict: unresolved-open
confidence: 0.88
next branches:
1. Formalize the coarse-oracle barrier as a black-box lower bound: define the
   allowed same-marginal oracle queries, build the hidden-direction response
   adversary, and prove that polynomially many queries cannot force
   $\alpha-O(\epsilon)$ correlation when $\epsilon\ll\alpha<2\beta$.
2. Search for an actual class realizing the barrier: large correlations are
   efficiently findable for every distribution, but fixed-marginal
   sub-$\beta$ correlations are hard enough to block strong improper agnostic
   learning.
3. Search for a fully polynomial fixed-slack distribution-specific booster
   whose runtime is polynomial in the weak learner's parameters and $1/\epsilon$
   with no weak-sample, dual-dimension, cover-size, or sample-size parameter in
   the exponent.
4. Test whether adding a tunable weak-slack parameter to the source node makes
   the sibling implication immediately true by Feldman/Ghai, separating the
   schema issue from the fixed-additive obstruction.

## Depth 5 Branch: can fixed-marginal advice beat the coarse oracle?

depth: 5

This pass tries to turn the Depth 4 diagnostic into either a positive
fixed-marginal theorem or a real separation. The sharpened conclusion is still
open, but the search usefully splits "marginal-nonuniform" into two different
notions:

1. the atlas notion, where the learner is one uniform algorithm and only the
   polynomial bound may depend on the marginal $P$; and
2. a stronger advice fantasy, where the learner is given some $P$-specific
   preprocessing, cover, or oracle.

The assigned target has only the first kind. Even the second kind does not
obviously defeat the fixed-additive barrier unless the advice contains
fine-scale optimization information about $\mathcal C$ under $P$.

### What Fixed-Marginal Nonuniformity Actually Gives

For this edge, the source learner is distribution-free. Therefore every weak
call made by a reweighting booster is already covered by the same source
runtime polynomial, whether or not the induced marginal changes. This is why
the old "boosting changes the marginal" objection is not decisive here.

The target's marginal nonuniformity can still hide constants, a degree, or a
$P$-dependent unlabeled-sampling overhead in the final polynomial. It cannot
give the algorithm a separate data structure for $P$, and it cannot turn
$n^{m_0(s)}$ into a polynomial in $s$ when $m_0(s)$ grows with representation
size.

If one strengthens the target informally by allowing $P$-specific advice, a
positive route becomes more plausible but still not automatic. Advice could
include a finite $L_1(P)$ cover of $\mathcal C$, a search tree over the trace
of $\mathcal C$ on high-mass atoms, or a fixed-marginal ERM subroutine. Any of
these would make strong improper agnostic learning straightforward by
validation or ERM over the advised class. But none of them follows from the
source weak learner. The source only says that, from labeled samples, one can
find a proper hypothesis within a constant additive error of the best proper
hypothesis. It does not expose the trace of $\mathcal C$ at resolution
$\epsilon$.

This matters because sample-complexity reasoning is misleading here. The
source implies the usual sample-only weak-to-strong consequences, so for each
fixed $P$ there are finite covers and ERM witnesses at each accuracy scale.
The missing ingredient is effective access. A $P$-dependent polynomial bound is
not a $P$-dependent advice string.

### Rechecking The Same-Marginal Positive Theorems

Kalai--Mansour--Verbin make the key threshold issue explicit. Their
$(\alpha,\gamma)$ weak agnostic learner only promises a weak output when the
best class error is at most $1/2-\alpha$, and the booster reaches
$\operatorname{OPT}+\alpha+\epsilon$, not $\operatorname{OPT}+\epsilon$ for a
fixed positive $\alpha$. The atlas source can be converted into such a
threshold learner only with $\alpha$ above the fixed $\beta$ floor:

$$
\operatorname{OPT}\le 1/2-\alpha
\quad\Longrightarrow\quad
\operatorname{err}(A)\le 1/2-(\alpha-\beta).
$$

Thus the threshold scale cannot be pushed down to $O(\epsilon)$.

Ghai--Singh have the more modern and more fixed-marginal-friendly picture:
unlabeled samples come from the target marginal and the weak calls can be
viewed as same-marginal label manipulations. Their PMLR abstract explicitly
emphasizes distribution-specific settings where unlabeled samples are
available. But their oracle has tunable correlation/slack parameters; with the
atlas fixed slack $2\beta$ in correlation notation, the residual term remains
constant.

da Cunha--Hogsgaard--Paudice are still the closest theorem to this edge. Their
2026 arXiv abstract says the algorithm is polynomial in sample size with other
parameters fixed. That qualifier is exactly the atlas problem: the weak sample
parameter, dual VC dimension, or budgeted output-class capacity may grow with
the representation size. Fixed $P$ can hide constants but cannot hide those
representation-dependent quantities in the polynomial exponent.

So the positive route still needs a new theorem: a fully polynomial
fixed-slack agnostic booster, preferably same-marginal, whose runtime is
polynomial in the weak learner's own polynomial bounds, $1/(1/2-\beta)$,
$1/\epsilon$, and $\log(1/\delta)$, with no weak sample or capacity parameter
in the exponent.

### Can A Coarse-Oracle Barrier Be Realized By A Class?

The most promising false-witness shape is not halfspaces, fixed-$k$ DNF, or a
plain PRF class. It is a "weak shield plus hard core" construction.

The hard core would contain concepts $c_i$ that are hard to agnostically learn
under one fixed marginal $P^\star$ when the regression function is

$$
g_i(x)=\alpha c_i(x),
\qquad
\epsilon\ll \alpha < 2\beta .
$$

At this signal level, a fixed-additive weak learner is allowed to ignore the
hard direction: a default hypothesis with correlation near $0$ is still within
$2\beta$ of the best correlation $\alpha$. But a strong agnostic learner must
produce correlation $\alpha-O(\epsilon)$, which should require recovering
$c_i$ or a very accurate surrogate.

The weak shield is needed to make the source true on all other distributions.
If some labeled distribution has a concept in the hard core with correlation
well above $2\beta$, the source cannot simply return the default. It must find
some proper hypothesis whose correlation is within $2\beta$ of that large
value. A valid separation therefore needs easy proper handles that certify the
weak source whenever the best correlation is large, while still being too weak
to solve the low-signal hard-core task.

This is the first place where the coarse-oracle barrier starts to look like a
real separation template rather than a purely artificial oracle objection.
There is no contradiction in principle: large-correlation regimes could be
easy because the shield supplies robust handles, while sub-$2\beta$
correlations could remain cryptographically hidden and still matter for
strong agnostic learning.

I do not have an atlas-ready class satisfying this template. The known
templates fail in instructive ways:

- PRFs or parities can make low-signal agnostic learning hard under a fixed
  marginal, but then high-signal or realizable distributions are also hard for
  the weak source unless extra handles are added.
- One-way image-coordinate classes with handles make weak proper learning
  plausible, but the same sparse or block handles tend to make improper strong
  learning easy by lookup, sparse ERM, or sample-driven aggregation.
- Fixed-$k$ DNF has the right proper weak source and the right flavor of
  nonboostability, but the available hardness is for proper strong learning.
  The assigned target is improper, and I did not find a fixed-marginal strong
  improper agnostic hardness theorem for this class.
- Halfspaces have a fixed-marginal strong agnostic improper hardness theorem,
  but they fail the distribution-free weak agnostic source.

The shield-plus-hard-core route suggests the missing witness should be more
structured than a standard hardness class. It needs an efficient weak selector
that is deliberately coarse: it succeeds whenever the optimum is separated by
more than the fixed slack, but it reveals essentially no information about
which hard-core direction is best below that scale.

### Why Advice Does Not Immediately Kill The Barrier

Suppose we grant a hypothetical learner an advice object depending only on
$P^\star$. If the advice contains an explicit polynomial-time ERM oracle over
the hard core, then of course the target becomes true. But such advice is much
stronger than marginal nonuniformity and would make most fixed-marginal
computational lower bounds meaningless.

The more relevant advice is unlabeled or geometric: covers, partitions,
density estimates, or sampling tables for $P^\star$. This kind of advice does
not identify the hidden label direction $c_i$. In the hard-core distribution
$g_i=\alpha c_i$, the marginal is the same for all $i$, so $P^\star$-only
advice cannot depend on the target direction. If recovering a
$\alpha-O(\epsilon)$ correlated predictor is computationally hard from noisy
labeled samples, then fixed-marginal advice of this geometric kind should not
break the separation.

This is exactly the distinction the atlas target relies on. The learner may
benefit from the fact that one polynomial works for $P^\star$, but it must
still discover the label-dependent fine structure from examples. The
fixed-additive source is permitted to avoid discovering that structure whenever
the best correlation lies below the constant oracle resolution.

### Provisional Verdict

verdict: unresolved-open

The edge is still not resolved. I see no current positive theorem that turns a
fixed-additive proper weak agnostic learner into a fully polynomial strong
improper agnostic learner, even with all weak calls kept under one marginal.
I also do not have a concrete false witness.

The depth-5 update is that the fixed-marginal coarse-oracle barrier looks more
like a real separation template than it did at depth 4. A valid false witness
would likely combine:

1. a hard low-signal family under one fixed marginal $P^\star$;
2. easy proper weak shields that make the source true for every distribution,
   especially when the best hard-core correlation exceeds the fixed slack;
3. a proof that $P^\star$-only geometric advice and polynomially many samples
   do not recover a near-best hard-core direction at signal
   $\epsilon\ll\alpha<2\beta$; and
4. a check that the added shields do not themselves form an improper strong
   learner by aggregation.

confidence: 0.89

### Depth 6 Directions

1. Formalize the shield-plus-hard-core template. Start with a hard class
   $\mathcal G$ under a fixed marginal $P^\star$, add a shield class
   $\mathcal S$, and write exact inequalities guaranteeing
   $\max_{s\in\mathcal S}\langle s,g\rangle
   \ge \max_{c\in\mathcal G}\langle c,g\rangle-2\beta$ whenever the hard-core
   optimum is above the slack floor.

2. Test a cryptographic instantiation where $\mathcal G$ is a PRF or LPN-style
   family under a fixed product marginal, and $\mathcal S$ is a public weak
   correlate family. The hard part is making the public shields work under
   arbitrary marginals without letting their convex hull strongly learn
   $g_i=\alpha c_i$.

3. Try to prove a black-box lower bound with labeled samples included, not
   just oracle replies. The lower bound should allow arbitrary same-marginal
   relabeling queries to a $2\beta$-coarse proper optimizer and show that
   sub-$2\beta$ hidden directions remain unrecoverable without non-black-box
   structure.

4. Search the agnostic DNF literature specifically for fixed-$k$ term DNF
   strong improper agnostic hardness. If such a theorem exists, it could
   collapse this edge to `resolved-false`; if not, fixed-$k$ DNF should remain
   classified as only a proper-target separation.

5. Track fixed-slack boosting after da Cunha--Hogsgaard--Paudice. A theorem
   removing weak-sample and dual-dimension parameters from the runtime
   exponent would likely collapse this edge to `resolved-true`, with the
   marginal-nonuniform target following immediately.

## Depth 6 Branch: final synthesis on the shield/hard-core template

depth: 6

This final pass tried to force the Depth 5 template into either a legal
counterexample or a legal booster. I still do not resolve the edge. The best
atlas-ready output is a sharper obstruction statement and two precise missing
lemmas, one positive and one negative.

### Normalized Oracle View

Write labels as $\{\pm 1\}$ and let the regression function be
$g(x)=\mathbf E[Y\mid X=x]$. The source learner is a proper coarse optimizer:
for every joint distribution it returns $c\in\mathcal C$ with

$$
\langle c,g\rangle_P
\ge
\sup_{h\in\mathcal C}\langle h,g\rangle_P-\tau,
$$

where $\tau=2\beta<1$ in the constant-gap notation, equivalently
$\tau=1-2\gamma$ if the weak advantage is written as
$\gamma=1/2-\beta$. The important point is not whether $\gamma$ is a fixed
constant or inverse-polynomial in the representation size. The important point
is that $\tau$ is not an accuracy parameter that can be driven to
$O(\epsilon)$.

A same-marginal agnostic booster can query the weak learner on relabeled
distributions with the original instance marginal $P$. Such a relabeling has
new regression

$$
g_t(x)=a_t(x)+b_t(x)g(x),\qquad |a_t(x)|+|b_t(x)|\le 1,
$$

possibly after using the current aggregate predictor. This can rotate or clip
the residual, but it does not magically amplify an unknown hard direction. If
$g=\alpha c_i$ with $\epsilon\ll\alpha<\tau$, then a valid source response may
ignore $c_i$ on every query whose best class correlation remains below the
coarse floor. The final strong target, however, needs a predictor with
correlation $\alpha-O(\epsilon)$.

Thus fixed-marginal relabeling solves the old marginal-bookkeeping problem but
not the coarse-oracle problem. Properness also helps only at the interface: the
base hypotheses are in $\mathcal C$, and the target may output an improper vote
over them. It does not turn a $\tau$-additive linear optimizer into an
$O(\epsilon)$-additive one.

### Why The Positive Booster Is Still Missing

The desired positive theorem would have to say something like this.

**Missing positive lemma.** Let $\mathcal C$ have an efficient distribution-free
proper agnostic weak learner with fixed additive slack $\tau<1$ in correlation
form. Then for every fixed marginal $P$, there is one polynomial $p_P$ such
that a uniform algorithm, using only labeled samples from distributions with
marginal $P$ and calls to the weak learner, outputs an improper hypothesis with
error at most $\operatorname{OPT}_{\mathcal C}+\epsilon$ in time
$p_P(s,1/\epsilon,\log(1/\delta))$.

Existing results stop just short of this lemma.

- Feldman-style distribution-specific boosting and Ghai--Singh-style
  unlabeled-data boosting are same-marginal friendly, but their weak oracle has
  tunable threshold/correlation slack. With a fixed atlas slack, a constant
  residual term remains.
- Ben-David--Long--Mansour and Gavinsky handle the original fixed-additive
  weak notion only to non-strong final guarantees, not
  $\operatorname{OPT}+\epsilon$.
- da Cunha--Hogsgaard--Paudice are the closest match to the fixed-slack
  source, but their running time is polynomial in the sample size with other
  parameters fixed. In atlas terms, weak sample parameters, dual dimensions, or
  output-class capacities may grow with representation size, and putting those
  quantities in the exponent is not a marginal-dependent polynomial.

So a positive resolution needs a genuinely fully polynomial fixed-slack
agnostic booster, not merely a same-marginal booster.

### Why The False Witness Is Also Missing

The most plausible counterexample would be
$\mathcal C=\mathcal S\cup\mathcal G$, where $\mathcal G$ is a hard low-signal
family under one fixed marginal $P^\star$, and $\mathcal S$ is a family of easy
proper shields. To be legal for this edge it must satisfy all of the following.

1. **Source domination.** For every marginal $Q$ and every label regression
   $r$, there is an efficient way to find a proper hypothesis in
   $\mathcal S\cup\mathcal G$ whose correlation is within $\tau$ of
   $\sup_{\mathcal S\cup\mathcal G}\langle h,r\rangle_Q$.

2. **Hard low-signal slice.** For one fixed marginal $P^\star$, there are
   regressions $r_i=\alpha g_i$ with $g_i\in\mathcal G$ and
   $\epsilon\ll\alpha<\tau$ such that producing correlation
   $\alpha-O(\epsilon)$ is computationally hard even for improper hypotheses.

3. **Shield nonleakage.** The shields that make the source true must not have a
   convex hull, vote closure, lookup closure, or sample-driven aggregate that
   already predicts $r_i$ to correlation $\alpha-O(\epsilon)$ under
   $P^\star$.

The obstruction is condition 1. If $r=g_i$ is a clean realizable hard-core
concept and $Q=P^\star$, the source requires an efficiently findable weak
proper predictor with correlation at least $1-\tau$. Therefore the shields must
weakly predict every hard concept under every marginal in the high-signal
regime. That is much stronger than merely adding a default hypothesis that
beats low-signal noise. In most cryptographic hard cores, such a public weak
shield would already contradict pseudorandomness or give the first step of a
standard realizable booster.

The candidate families fail for exactly this reason.

- PRF and LPN/parity hard cores make the low-signal target failure plausible
  under a fixed product marginal, but they do not satisfy the distribution-free
  proper weak source once the labels have correlation above the slack floor.
  Adding public shields strong enough to handle clean PRF labels would destroy
  the intended hardness.
- Halfspaces have the right marginal strong agnostic hardness, but Tiegel-style
  hardness rules out the assigned distribution-free weak agnostic source.
- Fixed-$k$ DNF has the right weak proper source and the right proper-output
  separation, but I still found no primary theorem giving fixed-marginal strong
  improper agnostic hardness for fixed $k$. The known DNF hardness results
  either concern proper learning, growing-size DNF families, distribution-free
  hardness, or a stronger output restriction.
- The one-way image-coordinate weak-handle witnesses are instructive but not
  legal here. Their handles separate weak proper from strong proper learning;
  once the target is improper, lookup or sample-driven aggregation tends to
  learn the fixed finite block.

This leaves the following as the missing negative lemma.

**Missing negative lemma.** Construct a representation class
$\mathcal C=\mathcal S\cup\mathcal G$ satisfying the source domination and
shield nonleakage conditions above, together with a fixed marginal $P^\star$
and a family of low-signal regressions $r_i=\alpha g_i$ witnessing improper
agnostic hardness at excess $\epsilon\ll\alpha<\tau$.

I do not know such a class, and the existing atlas witnesses do not provide it.

### Atlas-Ready Final Recommendation

verdict: unresolved-open

confidence: 0.91

Recommended status remains `open`, with family `agnostic-boosting-open`.
However, the current implication note's obstacle should be sharpened when the
atlas is next edited. For this particular edge, the source is
distribution-free, so reweighted or relabeled weak calls are already covered by
one source polynomial. The live obstruction is instead the fixed-additive
agnostic weak guarantee: same-marginal boosting theorems need tunable
final-scale slack, while fixed-slack boosting theorems known to me do not give
a fully polynomial atlas runtime.

Suggested replacement summary:

> Open: the distribution-free weak source removes the marginal-reweighting
> bookkeeping problem, but it gives only a fixed-additive proper agnostic weak
> oracle. Existing same-marginal agnostic boosters require tunable weak slack,
> and existing fixed-slack boosters have representation-dependent parameters in
> the exponent. No legal shield-plus-hard-core counterexample is currently
> known.

Suggested proof-status paragraph:

> A positive proof would require a fully polynomial fixed-slack agnostic
> booster converting a proper learner with
> $\operatorname{err}\le\operatorname{OPT}_{\mathcal C}+\beta$ into an improper
> learner with $\operatorname{OPT}_{\mathcal C}+\epsilon$, at least
> marginal-by-marginal. A negative proof would require a class with
> distribution-free proper weak agnostic learning in all high-signal regimes
> but fixed-marginal improper agnostic hardness for low-signal regressions below
> the weak oracle's additive resolution. The natural halfspace, fixed-$k$ DNF,
> PRF/parity, PCP lookup, and one-way weak-handle witnesses each miss one of
> these requirements.

No atlas files should be changed from this pass without a new theorem or a
new concrete witness.
