# Edge Investigation: Efficient Marginal-Nonuniform Weak Realizable Proper PAC -> Efficient Marginal-Nonuniform Realizable Improper PAC

- date: 2026-05-07
- worker depth: 1 of 7
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- target: `efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

## Verdict

`unresolved`.

I do not see an atlas-ready proof or an atlas-ready counterexample. The current
`open` status still looks correct under the atlas semantics.

The central obstruction is not the final-output properness and not the
pathwise runtime of one weak call. The target is improper, so an ordinary
boosted vote would be allowed. Also, the source learner is one uniform
algorithm, and the atlas convention treats efficient sample use and running
time as worst-case/pathwise finite-transcript bounds, so the
full-support-reference argument can uniformize the resource bound of that one
algorithm.

What remains nonuniform is the weak advantage. Standard realizable boosting
queries the weak learner on reweighted or filtered residual marginals
`Q_t`. The source gives, for every such marginal `Q`, some inverse-polynomial
advantage

$$
\gamma_Q(s) \ge 1 / \operatorname{poly}_Q(s),
$$

but the target would need one polynomial depending only on the original
marginal `P`:

$$
\gamma_{Q_t}(s)^{-1}
\le r_P(s, 1/\varepsilon, \log(1/\delta))
$$

for every booster-induced marginal that can arise before reaching error
`epsilon`. I found no theorem in the checked sources or atlas notes that
performs this quantifier swap.

## Files And Prior Work Read

Atlas conventions and edge/endpoint notes:

- `atlas/README.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`

Linked or directly relevant atlas notes:

- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/unrestricted-labelings.md`

Prior exact scratchpad:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

Primary sources checked or used for calibration:

- Schapire 1990, "The Strength of Weak Learnability",
  https://doi.org/10.1023/A:1022648800760.
- Freund 1995, "Boosting a Weak Learning Algorithm by Majority",
  https://doi.org/10.1006/inco.1995.1136.
- Benedek and Itai 1991, "Learnability with respect to fixed distributions",
  https://doi.org/10.1016/0304-3975(91)90026-X.
- Ben-David, Benedek, and Mansour 1995, "A Parameterization Scheme for
  Classifying Models of PAC Learnability",
  https://doi.org/10.1006/inco.1995.1094.
- Hanneke, Moran, and Thiessen 2025, "Marginal-Nonuniform PAC Learnability",
  https://openreview.net/forum?id=aoVCFtox89.
- Feldman 2010, "Distribution-Specific Agnostic Boosting",
  https://arxiv.org/abs/0909.2927.
- Ghai and Singh 2025, "Sample-Optimal Agnostic Boosting with Unlabeled Data",
  https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha, Hogsgaard, and Paudice 2026, "Sample-Near-Optimal Agnostic
  Boosting with Improved Running Time", https://arxiv.org/abs/2601.11265.
- Goldreich, Goldwasser, and Micali 1986, "How to Construct Random Functions",
  https://doi.org/10.1145/6490.6503.
- Kearns and Valiant 1994, "Cryptographic Limitations on Learning Boolean
  Formulae and Finite Automata", https://doi.org/10.1145/174644.174647.

## Positive Route Checked

### Classical Realizable Boosting

Schapire and Freund give the standard weak-to-strong conversion in the
distribution-free realizable setting. Freund also explicitly discusses
extensions where the weak learner's accuracy depends on the instance
distribution. This is a near miss rather than a proof here: the number of
weak calls and the validation/sample overhead depend quantitatively on the
weak edge available on the distributions passed to the weak learner.

For a fixed original marginal `P`, a boosting proof would need to simulate
weak calls on residual marginals `Q_t`, obtain hypotheses with edge
`gamma_{Q_t}`, and finish in time polynomial in `s`, `1/epsilon`, and
`log(1/delta)` with a polynomial allowed to depend on `P`. The source only
says each `Q_t` has its own polynomial and weak edge. It does not say those
polynomials are dominated by a single `P`-dependent polynomial over all
reachable `Q_t`.

### Full-Support Resource Uniformization

The full-support argument does help, but only for resources. Because the
source learner is one algorithm with worst-case finite-transcript resource
bounds, a full-support reference marginal can force one global sample/time
bound for that algorithm. This removes a tempting runtime diagonalization.

It does not transfer weak accuracy. A weak guarantee under a reference mixture
can be poor or even worse than random on a small component; more importantly,
the source advantage under a residual marginal `Q` may have an exponent
depending on `Q`. Accuracy is still evaluated under the actual marginal passed
to the weak learner.

### Smooth Or Bounded-Density Boosting

Smooth boosting would prove the edge under an extra local-uniformity axiom.
For example, suppose every induced marginal satisfies

$$
Q \ll P,\qquad dQ/dP \le B(s,1/\varepsilon),
$$

and suppose the source implied a bounded-density weak-gap envelope

$$
\gamma_Q(s)^{-1} \le r_P(s,B)
$$

for one polynomial `r_P`. Then standard realizable boosting would yield the
target.

The current source does not imply that envelope. A rare-block marginal

$$
P = \sum_{j \ge 1} w_j P_j,\qquad Q_j=P_j=P(\cdot\mid S_j)
$$

has density `dQ_j/dP = 1/w_j` on block `S_j`. The source quantifiers are still
compatible with

$$
\gamma_{Q_j}(s)=s^{-j}
$$

or even `s^{-j^2}`. Each `Q_j` has an inverse-polynomial edge individually,
but no fixed polynomial in `(s,1/w_j)` dominates all these gaps. Bounded
density controls how much mass the booster concentrates; it does not control
the representation-size degree hidden in the weak edge on the concentrated
region.

### Same-Marginal Boosting

Same-marginal agnostic boosting avoids changing the instance marginal by
changing labels or losses. Feldman, Ghai-Singh, and da Cunha-Hogsgaard-Paudice
are relevant analogies, but their oracle assumptions are stronger than this
source.

Here the source is realizable only. If every weak call keeps marginal `P`,
then any auxiliary labels must still be labels of some concept in `C` for the
source guarantee to apply. Generic residual labels, margin signs, randomized
labels, and cost-sensitive labels are not guaranteed to be concepts in `C`.
If the booster simply repeats calls on the original target `c`, a valid weak
learner may return the same weak hypothesis every time. Thus same-marginal
boosting does not give a general proof for this edge.

### Dovetailing Over Guessed Gaps

One can dovetail over guessed weak gaps or booster schedules and validate the
resulting ensembles on fresh samples from `P`. This is not enough for the
target. It may eventually find a good ensemble, but the first successful guess
can occur at a degree controlled by residual marginals rather than by the
original `P`, so no target polynomial follows.

## Counterexample Route Checked

### Plain PRF Classes

Plain pseudorandom-function classes have the right kind of strong-learning
hardness under the usual hard marginal: an efficient learner that predicts
well on unseen random-looking labels would distinguish pseudorandom functions
from random functions.

They do not satisfy the source. Under that same hard marginal, no efficient
algorithm can even get an inverse-polynomial weak prediction advantage
without violating the PRF hardness assumption.

### Fixed-k-Term DNF

Fixed-`k`-term DNF separates weak proper learning from strong proper learning
under standard assumptions, but this edge has an improper target. Classical
boosting is allowed to output a majority vote or other improper aggregate, so
this witness does not refute the edge.

### One-Way Image Coordinate Weak-Handle Class

The one-way image-coordinate weak-handle class is source-positive for weak
proper marginal realizable learning: constants and positive-atom handles give
proper weak edges. Its recorded lower bound is a strong proper lower bound,
however. This edge's target is improper, and an improper learner may output a
lookup table or memorize sparse atoms. So this witness also does not refute
the edge.

### Rare-Block PRF Or Random-Oracle Handles

The best false template is still the rare-block construction from the May 5
scratchpad. Put large hard blocks `B_{n,j}` under a fixed mixture marginal
`P*`, with block sizes such as `N_{n,j}=n^j`. On block `j`, labels are
generated by a PRF or a random oracle. If a candidate strong improper learner
has `P*`-polynomial degree `D`, choose `j>D` and request accuracy below the
mass of that block. The learner sees too few coordinates to predict unseen
labels on the block; improper output does not help against independent unseen
bits.

The source proof is where the template fails. Adding constants and singleton
or pair handles gives a weak edge on nice block-uniform marginals, but the
source must work under every marginal, including marginals concentrated on one
hard block and nearly balanced between positive and negative atoms.

For a learner using at most `m(s)` samples/queries, choose a block of size
`N >> m(s)^2`. Define two marginals on the same hard target:

$$
P_+(\text{positive atoms})=1/2+\eta,\qquad
P_-(\text{positive atoms})=1/2-\eta
$$

with `eta` on the order of `m(s)/N`, and spread mass nearly uniformly inside
each side. Sparse sampled handles can correct only `O(m/N)` mass, so they
must also choose the right default orientation: default positive for one
marginal and default negative for the other. But the transcript
distributions under `P_+` and `P_-` have total variation `O(m eta)`, which is
tiny for the chosen block size. A single polynomial-time proper weak learner
cannot reliably choose opposite orientations, and with the wrong orientation
its error remains at least `1/2`.

