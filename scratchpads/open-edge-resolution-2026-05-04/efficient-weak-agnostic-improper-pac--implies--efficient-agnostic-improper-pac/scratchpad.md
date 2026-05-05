# Open Edge Resolution Scratchpad

Edge: `efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `agnostic-boosting-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

Source node: `efficient-weak-agnostic-improper-pac`.

The source learner is distribution-free and agnostic. For some fixed additive tolerance
$\beta < 1/2$, with polynomial samples and time, it outputs an arbitrary hypothesis
$h$ such that
$$
\operatorname{err}_{\mathcal D}(h) \leq
\operatorname{opt}_{\mathcal C}(\mathcal D)+\beta.
$$
The final hypothesis is allowed to be improper.

Target node: `efficient-agnostic-improper-pac`.

The target learner must, for every requested $\varepsilon>0$, output an arbitrary
hypothesis $h$ in polynomial time and samples such that
$$
\operatorname{err}_{\mathcal D}(h) \leq
\operatorname{opt}_{\mathcal C}(\mathcal D)+\varepsilon.
$$

In $\{\pm1\}$ notation, if
$\rho^*=\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)$, the atlas source
guarantee implies
$$
\operatorname{corr}_{\mathcal D}(h)\geq \rho^* - 2\beta.
$$
Thus it is a fixed-additive approximation to the best correlation, not an
$\varepsilon$-accurate agnostic learner.

### Sources Checked

Local atlas context:

- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/registry/edge_families.yml`

Primary and near-primary external sources:

- Ben-David, Long, and Mansour, "Agnostic Boosting", COLT/EuroCOLT 2001, DOI:
  https://doi.org/10.1007/3-540-44581-1_33
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic
  Learning", JMLR 2003: https://www.jmlr.org/papers/v4/gavinsky03a.html
- Kalai, Mansour, and Verbin, "On agnostic boosting and parity learning",
  STOC 2008, DOI: https://doi.org/10.1145/1374376.1374466
- Kanade and Kalai, "Potential-Based Agnostic Boosting", 2009:
  https://www.cs.ox.ac.uk/people/varun.kanade/docs/potential-KK09.pdf
- Feldman, "Distribution-Specific Agnostic Boosting", 2009:
  https://vtaly.net/papers/F_AgnosticBoosting_111609.pdf
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", NeurIPS 2024:
  https://arxiv.org/abs/2410.23632
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data",
  ICML 2025 / PMLR: https://proceedings.mlr.press/v267/ghai25a.html and
  arXiv: https://arxiv.org/abs/2503.04706
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting",
  NeurIPS 2025: https://arxiv.org/abs/2503.09384
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", ALT 2026: https://arxiv.org/abs/2601.11265

### Theorem And Counterexample Attempts

Attempt 1: apply the original fixed-additive agnostic boosters.

Ben-David--Long--Mansour use essentially the same $\beta$-weak agnostic notion
as the atlas source. Gavinsky improves the boosting guarantee, but the guarantee
is still of the form roughly
$$
\operatorname{err} \lesssim
\frac{\operatorname{opt}_{\mathcal C}}{1/2-\beta}+\zeta,
$$
not $\operatorname{opt}_{\mathcal C}+\varepsilon$. This is useful when
$\operatorname{opt}_{\mathcal C}$ is very small, but it leaves a multiplicative
loss on the agnostic optimum. It therefore does not resolve this edge as `true`.
The lower-bound discussion in Gavinsky is also only a black-box boosting
obstruction, not an atlas counterexample class, so it does not resolve the edge
as `false`.

Attempt 2: translate the atlas source into the modern multiplicative-correlation
weak oracle.

Modern agnostic boosting papers often assume an oracle satisfying
$$
\operatorname{corr}(W)\geq
\gamma \sup_{c\in\mathcal C}\operatorname{corr}(c)-\varepsilon_0.
$$
The atlas fixed-additive learner does imply such an oracle with constant
parameters. Indeed, from
$\operatorname{corr}(h)\geq\rho^*-2\beta$ and the trivial bound
$\operatorname{corr}(h)\geq -1$, choose any
$\gamma\in(1/(2(1-\beta)),1)$ and set
$\varepsilon_0=1-\gamma(1-2\beta)$. Then $\gamma>\varepsilon_0$, and for every
$\rho^*\in[-1,1]$,
$$
\max\{-1,\rho^*-2\beta\}
\geq
\gamma\rho^*-\varepsilon_0.
$$
If one assumes $\rho^*\geq0$ by closure under negation or an available
nonnegative-correlation fallback, the simpler choice $\varepsilon_0=2\beta$ also
works. In either version, the conversion is nontrivial exactly because
$\beta<1/2$. Thus the source is not obviously too weak for the newest "any
nontrivial weak learner" formulations.

Attempt 3: apply efficient modern agnostic boosting directly.

Ghai--Singh 2024 and the ICML 2025 unlabeled-data version are computationally
efficient, but their final guarantee contains an unavoidable term such as
$2\varepsilon_0/\gamma$ plus the target boosting error. To get arbitrary
excess $\varepsilon$, their framework needs $\varepsilon_0=O(\gamma\varepsilon)$.
The atlas source supplies only a fixed positive weak-oracle slack, so these
theorems do not turn the source node into the target node.

Attempt 4: apply da Cunha--Hogsgaard--Paudice 2026.

This is the closest positive evidence. Their ALT 2026 result explicitly
leverages any nontrivial agnostic weak learner with $\gamma_0>\varepsilon_0$,
which the atlas source can provide by the calculation above. It then achieves
near-optimal agnostic excess error statistically. However, the stated running
time calls the weak learner about $n^{m_0+3}$ times and has an exponent depending
on $m_0$ and other weak-learner/base-class parameters. In the atlas computational
node, $m_0$ is generally polynomial in the representation size, not a fixed
constant. This gives a runtime that is polynomial in the final sample size only
when those parameters are treated as fixed, but not a representation-uniform
polynomial-time reduction of the atlas kind.

There is also a base-class definitional gap: the atlas weak improper learner
does not specify a low-VC or otherwise controlled class of all hypotheses it may
output, whereas modern sample-complexity statements are parameterized by the
base class used by the weak oracle.

Attempt 5: search for a conditional counterexample.

A plausible route is to encode an optimization problem where a constant-additive
agnostic approximation is easy but a PTAS-level approximation is hard. This
would separate fixed-additive weak agnostic learning from strong agnostic
learning. I did not find a ready atlas-compatible primary-source witness in this
pass. Existing atlas witnesses do not immediately apply: halfspaces are recorded
as failing weak agnostic improper learning under lattice assumptions, and the
conjunction notes concern agnostic proper hardness rather than an improper
strong target from a weak agnostic improper source.

### Precise Obstruction

The best current positive route is:

1. Convert the atlas source to a nontrivial modern correlation weak learner:
   $\operatorname{corr}(h)\geq\gamma\rho^*-\varepsilon_0$ with constants
   $\gamma>\varepsilon_0$.
2. Feed that oracle to a modern agnostic booster.

Known fully efficient boosters fail step 2 unless $\varepsilon_0$ shrinks with
the requested final $\varepsilon$. The 2026 sample-near-optimal booster accepts
constant $\varepsilon_0$, but its runtime is not polynomial uniformly in the
representation size under the atlas definition because the exponent depends on
weak-learner sample/base-class parameters.

So the edge is neither settled true by current boosting theorems nor settled
false by a known class separation.

### Final Verdict

`unresolved`.

The atlas implication should remain `status: "open"`, `evidence: unknown` after
this depth-0 pass. The strongest update is that the 2026 ALT result removes the
purely statistical obstruction for the fixed-additive source, but leaves a
computational/uniformity obstruction.

### Concrete Follow-Up Directions

- Check whether da Cunha--Hogsgaard--Paudice 2026 can be made fully polynomial
  in $m_0$, weak-learner evaluation time, and representation size, perhaps by
  replacing the enumeration of all $m_0$-subsamples with direct oracle calls on
  reweighted distributions plus a different generalization argument.
- Formalize an atlas lemma: fixed-additive weak agnostic learning implies a
  nontrivial multiplicative-correlation weak oracle with constants
  $\gamma>\varepsilon_0$, but only at fixed slack.
- Look for a CSP/PCP-style conditional witness where constant-additive agnostic
  approximation is efficient while arbitrary additive approximation is
  NP-hard, and verify that the resulting learning class satisfies the atlas
  source for all distributions, not just realizable instances.
- Clarify whether atlas "improper output" includes an implicit representation
  class with controlled VC dimension/evaluation time. This matters for applying
  modern agnostic boosting statements whose bounds depend on the base class of
  weak hypotheses.

## Depth-1 Entry - 2026-05-04

### Verdict

`unresolved`.

Depth 1 strengthens the positive evidence but still does not justify changing
the atlas edge to true. The fixed-additive atlas source can be converted into
the nontrivial correlation-oracle format used by the recent da
Cunha--Hogsgaard--Paudice theorem, but the currently available theorem is not a
uniform polynomial-time reduction in the atlas representation-size sense. The
best CSP/PCP counterexample lead remains plausible but did not produce an
atlas-valid witness, because the easy constant-additive approximation has to
work for every labeled distribution, not only for positive CSP instances.

### Lead 1: Fixed-Additive Weak Learning Versus Modern Weak Oracles

Work in $\{\pm 1\}$ labels and write
$$
\rho^*(\mathcal D)=\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c).
$$
The atlas source says that, for one fixed $\beta<1/2$,
$$
\operatorname{err}_{\mathcal D}(h)
\leq
\operatorname{opt}_{\mathcal C}(\mathcal D)+\beta,
$$
or equivalently
$$
\operatorname{corr}_{\mathcal D}(h)\geq \rho^*(\mathcal D)-2\beta.
$$
Since correlations are always at least $-1$, this implies
$$
\operatorname{corr}_{\mathcal D}(h)
\geq
\max\{-1,\rho^*(\mathcal D)-2\beta\}.
$$

The Ghai--Singh and da Cunha--Hogsgaard--Paudice weak oracle asks for constants
$(\gamma_0,\varepsilon_0)$ such that
$$
\operatorname{corr}_{\mathcal D}(W)
\geq
\gamma_0 \rho^*(\mathcal D)-\varepsilon_0.
$$
For any
$$
\gamma_0\in\left(\frac{1}{2(1-\beta)},1\right),
$$
set
$$
\varepsilon_0=1-\gamma_0(1-2\beta).
$$
Then $\gamma_0>\varepsilon_0$, because
$\gamma_0>1/(2(1-\beta))$, and for every $\rho\in[-1,1]$,
$$
\max\{-1,\rho-2\beta\}\geq \gamma_0\rho-\varepsilon_0.
$$
The two linear pieces meet at $\rho=2\beta-1$, where both require exactly
$\varepsilon_0=1-\gamma_0(1-2\beta)$. Thus, at the level of inequalities, the
atlas source really does give the "nontrivial" modern oracle with
$\gamma_0>\varepsilon_0$.

What it does not give is an oracle whose additive slack $\varepsilon_0$ can be
made arbitrarily small. For fixed $\beta$, the constructed $\varepsilon_0$ is a
fixed positive constant. This distinction is decisive for the efficient
Ghai--Singh theorems.

### Lead 2: Ghai--Singh And da Cunha--Hogsgaard--Paudice Runtime Dependence

Ghai--Singh 2024 define a $\gamma$-agnostic weak learner for reference class
$\mathcal H$ and base class $\mathcal B$ by
$$
\operatorname{corr}_{\mathcal D'}(W)
\geq
\gamma\max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D'}(h)-\varepsilon_0.
$$
Their main finite-class theorem uses
$T=O((\log|\mathcal B|)/(\gamma^2\varepsilon^2))$ weak calls and
$O((\log|\mathcal B|)/(\gamma^3\varepsilon^3))$ labeled examples, but its final
correlation guarantee is
$$
\operatorname{corr}_{\mathcal D}(\bar h)
\geq
\max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D}(h)
-\frac{2\varepsilon_0}{\gamma}-\varepsilon.
$$
The VC version has the same $2\varepsilon_0/\gamma$ loss. Therefore a
fixed-additive atlas learner only yields fixed excess error through this route.
To get the atlas target for arbitrary $\varepsilon$, one would need
$\varepsilon_0=O(\gamma\varepsilon)$, which is not supplied by the source node.

Ghai--Singh 2025, "Sample-Optimal Agnostic Boosting with Unlabeled Data",
keeps the same oracle format. Theorem 3.1 gives
$O(1/(\gamma^2\varepsilon^2))$ weak calls,
$O(\operatorname{VC}(\mathcal B)/(\gamma^2\varepsilon^2))$ labeled samples, and
$O(\operatorname{VC}(\mathcal B)/(\gamma^4\varepsilon^4))$ unlabeled samples,
with final loss $2\varepsilon_0/\gamma+\varepsilon$. Their reuse theorem
improves unlabeled samples to $O((\log|\mathcal B|)/(\gamma^3\varepsilon^3))$
in the finite case, but the final loss becomes $3\varepsilon_0/\gamma+\varepsilon$.
The paper explicitly notes that $\varepsilon_0$ can be made small by feeding
more samples to the weak learner, but the atlas source does not provide a
variable-$\varepsilon_0$ weak learner; it provides only one fixed additive
$\beta$.

da Cunha--Hogsgaard--Paudice 2026 is the closest positive lead. Their Definition
1 uses a $(\gamma_0,\varepsilon_0,\delta_0,m_0)$ agnostic weak learner, and
Theorem 2 sets
$$
\theta=(\gamma_0-\varepsilon_0)/2.
$$
Thus the fixed-additive conversion above gives a valid positive $\theta$. Their
bound then achieves agnostic excess error statistically, without the
$\varepsilon_0/\gamma$ residual term that blocks Ghai--Singh.

The remaining obstruction is computational uniformity. The theorem states that,
when the bound is nonvacuous, the algorithm invokes the weak learner at most
$O(n^{m_0+3})$ times, and its running time is at most
$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$
This is polynomial in the final sample size only when $m_0,d^*,\theta^{-1}$ and
the base-hypothesis evaluation model are treated as fixed side parameters. In
the atlas node, the weak learner's sample bound $m_0$ is generally polynomial in
the representation size. Then $n^{m_0+3}$ is not polynomial in representation
size and $1/\varepsilon$. Also, the atlas improper learner does not name a
single controlled base class $\mathcal H$ containing all weak outputs with known
VC dimension, dual VC dimension, and evaluation-time bounds.

### Lead 3: CSP/PCP Approximation Witness Search

The tempting witness template is a Max-CSP class where a random assignment gives
a constant-additive approximation to optimum, but a PTAS-level approximation is
NP-hard. Håstad's optimal inapproximability results give this flavor: for
Max-E3-SAT, random assignment gives the $7/8$ baseline, and improving beyond the
random threshold by a fixed constant is NP-hard even on nearly satisfiable
instances. Papadimitriou--Yannakakis Max-SNP/APX theory supplies the broader
"constant approximation but no PTAS unless P=NP" landscape.

However, the naive learning-class encoding does not yet satisfy the atlas
source. If examples are CSP constraints and hypotheses are assignments, a
positive-label distribution corresponds to a weighted Max-CSP instance, where a
random assignment may indeed give a constant-additive approximation. But
agnostic PAC distributions may put arbitrary labels on examples. A negative
label asks the learner to predict that a constraint is not satisfied, i.e. it
introduces complement predicates. For predicates such as 3-SAT clauses, the
random-assignment acceptance probability for the complemented predicate is
$1/8$, which only gives additive slack $7/8$, far above the required
$\beta<1/2$. Constant majority prediction also fails in balanced realizable
cases, where it can have error $1/2$ while the atlas weak source requires error
strictly below $1/2$.

Thus the CSP/PCP direction has not produced a separation. A viable witness would
need a representation of arbitrary labeled samples as a constraint family for
which there is a uniform polynomial-time additive-$\beta$ approximation with
$\beta<1/2$, while additive-$\varepsilon$ approximation is hard. Standard
random-assignment thresholds for one-sided positive CSP instances do not by
themselves meet this all-distributions agnostic requirement.

### Sources Checked

- Ghai and Singh, "Sample-Efficient Agnostic Boosting", NeurIPS 2024,
  arXiv: https://arxiv.org/abs/2410.23632.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data",
  ICML 2025 / PMLR: https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", ALT 2026, arXiv: https://arxiv.org/abs/2601.11265.
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting",
  NeurIPS 2025, arXiv: https://arxiv.org/abs/2503.09384.
- Håstad, "Some Optimal Inapproximability Results", JACM 2001,
  DOI: https://doi.org/10.1145/502090.502098.
- Papadimitriou and Yannakakis, "Optimization, Approximation, and Complexity
  Classes", JCSS 1991, DOI: https://doi.org/10.1016/0022-0000(91)90023-X.

### Concrete Next Directions

1. Ask whether the atlas source can be strengthened locally to a
   parameterized weak-agnostic learner: for every requested oracle slack
   $\varepsilon_0$, output
   $\operatorname{corr}(h)\geq\gamma\rho^*-\varepsilon_0$ in polynomial time.
   If yes, Ghai--Singh would give a clean efficient implication.
2. Try to remove the $n^{m_0}$ dependence in da Cunha--Hogsgaard--Paudice by
   replacing enumeration over weak-learner samples with direct calls to the
   atlas learner on simulated/relabelled distributions. This is the most direct
   path to `resolved true`.
3. Search specifically for labeled-CSP or valued-CSP approximation problems,
   not ordinary positive Max-CSP, where a constant additive approximation below
   $1/2$ is easy for every signed instance but a PTAS is hard. Any such witness
   must be checked as a distribution-free agnostic learning class, including
   representation size and improper output evaluation.
4. Clarify the atlas convention for improper weak outputs: whether the output
   family is required to have an efficiently evaluable representation and
   controlled VC/dual-VC dimension. This determines whether the 2026 theorem can
   even be applied as a black box.

## Depth-2 Entry - 2026-05-04

### Verdict

`unresolved`.

The proposed shortcut--replace da Cunha--Hogsgaard--Paudice's enumeration over
all weak-learner samples by direct oracle calls to the atlas weak learner on
simulated or reweighted distributions--does not currently give a polynomial-time
atlas reduction. The atlas learner is distribution-free, so in principle it
accepts arbitrary labeled distributions. The obstruction is not semantic
acceptance of a reweighted distribution; it is algorithmic access to the
specific distributions used in the 2026 proof, plus generalization/control of
the output class once the enumeration is removed.

### Source Check

Primary source details checked:

- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", arXiv:2601.11265v3, submitted January 16, 2026 and
  revised February 3, 2026: https://arxiv.org/abs/2601.11265.
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting",
  arXiv:2503.09384v3, revised December 30, 2025:
  https://arxiv.org/abs/2503.09384.
- A quick arXiv primary-source search on May 4, 2026 for exact "agnostic
  boosting" and for "weak agnostic learner" / "agnostic weak learner", sorted by
  submitted date, found no later general classical fully polynomial agnostic
  booster after arXiv:2601.11265. The only later-updated nearby item I found was
  Arunachalam--Dutt--Gheorghiu--de Oliveira, "Learning depth-3 circuits via
  quantum agnostic boosting", arXiv:2509.14461v3, revised February 17, 2026:
  https://arxiv.org/abs/2509.14461. It is a quantum, class-specific result
  about phase-state learning / quantum examples and does not supply a
  distribution-free classical booster for the atlas edge.

### What The Enumeration Is Doing

The 2026 algorithm first builds a finite set $\mathcal B$ by calling the weak
learner on every $m_0$-tuple from the first half of the sample, repeated $M$
times with independent weak-learner randomness. The proof then fixes a
near-optimal comparator $f \in \mathcal F$ and lets
$$
S_f=\{(x_i,y_i)\in S_1:f(x_i)=y_i\}.
$$
For any distribution $D'$ supported on $S_f$, the labels are realizable by
$f$, so the agnostic weak-oracle condition gives a hypothesis with empirical
advantage $\theta=(\gamma_0-\varepsilon_0)/2$ over $D'$. Since the learner
succeeds when its $m_0$ training examples are drawn from $D'$, averaging implies
that there exists at least one deterministic $m_0$-tuple
$S'\in S_f^{m_0}$ for which a fresh random seed succeeds with probability at
least $1-\delta_0$. Enumeration guarantees that this hidden tuple is in
$\mathcal B$, even though the algorithm does not know $f$, $S_f$, or the
AdaBoost distribution $D'$.

This is the key point: the proof does not literally run the weak learner on the
AdaBoost distributions. It constructs a large menu of hypotheses in advance,
then argues existentially that for each proof-generated AdaBoost round there is
a good hypothesis in the menu.

### Can The Atlas Learner Be Called On The Needed Distributions?

Only in a proof-oracle sense.

If a booster had sampling access to a labeled distribution $D'$ supported on
$S_f$, then the atlas distribution-free weak agnostic learner could be run on
i.i.d. samples from $D'$. The atlas source is agnostic and distribution-free, so
finite reweightings and empirical distributions are not excluded.

But the actual distributions needed by the 2026 proof are not available to the
algorithm. They are supported on $S_f$, the examples on which an unknown
near-optimal comparator agrees with the observed labels. Sampling from a
reweighted version of $S_f$ requires knowing the event $f(x_i)=y_i$. The
algorithm does not know $f$, and finding such an $f$ is essentially the strong
agnostic learning task.

Calling the atlas learner instead on the observable reweighted distribution
over all of $S_1$ does not reproduce the proof. Under that distribution the
benchmark correlation
$$
\sup_{c\in\mathcal C}\operatorname{corr}(c)
$$
need not be close to $1$. The fixed-additive atlas guarantee then gives only
$$
\operatorname{corr}(h)\geq \rho^* - 2\beta,
$$
or, after the depth-1 conversion, a nontrivial
$\gamma_0\rho^*-\varepsilon_0$ guarantee. This can be nonpositive on noisy
reweighted empirical distributions. It is not the constant positive edge needed
to simulate realizable AdaBoost on $S_f$.

So the precise access obstruction is:

> The distributions for which the 2026 proof obtains a realizable weak edge are
> adaptive reweightings of the unknown clean subset $S_f$, not observable
> reweightings of the sample. The atlas weak learner can learn from such
> distributions if handed i.i.d. examples from them, but the booster cannot
> sample from them without already knowing the near-optimal comparator.

### Can Generalization Be Controlled Without Enumeration?

Not from the bare atlas source.

If one somehow had oracle sampling access to every adaptive $D_i$ over $S_f$,
then a direct simulated-AdaBoost proof would still need a uniform
generalization argument for the final improper majority. The 2026 theorem gets
this from a specified base class $\mathcal H$: it assumes the weak learner's
outputs lie in $\mathcal H$, and its bounds depend on $\operatorname{VC}(\mathcal H)$,
dual VC dimension $d^*$, and the evaluation cost of hypotheses in
$\mathcal H$. The atlas node says only that the weak learner outputs an
improper efficiently evaluable hypothesis with polynomial sample/time bounds.
It does not name a single base class containing all possible outputs with
polynomially controlled VC dimension, dual VC dimension, or finite-class size.

With only polynomially many direct oracle calls, one could hope to union-bound
over the actually produced hypotheses, but this controls validation-set
selection only if the final algorithm searches over a finite, explicitly
generated family and if each generated hypothesis has controlled evaluation
time. It does not by itself justify the 2026 margin-pruning and
$\operatorname{VC}(\operatorname{sign}(\mathcal H^{(T)}))$ generalization
argument, and it still leaves the hidden-$S_f$ sampling problem above.

Thus enumeration has two roles that the direct-call shortcut has not replaced:

1. It removes the need to identify the hidden successful weak-learner sample
   from the unknown clean subset.
2. Together with the 2026 base-class assumptions, it makes the final search over
   combinations of generated hypotheses analyzable.

### Precise Obstruction

A direct oracle-call replacement would need to implement the following step in
polynomial time:

Given the original agnostic sample $S_1$, an unknown near-optimal
$f\in\mathcal C$, and an adaptively generated AdaBoost distribution
$D_i\in\operatorname{DistribOver}(S_f)$, draw i.i.d. labeled examples from
$D_i$ and call the weak learner to obtain error at most $1/2-\theta$ under
$D_i$.

The atlas source does not provide this. It provides a learner that works once
i.i.d. samples from a distribution are supplied; it does not provide a sampler
for hidden conditional distributions defined by an unknown comparator. Observable
reweightings of the full noisy sample are different distributions and do not
have the realizable benchmark that the 2026 proof uses.

Even granting hidden-distribution oracle access, the atlas source does not
provide the base-class complexity data needed to port the 2026 generalization
bound uniformly. The current obstruction is therefore both **access** and
**complexity control**, with access being the sharper blocker for the proposed
enumeration-removal idea.

### Next Directions

1. Look for a new proof that runs on observable reweighted agnostic
   distributions and avoids the hidden clean subset $S_f$. It would need to use
   the fixed-additive atlas guarantee without incurring a residual
   $\varepsilon_0/\gamma$ loss.
2. Formulate a strengthened atlas source with an explicit base class
   $\mathcal H$, polynomially bounded VC/dual-VC dimension and evaluation time,
   and a weak-oracle interface for weighted empirical distributions. This would
   clarify exactly which part of the 2026 theorem can be imported.
3. Try to replace the hidden-subset enumeration by an efficient search over
   candidate clean filters. This is only promising if the filter family has
   additional structure; for an arbitrary concept class it looks tantamount to
   solving the strong agnostic problem.

Bottom line: no post-2601.11265 primary source I found resolves the edge as
`true`, and the direct-oracle shortcut does not resolve it. No counterexample
was found either, so the edge remains `unresolved` rather than resolved false.

## Depth-3 Entry - 2026-05-04

### Question

Depth 2 isolated the sharp obstruction in the da Cunha--Hogsgaard--Paudice
route: their proof obtains a realizable weak edge on adaptive distributions
supported on
$$
S_f=\{(x_i,y_i): f(x_i)=y_i\},
$$
where $f$ is an unknown near-optimal comparator. The atlas weak learner would
accept such labeled distributions if samples from them were handed to it, but a
booster cannot sample from $S_f$ without already knowing which examples the
near-optimal comparator labels correctly.

The depth-3 question is whether some agnostic boosting theorem avoids this
unknown-clean-subset step and instead uses only observable reweighted or
relabeled distributions while still converting the atlas fixed-additive weak
agnostic learner into arbitrary $\operatorname{opt}+\varepsilon$ error in
polynomial time.

### Comparison Of Variants

**Ben-David--Long--Mansour.** This is closest to the atlas definition of weak
agnostic learning: the weak learner has fixed additive slack
$\operatorname{err}(h)\leq \operatorname{opt}_{\mathcal C}+\beta$ for
$\beta<1/2$. Their booster uses ordinary observable reweightings of the labeled
sample/distribution, so it does not face the hidden-$S_f$ access problem.
However, this older model does not reach arbitrary
$\operatorname{opt}+\varepsilon$. Its boosted guarantee leaves a loss that is
too large when $\operatorname{opt}_{\mathcal C}$ is bounded away from $0$.
Thus it avoids the depth-2 obstruction only by proving a weaker target.

**Gavinsky.** Gavinsky improves the smoothness/adaptivity and the quantitative
dependence in the Ben-David--Long--Mansour style approach. Again, the weak
learner is run on observable reweightings rather than on an unknown clean
subset. But the paper explicitly frames the attainable agnostic accuracy as the
optimal accuracy for that boosting model up to constants, not as a full
$\operatorname{opt}+\varepsilon$ theorem for the atlas fixed-additive source.
So this also avoids hidden-clean-subset sampling but does not prove the atlas
target.

**Feldman.** Feldman's distribution-specific booster deliberately avoids
adaptive reweighting of the feature marginal: it modifies labels, equivalently
the target function, while keeping the same marginal distribution on $X$. This
is an observable relabeling framework and is even better aligned with
distribution-specific weak learners. But the weak learner is not merely the
atlas fixed-additive learner. In Feldman's notation, the oracle must respond to
relabeling functions $g:X\to[-1,1]$ with a nontrivial edge whenever the best
reference hypothesis has sufficiently strong advantage; the later da Cunha
comparison records that the resulting strong guarantee needs the weak parameter
$\alpha=O(\varepsilon)$. A fixed atlas $\beta$ supplies only constant slack, not
a tunable $O(\varepsilon)$ edge. Feldman therefore gives an observable route
under a stronger/different weak-oracle interface, not a resolution of this edge.

**Kalai--Kanade.** The potential-based booster is the cleanest older
observable-distribution positive theorem. It can be implemented by randomly
relabeling examples rather than by reweighting them, and it uses a
correlation-style agnostic weak learner:
$$
\operatorname{corr}_{\mathcal D'}(W)
\geq
\gamma \max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D'}(h)
-\varepsilon_0.
$$
With $\varepsilon_0$ small enough relative to the target accuracy, this gives a
polynomial-time improper agnostic learner with arbitrary excess error. The
catch is exactly the quantifier on $\varepsilon_0$: the atlas source gives only
a fixed additive $\beta$, which depth 1 converted into constants
$(\gamma,\varepsilon_0)$ with $\gamma>\varepsilon_0$, but not into
$\varepsilon_0=O(\gamma\varepsilon)$. Thus Kalai--Kanade avoids the
unknown-clean-subset obstruction, but only because it assumes a stronger
parameterized weak learner than the atlas source.

**Ghai--Singh.** The 2024 and 2025 Ghai--Singh algorithms are fully
computationally efficient and use observable relabeled/resampled distributions.
The 2025 unlabeled-data version is especially explicit: the learner builds
pseudo-labeled distributions from labeled and unlabeled samples, calls the weak
learner on those observable samples, and obtains sample-optimal labeled
complexity with polynomially many unlabeled samples. These theorems therefore
do not suffer from hidden-$S_f$ access.

But their guarantees retain a residual weak-oracle term. The 2024 theorem gives
roughly
$$
\operatorname{corr}(\bar h)
\geq
\max_{h\in\mathcal H}\operatorname{corr}(h)
-\frac{2\varepsilon_0}{\gamma}
-\varepsilon,
$$
and the unlabeled/reuse variants keep the same kind of
$\varepsilon_0/\gamma$ loss, sometimes with a different constant. With only the
atlas fixed-additive source, $\varepsilon_0$ is a fixed positive constant after
conversion to the modern correlation oracle. Hence Ghai--Singh yields only
fixed excess error for this edge, not arbitrary
$\operatorname{opt}+\varepsilon$.

**da Cunha variants.** The 2025 "Revisiting Agnostic Boosting" and 2026
"Sample-Near-Optimal Agnostic Boosting with Improved Running Time" papers are
the only variants in this list that accept a genuinely nontrivial weak learner
with fixed constants $\gamma_0>\varepsilon_0$ and remove the residual
$\varepsilon_0/\gamma_0$ term. This is exactly why they were the strongest
positive lead in depths 0--2.

Their price is that the proof reduces the agnostic problem to realizable
boosting on the unknown clean subset $S_f$. The 2026 algorithm avoids explicit
knowledge of $S_f$ by building a large finite menu $\mathcal B$: it calls the
weak learner on every $m_0$-tuple from the observed first-half sample, repeated
with fresh random seeds. Since the unknown successful tuple from
$S_f^{m_0}$ is among the enumerated tuples, AdaBoost can be simulated
existentially using hypotheses in $\mathcal B$.

This is an important distinction. The algorithm uses only observable labeled
subsamples, but not only polynomially many observable adaptive reweightings in
the atlas sense. It replaces hidden-subset access with enumeration. The stated
number of weak-learner calls is of order $n^{m_0+3}$, and the runtime exponent
depends on $m_0$ and base-class complexity parameters. In the atlas source,
$m_0$ is generally allowed to be polynomial in the representation size, not a
fixed constant. Therefore the da Cunha route is not a representation-uniform
polynomial-time black-box conversion for the atlas edge.

### Observable-Distribution Scorecard

- Uses only observable adaptive distributions but fails arbitrary
  $\operatorname{opt}+\varepsilon$ for the atlas source:
  Ben-David--Long--Mansour, Gavinsky.
- Uses observable relabeling/reweighting and reaches arbitrary excess error
  with polynomial time, but only for a stronger or parameterized weak oracle
  whose slack can shrink with $\varepsilon$: Feldman, Kalai--Kanade,
  Ghai--Singh.
- Accepts fixed nontrivial weak-oracle slack and reaches arbitrary excess
  statistically, but removes the hidden-clean-subset obstruction by exhaustive
  enumeration rather than by an observable polynomial-time reweighting
  simulation: da Cunha 2025/2026.

### Can Any Variant Resolve The Atlas Edge?

No current variant in this comparison gives all three properties simultaneously:

1. It uses only distributions the atlas weak learner can be sampled from
   observably, without knowing a near-optimal clean subset.
2. It tolerates the atlas source's fixed additive weak-agnostic slack
   $\beta<1/2$, equivalently only fixed constants
   $\gamma_0>\varepsilon_0$ after the depth-1 correlation conversion.
3. It reaches arbitrary $\operatorname{opt}_{\mathcal C}+\varepsilon$ in time
   polynomial in the representation size and $1/\varepsilon$.

The pattern is now quite stable. Observable efficient boosters need
$\varepsilon_0$ to shrink with the target $\varepsilon$, while residual-free
boosters with fixed $\varepsilon_0<\gamma_0$ use the hidden-clean-subset
argument and pay for it by enumeration or by non-uniform/base-class parameters
outside the atlas edge.

### Verdict

`unresolved`.

The depth-3 pass gives negative evidence against the most plausible positive
shortcut: no checked agnostic boosting theorem both avoids the unknown-clean
subset using only observable polynomial-time oracle calls and converts the atlas
fixed-additive weak learner to arbitrary excess error. But this is not a
separation theorem. I still do not have a concept-class witness satisfying the
source while refuting the target under a standard assumption. The atlas edge
should therefore remain open rather than be marked true or false.

## Depth-4 Entry - 2026-05-04

### Final Verdict

`unresolved`.

This final pass does not justify changing the atlas edge to either `true` or
`false`. The strongest available positive results each miss one member of the
exact triad needed for the atlas implication:

1. the booster should call the weak learner only on observable distributions,
   meaning distributions that can be sampled or simulated from the given
   labeled/unlabeled data without knowing a near-optimal comparator;
2. the weak learner should be only the atlas fixed-additive weak agnostic
   learner, i.e. for one fixed $\beta<1/2$ it returns
   $\operatorname{err}(h)\leq \operatorname{opt}_{\mathcal C}+\beta$;
3. the final learner should achieve arbitrary
   $\operatorname{opt}_{\mathcal C}+\varepsilon$ in time polynomial in the
   representation size, $1/\varepsilon$, and $\log(1/\delta)$.

No checked theorem simultaneously has all three.

### The Fixed-Slack Translation Is Real But Not Enough

The source guarantee is not merely a realizable weak learner. In
$\{\pm1\}$ notation it says
$$
\operatorname{corr}_{\mathcal D}(h)\geq
\rho^*(\mathcal D)-2\beta,
\qquad
\rho^*(\mathcal D)=
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c).
$$
Since every correlation is at least $-1$,
$$
\operatorname{corr}_{\mathcal D}(h)
\geq
\max\{-1,\rho^*(\mathcal D)-2\beta\}.
$$
For any
$$
\gamma_0\in\left(\frac{1}{2(1-\beta)},1\right)
$$
and
$$
\varepsilon_0=1-\gamma_0(1-2\beta),
$$
we have $\gamma_0>\varepsilon_0$ and, for all $\rho\in[-1,1]$,
$$
\max\{-1,\rho-2\beta\}\geq \gamma_0\rho-\varepsilon_0.
$$
Thus the atlas source does imply the modern "nontrivial" agnostic weak oracle
with fixed constants $\gamma_0>\varepsilon_0$. The remaining issue is exactly
that $\varepsilon_0$ is fixed. It is not an oracle slack that can be driven down
to $O(\varepsilon)$ by asking for more samples or more runtime.

### Strongest Sources And Where They Miss

**Ben-David--Long--Mansour 2001.** This is the source most closely matched to
the atlas weak-agnostic convention. It uses a fixed $\beta$-weak agnostic
learner and observable reweightings, but the boosted guarantee is weaker than
$\operatorname{opt}+\varepsilon$ in the fully agnostic regime. It therefore
satisfies observable distributions and fixed-additive slack, but not arbitrary
excess-error optimality.

**Gavinsky 2003.** Gavinsky improves the smooth/adaptive boosting picture under
the same broad agnostic-boosting line. It is still not a theorem that a fixed
$\beta$-weak learner gives arbitrary
$\operatorname{opt}_{\mathcal C}+\varepsilon$. Its lower-bound discussion is a
black-box boosting limitation, not a concept-class separation for the atlas
edge.

**Feldman 2009 and Kalai--Kanade/Kalai--Mansour--Verbin style potential
boosting.** These are the best observable-distribution positive routes. They
work by relabeling or using correlation-style agnostic weak oracles on
accessible distributions. However, the weak-oracle accuracy has to be tuned to
the desired final $\varepsilon$ or appears with a residual dependence on the
weak slack. A single fixed atlas $\beta$ does not supply that parameterized
oracle.

**Ghai--Singh 2024/2025.** These are the strongest fully efficient observable
boosters in the recent line. The 2024 theorem and the 2025 unlabeled-data
theorem use polynomially many weak calls on observable samples and achieve good
sample complexity. But their final bound retains a term of order
$\varepsilon_0/\gamma$. After translating the atlas source into
$(\gamma_0,\varepsilon_0)$, this is a fixed constant loss. Hence they give only
fixed excess error for this edge, not arbitrary
$\operatorname{opt}+\varepsilon$.

**da Cunha--Hogsgaard--Paudice--Sun 2025 and da
Cunha--Hogsgaard--Paudice 2026.** These are the strongest positive evidence.
They accept a genuinely nontrivial weak learner with fixed
$\gamma_0>\varepsilon_0$ and remove the residual
$\varepsilon_0/\gamma_0$ term, so they overcome the fixed-slack barrier
statistically. The 2026 ALT paper improves the running time and is explicit
that the algorithm runs in time polynomial in the sample size when the other
parameters are fixed. This is still not the atlas computational implication:
the algorithm constructs a menu by enumerating weak-learner training samples,
with a number of weak calls of order $n^{m_0+3}$ and runtime exponents depending
on weak-learner/base-class parameters. In the atlas node, $m_0$ may be
polynomial in the representation size, and the improper weak outputs are not
packaged as a base class with controlled VC, dual-VC, and evaluation complexity.

### The Exact Remaining Obstruction

The cleanest current statement is:

Observable efficient boosters can call the atlas learner on reweighted or
relabelled distributions that the algorithm can actually sample. But with only
fixed additive slack they seem to leave a fixed residual error term.

Residual-free fixed-slack boosters instead use the "unknown clean subset" idea.
For a near-optimal comparator $f$, define
$$
S_f=\{(x_i,y_i): f(x_i)=y_i\}.
$$
On distributions supported on $S_f$, the problem becomes realizable by $f$ and
a nontrivial fixed weak edge suffices. The algorithm cannot sample from
$S_f$ directly, because it does not know $f$. The 2025/2026 da Cunha route
handles this by enumerating enough candidate weak-learner input samples so that
some hidden successful sample from $S_f^{m_0}$ is included. That enumeration is
precisely where the representation-uniform polynomial-time atlas implication
is lost.

So the missing theorem is not "agnostic boosting exists" in the broad sense.
The missing theorem is the simultaneous combination:

- observable adaptive distributions, not oracle access to or exhaustive search
  over an unknown clean subset;
- tolerance of a fixed atlas additive slack $\beta<1/2$, equivalently fixed
  constants $\gamma_0>\varepsilon_0$ after correlation conversion;
- fully polynomial runtime for every requested final $\varepsilon$.

### Atlas-Ready Unresolved Summary

The implication remains open. A fixed-additive weak agnostic improper learner
can be converted into a nontrivial correlation weak oracle with constants
$\gamma_0>\varepsilon_0$, but not into one whose slack is
$O(\varepsilon)$. Known efficient observable agnostic boosters, including
potential/relabeling-based and Ghai--Singh style algorithms, require such
tunable slack or retain a residual $\varepsilon_0/\gamma_0$ loss. The recent da
Cunha et al. line accepts fixed nontrivial slack and reaches arbitrary agnostic
excess statistically, but its residual-free proof uses an unknown-clean-subset
reduction implemented by enumeration over weak-learner samples, giving runtime
polynomial in the final sample size only when weak-learner/base-class parameters
are fixed. No known concept-class separation shows that the source can hold
while the target fails. Therefore the edge should remain `status: "open"`,
`evidence: unknown`.

Suggested atlas summary:

> Open. The atlas fixed-additive weak agnostic guarantee implies a nontrivial
> correlation weak oracle with fixed constants $\gamma_0>\varepsilon_0$, but
> current fully efficient observable agnostic boosters need slack shrinking with
> the target $\varepsilon$ or incur a residual weak-slack loss. The recent da
> Cunha et al. boosters remove the residual fixed-slack loss statistically, but
> their residual-free construction uses an unknown-clean-subset/enumeration
> argument whose runtime is not a representation-uniform polynomial-time
> reduction for the atlas node. No matching separation witness is known.

### Precise Future-Settling Theorem

A positive theorem that would settle this edge as `true` is the following.

**Theorem Needed.** Let $\mathcal C=\{\mathcal C_n\}$ be any efficiently
represented binary concept class. Suppose there is an algorithm $W$ and a fixed
$\beta<1/2$ such that, for every distribution $\mathcal D$ over
$\mathcal X_n\times\{\pm1\}$ and every $\delta>0$, $W$ draws i.i.d. examples
from $\mathcal D$, runs in $\operatorname{poly}(n,\log(1/\delta))$ time, and
with probability at least $1-\delta$ outputs an efficiently evaluable
hypothesis $h$ satisfying
$$
\operatorname{err}_{\mathcal D}(h)
\leq
\inf_{c\in\mathcal C_n}\operatorname{err}_{\mathcal D}(c)+\beta.
$$
Then there is a black-box booster $B^W$ such that, for every
$\varepsilon,\delta>0$ and every distribution $\mathcal D$ over
$\mathcal X_n\times\{\pm1\}$, $B^W$ uses only
$\operatorname{poly}(n,1/\varepsilon,\log(1/\delta),1/(1/2-\beta))$ samples,
time, weak calls, and weak-hypothesis evaluations; every weak call is on a
distribution samplable in polynomial time from the observed labeled sample
and/or the feature marginal without conditioning on an unknown comparator; and
with probability at least $1-\delta$ it outputs an efficiently evaluable
improper hypothesis $H$ satisfying
$$
\operatorname{err}_{\mathcal D}(H)
\leq
\inf_{c\in\mathcal C_n}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$

If proved, this theorem would satisfy all three missing requirements and make
the atlas edge `true` with evidence `theorem`. A negative settlement would
instead require an explicit efficiently represented class $\mathcal C$ and a
standard assumption under which the fixed-$\beta$ source learner exists for all
distributions but no polynomial-time improper agnostic learner achieves
$\operatorname{opt}_{\mathcal C}+\varepsilon$ for arbitrary $\varepsilon$.
No such witness is currently known from the checked sources.

### Source List For This Final Pass

- Ben-David, Long, and Mansour, "Agnostic Boosting", COLT/EuroCOLT 2001,
  https://doi.org/10.1007/3-540-44581-1_33.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic
  Learning", JMLR 2003, https://www.jmlr.org/papers/v4/gavinsky03a.html.
- Kalai, Mansour, and Verbin, "On agnostic boosting and parity learning", STOC
  2008, https://doi.org/10.1145/1374376.1374466.
- Kanade and Kalai, "Potential-Based Agnostic Boosting", 2009,
  https://www.cs.ox.ac.uk/people/varun.kanade/docs/potential-KK09.pdf.
- Feldman, "Distribution-Specific Agnostic Boosting", 2009,
  https://vtaly.net/papers/F_AgnosticBoosting_111609.pdf.
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", NeurIPS 2024,
  https://arxiv.org/abs/2410.23632.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", ICML
  2025, https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting",
  NeurIPS 2025, https://arxiv.org/abs/2503.09384.
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", ALT 2026, https://arxiv.org/abs/2601.11265. The arXiv
  page checked on May 4, 2026 lists v3 as revised February 3, 2026 and states
  the runtime as polynomial in sample size with other parameters fixed.
- Arunachalam, Dutt, Gheorghiu, and de Oliveira, "Learning depth-3 circuits via
  quantum agnostic boosting", arXiv:2509.14461v3, checked only as a nearby
  later-updated source; it is quantum/class-specific and does not settle this
  classical distribution-free atlas edge.

## Depth-5 Entry - 2026-05-05

### Verdict

`unresolved`.

Depth 5 did not find a theorem or witness that resolves
`efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`.
The edge should remain `status: "open"`, `evidence: unknown`.

The closest apparent positive theorem is Feldman's distribution-specific
weak-to-strong result, because it explicitly says weak agnostic learnability is
equivalent to strong agnostic learnability over a fixed marginal. But its weak
input is not the atlas input. It requires an $(\alpha,\gamma)$ weak learner at
the requested final accuracy scale, i.e. for every threshold $\alpha$ down to
$\Theta(\varepsilon)$. The atlas source gives only one fixed additive
$\beta<1/2$. When $\alpha\leq\beta$, the atlas guarantee may give no positive
edge at all.

### Definitions Used

Source definition read:
`atlas/definitions/efficient-weak-agnostic-improper-pac.md`.

The source learner is distribution-free, agnostic, computationally efficient,
and improper. For one fixed additive tolerance $\beta<1/2$, it must output an
efficiently evaluable hypothesis satisfying
$$
\operatorname{err}_{\mathcal D}(h)
\leq
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta .
$$
In correlation notation this is
$$
\operatorname{corr}_{\mathcal D}(h)
\geq
\rho^*(\mathcal D)-2\beta,
\qquad
\rho^*(\mathcal D)=
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c).
$$

Target definition read:
`atlas/definitions/efficient-agnostic-improper-pac.md`.

The target learner must, for every $\varepsilon>0$, run in time and samples
polynomial in the representation size, $1/\varepsilon$, and
$\log(1/\delta)$, and output an improper hypothesis satisfying
$$
\operatorname{err}_{\mathcal D}(H)
\leq
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon .
$$

Implication and argument notes read:

- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- Existing scratchpad Depth 0--4 entries for this edge.

### Sources Checked

Primary sources and source pages checked on May 5, 2026:

- Ben-David, Long, and Mansour, "Agnostic Boosting", COLT/EuroCOLT 2001,
  https://doi.org/10.1007/3-540-44581-1_33.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic
  Learning", JMLR 2003, https://www.jmlr.org/papers/v4/gavinsky03a.html.
- Kalai, Mansour, and Verbin, "On agnostic boosting and parity learning", STOC
  2008, https://doi.org/10.1145/1374376.1374466.
- Feldman, "Distribution-Specific Agnostic Boosting", arXiv/JMLR source page,
  https://arxiv.org/abs/0909.2927, and PDF mirror
  https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf.
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", NeurIPS 2024,
  https://arxiv.org/abs/2410.23632.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", ICML
  2025, https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting",
  NeurIPS 2025, https://arxiv.org/abs/2503.09384.
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", ALT 2026, https://arxiv.org/abs/2601.11265. The arXiv
  page lists submission on January 16, 2026, last revision v3 on February 3,
  2026, and states that the algorithm runs in time polynomial in the sample
  size when the other problem parameters are fixed.

I also searched for newer primary-source agnostic boosting papers after
arXiv:2601.11265 and did not find a later classical distribution-free theorem
that accepts only the atlas fixed-additive weak learner and gives a
representation-uniform polynomial-time strong agnostic learner.

### Theorem Route

The promising theorem route is to convert the atlas source into one of the
known weak-oracle formats and then invoke an agnostic booster.

For Feldman/Kalai--Mansour--Verbin style weak agnostic learning, the relevant
oracle is roughly:

If
$$
\operatorname{opt}_{\mathcal C}(\mathcal D)\leq 1/2-\alpha,
$$
then the weak learner outputs $h$ with
$$
\operatorname{err}_{\mathcal D}(h)\leq 1/2-\gamma.
$$

The atlas source implies this only with
$$
\gamma=\alpha-\beta,
$$
because
$$
\operatorname{err}(h)\leq \operatorname{opt}_{\mathcal C}+\beta
\leq 1/2-\alpha+\beta.
$$
Thus it is useful only for $\alpha>\beta$. Feldman's Theorem 3.2 obtains strong
agnostic learning by calling the weak learner with
$\alpha=\Theta(\varepsilon)$. For requested accuracies
$\varepsilon < \beta$, the atlas source no longer supplies the required weak
edge. This is the cleanest reason Feldman's theorem does not resolve the edge,
despite its surface-level "weak implies strong" statement.

For modern correlation-oracle boosters, Depth 4 already checked that the atlas
source gives fixed constants $\gamma_0>\varepsilon_0$ satisfying
$$
\operatorname{corr}(h)\geq \gamma_0\rho^*-\varepsilon_0.
$$
Ghai--Singh style observable boosters are efficient, but their final guarantee
retains a residual term proportional to $\varepsilon_0/\gamma_0$. Since
$\varepsilon_0$ is fixed, this gives only fixed excess error.

The da Cunha et al. route accepts fixed nontrivial constants
$\gamma_0>\varepsilon_0$ and removes the residual statistical loss. The
remaining obstruction is computational uniformity: the residual-free algorithm
builds a large menu by enumerating weak-learner input samples, with weak-call
and runtime exponents depending on parameters such as the weak learner's sample
size and base-class complexity. Under the atlas definition these parameters
can grow polynomially with the representation size, so the resulting
$n^{m_0}$-type dependence is not a polynomial-time black-box reduction in the
atlas sense.

Conclusion of theorem route: no checked theorem simultaneously has fixed atlas
additive slack, arbitrary final $\varepsilon$, observable/implementable weak
calls, and representation-uniform polynomial runtime.

### Counterexample Route

The plausible counterexample route is an approximation gap:

1. Construct an efficiently represented concept class $\mathcal C$ for which
   constant-additive agnostic approximation is easy for every labeled
   distribution.
2. Show that arbitrary additive agnostic approximation, i.e.
   $\operatorname{opt}_{\mathcal C}+\varepsilon$, is computationally hard.

PCP/Max-CSP hardness is the natural source of such gaps. However, the naive
encoding still fails the atlas source requirement. Positive Max-CSP instances
give a constant baseline under random assignments, but agnostic PAC
distributions allow arbitrary labels. Negative labels introduce complement
predicates, and the random-assignment baseline can be too poor to guarantee
error below $\operatorname{opt}+\beta$ with $\beta<1/2$ on all labeled
distributions. Majority prediction also fails when the distribution is balanced
but nearly realizable by some concept.

Thus a valid witness would need more than a standard one-sided Max-CSP
inapproximability theorem. It would need an all-distributions signed or valued
instance encoding where a uniform polynomial-time algorithm always achieves
fixed additive slack below $1/2$, while a PTAS-level approximation remains hard.
I did not find such a primary-source witness.

Conclusion of counterexample route: plausible but not realized; no atlas-valid
class separation was found.

### Concrete Obstruction

The obstruction can be stated quantitatively.

At the point in an observable boosting proof where the current residual has
best comparator advantage only
$$
\rho^*=2\alpha\leq 2\beta,
$$
the atlas weak learner may return a hypothesis with
$$
\operatorname{corr}(h)\geq \rho^*-2\beta\leq 0.
$$
So observable gradient/potential boosters cannot force progress all the way to
an arbitrary $\varepsilon$ scale from the fixed-additive atlas guarantee alone.

Residual-free fixed-slack boosters avoid this by moving to the unknown clean
subset of a near-optimal comparator, where the induced problem is realizable
and a fixed weak edge is enough. But the booster cannot sample from that subset
without knowing the comparator. The da Cunha et al. construction compensates by
enumerating weak-learner samples so that a successful hidden clean sample is in
the generated menu. That enumeration is exactly what breaks the
representation-uniform polynomial-time implication.

### Atlas-Ready Text If Still Open

Suggested atlas replacement/summary, if the atlas note is later refreshed:

> Open. The fixed-additive weak agnostic improper learner gives
> $\operatorname{err}(h)\leq\operatorname{opt}_{\mathcal C}+\beta$ for one
> fixed $\beta<1/2$. This implies a nontrivial fixed-parameter correlation
> weak oracle, but not a weak oracle whose slack scales with the requested
> final $\varepsilon$. Observable efficient agnostic boosters such as the
> Feldman/Kalai--Mansour--Verbin and Ghai--Singh lines need threshold or slack
> parameters at the $\varepsilon$ scale, or else retain a residual weak-slack
> loss. The da Cunha et al. residual-free boosters handle fixed nontrivial
> slack statistically, but their known construction uses an
> unknown-clean-subset/enumeration argument whose runtime is polynomial in the
> sample size only with weak-learner and base-class parameters fixed. No
> all-distributions concept-class witness is known that satisfies the source
> while refuting the target. Therefore the implication remains open with
> evidence `unknown`.

No atlas edits are justified from this Depth 5 pass. If one nevertheless wanted
to encode the current state, the exact atlas changes would be: keep
`status: "open"` and `evidence: unknown`; optionally update the body summary
with the text above and keep the current reference set including
`feldman2010distributionspecific`, `ghai2025agnosticboosting`, and
`dacunha2026agnosticboosting`.