This is a real obstruction to the false route, not a proof of truth. It says
the usual rare-block/singleton-handle template does not certify the
arbitrary-marginal proper weak source.

## Conditional Statements That Would Resolve It

### Conditional Positive Theorem

The edge would be true if one could prove the following envelope from the
current source, or add it as an explicit extra hypothesis:

For every original marginal `P`, every target accuracy `epsilon`, and every
booster-reachable residual marginal `Q_t` before error `epsilon`,

$$
\gamma_{Q_t}(s)^{-1}
\le r_P(s,1/\varepsilon,\log(1/\delta))
$$

for one polynomial `r_P`.

With that statement, Schapire/Freund-style realizable boosting would produce
an efficient marginal-nonuniform strong improper learner.

### Conditional Negative Template

The edge would be false if one could build a concrete or relativized concept
class with all of the following:

1. One uniform proper weak learner works under every marginal.
2. On some fixed mixture marginal `P*`, every strong improper learner with a
   `P*`-dependent polynomial bound fails on a rare hard block.
3. The weak handles are deterministic and orientation-free under arbitrary
   near-balanced block marginals.
4. Obtaining enough independent handles for low-error improper prediction
   remains computationally hard.

The current rare-block PRF and random-oracle ideas satisfy the target-hardness
intuition but fail item 3.

## Promising Depth-2 Directions

1. Formalize the weak-gap-envelope condition as a reusable conditional
   positive theorem. It would separate the clean boosting theorem from the
   missing atlas quantifier.

2. Prove a small hidden-orientation lemma for finite-exception proper handles:
   under two near-balanced block marginals, any pathwise-polynomial learner
   cannot reliably choose opposite defaults if the imbalance is below the
   sampled mass scale.

3. Search for deterministic orientation-free proper handles. This is the
   bottleneck for a false witness. Singletons, co-singletons, finite subsets,
   and sampled pair handles all appear to need a default orientation under
   near-balanced marginals.

4. Audit named smooth boosters for stronger reachability restrictions than
   bounded density, such as KL control or a finite residual menu. The depth-1
   rare-block calculation rules out plain bounded-density control, but maybe a
   more structured booster avoids conditionals on arbitrary rare blocks.

5. Keep agnostic same-marginal boosting as a near miss only. A future theorem
   with a residual-responsive correlation oracle could resolve a neighboring
   agnostic edge, but the present realizable source cannot be queried on noisy
   residual labels.

## Atlas Recommendation

No atlas edit is justified from this depth-1 pass. The current edge note
already reflects the main obstruction:

- `status: "open"`
- `evidence: unknown`
- `family: marginal-boosting-open`
- `argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"`

If the note is later edited, the most important phrasing is that the obstacle
is a weak-gap envelope over booster-induced marginals, while the best
counterexample templates fail to certify the proper weak source under
arbitrary near-balanced marginals.

VERDICT: unresolved

## Depth 2 Branch A: Original-Marginal Weak-Gap Envelope

- date: 2026-05-07
- branch: original-marginal weak-gap envelope for proper weak realizable boosting
- edge: `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, bibliography, or legacy LaTeX edited

### Branch Goal

Test whether a Schapire/Freund, SmoothBoost, filtering, or same-marginal
simulation argument can turn the source guarantee

$$
\forall Q\ \exists p_Q,\gamma_Q\qquad
\operatorname{err}_Q(A(Q,c),c)\le \frac12-\gamma_Q(s),
\qquad
\gamma_Q(s)^{-1}\le p_Q(s)
$$

into the target-side envelope needed by one strong learner:

$$
\forall P\ \exists r_P\ \forall c\in\mathcal C\ \forall Q
\in \mathsf{Reach}(P,c,\varepsilon),\qquad
\gamma_Q(s)^{-1}
\le r_P(s,1/\varepsilon,\log(1/\delta)).
$$

Here `Reach(P,c,epsilon)` is the family of reweighted, filtered, or
sample-distribution marginals on which a booster may call the weak learner
before it has driven the original $P$-error below $\varepsilon$.

### Literature Calibration

Schapire's original construction explicitly moves away from the original
distribution. It creates filtered oracles such as the distribution on examples
correctly or incorrectly classified by a previous hypothesis, and it notes the
technical problem that these filters may request examples from a small part of
the original distribution. The proof handles this under the classical
distribution-free weak assumption because there is one polynomial weak edge
$1/p(n,s)$ available for every induced oracle.

Freund's boost-by-majority is a near miss in a different way. The paper's
abstract says the analysis includes an extension where the weak learner's
accuracy depends on the instance distribution. That is still quantitative:
the booster can be analyzed once the distribution-dependent accuracies along
the path are controlled. It does not supply, from the mere statement
`for every Q, some inverse polynomial gap exists`, one polynomial depending
only on the original marginal $P$.

Servedio's SmoothBoost sharpens the test. SmoothBoost constructs distributions
over a sample with $L_\infty(D_t)\le 1/(\kappa m)$ and terminates in
$O(1/(\kappa\gamma^2))$ rounds when every weak call has advantage at least
$\gamma$. In population language, smoothness corresponds to a bounded-density
restriction $Q_t\ll P$ with density about $O(1/\kappa)$. This bounds how hard
the booster may focus, but the theorem still assumes a supplied lower bound
on the weak advantage on every generated distribution.

Hanneke, Moran, and Thiessen's marginal-nonuniform formulation confirms the
relevant quantifier shape: the learning rate may depend on the marginal
distribution $P$, but once $P$ is fixed it must hold uniformly over target
concepts. Their trichotomy and discussion also allow arbitrarily slow
distribution-sensitive rates in the broad marginal-nonuniform setting. This
does not prove a computational separation here, but it is strong evidence
against silently replacing the family of $Q$-dependent rates by one
locally-uniform $P$-dependent polynomial.

Primary sources checked for this branch:

- Schapire, "The Strength of Weak Learnability" (1990):
  https://www.schapire.net/papers/strengthofweak.pdf
- Freund, "Boosting a Weak Learning Algorithm by Majority" (1995):
  https://doi.org/10.1006/inco.1995.1136
- Servedio, "Smooth Boosting and Learning with Malicious Noise" (2003):
  https://jmlr.org/papers/v4/servedio03a.html
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (2025):
  https://openreview.net/forum?id=aoVCFtox89

### Conditional Positive Theorem

**Theorem, conditional on an original-marginal envelope.** Fix a realizable
proper weak learner $A$ satisfying the source. Suppose that for every original
marginal $P$, target accuracy $\varepsilon$, and confidence $\delta$, there
is a polynomial $r_P$ such that every marginal $Q_t$ generated by a chosen
realizable booster before reaching $P$-error $\varepsilon$ satisfies:

1. samples from $Q_t$ can be simulated using samples from $P$ with overhead
   at most $r_P(s,1/\varepsilon,\log(1/\delta))$;
2. the pathwise running time of $A$ on those samples is at most the same kind
   of $P$-dependent polynomial; and
3. $A$ has weak advantage at least
   $1/r_P(s,1/\varepsilon,\log(1/\delta))$ under every such $Q_t$, uniformly
   over targets $c\in\mathcal C_s$.

Then the edge is true for this booster: an efficient marginal-nonuniform
realizable improper learner is obtained by running the booster with weak-gap
guess $1/r_P$ and outputting the boosted vote.

**Proof sketch.** The booster is classical realizable boosting once every
weak call has a common lower bound $\gamma\ge 1/r_P$. Schapire/Freund-style
boosting gives an improper majority or recursive vote with $P$-error at most
$\varepsilon$ after a number of weak calls polynomial in
$1/\gamma$, $1/\varepsilon$, and $\log(1/\delta)$; SmoothBoost gives an
analogous statement with its own dependence on $\kappa$ and $\gamma$. The
simulation and pathwise resource assumptions keep each weak call within a
$P$-dependent polynomial. The final vote is legal because the target node is
improper.

This theorem is useful bookkeeping, but it is not a proof of the atlas edge:
item 3 is precisely the missing envelope.

### Why Filtering Does Not Derive The Envelope

Schapire-style filtering only controls the probability mass of the filtered
regions well enough to keep rejection sampling finite. Before the booster has
already reached error $\varepsilon$, the relevant filters can be forced to
have mass at least a polynomial function of $\varepsilon$, so the induced
marginals often satisfy a density bound of the form

$$
\frac{dQ_t}{dP}\le \operatorname{poly}(1/\varepsilon).
$$

But the source does not say that the weak gap depends polynomially on this
density bound. It only says that for each fixed $Q_t$ there exists some
polynomial in the representation size. A rare-block rate pattern is
compatible with the source:

$$
P=\sum_{j\ge 1} w_jP_j,\qquad
Q_j=P_j=P(\cdot\mid S_j),\qquad
w_j=2^{-j},
$$

and

$$
\gamma_{Q_j}(s)=s^{-j}.
$$

Each $Q_j$ has an inverse-polynomial weak gap. Also
$dQ_j/dP=2^j$. Nevertheless no fixed polynomial in the two variables
$(s,2^j)$ bounds $s^j$ for all $j$: for any $s^a(2^j)^b$, choosing
$j>a+b+1$ and then large $s$ violates the bound. Thus even a clean
bounded-density filtering analysis cannot produce the needed
$r_P(s,1/\varepsilon)$ from the current quantifiers.

This is only an obstruction to a proof route, not a counterexample. One still
has to realize such a gap pattern by a concrete concept class and a single
proper weak learner satisfying the source under every marginal.

### Why SmoothBoost Does Not Repair It

SmoothBoost improves the filtering story by guaranteeing smooth sample
distributions: no sample point receives more than $1/(\kappa m)$ mass. Its
round bound is explicitly in terms of a common weak advantage $\gamma$.

For this edge, the natural population translation is:

$$
Q_t\ll P,\qquad \left\|dQ_t/dP\right\|_\infty
\lesssim 1/\kappa,
$$

with $\kappa$ comparable to the desired final error. This excludes extremely
spiky residual marginals, but it does not relate $\gamma_{Q_t}$ to $P$ or to
$\kappa$ by any polynomial law. The rare-block calculation above survives
with $2^j\le 1/\kappa$: the hidden exponent $j$ can grow like
\(\log(1/\kappa)\), giving $s^j=s^{\log(1/\kappa)}$, which is not bounded by
any fixed bivariate polynomial in $(s,1/\kappa)$.

So SmoothBoost proves a conditional theorem:

$$
\text{bounded-density weak-gap envelope}
\quad\Longrightarrow\quad
\text{marginal-nonuniform strong improper learning}.
$$

It does not prove that the envelope follows from marginal-nonuniform weak
proper learnability.

### Why Same-Marginal Simulation Does Not Repair It

There are two same-marginal ideas, and both stall.

First, one can try rejection sampling: draw from $P$ and accept with
probability proportional to $dQ/dP$. This keeps oracle access ultimately
rooted in $P$, but the weak learner is still being run on accepted examples
distributed as $Q$. The unknown quantity remains $\gamma_Q$, so rejection
sampling only controls sample overhead.

Second, one can try to keep $X\sim P$ exactly and encode the booster's
residual state in labels or weights. This is the philosophy behind
distribution-specific agnostic boosting, but the present source is only
realizable proper weak learning. Its guarantee applies when labels are
$c(X)$ for some concept $c\in\mathcal C$. Generic residual labels,
importance-weighted losses, randomized pseudo-labels, or cost-sensitive
labels are not promised to be realizable by concepts in $\mathcal C$. If the
booster simply calls the weak learner repeatedly on the original realizable
distribution $(P,c)$, the learner may legally return the same weak hypothesis
each time. No residual progress follows.

Thus same-marginal simulation removes neither the need for residual
information nor the need for a residual-responsive oracle.

### Hanneke-Style Quantifier Diagnosis

The target polynomial may depend on the original marginal $P$, but it may not
depend on the target concept $c$ or on the target-dependent boosting path.
However, booster-induced marginals $Q_t$ do depend on $c$ through the errors
of previous hypotheses. The source gives a rate for each such $Q_t$ after
$Q_t$ is fixed; it does not give a modulus saying that all $Q_t$ lying near
$P$ in density, KL, total variation, or filtering complexity share one
polynomial rate.

This is the exact Hanneke-style marginal-nonuniform issue: distribution
sensitivity is pointwise in the marginal. It is not automatically locally
uniform over a family of neighboring marginals. The positive theorem above
would be valid if such local uniformity were added, but the current atlas
node does not include it.

### Rare-Block Obstruction To Any Smooth/Filtering Proof

The most compact obstruction is the following rate envelope test.

Let a fixed original marginal have blocks of masses

$$
w_j=2^{-j},
$$

and suppose that the weak source, on the block conditional $Q_j$, has best
certified gap

$$
\gamma_{Q_j}(s)=s^{-j}.
$$

For every fixed $Q_j$, this is an inverse polynomial, so it is compatible
with marginal-nonuniform weak learning. But for target accuracy
\(\varepsilon\approx 2^{-j}\), any booster that has not already solved block
$j$ may generate a residual marginal comparable to $Q_j$, with density
$O(1/\varepsilon)$. An original-marginal polynomial would have to dominate

$$
s^j=s^{\log_2(1/\varepsilon)}.
$$

No polynomial in $(s,1/\varepsilon)$ can do this uniformly in $j$.

This obstruction is not enough to mark the edge false because it assigns
rates abstractly. A real false witness still needs a class where:

1. one uniform proper weak learner works under every marginal;
2. the weak gaps on rare block conditionals really deteriorate with the block
   index;
3. a fixed original marginal forces strong improper learning to solve
   arbitrarily high-index blocks; and
4. the proper weak handles avoid the near-balanced orientation obstruction
   recorded in the depth-1 scratchpad.

The existing rare-block PRF/singleton-handle templates satisfy the target
hardness intuition but still fail item 4.

### Branch Conclusion

I do not see a proof of the original-marginal weak-gap envelope from the
current source. Schapire/Freund filtering and Servedio SmoothBoost both need
a quantitative lower bound on the weak advantage along induced marginals;
smoothness only bounds density, not the hidden polynomial degree in the
induced marginal's weak gap. Same-marginal simulation either still calls the
weak learner on $Q$ or leaves the realizable source's domain of validity.
Hanneke-style marginal-nonuniform quantifiers support the diagnosis: rates
are pointwise in the marginal unless a local-uniformity modulus is added.

The branch therefore yields a clean conditional theorem but no atlas-ready
resolution. The edge should remain open pending either a genuine
original-marginal envelope theorem or a concrete rare-block counterexample
with orientation-free proper weak handles.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Rare-Block Obstruction Instantiation

- date: 2026-05-07
- branch: rare-block obstruction as a real class or only a no-go template
- edge: `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, bibliography, or legacy LaTeX edited

### Branch Goal

Try to turn the rare-block obstruction into an actual counterexample class:

1. the source should hold by one uniform, efficient, proper weak learner under
   every marginal;
2. the weak advantage should have hidden block-dependent exponents, e.g.
   $\gamma_{Q_j}(s)\approx s^{-j}$ on the $j$th isolated block;
3. under one fixed mixture marginal $P^\star$, every strong improper learner
   should fail at some rare block whose internal scale exceeds the learner's
   $P^\star$-polynomial degree; and
4. the construction should not rely on distribution-specific orientation
   advice, unevaluable improper outputs, or an oracle that gives the weak
   learner semantic access to the marginal.

The verdict is negative for the current deterministic binary PAC semantics:
the rare-block idea remains a no-go template/diagnostic, not an atlas-ready
source-positive target-hard class.

### Candidate Class Shape

The cleanest candidate is still a paired rare-block PRF or random-oracle
class. For sizes $n$ and block levels $j$, let

$$
B_{n,j}=[N_{n,j}]\times\{0,1\},\qquad N_{n,j}=n^j.
$$

A hard concept is active on one block and has one positive atom in each pair:

$$
c_{n,j,k}(u,b)=1\{b=F_k(u)\}
$$

on $B_{n,j}$ and is zero off that block, where $F_k$ is a PRF or a random
oracle bit. Add proper handles such as constants, finite lookup tables,
singletons, co-singletons, or sampled-pair corrections. The intended weak
learner samples from the current marginal, builds a small proper handle from
the observed orientations, validates a few candidates, and outputs one legal
concept.

Under the fixed mixture marginal

$$
P^\star(B_{n,j})=w_{n,j},
$$

with $w_{n,j}$ summable and positive, the target-hardness calculation is
plausible. Given a candidate strong improper learner whose $P^\star$-rate has
degree $D$, choose $j\gg D$ and request
$\varepsilon \ll w_{n,j}$. The learner sees only
$\operatorname{poly}(n)/N_{n,j}$ of the active pairs. A lookup-style improper
output can memorize seen pairs, but predicting fresh unseen pair orientations
with noticeable advantage would distinguish the PRF from random labels. This
part is the useful obstruction geometry.

### Source Audit: The Same Candidate Fails

The source must hold for every marginal, including marginals concentrated on
one hard block. This quantifier is the fatal constraint.

Fix a source learner whose pathwise sample/query bound at size $s$ and
constant confidence is $m=m(s)$. The full-support finite-transcript
convention means $m$ is controlled by one fixed polynomial for this learner;
the learner cannot secretly spend $s^j$ samples only on level-$j$ blocks.
Choose a block with $N=N_{n,j}\gg m(s)^2$.

For a fixed target $c_f(u,b)=1\{b=f(u)\}$, take two realizable marginals on
the same block. Let $A$ be the set of atoms or pair-orientations on which a
given unseen default agrees with $c_f$. Define

$$
P_+(A)=\frac12+\eta,\qquad P_-(A)=\frac12-\eta,
$$

with mass spread nearly uniformly inside $A$ and its complement, and choose

$$
\eta \asymp \frac{m}{N}.
$$

The two $m$-sample transcript distributions have total variation
$O(m\eta)=O(m^2/N)$, so for $N\gg m^2$ no learner can reliably tell whether it
is in the $+$ or $-$ case. But a sparse proper handle corrects only the mass
of sampled pairs, $O(m/N)$. If it uses the wrong unseen default orientation,
its error is still at least $1/2$ after local corrections. Since the labels
are realizable, the source requires error $1/2-\gamma_P(s)$ for some positive
inverse-polynomial $\gamma_P$, so being at or above $1/2$ is a hard failure,
not merely a too-small edge.

This blocks constants, singletons, co-singletons, finite lookup tables with a
default, sampled-pair handles, and collision/pair variants whose only
target-dependent gain comes from observed mass. They all require either
choosing the correct global default orientation or validating a bias at the
hidden $1/N$ scale.

### Attempted Orientation-Free Repairs

I checked the natural repairs against the same source/target requirements.

**Public balanced hashes or code handles.** If an explicit family is
searchable enough that the source learner can find, for every marginal, a
proper handle with positive balanced correlation on both the positive and
negative regions, then an improper strong learner under $P^\star$ can also
search or validate the same public family. That leaks a uniform weak handle
and undermines the intended PRF lower bound.

**Hidden or cryptographic balanced handles.** If the correlated handle is
hidden enough that the target learner cannot find it, the source learner also
cannot find it from arbitrary marginal samples. Empirical validation at
correlation scale $s^{-j}$ costs about $s^{2j}$ samples, which violates the
single pathwise polynomial bound once $j$ is unbounded.

**Pair-balanced gadgets.** Pairing can make the sampled coordinates look
orientation-free under specially structured marginals, but the source
quantifies over arbitrary marginals. A marginal may tilt mass toward the side
where the deterministic unseen behavior is wrong.

**Stochastic neutralization.** A prediction-time fair coin on unseen pairs
would solve the local source problem: seen pairs give advantage about sampled
mass, while unseen pairs contribute exactly $1/2$ error pointwise. But the
source node is proper deterministic binary output, not stochastic prediction
or expected-loss mixtures. Randomly choosing one deterministic default at
training time does not simulate the fair coin; after the choice, one of
$P_+$ or $P_-$ still sees the wrong orientation with constant probability.

### Evaluator And Oracle Issues

The PRF lower bound also needs the standard efficient-output evaluator
convention: after training, a distinguisher evaluates the returned improper
hypothesis on fresh paired points. This is the convention implicitly used by
the atlas PRF witnesses, but the written endpoint definitions do not spell it
out in this edge note. With that convention, the target-hardness side is
reasonable; without it, PRF prediction lower bounds for improper outputs are
not formally available.

Trying to repair the source by giving an oracle the correct orientation of
the current marginal would be cheating. The learner does not receive the
marginal as an input; it sees samples. An oracle with semantic access to
$P_+$ versus $P_-$ is distribution-specific advice, not a standard PAC or
relativized concept-class construction. A shared oracle that exposes enough
information to choose every hidden orientation also risks exposing enough
information for the improper target to aggregate handles.

### Model Forks

Under the current atlas model, I cannot instantiate the rare-block obstruction
as a real counterexample. The precise blockers are:

1. deterministic proper source outputs must choose definite unseen labels;
2. arbitrary near-balanced marginals can require opposite unseen orientations
   while producing statistically indistinguishable finite transcripts;
3. public orientation-free handles tend to make the target learnable;
4. hidden orientation-free handles tend to make the source fail; and
5. PRF target hardness assumes an efficient evaluator convention for improper
   outputs.

There are two nearby conditional forks, both outside the present edge.

**Prediction-time stochastic or expected-mixture outputs.** If the source may
output a stochastic predictor or a convex mixture evaluated by expected loss,
the fair-coin neutralizer on unseen pairs turns the paired rare-block
construction into a plausible conditional false template under PRF
assumptions. This changes proper deterministic binary semantics.

**Size-conditioned marginal semantics.** If marginals were families
$(P_s)_{s\ge 1}$ and each size-$s$ guarantee were evaluated with full mass on
its size slice, diagonal arguments could force or refute different weak-gap
envelopes. That is not the current global-mixture marginal semantics.

### Branch Conclusion

The rare-block construction is still valuable: it explains why bounded-density
or smooth boosting does not automatically give one original-marginal weak-gap
envelope. But as a false witness it is not source-positive under the current
deterministic proper binary model. The missing object is very specific:

> a deterministic, efficiently findable, proper orientation-free hidden-gap
> handle that works under every marginal while remaining computationally
> nonboostable for strong improper learning under a fixed rare-block mixture.

I did not find such an object, and the known repairs either change the model
or collapse one side of the witness.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`


## Depth 4 Branch A: Model Forks And Evaluator Convention

- date: 2026-05-07
- branch: model-fork/evaluator consolidation for proper weak boosting
- edge: `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, bibliography, or legacy LaTeX edited

### Branch Goal

Consolidate the model forks left by the depth-3 rare-block analysis:

1. Would prediction-time stochastic outputs make the rare-block PRF/random-oracle
   construction a conditional false witness?
2. Would explicit mixture-valued outputs do the same?
3. Would merely adding a polynomial-time evaluator convention for improper
   outputs do the same?
4. Does the current deterministic proper binary source semantics still block
   the rare-block route?
5. What is the clean conditional true theorem on the positive side?

The short answer is: stochastic or prediction-time mixture outputs would move
the rare-block route into a plausible conditional-false theorem for a nearby
model, provided the target hypotheses are required to have polynomial-time
evaluators. The evaluator convention alone does not fix the source side. Under
the current atlas source, which outputs deterministic binary concepts
$h\in\mathcal C$, the near-balanced orientation obstruction still blocks the
counterexample. Thus this branch gives conditional model-fork statements, not
a resolution of the present edge.

### Current Output Semantics

The endpoint definitions use ordinary binary PAC language. The source learner
must output a proper hypothesis $h\in\mathcal C$, and the error is ordinary
zero-one error under the sampled marginal. The learner may be randomized while
training, but after its random choices are fixed the returned hypothesis is a
deterministic binary function. This is not the same as prediction-time
randomization.

The target is improper, so the final hypothesis may be outside
$\mathcal C$. For computational hardness arguments, the usual convention
should be made explicit: the learner's output is an efficiently evaluable
representation, and its running time includes producing that representation.
Otherwise PRF-style lower bounds against improper hypotheses are not even
well-posed, because the reduction needs to evaluate the returned predictor on
fresh unseen block points.

This convention is compatible with the atlas README's pathwise polynomial-time
interpretation, but the edge note itself does not currently spell it out.
Adding the convention would sharpen target-hardness arguments; it would not
change the weak proper source guarantee.

### Fork 1: Prediction-Time Stochastic Weak Outputs

If the source model were changed so that a weak learner may output a
prediction-time stochastic predictor and its loss is expected zero-one loss,
then the paired rare-block obstruction becomes a real conditional-false
template.

Use a hard block consisting of pairs $(u,0),(u,1)$ with exactly one positive
atom per pair, determined by a PRF or random oracle bit. A stochastic weak
handle can behave as follows:

- on pairs whose orientation was observed in the training sample, predict the
  observed label correctly;
- on unseen pairs, flip a fair coin at prediction time.

Under any marginal on the block, the unseen part contributes exactly $1/2$
expected error, independent of whether the marginal is tilted toward the
positive or negative atoms. The observed part gives a positive advantage
equal to roughly half the marginal mass of coordinates covered by the sample.
For a fixed marginal this mass can be inverse-polynomial with a marginal-
dependent exponent, which is allowed by marginal-nonuniform weak learning.
Most importantly, no global default orientation has to be chosen.

Under a fixed rare-block mixture $P^\star$, strong learning to
$\varepsilon\ll P^\star(B_{n,j})$ still requires substantially better than
coin-flip prediction on fresh unseen coordinates in the active block. With a
polynomial-time evaluator convention, such a learner would yield the usual
PRF/random-oracle predictor or distinguisher. Thus the rare-block route is
plausibly conditionally false in this stochastic-output model.

This is not the current edge. A stochastic predictor is not a deterministic
proper concept $h\in\mathcal C$.

### Fork 2: Explicit Mixture Outputs

Explicit mixture-valued weak outputs behave the same way if the loss is
prediction-time expected loss. A mixture that places equal weight on the two
unseen defaults, while using memorized proper handles on sampled coordinates,
is just the fair-coin neutralizer in another representation.

This fork can also support a conditional false witness, again assuming:

1. the mixture representation is polynomial-time evaluable;
2. expected prediction loss, not sampled-once deterministic loss, is the
   evaluation criterion; and
3. "proper" is weakened to mean something like "a mixture over proper
   components" rather than "the returned hypothesis is an element of
   $\mathcal C$."

If the learner instead samples one deterministic component at training time
and returns it, the obstruction returns immediately. One of the two
near-balanced marginals sees the wrong unseen default with constant
probability. Therefore the useful fork is prediction-time mixture evaluation,
not ordinary randomized selection of a deterministic proper hypothesis.

Again, this is a different source model from the atlas node.

### Fork 3: Polynomial-Time Evaluator Convention Alone

Adding an explicit polynomial-time evaluator convention for improper target
outputs is necessary for the PRF side of the rare-block lower bound, but it
does not by itself produce a counterexample to the current edge.

The target-hardness argument needs the convention because a reduction from a
strong learner to a PRF distinguisher must run the learned hypothesis on fresh
points. If the learner could output an arbitrary unevaluable object, the
cryptographic prediction argument would have no computational interface.

But the current bottleneck is source-positivity. The source learner must be a
proper deterministic binary weak learner under every marginal, including
marginals concentrated on one hard block and tilted by a tiny amount in
opposite directions. A target evaluator convention says nothing about how the
source learner chooses the correct default orientation on unseen pairs.

So the evaluator convention is:

- necessary for making the rare-block PRF/random-oracle target lower bound
  formal;
- sufficient together with stochastic or prediction-time mixture weak outputs
  to make a nearby conditional false witness plausible; and
- insufficient by itself for the present deterministic proper source.

### Why Current Deterministic Proper Semantics Blocks The False Witness

The blocking lemma is the same hidden-orientation test, now stated as the
model fork boundary.

Fix any deterministic proper weak learner whose pathwise sample and time use
is bounded by a polynomial $m(s)$ under the full-support transcript
convention. Choose a paired hard block with $N\gg m(s)^2$ pair coordinates.
For the same target orientation $f$, define two marginals $P_+$ and $P_-$ on
the block so that the mass of the atoms agreeing with one candidate unseen
default is $1/2+\eta$ under $P_+$ and $1/2-\eta$ under $P_-$, with
$\eta\asymp m(s)/N$.

The $m(s)$-sample transcript distributions under $P_+$ and $P_-$ have tiny
total variation, so the learner cannot reliably choose opposite defaults.
Any finite-exception proper handle only corrects the sampled mass, about
$O(m(s)/N)$. With the wrong unseen default, the error remains at least
$1/2$ up to the same negligible correction, which violates the required
strict weak edge $1/2-\gamma_P(s)$.

Prediction-time fair coins avoid this by making the unseen contribution
exactly $1/2$ under both $P_+$ and $P_-$. Deterministic proper binary
hypotheses cannot do that; they must choose a side.

This is why constants, singletons, co-singletons, finite lookup handles,
sampled-pair handles, and deterministic default-with-exceptions gadgets fail
as source witnesses for the current edge.

### Conditional True Envelope Theorem

The positive side can be stated cleanly as an envelope theorem.

**Conditional theorem.** Let $A$ be the source learner for efficient
marginal-nonuniform weak realizable proper PAC learning. Fix a realizable
booster that may call $A$ on residual, filtered, or reweighted marginals
$Q_t$ derived from an original marginal $P$, target concept $c$, and desired
accuracy/confidence $(\varepsilon,\delta)$.

Suppose that for every original marginal $P$ there is a polynomial $r_P$ such
that, uniformly over all target concepts $c\in\mathcal C_s$ and all
booster-reachable marginals $Q_t$ before the booster reaches $P$-error
$\varepsilon$:

1. samples from $Q_t$ can be simulated using samples from $P$ with overhead
   at most $r_P(s,1/\varepsilon,\log(1/\delta))$;
2. the pathwise runtime of $A$ on those simulated calls is bounded by the
   same kind of $P$-dependent polynomial; and
3. the weak advantage of $A$ under $Q_t$ satisfies
   $$
   \gamma_{Q_t}(s)\ge
   \frac{1}{r_P(s,1/\varepsilon,\log(1/\delta))}.
   $$

Then the edge is true under this extra envelope hypothesis: running
Schapire/Freund-style realizable boosting with this common gap lower bound
produces an improper vote with $P$-error at most $\varepsilon$ in
$P$-dependent polynomial sample size and time.

The proof is exactly classical weak-to-strong boosting once all weak calls
share a common lower bound $\gamma\ge 1/r_P$. Properness of the weak outputs
is harmless because the target allows the final boosted vote to be improper.

The theorem is conditional because item 3 is not implied by the current
marginal-nonuniform source. The source gives only pointwise rates
$\forall Q\,\exists r_Q$; the theorem assumes the missing original-marginal
envelope $\forall P\,\exists r_P\,\forall Q_t\in\mathsf{Reach}(P,c,
\varepsilon)$.

### Consolidated Conclusion

The model forks separate cleanly.

Stochastic prediction-time outputs or expected-loss mixture outputs would
neutralize the rare-block near-balanced orientation obstruction and make the
PRF/random-oracle rare-block construction a plausible conditional false
witness for a neighboring model. That neighboring model should also state the
polynomial-time evaluator convention explicitly so the target lower bound can
query the learned predictor on fresh examples.

The evaluator convention alone does not resolve this edge. It supports the
target-hardness half but leaves the deterministic proper weak source
unverified.

For the current atlas node, the rare-block false route is still blocked by
deterministic proper binary semantics. A proof route still needs the
original-marginal weak-gap envelope stated above. Therefore the present edge
remains open, while the useful output of this branch is conditional-only:
nearby stochastic/mixture models admit a plausible conditional false route,
and the current deterministic model admits a clean conditional true envelope
theorem.

VERDICT: conditional-only

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Weak-Realizable Proper Boosting Consolidation

- date: 2026-05-07
- branch: final consolidation for weak-realizable proper boosting
- edge: `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, bibliography, or legacy LaTeX edited

### Branch Inventory

The earlier branches now point to one stable picture.

Depth 1 identified the main quantifier obstruction. Classical boosting can
use proper weak hypotheses and output an improper vote, so final-output
properness is not the problem. Full-support marginal uniformization also
removes a tempting resource-bound diagonal: because the source learner is one
algorithm with pathwise finite-transcript sample/time bounds, one full-support
reference marginal bounds the resources of every weak call. What remains
nonuniform is the weak advantage.

Depth 2 tested the positive envelope route. Schapire/Freund boosting,
SmoothBoost, bounded-density filtering, same-marginal relabeling, and
dovetailing all require some common lower bound on the weak edge along the
booster path. The source only gives

$$
\forall Q\ \exists \gamma_Q(s)>0,\qquad
\gamma_Q(s)^{-1}\le \operatorname{poly}_Q(s),
$$

while the target needs, for each original marginal $P$,

$$
\exists r_P\ \forall Q_t\in\mathsf{Reach}(P,c,\varepsilon,\delta),\qquad
\gamma_{Q_t}(s)^{-1}
\le r_P(s,1/\varepsilon,\log(1/\delta)).
$$

Depth 3 tested the false rare-block route. Rare PRF or random-oracle blocks
make the target-hardness geometry plausible under one fixed mixture marginal,
but constants, singletons, co-singletons, finite lookup handles, and sampled
pair handles fail to certify the source under arbitrary near-balanced
marginals.

Depth 4 isolated model forks. Prediction-time stochastic predictors or
expected-loss mixtures would neutralize the rare-block orientation problem and
make a nearby conditional-false construction plausible. A polynomial-time
evaluator convention is needed for PRF-style target lower bounds. But neither
fork is part of the present deterministic proper binary source.

The May 5 branches agree: bounded-density compactness, same-marginal
realizable boosting, and relativized rare-block constructions are all useful
diagnostics, but none proves the edge or refutes it.

### Final Positive Attempt: Diagonal Envelope From Bad Residuals

The last plausible theorem attempt is a diagonal or stitching argument:
suppose the original-marginal envelope fails for some $P$. Then there are
reachable residual marginals $Q_j$ and accuracies $\varepsilon_j$ whose weak
gaps have representation-size exponents escaping every candidate polynomial,
for example

$$
\gamma_{Q_j}(s)^{-1}\ge s^j.
$$

Can one stitch the $Q_j$ into one marginal

$$
R=\sum_j \alpha_j Q_j
$$

and use the source guarantee on $R$ to force one polynomial envelope over the
components?

This does not work under the current global-mixture semantics. The weak
guarantee on $R$ only asks for error below $1/2-\gamma_R(s)$ on the mixture.
The learner may ignore components whose weights are below the mixture-level
advantage scale. If the $\alpha_j$ decay fast enough to form a probability
distribution, then for any fixed inverse-polynomial $\gamma_R$ all sufficiently
light components are statistically invisible to the weak requirement. If the
$\alpha_j$ are kept heavy enough to force attention to every bad component,
there can be only finitely many such components. Thus the stitching argument
does not turn

$$
\forall Q_j\ \exists \operatorname{poly}_{Q_j}
$$

into

$$
\exists \operatorname{poly}_P\ \forall j.
$$

This is the same reason finite covers at each fixed $\varepsilon$ do not yield
a PAC polynomial envelope: the maximum weak-gap exponent may grow with the
active rare block, and the polynomial in $(s,1/\varepsilon)$ must have fixed
degree once $P$ is fixed.

So the positive theorem remains conditional, not derivable from the current
source node.

### Conditional True Envelope

The clean positive statement is:

**Conditional theorem.** Let $A$ be the source learner. Fix any realizable
boosting procedure whose weak calls use residual, filtered, reweighted, or
smooth marginals $Q_t$ derived from an original marginal $P$, target
$c\in\mathcal C_s$, and requested $(\varepsilon,\delta)$. Suppose that for
every original marginal $P$ there is a polynomial $r_P$ such that, uniformly
over targets and over every booster-reachable $Q_t$ before the booster reaches
$P$-error $\varepsilon$:

1. samples from $Q_t$ can be simulated from samples from $P$ with overhead at
   most $r_P(s,1/\varepsilon,\log(1/\delta))$;
2. the pathwise runtime of $A$ on those weak calls is bounded by the same kind
   of $P$-dependent polynomial; and
3. the weak advantage satisfies
   $$
   \gamma_{Q_t}(s)\ge
   1/r_P(s,1/\varepsilon,\log(1/\delta)).
   $$

Then the edge is true under this extra hypothesis. Run the booster with the
common gap lower bound supplied by item 3. Schapire/Freund-style realizable
boosting produces a finite vote of proper weak hypotheses with
$P$-error at most $\varepsilon$ after a number of weak calls polynomial in
$1/\gamma$, $1/\varepsilon$, and $\log(1/\delta)$. The vote is a legal target
output because the target node is improper, and items 1 and 2 keep the total
sample use and running time within a $P$-dependent polynomial.

This theorem should be recorded only as a conditional envelope theorem. The
present source gives pointwise marginal-dependent weak gaps, not item 3.

### Final Counterexample Attempt: Deterministic Rare-Block Repair

The last false attempt was to repair the rare-block PRF/random-oracle template
with deterministic orientation-free proper handles.

The target-hardness half is still compelling. Let a block be paired:

$$
B_{n,j}=[N_{n,j}]\times\{0,1\},\qquad N_{n,j}=n^j,
$$

and let the target choose one positive atom per pair using a PRF or random
oracle bit. Under a fixed mixture marginal $P^\star$, a strong improper
learner with $P^\star$-polynomial degree $D$ can be attacked by choosing
$j\gg D$ and asking for $\varepsilon$ below the mass of block $j$. The learner
then sees too few pair coordinates; an efficiently evaluable improper
hypothesis that predicts fresh pair orientations would give a PRF predictor
or random-oracle contradiction.

The source side still breaks. Fix a deterministic proper weak learner using
at most $m(s)$ samples/queries on finite transcripts. Pick a paired block with
$N\gg m(s)^2$. For the same target orientation $f$, define two marginals on
that block:

$$
P_+(\text{mass on atoms labeled }1\text{ by }f)=1/2+\eta,
\qquad
P_-(\text{mass on atoms labeled }1\text{ by }f)=1/2-\eta,
$$

with mass nearly uniform inside each side and $\eta\asymp m(s)/N$. The two
$m(s)$-sample transcript distributions have total variation
$O(m(s)\eta)=O(m(s)^2/N)$, so the learner cannot reliably choose opposite
unseen defaults. A finite-exception proper handle based on the transcript can
correct only $O(m(s)/N)$ mass. With the wrong default orientation, its error
is at least $1/2$ after those corrections, violating the strict weak
requirement.

The same test blocks the deterministic repairs checked so far:

- Public balanced hash or code handles are searchable enough that a strong
  improper learner can validate or aggregate them, and arbitrary marginals can
  concentrate on the side where their deterministic unseen behavior is wrong.
- Hidden balanced handles preserve target hardness but are not findable by
  the source learner without validation at the hidden correlation scale.
- Pair-balanced gadgets help only for structured marginals; the source
  quantifies over all marginals.
- Randomized training that samples one deterministic default is not enough;
  after the output is fixed, one of $P_+$ or $P_-$ still sees the wrong
  orientation.

This is not a general impossibility theorem for every imaginable
deterministic proper handle. It is, however, enough to kill the known
rare-block singleton, lookup, pair, and default-with-exception templates. A
resolved-false proof would need a new object:

> a deterministic, efficiently findable, proper orientation-free hidden-gap
> handle that works under every marginal while remaining computationally
> nonboostable for strong improper learning under one fixed mixture marginal.

I do not have such an object.

### Evaluator And Stochastic False Forks

The evaluator convention should be separated from the source obstruction.
For any PRF-style lower bound against the improper target, the learned
hypothesis must have an efficiently evaluable representation; otherwise the
distinguisher cannot query the output on fresh unseen block points. Adding
this convention makes the target-hardness half formalizable, but it does not
help the deterministic proper source choose hidden orientations.

The stochastic fork is genuinely different. If the source were allowed to
return a prediction-time stochastic proper handle, or an explicit mixture over
proper handles evaluated by expected zero-one loss, then the rare-block source
side becomes plausible:

- memorize sampled pair orientations;
- on unseen pairs, flip a fair coin at prediction time.

The unseen region then contributes exactly $1/2$ expected error under every
marginal, independent of the positive/negative tilt. The observed region gives
a positive marginal-dependent advantage. Under the fixed rare-block mixture,
strong learning below a block's mass would still require nontrivial prediction
of fresh PRF/random-oracle orientations, assuming an efficient evaluator
convention.

That is a conditional false route for a neighboring stochastic-output or
expected-mixture model, not for the current deterministic binary proper source.

### Proposed Atlas Text

If atlas edits are later permitted, the edge should remain open. Suggested
frontmatter posture:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: realizable boosting would require one original-marginal polynomial controlling weak advantages on booster-induced residual marginals. Rare-block PRF/handle templates suggest possible target hardness, but currently fail to certify the arbitrary-marginal deterministic proper weak source because near-balanced blocks require a hidden default-orientation test."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested body wording:

```markdown
The obstacle is a weak-gap envelope, not the final boosted vote and not the
pathwise resource bound of one weak call. Since the source learner is a single
algorithm and atlas efficiency is worst-case over finite sample transcripts,
full-support marginal uniformization controls sample use and running time.
It does not turn pointwise marginal-dependent weak advantages on residual
marginals into one polynomial depending only on the original marginal.

A conditional positive theorem follows if every booster-induced marginal has
a weak advantage bounded below by one original-marginal polynomial. Standard
realizable boosting then gives an improper vote. The current source definition
does not imply that envelope.

The leading false route uses rare PRF or random-oracle blocks. It plausibly
defeats strong improper learning under one fixed mixture marginal, assuming
learned improper hypotheses are efficiently evaluable. But the same templates
fail the source under arbitrary near-balanced block marginals: deterministic
proper weak hypotheses must choose an unseen default orientation, and sparse
sampled corrections cannot rescue the wrong orientation. Prediction-time
stochastic or expected-mixture outputs would avoid this in a neighboring
model, but they are not the present proper binary PAC semantics.
```

### Consolidated Verdict

No atlas-ready proof was found. No atlas-ready counterexample was found.

The strongest result from this branch is conditional-only evidence around the
open edge: a true theorem under an explicit original-marginal weak-gap
envelope, and a plausible false fork for stochastic or expected-mixture output
models with efficient evaluators. Under the current deterministic proper
source, the rare-block false route is still blocked by near-balanced
orientation tests.

VERDICT: unresolved

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`

## Depth 6 Branch A: Finite Residuals Do Not Force Envelopes

- date: 2026-05-07
- branch: finite booster paths, global mixtures, and the missing envelope
- edge: `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, bibliography, or legacy LaTeX edited

### Question Tested

The narrow question is whether the current atlas semantics force an
original-marginal envelope once the booster makes only finitely many weak
calls for a fixed target accuracy. In symbols, can one derive

$$
\forall P\ \exists r_P\ \forall c,\varepsilon,\delta,\rho,t,\qquad
\gamma_{Q_t(P,c,\varepsilon,\delta,\rho)}(s)^{-1}
\le r_P(s,1/\varepsilon,\log(1/\delta))
$$

from the source guarantee

$$
\forall Q\ \exists p_Q,\gamma_Q,\qquad
\gamma_Q(s)^{-1}\le p_Q(s)?
$$

Here $\rho$ denotes the booster's internal randomness or validation
transcript, and $Q_t$ ranges over residual, filtered, reweighted, or smooth
marginals generated before the booster has already achieved $P$-error
$\varepsilon$.

### Finite-Path Maxima Are Too Weak

For one fixed numerical tuple $(P,c,\varepsilon,\delta,\rho)$, a finite
booster path visits only finitely many marginals

$$
Q_1,\ldots,Q_T.
$$

For that single path, the source gives finitely many polynomials
$p_{Q_1},\ldots,p_{Q_T}$, so their pointwise maximum is again a polynomial in
$s$. This observation is true but insufficient. The target learner does not
need a separate polynomial for each target concept, accuracy, validation
transcript, or realized booster path. Once $P$ is fixed, the target needs one
polynomial in the variables $(s,1/\varepsilon,\log(1/\delta))$ whose degree is
fixed independently of all of those choices.

The finite maximum can have a degree that grows with the requested accuracy.
A canonical obstruction is:

$$
\varepsilon_j=2^{-j},\qquad
\gamma_{Q_j}(s)^{-1}=s^j.
$$

For each fixed $\varepsilon_j$, the residual menu $\{Q_j\}$ is finite and
$s^j$ is a polynomial in $s$. But no bivariate polynomial

$$
r(s,u)=C s^a u^b
$$

dominates all values $s^j$ at $u=1/\varepsilon_j=2^j$. If $j>a$, then
$C2^{bj}s^a<s^j$ for all sufficiently large $s$. Thus "finite for each
epsilon" does not imply "polynomial in $(s,1/\varepsilon)$" unless there is
an additional uniform bound on the degree growth.

This also explains why bounded-density or smooth residuals do not by
themselves repair the issue. If $Q_j$ is a block conditional of an original
mixture with block mass $2^{-j}$, then $dQ_j/dP=2^j=1/\varepsilon_j$. A
density parameter controls the second input $u=1/\varepsilon$, but the hidden
degree of $s$ may still be $j=\log_2 u$, yielding the quasipolynomial
quantity $s^{\log u}$ rather than a fixed polynomial in $(s,u)$.

### Why The Global-Mixture Diagonal Fails

The natural diagonal proof attempt is to stitch all bad residual marginals
into one marginal

$$
R=\sum_{j\ge 1}\alpha_j Q_j
$$

and then apply the source guarantee to $R$. If this forced the source learner
to have weak advantage on every component $Q_j$, one might recover an
envelope by contradiction.

The current global-mixture semantics do not force that. For a hypothesis $h$,
write the component advantage as

$$
A_j(h)=\frac12-\operatorname{err}_{Q_j}(h,c).
$$

The mixture guarantee controls only the weighted average

$$
\sum_j \alpha_j A_j(h)
\ge \gamma_R(s).
$$

It does not imply $A_j(h)>0$ on each component. A learner may be wrong, or
essentially random, on a sufficiently light component as long as heavier
components supply the average advantage. Since the weights $\alpha_j$ must be
summable, for every inverse-polynomial scale $\gamma_R(s)$ there are
arbitrarily far components whose weights are below the scale at the relevant
sizes. Those components are invisible to the weak requirement on the mixture.

There is an even simpler version in the rare-block learning geometry. If a
target is active only on a block of $R$-mass $\alpha_j$, then a constant
predictor can already have error far below $1/2$ on the full mixture when
$\alpha_j$ is small. The source guarantee under $R$ therefore need not learn
the conditional problem on $Q_j$ at all. To force attention to every bad block,
the blocks would all need non-negligible weight at the same weak-advantage
scale, but a probability distribution can have only finitely many such
blocks.

This is the precise point where global-mixture marginal semantics defeat the
diagonal theorem. A size-conditioned marginal semantics, where each size slice
could carry full mass separately, might force a different compactness or
diagonal argument. The atlas definitions currently use a single global
marginal distribution, and under that reading low-mass slices may be ignored
by weak learning until the target accuracy asks the strong learner to resolve
them.

### Does This Give An Atlas-Valid Counterexample?

No. It gives a valid obstruction to proving the envelope from semantics alone,
but it is not yet a false witness for the edge.

The abstract rate pattern

$$
\gamma_{Q_j}(s)=s^{-j}
$$

is compatible with marginal-nonuniform weak guarantees, and it explains how a
fixed mixture marginal $P^\star$ could defeat any proposed strong learner:
put hard blocks at masses $w_j$, ask for $\varepsilon\ll w_j$, and choose a
block index whose hidden exponent exceeds the $P^\star$-polynomial degree.
But an atlas counterexample must realize this rate pattern by one concrete
concept class and one uniform deterministic proper weak learner that works
under every marginal.

The known rare-block PRF/random-oracle templates still fail exactly there.
For a paired hard block with $N$ coordinates, fix a deterministic proper weak
learner with global pathwise sample bound $m(s)$, using full-support resource
uniformization. Choose $N\gg m(s)^2$. For the same target orientation, define
two near-balanced marginals on the block:

$$
P_+(\text{target-positive atoms})=\frac12+\eta,\qquad
P_-(\text{target-positive atoms})=\frac12-\eta,
\qquad
\eta\asymp \frac{m(s)}{N}.
$$

The $m(s)$-sample transcript distributions have total variation
$O(m(s)\eta)=O(m(s)^2/N)$, so the learner cannot reliably tell which default
orientation is needed. A deterministic proper finite-exception handle can
correct only $O(m(s)/N)$ mass. With the wrong unseen default, its error is at
least $1/2$ up to negligible corrections, violating the strict weak source
requirement.

This is where properness matters. The target may output an improper boosted
vote, so final-output properness is harmless on the positive route. But the
source weak calls must output actual deterministic concepts in the class.
Prediction-time fair coins or explicit expected-loss mixtures would neutralize
the unseen part of a paired block, but those are not proper deterministic
binary concepts. Public deterministic balanced handles tend to be searchable
by the strong improper learner; hidden deterministic balanced handles tend not
to be findable by the source under arbitrary marginals. Thus the global-mixture
obstruction is not yet an atlas-valid counterexample.

### Result Of This Branch

The branch rules out one tempting positive proof:

> Current atlas semantics do not force an original-marginal weak-gap envelope
> merely because a booster visits finitely many residual distributions at each
> fixed target accuracy.

Finite residual menus give finite maxima with degrees that may grow with
$1/\varepsilon$, and global-mixture diagonalization cannot force weak accuracy
componentwise on infinitely many rare residuals. This supports keeping the
edge open, not marking it true.

It also does not justify marking the edge false. A false atlas update still
needs a deterministic proper, orientation-free, efficiently findable weak
handle construction that survives arbitrary near-balanced marginals while
remaining nonboostable under one fixed mixture marginal. I do not have such a
construction.

### Depth-7 Directions

1. Formalize the finite-epsilon degree-growth lemma as a standalone
   obstruction: for residual gaps $s^{-j}$ at accuracies $2^{-j}$, every
   fixed finite path is polynomial in $s$, but no original-marginal polynomial
   in $(s,1/\varepsilon)$ exists.

2. Search specifically for deterministic proper orientation-free handles.
   The target object is a proper concept family where sampled evidence gives
   positive weak advantage under every marginal without choosing an unseen
   default orientation, while public search over those handles does not give
   the improper strong learner enough independent handles to boost.

3. Compare the current global-mixture semantics with a size-conditioned
   variant. If size-conditioned marginals force a diagonal envelope, that
   would clarify that the present obstruction is semantic rather than a
   classical boosting issue.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md

## Depth 7 Branch A: Final Consolidation

- date: 2026-05-07
- branch: final depth consolidation
- edge: `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
- write constraint: appended only to this scratchpad; no atlas files, bibliography, or legacy LaTeX edited
- semantics fixed here: deterministic binary proper weak outputs; deterministic binary improper target outputs, with the usual efficient-evaluator convention needed for computational lower bounds

### Final Goal

This is the last allowed depth for the edge. I tried once more to force either
side:

1. prove a true implication by deriving an original-marginal weak-gap envelope
   from the current marginal-nonuniform weak source; or
2. prove a false implication by completing a rare-block computational witness
   whose weak source remains deterministic, proper, binary, and valid under
   every marginal.

Neither route closes. The best final state is an atlas-ready open-edge note:
the exact obstruction is a quantifier swap over weak advantages, and the best
false templates still fail at deterministic proper source semantics.

### Exact Quantifier Obstruction

The source has the following shape. There is one uniform proper weak learner
$A$ such that

$$
\forall Q\ \exists p_Q,\gamma_Q\ \forall c\in\mathcal C_s\ \forall\delta,
\qquad
\operatorname{err}_Q(A(Q,c),c)\le \frac12-\gamma_Q(s),
$$

with $1/\gamma_Q(s)$ and the resources of $A$ bounded by the
$Q$-dependent polynomial $p_Q(s,\log(1/\delta))$. The polynomial may depend
on the marginal $Q$, but not on the target concept.

The target requires one strong learner $B$ such that

$$
\forall P\ \exists r_P\ \forall c\in\mathcal C_s\ \forall\varepsilon,\delta,
\qquad
\operatorname{err}_P(B(P,c,\varepsilon,\delta),c)\le\varepsilon
$$

with resources bounded by the $P$-dependent polynomial
$r_P(s,1/\varepsilon,\log(1/\delta))$, independent of $c$.

A standard realizable booster using $A$ would need the intermediate statement

$$
\forall P\ \exists r_P\ \forall c,\varepsilon,\delta,\rho,t,\qquad
\gamma_{Q_t(P,c,\varepsilon,\delta,\rho)}(s)^{-1}
\le r_P(s,1/\varepsilon,\log(1/\delta)),
$$

where $Q_t$ ranges over residual, filtered, reweighted, or smooth marginals
generated before the booster has already achieved $P$-error $\varepsilon$,
and $\rho$ denotes any validation transcript or internal randomness.

The invalid step is therefore:

$$
\forall Q\ \exists p_Q
\quad\not\Rightarrow\quad
\forall P\ \exists r_P\ \forall Q_t\in\mathsf{Reach}(P,c,\varepsilon,\delta).
$$

For a fixed numerical path there are only finitely many $Q_t$, so the maximum
of their finitely many polynomials is a polynomial in $s$. This observation
does not give the target. The degree of that finite maximum may depend on
$c$, on the requested accuracy, or on the residual transcript. The target
needs one fixed polynomial degree after $P$ is fixed.

The canonical obstruction remains:

$$
\varepsilon_j=2^{-j},\qquad
\gamma_{Q_j}(s)^{-1}=s^j.
$$

Each fixed $Q_j$ has an inverse-polynomial weak gap, but no polynomial in
$(s,1/\varepsilon)$ dominates $s^j$ at $1/\varepsilon=2^j$ for all $j$.
Bounded density gives the same obstruction: even if $dQ_j/dP=2^j$, the
quantity $s^j=s^{\log_2(1/\varepsilon)}$ is only quasipolynomial in the two
parameters, not polynomial.

### Last Positive Attempt: Heavier Diagonal Mixtures

Depth 6 ruled out the simplest global-mixture diagonal because low-mass bad
components can be ignored by weak learning. The last possible repair is to
choose size markers $s_j$ growing so fast that summable weights such as
$\alpha_j=1/j^2$ are still larger than every inverse polynomial in $s_j$.
Then, if a stitched marginal

$$
R=\sum_j\alpha_jQ_j
$$

had weak advantage $\gamma_R(s)\ge s^{-a}$, component $j$ would not be
invisible at size $s_j$, since $\alpha_j\gg s_j^{-a}$.

This still does not derive the envelope from the current semantics. The weak
guarantee on $R$ is an average guarantee for each single target concept:

$$
\sum_j \alpha_j
\left(\frac12-\operatorname{err}_{Q_j}(h,c)\right)
\ge \gamma_R(s).
$$

It does not force the learner to have positive advantage on a designated bad
component. If the target is active only on that component, constants or other
off-component behavior may already give a large mixture advantage. If one
tries to neutralize all other components so that only the bad component can
contribute advantage, that requires closure or balancing structure in the
concept class that the endpoint definition does not provide. Thus even
carefully weighted size markers do not turn the pointwise marginal guarantee
into a componentwise envelope theorem.

This is a semantic obstruction, not a classical boosting issue. A
size-conditioned variant of the model might support a different diagonal
argument, but the current atlas definitions use one global marginal and
ordinary zero-one error under that marginal.

### Conditional True Principles

The following principles are safe to record as conditional, not as the present
edge.

**Original-marginal envelope boosting.** If for each original marginal $P$
there is a polynomial $r_P$ controlling all booster-reachable weak gaps,

$$
\gamma_{Q_t}(s)\ge
1/r_P(s,1/\varepsilon,\log(1/\delta)),
$$

uniformly over targets and residual transcripts before reaching
$P$-error $\varepsilon$, then Schapire/Freund-style realizable boosting gives
the target. The final vote is allowed because the target is improper.

**Bounded-density or smooth envelope.** It is enough to prove a local-stability
modulus of the form

$$
Q\ll P,\quad \|dQ/dP\|_\infty\le B
\quad\Longrightarrow\quad
\gamma_Q(s)^{-1}\le r_P(s,B)
$$

for one polynomial $r_P$. Smooth or filtering boosters would then set
$B=\operatorname{poly}(1/\varepsilon)$. The current source does not imply this
modulus.

**Residual-responsive same-marginal oracle.** Same-marginal agnostic boosting
would be relevant if the source accepted residual labels, costs, or a tunable
correlation oracle under the original marginal $P$. The present source is
realizable proper weak PAC only: its guarantee applies to labels $c(X)$ for
$c\in\mathcal C$, not to arbitrary residual or soft labels.

**Neighboring stochastic-output false fork.** If the source output were a
prediction-time stochastic proper handle, or an explicit mixture over proper
handles evaluated by expected zero-one loss, rare paired blocks would become
a plausible conditional false construction under PRF or random-oracle
assumptions. That fork changes the deterministic binary proper source
semantics and is not this edge.

### Failed False-Witness Templates

The final false route would need a class that is weakly properly learnable
under every marginal, but not strongly improperly learnable under one fixed
marginal. The tested templates fail as follows.

| Template | Why It Looked Promising | Why It Fails Here |
| --- | --- | --- |
| Plain PRF classes | Strong improper learning is cryptographically hard under the usual hard marginal. | The same hard marginal defeats even weak learning; no inverse-polynomial weak edge is available. |
| Fixed-$k$-term DNF | Separates weak proper from strong proper under standard assumptions. | The target is improper, so boosted votes or other improper aggregates are legal. |
| One-way image-coordinate weak handles | Constants and atom handles give weak proper behavior in the recorded witness. | The known lower bound is proper; an improper target can memorize or lookup sparse atoms. |
| Rare-block PRF/random-oracle with singleton or finite-exception handles | A fixed mixture marginal can hide a hard block whose size beats any proposed target polynomial. | Source must work on marginals isolating a single block and nearly balanced between the two label orientations; deterministic finite-exception handles must choose a hidden unseen default. |
| Public balanced hashes or code handles | Could avoid simple default bias. | If public and searchable enough for the weak learner, they are also available to the strong improper learner for validation and aggregation. |
| Hidden balanced handles | Could preserve target hardness. | If hidden enough to defeat the target learner, the source learner cannot find them from arbitrary marginal samples at the needed hidden correlation scale. |
| Prediction-time randomization or expected mixtures | Fair coins on unseen pairs neutralize the orientation problem. | This leaves deterministic binary proper PAC semantics. Sampling one deterministic hypothesis at training time does not help. |
| Polynomial-time evaluator convention for the target | Needed to make PRF lower bounds against improper outputs formal. | It only helps the target-hardness argument; it does not make the deterministic proper source weakly learnable. |

The reusable source obstruction for the rare-block family is the
near-balanced orientation test. Fix a deterministic proper learner with
pathwise sample bound $m(s)$ and a paired block with $N\gg m(s)^2$ pairs. For
one target orientation, define two marginals $P_+$ and $P_-$ so that the mass
of atoms agreeing with one candidate unseen default is $1/2+\eta$ under
$P_+$ and $1/2-\eta$ under $P_-$, with $\eta\asymp m(s)/N$. The two
$m(s)$-sample transcript distributions have total variation
$O(m(s)^2/N)$. A finite-exception handle can correct only $O(m(s)/N)$ mass.
Therefore a learner that cannot reliably choose opposite unseen defaults has
error at least $1/2$ on one of the two marginals, contradicting the strict
weak requirement. This blocks the known deterministic default, singleton,
co-singleton, lookup, and sampled-pair repairs.

This is not a theorem excluding every possible deterministic proper handle.
It identifies the missing object for a resolved-false proof:

> a deterministic, efficiently findable, proper, orientation-free weak handle
> that works under every marginal while remaining computationally
> nonboostable for strong deterministic improper learning under one fixed
> mixture marginal.

No such object emerged in the depth-7 search.

### Atlas-Ready Summary

Suggested frontmatter posture if atlas edits are later allowed:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: boosting would be valid under an original-marginal weak-gap envelope for booster-induced residual marginals, but the current source only gives pointwise marginal-dependent weak gaps. Rare-block PRF/handle templates suggest possible target hardness, but deterministic proper weak handles still fail near-balanced orientation tests under arbitrary marginals."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested proof-status body:

```markdown
**Goal.** Decide whether efficient marginal-nonuniform weak realizable proper
PAC learning boosts to efficient marginal-nonuniform realizable improper PAC
learning.

**Conditional positive theorem.** The implication is true under an additional
original-marginal weak-gap envelope. Namely, fix the original marginal $P$.
If all residual, filtered, reweighted, or smooth marginals $Q_t$ generated by
a realizable booster before reaching $P$-error $\varepsilon$ have weak
advantage at least
$1/r_P(s,1/\varepsilon,\log(1/\delta))$ for one $P$-dependent polynomial
$r_P$, then ordinary weak-to-strong boosting outputs a deterministic improper
vote with $P$-error at most $\varepsilon$.

**Why this is not a proof.** The source gives only
$\forall Q\,\exists p_Q$, while the target-side boosting proof needs
$\forall P\,\exists r_P\,\forall Q_t\in\mathsf{Reach}(P,c,\varepsilon,\delta)$.
Finite booster paths only give finite maxima whose polynomial degree may
depend on the target or requested accuracy. Bounded density and SmoothBoost
control how residual marginals concentrate mass, but they do not bound the
degree hidden in the residual marginal's weak advantage. Same-marginal
boosting does not apply because the source is realizable proper PAC, not a
residual-label or cost-sensitive weak oracle.

**Counterexample status.** Plain PRF classes fail the weak source, and
fixed-$k$-term DNF only separates proper strong learning. Rare-block
PRF/random-oracle templates come closest to a false witness: one fixed
mixture marginal can make strong deterministic improper learning hard on a
sufficiently large rare block, assuming learned hypotheses are efficiently
evaluable. The source side remains unproved. Under marginals concentrated on
one paired block and nearly balanced between the two label orientations,
deterministic proper finite-exception handles must choose a hidden unseen
default; sampled corrections cannot rescue the wrong default. Public balanced
handles tend to make the target learnable, hidden balanced handles tend not
to be findable by the source, and prediction-time stochastic or expected
mixture handles belong to a different model.

**Conclusion.** Keep the edge open. A true proof needs an original-marginal
weak-gap envelope or an equivalent local-uniformity theorem. A false proof
needs a deterministic proper orientation-free weak-handle construction that
survives arbitrary near-balanced marginals while remaining nonboostable by
deterministic improper learners under a fixed marginal.
```

### Final Verdict

The edge is not resolved at depth 7. The strongest atlas-ready contribution
is a sharpened open proof status: the positive side is exactly an
original-marginal weak-gap envelope problem, and the negative side is exactly
a deterministic proper orientation-free handle problem. Conditional true and
neighboring stochastic/mixture false principles are clear, but neither is the
current deterministic binary proper-source to deterministic improper-target
edge.
VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md
